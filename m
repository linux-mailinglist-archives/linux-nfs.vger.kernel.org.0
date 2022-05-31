Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4A539619
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiEaSTZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbiEaSTY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 14:19:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805DF9A98B
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654021163; x=1685557163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xumI9vuXdEUNGgXHWBVLplQGJT8n7O0W3v3H+0e2JpI=;
  b=S53JjvwSpqhEBGRn/AKbWBft51453mCK/NnISwKx/f/43A2bdZya0cSZ
   9hkVkgQTj7dDldu6UpRiGyDvZjqTLzEGtav2ImvI/QrZzfA0HAczl0+6R
   LaUFlZSdQ9oEJ7XMdOqcutRLp1JK8CWHiCd94zWxZpidHcNXbLgNm6DFk
   18pPa1/FARu1QMFFG9bOz6Eo0epZlS+pA4FBjsnpgYXpcEauq8nh8+e38
   UHpWY4n7tqxTV/C5xRL6qzS1eVx6Hb2p0t70bcESb7FmFi7L7dvm2QCyH
   y0de39g7y6JAYGrYfBZZq0JXdrXK40HYYhrLTc+QSp/h5oM9McAy8EiP8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361721301"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="361721301"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 11:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="611957473"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 May 2022 11:19:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw6Se-0002xI-Kc;
        Tue, 31 May 2022 18:19:20 +0000
Date:   Wed, 1 Jun 2022 02:19:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     kbuild-all@lists.01.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
Message-ID: <202206010206.kDKlof2o-lkp@intel.com>
References: <20220531134854.63115-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531134854.63115-1-olga.kornievskaia@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on v5.18 next-20220531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Olga-Kornievskaia/pNFS-fix-IO-thread-starvation-problem-during-LAYOUTUNAVAILABLE-error/20220531-215040
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220601/202206010206.kDKlof2o-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7f80a6c53d6cdb806706a8748cb79348f9906229
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Olga-Kornievskaia/pNFS-fix-IO-thread-starvation-problem-during-LAYOUTUNAVAILABLE-error/20220531-215040
        git checkout 7f80a6c53d6cdb806706a8748cb79348f9906229
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/in.h:24,
                    from include/linux/in.h:19,
                    from include/linux/nfs_fs.h:22,
                    from fs/nfs/pnfs.c:30:
   fs/nfs/pnfs.c: In function 'pnfs_update_layout':
>> arch/arm/include/asm/bitops.h:183:41: warning: this statement may fall through [-Wimplicit-fallthrough=]
     183 | #define ATOMIC_BITOP(name,nr,p)         _##name(nr,p)
         |                                         ^~~~~~~~~~~~~
   arch/arm/include/asm/bitops.h:189:41: note: in expansion of macro 'ATOMIC_BITOP'
     189 | #define set_bit(nr,p)                   ATOMIC_BITOP(set_bit,nr,p)
         |                                         ^~~~~~~~~~~~
   fs/nfs/pnfs.c:2164:25: note: in expansion of macro 'set_bit'
    2164 |                         set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
         |                         ^~~~~~~
   fs/nfs/pnfs.c:2165:17: note: here
    2165 |                 default:
         |                 ^~~~~~~


vim +183 arch/arm/include/asm/bitops.h

^1da177e4c3f41 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  175  
e7ec02938dbe8c include/asm-arm/bitops.h      Russell King   2005-07-28  176  #ifndef CONFIG_SMP
^1da177e4c3f41 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  177  /*
^1da177e4c3f41 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  178   * The __* form of bitops are non-atomic and may be reordered.
^1da177e4c3f41 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  179   */
6323f0ccedf756 arch/arm/include/asm/bitops.h Russell King   2011-01-16  180  #define ATOMIC_BITOP(name,nr,p)			\
6323f0ccedf756 arch/arm/include/asm/bitops.h Russell King   2011-01-16  181  	(__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
e7ec02938dbe8c include/asm-arm/bitops.h      Russell King   2005-07-28  182  #else
6323f0ccedf756 arch/arm/include/asm/bitops.h Russell King   2011-01-16 @183  #define ATOMIC_BITOP(name,nr,p)		_##name(nr,p)
e7ec02938dbe8c include/asm-arm/bitops.h      Russell King   2005-07-28  184  #endif
^1da177e4c3f41 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  185  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
