Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456AF5A350C
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Aug 2022 08:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiH0Gbq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 27 Aug 2022 02:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiH0Gbp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 27 Aug 2022 02:31:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AACCAC95
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 23:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661581904; x=1693117904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AHApHPXEU7s+9bfLBV5PgrKBP2tv1XVmisi7/hNIHeo=;
  b=HehfAL0EZc37f6NjNZoZjziyCX14MUIAxezTBGuOahs4RrpcrhrIWSwY
   ykl+oggWQU7Cu+KKJG6PX00n/gSmfgNcvYTBu5GTWBJXAvJarh1hdiGWA
   L+oy+Yn5Y7LlEJ7SjR8WMWYRQdxNPKAUatevYL0tU4kapiG/Q+c9P00RT
   prDyTf3dg+ti1VkahqjJ7sOMDQVXLzZyt3ngbdGxVYwUag1dOezWq5s5g
   4GSMVaAEajLQ/u9I21YGM0/yJyfHtShPWesEJftST+Xiu8r717AqP1dsk
   RvObpHowaI1gP60ZnlPos9j3r59ihHu3RJ9psSiBpqD1hEKrEz0mLYocw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="380944895"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="380944895"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 23:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="610786934"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2022 23:31:40 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRpM4-00014P-0D;
        Sat, 27 Aug 2022 06:31:40 +0000
Date:   Sat, 27 Aug 2022 14:31:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Message-ID: <202208271403.SinCnRF0-lkp@intel.com>
References: <1661554886-26025-3-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661554886-26025-3-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc2 next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dai-Ngo/NFSD-memory-shrinker-for-NFSv4-clients/20220827-070241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e022620b5d056e822e42eb9bc0f24fcb97389d86
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220827/202208271403.SinCnRF0-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8430e1a9491e9b4470a68f989a004b579e37fb73
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dai-Ngo/NFSD-memory-shrinker-for-NFSv4-clients/20220827-070241
        git checkout 8430e1a9491e9b4470a68f989a004b579e37fb73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/nfsd/trace.c:4:
   In file included from fs/nfsd/trace.h:488:
   In file included from fs/nfsd/state.h:42:
>> fs/nfsd/nfsd.h:513:72: error: expected ';' after return statement
   static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0 };
                                                                          ^
                                                                          ;
   1 error generated.
--
   In file included from fs/nfsd/nfsctl.c:23:
>> fs/nfsd/nfsd.h:513:72: error: expected ';' after return statement
   static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0 };
                                                                          ^
                                                                          ;
>> fs/nfsd/nfsctl.c:1511:2: error: implicit declaration of function 'nfsd4_leases_net_shutdown' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           nfsd4_leases_net_shutdown(nn);
           ^
   fs/nfsd/nfsctl.c:1511:2: note: did you mean 'nfsd4_leases_shutdown'?
   fs/nfsd/nfsd.h:514:20: note: 'nfsd4_leases_shutdown' declared here
   static inline void nfsd4_leases_shutdown(struct nfsd_net *nn) { };
                      ^
   2 errors generated.
--
   In file included from fs/nfsd/export.c:21:
>> fs/nfsd/nfsd.h:513:72: error: expected ';' after return statement
   static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0 };
                                                                          ^
                                                                          ;
   fs/nfsd/export.c:979:17: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
           struct inode            *inode;
                                    ^
   1 warning and 1 error generated.
--
   In file included from fs/nfsd/trace.c:4:
   In file included from fs/nfsd/trace.h:488:
   In file included from fs/nfsd/state.h:42:
>> fs/nfsd/nfsd.h:513:72: error: expected ';' after return statement
   static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0 };
                                                                          ^
                                                                          ;
   In file included from fs/nfsd/trace.c:4:
   In file included from fs/nfsd/trace.h:1407:
   include/trace/define_trace.h:95:10: fatal error: './trace.h' file not found
   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:90:32: note: expanded from macro 'TRACE_INCLUDE'
   # define TRACE_INCLUDE(system) __TRACE_INCLUDE(system)
                                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:87:34: note: expanded from macro '__TRACE_INCLUDE'
   # define __TRACE_INCLUDE(system) __stringify(TRACE_INCLUDE_PATH/system.h)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stringify.h:10:27: note: expanded from macro '__stringify'
   #define __stringify(x...)       __stringify_1(x)
                                   ^~~~~~~~~~~~~~~~
   include/linux/stringify.h:9:29: note: expanded from macro '__stringify_1'
   #define __stringify_1(x...)     #x
                                   ^~
   <scratch space>:56:1: note: expanded from here
   "./trace.h"
   ^~~~~~~~~~~
   2 errors generated.


vim +513 fs/nfsd/nfsd.h

   512	
 > 513	static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0 };
   514	static inline void nfsd4_leases_shutdown(struct nfsd_net *nn) { };
   515	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
