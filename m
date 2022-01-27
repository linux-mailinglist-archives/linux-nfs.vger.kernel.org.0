Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DE349E543
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbiA0O42 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 09:56:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:19072 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238299AbiA0O42 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 27 Jan 2022 09:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643295388; x=1674831388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5JqBhbKZpHGhCwE817w/MTdn0iHX7bVUkxZvo78zz8I=;
  b=froeec7awCVpI7ZFeosZZKaWxkAxIaHe0GG6e2pFHBzCX7eROWSiiVPm
   y3n4ZVCzh+i/uXjOq1hO9S8zBDmq5c9d6hCKr+FOieE/8z1lXhenSg+yq
   eKqHYnNfdgWpAS1CmFXndUKol6Clmm5Vk/UN6609/mNpnZ9tnC535ayaj
   pzoYPf/H0afcgLqQXoel3qeHvkHEQwAdlH+yS48gbkPLuOlMrNeycvmPj
   rLokcWvD9SEBc4AzAxQwmL0R5eEomZ8KldrfpeHq5HM5/+VzlAIxn4Ep4
   XmK7Kh1ig6E3nBSO2rczWNGfHkCcZ+eRH43lPDAF0kEbjh7EUZ2YC9yMl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245716675"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="245716675"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 06:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="521262057"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2022 06:53:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD68y-000Mi3-8Z; Thu, 27 Jan 2022 14:53:00 +0000
Date:   Thu, 27 Jan 2022 22:51:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/4] nfsd: prepare for supporting admin-revocation of
 state
Message-ID: <202201272253.LNgeJGaJ-lkp@intel.com>
References: <164325949068.23133.18090188528073823272.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164325949068.23133.18090188528073823272.stgit@noble.brown>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NeilBrown,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc1 next-20220127]
[cannot apply to cel-2.6/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/NeilBrown/nfsd-allow-NFSv4-state-to-be-revoked/20220127-130132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
config: s390-randconfig-r004-20220126 (https://download.01.org/0day-ci/archive/20220127/202201272253.LNgeJGaJ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/36a49da0c1204b769399e692f540bf2a6332f89a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review NeilBrown/nfsd-allow-NFSv4-state-to-be-revoked/20220127-130132
        git checkout 36a49da0c1204b769399e692f540bf2a6332f89a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: fs/nfsd/nfsctl.o: in function `write_unlock_fs':
>> nfsctl.c:(.text+0x302): undefined reference to `nfsd4_revoke_states'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
