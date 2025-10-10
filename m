Return-Path: <linux-nfs+bounces-15135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37470BCE046
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 18:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B715801B0
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937B2FC866;
	Fri, 10 Oct 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzLbzEtd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FD2FC86A;
	Fri, 10 Oct 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115426; cv=none; b=H/aH4DVpceH1rE2qgXoWH5JGDoDh0eZcaI+wpnWbfz1IqIbX3nZ2uUa+vIxGJmbrOdU5XDB7mdof5M0GL2LG1QWT1lVcZLsE3gl2a5ezPn3UL+Q4vkrLduXxJApJemNFhDlKbhlnSYMuVoaYrOoBChuahaKBeNkXkFeXpVel9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115426; c=relaxed/simple;
	bh=l0fiWZYVG+wfmCw7kScmyAYvT0108Un2WDvxgohMa4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI0HbGxULjVWUxoTD9vfQLjbFyPUaO6IivlVVjmre79guPQrCg5T3AMyl7FaHiPdutk9ojgqgcpiR90tf3d0pihs71/ou5xeuJiVvi5LjC1Ph12iDQzi0Pd5XH61dxNeYyrAOK8xFu+V8YCEk4fAqCBxKa1PN9km0lprO6o6ge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzLbzEtd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760115425; x=1791651425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0fiWZYVG+wfmCw7kScmyAYvT0108Un2WDvxgohMa4o=;
  b=KzLbzEtdnXtvQHua7toE4ItCLZvVxmod+M4CsF4uW4yr5pdZvj4UffTU
   pw6QxesLsk9iNUMOiR0DmXAGKck6C3NHw1nxCVypQdUD+D0SPkTNaXb8Q
   q7FF3pSB39MjU0dRm0v+gh8m8iYqwHM3IzmpIh5SInhNiDAIyWIhqKVmf
   s1x6D/o0gfodqE2FldO4PtyuwoWsndCevpIX13NeDsKR/AxhbKkkYh9AT
   LUCjb4fYudCKA5fR08Ve6hDzQlCZ4tHtHtaABZnnuWFuj2WzpIguLTCmP
   ZpyppO92Eoll2mljTGDmdEvLqdDl9bNrdAMTGHIAMbmPFCjHigo/UlZ2R
   A==;
X-CSE-ConnectionGUID: lHFD67YXRMWthHOB1hwNbg==
X-CSE-MsgGUID: 0dFUmp6YTjOqUKxWl4U23g==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62367667"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="62367667"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 09:57:04 -0700
X-CSE-ConnectionGUID: jgY5epT1SJWEgpZleUaRIA==
X-CSE-MsgGUID: aoCx4benQO2MyTbhCbqfeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180703370"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Oct 2025 09:57:01 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7GQN-0002yl-2V;
	Fri, 10 Oct 2025 16:56:59 +0000
Date: Sat, 11 Oct 2025 00:56:12 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Watt <jpewhacker@gmail.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Joshua Watt <jpewhacker@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH] NFS: Fix state renewals missing after boot
Message-ID: <202510110046.sj3dc5HD-lkp@intel.com>
References: <20251008230935.738405-1-JPEWhacker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008230935.738405-1-JPEWhacker@gmail.com>

Hi Joshua,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Watt/NFS-Fix-state-renewals-missing-after-boot/20251010-103708
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20251008230935.738405-1-JPEWhacker%40gmail.com
patch subject: [PATCH] NFS: Fix state renewals missing after boot
config: mips-ip32_defconfig (https://download.01.org/0day-ci/archive/20251011/202510110046.sj3dc5HD-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110046.sj3dc5HD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110046.sj3dc5HD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfs/client.c:184:7: error: no member named 'cl_last_renewal' in 'struct nfs_client'
     184 |         clp->cl_last_renewal = jiffies;
         |         ~~~  ^
   1 error generated.


vim +184 fs/nfs/client.c

   141	
   142	/*
   143	 * Allocate a shared client record
   144	 *
   145	 * Since these are allocated/deallocated very rarely, we don't
   146	 * bother putting them in a slab cache...
   147	 */
   148	struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
   149	{
   150		struct nfs_client *clp;
   151		int err = -ENOMEM;
   152	
   153		if ((clp = kzalloc(sizeof(*clp), GFP_KERNEL)) == NULL)
   154			goto error_0;
   155	
   156		clp->cl_minorversion = cl_init->minorversion;
   157		clp->cl_nfs_mod = cl_init->nfs_mod;
   158		if (!get_nfs_version(clp->cl_nfs_mod))
   159			goto error_dealloc;
   160	
   161		clp->rpc_ops = clp->cl_nfs_mod->rpc_ops;
   162	
   163		refcount_set(&clp->cl_count, 1);
   164		clp->cl_cons_state = NFS_CS_INITING;
   165	
   166		memcpy(&clp->cl_addr, cl_init->addr, cl_init->addrlen);
   167		clp->cl_addrlen = cl_init->addrlen;
   168	
   169		if (cl_init->hostname) {
   170			err = -ENOMEM;
   171			clp->cl_hostname = kstrdup(cl_init->hostname, GFP_KERNEL);
   172			if (!clp->cl_hostname)
   173				goto error_cleanup;
   174		}
   175	
   176		INIT_LIST_HEAD(&clp->cl_superblocks);
   177		clp->cl_rpcclient = ERR_PTR(-EINVAL);
   178	
   179		clp->cl_flags = cl_init->init_flags;
   180		clp->cl_proto = cl_init->proto;
   181		clp->cl_nconnect = cl_init->nconnect;
   182		clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
   183		clp->cl_net = get_net_track(cl_init->net, &clp->cl_ns_tracker, GFP_KERNEL);
 > 184		clp->cl_last_renewal = jiffies;
   185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

