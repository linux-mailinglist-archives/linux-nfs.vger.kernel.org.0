Return-Path: <linux-nfs+bounces-5810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41031961405
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42076B22F28
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7419C1A01CD;
	Tue, 27 Aug 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foYNthAY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CC1803D
	for <linux-nfs@vger.kernel.org>; Tue, 27 Aug 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776042; cv=none; b=K66O+Y3BWhPT4SUS0AkJkBrHFG5BociYQs4X2QIvJod2PqivVSyrybF9/m1bVD0rWS14urrjY68F8CBa50jW4635+nd1U7cz0VNWy/m0rggLNKCP+qEtITw4BclKN4h8sEVNAVUFb4CSpqi0j6dKmygtFDcLLweH2ANSc56D4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776042; c=relaxed/simple;
	bh=fgIqp6lsMqCxN/pBhy+2jHwha/IUGFLzrUEZPLdQ/lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYbxzTx4Lk5xzSI5TiWKjil7pZsNCMgeok61dTrI09DMQteg5lbfuZjVUV6uogJLaCTwdza3sPlHjmCnW2NEURq2pgVRTJBSxLngxYeJ9t9PkDCB0VilZGnZBGxSXG7Xo3+xHDtKlKVuq/H1kQL9LsKSc53gIY6NibvsNVPdkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foYNthAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A877C4CA0C;
	Tue, 27 Aug 2024 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776041;
	bh=fgIqp6lsMqCxN/pBhy+2jHwha/IUGFLzrUEZPLdQ/lc=;
	h=From:To:Cc:Subject:Date:From;
	b=foYNthAYdad8YmQXeCpuogYLsEKrE+yC+YS4KSl2toOV1bSRIqwTXSAW6U1uYRe0H
	 9RAQ+z4oEfE392WUYA7PDRLHMCLEe2Lrj0Xg6DMQAfd4zxxfpdGruy5TNVl2arj52j
	 6xjcB2EH8mbQLqOanYjAPrkgma1F8EHqUjNwp80rksRy5UnXjhoAidJqMgPvsX7M0w
	 oiVtwxUZ6LLT65rXTrvIaAE3/EyC18e4W2Ce7cP5sz6HZTM4OJqSj/Ci9gSpt6cmlx
	 4zKEeL3NYTwZnK42Vue1o37ASBfJ9cpsvmGtt4nda1c2E+mR7QzEP2/WpXXx1yxhO5
	 GbdMeeR0f12yw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/2] xdrgen tool
Date: Tue, 27 Aug 2024 12:27:16 -0400
Message-ID: <20240827162718.42342-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Update of the xdrgen tool.

I don't know what the merge criteria are for a tool like this, but
Jeff's delstid work depends on getting this merged first. I could
just pop it onto the nfsd-next stack, if folks think that's OK.

Changes include:
- Added some support for generating files for client side (not complete)
- Added a single SourceGenerator class, all others now inherit from that
- Split XDR pointers (optional data) into a separate class and generator
- Added Python type hints
- Lots of other minor cleanup

Original posting:

https://lore.kernel.org/linux-nfs/20240820144600.189744-1-cel@kernel.org/

