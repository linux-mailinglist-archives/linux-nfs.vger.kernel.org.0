Return-Path: <linux-nfs+bounces-5497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A4959F3F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83D528354A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E421AF4DB;
	Wed, 21 Aug 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/p9eLs7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D81AF4D3
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249040; cv=none; b=nL2gFub9E9nK8N3fnTMBRmCJUF/Gkz51c0U4P4Tw6DAhq8igD/mPDi3PAEj3upbjTMWI++xD79Wxbj1eoY3lJ79sFaGG4PKFgSLkIP3CpopyNSWxUeKeb48+j396uXCnWVU9gfx9WwgcojW5LcnYxMFqbG9aFIKFHOZ0Wqy13GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249040; c=relaxed/simple;
	bh=R+3pIhR13i1yDh9yPzgqkj35njiq9b+Q4Il2p58JpVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzFJi7PXD02sgYjjQ+eRuBdic8QArAm6LyUET29LaFmrLDfj6t19gNENbV5ViBjsKg1yCfJ5fx4QAiYXqynG2QHlypNnzepIwZ9U1iaAPqcBURD9hKcz4XRW0SZnRjPjn9Zk2cM5HUcOLqc/qzQK79w4Y0TNfsKPjCsVvsU6vd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/p9eLs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5035C32781;
	Wed, 21 Aug 2024 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724249040;
	bh=R+3pIhR13i1yDh9yPzgqkj35njiq9b+Q4Il2p58JpVA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=H/p9eLs7qEzvCh27I1fyTS990iPzlvqWFUoSJW7s5iE7LWx0WDQEfUz19hm+NofPx
	 p6VYuyud02IS4nWJeBoINLUBj3drRc/CQheItwbNWMyk1jCLEXkgY77MLCGGG7UBOB
	 r7kO5mahyEgDjy3wYtYCT+9ZgZ+Lz70slBUlSlvZfSBZg7YMEKaxW9JxrOz1Z2oxSO
	 yWTTIiFkBxBHhHyP1sb3Jv7e6jBUGghPdWAx/MZti1e7ELbT+6gYPfGigGquOqoS8E
	 Lbb6Vwt8RecrYE+KSFPgCe4llnh1vxo0OUYWgmCywgz8MTR2Rj4/VQUtz/+zQp6Scv
	 YpX0m4xHGda1A==
