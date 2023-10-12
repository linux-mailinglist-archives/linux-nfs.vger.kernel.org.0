Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028F07C6A6F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 12:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbjJLKGt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjJLKGs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 06:06:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FA0BB;
        Thu, 12 Oct 2023 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697105206; x=1728641206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Fek6JwjKVJlZ3rkJLoLErsIJ5qyM6I/dA5MFWXz2tk=;
  b=j25CHhZPybObjVpiH/UhoUgA6OGNLxqiA56qD1SYVamK8PaSoAlom4PD
   w4mykF4iXVN/2jlaSk8NUx6+8uPSK5XhsO23vilrA/ww/dDlXpGtcbpbW
   VlzJ4YNmu06GatpqnTFADUruR1AbVWXFvQEY5IvXnMMEXqLfhfnbFJkBV
   nO7y1A8ItCnLMpUN72BQjZEBk7ao0JtEjg0qglDSQm9d3Pczhg3JF3M9B
   jI9bMCzYvIi+4Ly1AyqdcsPsieZUyQcS0TJSy4BM7hY4kKcOkNgniJ/dU
   6sLSms5NXZqnPGoD7gdgJ9TiVXe01oa4EWf2zSB1vRyyXtAcTRD3RACrD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="387721290"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="387721290"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="730861872"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="730861872"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Oct 2023 03:06:41 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqsaU-0003MX-2r;
        Thu, 12 Oct 2023 10:06:38 +0000
Date:   Thu, 12 Oct 2023 18:06:20 +0800
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
Message-ID: <202310121759.0CF34DcN-lkp@intel.com>
References: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Geert,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geert-Uytterhoeven/sunrpc-Use-no_printk-in-dfprintk-dummies/20231011-181013
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert%2Brenesas%40glider.be
patch subject: [PATCH] sunrpc: Use no_printk() in dfprintk*() dummies
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20231012/202310121759.0CF34DcN-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310121759.0CF34DcN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310121759.0CF34DcN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:30,
                    from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/in.h:25,
                    from include/linux/in.h:19,
                    from include/linux/nfs_fs.h:22,
                    from fs/nfs/filelayout/filelayout.c:32:
   fs/nfs/filelayout/filelayout.c: In function 'filelayout_reset_write':
