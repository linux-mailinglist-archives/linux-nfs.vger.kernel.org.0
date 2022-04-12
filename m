Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14FE4FDB08
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350417AbiDLIaF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352705AbiDLHOQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 03:14:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7976730553
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649746504; x=1681282504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zmCpj8ynDZLqsmvzje1fDzRmNjzoE1Dkam6S5/Xi3zY=;
  b=g/NvC25PlHoORBMaFd/uDTV1e5F7aheloGWpXQqHzy16ZOvtLI46vcUu
   n6OmVwgoJtqYXgOncBweFpfbz+aPWT5QWPzKHphsZtckYy8bVCly67fmS
   ETj4BMTIqkl3nwsSIo8VyXUVwqciJm//Fj6wvy3D0ccIMXs90UCVxDynh
   Q6xn1l4THHGaUmIp6iUWSIYe8ghV8L1nuNDhieZ6z6ZeDUWiVj6wVp+Ha
   e589wj21BJvgQviJupQCMHQvNMBtjXSo6QkPDYV+6VnnDURS6DrbFxBOf
   AyIZTDQs7v3cThAf+cHhwhepNJSbAb7bCuw79H5RB08ppGwrj5YrLVRRv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242879191"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242879191"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="724315235"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2022 23:55:01 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neAQX-0002b2-71;
        Tue, 12 Apr 2022 06:55:01 +0000
Date:   Tue, 12 Apr 2022 14:54:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-nfs@vger.kernel.org
Subject: [trondmy-nfs:testing 107/109] fs/nfs/file.c:642:6: warning: variable
 'written' is used uninitialized whenever 'if' condition is true
Message-ID: <202204121438.tlkzeoSx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git testing
head:   b9d284d92b8b0f614c96193391741893d3680c89
commit: bf5e5c86c50f9dbbda976beb6d59bfac31302f5e [107/109] NFS: Don't report ENOSPC write errors twice
config: i386-randconfig-a003-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121438.tlkzeoSx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add trondmy-nfs git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
        git fetch --no-tags trondmy-nfs testing
        git checkout bf5e5c86c50f9dbbda976beb6d59bfac31302f5e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/nfs/file.c:642:6: warning: variable 'written' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (result <= 0)
               ^~~~~~~~~~~
   fs/nfs/file.c:679:50: note: uninitialized use occurs here
           nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
                                                           ^~~~~~~
   fs/nfs/file.c:642:2: note: remove the 'if' if its condition is always false
           if (result <= 0)
           ^~~~~~~~~~~~~~~~
   fs/nfs/file.c:606:25: note: initialize the variable 'written' to silence this warning
           ssize_t result, written;
                                  ^
                                   = 0
   1 warning generated.


vim +642 fs/nfs/file.c

