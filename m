Return-Path: <linux-nfs+bounces-16749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714EC8D418
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 08:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDA63A53B9
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FDC321437;
	Thu, 27 Nov 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agE39cJC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6A3242A7;
	Thu, 27 Nov 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229840; cv=none; b=ihi7F33sQXk2G2tTWim4WoVb0LNGc4HYnieVrDx3l5Wnf72iRwP4D1IVE/iJe+p2PAGrFnv4s2UmQ7WLL64NieuEePd9eI+5Fu/s7ee2nLnHhF/L95huO13f7ygXrEW8rIqUTWR7jrl9PzmJWhDBkXonYnF97+KBXkXFXlEQ8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229840; c=relaxed/simple;
	bh=8UoFwEA8BV5fyntT6fyEPjGg92U4QgrkAqawzzW0xgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ/s92DOWdJZx3HK8BTmxe+ZHDGyui44VLoLq/6zN/48YxrUqUJrkOBC3xW1J681FCytY6f7QfxtkUnEeub2JtPt3ayz6abFOotrgG2+qEAeFrk6zSbnHbKCevBu06LnlWG0d9s7kruIxWCkBACM/e+1ZUhrzbT5sVDZZ7MjN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agE39cJC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764229839; x=1795765839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8UoFwEA8BV5fyntT6fyEPjGg92U4QgrkAqawzzW0xgU=;
  b=agE39cJC3IetaxacAF33ehZmqfjSZB/YRzwD5t7UKWl60Dpptpmfo7Dm
   12pZv+f2T5fIGtqjtD1ik499mQrwL9/W9jVUjSOD0vVrVRtG3nUf47K6t
   2qKDs8XImXLAQzRCPNw1gmJG/gZZUrnk94JJHiIgKHUka4oGBgt4K7AZ1
   +pJfeScoJ6AAdjbDH4WTANsEpE/CtPFlQfeOfFI/mMKkCoZBWPgfrii8C
   v23qZk9rTJJ7FNvhp+aZy7XzbjQCz+tLOtqdnfKAOMvIp09apMklB2yWQ
   uetezlgZVj5iRRs09fgSw2QNkWHIbmBYXzWe7Qxb6gg8/fwYJH0COzD9O
   Q==;
X-CSE-ConnectionGUID: /bDWQTayQQKS/eHc/E7aTA==
X-CSE-MsgGUID: M3L9ng5ORJSzWQuuU4fACA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="53842033"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="53842033"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 23:50:38 -0800
X-CSE-ConnectionGUID: dMwi9piuQ/aggK1q2vS9fg==
X-CSE-MsgGUID: X4ZIhokpQ0ioBUA2oLq7OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="193619336"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 26 Nov 2025 23:50:35 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 557A6A0; Thu, 27 Nov 2025 08:50:34 +0100 (CET)
Date: Thu, 27 Nov 2025 08:50:34 +0100
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
Message-ID: <aSgCyqR72Zu6TSSI@black.igk.intel.com>
References: <20251113083131.2239677-1-andriy.shevchenko@linux.intel.com>
 <176338731878.4204.10224670039692915729.b4-ty@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176338731878.4204.10224670039692915729.b4-ty@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 17, 2025 at 08:49:29AM -0500, Chuck Lever wrote:
> On Thu, 13 Nov 2025 09:31:31 +0100, Andy Shevchenko wrote:
> > Clang is not happy about set but (in some cases) unused variable:
> > 
> > fs/nfsd/export.c:1027:17: error: variable 'inode' set but not used [-Werror,-Wunused-but-set-variable]
> > 
> > since it's used as a parameter to dprintk() which might be configured
> > a no-op. To avoid uglifying code with the specific ifdeffery just mark
> > the variable __maybe_unused.

[...]

> Applied to nfsd-testing, thanks!
> 
> [1/1] nfsd: Mark variable __maybe_unused to avoid W=1 build break
>       commit: 56e9f88b25abf08de6f2b1bfbbb2ddc4e6622d1e

Thanks, but still no appearance in Linux Next and problem seems to be present.

-- 
With Best Regards,
Andy Shevchenko



