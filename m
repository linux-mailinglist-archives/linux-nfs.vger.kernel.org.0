Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F3E5AA5F9
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 04:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiIBClI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 22:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiIBCkw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 22:40:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6966F5A2D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 19:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662086450; x=1693622450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tkRhackqcBoDUoGYtT8zvKygna2iGqVs+szsvAB8SRI=;
  b=D+OhZrg4d5DrmCNxg6qdW6k1kWgfcgpkM5FwE4yi+GBB0t23Fw0Y52Wg
   6gGD+UwO+0letlPslUXc6p6YCAolq+O3qD/Qu44WePGL2936cmnKd/yds
   KZif9R/KIUsmzdskPoZHV8mRxt2Mj3BAJouKbRlmml9wThckyQFB1iBnJ
   CVhN/3s7BoP0WdzrFKoJSOeIe9Fa3DMJD7wXxOrBX+bcGzaAxB0aD5bRu
   +9Vq1QqejyhlOzXwuFZkwaYSLDUi0LQwjIsFDNTkFmIMWN/Mb4whn0vdQ
   El2apOaZR94K5BSov0xUz/Pl7EiwWMAFOhWpP+DMPAySjrogKfbpLZA1f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282862965"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="282862965"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 19:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="612783266"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 19:40:47 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTwbv-00001k-0i;
        Fri, 02 Sep 2022 02:40:47 +0000
Date:   Fri, 2 Sep 2022 10:39:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com
Cc:     kbuild-all@lists.01.org, anna@kernel.org, cuiyue-fnst@fujitsu.com
Subject: Re: [PATCH v3] NFSv4.2: Update mode bits after ALLOCATE and
 DEALLOCATE
Message-ID: <202209021046.JT3dSTuK-lkp@intel.com>
References: <20220901191927.1582107-1-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901191927.1582107-1-anna@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,

I love your patch! Perhaps something to improve:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anna-Schumaker/NFSv4-2-Update-mode-bits-after-ALLOCATE-and-DEALLOCATE/20220902-032035
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220902/202209021046.JT3dSTuK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8a722317bde651cf6fa29c7c618ddcce4e52b4e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anna-Schumaker/NFSv4-2-Update-mode-bits-after-ALLOCATE-and-DEALLOCATE/20220902-032035
        git checkout 8a722317bde651cf6fa29c7c618ddcce4e52b4e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/nfs/nfs42proc.c: In function '_nfs42_proc_fallocate':
>> fs/nfs/nfs42proc.c:59:22: warning: unused variable 'invalid' [-Wunused-variable]
      59 |         unsigned int invalid = 0;
         |                      ^~~~~~~


vim +/invalid +59 fs/nfs/nfs42proc.c

    43	
    44	static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
    45			struct nfs_lock_context *lock, loff_t offset, loff_t len)
    46	{
    47		struct inode *inode = file_inode(filep);
    48		struct nfs_server *server = NFS_SERVER(inode);
    49		u32 bitmask[NFS_BITMASK_SZ];
    50		struct nfs42_falloc_args args = {
    51			.falloc_fh	= NFS_FH(inode),
    52			.falloc_offset	= offset,
    53			.falloc_length	= len,
    54			.falloc_bitmask	= bitmask,
    55		};
    56		struct nfs42_falloc_res res = {
    57			.falloc_server	= server,
    58		};
  > 59		unsigned int invalid = 0;
    60		int status;
    61	
    62		msg->rpc_argp = &args;
    63		msg->rpc_resp = &res;
    64	
    65		status = nfs4_set_rw_stateid(&args.falloc_stateid, lock->open_context,
    66				lock, FMODE_WRITE);
    67		if (status) {
    68			if (status == -EAGAIN)
    69				status = -NFS4ERR_BAD_STATEID;
    70			return status;
    71		}
    72	
    73		nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask, inode,
    74				 NFS_INO_INVALID_BLOCKS);
    75	
    76		res.falloc_fattr = nfs_alloc_fattr();
    77		if (!res.falloc_fattr)
    78			return -ENOMEM;
    79	
    80		status = nfs4_call_sync(server->client, server, msg,
    81					&args.seq_args, &res.seq_res, 0);
    82		if (status == 0) {
    83			if (nfs_should_remove_suid(inode)) {
    84				spin_lock(&inode->i_lock);
    85				nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
    86				spin_unlock(&inode->i_lock);
    87			}
    88			status = nfs_post_op_update_inode_force_wcc(inode,
    89								    res.falloc_fattr);
    90		}
    91		if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE])
    92			trace_nfs4_fallocate(inode, &args, status);
    93		else
    94			trace_nfs4_deallocate(inode, &args, status);
    95		kfree(res.falloc_fattr);
    96		return status;
    97	}
    98	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
