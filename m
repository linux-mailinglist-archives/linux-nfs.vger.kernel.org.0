Return-Path: <linux-nfs+bounces-19496-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMRcIqyQpWmoDgYAu9opvQ
	(envelope-from <linux-nfs+bounces-19496-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:29:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24271D9C21
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37D5C304482A
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC153E7151;
	Mon,  2 Mar 2026 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmOZ4vL+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE561327C1D;
	Mon,  2 Mar 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457985; cv=none; b=GnPvfECMIQP8uPfu42tPGHh2RiVpJ76fIhgjCWEb2FNwdZVC1pATO1kAvyT3g8Iagk/1jMLgHqPwc/IGcQ0wAFujjceX6dx2BVd/V6G00Wg4XU3T2p42hxlW+4h6JNBXrJsNI6KjLnxrsDgfPvEEh2uEHNI1U1FFrDARNm6nxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457985; c=relaxed/simple;
	bh=Oq3083InT95hDnL0d3fLGwg40l2fjvqKCt9OdKGjoPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv/2PS8/BoGhdR7QETXBGVfK+7dPOjMzl7LVI+mKv1iNOrisQ6PYFeCspDZE51xmWlLjDnwbRttlgN8gsor46d2h8eFqPcxJ0mOGFu7OD7Byx9CC9AQX/EwcUUuS5ExHYmW8RdQNX/qXemqUEVMUo6H6wMm4ZaauJgzOhU2HWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmOZ4vL+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772457976; x=1803993976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oq3083InT95hDnL0d3fLGwg40l2fjvqKCt9OdKGjoPU=;
  b=RmOZ4vL+Z78SFdb8MtllYFb6B3ASI1qhUucpg6hzmfK/MIx5k2n/K6GT
   uFQ5RQ4NYoK/8YsY3MSa5e04Ca3jJUs8PR8h5ziZaAlUDkNdqTQKQ5PCE
   DsrfK8fuN/Q5FoKdG3mQ4j399v6kve9kovpXUBTqPxmkyrB+bQoIoQEo8
   j8GOLf/r1Tw52Cl2q8Z5fBmAGEFcFxis39+PxkDVm2jVHS/gRJ5ZbTIqR
   i/XX4lRW8FqMCvbNHPapvYOIh9OLAq8PZsu7wJEQa6yAhU1z4vN49ScFq
   aC1N+R+ie3Q8DvOdrBx0Ga5vptzCbWSXNweVp5tSHF0G49v7k0qrEJhwR
   Q==;
X-CSE-ConnectionGUID: j/pdP1kHSLG2PpldPgiPXQ==
X-CSE-MsgGUID: GmjW/NeSSaqmqBuIqm3vcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84813196"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="84813196"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:26:15 -0800
X-CSE-ConnectionGUID: Z0dJ11j+RneoDliohktGbA==
X-CSE-MsgGUID: CzH7D8c/S2axnstD4ko87Q==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 02 Mar 2026 05:26:12 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B20A999; Mon, 02 Mar 2026 14:26:11 +0100 (CET)
Date: Mon, 2 Mar 2026 14:26:11 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sean Chang <seanwascoding@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Fix compiler warnings/errors in SUNRPC and MACB
Message-ID: <aaWP88PplFTsAPg3@black.igk.intel.com>
References: <20260301161709.1365975-1-seanwascoding@gmail.com>
 <0a784056-f57f-4634-aa7a-fd0b5916f40a@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a784056-f57f-4634-aa7a-fd0b5916f40a@lunn.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19496-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,black.igk.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: E24271D9C21
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 06:39:44PM +0100, Andrew Lunn wrote:
> > - Verified via .lst and nm that both variables (buf) and helper functions 
> >   (nlmdbg_cookie2a) are fully optimized out by the compiler when 
> >   CONFIG_SUNRPC_DEBUG is disabled.
> 
> Thanks for doing this bit. It was needed to show my guess was correct.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

It already has your tag. My Q in v5 still stands: Why is this a series and not
standalone changes?

Also I just gave a tag, please split these two and send individually.

-- 
With Best Regards,
Andy Shevchenko



