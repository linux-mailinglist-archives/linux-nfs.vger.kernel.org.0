Return-Path: <linux-nfs+bounces-17687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA67D0A8F6
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 15:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA90D301AFF9
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95135BDC4;
	Fri,  9 Jan 2026 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPmHRlT7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D635BDAF;
	Fri,  9 Jan 2026 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967782; cv=none; b=SJZthsbfSeTaRn05PxNDL+BrjZB9xU72FffGUv7wIU0cVor2EO+o78Dzc4knUJ+JJoDWFiTyAfhucGZ3Gkk+P/f1D+f1s2yVcwZVzgaIrTFLdzr8NwLverRDtlD4rWcxNi4FizVI7r3HeWNY8V7uG4Fw1KqeMy6vy9poO31FQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967782; c=relaxed/simple;
	bh=NcivEdZVRpZhLaS1QCCFRLsO+KkPaLEaUpYHu9tWpAg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O+5X+oJMc899fRf2SP3+7y2nbfZ/fH2goXlWTz2eC04m5Xa2UDXfCqB/nMA5e71EX7/k1hE6wexZYs0CHtdcfPculbDyMFbN+KwjRFhLNqZlwxS4bsIT6yPdPCJB//CeGVU+kVmCz6Siw9//lnO0yuvt4/DMcFfYrDS6HFa8ntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPmHRlT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1701C19422;
	Fri,  9 Jan 2026 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767967782;
	bh=NcivEdZVRpZhLaS1QCCFRLsO+KkPaLEaUpYHu9tWpAg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WPmHRlT7Ya4cqT0paVBAI/n4oUDVzGvnFs3SSkALaI9fvlZ3K4zpudJf9fmU1ZJZ7
	 yys42MenIt2gEtoXyghkNwsA5hEAzw7rYgoO47JeJdUOP2T0zFXbvHeCLUJV+8jeJx
	 +0MistcSMgvZNomL2mug9WqkWyZg2wKohalwIgX/s3lBlJwyyjxEq2j3Rro+uQwglc
	 pkov0JCnyIZ38Mxe50rAluUJ6mPNWAAfegZhnTLIaydCprLBhZd/HSsAJl8o8+61ps
	 2kvDHvYfwffKLj6oBPfoE2zBAlsZW14U7ujKLVSUaf5EMBPVimQCkcTqtjUOCsw/5T
	 vefKmyiotqcPQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E5CB2F40069;
	Fri,  9 Jan 2026 09:09:40 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 09:09:40 -0500
X-ME-Sender: <xms:JAxhaXAEEVx_j-mGrTzcHvzpg_lYvZoKzyY0e4qc8c9wG-1Y2izEmg>
    <xme:JAxhaYVXCpBR0OkMQQw4iPsFjAbWcqfGTI_HI8rGk_YMCmZ8RrqQKNtK1IdCKmBG0
    sfHMjkOtX1Qnn5k7KbQGEYrVvHYpvXaJUjwojrc68_Wqfm96BXXefM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeegheduieeiveevheelheelueeghffhtddtheelhfdutddtheeileetkeelvedtjeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JAxhaeO0wQqlyusxheGuhp4Dgq2iOlZcEre6bGdMfJicaCXGiboIfw>
    <xmx:JAxhaV5QPjyRoqqS4O81K0AqXn_1TFuoFjuMc7PWwF1KgYP9lMrD2A>
    <xmx:JAxhaQ30nZNCmrTeK4HIkf_JaHvFgNqU3Nzv8c6bpTaOL4X-FXabKA>
    <xmx:JAxhaezY8fytGuif8O35kOzvjS7ztQw51oSBrP0WxKJ2Ds0RQP6_TA>
    <xmx:JAxhaSu_MOZoopBjrvl9Yj_Tb59WsKwsUoWXBjlsxWxlPTYri4pvN8sx>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C7FFF780054; Fri,  9 Jan 2026 09:09:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUhaZbciXRC-
Date: Fri, 09 Jan 2026 09:09:20 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, "Sasha Levin" <sashal@kernel.org>,
 linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Message-Id: <f664b380-29cb-4a77-b0da-32c36e105089@app.fastmail.com>
In-Reply-To: <2026010958-defiance-equate-955f@gregkh>
References: <2025122941-civic-revered-b250@gregkh>
 <20260108191002.4071603-2-cel@kernel.org>
 <2026010958-defiance-equate-955f@gregkh>
Subject: Re: [PATCH 6.6.y v2 1/4] nfsd: convert to new timestamp accessors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Jan 9, 2026, at 4:55 AM, Greg Kroah-Hartman wrote:
> On Thu, Jan 08, 2026 at 02:09:59PM -0500, Chuck Lever wrote:
>> From: Jeff Layton <jlayton@kernel.org>
>>=20
>> [ Upstream commit 11fec9b9fb04fd1b3330a3b91ab9dcfa81ad5ad3 ]
>>=20
>> Convert to using the new inode timestamp accessor functions.
>>=20
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> Link: https://lore.kernel.org/r/20231004185347.80880-50-jlayton@kerne=
l.org
>> Stable-dep-of: 24d92de9186e ("nfsd: Fix NFSv3 atomicity bugs in nfsd_=
setattr()")
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/blocklayout.c | 4 +++-
>>  fs/nfsd/nfs3proc.c    | 4 ++--
>>  fs/nfsd/nfs4proc.c    | 8 ++++----
>>  fs/nfsd/nfsctl.c      | 2 +-
>>  fs/nfsd/vfs.c         | 2 +-
>>  5 files changed, 11 insertions(+), 9 deletions(-)
>
> Adds a build warning, which breaks the build:
>
> fs/nfsd/blocklayout.c: In function =E2=80=98nfsd4_block_commit_blocks=E2=
=80=99:
> fs/nfsd/blocklayout.c:123:16: error: unused variable =E2=80=98new_size=
=E2=80=99=20
> [-Werror=3Dunused-variable]
>   123 |         loff_t new_size =3D lcp->lc_last_wr + 1;
>       |                ^~~~~~~~
> cc1: all warnings being treated as errors
>
> try a 3rd version?
>
> thanks,
>
> greg k-h

Harumph. I didn't see any warnings before I posted yesterday.

/me trudges back to his drawing board.


--=20
Chuck Lever

