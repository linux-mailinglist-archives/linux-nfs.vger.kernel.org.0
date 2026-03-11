Return-Path: <linux-nfs+bounces-20050-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL67M+/isWksGwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20050-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 22:47:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BA26A8B0
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 22:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 435713027368
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916229BDBF;
	Wed, 11 Mar 2026 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEQtPWlA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD0126F3B;
	Wed, 11 Mar 2026 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265643; cv=none; b=FIdJsBbqywbHR0pTbejwOa10o7h3JuUExXG1BHgC34wOijX4plnvrEqXkcfGasKHlpl3QZU7kesyHIWh8wv/6mDzrCbFWMDPk1GSwypD4yCF/hKNhwtNrC4tt0vywFcir3ngwkMceVYnOtwAzBCIvXj+T/5C9kEHXYErH4i8Ifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265643; c=relaxed/simple;
	bh=AfzgWescQI12VbDmGcofZ3H+xed6L8D2mUifEiyldjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1ctQwO40NAVMKrTzkkYZMFRGB+rniquZsGyr2Mqkj9LjlaELcegd2DxpqE4TgfATEQpEGBB4xwCFyNFO8jmJLOX/s5f5nc8kNpEVMJ6uCwOP2UbJh3MYUsWCrhI+KRpZZIoFfk3Ul+ZxR7nY2kdUCWiL5cUjbSa7Scc9VY++/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEQtPWlA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773265642; x=1804801642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AfzgWescQI12VbDmGcofZ3H+xed6L8D2mUifEiyldjg=;
  b=QEQtPWlAUDhLOEBYlT9NFD6Q301D5HrmTrSisnpNkGKC3yy6epTBCBsq
   Z1gYQyFA2ohJ5bzW6P36A62mcsgCf4s/t49ViCDEImMV0GnUEJksLlUzF
   V9WZRz+H86y3G0jJYzaX2GqWNUi+U78vpSMvPsOizfIYQX7tlSENSDFc1
   kasPdk/YpdfcYZfQiRNcERd6teudHsOE+aCuExInZYdZL22a2q1Ru6i52
   QIuJ1z/jtQx56O1YJQrtyUtxEZQ0P9XnmBlXUBGNJJ86o3j+FGmiUiCN3
   u/0cqSequJlb0jp+9fHcpujZgoWdmlFVwz7wEz3B7eTNbh2dIUsz6JUaJ
   g==;
X-CSE-ConnectionGUID: Pmwxxah1R/OwvNBwg75TKA==
X-CSE-MsgGUID: EaEbJf6zTtGNcQw62taZkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="91730013"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="91730013"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 14:47:21 -0700
X-CSE-ConnectionGUID: RTEzrkycTEuwrVh0Fv2pPg==
X-CSE-MsgGUID: SM4OfwNfSpO07ENE0Tpd8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="220781669"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 14:47:19 -0700
Date: Wed, 11 Mar 2026 23:47:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
Message-ID: <abHi5SOPaaly-v1l@ashevche-desk.local>
References: <20260303140725.86260-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303140725.86260-1-seanwascoding@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20050-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 509BA26A8B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 03, 2026 at 10:07:25PM +0800, Sean Chang wrote:
> Following David Laight's suggestion, simplify the macro definitions by
> removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__)
> directly.
> 
> Verification with .lst files under -O2 confirms that the compiler
> successfully performs "dead code elimination". Even when variables
> (like char buf[] in nfsfh.c) or static helper functions (like
> nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they are
> completely optimized out (no stack allocation, no symbol references in
> the final executable) as they are only referenced within no_printk().

Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?

-- 
With Best Regards,
Andy Shevchenko



