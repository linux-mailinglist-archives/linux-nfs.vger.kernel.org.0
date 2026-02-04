Return-Path: <linux-nfs+bounces-18709-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIWWEKZrg2l+mgMAu9opvQ
	(envelope-from <linux-nfs+bounces-18709-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 16:54:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB6E98D0
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 16:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F1A13001477
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8FD4218B6;
	Wed,  4 Feb 2026 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALK/qwkl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1A2C026F;
	Wed,  4 Feb 2026 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220292; cv=none; b=mDc43vuLfrnw30uDc8bAvz5ULQUF/9YMZS231MCnEg+WXIsNGcaQTxSvBp4+Wu3mee0P9PB2M7BuKW8o/UO7o8mQY8eub66szbV+fus6S10jJ0/kugJ35vG4R2z2qp8rFXv0Jz9bbSySsG1lC9HSk/djbC3deDJFPaIvf85m9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220292; c=relaxed/simple;
	bh=uyBCUjP/mwjgx//FVeT4gz8yf648jspRHIOMRLzx6GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0Di4BtY0stVHL0RFDjgjd8+BbKQO6dzL614W4yuUzv8JgEFVUDJLw0h4DWjWU76U01gHZ3dlH1g/gy3teHKNASdNDhj0srRvLZV7Pt/Z1Wk2tWtIs9gRYuZUN5VheOm/BFRZgBZEAKjvzSxhMweMP+6aZs7pWAsj6WQefgLsFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALK/qwkl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770220292; x=1801756292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uyBCUjP/mwjgx//FVeT4gz8yf648jspRHIOMRLzx6GQ=;
  b=ALK/qwklIWkXON9r2dnOSmHhJ2oVknkmhHm/SdQzUr4hHbWN+TT8TMS2
   dDZ6zsSE3QhT2ec0nbpEcFcXPXIMIRv7b97ZsfT1sjDQUD8JDSTLt6+Lp
   MPZ7d31euFUL1MdTgFItOJtcogZX+G2p7hk5hu+6xVSXCt3ux7SyZOKpn
   3FXEdtQ61LYGk+2VhsdZ2qmirnxOkMzVPjaOc16dANV5YmUbCO/4ac2SS
   sgnsC0LT6XKoWiSPNKz4awKGhPa0NI6EBpi/63/xn1abswVGP2GE+MP3E
   Y0OioKg8s3ZtnpKSGfjeRanyGx07PvWKZsBG6t+DUib4cBaYTVZeu0KwC
   Q==;
X-CSE-ConnectionGUID: 5fjRa/6dTwC1eAQccT3JIg==
X-CSE-MsgGUID: ehnLUmwARFCMOvQJCnKOIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82845518"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82845518"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:51:32 -0800
X-CSE-ConnectionGUID: DdqKZCfuQg6+wVF0bCBX7w==
X-CSE-MsgGUID: PFTl2NZWTq+XwlXAndXRlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214693284"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:51:26 -0800
Date: Wed, 4 Feb 2026 17:51:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
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
Message-ID: <aYNq_PdXPo-S-ItG@smile.fi.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <177021968762.97318.15008544066362314853.b4-ty@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177021968762.97318.15008544066362314853.b4-ty@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-18709-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADFB6E98D0
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:42:06AM -0500, Chuck Lever wrote:
> On Wed, 04 Feb 2026 10:41:20 +0100, Andy Shevchenko wrote:

[...]

> Applied to nfsd-testing, thanks!
> 
> Acks from the NFS client maintainers on 1/3 are welcome.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



