Return-Path: <linux-nfs+bounces-13968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD101B3EE60
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 21:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D511B2117B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD661FFE;
	Mon,  1 Sep 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwIBjj1f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CD45C0B
	for <linux-nfs@vger.kernel.org>; Mon,  1 Sep 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756754290; cv=none; b=gHONAKaA0B0MEndbw52W98CmhYEOEcbqESq87GSYF77aq6VViRTaih4YBVuQTV8JG3l2sQ5YP/aPj6hPdFHHdnJ7VO3Whb27GcZ5trlKK2NeT1aGACPnKsiif31iRFppXMcPk8j43p9Rmeg76Me7Bx+qzPCc5YqZ79NoZ4rIMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756754290; c=relaxed/simple;
	bh=A14t6YvwuVGwqATOzHm61BgKI3n+b5f3n14mYbHgPwQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ueoiSTItcAualrbb4WG1l9m1ejqF9F329+Z+7TtWfPl4sBjE7SB5kqqP6G4zUsWrw5xvRspWL2dIsYdwQcbkHhvDO5baeM3S4L9nraDtYg2i+p/LOz0QthEpUdvcwe10ceYtuWdryZH3WHjTe420+ouG5yzecGQ1knH56Q+QJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwIBjj1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68935C4CEF0;
	Mon,  1 Sep 2025 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756754289;
	bh=A14t6YvwuVGwqATOzHm61BgKI3n+b5f3n14mYbHgPwQ=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=DwIBjj1fAbS2jQDm8nNN3K8/15SYCC7k+xXV/P/mx1YwdD930r0iPBE2DThbqcpqb
	 /IH3daFhR1cN2mr8WT8fst6A1q0uNpM3QCSzUFM8Pdl9XAusnyIEalxOhDx3qSR7FJ
	 8DIl5RZK7SaBDFqvUk3/vpe++GnXNelI/TA2Rn9XsZjCdKD1Pb9Pvu5vvsqvw7acBo
	 hKdCzlPdGAz1l5xkyZDARSQkTg5V+lY815BKYVBGa7U0K2rNCpOK7UGhXHVYOAzQ2k
	 7XdFjVrerRviDBrddYdp0aMs0lfYzcOH1k5fogVUqbhCnH5QrhxywH0og7p9PUotCm
	 ljCuHNQ0JqRvA==
Date: Mon, 01 Sep 2025 12:18:09 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, SSH <originalssh@pm.me>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_Question_about_potential_buffer_issue?=
 =?US-ASCII?Q?_in_nfs=5Frequest=5Fmount=28=29_-_seeking_feedback?=
User-Agent: K-9 Mail for Android
In-Reply-To: <71fa0055f1ddd5a7f8606515579889e85390d8e9.camel@kernel.org>
References: <TX-1G5eig2RBJI5kkHe2QNzRk-LQ8QOTpV3o5FQNV1Iaz2Rr-zCE69gCBA-ah22pNehg97Q-KRjiimwwrZHfgyqXg1jPYty3FoQS5Rmfkn8=@pm.me> <71fa0055f1ddd5a7f8606515579889e85390d8e9.camel@kernel.org>
Message-ID: <C584CAD4-B954-42C5-89DF-F3033998BEE7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 1, 2025 5:25:29 AM PDT, Jeff Layton <jlayton@kernel=2Eorg> wr=
ote:
>On Mon, 2025-09-01 at 01:38 +0000, SSH wrote:
>> Hi NFS maintainers,
>>=20
>> I was looking at a kernel warning from 6=2E1-rc1 to understand it bette=
r and tried to trace through the code to understand what was happening=2E I=
 think I may have found something, although now the most up-to-date kernel =
