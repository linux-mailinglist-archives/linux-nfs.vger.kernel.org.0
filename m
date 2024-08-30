Return-Path: <linux-nfs+bounces-6057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6196655D
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 17:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA611C212AC
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D411B5EAA;
	Fri, 30 Aug 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7lyQ7cI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A691B4C29;
	Fri, 30 Aug 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031583; cv=none; b=HuldVX9mkcLkZHVaBd2fklkU3HJv/aEoo7PbBhMUTgGNgucCgx5ufDmj57Lw1Qp3+bvv97iWOLh1O6QFvXurtBkA4nJvAa+ihhR9dGW4YPhUJuxnwkgT20MjjjiNz8rb5D1rGPKGbsa9hk1JCmpnk/yu68+lvBYsLwiwxWRsWOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031583; c=relaxed/simple;
	bh=C0WOOozSTgEFuiMBLxHw7M8hNxWE4gcUb9pNKJ7jF8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX8qo9Z+B0k8Svjd0n+6uGb/0h9Hn94LVlzbENooWtMRJTZ5eNRBQsx3zpIwy7meeILNFhw2waMbe5PkRwGcmWqJqyV621JN43JsSISq7KHzm3tTpcOhXhBC3gLTnvqB7/iRMW3iC1lf7sNZZfU/ejSHAYG6fh+E6Rm+bxerwZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7lyQ7cI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725031579; x=1756567579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0WOOozSTgEFuiMBLxHw7M8hNxWE4gcUb9pNKJ7jF8Y=;
  b=g7lyQ7cIBJhF+aWjl2XfY2XiTJRgDZ8sbmYOIt4nN00mnVcyAEw3epWi
   2cCsArMb1NIlZrfQQ9cbZLw7AaCSaQ5uFMGWbgTW81YCzObRP78N2M/UG
   uol6G+1yYJ0uigAxvNPp+LfeXTd/3/nOPfyd/DONb/j8WxzX/1bHy+Ax/
   e8HMS0oZoI/8EBQPeJemsXxiZSLsLi8zi+ktUJFgeTsb8UlGeX8kT8s4U
   gGe1pmRoWcWpobd3BKqLSEyACBQNW0w4roRzj7fIhdDaPFMUcC7mV8tew
   5yOmpnmXRfXwMiLuATRV1LtF55QCRk0fuGNUmCeDC6SbhUN4Sb/1twDdi
   A==;
X-CSE-ConnectionGUID: IZRsCd2FQ96TY55sMgHEvg==
X-CSE-MsgGUID: W37iVLelTnC9qd9AeMTAFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13299626"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13299626"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 08:26:18 -0700
X-CSE-ConnectionGUID: tl3tTf0ESYi2Xww4hMSRhg==
X-CSE-MsgGUID: o8vLVVWmRMaRu2s4tMj8AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63941616"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Aug 2024 08:26:15 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk3Vt-0001a4-1C;
	Fri, 30 Aug 2024 15:26:13 +0000
Date: Fri, 30 Aug 2024 23:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: Li Lingfeng <lilingfeng3@huawei.com>, trondmy@kernel.org,
	anna@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jlayton@kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: Re: [PATCH v2] nfs: protect nfs41_impl_id by rcu
Message-ID: <202408302315.02P7HuVM-lkp@intel.com>
References: <20240829133743.1008788-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829133743.1008788-1-lilingfeng3@huawei.com>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Lingfeng/nfs-protect-nfs41_impl_id-by-rcu/20240829-213622
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20240829133743.1008788-1-lilingfeng3%40huawei.com
patch subject: [PATCH v2] nfs: protect nfs41_impl_id by rcu
config: i386-randconfig-001-20240830 (https://download.01.org/0day-ci/archive/20240830/202408302315.02P7HuVM-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408302315.02P7HuVM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408302315.02P7HuVM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfs/nfs4client.c:286:34: error: incomplete definition of type 'struct nfs41_impl_id'
     286 |         struct nfs41_impl_id *impl_id = container_of(head, struct nfs41_impl_id, __rcu_head);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:20:47: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:451:74: note: expanded from macro '__same_type'
     451 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/nfs_fs_sb.h:23:8: note: forward declaration of 'struct nfs41_impl_id'
      23 | struct nfs41_impl_id;
         |        ^
>> fs/nfs/nfs4client.c:286:34: error: offsetof of incomplete type 'struct nfs41_impl_id'
     286 |         struct nfs41_impl_id *impl_id = container_of(head, struct nfs41_impl_id, __rcu_head);
         |                                         ^                  ~~~~~~
   include/linux/container_of.h:23:21: note: expanded from macro 'container_of'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^        ~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^                  ~~~~
   include/linux/nfs_fs_sb.h:23:8: note: forward declaration of 'struct nfs41_impl_id'
      23 | struct nfs41_impl_id;
         |        ^
>> fs/nfs/nfs4client.c:286:24: error: initializing 'struct nfs41_impl_id *' with an expression of incompatible type 'void'
     286 |         struct nfs41_impl_id *impl_id = container_of(head, struct nfs41_impl_id, __rcu_head);
         |                               ^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/nfs4client.c:304:27: error: incomplete definition of type 'struct nfs41_impl_id'
     304 |                 call_rcu(&clp->cl_implid->__rcu_head, nfs4_free_impl_id_rcu);
         |                           ~~~~~~~~~~~~~~^
   include/linux/nfs_fs_sb.h:23:8: note: forward declaration of 'struct nfs41_impl_id'
      23 | struct nfs41_impl_id;
         |        ^
   4 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FB_IOMEM_HELPERS
   Depends on [n]: HAS_IOMEM [=y] && FB_CORE [=n]
   Selected by [m]:
   - DRM_XE_DISPLAY [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_XE [=m] && DRM_XE [=m]=m [=m]


vim +286 fs/nfs/nfs4client.c

   283	
   284	static void nfs4_free_impl_id_rcu(struct rcu_head *head)
   285	{
 > 286		struct nfs41_impl_id *impl_id = container_of(head, struct nfs41_impl_id, __rcu_head);
   287	
   288		kfree(impl_id);
   289	}
   290	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

