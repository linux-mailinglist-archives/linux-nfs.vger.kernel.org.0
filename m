Return-Path: <linux-nfs+bounces-15076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1041BC6BB2
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 00:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B352B4E376C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0A23312D;
	Wed,  8 Oct 2025 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="DtUxzgnd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eG21fxe+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2995274668
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759961006; cv=none; b=VBhmFVcAV3J9WGdROPywh5GHdgqCPZwg6nWDuCigENMpi9mYUVf5kGgtQXhQ1xiW3bDN88A3r4QCnyA+jeyl+vP2okckMSaAdxzu58IZGsOUuFcDCTPjM+xKKYJoySLwOaeim2yzA4zxjcKVjUoN1bYXTRCfQOxoFl3LnOgH/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759961006; c=relaxed/simple;
	bh=gDlRj+GjfKphmzLOh6MGOR3eUI+2DawEXintQxAMI/Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jQO2D+IRZRHDfo+sD5kNgqId0H6O8DsiFHttoefk5QIfZ6kmqie2Ht++nFVt1OzihAh7OswxlvHFeklHlZKdubOhtwRsfYLv2WvL0cDFtqdxYil2vAD0b6y7Q/AwRqrLSG4fEnZOkmwXX3EvuTng3Q5ljDcv8eJ4GDFyBn8hh5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DtUxzgnd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eG21fxe+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C9C0FEC01E1;
	Wed,  8 Oct 2025 18:03:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 18:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759961001; x=1760047401; bh=AcgwONb+FSoURxSzBXQ/JmL/nCyJ66Btrt+
	GcScF9i0=; b=DtUxzgnddhWcq+OJkqTAs0mrea0K/l0NUYE98TQeO/QWs+unWtR
	Nc9GCZuoOEC/qIRCHNBxpLzJ5qxJI7VSbpYKnownnn+kGhJwsqUr/F6Owq7y1CWV
	tg14g7ApHUweqa5abmf9aKZjzZynpbhejSUZ4QdByHMq8zZKKfejKf+7/Lz3uOHe
	Q4vhgm7lvGzt/A3ENs+TsO1j27Bf3DDQQNOTZzaQcekiYiu5BKR3cZ+JROsjUGFh
	oS+FwtFzTQ8XqCPNuF8NDkad0vrGZDO6m2jL9PWqXVQxLeiiFCUBgTNcyuS+3jYx
	XIKTocBPvDzJSA1RLtAFn+AI0mL07HquQ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759961001; x=
	1760047401; bh=AcgwONb+FSoURxSzBXQ/JmL/nCyJ66Btrt+GcScF9i0=; b=e
	G21fxe+NUP8yRjGPSeBVwLoaPPY7D0ZcARtnECBdRGeLGTbf0CIGCpIP1bVfx5mi
	5baoZ3k8IqG0lzVglyJJi99L3P5OMOUQhUIzAFWPCOwmfjbd87OZLZwMInWnPTeh
	RVK/3m63yXUocd4S511ixYzi0seOTnCUjj6p0IolobyDZK/7pLibSGsH05/7W4h7
	sPcX5KC2DbJ+ZdmL2Rfaz245/Sk5x8NRgsTd6UTdTy169Ejsvax0TH6dFJmX67Tl
	gX4T/pxLuPtP7jTCFRqFEPYj/jK0C7UUIGkUdkPrKgNNJiGjvxxTPicEbEWcvM2+
	qSfYVkX6aWWdp4TFYcXaQ==
X-ME-Sender: <xms:qd_maOLgiCQOklqPe37TXNwMxdva105rEiB_Ch34IKSGnvEobpy1ig>
    <xme:qd_maIbQeNMAHu6l9xVC4gCgaHC5_TiwfGTPgX-w31gY2edd9HlgHXzWknWpzXJO0
    dqyVhHkZ0lpWueZA1D4jBikK41P_KVsdHvXmraybbNPpnzpmEc>
