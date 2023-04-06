Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21D36D9DA6
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbjDFQjR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbjDFQjQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 12:39:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9836F7DB6
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680799155; x=1712335155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RLhrMy7wRgg6njg69Hr+mSGX1C74fNM5cukPqWsViDo=;
  b=IyYp58pBcAsS3lfjMW2cKiTuqGRe+nZXQ59paEk0hejdgOUMiH0Fiyo2
   2eXR4I3xgYgOKQlTth8oEplcgDIceuzvhaD6wE+MWIG+5+0zgF6yB8MlZ
   am5BuIm5dgy6s6uaYAwTko3+Kr+SQr/Z2e7im1uvsAYpHhhfpOi6nFXJN
   OH19fvhO500j2pFFUYBaq+VtKll/QRIdLe2hCGNcd2ETyHQEoYC1pbGRG
   znvjALB963XY4+Jvj4wpkcOgFE8+xC7X4ti20SxGFnlrolEg/6p9+8YpZ
   WCJX99FNEN4IkcqPh41TinsZRPceXbpxtoyvGYVyGlNnxp6LkAwQMERL7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="429074485"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="429074485"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 09:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="811065658"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="811065658"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Apr 2023 09:39:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkSdW-000RW6-2w;
        Thu, 06 Apr 2023 16:38:58 +0000
Date:   Fri, 7 Apr 2023 00:38:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Anna.Schumaker@netapp.com, Olga.Kornievskaia@netapp.com
Subject: Re: [PATCH 3/6] NFS: add superblock sysfs entries
Message-ID: <202304070036.ohHbkfab-lkp@intel.com>
References: <706fb7c1e5bfd869165a61a51663427104567c49.1680786859.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <706fb7c1e5bfd869165a61a51663427104567c49.1680786859.git.bcodding@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
config: i386-randconfig-a004-20230403 (https://download.01.org/0day-ci/archive/20230407/202304070036.ohHbkfab-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d1dbf0643a167363732daa337b0e519f44190733
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Coddington/NFS-rename-nfs_client_kset-to-nfs_kset/20230406-221247
        git checkout d1dbf0643a167363732daa337b0e519f44190733
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304070036.ohHbkfab-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfs/sysfs.c:213:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           int ret;
               ^
   1 warning generated.


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
