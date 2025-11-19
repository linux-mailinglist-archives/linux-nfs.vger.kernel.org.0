Return-Path: <linux-nfs+bounces-16533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F210C6E389
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 12:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69DE234BD1F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC8D352F8F;
	Wed, 19 Nov 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vtm+3DVh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D696351FDE
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551241; cv=none; b=npPKwWp6V5GVXKtikA9XfU1+haCWqHFJqeLmdbCTiXOB3XjusU+RB1rQaRgsLbgcoviqHh304ww8L7pig3cNft5rlZpI3n/KpQqAt69YmSpK/dURVqfzWvlOlCJKZyDcEQvK9o2NEa/nlSxOPcFS093U+hWHXQdrTP8aLBymHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551241; c=relaxed/simple;
	bh=n1ssxyGcRM+PfkXOFco2Il0uRHH1F+ktAABiJ82ROQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqDsZ/W2i7NhKWqUB0+BrWPGZ+ZNtaSN9LN3Ya+9o50ALoQkwaVuG9wRB/4YXVgu/PE7svum3PxlwmjU5slgv9NMbYfD1asuHJrL5WbuNHq3mHH7yTv8ZiRX+BsUIHHwMJ0y2t3tubZlQejvdp6B3rIg9kgGNGMFSwEKBYemOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vtm+3DVh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763551240; x=1795087240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n1ssxyGcRM+PfkXOFco2Il0uRHH1F+ktAABiJ82ROQI=;
  b=Vtm+3DVhMo+lX66Wk5VfwwUF+F/HnzP7112GQJwvfM/SV+GRk2YZU9TJ
   /qJhWySNCfVknl+Aqb5JE36ij22xIvC79G83x9diJtfMmbVhfIHtCOPV7
   5z3V4rL8/iCvDETFNkJMncJGeG8IiE76tfhE5/omYMWi7hVXay4TxdpxQ
   Kcf3cG1EEwz5RIazmV8BeBL+nCrVljC0cq6ukxIecEhye3/veUwCd46rN
   /0DVudA5MTwVYOsMF8Dv4lwC4VyuMiLlwFOqAg0Wp1g7nwUbQmL/Nn17I
   Uod/OWpSbUKft1K9MjOJ19x8FNne3IbU+9uuVJlYTotvoqpQAItTrVrFK
   g==;
X-CSE-ConnectionGUID: SKRlxHq1QqOlwd/UQHT8eg==
X-CSE-MsgGUID: 9xJ30wVwQEyoLHe67Y15Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65469757"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65469757"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 03:20:39 -0800
X-CSE-ConnectionGUID: fFSGaDUeQqKQOB64wwURRg==
X-CSE-MsgGUID: h4Qq38zORXG5ySVDF9x0CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="191283233"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Nov 2025 03:20:37 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLgEl-0002oB-1O;
	Wed, 19 Nov 2025 11:20:35 +0000
Date: Wed, 19 Nov 2025 19:20:00 +0800
From: kernel test robot <lkp@intel.com>
To: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>, trondmy@kernel.org,
	anna@kernel.org, tom@talpey.com, chuck.lever@oracle.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Subject: Re: [PATCH] nfs: Implement delayed data server destruction with hold
 cache
Message-ID: <202511191852.nGdrhdUC-lkp@intel.com>
References: <20251118105752.52098-1-gaurav.gangalwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118105752.52098-1-gaurav.gangalwar@gmail.com>

Hi Gaurav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.18-rc6 next-20251119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gaurav-Gangalwar/nfs-Implement-delayed-data-server-destruction-with-hold-cache/20251118-190020
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20251118105752.52098-1-gaurav.gangalwar%40gmail.com
patch subject: [PATCH] nfs: Implement delayed data server destruction with hold cache
config: arm-lpc32xx_defconfig (https://download.01.org/0day-ci/archive/20251119/202511191852.nGdrhdUC-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511191852.nGdrhdUC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511191852.nGdrhdUC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfs/pnfs_nfs.c:753:6: warning: variable 'active_count' set but not used [-Wunused-but-set-variable]
     753 |         int active_count = 0, hold_count = 0, expired_count = 0;
         |             ^
>> fs/nfs/pnfs_nfs.c:753:24: warning: variable 'hold_count' set but not used [-Wunused-but-set-variable]
     753 |         int active_count = 0, hold_count = 0, expired_count = 0;
         |                               ^
>> fs/nfs/pnfs_nfs.c:753:40: warning: variable 'expired_count' set but not used [-Wunused-but-set-variable]
     753 |         int active_count = 0, hold_count = 0, expired_count = 0;
         |                                               ^
   3 warnings generated.


vim +/active_count +753 fs/nfs/pnfs_nfs.c

   741	
   742	/*
   743	 * Periodic cleanup task to check hold cache and destroy expired DS entries
   744	 */
   745	void nfs4_pnfs_ds_cleanup_work(struct work_struct *work)
   746	{
   747		struct nfs_net *nn = container_of(work, struct nfs_net,
   748						  nfs4_data_server_cleanup_work.work);
   749		struct nfs4_pnfs_ds *ds, *tmp;
   750		LIST_HEAD(destroy_list);
   751		unsigned long grace_period = nfs4_pnfs_ds_grace_period * HZ;
   752		unsigned long now = jiffies;
 > 753		int active_count = 0, hold_count = 0, expired_count = 0;
   754	
   755		dprintk("NFS: DS cleanup work started for namespace (jiffies=%lu)\n", now);
   756	
   757		spin_lock(&nn->nfs4_data_server_lock);
   758	
   759		/* Count entries in active cache */
   760		list_for_each_entry(ds, &nn->nfs4_data_server_cache, ds_node)
   761			active_count++;
   762	
   763		/* Process hold cache */
   764		list_for_each_entry_safe(ds, tmp, &nn->nfs4_data_server_hold_cache, ds_node) {
   765			unsigned long time_since_last_access = now - ds->ds_last_access;
   766	
   767			hold_count++;
   768			if (time_since_last_access >= grace_period) {
   769				/* Grace period expired, move to destroy list */
   770				dprintk("NFS: DS cleanup task destroying expired DS: %s (idle for %lu seconds)\n",
   771					ds->ds_remotestr, time_since_last_access / HZ);
   772				list_move(&ds->ds_node, &destroy_list);
   773				expired_count++;
   774			} else {
   775				dprintk("NFS: DS %s in hold cache (idle for %lu seconds, %lu seconds remaining)\n",
   776					ds->ds_remotestr, time_since_last_access / HZ,
   777					(grace_period - time_since_last_access) / HZ);
   778			}
   779		}
   780	
   781		spin_unlock(&nn->nfs4_data_server_lock);
   782	
   783		dprintk("NFS: DS cleanup work: active_cache=%d, hold_cache=%d, expired=%d\n",
   784			active_count, hold_count, expired_count);
   785	
   786		/* Destroy DS entries outside of lock */
   787		list_for_each_entry_safe(ds, tmp, &destroy_list, ds_node) {
   788			list_del_init(&ds->ds_node);
   789			destroy_ds(ds);
   790		}
   791	
   792		/* Reschedule cleanup task */
   793		dprintk("NFS: DS cleanup work completed, rescheduling in %u seconds\n",
   794			nfs4_pnfs_ds_cleanup_interval);
   795		schedule_delayed_work(&nn->nfs4_data_server_cleanup_work,
   796				      nfs4_pnfs_ds_cleanup_interval * HZ);
   797	}
   798	EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_cleanup_work);
   799	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