HEAD is August, 2025 and most of all, I'm not a kernel developer so I wante=
d to ask for your feedback on whether my analysis makes sense=2E
>>=20
>> ## Context
>> * This was on all NFS v3 TCP mounts
>> * The warning came from kernel's hardened memcpy detection
>> * The mount seemed to work despite the warning
>>=20
>> ### Additional Context
>> I noticed this warning was originally reported around 6=2E1-rc1 timefra=
me (~2022), but checking the current kernel source, it would appear that th=
e same code pattern exists=2E
>> I'm not sure if this was previously reported to the NFS maintainers spe=
cifically, or if there's a reason it wasn't addressed=2E Either way, I thou=
ght it was worth bringing up again in case it got missed or deprioritized=
=2E
>>=20
>> Source: https://lkml=2Eorg/lkml/2022/10/16/461
>>=20
>> ## The Original Warning
>> I saw this warning during NFS v3 TCP mount:
>>=20
>> ```
>> [ =C2=A0 19=2E617475] memcpy: detected field-spanning write (size 28) o=
f single field "request=2Esap" at fs/nfs/super=2Ec:857 (size 18446744073709=
551615)
>> [ =C2=A0 19=2E617504] WARNING: CPU: 3 PID: 1300 at fs/nfs/super=2Ec:857=
 nfs_request_mount=2Econstprop=2E0=2Eisra=2E0+0x1c0/0x1f0
>> ```
>>=20
>> ## Likely Source of Failure
>>=20
>> Looking at `nfs_request_mount()` in `fs/nfs/super=2Ec`, I see this code=
:
>>=20
>> ```c
>> // Around line 850
>> struct nfs_mount_request request =3D {
>> =C2=A0 =C2=A0 =2Esap =3D &ctx->mount_server=2E_address,
>> =C2=A0 =C2=A0 // =2E=2E=2E other fields
>> };
>>=20
>> // Later, around line 881
>> if (ctx->mount_server=2Eaddress=2Esa_family =3D=3D AF_UNSPEC) {
>> =C2=A0 =C2=A0 memcpy(request=2Esap, &ctx->nfs_server=2E_address, ctx->n=
fs_server=2Eaddrlen);
>> =C2=A0 =C2=A0 ctx->mount_server=2Eaddrlen =3D ctx->nfs_server=2Eaddrlen=
;
>> }
>> ```
>>=20
>> My understanding is:
>> 1=2E `request=2Esap` points to `ctx->mount_server=2E_address`
>> 2=2E We're copying from `ctx->nfs_server=2E_address` (which could be 28=
 bytes for IPv6)
>> 3=2E Into whatever `mount_server=2E_address` points to (which might be =
smaller?)
>>=20
>> The weird size value (18446744073709551615) in the warning makes me thi=
nk there might be memory corruption happening=2E
>>=20
>> Does this seem like a real issue? If so, would adding a size check befo=
re the memcpy make sense, something like:
>>=20
>> ```c
>> if (ctx->mount_server=2Eaddress=2Esa_family =3D=3D AF_UNSPEC) {
>> =C2=A0 =C2=A0 if (ctx->nfs_server=2Eaddrlen <=3D sizeof(ctx->mount_serv=
er=2E_address)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(request=2Esap, &ctx->nfs_server=2E_a=
ddress, ctx->nfs_server=2Eaddrlen);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx->mount_server=2Eaddrlen =3D ctx->nfs_se=
rver=2Eaddrlen;
>> =C2=A0 =C2=A0 } else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 // handle error case; maybe -EINVAL?
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> =C2=A0 =C2=A0 }
>> }
>> ```
>>=20
>> I could easily be misunderstanding something fundamental here, so pleas=
e let me know if I'm off track=2E I just wanted to share this in case it's =
helpful=2E
>>=20
>> Thanks for your time and for maintaining NFS!
>>=20
>
>(cc'ing Kees, our resident hardening expert)
>
>FYI, that large size field is 0xffffffffffffffff (a 64-bit integer with
>all bits set to 1)=2E The doc header over __fortify_memcpy_chk()
>definition is a little helpful, but the commit it refers to
>(6f7630b1b5bc) has a bit more info=2E
>
>It looks like that means that the size detection was broken for this
>memcpy check? That commit mentions that this may be due to a GCC bug=2E
>
>Kees, any thoughts?

Yup, the referenced commit in the comment is specifically fixing the above=
 report (v6=2E1-rc1)

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/c=
ommit/include/linux/fortify-string=2Eh?id=3D6f7630b1b5bc672b54c1285ee6aba75=
2b446672c


--=20
Kees Cook

