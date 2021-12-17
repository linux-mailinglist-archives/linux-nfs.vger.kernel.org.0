Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1B0478680
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 09:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhLQIwG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 03:52:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:6659 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhLQIwG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Dec 2021 03:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639731125; x=1671267125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x+I5rE7VNY12BhYU+2TspOP4sX4P36nu1hjhpz7qMZc=;
  b=Ooj/0FrQe9+mT/XJyQTKHKcBfx7UxZ+xDBWtrR8ek1szgI4gdaSU+jg/
   miLUB0WxJo4VBt+s53u7LhMYk/YI68kXLrnPOVxHvIIV3Xn4BVs7PmVH1
   qbFR8BEZZBJ/exthrrS7OPVVr/7Z9nBZz3fmSwL4WKlpSOyso6fYwoR9C
   tRDysKTEpD0hNwMIKuW1wJX28mrkQv6eCa2c0QNP25H1kc8NoVc/HJZs3
   W7+sWIXWOqmz+T3I1oALkNNTrmQmMnTRg/tz2i8g58dWr0Q/9v/TFHc87
   nFx5fFDH6sBAf023Xii6sSF6l8v5USRJ9litWj/hMJFRE/QnYitFPNKW+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="237253469"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="237253469"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 00:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="662788992"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 00:52:00 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my8y8-0004VB-1I; Fri, 17 Dec 2021 08:52:00 +0000
Date:   Fri, 17 Dec 2021 16:51:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] MM: reclaim mustn't enter FS for SWP_FS_OPS
 swap-space
Message-ID: <202112171635.JUIRMzHQ-lkp@intel.com>
References: <163969850295.20885.4255989535187500085.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850295.20885.4255989535187500085.stgit@noble.brown>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NeilBrown,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on cifs/for-next]
[also build test ERROR on axboe-block/for-next rostedt-trace/for-next linus/master v5.16-rc5]
[cannot apply to trondmy-nfs/linux-next hnaz-mm/master mszeredi-vfs/overlayfs-next next-20211216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/NeilBrown/Repair-SWAP-over-NFS/20211217-075659
base:   git://git.samba.org/sfrench/cifs-2.6.git for-next
config: arm-randconfig-r006-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171635.JUIRMzHQ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 9043c3d65b11b442226015acfbf8167684586cfa)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/a8e1b1ffec6ade1545df519d254eae0400b7ec37
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review NeilBrown/Repair-SWAP-over-NFS/20211217-075659
        git checkout a8e1b1ffec6ade1545df519d254eae0400b7ec37
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/vmscan.c:1480:20: error: implicit declaration of function 'page_swap_info' [-Werror,-Wimplicit-function-declaration]
           return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
                             ^
   mm/vmscan.c:1480:20: note: did you mean 'swp_swap_info'?
   include/linux/swap.h:487:40: note: 'swp_swap_info' declared here
   static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
                                          ^
>> mm/vmscan.c:1480:42: error: member reference type 'int' is not a pointer
           return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
                             ~~~~~~~~~~~~~~~~~~~~  ^
   include/linux/compiler.h:216:28: note: expanded from macro 'data_race'
           __unqual_scalar_typeof(({ expr; })) __v = ({                    \
                                     ^~~~
   include/linux/compiler_types.h:291:13: note: expanded from macro '__unqual_scalar_typeof'
                   _Generic((x),                                           \
                             ^
>> mm/vmscan.c:1480:20: error: implicit declaration of function 'page_swap_info' [-Werror,-Wimplicit-function-declaration]
           return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
                             ^
>> mm/vmscan.c:1480:42: error: member reference type 'int' is not a pointer
           return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
                             ~~~~~~~~~~~~~~~~~~~~  ^
   include/linux/compiler.h:216:28: note: expanded from macro 'data_race'
           __unqual_scalar_typeof(({ expr; })) __v = ({                    \
                                     ^~~~
   include/linux/compiler_types.h:298:15: note: expanded from macro '__unqual_scalar_typeof'
                            default: (x)))
                                      ^
>> mm/vmscan.c:1480:20: error: implicit declaration of function 'page_swap_info' [-Werror,-Wimplicit-function-declaration]
           return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
                             ^
>> mm/vmscan.c:1480:42: error: member reference type 'int' is not a pointer
           return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
                             ~~~~~~~~~~~~~~~~~~~~  ^
   include/linux/compiler.h:218:3: note: expanded from macro 'data_race'
                   expr;                                                   \
                   ^~~~
>> mm/vmscan.c:1480:9: error: invalid argument type 'void' to unary expression
           return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   7 errors generated.


vim +/page_swap_info +1480 mm/vmscan.c

  1467	
  1468	static bool test_may_enter_fs(struct page *page, gfp_t gfp_mask)
  1469	{
  1470		if (gfp_mask & __GFP_FS)
  1471			return true;
  1472		if (!PageSwapCache(page) || !(gfp_mask & __GFP_IO))
  1473			return false;
  1474		/* We can "enter_fs" for swap-cache with only __GFP_IO
  1475		 * providing this isn't SWP_FS_OPS.
  1476		 * ->flags can be updated non-atomicially (scan_swap_map_slots),
  1477		 * but that will never affect SWP_FS_OPS, so the data_race
  1478		 * is safe.
  1479		 */
> 1480		return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
  1481	}
  1482	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
