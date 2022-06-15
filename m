Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761F054BEBF
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 02:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiFOAeA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jun 2022 20:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiFOAeA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jun 2022 20:34:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284434B95;
        Tue, 14 Jun 2022 17:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655253239; x=1686789239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hGcqanuZpHzm7Jkcjrifztv7rwms6hKEm7vjoZb9GZc=;
  b=ZgwfLcrBaQsC5d+2GuN5iuUFhk8fjHLf/EEDk371RK+Dctfp8jA2NiYJ
   RBoHO8kHNCHsLChR8fDUBxexP2TgCCARRG4MRsFuKNMUi39cfXCE+E2i2
   PyTOV02iEqq17pDnyh3mIZykSWmWRynHdhzkTlUwF4BN1YJ+w2T4b/zxv
   1w1FIsI6vsN6vmArIw0fsTwttBWsJ+uQkOx2L/aeD8EzEgAyqNlS4PWtC
   Y2KlpWXGKealz30GBbENCo1CdypHRA4/Mb2BlcgWmERlXdJ/oxYGl9l4i
   wdssYOUYP/8O2Zr2/TI+dGPaYP2tR4NH9fnFMgcsuAiUW1Tpf7QgL8pDD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279822856"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279822856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="686978922"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2022 17:33:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1Gyp-000MQh-Dl;
        Wed, 15 Jun 2022 00:33:55 +0000
Date:   Wed, 15 Jun 2022 08:33:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     kbuild-all@lists.01.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenxiaosong2@huawei.com,
        liuyongqiang13@huawei.com, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com
Subject: Re: [PATCH -next,v2] NFS: report and clear ENOSPC/EFBIG/EDQUOT
 writeback error on close() file
Message-ID: <202206150810.4h1FZM2Z-lkp@intel.com>
References: <20220614152817.271507-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614152817.271507-1-chenxiaosong2@huawei.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220615/202206150810.4h1FZM2Z-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f65252667ed27ca5a3e7f2182d1819d009dc98d7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review ChenXiaoSong/NFS-report-and-clear-ENOSPC-EFBIG-EDQUOT-writeback-error-on-close-file/20220614-231738
        git checkout f65252667ed27ca5a3e7f2182d1819d009dc98d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/nfs/file.c: In function 'nfs_file_flush':
>> fs/nfs/file.c:155:17: warning: ignoring return value of 'file_check_and_advance_wb_err' declared with attribute 'warn_unused_result' [-Wunused-result]
     155 |                 file_check_and_advance_wb_err(file);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +155 fs/nfs/file.c

   133	
   134	/*
   135	 * Flush all dirty pages, and check for write errors.
   136	 */
   137	static int
   138	nfs_file_flush(struct file *file, fl_owner_t id)
   139	{
   140		struct inode	*inode = file_inode(file);
   141		errseq_t since, error;
   142	
   143		dprintk("NFS: flush(%pD2)\n", file);
   144	
   145		nfs_inc_stats(inode, NFSIOS_VFSFLUSH);
   146		if ((file->f_mode & FMODE_WRITE) == 0)
   147			return 0;
   148	
   149		/* Flush writes to the server and return any errors */
   150		since = filemap_sample_wb_err(file->f_mapping);
   151		nfs_wb_all(inode);
   152		error = filemap_check_wb_err(file->f_mapping, since);
   153	
   154		if (nfs_should_clear_wb_err(error))
 > 155			file_check_and_advance_wb_err(file);
   156	
   157		return error;
   158	}
   159	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