X-ME-Received: <xmr:qd_maA8JlfDnJADCTmE5bjc71M3ItDpaW22diUsJ2FZqlnMAxymyp963m5OlB-nSyVc71AClOR5X-LdPUUFz4FncXyTnzcFqw9JsWa0bu3QF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeggeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:qd_maJbDG0DQUwf1Pgt6scrTgMDf_MtjeYR_-cfsQR_AX4tSOD16Dg>
    <xmx:qd_maEPfh-chpITrtNL-kCZuMt-j42ZhBs40rhYEdI5k6n6ggGY1YQ>
    <xmx:qd_maFChgeWWq_wS40yVHitVUj5w0haOTJ2nYUbP2Cpe82CVaGHrIg>
    <xmx:qd_maLLqubikGD61vl_mtJ1oJEW0-XTGYjuEPcb6rq3b9FTIn9DYdg>
    <xmx:qd_maMHZt2ysSOKStJT88PQ_OwFcl7U_jKfhIvkUhlWgGb-QMvngUkTR>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 18:03:19 -0400 (EDT)
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
In-reply-to: <711bd35a-78b3-4309-9cb7-9e2c7a83a87e@oracle.com>
References: <20251007160413.4953-1-cel@kernel.org>,
 <20251007160413.4953-4-cel@kernel.org>,
 <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>,
 <175987517335.1793333.17851849438303159693@noble.neil.brown.name>,
 <711bd35a-78b3-4309-9cb7-9e2c7a83a87e@oracle.com>
Date: Thu, 09 Oct 2025 09:03:17 +1100
Message-id: <175996099762.1793333.16836310191716279044@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 09 Oct 2025, Chuck Lever wrote:
> On 10/7/25 6:12 PM, NeilBrown wrote:
> > On Wed, 08 Oct 2025, Chuck Lever wrote:
> >> On 10/7/25 12:04 PM, Chuck Lever wrote:
> >>>  RFC 8881 Section 2.10.6.1.3 says:
> >>>
> >>>> On a per-request basis, the requester can choose to direct the
> >>>> replier to cache the reply to all operations after the first
> >>>> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
> >>>> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
> >>> RFC 8881 Section 2.10.6.4 further says:
> >>>
> >>>> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
> >>>> cache a reply except if an error is returned by the SEQUENCE or
> >>>> CB_SEQUENCE operation (see Section 2.10.6.1.2).
> >>> This suggests to me that the spec authors do not expect an NFSv4.1
> >>> server implementation to ever cache the result of a SEQUENCE
> >>> operation (except perhaps as part of a successful multi-operation
> >>> COMPOUND).
> >>>
> >>> NFSD attempts to cache the result of solo SEQUENCE operations,
> >>> however. This is because the protocol does not permit servers to
> >>> respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
> >>> always caches solo SEQUENCE operations, then it never has occasion
> >>> to return that status code.
> >>>
> >>> However, clients use solo SEQUENCE to query the current status of a
> >>> session slot. A cached reply will return stale information to the
> >>> client, and could result in an infinite loop.
> >>
> >> The pynfs SEQ9f test is now failing with this change. This test:
> >>
> >> - Sends a CREATE_SESSION
> >> - Sends a solo SEQUENCE with sa_cachethis set
> >> - Sends the same operation without changing the slot sequence number
> >>
> >> The test expects the server's response to be NFS4_OK. NFSD now returns
> >> NFS4ERR_SEQ_FALSE_RETRY instead.
> >>
> >> It's possible the test is wrong, but how should it be fixed?
> >>
> >> Is it compliant for an NFSv4.1 server to ignore sa_cachethis for a
> >> COMPOUND containing a solo SEQUENCE?
> >>
> >> When reporting a retransmitted solo SEQUENCE, what is the correct status
> >> code?
> > 
> > Interesting question....
> > To help with context: you wrote:
> > 
> >    However, clients use solo SEQUENCE to query the current status of a
> >    session slot.  A cached reply will return stale information to the
> >    client, and could result in an infinite loop.
> > 
> > Could you please expand on that?  What in the reply might be stale, and
> > how might that result in an infinite loop?
> > 
> > Could a reply to a replayed singleton SEQUENCE simple always return the
> > current info, rather than cached info?
> 
> If a cached reply is returned to the client, the slot sequence number
> doesn't change, and neither do the SEQ4_STATUS flags.

Why is that a problem?  And importantly: how can it result in an
infinite loop?

> 
> The only real recovery in this case is to destroy the session, which
> will remove the cached reply.

What "case" that needs to be recovered from?

> 
> We've determined that the Linux NFS client never asserts sa_cachethis
> when sending a solo SEQUENCE, so the questions above might be academic.

It would still be nice to have clear agreement on what the spec allows
and expects.

Thanks,
NeilBrown

