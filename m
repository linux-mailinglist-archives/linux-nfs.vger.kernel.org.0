Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706B27C662F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 09:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjJLHJf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 03:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjJLHJe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 03:09:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DCBE4;
        Thu, 12 Oct 2023 00:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697094573; x=1728630573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OMxs2rMhSekOxNVACAqGobX6bcaVW/K7s0u9w4fLQe8=;
  b=hM/ZYj5DLffwjU82Zgp7bRIrdExRi9JP0AajZ1y3oVa5wW79EUjnMNhe
   6Po15W3pOydR2rwbupZ63LiL4P5QBqN0ozA2h389cw6tt0k5C+yTz6dKk
   6H9uOFXD8ncicPbGOchkTmJ3IVLDfZOdFjn5fAMbGANA4zRD8JcX4HEYI
   LVF2+FiB7waVZTiS/+EeLDuKWCOhzCeDfuujoXeDWmTxwM0vJBeJ8DGPD
   jtOmDl8FU+fh1YrJCwoSyP1/daIZaNC7v6s2T7h0QlWCPA0iG0DVRH8gi
   ng92a7XJPU5ZMpHID/lRHwDpuPdYxoUxRViCic3SNX9akVHBv9OKj+pqw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3441534"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="3441534"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 00:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="730813728"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="730813728"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Oct 2023 00:09:19 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqpor-0003Id-0u;
        Thu, 12 Oct 2023 07:09:17 +0000
Date:   Thu, 12 Oct 2023 15:08:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] sunrpc: Use no_printk() in dfprintk*() dummies
Message-ID: <202310121404.FMC1T6FF-lkp@intel.com>
References: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Geert,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.6-rc5 next-20231011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geert-Uytterhoeven/sunrpc-Use-no_printk-in-dfprintk-dummies/20231011-181013
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert%2Brenesas%40glider.be
patch subject: [PATCH] sunrpc: Use no_printk() in dfprintk*() dummies
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20231012/202310121404.FMC1T6FF-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310121404.FMC1T6FF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310121404.FMC1T6FF-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/alpha/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from fs/lockd/svclock.c:25:
   fs/lockd/svclock.c: In function 'nlmsvc_lookup_block':
>> fs/lockd/svclock.c:164:33: error: implicit declaration of function 'nlmdbg_cookie2a' [-Werror=implicit-function-declaration]
     164 |                                 nlmdbg_cookie2a(&block->b_call->a_args.cookie));
         |                                 ^~~~~~~~~~~~~~~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:129:17: note: in expansion of macro 'printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/sunrpc/debug.h:70:41: note: in expansion of macro 'no_printk'
      70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
         |                                         ^~~~~~~~~
   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/lockd/svclock.c:160:17: note: in expansion of macro 'dprintk'
     160 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                 ^~~~~~~
>> fs/lockd/svclock.c:160:25: warning: format '%s' expects argument of type 'char *', but argument 7 has type 'int' [-Wformat=]
     160 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ......
     164 |                                 nlmdbg_cookie2a(&block->b_call->a_args.cookie));
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:129:17: note: in expansion of macro 'printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/sunrpc/debug.h:70:41: note: in expansion of macro 'no_printk'
      70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
         |                                         ^~~~~~~~~
   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/lockd/svclock.c:160:17: note: in expansion of macro 'dprintk'
     160 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                 ^~~~~~~
   fs/lockd/svclock.c:160:72: note: format string is defined here
     160 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                                                                       ~^
         |                                                                        |
         |                                                                        char *
         |                                                                       %d
   fs/lockd/svclock.c: In function 'nlmsvc_find_block':
   fs/lockd/svclock.c:203:17: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'int' [-Wformat=]
     203 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~~~~~~~~~~~~~~~~~~~~
         |                                                      |
         |                                                      int
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:129:17: note: in expansion of macro 'printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/sunrpc/debug.h:70:41: note: in expansion of macro 'no_printk'
      70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
         |                                         ^~~~~~~~~
   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/lockd/svclock.c:203:9: note: in expansion of macro 'dprintk'
     203 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |         ^~~~~~~
   fs/lockd/svclock.c:203:37: note: format string is defined here
     203 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |                                    ~^
         |                                     |
         |                                     char *
         |                                    %d
   fs/lockd/svclock.c: In function 'nlmsvc_lock':
   fs/lockd/svclock.c:494:33: error: 'inode' undeclared (first use in this function)
     494 |                                 inode->i_sb->s_id, inode->i_ino,
         |                                 ^~~~~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:129:17: note: in expansion of macro 'printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/sunrpc/debug.h:70:41: note: in expansion of macro 'no_printk'
      70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
         |                                         ^~~~~~~~~
   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/lockd/svclock.c:493:9: note: in expansion of macro 'dprintk'
     493 |         dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
         |         ^~~~~~~
   fs/lockd/svclock.c:494:33: note: each undeclared identifier is reported only once for each function it appears in
     494 |                                 inode->i_sb->s_id, inode->i_ino,
         |                                 ^~~~~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:129:17: note: in expansion of macro 'printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/sunrpc/debug.h:70:41: note: in expansion of macro 'no_printk'
      70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
         |                                         ^~~~~~~~~
   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/lockd/svclock.c:493:9: note: in expansion of macro 'dprintk'
     493 |         dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
         |         ^~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/asm-generic/bug.h:22,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:6,
                    from ./arch/alpha/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/sunrpc/svcauth_gss.h:12,
                    from fs/nfsd/nfsfh.c:13:
   fs/nfsd/nfsfh.c: In function 'nfsd_setuser_and_check_port':
