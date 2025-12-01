Return-Path: <linux-nfs+bounces-16819-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3866DC97FB6
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 16:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1443A3994
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE943164DF;
	Mon,  1 Dec 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4EBiGbs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E25313E0C
	for <linux-nfs@vger.kernel.org>; Mon,  1 Dec 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601885; cv=none; b=slMqimIqvzNMvsbXBE3uskZ8+OUPTxtGOKH9ubd+4LSYygwXTXKdNqdmmFl6hvK0zksOfMPW1R4J5PdijSb/z5vWCcE2JsvoZ49QovIiCpq2EBnBdwD8ih7XhxG84kkszcfA6Nhlzc89Jku7KxrXTEjtTcn54kXkuGJbavNwEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601885; c=relaxed/simple;
	bh=CQjhTj/QubEllB3g+Hbf2r8jG0zen4l3G1e8YpFoGnE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FHiVihnXMJCtM5w1paSlS0oz13IPKDKRyAkduGSWx9Pf/VPeJUWYKPfnOlAGPlenIWhPOQ2mi9V5Vp+p47o6+jj/bYtqDnCXRLtUJu9KoVP0kWcPkm2gOErJtjp+Q8XlOQKDy3AwbwIcvSoN4N/8E1accwShI0NbdiXsJLw7LA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4EBiGbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A39AC116C6;
	Mon,  1 Dec 2025 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764601884;
	bh=CQjhTj/QubEllB3g+Hbf2r8jG0zen4l3G1e8YpFoGnE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=X4EBiGbs8z0Rj86ZhAnB2c4p2M+Vk7xCd9Ed9kvIW2acaZdd2J7mJhH+TnqcLwx45
	 tD5ZEF6tIC8YNWPsPilEx8la4vpzaltgybu+/QAn01S+ZKyN58IWLFjCXLIYDtCU+r
	 AXADeMpYX8dfzyFojnNtWYpuWRhUqCdAMxfSBqrq0jbNxB7/GX7C6msMY3PIGwoUJq
	 46Yuk9y0Eq2XcSx9BzMRS9WQ1PMdgJs6hzSGfXXyRWxVd8c7IO537DZ79+qtEHiUjh
	 ynGNapdjHxWQBMRUWKW+6UPztQcF/cezSldia07YNZdFU54MCQpMYezpLm/vQUXW8x
	 yC+2TE6cl2X+A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 73C3AF4006E;
	Mon,  1 Dec 2025 10:11:23 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 01 Dec 2025 10:11:23 -0500
X-ME-Sender: <xms:G7AtadovReR_7FvTxW81ocUQgGf8avpaL5AgNRc7K-sROM_2cBbOSQ>
    <xme:G7AtaacP-l5ZEQK84zmL7IJeogTiUzZtlXiJ9JvLiDJRN1BtJQ5nzmDI613aGfsuG
    HiPkXd02gL7G2pzOrghmEZX7W0N8fIUOTpEGoDs_4SfW1nBqmnq_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhgeejgfegvdfgkeeugfejheefkeeghfdtleegheejheekgfekjeeluddvveekuden
    ucffohhmrghinheplhhinhhugidqnhhfshdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqd
    gtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhitghkrdhmrggtkh
    hlvghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgvsggrshhtihgrnhdrnhdrfhgv
    lhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G7AtaeGES2vNTcbCoPLYREoMfhdwMJYS_QEGH0fqCOihYYEZLQB6Ew>
    <xmx:G7AtaXE9wA4T6ilFaiF4HteOMEM91XWArsChlVHFuGTr2E_cNkBfPg>
    <xmx:G7AtabMqmwtnssENBceGqJGqA9wSMe0P3kC59ZDRW8yEsdKLWqy_5A>
    <xmx:G7AtaWGBA_uZLZVw1OjZ_Pk7i1EyAZ5miQECmyPLNIlMrNxG6YvydQ>
    <xmx:G7AtaSNG-tdfr8g5_d3sI4NFdMqPxnTxJLkK8V_MNoKe4uI-zzaUfAGJ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 34956780054; Mon,  1 Dec 2025 10:11:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9oaoCPaRE3R
