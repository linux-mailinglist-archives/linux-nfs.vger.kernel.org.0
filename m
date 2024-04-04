Return-Path: <linux-nfs+bounces-2645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4E389909C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 23:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87551F237C1
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E1B13BC04;
	Thu,  4 Apr 2024 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpqDLYde"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1413BC3B
	for <linux-nfs@vger.kernel.org>; Thu,  4 Apr 2024 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267357; cv=none; b=gEcjgpYwmaIZbiEPxeBv3gb/ZvHWTN9W25mIYTAERmh1Ydz34G5uTt5b0/2xlsqssm/iqrkjw/NQXnln9R9LOlmPy4sEnSf2zY3+LK1sSE+Xbwse2lps29NdWy+WKuDAphlSN44PTvQsl9C6t02suIk3T4qZOuK9rMFt9Reta/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267357; c=relaxed/simple;
	bh=GRpTUpsyGxW4b9O1KoWGVOmQnT1hSNfuqHfunyl0YJY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ro3nVOTveXf/CBFM4CAZUACBp4wmMHcdQu5mKf+NFcRDO37sZUFDz14lswUPLtXJEqJvoHmjmRzgfSJFqW5JCDg+Th5pWOssiRIGQHr7A5xv1QLQiptsNDrrJJDkdhCuDrgk0Xpfz8TmVwGZeLPhM9JxXilYXRWGMEhJA+PgKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpqDLYde; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712267354; x=1743803354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GRpTUpsyGxW4b9O1KoWGVOmQnT1hSNfuqHfunyl0YJY=;
  b=YpqDLYdexFybIDA9UE7QxoUmSYAvtGffm+SobesMb63Us4h8DmE8R1x3
   mijNcyOwE9aoqfk1wKIopFEXfqlL+eQKA/jRTCio8oyDC3Y492w3tJ8E2
   F10G5nxVplOT5FmgJgB9ChPDfXf2WVlFciWCoeqJARBgoyKSOPOzEMdcy
   tx8tIgKPUZZjLUSHQiWLQGS59qMS0S9Q6IoMtDbsk2oVLohKx05iMomuB
   5UV6YswY43YFKBf4WAXdj88Iob7B+XYT2Q6njI2+RYzP4Cyk28mvaS8vJ
   PhRjgjRQGowg1wdq+gVcN28S9vN9b5vhsJqsCGeS7nF+gK0QNIL5rBluN
   Q==;
X-CSE-ConnectionGUID: acFn7qDIT3uXzfXofROzcw==
X-CSE-MsgGUID: CKwf1I3uQIK/EmsCDd4SMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7446132"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7446132"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 14:49:13 -0700
X-CSE-ConnectionGUID: b0+HsFKFRYGjnKNXGej5ug==
X-CSE-MsgGUID: Ezj6bbA4R1u6tjuYqB+F+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18979743"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Apr 2024 14:49:12 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsUxK-0001YA-0c;
	Thu, 04 Apr 2024 21:49:10 +0000
Date: Fri, 5 Apr 2024 05:48:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [trondmy-nfs:testing 31/31] fs/nfs/inode.c:2434:13: warning:
 assignment to 'int' from 'struct proc_dir_entry *' makes integer from
 pointer without a cast
Message-ID: <202404050536.TP9zhcZf-lkp@intel.com>
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
config: arc-defconfig (https://download.01.org/0day-ci/archive/20240405/202404050536.TP9zhcZf-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404050536.TP9zhcZf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050536.TP9zhcZf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nfs/inode.c: In function 'nfs_net_init':
>> fs/nfs/inode.c:2434:13: warning: assignment to 'int' from 'struct proc_dir_entry *' makes integer from pointer without a cast [-Wint-conversion]
    2434 |         err = rpc_proc_register(net, &nn->rpcstats);
         |             ^


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

