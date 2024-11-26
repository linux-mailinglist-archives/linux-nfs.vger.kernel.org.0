Return-Path: <linux-nfs+bounces-8225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542159D9C41
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 18:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED57AB284B3
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B01DB37A;
	Tue, 26 Nov 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8Xa5aTh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254451DA612
	for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641294; cv=none; b=Ni9C1CLAU/qTSPmywjBqyRVECsK1fPvcR6RdkCbddqfi2EkQADb7fjd9krasQafvc3QcvpDfapYHEGTIPSnnL6chvSNz4XerK8u9Bn8LK7mgdGM9KrIBK10/rAjPeBrFbFd2MJHpBNWkVrmGSpH/z6/ELJsdz4jsOe4JAIU4moU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641294; c=relaxed/simple;
	bh=wqhKDuEd3dg6DtnA3TTsuXqmBNJnqyjJ81rzJ58s+CU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QnugoRDN+QjyPnMxVQ5bKUvj1HmQVHJALVxRLNeZkdqbMGE+H3QPCzNUp0fana2Dkd3yKoMhkHNZ55N0X6VbKIrN9Nmuy0TAY2fa8vrs0ak5GNb7P9/cKqetOj/VMa4eJTNWMo76iD6McHNyLpdJulsh//hnFoHWtKHpenTZB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8Xa5aTh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732641293; x=1764177293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wqhKDuEd3dg6DtnA3TTsuXqmBNJnqyjJ81rzJ58s+CU=;
  b=i8Xa5aThKa6ro9HP474gaSZodlXyl1SOm0z00TGJhspkc8YHYeeRv43h
   95EwJgHBdhwPHIINmyyWQWxl5echV9Ld6v6BN+v3CQLui6fmcD4DxZB7M
   gAZBS9RbWd7S+IkFWdOtrVhXzjBGVmEl/uIuhOTy3i1kk+lEvtw8Z6O2B
   8X3EE2yU+I9ngnDc6ZBRmDUrx/yLsj4jwfl4iHLROZnyZHrlHvgKCcXpb
   GtYgS+/WFUkvPnB+L5PNvIt6l3j9oUNhmu/zHPw4+xenez7dGvsmV3hFW
   0rw08wcL39rP0rFBJBvdhawFvG8PDoZ0o3KriiSzGfDwtIQfcbsbF8HQM
   w==;
X-CSE-ConnectionGUID: zZwaY1R3RGeoD8A4Y4ZGnw==
X-CSE-MsgGUID: Ih2fVrZ1S7q41geoTK0X6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32672232"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32672232"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 09:14:52 -0800
X-CSE-ConnectionGUID: FRJboDS+RZycq3xod1ULDw==
X-CSE-MsgGUID: 1Lu4+XCeSLGBfo5+etDcJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91566366"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Nov 2024 09:14:48 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFz99-0007RT-0O;
	Tue, 26 Nov 2024 17:14:43 +0000
Date: Wed, 27 Nov 2024 01:14:09 +0800
From: kernel test robot <lkp@intel.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [trondmy-nfs:testing 27/29] net/sunrpc/debugfs.c:78:21: sparse:
 sparse: cast removes address space '__rcu' of expression
Message-ID: <202411270142.dpt7kOPF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git testing
head:   0c72d16cb63da4589029e2e60b0be86ab4def2c4
commit: 47f2d22f3ba33173238cf7e009b931602983157c [27/29] SUNRPC: display total RPC tasks for RPC client
config: i386-randconfig-r133-20241126 (https://download.01.org/0day-ci/archive/20241127/202411270142.dpt7kOPF-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241127/202411270142.dpt7kOPF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411270142.dpt7kOPF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/sunrpc/debugfs.c:78:21: sparse: sparse: cast removes address space '__rcu' of expression
--
>> net/sunrpc/clnt.c:3332:9: sparse: sparse: cast removes address space '__rcu' of expression

vim +/__rcu +78 net/sunrpc/debugfs.c

    70	
    71	static void
    72	tasks_stop(struct seq_file *f, void *v)
    73		__releases(&clnt->cl_lock)
    74	{
    75		struct rpc_clnt *clnt = f->private;
    76		spin_unlock(&clnt->cl_lock);
    77		seq_printf(f, "clnt[%pISpc] RPC tasks[%d]\n",
  > 78			   (struct sockaddr *)&clnt->cl_xprt->addr,
    79			   atomic_read(&clnt->cl_task_count));
    80	}
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

