Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557707C6BB9
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347144AbjJLK7v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbjJLK7u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 06:59:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DFCB7;
        Thu, 12 Oct 2023 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697108389; x=1728644389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3YC+4BLVMkkibIln0wa4F1QGAJso+eq+Ty6FTxk84Ig=;
  b=IphY8ZuFRPaIPhlPOSKE1FsfEiI9CZe7wJD+iLkdyu6DEGIcxjKghCEw
   5TBefT6Nyt3bntQb/YV+KiMqbkYwSFaym8cCl06DMBtAUiRh2arI9dt0Y
   uPEbTXDJvcVmEDw+S0kdsTDt08tBqZcan/+eo3nSdm34x9qYZ3L/QNKFy
   C5Z0lsrs2nOageBT2cxjnlQqKDXptC5sDG+3jynH5g6+MwlEzGYSKUnln
   ZVF0LSxN0ok2Oirnldd3tHxWrv16dTde58pBqnAt0dxEpiaii1/4MfAq9
   fODl9Mjtq8bIQizb8e4iuOW2sBk3o4Woz1j98KgOrLqCCgyFYzqSxOxf/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415941084"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="415941084"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="820093078"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="820093078"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Oct 2023 03:59:46 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqtPs-0003O9-04;
        Thu, 12 Oct 2023 10:59:44 +0000
Date:   Thu, 12 Oct 2023 18:59:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] sunrpc: Use no_printk() in dfprintk*() dummies
Message-ID: <202310121849.fnsB0A2T-lkp@intel.com>
References: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Geert,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geert-Uytterhoeven/sunrpc-Use-no_printk-in-dfprintk-dummies/20231011-181013
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert%2Brenesas%40glider.be
patch subject: [PATCH] sunrpc: Use no_printk() in dfprintk*() dummies
config: powerpc-ebony_defconfig (https://download.01.org/0day-ci/archive/20231012/202310121849.fnsB0A2T-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310121849.fnsB0A2T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310121849.fnsB0A2T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/lockd/svclock.c:164:5: error: call to undeclared function 'nlmdbg_cookie2a'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     164 |                                 nlmdbg_cookie2a(&block->b_call->a_args.cookie));
         |                                 ^
>> fs/lockd/svclock.c:164:5: warning: format specifies type 'char *' but the argument has type 'int' [-Wformat]
     164 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                                                                       ~~
         |                                                                       %d
     165 |                                 block->b_file, fl->fl_pid,
     166 |                                 (long long)fl->fl_start,
     167 |                                 (long long)fl->fl_end, fl->fl_type,
     168 |                                 nlmdbg_cookie2a(&block->b_call->a_args.cookie));
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:28: note: expanded from macro 'dprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |                            ~~~    ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:70:51: note: expanded from macro 'dfprintk'
      70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
         |                                                   ~~~    ^~~~~~~~~~~
   include/linux/printk.h:129:17: note: expanded from macro 'no_printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                        ~~~    ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
     455 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   fs/lockd/svclock.c:203:47: error: call to undeclared function 'nlmdbg_cookie2a'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     203 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |                                                      ^
   fs/lockd/svclock.c:203:47: warning: format specifies type 'char *' but the argument has type 'int' [-Wformat]
     203 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |                                    ~~                ^~~~~~~~~~~~~~~~~~~~~~~
         |                                    %d
   include/linux/sunrpc/debug.h:25:28: note: expanded from macro 'dprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |                            ~~~    ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:70:51: note: expanded from macro 'dfprintk'
      70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
         |                                                   ~~~    ^~~~~~~~~~~
   include/linux/printk.h:129:17: note: expanded from macro 'no_printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                        ~~~    ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
     455 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   fs/lockd/svclock.c:494:5: error: use of undeclared identifier 'inode'
     494 |                                 inode->i_sb->s_id, inode->i_ino,
         |                                 ^
   fs/lockd/svclock.c:494:24: error: use of undeclared identifier 'inode'
     494 |                                 inode->i_sb->s_id, inode->i_ino,
         |                                                    ^
   2 warnings and 4 errors generated.


vim +164 fs/lockd/svclock.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  143  
^1da177e4c3f41 Linus Torvalds  2005-04-16  144  /*
d9f6eb75d49007 Trond Myklebust 2006-03-20  145   * Find a block for a given lock
^1da177e4c3f41 Linus Torvalds  2005-04-16  146   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  147  static struct nlm_block *
d9f6eb75d49007 Trond Myklebust 2006-03-20  148  nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
^1da177e4c3f41 Linus Torvalds  2005-04-16  149  {
68a2d76cea4234 Olaf Kirch      2006-10-04  150  	struct nlm_block	*block;
^1da177e4c3f41 Linus Torvalds  2005-04-16  151  	struct file_lock	*fl;
^1da177e4c3f41 Linus Torvalds  2005-04-16  152  
^1da177e4c3f41 Linus Torvalds  2005-04-16  153  	dprintk("lockd: nlmsvc_lookup_block f=%p pd=%d %Ld-%Ld ty=%d\n",
^1da177e4c3f41 Linus Torvalds  2005-04-16  154  				file, lock->fl.fl_pid,
^1da177e4c3f41 Linus Torvalds  2005-04-16  155  				(long long)lock->fl.fl_start,
^1da177e4c3f41 Linus Torvalds  2005-04-16  156  				(long long)lock->fl.fl_end, lock->fl.fl_type);
be2be5f7f44364 Alexander Aring 2023-07-20  157  	spin_lock(&nlm_blocked_lock);
68a2d76cea4234 Olaf Kirch      2006-10-04  158  	list_for_each_entry(block, &nlm_blocked, b_list) {
92737230dd3f14 Trond Myklebust 2006-03-20  159  		fl = &block->b_call->a_args.lock.fl;
^1da177e4c3f41 Linus Torvalds  2005-04-16  160  		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
^1da177e4c3f41 Linus Torvalds  2005-04-16  161  				block->b_file, fl->fl_pid,
^1da177e4c3f41 Linus Torvalds  2005-04-16  162  				(long long)fl->fl_start,
^1da177e4c3f41 Linus Torvalds  2005-04-16  163  				(long long)fl->fl_end, fl->fl_type,
92737230dd3f14 Trond Myklebust 2006-03-20 @164  				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
^1da177e4c3f41 Linus Torvalds  2005-04-16  165  		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
6849c0cab69f5d Trond Myklebust 2006-03-20  166  			kref_get(&block->b_count);
be2be5f7f44364 Alexander Aring 2023-07-20  167  			spin_unlock(&nlm_blocked_lock);
^1da177e4c3f41 Linus Torvalds  2005-04-16  168  			return block;
^1da177e4c3f41 Linus Torvalds  2005-04-16  169  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  170  	}
be2be5f7f44364 Alexander Aring 2023-07-20  171  	spin_unlock(&nlm_blocked_lock);
^1da177e4c3f41 Linus Torvalds  2005-04-16  172  
^1da177e4c3f41 Linus Torvalds  2005-04-16  173  	return NULL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  174  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  175  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
