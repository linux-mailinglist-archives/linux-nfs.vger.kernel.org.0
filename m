Return-Path: <linux-nfs+bounces-16796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C8C94334
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 17:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 004AF4E128D
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4991EB5E1;
	Sat, 29 Nov 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvngJzck"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6741E5714
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764433010; cv=none; b=skVGngZifT9SgDWFA8GyX0lMQxPtwrQ9wCEExA6gjkea/VphQgGfkKkGqIcT1Zb4PMgdFN/vIwPlALHsrzk26OGKTHfWxnTEo8maDpu3c53Qt0giAS+/zisoUJJfXruYp4LstbVpFPT1i9agjY/TRwl5uuyu0yhJ3UuBF08zRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764433010; c=relaxed/simple;
	bh=jv6nffjdYGCTaQCh/Ojyhj+fUzH0FcV9ti+mfShA7F4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nJQDjQdyRP2qqe1rgwP21ZbWoAkbY+LnjvSypk32iRKb1ouT9TZofwsSEgaE/neN4Ur/VETy/O5/iiVldj5GQU+igQ9pYCREnkRD4ysycVqEyqaKyNPBtubduOjmKASPTTRWisLfOaqlKtrIv4c29pA8gNnWAj9hYlIlql3t1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvngJzck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55545C113D0
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764433007;
	bh=jv6nffjdYGCTaQCh/Ojyhj+fUzH0FcV9ti+mfShA7F4=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=dvngJzckzETs9jLybdS9v4McvDQ0TSHuPKuWegl5bcA/6MuWIgEI0nd6H7BSRyKAB
	 pwBitPNobtdzJyQGbx0lTbBfUsoBDpmlbmPGRSb2yMNLux9bhrYMszi5PA7EOrHIfK
	 NxhwGV6nnIPqBKFggcncIiaMT+Uzco8ZksQwHzo4XvoOO3syfINkzM/SY0jtRfa/QF
	 3ycycjaGuKUoL2phrpzhGtlUbEA2t2sTl5maJEuANvNU1XYphJcTuEz40X0QMUTc8H
	 Fe2kAaqO3Fn8TWRAj8H6swQ6BxZGkdL+DBSvIVeeo6/6rSMU1A8tgp/wYQjL+CZLeg
	 TJCQ6/eJyn+lA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5E1C7F4007C;
	Sat, 29 Nov 2025 11:16:46 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 29 Nov 2025 11:16:46 -0500
X-ME-Sender: <xms:bhwrabRABpwBWWN2TbEgmB_zegN-hnJBO9wwJr9EySXrdEMNQRcLsg>
    <xme:bhwraXkYSqbDw_53e0Qud6Pal4siozN7ruUgoMbetiKZUyGa8rsba2cg47P27UbDn
    Pxzt8-flC0Cdd56DCM842ynWmiyFXEkMIRM26IMd4a3VcDt4fSrNBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephefgvdetffdugfdvtdetieeiudffuefhleeuffdvgeduueehffffveejteeuhfdunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegruhhrvghlihgvnhdrtghouhguvghrtgdvtddtvdesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bhwrad888nZWAH_Hm6vmi1FXVLVHCf1PCmPN-A7bRry0YZhud1Rn9g>
    <xmx:bhwrafqNQu_To3L_8YOOJEgFZcGepNYlB7s9pZI5QbUbIQ-ZyNJ5Fg>
    <xmx:bhwraSmNI0Mn3vSS3mKcBb8ooiepkDTm4zUERseVxfdccQjyjNLVPA>
    <xmx:bhwraeLbWdS0GHBKsNmJKUyPl84U-wCbEHtt2yZnH58M6Z5vAhOoyg>
    <xmx:bhwrafxdvLFwbwFWRqE12iuDbfOHLJcXkW5MVT-Hru6EpQwdtU43GiP3>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2652A780054; Sat, 29 Nov 2025 11:16:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwX2CI0UG88J
Date: Sat, 29 Nov 2025 11:16:04 -0500
From: "Chuck Lever" <cel@kernel.org>
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>,
 linux-nfs@vger.kernel.org
Message-Id: <b7ec524c-91fa-4638-86f0-ab2e93029c2a@app.fastmail.com>
In-Reply-To: 
 <CA+1jF5qLyY0=oKmUMwH6-b8azfP1J7j4B3LeOcfc0kg-n9bOgw@mail.gmail.com>
References: <20251119005119.5147-1-cel@kernel.org>
 <CA+1jF5pTHTh1o1S92s1JVF4Lvx5XT7+tccu=woDSbDUPRsubXA@mail.gmail.com>
 <bde0d0ba-4e1d-420c-b8f5-71835ffcba16@app.fastmail.com>
 <CA+1jF5qLyY0=oKmUMwH6-b8azfP1J7j4B3LeOcfc0kg-n9bOgw@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, Nov 29, 2025, at 10:49 AM, Aur=C3=A9lien Couderc wrote:
> On Sat, Nov 29, 2025 at 4:40=E2=80=AFPM Chuck Lever <cel@kernel.org> w=
rote:
>>
>>
>>
>> On Sat, Nov 29, 2025, at 2:57 AM, Aur=C3=A9lien Couderc wrote:
>> > On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org=
> wrote:
>> >>
>> >> From: Chuck Lever <chuck.lever@oracle.com>
>> >>
>> >> An NFSv4 client that sets an ACL with a named principal during file
>> >> creation retrieves the ACL afterwards, and finds that it is only a
>> >> default ACL (based on the mode bits) and not the ACL that was
>> >> requested during file creation. This violates RFC 8881 section
>> >> 6.4.1.3: "the ACL attribute is set as given".
>> >>
>> >> The issue occurs in nfsd_create_setattr(), which calls
>> >> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
>> >> However, nfsd_attrs_valid() checks only for iattr changes and
>> >> security labels, but not POSIX ACLs. When only an ACL is present,
>> >> the function returns false, nfsd_setattr() is skipped, and the
>> >> POSIX ACL is never applied to the inode.
>> >>
>> >> Subsequently, when the client retrieves the ACL, the server finds
>> >> no POSIX ACL on the inode and returns one generated from the file's
>> >> mode bits rather than returning the originally-specified ACL.
>> >>
>> >> Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
>> >> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
>> >> Cc: Roland Mainz <roland.mainz@nrubsig.org>
>> >> X-Cc: stable@vger.kernel.org
>> >> Signed-off-by: Chuck Lever <cel@kernel.org>
>> >
>> > stable@vger.kernel.org is in CC. When will this patch land in the
>> > Linux 6.6 and 5.10 STABLE branches?
>>
>> I can't give an exact date, but I expect it will appear in the LTS
>> kernels in about 6-7 weeks, unless someone finds an issue with it.
>
> Do you have a web link (URL) where the patch is in Linus's tree (Linux
> git HEAD)?

It hasn't been merged yet, so it isn't in Linus' tree at the moment.


--=20
Chuck Lever

