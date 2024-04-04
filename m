Return-Path: <linux-nfs+bounces-2647-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CBB899107
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 00:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A676284F08
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 22:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5B682D90;
	Thu,  4 Apr 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0U1g5TT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABF12D1EF
	for <linux-nfs@vger.kernel.org>; Thu,  4 Apr 2024 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268617; cv=none; b=SICkuJqBJGRqKSKT9evPcBKFcyMj4IG98BhrFbeRy5/aycvFR42RczmdwJ8U1pAyOuXlFJyWo8cCpUDCUEjsRKRpvifq/atnmFjBkl5ZogGRiXPwceUTvGhgkL9r+bK/AUAplK2/HJIaCaqwYqxOOfPlJNmr4EuOG8dxhPPgUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268617; c=relaxed/simple;
	bh=x9YImRUgczdtN1gsBIQYqYrgwTtPDST/DQC6rlVvDGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sPM63eulqJ4chBDGAazbxRxB2HsKwY1rzPEWRpMSbZFoBmCmrHFyMId65fPtYZkYeju7NZDZayGBYWPPrhlfe15egHXc97cQnD6VoMZ8s6idRVDc+iLoPBWO+enaJ+IUwxwxR6vwy2SZvGzcQwAIi5PMX4ts1VgkPfrbvLgceG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0U1g5TT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712268615; x=1743804615;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x9YImRUgczdtN1gsBIQYqYrgwTtPDST/DQC6rlVvDGQ=;
  b=e0U1g5TT4mDj1vLkovgNIbfSr2FaaS4UNc53Op/5v2JA/t1SYVg8vuID
   lRsan5hk94/R/4X6SP8I2L3/3utAZDuVMh04xT16h+CsXdXg6blbv07N9
   3qaPhFg+sE6h0grt7jbtxVbKq2U7+5iW4jTOTTYZaPdgaOxtVN9BFdDUA
   00DvjB63prhM+8BkgYz4yru+buFQqIUO2BidjNbDIdX5V8/w5Hxcfgb95
   jd9/1pr6y1BfkTrStNGmM6Zx5vljktnYSYWHweI+6P8HsHUWEVY9opgiO
   96xAy7tnpSPWOoRkHbFTrOpIPTmKT1sVVrE0KHQUxGJqXLS4pRr2WZMgV
   g==;
X-CSE-ConnectionGUID: FOVs9euMQBaprvpAlgbDlw==
X-CSE-MsgGUID: 3B5z+HiHSIO9bN+2VQ6JOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7713987"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7713987"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 15:10:14 -0700
X-CSE-ConnectionGUID: 7hZJWJJSQ4aA4bJTIGc0+g==
X-CSE-MsgGUID: 8mp0uYzwSmSJ4iWpIDTDGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18829573"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Apr 2024 15:10:14 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsVHe-0001ZF-2T;
	Thu, 04 Apr 2024 22:10:10 +0000
Date: Fri, 5 Apr 2024 06:09:59 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [trondmy-nfs:testing 31/31] fs/nfs/inode.c:2434:6: warning:
 incompatible pointer to integer conversion assigning to 'int' from 'struct
 proc_dir_entry *'
Message-ID: <202404050613.KnVPG1fF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git testing
head:   f290a586e31f8965387dde660729c716a3af9b6c
commit: f290a586e31f8965387dde660729c716a3af9b6c [31/31] nfs: Handle error of rpc_proc_register() in nfs_net_init().
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240405/202404050613.KnVPG1fF-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404050613.KnVPG1fF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050613.KnVPG1fF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfs/inode.c:2434:6: warning: incompatible pointer to integer conversion assigning to 'int' from 'struct proc_dir_entry *' [-Wint-conversion]
           err = rpc_proc_register(net, &nn->rpcstats);
               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +2434 fs/nfs/inode.c

  2426	
  2427	static int nfs_net_init(struct net *net)
  2428	{
  2429		struct nfs_net *nn = net_generic(net, nfs_net_id);
  2430		int err;
  2431	
  2432		nfs_clients_init(net);
  2433	
> 2434		err = rpc_proc_register(net, &nn->rpcstats);
  2435		if (err) {
  2436			nfs_clients_exit(net);
  2437			return err;
  2438		}
  2439	
  2440		return nfs_fs_proc_net_init(net);
  2441	}
  2442	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

