Return-Path: <linux-nfs+bounces-12574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90747AE0682
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 15:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041203A5257
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310D23E35B;
	Thu, 19 Jun 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQ1D82t1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50204224AF7
	for <linux-nfs@vger.kernel.org>; Thu, 19 Jun 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338358; cv=none; b=pmwhKDqYMbH9pRKlN0gCfHdUMBKZRGzHUQEMZ4Nf+5iid8IutenxyxxtE2tdYYrEqkVTOry5K5JFBsTJHxNM6iNcgw/U3ERxnp/E3wFl+ujeqeUUpjtE0GyMpxqlNdHi5jzQBJkQ8CGA6Kzx7SkfaqNEmBTRTVUksOzOt7N+RN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338358; c=relaxed/simple;
	bh=3sLwub0kCxpt7FgCUch4YpkTuMlye/WYe1eo3ve+GI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImW0y0uZ1/rmsJy8BsGbPjNA7Ejm3bjAqoshl23oAEm6/V0dqwPB2FUjvi/TJ+m271+xo41/I6ntXmOEimc0/UJIEJLShypCJWHLSKHt0Ts7LCDYIMsXTHulWpFjVTCAZJf8Mkus1XXtjritIGkLNCv9XBDIxlbStpw3CL7lfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQ1D82t1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750338357; x=1781874357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3sLwub0kCxpt7FgCUch4YpkTuMlye/WYe1eo3ve+GI4=;
  b=jQ1D82t1TMPYWrq5ys2R3cmjMBsr7Ukce0cu2pEEgoFMrk5Oyw6rYgyv
   i1FeZJZ3bIsM61cwT7Rf8/ZMUom/CrG2mT6DMrz9p3/VCMtEnJlpBGXt/
   wgIa8zsjgXEtoe5WV9BbFPVhfKvajum/ZuZy57ITQym4hsQ6/f73AtLyH
   0RinNBWXolzUrG4RSkmvRMoV5EVFkv9idIhQWkcjXeG3T74aJsl2/3BVE
   Jv8RjVqTvjvYqkxTiuKERkVOS+72uRjnGiJVxAH/ykNW+zuhYN/WC9Q2T
   /nrry1MC+lX0fHAvEWw0t67d6xWvuNRS448Yp/ExUkU8Pd8EGcnstz7QK
   g==;
X-CSE-ConnectionGUID: GxkcvMR7S8KHsMpvbAg+0g==
X-CSE-MsgGUID: NtAn1ff/QuO0Nrh2x9PHNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63195144"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="63195144"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 06:05:57 -0700
X-CSE-ConnectionGUID: uJDRLRxTRIiBRYIt22KQNg==
X-CSE-MsgGUID: ENBedoJ/ToyxydofWZvOtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="150964727"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jun 2025 06:05:55 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSExl-000KlW-08;
	Thu, 19 Jun 2025 13:05:53 +0000
Date: Thu, 19 Jun 2025 21:05:03 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Coddington <bcodding@redhat.com>, trondmy@kernel.org,
	anna@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN
Message-ID: <202506192044.sMgMZpkZ-lkp@intel.com>
References: <43be0de9ff48ea68dec20d07cb235e164e634588.1750271744.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43be0de9ff48ea68dec20d07cb235e164e634588.1750271744.git.bcodding@redhat.com>

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.16-rc2 next-20250618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/NFSv4-pNFS-Fix-a-race-to-wake-on-NFS_LAYOUT_DRAIN/20250619-023749
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/43be0de9ff48ea68dec20d07cb235e164e634588.1750271744.git.bcodding%40redhat.com
patch subject: [PATCH] NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250619/202506192044.sMgMZpkZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250619/202506192044.sMgMZpkZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506192044.sMgMZpkZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nfs/pnfs.c: In function 'nfs_layoutget_end':
>> fs/nfs/pnfs.c:2061:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    2061 |         if (atomic_dec_and_test(&lo->plh_outstanding) &&
         |         ^~
   fs/nfs/pnfs.c:2064:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    2064 |                 wake_up_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN);
         |                 ^~~~~~~~~~~


vim +/if +2061 fs/nfs/pnfs.c

411ae722d10a6d Trond Myklebust     2018-06-23  2058  
411ae722d10a6d Trond Myklebust     2018-06-23  2059  static void nfs_layoutget_end(struct pnfs_layout_hdr *lo)
411ae722d10a6d Trond Myklebust     2018-06-23  2060  {
880265c77ac415 Trond Myklebust     2022-05-31 @2061  	if (atomic_dec_and_test(&lo->plh_outstanding) &&
880265c77ac415 Trond Myklebust     2022-05-31  2062  	    test_and_clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags))
b844d0ad43d3ba Benjamin Coddington 2025-06-18  2063  		smp_mb__after_atomic();
880265c77ac415 Trond Myklebust     2022-05-31  2064  		wake_up_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN);
411ae722d10a6d Trond Myklebust     2018-06-23  2065  }
411ae722d10a6d Trond Myklebust     2018-06-23  2066  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

