Return-Path: <linux-nfs+bounces-5481-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC1958A0F
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2024 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B0F2821F2
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015EB192B95;
	Tue, 20 Aug 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm5QC7Q7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC21922F3
	for <linux-nfs@vger.kernel.org>; Tue, 20 Aug 2024 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165174; cv=none; b=BhO3CgckYCJWOiweCbAeBKB9knRhtTSGgD/DEGvxVHlJbgnnpF0GKUK40IKqMwcebw4lGyvc/BP8k2HC9iV/e+AdYBfCgTLLaqqLvEgsvlh87PueMBZxzVHinSLLLaIWD8FGV/UJ+PVME7U1vR59uSxR0Wq7riLwsA0Lto7SfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165174; c=relaxed/simple;
	bh=WOrL+zL07ME5WiGmLejvj2PwJX4ONmTTVknwoxy5nUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIsgocQk0D/AG40ovaKHrxI3VokqvRUwrJTOBNN2/NQVDiagHL0dvIKoCQ5MoVbY9i3/ryohZmu8gf3axN/xUKApeDUJQLv+4QDj4oerj41CvgNkl+mtIituzGs/ZxJSlRoMw+1RRzsKvaoHJGK+PvXqh2xHxU0Cyb1VznBHxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm5QC7Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8452CC4AF0F;
	Tue, 20 Aug 2024 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165174;
	bh=WOrL+zL07ME5WiGmLejvj2PwJX4ONmTTVknwoxy5nUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xm5QC7Q7/TqX1e9r18G1sMqwMpCg51QnOKJLWFiFAfQ61wo63xzLhmTSTd1ZYdTOG
	 wSBeIm0hTdPfRYwfnGo3KJhkjYhvbCQ8kJFH2QcO9lZSlTpveD/wsHx1714cL4PO2Y
	 eHJw5m4o8QtJnWzUpggGxWFO7bUNw5/oN0CmEC+VSZlOfsJh0Sas8QNZj7efrKrhCl
	 ZMfRJkMX/jB4KP0FUFQ2MP/YFmIB7owIaeCwvxKc2wk7MxM5owQxkw/tjUTkQaFW5S
	 McOkgK4f4ZNyL14dThxndB2C0EU39CHwG9dnQYj4jr0IOGF/l6/ALFn1vPkjhH7PZ8
	 88cLwXCg8larQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/2] tools: Add xdrgen
Date: Tue, 20 Aug 2024 10:45:59 -0400
Message-ID: <20240820144600.189744-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240820144600.189744-1-cel@kernel.org>
References: <20240820144600.189744-1-cel@kernel.org>
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
the Linux kernel's sunrpc/ layer.

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
 109 files changed, 3473 insertions(+)
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

