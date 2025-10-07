Return-Path: <linux-nfs+bounces-15041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B515DBC2D34
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 00:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A920E4E5FDB
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 22:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B32220010A;
	Tue,  7 Oct 2025 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YwnEatUv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="epdCswYo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D181922FB
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875187; cv=none; b=mqjAcOA/wLrqk+sJnfdLTp9dToOtPx+Ym/j3vRSBuUDf+dSnd8uII5E+BKmu0FX76CWadjA6axB/fHswUte4M9aTZIyiixM2TfAcRQc8I9aKy43Qu04SCzbnRAdS5zGzqGdM7AuQxmq7pgWDpE0Nfkfdtv5orTWmt7QBEurKi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875187; c=relaxed/simple;
	bh=A6WTMomYRYyCNmQM0v7a9m0zkw0F7cWzZlSFoafAGbY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=vFCQA3GmaunM7oCcrBkQhxmdikAB/N7ora+7IfoH77bYUL/Q1MuQI+iSWe5xHU4zLtxJJFyihE9m/c33aLReIOxe2bfv8ynP4djN22u/Y2uPF3SS8E6q7C7K1ajAjvMRao/CsoeJMTu6Zw/cPtLJfxRhnqbubzy257/wKuPEXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YwnEatUv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=epdCswYo; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDFC714000FE;
	Tue,  7 Oct 2025 18:13:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 18:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759875183; x=1759961583; bh=AMZokNPRoZ7ycmlziGgZ9LqFfoPkN5NkF0u
	IpAhrpi0=; b=YwnEatUvQfalgr9ZV7roXE3ON5GgfTnQolKgdVXdCpeFkim+/wn
	5da0bTjTMhGsU4yFXWZWrzQjwHZ8rwUTpTLgzW8PXnVOMkUHNskhqy+/nRY2WaGy
	bLfgL8HeXC2zbRJhE5DvKCmssH5aMkncHFtjVev3Zuo5FvlR0lEqTrQxiYQUQ/Zs
	I74gmqtC+RkjHF5hK9R8UtKRT26yBBAfpbNmxaYBPCgEqM862Ti+Z9OsR9ePFSA3
	dm/aKbrP4lMXVPFSeU5/6WRuzAfNU4B4EFKB7JBc5B6O/p5YjgpB4bnjjrhYB/Mi
	Dzm7sqP7NR2Ubp8GbywZamPMoJZvoiGLkVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759875183; x=
	1759961583; bh=AMZokNPRoZ7ycmlziGgZ9LqFfoPkN5NkF0uIpAhrpi0=; b=e
	pdCswYoS6gJkZGEv6fE23IJXXAciPI3xTNwCsBikLL7h/I4Z+wGGgv5LR/8S9Czp
	T1PrbbBByQHSg3IROOGvqfSLqvj4TFs1l+HR3lAisZB9AqbMZN4RpMrk7UjDehTr
	CxH5evqMmFOAIq+qXyRZ75kvC7RV8LlPc88Tf84ro8WruTxE61WN+shk9c4sSJ6n
	+P94GFmxxgN9YPaydmOHcYZ6anVs5pbI1D3XnyYEWdeQjYdZrO3zYMbyi+7zJuRM
	auEvkezcKTM7LsLIQXHFD3fEI/Jh8r64gek1edzmMIGp1Y/75OI540gNPlGCixcu
	TlW8pJlAWXHWHgctrXZYQ==
X-ME-Sender: <xms:b5DlaJBTNIAw_EvR7o8UXO7MkZLDo9zzLoHY9hC0Ya-U9PUiW8tPog>
    <xme:b5DlaFHQXm2tE46dbw97rDmhb_mUBDuvdEgMkenjiXKv1OGO0bn9pK_LfKcX1bfxu
    qFJrNU5Bk2r8NBQHG9DsPP_G1SqsT9vijNfE2_b3Lni_6GGSw>
X-ME-Received: <xmr:b5DlaLDm4pcu2ylwja9NrL0rNHgz-nMt9E9nJeIXLz4BkPsmM7hxOGCpBNf4DxyQWyYWooX0fDphdClvyLqJP9q7WjwQ67vaVWhS4A0e40bk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    gvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b5DlaFUt0xjXEEh-NI4PXGEuwUNPKVPRMwP_wlAyPveFfr538sdRQw>
    <xmx:b5DlaPoKTh8Yc92HFvfWO1rVJhqSsAx-GjiQZuhFR-WSFomyYHPhVg>
    <xmx:b5DlaBSkadA_yk_UMPKR03kMqLNLPS_7TTBo3lT8Ei_9eZZf5xnbkg>
    <xmx:b5DlaJ3PPc8Pwcahv6fFxEGTBp6ZctHDiCSGfDayXO9fvINWg5PFmw>
    <xmx:b5DlaGm_xskLgfIdCt36zo64tdKNjDPM7Kfier3HM2bD0fFS-Dy6yeBX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 18:13:01 -0400 (EDT)
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
Cc: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] NFSD: Do not cache solo SEQUENCE operations
In-reply-to: <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>
References: <20251007160413.4953-1-cel@kernel.org>,
 <20251007160413.4953-4-cel@kernel.org>,
 <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>
Date: Wed, 08 Oct 2025 09:12:53 +1100
Message-id: <175987517335.1793333.17851849438303159693@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 08 Oct 2025, Chuck Lever wrote:
> On 10/7/25 12:04 PM, Chuck Lever wrote:
> >  RFC 8881 Section 2.10.6.1.3 says:
> > 
> >> On a per-request basis, the requester can choose to direct the
> >> replier to cache the reply to all operations after the first
> >> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
> >> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
> > RFC 8881 Section 2.10.6.4 further says:
> > 
> >> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
> >> cache a reply except if an error is returned by the SEQUENCE or
> >> CB_SEQUENCE operation (see Section 2.10.6.1.2).
> > This suggests to me that the spec authors do not expect an NFSv4.1
> > server implementation to ever cache the result of a SEQUENCE
> > operation (except perhaps as part of a successful multi-operation
> > COMPOUND).
> > 
> > NFSD attempts to cache the result of solo SEQUENCE operations,
> > however. This is because the protocol does not permit servers to
> > respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
> > always caches solo SEQUENCE operations, then it never has occasion
> > to return that status code.
> > 
> > However, clients use solo SEQUENCE to query the current status of a
> > session slot. A cached reply will return stale information to the
> > client, and could result in an infinite loop.
> 
> The pynfs SEQ9f test is now failing with this change. This test:
> 
> - Sends a CREATE_SESSION
> - Sends a solo SEQUENCE with sa_cachethis set
> - Sends the same operation without changing the slot sequence number
> 
> The test expects the server's response to be NFS4_OK. NFSD now returns
> NFS4ERR_SEQ_FALSE_RETRY instead.
> 
> It's possible the test is wrong, but how should it be fixed?
> 
> Is it compliant for an NFSv4.1 server to ignore sa_cachethis for a
> COMPOUND containing a solo SEQUENCE?
> 
> When reporting a retransmitted solo SEQUENCE, what is the correct status
> code?

Interesting question....
To help with context: you wrote:

   However, clients use solo SEQUENCE to query the current status of a
   session slot.  A cached reply will return stale information to the
   client, and could result in an infinite loop.

Could you please expand on that?  What in the reply might be stale, and
how might that result in an infinite loop?

Could a reply to a replayed singleton SEQUENCE simple always return the
current info, rather than cached info?

Thanks,
NeilBrown