94387fb1aa16ee Trond Myklebust    2007-07-22  600  
edaf43694898c5 Al Viro            2014-04-03  601  ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
^1da177e4c3f41 Linus Torvalds     2005-04-16  602  {
6de1472f1a4a3b Al Viro            2013-09-16  603  	struct file *file = iocb->ki_filp;
6de1472f1a4a3b Al Viro            2013-09-16  604  	struct inode *inode = file_inode(file);
ed7bcdb374d20f Trond Myklebust    2021-02-12  605  	unsigned int mntflags = NFS_SERVER(inode)->flags;
ed7bcdb374d20f Trond Myklebust    2021-02-12  606  	ssize_t result, written;
ce368536dd6144 Scott Mayhew       2020-08-01  607  	errseq_t since;
ce368536dd6144 Scott Mayhew       2020-08-01  608  	int error;
^1da177e4c3f41 Linus Torvalds     2005-04-16  609  
6de1472f1a4a3b Al Viro            2013-09-16  610  	result = nfs_key_timeout_notify(file, inode);
dc24826bfca8d7 Andy Adamson       2013-08-14  611  	if (result)
dc24826bfca8d7 Andy Adamson       2013-08-14  612  		return result;
dc24826bfca8d7 Andy Adamson       2013-08-14  613  
89698b24d24f9c Trond Myklebust    2016-06-23  614  	if (iocb->ki_flags & IOCB_DIRECT)
64158668ac8b31 NeilBrown          2022-03-07  615  		return nfs_file_direct_write(iocb, from, false);
^1da177e4c3f41 Linus Torvalds     2005-04-16  616  
619d30b4b8c488 Al Viro            2014-03-04  617  	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
18290650b1c865 Trond Myklebust    2016-06-23  618  		file, iov_iter_count(from), (long long) iocb->ki_pos);
^1da177e4c3f41 Linus Torvalds     2005-04-16  619  
^1da177e4c3f41 Linus Torvalds     2005-04-16  620  	if (IS_SWAPFILE(inode))
^1da177e4c3f41 Linus Torvalds     2005-04-16  621  		goto out_swapfile;
7d52e86274e09f Trond Myklebust    2005-06-22  622  	/*
7d52e86274e09f Trond Myklebust    2005-06-22  623  	 * O_APPEND implies that we must revalidate the file length.
7d52e86274e09f Trond Myklebust    2005-06-22  624  	 */
fc9dc401899ab2 Trond Myklebust    2021-02-08  625  	if (iocb->ki_flags & IOCB_APPEND || iocb->ki_pos > i_size_read(inode)) {
6de1472f1a4a3b Al Viro            2013-09-16  626  		result = nfs_revalidate_file_size(inode, file);
^1da177e4c3f41 Linus Torvalds     2005-04-16  627  		if (result)
bf5e5c86c50f9d Trond Myklebust    2022-04-09  628  			return result;
fe51beecc55d0b Trond Myklebust    2005-06-22  629  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  630  
28aa2f9e73e762 Trond Myklebust    2021-02-08  631  	nfs_clear_invalid_mapping(file->f_mapping);
28aa2f9e73e762 Trond Myklebust    2021-02-08  632  
ce368536dd6144 Scott Mayhew       2020-08-01  633  	since = filemap_sample_wb_err(file->f_mapping);
a5864c999de670 Trond Myklebust    2016-06-03  634  	nfs_start_io_write(inode);
18290650b1c865 Trond Myklebust    2016-06-23  635  	result = generic_write_checks(iocb, from);
18290650b1c865 Trond Myklebust    2016-06-23  636  	if (result > 0) {
18290650b1c865 Trond Myklebust    2016-06-23  637  		current->backing_dev_info = inode_to_bdi(inode);
18290650b1c865 Trond Myklebust    2016-06-23  638  		result = generic_perform_write(file, from, iocb->ki_pos);
18290650b1c865 Trond Myklebust    2016-06-23  639  		current->backing_dev_info = NULL;
18290650b1c865 Trond Myklebust    2016-06-23  640  	}
a5864c999de670 Trond Myklebust    2016-06-03  641  	nfs_end_io_write(inode);
18290650b1c865 Trond Myklebust    2016-06-23 @642  	if (result <= 0)
^1da177e4c3f41 Linus Torvalds     2005-04-16  643  		goto out;
^1da177e4c3f41 Linus Torvalds     2005-04-16  644  
c49edecd513693 Trond Myklebust    2016-09-03  645  	written = result;
18290650b1c865 Trond Myklebust    2016-06-23  646  	iocb->ki_pos += written;
ed7bcdb374d20f Trond Myklebust    2021-02-12  647  
ed7bcdb374d20f Trond Myklebust    2021-02-12  648  	if (mntflags & NFS_MOUNT_WRITE_EAGER) {
ed7bcdb374d20f Trond Myklebust    2021-02-12  649  		result = filemap_fdatawrite_range(file->f_mapping,
ed7bcdb374d20f Trond Myklebust    2021-02-12  650  						  iocb->ki_pos - written,
ed7bcdb374d20f Trond Myklebust    2021-02-12  651  						  iocb->ki_pos - 1);
ed7bcdb374d20f Trond Myklebust    2021-02-12  652  		if (result < 0)
ed7bcdb374d20f Trond Myklebust    2021-02-12  653  			goto out;
ed7bcdb374d20f Trond Myklebust    2021-02-12  654  	}
ed7bcdb374d20f Trond Myklebust    2021-02-12  655  	if (mntflags & NFS_MOUNT_WRITE_WAIT) {
ed7bcdb374d20f Trond Myklebust    2021-02-12  656  		result = filemap_fdatawait_range(file->f_mapping,
ed7bcdb374d20f Trond Myklebust    2021-02-12  657  						 iocb->ki_pos - written,
ed7bcdb374d20f Trond Myklebust    2021-02-12  658  						 iocb->ki_pos - 1);
ed7bcdb374d20f Trond Myklebust    2021-02-12  659  		if (result < 0)
ed7bcdb374d20f Trond Myklebust    2021-02-12  660  			goto out;
ed7bcdb374d20f Trond Myklebust    2021-02-12  661  	}
e973b1a5999e57 tarangg@amazon.com 2017-09-07  662  	result = generic_write_sync(iocb, written);
e973b1a5999e57 tarangg@amazon.com 2017-09-07  663  	if (result < 0)
bf5e5c86c50f9d Trond Myklebust    2022-04-09  664  		return result;
bf5e5c86c50f9d Trond Myklebust    2022-04-09  665  out:
7e94d6c4ab6956 Trond Myklebust    2015-08-17  666  	/* Return error values */
ce368536dd6144 Scott Mayhew       2020-08-01  667  	error = filemap_check_wb_err(file->f_mapping, since);
bf5e5c86c50f9d Trond Myklebust    2022-04-09  668  	switch (error) {
bf5e5c86c50f9d Trond Myklebust    2022-04-09  669  	default:
bf5e5c86c50f9d Trond Myklebust    2022-04-09  670  		break;
bf5e5c86c50f9d Trond Myklebust    2022-04-09  671  	case -EDQUOT:
bf5e5c86c50f9d Trond Myklebust    2022-04-09  672  	case -EFBIG:
bf5e5c86c50f9d Trond Myklebust    2022-04-09  673  	case -ENOSPC:
bf5e5c86c50f9d Trond Myklebust    2022-04-09  674  		nfs_wb_all(inode);
bf5e5c86c50f9d Trond Myklebust    2022-04-09  675  		error = file_check_and_advance_wb_err(file);
bf5e5c86c50f9d Trond Myklebust    2022-04-09  676  		if (error < 0)
bf5e5c86c50f9d Trond Myklebust    2022-04-09  677  			result = error;
200baa2112012d Trond Myklebust    2006-12-05  678  	}
7e381172cf6e02 Chuck Lever        2010-02-01  679  	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
^1da177e4c3f41 Linus Torvalds     2005-04-16  680  	return result;
^1da177e4c3f41 Linus Torvalds     2005-04-16  681  
^1da177e4c3f41 Linus Torvalds     2005-04-16  682  out_swapfile:
^1da177e4c3f41 Linus Torvalds     2005-04-16  683  	printk(KERN_INFO "NFS: attempt to write to active swap file!\n");
89658c4d04c766 Anna Schumaker     2019-11-08  684  	return -ETXTBSY;
^1da177e4c3f41 Linus Torvalds     2005-04-16  685  }
89d77c8fa8e6d1 Bryan Schumaker    2012-07-30  686  EXPORT_SYMBOL_GPL(nfs_file_write);
^1da177e4c3f41 Linus Torvalds     2005-04-16  687  

:::::: The code at line 642 was first introduced by commit
:::::: 18290650b1c8655cfe6e0d63dd34942a037a130b NFS: Move buffered I/O locking into nfs_file_write()

:::::: TO: Trond Myklebust <trond.myklebust@primarydata.com>
:::::: CC: Trond Myklebust <trond.myklebust@primarydata.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
