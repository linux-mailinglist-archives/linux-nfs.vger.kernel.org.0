Return-Path: <linux-nfs+bounces-18686-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI29EFQNg2k+hAMAu9opvQ
	(envelope-from <linux-nfs+bounces-18686-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 10:11:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A097CE39DF
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 10:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58DEE3038289
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8773A0EBA;
	Wed,  4 Feb 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFpR6ZYd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36493A0EAA;
	Wed,  4 Feb 2026 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195993; cv=none; b=kGKyXc/BJKXxCkOItfznbKwSvj3Nvce3mYKf1PDKZwhBzMkSqf+OsvfTdUZL4iWp5lS8lEFBQYfzbkUcW0DSGNGt6LA4oyDWcTf90CPABAO2mXQC4n9qsmvAvNiEioxjb2Tvt3aeDpde1iF1y5cqJW3tOUqLXkfqRZquRpwE/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195993; c=relaxed/simple;
	bh=LFPO4C23K7OoNSgXRpJHswJquymHaqFVqV8EhvfrOO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6jXZwbHxUWAQr6NXmj/n/PNBwhL3hDIlzcVBsi02UVALEuu4khzAznnPEdoPpyBNXvzX5378H5xabtconV60sLVuqCvId9lclUbxRQT1gUMI3qrTILSx9DdTFKnlK/bBGObUaGtZBC2/f84afsaY7DvTG5XSjv8mvkFBWeaGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFpR6ZYd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770195993; x=1801731993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LFPO4C23K7OoNSgXRpJHswJquymHaqFVqV8EhvfrOO8=;
  b=oFpR6ZYdSeeq43EDRjaesIc/58MoQeWD6di064xox/IcsIr7tJmE3ZLU
   duOsY/FWMl71yhAEtNuxSVSNGbaanVB9jgPQRXq4hZrG3jXNxQ6YV6fAL
   j7axxuUXPusV3XBdJlhpnzgBsIDx0/Ct6DOlIHihetAx6xM1pOy9SZ/Sh
   cRJFmxpOsrqvWShZZTY+j/e4o+ZaZDl/K6UjopI/ZcFDp+R/j18LuP+5Q
   durn4l3Gj/7PkQgaeaBnbVezIe5D/E4qRteCLfQc6ysly/1aTmWdMmXfT
   KzHasVkpjZBTalHYyUdHSgF2tbdzKqOpFSe/Dp+1smXl08Cgblgp7P4IF
   Q==;
X-CSE-ConnectionGUID: OIZSch2NQMaaPMlhsKUgkw==
X-CSE-MsgGUID: GDEfA88nSii7W4jJm9aoeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="94032021"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="94032021"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:06:32 -0800
X-CSE-ConnectionGUID: 6zHI9yqNRra81qGksnMc8g==
X-CSE-MsgGUID: pmuFWp8US6mups3l7WIsrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210160815"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:06:29 -0800
Date: Wed, 4 Feb 2026 11:06:26 +0200
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
Message-ID: <aYMMEiNCPaJIc9Rd@smile.fi.intel.com>
References: <20260204010415.2149607-1-andriy.shevchenko@linux.intel.com>
 <aYKcNds-XsVLRjcC@smile.fi.intel.com>
 <CAMuHMdWZx=2-y_OSjCkxmXo-3YjGjU0aH89puTcL0rmvw7E-Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWZx=2-y_OSjCkxmXo-3YjGjU0aH89puTcL0rmvw7E-Eg@mail.gmail.com>
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
	FREEMAIL_CC(0.00)[oracle.com,brown.name,kernel.org,vger.kernel.org,lists.linux.dev,redhat.com,talpey.com,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-18686-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A097CE39DF
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 08:53:39AM +0100, Geert Uytterhoeven wrote:
> On Wed, 4 Feb 2026 at 02:11, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Feb 04, 2026 at 02:04:15AM +0100, Andy Shevchenko wrote:

...

> Definitely.  I tried something similar a few years ago[1], but ran into build
> errors from the robots, and gave up due to lack of time.

For the matter of fact, I also get into errors from LKP (I compiled only part
of this, need to enable more to cover these cases).

> So for the principle:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I will do more tests and fixes and add your Ack.

> Ah, my local tree still has the following fix I never sent out, and still
> looks suboptimal:

Right, thanks for sharing, it's the same call robots are not okay with.

-- 
With Best Regards,
Andy Shevchenko



