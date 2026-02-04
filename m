Return-Path: <linux-nfs+bounces-18712-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAyrOPd3g2mFmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18712-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:46:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FCEA70C
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F31E0300B9D2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C050C339868;
	Wed,  4 Feb 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1fWzrcJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BB9338936;
	Wed,  4 Feb 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223596; cv=none; b=Q536eFeR77stVH0S8jQp0W1o6qxHog6L+i1c0GMdtIWo01UuyZVNsVr3MZfbCT4mVoGD4ZAldMMPXroF3FSdRpjQilHggE1DK3oBQ3PqXXyQ2LFdvgVwTEuFBNRuFgo0fGzn3uY55CweWlthJ4pyM7bSUQDduMINMXfmulEc+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223596; c=relaxed/simple;
	bh=5MvKB/pLVNRIf5mz1Pcl2H3OSmAikYcgRO6TMhbbEhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qildz1aYClCmhTuCQwR/tXh5V3yRwGZMAwsBYLL9/WLccZqpfuqhxcIVbv4NRSR/uo9VomgsE6hcYh2OblCn0NA9xX3J2pfCQihA6GMuxKDjpyDjmTfvA3KC/hOUiyCaQD1X6l/QGIUvTUvLzEyTOYwGvop7i/zBeMcfu3/xy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1fWzrcJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770223597; x=1801759597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5MvKB/pLVNRIf5mz1Pcl2H3OSmAikYcgRO6TMhbbEhQ=;
  b=B1fWzrcJOEj3JSxBRCwVN/o1jsAMmvGZUGLIbJ4sohFfV3DWSf4AxTJT
   hHkeNMiF/JtdWilgF2tf1zvW8IwPbgXQAjP3nBO1Sp5cHZudeYRneJccQ
   eAXjR1D7qYzqZC3vrfJwZkbAv4peK1IxEuSGvCqe0HYuC+oBgX1WCcZTz
   OGa9XbQJCEihiffCiWs0PUaOCRzAampPQ69rKKw1mO8gOPnlUlwdlSUPJ
   +dQrcsA4LURsCljnSthCjkvBeCrZmF79MDsiLXbmXZW+qsIaUkVNtougE
   fuoym+FdfF6qZTHMChc68cdZo6ROYV2T5mUgrGOX1LB/ECc0H1NprAOjw
   A==;
X-CSE-ConnectionGUID: FTD7u8fWR+OpxncGIqylpA==
X-CSE-MsgGUID: b2TpdTjvQOS1CjvayKvdpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82849683"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82849683"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 08:46:36 -0800
X-CSE-ConnectionGUID: jE9J6EhAQLyPa9CcOLprtw==
X-CSE-MsgGUID: CSh0pk6rT8K9zmmZc64pvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="233140431"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 08:46:31 -0800
Date: Wed, 4 Feb 2026 18:46:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 3/3] sunrpc: Fix compilation error (`make W=1`) when
 dprintk() is no-op
Message-ID: <aYN35agQMKaIGZA0@smile.fi.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <20260204094500.2443455-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204094500.2443455-4-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com,glider.be];
	TAGGED_FROM(0.00)[bounces-18712-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,lkml,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 8C5FCEA70C
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:41:23AM +0100, Andy Shevchenko wrote:
> Clang compiler is not happy about set but unused variables:
> 
> .../flexfilelayout/flexfilelayoutdev.c:56:9: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
> .../flexfilelayout/flexfilelayout.c:1505:6: error: variable 'err' set but not used [-Werror,-Wunused-but-set-variable]
> .../nfs4proc.c:9244:12: error: variable 'ptr' set but not used [-Werror,-Wunused-but-set-variable]
> 
> Fix these by forwarding parameters of dprintk() to no_printk().
> The positive side-effect is a format-string checker enabled even for the cases
> when dprintk() is no-op.

I'm afraid this is not end of story...
I received a dozen of minutes ago a new report and now I'm investigating.

Patches 1 & 2 though are ready to go.

-- 
With Best Regards,
Andy Shevchenko



