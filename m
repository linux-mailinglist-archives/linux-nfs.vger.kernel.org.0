Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805115E7264
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiIWDUn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 23:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiIWDUe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 23:20:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD898D22;
        Thu, 22 Sep 2022 20:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663903232; x=1695439232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+A/qYlJeKZBPbpBrijZ8bmcVp04W1EXYKGOTOpIgSg=;
  b=Gi8FV3eLFffWOtDGAdYIHtgN1Nao3ttnF9JKY0tRBcQR76w2Ndzi2dhy
   9yCLJ8XDqoiftlc/5kU3zIswCLbeOn1lWn2z6a6DW8QzLXHqeQSKUxrJx
   D+MgJzmqyVmT/cQ4dIFQMjfC2F/Q4HlI66ymJtIxPeqKLgdYwWdRFWs6H
   uuyu21JLk95Ba1zwb4tDBkiBXtIFdAWbY1RH7gUgQ+EU77iwY5Vsj/Bmc
   8RSzToa33AvQhBo3+uNyI+utoIVwH77O2JFhC4ZHVFs8g6Y+rU5nJRVXN
   h6g27Gr3A3NWR41VYqJ/m0hUvs7ozYh3/cRthYEMtahN3Np8MD2LDXnIv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364511569"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364511569"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 20:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="709148133"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2022 20:20:29 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obZEr-0005Gm-0Z;
        Fri, 23 Sep 2022 03:20:29 +0000
Date:   Fri, 23 Sep 2022 11:19:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     kbuild-all@lists.01.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenxiaosong2@huawei.com,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/2] NFSv4: check FMODE_EXEC from open context mode in
 nfs4_opendata_access()
Message-ID: <202209231127.Fb4Qkx0m-lkp@intel.com>
References: <20220922034905.1442056-3-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922034905.1442056-3-chenxiaosong2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi ChenXiaoSong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ChenXiaoSong/NFS-check-FMODE_EXEC-from-open-context-mode/20220922-105006
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: arm64-randconfig-s041-20220921 (https://download.01.org/0day-ci/archive/20220923/202209231127.Fb4Qkx0m-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/74ed5473611c0257ea5fe8bb5e77f19d94d02596
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review ChenXiaoSong/NFS-check-FMODE_EXEC-from-open-context-mode/20220922-105006
        git checkout 74ed5473611c0257ea5fe8bb5e77f19d94d02596
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> fs/nfs/nfs4proc.c:2638:13: sparse: sparse: restricted fmode_t degrades to integer

vim +2638 fs/nfs/nfs4proc.c

  2616	
  2617	/*
  2618	 * Additional permission checks in order to distinguish between an
  2619	 * open for read, and an open for execute. This works around the
  2620	 * fact that NFSv4 OPEN treats read and execute permissions as being
  2621	 * the same.
  2622	 * Note that in the non-execute case, we want to turn off permission
  2623	 * checking if we just created a new file (POSIX open() semantics).
  2624	 */
  2625	static int nfs4_opendata_access(const struct cred *cred,
  2626					struct nfs4_opendata *opendata,
  2627					struct nfs4_state *state, fmode_t fmode)
  2628	{
  2629		struct nfs_access_entry cache;
  2630		u32 mask, flags;
  2631	
  2632		/* access call failed or for some reason the server doesn't
  2633		 * support any access modes -- defer access call until later */
  2634		if (opendata->o_res.access_supported == 0)
  2635			return 0;
  2636	
  2637		mask = 0;
> 2638		if (fmode & __FMODE_EXEC) {
  2639			/* ONLY check for exec rights */
  2640			if (S_ISDIR(state->inode->i_mode))
  2641				mask = NFS4_ACCESS_LOOKUP;
  2642			else
  2643				mask = NFS4_ACCESS_EXECUTE;
  2644		} else if ((fmode & FMODE_READ) && !opendata->file_created)
  2645			mask = NFS4_ACCESS_READ;
  2646	
  2647		nfs_access_set_mask(&cache, opendata->o_res.access_result);
  2648		nfs_access_add_cache(state->inode, &cache, cred);
  2649	
  2650		flags = NFS4_ACCESS_READ | NFS4_ACCESS_EXECUTE | NFS4_ACCESS_LOOKUP;
  2651		if ((mask & ~cache.mask & flags) == 0)
  2652			return 0;
  2653	
  2654		return -EACCES;
  2655	}
  2656	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
