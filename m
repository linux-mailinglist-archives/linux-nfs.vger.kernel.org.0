Return-Path: <linux-nfs+bounces-18693-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL6wJVwZg2n+hgMAu9opvQ
	(envelope-from <linux-nfs+bounces-18693-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 11:03:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACF0E439C
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 11:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF05D3014107
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FD83D3D16;
	Wed,  4 Feb 2026 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3scJkMY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BE3D3D10;
	Wed,  4 Feb 2026 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199385; cv=none; b=BgraNL4t2r2gQypo+/EY2/HQwo1wRo6mAVzLDeRXZuLDr0SbfBEbRdh0ThpHCwhsFrMzcZg7zTL6kSozGNqTS9BB7UFG3BSKohPbWrHYlFgYp8fIGR7mawt9BFS1rLPl5/Q5/7rkCjTdIIY+FYD6aB2h5uvx0y24SFJovr/DHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199385; c=relaxed/simple;
	bh=L0AVkdO3hbuHTV7sU08P2NN9g6svFVp8MHcCj6JP2IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elWiloJS1HwyagWMx8n+wjhnE/fxhNHRjJP4eT0f79lyPxpN6VfEX1g7NNtFZoXAJzE/zEGdpCQ1l7Hxpo7Bw1Rbbw5HAugRo98v9Z0Z1HrQ4Vs9XFAj1ruIqO7MulmfW/+Jp4ecCe33Wh5x/FiuXipS4TD+cnjNSs01/btmfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3scJkMY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770199386; x=1801735386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L0AVkdO3hbuHTV7sU08P2NN9g6svFVp8MHcCj6JP2IA=;
  b=K3scJkMYyjz+1DQawnJsDWd9FthMvc472q0O4RDvU9Brf0W/y+N+A962
   Sgz0QN7plK40nKT0C2kKl9FI5NgtVd6yIc7DYpl6MAr2iyNsbbhcQfsQ3
   4bcS0LTyBiWqzvbmUyxbOIvjRZJMTAOZzvnb6Mb9wXm3+CXZ4LP3/ufFV
   kqzrMH2cAIDbBlhyyhoVNBO7xnJahEPCaUTnauCzQ+YkUoyUFCAbDcrco
   xpebxc5ZqMq48m94X31QFE1i7r9N7H1hHcmEmY0CcWYWBLDaPKZKdBKyP
   izekRGyQbONv6S/aXOiH+dlrqz8xO4Ty/LoQzEeQ4Q8lu+G8eoefUqQk/
   w==;
X-CSE-ConnectionGUID: a6iQmQbmS3maaXXFGxiFTQ==
X-CSE-MsgGUID: 8+j09xDsR+2Qk7Kqx5zO9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82124501"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82124501"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:03:05 -0800
X-CSE-ConnectionGUID: oO9W3EI1QwWtQFw+JeOHgg==
X-CSE-MsgGUID: 7oS+eukfT/aaZJgYE6teww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="233048748"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:03:00 -0800
Date: Wed, 4 Feb 2026 12:02:58 +0200
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
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 0/3] sunrpc: Fix `make W=1` build issues
Message-ID: <aYMZUuu39IZvBva7@smile.fi.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
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
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-18693-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ACF0E439C
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:41:20AM +0100, Andy Shevchenko wrote:
> Compiler is not happy about unused variables (especially when
> dprintk() call is defined as no-op). Here is the series to
> address the issues.

Note, I assumed that this goes via NFS tree, but if net wants to take it,
I will be glad as well!

-- 
With Best Regards,
Andy Shevchenko