Date: Mon, 01 Dec 2025 10:11:00 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Rick Macklem" <rick.macklem@gmail.com>
Cc: "Sebastian Feld" <sebastian.n.feld@gmail.com>,
 linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <eee05a02-8f4a-4a41-8af1-c40900e4aed8@app.fastmail.com>
In-Reply-To: 
 <CAM5tNy6jjeoN0H_JcD=8Ci4X8hU=4oyn3ZxRJrhpxJgApZUCcQ@mail.gmail.com>
References: <tencent_780E66F24A209F467917744D@qq.com>
 <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
 <CAHnbEGLi--K9R_JHhROR4YfY4gbD3NmyO3MwX2xrdX8fxxAAdA@mail.gmail.com>
 <d0bcf5cd-bfa2-4f91-b1ea-1159639303c7@app.fastmail.com>
 <CAM5tNy6jjeoN0H_JcD=8Ci4X8hU=4oyn3ZxRJrhpxJgApZUCcQ@mail.gmail.com>
Subject: Re: LAYOUT4_NFSV4_1_FILES supported? Re: Can the PNFS blocklayout of the Linux
 nfsd server be used in a production environment?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Nov 28, 2025, at 6:16 PM, Rick Macklem wrote:
> On Fri, Nov 28, 2025 at 8:24=E2=80=AFAM Chuck Lever <cel@kernel.org> w=
rote:
>>
>>
>>
>> On Fri, Nov 28, 2025, at 3:57 AM, Sebastian Feld wrote:
>> > On Thu, Nov 27, 2025 at 5:41=E2=80=AFPM Chuck Lever <cel@kernel.org=
> wrote:
>> >>
>> >> On Wed, Nov 26, 2025, at 9:14 PM, Zhou Jifeng wrote:
>> >> > Hello everyone, I learned through ChatGPT that the PNFS blocklay=
out of Linux
>> >> > nfsd cannot be used for production environment deployment. Howev=
er, I saw
>> >> > a technical sharing conference video on YouTube titled "SNIA SDC=
 2024 - The
>> >> > Linux NFS Server in 2024" where it was mentioned that the PNFS b=
locklayout
>> >> > of nfsd has been fully maintained, which is contrary to the resu=
lt given by
>> >> > ChatGPT.
>> >> >
>> >> > My question is: Can the PNFS blocklayout of nfsd be used for
>> >> > production environment deployment? If yes, from which kernel ver=
sion can it
>> >> > be used in the production environment?
>> >>
>> >> Responding as the presenter of the SNIA SDC talk:
>> >>
>> >> There's a difference between "maintained" and "can be deployed in a
>> >> production environment". "Maintained" means there are developers
>> >> who are active and can help with bugs and new features. "Production
>> >> ready" means you can trust it with significant workloads.
>> >>
>> >> The pNFS block layout type has several subtypes. Pure block, iSCSI,
>> >> SCSI, and NVMe.
>> >
>> > What about the LAYOUT4_NFSV4_1_FILES layout type? Is that still sup=
ported?
>>
>> Above, we're talking about the Linux NFS server... IIRC NFSD never
>> supported the NFSv4.1 file layout type. It has a simple experimental
>> implementation of the flexfile layout type (the MDS and DS are the
>> same server).
> Once upon a time Benny Halevy had a single server (in the Linux
> kernel) that did file layout. (I remember because that is what I used
> for testing the FreeBSD client side.) It even knew how to do striping.
>
> However, it was a "single server" (MDS and DS in the same Linux kernel=
 nfsd),
> so it was only useful for testing purposes.
>
> I have no idea if it is still around somewhere, but unless someone wan=
ts
> to do a lot of work on it, it is definitely not useful for production =
sites.

I am going to guess that was Dan Muntz's prototype. AFAIK that was
never merged upstream, but remains available in archive form at
git.linux-nfs.org.

NFSD continues to implement only the block-related layout types,
plus flexfile (in toy form).


--=20
Chuck Lever

