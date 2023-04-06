Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF806DA5F9
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Apr 2023 00:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbjDFWt0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 18:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjDFWtZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 18:49:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253930D4
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680821364; x=1712357364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wn9GOc5k2mKwaVhqQehqkBHzZT6p9PNx/YpZAvLEs5U=;
  b=UZfJtbbl30ipMTizfGwHqQS69tFIX6/G43ADaUr8zD5KHox60AJrNXhS
   SyNcDW9HNAJnIrOtvhHX3EZ+fCQ80iuEFFLLGyvr7EySe3vtGvJEqRqpR
   Gol6L8XqDWnV5xUbLHA9YbEaEGu4ZrpVCLvzlT5OKVfifjv9iJNQOZ2t4
   DhCIceh0kzIQAokkhqqAn3QzRkPi9Vc/3o5g3WvoO0Rl5tBEAprWg96BD
   oyCZ/8jUdDQHj4rElFhzq+jeroqnEvqdEyS/pXW1YIx+StBHLgvG0A6Oa
   Bh358b1BTqU4+OFiS/bdAxnb8ze9CfC3hGJNZLb4a6aqi0G2iLEaxB9qn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="326932088"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="326932088"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 15:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="719869072"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="719869072"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2023 15:49:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkYPs-000Rsu-2P;
        Thu, 06 Apr 2023 22:49:16 +0000
Date:   Fri, 7 Apr 2023 06:48:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Anna.Schumaker@netapp.com,
        Olga.Kornievskaia@netapp.com
Subject: Re: [PATCH 2/6] NFS: rename nfs_client_kobj to nfs_net_kobj
Message-ID: <202304070607.zNXFIg0W-lkp@intel.com>
References: <75aec6f877a89c63478073861cf277bbfcb90453.1680786859.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75aec6f877a89c63478073861cf277bbfcb90453.1680786859.git.bcodding@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/75aec6f877a89c63478073861cf277bbfcb90453.1680786859.git.bcodding%40redhat.com
patch subject: [PATCH 2/6] NFS: rename nfs_client_kobj to nfs_net_kobj
config: i386-randconfig-s001-20230403 (https://download.01.org/0day-ci/archive/20230407/202304070607.zNXFIg0W-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/27e42c94f90782f5d27b8de8e18d701e99764a03
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Coddington/NFS-rename-nfs_client_kset-to-nfs_kset/20230406-221247
        git checkout 27e42c94f90782f5d27b8de8e18d701e99764a03
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304070607.zNXFIg0W-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/nfs/sysfs.c:20:16: sparse: sparse: symbol 'nfs_net_kobj' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
