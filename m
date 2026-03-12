Return-Path: <linux-nfs+bounces-20070-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HF4FX7psmljQwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20070-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 17:27:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5162A27592F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 17:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFE653024422
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 16:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFEE3D9035;
	Thu, 12 Mar 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLYM6CMi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE93B4E9B;
	Thu, 12 Mar 2026 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332096; cv=none; b=R8AT93eNnDwQrnV5mYPgYJSHNpdQotSrDw/3gJrdem6ynnH0QNkqtkWmv2Q/SEmWt7c9/QhGiQLCFKOiMo61uI2sd6rbyOFZSvl8oD34RxcYjXUzOM6mVc4EeMvH72O3sCWEybfCtp6420PlUWkrm9k83bbbhFAAFb+xLNshxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332096; c=relaxed/simple;
	bh=Kv+vkMIrcKJ2USGGn+hek5UgDjt/pQ55hP7RYgtuuYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT0QsgAvlAiCJdy4MWccekGqZhVL1qo9qO1a5Oeogd9zTcEhTeaLyazijvaG8V2vKmGZAUPtUE6J4TxYjOXc7tiU/MmXz9/wPXfNssOhj58uWHmZWiWy0jmMtps8V7W+Ohlf5NDqgAonXLHEeeLJijwxaPHgXcYcHwmi0ZvFbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLYM6CMi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773332095; x=1804868095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Kv+vkMIrcKJ2USGGn+hek5UgDjt/pQ55hP7RYgtuuYs=;
  b=CLYM6CMi94uIyrEcpoQzTca4IldlCYanpBGo+fAe7xQ53oMvpiiBsnMC
   TrR7NTUjcm9GHjHJYvKRzqZqKVwVwGXdfLAFLw2EHHah6esUQPNfBSPZu
   y6NCmvgf3YKqOVLGRsIee6TSwp0MB+sy/eHD0PBw2ucWOl8JBp9pYggH0
   rrzD2vtBHcs76bkcg/Bs956qzIao3poSAE/t8jMK+Zj8GKgB7YDznoJ8u
   32EoqTpwow4BRTxsHQ2ehPH5Ui+ZL/xWiUyLlxj+T9Ej4VnzjY41/PLPX
   E1i5Yk067TO6gne31c13pj59FpyP7Tj4Tl83+/QS7AzjU3bflzGvy1zFo
   w==;
X-CSE-ConnectionGUID: 7J3hzh7GRVKsX0wf8GRbrw==
X-CSE-MsgGUID: 7BWXHuswTRKH9s5jMzOkfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="91810270"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="91810270"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:14:55 -0700
X-CSE-ConnectionGUID: cBKj5evWSXCdj2qVZ/OXXQ==
X-CSE-MsgGUID: 20Rhd+hKTquT3rQcD1HIeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="225843716"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:14:52 -0700
Date: Thu, 12 Mar 2026 18:14:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Chuck Lever <cel@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
Message-ID: <abLmectMwJ_kSF_E@ashevche-desk.local>
References: <20260303140725.86260-1-seanwascoding@gmail.com>
 <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com>
 <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,oracle.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20070-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 5162A27592F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:54:15PM +0800, Sean Chang wrote:
> On Thu, Mar 12, 2026 at 5:47 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Mar 03, 2026 at 10:07:25PM +0800, Sean Chang wrote:
> > > Following David Laight's suggestion, simplify the macro definitions by
> > > removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__)
> > > directly.
> > >
> > > Verification with .lst files under -O2 confirms that the compiler
> > > successfully performs "dead code elimination". Even when variables
> > > (like char buf[] in nfsfh.c) or static helper functions (like
> > > nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they are
> > > completely optimized out (no stack allocation, no symbol references in
> > > the final executable) as they are only referenced within no_printk().
> >
> > Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?
> 
> Regarding the LKP report:
> I have reproduced the Sparse warning (void vs int mismatch) locally.
> To resolve this, I'll use the do-while(0) form in v3 to ensure the macro
> always evaluates to void:
> -# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
> -# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
> +# define dfprintk(fac, ...)            do { no_printk(__VA_ARGS__); } while (0)
> +# define dfprintk_rcu(fac, ...)        do { no_printk(__VA_ARGS__); } while (0)

Wouldn't be better to drop ({}) in nfs_error*() macros?

-- 
With Best Regards,
Andy Shevchenko



