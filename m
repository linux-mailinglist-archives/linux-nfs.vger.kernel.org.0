Return-Path: <linux-nfs+bounces-15870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E8CC28946
	for <lists+linux-nfs@lfdr.de>; Sun, 02 Nov 2025 03:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA87A4E0117
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Nov 2025 02:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7614B96E;
	Sun,  2 Nov 2025 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="bj4qnEBI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i0inD383"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2801F5EA
	for <linux-nfs@vger.kernel.org>; Sun,  2 Nov 2025 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762048982; cv=none; b=fVDh1uJxSK9FvFnLqT55uZkN8YrHuiOxrFrBk+ZDRlv78yWDBpjKq1g9t77BDr/tii2ctJLqJ3o0+rKVUQ2Ax9tQDlDy5LBVYohJsS2tshV/D2+A+R/kKziEnjjXrptnteqaNnr1TlWqBsmfvvOF6oj+FjazVvEsdNFYiE9wCbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762048982; c=relaxed/simple;
	bh=XI2tNJYSZrLQe8Iz8HhnqppuwCiEMNM7S4noJrCW/gc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aJ+23XQg76Xw896qn0m4WEggxC7iLcCAcTwFwjQk93f42iFYJKVfMg9l2DAsMNGRevzBvF8NxBb7PQiydG/NUb1/Y9gYu12nrrt7TOhwGWvQ9/AZZkBtXlXrm9mFJDkUZtSrwRHq3mzHp/prohl4O+/457xGFe7YGkOM7w/aXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=bj4qnEBI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i0inD383; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF9367A0083;
	Sat,  1 Nov 2025 22:02:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 01 Nov 2025 22:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762048978; x=1762135378; bh=fn/KQ2WGPcoPk8NbF4Rq9jDypEqp/exhsca
	5FQNNwF4=; b=bj4qnEBIX254FO5rgHBIilRPZXizh1+i4RTHHlBfGbWTv3Qrilv
	2vMyr0ni9pn98KtD7Re7U2NIHVQuRxtCYA1Y7ntNCb7DZrJ8EfK3pUYGagzw9di6
	QXh6mNPn6sBDwHAN3aF2M7kN46VTolC3dC/kjAtZktBITSNpwPe2Sozu1FpLvp5a
	lM1ySLMKKmuaWYdQexICLdk9nmUlfTV+GRnWHciD4oxlPqZUY9i4y/zk1Zz7TbP/
	pua/vAzZ1LLVa4zkxoMFi+nGEgzUeMhx6akKXcKK8aamjBSjV3ObK8KBSaADrnH5
	PvXYNXytNaSx6Pi4nnk3YuhlcUMcRg2p1xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762048978; x=
	1762135378; bh=fn/KQ2WGPcoPk8NbF4Rq9jDypEqp/exhsca5FQNNwF4=; b=i
	0inD383vVcv5LRJsd9uPq9slAn9Jz/Oo6cSZaosxtS8iQfW9rYKH752bUgMfmkM/
	QiQp8sFPLxGfP9rjB92DAZAR+M4dlzFn5kSjLdcV6r6h1st/kSSPv9sl8kajWXKK
	hzPc9BiXhZEpNvc8HeRzmymUlnW8WRT3DHR5MUglYrXrmf2ZG5sXqDG8e3rmbX2r
	t02A/F7+82X/5hBMNgGqJOBSEUiNqNv7EkipVR+gRVQHvqt7Nky9MgQGGErsEps2
	mJ5hVGDVO7hg1mUumTBW80YN2xTldKbpRMM1cYQXW+/cmGJdK+is0YHjxUNvL/ZG
	fVbygpgigc4HEO8b9Ha5g==
X-ME-Sender: <xms:0rsGaUFhiZE2P-e7BF0zXwntvrkTrA2JSTZJ9hKA5hVC8AsWMwW69Q>
    <xme:0rsGaRAQPGJ3ktTprhc1AbEuKcsnHDJ85PbRQl_n-vIUoK4g5AdHXW4EhyDxICRM7
    nHr4qzJ7uZmLHv1dNWrJS0X7FQRO1pB9yFrRq67zle7_VfE>
X-ME-Received: <xmr:0rsGaX-RhMHMiv5feS2JIogfRwHiYtXJeMc0Quuhnxk3PsHVRT9TKJ-XNwveZNcQ9W3bK4w2VTLq6Tse38mBUIsTK4N5qY_-Wbr_r8R6w5qu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeegtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0rsGadB8K6e9GNTLuZwPq_Y1JvcExu8OSLOpKFyJa0dfCUYo38xwFA>
    <xmx:0rsGacTT3BX5WxdNJxxEh4oY0p3L6mJ_ZW8jd82SmsIY8bemN72DxA>
    <xmx:0rsGaUthKHWDOJxUAc59fgy6U47QNx5VDu_0qOw33xrQ_7ajLwCVmQ>
    <xmx:0rsGaY1Fx_IGegNekjVdeTeWbvXitCSQNpaT88bH41juJ84ejK2n7A>
    <xmx:0rsGaZntHcohe1fgvvVdvIv49l43NpvB4t7ochHU_1cpWjHq_TTtTXLJ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 22:02:56 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 10/10] nfsd: conditionally clear seqid when
 current_stateid is used.
In-reply-to: <4086d557-00ab-4e50-9424-212cefe0c0b7@oracle.com>
References: <20251031032524.2141840-1-neilb@ownmail.net>,
 <20251031032524.2141840-11-neilb@ownmail.net>,
 <4086d557-00ab-4e50-9424-212cefe0c0b7@oracle.com>
Date: Sun, 02 Nov 2025 13:02:48 +1100
Message-id: <176204896840.1793333.10609031806076493945@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 01 Nov 2025, Chuck Lever wrote:
> On 10/30/25 11:16 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > As described in RFC 8881 scions 8.2.3 on Special Stateids:
> 
> s/scions/Section/
> 
> Does this change need to be backported to LTS kernels?
> 

I don't think so.  There is no regression, so security issue, no data
corruption expected.  We (I) don't even know if any clients actually use
current-stateid, so maybe it is of no consequence.

It took a while to come up with a sample scenario where the change makes
a practical difference.  What I've come up with is a sequence like
Figure 4 in section  16.2.3.1.2. Current Stateid  of RFC 8881

 PUTROOTFH
 OPEN "compA"
 READ (1,0), 0, 1024
 CLOSE (1,0)

(here (1,0) is the special stateid for "current stateid").

If some other request from the same client races to also open "compA" -
possibly by a different name if there is a hard-link, so the client
cannot know if this might happen - then the seqid in the stateid
returned by the OPEN could get updated.

If it is update before the CLOSE, then as the CLOSE explicitly must use
the unchanged seqid, that CLOSE will fail.  That is correct behaviour
because the client still has the file open via another request.

If the seqid update happens before the READ, then the READ *shouldn't*
fail because it should use a seqid of zero, but with our current code it
will fail.

Given that the client must cope with CLOSE failing, can we also expect
it to cope with READ failing?  Is this serious enough to justify a
backport?

If we could have the new code in mainline for a few months then decide
it is safe to backport, I would feel more comfortable.  But as I am
trying to change this code, we wouldn't have the exactly stable backport
running in mainline, so I'm not sure it would help confidence...

Those are my thoughts.

NeilBrown


