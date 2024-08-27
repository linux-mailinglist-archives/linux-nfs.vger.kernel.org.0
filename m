Return-Path: <linux-nfs+bounces-5811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B31961406
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3CD1F246F5
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D721A01CD;
	Tue, 27 Aug 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA6ojVw7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4E1C4EE3
	for <linux-nfs@vger.kernel.org>; Tue, 27 Aug 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776064; cv=none; b=EdH98fnrqCiqKh53QUdR8lKoH5oCHvlPrvb33q5SXQXHQogMrB2ce7nBX/WHfc0UeAzIDI1diGBPW6rd2cbdGK7tnEfoHOOm7SDa0WZtZ4DwePz0S9/9rHPNxR5g2neJBp+ubQLZRJkZMOsvTFvJqp0DTWChHLYVKkRzmA2c7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776064; c=relaxed/simple;
	bh=KWB+GH7FAql0aD/VUsHNoi2Iw1S9RJQI94G25GHaAvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSZYL0HzTSjGnL4CNv8qITXT1yjFGr8RqYMgxHmM5yM7eVjoYZ7e5pwmnlC+oynJvNgELvbgEyPsvJdePJUEGnXCxL5ZCpXPnW9Hks3Kq9TOEgOAxbfcsY9XOntA7kk8WdTaqe0rPPzzw9eMfP2WZX7RHkWQpyjQ4rvFhd+8Lec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA6ojVw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41DEC4CA0C;
	Tue, 27 Aug 2024 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776064;
	bh=KWB+GH7FAql0aD/VUsHNoi2Iw1S9RJQI94G25GHaAvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jA6ojVw7aQ3pDLfrkmwtOUEFpIhZ7Safw2NKCvCkmBs4vwIvZurXiZZGyq4NrGe2g
	 z8yt2JVaprhetHTGrkULzuJ0iRjwS1gEplzJ8tluJMML7WLiTnLtkD19rlzRhBjKYx
	 h2UrCu+j+y14mTNM1/Vxpd1zvIjc3KEPE3b8kCwBabxlfb6RO6ny4AVBGQ1Nccz3RQ
	 ptUBJxLiJ6nU59azbfR7/Lwofowna4V84pnZLnBtc4skTxFHs2+UvgqNQ7PY5LZ59R
	 qgpWvu4L3a6vLanJyQJ1q9ArwuW5ZbhWPyEkNoxdG1mXhz61zzxp/gMLByqUkdCs18
	 gGgwG3Mqk59CQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/2] tools: Add xdrgen
Date: Tue, 27 Aug 2024 12:27:17 -0400
Message-ID: <20240827162718.42342-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827162718.42342-1-cel@kernel.org>
References: <20240827162718.42342-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add a Python-based tool for translating XDR specifications into XDR
encoder and decoder functions written in the Linux kernel's C coding
style. The generator attempts to match the usual C coding style of
the Linux kernel's SunRPC consumers.

This approach is similar to the netlink code generator in
tools/net/ynl .

The maintainability benefits of machine-generated XDR code include:

- Stronger type checking
- Reduces the number of bugs introduced by human error
- Makes the XDR code easier to audit and analyze
- Enables rapid prototyping of new RPC-based protocols
- Hardens the layering between protocol logic and marshaling
- Makes it easier to add observability on demand
- Unit tests might be built for both the tool and (automatically)
  for the generated code

In addition, converting the XDR layer to use memory-safe languages
such as Rust will be easier if much of the code can be converted
automatically.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
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
 134 files changed, 3892 insertions(+)
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

