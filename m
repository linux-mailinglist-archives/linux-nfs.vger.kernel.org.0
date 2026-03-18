Return-Path: <linux-nfs+bounces-20261-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKq6H4vZummfcgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20261-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 17:57:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A512BFBED
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 17:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A04D30BFE7E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353033D4E4;
	Wed, 18 Mar 2026 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8EhnC6Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390F262FE7;
	Wed, 18 Mar 2026 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852057; cv=none; b=d8fy2x5PvS6l/Ty+kYPzY9/sMet+Hx7M9BTFa+xk7f4skWZKzEOx3dwOoiSwxMWqyzrxNnVeHWzSRWk7mMMiPqmqx5z7+rtau1Tv4Opj2h65Lt4cKhHfUxYh2egcdpWyDH7sTe+kmPcoFRkYDJVlixdFyDuPxX47hfpBfHPgWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852057; c=relaxed/simple;
	bh=cCxUOeE6RighpWkLGXMN/D7fFVTQx+9Fs+jSDEJEO10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6wAWku5Cr1yv7YqYmnTCsvg/RBaGvA5g6x4ZW0rZmBA6uRpC5qQi3BuR4vg/t+2MwrpFs4ZJfqEnK4l04FhNGlAtoUYq6ivlb9VQd/8K/F8NJx+GTDOZURXO2zBooY9XRDUtWKCWO+RRPUIHYe71eLMUSk/OTR2+9mpgPG2ioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8EhnC6Z; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773852056; x=1805388056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cCxUOeE6RighpWkLGXMN/D7fFVTQx+9Fs+jSDEJEO10=;
  b=X8EhnC6Zcrtd6/J7dK/pdVNJzqEzcgvYLs47Gu85XUsZyQYi5V7coX6y
   hs2hZJb40/shX/Rplo+XZY5yO0MHfx0UMgRbyIFz4JyxzBsRMSryDm1/m
   oNGEsPmxv7I7KdG5F+4HmquWxhkymFDJa/SN/iJMLgiJTsrg/F1A93oZA
   R/2k0bXIZ0wAeTIauW4xEWoj86/vfkgLuXRX4ZE4U0tygnhRwN/g8nnjJ
   Nw5mvOiqmn4SiWpKSLbnO1PiJl0BlTZAYDbcdSZgqX1WSjX1A7cxwp2Ts
   ugJje7NGzGxFftnF7CSBRJARFfEJsKOpsUCE8NK0lu9Fk08jvhJetKa/z
   g==;
X-CSE-ConnectionGUID: 6sVA3qAFQ9qHhR13YhNBcg==
X-CSE-MsgGUID: n83Wt9+1SbWfJsfblZTuog==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85614471"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85614471"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:40:55 -0700
X-CSE-ConnectionGUID: RXFmq2aSTdG3uPRWe1kfKQ==
X-CSE-MsgGUID: 1E4LIznmQsGefMYE6VdjGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="253162885"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:40:52 -0700
Date: Wed, 18 Mar 2026 18:40:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Chuck Lever <cel@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
Message-ID: <abrVkvbmhQsAA0rZ@ashevche-desk.local>
References: <20260303140725.86260-1-seanwascoding@gmail.com>
 <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com>
 <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
 <63721454-ffbe-4725-b2c3-843560a3d5e0@app.fastmail.com>
 <CAAb=EJVw8S9o+N2JcBQridSPeNOHQgpiFAPqeNV-X-uSxwjvqg@mail.gmail.com>
 <abljNCs_wjNELf6b@ashevche-desk.local>
 <CAAb=EJXA+SVPWLcWu1WRr-8A5Vk0k4za09+ROFqYX2eceH65XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAb=EJXA+SVPWLcWu1WRr-8A5Vk0k4za09+ROFqYX2eceH65XA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20261-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,oracle.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 19A512BFBED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 12:21:41AM +0800, Sean Chang wrote:
> On Tue, Mar 17, 2026 at 10:20 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > > > > > Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?
> > > > >
> > > > > Regarding the LKP report:
> > > > > I have reproduced the Sparse warning (void vs int mismatch) locally.
> > > > > To resolve this, I'll use the do-while(0) form in v3 to ensure the macro
> > > > > always evaluates to void:
> > > > > -# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
> > > > > -# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
> > > > > +# define dfprintk(fac, ...)            do { no_printk(__VA_ARGS__); } while (0)
> > > > > +# define dfprintk_rcu(fac, ...)        do { no_printk(__VA_ARGS__); } while (0)
> > > >
> > > > Wouldn't be better to drop ({}) in nfs_error*() macros?
> > >
> > > I understand that the ({}) wrapper might look redundant at first
> > > glance. However,
> > > even if I remove it, the return type remains an issue because no_printk() (which
> > > dprintk() expands to) already contains its own ({}) statement expression.
> > >
> > > To resolve this without refactoring errorf(), which hasn't been
> > > touched in years,
> > > I believe modifying dfprintk() is the better path.
> > >
> > > One alternative is to explicitly force the return type to void like this:
> > > ({ dprintk(fmt "\n", ##__VA_ARGS__); (void)0; })
> > >
> > > While this ensures the return type remains void (consistent with the
> > > behavior before
> > > dprintk() was redefined), it is admittedly clunky. We could wrap
> > > (void)0 in a macro like
> > > #define nothing_to_do ((void)0), but that adds unnecessary complexity.
> > >
> > > Therefore, I still prefer Option 1, as it restores the original
> > > behavior from before the
> > > recent commits and maintains the cleanest code structure for this subsystem.
> > > What do you think?
> >
> > Personally I found the ({}) in nfs_error*() redundant and the point of those
> > functions not being touched in years doesn't work for internal APIs. Do you
> > know the reason why it wasn't touched? Perhaps there was nothing to do simply
> > with that until dprintk() issue reveals some (legacy?) stuff to improve.
> >
> > I would not go with (void)0 approach, but I also think that dropping unneeded
> > (if confirmed) expression wrapping is a good thing to do.

> Thanks for your comment, how about removing the ({}) and ternary operator to
> prevent sparse throw incompatible types. And use the do{} while(0) to prevent
> dangling-else problem.

LGTM.

> #define nfs_errorf(fc, fmt, ...) do { \
>     if ((fc)->log.log) \
>         errorf(fc, fmt, ## __VA_ARGS__); \
>     else \
>         dprintk(fmt "\n", ## __VA_ARGS__); \
> } while (0)

-- 
With Best Regards,
Andy Shevchenko



