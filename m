Return-Path: <linux-nfs+bounces-16793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A09C94154
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 16:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CED723452F2
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33701EE7B9;
	Sat, 29 Nov 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPT7V4sY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CA1A9FAC
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430844; cv=none; b=YLPs/9kHjyjYzSQkPVqmmNQUmYyzU2oDxM3T6v+imv1TIJIYNzlCwn4NBj+Kwg4S/FTV2AQrzArgbex+4K+PupToBPyUuCnl+1kejp0lgF+s3BW7KCm5Nnyna9G67ddJ+nX+Jn07nYF3WkAfIa5wI2bY6dJFYq2r/2h4dtszYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430844; c=relaxed/simple;
	bh=cUhCtvourTec25IW7Lm55jVX/2alWK+X1PLs2qrph84=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PQrSSfQd9BJqyy7m/nKhtBkRYA7W5DA3M7IIDoAqT3n7YIpx37Hl5du+jgxUismh/EkIAPEYqvAZO/lRWOk0bO9xIZkBUOLFL1NkMmkX/kVWo9MkSTCULtsj1SJJhaWOa2jodme0StzMa/ukq0U8pOv8mmUFEulgoJdj74s09r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPT7V4sY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F2CC4CEF7;
	Sat, 29 Nov 2025 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764430844;
	bh=cUhCtvourTec25IW7Lm55jVX/2alWK+X1PLs2qrph84=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=RPT7V4sY1BnPFP1BpI9RQnhaoZzhDbHCoAGWHjPZQDOqSFJsXaCK5uuq7y3Y6iX8E
	 9z5vMTKKVV2SJR3nFt9x/LMl5tOkt+m8g6Gtw4cua2fCPc+d4tJ/RjMym1gzk4RACS
	 /OmoBAXh4VCrmChJfT5Hy6LK6APoNOyhVIMIR6M5tlUGRROKbGn6AXJJEDoO8V2kd1
	 tKGk/OKjRR+1dPP/dwGHKgZg8MxrjOCPGkv6j5YnfqbsVExV5vCD7NUy2X4tg6CbbW
	 322woTqQEYBi2W3gUz99MXKGEXIAZ74C2daPQqx/HA/kFkZ5wFKEzWKoeT50Tnf9aq
	 i+hpU61wMUViA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B5426F4008C;
	Sat, 29 Nov 2025 10:40:42 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 29 Nov 2025 10:40:42 -0500
X-ME-Sender: <xms:-hMraX7C3EKqTtgvVmzm5yyFhftCCUZ7G2FqkruTcgX6drLC5ySRFA>
    <xme:-hMraXvXcjoaYbAA9K8E9BT_N4MdDb0pqGDHAzPa9GfMGDmP44Y8IQr8aLhtbR2UP
    vVh9ISNUwsJ059hi6I1W-0nFh6Vi2Nb-3w5bKmxQySzQQCC8ufbtM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvkeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:-hMraSnF9A9ShE7JTjfQhS79SmI6u6neBKUaFAGhniiZqsnN1hKfcA>
    <xmx:-hMraXwRASxdeel3mMVQTI3cs_Sah3uCEq87cCiu-pcijHC3Fn2igw>
    <xmx:-hMraYNXQELVNv98Mzz0Eo73kDouWC97VJTcm6rfL9TKQxGYIaWOQQ>
    <xmx:-hMraTTgYOgAYhpfha2khCpiMrtTEu56uKP21Y_Gw3NYaNGQ6jtLsg>
    <xmx:-hMraebgMp6FHeQPtemBt_0rLjGRY_fzV6Ch0fMgIZi4pCJIk5dlZ3Qm>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7B026780054; Sat, 29 Nov 2025 10:40:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwX2CI0UG88J
Date: Sat, 29 Nov 2025 10:40:18 -0500
From: "Chuck Lever" <cel@kernel.org>
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>,
 linux-nfs@vger.kernel.org
Message-Id: <bde0d0ba-4e1d-420c-b8f5-71835ffcba16@app.fastmail.com>
In-Reply-To: 
 <CA+1jF5pTHTh1o1S92s1JVF4Lvx5XT7+tccu=woDSbDUPRsubXA@mail.gmail.com>
References: <20251119005119.5147-1-cel@kernel.org>
 <CA+1jF5pTHTh1o1S92s1JVF4Lvx5XT7+tccu=woDSbDUPRsubXA@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, Nov 29, 2025, at 2:57 AM, Aur=C3=A9lien Couderc wrote:
> On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org> w=
rote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> An NFSv4 client that sets an ACL with a named principal during file
>> creation retrieves the ACL afterwards, and finds that it is only a
>> default ACL (based on the mode bits) and not the ACL that was
>> requested during file creation. This violates RFC 8881 section
>> 6.4.1.3: "the ACL attribute is set as given".
>>
>> The issue occurs in nfsd_create_setattr(), which calls
>> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
>> However, nfsd_attrs_valid() checks only for iattr changes and
>> security labels, but not POSIX ACLs. When only an ACL is present,
>> the function returns false, nfsd_setattr() is skipped, and the
>> POSIX ACL is never applied to the inode.
>>
>> Subsequently, when the client retrieves the ACL, the server finds
>> no POSIX ACL on the inode and returns one generated from the file's
>> mode bits rather than returning the originally-specified ACL.
>>
>> Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
>> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
>> Cc: Roland Mainz <roland.mainz@nrubsig.org>
>> X-Cc: stable@vger.kernel.org
>> Signed-off-by: Chuck Lever <cel@kernel.org>
>
> stable@vger.kernel.org is in CC. When will this patch land in the
> Linux 6.6 and 5.10 STABLE branches?

I can't give an exact date, but I expect it will appear in the LTS
kernels in about 6-7 weeks, unless someone finds an issue with it.


--=20
Chuck Lever

