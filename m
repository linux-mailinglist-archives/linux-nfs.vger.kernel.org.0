Return-Path: <linux-nfs+bounces-5897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 946C6963549
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 01:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC311F258D5
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D651667E1;
	Wed, 28 Aug 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zjt8ALt/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964F156230;
	Wed, 28 Aug 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887059; cv=none; b=lTG8P4rfTJEQI8XUb2Xh+eGmddJ8QDA3h4GabgYx8W122NoSq+MDhBzdNTPIDYkFJ3P6GCRhdlTEdCNDvI5Epo1NGR3BW+vLsSRWughUihHrrOujvCx9tnbrCiluTy6ihBQzixcoQewbmSk7iOQB17oceD1K8j4UDuoLM7YbIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887059; c=relaxed/simple;
	bh=xTFXw5fW98i/uom18MtpYnU+ph1/QdPNkw+9Ey01zDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pInlACS1hq5BZzffvfRccaHO3Lz+NU6jEPdOgZuUGuwpWbBQdCEAibhOTZXzC5TuyUMtj31n/O0emtbjL2pb8iRo7mtF9BjGfY+OW+fxIrKCsZG9/7V0mpsk8NSwcJlyIh5CQCRqfHNVqru6PN366hU5cXY98NZ+468fcif2XVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zjt8ALt/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724887057; x=1756423057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xTFXw5fW98i/uom18MtpYnU+ph1/QdPNkw+9Ey01zDI=;
  b=Zjt8ALt/+6yVb7SOZYn9oa2+ILSV4RDKDd63WE2nSPsN8IeZIzVzE0Io
   nE+Gbu0GxgFmMq4GesR6822QvnilvWUe0wpGNMMARhSuuj062+Tx0cjD9
   kWlBHUBKIB4CJ8lCvyxsOkfA1CmEU+K8VuydFHZdjqtkHzg3BzWKg6iNx
   MSdVpDtLLIedwUsebQCXgdi3qaDz5SYPm8TAO1g3y3BwfpyjqVQZnWqb0
   Kh6YS5mDIbQeMay6E28DjMDP8tHrASJYcpQQIHJjDdTRdW5sl0DfeB0VJ
   D3gyPkp2dNfu/JY7QqjMXU8X4J0IhacD0OTicuU2HRneLxYebkWBE7AIW
   w==;
X-CSE-ConnectionGUID: FpfCNB3xQsWytnf0/ya8Lg==
X-CSE-MsgGUID: 6l2AKAFORGGlEXvU9nmxHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34022070"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="34022070"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:17:37 -0700
X-CSE-ConnectionGUID: Nfd4LzNgRCmLQ0OShireQw==
X-CSE-MsgGUID: 3u170mVFQTGlOlu+J54MEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63714103"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Aug 2024 16:17:33 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjRut-000LRK-09;
	Wed, 28 Aug 2024 23:17:31 +0000
Date: Thu, 29 Aug 2024 07:16:52 +0800
From: kernel test robot <lkp@intel.com>
To: Li Lingfeng <lilingfeng3@huawei.com>, trondmy@kernel.org,
	anna@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jlayton@kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: Re: [PATCH] nfs: protect nfs41_impl_id by rcu
Message-ID: <202408290616.QG17h6tl-lkp@intel.com>
References: <20240828044933.676898-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828044933.676898-1-lilingfeng3@huawei.com>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.11-rc5 next-20240828]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Lingfeng/nfs-protect-nfs41_impl_id-by-rcu/20240828-124056
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20240828044933.676898-1-lilingfeng3%40huawei.com
patch subject: [PATCH] nfs: protect nfs41_impl_id by rcu
config: x86_64-randconfig-121-20240829 (https://download.01.org/0day-ci/archive/20240829/202408290616.QG17h6tl-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408290616.QG17h6tl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408290616.QG17h6tl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/nfs/nfs4client.c:296:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct nfs41_impl_id [noderef] __rcu *cl_implid @@
   fs/nfs/nfs4client.c:296:18: sparse:     expected void const *objp
   fs/nfs/nfs4client.c:296:18: sparse:     got struct nfs41_impl_id [noderef] __rcu *cl_implid

vim +296 fs/nfs/nfs4client.c

ec409897e7c715 Bryan Schumaker 2012-07-16  283  
ec409897e7c715 Bryan Schumaker 2012-07-16  284  static void nfs4_shutdown_client(struct nfs_client *clp)
ec409897e7c715 Bryan Schumaker 2012-07-16  285  {
ec409897e7c715 Bryan Schumaker 2012-07-16  286  	if (__test_and_clear_bit(NFS_CS_RENEWD, &clp->cl_res_state))
ec409897e7c715 Bryan Schumaker 2012-07-16  287  		nfs4_kill_renewd(clp);
abf79bb341bf52 Chuck Lever     2013-08-09  288  	clp->cl_mvops->shutdown_client(clp);
ec409897e7c715 Bryan Schumaker 2012-07-16  289  	nfs4_destroy_callback(clp);
ec409897e7c715 Bryan Schumaker 2012-07-16  290  	if (__test_and_clear_bit(NFS_CS_IDMAP, &clp->cl_res_state))
ec409897e7c715 Bryan Schumaker 2012-07-16  291  		nfs_idmap_delete(clp);
ec409897e7c715 Bryan Schumaker 2012-07-16  292  
ec409897e7c715 Bryan Schumaker 2012-07-16  293  	rpc_destroy_wait_queue(&clp->cl_rpcwaitq);
ec409897e7c715 Bryan Schumaker 2012-07-16  294  	kfree(clp->cl_serverowner);
ec409897e7c715 Bryan Schumaker 2012-07-16  295  	kfree(clp->cl_serverscope);
ec409897e7c715 Bryan Schumaker 2012-07-16 @296  	kfree(clp->cl_implid);
ceb3a16c070c40 Trond Myklebust 2015-01-03  297  	kfree(clp->cl_owner_id);
ec409897e7c715 Bryan Schumaker 2012-07-16  298  }
ec409897e7c715 Bryan Schumaker 2012-07-16  299  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

