Return-Path: <linux-nfs+bounces-16780-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4309C92923
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 17:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B443AE009
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DF922F389;
	Fri, 28 Nov 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmJXf4Jp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91206221D9E
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347048; cv=none; b=ivxUhMqknOkpo0zH5GH/78dnI0D19MyhS/SeFJ4PFHzRhNe+Hu4pZOUMjDxwJQ+s/E19hoZDZXLbyAvspYZETCO4GnR+etPHb0CJnRKFzjD2hs8a+aDrpLlY8DR39Smondrk1vw1BsaYQ21ceDzeyLc4td0dhgovCZb7k9s+Ypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347048; c=relaxed/simple;
	bh=msiwvk5w4mQwC8jpLhIDDPXyCOM5gvKsJt0ERunqEIs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e6FILfQfuqX3tWvbK17JcedNlRw+79rWRLIpG3zRQyycF8r7ywQcHr5fnDVAxWLdZlyJZZLJ4zFCT/ESmnAR9SVV1rm+pJfFaaD8snvqr4aucjBITDCKysFcOLThlJk9eR8nWSpkZE7AJRUVfcVXp3Jr3uQEk+eueSLsWKY8Fyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmJXf4Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A2AC4CEF1
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764347047;
	bh=msiwvk5w4mQwC8jpLhIDDPXyCOM5gvKsJt0ERunqEIs=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=SmJXf4Jp78fCzZZ4WIZemhuipeZz4ysza707yMRIRD4Xr5zZxZ0fmnnK4aih+Byl1
	 bqVZp3UMMOH/kLA+R58S5aiIs56ehMae9xRxtwPUG1EwFJFKgKt9A8abAxGYgyWWyc
	 3UjrqFMcAjmTYjXFz0JwKxY0pziW6ZtqVyHA36jZvMSNwhM5BP0fRpH4cxGayf7B+q
	 HjFj8LUpjsR07VqSiEcAt7KGCUalBOaiuvzzsfUmC6SDtJB8wq4YeWD7/ETDcY0exS
	 4kNHEF7y9f/x00vNLMnmrp/7EpldHHgqPfBIDAjJch6EXi2OHx3ByvgiCHmSVm+Pe0
	 oQdGGHZ8FKJcQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18791F40068;
	Fri, 28 Nov 2025 11:24:06 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 28 Nov 2025 11:24:06 -0500
X-ME-Sender: <xms:pcwpads7Od9WaJi24vXt9RQItsqeqw0UAeaUV9SpyU01kyClwgAG8w>
    <xme:pcwpaRQSmGpnjHO4TbPdH4zzdS6l6z3fsPTaCJby1AP70DGUWPYhWFdKOkNR3Zekz
    gVpeegfnXaB4gSH0uXTdl8Cip3tVRiYrWGZ_VyyrkxjIZn-DuntInM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephefgvdetffdugfdvtdetieeiudffuefhleeuffdvgeduueehffffveejteeuhfdunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsvggsrghsthhirghnrdhnrdhfvghlugesghhmrghilhdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pcwpacZPhlrhdJpOU1Bi8GOViLr4w1kcODBAdiYd8vwxi7MwabSC2g>
    <xmx:pcwpaVUkPp3JhSA-fvGxnS_uYGMPdK27nVc8y9QJwEwbfGz3Wv-d2g>
    <xmx:pcwpaehTPOaoR0Y3Kgs065gy8pNj0XyAct2uI5iFqW4A_lSBa0fb-A>
    <xmx:pcwpaTUVimIkRx6OChLes52Kz8nQhvuAIAyiwDJG_ktDL10-sL8nzA>
    <xmx:pswpaVNYSWJxibKRV02W4eqVhjjBmfocR-GGf8UE921UIco7WsUaC8zt>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF2EE78006C; Fri, 28 Nov 2025 11:24:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9oaoCPaRE3R
Date: Fri, 28 Nov 2025 11:23:24 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Sebastian Feld" <sebastian.n.feld@gmail.com>,
 linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <d0bcf5cd-bfa2-4f91-b1ea-1159639303c7@app.fastmail.com>
In-Reply-To: 
 <CAHnbEGLi--K9R_JHhROR4YfY4gbD3NmyO3MwX2xrdX8fxxAAdA@mail.gmail.com>
References: <tencent_780E66F24A209F467917744D@qq.com>
 <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
 <CAHnbEGLi--K9R_JHhROR4YfY4gbD3NmyO3MwX2xrdX8fxxAAdA@mail.gmail.com>
Subject: Re: LAYOUT4_NFSV4_1_FILES supported? Re: Can the PNFS blocklayout of the Linux
 nfsd server be used in a production environment?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Nov 28, 2025, at 3:57 AM, Sebastian Feld wrote:
> On Thu, Nov 27, 2025 at 5:41=E2=80=AFPM Chuck Lever <cel@kernel.org> w=
rote:
>>
>> On Wed, Nov 26, 2025, at 9:14 PM, Zhou Jifeng wrote:
>> > Hello everyone, I learned through ChatGPT that the PNFS blocklayout=
 of Linux
>> > nfsd cannot be used for production environment deployment. However,=
 I saw
>> > a technical sharing conference video on YouTube titled "SNIA SDC 20=
24 - The
>> > Linux NFS Server in 2024" where it was mentioned that the PNFS bloc=
klayout
>> > of nfsd has been fully maintained, which is contrary to the result =
given by
>> > ChatGPT.
>> >
>> > My question is: Can the PNFS blocklayout of nfsd be used for
>> > production environment deployment? If yes, from which kernel versio=
n can it
>> > be used in the production environment?
>>
>> Responding as the presenter of the SNIA SDC talk:
>>
>> There's a difference between "maintained" and "can be deployed in a
>> production environment". "Maintained" means there are developers
>> who are active and can help with bugs and new features. "Production
>> ready" means you can trust it with significant workloads.
>>
>> The pNFS block layout type has several subtypes. Pure block, iSCSI,
>> SCSI, and NVMe.
>
> What about the LAYOUT4_NFSV4_1_FILES layout type? Is that still suppor=
ted?

Above, we're talking about the Linux NFS server... IIRC NFSD never
supported the NFSv4.1 file layout type. It has a simple experimental
implementation of the flexfile layout type (the MDS and DS are the
same server).

The Linux NFS client fully implements the file, flexfile, and all
the block layout types.


--=20
Chuck Lever

