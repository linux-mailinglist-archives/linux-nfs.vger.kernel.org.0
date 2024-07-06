Return-Path: <linux-nfs+bounces-4678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E4929168
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 09:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B45B1F21FCB
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 07:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D021C2AD;
	Sat,  6 Jul 2024 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="X1YogIQY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfcBYP3+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDB1BC53;
	Sat,  6 Jul 2024 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720249873; cv=none; b=XW9ml7szzLG+dc64BYL/aLobvSMVoLMnupF9C0LU9RrXTiruWKoIYbw1gAagO0Q4aGtmJxi865N2J120c4Je5mmnwmAlgSBAjtUNWw32JuI8RSsR/PAqhhuVvHG394aC3ycMT7hPkwJBAQNfUU4Z8gmwUVbzNIaqNVUWoKEusOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720249873; c=relaxed/simple;
	bh=Lm3LdK6zABgjXBCb/NQ6EpvQi1zCJ7Lw7aCYYa0UYVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABCxtNbScwNGvAQZ5wKZzjrphrykNFgts3eIffRUNR8L+YW0FXN7hv54jR8MzNEN81bo/4GkkGdh5ucX42T7GYPrqi07M/tGrS72TPXQpVID1lm1gOVhQpWrxrw5KHtKqAxVYCkWP7qhD4BrSU2UJQULwH8BOkuej6cD/4zOtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=X1YogIQY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfcBYP3+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2A4A31140091;
	Sat,  6 Jul 2024 03:11:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 06 Jul 2024 03:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720249870;
	 x=1720336270; bh=DZNLD/IW5otGUh4hw/mSAd6wKC+4YoRkqCUTzyDywq0=; b=
	X1YogIQYdt02lx4L6ENwXj8iCHklT3eYseveIV/rBG9DN5UpUJFJfg7Rd7UxwlL3
	e5Y2N8kZE/FG2uYPCeY3VxbQ7m0fYVXVUNHDIavX8ZL6nTGMMMWK0k3GOWtjOTBs
	OsT5J3ndh6b8XMQHSDHuDUOgfBRtg/pYy9V4YAYOH34q0lowo6UcKHsH0g2e5tHD
	lNUF079R45fG6gM5S4KAsubJwyS0xoW/Qa8KX/o2GEcZFxqRBQlZUgeF4EU1oquT
	DpAE9F4zh9y7d7FuGHkr5c4RomK+Igz6hoBIFkFjMgSYuTV3Axr36LmPrVwTh3Y0
	7awObc4pUtcl5X1L0l1J/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720249870; x=
	1720336270; bh=DZNLD/IW5otGUh4hw/mSAd6wKC+4YoRkqCUTzyDywq0=; b=Y
	fcBYP3+Gzm74S1nQgh//3AqD0kHErf4RPURR+qwvYxjFmL/8sK8eDaxm0Zc/h3R4
	faPug7TzgR8lr83SviBkgqT5rq1dmFYew2800E8H7g+J6u3FjY7YcxbawNtUq8ea
	Oqa/B4C8FWZkpTr5V7vC1U5+mPCtP1eK861EnD4CaqWSRXVM8j5CUe5u3T9xmg+y
	nMRNg4wuDJWx+EW3SD5C5L+WwvUgja/vHkMsKkB6HjF2vEJJ/O9Hnkqyt3Hg/kiu
	5g/iWuK2rTa/I5CIrd9PdpFyBpd+AhkLJXkjNFyBuo2RdxuB2FfTPOjb40kbhXDX
	RODgsHD5NpZY2xhTGCOcw==
X-ME-Sender: <xms:De6IZsaXiIs4ZM0N5W6kfw61zpqrtvEKzNvpwzqG-lH2Usp1O267Pg>
    <xme:De6IZnafAgizcH6ivca3z5VyUKvBOhtjAn9RZ4sel2QoUbMv9oqPz_RWwWUmAPTLW
    sMjxv5gfx-6vg>
