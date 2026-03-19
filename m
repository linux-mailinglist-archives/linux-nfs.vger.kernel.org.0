Return-Path: <linux-nfs+bounces-20279-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EADlDxkdvGlEsQIAu9opvQ
	(envelope-from <linux-nfs+bounces-20279-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 16:58:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E572CE23C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 16:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAFEC30CFA5C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554B3DEAC3;
	Thu, 19 Mar 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecSR50Mc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA71459F6;
	Thu, 19 Mar 2026 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935373; cv=none; b=h02Eob4XOGJmtMM/2ISE1ZIpRLXYKxxdc7SA9ki4qFN5brfpiZQXlcwhIoouTFiKd/svGz9qymkTmJoYeINBSCf+eqsu4hvOQYPN72GmQjYUaHfaRHzGSy69vyEaZpLMXrvlljrf7TN9hZC/OLiHk1ToBnKV34kz184IUvUo4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935373; c=relaxed/simple;
	bh=cGkr+p16Ngs8vie3raqWm7LPgNZ8uve+QEs9dd/iT7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4yAEA5R0AyahPRPX9nxMHRz/rutgzQVqJsKgelk5RLH7ES13hFT02ltfGTX0C2SARY8HH6Bxev7PQ+V4Hem57zTc+dJ1u2c8f3HBn2GJlNJp3ZuV0GLkpsKJeyDEefPf8CLtRtQInT7+B2t9VKV532kogMytD4mNh2VHsSeGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecSR50Mc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773935372; x=1805471372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cGkr+p16Ngs8vie3raqWm7LPgNZ8uve+QEs9dd/iT7g=;
  b=ecSR50Mc+7/Pfx8nNvQkjjMYdiL6ziTnRX9M+TYXWlt3XSWIU05JFyvN
   VFywkXRh1BbUbGgDYWmfJSd/P565NqvtJmIfePfFVE1tS7/zcMF9xZjRB
   ysANOI7E6OnUC+KqatJR/9ZnaMJg5sqFVs1GhTSe7+CYPeKXr1hi0lTjw
   G4tD/xoaTO6q9F2o8JSLxm/8gIwEAA1KkbUEcgmArcYsCcGGD9e5yJ5Dm
   TGzMk5lCk4ZhvwDVKKZK1mlHa7hceyv18UO1V+g9gjpMfcDNiKFZrmbIZ
   i6KWS83xsjbmfb7GY4PwDx7p5PYJFh85XBiawPd8AxvfLH9dh5OR1K8zZ
   A==;
X-CSE-ConnectionGUID: QaMSATjeQvyMAgAasDyvnw==
X-CSE-MsgGUID: eCEO59ivS3mSeQ0NOpu0vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86373816"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="86373816"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:49:32 -0700
X-CSE-ConnectionGUID: WKBqTyx9T3uNo1IiDQyJiw==
X-CSE-MsgGUID: r1ZGyPPGRs6pANxhD0qq8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218444375"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.120])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:49:29 -0700
Date: Thu, 19 Mar 2026 17:49:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/3] nfs: refactor nfs_errorf macros and remove unused
 ones
Message-ID: <abwbB-AkHH9Syppw@ashevche-desk.local>
References: <20260319141846.78222-1-seanwascoding@gmail.com>
 <20260319141846.78222-4-seanwascoding@gmail.com>
 <abwLFk0L_kCZqIiK@ashevche-desk.local>
 <CAAb=EJVCkn9_iO_YHMbLU1VR1OsKqTSg5Jo9jviaT3dEq0k5vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAb=EJVCkn9_iO_YHMbLU1VR1OsKqTSg5Jo9jviaT3dEq0k5vQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org,intel.com];
	TAGGED_FROM(0.00)[bounces-20279-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C9E572CE23C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:59:02PM +0800, Sean Chang wrote:
> On Thu, Mar 19, 2026 at 10:41 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Mar 19, 2026 at 10:18:46PM +0800, Sean Chang wrote:

...

> > >  #define nfs_invalf(fc, fmt, ...) ((fc)->log.log ?            \
> > >       invalf(fc, fmt, ## __VA_ARGS__) :                       \
> >
> > >       invalf(fc, fmt, ## __VA_ARGS__) :                       \
> > >       ({ dfprintk(fac, fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
> >
> > Why not all of them?
> 
> I initially only refactored nfs_errorf because it doesn't return a value.
> For nfs_invalf, it will always return -EINVAL. Would you prefer me to
> refactor it using the ({ ... }) statement expression pattern to keep the
> return value, or is it better to leave it as is ?

I don't think in this case it improves the situation. Yeah, it's unfortunate.

> #define nfs_invalf(fc, fmt, ...) ({            \
>     if ((fc)->log.log)                \
>         invalf(fc, fmt, ## __VA_ARGS__);    \

I believe this already has an error code inside, that's why it's only added to
the 'else' branch.

>     else                        \
>         dfprintk(fac, fmt "\n", ## __VA_ARGS__);\
>     -EINVAL;                    \
> })

Okay, let's go with your original approach (ideally these all probably should
be replaced by static inline:s).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Unrelated to the series, but if you want to address these:

nfs/super.c:1170:49: warning: incorrect type in initializer (different address spaces)
nfs/super.c:1170:49:    expected struct rpc_xprt *xprt1
nfs/super.c:1170:49:    got struct rpc_xprt [noderef] __rcu *cl_xprt
nfs/super.c:1171:49: warning: incorrect type in initializer (different address spaces)
nfs/super.c:1171:49:    expected struct rpc_xprt *xprt2
nfs/super.c:1171:49:    got struct rpc_xprt [noderef] __rcu *cl_xprt

nfs/./nfstrace.h:1488:1: warning: dereference of noderef expression
nfs/./nfs4trace.h:2168:1: error: too long token expansion
nfs/./nfs4trace.h:2234:1: error: too long token expansion

-- 
With Best Regards,
Andy Shevchenko



