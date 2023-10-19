Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D227CF892
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 14:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjJSMSR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Oct 2023 08:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjJSMSQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 08:18:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2A121
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697717893; x=1729253893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=egphvTp+G9uX9PWRwebQ2cv7azqdCltj2VjYqZBu8EM=;
  b=hqmLBcmIN+/Em6b8CCnyfKaAZrAI6W3e50zvljCiNsTLuO8PuOE0Z5HX
   +Ct3rDJHPxDe96OYZhZHO+Tzh8zXKhS+vKA11Cw8lwckFRLhJrIxn9DSE
   hPXgGOB7mb2Nk1yjrC75vp4+Wsg2xoH59pD/Pn6yB3FhLjclPseC3W8lj
   jvwElnBx2JyjFx+8YlmtK81kOgwWGKXV1MqvBT38rH8KSyHo5eJoPMqM2
   PnqMPxKvvLDN1hxqEKJT0SmP3OnLycLiSbvqhRzEmUsWbKYQuVowqSrk6
   t35zbSal72EcO5VUFwtqgJeOGycbtJYZRL/kPVx/HEMt1YWgkbYWzCvHn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417346995"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="417346995"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="822819350"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="822819350"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Oct 2023 05:18:10 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtRyZ-00025t-1M;
        Thu, 19 Oct 2023 12:18:07 +0000
Date:   Thu, 19 Oct 2023 20:18:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Message-ID: <202310192058.OzHqCGKn-lkp@intel.com>
References: <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.6-rc6 next-20231019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/NFSv4-Always-ask-for-type-with-READDIR/20231018-053217
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding%40redhat.com
patch subject: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
config: powerpc-mpc885_ads_defconfig (https://download.01.org/0day-ci/archive/20231019/202310192058.OzHqCGKn-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310192058.OzHqCGKn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310192058.OzHqCGKn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      47 | DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      48 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     669 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:98:1: note: expanded from here
      98 | __do_insl
         | ^
   arch/powerpc/include/asm/io.h:611:56: note: expanded from macro '__do_insl'
     611 | #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
         |                                        ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/nfs/client.c:19:
   In file included from include/linux/sunrpc/addr.h:14:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:94:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      49 | DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      50 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     669 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:100:1: note: expanded from here
     100 | __do_outsb
         | ^
   arch/powerpc/include/asm/io.h:612:58: note: expanded from macro '__do_outsb'
     612 | #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/nfs/client.c:19:
   In file included from include/linux/sunrpc/addr.h:14:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:94:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      51 | DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      52 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     669 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:102:1: note: expanded from here
     102 | __do_outsw
         | ^
   arch/powerpc/include/asm/io.h:613:58: note: expanded from macro '__do_outsw'
     613 | #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/nfs/client.c:19:
   In file included from include/linux/sunrpc/addr.h:14:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:94:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      53 | DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      54 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     669 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:104:1: note: expanded from here
     104 | __do_outsl
         | ^
   arch/powerpc/include/asm/io.h:614:58: note: expanded from macro '__do_outsl'
     614 | #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
>> fs/nfs/client.c:925:17: error: no member named 'readdir_attrs' in 'struct nfs_server'
     925 |         memcpy(target->readdir_attrs, source->readdir_attrs,
         |                ~~~~~~  ^
   fs/nfs/client.c:925:40: error: no member named 'readdir_attrs' in 'struct nfs_server'
     925 |         memcpy(target->readdir_attrs, source->readdir_attrs,
         |                                       ~~~~~~  ^
   fs/nfs/client.c:926:19: error: no member named 'readdir_attrs' in 'struct nfs_server'
     926 |                         sizeof(target->readdir_attrs));
         |                                ~~~~~~  ^
   6 warnings and 3 errors generated.
--
   In file included from fs/nfs/sysfs.c:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      47 | DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      48 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     669 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:182:1: note: expanded from here
     182 | __do_insl
         | ^
   arch/powerpc/include/asm/io.h:611:56: note: expanded from macro '__do_insl'
     611 | #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
         |                                        ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/nfs/sysfs.c:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      49 | DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      50 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     669 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:184:1: note: expanded from here
     184 | __do_outsb
         | ^
   arch/powerpc/include/asm/io.h:612:58: note: expanded from macro '__do_outsb'
     612 | #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/nfs/sysfs.c:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      51 | DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      52 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     669 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:186:1: note: expanded from here
     186 | __do_outsw
         | ^
   arch/powerpc/include/asm/io.h:613:58: note: expanded from macro '__do_outsw'
     613 | #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/nfs/sysfs.c:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      53 | DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      54 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     669 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:188:1: note: expanded from here
     188 | __do_outsl
         | ^
   arch/powerpc/include/asm/io.h:614:58: note: expanded from macro '__do_outsl'
     614 | #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
>> fs/nfs/sysfs.c:281:12: error: no member named 'readdir_attrs' in 'struct nfs_server'
     281 |                         server->readdir_attrs[0],
         |                         ~~~~~~  ^
   fs/nfs/sysfs.c:282:12: error: no member named 'readdir_attrs' in 'struct nfs_server'
     282 |                         server->readdir_attrs[1],
         |                         ~~~~~~  ^
   fs/nfs/sysfs.c:283:12: error: no member named 'readdir_attrs' in 'struct nfs_server'
     283 |                         server->readdir_attrs[2]);
         |                         ~~~~~~  ^
   fs/nfs/sysfs.c:338:11: error: no member named 'readdir_attrs' in 'struct nfs_server'
     338 |                 server->readdir_attrs[0] = attrs[0];
         |                 ~~~~~~  ^
   fs/nfs/sysfs.c:340:11: error: no member named 'readdir_attrs' in 'struct nfs_server'
     340 |                 server->readdir_attrs[1] = attrs[1];
         |                 ~~~~~~  ^
   fs/nfs/sysfs.c:342:11: error: no member named 'readdir_attrs' in 'struct nfs_server'
     342 |                 server->readdir_attrs[2] = attrs[2];
         |                 ~~~~~~  ^
   6 warnings and 6 errors generated.


vim +925 fs/nfs/client.c

   908	
   909	/*
   910	 * Copy useful information when duplicating a server record
   911	 */
   912	void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *source)
   913	{
   914		target->flags = source->flags;
   915		target->rsize = source->rsize;
   916		target->wsize = source->wsize;
   917		target->acregmin = source->acregmin;
   918		target->acregmax = source->acregmax;
   919		target->acdirmin = source->acdirmin;
   920		target->acdirmax = source->acdirmax;
   921		target->caps = source->caps;
   922		target->options = source->options;
   923		target->auth_info = source->auth_info;
   924		target->port = source->port;
 > 925		memcpy(target->readdir_attrs, source->readdir_attrs,
   926				sizeof(target->readdir_attrs));
   927	}
   928	EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
   929	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
