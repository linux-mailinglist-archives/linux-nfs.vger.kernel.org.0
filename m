Return-Path: <linux-nfs+bounces-17076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF889CBB2B9
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 20:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4F5A3009572
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F4622A7F9;
	Sat, 13 Dec 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMecSclT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF17212B0A
	for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765654511; cv=none; b=oFtnl7SXAdMdoh6vkCPPFNazCCUfZDJUAZH1fjBGXa9laoh/k1+YpetUpUzkZcj5+m/yt0y4sPFST4hXs5DW9dhKHQ6guBcJVcF5kYlovOFdUC7+sGEPG9wtcLRXtAWHCzp4AoKeW894xL6xSJf5/cztz944XGl6n4yhCT238kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765654511; c=relaxed/simple;
	bh=lhIDqPX11pIVAellqCXy+w2jvKUBCsEzvQK8uswX/Nc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j0o+Dg8ZdHBj+a7IhRUYWWOKdJuP+CQuBP8qYrxoCWWjKspqG2ScWqV5bd7zUXGZDggBHLjNKR5hOdG9mxiuiHiKnQUVK/9sIj6Eb2XaPKAnPb/846daV+aI+i3k0zxC5GXZBx9hBhslIavd2d9zV5jtrL1BGAqNzLmjF5wcNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMecSclT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB54FC4AF09;
	Sat, 13 Dec 2025 19:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765654511;
	bh=lhIDqPX11pIVAellqCXy+w2jvKUBCsEzvQK8uswX/Nc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sMecSclTn412RIG0r11bqYPpwUNIMSeEXk1C/rC0CuOlS0qeJ/WNT0qI3cVY18a3p
	 wUNcQ5E6l7ENU/8nexR/vRuzPJsfQkdtS9UnOr5Niig+vR4dZmcktL/dn+gWlX9TNU
	 /qzwoynHgNATdSuFkkZfsqXBYpGjezgiw8YGe22Lz/FLXIIBdndFSMHHQhmAWKjend
	 xj1Bt1bA7PicZgu/9jRWOA2ktqJP6RNrJ7VOEDakE9/sEl9roOWys3xlQoD3dV6H/8
	 VLgOtKDIyYL7JdpcmBdvIKpoIJO2XdGU4aANFMICTWXniTaDWMQQIT44+my4GZ4KFm
	 IEve0fBrszmXg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DC604F4006C;
	Sat, 13 Dec 2025 14:35:09 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 13 Dec 2025 14:35:09 -0500
X-ME-Sender: <xms:7b89af-cro3UeX_Q04KJgRoI1cuhAjX9cibg5ZEqwUWbryi4rtgBWw>
    <xme:7b89aWjGCO2yBpLKPzymFADFRj4eJXaqS8Iy2jl9PjGPplIvsSMdPW_3I04y-Nyet
    6T7hCNZT4tAorsKdzS-4KuDEkdFhLxXW-73obKw3XQjiI0ItxU3uQ-N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrnhhnrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrih
    drnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7b89aZLKW4YWgOdvJQ2IqazWjj-NRKPkhrzpugaGgor7n8UaPsoFXA>
    <xmx:7b89aSjVbJvEfp1jL4TJXvpSu-dqZFWnW3vzkZbah30Cx4jiWJckcg>
    <xmx:7b89abPCKuj-SlqGES-WPgT5NawXXUp5_EORjcDsdet-BDFOVnCOoA>
    <xmx:7b89aVp6oIVyetkqWraY27iuJuXoS4mf3BQi3qb0sJxNTvBiLBjKEg>
    <xmx:7b89aV56sUw27pJJQNFyKWJO-DX33w9ZSxTW9m32uVh2HC_pZQ5PJBtL>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B9E89780054; Sat, 13 Dec 2025 14:35:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwGBrbvZiv0o
Date: Sat, 13 Dec 2025 14:34:48 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <53080a86-df29-4321-8b51-c5af565cc6f2@app.fastmail.com>
In-Reply-To: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
Subject: Re: [PATCH RFC 0/6] nfsd: allow for a dynamically-sized threadpool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 12, 2025, at 5:39 PM, Jeff Layton wrote:
> This patchset changes nfsd to dynamically size its threadpool as
> needed. The main user-visible change is the addition of new controls
> that allow the admin to set a minimum number of threads.
>
> When the minimum is set to a non-zero value, the traditional "threads"
> setting is interpreted as a maximum number of threads instead of a
> static count. The server will start the minimum number of threads, and
> then ramp up the thread count as needed. When the server is idle, it
> will gradually ramp down the thread count.
>
> This control scheme should allow us to sanely switch between kernels
> that do and do not support dynamic threading. In the case where dynamic
> threading is not supported, the user will just get the static maximum
> number of threads.

An important consideration!


> The series is based on a set of draft patches by Neil. There are a
> number of changes from his work:
>
> 1/ his original series was based around a new setting that defined a
> maximum number of threads. This one instead adds a control to define a
> minimum number of threads.

My concern is whether one or more clients can force this mechanism
to continue creating threads until resource exhaustion causes a
denial of service.

I'm not convinced that setting a minimum number of threads is all
that interesting. Can you elaborate on why you chose that design?


-- 
Chuck Lever

