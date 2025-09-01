Return-Path: <linux-nfs+bounces-13964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981B2B3E2AB
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 14:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C6F189BB04
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 12:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E530E831;
	Mon,  1 Sep 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6jEwB3g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336930F81F
	for <linux-nfs@vger.kernel.org>; Mon,  1 Sep 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729530; cv=none; b=VEvJyArLvQreEO2E0C2/O4Dyx1yJRiiARQf2mKzydtHWCqh+kviALncnhOyJNHVpdMoVUsoIq7f96M9qLHS2urnf5y/tBtTJbsVTCnWZXrC5rV7cIOTfrHLehs90lg/xnmUeloPG/ZdUji/tjO5wxU93Ua9W4yrQxKC2Kr5yZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729530; c=relaxed/simple;
	bh=ut6dLzV0s23NVocktYN8sYlOrmEc8JbGnLMFodGEF5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtQWqcVOaH4IhnddAAfoHBKvl3oe6gkggkAkvEVtqDL5ELKSdIIVC1XUPoB0uRYjo0220sE0HgHpXEBLHpuPQ5sC2TxnU573jwayc8tsBZd403oW3wXymiVNKMEiCKgD6aXQ8kqATiTmoiSrWLU2VjToyRLxTE34IVXW8ymPw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6jEwB3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E599C4CEF0;
	Mon,  1 Sep 2025 12:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756729530;
	bh=ut6dLzV0s23NVocktYN8sYlOrmEc8JbGnLMFodGEF5k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=k6jEwB3gnPx8HDtYmLtA+IDKf+WmNTEMSJ/jOJmZrpR/QHqwyDCFphz+Y4twYRFwd
	 SWIp5ut472cMpEmZsm8Jgd9Ut1Yr9Myi/zP+3Cf0iC9a/CCoSndCEk24mnaMOBv7/Q
	 gne9M+0aIMVc10Xlnc2rWgiRdtHVrAYZxpwKAOff7SCAH12RvWyqR+6Px8SeNfnajJ
	 HDh+ri2ba/v95V9Ii0Tt1Z3hEMXCAb6zpGZbx/0Mi8clur0zlpWTEcE9AACel+yyv3
	 hsshgfiQYaCP22TA/1wo2o+vYh8qlsn5K+eaBxhDLhqvdvL++g/ga06bXLpBVn5XnJ
	 vmfeloN+KCyfg==
Message-ID: <71fa0055f1ddd5a7f8606515579889e85390d8e9.camel@kernel.org>
Subject: Re: Question about potential buffer issue in nfs_request_mount() -
 seeking feedback
From: Jeff Layton <jlayton@kernel.org>
To: SSH <originalssh@pm.me>, "linux-nfs@vger.kernel.org"
	 <linux-nfs@vger.kernel.org>
Cc: Kees Cook <kees@kernel.org>
Date: Mon, 01 Sep 2025 08:25:29 -0400
In-Reply-To: <TX-1G5eig2RBJI5kkHe2QNzRk-LQ8QOTpV3o5FQNV1Iaz2Rr-zCE69gCBA-ah22pNehg97Q-KRjiimwwrZHfgyqXg1jPYty3FoQS5Rmfkn8=@pm.me>
References: 
	<TX-1G5eig2RBJI5kkHe2QNzRk-LQ8QOTpV3o5FQNV1Iaz2Rr-zCE69gCBA-ah22pNehg97Q-KRjiimwwrZHfgyqXg1jPYty3FoQS5Rmfkn8=@pm.me>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-01 at 01:38 +0000, SSH wrote:
> Hi NFS maintainers,
>=20
> I was looking at a kernel warning from 6.1-rc1 to understand it better an=
d tried to trace through the code to understand what was happening. I think=
 I may have found something, although now the most up-to-date kernel HEAD i=
s August, 2025 and most of all, I'm not a kernel developer so I wanted to a=
sk for your feedback on whether my analysis makes sense.
>=20
> ## Context
> * This was on all NFS v3 TCP mounts
> * The warning came from kernel's hardened memcpy detection
> * The mount seemed to work despite the warning
>=20
> ### Additional Context
> I noticed this warning was originally reported around 6.1-rc1 timeframe (=
~2022), but checking the current kernel source, it would appear that the sa=
me code pattern exists.
> I'm not sure if this was previously reported to the NFS maintainers speci=
fically, or if there's a reason it wasn't addressed. Either way, I thought =
it was worth bringing up again in case it got missed or deprioritized.
>=20
> Source: https://lkml.org/lkml/2022/10/16/461
>=20
> ## The Original Warning
> I saw this warning during NFS v3 TCP mount:
>=20
> ```
> [ =C2=A0 19.617475] memcpy: detected field-spanning write (size 28) of si=
ngle field "request.sap" at fs/nfs/super.c:857 (size 18446744073709551615)
> [ =C2=A0 19.617504] WARNING: CPU: 3 PID: 1300 at fs/nfs/super.c:857 nfs_r=
equest_mount.constprop.0.isra.0+0x1c0/0x1f0
> ```
>=20
> ## Likely Source of Failure
>=20
> Looking at `nfs_request_mount()` in `fs/nfs/super.c`, I see this code:
>=20
> ```c
> // Around line 850
> struct nfs_mount_request request =3D {
> =C2=A0 =C2=A0 .sap =3D &ctx->mount_server._address,
> =C2=A0 =C2=A0 // ... other fields
> };
>=20
> // Later, around line 881
> if (ctx->mount_server.address.sa_family =3D=3D AF_UNSPEC) {
> =C2=A0 =C2=A0 memcpy(request.sap, &ctx->nfs_server._address, ctx->nfs_ser=
ver.addrlen);
> =C2=A0 =C2=A0 ctx->mount_server.addrlen =3D ctx->nfs_server.addrlen;
> }
> ```
>=20
> My understanding is:
> 1. `request.sap` points to `ctx->mount_server._address`
> 2. We're copying from `ctx->nfs_server._address` (which could be 28 bytes=
 for IPv6)
> 3. Into whatever `mount_server._address` points to (which might be smalle=
r?)
>=20
> The weird size value (18446744073709551615) in the warning makes me think=
 there might be memory corruption happening.
>=20
> Does this seem like a real issue? If so, would adding a size check before=
 the memcpy make sense, something like:
>=20
> ```c
> if (ctx->mount_server.address.sa_family =3D=3D AF_UNSPEC) {
> =C2=A0 =C2=A0 if (ctx->nfs_server.addrlen <=3D sizeof(ctx->mount_server._=
address)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(request.sap, &ctx->nfs_server._address=
, ctx->nfs_server.addrlen);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx->mount_server.addrlen =3D ctx->nfs_server=
.addrlen;
> =C2=A0 =C2=A0 } else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 // handle error case; maybe -EINVAL?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> =C2=A0 =C2=A0 }
> }
> ```
>=20
> I could easily be misunderstanding something fundamental here, so please =
let me know if I'm off track. I just wanted to share this in case it's help=
ful.
>=20
> Thanks for your time and for maintaining NFS!
>=20

(cc'ing Kees, our resident hardening expert)

FYI, that large size field is 0xffffffffffffffff (a 64-bit integer with
all bits set to 1). The doc header over __fortify_memcpy_chk()
definition is a little helpful, but the commit it refers to
(6f7630b1b5bc) has a bit more info.

It looks like that means that the size detection was broken for this
memcpy check? That commit mentions that this may be due to a GCC bug.

Kees, any thoughts?
--=20
Jeff Layton <jlayton@kernel.org>

