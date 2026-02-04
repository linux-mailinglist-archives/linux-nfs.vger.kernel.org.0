Return-Path: <linux-nfs+bounces-18707-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MSeEpFbg2mWlwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18707-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:45:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6610FE750C
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C58D73004690
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2527FD56;
	Wed,  4 Feb 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPt4bptm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2710C1C5D77;
	Wed,  4 Feb 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216333; cv=none; b=g3wmGFhMZud5HJdDEx62+6Uzn+U06Srphr4B6NNapwZlMb2JaLsYarxsKk7yiOzVWc7kWZCwawk3fkp04jBs3rw+dWFbVHql+2DuPCzLUb9t04CJgPdtpmBRgNvvEVBqyIRdPyParOhInWKvwIGKJkuxgqEWl5SN3P46eIy7P5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216333; c=relaxed/simple;
	bh=JUutqR6XP+ZpDtLSNZPJ67DHL3LNXD4Ds8jj8EUno9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPBIrlr8bZFdKlLkHRdNYq/CcvOjMlpEqRvkEvTm2yD91GsHJFQpb10MYjfWMFlWFWelJTSjwWmIRpCBqwbGyRqUwJ4WFPbRnxpfhhjkuoo4iriU/EuNFntNaqTVpP5RLvjVPfKLebkz4F8TUCUkKveDBalGprs5muoM6+qGyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPt4bptm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770216333; x=1801752333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JUutqR6XP+ZpDtLSNZPJ67DHL3LNXD4Ds8jj8EUno9M=;
  b=gPt4bptmUpi+XxgsDK5wqiZsVgZgyd2zjcsgS3v/Qgpi8T4ORBre1NvM
   wjMTaqdYo1iU5Wq6Y7X0vW0bvNrwPQ1Y0IR647pKHiud4dJ85zG31ZSKl
   OUTHDC+fAJLfDzA7hW+al2B+XPqcYWY2f53aAfBysMN+8G3iQgpGUjhk6
   ywe/YizbywpLtdt/DzDDy/NsQ8KV4Ek24GvHFwJLrApqtY3Z2fXElqtd1
   Elao998zMkuUohGbcASMRJjBT4wFOme+Zhi9IvAbJt7gOUzpog3UmJ3N4
   7Cm66p011aTP8wJ/Ifm8cr3W+fwK5VFS9CJsK9MQVeEFX33KIShAkHuvB
   g==;
X-CSE-ConnectionGUID: CCD76p1yRqeJ5RVaxBj/FA==
X-CSE-MsgGUID: 4JiYtFq3SW6IkW1Hr+MBCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88981218"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88981218"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:45:32 -0800
X-CSE-ConnectionGUID: muuFos9IRT+vdf4cNCidEw==
X-CSE-MsgGUID: oGYBZYXGTI6hEz+rip5Riw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="233104394"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:45:28 -0800
Date: Wed, 4 Feb 2026 16:45:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev,
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
Subject: Re: [PATCH v2 0/3] sunrpc: Fix `make W=1` build issues
Message-ID: <aYNbhhJJgpv0TjmY@smile.fi.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <9859fe54fded87e720e375b1b267908437480f47.camel@kernel.org>
 <65f86149-eafe-4f83-ac18-f3aedd516152@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f86149-eafe-4f83-ac18-f3aedd516152@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,vger.kernel.org,lists.linux.dev,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-18707-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 6610FE750C
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:30:30AM -0500, Chuck Lever wrote:
> On 2/4/26 9:28 AM, Jeff Layton wrote:
> > On Wed, 2026-02-04 at 10:41 +0100, Andy Shevchenko wrote:

...

> >> Andy Shevchenko (3):
> >>   nfs/blocklayout: Fix compilation error (`make W=1`) in
> >>     bl_write_pagelist()
> >>   sunrpc: Kill RPC_IFDEBUG()
> >>   sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op

> > These all look like good changes to me. The first patch should go to
> > Trond/Anna and Chuck will probably pick up the other two?

> That's what I was thinking, as long as there aren't any dependencies
> between 1/3 and the others.

There are no explicit compilation dependencies, but if one will wonder
in the future the third patch alone may "fix" the first issue. That's
why I prefer them going together.

-- 
With Best Regards,
Andy Shevchenko



