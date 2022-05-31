Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03E0538B35
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiEaGMD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 02:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiEaGMC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 02:12:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353DB46159
        for <linux-nfs@vger.kernel.org>; Mon, 30 May 2022 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653977520; x=1685513520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fekQ/J8nbROQkB+pG2DwAGCVJ8UWT1A/AYFz2noIobc=;
  b=evvwamiyC57y6NNEP3VJCfx6HpdZqwv4sIAQJ81JZRSueB0hW9fgwE24
   pB88IRwfQ2mSNejGalXAncnh8xyps3YfyU2XHFi6cqtbbIvV8kH3r+tPV
   RCJHtLREDmIA6xoMRFAbdI3cuXyZrIPg48DNDBX3+rxSxHWxiu9tZOtQM
   0ySzYVcDGM1ruah/2RSXROb9AgqQ1ychkN3KCXZ7l8x8r8jlwzranNvoK
   4dn2UCT3AKWu+bRbt0k0sdPIVr//4cHNyYZNaPts43tdH2zUdRHd6olV6
   KQHo3UUQzN9ry47kXoa6+YytxQn03RG/2PC8ARj+k2kFu9jSou0BxKE47
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="335809479"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="335809479"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 23:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="706429509"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2022 23:11:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvv6k-0002PO-1c;
        Tue, 31 May 2022 06:11:58 +0000
Date:   Tue, 31 May 2022 14:10:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-nfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH] nfsd: serialize filecache garbage collector
Message-ID: <202205311402.i5by7a5m-lkp@intel.com>
References: <20220530012947.16451-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530012947.16451-1-wangyugui@e16-tech.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Wang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18 next-20220527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Yugui/nfsd-serialize-filecache-garbage-collector/20220530-093218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b00ed48bb0a7c295facf9036135a573a5cdbe7de
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220531/202205311402.i5by7a5m-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://github.com/intel-lab-lkp/linux/commit/7e2af8570695784cb8a9f9a3931dc631a9077206
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wang-Yugui/nfsd-serialize-filecache-garbage-collector/20220530-093218
        git checkout 7e2af8570695784cb8a9f9a3931dc631a9077206
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/nfsd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/nfsd/filecache.c:475:10: sparse: sparse: symbol 'nfsd_file_gc_running' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
