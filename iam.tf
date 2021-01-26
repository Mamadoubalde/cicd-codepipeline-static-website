resource "aws_iam_role" "codepipeline_role" {
  name               = "codepipeline-${var.app_name}-${var.git_repository_branch}-role"
  assume_role_policy = "${file("templates/policies/codepipeline_role.json")}"
}

data "template_file" "codepipeline_policy" {
  template = "${file("templates/policies/codepipeline.json")}"

  vars {
    aws_s3_bucket_arn = "${aws_s3_bucket.source.arn}"
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline_policy"
  role   = "${aws_iam_role.codepipeline_role.id}"
  policy = "${data.template_file.codepipeline_policy.rendered}"
}

resource "aws_iam_role" "codebuild_role" {
  name               = "codebuild-${var.app_name}-${var.git_repository_branch}-role"
  assume_role_policy = "${file("templates/policies/codebuild_role.json")}"
}

data "template_file" "codebuild_policy" {
  template = "${file("templates/policies/codebuild.json")}"

  vars {
    aws_s3_bucket_arn = "${aws_s3_bucket.source.arn}"
  }
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "codebuild-${var.app_name}-${var.git_repository_branch}-policy"
  role   = "${aws_iam_role.codebuild_role.id}"
  policy = "${data.template_file.codebuild_policy.rendered}"
}