diff --git a/include/linux/sunrpc/xdrgen-builtins.h b/include/linux/sunrpc/xdrgen-builtins.h
new file mode 100644
index 000000000000..00cbd09e100d
--- /dev/null
+++ b/include/linux/sunrpc/xdrgen-builtins.h
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ *
+ * This header defines the XDR data type primitives, specified in
+ * Section 4 of RFC 4506, that are used by RPC programs implemented
+ * in the Linux kernel.
+ */
+
+#ifndef _SUNRPC_XDRGEN_BUILTINS_H_
+#define _SUNRPC_XDRGEN_BUILTINS_H_
+
+#include <linux/sunrpc/xdr.h>
+
+#define TRUE	(true)
+#define FALSE	(false)
+
+static inline bool
+xdrgen_decode_void(struct xdr_stream *xdr)
+{
+	return true;
+}
+
+static inline bool
+xdrgen_encode_void(struct xdr_stream *xdr)
+{
+	return true;
+}
+
+static inline bool
+xdrgen_decode_bool(struct xdr_stream *xdr, bool *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = (*p != xdr_zero);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_bool(struct xdr_stream *xdr, bool val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = val ? xdr_one : xdr_zero;
+	return true;
+}
+
+static inline bool
+xdrgen_decode_int(struct xdr_stream *xdr, s32 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = be32_to_cpup(p);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_int(struct xdr_stream *xdr, s32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_unsigned_int(struct xdr_stream *xdr, u32 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = be32_to_cpup(p);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_unsigned_int(struct xdr_stream *xdr, u32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_long(struct xdr_stream *xdr, s32 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = be32_to_cpup(p);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_long(struct xdr_stream *xdr, s32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_unsigned_long(struct xdr_stream *xdr, u32 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = be32_to_cpup(p);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_unsigned_long(struct xdr_stream *xdr, u32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_hyper(struct xdr_stream *xdr, s64 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT * 2);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = get_unaligned_be64(p);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_hyper(struct xdr_stream *xdr, s64 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT * 2);
+
+	if (unlikely(!p))
+		return false;
+	put_unaligned_be64(val, p);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_unsigned_hyper(struct xdr_stream *xdr, u64 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT * 2);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = get_unaligned_be64(p);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_unsigned_hyper(struct xdr_stream *xdr, u64 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT * 2);
+
+	if (unlikely(!p))
+		return false;
+	put_unaligned_be64(val, p);
+	return true;
+}
+
+typedef struct {
+	u32 len;
+	unsigned char *data;
+} string;
+
+static inline bool
+xdrgen_decode_string(struct xdr_stream *xdr, string *ptr, u32 maxlen)
+{
+	__be32 *p;
+	u32 len;
+
+	if (unlikely(xdr_stream_decode_u32(xdr, &len) != XDR_UNIT))
+		return false;
+	if (unlikely(maxlen && len > maxlen))
+		return false;
+	if (len != 0) {
+		p = xdr_inline_decode(xdr, len);
+		if (unlikely(!p))
+			return false;
+		ptr->data = (unsigned char *)p;
+	}
+	ptr->len = len;
+	return true;
+}
+
+static inline bool
+xdrgen_encode_string(struct xdr_stream *xdr, string val, u32 maxlen)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT + xdr_align_size(val.len));
+
+	if (unlikely(!p))
+		return false;
+	xdr_encode_opaque(p, val.data, val.len);
+	return true;
+}
+
+typedef struct {
+	u32 len;
+	u8 *data;
+} opaque;
+
+static inline bool
+xdrgen_decode_opaque(struct xdr_stream *xdr, opaque *ptr, u32 maxlen)
+{
+	__be32 *p;
+	u32 len;
+
+	if (unlikely(xdr_stream_decode_u32(xdr, &len) != XDR_UNIT))
+		return false;
+	if (unlikely(maxlen && len > maxlen))
+		return false;
+	if (len != 0) {
+		p = xdr_inline_decode(xdr, len);
+		if (unlikely(!p))
+			return false;
+		ptr->data = (u8 *)p;
+	}
+	ptr->len = len;
+	return true;
+}
+
+static inline bool
+xdrgen_encode_opaque(struct xdr_stream *xdr, opaque val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT + xdr_align_size(val.len));
+
+	if (unlikely(!p))
+		return false;
+	xdr_encode_opaque(p, val.data, val.len);
+	return true;
+}
+
+#endif /* _SUNRPC_XDRGEN_BUILTINS_H_ */
diff --git a/tools/net/sunrpc/xdrgen/.gitignore b/tools/net/sunrpc/xdrgen/.gitignore
new file mode 100644
index 000000000000..d7366c2f9be8
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/.gitignore
@@ -0,0 +1,2 @@
+__pycache__
+generators/__pycache__
diff --git a/tools/net/sunrpc/xdrgen/README b/tools/net/sunrpc/xdrgen/README
new file mode 100644
index 000000000000..a1a2454a5edf
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/README
@@ -0,0 +1,249 @@
+xdrgen - Linux Kernel XDR code generator
+
+Introduction
+------------
+
+SunRPC programs are typically specified using a language defined by
+RFC 4506. In fact, all IETF-published NFS specifications provide a
+description of the specified protocol using this language.
+
+Since the 1990's, user space consumers of SunRPC have had access to
+a tool that could read such XDR specifications and then generate C
+code that implements the RPC portions of that protocol. This tool is
+called rpcgen.
+
+This RPC-level code is code that handles input directly from the
+network, and thus a high degree of memory safety and sanity checking
+is needed to help ensure proper levels of security. Bugs in this
+code can have significant impact on security and performance.
+
+However, it is code that is repetitive and tedious to write by hand.
+
+The C code generated by rpcgen makes extensive use of the facilities
+of the user space TI-RPC library and libc. Furthermore, the dialect
+of the generated code is very traditional K&R C.
+
+The Linux kernel's implementation of SunRPC-based protocols hand-roll
+their XDR implementation. There are two main reasons for this:
+
+1. libtirpc (and its predecessors) operate only in user space. The
+   kernel's RPC implementation and its API are significantly
+   different than libtirpc.
+
+2. rpcgen-generated code is believed to be less efficient than code
+   that is hand-written.
+
+These days, gcc and its kin are capable of optimizing code better
+than human authors. There are only a few instances where writing
+XDR code by hand will make a measurable performance different.
+
+In addition, the current hand-written code in the Linux kernel is
+difficult to audit and prove that it implements exactly what is in
+the protocol specification.
+
+In order to accrue the benefits of machine-generated XDR code in the
+kernel, a tool is needed that will output C code that works against
+the kernel's SunRPC implementation rather than libtirpc.
+
+Enter xdrgen.
+
+
+Dependencies
+------------
+
+These dependencies are typically packaged by Linux distributions:
+
+- python3
+- python3-lark
+- python3-jinja2
+
+These dependencies are available via PyPi:
+
+- pip install 'lark[interegular]'
+
+
+XDR Specifications
+------------------
+
+When adding a new protocol implementation to the kernel, the XDR
+specification can be derived by feeding a .txt copy of the RFC to
+the script located in tools/net/sunrpc/extract.sh.
+
+   $ extract.sh < rfc0001.txt > new2.x
+
+
+Operation
+---------
+
+Once a .x file is available, use xdrgen to generate source and
+header files containing an implementation of XDR encoding and
+decoding functions for the specified protocol.
+
+   $ ./xdrgen header --definitions --declarations new2.x > new2xdr_gen.h
+
+and
+
+   $ ./xdrgen source new2.x > new2xdr_gen.c
+
+The files are ready to use for a server-side protocol implementation,
+or may be used as a guide for implementing these routines by hand.
+
+By default, the only comments added to this code are kdoc comments
+that appear directly in front of the public per-procedure APIs. For
+deeper introspection, specifying the "--annotate" flag will insert
+additional comments in the generated code to help readers match the
+generated code to specific parts of the XDR specification.
+
+Because the generated code is targeted for the Linux kernel, it
+is tagged with a GPLv2-only license.
+
+The xdrgen tool can also provide lexical and syntax checking of
+an XDR specification:
+
+   $ ./xdrgen lint xdr/new.x
+
+
+How It Works
+------------
+
+xdrgen does not use machine learning to generate source code. The
+translation is entirely deterministic.
+
+RFC 4506 Section 6 contains a BNF grammar of the XDR specification
+language. The grammar has been adapted for use by the Python Lark
+module.
+
+The xdr.ebnf file in this directory contains the grammar used to
+parse XDR specifications. xdrgen configures Lark using the grammar
+in xdr.ebnf. Lark parses the target XDR specification using this
+grammar, creating a parse tree.
+
+xdrgen then transforms the parse tree into an abstract syntax tree.
+This tree is passed to a series of code generators.
+
+The generators are implemented as Python classes residing in the
+generators/ directory. Each generator emits code created from Jinja2
+templates stored in the templates/ directory.
+
+The source code is generated in the same order in which they appear
+in the specification to ensure the generated code compiles. This
+conforms with the behavior of rpcgen.
+
+xdrgen assumes that the generated source code is further compiled by
+a compiler that can optimize in a number of ways, including:
+
+ - Unused functions are discarded (ie, not added to the executable)
+
+ - Aggressive function inlining removes unnecessary stack frames
+
+ - Single-arm switch statements are replaced by a single conditional
+   branch
+
+And so on.
+
+
+Pragmas
+-------
+
+Pragma directives specify exceptions to the normal generation of
+encoding and decoding functions. Currently one directive is
+implemented: "public".
+
+Pragma exclude
+------ -------
+
+  pragma exclude <RPC procedure> ;
+
+In some cases, a procedure encoder or decoder function might need
+special processing that cannot be automatically generated. The
+automatically-generated functions might conflict or interfere with
+the hand-rolled function. To avoid editing the generated source code
+by hand, a pragma can specify that the procedure's encoder and
+decoder functions are not included in the generated header and
+source.
+
+For example:
+
+  pragma exclude NFSPROC3_READDIRPLUS;
+
+Excludes the decoder function for the READDIRPLUS argument and the
+encoder function for the READDIRPLUS result.
+
+Note that because data item encoder and decoder functions are
+defined "static __maybe_unused", subsequent compilation
+automatically excludes data item encoder and decoder functions that
+are used only by excluded procedure.
+
+Pragma header
+------ ------
+
+  pragma header <string> ;
+
+Provide a name to use for the header file and header guards.
+
+For example:
+
+  pragma header nlm4;
+
+Adds header guards in the generated header file called
+
+  NLM4_XDR_GEN_H
+
+And adds
+
+  #include "nlm4xdr_gen.h"
+
+to the generated source file.
+
+Pragma public
+------ ------
+
+  pragma public <XDR data item> ;
+
+Normally XDR encoder and decoder functions are "static". In case an
+implementer wants to call these functions from other source code,
+s/he can add a public pragma in the input .x file to indicate a set
+of functions that should get a prototype in the generated header,
+and the function definitions will not be declared static.
+
+For example:
+
+  pragma public nfsstat3;
+
+Adds these prototypes in the generated header:
+
+  bool xdrgen_decode_nfsstat3(struct xdr_stream *xdr, enum nfsstat3 *ptr);
+  bool xdrgen_encode_nfsstat3(struct xdr_stream *xdr, enum nfsstat3 value);
+
+And, in the generated source code, both of these functions appear
+without the "static __maybe_unused" modifiers.
+
+
+Future Work
+-----------
+
+Finish implementing XDR pointer and list types.
+
+Generate client-side procedure functions
+
+Expand the README into a user guide similar to rpcgen(1)
+
+Add more pragma directives:
+
+  * @pages -- use xdr_read/write_pages() for the specified opaque
+    field
+  * @skip -- do not decode, but rather skip, the specified argument
+    field
+
+Enable something like a #include to dynamically insert the content
+of other specification files
+
+Properly support line-by-line pass-through via the "%" decorator
+
+Build a unit test suite for verifying translation of XDR language
+into compilable code
+
+Add a command-line option to insert trace_printk call sites in the
+generated source code, for improved (temporary) observability
+
+Generate kernel Rust code as well as C code
diff --git a/tools/net/sunrpc/xdrgen/__init__.py b/tools/net/sunrpc/xdrgen/__init__.py
new file mode 100644
index 000000000000..c940e9275252
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/__init__.py
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+# Just to make sphinx-apidoc document this directory
diff --git a/tools/net/sunrpc/xdrgen/generators/__init__.py b/tools/net/sunrpc/xdrgen/generators/__init__.py
new file mode 100644
index 000000000000..306b34a1a203
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/__init__.py
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""Define a base code generator class"""
+
+import sys
+from jinja2 import Environment, FileSystemLoader
+
+from xdr_ast import _XdrAst, public_apis, pass_by_reference
+from xdr_parse import get_xdr_annotate
+
+def create_jinja2_environment(language: str, xdr_type: str) -> Environment:
+    """Open a set of templates based on output language"""
+    match language:
+        case "C":
+            environment = Environment(
+                loader=FileSystemLoader(sys.path[0] + "/templates/C/" + xdr_type + "/"),
+                trim_blocks=True,
+                lstrip_blocks=True,
+            )
+            environment.globals["annotate"] = get_xdr_annotate()
+            environment.globals["public_apis"] = public_apis
+            environment.globals["pass_by_reference"] = pass_by_reference
+            return environment
+        case _:
+            raise NotImplementedError("Language not supported")
+
+
+class SourceGenerator:
+    """Base class to generate source code for XDR types"""
+
+    def __init__(self, language: str, peer: str):
+        """Initialize an instance of this class"""
+        raise NotImplementedError("No language support defined")
+
+    def emit_definition(self, node: _XdrAst) -> None:
+        """Emit one definition for this XDR type"""
+        raise NotImplementedError("Definition generation not supported")
+
+    def emit_declaration(self, node: _XdrAst) -> None:
+        """Emit one function declaration for this XDR type"""
+        raise NotImplementedError("Declaration generation not supported")
+
+    def emit_decoder(self, node: _XdrAst) -> None:
+        """Emit one decoder function for this XDR type"""
+        raise NotImplementedError("Decoder generation not supported")
+
+    def emit_encoder(self, node: _XdrAst) -> None:
+        """Emit one encoder function for this XDR type"""
+        raise NotImplementedError("Encoder generation not supported")
diff --git a/tools/net/sunrpc/xdrgen/generators/boilerplate.py b/tools/net/sunrpc/xdrgen/generators/boilerplate.py
new file mode 100644
index 000000000000..3d8c7e0937e3
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/boilerplate.py
@@ -0,0 +1,58 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate boilerplate items"""
+
+import os.path
+import time
+
+from generators import create_jinja2_environment
+from xdr_ast import _XdrAst, _RpcProgram, Specification, get_header_name
+
+
+def find_xdr_program_name(root: Specification) -> str:
+    """Retrieve the RPC program name from an abstract syntax tree"""
+    raw_name = get_header_name()
+    if raw_name != "none":
+        return raw_name.lower()
+    for definition in root.definitions:
+        if isinstance(definition.value, _RpcProgram):
+            raw_name = definition.value.name
+            return raw_name.lower().removesuffix("_program").removesuffix("_prog")
+    return "noprog"
+
+
+class XdrBoilerplateGenerator:
+    """Generate source code boilerplate"""
+
+    def __init__(self, language: str):
+        """Initialize an instance of this class"""
+        self.environment = create_jinja2_environment(language, "boilerplate")
+
+    def emit_header_bottom(self, root: Specification) -> None:
+        """Emit the bottom header guard"""
+        name = find_xdr_program_name(root)
+        template = self.environment.get_template("header_bottom.j2")
+        print(template.render(program=name))
+
+    def emit_header_top(self, filename: str, root: Specification) -> None:
+        """Emit the top header guard"""
+        name = find_xdr_program_name(root)
+        template = self.environment.get_template("header_top.j2")
+        print(
+            template.render(
+                program=name,
+                mtime=time.ctime(os.path.getmtime(filename)),
+            )
+        )
+
+    def emit_source_top(self, filename: str, root: Specification) -> None:
+        """Emit the top source boilerplate"""
+        name = find_xdr_program_name(root)
+        template = self.environment.get_template("source_top.j2")
+        print(
+            template.render(
+                program=name,
+                mtime=time.ctime(os.path.getmtime(filename)),
+            )
+        )
diff --git a/tools/net/sunrpc/xdrgen/generators/constant.py b/tools/net/sunrpc/xdrgen/generators/constant.py
new file mode 100644
index 000000000000..f2339caf0953
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/constant.py
@@ -0,0 +1,20 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR constants"""
+
+from generators import SourceGenerator, create_jinja2_environment
+from xdr_ast import _XdrConstant
+
+class XdrConstantGenerator(SourceGenerator):
+    """Generate source code for XDR constants"""
+
+    def __init__(self, language: str, peer: str):
+        """Initialize an instance of this class"""
+        self.environment = create_jinja2_environment(language, "constants")
+        self.peer = peer
+
+    def emit_definition(self, node: _XdrConstant) -> None:
+        """Emit one definition for a constant"""
+        template = self.environment.get_template("definition.j2")
+        print(template.render(name=node.name, value=node.value))
diff --git a/tools/net/sunrpc/xdrgen/generators/enum.py b/tools/net/sunrpc/xdrgen/generators/enum.py
new file mode 100644
index 000000000000..e893f6f90a72
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/enum.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR enum types"""
+
+from generators import SourceGenerator, create_jinja2_environment
+from xdr_ast import _XdrEnum
+
+
+class XdrEnumGenerator(SourceGenerator):
+    """Generate source code for XDR enum types"""
+
+    def __init__(self, language: str, peer: str):
+        """Initialize an instance of this class"""
+        self.environment = create_jinja2_environment(language, "enum")
+        self.peer = peer
+
+    def emit_definition(self, node: _XdrEnum) -> None:
+        """Emit one definition for an XDR enum type"""
+
+        template = self.environment.get_template("definition/open.j2")
+        print(template.render(name=node.name))
+
+        template = self.environment.get_template("definition/enumerator.j2")
+        for enumerator in node.enumerators:
+            print(template.render(name=enumerator.name, value=enumerator.value))
+
+        template = self.environment.get_template("definition/close.j2")
+        print(template.render(name=node.name))
+
+    def emit_decoder(self, node: _XdrEnum) -> None:
+        """Emit one decoder function for an XDR enum type"""
+
+        template = self.environment.get_template("decoder/enum.j2")
+        print(template.render(name=node.name))
+
+    def emit_encoder(self, node: _XdrEnum) -> None:
+        """Emit one encoder function for an XDR enum type"""
+
+        template = self.environment.get_template("encoder/enum.j2")
+        print(template.render(name=node.name))
diff --git a/tools/net/sunrpc/xdrgen/generators/pointer.py b/tools/net/sunrpc/xdrgen/generators/pointer.py
new file mode 100644
index 000000000000..fd209d9cc2b4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/pointer.py
@@ -0,0 +1,283 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR pointer types"""
+
+from jinja2 import Environment, Template
+
+from generators import SourceGenerator, create_jinja2_environment
+
+from xdr_ast import _XdrBasic, _XdrVariableLengthString
+from xdr_ast import _XdrFixedLengthOpaque, _XdrVariableLengthOpaque
+from xdr_ast import _XdrFixedLengthArray, _XdrVariableLengthArray
+from xdr_ast import _XdrOptionalData, _XdrBuiltInType, _XdrPointer
+from xdr_ast import _XdrDeclaration
+
+
+def get_kernel_c_type(type_spec: str) -> str:
+    """Return C type to be used for an XDR built-in type"""
+    xdr_type_to_c_type = {
+        "unsigned_hyper": "u64",
+        "hyper": "s64",
+        "unsigned_long": "u32",
+        "long": "s32",
+        "unsigned_int": "u32",
+        "int": "s32",
+        "bool": "bool",
+    }
+    if isinstance(type_spec, _XdrBuiltInType):
+        return xdr_type_to_c_type[type_spec.type_name]
+    return type_spec.type_name
+
+
+def get_jinja_template(
+    environment: Environment, template_type: str, template_name: str
+) -> Template:
+    """Retrieve a Jinja2 template for emitting source code"""
+    return environment.get_template(template_type + "/" + template_name + ".j2")
+
+
+def emit_pointer_member_definition(
+    environment: Environment, field: _XdrDeclaration
+) -> None:
+    """Emit a definition for one field in an XDR struct"""
+    if isinstance(field, _XdrBasic):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthOpaque):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthOpaque):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(template.render(name=field.name))
+    elif isinstance(field, _XdrVariableLengthString):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(template.render(name=field.name))
+    elif isinstance(field, _XdrFixedLengthArray):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthArray):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrOptionalData):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                ctype=field.spec.type_decorator,
+            )
+        )
+
+
+def emit_pointer_definition(environment: Environment, node: _XdrPointer) -> None:
+    """Emit a definition for an XDR pointer type"""
+    template = get_jinja_template(environment, "definition", "open")
+    print(template.render(name=node.name))
+
+    for field in node.fields[0:-1]:
+        emit_pointer_member_definition(environment, field)
+
+    template = get_jinja_template(environment, "definition", "close")
+    print(template.render(name=node.name))
+
+
+def emit_pointer_member_decoder(
+    environment: Environment, field: _XdrDeclaration
+) -> None:
+    """Emit a decoder for one field in an XDR pointer"""
+    if isinstance(field, _XdrBasic):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthOpaque):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthOpaque):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthString):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthArray):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                size=field.size,
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthArray):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                maxsize=field.maxsize,
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrOptionalData):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                ctype=field.spec.type_decorator,
+            )
+        )
+
+
+def emit_pointer_decoder(environment: Environment, node: _XdrPointer) -> None:
+    """Emit one decoder function for an XDR pointer type"""
+    template = get_jinja_template(environment, "decoder", "open")
+    print(template.render(name=node.name))
+
+    for field in node.fields[0:-1]:
+        emit_pointer_member_decoder(environment, field)
+
+    template = get_jinja_template(environment, "decoder", "close")
+    print(template.render())
+
+
+def emit_pointer_member_encoder(
+    environment: Environment, field: _XdrDeclaration
+) -> None:
+    """Emit an encoder for one field in a XDR pointer"""
+    if isinstance(field, _XdrBasic):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthOpaque):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthOpaque):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthString):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthArray):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthArray):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrOptionalData):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                ctype=field.spec.type_decorator,
+            )
+        )
+
+
+def emit_pointer_encoder(environment: Environment, node: _XdrPointer) -> None:
+    """Emit one encoder function for a pointer type"""
+    template = get_jinja_template(environment, "encoder", "open")
+    print(template.render(name=node.name))
+
+    for field in node.fields[0:-1]:
+        emit_pointer_member_encoder(environment, field)
+
+    template = get_jinja_template(environment, "encoder", "close")
+    print(template.render())
+
+
+class XdrPointerGenerator(SourceGenerator):
+    """Generate source code for XDR pointer"""
+
+    def __init__(self, language: str, peer: str):
+        """Initialize an instance of this class"""
+        self.environment = create_jinja2_environment(language, "pointer")
+        self.peer = peer
+
+    def emit_definition(self, node: _XdrPointer) -> None:
+        """Emit one declaration for a pointer type"""
+        emit_pointer_definition(self.environment, node)
+
+    def emit_decoder(self, node: _XdrPointer) -> None:
+        """Emit one decoder function for a pointer type"""
+        emit_pointer_decoder(self.environment, node)
+
+    def emit_encoder(self, node: _XdrPointer) -> None:
+        """Emit one encoder function for a pointer type"""
+        emit_pointer_encoder(self.environment, node)
diff --git a/tools/net/sunrpc/xdrgen/generators/program.py b/tools/net/sunrpc/xdrgen/generators/program.py
new file mode 100644
index 000000000000..7c9016b4c635
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/program.py
@@ -0,0 +1,141 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code for an RPC program's procedures"""
+
+from jinja2 import Environment
+
+from generators import SourceGenerator, create_jinja2_environment
+from xdr_ast import _RpcProgram, _RpcVersion, excluded_apis
+
+
+def emit_version_declarations(
+    environment: Environment, program: str, version: _RpcVersion
+) -> None:
+    """Emit declarations for each RPC version's procedures"""
+    print("")
+    template = environment.get_template("declaration/argument.j2")
+    for procedure in version.procedures:
+        if procedure.name not in excluded_apis:
+            print(
+                template.render(
+                    program=program,
+                    argument=procedure.argument.type_name,
+                )
+            )
+
+    print("")
+    template = environment.get_template("declaration/result.j2")
+    for procedure in version.procedures:
+        if procedure.name not in excluded_apis:
+            print(
+                template.render(
+                    program=program,
+                    result=procedure.result.type_name,
+                )
+            )
+
+
+def emit_version_argument_decoders(
+    environment: Environment, program: str, version: _RpcVersion
+) -> None:
+    """Emit server argument decoders for each RPC version's procedures"""
+    arguments = set()
+    for procedure in version.procedures:
+        if procedure.name not in excluded_apis:
+            arguments.add(procedure.argument.type_name)
+
+    template = environment.get_template("decoder/argument.j2")
+    for argument in arguments:
+        print(template.render(program=program, argument=argument))
+
+
+def emit_version_result_decoders(
+    environment: Environment, program: str, version: _RpcVersion
+) -> None:
+    """Emit client result decoders for each RPC version's procedures"""
+    results = set()
+    for procedure in version.procedures:
+        if procedure.name not in excluded_apis:
+            results.add(procedure.result.type_name)
+
+    template = environment.get_template("decoder/result.j2")
+    for result in results:
+        print(template.render(program=program, result=result))
+
+
+def emit_version_argument_encoders(
+    environment: Environment, program: str, version: _RpcVersion
+) -> None:
+    """Emit client argument encoders for each RPC version's procedures"""
+    arguments = set()
+    for procedure in version.procedures:
+        if procedure.name not in excluded_apis:
+            arguments.add(procedure.argument.type_name)
+
+    template = environment.get_template("encoder/argument.j2")
+    for argument in arguments:
+        print(template.render(program=program, argument=argument))
+
+
+def emit_version_result_encoders(
+    environment: Environment, program: str, version: _RpcVersion
+) -> None:
+    """Emit server result encoders for each RPC version's procedures"""
+    results = set()
+    for procedure in version.procedures:
+        if procedure.name not in excluded_apis:
+            results.add(procedure.result.type_name)
+
+    template = environment.get_template("encoder/result.j2")
+    for result in results:
+        print(template.render(program=program, result=result))
+
+
+class XdrProgramGenerator(SourceGenerator):
+    """Generate source code for an RPC program's procedures"""
+
+    def __init__(self, language: str, peer: str):
+        """Initialize an instance of this class"""
+        self.environment = create_jinja2_environment(language, "program")
+        self.peer = peer
+
+    def emit_declaration(self, node: _RpcProgram) -> None:
+        """Emit a declaration pair for each of an RPC programs's procedures"""
+        raw_name = node.name
+        program = raw_name.lower().removesuffix("_program").removesuffix("_prog")
+
+        for version in node.versions:
+            emit_version_declarations(self.environment, program, version)
+
+    def emit_decoder(self, node: _RpcProgram) -> None:
+        """Emit all decoder functions for an RPC program's procedures"""
+        raw_name = node.name
+        program = raw_name.lower().removesuffix("_program").removesuffix("_prog")
+        match self.peer:
+            case "server":
+                for version in node.versions:
+                    emit_version_argument_decoders(
+                        self.environment, program, version,
+                    )
+            case "client":
+                for version in node.versions:
+                    emit_version_result_decoders(
+                        self.environment, program, version,
+                    )
+
+    def emit_encoder(self, node: _RpcProgram) -> None:
+        """Emit all encoder functions for an RPC program's procedures"""
+        raw_name = node.name
+        program = raw_name.lower().removesuffix("_program").removesuffix("_prog")
+        match self.peer:
+            case "server":
+                for version in node.versions:
+                    emit_version_result_encoders(
+                        self.environment, program, version,
+                    )
+            case "client":
+                for version in node.versions:
+                    emit_version_argument_encoders(
+                        self.environment, program, version,
+                    )
diff --git a/tools/net/sunrpc/xdrgen/generators/struct.py b/tools/net/sunrpc/xdrgen/generators/struct.py
new file mode 100644
index 000000000000..117319ae70d1
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/struct.py
@@ -0,0 +1,283 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR struct types"""
+
+from jinja2 import Environment, Template
+
+from generators import SourceGenerator, create_jinja2_environment
+
+from xdr_ast import _XdrBasic, _XdrVariableLengthString
+from xdr_ast import _XdrFixedLengthOpaque, _XdrVariableLengthOpaque
+from xdr_ast import _XdrFixedLengthArray, _XdrVariableLengthArray
+from xdr_ast import _XdrOptionalData, _XdrBuiltInType, _XdrStruct
+from xdr_ast import _XdrDeclaration
+
+
+def get_kernel_c_type(type_spec: str) -> str:
+    """Return C type to be used for an XDR built-in type"""
+    xdr_type_to_c_type = {
+        "unsigned_hyper": "u64",
+        "hyper": "s64",
+        "unsigned_long": "u32",
+        "long": "s32",
+        "unsigned_int": "u32",
+        "int": "s32",
+        "bool": "bool",
+    }
+    if isinstance(type_spec, _XdrBuiltInType):
+        return xdr_type_to_c_type[type_spec.type_name]
+    return type_spec.type_name
+
+
+def get_jinja_template(
+    environment: Environment, template_type: str, template_name: str
+) -> Template:
+    """Retrieve a Jinja2 template for emitting source code"""
+    return environment.get_template(template_type + "/" + template_name + ".j2")
+
+
+def emit_struct_member_definition(
+    environment: Environment, field: _XdrDeclaration
+) -> None:
+    """Emit a definition for one field in an XDR struct"""
+    if isinstance(field, _XdrBasic):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthOpaque):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthOpaque):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(template.render(name=field.name))
+    elif isinstance(field, _XdrVariableLengthString):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(template.render(name=field.name))
+    elif isinstance(field, _XdrFixedLengthArray):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthArray):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrOptionalData):
+        template = get_jinja_template(environment, "definition", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                ctype=field.spec.type_decorator,
+            )
+        )
+
+
+def emit_struct_definition(environment: Environment, node: _XdrStruct) -> None:
+    """Emit one definition for an XDR struct type"""
+    template = get_jinja_template(environment, "definition", "open")
+    print(template.render(name=node.name))
+
+    for field in node.fields:
+        emit_struct_member_definition(environment, field)
+
+    template = get_jinja_template(environment, "definition", "close")
+    print(template.render(name=node.name))
+
+
+def emit_struct_member_decoder(
+    environment: Environment, field: _XdrDeclaration
+) -> None:
+    """Emit a decoder for one field in an XDR struct"""
+    if isinstance(field, _XdrBasic):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthOpaque):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthOpaque):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthString):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthArray):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                size=field.size,
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthArray):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                maxsize=field.maxsize,
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrOptionalData):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                ctype=field.spec.type_decorator,
+            )
+        )
+
+
+def emit_struct_decoder(environment: Environment, node: _XdrStruct) -> None:
+    """Emit one decoder function for a struct type"""
+    template = get_jinja_template(environment, "decoder", "open")
+    print(template.render(name=node.name))
+
+    for field in node.fields:
+        emit_struct_member_decoder(environment, field)
+
+    template = get_jinja_template(environment, "decoder", "close")
+    print(template.render())
+
+
+def emit_struct_member_encoder(
+    environment: Environment, field: _XdrDeclaration
+) -> None:
+    """Emit an encoder for one field in an XDR struct"""
+    if isinstance(field, _XdrBasic):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthOpaque):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthOpaque):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthString):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrFixedLengthArray):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _XdrVariableLengthArray):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _XdrOptionalData):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                name=field.name,
+                type=field.spec.type_name,
+                ctype=field.spec.type_decorator,
+            )
+        )
+
+
+def emit_struct_encoder(environment: Environment, node: _XdrStruct) -> None:
+    """Emit one encoder function for a struct type"""
+    template = get_jinja_template(environment, "encoder", "open")
+    print(template.render(name=node.name))
+
+    for field in node.fields:
+        emit_struct_member_encoder(environment, field)
+
+    template = get_jinja_template(environment, "encoder", "close")
+    print(template.render())
+
+
+class XdrStructGenerator(SourceGenerator):
+    """Generate source code for XDR structs"""
+
+    def __init__(self, language: str, peer: str):
+        """Initialize an instance of this class"""
+        self.environment = create_jinja2_environment(language, "struct")
+        self.peer = peer
+
+    def emit_definition(self, node: _XdrStruct) -> None:
+        """Emit one definition for an XDR struct type"""
+        emit_struct_definition(self.environment, node)
+
+    def emit_decoder(self, node: _XdrStruct) -> None:
+        """Emit one decoder function for an XDR struct type"""
+        emit_struct_decoder(self.environment, node)
+
+    def emit_encoder(self, node: _XdrStruct) -> None:
+        """Emit one encoder function for an XDR struct type"""
+        emit_struct_encoder(self.environment, node)
diff --git a/tools/net/sunrpc/xdrgen/generators/typedef.py b/tools/net/sunrpc/xdrgen/generators/typedef.py
new file mode 100644
index 000000000000..6cdee5097020
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/typedef.py
@@ -0,0 +1,225 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR typedefs"""
+
+from jinja2 import Environment, Template
+
+from generators import SourceGenerator, create_jinja2_environment
+
+from xdr_ast import _XdrBasic, _XdrVariableLengthString
+from xdr_ast import _XdrFixedLengthOpaque, _XdrVariableLengthOpaque
+from xdr_ast import _XdrFixedLengthArray, _XdrVariableLengthArray
+from xdr_ast import _XdrOptionalData, _XdrVoid, _XdrBuiltInType
+from xdr_ast import _XdrDeclaration, _XdrTypedef
+
+
+def get_kernel_c_type(type_spec: str) -> str:
+    """Return C type to be used for an XDR built-in type"""
+    xdr_type_to_c_type = {
+        "unsigned_hyper": "u64",
+        "hyper": "s64",
+        "unsigned_long": "u32",
+        "long": "s32",
+        "unsigned_int": "u32",
+        "int": "s32",
+        "bool": "bool",
+    }
+    if isinstance(type_spec, _XdrBuiltInType):
+        return xdr_type_to_c_type[type_spec.type_name]
+    return type_spec.type_name
+
+
+def get_jinja_template(
+    environment: Environment, template_type: str, template_name: str
+) -> Template:
+    """Retrieve a Jinja2 template for emitting source code"""
+    return environment.get_template(template_type + "/" + template_name + ".j2")
+
+
+def emit_type_definition(environment: Environment, node: _XdrDeclaration) -> None:
+    """Emit a definition for one XDR typedef"""
+    if isinstance(node, _XdrBasic):
+        template = get_jinja_template(environment, "definition", node.template)
+        print(
+            template.render(
+                name=node.name,
+                type=get_kernel_c_type(node.spec),
+                ctype=node.spec.type_decorator,
+            )
+        )
+    elif isinstance(node, _XdrVariableLengthString):
+        template = get_jinja_template(environment, "definition", node.template)
+        print(template.render(name=node.name))
+    elif isinstance(node, _XdrFixedLengthOpaque):
+        template = get_jinja_template(environment, "definition", node.template)
+        print(template.render(name=node.name, size=node.size))
+    elif isinstance(node, _XdrVariableLengthOpaque):
+        template = get_jinja_template(environment, "definition", node.template)
+        print(template.render(name=node.name))
+    elif isinstance(node, _XdrFixedLengthArray):
+        template = get_jinja_template(environment, "definition", node.template)
+        print(
+            template.render(
+                name=node.name,
+                type=node.spec.type_name,
+                size=node.size,
+            )
+        )
+    elif isinstance(node, _XdrVariableLengthArray):
+        template = get_jinja_template(environment, "definition", node.template)
+        print(
+            template.render(
+                name=node.name,
+                type=node.spec.type_name,
+                ctype=node.spec.type_decorator,
+            )
+        )
+    elif isinstance(node, _XdrOptionalData):
+        raise NotImplementedError("<optional_data> typedef not yet implemented")
+    elif isinstance(node, _XdrVoid):
+        raise NotImplementedError("<void> typedef not yet implemented")
+    else:
+        raise NotImplementedError("typedef: type not recognized")
+
+
+def emit_typedef_decoder(environment: Environment, node: _XdrDeclaration) -> None:
+    """Emit a decoder function for one typedef"""
+    if isinstance(node, _XdrBasic):
+        template = get_jinja_template(environment, "decoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                type=node.spec.type_name,
+            )
+        )
+    elif isinstance(node, _XdrVariableLengthString):
+        template = get_jinja_template(environment, "decoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                maxsize=node.maxsize,
+            )
+        )
+    elif isinstance(node, _XdrFixedLengthOpaque):
+        template = get_jinja_template(environment, "decoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                size=node.size,
+            )
+        )
+    elif isinstance(node, _XdrVariableLengthOpaque):
+        template = get_jinja_template(environment, "decoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                maxsize=node.maxsize,
+            )
+        )
+    elif isinstance(node, _XdrFixedLengthArray):
+        template = get_jinja_template(environment, "decoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                type=node.spec.type_name,
+                size=node.size,
+                ctype=node.spec.type_decorator,
+            )
+        )
+    elif isinstance(node, _XdrVariableLengthArray):
+        template = get_jinja_template(environment, "decoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                type=node.spec.type_name,
+                maxsize=node.maxsize,
+            )
+        )
+    elif isinstance(node, _XdrOptionalData):
+        raise NotImplementedError("<optional_data> typedef not yet implemented")
+    elif isinstance(node, _XdrVoid):
+        raise NotImplementedError("<void> typedef not yet implemented")
+    else:
+        raise NotImplementedError("typedef: type not recognized")
+
+
+def emit_typedef_encoder(environment: Environment, node: _XdrDeclaration) -> None:
+    """Emit one encoder function for one typedef"""
+    if isinstance(node, _XdrBasic):
+        template = get_jinja_template(environment, "encoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                type=node.spec.type_name,
+            )
+        )
+    elif isinstance(node, _XdrVariableLengthString):
+        template = get_jinja_template(environment, "encoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                maxsize=node.maxsize,
+            )
+        )
+    elif isinstance(node, _XdrFixedLengthOpaque):
+        template = get_jinja_template(environment, "encoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                size=node.size,
+            )
+        )
+    elif isinstance(node, _XdrVariableLengthOpaque):
+        template = get_jinja_template(environment, "encoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                maxsize=node.maxsize,
+            )
+        )
+    elif isinstance(node, _XdrFixedLengthArray):
+        template = get_jinja_template(environment, "encoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                type=node.spec.type_name,
+                size=node.size,
+            )
+        )
+    elif isinstance(node, _XdrVariableLengthArray):
+        template = get_jinja_template(environment, "encoder", node.template)
+        print(
+            template.render(
+                name=node.name,
+                type=node.spec.type_name,
+                maxsize=node.maxsize,
+            )
+        )
+    elif isinstance(node, _XdrOptionalData):
+        raise NotImplementedError("<optional_data> typedef not yet implemented")
+    elif isinstance(node, _XdrVoid):
+        raise NotImplementedError("<void> typedef not yet implemented")
+    else:
+        raise NotImplementedError("typedef: type not recognized")
+
+
+class XdrTypedefGenerator(SourceGenerator):
+    """Generate source code for XDR typedefs"""
+
+    def __init__(self, language: str, peer: str):
+        """Initialize an instance of this class"""
+        self.environment = create_jinja2_environment(language, "typedef")
+        self.peer = peer
+
+    def emit_definition(self, node: _XdrTypedef) -> None:
+        """Emit one definition for an XDR typedef"""
+        emit_type_definition(self.environment, node.declaration)
+
+    def emit_decoder(self, node: _XdrTypedef) -> None:
+        """Emit one decoder function for an XDR typedef"""
+        emit_typedef_decoder(self.environment, node.declaration)
+
+    def emit_encoder(self, node: _XdrTypedef) -> None:
+        """Emit one encoder function for an XDR typedef"""
+        emit_typedef_encoder(self.environment, node.declaration)
diff --git a/tools/net/sunrpc/xdrgen/generators/union.py b/tools/net/sunrpc/xdrgen/generators/union.py
new file mode 100644
index 000000000000..f66eded11015
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/union.py
@@ -0,0 +1,238 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR unions"""
+
+from jinja2 import Environment, Template
+
+from generators import SourceGenerator, create_jinja2_environment
+
+from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid
+from xdr_ast import _XdrDeclaration, _XdrCaseSpec
+
+
+def get_jinja_template(
+    environment: Environment, template_type: str, template_name: str
+) -> Template:
+    """Retrieve a Jinja2 template for emitting source code"""
+    return environment.get_template(template_type + "/" + template_name + ".j2")
+
+
+def emit_union_switch_spec_definition(
+    environment: Environment, node: _XdrDeclaration
+) -> None:
+    """Emit a definition for an XDR union's discriminant"""
+    assert isinstance(node, _XdrBasic)
+    template = get_jinja_template(environment, "definition", "switch_spec")
+    print(
+        template.render(
+            name=node.name,
+            type=node.spec.type_name,
+            ctype=node.spec.type_decorator,
+        )
+    )
+
+
+def emit_union_case_spec_definition(
+    environment: Environment, node: _XdrDeclaration
+) -> None:
+    """Emit a definition for an XDR union's case arm"""
+    if isinstance(node.arm, _XdrVoid):
+        return
+    assert isinstance(node.arm, _XdrBasic)
+    template = get_jinja_template(environment, "definition", "case_spec")
+    print(
+        template.render(
+            name=node.arm.name,
+            type=node.arm.spec.type_name,
+            ctype=node.arm.spec.type_decorator,
+        )
+    )
+
+
+def emit_union_definition(environment: Environment, node: _XdrUnion) -> None:
+    """Emit one XDR union definition"""
+    template = get_jinja_template(environment, "definition", "open")
+    print(template.render(name=node.name))
+
+    emit_union_switch_spec_definition(environment, node.discriminant)
+
+    for case in node.cases:
+        emit_union_case_spec_definition(environment, case)
+
+    if node.default is not None:
+        emit_union_case_spec_definition(environment, node.default)
+
+    template = get_jinja_template(environment, "definition", "close")
+    print(template.render(name=node.name))
+
+
+def emit_union_switch_spec_decoder(
+    environment: Environment, node: _XdrDeclaration
+) -> None:
+    """Emit a decoder for an XDR union's discriminant"""
+    assert isinstance(node, _XdrBasic)
+    template = get_jinja_template(environment, "decoder", "switch_spec")
+    print(template.render(name=node.name, type=node.spec.type_name))
+
+
+def emit_union_case_spec_decoder(environment: Environment, node: _XdrCaseSpec) -> None:
+    """Emit decoder functions for an XDR union's case arm"""
+
+    if isinstance(node.arm, _XdrVoid):
+        return
+
+    template = get_jinja_template(environment, "decoder", "case_spec")
+    for case in node.values:
+        print(template.render(case=case))
+
+    assert isinstance(node.arm, _XdrBasic)
+    template = get_jinja_template(environment, "decoder", node.arm.template)
+    print(
+        template.render(
+            name=node.arm.name,
+            type=node.arm.spec.type_name,
+            ctype=node.arm.spec.type_decorator,
+        )
+    )
+
+    template = get_jinja_template(environment, "decoder", "break")
+    print(template.render())
+
+
+def emit_union_default_spec_decoder(environment: Environment, node: _XdrUnion) -> None:
+    """Emit a decoder function for an XDR union's default arm"""
+    default_case = node.default
+
+    # Avoid a gcc warning about a default case with boolean discriminant
+    if default_case is None and node.discriminant.spec.type_name == "bool":
+        return
+
+    template = get_jinja_template(environment, "decoder", "default_spec")
+    print(template.render())
+
+    if default_case is None or isinstance(default_case.arm, _XdrVoid):
+        template = get_jinja_template(environment, "decoder", "break")
+        print(template.render())
+        return
+
+    assert isinstance(default_case.arm, _XdrBasic)
+    template = get_jinja_template(environment, "decoder", default_case.arm.template)
+    print(
+        template.render(
+            name=default_case.arm.name,
+            type=default_case.arm.spec.type_name,
+            ctype=default_case.arm.spec.type_decorator,
+        )
+    )
+
+
+def emit_union_decoder(environment: Environment, node: _XdrUnion) -> None:
+    """Emit one XDR union decoder"""
+    template = get_jinja_template(environment, "decoder", "open")
+    print(template.render(name=node.name))
+
+    emit_union_switch_spec_decoder(environment, node.discriminant)
+
+    for case in node.cases:
+        emit_union_case_spec_decoder(environment, case)
+
+    emit_union_default_spec_decoder(environment, node)
+
+    template = get_jinja_template(environment, "decoder", "close")
+    print(template.render())
+
+
+def emit_union_switch_spec_encoder(
+    environment: Environment, node: _XdrDeclaration
+) -> None:
+    """Emit an encoder for an XDR union's discriminant"""
+    assert isinstance(node, _XdrBasic)
+    template = get_jinja_template(environment, "encoder", "switch_spec")
+    print(template.render(name=node.name, type=node.spec.type_name))
+
+
+def emit_union_case_spec_encoder(environment: Environment, node: _XdrCaseSpec) -> None:
+    """Emit encoder functions for an XDR union's case arm"""
+
+    if isinstance(node.arm, _XdrVoid):
+        return
+
+    template = get_jinja_template(environment, "encoder", "case_spec")
+    for case in node.values:
+        print(template.render(case=case))
+
+    assert isinstance(node.arm, _XdrBasic)
+    template = get_jinja_template(environment, "encoder", node.arm.template)
+    print(
+        template.render(
+            name=node.arm.name,
+            type=node.arm.spec.type_name,
+        )
+    )
+
+    template = get_jinja_template(environment, "encoder", "break")
+    print(template.render())
+
+
+def emit_union_default_spec_encoder(environment: Environment, node: _XdrUnion) -> None:
+    """Emit an encoder function for an XDR union's default arm"""
+    default_case = node.default
+
+    # Avoid a gcc warning about a default case with boolean discriminant
+    if default_case is None and node.discriminant.spec.type_name == "bool":
+        return
+
+    template = get_jinja_template(environment, "encoder", "default_spec")
+    print(template.render())
+
+    if default_case is None or isinstance(default_case.arm, _XdrVoid):
+        template = get_jinja_template(environment, "encoder", "break")
+        print(template.render())
+        return
+
+    assert isinstance(default_case.arm, _XdrBasic)
+    template = get_jinja_template(environment, "encoder", default_case.arm.template)
+    print(
+        template.render(
+            name=default_case.arm.name,
+            type=default_case.arm.spec.type_name,
+        )
+    )
+
+
+def emit_union_encoder(environment, node: _XdrUnion) -> None:
+    """Emit one XDR union encoder"""
+    template = get_jinja_template(environment, "encoder", "open")
+    print(template.render(name=node.name))
+
+    emit_union_switch_spec_encoder(environment, node.discriminant)
+
+    for case in node.cases:
+        emit_union_case_spec_encoder(environment, case)
+
+    emit_union_default_spec_encoder(environment, node)
+
+    template = get_jinja_template(environment, "encoder", "close")
+    print(template.render())
+
+
+class XdrUnionGenerator(SourceGenerator):
+    """Generate source code for XDR unions"""
+
+    def __init__(self, language: str, peer: str):
+        """Initialize an instance of this class"""
+        self.environment = create_jinja2_environment(language, "union")
+        self.peer = peer
+
+    def emit_definition(self, node: _XdrUnion) -> None:
+        """Emit one definition for an XDR union"""
+        emit_union_definition(self.environment, node)
+
+    def emit_decoder(self, node: _XdrUnion) -> None:
+        """Emit one decoder function for an XDR union"""
+        emit_union_decoder(self.environment, node)
+
+    def emit_encoder(self, node: _XdrUnion) -> None:
+        """Emit one encoder function for an XDR union"""
+        emit_union_encoder(self.environment, node)
diff --git a/tools/net/sunrpc/xdrgen/grammars/xdr.lark b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
new file mode 100644
index 000000000000..f3c4552e548d
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
@@ -0,0 +1,119 @@
+// A Lark grammar for the XDR specification language based on
+// https://tools.ietf.org/html/rfc4506 Section 6.3
+
+declaration             : "opaque" identifier "[" value "]"            -> fixed_length_opaque
+                        | "opaque" identifier "<" [ value ] ">"        -> variable_length_opaque
+                        | "string" identifier "<" [ value ] ">"        -> variable_length_string
+                        | type_specifier identifier "[" value "]"      -> fixed_length_array
+                        | type_specifier identifier "<" [ value ] ">"  -> variable_length_array
+                        | type_specifier "*" identifier                -> optional_data
+                        | type_specifier identifier                    -> basic
+                        | "void"                                       -> void
+
+value                   : decimal_constant
+                        | hexadecimal_constant
+                        | octal_constant
+                        | identifier
+
+constant                : decimal_constant | hexadecimal_constant | octal_constant
+
+type_specifier          : unsigned_hyper
+                        | unsigned_long
+                        | unsigned_int
+                        | hyper
+                        | long
+                        | int
+                        | float
+                        | double
+                        | quadruple
+                        | bool
+                        | enum_type_spec
+                        | struct_type_spec
+                        | union_type_spec
+                        | identifier
+
+unsigned_hyper          : "unsigned" "hyper"
+unsigned_long           : "unsigned" "long"
+unsigned_int            : "unsigned" "int"
+hyper                   : "hyper"
+long                    : "long"
+int                     : "int"
+float                   : "float"
+double                  : "double"
+quadruple               : "quadruple"
+bool                    : "bool"
+
+enum_type_spec          : "enum" enum_body
+
+enum_body               : "{" ( identifier "=" value ) ( "," identifier "=" value )* "}"
+
+struct_type_spec        : "struct" struct_body
+
+struct_body             : "{" ( declaration ";" )+ "}"
+
+union_type_spec         : "union" union_body
+
+union_body              : switch_spec "{" case_spec+ [ default_spec ] "}"
+
+switch_spec             : "switch" "(" declaration ")"
+
+case_spec               : ( "case" value ":" )+ declaration ";"
+
+default_spec            : "default" ":" declaration ";"
+
+constant_def            : "const" identifier "=" value ";"
+
+type_def                : "typedef" declaration ";"                -> typedef
+                        | "enum" identifier enum_body ";"          -> enum
+                        | "struct" identifier struct_body ";"      -> struct
+                        | "union" identifier union_body ";"        -> union
+
+specification           : definition*
+
+definition              : constant_def
+                        | type_def
+                        | program_def
+                        | pragma_def
+
+//
+// RPC program definitions not specified in RFC 4506
+//
+
+program_def             : "program" identifier "{" version_def+ "}" "=" constant ";"
+
+version_def             : "version" identifier "{" procedure_def+ "}" "=" constant ";"
+
+procedure_def           : type_specifier identifier "(" type_specifier ")" "=" constant ";"
+
+pragma_def              : "pragma" directive identifier [ identifier ] ";"
+
+directive               : exclude_directive
+                        | header_directive
+                        | pages_directive
+                        | public_directive
+                        | skip_directive
+
+exclude_directive       : "exclude"
+header_directive        : "header"
+pages_directive         : "pages"
+public_directive        : "public"
+skip_directive          : "skip"
+
+//
+// XDR language primitives
+//
+
+identifier              : /([a-z]|[A-Z])(_|[a-z]|[A-Z]|[0-9])*/
+
+decimal_constant        : /[\+-]?(0|[1-9][0-9]*)/
+hexadecimal_constant    : /0x([a-f]|[A-F]|[0-9])+/
+octal_constant          : /0[0-7]+/
+
+PASSTHRU                : "%" | "%" /.+/
+%ignore PASSTHRU
+
+%import common.C_COMMENT
+%ignore C_COMMENT
+
+%import common.WS
+%ignore WS
diff --git a/tools/net/sunrpc/xdrgen/subcmds/__init__.py b/tools/net/sunrpc/xdrgen/subcmds/__init__.py
new file mode 100644
index 000000000000..c940e9275252
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/subcmds/__init__.py
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+# Just to make sphinx-apidoc document this directory
diff --git a/tools/net/sunrpc/xdrgen/subcmds/header.py b/tools/net/sunrpc/xdrgen/subcmds/header.py
new file mode 100644
index 000000000000..08a7a2a94feb
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/subcmds/header.py
@@ -0,0 +1,88 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Translate an XDR specification into executable code that
+can be compiled for the Linux kernel."""
+
+import logging
+
+from argparse import Namespace
+from lark import logger
+from lark.exceptions import UnexpectedInput
+
+from generators.boilerplate import XdrBoilerplateGenerator
+from generators.constant import XdrConstantGenerator
+from generators.enum import XdrEnumGenerator
+from generators.pointer import XdrPointerGenerator
+from generators.program import XdrProgramGenerator
+from generators.typedef import XdrTypedefGenerator
+from generators.struct import XdrStructGenerator
+from generators.union import XdrUnionGenerator
+
+from xdr_ast import transform_parse_tree, _RpcProgram, Specification
+from xdr_ast import _XdrConstant, _XdrEnum, _XdrPointer
+from xdr_ast import _XdrTypedef, _XdrStruct, _XdrUnion
+from xdr_parse import xdr_parser, set_xdr_annotate
+
+logger.setLevel(logging.INFO)
+
+
+def emit_header_declarations(root: Specification, language: str) -> None:
+    """Emit header declarations"""
+    for definition in root.definitions:
+        if isinstance(definition.value, _RpcProgram):
+            gen = XdrProgramGenerator(language, "server")
+            gen.emit_declaration(definition.value)
+
+
+def emit_header_definitions(root: Specification, language: str) -> None:
+    """Emit header definitions"""
+    for definition in root.definitions:
+        if isinstance(definition.value, _XdrConstant):
+            gen = XdrConstantGenerator(language, "server")
+        elif isinstance(definition.value, _XdrEnum):
+            gen = XdrEnumGenerator(language, "server")
+        elif isinstance(definition.value, _XdrPointer):
+            gen = XdrPointerGenerator(language, "server")
+        elif isinstance(definition.value, _XdrTypedef):
+            gen = XdrTypedefGenerator(language, "server")
+        elif isinstance(definition.value, _XdrStruct):
+            gen = XdrStructGenerator(language, "server")
+        elif isinstance(definition.value, _XdrUnion):
+            gen = XdrUnionGenerator(language, "server")
+        else:
+            continue
+        gen.emit_definition(definition.value)
+
+
+def handle_parse_error(e: UnexpectedInput) -> bool:
+    """Simple parse error reporting, no recovery attempted"""
+    print(e)
+    return True
+
+
+def subcmd(args: Namespace) -> int:
+    """Generate definitions and declarations"""
+
+    if not args.definitions and not args.declarations:
+        print("One or both of --definitions and --declarations is needed.")
+        return 0
+
+    set_xdr_annotate(args.annotate)
+    parser = xdr_parser()
+    with open(args.filename, encoding="utf-8") as f:
+        parse_tree = parser.parse(f.read(), on_error=handle_parse_error)
+        ast = transform_parse_tree(parse_tree)
+
+        gen = XdrBoilerplateGenerator(args.language)
+        gen.emit_header_top(args.filename, ast)
+
+        if args.definitions:
+            emit_header_definitions(ast, args.language)
+        if args.declarations:
+            emit_header_declarations(ast, args.language)
+
+        generator = XdrBoilerplateGenerator(args.language)
+        generator.emit_header_bottom(ast)
+
+    return 0
diff --git a/tools/net/sunrpc/xdrgen/subcmds/lint.py b/tools/net/sunrpc/xdrgen/subcmds/lint.py
new file mode 100644
index 000000000000..36cc43717d30
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/subcmds/lint.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Translate an XDR specification into executable code that
+can be compiled for the Linux kernel."""
+
+import logging
+
+from argparse import Namespace
+from lark import logger
+from lark.exceptions import UnexpectedInput
+
+from xdr_parse import xdr_parser
+from xdr_ast import transform_parse_tree
+
+logger.setLevel(logging.DEBUG)
+
+
+def handle_parse_error(e: UnexpectedInput) -> bool:
+    """Simple parse error reporting, no recovery attempted"""
+    print(e)
+    return True
+
+
+def subcmd(args: Namespace) -> int:
+    """Lexical and syntax check of an XDR specification"""
+
+    parser = xdr_parser()
+    with open(args.filename, encoding="utf-8") as f:
+        parse_tree = parser.parse(f.read(), on_error=handle_parse_error)
+        transform_parse_tree(parse_tree)
+
+    return 0
diff --git a/tools/net/sunrpc/xdrgen/subcmds/source.py b/tools/net/sunrpc/xdrgen/subcmds/source.py
new file mode 100644
index 000000000000..0e210c6832e3
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/subcmds/source.py
@@ -0,0 +1,121 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Translate an XDR specification into executable code that
+can be compiled for the Linux kernel."""
+
+import logging
+
+from argparse import Namespace
+from lark import logger
+from lark.exceptions import UnexpectedInput
+
+from generators.boilerplate import XdrBoilerplateGenerator
+from generators.constant import XdrConstantGenerator
+from generators.enum import XdrEnumGenerator
+from generators.pointer import XdrPointerGenerator
+from generators.program import XdrProgramGenerator
+from generators.typedef import XdrTypedefGenerator
+from generators.struct import XdrStructGenerator
+from generators.union import XdrUnionGenerator
+
+from xdr_ast import transform_parse_tree, _RpcProgram, Specification
+from xdr_ast import _XdrAst, _XdrEnum, _XdrPointer
+from xdr_ast import _XdrStruct, _XdrTypedef, _XdrUnion
+
+from xdr_parse import xdr_parser, set_xdr_annotate
+
+logger.setLevel(logging.INFO)
+
+
+def emit_source_decoder(node: _XdrAst, language: str, peer: str) -> None:
+    """Emit one XDR decoder function for a source file"""
+    if isinstance(node, _XdrEnum):
+        gen = XdrEnumGenerator(language, peer)
+    elif isinstance(node, _XdrPointer):
+        gen = XdrPointerGenerator(language, peer)
+    elif isinstance(node, _XdrTypedef):
+        gen = XdrTypedefGenerator(language, peer)
+    elif isinstance(node, _XdrStruct):
+        gen = XdrStructGenerator(language, peer)
+    elif isinstance(node, _XdrUnion):
+        gen = XdrUnionGenerator(language, peer)
+    elif isinstance(node, _RpcProgram):
+        gen = XdrProgramGenerator(language, peer)
+    else:
+        return
+    gen.emit_decoder(node)
+
+
+def emit_source_encoder(node: _XdrAst, language: str, peer: str) -> None:
+    """Emit one XDR encoder function for a source file"""
+    if isinstance(node, _XdrEnum):
+        gen = XdrEnumGenerator(language, peer)
+    elif isinstance(node, _XdrPointer):
+        gen = XdrPointerGenerator(language, peer)
+    elif isinstance(node, _XdrTypedef):
+        gen = XdrTypedefGenerator(language, peer)
+    elif isinstance(node, _XdrStruct):
+        gen = XdrStructGenerator(language, peer)
+    elif isinstance(node, _XdrUnion):
+        gen = XdrUnionGenerator(language, peer)
+    elif isinstance(node, _RpcProgram):
+        gen = XdrProgramGenerator(language, peer)
+    else:
+        return
+    gen.emit_encoder(node)
+
+
+def generate_server_source(filename: str, root: Specification, language: str) -> None:
+    """Generate server-side source code"""
+
+    gen = XdrBoilerplateGenerator(language)
+    gen.emit_source_top(filename, root)
+
+    for definition in root.definitions:
+        emit_source_decoder(definition.value, language, "server")
+    for definition in root.definitions:
+        emit_source_encoder(definition.value, language, "server")
+
+
+def generate_client_source(filename: str, root: Specification, language: str) -> None:
+    """Generate server-side source code"""
+
+    gen = XdrBoilerplateGenerator(language)
+    gen.emit_source_top(filename, root)
+
+    # cel: todo: client needs XDR size macros
+
+    for definition in root.definitions:
+        emit_source_encoder(definition.value, language, "client")
+    for definition in root.definitions:
+        emit_source_decoder(definition.value, language, "client")
+
+    # cel: todo: client needs different arg/res functions
+
+    # cel: todo: client needs PROC macros
+
+
+def handle_parse_error(e: UnexpectedInput) -> bool:
+    """Simple parse error reporting, no recovery attempted"""
+    print(e)
+    return True
+
+
+def subcmd(args: Namespace) -> int:
+    """Generate encoder and decoder functions"""
+
+    set_xdr_annotate(args.annotate)
+    parser = xdr_parser()
+    with open(args.filename, encoding="utf-8") as f:
+        parse_tree = parser.parse(f.read(), on_error=handle_parse_error)
+        ast = transform_parse_tree(parse_tree)
+        match args.peer:
+            case "server":
+                generate_server_source(args.filename, ast, args.language)
+            case "client":
+                generate_client_source(args.filename, ast, args.language)
+            case _:
+                print("Code generation for", args.peer, "is not yet supported")
+
+    return 0
diff --git a/tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_bottom.j2 b/tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_bottom.j2
new file mode 100644
index 000000000000..5391a867b16f
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_bottom.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+#endif /* _LINUX_{{ program.upper() }}_XDRGEN_H */
diff --git a/tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_top.j2 b/tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_top.j2
new file mode 100644
index 000000000000..216f10fc7250
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_top.j2
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by xdrgen. Manual edits will be lost. */
+/* XDR specification modification time: {{ mtime }} */
+
+#ifndef _LINUX_{{ program.upper() }}_XDRGEN_H
+#define _LINUX_{{ program.upper() }}_XDRGEN_H
+
+#include <linux/types.h>
+#include <linux/sunrpc/svc.h>
+
+#include <linux/sunrpc/xdrgen-builtins.h>
diff --git a/tools/net/sunrpc/xdrgen/templates/C/boilerplate/source_top.j2 b/tools/net/sunrpc/xdrgen/templates/C/boilerplate/source_top.j2
new file mode 100644
index 000000000000..db46f9bd8354
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/boilerplate/source_top.j2
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+// Generated by xdrgen. Manual edits will be lost.
+// XDR specification modification time: {{ mtime }}
+
+#include "{{ program }}xdr_gen.h"
diff --git a/tools/net/sunrpc/xdrgen/templates/C/constants/definition.j2 b/tools/net/sunrpc/xdrgen/templates/C/constants/definition.j2
new file mode 100644
index 000000000000..d648ca4193f8
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/constants/definition.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+enum { {{ name }} = {{ value }} };
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2
new file mode 100644
index 000000000000..341d829afeda
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2
@@ -0,0 +1,19 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* enum {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
new file mode 100644
index 000000000000..dd3e880d0fa2
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
@@ -0,0 +1,7 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/enumerator.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/enumerator.j2
new file mode 100644
index 000000000000..ff0b893b8b14
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/enumerator.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	{{ name }} = {{ value }},
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/definition/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/open.j2
new file mode 100644
index 000000000000..b25335221d48
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/definition/open.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+enum {{ name }} {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2
new file mode 100644
index 000000000000..bd0a770e50f2
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2
@@ -0,0 +1,14 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* enum {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/basic.j2
new file mode 100644
index 000000000000..cde4ab53f4be
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/basic.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (basic) */
+{% endif %}
+	if (!xdrgen_decode_{{ type }}(xdr, &ptr->{{ name }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2
new file mode 100644
index 000000000000..5bf010665f84
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_array.j2
new file mode 100644
index 000000000000..cfd64217ad82
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_array.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (fixed-length array) */
+{% endif %}
+	for (u32 i = 0; i < {{ size }}; i++) {
+		if (xdrgen_decode_{{ type }}(xdr, &ptr->{{ name }}.items[i]) < 0)
+			return false;
+	}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
new file mode 100644
index 000000000000..b4695ece1884
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (fixed-length opaque) */
+{% endif %}
+	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) < 0)
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/open.j2
new file mode 100644
index 000000000000..c093d9e3c9ad
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/open.j2
@@ -0,0 +1,22 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* pointer {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr)
+{
+	bool opted;
+
+{% if annotate %}
+	/* opted */
+{% endif %}
+	if (!xdrgen_decode_bool(xdr, &opted))
+		return false;
+	if (!opted)
+		return true;
+
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/optional_data.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/optional_data.j2
new file mode 100644
index 000000000000..b6834299a04b
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/optional_data.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (optional data) */
+{% endif %}
+	if (!xdrgen_decode_{{ type }}(xdr, ptr->{{ name }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_array.j2
new file mode 100644
index 000000000000..d318a09cad12
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_array.j2
@@ -0,0 +1,13 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length array) */
+{% endif %}
+	if (xdr_stream_decode_u32(xdr, &ptr->{{ name }}.count) != XDR_UNIT)
+		return false;
+{% if maxsize != 0 %}
+	if (ptr->{{ name }}.count > {{ maxsize }})
+		return false;
+{% endif %}
+	for (u32 i = 0; i < ptr->{{ name }}.count; i++)
+		if (!xdrgen_decode_{{ type }}(xdr, &ptr->{{ name }}.element[i]))
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_opaque.j2
new file mode 100644
index 000000000000..9a814de54ae8
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_opaque.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length opaque) */
+{% endif %}
+	if (!xdrgen_decode_opaque(xdr, (opaque *)ptr, {{ maxsize }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_string.j2
new file mode 100644
index 000000000000..12d20b143b43
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_string.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length string) */
+{% endif %}
+	if (!xdrgen_decode_string(xdr, (string *)ptr, {{ maxsize }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/basic.j2
new file mode 100644
index 000000000000..d3a5607d30da
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/basic.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (basic) */
+{% endif %}
+	{{ ctype }}{{ type }} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/close.j2
new file mode 100644
index 000000000000..f40098266f7f
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/close.j2
@@ -0,0 +1,7 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_array.j2
new file mode 100644
index 000000000000..66be836826a0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_array.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (fixed-length array) */
+{% endif %}
+	{{ type }} {{ name }}[{{ size }}];
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_opaque.j2
new file mode 100644
index 000000000000..0daba19aa0f0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_opaque.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (fixed-length opaque) */
+{% endif %}
+	u8 {{ name }}[{{ size }}];
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/open.j2
new file mode 100644
index 000000000000..bc886b818d85
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/open.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* pointer {{ name }} */
+{% endif %}
+struct {{ name }} {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/optional_data.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/optional_data.j2
new file mode 100644
index 000000000000..7e52afbb1f3e
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/optional_data.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (optional data) */
+{% endif %}
+	{{ ctype }}{{ type }} *{{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_array.j2
new file mode 100644
index 000000000000..aa3e62c2cd3c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_array.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (variable-length array) */
+{% endif %}
+	struct {
+		u32 count;
+		{{ ctype }}{{ type }} *element;
+	} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_opaque.j2
new file mode 100644
index 000000000000..4d0cd84be3db
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_opaque.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (variable-length opaque) */
+{% endif %}
+	opaque {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_string.j2
new file mode 100644
index 000000000000..2de2feec77db
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_string.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (variable-length string) */
+{% endif %}
+	string {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/basic.j2
new file mode 100644
index 000000000000..a7d3695c5a6a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/basic.j2
@@ -0,0 +1,10 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (basic) */
+{% endif %}
+{% if type in pass_by_reference %}
+	if (!xdrgen_encode_{{ type }}(xdr, &value->{{ name }}))
+{% else %}
+	if (!xdrgen_encode_{{ type }}(xdr, value->{{ name }}))
+{% endif %}
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2
new file mode 100644
index 000000000000..5bf010665f84
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_array.j2
new file mode 100644
index 000000000000..b01833a2c7a1
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_array.j2
@@ -0,0 +1,12 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (fixed-length array) */
+{% endif %}
+	for (u32 i = 0; i < {{ size }}; i++) {
+{% if type in pass_by_reference %}
+		if (xdrgen_encode_{{ type }}(xdr, &value->items[i]) < 0)
+{% else %}
+		if (xdrgen_encode_{{ type }}(xdr, value->items[i]) < 0)
+{% endif %}
+			return false;
+	}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_opaque.j2
new file mode 100644
index 000000000000..07bc91919898
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_opaque.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (fixed-length opaque) */
+{% endif %}
+	if (xdr_stream_encode_opaque_fixed(xdr, value->{{ name }}, {{ size }}) < 0)
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/open.j2
new file mode 100644
index 000000000000..d67fae200261
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/open.j2
@@ -0,0 +1,20 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* pointer {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *value)
+{
+{% if annotate %}
+	/* opted */
+{% endif %}
+	if (!xdrgen_encode_bool(xdr, value != NULL))
+		return false;
+	if (!value)
+		return true;
+
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/optional_data.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/optional_data.j2
new file mode 100644
index 000000000000..16fb3e09bba1
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/optional_data.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (optional data) */
+{% endif %}
+	if (!xdrgen_encode_{{ type }}(xdr, value->{{ name }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_array.j2
new file mode 100644
index 000000000000..0ec8660d621a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_array.j2
@@ -0,0 +1,15 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length array) */
+{% endif %}
+	if (value->{{ name }}.count > {{ maxsize }})
+		return false;
+	if (xdr_stream_encode_u32(xdr, value->{{ name }}.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value->{{ name }}.count; i++)
+{% if type in pass_by_reference %}
+		if (!xdrgen_encode_{{ type }}(xdr, &value->{{ name }}.element[i]))
+{% else %}
+		if (!xdrgen_encode_{{ type }}(xdr, value->{{ name }}.element[i]))
+{% endif %}
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2
new file mode 100644
index 000000000000..1d477c2d197a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length opaque) */
+{% endif %}
+	if (value->{{ name }}.len > {{ maxsize }})
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->{{ name }}.data, value->{{ name }}.len) < 0)
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2
new file mode 100644
index 000000000000..cf65b71eaef3
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length string) */
+{% endif %}
+	if (value->{{ name }}.len > {{ maxsize }})
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->{{ name }}.data, value->{{ name }}.len) < 0)
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/declaration/argument.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/declaration/argument.j2
new file mode 100644
index 000000000000..4364fed19162
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/declaration/argument.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+bool {{ program }}_svc_decode_{{ argument }}(struct svc_rqst *rqstp, struct xdr_stream *xdr);
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/declaration/result.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/declaration/result.j2
new file mode 100644
index 000000000000..e0ea1e849910
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/declaration/result.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+bool {{ program }}_svc_encode_{{ result }}(struct svc_rqst *rqstp, struct xdr_stream *xdr);
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
new file mode 100644
index 000000000000..0b1709cca0d4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
@@ -0,0 +1,21 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+/**
+ * {{ program }}_svc_decode_{{ argument }} - Decode a {{ argument }} argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool {{ program }}_svc_decode_{{ argument }}(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+{% if argument == 'void' %}
+	return xdrgen_decode_void(xdr);
+{% else %}
+	struct {{ argument }} *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_{{ argument }}(xdr, argp);
+{% endif %}
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
new file mode 100644
index 000000000000..d304eccb5c40
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
@@ -0,0 +1,22 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* Decode {{ result }} results */
+{% endif %}
+static int {{ program }}_xdr_dec_{{ result }}(struct rpc_rqst *req,
+		struct xdr_stream *xdr, void *data)
+{
+{% if result == 'void' %}
+	xdrgen_decode_void(xdr);
+{% else %}
+	struct {{ result }} *result = data;
+
+	if (!xdrgen_decode_{{ result }}(xdr, result))
+		return -EIO;
+	if (result->stat != nfs_ok) {
+		trace_nfs_xdr_status(xdr, (int)result->stat);
+		return {{ program }}_stat_to_errno(result->stat);
+	}
+{% endif %}
+	return 0;
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/encoder/argument.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/encoder/argument.j2
new file mode 100644
index 000000000000..2fbb5bd13aec
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/encoder/argument.j2
@@ -0,0 +1,16 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{%if annotate %}
+/* Encode {{ argument }} arguments */
+{% endif %}
+static void {{ program }}_xdr_enc_{{ argument }}(struct rpc_rqst *req,
+		struct xdr_stream *xdr, const void *data)
+{
+{% if argument == 'void' %}
+	xdrgen_encode_void(xdr);
+{% else %}
+	const struct {{ argument }} *args = data;
+
+	xdrgen_encode_{{ argument }}(xdr, args);
+{% endif %}
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
new file mode 100644
index 000000000000..6fc61a5d47b7
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
@@ -0,0 +1,21 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+/**
+ * {{ program }}_svc_encode_{{ result }} - Encode a {{ result }} result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+bool {{ program }}_svc_encode_{{ result }}(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+{% if result == 'void' %}
+	return xdrgen_encode_void(xdr);
+{% else %}
+	struct {{ result }} *resp = rqstp->rq_resp;
+
+	return xdrgen_encode_{{ result }}(xdr, resp);
+{% endif %}
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/basic.j2
new file mode 100644
index 000000000000..cde4ab53f4be
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/basic.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (basic) */
+{% endif %}
+	if (!xdrgen_decode_{{ type }}(xdr, &ptr->{{ name }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2
new file mode 100644
index 000000000000..5bf010665f84
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_array.j2
new file mode 100644
index 000000000000..cfd64217ad82
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_array.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (fixed-length array) */
+{% endif %}
+	for (u32 i = 0; i < {{ size }}; i++) {
+		if (xdrgen_decode_{{ type }}(xdr, &ptr->{{ name }}.items[i]) < 0)
+			return false;
+	}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
new file mode 100644
index 000000000000..b4695ece1884
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (fixed-length opaque) */
+{% endif %}
+	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) < 0)
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/open.j2
new file mode 100644
index 000000000000..289e67259f55
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/open.j2
@@ -0,0 +1,12 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* struct {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr)
+{
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/optional_data.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/optional_data.j2
new file mode 100644
index 000000000000..b6834299a04b
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/optional_data.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (optional data) */
+{% endif %}
+	if (!xdrgen_decode_{{ type }}(xdr, ptr->{{ name }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_array.j2
new file mode 100644
index 000000000000..d318a09cad12
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_array.j2
@@ -0,0 +1,13 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length array) */
+{% endif %}
+	if (xdr_stream_decode_u32(xdr, &ptr->{{ name }}.count) != XDR_UNIT)
+		return false;
+{% if maxsize != 0 %}
+	if (ptr->{{ name }}.count > {{ maxsize }})
+		return false;
+{% endif %}
+	for (u32 i = 0; i < ptr->{{ name }}.count; i++)
+		if (!xdrgen_decode_{{ type }}(xdr, &ptr->{{ name }}.element[i]))
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2
new file mode 100644
index 000000000000..9a814de54ae8
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length opaque) */
+{% endif %}
+	if (!xdrgen_decode_opaque(xdr, (opaque *)ptr, {{ maxsize }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2
new file mode 100644
index 000000000000..12d20b143b43
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length string) */
+{% endif %}
+	if (!xdrgen_decode_string(xdr, (string *)ptr, {{ maxsize }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/basic.j2
new file mode 100644
index 000000000000..d3a5607d30da
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/basic.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (basic) */
+{% endif %}
+	{{ ctype }}{{ type }} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/close.j2
new file mode 100644
index 000000000000..f40098266f7f
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/close.j2
@@ -0,0 +1,7 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_array.j2
new file mode 100644
index 000000000000..66be836826a0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_array.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (fixed-length array) */
+{% endif %}
+	{{ type }} {{ name }}[{{ size }}];
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_opaque.j2
new file mode 100644
index 000000000000..0daba19aa0f0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_opaque.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (fixed-length opaque) */
+{% endif %}
+	u8 {{ name }}[{{ size }}];
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/open.j2
new file mode 100644
index 000000000000..07cbf5424546
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/open.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* struct {{ name }} */
+{% endif %}
+struct {{ name }} {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/optional_data.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/optional_data.j2
new file mode 100644
index 000000000000..7e52afbb1f3e
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/optional_data.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (optional data) */
+{% endif %}
+	{{ ctype }}{{ type }} *{{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_array.j2
new file mode 100644
index 000000000000..aa3e62c2cd3c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_array.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (variable-length array) */
+{% endif %}
+	struct {
+		u32 count;
+		{{ ctype }}{{ type }} *element;
+	} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_opaque.j2
new file mode 100644
index 000000000000..4d0cd84be3db
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_opaque.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (variable-length opaque) */
+{% endif %}
+	opaque {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_string.j2
new file mode 100644
index 000000000000..2de2feec77db
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_string.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (variable-length string) */
+{% endif %}
+	string {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2
new file mode 100644
index 000000000000..a7d3695c5a6a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2
@@ -0,0 +1,10 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (basic) */
+{% endif %}
+{% if type in pass_by_reference %}
+	if (!xdrgen_encode_{{ type }}(xdr, &value->{{ name }}))
+{% else %}
+	if (!xdrgen_encode_{{ type }}(xdr, value->{{ name }}))
+{% endif %}
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2
new file mode 100644
index 000000000000..5bf010665f84
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_array.j2
new file mode 100644
index 000000000000..b01833a2c7a1
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_array.j2
@@ -0,0 +1,12 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (fixed-length array) */
+{% endif %}
+	for (u32 i = 0; i < {{ size }}; i++) {
+{% if type in pass_by_reference %}
+		if (xdrgen_encode_{{ type }}(xdr, &value->items[i]) < 0)
+{% else %}
+		if (xdrgen_encode_{{ type }}(xdr, value->items[i]) < 0)
+{% endif %}
+			return false;
+	}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_opaque.j2
new file mode 100644
index 000000000000..07bc91919898
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_opaque.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (fixed-length opaque) */
+{% endif %}
+	if (xdr_stream_encode_opaque_fixed(xdr, value->{{ name }}, {{ size }}) < 0)
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/open.j2
new file mode 100644
index 000000000000..2286a3adf82a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/open.j2
@@ -0,0 +1,12 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* struct {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *value)
+{
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/optional_data.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/optional_data.j2
new file mode 100644
index 000000000000..16fb3e09bba1
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/optional_data.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (optional data) */
+{% endif %}
+	if (!xdrgen_encode_{{ type }}(xdr, value->{{ name }}))
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2
new file mode 100644
index 000000000000..0ec8660d621a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2
@@ -0,0 +1,15 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length array) */
+{% endif %}
+	if (value->{{ name }}.count > {{ maxsize }})
+		return false;
+	if (xdr_stream_encode_u32(xdr, value->{{ name }}.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value->{{ name }}.count; i++)
+{% if type in pass_by_reference %}
+		if (!xdrgen_encode_{{ type }}(xdr, &value->{{ name }}.element[i]))
+{% else %}
+		if (!xdrgen_encode_{{ type }}(xdr, value->{{ name }}.element[i]))
+{% endif %}
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2
new file mode 100644
index 000000000000..1d477c2d197a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length opaque) */
+{% endif %}
+	if (value->{{ name }}.len > {{ maxsize }})
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->{{ name }}.data, value->{{ name }}.len) < 0)
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2
new file mode 100644
index 000000000000..cf65b71eaef3
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (variable-length string) */
+{% endif %}
+	if (value->{{ name }}.len > {{ maxsize }})
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->{{ name }}.data, value->{{ name }}.len) < 0)
+		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2
new file mode 100644
index 000000000000..da4709403dc9
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2
@@ -0,0 +1,17 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ name }} *ptr)
+{
+{% if annotate %}
+	/* (basic) */
+{% endif %}
+	return xdrgen_decode_{{ type }}(xdr, ptr);
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2
new file mode 100644
index 000000000000..e4791eb55417
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2
@@ -0,0 +1,25 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr)
+{
+{% if annotate %}
+	/* (fixed-length array) */
+{% endif %}
+	for (u32 i = 0; i < {{ size }}; i++) {
+{%- if ctype == '' %}
+		if (xdrgen_decode_{{ type }}(xdr, ptr->items[i]) < 0)
+{% else %}
+		if (xdrgen_decode_{{ type }}(xdr, &ptr->items[i]) < 0)
+{% endif %}
+			return false;
+	}
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
new file mode 100644
index 000000000000..7cc2a474f583
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
@@ -0,0 +1,17 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr)
+{
+{% if annotate %}
+	/* (fixed-length opaque) */
+{% endif %}
+	return xdr_stream_decode_opaque_fixed(xdr, ptr, {{ size }}) >= 0;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2
new file mode 100644
index 000000000000..54bc0a0fd9f9
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2
@@ -0,0 +1,26 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr)
+{
+{% if annotate %}
+	/* (variable-length array) */
+{% endif %}
+	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
+		return false;
+{% if maxsize != 0 %}
+	if (ptr->count > {{ maxsize }})
+		return false;
+{% endif %}
+	for (u32 i = 0; i < ptr->count; i++)
+		if (!xdrgen_decode_{{ type }}(xdr, &ptr->element[i]))
+			return false;
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2
new file mode 100644
index 000000000000..0cabb94c0f8a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2
@@ -0,0 +1,17 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr)
+{
+{% if annotate %}
+	/* (variable-length opaque) */
+{% endif %}
+	return xdr_stream_decode_opaque(xdr, ptr->data, ptr->len) >= 0;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2
new file mode 100644
index 000000000000..4f12ac002aa6
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2
@@ -0,0 +1,17 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr)
+{
+{% if annotate %}
+	/* (variable-length string) */
+{% endif %}
+	return xdr_stream_decode_opaque(xdr, ptr->data, ptr->len) >= 0;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/basic.j2
new file mode 100644
index 000000000000..8ad8af7f7beb
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/basic.j2
@@ -0,0 +1,15 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} (basic) */
+{% endif %}
+typedef {{ ctype }}{{ type }} {{ name }};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ name }} *ptr);
+{% if name in pass_by_reference %}
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ name }} *value);
+{% else %}
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ name }} value);
+{% endif %}
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_array.j2
new file mode 100644
index 000000000000..2ab394f3b1bc
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_array.j2
@@ -0,0 +1,11 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} (fixed-length array) */
+{% endif %}
+typedef {{ type }}{{ name }}[{{ size }}];
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_opaque.j2
new file mode 100644
index 000000000000..b81773efdb54
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_opaque.j2
@@ -0,0 +1,11 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} (fixed-length opaque) */
+{% endif %}
+typedef u8 {{ name }}[{{ size }}];
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_array.j2
new file mode 100644
index 000000000000..b6f67a4007ab
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_array.j2
@@ -0,0 +1,14 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} (variable-length array) */
+{% endif %}
+typedef struct {
+	u32 count;
+	{{ ctype }}{{ type }} *element;
+} {{ name }};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_opaque.j2
new file mode 100644
index 000000000000..badf2fec1e5d
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_opaque.j2
@@ -0,0 +1,11 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} (variable-length opaque) */
+{% endif %}
+typedef opaque {{ name }};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_string.j2
new file mode 100644
index 000000000000..1f8b24c4137a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_string.j2
@@ -0,0 +1,11 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} (variable-length string) */
+{% endif %}
+typedef string {{ name }};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ ctype }}{{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
new file mode 100644
index 000000000000..89caf1387936
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
@@ -0,0 +1,21 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+{% if name in pass_by_reference %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} *value)
+{% else %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value)
+{% endif %}
+{
+{% if annotate %}
+	/* (basic) */
+{% endif %}
+	return xdrgen_encode_{{ type }}(xdr, value);
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
new file mode 100644
index 000000000000..d704d60bf4c3
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
@@ -0,0 +1,25 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value)
+{
+{% if annotate %}
+	/* (fixed-length array) */
+{% endif %}
+	for (u32 i = 0; i < {{ size }}; i++) {
+{% if type in pass_by_reference %}
+		if (xdrgen_encode_{{ type }}(xdr, &value->items[i]) < 0)
+{% else %}
+		if (xdrgen_encode_{{ type }}(xdr, value->items[i]) < 0)
+{% endif %}
+			return false;
+	}
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2
new file mode 100644
index 000000000000..2b51b61f3c85
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2
@@ -0,0 +1,17 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value)
+{
+{% if annotate %}
+	/* (fixed-length opaque) */
+{% endif %}
+	return xdr_stream_encode_opaque_fixed(xdr, value, {{ size }}) >= 0;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2
new file mode 100644
index 000000000000..5e279967f021
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2
@@ -0,0 +1,30 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value)
+{
+{% if annotate %}
+	/* (variable-length array) */
+{% endif %}
+{% if maxsize != 0 %}
+	if (unlikely(value.count > {{ maxsize }}))
+		return false;
+{% endif %}
+	if (xdr_stream_encode_u32(xdr, value.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value.count; i++)
+{% if type in pass_by_reference %}
+		if (!xdrgen_encode_{{ type }}(xdr, &value.element[i]))
+{% else %}
+		if (!xdrgen_encode_{{ type }}(xdr, value.element[i]))
+{% endif %}
+			return false;
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2
new file mode 100644
index 000000000000..17e97fe1f43b
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2
@@ -0,0 +1,17 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value)
+{
+{% if annotate %}
+	/* (variable-length opaque) */
+{% endif %}
+	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2
new file mode 100644
index 000000000000..8747925292fe
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2
@@ -0,0 +1,17 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value)
+{
+{% if annotate %}
+	/* (variable-length string) */
+{% endif %}
+	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/basic.j2
new file mode 100644
index 000000000000..4d97cc5395eb
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/basic.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+		/* member {{ name }} (basic) */
+{% endif %}
+		if (!xdrgen_decode_{{ type }}(xdr, &ptr->u.{{ name }}))
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/break.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/break.j2
new file mode 100644
index 000000000000..b286d1407029
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/break.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+		break;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec.j2
new file mode 100644
index 000000000000..5fa2163f0a74
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	case {{ case }}:
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2
new file mode 100644
index 000000000000..fdc2dfd1843b
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2
@@ -0,0 +1,4 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	}
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/default_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/default_spec.j2
new file mode 100644
index 000000000000..044a002d0589
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/default_spec.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	default:
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/open.j2
new file mode 100644
index 000000000000..eb9941376e49
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/open.j2
@@ -0,0 +1,12 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* union {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr)
+{
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/optional_data.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/optional_data.j2
new file mode 100644
index 000000000000..e4476f5fd8d3
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/optional_data.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+		/* member {{ name }} (optional data) */
+{% endif %}
+		if (!xdrgen_decode_{{ type }}(xdr, &ptr->u.{{ name }}))
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/switch_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/switch_spec.j2
new file mode 100644
index 000000000000..99b3067ef617
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/switch_spec.j2
@@ -0,0 +1,7 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* discriminant {{ name }} */
+{% endif %}
+	if (!xdrgen_decode_{{ type }}(xdr, &ptr->{{ name }}))
+		return false;
+	switch (ptr->{{ name }}) {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_array.j2
new file mode 100644
index 000000000000..eee2b9a68e27
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_array.j2
@@ -0,0 +1,13 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+		/* member {{ name }} (variable-length array) */
+{% endif %}
+		if (xdr_stream_decode_u32(xdr, &count) != XDR_UNIT)
+			return false;
+		if (count > {{ maxsize }})
+			return false;
+		for (u32 i = 0; i < count; i++) {
+			if (xdrgen_decode_{{ type }}(xdr, &ptr->{{ name }}.items[i]) < 0)
+				return false;
+		}
+		ptr->{{ name }}.len = count;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_opaque.j2
new file mode 100644
index 000000000000..c9d88ed29c78
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_opaque.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+		/* member {{ name }} (variable-length opaque) */
+{% endif %}
+		if (!xdrgen_decode_opaque(xdr, (struct opaque *)ptr->u.{{ name }}, {{ maxsize }}))
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_string.j2
new file mode 100644
index 000000000000..83b6e5a14e7f
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_string.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+		/* member {{ name }} (variable-length string) */
+{% endif %}
+		if (!xdrgen_decode_string(xdr, (struct string *)ptr->u.{{ name }}, {{ maxsize }}))
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/void.j2
new file mode 100644
index 000000000000..65205ce37b36
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/void.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+		if (!xdrgen_decode_void(xdr))
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/definition/case_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/definition/case_spec.j2
new file mode 100644
index 000000000000..6bfba6c53996
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/definition/case_spec.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+		{{ ctype }}{{ type }} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
new file mode 100644
index 000000000000..01d716d0099e
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	} u;
+};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *ptr);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/definition/default_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/definition/default_spec.j2
new file mode 100644
index 000000000000..6bfba6c53996
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/definition/default_spec.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+		{{ ctype }}{{ type }} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/definition/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/definition/open.j2
new file mode 100644
index 000000000000..20fcfd1fc4e5
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/definition/open.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* union {{ name }} */
+{% endif %}
+struct {{ name }} {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/definition/switch_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/definition/switch_spec.j2
new file mode 100644
index 000000000000..53639b006b0c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/definition/switch_spec.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	{{ ctype }}{{ type }} {{ name }};
+	union {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2
new file mode 100644
index 000000000000..6452d75c6f9a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2
@@ -0,0 +1,10 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+		/* member {{ name }} (basic) */
+{% endif %}
+{% if type in pass_by_reference %}
+		if (!xdrgen_encode_{{ type }}(xdr, &ptr->u.{{ name }}))
+{% else %}
+		if (!xdrgen_encode_{{ type }}(xdr, ptr->u.{{ name }}))
+{% endif %}
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/break.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/break.j2
new file mode 100644
index 000000000000..b286d1407029
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/break.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+		break;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec.j2
new file mode 100644
index 000000000000..5fa2163f0a74
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	case {{ case }}:
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2
new file mode 100644
index 000000000000..fdc2dfd1843b
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2
@@ -0,0 +1,4 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	}
+	return true;
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/default_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/default_spec.j2
new file mode 100644
index 000000000000..044a002d0589
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/default_spec.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	default:
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/open.j2
new file mode 100644
index 000000000000..e5a206df10c6
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/open.j2
@@ -0,0 +1,12 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* union {{ name }} */
+{% endif %}
+{% if name in public_apis %}
+bool
+{% else %}
+static bool __maybe_unused
+{% endif %}
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *ptr)
+{
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/switch_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/switch_spec.j2
new file mode 100644
index 000000000000..c8c3ecbe038b
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/switch_spec.j2
@@ -0,0 +1,7 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* discriminant {{ name }} */
+{% endif %}
+	if (!xdrgen_encode_{{ type }}(xdr, ptr->{{ name }}))
+		return false;
+	switch (ptr->{{ name }}) {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/void.j2
new file mode 100644
index 000000000000..84e7c2127d75
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/void.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+		if (!xdrgen_encode_void(xdr))
+			return false;
diff --git a/tools/net/sunrpc/xdrgen/tests/test.x b/tools/net/sunrpc/xdrgen/tests/test.x
new file mode 100644
index 000000000000..90c8587f6fe5
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/tests/test.x
@@ -0,0 +1,36 @@
+/* Sample XDR specification from RFC 1832 Section 5.5 */
+
+const MAXUSERNAME = 32;     /* max length of a user name */
+const MAXFILELEN = 65535;   /* max length of a file      */
+const MAXNAMELEN = 255;     /* max length of a file name */
+
+/*
+ * Types of files:
+ */
+enum filekind {
+   TEXT = 0,       /* ascii data */
+   DATA = 1,       /* raw data   */
+   EXEC = 2        /* executable */
+};
+
+/*
+ * File information, per kind of file:
+ */
+union filetype switch (filekind kind) {
+case TEXT:
+   void;                           /* no extra information */
+case DATA:
+   string creator<MAXNAMELEN>;     /* data creator         */
+case EXEC:
+   string interpretor<MAXNAMELEN>; /* program interpretor  */
+};
+
+/*
+ * A complete file:
+ */
+struct file {
+   string filename<MAXNAMELEN>; /* name of file    */
+   filetype type;               /* info about file */
+   string owner<MAXUSERNAME>;   /* owner of file   */
+   opaque data<MAXFILELEN>;     /* file data       */
+};
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
new file mode 100644
index 000000000000..32ed918f56cd
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -0,0 +1,485 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Define and implement the Abstract Syntax Tree for the XDR language."""
+
+import sys
+from typing import List
+from dataclasses import dataclass
+
+from lark import ast_utils, Transformer
+from lark.tree import Meta
+
+this_module = sys.modules[__name__]
+
+excluded_apis = []
+header_name = "none"
+public_apis = []
+enums = set()
+structs = set()
+pass_by_reference = set()
+
+
+@dataclass
+class _XdrAst(ast_utils.Ast):
+    """Base class for the XDR abstract syntax tree"""
+
+
+@dataclass
+class _XdrIdentifier(_XdrAst):
+    """Corresponds to 'identifier' in the XDR language grammar"""
+
+    symbol: str
+
+
+@dataclass
+class _XdrValue(_XdrAst):
+    """Corresponds to 'value' in the XDR language grammar"""
+
+    value: str
+
+
+@dataclass
+class _XdrTypeSpecifier(_XdrAst):
+    """Corresponds to 'type_specifier' in the XDR language grammar"""
+
+    type_name: str
+
+
+@dataclass
+class _XdrDefinedType(_XdrTypeSpecifier):
+    """Corresponds to a type defined within the input"""
+    type_decorator: str
+
+
+@dataclass
+class _XdrBuiltInType(_XdrTypeSpecifier):
+    """Corresponds to a built-in XDR type"""
+    display_name: str
+    type_decorator: str = ""
+
+
+@dataclass
+class _XdrDeclaration(_XdrAst):
+    """Base class of XDR type declarations"""
+
+
+@dataclass
+class _XdrFixedLengthOpaque(_XdrDeclaration):
+    """A fixed-length opaque declaration"""
+
+    name: str
+    size: str
+    template: str = "fixed_length_opaque"
+
+
+@dataclass
+class _XdrVariableLengthOpaque(_XdrDeclaration):
+    """A variable-length opaque declaration"""
+
+    name: str
+    maxsize: str
+    template: str = "variable_length_opaque"
+
+
+@dataclass
+class _XdrVariableLengthString(_XdrDeclaration):
+    """A variable-length string declaration"""
+
+    name: str
+    maxsize: str
+    template: str = "variable_length_string"
+
+
+@dataclass
+class _XdrFixedLengthArray(_XdrDeclaration):
+    """A fixed-length array declaration"""
+
+    name: str
+    spec: _XdrTypeSpecifier
+    size: str
+    template: str = "fixed_length_array"
+
+
+@dataclass
+class _XdrVariableLengthArray(_XdrDeclaration):
+    """A variable-length array declaration"""
+
+    name: str
+    spec: _XdrTypeSpecifier
+    maxsize: str
+    template: str = "variable_length_array"
+
+
+@dataclass
+class _XdrOptionalData(_XdrDeclaration):
+    """An 'optional_data' declaration"""
+
+    name: str
+    spec: _XdrTypeSpecifier
+    template: str = "optional_data"
+
+
+@dataclass
+class _XdrBasic(_XdrDeclaration):
+    """A 'basic' declaration"""
+
+    name: str
+    spec: _XdrTypeSpecifier
+    template: str = "basic"
+
+
+@dataclass
+class _XdrVoid(_XdrDeclaration):
+    """A void declaration"""
+
+
+@dataclass
+class _XdrConstant(_XdrAst):
+    """Corresponds to 'constant_def' in the grammar"""
+
+    name: str
+    value: str
+
+
+@dataclass
+class _XdrEnumerator(_XdrAst):
+    """An 'identifier = value' enumerator"""
+
+    name: str
+    value: str
+
+
+@dataclass
+class _XdrEnum(_XdrAst):
+    """An XDR enum definition"""
+
+    name: str
+    minimum: int
+    maximum: int
+    enumerators: List[_XdrEnumerator]
+
+
+@dataclass
+class _XdrStruct(_XdrAst):
+    """An XDR struct definition"""
+
+    name: str
+    fields: List[_XdrDeclaration]
+
+
+@dataclass
+class _XdrPointer(_XdrAst):
+    """An XDR pointer definition"""
+
+    name: str
+    fields: List[_XdrDeclaration]
+
+
+@dataclass
+class _XdrTypedef(_XdrAst):
+    """An XDR typedef"""
+
+    declaration: _XdrDeclaration
+
+
+@dataclass
+class _XdrCaseSpec(_XdrAst):
+    """One case in an XDR union"""
+
+    values: List[str]
+    arm: _XdrDeclaration
+    template: str = "case_spec"
+
+
+@dataclass
+class _XdrDefaultSpec(_XdrAst):
+    """Default case in an XDR union"""
+
+    arm: _XdrDeclaration
+    template: str = "default_spec"
+
+
+@dataclass
+class _XdrUnion(_XdrAst):
+    """An XDR union"""
+
+    name: str
+    discriminant: _XdrDeclaration
+    cases: List[_XdrCaseSpec]
+    default: _XdrDeclaration
+
+
+@dataclass
+class _RpcProcedure(_XdrAst):
+    """RPC procedure definition"""
+
+    name: str
+    number: str
+    argument: _XdrTypeSpecifier
+    result: _XdrTypeSpecifier
+
+
+@dataclass
+class _RpcVersion(_XdrAst):
+    """RPC version definition"""
+
+    name: str
+    number: str
+    procedures: List[_RpcProcedure]
+
+
+@dataclass
+class _RpcProgram(_XdrAst):
+    """RPC program definition"""
+
+    name: str
+    number: str
+    versions: List[_RpcVersion]
+
+
+@dataclass
+class _Pragma(_XdrAst):
+    """Empty class for pragma directives"""
+
+
+@dataclass
+class Definition(_XdrAst, ast_utils.WithMeta):
+    """Corresponds to 'definition' in the grammar"""
+
+    meta: Meta
+    value: _XdrAst
+
+
+@dataclass
+class Specification(_XdrAst, ast_utils.AsList):
+    """Corresponds to 'specification' in the grammar"""
+
+    definitions: List[Definition]
+
+
+class ParseToAst(Transformer):
+    """Functions that transform productions into AST nodes"""
+
+    def identifier(self, children):
+        """Instantiate one _XdrIdentifier object"""
+        return _XdrIdentifier(children[0].value)
+
+    def value(self, children):
+        """Instantiate one _XdrValue object"""
+        if isinstance(children[0], _XdrIdentifier):
+            return _XdrValue(children[0].symbol)
+        return _XdrValue(children[0].children[0].value)
+
+    def type_specifier(self, children):
+        """Instantiate one type_specifier object"""
+        if isinstance(children[0], _XdrIdentifier):
+            name = children[0].symbol
+            decorator = ""
+            if name in enums:
+                decorator = "enum "
+            if name in structs:
+                decorator = "struct "
+            return _XdrDefinedType(name, decorator)
+
+        token = children[0].data
+        return _XdrBuiltInType(
+            type_name=token.value, display_name=token.value.replace("_", " ")
+        )
+
+    def constant_def(self, children):
+        """Instantiate one _XdrConstant object"""
+        name = children[0].symbol
+        value = children[1].value
+        return _XdrConstant(name, value)
+
+    # cel: Python can compute a min() and max() for the enumerator values
+    #      so that the generated code can perform proper range checking.
+    def enum(self, children):
+        """Instantiate one _XdrEnum object"""
+        enum_name = children[0].symbol
+        enums.add(enum_name)
+
+        i = 0
+        enumerators = []
+        body = children[1]
+        while i < len(body.children):
+            name = body.children[i].symbol
+            value = body.children[i + 1].value
+            enumerators.append(_XdrEnumerator(name, value))
+            i = i + 2
+
+        return _XdrEnum(enum_name, 0, 0, enumerators)
+
+    def fixed_length_opaque(self, children):
+        """Instantiate one _XdrFixedLengthOpaque declaration object"""
+        name = children[0].symbol
+        size = children[1].value
+
+        return _XdrFixedLengthOpaque(name, size)
+
+    def variable_length_opaque(self, children):
+        """Instantiate one _XdrVariableLengthOpaque declaration object"""
+        name = children[0].symbol
+        if children[1] is not None:
+            maxsize = children[1].value
+        else:
+            maxsize = 0
+
+        return _XdrVariableLengthOpaque(name, maxsize)
+
+    def variable_length_string(self, children):
+        """Instantiate one _XdrVariableLengthString declaration object"""
+        name = children[0].symbol
+        if children[1] is not None:
+            maxsize = children[1].value
+        else:
+            maxsize = 0
+
+        return _XdrVariableLengthString(name, maxsize)
+
+    def fixed_length_array(self, children):
+        """Instantiate one _XdrFixedLengthArray declaration object"""
+        spec = children[0]
+        name = children[1].symbol
+        size = children[2].value
+
+        return _XdrFixedLengthArray(name, spec, size)
+
+    def variable_length_array(self, children):
+        """Instantiate one _XdrVariableLengthArray declaration object"""
+        spec = children[0]
+        name = children[1].symbol
+        if children[2] is not None:
+            maxsize = children[2].value
+        else:
+            maxsize = 0
+
+        return _XdrVariableLengthArray(name, spec, maxsize)
+
+    def optional_data(self, children):
+        """Instantiate one _XdrOptionalData declaration object"""
+        spec = children[0]
+        name = children[1].symbol
+        structs.add(name)
+        pass_by_reference.add(name)
+
+        return _XdrOptionalData(name, spec)
+
+    def basic(self, children):
+        """Instantiate one _XdrBasic object"""
+        spec = children[0]
+        name = children[1].symbol
+
+        return _XdrBasic(name, spec)
+
+    def void(self, children):
+        """Instantiate one _XdrVoid declaration object"""
+        return _XdrVoid()
+
+    def struct(self, children):
+        """Instantiate one _XdrStruct object"""
+        name = children[0].symbol
+        structs.add(name)
+        pass_by_reference.add(name)
+        fields = children[1].children
+
+        last_field = fields[-1]
+        if (
+            isinstance(last_field, _XdrOptionalData)
+            and name == last_field.spec.type_name
+        ):
+            return _XdrPointer(name, fields)
+        return _XdrStruct(name, fields)
+
+    def typedef(self, children):
+        """Instantiate one _XdrTypedef object"""
+        new_type = children[0]
+        if isinstance(new_type, _XdrBasic) and isinstance(
+            new_type.spec, _XdrDefinedType
+        ):
+            if new_type.spec.type_name in pass_by_reference:
+                pass_by_reference.add(new_type.name)
+
+        return _XdrTypedef(new_type)
+
+    def case_spec(self, children):
+        """Instantiate one _XdrCaseSpec object"""
+        values = []
+        for item in children[0:-1]:
+            values.append(item.value)
+        arm = children[-1]
+
+        return _XdrCaseSpec(values, arm)
+
+    def default_spec(self, children):
+        """Instantiate one _XdrDefaultSpec object"""
+        arm = children[0]
+
+        return _XdrDefaultSpec(arm)
+
+    def union(self, children):
+        """Instantiate one _XdrUnion object"""
+        name = children[0].symbol
+        structs.add(name)
+        pass_by_reference.add(name)
+        body = children[1]
+        discriminant = body.children[0].children[0]
+        cases = body.children[1:-1]
+        default = body.children[-1]
+
+        return _XdrUnion(name, discriminant, cases, default)
+
+    def procedure_def(self, children):
+        """Instantiate one _RpcProcedure object"""
+        result = children[0]
+        name = children[1].symbol
+        argument = children[2]
+        number = children[3].children[0].children[0].value
+
+        return _RpcProcedure(name, number, argument, result)
+
+    def version_def(self, children):
+        """Instantiate one _RpcVersion object"""
+        name = children[0].symbol
+        number = children[-1].children[0].children[0].value
+        procedures = children[1:-1]
+
+        return _RpcVersion(name, number, procedures)
+
+    def program_def(self, children):
+        """Instantiate one _RpcProgram object"""
+        name = children[0].symbol
+        number = children[-1].children[0].children[0].value
+        versions = children[1:-1]
+
+        return _RpcProgram(name, number, versions)
+
+    def pragma_def(self, children):
+        """Instantiate one _Pragma object"""
+        directive = children[0].children[0].data
+        match directive:
+            case "exclude_directive":
+                excluded_apis.append(children[1].symbol)
+            case "header_directive":
+                global header_name
+                header_name = children[1].symbol
+            case "public_directive":
+                public_apis.append(children[1].symbol)
+            case _:
+                raise NotImplementedError("Directive not supported")
+        return _Pragma()
+
+
+transformer = ast_utils.create_transformer(this_module, ParseToAst())
+
+
+def transform_parse_tree(parse_tree):
+    """Transform productions into an abstract syntax tree"""
+
+    return transformer.transform(parse_tree)
+
+
+def get_header_name() -> str:
+    """Return header name set by pragma header directive"""
+    return header_name
diff --git a/tools/net/sunrpc/xdrgen/xdr_parse.py b/tools/net/sunrpc/xdrgen/xdr_parse.py
new file mode 100644
index 000000000000..964b44e675df
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/xdr_parse.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Common parsing code for xdrgen"""
+
+from lark import Lark
+
+
+# Set to True to emit annotation comments in generated source
+annotate = False
+
+
+def set_xdr_annotate(set_it: bool) -> None:
+    """Set 'annotate' if --annotate was specified on the command line"""
+    global annotate
+    annotate = set_it
+
+
+def get_xdr_annotate() -> bool:
+    """Return True if --annotate was specified on the command line"""
+    return annotate
+
+
+def xdr_parser() -> Lark:
+    """Return a Lark parser instance configured with the XDR language grammar"""
+
+    return Lark.open(
+        "grammars/xdr.lark",
+        rel_to=__file__,
+        start="specification",
+        debug=True,
+        strict=True,
+        propagate_positions=True,
+        parser="lalr",
+        lexer="contextual",
+    )
diff --git a/tools/net/sunrpc/xdrgen/xdrgen b/tools/net/sunrpc/xdrgen/xdrgen
new file mode 100755
index 000000000000..2daeb2db53af
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/xdrgen
@@ -0,0 +1,111 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Translate an XDR specification into executable code that
+can be compiled for the Linux kernel."""
+
+__author__ = "Chuck Lever"
+__copyright__ = "Copyright (c) 2024 Oracle and/or its affiliates."
+__license__ = "GPL-2.0 only"
+__version__ = "0.2"
+
+import sys
+import argparse
+
+from subcmds import source
+from subcmds import header
+from subcmds import lint
+
+
+sys.path.insert(1, "@pythondir@")
+
+
+def main() -> int:
+    """Parse command-line options"""
+    parser = argparse.ArgumentParser(
+        formatter_class=argparse.RawDescriptionHelpFormatter,
+        description="Convert an XDR specification to Linux kernel source code",
+        epilog="""\
+Copyright (c) 2024 Oracle and/or its affiliates.
+
+License GPLv2: <http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt>
+This is free software.  You are free to change and redistribute it.
+There is NO WARRANTY, to the extent permitted by law.""",
+    )
+    parser.add_argument(
+        "--version",
+        help="Display the version of this tool",
+        action="version",
+        version=__version__,
+    )
+
+    subcommands = parser.add_subparsers(title="Subcommands", required=True)
+
+    header_parser = subcommands.add_parser(
+        "header", help="Generate XDR definitions and declarations"
+    )
+    header_parser.add_argument(
+        "--annotate",
+        action="store_true",
+        default=False,
+        help="Add annotation comments",
+    )
+    header_parser.add_argument(
+        "--declarations",
+        action="store_true",
+        default=False,
+        help="Generate RPC procedure declarations",
+    )
+    header_parser.add_argument(
+        "--definitions",
+        action="store_true",
+        default=False,
+        help="Generate protocol definitions",
+    )
+    header_parser.add_argument(
+        "--language",
+        action="store_true",
+        default="C",
+        help="Output language",
+    )
+    header_parser.add_argument("filename", help="File containing an XDR specification")
+    header_parser.set_defaults(func=header.subcmd)
+
+    linter_parser = subcommands.add_parser("lint", help="Check an XDR specification")
+    linter_parser.add_argument("filename", help="File containing an XDR specification")
+    linter_parser.set_defaults(func=lint.subcmd)
+
+    source_parser = subcommands.add_parser(
+        "source", help="Generate XDR encoder and decoder source code"
+    )
+    source_parser.add_argument(
+        "--annotate",
+        action="store_true",
+        default=False,
+        help="Add annotation comments",
+    )
+    source_parser.add_argument(
+        "--language",
+        action="store_true",
+        default="C",
+        help="Output language",
+    )
+    source_parser.add_argument(
+        "--peer",
+        choices=["server", "client",],
+        default="server",
+        help="Generate code for client or server side",
+        type=str,
+    )
+    source_parser.add_argument("filename", help="File containing an XDR specification")
+    source_parser.set_defaults(func=source.subcmd)
+
+    args = parser.parse_args()
+    return args.func(args)
+
+
+try:
+    if __name__ == "__main__":
+        sys.exit(main())
+except (SystemExit, KeyboardInterrupt, RuntimeError, BrokenPipeError):
+    sys.exit(1)
-- 
2.45.2


