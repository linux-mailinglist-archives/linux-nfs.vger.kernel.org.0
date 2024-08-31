Return-Path: <linux-nfs+bounces-6068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD0966EDD
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 04:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425931F24B90
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 02:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A637A22089;
	Sat, 31 Aug 2024 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVXWcbVT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11B224D4;
	Sat, 31 Aug 2024 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725070070; cv=none; b=OjMYy7GKDjsL2xyc1MhnNTgAN3jz0dyijjhBjtzkFg8VSZ1a2IbwbMFCeeRSoXMA5ZVtmMVwqsI77ugKML/o5gJev3kutYp+O24whdsAcIYtm17dBwR4W1ysPDEDkIjvTb/AdCE/4PfgHa0vKBQUjnKxWLPBNgDH+50hDj3CA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725070070; c=relaxed/simple;
	bh=PdmR+d7nlj5paRJpUBYBwbzCmLk0r0IbTIMqcenMS/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBK1SaKgU01B7M38hYs1DIkBQgRvZ8GMFabRDSiHd85JCyG7lDm5pUmISU04ruOGhy0b16QBodrXo1QF9boDLm9w2a9rhTg4ujzUXN9zxFL4M5jxs9jTEGPn0wSfZHguvEPyfA/s4/s14/HwoYdBzq95PzS3yfZ7J7pgp27KvS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVXWcbVT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725070067; x=1756606067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PdmR+d7nlj5paRJpUBYBwbzCmLk0r0IbTIMqcenMS/U=;
  b=FVXWcbVTu2JxZvC/cidYaUUHx00+khEiVMaTE2Sy8DW4Nw8tEi5T3CoP
   vnB/695+4DzwXNFvwa8k8S4SYRZtg3GCCqzElZwU4kTuwLQyef1jInL/L
   VXkdwCZx/yHSuiQfsSxd1nEd3y9eBg3NpsS8hps/BAx7pGD/F7OKtz4Jw
   gaG5r9fEf309r+O44LYSTDbPed+Dr02oTXCmz/Ovq44JXIeKM91TeSXkq
   9nFO0gxe/355s6NtDf1snXjtbberdd7g22prHqXzP9OCJLd+/unt9z/09
   8CJfko1oXRX5+mOocxs5IYT3PxSR6NuQQvHozb0mGFJcBwqFKUx0kIKjS
   A==;
X-CSE-ConnectionGUID: /2ehZLJkSRS+uDI0khGLZg==
X-CSE-MsgGUID: MMjsTLtQQxGgaYcYHAz56A==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34885324"
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="34885324"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 19:07:47 -0700
X-CSE-ConnectionGUID: qQT/6q9jTgm8/M3TkWdR0A==
X-CSE-MsgGUID: P9ZmQQJdTPGVQvYFBSOw2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="68959259"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Aug 2024 19:07:44 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skDWg-0002Hm-0R;
	Sat, 31 Aug 2024 02:07:42 +0000
Date: Sat, 31 Aug 2024 10:07:04 +0800
From: kernel test robot <lkp@intel.com>
To: Li Lingfeng <lilingfeng3@huawei.com>, trondmy@kernel.org,
	anna@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jlayton@kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: Re: [PATCH v2] nfs: protect nfs41_impl_id by rcu
Message-ID: <202408310936.nUVC9Uw3-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240831/202408310936.nUVC9Uw3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310936.nUVC9Uw3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310936.nUVC9Uw3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from fs/nfs/nfs4client.c:6:
   fs/nfs/nfs4client.c: In function 'nfs4_free_impl_id_rcu':
>> include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct nfs41_impl_id'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   fs/nfs/nfs4client.c:286:41: note: in expansion of macro 'container_of'
     286 |         struct nfs41_impl_id *impl_id = container_of(head, struct nfs41_impl_id, __rcu_head);
         |                                         ^~~~~~~~~~~~
   include/linux/compiler_types.h:451:27: error: expression in static assertion is not an integer
     451 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   fs/nfs/nfs4client.c:286:41: note: in expansion of macro 'container_of'
     286 |         struct nfs41_impl_id *impl_id = container_of(head, struct nfs41_impl_id, __rcu_head);
         |                                         ^~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:314,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from fs/nfs/nfs4client.c:6:
>> include/linux/stddef.h:16:33: error: invalid use of undefined type 'struct nfs41_impl_id'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:28: note: in expansion of macro 'offsetof'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   fs/nfs/nfs4client.c:286:41: note: in expansion of macro 'container_of'
     286 |         struct nfs41_impl_id *impl_id = container_of(head, struct nfs41_impl_id, __rcu_head);
         |                                         ^~~~~~~~~~~~
   fs/nfs/nfs4client.c: In function 'nfs4_shutdown_client':
>> fs/nfs/nfs4client.c:304:41: error: invalid use of undefined type 'struct nfs41_impl_id'
     304 |                 call_rcu(&clp->cl_implid->__rcu_head, nfs4_free_impl_id_rcu);
         |                                         ^~


vim +20 include/linux/container_of.h

d2a8ebbf8192b8 Andy Shevchenko  2021-11-08   9  
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  10  /**
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  11   * container_of - cast a member of a structure out to the containing structure
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  12   * @ptr:	the pointer to the member.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  13   * @type:	the type of the container struct this is embedded in.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  14   * @member:	the name of the member within the struct.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  15   *
7376e561fd2e01 Sakari Ailus     2022-10-24  16   * WARNING: any const qualifier of @ptr is lost.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  17   */
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  18  #define container_of(ptr, type, member) ({				\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  19  	void *__mptr = (void *)(ptr);					\
e1edc277e6f6df Rasmus Villemoes 2021-11-08 @20  	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
e1edc277e6f6df Rasmus Villemoes 2021-11-08  21  		      __same_type(*(ptr), void),			\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  22  		      "pointer type mismatch in container_of()");	\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  23  	((type *)(__mptr - offsetof(type, member))); })
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  24  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