X-ME-Received: <xmr:De6IZm9BihC0ujcc-ws9a2pS8Wp25QlrFx5iOHEKBP3qomp3SZVcTP8o-5cQpFp-y9Eh18s1GChj63cVvimUI-JTaVsNyFtJ5bVoBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgke
    ffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:De6IZmoC3xo9Ec7oAZWYF7T6dirRsAsPObMAiz5slz0_i-LcY69S8Q>
    <xmx:De6IZnoHGy9CiEvt4sfVBL3UXBmaHIJESBHYxIQaIBDMABFm73CC_Q>
    <xmx:De6IZkRnmIiuzjPmNcS1sPj6XZrDTz_0ccjnOCL2iW25n9aTqlorcQ>
    <xmx:De6IZnqh-LJht9MMQFwj8cA3ydIDv50QfS2YzB3uqZjEr9TyQnFLKg>
    <xmx:Du6IZqVP5vpaY-aR56MsCw-N2ew4rDLUKjkZjR4hF_pEvznfgTkNyvhk>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jul 2024 03:11:08 -0400 (EDT)
Date: Sat, 6 Jul 2024 09:11:05 +0200
From: Greg KH <greg@kroah.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	linux-stable <stable@vger.kernel.org>, Petr Vorel <pvorel@suse.cz>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	Avinesh Kumar <akumar@suse.de>, Neil Brown <neilb@suse.de>,
	Sherry Yang <sherry.yang@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Message-ID: <2024070638-shale-avalanche-1b51@gregkh>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>

On Fri, Jul 05, 2024 at 02:19:18PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 2, 2024, at 6:55 PM, Calum Mackay <calum.mackay@oracle.com> wrote:
> > 
> > To clarify…
> > 
> > On 02/07/2024 5:54 pm, Calum Mackay wrote:
> >> hi Petr,
> >> I noticed your LTP patch [1][2] which adjusts the nfsstat01 test on v6.9 kernels, to account for Josef's changes [3], which restrict the NFS/RPC stats per-namespace.
> >> I see that Josef's changes were backported, as far back as longterm v5.4,
> > 
> > Sorry, that's not quite accurate.
> > 
> > Josef's NFS client changes were all backported from v6.9, as far as longterm v5.4.y:
> > 
> > 2057a48d0dd0 sunrpc: add a struct rpc_stats arg to rpc_create_args
> > d47151b79e32 nfs: expose /proc/net/sunrpc/nfs in net namespaces
> > 1548036ef120 nfs: make the rpc_stat per net namespace
> > 
> > 
> > Of Josef's NFS server changes, four were backported from v6.9 to v6.8:
> > 
> > 418b9687dece sunrpc: use the struct net as the svc proc private
> > d98416cc2154 nfsd: rename NFSD_NET_* to NFSD_STATS_*
> > 93483ac5fec6 nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
> > 4b14885411f7 nfsd: make all of the nfsd stats per-network namespace
> > 
> > and the others remained only in v6.9:
> > 
> > ab42f4d9a26f sunrpc: don't change ->sv_stats if it doesn't exist
> > a2214ed588fb nfsd: stop setting ->pg_stats for unused stats
> > f09432386766 sunrpc: pass in the sv_stats struct through svc_create_pooled
> > 3f6ef182f144 sunrpc: remove ->pg_stats from svc_program
> > e41ee44cc6a4 nfsd: remove nfsd_stats, make th_cnt a global counter
> > 16fb9808ab2c nfsd: make svc_stat per-network namespace instead of global
> > 
> > 
> > 
> > I'm wondering if this difference between NFS client, and NFS server, stat behaviour, across kernel versions, may perhaps cause some user confusion?
> 
> As a refresher for the stable folken, Josef's changes make
> nfsstats silo'd, so they no longer show counts from the whole
> system, but only for NFS operations relating to the local net
> namespace. That is a surprising change for some users, tools,
> and testing.
> 
> I'm not clear on whether there are any rules/guidelines around
> LTS backports causing behavior changes that user tools, like
> nfsstat, might be impacted by.

The same rules that apply for Linus's tree (i.e. no userspace
regressions.)

thanks,

greg k-h

