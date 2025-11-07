Return-Path: <linux-nfs+bounces-16201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E93C41C97
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 22:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C6654E10C2
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230130F959;
	Fri,  7 Nov 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="a9LFH9z2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQgLzEYR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7E23507E
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552748; cv=none; b=DGjKxXt0bbpSGAsDjylFyLJJ96ZgetAFR3PkJgDO+KJYU1cEuhDwZk4y8AK8xLcmR1HuMTTOzExq9o+Ahfz7vIOpQi4Ju3LOmCDVD/bn+WRVChncQMQpdqv64tD9nRV/vZVv15UzIGbe4DnPkfTdlAYcz5XVciiT6OMW+8Ng9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552748; c=relaxed/simple;
	bh=R6P70sizQj+PkckWgBhESj3qDFKTbwFRJ8AuB3qxU7o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=sarwD5koXJ41a0E6gH1Cj48RPMTkedNDdp1EkBh9xz6We70AcuMI9lfcpS/fOvszDGPNjuzw884n9j+VnktpbAa7x49wMeEaxvmnBY2af+dusQny6RpjNTMgUgWyQtJ80QG/sXgcS7PvDCTOaLHqVyVLSON0vZ0j340zc4Vedaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=a9LFH9z2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EQgLzEYR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C4947A0130;
	Fri,  7 Nov 2025 16:59:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 07 Nov 2025 16:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762552745; x=1762639145; bh=srWsCbLFOangWxiLTM4BZCbwyVi2jz53l1l
	ndJOsmPw=; b=a9LFH9z2OWTriHLIkoCq0HuznXMsTgdWkJHralskGE5lo/ZK0yN
	BQgZQKvSDPyNiwOy1MsgsaNaV0z5U5wHkyChbqoCkxaGEwRLvXa35zGlxSbIkxg7
	xKz4qlTKBHlN7apewrABkPAMR3ClYhQ0wTAkFWtK7M4GCxMtnau2xZXMr0M9MggK
	Zebt3xRWvk4mQSSs0Yd3qQjN2+8/o7uc9hwOwAWaJRf4KiavGYsbRlTFkHSw2H/k
	oBPBZy4t/oFhtxia1RWNb3/vnz+/pzoeVTwoBA2Uv2+LcfWnNcb0+GZ8sH5BPZkg
	PLp3L/rObY4IyANiZO3mwRCAmCxGGGZPcsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762552745; x=
	1762639145; bh=srWsCbLFOangWxiLTM4BZCbwyVi2jz53l1lndJOsmPw=; b=E
	QgLzEYR3XLX9+eoMHmEwhMpLGU9s26kv7LLzauCHNg3uvSl/T1rn3Zu9YfB99ruo
	+pDm1CQsKXpBQxtUzhosYzK+IujvOFwXjVQDLU4cuvb81H75vgquJ0ecCbZa6jcZ
	B1nloLijUu6uhBfhSv6+cOqCJfLRldfqekb81HIp/Btj6tUO01xhAxjg9kYtworY
	9u81cl3k9CZNvTLXF2aWdAxRTVa2M6uw4vzmtSDmo7RdvHrLkz19h8oMkSy6Gbv0
	7EcwDvNU7Uj8urGj7zyxB38R3uA2HibBNI2U/q+kX4uBSMSNf+5zWrSVMiasNNwz
	lcN61KRZdKYwBjAfAuDyg==
X-ME-Sender: <xms:p2sOaWqFs3rXjM7L11u6MSxu0C9iRMxP-ySoEWEg6KEeoBB44mMDbA>
    <xme:p2sOaXPquKQmOYaeZWqKZadRgXBKP-F1Kz4AAvmV5t_vBWtXLJppgcG8v7pJoxHfQ
    DPq11wAXg8HMQmbou5dipoxqx9DVSiDi-QS25u9wRJc7DlYGQ>
X-ME-Received: <xmr:p2sOae35gKgIFcBuo83qIqjReMnhf2hFh19Fn5lBjZS4-1wQbxUhInoXYj0dFnsUpMCnxjwvvlmRL7SbnjWD68BzM8yTPYAg6iP2yn79JN4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepshhnihhtiigvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:p2sOaWANfplornZlSrpyJEnHTdZ1sp37vhDqT_vrApkBDMlWhJ2DEw>
    <xmx:p2sOabIhsLA4euL0HMheKpV3ifsU74HnWZYjaEKxyOnQCeD-mphvDA>
    <xmx:p2sOafn6_fazyzilR14g-ttTzriB_Ge8t0PpjJ_TOgPa67qajecbDA>
    <xmx:p2sOaUaOMm6alTeadVjlIxebkwgPc6CaeszcLfskfiHTLjoutvE8yw>
    <xmx:qWsOaQ93Vg70qoZerMcI8SPvcMgVfiZkNUDPjhKP3KUG8XfkN48eLCxd>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 16:59:00 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Chuck Lever" <cel@kernel.org>, "Christoph Hellwig" <hch@infradead.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
In-reply-to: <aQ5SSnW9xUWj9xBi@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>,
 <20251107153422.4373-3-cel@kernel.org>, <aQ4Sr5M9dk2jGS0D@infradead.org>,
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>,
 <aQ5Q99Kvw0ZE09Th@kernel.org>,
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>,
 <aQ5SSnW9xUWj9xBi@kernel.org>
Date: Sat, 08 Nov 2025 08:58:56 +1100
Message-id: <176255273643.634289.15333032218575182744@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 08 Nov 2025, Mike Snitzer wrote:
> On Fri, Nov 07, 2025 at 03:08:11PM -0500, Chuck Lever wrote:
> > On 11/7/25 3:05 PM, Mike Snitzer wrote:
> > >> Agreed. The cover letter noted that this is still controversial.
> > > Only see this, must be missing what you're referring to:
> > > 
> > >   Changes since v9:
> > >   * Unaligned segments no longer use IOCB_DONTCACHE
> > 
> > From the v11 cover letter:
> > 
> > > One controversy remains: Whether to set DONTCACHE for the unaligned
> > > segments.
> 
> Ha, blind as a bat...
> 
> hopefully the rest of my reply helps dispel the controversy
> 

Unfortunately I don't think it does.  I don't think it even addresses
it.

What Christoph said was:

   I'd like to sort out the discussion on why to set IOCB_DONTCACHE when
   nothing is aligned, but not for the non-aligned parts as that is
   extremely counter-intuitive.

You gave a lengthy (and probably valid) description on why "not for the
non-aligned parts" but don't seem to address the "why to set
IOCB_DONTCACHE when nothing is aligned" bit.

I can see Christoph's point.

Can you please explain why all the arguments you have for avoiding
IOCB_DONTCACHE on the non-aligned head and tail do not equally apply
when the whole body is assessed as non-aligned.  i.e.  the no_dio label
in nfsd_write_dio_iters_init().

Thanks,
NeilBrown

