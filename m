Return-Path: <linux-nfs+bounces-5480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF116958A0E
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2024 16:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3011F219EC
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2024 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F305191F7C;
	Tue, 20 Aug 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGsAPNLt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA718C007
	for <linux-nfs@vger.kernel.org>; Tue, 20 Aug 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165170; cv=none; b=qYZPk1v7fbUOk1V67CigWecEstjoD+LaYGLXzjJKCG/63przhmFFmYTwEnYxPI+msr91XYsgFsNBXq7ez9Sxn/jOPjhzUlj0ovIi+LBDNmvY9GpJ/5Iir6xgXEBiIKqzxFYC2ZjcmR8KYnGYvXh/GsHjsRbCkrvDt6pzQzdBv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165170; c=relaxed/simple;
	bh=jgqKsuwY2aFGEQ6ZzbbclNwc3X0Bc4yK0csDF1SJxNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lubOk7GYqg851Ui1Y0tkTnscHgGb2d0VjKesh7ogtmfAyINVv62Y6Iq0g/9jd/HZqk6wRVSQETI9GTHjPJGw3d0sZabLoPdQqXwxOM6xyBqk/HHfYCzVhfiZPZTWis0DdhVZbuA4gV/nrkYbkkDPHYW3QW52huGXxo1na1wUvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGsAPNLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95614C4AF0F;
	Tue, 20 Aug 2024 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165169;
	bh=jgqKsuwY2aFGEQ6ZzbbclNwc3X0Bc4yK0csDF1SJxNo=;
	h=From:To:Cc:Subject:Date:From;
	b=QGsAPNLtI+RO0oMdgQ7egj/MiDx8VIOmfvfHZ4YqkSDPGtdR7PdMHqWyf+uDOQkYS
	 6R6SJoI3YXc7f7PJrplU5rTgXOJSkrWOeNVAwhZf9N7UVxDsVfDMdJBkanm5chHw7u
	 a1TrAaK7P8LDPMkNqPtVIkHD7uJQY9erQECGIN8Y5wAtkRVvs2PoFhZ3g3uNgii8sl
	 /lXvjPYSdwTLwsT8nX8r6NgoomIWJML3R0rUv3hDRIPi92AUIWMQN1H9bzKky8s536
	 Yw9yTvNgCk9gqFRV0zTGEBQew8KjdTzMVZ/uZmSAuCHxtrgaEokBvQIhXNlfYLQ2cL
	 8WWPQxHDMOvMA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/2] xdrgen - machine-generated XDR functions
Date: Tue, 20 Aug 2024 10:45:58 -0400
Message-ID: <20240820144600.189744-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

For a description of this work-in-progress, see the new README file.
For unfinished work items, ditto.

The first patch adds the tool.

The second patch is an nfs4_1.x file that I created to confirm that
the tool indeed works for Jeff's purposes. Actual generated header
and source are in fs/nfsd/nfs4xdr_gen.? .

Feel free to ignore 2/2. It is included here only to demonstrate the
tool's new "pragma" directives that I think can avoid the need to
hand-edit generated source, as discussed in an earlier thread. Grep
the new README or nfs4_1.x for "pragma".

These patches apply to v6.11-rc4, but can be rebased on nfsd-next if
they are found merge-worthy. See also:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=lkxdrgen

For review, note that the numerous .j2 files are all tiny and can be
skimmed in favor of the .py files, where the tool's logic is.

All Python-related advice and guidance is gratefully accepted.

--

