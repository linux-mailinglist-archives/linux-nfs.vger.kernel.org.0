Return-Path: <linux-nfs+bounces-970-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC5E82673C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 03:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526F3B21291
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 02:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18397481;
	Mon,  8 Jan 2024 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Hm73PF3s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vDZkDcha"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E66FB9
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jan 2024 02:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 5C9BA5C0A6B;
	Sun,  7 Jan 2024 21:01:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 07 Jan 2024 21:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704679309;
	 x=1704765709; bh=3kpDub9Tp4ZGxg3/gioLIqK0LDKg1bkTfDGFayq4sZU=; b=
	Hm73PF3sdVCU2epUpGfGPvsMrNUFaBeGlZgl3ctQibjR3qtyld4W7QNsd6ogadVU
	BUaRPvlHcov6atFKYk6Unf3P3xNYV8wJi3pGhUKB1dAqR7X9dLQ+SxwRsruzkO3Q
	EXhvOxMpE+9yfWwzDinhG/4gp64yIdIXidRcMRq9r1YS7e/N44VszLR4R3WgKj5A
	d2idaU9jzItcKeVierP/56vBBtKjcfEO5tplZ9LxDEwhwFkZZ3RWU7npppI56cde
	8nXCdARBjd3/bZBqKD+qSQ9bkKjgVn3BP/bMg5THFBCBNxYJFdbkL+wYKS436jQk
	0H84a+B0RykD6KZYXkIxNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704679309; x=
	1704765709; bh=3kpDub9Tp4ZGxg3/gioLIqK0LDKg1bkTfDGFayq4sZU=; b=v
	DZkDchaVi/JArxF+++ycDZoyoaZ8U5N5sqn58D5dYwVTbXq4T0Kk2H81Td/T6WA3
	J6cvZHrKE+rttVTI6CNSdnbwTI4mMeEXy6sXZimbbJD2CZgdRroz4VJ613ZgFOx1
	ifflk91DbAw/evtH7F4AbqMky7nS/ELosxQ8bmuvdhyHYndjXSojAA8XLQuyyr/Z
	nmQ8lhykZ939OPhtuazZ+GPI1appVOb/3MyY0a7r5dJrlUtUmEY7G2mKyfBeSoPM
	lvvfRzz78yD5xlIaTRBaELLnQATIg2yMsGX65L+b7PIgNY4KG/hFeOK9pdaFhj8H
	L9iTVp265lDBpgkFLrKow==
X-ME-Sender: <xms:jVebZSX09bj0qndY2u23ekP6OP8cP-LPAHNG_bTCpx8otBrNLR8Jxg>
    <xme:jVebZelNJCp6UCbSBfULl_Pzc-hgs3ScqWnVCaxox-1CgFEInWCNQGcdaO0yPq3-B
    uq8AG1GenGC>
X-ME-Received: <xmr:jVebZWbaoGdYhzARixt3RCGudJWxRsjecRYLTXgEUEHzJ7LuqcfnyB4liegOOXwGrfl6iaoGoX1VM0Cd-ZWX9yAcLp4WWliwkh_lU09FLiw9q0tjmbWv8btN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehhedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfhfhffujggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fhueejuefhvddtledugeeufeduudfgveevieeffeeuudefueeuffeufedugfefieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:jVebZZUNoLKBq0s8ABUV-wkd3a7X_lttB4oFtz_q2Rd7daXazKCTow>
    <xmx:jVebZclq-dGeB55P7tKILEHin8nAOKedOVXYRsT_8GAfbUgOMyInrA>
    <xmx:jVebZeepVb1Ywi2lm08fZQ7rBrDFdJOawNV0H45aG-C8Fiu-GoRbiQ>
    <xmx:jVebZeT0gmQcWJ7zz-oLCrzfmOE3RtxgUlxrRi_MyiohjJPzhFIQQg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jan 2024 21:01:47 -0500 (EST)
Message-ID: <68a64e1a-6f39-2b9e-b41c-ae2200e054c0@themaw.net>
Date: Mon, 8 Jan 2024 10:01:43 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Cedric Blancher <cedric.blancher@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
 <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Subject: Re: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers -
 Fwd: showmount -e with custom port number?
In-Reply-To: <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 06:33, Cedric Blancher wrote:
> Good evening!
>
> Generic issue in all of nfs-utils: None of the utils properly support
> NFSv4 with non.standard (TCP/2049) port numbers.
>
> mount supports it for mounting, but does not show it for listing mounts
> /proc/mounts does not show the port number either

I'll leave this to the nfs folks but, looking at the nfs kernel code,

neither of the above appear to be accurate. But then you haven't provided

information about what kernel and utility versions your report is based on

so I can't check.


> showmount -e does not support a port number

Now this does look to be a problem, even with the current code, and the

mountd port can't be specified at all.


> autofs does not support non-2049 port numbers

What is it you expect to be able to do with autofs that you can't do?


It's interesting that you sound like you assume mountd "must" not be

used for NFSv4 and it's not the first time I've heard that.


I thought NFSv4 "must" be able to be used without mountd but there was

nothing that says mountd "must" not be used to provide port information

to clients if they ask, such as on a local (probably isolated) network.


So, based on that assumption, the fact that it (the kernel => mount(8),

proc mount listings) doesn't print the value of the port option if the

default NFS server port is being used seems sensible enough.


I'm not aware of any protocol in NFS itself for communicating the list

of exports. And if your not on an isolated network would being able to

list the exports be a wise idea?


So I'm not sure what your expecting to be done ... other than some

improvements to showmount(8).


> nfsd referrals do not support setting non-2049 port numbers
> ...

Another interesting comment, I don't actually know about NFS referrals

these days. I'd be interested in hearing about them.


Ian

>
> Could you please make a concentrated effort and allow non-2049 port
> numbers for NFSv4 mounts, in all of the lifecycle of a NFSv4 mount?
>  From nfsd, nfsd referrals, client mount/umount, autofs
> mount/umount+LDAP spec
>
> Ced
>
> ---------- Forwarded message ---------
> From: Cedric Blancher <cedric.blancher@gmail.com>
> Date: Sun, 7 Jan 2024 at 22:32
> Subject: showmount -e with custom port number?
> To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
>
>
> Good evening!
>
> How can I get showmount -e to use a non-2049 TCP port number to show
> mounts on a NFSv4 server?
>
> /sbin/showmount -e localhost@30000
> clnt_create: RPC: Unknown host
>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
>
>

