Return-Path: <linux-nfs+bounces-20235-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA5PHBNnuWkyDgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20235-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 15:37:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EFB2AC19A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507693148659
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869C3E1CFC;
	Tue, 17 Mar 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iV6GtnsE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BB24501D;
	Tue, 17 Mar 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757245; cv=none; b=YH80QmHAC7fv+SVysAH0NG1VtcZ/PxiynUJCNY0mN8DjVGUD3MT0f9r5UKEitu9GCck4IG690iJdakqzWX2/XSWjARezufBnalRsVHkjDvRrQgKryvpQInHn171s6JFgLmyA9JnvuAc4JJLQ+l5kKkZ/ukwLx6w6NiPCpyvfSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757245; c=relaxed/simple;
	bh=j6WXl5+nwncNGXx8BzEJOh4WBp45Xl2SryWijQYH4JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIAc1nWrJTx3lNh6beajwQ/7SLz8ApMu4BeaNPAEiulxF4oL3LNphaXVSkwCZxMigGAheTv7DD0YKGluWb8kWp0Edx3TPCPV3v79V0ScxIpOwMUaQYth3oLnQ5S7JfGPZradw20ZfOYh96Ow4xWIMSSQb3TyLuawW84jNZr3LuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iV6GtnsE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773757242; x=1805293242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j6WXl5+nwncNGXx8BzEJOh4WBp45Xl2SryWijQYH4JY=;
  b=iV6GtnsEit7TEqTWlYuRfVbp/uZ+V5BIEYE1w8s5r2DW7hjGWlHGsSko
   OSU/37QGMk5le+sUy53hzaTmQoAEuRXk5U0OXnc+1Qjgbw7xQ0ZtRkJqu
   Sco0ZHotNynoJDWDKegiIqwz46KoVLtHzQ8rdID2ogFqweF7GfQSLE5dQ
   w8P3TOzNqqjB1Wl66rLMF0TZxDrWWvh+UOXUmjJp1kxHy6ehUuUbP/vEo
   zlkLaWNkzNqh+lVGz5smUeWIRUYuU/kDjByzkVDiPWG9if0MvZ0PWqxqw
   +9eZRlBcWyW2VPuD5UkTQ49w+m0nGggx1eeDCajZcV82g1ppJHfgyPfu0
   w==;
X-CSE-ConnectionGUID: ssg+4Jt0R3uL0oQGrBNdeQ==
X-CSE-MsgGUID: arCUD+mwTwOGBIgGmrV7dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92360829"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92360829"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 07:20:41 -0700
X-CSE-ConnectionGUID: v4rwG5qwRiCclxFA+2ffyA==
X-CSE-MsgGUID: zQsyU7qXTaKXz3V8FBVM/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221512826"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 07:20:39 -0700
Date: Tue, 17 Mar 2026 16:20:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Chuck Lever <cel@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
Message-ID: <abljNCs_wjNELf6b@ashevche-desk.local>
References: <20260303140725.86260-1-seanwascoding@gmail.com>
 <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com>
 <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
 <63721454-ffbe-4725-b2c3-843560a3d5e0@app.fastmail.com>
 <CAAb=EJVw8S9o+N2JcBQridSPeNOHQgpiFAPqeNV-X-uSxwjvqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAb=EJVw8S9o+N2JcBQridSPeNOHQgpiFAPqeNV-X-uSxwjvqg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20235-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 10EFB2AC19A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 09:04:07PM +0800, Sean Chang wrote:
> On Fri, Mar 13, 2026 at 12:14 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Mar 12, 2026 at 11:54:15PM +0800, Sean Chang wrote:
> > > On Thu, Mar 12, 2026 at 5:47 AM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Tue, Mar 03, 2026 at 10:07:25PM +0800, Sean Chang wrote:

...

> > > > Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?
> > >
> > > Regarding the LKP report:
> > > I have reproduced the Sparse warning (void vs int mismatch) locally.
> > > To resolve this, I'll use the do-while(0) form in v3 to ensure the macro
> > > always evaluates to void:
> > > -# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
> > > -# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
> > > +# define dfprintk(fac, ...)            do { no_printk(__VA_ARGS__); } while (0)
> > > +# define dfprintk_rcu(fac, ...)        do { no_printk(__VA_ARGS__); } while (0)
> >
> > Wouldn't be better to drop ({}) in nfs_error*() macros?
> 
> I understand that the ({}) wrapper might look redundant at first
> glance. However,
> even if I remove it, the return type remains an issue because no_printk() (which
> dprintk() expands to) already contains its own ({}) statement expression.
> 
> To resolve this without refactoring errorf(), which hasn't been
> touched in years,
> I believe modifying dfprintk() is the better path.
> 
> One alternative is to explicitly force the return type to void like this:
> ({ dprintk(fmt "\n", ##__VA_ARGS__); (void)0; })
> 
> While this ensures the return type remains void (consistent with the
> behavior before
> dprintk() was redefined), it is admittedly clunky. We could wrap
> (void)0 in a macro like
> #define nothing_to_do ((void)0), but that adds unnecessary complexity.
> 
> Therefore, I still prefer Option 1, as it restores the original
> behavior from before the
> recent commits and maintains the cleanest code structure for this subsystem.
> What do you think?

Personally I found the ({}) in nfs_error*() redundant and the point of those
functions not being touched in years doesn't work for internal APIs. Do you
know the reason why it wasn't touched? Perhaps there was nothing to do simply
with that until dprintk() issue reveals some (legacy?) stuff to improve.

I would not go with (void)0 approach, but I also think that dropping unneeded
(if confirmed) expression wrapping is a good thing to do.

-- 
With Best Regards,
Andy Shevchenko



