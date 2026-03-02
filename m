Return-Path: <linux-nfs+bounces-19497-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PolLoyQpWmoDgYAu9opvQ
	(envelope-from <linux-nfs+bounces-19497-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:28:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B27971D9C00
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2DFE301733E
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAB13EFD38;
	Mon,  2 Mar 2026 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHa17lyG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C038553D;
	Mon,  2 Mar 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458059; cv=none; b=UW56El26jnGJE14he9FBkRA7aBKXn8H0xELzWbbUHuk/KF9ROm0CpTEklujVjUUWKfTZh/uk7nRh1L43TLLkDgA4XuJoUIm+4rKpcp7D1jXC0C1hf+fjaKyHArvj0nrr+7s+me4PMx/KG3OM+a/3LE02TGS04gze9NwhSxym+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458059; c=relaxed/simple;
	bh=gNNQMuJ4vbSo9Z3upH+zjkbLMLvNRBdyx1c84fv+xLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhAD2Dv97LSeMgsL4W7Qg8Zjpma0756KynJRa0cFaKkMlyq8pY6YV+7tpYz6OAFVK0HSrQIsKdw1ScS8CHC5YjWRnrrhElzhlkqwQoBVM8npVZJkvbF3OQkKQxXHfeZEreQx9SRVmZs4lwjjv/AQLsdDUSuO/nO02SsB0gBALdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHa17lyG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772458051; x=1803994051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gNNQMuJ4vbSo9Z3upH+zjkbLMLvNRBdyx1c84fv+xLo=;
  b=eHa17lyGd4R6zt79iDXbLa8fkqpXmKOkiU+1UT9nQpM3x5N5OYnY0JQL
   LwwyE3q7NdYBnjl8CNaAj/JD6XHxdUZZbCvg8aMgxiahukh5E4/Hoykm2
   qp0bWe+XcRXtcZDn2vW1sAJGfrvFqzQsz1arN6BVPUk4IY2uHOVH0FtOB
   EDU9hdzrhtKz1Ofy+dNoJqrcNcoaPhhtN8ZJUmIbQ7JIlEp8FRATUXvEA
   CBJA0nTjkuKd5UYpF2n0be+TzhtZujkn+tgQl+HTfe4WwAN1dlNHYmnhm
   putUeuyfxxHsFKfZXZm14M/yL21au54NUn+p/IYYqRpgEMHnBUK/awflw
   Q==;
X-CSE-ConnectionGUID: j/HjKenMRSC1HUu/su+gKg==
X-CSE-MsgGUID: vZNEYDZDT7uIRUZy+PUhhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73650237"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73650237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:27:30 -0800
X-CSE-ConnectionGUID: Ou0KlTdmS5CBy46B8e3nPA==
X-CSE-MsgGUID: xuCyVknAS9eAo9HCYKU7rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="215636206"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 02 Mar 2026 05:27:28 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4475899; Mon, 02 Mar 2026 14:27:27 +0100 (CET)
Date: Mon, 2 Mar 2026 14:27:27 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 1/2] sunrpc: simplify dprintk macros and cleanup
 redundant debug guards
Message-ID: <aaWQPw-My_eo1myI@black.igk.intel.com>
References: <20260301161709.1365975-1-seanwascoding@gmail.com>
 <20260301161709.1365975-2-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301161709.1365975-2-seanwascoding@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org,intel.com];
	TAGGED_FROM(0.00)[bounces-19497-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[black.igk.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: B27971D9C00
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 12:17:08AM +0800, Sean Chang wrote:
> When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
> expand to empty do-while loops. This causes variables used solely
> within these calls to appear unused, triggering -Wunused-variable
> warnings.
> 
> Following David Laight's suggestion, simplify the macro definitions by
> removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__)
> directly. This ensures the compiler performs type checking and "sees"
> the variables, silencing the warnings without emitting any code.
> 
> Verification with .lst files under -O2 confirms that the compiler
> successfully performs "dead code elimination". Even when variables
> (like char buf[] in nfsfh.c) or static helper functions (like
> nlmdbg_cookie2a in svclock.c) are declared without #ifdef, they are
> completely optimized out (no stack allocation, no symbol references in
> the final executable) as they are only referenced within no_printk().
> 
> This allows for significant cleanup:
> - Remove RPC_IFDEBUG() and associated #if blocks in fs/nfsd/nfsfh.c
>   and net/sunrpc/xprtrdma/svc_rdma_transport.c.
> - Remove the #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) guard around
>   nlmdbg_cookie2a in fs/lockd/svclock.c.
> - Consolidate the dprintk definition to be more idiomatic.
> 
> This fixes the build errors reported by the kernel test robot while
> improving code maintainability.

If you feel something has to be done against nfsd-next, please rebase and send
as a standalone patch.

-- 
With Best Regards,
Andy Shevchenko



