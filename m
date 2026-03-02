Return-Path: <linux-nfs+bounces-19490-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGK3LTY4pWnt5wUAu9opvQ
	(envelope-from <linux-nfs+bounces-19490-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 08:11:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CF1D3AE2
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 08:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A75103005142
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 07:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E5383C62;
	Mon,  2 Mar 2026 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDEnjBC/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20937702F;
	Mon,  2 Mar 2026 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435504; cv=none; b=XKzh+N0lNYP8Zv0slcKdwYpt8Y1P0rPrGfQ4AsANRSYgisBcA/P4HoSN7AjAQu6ocOoX5r6uAXRJoaVht5rlJxcleRtrsUWHAByqDZoKoB8ClYvNzZrOsVUWrDMk70rD4hM3wOIQVpH3nw9dL+qUgVACS4THX7/tVN6yodKZzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435504; c=relaxed/simple;
	bh=dw3y0ZYsmbmXggZenP0NempbD26buVG5VGWsEkxE7pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEXUrdT+4WaX6Pf/F8kuLsP0uUdBouXhFP027924hCl/2kXqBNPMCDh5KPCGfyUmpEvPk+D2Qo2dZft4Xw/mn2U+gPQI08nfVcZcyYwTJcCqVEXdClnpFw10XduBceR5ZLvBEMkMSKeymUfdq+LSaePlVdJ1cOVTrNk/hfyGzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDEnjBC/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772435501; x=1803971501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dw3y0ZYsmbmXggZenP0NempbD26buVG5VGWsEkxE7pg=;
  b=cDEnjBC/6lM3ONhMxKpvz9aWB7q2jIwQx2W/76Y2TqnoJzPK7Lm2yW3K
   He2AyoGVSgrN6ViOtdfqsyUZvwckvDXuG7bCnrJBemVGdAIebTZXLV9Vq
   Q8r+TyZB1u1TWUIWZvruRpfIJUy0AyuIXNSfU6wGvmzjunlQHY9H2phMr
   rRhkys0iJ16FfaWmDvqNSZfRou87MPVymcpDIAI3ukrJ8mK/+5At4tiYx
   kDoSl8EU5kqG3zECih5QKxIwdb/eMSVOaWmfDSov1bYdulQ6E/xYQ7I+e
   XZIvqyrFqcDMOr9WSuTG1cmub/Rve4V+SNlI2KdYMzEP89gkx8kgfaCZf
   w==;
X-CSE-ConnectionGUID: 4VoHbrjCQ12X/FP3XHxHgw==
X-CSE-MsgGUID: zty68Ck7Q76RhwlOJxQYcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84901544"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84901544"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:11:40 -0800
X-CSE-ConnectionGUID: ba4D5QFXRH+vlpV/hQieQQ==
X-CSE-MsgGUID: O7XdcXJmS/6H4IZriEXdWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="217465832"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:11:34 -0800
Date: Mon, 2 Mar 2026 09:11:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
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
Subject: Re: [PATCH v3 0/3] sunrpc: Fix `make W=1` build issues
Message-ID: <aaU4I1l5RiZWMNZR@ashevche-desk.local>
References: <20260204202437.2762161-1-andriy.shevchenko@linux.intel.com>
 <177024270291.126397.9981743455921781902.b4-ty@oracle.com>
 <aYXDpqqM0qrEVzvy@smile.fi.intel.com>
 <aaLNTpODbiNCwmps@ashevche-desk.local>
 <bf983b54-6a1d-4520-b07b-29cba47d5665@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf983b54-6a1d-4520-b07b-29cba47d5665@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,hammerspace.com,vger.kernel.org,lists.linux.dev,oracle.com,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19490-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC6CF1D3AE2
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 12:02:53PM -0500, Chuck Lever wrote:
> On Sat, Feb 28, 2026, at 6:11 AM, Andy Shevchenko wrote:
> > On Fri, Feb 06, 2026 at 12:34:21PM +0200, Andy Shevchenko wrote:
> >> On Wed, Feb 04, 2026 at 05:05:35PM -0500, Chuck Lever wrote:
> >> > On Wed, 04 Feb 2026 21:21:48 +0100, Andy Shevchenko wrote:

[...]

> >> > Applied to nfsd-testing, thanks!
> >> 
> >> Thanks!
> >> 
> >> FWIW, I have got a success report from LKP.
> >
> > Any estimations when this appears in Linux Next (or even vanilla)?
> 
> Applied to nfsd-next just now. Should appear in linux-next the next
> time nfsd-next is pulled (Sunday night US/Eastern, maybe?)

Yep, I think it will be in today's Linux Next, thank you!

-- 
With Best Regards,
Andy Shevchenko



