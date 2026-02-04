Return-Path: <linux-nfs+bounces-18692-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJZDKKsVg2nihQMAu9opvQ
	(envelope-from <linux-nfs+bounces-18692-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 10:47:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D993E40AB
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 006173018C2F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD23B8BAA;
	Wed,  4 Feb 2026 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPty9JUx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38883ACEF7;
	Wed,  4 Feb 2026 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198439; cv=none; b=d/igw4qmXyIYxH0K8Q+onbg2oukCTBBqVqMpOJ8YLEtBmy0TcDoBTxd41brc9jU1ij/rzmdwuyqDBXW4PN1JhSunYUohQXQmKmCwux0Olo+0XasCPsXUn9u4rGMge0PRuSFljsaIWLvEIy39MRA8zZ8QOWhqwDZta9a4691uUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198439; c=relaxed/simple;
	bh=I8UFuP4ONsf4FfnsQCNKLr70L3Z6ATJ2nO+gr7Yys1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be4b8hw9AH4LIyN6wt/h/ukzc19MmN3kq0K0Kx+tYlIvQxDsG4x5FgPJZ1Hoa5GwCRuZprm+Rd8crffwOXFV3UDOoAOkL9bNPwYad1uG8uJBMFsoQlowqySsTH6rN4t8iGvzo61Y37GOameGndRFfZydC2hbaCoCMT0rT9ll9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPty9JUx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770198439; x=1801734439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I8UFuP4ONsf4FfnsQCNKLr70L3Z6ATJ2nO+gr7Yys1M=;
  b=FPty9JUxkx0Iuw512vlRP4uSKnceqZOJK+MgkqI5kSHDQbdl8ee5Ym4F
   Qh9zvoPHm0JbDR7Do83fLA8LtviBwrnm5h9pmg9my38Vjx2s31PFWqRCV
   XVt1BuH+jPYlBPvZJEDHjH76Kfd0ys7vFJOS14DHcauW7v5VCIt6ah61I
   1UgInn4Knt1K4R19+liJQItqlRAWqi7pYsZkj2iQyyQqX93ABO+uQq1gj
   hrDMFvWqaYD1SVz66p98ttPG3DkkjnUEOfwJV/kQ9bD7tMLeFV8h08xAt
   yvlEJdt0PLfPFp4p4aCotJXeiRlof15O4yRl9pY80RBNq398yYE+/9mfd
   Q==;
X-CSE-ConnectionGUID: hNrANAgoQMy0tdjA8SY4Eg==
X-CSE-MsgGUID: 6lGBvcyWROq2Z3y4XP1MDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82492874"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82492874"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:47:16 -0800
X-CSE-ConnectionGUID: 8DNxzStoSYqNwiaslnT5DQ==
X-CSE-MsgGUID: GWDxH5b5QcujBPATNzuCQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="215097929"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:47:12 -0800
Date: Wed, 4 Feb 2026 11:47:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] sunrpc: Fix compilation error (`make W=1`) when
 dprintk() is no-op
Message-ID: <aYMVnVv2Csz7Zi44@smile.fi.intel.com>
References: <20260204010415.2149607-1-andriy.shevchenko@linux.intel.com>
 <aYKcNds-XsVLRjcC@smile.fi.intel.com>
 <CAMuHMdWZx=2-y_OSjCkxmXo-3YjGjU0aH89puTcL0rmvw7E-Eg@mail.gmail.com>
 <aYMMEiNCPaJIc9Rd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYMMEiNCPaJIc9Rd@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,kernel.org,vger.kernel.org,lists.linux.dev,redhat.com,talpey.com,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-18692-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 1D993E40AB
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:06:32AM +0200, Andy Shevchenko wrote:
> On Wed, Feb 04, 2026 at 08:53:39AM +0100, Geert Uytterhoeven wrote:

...

> Thanks, I will do more tests and fixes and add your Ack.

v2 just has been sent. You Cc'ed only on patch 3, but it should be available in
full here https://lore.kernel.org/r/20260204094500.2443455-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



