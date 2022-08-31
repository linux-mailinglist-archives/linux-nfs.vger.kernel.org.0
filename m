Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE25A73F0
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 04:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiHaCfx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 22:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHaCfw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 22:35:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3631E9C2C5
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 19:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661913351; x=1693449351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MAEtyRwljSEBgoe735hS0JTGnHILBQuu7FiQrC/r7Os=;
  b=n04hoHz2WdvLRzHSHHSijrhBDBzLbitRMzYZpdsdEagQSQleTiIQApIO
   VDcy6VVjQPJFxym4z67b3gwS9sk5Kzkwpt6N5aZOgsSQdnHYAIvaCPYPS
   wpnhjV4r2x9r7nclWkNEVAG6N791DDc7UbJrQsS3orXgN8LuUYLVT9bBt
   flaLB6KZTeY9c+OMrWGpJR50ZTVEOGtVrNIJQk/70QR61jHts0zKHu6k2
   OppdOSUP47Ovpzo1Vhzgw5OU0JDIoYwL0iiEjcGZBK7VpaLz99uzcGXZz
   +H+aZ2iieAQ9rCA+VoCEMAGavvbuwrg4ruS9S2kG7pMtBobBtpGlUsmzA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357073297"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357073297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="562891345"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 19:35:48 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTDa0-0000tn-0I;
        Wed, 31 Aug 2022 02:35:48 +0000
Date:   Wed, 31 Aug 2022 10:35:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: Re: [PATCH v3 3/3] NFS: Convert buffered read paths to use netfs
 when fscache is enabled
Message-ID: <202208311054.eXBCcm1y-lkp@intel.com>
References: <20220831005053.1287363-4-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831005053.1287363-4-dwysocha@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dave,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v6.0-rc3]
[also build test WARNING on linus/master next-20220830]
[cannot apply to trondmy-nfs/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Wysochanski/Convert-NFS-with-fscache-to-the-netfs-API/20220831-085217
base:    b90cb1053190353cc30f0fef0ef1f378ccc063c5
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220831/202208311054.eXBCcm1y-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5ac59d0573d1008c9d8856a91e4b4fd2ee61bb63
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dave-Wysochanski/Convert-NFS-with-fscache-to-the-netfs-API/20220831-085217
        git checkout 5ac59d0573d1008c9d8856a91e4b4fd2ee61bb63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/nfs/fscache.c: In function 'nfs_netfs_read_initiate':
>> fs/nfs/fscache.c:331:42: warning: variable 'sreq' set but not used [-Wunused-but-set-variable]
     331 |         struct netfs_io_subrequest      *sreq;
         |                                          ^~~~
   fs/nfs/fscache.c: In function 'nfs_netfs_read_done':
   fs/nfs/fscache.c:346:42: warning: variable 'sreq' set but not used [-Wunused-but-set-variable]
     346 |         struct netfs_io_subrequest      *sreq;
         |                                          ^~~~


vim +/sreq +331 fs/nfs/fscache.c

   327	
   328	void nfs_netfs_read_initiate(struct nfs_pgio_header *hdr)
   329	{
   330		struct nfs_netfs_io_data        *netfs = hdr->netfs;
 > 331		struct netfs_io_subrequest      *sreq;
   332	
   333		if (!netfs)
   334			return;
   335	
   336		sreq = netfs->sreq;
   337		spin_lock(&netfs->lock);
   338		atomic_inc(&netfs->rpcs);
   339		netfs->rpc_byte_count += hdr->args.count;
   340		spin_unlock(&netfs->lock);
   341	}
   342	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
