Return-Path: <linux-nfs+bounces-18666-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AsvJLWcgmlgWwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18666-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 02:11:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD09E0551
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 02:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 187DC307B2F9
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD623BCFD;
	Wed,  4 Feb 2026 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUSLRKO9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405623FCC;
	Wed,  4 Feb 2026 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167356; cv=none; b=LvYfVk0LbFNCYKmi0nDdCYDm86UnMrhG0Tc9eaFbWPp8FozxSdPoSPC/t8Tu/prMjmYKv/jpfqsnXM5ZwAJvIPb1Y7KMYZAY9kb6/qEFz7a8CM7M53ej9xZB0KfrySAga7CI28uZz2E8VTmq41YeDbVu9OOd/9OP5J6HXzpEdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167356; c=relaxed/simple;
	bh=/9HVvPdr8HQCtfTWppNf6n84GxbfsGIRo3YUXCxq7pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A85hV0nw1vgMOFDcov+OKETiNmgyoe19+97zPX0UsW+FvBSIYnOCHuSkfkiRcehMlm0XdK8tHIoLMthKDF/GCTiCze34R9T18EBSryDMG5csISgUmZ2c+5wSPabK9BqynXncU5wfTiljZ7yClCWkMyVpeRnh+agM8fZUUAxxfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUSLRKO9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770167355; x=1801703355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/9HVvPdr8HQCtfTWppNf6n84GxbfsGIRo3YUXCxq7pk=;
  b=gUSLRKO96cgJSL1OTs1qVfRgg/gKjZYxEcjN2tfFmSZIxRjpVdGIh9Pg
   xcTFKIpKoz1AQW/W7rEjMWQrvaMIj9+kwUacLa2MXQgsAPKlLiTYuwS20
   4RVT06NLPIVO3CHt09+Id2Q70Q7RA0JxTEnZKvu7VMOktCKAa8Ss1brZ4
   Y7sQ4WLNfjd60KVyAR4DIt2yrpKvlM6duU7OSze/c7OoKH7EljSHHLoZm
   lDccmmGJsjMLtGDGyPOZlhioBjb8lK8y8u0tImx08UwlJ6N5BlYnMnp3u
   lXKEd7udEJCqsByi/61kqoqvPAxh9HwOzN9F8fKzegl3DCMIThfNNd5+b
   Q==;
X-CSE-ConnectionGUID: uQqcaNDASBqvAWLQBNdoEg==
X-CSE-MsgGUID: nN3juj82QZynlxdvcvEMRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88926472"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="88926472"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:09:15 -0800
X-CSE-ConnectionGUID: oKdSBW3ETHqmD0iExfH6cQ==
X-CSE-MsgGUID: tI4URy7TRB65xA6sz/1xbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209662651"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:09:11 -0800
Date: Wed, 4 Feb 2026 03:09:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] sunrpc: Fix compilation error (`make W=1`) when
 dprintk() is no-op
Message-ID: <aYKcNds-XsVLRjcC@smile.fi.intel.com>
References: <20260204010415.2149607-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204010415.2149607-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,oracle.com,talpey.com,kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-18666-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 0FD09E0551
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 02:04:15AM +0100, Andy Shevchenko wrote:
> Clang compiler is not happy about set but unused variables:
> 
> .../flexfilelayout/flexfilelayoutdev.c:56:9: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
> .../flexfilelayout/flexfilelayout.c:1505:6: error: variable 'err' set but not used [-Werror,-Wunused-but-set-variable]
> .../nfs4proc.c:9244:12: error: variable 'ptr' set but not used [-Werror,-Wunused-but-set-variable]
> 
> Fix these by forwarding parameters of dprintk() to no_printk().
> The positive side-effect is a format-string checker enabled even for the cases
> when dprintk() is no-op.

Note, the alternative fix is to add __maybe_unused all over the place.
With pros and cons I consider my approach better.

-- 
With Best Regards,
Andy Shevchenko



