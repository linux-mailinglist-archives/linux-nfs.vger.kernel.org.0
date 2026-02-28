Return-Path: <linux-nfs+bounces-19438-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vk4ZBlvNomll5gQAu9opvQ
	(envelope-from <linux-nfs+bounces-19438-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 12:11:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E961B1C2808
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 12:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B7DB3012846
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777442E00A;
	Sat, 28 Feb 2026 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbMQcskD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD942DFEB;
	Sat, 28 Feb 2026 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277078; cv=none; b=GgKwYnQKraptj6mTe1VEQ7VKE6HpfVJDGIGoDU6JoG/3N9tvZ7NXhB+FmhMf4+2z7X/jMZrUiR+5k8d4WJ2YjezP7jdPWQh8K9PcTpDfz/BaZxq5sQnGl0pE9DbUpWSYmTQels7IQ4QkmUhUSIqwMeUi7ySjgQoYHriG7RL149w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277078; c=relaxed/simple;
	bh=qeJjeeYo7h+jV66lUjMWyEjvn5PUYwkmIU9ffj0uwZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFvXDpx6+RvVjY/O59P96zrgb7mAGy6yNMavPx5J4Ucvdk0r1XBeZ//kF7IUQnH1Lh4LK09D4vFd/tNCd2rcI/G/lnjC0wSMV35haSC7X/U9p0j1IkGG0VvyWE416Zbl2ZayBrN/aWbiR0tG/j5InC3tJmPGOT/9oUoPcvce5u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbMQcskD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772277077; x=1803813077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qeJjeeYo7h+jV66lUjMWyEjvn5PUYwkmIU9ffj0uwZ4=;
  b=PbMQcskDTU01DJcIs4HnyZP0/+I6EYJuesXJ7R9RsM0jD5Xh7tzLuyNc
   oEtQTBhQSjZD+Kgz6uNBXJNGgSia4CgREKBtV/gkUVyAgH87Bwatf3Um8
   utIvc8Cp+QaZyVhzDSOt9PH+eY91sEIE+PuJYOdKRRg52a5L/3gAabBcB
   JDCLOtYPtTAKT0oHU8yM+qIUTQK3+2RnKGgFSMbL4bCJvZvXN1LOhDSwJ
   yROlFC+UghX+ssDWt43Dvbl+bcdR/OFPqpqSPMvFAsalYtYULJ5yVjOjK
   4cycB4aYS82n2l0BUmepgKJ4a3D/vNM3jfAzEgwHIjSoVUpxVE6BZ+gGm
   w==;
X-CSE-ConnectionGUID: SCgzXqflQUmMIBCyTCzrUg==
X-CSE-MsgGUID: uhmhNzptR+a4xZZtAUkJeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="75953792"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="75953792"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:11:17 -0800
X-CSE-ConnectionGUID: aefoXC9oRfOTlOj+Up/Z2g==
X-CSE-MsgGUID: 1XdQ5didTryw51+mxbO38g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="214490364"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:11:12 -0800
Date: Sat, 28 Feb 2026 13:11:10 +0200
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
Message-ID: <aaLNTpODbiNCwmps@ashevche-desk.local>
References: <20260204202437.2762161-1-andriy.shevchenko@linux.intel.com>
 <177024270291.126397.9981743455921781902.b4-ty@oracle.com>
 <aYXDpqqM0qrEVzvy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYXDpqqM0qrEVzvy@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,hammerspace.com,vger.kernel.org,lists.linux.dev,oracle.com,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19438-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Queue-Id: E961B1C2808
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 12:34:21PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 04, 2026 at 05:05:35PM -0500, Chuck Lever wrote:
> > On Wed, 04 Feb 2026 21:21:48 +0100, Andy Shevchenko wrote:

[...]

> > Applied to nfsd-testing, thanks!
> 
> Thanks!
> 
> FWIW, I have got a success report from LKP.

Any estimations when this appears in Linux Next (or even vanilla)?

-- 
With Best Regards,
Andy Shevchenko



