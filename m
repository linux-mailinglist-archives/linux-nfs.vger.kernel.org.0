Return-Path: <linux-nfs+bounces-20301-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIENN2OdvWmW/gIAu9opvQ
	(envelope-from <linux-nfs+bounces-20301-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 20:17:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A42DFD4E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 20:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2723302BE2F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 19:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890F34A785;
	Fri, 20 Mar 2026 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMrXv9Uo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF552FB965;
	Fri, 20 Mar 2026 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034271; cv=none; b=ek9tw6ORnJCpDqY8MypZE1/ZYEPprsVajJyJL8Q3EQ0UjDQNtB6OJ2eUZRP3i/zvQp6bEDMKcNk9fvVafCran95LdBhOOwQN/tPFNSMd4mbY8Ld10sDwdWRsFt8+EBGuRWyGMqjOa+egVwlsCJbRqRhKqzXUz/aJwjqBrb6PRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034271; c=relaxed/simple;
	bh=TEMmjn3iMl321EDkY/zXZ7b/nNbu7lS3NrQwZhflzXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF1keFVRIY3jJXTu9mWtgLpt4/KBlB2i1Kz0FdtOK8xMafjc/1yzdWMabOlvtgkzkN3+Ocw9CGjBqHiBB5DD/ZNfCv5p+AOL34wThnUtfcOTjn7IAA7ibbhtnqKUhkZWocE0IgWiHF4mcoV2ILMp4h8FSwlF3uxFHE9kfV3e9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMrXv9Uo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774034270; x=1805570270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TEMmjn3iMl321EDkY/zXZ7b/nNbu7lS3NrQwZhflzXs=;
  b=RMrXv9UonllRr/vRUlylv7vpXuOOW07KxFABF+tSGPyE+/rbtIhsX5W/
   452a6IM1uGjvt4Wzz7VlJtTUOZIVu5VnGPo+9KpdqCxcCfCxwSqytStie
   0ppTf+s1xyvmBG1lDffoacI4KYIn6Qojj1N0LmxMULiVUUFG9KTcwERvt
   JoFMXqgF3amvL7X+ruU3RL8IQX5obZ25WsfMEofqFGUHE/3BW53Lnr/xr
   Cs1vpktMXY0nSaeGNPsTq6Dv/jwxCoatWmJ5M3B85+Tf9yE24neAPVwIL
   5Fdfv4aoJeG+/A3pbAar10R2xTaBpgSKozz7+1hPcT+D7gGKe/DACH71+
   w==;
X-CSE-ConnectionGUID: HX8UKrdgRUCmAMxK+u5ctw==
X-CSE-MsgGUID: b0hNBLwFTpqTTDZaag89/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86491198"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86491198"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:17:50 -0700
X-CSE-ConnectionGUID: B3nLcsC9RjqrkKBFgv2QEg==
X-CSE-MsgGUID: ipf3TxK7S/G78JlkoVyC+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218695307"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:17:47 -0700
Date: Fri, 20 Mar 2026 21:17:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] nfsd: remove obsolete __maybe_unused from
 variables
Message-ID: <ab2dWegGmQOX61nA@ashevche-desk.local>
References: <20260320180955.150696-1-seanwascoding@gmail.com>
 <20260320180955.150696-6-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320180955.150696-6-seanwascoding@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20301-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 440A42DFD4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 02:09:55AM +0800, Sean Chang wrote:
> Now that dprintk() has been refactored to use no_printk(), variables
> used only for debugging are properly referenced by the compiler even
> when CONFIG_SUNRPC_DEBUG is disabled.
> 
> Therefore, the __maybe_unused attributes added in commit ebae102897e7
> ("nfsd: Mark variable __maybe_unused to avoid W=1 build break") are
> no longer necessary. This patch removes them to clean up the code.

Just make it a revert: proper Subject like 'Revert: "..."' and
the Git added line "This reverts ...".

-- 
With Best Regards,
Andy Shevchenko



