Return-Path: <linux-nfs+bounces-18718-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGg3KXJ8g2nyngMAu9opvQ
	(envelope-from <linux-nfs+bounces-18718-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 18:05:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAEEAC6E
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 18:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52D1F302C906
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB4341044;
	Wed,  4 Feb 2026 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ksyb/Mwb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322833F390;
	Wed,  4 Feb 2026 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224340; cv=none; b=iZCiZuwkXAokt6s2i4bSL8aHBcNLQvL8N57JWm5jfKSpTMGMQVhRO4UFINDn9voAo5BTDF5EMlyUKpbAMacMtVzZTXcL/hZACU1LZzzM/euDBGiV0dcu/tU+uJJ8+X0Ud/nBbecROmJ+zDgmnl3QNfdSh0UvlVZyAm08fJwehuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224340; c=relaxed/simple;
	bh=5p4eUAg3z+8rWM3HHAefWU2eIILWHVSOg4eCtv94Be8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYQ2Q5gRfTRGZovQYsQ3wkevuJpnR4KabuBbGFuWCmb5fwPWXMIaPvXIy+3UbLDDJALcyygLWEYRgtKAyDzYfJnxNNv0pHVARH20s7FNyyGhSYIqUheivsYvfHqkHDNqJvKx2oWilxv4SRReTcwwI8GLcplgKsxuZPf0DIvHEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ksyb/Mwb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770224340; x=1801760340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5p4eUAg3z+8rWM3HHAefWU2eIILWHVSOg4eCtv94Be8=;
  b=Ksyb/Mwbs19SoWAkhfAS5GmljW8bNWZ1cEWDEHDBrb4Z6SDfmDFgtJ1/
   M8Z2TeOPW0K0xl4YvgEgelj1WT+iIcD8wQu0ZTvuOOtcWx4hsxS9267D+
   +8ak3XE59GvsxMiV6qaZbBQZWg0cTQhpraUx1UiGjnY5PEzk4lJRjxfxx
   N/FUQKxQPLLOu4eAw5GD/DmtH2eEOZbD6gZJnxe5vuBKIUDzQ2z3JvTZY
   2pEqyC3ZMGbNvqsq0iarG2iEruCpjtrC0AZO9rLdihd22t5ZDHHKCuJnw
   IKdyarISivPSrsZJOX58BNyuP69c5oigolKa9glp1O4rALMQyBEUSj2kx
   A==;
X-CSE-ConnectionGUID: jZA7+tuISp6pMP32jyus5g==
X-CSE-MsgGUID: 5vScNTRMR1aLToSafRv6gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82047809"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82047809"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 08:58:59 -0800
X-CSE-ConnectionGUID: Bw+BDVbtRHK1sm+swOUD+w==
X-CSE-MsgGUID: +/Lw7ZhnRkaIdrvvE/BVmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214748988"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 08:58:54 -0800
Date: Wed, 4 Feb 2026 18:58:52 +0200
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
Message-ID: <aYN6zA79q6yOLFmA@smile.fi.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <20260204094500.2443455-4-andriy.shevchenko@linux.intel.com>
 <aYN35agQMKaIGZA0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYN35agQMKaIGZA0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com,glider.be];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18718-lists,linux-nfs=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs,lkml,renesas];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1FBAEEAC6E
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 06:46:36PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 04, 2026 at 10:41:23AM +0100, Andy Shevchenko wrote:
> > Clang compiler is not happy about set but unused variables:
> > 
> > .../flexfilelayout/flexfilelayoutdev.c:56:9: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
> > .../flexfilelayout/flexfilelayout.c:1505:6: error: variable 'err' set but not used [-Werror,-Wunused-but-set-variable]
> > .../nfs4proc.c:9244:12: error: variable 'ptr' set but not used [-Werror,-Wunused-but-set-variable]
> > 
> > Fix these by forwarding parameters of dprintk() to no_printk().
> > The positive side-effect is a format-string checker enabled even for the cases
> > when dprintk() is no-op.
> 
> I'm afraid this is not end of story...
> I received a dozen of minutes ago a new report and now I'm investigating.
> 
> Patches 1 & 2 though are ready to go.

Okay, if I'm not mistaken the only leftover is the missing tk_pid field due to
conditional inclusion. However, if we do that unconditionally the data structure
won't be expanded (there is a gap of 3 bytes. (Dunno about m68k, there may be
actually +2 bytes due to 2-byte alignment.) The rest of the conditionally included
members seem not being used in dprintk().

That said, removing ifdeffery around tk_pid in struct rpc_task should fix that
problem.

If you can fold this to the patch 3, would be nice:

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index ccba79ebf893..0dbdf3722537 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -95,10 +95,7 @@ struct rpc_task {
 	int			tk_rpc_status;	/* Result of last RPC operation */
 	unsigned short		tk_flags;	/* misc flags */
 	unsigned short		tk_timeouts;	/* maj timeouts */
-
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 	unsigned short		tk_pid;		/* debugging aid */
-#endif
 	unsigned char		tk_priority : 2,/* Task priority */
 				tk_garb_retry : 2,
 				tk_cred_retry : 2;

Otherwise I can send a new version.

-- 
With Best Regards,
Andy Shevchenko



