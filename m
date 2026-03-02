Return-Path: <linux-nfs+bounces-19495-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL8aKrWPpWmoDgYAu9opvQ
	(envelope-from <linux-nfs+bounces-19495-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:25:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 251F41D9B3C
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E49AC300644D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6E3E9F83;
	Mon,  2 Mar 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrOcWNi5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6F3E716C;
	Mon,  2 Mar 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457874; cv=none; b=ufV0OfER3FhZCYZmDZZ+xo1uK93LW9W2449bp4HbV3iZCyeO3zvC2NRvR2eYnsvA9SedOyIbdxzm0ALh3xZonwgBxadNlAMRNU3Z1k1UawBfd9uwjVLyQi7hBj2Q/T8TRPYhhlevMjqrPJxpWQNZaS/p4dqqiwa1czz1FYqO4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457874; c=relaxed/simple;
	bh=7yC5wK6epw3oeZrCTpnWjoU1oo9pKs5PQ62VmZJMkjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA/tNhUuhC9FkTNG/UyTZuOeCd6xq3b9GmMfjUgdFWFrL+l/HOiRyYqK4wG7XewiA1XYAVY0SPPFkCXUD5xt9P5C28nzsRxijnIM+QSELHgdA03eRGW5QkB2RDRDoAG7SWblHRx5Ej+XzWdt2wf+DlCrH4szCbCS4EE8lNxxXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrOcWNi5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772457865; x=1803993865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7yC5wK6epw3oeZrCTpnWjoU1oo9pKs5PQ62VmZJMkjs=;
  b=CrOcWNi5vTH4yaeXGI+DljQm6A9HTOKSuyQ2bKUJYSueWvV9Im3p56u2
   799N/b7EaKRHYM/ebi0zRPeCq4XL7q7zaUeASVWniE38WGBdXQZZSREfF
   9BzQ+VcDFOY7De9iguZM6ubaQYIpIHRHODYRmY/bZi9bETEUpvR0Dw6Nu
   IEAHal8lPKRm/xtLVNpe1mdj6TWLoj0L3s9NrsdGIf8MUjPsKsgeF7tuE
   hrsRmUPJB5QFlCqGjg6nyddJM5SgPC/BzcFrzF2PTG7GMdwKmcD1XVJtf
   IvflECAV2p8DuAxBujUaaw/UxOsGufgVGSJVHZRsJfAheVVRdyGPSOi94
   g==;
X-CSE-ConnectionGUID: jtPcTq/0TPe+WlCo7ZCLRA==
X-CSE-MsgGUID: Isf6tsfaTTS086qO1rxgsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73649914"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73649914"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:24:24 -0800
X-CSE-ConnectionGUID: KrqE43lhSpqzQL0iReIm9g==
X-CSE-MsgGUID: Ffna2aYjTE2z/SNQnJsrbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="216108639"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2026 05:24:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 41B3398; Mon, 02 Mar 2026 14:24:21 +0100 (CET)
Date: Mon, 2 Mar 2026 14:24:21 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] net: macb: use ethtool_sprintf to fill ethtool
 stats strings
Message-ID: <aaWPhXrcthze_ZxE@black.igk.intel.com>
References: <20260228180821.811683-1-seanwascoding@gmail.com>
 <20260228180821.811683-3-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228180821.811683-3-seanwascoding@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19495-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: 251F41D9B3C
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 02:08:21AM +0800, Sean Chang wrote:
> The RISC-V toolchain triggers a stringop-truncation warning when using
> snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.
> 
> Convert the driver to use the modern ethtool_sprintf() API from
> linux/ethtool.h. This removes the need for manual snprintf() and
> memcpy() calls, handles the 32-byte padding automatically, and
> simplifies the logic by removing manual pointer arithmetic.

This can go separately from patch 1. Dunno why this is a series...

And this one LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



