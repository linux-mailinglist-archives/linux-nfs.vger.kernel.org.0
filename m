Return-Path: <linux-nfs+bounces-18705-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOqpOahYg2mJlQMAu9opvQ
	(envelope-from <linux-nfs+bounces-18705-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:33:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F170E724E
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46FEB300F159
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E396274FC1;
	Wed,  4 Feb 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZrndd52"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C327B359;
	Wed,  4 Feb 2026 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215585; cv=none; b=luz6G9dBBaU7WI1ahsohTODScTAx6ecvBzSXMDRahwrGBHw+CMTwB3m8nDgXUyCQo+1POEcYW+WUlJPVVTfoGLJyn+qw3Js6RTL+xQxcJF/OmrxFWuxMbvbde9pbdGLQhS9eFNHGZGQsz+60D5vuDElMxHQzw/FlZFJWayGPpNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215585; c=relaxed/simple;
	bh=pXXP39c4G2+cWRpwZabdRWaGFcVTaSz2uuubofAEqzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci3YIbLcyrSylk7YRntHplyv/oGu2O7lIPsgbcCXsLanBYewBrQc9KuL6s/wJCgCwglJJ2VtQFApTyyS360TnqBOeZaMzNZQkCt15VBXPNve5StRfHGwJjhj9igfO0BGgFROXvUGBy/IB6JWe3KTouQoJXzDR0GRNMTH/WCCpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZrndd52; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770215585; x=1801751585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pXXP39c4G2+cWRpwZabdRWaGFcVTaSz2uuubofAEqzs=;
  b=ZZrndd52X7Qu0MdAns6V9dd3yERRvGk7YfS0jFo4cdCH7AihB2nvPVsb
   QTcxWC8CmqL/a6jkcEf9iWfwNTairWoOda1g/mGCg0CsGIbjfHCTkVdOc
   7w5RqR9SeTV9OI80bL7eJTpXwgJb8AR4i77rlQmJy3OZYsOemqx8fEBxf
   OiVuMjsHeB98Eu3fTMVsdiYFfDjM+xrBUrDlFtjFiSC3v9xJ4BqkfiSQ7
   72K7DgXkkjJlALc8V+TRGFrvWupQKtVLbX6fMjexOfUFOMNNGI6bZQGcZ
   9q6SEd2r6A0nEjN4NT62JBauG3vWbc7rCIxF7vCCwGKZdthI299LdNV4K
   w==;
X-CSE-ConnectionGUID: RtoAN6d6RHKuBCPoahCOxw==
X-CSE-MsgGUID: ABqIg06QTxGRuoJBLRsFrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96855671"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="96855671"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:33:03 -0800
X-CSE-ConnectionGUID: 7iVTz8XvT0iKwlrMyzxQmw==
X-CSE-MsgGUID: PQeFSibgRTmg/z2CvsDH3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="247776896"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:32:58 -0800
Date: Wed, 4 Feb 2026 16:32:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev,
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
Subject: Re: [PATCH v2 0/3] sunrpc: Fix `make W=1` build issues
Message-ID: <aYNYlzxdz8cCe5cf@smile.fi.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <9859fe54fded87e720e375b1b267908437480f47.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9859fe54fded87e720e375b1b267908437480f47.camel@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,vger.kernel.org,lists.linux.dev,kernel.org,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-18705-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 1F170E724E
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:28:28AM -0500, Jeff Layton wrote:
> On Wed, 2026-02-04 at 10:41 +0100, Andy Shevchenko wrote:
> > Compiler is not happy about unused variables (especially when
> > dprintk() call is defined as no-op). Here is the series to
> > address the issues.
> > 
> > Changelog v2:
> > - added patch to kill RPC_IFDEBUG() macro (LKP, Geert)
> > - united separate patches in the series
> > - collected tags (Geert)
> > 
> > v1: 20260204010402.2149563-1-andriy.shevchenko@linux.intel.com
> > v1: 20260204010415.2149607-1-andriy.shevchenko@linux.intel.com
> > 
> > Andy Shevchenko (3):
> >   nfs/blocklayout: Fix compilation error (`make W=1`) in
> >     bl_write_pagelist()
> >   sunrpc: Kill RPC_IFDEBUG()
> >   sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op
> > 
> >  fs/lockd/svclock.c                       |  5 +++++
> >  fs/nfs/blocklayout/blocklayout.c         |  4 +---
> >  fs/nfsd/nfsfh.c                          |  9 +++++---
> >  include/linux/sunrpc/debug.h             | 10 +++++----
> >  net/sunrpc/xprtrdma/svc_rdma_transport.c | 27 ++++++++++++------------
> >  5 files changed, 32 insertions(+), 23 deletions(-)
> 
> These all look like good changes to me. The first patch should go to
> Trond/Anna and Chuck will probably pick up the other two?

As I explained in v1, the error in the first patch may be shadowed if the third
one (and hence second) is taken first. That's why I prefer them to go via
single place.

> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



