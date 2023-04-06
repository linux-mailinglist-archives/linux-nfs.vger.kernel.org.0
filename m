Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6D6D9DA5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 18:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjDFQjI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 12:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbjDFQjH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 12:39:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5104C6593
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680799146; x=1712335146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kp5hcyRdxrReD/7Zic9IvJnFPjbjTfMEc3cu8E9UFzg=;
  b=nfnTkB02+9yVfsICzmgyDryqRmGWGiPhLVEd9vechNnhQdPeA2lFcrmf
   kb6dNsYh9EQlEzDEH4H3Atj4nzQsKC5+VVvn83IHzGDhvOfE67gj2/fzG
   IbzDJ4R3T0zG+mHzHECpPpiy4Dj0UQumGff3A+wdQPwH6NjOStmbKbhHg
   A4kIDF5k43deUNhJgamhZGqjileJnjk2OztM/Kshs087JYqyHzkchpxPc
   vwZVotNrPGGxA4UQJJtk4qQbVLxa6vp+w17T8Ggv1f7ZsI+HR9vtAZmo7
   /k4ypgb37iILtSG1IDIgDgCKuK1aZBUqQl7b5W+SNJ0HFVz55DqA61Owu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="322430931"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="322430931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 09:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="933273528"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="933273528"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Apr 2023 09:39:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkSdW-000RW8-30;
        Thu, 06 Apr 2023 16:38:58 +0000
Date:   Fri, 7 Apr 2023 00:38:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Anna.Schumaker@netapp.com,
        Olga.Kornievskaia@netapp.com
Subject: Re: [PATCH 3/6] NFS: add superblock sysfs entries
Message-ID: <202304070050.prAZXGm5-lkp@intel.com>
References: <706fb7c1e5bfd869165a61a51663427104567c49.1680786859.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <706fb7c1e5bfd869165a61a51663427104567c49.1680786859.git.bcodding@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.3-rc5 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/NFS-rename-nfs_client_kset-to-nfs_kset/20230406-221247
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/706fb7c1e5bfd869165a61a51663427104567c49.1680786859.git.bcodding%40redhat.com
patch subject: [PATCH 3/6] NFS: add superblock sysfs entries
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230407/202304070050.prAZXGm5-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d1dbf0643a167363732daa337b0e519f44190733
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Coddington/NFS-rename-nfs_client_kset-to-nfs_kset/20230406-221247
        git checkout d1dbf0643a167363732daa337b0e519f44190733
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304070050.prAZXGm5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nfs/sysfs.c: In function 'nfs_sysfs_add_server':
>> fs/nfs/sysfs.c:213:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     213 |         int ret;
         |             ^~~


vim +/ret +213 fs/nfs/sysfs.c

   210	
   211	void nfs_sysfs_add_server(struct nfs_server *server)
   212	{
 > 213		int ret;
   214		ret = kobject_init_and_add(&server->kobj, &nfs_sb_ktype,
   215					&nfs_kset->kobj, "server-%d", server->s_sysfs_id);
   216	}
   217	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
