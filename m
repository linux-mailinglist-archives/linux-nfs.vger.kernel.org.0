Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59377DC375
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 01:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjJaAOX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 20:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbjJaAOW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 20:14:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA6A6
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698711260; x=1730247260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3hEw6whma9Mw9eHI+cBivqj65fCA/MyOO8qKfOkydho=;
  b=iRY/IVQ1seNCKqCymXcN3El8LSCW2CZP4dT0BXD+XwtPC8DjSXzQVZoR
   fEgze2JzrSXCQKYJ+oqHu6WmhjeJ8P1ov0YRzTC6fbKPUK7KKsLr03nYe
   lQIXaE18QE6gdA04m/GnWxWypEuGXZOjzLcQyAivwX8H2JToOnQZpRrt9
   miE55L99hMZV86tGzrvYKUjPDTPtY/3y2ZaBUKKIj260NoolzLziP5tD4
   hRF2k2qAId4hAS2OEOeroav1jToT+jIu3znq1FIL7Qh3WMmBAfXIBv/oV
   JL2eJTlfplNN1aDAAudEA2eJlI8g0vgMcSNibaoKtQtC47mpPBGmC8Bl5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="373236066"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="373236066"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 17:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1007586471"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="1007586471"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Oct 2023 17:14:17 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxcOc-000Dfz-2q;
        Tue, 31 Oct 2023 00:14:14 +0000
Date:   Tue, 31 Oct 2023 08:13:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/6] nfsd: allow admin-revoked NFSv4.0 state to be freed.
Message-ID: <202310310756.sZ0piSTX-lkp@intel.com>
References: <20231027015613.26247-4-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027015613.26247-4-neilb@suse.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NeilBrown,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6 next-20231030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfsd-prepare-for-supporting-admin-revocation-of-state/20231027-095832
base:   linus/master
patch link:    https://lore.kernel.org/r/20231027015613.26247-4-neilb%40suse.de
patch subject: [PATCH 3/6] nfsd: allow admin-revoked NFSv4.0 state to be freed.
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231031/202310310756.sZ0piSTX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310756.sZ0piSTX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310310756.sZ0piSTX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   fs/nfsd/nfs4state.c: In function 'nfsd4_revoke_states':
>> include/linux/compiler_types.h:425:45: error: call to '__compiletime_assert_955' declared with attribute error: Need native word sized stores/loads for atomicity.
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:406:25: note: in definition of macro '__compiletime_assert'
     406 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:425:9: note: in expansion of macro '_compiletime_assert'
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:428:9: note: in expansion of macro 'compiletime_assert'
     428 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:65:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      65 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   fs/nfsd/nfs4state.c:1725:41: note: in expansion of macro 'smp_store_release'
    1725 |                                         smp_store_release(&nn->nfs40_last_revoke,
         |                                         ^~~~~~~~~~~~~~~~~
   In function 'nfs40_clean_admin_revoked',
       inlined from 'nfs4_laundromat' at fs/nfsd/nfs4state.c:6304:2:
   include/linux/compiler_types.h:425:45: error: call to '__compiletime_assert_989' declared with attribute error: Need native word sized stores/loads for atomicity.
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:406:25: note: in definition of macro '__compiletime_assert'
     406 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:425:9: note: in expansion of macro '_compiletime_assert'
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:428:9: note: in expansion of macro 'compiletime_assert'
     428 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:73:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      73 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   fs/nfsd/nfs4state.c:6242:13: note: in expansion of macro 'smp_load_acquire'
    6242 |         if (smp_load_acquire(&nn->nfs40_last_revoke) == 0 ||
         |             ^~~~~~~~~~~~~~~~


vim +/__compiletime_assert_955 +425 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  411  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  412  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  413  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  414  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  415  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  416   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  417   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  418   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  419   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  420   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  421   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  422   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  423   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  424  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @425  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  426  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
