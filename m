Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE53F478901
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhLQKeN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 05:34:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:51139 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhLQKeN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Dec 2021 05:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639737253; x=1671273253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NVNGMMi+GcP2D2tp7o/8LBJVGo1HVXYBvPe0/10EQVw=;
  b=PXhr7E1ku2b7Z87olp2mGz94qbH52i6IKb11yKOcZOLysVMzlNUeHIRv
   4mJ04bwtSdrC4PF8Ax9wpQnnvW5QJAmk6poShBq8D7JMxF5QYAbGiL88V
   JrrtpAQvY9AdsFyT77WiKdlTF5I52lfXISiI+1v0baxeQHEahnF5ITHzQ
   P0wFrk32D/ESeESydwo3OfYjBpHLfF3hRQmEJsNo15+k11r6y1mCH6fod
   ezbPgUs3xYmHrN5wPRC0UP1G/Z7Okj2wO8iC4y+Xr8Vvc5V8yeX7QDgq1
   BMtxod4eFknP4Zpllj78oCizwg/a5Ifmvv+vvSOmuVclCzUgCkM/T8aF+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300503413"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="300503413"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 02:34:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="605861172"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Dec 2021 02:34:09 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myAYz-0004bD-3w; Fri, 17 Dec 2021 10:34:09 +0000
Date:   Fri, 17 Dec 2021 18:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] Structural cleanup for filesystem-based swap
Message-ID: <202112171822.DW1WPE1G-lkp@intel.com>
References: <163969850251.20885.10819272484905153807.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850251.20885.10819272484905153807.stgit@noble.brown>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NeilBrown,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on cifs/for-next]
[also build test ERROR on axboe-block/for-next mszeredi-vfs/overlayfs-next rostedt-trace/for-next linus/master v5.16-rc5 next-20211216]
[cannot apply to trondmy-nfs/linux-next hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/NeilBrown/Repair-SWAP-over-NFS/20211217-075659
base:   git://git.samba.org/sfrench/cifs-2.6.git for-next
config: arm-randconfig-r005-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171822.DW1WPE1G-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 9043c3d65b11b442226015acfbf8167684586cfa)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/6443c9d01129c1a1c19f3df4a594b01e3772e6bd
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review NeilBrown/Repair-SWAP-over-NFS/20211217-075659
        git checkout 6443c9d01129c1a1c19f3df4a594b01e3772e6bd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/nfs/file.c:512:8: error: implicit declaration of function 'add_swap_extent' [-Werror,-Wimplicit-function-declaration]
           ret = add_swap_extent(sis, 0, sis->max, 0);
                 ^
   1 error generated.


vim +/add_swap_extent +512 fs/nfs/file.c

   486	
   487	static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
   488							sector_t *span)
   489	{
   490		unsigned long blocks;
   491		long long isize;
   492		int ret;
   493		struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
   494		struct inode *inode = file->f_mapping->host;
   495	
   496		if (!file->f_mapping->a_ops->swap_rw)
   497			/* Cannot support swap */
   498			return -EINVAL;
   499	
   500		spin_lock(&inode->i_lock);
   501		blocks = inode->i_blocks;
   502		isize = inode->i_size;
   503		spin_unlock(&inode->i_lock);
   504		if (blocks*512 < isize) {
   505			pr_warn("swap activate: swapfile has holes\n");
   506			return -EINVAL;
   507		}
   508	
   509		ret = rpc_clnt_swap_activate(clnt);
   510		if (ret)
   511			return ret;
 > 512		ret = add_swap_extent(sis, 0, sis->max, 0);
   513		if (ret < 0) {
   514			rpc_clnt_swap_deactivate(clnt);
   515			return ret;
   516		}
   517		*span = sis->pages;
   518		sis->flags |= SWP_FS_OPS;
   519		return ret;
   520	}
   521	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