diff --git a/include/linux/sunrpc/xdrgen-builtins.h b/include/linux/sunrpc/xdrgen-builtins.h
new file mode 100644
index 000000000000..01daef4b66b7
--- /dev/null
+++ b/include/linux/sunrpc/xdrgen-builtins.h
@@ -0,0 +1,253 @@
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
index 000000000000..1b67c1838dae
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/README
@@ -0,0 +1,231 @@
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
+XDR specifications for SunRPC-based protocols implemented in the
+Linux kernel are located here:
+
+   Documentation/sunrpc/xdr/
+
+A symlink has been added to the xdrgen directory for easy access to
+those files.
+
+When adding a new protocol implementation to the kernel, the XDR
+specification can be derived by feeding a .txt copy of the RFC to
+the script located in tools/net/sunrpc/extract.sh.
+
+   $ extract.sh < rfc0001.txt > xdr/new2.x
+
+
+Operation
+---------
+
+Once a .x file is available, use xdrgen to generate a C source and
+header file containing an implementation of XDR encoding and
+decoding functions for the specified protocol.
+
+   $ ./xdrgen header xdr/new.x > new2xdr_gen.h
+
+and
+
+   $ ./xdrgen source xdr/new.x > new2xdr_gen.c
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
+Pragma header
+------ ------
+
+  pragma header <string> ;
+
+Provide a name to use for the header file and header guards.
+
+For example:
+
+  pragma header NLM4;
+
+Adds header guards in the generated header file called
+
+  NLM4_XDR_GEN_H
+
+And adds
+
+  #include "nlm4xdr_gen.h"
+
+to the generated C source file.
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
+without the "static __maybe_unused" declaration.
+
+
+Future Work
+-----------
+
+Enable xdrgen to be run in any directory rather than only in
+tools/net/sunrpc/xdrgen.
+
+Add more pragma directives:
+
+  * @exclude -- don't emit procedure argument or result encoders;
+    the specified procedure will be hand-rolled
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
+into C code
+
+Generate kernel Rust code as well as C code
+
+Add a command-line option to insert trace_printk call sites in the
+generated source code, for improved (temporary) observability
diff --git a/tools/net/sunrpc/xdrgen/__init__.py b/tools/net/sunrpc/xdrgen/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/net/sunrpc/xdrgen/common.py b/tools/net/sunrpc/xdrgen/common.py
new file mode 100644
index 000000000000..c493ffbdddb0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/common.py
@@ -0,0 +1,21 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Utility functions and global variables for xdrgen."""
+
+global annotate
+annotate = False
+
+
+def set_xdr_annotate(set_it):
+    """Set 'annotate' if --annotate was specified on the command line"""
+    global annotate
+
+    annotate = set_it
+
+
+def get_xdr_annotate():
+    """Return True if --annotate was specified on the command line"""
+    global annotate
+
+    return annotate
diff --git a/tools/net/sunrpc/xdrgen/generators/__init__.py b/tools/net/sunrpc/xdrgen/generators/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/net/sunrpc/xdrgen/generators/boilerplate.py b/tools/net/sunrpc/xdrgen/generators/boilerplate.py
new file mode 100644
index 000000000000..8680161dd3a3
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/boilerplate.py
@@ -0,0 +1,66 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate boilerplate items"""
+
+import os.path
+import time
+from jinja2 import Environment, FileSystemLoader
+
+from xdr_ast import _RpcProgram, get_header_name
+
+
+def find_xdr_program_name(ast):
+    """Retrieve the RPC program name from an abstract syntax tree"""
+    raw_name = get_header_name()
+    if raw_name != "none":
+        return raw_name.lower()
+    for definition in ast.definitions:
+        if isinstance(definition.value, _RpcProgram):
+            raw_name = definition.value.name
+            return raw_name.lower().removesuffix("_program").removesuffix("_prog")
+    return "noprog"
+
+
+class SourceGenerator:
+    """Generate source code boilerplate"""
+
+    def __init__(self, language):
+        """Set the output language"""
+        match language:
+            case "C":
+                self.environment = Environment(
+                    loader=FileSystemLoader("templates/C/boilerplate/"),
+                    trim_blocks=True,
+                    lstrip_blocks=True,
+                )
+            case _:
+                raise NotImplementedError("Language not supported")
+
+    def emit_header_bottom(self, ast):
+        """Emit the bottom header guard"""
+        name = find_xdr_program_name(ast)
+        template = self.environment.get_template("header_bottom.j2")
+        print(template.render(program=name))
+
+    def emit_header_top(self, filename, ast):
+        """Emit the top header guard"""
+        name = find_xdr_program_name(ast)
+        template = self.environment.get_template("header_top.j2")
+        print(
+            template.render(
+                program=name,
+                mtime=time.ctime(os.path.getmtime(filename)),
+            )
+        )
+
+    def emit_source_top(self, filename, ast):
+        """Emit the top source boilerplate"""
+        name = find_xdr_program_name(ast)
+        template = self.environment.get_template("source_top.j2")
+        print(
+            template.render(
+                program=name,
+                mtime=time.ctime(os.path.getmtime(filename)),
+            )
+        )
diff --git a/tools/net/sunrpc/xdrgen/generators/constant.py b/tools/net/sunrpc/xdrgen/generators/constant.py
new file mode 100644
index 000000000000..3d70bd103dc9
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/constant.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR constants"""
+
+from jinja2 import Environment, FileSystemLoader
+
+
+class SourceGenerator:
+    """Generate source code for XDR constants"""
+
+    def __init__(self, language):
+        """Set the output language"""
+        match language:
+            case "C":
+                self.environment = Environment(
+                    loader=FileSystemLoader("templates/C/constants/"),
+                    trim_blocks=True,
+                    lstrip_blocks=True,
+                )
+            case _:
+                raise NotImplementedError("Language not supported")
+
+    def emit_declaration(self, ast_node):
+        """Emit one declaration for a constant"""
+        template = self.environment.get_template("declaration.j2")
+        print(
+            template.render(
+                name=ast_node.name,
+                value=ast_node.value,
+            )
+        )
+
+    def emit_decoder(self, ast_node):
+        """Emit one decoder for a constant"""
+
+    def emit_encoder(self, ast_node):
+        """Emit one encoder for a constant"""
diff --git a/tools/net/sunrpc/xdrgen/generators/enum.py b/tools/net/sunrpc/xdrgen/generators/enum.py
new file mode 100644
index 000000000000..62caa8661f47
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/enum.py
@@ -0,0 +1,67 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR enum types"""
+
+from jinja2 import Environment, FileSystemLoader
+
+from xdr_ast import public_apis
+from common import get_xdr_annotate
+
+
+class SourceGenerator:
+    """Generate source code for XDR enum types"""
+
+    def __init__(self, language):
+        """Set the output language"""
+        match language:
+            case "C":
+                self.environment = Environment(
+                    loader=FileSystemLoader("templates/C/enum/"),
+                    trim_blocks=True,
+                    lstrip_blocks=True,
+                )
+            case _:
+                raise NotImplementedError("Language not supported")
+
+    def emit_declaration(self, ast_node):
+        """Emit one declaration for an enum type"""
+
+        template = self.environment.get_template("declaration/open.j2")
+        print(template.render(name=ast_node.name))
+
+        template = self.environment.get_template("declaration/enumerator.j2")
+        for enumerator in ast_node.enumerators:
+            print(
+                template.render(
+                    name=enumerator.name,
+                    value=enumerator.value,
+                )
+            )
+
+        template = self.environment.get_template("declaration/close.j2")
+        print(template.render(public_apis=public_apis, name=ast_node.name))
+
+    def emit_decoder(self, ast_node):
+        """Emit one decoder function for an enum type"""
+
+        template = self.environment.get_template("decoder/enum.j2")
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+            )
+        )
+
+    def emit_encoder(self, ast_node):
+        """Emit one encoder function for an enum type"""
+
+        template = self.environment.get_template("encoder/enum.j2")
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+            )
+        )
diff --git a/tools/net/sunrpc/xdrgen/generators/program.py b/tools/net/sunrpc/xdrgen/generators/program.py
new file mode 100644
index 000000000000..1825fadd9764
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/program.py
@@ -0,0 +1,96 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code for an RPC program's procedures"""
+
+from jinja2 import Environment, FileSystemLoader
+
+
+def emit_version_declarations(environment, program, version):
+    """Emit C declarations for each RPC version's procedures"""
+    print("")
+    template = environment.get_template("declaration/argument.j2")
+    for procedure in version.procedures:
+        print(
+            template.render(
+                program=program,
+                argument=procedure.argument.type_name,
+            )
+        )
+
+    print("")
+    template = environment.get_template("declaration/result.j2")
+    for procedure in version.procedures:
+        print(template.render(program=program, result=procedure.result.type_name))
+
+
+def emit_version_argument_decoders(environment, program, version):
+    """Emit C decoders for each RPC version's procedures"""
+    arguments = set()
+    for procedure in version.procedures:
+        arguments.add(procedure.argument.type_name)
+
+    template = environment.get_template("decoder/argument.j2")
+    for argument in arguments:
+        print(
+            template.render(
+                program=program,
+                argument=argument,
+            )
+        )
+
+
+def emit_version_result_encoders(environment, program, version):
+    """Emit C encoders for each RPC version's procedures"""
+    results = set()
+    for procedure in version.procedures:
+        results.add(procedure.result.type_name)
+
+    template = environment.get_template("encoder/result.j2")
+    for result in results:
+        print(
+            template.render(
+                program=program,
+                result=result,
+            )
+        )
+
+
+class SourceGenerator:
+    """Generate source code for an RPC program's procedures"""
+
+    def __init__(self, language):
+        """Set the output language"""
+        match language:
+            case "C":
+                self.environment = Environment(
+                    loader=FileSystemLoader("templates/C/program/"),
+                    trim_blocks=True,
+                    lstrip_blocks=True,
+                )
+            case _:
+                raise NotImplementedError("Language not supported")
+
+    def emit_declaration(self, ast_node):
+        """Emit a declarations pair for each of an RPC programs's procedures"""
+        raw_name = ast_node.name
+        program = raw_name.lower().removesuffix("_program").removesuffix("_prog")
+
+        for version in ast_node.versions:
+            emit_version_declarations(self.environment, program, version)
+
+    def emit_decoder(self, ast_node):
+        """Emit all decoder functions for an RPC program's procedures"""
+        raw_name = ast_node.name
+        program = raw_name.lower().removesuffix("_program").removesuffix("_prog")
+
+        for version in ast_node.versions:
+            emit_version_argument_decoders(self.environment, program, version)
+
+    def emit_encoder(self, ast_node):
+        """Emit all encoder functions for an RPC program's procedures"""
+        raw_name = ast_node.name
+        program = raw_name.lower().removesuffix("_program").removesuffix("_prog")
+
+        for version in ast_node.versions:
+            emit_version_result_encoders(self.environment, program, version)
diff --git a/tools/net/sunrpc/xdrgen/generators/struct.py b/tools/net/sunrpc/xdrgen/generators/struct.py
new file mode 100644
index 000000000000..aec908a7952c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/struct.py
@@ -0,0 +1,435 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR struct types"""
+
+from jinja2 import Environment, FileSystemLoader
+
+from common import get_xdr_annotate
+
+from xdr_ast import _BasicDeclaration, _VariableLengthString
+from xdr_ast import _FixedLengthOpaque, _VariableLengthOpaque
+from xdr_ast import _FixedLengthArray, _VariableLengthArray
+from xdr_ast import _XdrOptionalData, _BuiltInType, public_apis
+
+
+def get_kernel_c_type(type_spec):
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
+    if isinstance(type_spec, _BuiltInType):
+        return xdr_type_to_c_type[type_spec.type_name]
+    return type_spec.type_name
+
+
+def get_jinja_template(environment, template_type, template_name):
+    """Retrieve a Jinja2 template for emitting source code"""
+    return environment.get_template(template_type + "/" + template_name + ".j2")
+
+
+def emit_struct_member_definition(environment, field):
+    """Emit C definition for one field in one XDR struct"""
+    if isinstance(field, _BasicDeclaration):
+        template = get_jinja_template(environment, "declaration", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _FixedLengthOpaque):
+        template = get_jinja_template(environment, "declaration", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _VariableLengthOpaque):
+        template = get_jinja_template(environment, "declaration", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+            )
+        )
+    elif isinstance(field, _VariableLengthString):
+        template = get_jinja_template(environment, "declaration", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+            )
+        )
+    elif isinstance(field, _FixedLengthArray):
+        template = get_jinja_template(environment, "declaration", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _VariableLengthArray):
+        template = get_jinja_template(environment, "declaration", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _XdrOptionalData):
+        template = get_jinja_template(environment, "declaration", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=get_kernel_c_type(field.spec),
+                ctype=field.spec.type_decorator,
+            )
+        )
+
+
+def emit_struct_definition(environment, ast_node):
+    """Emit one C declaration for a struct type"""
+    template = get_jinja_template(environment, "declaration", "open")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=ast_node.name,
+        )
+    )
+
+    for field in ast_node.fields:
+        emit_struct_member_definition(environment, field)
+
+    template = get_jinja_template(environment, "declaration", "close")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            public_apis=public_apis,
+            name=ast_node.name,
+        )
+    )
+
+
+def emit_pointer_definition(environment, ast_node):
+    """Emit one C definition for a pointer type"""
+    template = get_jinja_template(environment, "declaration", "pointer-open")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=ast_node.name,
+        )
+    )
+
+    for field in ast_node.fields[0:-1]:
+        emit_struct_member_definition(environment, field)
+
+    template = get_jinja_template(environment, "declaration", "close")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            public_apis=public_apis,
+            name=ast_node.name,
+        )
+    )
+
+
+def emit_struct_member_decoder(environment, field):
+    """Emit C decoder for one field in one XDR struct"""
+    if isinstance(field, _BasicDeclaration):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=field.spec.type_name,
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _FixedLengthOpaque):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _VariableLengthOpaque):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _VariableLengthString):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _FixedLengthArray):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=field.spec.type_name,
+                size=field.size,
+                ctype=field.spec.type_decorator,
+            )
+        )
+    elif isinstance(field, _VariableLengthArray):
+        template = get_jinja_template(environment, "decoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
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
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=field.spec.type_name,
+                ctype=field.spec.type_decorator,
+            )
+        )
+
+
+def emit_struct_decoder(environment, ast_node):
+    """Emit one decoder function for a struct type"""
+    template = get_jinja_template(environment, "decoder", "open")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            public_apis=public_apis,
+            name=ast_node.name,
+        )
+    )
+
+    for field in ast_node.fields:
+        emit_struct_member_decoder(environment, field)
+
+    template = get_jinja_template(environment, "decoder", "close")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+        )
+    )
+
+
+# cel: Would be better to just create a new dataclass for pointer types,
+# and copy all of this to generators/pointer.py
+def emit_pointer_decoder(environment, ast_node):
+    """Emit one decoder function for a struct type"""
+    template = get_jinja_template(environment, "decoder", "pointer-open")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            public_apis=public_apis,
+            name=ast_node.name,
+        )
+    )
+
+    for field in ast_node.fields[0:-1]:
+        emit_struct_member_decoder(environment, field)
+
+    template = get_jinja_template(environment, "decoder", "close")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+        )
+    )
+
+
+def emit_struct_member_encoder(environment, field):
+    """Emit C encoder for one field in one XDR struct"""
+    if isinstance(field, _BasicDeclaration):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=field.spec.type_name,
+                encode_needs_addressof=field.spec.pass_by_reference,
+            )
+        )
+    elif isinstance(field, _FixedLengthOpaque):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                size=field.size,
+            )
+        )
+    elif isinstance(field, _VariableLengthOpaque):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _VariableLengthString):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                maxsize=field.maxsize,
+            )
+        )
+    elif isinstance(field, _FixedLengthArray):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=field.spec.type_name,
+                size=field.size,
+                encode_needs_addressof=field.spec.pass_by_reference,
+            )
+        )
+    elif isinstance(field, _VariableLengthArray):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=field.spec.type_name,
+                maxsize=field.maxsize,
+                encode_needs_addressof=field.spec.pass_by_reference,
+            )
+        )
+    elif isinstance(field, _XdrOptionalData):
+        template = get_jinja_template(environment, "encoder", field.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                name=field.name,
+                type=field.spec.type_name,
+                ctype=field.spec.type_decorator,
+            )
+        )
+
+
+def emit_struct_encoder(environment, ast_node):
+    """Emit one encoder function for a struct type"""
+    template = get_jinja_template(environment, "encoder", "open")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            public_apis=public_apis,
+            name=ast_node.name,
+        )
+    )
+
+    for field in ast_node.fields:
+        emit_struct_member_encoder(environment, field)
+
+    template = get_jinja_template(environment, "encoder", "close")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+        )
+    )
+
+
+# cel: Would be better to just create a new dataclass for pointer types,
+# and copy all of this to generators/pointer.py
+def emit_pointer_encoder(environment, ast_node):
+    """Emit one encoder function for a struct type"""
+    template = get_jinja_template(environment, "encoder", "pointer-open")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            public_apis=public_apis,
+            name=ast_node.name,
+        )
+    )
+
+    for field in ast_node.fields[0:-1]:
+        emit_struct_member_encoder(environment, field)
+
+    template = get_jinja_template(environment, "encoder", "close")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+        )
+    )
+
+
+def is_pointer_type(ast_node):
+    """Predicate: returns true if @ast_node should be a pointer type"""
+    last_field = ast_node.fields[-1]
+    if (
+        isinstance(last_field, _XdrOptionalData)
+        and ast_node.name == last_field.spec.type_name
+    ):
+        return True
+    return False
+
+
+class SourceGenerator:
+    """Generate source code for XDR structs"""
+
+    def __init__(self, language):
+        """Set the output language"""
+        match language:
+            case "C":
+                self.environment = Environment(
+                    loader=FileSystemLoader("templates/C/struct/"),
+                    trim_blocks=True,
+                    lstrip_blocks=True,
+                )
+            case _:
+                raise NotImplementedError("Language not supported")
+
+    def emit_declaration(self, ast_node):
+        """Emit one declaration for a struct type"""
+        if is_pointer_type(ast_node):
+            emit_pointer_definition(self.environment, ast_node)
+        else:
+            emit_struct_definition(self.environment, ast_node)
+
+    def emit_decoder(self, ast_node):
+        """Emit one decoder function for a struct type"""
+        if is_pointer_type(ast_node):
+            emit_pointer_decoder(self.environment, ast_node)
+        else:
+            emit_struct_decoder(self.environment, ast_node)
+
+    def emit_encoder(self, ast_node):
+        """Emit one encoder function for a struct type"""
+        if is_pointer_type(ast_node):
+            emit_pointer_encoder(self.environment, ast_node)
+        else:
+            emit_struct_encoder(self.environment, ast_node)
diff --git a/tools/net/sunrpc/xdrgen/generators/typedef.py b/tools/net/sunrpc/xdrgen/generators/typedef.py
new file mode 100644
index 000000000000..615f1e4b0e4d
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/typedef.py
@@ -0,0 +1,282 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR typedefs"""
+
+from jinja2 import Environment, FileSystemLoader
+
+from common import get_xdr_annotate
+
+from xdr_ast import _BasicDeclaration, _VariableLengthString
+from xdr_ast import _FixedLengthOpaque, _VariableLengthOpaque
+from xdr_ast import _FixedLengthArray, _VariableLengthArray
+from xdr_ast import _XdrOptionalData, _XdrVoid, _BuiltInType
+from xdr_ast import public_apis
+
+
+def get_kernel_c_type(type_spec):
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
+    if isinstance(type_spec, _BuiltInType):
+        return xdr_type_to_c_type[type_spec.type_name]
+    return type_spec.type_name
+
+
+def get_jinja_template(environment, template_type, template_name):
+    """Retrieve a Jinja2 template for emitting source code"""
+    return environment.get_template(template_type + "/" + template_name + ".j2")
+
+
+def emit_type_definition(environment, ast_node):
+    """Emit C declaration for one XDR typedef"""
+    if isinstance(ast_node, _BasicDeclaration):
+        template = get_jinja_template(environment, "declaration", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                type=get_kernel_c_type(ast_node.spec),
+                ctype=ast_node.spec.type_decorator,
+            )
+        )
+    elif isinstance(ast_node, _VariableLengthString):
+        template = get_jinja_template(environment, "declaration", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+            )
+        )
+    elif isinstance(ast_node, _FixedLengthOpaque):
+        template = get_jinja_template(environment, "declaration", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                size=ast_node.size,
+            )
+        )
+    elif isinstance(ast_node, _VariableLengthOpaque):
+        template = get_jinja_template(environment, "declaration", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+            )
+        )
+    elif isinstance(ast_node, _FixedLengthArray):
+        template = get_jinja_template(environment, "declaration", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                type=ast_node.spec.type_name,
+                size=ast_node.size,
+            )
+        )
+    elif isinstance(ast_node, _VariableLengthArray):
+        template = get_jinja_template(environment, "declaration", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                type=ast_node.spec.type_name,
+                ctype=ast_node.spec.type_decorator,
+            )
+        )
+    elif isinstance(ast_node, _XdrOptionalData):
+        raise NotImplementedError("<optional_data> typedef not yet implemented")
+    elif isinstance(ast_node, _XdrVoid):
+        raise NotImplementedError("<void> typedef not yet implemented")
+    else:
+        raise NotImplementedError("typedef: type not recognized")
+
+
+def emit_typedef_decoder(environment, ast_node):
+    """Emit C decoder function for one typedef"""
+    if isinstance(ast_node, _BasicDeclaration):
+        template = get_jinja_template(environment, "decoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                type=ast_node.spec.type_name,
+            )
+        )
+    elif isinstance(ast_node, _VariableLengthString):
+        template = get_jinja_template(environment, "decoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                maxsize=ast_node.maxsize,
+            )
+        )
+    elif isinstance(ast_node, _FixedLengthOpaque):
+        template = get_jinja_template(environment, "decoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                size=ast_node.size,
+            )
+        )
+    elif isinstance(ast_node, _VariableLengthOpaque):
+        template = get_jinja_template(environment, "decoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                maxsize=ast_node.maxsize,
+            )
+        )
+    elif isinstance(ast_node, _FixedLengthArray):
+        template = get_jinja_template(environment, "decoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                type=ast_node.spec.type_name,
+                size=ast_node.size,
+                ctype=ast_node.spec.type_decorator,
+            )
+        )
+    elif isinstance(ast_node, _VariableLengthArray):
+        template = get_jinja_template(environment, "decoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                type=ast_node.spec.type_name,
+                maxsize=ast_node.maxsize,
+            )
+        )
+    elif isinstance(ast_node, _XdrOptionalData):
+        raise NotImplementedError("<optional_data> typedef not yet implemented")
+    elif isinstance(ast_node, _XdrVoid):
+        raise NotImplementedError("<void> typedef not yet implemented")
+    else:
+        raise NotImplementedError("typedef: type not recognized")
+
+
+def emit_typedef_encoder(environment, ast_node):
+    """Emit one encoder function for one typedef"""
+    if isinstance(ast_node, _BasicDeclaration):
+        template = get_jinja_template(environment, "encoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                type=ast_node.spec.type_name,
+                encode_needs_addressof=ast_node.spec.pass_by_reference,
+            )
+        )
+    elif isinstance(ast_node, _VariableLengthString):
+        template = get_jinja_template(environment, "encoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                maxsize=ast_node.maxsize,
+            )
+        )
+    elif isinstance(ast_node, _FixedLengthOpaque):
+        template = get_jinja_template(environment, "encoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                size=ast_node.size,
+            )
+        )
+    elif isinstance(ast_node, _VariableLengthOpaque):
+        template = get_jinja_template(environment, "encoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                maxsize=ast_node.maxsize,
+            )
+        )
+    elif isinstance(ast_node, _FixedLengthArray):
+        template = get_jinja_template(environment, "encoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                type=ast_node.spec.type_name,
+                size=ast_node.size,
+                encode_needs_addressof=ast_node.spec.pass_by_reference,
+            )
+        )
+    elif isinstance(ast_node, _VariableLengthArray):
+        template = get_jinja_template(environment, "encoder", ast_node.template)
+        print(
+            template.render(
+                annotate=get_xdr_annotate(),
+                public_apis=public_apis,
+                name=ast_node.name,
+                type=ast_node.spec.type_name,
+                maxsize=ast_node.maxsize,
+                encode_needs_addressof=ast_node.spec.pass_by_reference,
+            )
+        )
+    elif isinstance(ast_node, _XdrOptionalData):
+        raise NotImplementedError("<optional_data> typedef not yet implemented")
+    elif isinstance(ast_node, _XdrVoid):
+        raise NotImplementedError("<void> typedef not yet implemented")
+    else:
+        raise NotImplementedError("typedef: type not recognized")
+
+
+class SourceGenerator:
+    """Generate source code for XDR typedefs"""
+
+    def __init__(self, language):
+        """Set the output language"""
+        match language:
+            case "C":
+                self.environment = Environment(
+                    loader=FileSystemLoader("templates/C/typedef/"),
+                    trim_blocks=True,
+                    lstrip_blocks=True,
+                )
+            case _:
+                raise NotImplementedError("Language not supported")
+
+    def emit_declaration(self, ast_node):
+        """Emit one declaration for an XDR typedef"""
+        emit_type_definition(self.environment, ast_node.declaration)
+
+    def emit_decoder(self, ast_node):
+        """Emit one decoder function for an XDR typedef"""
+        emit_typedef_decoder(self.environment, ast_node.declaration)
+
+    def emit_encoder(self, ast_node):
+        """Emit one encoder function for an XDR typedef"""
+        emit_typedef_encoder(self.environment, ast_node.declaration)
diff --git a/tools/net/sunrpc/xdrgen/generators/union.py b/tools/net/sunrpc/xdrgen/generators/union.py
new file mode 100644
index 000000000000..ea638c1b0d4a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/generators/union.py
@@ -0,0 +1,297 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Generate code to handle XDR unions"""
+
+from jinja2 import Environment, FileSystemLoader
+
+from common import get_xdr_annotate
+
+from xdr_ast import _BasicDeclaration, _XdrVoid, public_apis
+
+
+def get_jinja_template(environment, template_type, template_name):
+    """Retrieve a Jinja2 template for emitting source code"""
+    return environment.get_template(template_type + "/" + template_name + ".j2")
+
+
+def emit_union_switch_spec_definition(environment, ast_node):
+    """Emit C declaration for an XDR union's discriminant"""
+    assert isinstance(ast_node, _BasicDeclaration)
+    template = get_jinja_template(environment, "declaration", "switch_spec")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=ast_node.name,
+            type=ast_node.spec.type_name,
+            ctype=ast_node.spec.type_decorator,
+        )
+    )
+
+
+def emit_union_case_spec_definition(environment, ast_node):
+    """Emit C declaration for an XDR union's case arm"""
+    if isinstance(ast_node.arm, _XdrVoid):
+        return
+    assert isinstance(ast_node.arm, _BasicDeclaration)
+    template = get_jinja_template(environment, "declaration", "case_spec")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=ast_node.arm.name,
+            type=ast_node.arm.spec.type_name,
+            ctype=ast_node.arm.spec.type_decorator,
+        )
+    )
+
+
+def emit_union_declaration(environment, ast_node):
+    """Emit one C union definition"""
+    template = get_jinja_template(environment, "declaration", "open")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=ast_node.name,
+        )
+    )
+
+    emit_union_switch_spec_definition(environment, ast_node.discriminant)
+
+    for case in ast_node.cases:
+        emit_union_case_spec_definition(environment, case)
+
+    if ast_node.default is not None:
+        emit_union_case_spec_definition(environment, ast_node.default)
+
+    template = get_jinja_template(environment, "declaration", "close")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            public_apis=public_apis,
+            name=ast_node.name,
+        )
+    )
+
+
+def emit_union_switch_spec_decoder(environment, ast_node):
+    """Emit C decoder for an XDR union's discriminant"""
+    assert isinstance(ast_node, _BasicDeclaration)
+    template = get_jinja_template(environment, "decoder", "switch_spec")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=ast_node.name,
+            type=ast_node.spec.type_name,
+        )
+    )
+
+
+def emit_union_case_spec_decoder(environment, ast_node):
+    """Emit C decoder functions for an XDR union's case arm"""
+
+    if isinstance(ast_node.arm, _XdrVoid):
+        return
+
+    template = get_jinja_template(environment, "decoder", "case_spec")
+    for case in ast_node.values:
+        match case:
+            case "TRUE":
+                print(template.render(case="true"))
+            case "FALSE":
+                print(template.render(case="false"))
+            case _:
+                print(template.render(case=case))
+
+    assert isinstance(ast_node.arm, _BasicDeclaration)
+    template = get_jinja_template(environment, "decoder", ast_node.arm.template)
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=ast_node.arm.name,
+            type=ast_node.arm.spec.type_name,
+            ctype=ast_node.arm.spec.type_decorator,
+        )
+    )
+
+    template = get_jinja_template(environment, "decoder", "break")
+    print(template.render())
+
+
+def emit_union_default_spec_decoder(environment, ast_node):
+    """Emit C decoder function for an XDR union's default arm"""
+    default_case = ast_node.default
+
+    # Avoid a gcc warning about a default case with boolean discriminant
+    if default_case is None and ast_node.discriminant.spec.type_name == "bool":
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
+    assert isinstance(default_case.arm, _BasicDeclaration)
+    template = get_jinja_template(environment, "decoder", default_case.arm.template)
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=default_case.arm.name,
+            type=default_case.arm.spec.type_name,
+            ctype=default_case.arm.spec.type_decorator,
+        )
+    )
+
+
+def emit_union_decoder(environment, ast_node):
+    """Emit one C union decoder"""
+    template = get_jinja_template(environment, "decoder", "open")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            public_apis=public_apis,
+            name=ast_node.name,
+        )
+    )
+
+    emit_union_switch_spec_decoder(environment, ast_node.discriminant)
+
+    for case in ast_node.cases:
+        emit_union_case_spec_decoder(environment, case)
+
+    emit_union_default_spec_decoder(environment, ast_node)
+
+    template = get_jinja_template(environment, "decoder", "close")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+        )
+    )
+
+
+def emit_union_switch_spec_encoder(environment, ast_node):
+    """Emit C encoder for an XDR union's discriminant"""
+    assert isinstance(ast_node, _BasicDeclaration)
+    template = get_jinja_template(environment, "encoder", "switch_spec")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=ast_node.name,
+            type=ast_node.spec.type_name,
+        )
+    )
+
+
+def emit_union_case_spec_encoder(environment, ast_node):
+    """Emit C encoder functions for an XDR union's case arm"""
+
+    if isinstance(ast_node.arm, _XdrVoid):
+        return
+
+    template = get_jinja_template(environment, "encoder", "case_spec")
+    for case in ast_node.values:
+        match case:
+            case "TRUE":
+                print(template.render(case="true"))
+            case "FALSE":
+                print(template.render(case="false"))
+            case _:
+                print(template.render(case=case))
+
+    assert isinstance(ast_node.arm, _BasicDeclaration)
+    template = get_jinja_template(environment, "encoder", ast_node.arm.template)
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=ast_node.arm.name,
+            type=ast_node.arm.spec.type_name,
+            encode_needs_addressof=ast_node.arm.spec.pass_by_reference,
+        )
+    )
+
+    template = get_jinja_template(environment, "encoder", "break")
+    print(template.render())
+
+
+def emit_union_default_spec_encoder(environment, ast_node):
+    """Emit C encoder function for an XDR union's default arm"""
+    default_case = ast_node.default
+
+    # Avoid a gcc warning about a default case with boolean discriminant
+    if default_case is None and ast_node.discriminant.spec.type_name == "bool":
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
+    assert isinstance(default_case.arm, _BasicDeclaration)
+    template = get_jinja_template(environment, "encoder", default_case.arm.template)
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            name=default_case.arm.name,
+            type=default_case.arm.spec.type_name,
+            encode_needs_addressof=default_case.arm.spec.pass_by_reference,
+        )
+    )
+
+
+def emit_union_encoder(environment, ast_node):
+    """Emit one C union encoder"""
+    template = get_jinja_template(environment, "encoder", "open")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+            public_apis=public_apis,
+            name=ast_node.name,
+        )
+    )
+
+    emit_union_switch_spec_encoder(environment, ast_node.discriminant)
+
+    for case in ast_node.cases:
+        emit_union_case_spec_encoder(environment, case)
+
+    emit_union_default_spec_encoder(environment, ast_node)
+
+    template = get_jinja_template(environment, "encoder", "close")
+    print(
+        template.render(
+            annotate=get_xdr_annotate(),
+        )
+    )
+
+
+class SourceGenerator:
+    """Generate source code for XDR unions"""
+
+    def __init__(self, language):
+        """Set the output language"""
+        match language:
+            case "C":
+                self.environment = Environment(
+                    loader=FileSystemLoader("templates/C/union/"),
+                    trim_blocks=True,
+                    lstrip_blocks=True,
+                )
+            case _:
+                raise NotImplementedError("Language not supported")
+
+    def emit_declaration(self, ast_node):
+        """Emit one declaration for an XDR union"""
+        emit_union_declaration(self.environment, ast_node)
+
+    def emit_decoder(self, ast_node):
+        """Emit one decoder function for an XDR union"""
+        emit_union_decoder(self.environment, ast_node)
+
+    def emit_encoder(self, ast_node):
+        """Emit one encoder function for an XDR union"""
+        emit_union_encoder(self.environment, ast_node)
diff --git a/tools/net/sunrpc/xdrgen/subcmds/__init__.py b/tools/net/sunrpc/xdrgen/subcmds/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/net/sunrpc/xdrgen/subcmds/header.py b/tools/net/sunrpc/xdrgen/subcmds/header.py
new file mode 100755
index 000000000000..a3f2bc475715
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/subcmds/header.py
@@ -0,0 +1,62 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Translate an XDR specification into executable C code that
+can be compiled for the Linux kernel."""
+
+import logging
+
+from lark import logger
+
+from generators import boilerplate, constant, enum
+from generators import program, typedef, struct, union
+from xdr_ast import transform_parse_tree, _RpcProgram, _XdrEnum
+from xdr_ast import _XdrConstant, _XdrTypedef, _XdrStruct, _XdrUnion
+from xdr_parse import xdr_parser
+
+logger.setLevel(logging.INFO)
+
+
+def generate_header(filename, ast, language):
+    """Generate and emit a header file"""
+
+    sg = boilerplate.SourceGenerator(language)
+    sg.emit_header_top(filename, ast)
+
+    for definition in ast.definitions:
+        if isinstance(definition.value, _XdrConstant):
+            sg = constant.SourceGenerator(language)
+        elif isinstance(definition.value, _XdrEnum):
+            sg = enum.SourceGenerator(language)
+        elif isinstance(definition.value, _XdrTypedef):
+            sg = typedef.SourceGenerator(language)
+        elif isinstance(definition.value, _XdrStruct):
+            sg = struct.SourceGenerator(language)
+        elif isinstance(definition.value, _XdrUnion):
+            sg = union.SourceGenerator(language)
+        elif isinstance(definition.value, _RpcProgram):
+            sg = program.SourceGenerator(language)
+        else:
+            continue
+        sg.emit_declaration(definition.value)
+
+    generator = boilerplate.SourceGenerator(language)
+    generator.emit_header_bottom(ast)
+
+
+def handle_parse_error(e):
+    """Simple parse error reporting, no recovery attempted"""
+    print(e)
+    return True
+
+
+def subcmd(args):
+    """Generate definitions and declarations"""
+
+    parser = xdr_parser()
+    with open(args.filename, encoding="utf-8") as f:
+        parse_tree = parser.parse(f.read(), on_error=handle_parse_error)
+        ast = transform_parse_tree(parse_tree)
+        generate_header(args.filename, ast, args.language)
+
+    return 0
diff --git a/tools/net/sunrpc/xdrgen/subcmds/lint.py b/tools/net/sunrpc/xdrgen/subcmds/lint.py
new file mode 100755
index 000000000000..d0ace248adb7
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/subcmds/lint.py
@@ -0,0 +1,28 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Translate an XDR specification into executable C code that
+can be compiled for the Linux kernel."""
+
+import logging
+
+from lark import logger
+from xdr_parse import xdr_parser
+
+logger.setLevel(logging.DEBUG)
+
+
+def handle_parse_error(e):
+    """Simple parse error reporting, no recovery attempted"""
+    print(e)
+    return True
+
+
+def subcmd(args):
+    """Lexical and syntax check of an XDR specification"""
+
+    parser = xdr_parser()
+    with open(args.filename, encoding="utf-8") as f:
+        parser.parse(f.read(), on_error=handle_parse_error)
+
+    return 0
diff --git a/tools/net/sunrpc/xdrgen/subcmds/source.py b/tools/net/sunrpc/xdrgen/subcmds/source.py
new file mode 100755
index 000000000000..b7d0bb4a692d
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/subcmds/source.py
@@ -0,0 +1,82 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Translate an XDR specification into executable C code that
+can be compiled for the Linux kernel."""
+
+import logging
+
+from lark import logger
+
+from generators import boilerplate, enum, program
+from generators import typedef, struct, union
+from xdr_ast import transform_parse_tree, _XdrEnum, _XdrTypedef
+from xdr_ast import _XdrStruct, _XdrUnion, _RpcProgram
+from xdr_parse import xdr_parser
+
+logger.setLevel(logging.INFO)
+
+
+def emit_source_decoder(ast_node, language):
+    """Emit one XDR decoder function for a source file"""
+    if isinstance(ast_node, _XdrEnum):
+        sg = enum.SourceGenerator(language)
+    elif isinstance(ast_node, _XdrTypedef):
+        sg = typedef.SourceGenerator(language)
+    elif isinstance(ast_node, _XdrStruct):
+        sg = struct.SourceGenerator(language)
+    elif isinstance(ast_node, _XdrUnion):
+        sg = union.SourceGenerator(language)
+    elif isinstance(ast_node, _RpcProgram):
+        sg = program.SourceGenerator(language)
+    else:
+        return
+    sg.emit_decoder(ast_node)
+
+
+def emit_source_encoder(ast_node, language):
+    """Emit one XDR encoder function for a source file"""
+    if isinstance(ast_node, _XdrEnum):
+        sg = enum.SourceGenerator(language)
+    elif isinstance(ast_node, _XdrTypedef):
+        sg = typedef.SourceGenerator(language)
+    elif isinstance(ast_node, _XdrStruct):
+        sg = struct.SourceGenerator(language)
+    elif isinstance(ast_node, _XdrUnion):
+        sg = union.SourceGenerator(language)
+    elif isinstance(ast_node, _RpcProgram):
+        sg = program.SourceGenerator(language)
+    else:
+        return
+    sg.emit_encoder(ast_node)
+
+
+def generate_source(filename, ast, language):
+    """Generate and emit a C source file"""
+
+    sg = boilerplate.SourceGenerator(language)
+    sg.emit_source_top(filename, ast)
+
+    for definition in ast.definitions:
+        emit_source_decoder(definition.value, language)
+
+    for definition in ast.definitions:
+        emit_source_encoder(definition.value, language)
+
+
+def handle_parse_error(e):
+    """Simple parse error reporting, no recovery attempted"""
+    print(e)
+    return True
+
+
+def subcmd(args):
+    """Generate encoder and decoder functions"""
+
+    parser = xdr_parser()
+    with open(args.filename, encoding="utf-8") as f:
+        parse_tree = parser.parse(f.read(), on_error=handle_parse_error)
+        ast = transform_parse_tree(parse_tree)
+        generate_source(args.filename, ast, args.language)
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/constants/declaration.j2 b/tools/net/sunrpc/xdrgen/templates/C/constants/declaration.j2
new file mode 100644
index 000000000000..40b7db7944d4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/constants/declaration.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+enum {
+	{{ name }} = {{ value }}
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2
new file mode 100644
index 000000000000..dd3e880d0fa2
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2
@@ -0,0 +1,7 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, enum {{ name }} value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enumerator.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enumerator.j2
new file mode 100644
index 000000000000..ff0b893b8b14
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enumerator.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	{{ name }} = {{ value }},
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/open.j2
new file mode 100644
index 000000000000..b25335221d48
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/open.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+enum {{ name }} {
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/basic.j2
new file mode 100644
index 000000000000..d3a5607d30da
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/basic.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (basic) */
+{% endif %}
+	{{ ctype }}{{ type }} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/close.j2
new file mode 100644
index 000000000000..f40098266f7f
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/close.j2
@@ -0,0 +1,7 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/fixed_length_array.j2
new file mode 100644
index 000000000000..66be836826a0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/fixed_length_array.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (fixed-length array) */
+{% endif %}
+	{{ type }} {{ name }}[{{ size }}];
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/fixed_length_opaque.j2
new file mode 100644
index 000000000000..0daba19aa0f0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/fixed_length_opaque.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (fixed-length opaque) */
+{% endif %}
+	u8 {{ name }}[{{ size }}];
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/open.j2
new file mode 100644
index 000000000000..07cbf5424546
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/open.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* struct {{ name }} */
+{% endif %}
+struct {{ name }} {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/optional_data.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/optional_data.j2
new file mode 100644
index 000000000000..7e52afbb1f3e
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/optional_data.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (optional data) */
+{% endif %}
+	{{ ctype }}{{ type }} *{{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/pointer-open.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/pointer-open.j2
new file mode 100644
index 000000000000..bc886b818d85
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/pointer-open.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* pointer {{ name }} */
+{% endif %}
+struct {{ name }} {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_array.j2
new file mode 100644
index 000000000000..aa3e62c2cd3c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_array.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (variable-length array) */
+{% endif %}
+	struct {
+		u32 count;
+		{{ ctype }}{{ type }} *element;
+	} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_opaque.j2
new file mode 100644
index 000000000000..4d0cd84be3db
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_opaque.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (variable-length opaque) */
+{% endif %}
+	opaque {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_string.j2
new file mode 100644
index 000000000000..2de2feec77db
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/declaration/variable_length_string.j2
@@ -0,0 +1,5 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* (variable-length string) */
+{% endif %}
+	string {{ name }};
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/pointer-open.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/pointer-open.j2
new file mode 100644
index 000000000000..c093d9e3c9ad
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/pointer-open.j2
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2
new file mode 100644
index 000000000000..e67cdc36809a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2
@@ -0,0 +1,10 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (basic) */
+{% endif %}
+{% if encode_needs_addressof %}
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
index 000000000000..f9d40953e5b5
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_array.j2
@@ -0,0 +1,12 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+	/* member {{ name }} (fixed-length array) */
+{% endif %}
+	for (u32 i = 0; i < {{ size }}; i++) {
+{% if encode_needs_addressof %}
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/pointer-open.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/pointer-open.j2
new file mode 100644
index 000000000000..d67fae200261
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/pointer-open.j2
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2
new file mode 100644
index 000000000000..880097d8ee5e
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
+{% if encode_needs_addressof %}
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/basic.j2
new file mode 100644
index 000000000000..a74e3b2a6102
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/basic.j2
@@ -0,0 +1,11 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* typedef {{ name }} (basic) */
+{% endif %}
+typedef {{ ctype }}{{ type }} {{ name }};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ name }} value);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_array.j2
new file mode 100644
index 000000000000..2ab394f3b1bc
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_array.j2
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_opaque.j2
new file mode 100644
index 000000000000..b81773efdb54
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_opaque.j2
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_array.j2
new file mode 100644
index 000000000000..b6f67a4007ab
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_array.j2
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_opaque.j2
new file mode 100644
index 000000000000..badf2fec1e5d
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_opaque.j2
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_string.j2
new file mode 100644
index 000000000000..1f8b24c4137a
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_string.j2
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
new file mode 100644
index 000000000000..411644c7a289
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
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ ctype }}{{ name }} value)
+{
+{% if annotate %}
+	/* (basic) */
+{% endif %}
+{% if encode_needs_addressof %}
+	return xdrgen_encode_{{ type }}(xdr, &value);
+{% else %}
+	return xdrgen_encode_{{ type }}(xdr, value);
+{% endif %}
+};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
new file mode 100644
index 000000000000..ec6823b0c2b3
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
+{% elif encode_needs_deref %}
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
index 000000000000..f9230a32fd96
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
+{% if encode_needs_addressof %}
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/declaration/case_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/case_spec.j2
new file mode 100644
index 000000000000..6bfba6c53996
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/case_spec.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+		{{ ctype }}{{ type }} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2
new file mode 100644
index 000000000000..01d716d0099e
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2
@@ -0,0 +1,8 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	} u;
+};
+{%- if name in public_apis %}
+
+bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, struct {{ name }} *ptr);
+bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const struct {{ name }} *ptr);
+{%- endif -%}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/declaration/default_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/default_spec.j2
new file mode 100644
index 000000000000..6bfba6c53996
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/default_spec.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+		{{ ctype }}{{ type }} {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/declaration/open.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/open.j2
new file mode 100644
index 000000000000..20fcfd1fc4e5
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/open.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+
+{% if annotate %}
+/* union {{ name }} */
+{% endif %}
+struct {{ name }} {
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/declaration/switch_spec.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/switch_spec.j2
new file mode 100644
index 000000000000..53639b006b0c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/declaration/switch_spec.j2
@@ -0,0 +1,3 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+	{{ ctype }}{{ type }} {{ name }};
+	union {
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
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2
new file mode 100644
index 000000000000..29a440265824
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2
@@ -0,0 +1,10 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+		/* member {{ name }} (basic) */
+{% endif %}
+{% if encode_needs_addressof %}
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
diff --git a/tools/net/sunrpc/xdrgen/xdr b/tools/net/sunrpc/xdrgen/xdr
new file mode 120000
index 000000000000..95c127ec85a6
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/xdr
@@ -0,0 +1 @@
+../../../../Documentation/sunrpc/xdr
\ No newline at end of file
diff --git a/tools/net/sunrpc/xdrgen/xdr.ebnf b/tools/net/sunrpc/xdrgen/xdr.ebnf
new file mode 100644
index 000000000000..eedcca7e98b9
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/xdr.ebnf
@@ -0,0 +1,117 @@
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
+directive               : header_directive
+                        | pages_directive
+			| public_directive
+			| skip_directive
+
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
+COMMENT                 : "/*" /(.|\n)*?/ "*/"
+%ignore COMMENT
+
+PASSTHRU                : "%" | "%" /.+/
+%ignore PASSTHRU
+
+WS                      : /[ \t\f\r\n]/+
+%ignore WS
diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
new file mode 100644
index 000000000000..1592995cfda3
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -0,0 +1,437 @@
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
+header_name = "none"
+public_apis = []
+enums = set()
+structs = set()
+
+
+@dataclass
+class _Ast(ast_utils.Ast):
+    """Parent class for the XDR abstract syntax tree"""
+
+
+@dataclass
+class _XdrConstant(_Ast):
+    """Corresponds to 'constant_def' in the grammar"""
+
+    name: str
+    value: str
+
+
+@dataclass
+class _XdrEnumerator(_Ast):
+    """An 'identifier = value' enumerator"""
+
+    name: str
+    value: str
+
+
+@dataclass
+class _XdrEnum(_Ast):
+    """An XDR enum definition"""
+
+    name: str
+    minimum: int
+    maximum: int
+    enumerators: List[_XdrEnumerator]
+
+
+@dataclass
+class _TypeSpecifier(_Ast):
+    """Corresponds to 'type_specifier' in the grammar"""
+
+    type_name: str
+
+
+@dataclass
+class _DefinedType(_TypeSpecifier):
+    type_decorator: str
+    pass_by_reference: bool
+
+
+@dataclass
+class _BuiltInType(_TypeSpecifier):
+    display_name: str
+    type_decorator: str = ""
+    pass_by_reference: bool = False
+
+
+@dataclass
+class _Declaration(_Ast):
+    """Parent class of type declarations"""
+
+
+@dataclass
+class _FixedLengthOpaque(_Declaration):
+    """A fixed-length opaque declaration"""
+
+    name: str
+    size: str
+    template: str = "fixed_length_opaque"
+
+
+@dataclass
+class _VariableLengthOpaque(_Declaration):
+    """A variable-length opaque declaration"""
+
+    name: str
+    maxsize: str
+    template: str = "variable_length_opaque"
+
+
+@dataclass
+class _VariableLengthString(_Declaration):
+    """A variable-length string declaration"""
+
+    name: str
+    maxsize: str
+    template: str = "variable_length_string"
+
+
+@dataclass
+class _FixedLengthArray(_Declaration):
+    """A fixed-length array declaration"""
+
+    name: str
+    spec: _TypeSpecifier
+    size: str
+    template: str = "fixed_length_array"
+
+
+@dataclass
+class _VariableLengthArray(_Declaration):
+    """A variable-length array declaration"""
+
+    name: str
+    spec: _TypeSpecifier
+    maxsize: str
+    template: str = "variable_length_array"
+
+
+@dataclass
+class _XdrOptionalData(_Declaration):
+    """An 'optional_data' declaration"""
+
+    name: str
+    spec: _TypeSpecifier
+    template: str = "optional_data"
+
+
+@dataclass
+class _BasicDeclaration(_Declaration):
+    """A 'basic' declaration"""
+
+    name: str
+    spec: _TypeSpecifier
+    template: str = "basic"
+
+
+@dataclass
+class _XdrVoid(_Declaration):
+    """A void declaration"""
+
+
+@dataclass
+class _XdrStruct(_Ast):
+    """An XDR struct definition"""
+
+    name: str
+    fields: List[_Declaration]
+
+
+@dataclass
+class _XdrTypedef(_Ast):
+    """An XDR typedef"""
+
+    declaration: _Declaration
+
+
+@dataclass
+class _CaseSpec(_Ast):
+    """One case in an XDR union"""
+
+    values: List[str]
+    arm: _Declaration
+    template: str = "case_spec"
+
+
+@dataclass
+class _DefaultSpec(_Ast):
+    """Default case in an XDR union"""
+
+    arm: _Declaration
+    template: str = "default_spec"
+
+
+@dataclass
+class _XdrUnion(_Ast):
+    """An XDR union"""
+
+    name: str
+    discriminant: _Declaration
+    cases: List[_CaseSpec]
+    default: _Declaration
+
+
+@dataclass
+class _RpcProcedure(_Ast):
+    """RPC procedure definition"""
+
+    name: str
+    number: str
+    argument: _TypeSpecifier
+    result: _TypeSpecifier
+
+
+@dataclass
+class _RpcVersion(_Ast):
+    """RPC version definition"""
+
+    name: str
+    number: str
+    procedures: List[_RpcProcedure]
+
+
+@dataclass
+class _RpcProgram(_Ast):
+    """RPC program definition"""
+
+    name: str
+    number: str
+    versions: List[_RpcVersion]
+
+
+@dataclass
+class _Pragma(_Ast):
+    """Empty class for pragma directives"""
+
+
+@dataclass
+class Definition(_Ast, ast_utils.WithMeta):
+    """Corresponds to 'definition' in the grammar"""
+
+    meta: Meta
+    value: object
+
+
+@dataclass
+class Specification(_Ast, ast_utils.AsList):
+    """Corresponds to 'specification' in the grammar"""
+
+    definitions: List[Definition]
+
+
+class ParseToAst(Transformer):
+    """Functions that transform productions into AST nodes"""
+
+    def constant_def(self, children):
+        """Instantiate one _XdrConstant object"""
+        name = children[0].children[0].value
+        value = children[1].children[0].children[0].value
+        return _XdrConstant(name, value)
+
+    # cel: Python can compute a min() and max() for the enumerator values
+    #      so that the generated code can perform proper range checking.
+    def enum(self, children):
+        """Instantiate one _XdrEnum object"""
+        enum_name = children[0].children[0].value
+        enums.add(enum_name)
+
+        i = 0
+        enumerators = []
+        body = children[1]
+        while i < len(body.children):
+            name = body.children[i].children[0].value
+            value = body.children[i + 1].children[0].children[0].value
+            enumerators.append(_XdrEnumerator(name, value))
+            i = i + 2
+
+        return _XdrEnum(enum_name, 0, 0, enumerators)
+
+    def type_specifier(self, children):
+        """Instantiate one type_specifier object"""
+        if children[0].data == "identifier":
+            name = children[0].children[0].value
+            decorator = ""
+            pbr = False
+            if name in enums:
+                decorator = "enum "
+            if name in structs:
+                decorator = "struct "
+                pbr = True
+            return _DefinedType(name, decorator, pbr)
+
+        token = children[0].data
+        return _BuiltInType(
+            type_name=token.value, display_name=token.value.replace("_", " ")
+        )
+
+    def fixed_length_opaque(self, children):
+        """Instantiate one _FixedLengthOpaque declaration object"""
+        name = children[0].children[0].value
+        size = children[1].children[0].children[0].value
+
+        return _FixedLengthOpaque(name, size)
+
+    def variable_length_opaque(self, children):
+        """Instantiate one _VariableLengthOpaque declaration object"""
+        name = children[0].children[0].value
+        if children[1] is not None:
+            maxsize = children[1].children[0].children[0].value
+        else:
+            maxsize = 0
+
+        return _VariableLengthOpaque(name, maxsize)
+
+    def variable_length_string(self, children):
+        """Instantiate one _VariableLengthString declaration object"""
+        name = children[0].children[0].value
+        if children[1] is not None:
+            maxsize = children[1].children[0].children[0].value
+        else:
+            maxsize = 0
+
+        return _VariableLengthString(name, maxsize)
+
+    def fixed_length_array(self, children):
+        """Instantiate one _FixedLengthArray declaration object"""
+        spec = children[0]
+        name = children[1].children[0].value
+        size = children[2].children[0].children[0].value
+
+        return _FixedLengthArray(name, spec, size)
+
+    def variable_length_array(self, children):
+        """Instantiate one _VariableLengthArray declaration object"""
+        spec = children[0]
+        name = children[1].children[0].value
+        if children[2] is not None:
+            maxsize = children[2].children[0].children[0].value
+        else:
+            maxsize = 0
+
+        return _VariableLengthArray(name, spec, maxsize)
+
+    def optional_data(self, children):
+        """Instantiate one _XdrOptionalData declaration object"""
+        spec = children[0]
+        name = children[1].children[0].value
+        structs.add(name)
+
+        return _XdrOptionalData(name, spec)
+
+    def basic(self, children):
+        """Instantiate one _BasicDeclaration object"""
+        spec = children[0]
+        name = children[1].children[0].value
+
+        return _BasicDeclaration(name, spec)
+
+    def void(self, children):
+        """Instantiate one _XdrVoid declaration object"""
+        return _XdrVoid()
+
+    def struct(self, children):
+        """Instantiate one _XdrStruct object"""
+        name = children[0].children[0].value
+        structs.add(name)
+        fields = children[1].children
+
+        return _XdrStruct(name, fields)
+
+    def typedef(self, children):
+        """Instantiate one _XdrTypedef object"""
+
+        return _XdrTypedef(children[0])
+
+    def case_spec(self, children):
+        """Instantiate one _CaseSpec object"""
+        values = []
+        for item in children[0:-1]:
+            value = item.children[0].children[0].value
+            values.append(value)
+        arm = children[-1]
+
+        return _CaseSpec(values, arm)
+
+    def default_spec(self, children):
+        """Instantiate one _DefaultSpec object"""
+        arm = children[0]
+
+        return _DefaultSpec(arm)
+
+    def union(self, children):
+        """Instantiate one _XdrUnion object"""
+        name = children[0].children[0].value
+        structs.add(name)
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
+        name = children[1].children[0].value
+        argument = children[2]
+        number = children[3].children[0].children[0].value
+
+        return _RpcProcedure(name, number, argument, result)
+
+    def version_def(self, children):
+        """Instantiate one _RpcVersion object"""
+        name = children[0].children[0].value
+        number = children[-1].children[0].children[0].value
+        procedures = children[1:-1]
+
+        return _RpcVersion(name, number, procedures)
+
+    def program_def(self, children):
+        """Instantiate one _RpcProgram object"""
+        name = children[0].children[0].value
+        number = children[-1].children[0].children[0].value
+        versions = children[1:-1]
+
+        return _RpcProgram(name, number, versions)
+
+    def pragma_def(self, children):
+        """Instantiate one _Pragma object"""
+        directive = children[0].children[0].data
+        match directive:
+            case "public_directive":
+                public_apis.append(children[1].children[0].value)
+            case "header_directive":
+                global header_name
+                header_name = children[1].children[0].value
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
+def get_header_name():
+    """Return header name set by pragma header directive"""
+    return header_name
diff --git a/tools/net/sunrpc/xdrgen/xdr_parse.py b/tools/net/sunrpc/xdrgen/xdr_parse.py
new file mode 100644
index 000000000000..0631aa6f5c8c
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/xdr_parse.py
@@ -0,0 +1,20 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Common parsing code for xdrgen"""
+
+from lark import Lark, Discard
+
+
+def xdr_parser():
+    """Return a Lark parser instance configured with the XDR language grammar"""
+
+    return Lark.open(
+        "xdr.ebnf",
+        start="specification",
+        debug=True,
+        strict=True,
+        propagate_positions=True,
+        parser="lalr",
+        lexer="contextual",
+    )
diff --git a/tools/net/sunrpc/xdrgen/xdrgen b/tools/net/sunrpc/xdrgen/xdrgen
new file mode 100755
index 000000000000..6c44a2823abe
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/xdrgen
@@ -0,0 +1,95 @@
+#!/usr/bin/env python3
+# ex: set filetype=python:
+
+"""Translate an XDR specification into executable C code that
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
+from common import set_xdr_annotate
+
+
+sys.path.insert(1, "@pythondir@")
+
+
+def main():
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
+    linter = subcommands.add_parser("lint", help="Check an XDR specification")
+    linter.add_argument("filename", help="File containing an XDR specification")
+    linter.set_defaults(func=lint.subcmd)
+
+    source_output = subcommands.add_parser(
+        "source", help="Generate XDR encoder and decoder source code"
+    )
+    source_output.add_argument(
+        "--annotate",
+        action="store_true",
+        default=False,
+        help="Add annotation comments",
+    )
+    source_output.add_argument(
+        "--language",
+        action="store_true",
+        default="C",
+        help="Output language",
+    )
+    source_output.add_argument("filename", help="File containing an XDR specification")
+    source_output.set_defaults(func=source.subcmd)
+
+    header_output = subcommands.add_parser(
+        "header", help="Generate XDR definitions and declarations"
+    )
+    header_output.add_argument(
+        "--annotate",
+        action="store_true",
+        default=False,
+        help="Add annotation comments",
+    )
+    header_output.add_argument(
+        "--language",
+        action="store_true",
+        default="C",
+        help="Output language",
+    )
+    header_output.add_argument("filename", help="File containing an XDR specification")
+    header_output.set_defaults(func=header.subcmd)
+
+    args = parser.parse_args()
+    set_xdr_annotate(args.annotate)
+    return args.func(args)
+
+
+try:
+    if __name__ == "__main__":
+        sys.exit(main())
+except (SystemExit, KeyboardInterrupt, RuntimeError):
+    sys.exit(1)
-- 
2.45.1