Chuck Lever (2):
  tools: Add xdrgen
  NFSD: Create an initial nfs4_1.x file

 fs/nfsd/nfs4_1.x                              | 164 ++++++
 fs/nfsd/nfs4xdr_gen.c                         | 236 +++++++++
 fs/nfsd/nfs4xdr_gen.h                         | 100 ++++
 include/linux/sunrpc/xdrgen-builtins.h        | 256 +++++++++
 tools/net/sunrpc/xdrgen/.gitignore            |   2 +
 tools/net/sunrpc/xdrgen/README                | 249 +++++++++
 tools/net/sunrpc/xdrgen/__init__.py           |   2 +
 .../net/sunrpc/xdrgen/generators/__init__.py  |  49 ++
 .../sunrpc/xdrgen/generators/boilerplate.py   |  58 +++
 .../net/sunrpc/xdrgen/generators/constant.py  |  20 +
 tools/net/sunrpc/xdrgen/generators/enum.py    |  41 ++
 tools/net/sunrpc/xdrgen/generators/pointer.py | 283 ++++++++++
 tools/net/sunrpc/xdrgen/generators/program.py | 141 +++++
 tools/net/sunrpc/xdrgen/generators/struct.py  | 283 ++++++++++
 tools/net/sunrpc/xdrgen/generators/typedef.py | 225 ++++++++
 tools/net/sunrpc/xdrgen/generators/union.py   | 238 +++++++++
 tools/net/sunrpc/xdrgen/grammars/xdr.lark     | 119 +++++
 tools/net/sunrpc/xdrgen/subcmds/__init__.py   |   2 +
 tools/net/sunrpc/xdrgen/subcmds/header.py     |  88 ++++
 tools/net/sunrpc/xdrgen/subcmds/lint.py       |  33 ++
 tools/net/sunrpc/xdrgen/subcmds/source.py     | 121 +++++
 .../templates/C/boilerplate/header_bottom.j2  |   3 +
 .../templates/C/boilerplate/header_top.j2     |  11 +
 .../templates/C/boilerplate/source_top.j2     |   5 +
 .../templates/C/constants/definition.j2       |   3 +
 .../xdrgen/templates/C/enum/decoder/enum.j2   |  19 +
 .../templates/C/enum/definition/close.j2      |   7 +
 .../templates/C/enum/definition/enumerator.j2 |   2 +
 .../templates/C/enum/definition/open.j2       |   3 +
 .../xdrgen/templates/C/enum/encoder/enum.j2   |  14 +
 .../templates/C/pointer/decoder/basic.j2      |   6 +
 .../templates/C/pointer/decoder/close.j2      |   3 +
 .../C/pointer/decoder/fixed_length_array.j2   |   8 +
 .../C/pointer/decoder/fixed_length_opaque.j2  |   6 +
 .../templates/C/pointer/decoder/open.j2       |  22 +
 .../C/pointer/decoder/optional_data.j2        |   6 +
 .../pointer/decoder/variable_length_array.j2  |  13 +
 .../pointer/decoder/variable_length_opaque.j2 |   6 +
 .../pointer/decoder/variable_length_string.j2 |   6 +
 .../templates/C/pointer/definition/basic.j2   |   5 +
 .../templates/C/pointer/definition/close.j2   |   7 +
 .../pointer/definition/fixed_length_array.j2  |   5 +
 .../pointer/definition/fixed_length_opaque.j2 |   5 +
 .../templates/C/pointer/definition/open.j2    |   6 +
 .../C/pointer/definition/optional_data.j2     |   5 +
 .../definition/variable_length_array.j2       |   8 +
 .../definition/variable_length_opaque.j2      |   5 +
 .../definition/variable_length_string.j2      |   5 +
 .../templates/C/pointer/encoder/basic.j2      |  10 +
 .../templates/C/pointer/encoder/close.j2      |   3 +
 .../C/pointer/encoder/fixed_length_array.j2   |  12 +
 .../C/pointer/encoder/fixed_length_opaque.j2  |   6 +
 .../templates/C/pointer/encoder/open.j2       |  20 +
 .../C/pointer/encoder/optional_data.j2        |   6 +
 .../pointer/encoder/variable_length_array.j2  |  15 +
 .../pointer/encoder/variable_length_opaque.j2 |   8 +
 .../pointer/encoder/variable_length_string.j2 |   8 +
 .../C/program/declaration/argument.j2         |   2 +
 .../templates/C/program/declaration/result.j2 |   2 +
 .../templates/C/program/decoder/argument.j2   |  21 +
 .../templates/C/program/decoder/result.j2     |  22 +
 .../templates/C/program/encoder/argument.j2   |  16 +
 .../templates/C/program/encoder/result.j2     |  21 +
 .../templates/C/struct/decoder/basic.j2       |   6 +
 .../templates/C/struct/decoder/close.j2       |   3 +
 .../C/struct/decoder/fixed_length_array.j2    |   8 +
 .../C/struct/decoder/fixed_length_opaque.j2   |   6 +
 .../xdrgen/templates/C/struct/decoder/open.j2 |  12 +
 .../C/struct/decoder/optional_data.j2         |   6 +
 .../C/struct/decoder/variable_length_array.j2 |  13 +
 .../struct/decoder/variable_length_opaque.j2  |   6 +
 .../struct/decoder/variable_length_string.j2  |   6 +
 .../templates/C/struct/definition/basic.j2    |   5 +
 .../templates/C/struct/definition/close.j2    |   7 +
 .../C/struct/definition/fixed_length_array.j2 |   5 +
 .../struct/definition/fixed_length_opaque.j2  |   5 +
 .../templates/C/struct/definition/open.j2     |   6 +
 .../C/struct/definition/optional_data.j2      |   5 +
 .../definition/variable_length_array.j2       |   8 +
 .../definition/variable_length_opaque.j2      |   5 +
 .../definition/variable_length_string.j2      |   5 +
 .../templates/C/struct/encoder/basic.j2       |  10 +
 .../templates/C/struct/encoder/close.j2       |   3 +
 .../C/struct/encoder/fixed_length_array.j2    |  12 +
 .../C/struct/encoder/fixed_length_opaque.j2   |   6 +
 .../xdrgen/templates/C/struct/encoder/open.j2 |  12 +
 .../C/struct/encoder/optional_data.j2         |   6 +
 .../C/struct/encoder/variable_length_array.j2 |  15 +
 .../struct/encoder/variable_length_opaque.j2  |   8 +
 .../struct/encoder/variable_length_string.j2  |   8 +
 .../templates/C/typedef/decoder/basic.j2      |  17 +
 .../C/typedef/decoder/fixed_length_array.j2   |  25 +
 .../C/typedef/decoder/fixed_length_opaque.j2  |  17 +
 .../typedef/decoder/variable_length_array.j2  |  26 +
 .../typedef/decoder/variable_length_opaque.j2 |  17 +
 .../typedef/decoder/variable_length_string.j2 |  17 +
 .../templates/C/typedef/definition/basic.j2   |  15 +
 .../typedef/definition/fixed_length_array.j2  |  11 +
 .../typedef/definition/fixed_length_opaque.j2 |  11 +
 .../definition/variable_length_array.j2       |  14 +
 .../definition/variable_length_opaque.j2      |  11 +
 .../definition/variable_length_string.j2      |  11 +
 .../templates/C/typedef/encoder/basic.j2      |  21 +
 .../C/typedef/encoder/fixed_length_array.j2   |  25 +
 .../C/typedef/encoder/fixed_length_opaque.j2  |  17 +
 .../typedef/encoder/variable_length_array.j2  |  30 ++
 .../typedef/encoder/variable_length_opaque.j2 |  17 +
 .../typedef/encoder/variable_length_string.j2 |  17 +
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
 .../templates/C/union/definition/case_spec.j2 |   2 +
 .../templates/C/union/definition/close.j2     |   8 +
 .../C/union/definition/default_spec.j2        |   2 +
 .../templates/C/union/definition/open.j2      |   6 +
 .../C/union/definition/switch_spec.j2         |   3 +
 .../xdrgen/templates/C/union/encoder/basic.j2 |  10 +
 .../xdrgen/templates/C/union/encoder/break.j2 |   2 +
 .../templates/C/union/encoder/case_spec.j2    |   2 +
 .../xdrgen/templates/C/union/encoder/close.j2 |   4 +
 .../templates/C/union/encoder/default_spec.j2 |   2 +
 .../xdrgen/templates/C/union/encoder/open.j2  |  12 +
 .../templates/C/union/encoder/switch_spec.j2  |   7 +
 .../xdrgen/templates/C/union/encoder/void.j2  |   3 +
 tools/net/sunrpc/xdrgen/tests/test.x          |  36 ++
 tools/net/sunrpc/xdrgen/xdr_ast.py            | 485 ++++++++++++++++++
 tools/net/sunrpc/xdrgen/xdr_parse.py          |  36 ++
 tools/net/sunrpc/xdrgen/xdrgen                | 111 ++++
 137 files changed, 4392 insertions(+)
 create mode 100644 fs/nfsd/nfs4_1.x
 create mode 100644 fs/nfsd/nfs4xdr_gen.c
 create mode 100644 fs/nfsd/nfs4xdr_gen.h
 create mode 100644 include/linux/sunrpc/xdrgen-builtins.h
 create mode 100644 tools/net/sunrpc/xdrgen/.gitignore
 create mode 100644 tools/net/sunrpc/xdrgen/README
 create mode 100644 tools/net/sunrpc/xdrgen/__init__.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/__init__.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/boilerplate.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/constant.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/enum.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/pointer.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/program.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/struct.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/typedef.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/union.py
 create mode 100644 tools/net/sunrpc/xdrgen/grammars/xdr.lark
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/__init__.py
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/header.py
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/lint.py
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/source.py
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_bottom.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_top.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/source_top.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/constants/definition.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/enumerator.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declaration/argument.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declaration/result.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/encoder/argument.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2
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
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/case_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/default_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/switch_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/break.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/default_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/switch_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/tests/test.x
 create mode 100644 tools/net/sunrpc/xdrgen/xdr_ast.py
 create mode 100644 tools/net/sunrpc/xdrgen/xdr_parse.py
 create mode 100755 tools/net/sunrpc/xdrgen/xdrgen

-- 
2.45.2


