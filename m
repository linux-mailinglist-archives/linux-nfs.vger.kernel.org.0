Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6254BF1A
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 03:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiFOBPC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jun 2022 21:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFOBPB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jun 2022 21:15:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1111837B;
        Tue, 14 Jun 2022 18:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655255700; x=1686791700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RKeRh7FOWPYcY85O4a5uEFeJmRzU0kF+CzICY4BPX9w=;
  b=ldcarWz2HrLg1+LuR86lp9K8n/H+uuLGNfGFy5MR8udyk/hzZxvM6zOr
   pWFBZzHFOGLUKe8gSCuqWvZDdSOUzTE9h1ttAb1MGhZwl3nnl0WmDajYQ
   hgYs8P72So5QZgkPJ8QMSDx0fF4RdvYGtip9JtS5vVYFtbegKanohfwST
   ScMs+B2cTVez49bJopATzWrlY1EAJBI6o91jKu0nb3d3Bo6Bs8O6VDRfR
   LG2/Ypc9Uk0U4e1LsAX0PmKoIMZzKIa+ZnlZOOJb7dAZTgUbVoNurP/H7
   q2ainmeS26/gh+1CTFtOQShkHwFF/qd+H7C8SOkwGdBmLbMrwjROPUpqJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261819765"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="261819765"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 18:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="570703360"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2022 18:14:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1HcW-000MST-Ji;
        Wed, 15 Jun 2022 01:14:56 +0000
Date:   Wed, 15 Jun 2022 09:14:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     kbuild-all@lists.01.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenxiaosong2@huawei.com,
        liuyongqiang13@huawei.com, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com
Subject: Re: [PATCH -next,v2] NFS: report and clear ENOSPC/EFBIG/EDQUOT
 writeback error on close() file
Message-ID: <202206150903.fMetZz83-lkp@intel.com>
References: <20220614152817.271507-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614152817.271507-1-chenxiaosong2@huawei.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi ChenXiaoSong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.19-rc2]
[also build test WARNING on next-20220614]
[cannot apply to trondmy-nfs/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/ChenXiaoSong/NFS-report-and-clear-ENOSPC-EFBIG-EDQUOT-writeback-error-on-close-file/20220614-231738
base:    b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220615/202206150903.fMetZz83-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f65252667ed27ca5a3e7f2182d1819d009dc98d7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review ChenXiaoSong/NFS-report-and-clear-ENOSPC-EFBIG-EDQUOT-writeback-error-on-close-file/20220614-231738
        git checkout f65252667ed27ca5a3e7f2182d1819d009dc98d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/nfs/nfs4file.c: In function 'nfs4_file_flush':
>> fs/nfs/nfs4file.c:137:17: warning: ignoring return value of 'file_check_and_advance_wb_err' declared with attribute 'warn_unused_result' [-Wunused-result]
     137 |                 file_check_and_advance_wb_err(file);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +137 fs/nfs/nfs4file.c

   108	
   109	/*
   110	 * Flush all dirty pages, and check for write errors.
   111	 */
   112	static int
   113	nfs4_file_flush(struct file *file, fl_owner_t id)
   114	{
   115		struct inode	*inode = file_inode(file);
   116		errseq_t since, error;
   117	
   118		dprintk("NFS: flush(%pD2)\n", file);
   119	
   120		nfs_inc_stats(inode, NFSIOS_VFSFLUSH);
   121		if ((file->f_mode & FMODE_WRITE) == 0)
   122			return 0;
   123	
   124		/*
   125		 * If we're holding a write delegation, then check if we're required
   126		 * to flush the i/o on close. If not, then just start the i/o now.
   127		 */
   128		if (!nfs4_delegation_flush_on_close(inode))
   129			return filemap_fdatawrite(file->f_mapping);
   130	
   131		/* Flush writes to the server and return any errors */
   132		since = filemap_sample_wb_err(file->f_mapping);
   133		nfs_wb_all(inode);
   134		error = filemap_check_wb_err(file->f_mapping, since);
   135	
   136		if (nfs_should_clear_wb_err(error))
 > 137			file_check_and_advance_wb_err(file);
   138	
   139		return error;
   140	}
   141	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
