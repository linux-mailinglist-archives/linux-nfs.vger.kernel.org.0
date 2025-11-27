Return-Path: <linux-nfs+bounces-16763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62834C8F8EE
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 17:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 575EA4E231C
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D5533893D;
	Thu, 27 Nov 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTogOGHz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F68239E6C;
	Thu, 27 Nov 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764262539; cv=none; b=ItBiqxZs5G7aVnBaOmx0x05Xo8x0l9270XLdAQrj6h3TZR8gRDJKDZtKW2EX3OXadDk2ekw5b93pk1dyCdcad97bbcqYuY0W2MuwmieCnCvDfV+LyXDs6M7ZW72UGFXprje90zZGs/w2Ke2FuD0nVxGN5inxEm5Tyo/eY4ejJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764262539; c=relaxed/simple;
	bh=E6DalLiLYzAqDfyAOfAZWRl5/yIE/N1l/sN8CNzkmf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS/+6GGtCuybdTgMbgmUUAkXWDHyC1TM45RcjHWj46K5xR3U3RQNdW0I8UpYKGWJzrUU5v5v7SV1w8s2fjScW1xPMkDfLyDopHP3grHEgwyGQp2y6LoRQEpjtWzH0Rpad+PAbQ8ePlC2WVTslhvZfMFrbC7vYggnEIKBfWI/Rsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTogOGHz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764262537; x=1795798537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E6DalLiLYzAqDfyAOfAZWRl5/yIE/N1l/sN8CNzkmf4=;
  b=MTogOGHzIigKNo+YhwktXnuGsgLOWzD2bhGE3trKmoLZLrVP9YkDEzwJ
   rJLevXCgshZCOlUr5iJn5qwJb7vxz2JPVH2oi94Tl+QKIyMMgDSQh33gP
   pBVGtGgAZw3baHfl9+Q/re06M+xGt3L8Lr6ra0quan3nxf6t+VgQCLjGR
   yedYGGNQA3EXD75H/sqAD66w+6f7iTpXN8xF1YOFcr2NP7EEI4RMNdpcb
   BVUdoWvGNPtvhYRXotqTDsa0KJkPmMgYmnsaVOs+JXNbQvHR0Rtjl4Nmn
   9JFKbRkKaz8+wIVMJ9ACrO1frAYnSlbGRYJiHC2HmfU9Xk6F5HObeGf0p
   w==;
X-CSE-ConnectionGUID: W9ovBQMWTo+XlqjSAB9WcA==
X-CSE-MsgGUID: hZ9W80QrQx+d+yyNbAzzdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="77416524"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="77416524"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:55:37 -0800
X-CSE-ConnectionGUID: Uf1RBSaCTFmv8E40k3sAQA==
X-CSE-MsgGUID: /mivqr2ET8+RoyhKjgg6jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="198220972"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:55:34 -0800
Date: Thu, 27 Nov 2025 18:55:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] nfsd: Mark variable __maybe_unused to avoid W=1
 build break
Message-ID: <aSiCg0i4wMXk6QxV@smile.fi.intel.com>
References: <20251113083131.2239677-1-andriy.shevchenko@linux.intel.com>
 <176338731878.4204.10224670039692915729.b4-ty@oracle.com>
 <aSgCyqR72Zu6TSSI@black.igk.intel.com>
 <087f6258-a605-4e8c-9fa7-420ec12bef6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087f6258-a605-4e8c-9fa7-420ec12bef6f@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 11:20:16AM -0500, Chuck Lever wrote:
> On 11/27/25 2:50 AM, Andy Shevchenko wrote:
> > On Mon, Nov 17, 2025 at 08:49:29AM -0500, Chuck Lever wrote:
> >> On Thu, 13 Nov 2025 09:31:31 +0100, Andy Shevchenko wrote:
> >>> Clang is not happy about set but (in some cases) unused variable:
> >>>
> >>> fs/nfsd/export.c:1027:17: error: variable 'inode' set but not used [-Werror,-Wunused-but-set-variable]
> >>>
> >>> since it's used as a parameter to dprintk() which might be configured
> >>> a no-op. To avoid uglifying code with the specific ifdeffery just mark
> >>> the variable __maybe_unused.

[...]

> >> Applied to nfsd-testing, thanks!
> >>
> >> [1/1] nfsd: Mark variable __maybe_unused to avoid W=1 build break
> >>       commit: 56e9f88b25abf08de6f2b1bfbbb2ddc4e6622d1e
> > 
> > Thanks, but still no appearance in Linux Next and problem seems to be present.
> > 
> 
> The usual practice is to keep patches in nfsd-testing for four
> weeks to allow NFSD and community CI processes to work, and to
> enable extended review before it is merged. Both the community
> CI processes (eg, zero-day bots) and the availability of
> reviewers are not something I have control over.
> 
> It will be available for upstream merge after December 11. You
> seem to be suggesting there is a sense of urgency so I will
> direct it towards v6.20-rc as soon as it is merge-ready.

Since it's (not so critical TBH, but still) a build breakage I supposed this to
go via the respective -fixes path. But okay, your call.

So far I will keep a patch locally to remember to annoy you :-) if it isn't applied

TL;DR: Thanks for the explanation.

-- 
With Best Regards,
Andy Shevchenko



