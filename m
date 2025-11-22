Return-Path: <linux-nfs+bounces-16648-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F7C7C067
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C988E3A45DD
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E7913B7AE;
	Sat, 22 Nov 2025 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="CJ7tSz2v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="15Bffyq0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9767261D
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772433; cv=none; b=NI7oYD1x9OlHvIQuXgw0oDIB90WrQG5nBuoQxjnoXUEFwT9D9rTOjF8UENjOEKhfhjhwduZEYKlrEBdGI3V5HGfLeU96kABWCy6PvLOyfdZbr52x3KxnFEvcbvWHbKhgQJvjdOiDMVO511nas2upCTI+XiN1wtrmHkKJHK8Onm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772433; c=relaxed/simple;
	bh=bIItHfRqGPGCQlOlvZCE40qQ49XuN/wav+aMob9nEhI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YO1Vk2Zi5zeBWDp6OH7UrlXgiuTvQ2DLLDPeijXFFrobDELit//DOWn1+aJOc/doNczpjK0G0QYsheYK9AjLJeYMEa5zTgkDOwR+w6HuwcgU/joAakv2rOV2+59MkU1D9CgXlxGAih6NG/4CSbEHYi3ZOyu/CZK/Abbh0DTCDqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=CJ7tSz2v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=15Bffyq0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 90370EC00B4;
	Fri, 21 Nov 2025 19:47:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 19:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763772430; x=1763858830; bh=9edT/+/cD4jnI6v5kgEKE2h2JRQ1tJgJLyv
	EMGCACeQ=; b=CJ7tSz2vCMit8nuWTMjkPPQa/zY8snZnzCVpw/jPRChRfzWHLUT
	xsJE+SyVtZzx4N/j0FuUIx0MPKA4TZVVwJYPUXzS6Lq/2dQSP4CctfvjCsZ5vjO0
	yexPjTkiGtkgelAtU/mQnT3xi8nfi2RD3ENsTKj/BnKthZoCMSsp6AayWV4A0vc/
	LXPp0Qlod6cWV1kq9SQFl/qsAiwJYY45dRpNri2tkZaNxglLIzj8InAsHjTAllmT
	Dk0K0n0csHlmQ09BTohw4O4h+jS90x3/JElZKRUXQh6z3isqxxO+3yijmIm9z2AT
	+7OT2AP9zF3iw1Dypp3sfBI/71WelFFV+mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763772430; x=
	1763858830; bh=9edT/+/cD4jnI6v5kgEKE2h2JRQ1tJgJLyvEMGCACeQ=; b=1
	5Bffyq0C9THIgku4IhIPO415btdR2e/sgmrZcG7Zy7QCDZGenop/ZllKmIjZaXYV
	x6QvbiqQZlHO9nAdibP+MVuDvAu5Pet1rg+2Q0y8IW8rWP8URL5NILbyBUnXCehq
	f2lLRRGEvshKB64Eidzw4PONyAEHNSjKo95FI/rybJCdc3EQ2PUHGYLt1367lOva
	uqvUyPLjHdDZStOQVzxeHmcr6Db3UYUXujAQHBfqe3nrJozv1N7+1TLQIOED1XGf
	l/qVfdyYncVr6Tz/1GTsJmpC+DzzHgmeb6fDTV38VVJp0JFVts4Auz0DF2ggqZmb
	yOW0Xu90ZuHB5O/F0b+hg==
X-ME-Sender: <xms:DgghaY8ChgtsLA_CE8H_dpuFmXqzWgcz_1BE9CLEIdic4EVaO6xuUg>
    <xme:DgghaUbSoKOfs-F4sDFLpxUAGYFYTso35j5l3v9Y3iQglKm4nfh_06WguZa0n5kUL
    0y7odECls3VDInnZfd4MIWn3IWSRP2rXqtNFWBB44P2v49urw>
X-ME-Received: <xmr:DgghaX3Gr_1DhjKpC1PkaivmBbn5iRHO2n9NvkQsgbhLqoyRWVQAY3WVXLKc6QwEDJzVqRfuKwBicPsyh4QzNRuEjGv7nJ6st22ubV99ZJam>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DgghafZAVTVJfgspKgOp_4JiXt5d9Yf_Pf3K2_6qu10fPFbBTtw85g>
    <xmx:DgghafJ75-pt8Y6RkHJqUP__OMUdXrPmjkhPGPR75wudE_tSmxbVLQ>
    <xmx:DgghaeFQM6yTaO9PoSVl3xHdh6tx0V3-TJrne6Q9QX1cjxBsaU5Z5A>
    <xmx:DgghaWsM-CfH9Pa1VCHw-nIU3RqTvebIxVfS-3ZqgSdHv2RpxEdMZw>
    <xmx:DgghaWf8pZNY0Z2tLNnch6iJYyCQgNUtRfO7tnsxCRNL3uP2bfNqLAeR>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:47:08 -0500 (EST)
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
Subject: Re: [PATCH v5 03/11] nfsd: simplify foreign-filehandle handling to
 better match RFC-7862
In-reply-to: <6c346369-b39f-4b7e-b8c4-eff687304ccf@oracle.com>
References: <20251119033204.360415-1-neilb@ownmail.net>,
 <20251119033204.360415-4-neilb@ownmail.net>,
 <3097252a-8071-49ef-ad2d-1e9733540913@oracle.com>,
 <176358832223.634289.3617743312148292910@noble.neil.brown.name>,
 <6c346369-b39f-4b7e-b8c4-eff687304ccf@oracle.com>
Date: Sat, 22 Nov 2025 11:46:56 +1100
Message-id: <176377241687.634289.2886073708786543840@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 21 Nov 2025, Chuck Lever wrote:
> On 11/19/25 4:38 PM, NeilBrown wrote:
> >> Extending to match NFS4ERR_BADHANDLE as well explicitly does /not/
> >> comply with RFC 7862, as you say above. So the short description is
> >> misleading.
> > Does:
> > 			/*
> > 			 * RFC 7862 section 15.2.3 says:
> > 			 *  If a server supports the inter-server copy
> > 			 *  feature, a PUTFH followed by a SAVEFH MUST
> > 			 *  NOT return NFS4ERR_STALE for either
> > 			 *  operation.
> > 			 * We limit this to when there is a COPY
> > 			 * in the COMPOUND, and extend it to
> > 			 * also ignore NFS4ERR_BADHANDLE despite the
> > 			 * RFC not requiring this.  If the remote
> > 			 * server is running a different NFS implementation,
> > 			 * NFS4ERR_BADHANDLE is a likely error.
> > 			 */
> > 
> > resolve your concern?
> 
> Well the concern was mostly about the mismatch between the intent of the
> patch, as stated in the short description, and this comment.
> 
> But, without elaborating, the RFC does not place any mandate on
> NFS4ERR_BADHANDLE. It's hard to say whether ignoring that status code is
> going to be consequential. I'll have to study up.

Ah - I think I understand now. The text

 nfsd: simplify foreign-filehandle handling to better match RFC-7862

is inconsistent with adding adding NFS4ERR_BADHANDLE handling which is
*not* consistent with RFC-7862.
I'll move that bit to a separate patch.

Thanks,
NeilBrown