Chuck Lever (2):
  tools: Add xdrgen
  NFSD: Create an initial nfs4_1.x file

 fs/nfsd/nfs4_1.x                              | 164 +++++++
 fs/nfsd/nfs4xdr_gen.c                         | 236 ++++++++++
 fs/nfsd/nfs4xdr_gen.h                         | 113 +++++
 include/linux/sunrpc/xdrgen-builtins.h        | 253 ++++++++++
 tools/net/sunrpc/xdrgen/.gitignore            |   2 +
 tools/net/sunrpc/xdrgen/README                | 231 +++++++++
 tools/net/sunrpc/xdrgen/__init__.py           |   0
 tools/net/sunrpc/xdrgen/common.py             |  21 +
 .../net/sunrpc/xdrgen/generators/__init__.py  |   0
 .../sunrpc/xdrgen/generators/boilerplate.py   |  66 +++
 .../net/sunrpc/xdrgen/generators/constant.py  |  38 ++
 tools/net/sunrpc/xdrgen/generators/enum.py    |  67 +++
 tools/net/sunrpc/xdrgen/generators/program.py |  96 ++++
 tools/net/sunrpc/xdrgen/generators/struct.py  | 435 +++++++++++++++++
 tools/net/sunrpc/xdrgen/generators/typedef.py | 282 +++++++++++
 tools/net/sunrpc/xdrgen/generators/union.py   | 297 ++++++++++++
 tools/net/sunrpc/xdrgen/subcmds/__init__.py   |   0
 tools/net/sunrpc/xdrgen/subcmds/header.py     |  62 +++
 tools/net/sunrpc/xdrgen/subcmds/lint.py       |  28 ++
 tools/net/sunrpc/xdrgen/subcmds/source.py     |  82 ++++
 .../templates/C/boilerplate/header_bottom.j2  |   3 +
 .../templates/C/boilerplate/header_top.j2     |  11 +
 .../templates/C/boilerplate/source_top.j2     |   5 +
 .../templates/C/constants/declaration.j2      |   5 +
 .../templates/C/enum/declaration/close.j2     |   7 +
 .../C/enum/declaration/enumerator.j2          |   2 +
 .../templates/C/enum/declaration/open.j2      |   3 +
 .../xdrgen/templates/C/enum/decoder/enum.j2   |  19 +
 .../xdrgen/templates/C/enum/encoder/enum.j2   |  14 +
 .../C/program/declaration/argument.j2         |   2 +
 .../templates/C/program/declaration/result.j2 |   2 +
 .../templates/C/program/decoder/argument.j2   |  21 +
 .../templates/C/program/encoder/result.j2     |  21 +
 .../templates/C/struct/declaration/basic.j2   |   5 +
 .../templates/C/struct/declaration/close.j2   |   7 +
 .../struct/declaration/fixed_length_array.j2  |   5 +
 .../struct/declaration/fixed_length_opaque.j2 |   5 +
 .../templates/C/struct/declaration/open.j2    |   6 +
 .../C/struct/declaration/optional_data.j2     |   5 +
 .../C/struct/declaration/pointer-open.j2      |   6 +
 .../declaration/variable_length_array.j2      |   8 +
 .../declaration/variable_length_opaque.j2     |   5 +
 .../declaration/variable_length_string.j2     |   5 +
 .../templates/C/struct/decoder/basic.j2       |   6 +
 .../templates/C/struct/decoder/close.j2       |   3 +
 .../C/struct/decoder/fixed_length_array.j2    |   8 +
 .../C/struct/decoder/fixed_length_opaque.j2   |   6 +
 .../xdrgen/templates/C/struct/decoder/open.j2 |  12 +
 .../C/struct/decoder/optional_data.j2         |   6 +
 .../C/struct/decoder/pointer-open.j2          |  22 +
 .../C/struct/decoder/variable_length_array.j2 |  13 +
 .../struct/decoder/variable_length_opaque.j2  |   6 +
 .../struct/decoder/variable_length_string.j2  |   6 +
 .../templates/C/struct/encoder/basic.j2       |  10 +
 .../templates/C/struct/encoder/close.j2       |   3 +
 .../C/struct/encoder/fixed_length_array.j2    |  12 +
 .../C/struct/encoder/fixed_length_opaque.j2   |   6 +
 .../xdrgen/templates/C/struct/encoder/open.j2 |  12 +
 .../C/struct/encoder/optional_data.j2         |   6 +
 .../C/struct/encoder/pointer-open.j2          |  20 +
 .../C/struct/encoder/variable_length_array.j2 |  15 +
 .../struct/encoder/variable_length_opaque.j2  |   8 +
 .../struct/encoder/variable_length_string.j2  |   8 +
 .../templates/C/typedef/declaration/basic.j2  |  11 +
 .../typedef/declaration/fixed_length_array.j2 |  11 +
 .../declaration/fixed_length_opaque.j2        |  11 +
 .../declaration/variable_length_array.j2      |  14 +
 .../declaration/variable_length_opaque.j2     |  11 +
 .../declaration/variable_length_string.j2     |  11 +
 .../templates/C/typedef/decoder/basic.j2      |  17 +
 .../C/typedef/decoder/fixed_length_array.j2   |  25 +
 .../C/typedef/decoder/fixed_length_opaque.j2  |  17 +
 .../typedef/decoder/variable_length_array.j2  |  26 ++
 .../typedef/decoder/variable_length_opaque.j2 |  17 +
 .../typedef/decoder/variable_length_string.j2 |  17 +
 .../templates/C/typedef/encoder/basic.j2      |  21 +
 .../C/typedef/encoder/fixed_length_array.j2   |  25 +
 .../C/typedef/encoder/fixed_length_opaque.j2  |  17 +
 .../typedef/encoder/variable_length_array.j2  |  30 ++
 .../typedef/encoder/variable_length_opaque.j2 |  17 +
 .../typedef/encoder/variable_length_string.j2 |  17 +
 .../C/union/declaration/case_spec.j2          |   2 +
 .../templates/C/union/declaration/close.j2    |   8 +
 .../C/union/declaration/default_spec.j2       |   2 +
 .../templates/C/union/declaration/open.j2     |   6 +
 .../C/union/declaration/switch_spec.j2        |   3 +
 .../xdrgen/templates/C/union/decoder/basic.j2 |   6 +
 .../xdrgen/templates/C/union/decoder/break.j2 |   2 +
 .../templates/C/union/decoder/case_spec.j2    |   2 +
 .../xdrgen/templates/C/union/decoder/close.j2 |   4 +
 .../templates/C/union/decoder/default_spec.j2 |   2 +
 .../xdrgen/templates/C/union/decoder/open.j2  |  12 +
 .../C/union/decoder/optional_data.j2          |   6 +
 .../templates/C/union/decoder/switch_spec.j2  |   7 +
 .../C/union/decoder/variable_length_array.j2  |  13 +
 .../C/union/decoder/variable_length_opaque.j2 |   6 +
 .../C/union/decoder/variable_length_string.j2 |   6 +
 .../xdrgen/templates/C/union/decoder/void.j2  |   3 +
 .../xdrgen/templates/C/union/encoder/basic.j2 |  10 +
 .../xdrgen/templates/C/union/encoder/break.j2 |   2 +
 .../templates/C/union/encoder/case_spec.j2    |   2 +
 .../xdrgen/templates/C/union/encoder/close.j2 |   4 +
 .../templates/C/union/encoder/default_spec.j2 |   2 +
 .../xdrgen/templates/C/union/encoder/open.j2  |  12 +
 .../templates/C/union/encoder/switch_spec.j2  |   7 +
 .../xdrgen/templates/C/union/encoder/void.j2  |   3 +
 tools/net/sunrpc/xdrgen/tests/test.x          |  36 ++
 tools/net/sunrpc/xdrgen/xdr                   |   1 +
 tools/net/sunrpc/xdrgen/xdr.ebnf              | 117 +++++
 tools/net/sunrpc/xdrgen/xdr_ast.py            | 437 ++++++++++++++++++
 tools/net/sunrpc/xdrgen/xdr_parse.py          |  20 +
 tools/net/sunrpc/xdrgen/xdrgen                |  95 ++++
 112 files changed, 3986 insertions(+)
 create mode 100644 fs/nfsd/nfs4_1.x
 create mode 100644 fs/nfsd/nfs4xdr_gen.c
 create mode 100644 fs/nfsd/nfs4xdr_gen.h
 create mode 100644 include/linux/sunrpc/xdrgen-builtins.h
 create mode 100644 tools/net/sunrpc/xdrgen/.gitignore
 create mode 100644 tools/net/sunrpc/xdrgen/README
 create mode 100644 tools/net/sunrpc/xdrgen/__init__.py
 create mode 100644 tools/net/sunrpc/xdrgen/common.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/__init__.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/boilerplate.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/constant.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/enum.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/program.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/struct.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/typedef.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/union.py
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/__init__.py
 create mode 100755 tools/net/sunrpc/xdrgen/subcmds/header.py
 create mode 100755 tools/net/sunrpc/xdrgen/subcmds/lint.py
 create mode 100755 tools/net/sunrpc/xdrgen/subcmds/source.py
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_bottom.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_top.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/source_top.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/constants/declaration.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enumerator.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declaration/argument.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declaration/result.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/pointer-open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/pointer-open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/pointer-open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration/case_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration/default_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration/switch_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/break.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/default_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/switch_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/break.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/default_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/switch_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/tests/test.x
 create mode 120000 tools/net/sunrpc/xdrgen/xdr
 create mode 100644 tools/net/sunrpc/xdrgen/xdr.ebnf
 create mode 100644 tools/net/sunrpc/xdrgen/xdr_ast.py
 create mode 100644 tools/net/sunrpc/xdrgen/xdr_parse.py
 create mode 100755 tools/net/sunrpc/xdrgen/xdrgen

-- 
2.45.1


