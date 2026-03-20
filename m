Return-Path: <linux-nfs+bounces-20290-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFE2IRQ5vWkN7wIAu9opvQ
	(envelope-from <linux-nfs+bounces-20290-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 13:09:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC7A2D9EE9
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71204300E253
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966BC3A640F;
	Fri, 20 Mar 2026 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ND1ESRaH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BF39A06B;
	Fri, 20 Mar 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008519; cv=none; b=glExonf8n06qLpNcqqeKUtwEvbVlcORUtXvpl2dPHoopem9A6AIvqmwPQzRCZOjw1pb5NXMleBx3qHE2VCuVU/MQRHlltS/TYygMoVXxCIWIUal3XbCagcymwhP1cHFaBDR/PK5RCDdEfBGWYoezWZquZJJXp/JnmfNn061cP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008519; c=relaxed/simple;
	bh=rt5mAqVgT2DpnDuBJS+RgFzkBgiqbY7caCPN2LAI86M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+HrDL5QomWq82MkMhuMqIbFi3nD0zYnimSbA1kZRO2mBN4dytOs5n9E9v6qls5C+6dFjojUHtKul+flGU/Z+LbcXS//gBQd482C6Vk4tQ9AswvWPSiZ94LQMOPfkhLYwS8YSboD9kbyMc/f6v2eDkBet03DJdiz/1XoeLRnisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ND1ESRaH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774008519; x=1805544519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rt5mAqVgT2DpnDuBJS+RgFzkBgiqbY7caCPN2LAI86M=;
  b=ND1ESRaHpxHvYdrBOzW/ecdMwpwPCLCMFdhYshpqGfigO0XzPmgAwJwN
   jq+g7kZztdO0gVExJAXEXz1JI5x3Z/ijPE7TxxMIaTYQ1rw+8TmOe101e
   JEosQ4MASLJNWqUdZ513ZQa6+6/tbPGsbF8cufL9+OSNQSV72lmbtCbiE
   QGacXZ22O5HGKNEodpU3oUCrtcG/C1h7phWr4pgVB1sNkVImSguI9ibsj
   EOUhkcfUB4ZF46qaAas5avCTXqjWSPjfrZhgb83FYZrBiCJOmnMycCI5V
   ayedkqYdh5i5g5UrD0/uO61tFH+RI3ghxPdeNmzC4oMyVNMn2qU4pnxOM
   Q==;
X-CSE-ConnectionGUID: fxGVwqtCTGuECCT/egMyrw==
X-CSE-MsgGUID: rESNOd8SRWOhux3XRuOaWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74981525"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74981525"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:08:38 -0700
X-CSE-ConnectionGUID: QnkFAKxkSRyO93ncc+2hmg==
X-CSE-MsgGUID: aCVnXZOuT4KHWhsptBu7bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="219080561"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 20 Mar 2026 05:08:36 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E488295; Fri, 20 Mar 2026 13:08:34 +0100 (CET)
Date: Fri, 20 Mar 2026 13:08:34 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] sunrpc/nfs: cleanup redundant debug checks and
 refactor macros
Message-ID: <ab04wi3x3JNVbvPm@black.igk.intel.com>
References: <20260319141846.78222-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319141846.78222-1-seanwascoding@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20290-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: DEC7A2D9EE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:18:43PM +0800, Sean Chang wrote:
> This series cleans up redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards 
> across sunrpc, nfsd, and lockd, as these checks are already handled 
> within the dprintk macros.
> 
> Additionally, it refactors the nfs_errorf() macros into a safer 
> do-while(0) pattern and removes unused nfs_warnf() macros to improve 
> code maintainability.

Shall we also revert the commit ebae102897e7 ("nfsd: Mark variable
__maybe_unused to avoid W=1 build break") as it seems related to
dprintk() issues?


-- 
With Best Regards,
Andy Shevchenko



