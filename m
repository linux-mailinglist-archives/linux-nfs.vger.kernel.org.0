Return-Path: <linux-nfs+bounces-17501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FEFCF9622
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 17:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A56D300B9F5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358DF274B42;
	Tue,  6 Jan 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3w1o820"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039523C503
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717421; cv=none; b=J/e3DJ2Pek9WPOf/UsbTo3K0jREhfZ1Oy7Nd6p8iE7olmukXGhgdqnecjlgEyUSBU7zfQM+SZl5ejD4Y9SpO1sfymAT0OOa4IGXbZI4KJjH4zougAgxCsNO20YFvcwR/yqT6FEWDgTGaqBag4Ll3q608Vwkl5UwuBDBoV8AtdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717421; c=relaxed/simple;
	bh=LDVtcRxypa+UCE1odHBnRflvoUHSLqfQ7RXrS5bzT+s=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M2Z3bbdtUFAjnb6fvbt6CLo1/89L1kyN9dlXkDpQODsGRny2SKXN5TggAHFoQSmVbOYwriW0ceLFcZ+5jGlBuw8UtDA0ykpsMVjUWFnKfrXPQT0GXVhyWRgSILxMST9oCcn6UlOXvD7aDsxoXfmmTPcJ5Yd1oLE2fERur+0/HlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3w1o820; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B44C116C6
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717420;
	bh=LDVtcRxypa+UCE1odHBnRflvoUHSLqfQ7RXrS5bzT+s=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=C3w1o820eQj+GZ5N0MxZzqHOv4jSTP/z/DuIvUasag5ssZIQ5APNsIiKoZ9jz/s/n
	 N9En6vG03/P4o8FM/Y3sb45/tXa5EOBFgTaX+whT0cP+/7rwn5DWLCIE6Pi/c7qV4D
	 UJ4BDeLQX9/uEUox86mBGXaeoIH75t9XMk+NFxFWFYhN8m1dbog0vO/UMuASjVEaS7
	 36xv/GoYfPa9Q8+svXTvUbOeSFNqHCyE6n3jWRQOsb0Z5B4IDAm2JpJqQpka+uXO4v
	 ZDgD4BWgC7aSMtQEeOO6b0th0wQH6zy4tgauTCAibQb7eElii5T07HD/f+/WPWWfHv
	 SQvVxlE1rtjGw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 59676F4006E;
	Tue,  6 Jan 2026 11:36:59 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 06 Jan 2026 11:36:59 -0500
X-ME-Sender: <xms:KzpdaVnTYQeL1gXjwoHrdBJFJFY_YuybBqH6USnRfuNVvzeje_DKoA>
    <xme:KzpdabrGI-jpjepAuCwt6czF35BB9M3c815yMc3G7E4v-wb5Fvuh2nfFfyDHjQQCl
    J-4oNkhybX71ImpiJ-zJ-ZdNvm3iNnxyyuXBzmLBPUHkPIq3nCrDozV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheehjeelgeffffeihfduudevudeghfehheefhffgueeluedufeetjeduhfdukeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrihgtkhdrmhgrtghklhgvmhesghhmrghilhdrtghomhdprhgtphhtthhopehlih
    hnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KzpdacTCG8PicMkwYmtQuDwHjU6-aUFXfXpzYFVaGrbt7AXnlydAQQ>
    <xmx:KzpdaXtOWLB9HUo5OCOC4q7tBI-YQ-KoR4APMjkffz4zV82y5RhfHg>
    <xmx:KzpdaRZqRlkp8Z-7w6BIQKfzzujHrEASWqf5gu7cxz66BR6ydRrM9g>
    <xmx:KzpdacvaKsTT9YNK6dVxt0oHFADvI9n899qzjAmCZzieDbLRbmOfxg>
    <xmx:KzpdaTE9ip_V9tNC2ZuyfNFmppbh1V5FEYPurL461qeD5sNZpan7sj7_>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 367D678006C; Tue,  6 Jan 2026 11:36:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOkYyh3N-hyZ
Date: Tue, 06 Jan 2026 11:36:39 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Rick Macklem" <rick.macklem@gmail.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Message-Id: <679b3c2a-b70c-4364-a362-fa5eefbf3af3@app.fastmail.com>
In-Reply-To: 
 <CAM5tNy4Waqfaqu7kgtnSNrdyR0jBSzJ76tMTbGJPq4HGbBKHiQ@mail.gmail.com>
References: 
 <CAM5tNy4Waqfaqu7kgtnSNrdyR0jBSzJ76tMTbGJPq4HGbBKHiQ@mail.gmail.com>
Subject: Re: Limit on # of ACEs in a POSIX draft ACL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Jan 6, 2026, at 11:02 AM, Rick Macklem wrote:
> Hi,
>
> When I did the POSIX draft ACL patches, I mistakenly
> thought that NFS_MAX_ACL_ENTRIES was a generic
> limit that the code should follow.
> Chuck informed me that it is the limit for the NFS_ACL
> protocol.
>
> For the server side, the limit seems to be whatever the
> server file system can handle, which is detected
> later when a setting the ACL is done.
> For encoding, there is the generic limit, which is
> the maximum size an RPC messages can be (for NFSv4.2).
>
> For the client, the limit is more important, since it sets
> the number of pages to allocate for a large ACL which
> cannot be encoded inline.
>
> So, I think having a sanity limit is needed, at least for
> the client.

The Linux client does something special with ACL operations:
the transport/XDR layer allocates the pages as the reply is
read from the transport. It already does this for both
NFS_ACL and NFSv4.

I don't think there's anything different needed for this case.


> If there is a sanity limit, I can see having the same
> one as the NFS_ACL protocol will avoid any possible
> future confusion where an ACL can be handled by
> NFSv4.2, but not NFSv3.
> (The counter argument is NFSv4.2 is the newer
> protocol and, maybe, shouldn't be limited by the
> NFSv3 related NFS_ACL protocol.)
>
> To be honest, NFS_MAX_ACL_ENTRIES is 1024,
> which is a pretty generous limit.
>
> So, what do others think w.r.t. a sanity limit on
> the # of ACEs.
>
> Thanks in advance for any comments, rick
> ps: When wearing my internet draft author hat, I
>       lean to "no limit in the draft", since that is what
>       the RFCs do w.r.t. NFSv4 ACLs, but that doesn't
>       mean implementations will handle any number
>       of them. Maybe I'll add a sentence to the draft
>       noting that the limit of # of ACEs is server file
>       system dependent?

IMHO generally speaking, implementation guidance is reasonable
to put in an Internet standard, especially if it directs
implementers to address a subtle security issue such as a
denial of service.

Something like "Client implementations should be prepared to
handle ACLs with many ACEs and large 'who' fields."


-- 
Chuck Lever

