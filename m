Return-Path: <linux-nfs+bounces-11599-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9429AAF6F3
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 11:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBEDA1C06CA2
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E426560B;
	Thu,  8 May 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M14sG9Fd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78405264624;
	Thu,  8 May 2025 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697366; cv=none; b=b2FJ15FbVL32fdSLvFHh0pJ9J+QVMQhBNRzydJFjyS4CYRiS7lTRMdRef1z7ZT7oJp4tR/dRwhYDzJFSdGDIyi+tYWY1ml83u11hQKxqHUplrN48hIPKr1/xCP5M6r9UnIm+a+kHlb9SmEt+RVzWUr59rgSvaiYDSSwklAIxmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697366; c=relaxed/simple;
	bh=H7pF8pup0KLFwqbZMxrCJyXkzmhQcxeYeiaFzud/wsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p56596FaUOl68FttI2l6Sif8aL+gqvswGOQR23ZnD8+5zo+Sj+aoIhJ1ubFfD+nGYZYANFQhLfO5as40BCGBkNQ2Lem1VRR0uvOdXcLMXXNJ82zO6BsVoxXWcwrvuE6x7W9mThSw8SfpPy62my5MbcqqmoP3Jma9hYYOaRonCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M14sG9Fd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746697364; x=1778233364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H7pF8pup0KLFwqbZMxrCJyXkzmhQcxeYeiaFzud/wsY=;
  b=M14sG9FdsxZ6vCPgiv3uetPkTDHnuherVHWP++w3sbHiyT7usItuzu6L
   0V7wZHPJabqrHUHojbTBv3uVFcOxKQu+WCGhXbEEl7Yk0/a3QvQGxEfNR
   cCi5VYjvPDUAok0S7+fWLFO6vE864tUrRr40+q4tcKTxTEOdRUss6BylM
   T/rc7QuyAdGgydsy42k/nFfeDFKpoXme8YX1sDIe84mXbMtstT7JAAHv9
   8teLFwkNsGjFC7SKd8peVnKms4CPX3d2BPJOJwibwnLnBNlIGolWilNjA
   BMRQJMRJUvtYIBivxVw9QfR1r183a8dU0BU+oxIorM6Wc/i2VI+/GLAut
   A==;
X-CSE-ConnectionGUID: S1UlzuTvQnW8OgHLnHU5AQ==
X-CSE-MsgGUID: VC/Se/joSLu1O5Iz56Wrvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59100307"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="59100307"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 02:42:44 -0700
X-CSE-ConnectionGUID: qXwDo7gpTReLzfRYELq/+A==
X-CSE-MsgGUID: vZ2h6x+xS4KgOX5/yH/MVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="140278515"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 May 2025 02:42:41 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCxm3-000Apr-0g;
	Thu, 08 May 2025 09:42:39 +0000
Date: Thu, 8 May 2025 17:42:18 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
Message-ID: <202505081720.vtCPwAc0-lkp@intel.com>
References: <20250507080944.3947782-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507080944.3947782-3-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.15-rc5 next-20250507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/nfs-create-a-kernel-keyring/20250507-171041
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250507080944.3947782-3-hch%40lst.de
patch subject: [PATCH 2/2] nfs: create a kernel keyring
config: hexagon-defconfig (https://download.01.org/0day-ci/archive/20250508/202505081720.vtCPwAc0-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081720.vtCPwAc0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505081720.vtCPwAc0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfs/inode.c:2584:17: error: call to undeclared function 'keyring_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2584 |                 nfs_keyring = keyring_alloc(".nfs",
         |                               ^
>> fs/nfs/inode.c:2587:11: error: use of undeclared identifier 'KEY_POS_ALL'
    2587 |                                      (KEY_POS_ALL & ~KEY_POS_SETATTR) |
         |                                       ^
>> fs/nfs/inode.c:2587:26: error: use of undeclared identifier 'KEY_POS_SETATTR'
    2587 |                                      (KEY_POS_ALL & ~KEY_POS_SETATTR) |
         |                                                      ^
>> fs/nfs/inode.c:2588:11: error: use of undeclared identifier 'KEY_USR_ALL'
    2588 |                                      (KEY_USR_ALL & ~KEY_USR_SETATTR),
         |                                       ^
>> fs/nfs/inode.c:2588:26: error: use of undeclared identifier 'KEY_USR_SETATTR'
    2588 |                                      (KEY_USR_ALL & ~KEY_USR_SETATTR),
         |                                                      ^
>> fs/nfs/inode.c:2589:10: error: use of undeclared identifier 'KEY_ALLOC_NOT_IN_QUOTA'
    2589 |                                      KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
         |                                      ^
   6 errors generated.


vim +/keyring_alloc +2584 fs/nfs/inode.c

  2575	
  2576	/*
  2577	 * Initialize NFS
  2578	 */
  2579	static int __init init_nfs_fs(void)
  2580	{
  2581		int err;
  2582	
  2583		if (IS_ENABLED(CONFIG_NFS_V4)) {
> 2584			nfs_keyring = keyring_alloc(".nfs",
  2585					     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
  2586					     current_cred(),
> 2587					     (KEY_POS_ALL & ~KEY_POS_SETATTR) |
> 2588					     (KEY_USR_ALL & ~KEY_USR_SETATTR),
> 2589					     KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
  2590			if (IS_ERR(nfs_keyring))
  2591				return PTR_ERR(nfs_keyring);
  2592		}
  2593	
  2594		err = nfs_sysfs_init();
  2595		if (err < 0)
  2596			goto out10;
  2597	
  2598		err = register_pernet_subsys(&nfs_net_ops);
  2599		if (err < 0)
  2600			goto out9;
  2601	
  2602		err = nfsiod_start();
  2603		if (err)
  2604			goto out7;
  2605	
  2606		err = nfs_fs_proc_init();
  2607		if (err)
  2608			goto out6;
  2609	
  2610		err = nfs_init_nfspagecache();
  2611		if (err)
  2612			goto out5;
  2613	
  2614		err = nfs_init_inodecache();
  2615		if (err)
  2616			goto out4;
  2617	
  2618		err = nfs_init_readpagecache();
  2619		if (err)
  2620			goto out3;
  2621	
  2622		err = nfs_init_writepagecache();
  2623		if (err)
  2624			goto out2;
  2625	
  2626		err = nfs_init_directcache();
  2627		if (err)
  2628			goto out1;
  2629	
  2630		err = register_nfs_fs();
  2631		if (err)
  2632			goto out0;
  2633	
  2634		return 0;
  2635	out0:
  2636		nfs_destroy_directcache();
  2637	out1:
  2638		nfs_destroy_writepagecache();
  2639	out2:
  2640		nfs_destroy_readpagecache();
  2641	out3:
  2642		nfs_destroy_inodecache();
  2643	out4:
  2644		nfs_destroy_nfspagecache();
  2645	out5:
  2646		nfs_fs_proc_exit();
  2647	out6:
  2648		nfsiod_stop();
  2649	out7:
  2650		unregister_pernet_subsys(&nfs_net_ops);
  2651	out9:
  2652		nfs_sysfs_exit();
  2653	out10:
  2654		return err;
  2655	}
  2656	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

