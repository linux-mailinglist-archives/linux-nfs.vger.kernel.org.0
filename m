Return-Path: <linux-nfs+bounces-22230-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sLgQIOvmH2pqsAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22230-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 10:33:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B46635BD3
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 10:33:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=mcGXbX8m;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22230-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22230-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E64063022630
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67106407CC0;
	Wed,  3 Jun 2026 08:19:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBC23D7F0
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 08:19:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474769; cv=none; b=mRAlFSjXIsaQBOGtrAiItO4z3bsSwwk9RXS/kJT07GeCRkDCipJWXYhH/7J2VDp0ztkli1e77QwTpydMOYhmJ1yEXFkPRLmlcfMd6awUN0eVi2lGEDLdukmkmVxqdUva6kVJIpz2Nqtf+EMVHwaxsjzqjWzqBZfF8EhkX6faE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474769; c=relaxed/simple;
	bh=eR1KK9z9Afjg8V/D/SIP3xh+zLxBKi2Mag78w0KCiV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbvXnDSwEnYLeeNHpTeluM4lIcfVzsiloaOLDrys4SGY+63YYTot6RW4wDNFLR+MF8E0im9eU9mQISz5u8xFe75+/y5mSGvYTnxRbvy6BZfDIrn3BfzQQcxBmcWh5XamByxpRzbT8V0bKnZK9Jxfyr8IaHMWza1yUhv9nmJ6XK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcGXbX8m; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780474767; x=1812010767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eR1KK9z9Afjg8V/D/SIP3xh+zLxBKi2Mag78w0KCiV4=;
  b=mcGXbX8m2ukPQLllzlTTlyrITOmAMHaMivRIgq88vobtuFnb7zYRidtE
   9VLJl5LCMLJiVw4J5nkox1hY5xEH4eKEahdvHWO6u4T9A8r35Ftk7b1oh
   pmSql10dHr2i/mI4RDNz/zxtqxZbQ3svm8mIsZoXTuqhlElGogVurg9BK
   Q6BmUJZMSjQbErK0uKjFdypzqHVQCQxdYNjA/beczbZLISWohwt+F4qEJ
   zWxtaPXbg0euIAxjYdPAJ4xM0NUEIuMfl7PnKn/kZ8TsuRrYM1c/4W7xf
   ex5HCH/9fvnLh156pfrEK+28IfKqvvd15R92o8HOrNVMuoaTUq1XNH/Gq
   A==;
X-CSE-ConnectionGUID: 7qaVIjiYRo2AXjJre0Qhhw==
X-CSE-MsgGUID: 1mQrDzXUSSqzXHk6XnHxeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81305385"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81305385"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 01:19:26 -0700
X-CSE-ConnectionGUID: 9e1mPLtLTTq2e0nWMbYv6A==
X-CSE-MsgGUID: EPSYGF7EQTW9tybiJMCFrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243104952"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 03 Jun 2026 01:19:24 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id C1C5395; Wed, 03 Jun 2026 10:19:23 +0200 (CEST)
Date: Wed, 3 Jun 2026 10:19:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v2 1/2] nfsd: Replace open-coded conversion of bytes to
 hex
Message-ID: <ah_jizDKdRuVrniB@black.igk.intel.com>
References: <20250804224701.2278773-1-ebiggers@kernel.org>
 <20250804224701.2278773-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804224701.2278773-2-ebiggers@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22230-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,black.igk.intel.com:mid,cksum.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1B46635BD3

On Mon, Aug 04, 2025 at 10:46:59PM +0000, Eric Biggers wrote:
> Since the Linux kernel's sprintf() has conversion to hex built-in via
> "%*phN", delete md5_to_hex() and just use that.  Also add an explicit
> array bound to the dname parameter of nfs4_make_rec_clidname() to make
> its size clear.  No functional change.

...

> +	sprintf(dname, "%*phN", 16, cksum.data);

FWIW, since the length is static no need to use stack for that:

	sprintf(dname, "%16phN", cksum.data);

will be better.

-- 
With Best Regards,
Andy Shevchenko



