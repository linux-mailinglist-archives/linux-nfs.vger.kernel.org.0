Return-Path: <linux-nfs+bounces-3573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045108FD82B
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 23:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B41C254D6
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140315FA65;
	Wed,  5 Jun 2024 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTa33+q1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0315F40C;
	Wed,  5 Jun 2024 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621989; cv=none; b=DkcDlSqxAl+lZiFGaW8GQZ4SPsiIWKm4vrL/udKrHrmdY/JRZfTU7duvQgDhN98QdBwxrQwMgBzdtvlicn+2SSWXnGPAKWtWGHqN3eA4By0pN+jF5BmnafpkhoEd5sXcFsEo6ea1PmrvspEuT2UBdc8Fn/WHEHv9AravqOuG+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621989; c=relaxed/simple;
	bh=hWLUBTXsqjYpf/Y+7jj6qTjc3Zt+ncVlnVqufpZ0mHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed0V9RYFOfS7eam38R9Kvg9gxhVTN97K/D4a4Bh9Sws8S47RLNcZWnHj6WLIBwHwO8ykfq+ORh3QH6IBUQm1/HiLPPcMLXPr6QxonBY/jAHNT+tyf+kXjAtHsOiCqd60xGluAKnJqJVdsCppB2bDRnSn2bfeAq1uVFZHYqyFpt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTa33+q1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717621988; x=1749157988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hWLUBTXsqjYpf/Y+7jj6qTjc3Zt+ncVlnVqufpZ0mHI=;
  b=nTa33+q1LtJW67JszZ2QNPBmw3yk37BeSyBgNvigwllHLqYv9JF29Plm
   0N3vpyT1WZGd1/+DMnn5feJZj9pAy4ZD1tlJ0dYZncMton+rTBzDv4DPV
   1+qHjjRs0sqkeZ/boVJIoFKCliM58HaLIcm/lDw2sudWCa4lGb6PIrW+x
   GWCzthTq4+dp1+6psv5weu8GuOnI+ojIfgGoVVWhzJG/fvFhyBIkbDDTt
   vep0JNv1IDTnhfiUwysx7EwAE3chgIXJ/J7+LKIvVTZkB7vHvmoGQK7u1
   hvau1VzrzUv0rFGyyJpCGhP/qxMyTxw8Y0E3RWH2ctwRUb06voKZlgZBV
   w==;
X-CSE-ConnectionGUID: 5rNvcfxgQoyolI61zZq4zQ==
X-CSE-MsgGUID: oeceHNYJTv2VwltZpBOXig==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="36789651"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="36789651"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:13:07 -0700
X-CSE-ConnectionGUID: Y0QGY5eiSruNNRnmXE6QJQ==
X-CSE-MsgGUID: 4jUMf+QVTGSKoNFkVQCA4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42295277"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:13:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sExwM-0000000Dy9L-1NDe;
	Thu, 06 Jun 2024 00:13:02 +0300
Date: Thu, 6 Jun 2024 00:13:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v1 1/1] lockd: Use *-y instead of *-objs in Makefile
Message-ID: <ZmDU3q1Vfv9xkipa@smile.fi.intel.com>
References: <20240508151951.1445074-1-andriy.shevchenko@linux.intel.com>
 <ZjuijMla78l+sl5S@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjuijMla78l+sl5S@tissot.1015granger.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 12:04:28PM -0400, Chuck Lever wrote:
> On Wed, May 08, 2024 at 06:19:38PM +0300, Andy Shevchenko wrote:
> > *-objs suffix is reserved rather for (user-space) host programs while
> > usually *-y suffix is used for kernel drivers (although *-objs works
> > for that purpose for now).
> > 
> > Let's correct the old usages of *-objs in Makefiles.

...

> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Unless, of course, you'd like me to take this through the nfsd tree.

Why not? Otherwise it seems nobody have taken it so far.

-- 
With Best Regards,
Andy Shevchenko