Message-ID: <d78c9d50dcdefb13c96f1fac6f708781aad0bfe3.camel@kernel.org>
Subject: Re: [RFC PATCH 0/2] xdrgen - machine-generated XDR functions
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
Date: Wed, 21 Aug 2024 10:03:58 -0400
In-Reply-To: <20240820144600.189744-1-cel@kernel.org>
References: <20240820144600.189744-1-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-20 at 10:45 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> For a description of this work-in-progress, see the new README file.
> For unfinished work items, ditto.
>=20
> The first patch adds the tool.
>=20
> The second patch is an nfs4_1.x file that I created to confirm that
> the tool indeed works for Jeff's purposes. Actual generated header
> and source are in fs/nfsd/nfs4xdr_gen.? .
>=20
> Feel free to ignore 2/2. It is included here only to demonstrate the
> tool's new "pragma" directives that I think can avoid the need to
> hand-edit generated source, as discussed in an earlier thread. Grep
> the new README or nfs4_1.x for "pragma".
>=20
> These patches apply to v6.11-rc4, but can be rebased on nfsd-next if
> they are found merge-worthy. See also:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=3Dlk=
xdrgen
>=20
> For review, note that the numerous .j2 files are all tiny and can be
> skimmed in favor of the .py files, where the tool's logic is.
>=20
> All Python-related advice and guidance is gratefully accepted.
>=20
> --
>=20
> Chuck Lever (2):
>   tools: Add xdrgen
>   NFSD: Create an initial nfs4_1.x file
>=20
>  fs/nfsd/nfs4_1.x                              | 164 +++++++
>  fs/nfsd/nfs4xdr_gen.c                         | 236 ++++++++++
>  fs/nfsd/nfs4xdr_gen.h                         | 113 +++++
>  include/linux/sunrpc/xdrgen-builtins.h        | 253 ++++++++++
>  tools/net/sunrpc/xdrgen/.gitignore            |   2 +
>  tools/net/sunrpc/xdrgen/README                | 231 +++++++++
>  tools/net/sunrpc/xdrgen/__init__.py           |   0
>  tools/net/sunrpc/xdrgen/common.py             |  21 +
>  .../net/sunrpc/xdrgen/generators/__init__.py  |   0
>  .../sunrpc/xdrgen/generators/boilerplate.py   |  66 +++
>  .../net/sunrpc/xdrgen/generators/constant.py  |  38 ++
>  tools/net/sunrpc/xdrgen/generators/enum.py    |  67 +++
>  tools/net/sunrpc/xdrgen/generators/program.py |  96 ++++
>  tools/net/sunrpc/xdrgen/generators/struct.py  | 435 +++++++++++++++++
>  tools/net/sunrpc/xdrgen/generators/typedef.py | 282 +++++++++++
>  tools/net/sunrpc/xdrgen/generators/union.py   | 297 ++++++++++++
>  tools/net/sunrpc/xdrgen/subcmds/__init__.py   |   0
>  tools/net/sunrpc/xdrgen/subcmds/header.py     |  62 +++
>  tools/net/sunrpc/xdrgen/subcmds/lint.py       |  28 ++
>  tools/net/sunrpc/xdrgen/subcmds/source.py     |  82 ++++
>  .../templates/C/boilerplate/header_bottom.j2  |   3 +
>  .../templates/C/boilerplate/header_top.j2     |  11 +
>  .../templates/C/boilerplate/source_top.j2     |   5 +
>  .../templates/C/constants/declaration.j2      |   5 +
>  .../templates/C/enum/declaration/close.j2     |   7 +
>  .../C/enum/declaration/enumerator.j2          |   2 +
>  .../templates/C/enum/declaration/open.j2      |   3 +
>  .../xdrgen/templates/C/enum/decoder/enum.j2   |  19 +
>  .../xdrgen/templates/C/enum/encoder/enum.j2   |  14 +
>  .../C/program/declaration/argument.j2         |   2 +
>  .../templates/C/program/declaration/result.j2 |   2 +
>  .../templates/C/program/decoder/argument.j2   |  21 +
>  .../templates/C/program/encoder/result.j2     |  21 +
>  .../templates/C/struct/declaration/basic.j2   |   5 +
>  .../templates/C/struct/declaration/close.j2   |   7 +
>  .../struct/declaration/fixed_length_array.j2  |   5 +
>  .../struct/declaration/fixed_length_opaque.j2 |   5 +
>  .../templates/C/struct/declaration/open.j2    |   6 +
>  .../C/struct/declaration/optional_data.j2     |   5 +
>  .../C/struct/declaration/pointer-open.j2      |   6 +
>  .../declaration/variable_length_array.j2      |   8 +
>  .../declaration/variable_length_opaque.j2     |   5 +
>  .../declaration/variable_length_string.j2     |   5 +
>  .../templates/C/struct/decoder/basic.j2       |   6 +
>  .../templates/C/struct/decoder/close.j2       |   3 +
>  .../C/struct/decoder/fixed_length_array.j2    |   8 +
>  .../C/struct/decoder/fixed_length_opaque.j2   |   6 +
>  .../xdrgen/templates/C/struct/decoder/open.j2 |  12 +
>  .../C/struct/decoder/optional_data.j2         |   6 +
>  .../C/struct/decoder/pointer-open.j2          |  22 +
>  .../C/struct/decoder/variable_length_array.j2 |  13 +
>  .../struct/decoder/variable_length_opaque.j2  |   6 +
>  .../struct/decoder/variable_length_string.j2  |   6 +
>  .../templates/C/struct/encoder/basic.j2       |  10 +
>  .../templates/C/struct/encoder/close.j2       |   3 +
>  .../C/struct/encoder/fixed_length_array.j2    |  12 +
>  .../C/struct/encoder/fixed_length_opaque.j2   |   6 +
>  .../xdrgen/templates/C/struct/encoder/open.j2 |  12 +
>  .../C/struct/encoder/optional_data.j2         |   6 +
>  .../C/struct/encoder/pointer-open.j2          |  20 +
>  .../C/struct/encoder/variable_length_array.j2 |  15 +
>  .../struct/encoder/variable_length_opaque.j2  |   8 +
>  .../struct/encoder/variable_length_string.j2  |   8 +
>  .../templates/C/typedef/declaration/basic.j2  |  11 +
>  .../typedef/declaration/fixed_length_array.j2 |  11 +
>  .../declaration/fixed_length_opaque.j2        |  11 +
>  .../declaration/variable_length_array.j2      |  14 +
>  .../declaration/variable_length_opaque.j2     |  11 +
>  .../declaration/variable_length_string.j2     |  11 +
>  .../templates/C/typedef/decoder/basic.j2      |  17 +
>  .../C/typedef/decoder/fixed_length_array.j2   |  25 +
>  .../C/typedef/decoder/fixed_length_opaque.j2  |  17 +
>  .../typedef/decoder/variable_length_array.j2  |  26 ++
>  .../typedef/decoder/variable_length_opaque.j2 |  17 +
>  .../typedef/decoder/variable_length_string.j2 |  17 +
>  .../templates/C/typedef/encoder/basic.j2      |  21 +
>  .../C/typedef/encoder/fixed_length_array.j2   |  25 +
>  .../C/typedef/encoder/fixed_length_opaque.j2  |  17 +
>  .../typedef/encoder/variable_length_array.j2  |  30 ++
>  .../typedef/encoder/variable_length_opaque.j2 |  17 +
>  .../typedef/encoder/variable_length_string.j2 |  17 +
>  .../C/union/declaration/case_spec.j2          |   2 +
>  .../templates/C/union/declaration/close.j2    |   8 +
>  .../C/union/declaration/default_spec.j2       |   2 +
>  .../templates/C/union/declaration/open.j2     |   6 +
>  .../C/union/declaration/switch_spec.j2        |   3 +
>  .../xdrgen/templates/C/union/decoder/basic.j2 |   6 +
>  .../xdrgen/templates/C/union/decoder/break.j2 |   2 +
>  .../templates/C/union/decoder/case_spec.j2    |   2 +
>  .../xdrgen/templates/C/union/decoder/close.j2 |   4 +
>  .../templates/C/union/decoder/default_spec.j2 |   2 +
>  .../xdrgen/templates/C/union/decoder/open.j2  |  12 +
>  .../C/union/decoder/optional_data.j2          |   6 +
>  .../templates/C/union/decoder/switch_spec.j2  |   7 +
>  .../C/union/decoder/variable_length_array.j2  |  13 +
>  .../C/union/decoder/variable_length_opaque.j2 |   6 +
>  .../C/union/decoder/variable_length_string.j2 |   6 +
>  .../xdrgen/templates/C/union/decoder/void.j2  |   3 +
>  .../xdrgen/templates/C/union/encoder/basic.j2 |  10 +
>  .../xdrgen/templates/C/union/encoder/break.j2 |   2 +
>  .../templates/C/union/encoder/case_spec.j2    |   2 +
>  .../xdrgen/templates/C/union/encoder/close.j2 |   4 +
>  .../templates/C/union/encoder/default_spec.j2 |   2 +
>  .../xdrgen/templates/C/union/encoder/open.j2  |  12 +
>  .../templates/C/union/encoder/switch_spec.j2  |   7 +
>  .../xdrgen/templates/C/union/encoder/void.j2  |   3 +
>  tools/net/sunrpc/xdrgen/tests/test.x          |  36 ++
>  tools/net/sunrpc/xdrgen/xdr                   |   1 +
>  tools/net/sunrpc/xdrgen/xdr.ebnf              | 117 +++++
>  tools/net/sunrpc/xdrgen/xdr_ast.py            | 437 ++++++++++++++++++
>  tools/net/sunrpc/xdrgen/xdr_parse.py          |  20 +
>  tools/net/sunrpc/xdrgen/xdrgen                |  95 ++++
>  112 files changed, 3986 insertions(+)
>  create mode 100644 fs/nfsd/nfs4_1.x
>  create mode 100644 fs/nfsd/nfs4xdr_gen.c
>  create mode 100644 fs/nfsd/nfs4xdr_gen.h
>  create mode 100644 include/linux/sunrpc/xdrgen-builtins.h
>  create mode 100644 tools/net/sunrpc/xdrgen/.gitignore
>  create mode 100644 tools/net/sunrpc/xdrgen/README
>  create mode 100644 tools/net/sunrpc/xdrgen/__init__.py
>  create mode 100644 tools/net/sunrpc/xdrgen/common.py
>  create mode 100644 tools/net/sunrpc/xdrgen/generators/__init__.py
>  create mode 100644 tools/net/sunrpc/xdrgen/generators/boilerplate.py
>  create mode 100644 tools/net/sunrpc/xdrgen/generators/constant.py
>  create mode 100644 tools/net/sunrpc/xdrgen/generators/enum.py
>  create mode 100644 tools/net/sunrpc/xdrgen/generators/program.py
>  create mode 100644 tools/net/sunrpc/xdrgen/generators/struct.py
>  create mode 100644 tools/net/sunrpc/xdrgen/generators/typedef.py
>  create mode 100644 tools/net/sunrpc/xdrgen/generators/union.py
>  create mode 100644 tools/net/sunrpc/xdrgen/subcmds/__init__.py
>  create mode 100755 tools/net/sunrpc/xdrgen/subcmds/header.py
>  create mode 100755 tools/net/sunrpc/xdrgen/subcmds/lint.py
>  create mode 100755 tools/net/sunrpc/xdrgen/subcmds/source.py
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/heade=
r_bottom.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/heade=
r_top.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/sourc=
e_top.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/constants/declara=
tion.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/=
close.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/=
enumerator.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/=
open.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum=
.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum=
.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declarati=
on/argument.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declarati=
on/result.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/decoder/a=
rgument.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/encoder/r=
esult.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/basic.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/close.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/fixed_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/fixed_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/open.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/optional_data.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/pointer-open.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/variable_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/variable_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaratio=
n/variable_length_string.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/ba=
sic.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/cl=
ose.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fi=
xed_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fi=
xed_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/op=
en.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/op=
tional_data.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/po=
inter-open.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/va=
riable_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/va=
riable_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/va=
riable_length_string.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/ba=
sic.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/cl=
ose.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fi=
xed_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fi=
xed_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/op=
en.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/op=
tional_data.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/po=
inter-open.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/va=
riable_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/va=
riable_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/va=
riable_length_string.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declarati=
on/basic.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declarati=
on/fixed_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declarati=
on/fixed_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declarati=
on/variable_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declarati=
on/variable_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declarati=
on/variable_length_string.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/b=
asic.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/f=
ixed_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/f=
ixed_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/v=
ariable_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/v=
ariable_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/v=
ariable_length_string.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/b=
asic.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/f=
ixed_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/f=
ixed_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/v=
ariable_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/v=
ariable_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/v=
ariable_length_string.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration=
/case_spec.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration=
/close.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration=
/default_spec.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration=
/open.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration=
/switch_spec.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/bas=
ic.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/bre=
ak.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/cas=
e_spec.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/clo=
se.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/def=
ault_spec.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/ope=
n.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/opt=
ional_data.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/swi=
tch_spec.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/var=
iable_length_array.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/var=
iable_length_opaque.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/var=
iable_length_string.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/voi=
d.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/bas=
ic.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/bre=
ak.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/cas=
e_spec.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/clo=
se.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/def=
ault_spec.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/ope=
n.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/swi=
tch_spec.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/voi=
d.j2
>  create mode 100644 tools/net/sunrpc/xdrgen/tests/test.x
>  create mode 120000 tools/net/sunrpc/xdrgen/xdr
>  create mode 100644 tools/net/sunrpc/xdrgen/xdr.ebnf
>  create mode 100644 tools/net/sunrpc/xdrgen/xdr_ast.py
>  create mode 100644 tools/net/sunrpc/xdrgen/xdr_parse.py
>  create mode 100755 tools/net/sunrpc/xdrgen/xdrgen
>=20

This all looks great to me. I really support autogenerating our XDR
boilerplate, particularly as I've been looking at implementing
CB_NOTIFY (which would be quite tedious to roll by hand). This would
make it a lot simpler and less error prone.

Do you have these patches in a branch in your tree that I could pick
from?
--=20
Jeff Layton <jlayton@kernel.org>

