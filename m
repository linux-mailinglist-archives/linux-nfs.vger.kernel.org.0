Return-Path: <linux-nfs+bounces-20302-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BU4MI+evWmW/gIAu9opvQ
	(envelope-from <linux-nfs+bounces-20302-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 20:22:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9BA2DFDC1
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 20:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 455573010794
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62AA34BA59;
	Fri, 20 Mar 2026 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nyf1rg6V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C018871F;
	Fri, 20 Mar 2026 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034570; cv=none; b=pHabdHTI36wfN1Rm0nYQL3zdCYXlb/Elm3LGL5ChTv+a5IEY4rwama/v/3lPYDLt1K1/+qEoqOlclbFt8VnzHiIZhskYopY++0TgqNyGHLJsdjju64AAmUICn4o2AzjJ7eT09bICtVlZJz2YWBBf3UiqnbNh0imfxII7lhvVZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034570; c=relaxed/simple;
	bh=dK3QJ4iCR375JMYjX/TnY9hSKx2X40OYPwjGQYpkHkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU1MeNQ1xWMws1MpOnM/imJLh57DFCyji6/gY9ojV/IcKNMroHDxjFunYbzPvmh9TRHjdh6no3E9ZuxpUX4Ww4IWdDHyjjL4Zj/JYGEMmZ/7WaJivgWYec8iRo2w0R73oDae6dTQDldCgksj/3RmWiJPchvMfwwzTc8MHb6GR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nyf1rg6V; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774034569; x=1805570569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dK3QJ4iCR375JMYjX/TnY9hSKx2X40OYPwjGQYpkHkg=;
  b=Nyf1rg6VKs4/gXZEa0XqwrnU6qhQhiIXl1EATZBVAhHVhwDZ8Ehq84Ut
   BlwqzUMvsJOpSawBiok1jA9MyWmKqk1jvYQ0YVm6XGUPJpDBM0QcGqsbd
   aBoAPYXUNf3zUalRTKNYgmgliRk4jSLyTNBI8PFlV1e1vDvQ01yZo7iHT
   GHM+KAfTggpmobeH2/liJ8EXwlsmBs5TvKZ2ahnW1Sc36OKWR8Pbxp1dU
   5KZgYwtXayI+1LBsR+P3uReIub1ZIiC5j0+tnuKhXCm5Nf6NbM8RVEHqp
   vGN0T4KtbrDWB4uj7QRyg+LcjO7U5IAGb5Rf6c5fMDDJlB3GNwqjFLV/X
   g==;
X-CSE-ConnectionGUID: JtkV4yzdQHWLqPA2IXtkFQ==
X-CSE-MsgGUID: tVsmD9gqTIOUUgV1moJvkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75319811"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75319811"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:22:49 -0700
X-CSE-ConnectionGUID: SqHKRMXgQBavEdT9xaiyXA==
X-CSE-MsgGUID: mkp7356GTjGVCOAO08ezog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223406436"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:22:46 -0700
Date: Fri, 20 Mar 2026 21:22:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 4/5] nfs: refactor nfs_errorf macros and remove unused
 ones
Message-ID: <ab2egy2-2YfCiJM0@ashevche-desk.local>
References: <20260320180955.150696-1-seanwascoding@gmail.com>
 <20260320180955.150696-5-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320180955.150696-5-seanwascoding@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20302-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 0E9BA2DFDC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 02:09:54AM +0800, Sean Chang wrote:
> refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
> pattern for safer macro expansion and kernel style compliance.

> additionally, remove nfs_warnf() and nfs_fwarnf() as git grep

`git grep`

> confirms they have no callers in the current tree.

You can also add that they were never actually used from the day of
introduction by the commit ce8866f0913f ("NFS: Attach supplementary error
information to fs_context.").

-- 
With Best Regards,
Andy Shevchenko