>> fs/nfsd/nfsfh.c:111:47: error: 'buf' undeclared (first use in this function)
     111 |                         svc_print_addr(rqstp, buf, sizeof(buf)));
         |                                               ^~~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:129:17: note: in expansion of macro 'printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/sunrpc/debug.h:70:41: note: in expansion of macro 'no_printk'
      70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
         |                                         ^~~~~~~~~
   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/nfsd/nfsfh.c:110:17: note: in expansion of macro 'dprintk'
     110 |                 dprintk("nfsd: request from insecure port %s!\n",
         |                 ^~~~~~~
   fs/nfsd/nfsfh.c:111:47: note: each undeclared identifier is reported only once for each function it appears in
     111 |                         svc_print_addr(rqstp, buf, sizeof(buf)));
         |                                               ^~~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:129:17: note: in expansion of macro 'printk'
     129 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/sunrpc/debug.h:70:41: note: in expansion of macro 'no_printk'
      70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
         |                                         ^~~~~~~~~
   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/nfsd/nfsfh.c:110:17: note: in expansion of macro 'dprintk'
     110 |                 dprintk("nfsd: request from insecure port %s!\n",
         |                 ^~~~~~~


vim +/nlmdbg_cookie2a +164 fs/lockd/svclock.c

5a0e3ad6af8660 Tejun Heo            2010-03-24  @25  #include <linux/slab.h>
^1da177e4c3f41 Linus Torvalds       2005-04-16   26  #include <linux/errno.h>
^1da177e4c3f41 Linus Torvalds       2005-04-16   27  #include <linux/kernel.h>
^1da177e4c3f41 Linus Torvalds       2005-04-16   28  #include <linux/sched.h>
^1da177e4c3f41 Linus Torvalds       2005-04-16   29  #include <linux/sunrpc/clnt.h>
5ccb0066f2d561 Stanislav Kinsbursky 2012-07-25   30  #include <linux/sunrpc/svc_xprt.h>
^1da177e4c3f41 Linus Torvalds       2005-04-16   31  #include <linux/lockd/nlm.h>
^1da177e4c3f41 Linus Torvalds       2005-04-16   32  #include <linux/lockd/lockd.h>
d751a7cd069555 Jeff Layton          2008-02-07   33  #include <linux/kthread.h>
b840be2f00c0bc J. Bruce Fields      2021-08-20   34  #include <linux/exportfs.h>
^1da177e4c3f41 Linus Torvalds       2005-04-16   35  
^1da177e4c3f41 Linus Torvalds       2005-04-16   36  #define NLMDBG_FACILITY		NLMDBG_SVCLOCK
^1da177e4c3f41 Linus Torvalds       2005-04-16   37  
^1da177e4c3f41 Linus Torvalds       2005-04-16   38  #ifdef CONFIG_LOCKD_V4
^1da177e4c3f41 Linus Torvalds       2005-04-16   39  #define nlm_deadlock	nlm4_deadlock
^1da177e4c3f41 Linus Torvalds       2005-04-16   40  #else
^1da177e4c3f41 Linus Torvalds       2005-04-16   41  #define nlm_deadlock	nlm_lck_denied
^1da177e4c3f41 Linus Torvalds       2005-04-16   42  #endif
^1da177e4c3f41 Linus Torvalds       2005-04-16   43  
6849c0cab69f5d Trond Myklebust      2006-03-20   44  static void nlmsvc_release_block(struct nlm_block *block);
^1da177e4c3f41 Linus Torvalds       2005-04-16   45  static void	nlmsvc_insert_block(struct nlm_block *block, unsigned long);
68a2d76cea4234 Olaf Kirch           2006-10-04   46  static void	nlmsvc_remove_block(struct nlm_block *block);
963d8fe5333912 Trond Myklebust      2006-01-03   47  
5e1abf8cb713a0 Trond Myklebust      2006-03-20   48  static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock);
5e1abf8cb713a0 Trond Myklebust      2006-03-20   49  static void nlmsvc_freegrantargs(struct nlm_rqst *call);
963d8fe5333912 Trond Myklebust      2006-01-03   50  static const struct rpc_call_ops nlmsvc_grant_ops;
^1da177e4c3f41 Linus Torvalds       2005-04-16   51  
^1da177e4c3f41 Linus Torvalds       2005-04-16   52  /*
^1da177e4c3f41 Linus Torvalds       2005-04-16   53   * The list of blocked locks to retry
^1da177e4c3f41 Linus Torvalds       2005-04-16   54   */
68a2d76cea4234 Olaf Kirch           2006-10-04   55  static LIST_HEAD(nlm_blocked);
f904be9cc77f36 Bryan Schumaker      2010-09-21   56  static DEFINE_SPINLOCK(nlm_blocked_lock);
^1da177e4c3f41 Linus Torvalds       2005-04-16   57  
10b89567db51e1 Jeff Layton          2014-11-17   58  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
ffa94db6042e6f Trond Myklebust      2012-03-20   59  static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
ffa94db6042e6f Trond Myklebust      2012-03-20   60  {
ffa94db6042e6f Trond Myklebust      2012-03-20   61  	/*
3c5199143bc4b3 Jeff Layton          2015-01-22   62  	 * We can get away with a static buffer because this is only called
3c5199143bc4b3 Jeff Layton          2015-01-22   63  	 * from lockd, which is single-threaded.
ffa94db6042e6f Trond Myklebust      2012-03-20   64  	 */
ffa94db6042e6f Trond Myklebust      2012-03-20   65  	static char buf[2*NLM_MAXCOOKIELEN+1];
ffa94db6042e6f Trond Myklebust      2012-03-20   66  	unsigned int i, len = sizeof(buf);
ffa94db6042e6f Trond Myklebust      2012-03-20   67  	char *p = buf;
ffa94db6042e6f Trond Myklebust      2012-03-20   68  
ffa94db6042e6f Trond Myklebust      2012-03-20   69  	len--;	/* allow for trailing \0 */
ffa94db6042e6f Trond Myklebust      2012-03-20   70  	if (len < 3)
ffa94db6042e6f Trond Myklebust      2012-03-20   71  		return "???";
ffa94db6042e6f Trond Myklebust      2012-03-20   72  	for (i = 0 ; i < cookie->len ; i++) {
ffa94db6042e6f Trond Myklebust      2012-03-20   73  		if (len < 2) {
ffa94db6042e6f Trond Myklebust      2012-03-20   74  			strcpy(p-3, "...");
ffa94db6042e6f Trond Myklebust      2012-03-20   75  			break;
ffa94db6042e6f Trond Myklebust      2012-03-20   76  		}
ffa94db6042e6f Trond Myklebust      2012-03-20   77  		sprintf(p, "%02x", cookie->data[i]);
ffa94db6042e6f Trond Myklebust      2012-03-20   78  		p += 2;
ffa94db6042e6f Trond Myklebust      2012-03-20   79  		len -= 2;
ffa94db6042e6f Trond Myklebust      2012-03-20   80  	}
ffa94db6042e6f Trond Myklebust      2012-03-20   81  	*p = '\0';
ffa94db6042e6f Trond Myklebust      2012-03-20   82  
ffa94db6042e6f Trond Myklebust      2012-03-20   83  	return buf;
ffa94db6042e6f Trond Myklebust      2012-03-20   84  }
ffa94db6042e6f Trond Myklebust      2012-03-20   85  #endif
ffa94db6042e6f Trond Myklebust      2012-03-20   86  
^1da177e4c3f41 Linus Torvalds       2005-04-16   87  /*
^1da177e4c3f41 Linus Torvalds       2005-04-16   88   * Insert a blocked lock into the global list
^1da177e4c3f41 Linus Torvalds       2005-04-16   89   */
^1da177e4c3f41 Linus Torvalds       2005-04-16   90  static void
f904be9cc77f36 Bryan Schumaker      2010-09-21   91  nlmsvc_insert_block_locked(struct nlm_block *block, unsigned long when)
^1da177e4c3f41 Linus Torvalds       2005-04-16   92  {
68a2d76cea4234 Olaf Kirch           2006-10-04   93  	struct nlm_block *b;
68a2d76cea4234 Olaf Kirch           2006-10-04   94  	struct list_head *pos;
^1da177e4c3f41 Linus Torvalds       2005-04-16   95  
^1da177e4c3f41 Linus Torvalds       2005-04-16   96  	dprintk("lockd: nlmsvc_insert_block(%p, %ld)\n", block, when);
68a2d76cea4234 Olaf Kirch           2006-10-04   97  	if (list_empty(&block->b_list)) {
6849c0cab69f5d Trond Myklebust      2006-03-20   98  		kref_get(&block->b_count);
68a2d76cea4234 Olaf Kirch           2006-10-04   99  	} else {
68a2d76cea4234 Olaf Kirch           2006-10-04  100  		list_del_init(&block->b_list);
68a2d76cea4234 Olaf Kirch           2006-10-04  101  	}
68a2d76cea4234 Olaf Kirch           2006-10-04  102  
68a2d76cea4234 Olaf Kirch           2006-10-04  103  	pos = &nlm_blocked;
^1da177e4c3f41 Linus Torvalds       2005-04-16  104  	if (when != NLM_NEVER) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  105  		if ((when += jiffies) == NLM_NEVER)
^1da177e4c3f41 Linus Torvalds       2005-04-16  106  			when ++;
68a2d76cea4234 Olaf Kirch           2006-10-04  107  		list_for_each(pos, &nlm_blocked) {
68a2d76cea4234 Olaf Kirch           2006-10-04  108  			b = list_entry(pos, struct nlm_block, b_list);
68a2d76cea4234 Olaf Kirch           2006-10-04  109  			if (time_after(b->b_when,when) || b->b_when == NLM_NEVER)
68a2d76cea4234 Olaf Kirch           2006-10-04  110  				break;
68a2d76cea4234 Olaf Kirch           2006-10-04  111  		}
68a2d76cea4234 Olaf Kirch           2006-10-04  112  		/* On normal exit from the loop, pos == &nlm_blocked,
68a2d76cea4234 Olaf Kirch           2006-10-04  113  		 * so we will be adding to the end of the list - good
68a2d76cea4234 Olaf Kirch           2006-10-04  114  		 */
68a2d76cea4234 Olaf Kirch           2006-10-04  115  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  116  
68a2d76cea4234 Olaf Kirch           2006-10-04  117  	list_add_tail(&block->b_list, pos);
^1da177e4c3f41 Linus Torvalds       2005-04-16  118  	block->b_when = when;
^1da177e4c3f41 Linus Torvalds       2005-04-16  119  }
^1da177e4c3f41 Linus Torvalds       2005-04-16  120  
f904be9cc77f36 Bryan Schumaker      2010-09-21  121  static void nlmsvc_insert_block(struct nlm_block *block, unsigned long when)
f904be9cc77f36 Bryan Schumaker      2010-09-21  122  {
f904be9cc77f36 Bryan Schumaker      2010-09-21  123  	spin_lock(&nlm_blocked_lock);
f904be9cc77f36 Bryan Schumaker      2010-09-21  124  	nlmsvc_insert_block_locked(block, when);
f904be9cc77f36 Bryan Schumaker      2010-09-21  125  	spin_unlock(&nlm_blocked_lock);
f904be9cc77f36 Bryan Schumaker      2010-09-21  126  }
f904be9cc77f36 Bryan Schumaker      2010-09-21  127  
^1da177e4c3f41 Linus Torvalds       2005-04-16  128  /*
^1da177e4c3f41 Linus Torvalds       2005-04-16  129   * Remove a block from the global list
^1da177e4c3f41 Linus Torvalds       2005-04-16  130   */
68a2d76cea4234 Olaf Kirch           2006-10-04  131  static inline void
^1da177e4c3f41 Linus Torvalds       2005-04-16  132  nlmsvc_remove_block(struct nlm_block *block)
^1da177e4c3f41 Linus Torvalds       2005-04-16  133  {
f904be9cc77f36 Bryan Schumaker      2010-09-21  134  	spin_lock(&nlm_blocked_lock);
be2be5f7f44364 Alexander Aring      2023-07-20  135  	if (!list_empty(&block->b_list)) {
68a2d76cea4234 Olaf Kirch           2006-10-04  136  		list_del_init(&block->b_list);
f904be9cc77f36 Bryan Schumaker      2010-09-21  137  		spin_unlock(&nlm_blocked_lock);
6849c0cab69f5d Trond Myklebust      2006-03-20  138  		nlmsvc_release_block(block);
be2be5f7f44364 Alexander Aring      2023-07-20  139  		return;
^1da177e4c3f41 Linus Torvalds       2005-04-16  140  	}
be2be5f7f44364 Alexander Aring      2023-07-20  141  	spin_unlock(&nlm_blocked_lock);
^1da177e4c3f41 Linus Torvalds       2005-04-16  142  }
^1da177e4c3f41 Linus Torvalds       2005-04-16  143  
^1da177e4c3f41 Linus Torvalds       2005-04-16  144  /*
d9f6eb75d49007 Trond Myklebust      2006-03-20  145   * Find a block for a given lock
^1da177e4c3f41 Linus Torvalds       2005-04-16  146   */
^1da177e4c3f41 Linus Torvalds       2005-04-16  147  static struct nlm_block *
d9f6eb75d49007 Trond Myklebust      2006-03-20  148  nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
^1da177e4c3f41 Linus Torvalds       2005-04-16  149  {
68a2d76cea4234 Olaf Kirch           2006-10-04  150  	struct nlm_block	*block;
^1da177e4c3f41 Linus Torvalds       2005-04-16  151  	struct file_lock	*fl;
^1da177e4c3f41 Linus Torvalds       2005-04-16  152  
^1da177e4c3f41 Linus Torvalds       2005-04-16  153  	dprintk("lockd: nlmsvc_lookup_block f=%p pd=%d %Ld-%Ld ty=%d\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  154  				file, lock->fl.fl_pid,
^1da177e4c3f41 Linus Torvalds       2005-04-16  155  				(long long)lock->fl.fl_start,
^1da177e4c3f41 Linus Torvalds       2005-04-16  156  				(long long)lock->fl.fl_end, lock->fl.fl_type);
be2be5f7f44364 Alexander Aring      2023-07-20  157  	spin_lock(&nlm_blocked_lock);
68a2d76cea4234 Olaf Kirch           2006-10-04  158  	list_for_each_entry(block, &nlm_blocked, b_list) {
92737230dd3f14 Trond Myklebust      2006-03-20  159  		fl = &block->b_call->a_args.lock.fl;
^1da177e4c3f41 Linus Torvalds       2005-04-16 @160  		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  161  				block->b_file, fl->fl_pid,
^1da177e4c3f41 Linus Torvalds       2005-04-16  162  				(long long)fl->fl_start,
^1da177e4c3f41 Linus Torvalds       2005-04-16  163  				(long long)fl->fl_end, fl->fl_type,
92737230dd3f14 Trond Myklebust      2006-03-20 @164  				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
^1da177e4c3f41 Linus Torvalds       2005-04-16  165  		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
6849c0cab69f5d Trond Myklebust      2006-03-20  166  			kref_get(&block->b_count);
be2be5f7f44364 Alexander Aring      2023-07-20  167  			spin_unlock(&nlm_blocked_lock);
^1da177e4c3f41 Linus Torvalds       2005-04-16  168  			return block;
^1da177e4c3f41 Linus Torvalds       2005-04-16  169  		}
^1da177e4c3f41 Linus Torvalds       2005-04-16  170  	}
be2be5f7f44364 Alexander Aring      2023-07-20  171  	spin_unlock(&nlm_blocked_lock);
^1da177e4c3f41 Linus Torvalds       2005-04-16  172  
^1da177e4c3f41 Linus Torvalds       2005-04-16  173  	return NULL;
^1da177e4c3f41 Linus Torvalds       2005-04-16  174  }
^1da177e4c3f41 Linus Torvalds       2005-04-16  175  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
