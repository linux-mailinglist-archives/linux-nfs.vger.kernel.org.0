Return-Path: <linux-nfs+bounces-18711-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL+BDSp4g2mFmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18711-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:47:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A8EA798
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB2CA301C90C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530F32694F;
	Wed,  4 Feb 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7Ua2cgs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59290324B3C;
	Wed,  4 Feb 2026 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223506; cv=none; b=tqa0ITACixAmYhNkK8xsXswb2sJ7i7wR+pPiUphvLO85z7FSbJHsRSMtIbsM3DrivaMRFQRgphTDXMPIQnF2P9SI4CV4wUrbdpp5tCeDfcYH6MlCr359ah/9mUftP2k6pe5VvIHZoOy6ZKUulJ6E00WodIKPJDcRx4VEjGDyomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223506; c=relaxed/simple;
	bh=n19s5ZUMufz9NZJeogBuotiGBJiSfjx31oZB1Aw3D2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4U86c1IoyDPpzN0Rl5K3P6jee/+UwNmfTgoSEHdXBaKDHh23zA0ja8gXfB9uBtW9tRSi60HLkqGyWwZhybATH3SIGo4uH1/tATf6TPA4JapcYFsUk91F7y7k1J69j2xnITUUfLMCMH7z+p7H/SSztf0ZOPhIFNFwjnqvlrzPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7Ua2cgs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770223505; x=1801759505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n19s5ZUMufz9NZJeogBuotiGBJiSfjx31oZB1Aw3D2U=;
  b=V7Ua2cgsW2CBXiv0UbcDY+hDcbnIi2ya9UuPnkUmNZF9rcEJ8o77o9PE
   CgQoxabU0nVVffjXBkfoUE1ZlOksSSuZY9Zja+1Vn9JcjKLg0hDZlV4Hc
   tCYuyZmxPU/Re3OlZO1fFImTAr73lTaE9OQTDJT79gTXolw3bGkVVLcOZ
   SL+9TjnsOSFfVtM058EH5DdCfB58sIFPeaMPUTlKHff9K1vz7HufEc1u1
   /qt5MEKGTDNaRvE94UHMHDk3v3N+1nj80k+VEqpezXjmgUmrrfh5FPKH4
   8P8c8Zvg+vZxeLhCRJbRFBgry027uVkBujOnUklnHHZHCGxs2HGY1O7HK
   A==;
X-CSE-ConnectionGUID: JAiZzu1lS/SsXRiolfNLJg==
X-CSE-MsgGUID: gxwLOWI1TsSiKO0mtWKz0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88833825"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88833825"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 08:45:04 -0800
X-CSE-ConnectionGUID: IPUFOOQ/SnO175GWs5gOXw==
X-CSE-MsgGUID: uO9ee+3aR7mmg04tGC8BgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="240888772"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 08:45:00 -0800
Date: Wed, 4 Feb 2026 18:44:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev, Trond Myklebust <trondmy@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 1/3] nfs/blocklayout: Fix compilation error (`make
 W=1`) in bl_write_pagelist()
Message-ID: <aYN3ilagQ2XVg01X@smile.fi.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <20260204094500.2443455-2-andriy.shevchenko@linux.intel.com>
 <5bdb5b9d-30eb-4511-b839-21b073a6ce43@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdb5b9d-30eb-4511-b839-21b073a6ce43@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,kernel.org,vger.kernel.org,lists.linux.dev,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-18711-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,oracle.com:email,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: BF5A8EA798
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:53:26AM -0500, Anna Schumaker wrote:
> On Wed, Feb 4, 2026, at 4:41 AM, Andy Shevchenko wrote:
> > Clang compiler is not happy about set but unused variable
> > (when dprintk() is no-op):
> >
> > .../blocklayout/blocklayout.c:384:9: error: variable 'count' set but 
> > not used [-Werror,-Wunused-but-set-variable]
> >
> > Remove a leftover from the previous cleanup.
> >
> > Fixes: 3a6fd1f004fc ("pnfs/blocklayout: remove read-modify-write 
> > handling in bl_write_pagelist")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Anna Schumaker <anna.schumkaer@oracle.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



