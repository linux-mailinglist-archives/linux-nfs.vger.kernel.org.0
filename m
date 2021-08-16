Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B063EDDE4
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 21:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhHPT3J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 15:29:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:30843 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhHPT3F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Aug 2021 15:29:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="214077066"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="gz'50?scan'50,208,50";a="214077066"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 12:28:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="gz'50?scan'50,208,50";a="448799735"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2021 12:28:31 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFiHe-000QsD-Bm; Mon, 16 Aug 2021 19:28:30 +0000
Date:   Tue, 17 Aug 2021 03:28:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     kbuild-all@lists.01.org, daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH 7/8] lockd: don't attempt blocking locks on nfs reexports
Message-ID: <202108170352.1Qv3Tqgo-lkp@intel.com>
References: <1629122367-18541-8-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <1629122367-18541-8-git-send-email-bfields@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bruce,

I love your patch! Yet something to improve:

[auto build test ERROR on nfs/linux-next]
[also build test ERROR on linus/master v5.14-rc6 next-20210816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/J-Bruce-Fields/reexport-lock-fixes-v2/20210816-222314
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: arc-defconfig (attached as .config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a058b36c95ee50bc722c8077747279f6c7277edc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review J-Bruce-Fields/reexport-lock-fixes-v2/20210816-222314
        git checkout a058b36c95ee50bc722c8077747279f6c7277edc
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: fs/lockd/svclock.o: in function `nlmsvc_lock':
   svclock.c:(.text+0xb80): undefined reference to `nlmsvc_file_inode'
>> arc-elf-ld: svclock.c:(.text+0xb80): undefined reference to `nlmsvc_file_inode'
   arc-elf-ld: fs/lockd/svcsubs.o: in function `nlmsvc_match_sb':
   svcsubs.c:(.text+0x5a): undefined reference to `nlmsvc_file_inode'
   arc-elf-ld: svcsubs.c:(.text+0x5a): undefined reference to `nlmsvc_file_inode'
   arc-elf-ld: fs/lockd/svcsubs.o: in function `nlmsvc_unlock_all_by_sb':
   svcsubs.c:(.text+0x16e): undefined reference to `nlmsvc_file_inode'
   arc-elf-ld: fs/lockd/svcsubs.o:svcsubs.c:(.text+0x16e): more undefined references to `nlmsvc_file_inode' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Q68bSM7Ycu6FN28Q--