>> fs/nfs/filelayout/filelayout.c:96:34: error: 'struct rpc_task' has no member named 'tk_pid'
      96 |                         hdr->task.tk_pid,
         |                                  ^
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
   fs/nfs/filelayout/filelayout.c:94:17: note: in expansion of macro 'dprintk'
      94 |                 dprintk("%s Reset task %5u for i/o through MDS "
         |                 ^~~~~~~
   fs/nfs/filelayout/filelayout.c: In function 'filelayout_reset_read':
   fs/nfs/filelayout/filelayout.c:113:34: error: 'struct rpc_task' has no member named 'tk_pid'
     113 |                         hdr->task.tk_pid,
         |                                  ^
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
   fs/nfs/filelayout/filelayout.c:111:17: note: in expansion of macro 'dprintk'
     111 |                 dprintk("%s Reset task %5u for i/o through MDS "
         |                 ^~~~~~~
   fs/nfs/filelayout/filelayout.c: In function 'filelayout_read_prepare':
   fs/nfs/filelayout/filelayout.c:277:71: error: 'struct rpc_task' has no member named 'tk_pid'
     277 |                 dprintk("%s task %u reset io to MDS\n", __func__, task->tk_pid);
         |                                                                       ^~
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
   fs/nfs/filelayout/filelayout.c:277:17: note: in expansion of macro 'dprintk'
     277 |                 dprintk("%s task %u reset io to MDS\n", __func__, task->tk_pid);
         |                 ^~~~~~~
   fs/nfs/filelayout/filelayout.c: In function 'filelayout_write_prepare':
   fs/nfs/filelayout/filelayout.c:375:71: error: 'struct rpc_task' has no member named 'tk_pid'
     375 |                 dprintk("%s task %u reset io to MDS\n", __func__, task->tk_pid);
         |                                                                       ^~
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
   fs/nfs/filelayout/filelayout.c:375:17: note: in expansion of macro 'dprintk'
     375 |                 dprintk("%s task %u reset io to MDS\n", __func__, task->tk_pid);
         |                 ^~~~~~~
--
   In file included from include/linux/kernel.h:30,
                    from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/in.h:25,
                    from include/linux/in.h:19,
                    from include/linux/nfs_fs.h:22,
                    from fs/nfs/flexfilelayout/flexfilelayout.c:10:
   fs/nfs/flexfilelayout/flexfilelayout.c: In function 'ff_layout_reset_write':
>> fs/nfs/flexfilelayout/flexfilelayout.c:1020:34: error: 'struct rpc_task' has no member named 'tk_pid'
    1020 |                         hdr->task.tk_pid,
         |                                  ^
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
   fs/nfs/flexfilelayout/flexfilelayout.c:1018:17: note: in expansion of macro 'dprintk'
    1018 |                 dprintk("%s Reset task %5u for i/o through pNFS "
         |                 ^~~~~~~
   fs/nfs/flexfilelayout/flexfilelayout.c:1033:34: error: 'struct rpc_task' has no member named 'tk_pid'
    1033 |                         hdr->task.tk_pid,
         |                                  ^
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
   fs/nfs/flexfilelayout/flexfilelayout.c:1031:17: note: in expansion of macro 'dprintk'
    1031 |                 dprintk("%s Reset task %5u for i/o through MDS "
         |                 ^~~~~~~
   fs/nfs/flexfilelayout/flexfilelayout.c: In function 'ff_layout_reset_read':
   fs/nfs/flexfilelayout/flexfilelayout.c:1069:34: error: 'struct rpc_task' has no member named 'tk_pid'
    1069 |                         hdr->task.tk_pid,
         |                                  ^
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
   fs/nfs/flexfilelayout/flexfilelayout.c:1067:17: note: in expansion of macro 'dprintk'
    1067 |                 dprintk("%s Reset task %5u for i/o through MDS "
         |                 ^~~~~~~


vim +96 fs/nfs/filelayout/filelayout.c

7ab672ce312133 fs/nfs/nfs4filelayout.c        Dean Hildebrand       2010-10-20  @32  #include <linux/nfs_fs.h>
19345cb299e823 fs/nfs/nfs4filelayout.c        Benny Halevy          2011-06-19   33  #include <linux/nfs_page.h>
143cb494cb6662 fs/nfs/nfs4filelayout.c        Paul Gortmaker        2011-07-01   34  #include <linux/module.h>
66114cad64bf76 fs/nfs/filelayout/filelayout.c Tejun Heo             2015-05-22   35  #include <linux/backing-dev.h>
16b374ca439fb4 fs/nfs/nfs4filelayout.c        Andy Adamson          2010-10-20   36  
0a702195234eb7 fs/nfs/nfs4filelayout.c        Weston Andros Adamson 2012-02-17   37  #include <linux/sunrpc/metrics.h>
0a702195234eb7 fs/nfs/nfs4filelayout.c        Weston Andros Adamson 2012-02-17   38  
b5968725f46d95 fs/nfs/filelayout/filelayout.c Tom Haynes            2014-05-12   39  #include "../nfs4session.h"
b5968725f46d95 fs/nfs/filelayout/filelayout.c Tom Haynes            2014-05-12   40  #include "../internal.h"
b5968725f46d95 fs/nfs/filelayout/filelayout.c Tom Haynes            2014-05-12   41  #include "../delegation.h"
b5968725f46d95 fs/nfs/filelayout/filelayout.c Tom Haynes            2014-05-12   42  #include "filelayout.h"
b5968725f46d95 fs/nfs/filelayout/filelayout.c Tom Haynes            2014-05-12   43  #include "../nfs4trace.h"
7ab672ce312133 fs/nfs/nfs4filelayout.c        Dean Hildebrand       2010-10-20   44  
7ab672ce312133 fs/nfs/nfs4filelayout.c        Dean Hildebrand       2010-10-20   45  #define NFSDBG_FACILITY         NFSDBG_PNFS_LD
7ab672ce312133 fs/nfs/nfs4filelayout.c        Dean Hildebrand       2010-10-20   46  
7ab672ce312133 fs/nfs/nfs4filelayout.c        Dean Hildebrand       2010-10-20   47  MODULE_LICENSE("GPL");
7ab672ce312133 fs/nfs/nfs4filelayout.c        Dean Hildebrand       2010-10-20   48  MODULE_AUTHOR("Dean Hildebrand <dhildebz@umich.edu>");
7ab672ce312133 fs/nfs/nfs4filelayout.c        Dean Hildebrand       2010-10-20   49  MODULE_DESCRIPTION("The NFSv4 file layout driver");
7ab672ce312133 fs/nfs/nfs4filelayout.c        Dean Hildebrand       2010-10-20   50  
cbdabc7f8bf14c fs/nfs/nfs4filelayout.c        Andy Adamson          2011-03-01   51  #define FILELAYOUT_POLL_RETRY_MAX     (15*HZ)
9c455a8c1e146d fs/nfs/filelayout/filelayout.c Trond Myklebust       2020-03-21   52  static const struct pnfs_commit_ops filelayout_commit_ops;
cbdabc7f8bf14c fs/nfs/nfs4filelayout.c        Andy Adamson          2011-03-01   53  
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   54  static loff_t
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   55  filelayout_get_dense_offset(struct nfs4_filelayout_segment *flseg,
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   56  			    loff_t offset)
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   57  {
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   58  	u32 stripe_width = flseg->stripe_unit * flseg->dsaddr->stripe_count;
3476f114addb7b fs/nfs/nfs4filelayout.c        Chris Metcalf         2011-08-11   59  	u64 stripe_no;
3476f114addb7b fs/nfs/nfs4filelayout.c        Chris Metcalf         2011-08-11   60  	u32 rem;
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   61  
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   62  	offset -= flseg->pattern_offset;
3476f114addb7b fs/nfs/nfs4filelayout.c        Chris Metcalf         2011-08-11   63  	stripe_no = div_u64(offset, stripe_width);
3476f114addb7b fs/nfs/nfs4filelayout.c        Chris Metcalf         2011-08-11   64  	div_u64_rem(offset, flseg->stripe_unit, &rem);
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   65  
3476f114addb7b fs/nfs/nfs4filelayout.c        Chris Metcalf         2011-08-11   66  	return stripe_no * flseg->stripe_unit + rem;
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   67  }
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   68  
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   69  /* This function is used by the layout driver to calculate the
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   70   * offset of the file on the dserver based on whether the
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   71   * layout type is STRIPE_DENSE or STRIPE_SPARSE
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   72   */
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   73  static loff_t
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   74  filelayout_get_dserver_offset(struct pnfs_layout_segment *lseg, loff_t offset)
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   75  {
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   76  	struct nfs4_filelayout_segment *flseg = FILELAYOUT_LSEG(lseg);
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   77  
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   78  	switch (flseg->stripe_type) {
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   79  	case STRIPE_SPARSE:
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   80  		return offset;
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   81  
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   82  	case STRIPE_DENSE:
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   83  		return filelayout_get_dense_offset(flseg, offset);
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   84  	}
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   85  
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   86  	BUG();
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   87  }
cfe7f4120f8b1b fs/nfs/nfs4filelayout.c        Fred Isaman           2011-03-01   88  
d45f60c67848b9 fs/nfs/filelayout/filelayout.c Weston Andros Adamson 2014-06-09   89  static void filelayout_reset_write(struct nfs_pgio_header *hdr)
e7dd79af01e7ca fs/nfs/nfs4filelayout.c        Andy Adamson          2012-04-27   90  {
d45f60c67848b9 fs/nfs/filelayout/filelayout.c Weston Andros Adamson 2014-06-09   91  	struct rpc_task *task = &hdr->task;
e7dd79af01e7ca fs/nfs/nfs4filelayout.c        Andy Adamson          2012-04-27   92  
e7dd79af01e7ca fs/nfs/nfs4filelayout.c        Andy Adamson          2012-04-27   93  	if (!test_and_set_bit(NFS_IOHDR_REDO, &hdr->flags)) {
e7dd79af01e7ca fs/nfs/nfs4filelayout.c        Andy Adamson          2012-04-27   94  		dprintk("%s Reset task %5u for i/o through MDS "
1e8968c5b05823 fs/nfs/nfs4filelayout.c        Niels de Vos          2013-12-17   95  			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
d45f60c67848b9 fs/nfs/filelayout/filelayout.c Weston Andros Adamson 2014-06-09  @96  			hdr->task.tk_pid,
497826af60f812 fs/nfs/nfs4filelayout.c        Bryan Schumaker       2012-05-22   97  			hdr->inode->i_sb->s_id,
1e8968c5b05823 fs/nfs/nfs4filelayout.c        Niels de Vos          2013-12-17   98  			(unsigned long long)NFS_FILEID(hdr->inode),
d45f60c67848b9 fs/nfs/filelayout/filelayout.c Weston Andros Adamson 2014-06-09   99  			hdr->args.count,
d45f60c67848b9 fs/nfs/filelayout/filelayout.c Weston Andros Adamson 2014-06-09  100  			(unsigned long long)hdr->args.offset);
e7dd79af01e7ca fs/nfs/nfs4filelayout.c        Andy Adamson          2012-04-27  101  
53113ad35e4b9c fs/nfs/filelayout/filelayout.c Weston Andros Adamson 2014-06-09  102  		task->tk_status = pnfs_write_done_resend_to_mds(hdr);
e7dd79af01e7ca fs/nfs/nfs4filelayout.c        Andy Adamson          2012-04-27  103  	}
e7dd79af01e7ca fs/nfs/nfs4filelayout.c        Andy Adamson          2012-04-27  104  }
e7dd79af01e7ca fs/nfs/nfs4filelayout.c        Andy Adamson          2012-04-27  105  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
