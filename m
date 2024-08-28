Return-Path: <linux-nfs+bounces-5858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93377962816
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 15:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FA1281AAF
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C27184118;
	Wed, 28 Aug 2024 13:00:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B317C9BA;
	Wed, 28 Aug 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850000; cv=none; b=VQajDH/kR60+0TZ6AMzPkE6eXAXmqSR+NyoEXrXHeb0tKZ6UC/4J/GpQ6GYG2MYEklpuuaQuga9qiDzaIucJAurSIQzBDyy8WvXH4ZJ0Ib2rDua26woIrr/rJQrn9rUqmIMEl7eaTIer75MRwY7OdfQJtmuKbUKum3J3NofY8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850000; c=relaxed/simple;
	bh=45+XOa+myqwiH2qv1C8HzTdaZrwfZYOu9x8QlPibbRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prtSILLdGdFCfueMAILOLP9EiONkLGZXJYOHNU3GSF+3kEbosKLWA08z8MO0qIPgnB/rYuRLaCGuhQ9s/8xRiDiLhqd6yZ0C31O2qBqREmckwQCrsyYagf8ZC3qrs5iwtZh1Mauv/BHtGdazPZlA3xlEfhMVcF1CPDCIWkKPaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: zPf7fOaKTga/0YyJPEDDYw==
X-CSE-MsgGUID: CUOQ2bnmQYuVI/TkVeHsiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="22958483"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="22958483"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 05:59:45 -0700
X-CSE-ConnectionGUID: cOay8UndTUuSV7nd1+KHCQ==
X-CSE-MsgGUID: lLcf8IIZRiSMHnXNRER7JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="68104546"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 05:59:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sjIGx-00000002eHy-1NNZ;
	Wed, 28 Aug 2024 15:59:39 +0300
Date: Wed, 28 Aug 2024 15:59:38 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, kees@kernel.org, trondmy@kernel.org,
	anna@kernel.org, gregkh@linuxfoundation.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH -next v3 1/3] lib/string_choices: Add
 str_true_false()/str_false_true() helper
Message-ID: <Zs8fOjcHcsjZXR5a@smile.fi.intel.com>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
 <20240827024517.914100-2-lihongbo22@huawei.com>
 <20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 04:42:18PM -0700, Andrew Morton wrote:
> On Tue, 27 Aug 2024 10:45:15 +0800 Hongbo Li <lihongbo22@huawei.com> wrote:

...

> > +#define str_false_true(v)		str_true_false(!(v))

> This might result in copies of the strings "true" and "false" being
> generated for every .c file which uses this function, resulting in
> unnecessary bloat.
> 
> It's possible that the compiler/linker can eliminate this duplication. 
> If not, I suggest that every function in string_choices.h be uninlined.

From this perspective this patch doesn't change anything.
The function is inline and in the same compilation module the linker will
optimise away the duplicates (note as well that this is kinda new feature,
some relatively old GCC might not have this feature, but I'm not an expert
in the area).

-- 
With Best Regards,
Andy Shevchenko



