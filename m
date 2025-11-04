Return-Path: <linux-nfs+bounces-16016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149C1C32290
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 17:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD484216FF
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6952E3375CD;
	Tue,  4 Nov 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQXT6I3z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDBA33769A
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275238; cv=none; b=OLpJ/c0ximgwSWfNX3cOb+K+ifs10wEFqjgirBdA/KoAnGss1AXXP7AEKQZfbY+/+bOUUdNouzIQBZHkhs6MxrXvS9PeknmqY0wMDRNHf00qS00QMu0Dz+ZbQEyb1MwOJVzMDKAt6gx8GQlrkxt4hXzW9uqWlsq9xEvj36d8Zqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275238; c=relaxed/simple;
	bh=801Y4MEGjmcd1waB8sN3DVwqfK3PY8whbEFeV7sghKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ11kg8gRK35VbX3LpNTS1kyAfHn/v6xlRncLbEJxqIumFGc2h+T1l2LZ8yU91hpB7ioIA2CzuIlCMnO0ksJf9vySma4WdS09EbYtfD3N6wChsXg7NCJjjCXEDC3YKjIOuAf4DV2EThpNYuhkSTlBN6oR4plbBj7So5jEXgX/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQXT6I3z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762275237; x=1793811237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=801Y4MEGjmcd1waB8sN3DVwqfK3PY8whbEFeV7sghKY=;
  b=dQXT6I3zlHf/S/M7QIvYEOKjA+Vl5+WWtHOTHSgBjYOixZAARhKlDElO
   piAJ3QFvLrvbnyv6d0ZzsB2fjWrRcD7n/y/4e37kzbWTkoiGKUGWzjIrU
   U5Tvde+ZVW/KTjek5LmQnHPB2NuLNOAPN6rkRyp2Z75SZTmUbu3CCg5G9
   xzKwuPquenLFjdKZ+aEVJ0hmxW16JXj6CCg9zmfGie5d3LV13UFProG01
   XzzX6OdttRp2++0OArJmTJWImAQzdRZY0AYmMWaUB4ar1hUIrN+ZguLfg
   xIOUVs6Hkw39ZuhVjVo4yD3VnL7p3qORM5/O7J6Em/j0nXIam3XKMDAmO
   w==;
X-CSE-ConnectionGUID: Mi/jlFg0RQqktAYsP0xT7A==
X-CSE-MsgGUID: UIY4XoZPRn6apY6RhyFf/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64414004"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64414004"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:53:57 -0800
X-CSE-ConnectionGUID: R9w+IGxtQxuBXmN+JFHhuw==
X-CSE-MsgGUID: RfOA+qdoRJKOIXS4MEfK7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187154927"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2025 08:53:55 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGKHE-000Rd6-08;
	Tue, 04 Nov 2025 16:53:12 +0000
Date: Wed, 5 Nov 2025 00:52:06 +0800
From: kernel test robot <lkp@intel.com>
To: Olga Kornievskaia <okorniev@redhat.com>, trondmy@kernel.org,
	anna@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 3/4] SUNRPC: new helper function for stopping
 backchannel server
Message-ID: <202511050011.oPM1X3Kt-lkp@intel.com>
References: <20251103221339.45145-4-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103221339.45145-4-okorniev@redhat.com>

Hi Olga,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.18-rc4 next-20251104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Olga-Kornievskaia/NFSv4-1-pass-transport-for-callback-shutdown/20251104-062226
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20251103221339.45145-4-okorniev%40redhat.com
patch subject: [PATCH v3 3/4] SUNRPC: new helper function for stopping backchannel server
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20251105/202511050011.oPM1X3Kt-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511050011.oPM1X3Kt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511050011.oPM1X3Kt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/sunrpc/clnt.c:40:
>> include/linux/sunrpc/bc_xprt.h:73:13: warning: 'xprt_svc_destroy_nullify_bc' defined but not used [-Wunused-function]
      73 | static void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xprt_svc_destroy_nullify_bc +73 include/linux/sunrpc/bc_xprt.h

    69	
    70	static inline void xprt_free_bc_request(struct rpc_rqst *req)
    71	{
    72	}
  > 73	static void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

