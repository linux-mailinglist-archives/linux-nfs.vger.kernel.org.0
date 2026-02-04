Return-Path: <linux-nfs+bounces-18728-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA9hBd+rg2lvsgMAu9opvQ
	(envelope-from <linux-nfs+bounces-18728-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 21:28:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1C1EC73E
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 21:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94C0D30214F0
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 20:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C790B42DFE5;
	Wed,  4 Feb 2026 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKQTrs57"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14B42982B;
	Wed,  4 Feb 2026 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236735; cv=none; b=jJVwOaHVX44gAwDBk9ZFGTOp7klPsRcSRqMX2QoaD9LcOi9FeoIniAbxVlmR1dSgW+tE+9fDCXWnEBOr2RQDpaRDZNzxCzXpJNNJzZ3aaYUhxiFRfnhMhZmhXGksbJXCiMYA37cfGu5VIbHX6JWgsu5Xy0FyVuYmj1tsPFgCEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236735; c=relaxed/simple;
	bh=Mu7rUnAG7sN1Zo07pAjayKdb+6XBVjosqS2rDV+LOGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0dXB3BGBwGXg8kXUjWg+BzgvqYLpgH6pXfcE0J6tM3J3D/63+1BEvOuLl3A71MlBq5YO9gfpS7JMZakdBhEZhYU0/0CzdeRnIRshVuufKTJ1QVIOHXPWYXoMj6HQxbzPpeI4d+Z3ajgtx5KChkoAlIzW3QS3uHuT+x2BNtQI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKQTrs57; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770236736; x=1801772736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mu7rUnAG7sN1Zo07pAjayKdb+6XBVjosqS2rDV+LOGA=;
  b=bKQTrs57EaRoTZblV+kpfVionqTRZqaJF/x4YQSD5trux0QSZrrN36M/
   ZfUJK6clttW2I+aP/7y6+1UiUoEd5k5Gn5r4UWu/yF9M7iXtiOO92N+hV
   2iHDyEz7BhZZMWXgV64/tvugp2pPJt3MJnuTDWb1Yh7KGBPMjvv7OYzTp
   wtod3H86xOjoCAdJyBfVenSXbJN9fq+yeWVvkywnb4wIM8vcRDv/+PEUX
   nJ2vG5uJNMGtqpfpBSt50q2za3ryKN9hZr5E7Iy1rR358+kbQM2xmMFBP
   R8qRH6qn/VZzs2q5zpNUZq5CooCS9PF+JgE4q5unWSDwq05ge2xvvsnAw
   g==;
X-CSE-ConnectionGUID: ZBsPG+tZSo2YhhlGn0mW8g==
X-CSE-MsgGUID: iHDYbuofSt+EYwQ7yatvqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82064591"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="82064591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 12:25:35 -0800
X-CSE-ConnectionGUID: jHmYirvsSl+AuzN3plx2qQ==
X-CSE-MsgGUID: OeuJ0L8uQz+PHdJHGlAI5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="210308305"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 12:25:30 -0800
Date: Wed, 4 Feb 2026 22:25:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
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
	Justin Stitt <justinstitt@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 3/3] sunrpc: Fix compilation error (`make W=1`) when
 dprintk() is no-op
Message-ID: <aYOrN-C6R0Hniwxl@smile.fi.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <20260204094500.2443455-4-andriy.shevchenko@linux.intel.com>
 <aYN35agQMKaIGZA0@smile.fi.intel.com>
 <aYN6zA79q6yOLFmA@smile.fi.intel.com>
 <c0af23c2-bdf1-456b-a82a-0f224d640473@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0af23c2-bdf1-456b-a82a-0f224d640473@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,vger.kernel.org,lists.linux.dev,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com,glider.be];
	TAGGED_FROM(0.00)[bounces-18728-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: AC1C1EC73E
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:29:48PM -0500, Chuck Lever wrote:
> On 2/4/26 11:58 AM, Andy Shevchenko wrote:
> > On Wed, Feb 04, 2026 at 06:46:36PM +0200, Andy Shevchenko wrote:

...

> > Otherwise I can send a new version.
> 
> Please send a full series respin, thanks.

v3 has been sent.

-- 
With Best Regards,
Andy Shevchenko



