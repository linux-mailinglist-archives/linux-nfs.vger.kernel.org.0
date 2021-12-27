Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AF4480319
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 18:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhL0R6f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 12:58:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:62526 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhL0R6f (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Dec 2021 12:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640627915; x=1672163915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NkjbsmiVmuHzXY7F0rRZhYetn0NtusHxc19MkfdVzHs=;
  b=G6nqYnbaDHie0vUE9UZZhZo1q1GuKCikbQskVt3VlH5+zcgMdFnn39Ix
   y9Qia77i6IgQKpOzqpo0Yfher4MwdWQBkUxxCpyPMRSTCJFyPkoMGbCVM
   TuwTd+JsAn9dcVMD6NOD1rVQU+ZuBrlpo53yHHadNZIVa7iF8a9WUaI5a
   Q1RgKWOVkNvLzPiMatG9jBDhgBNaTx0e8DRSCB44fOJfiW/EngixbeQfn
   JnxUw0f3jdeYgUJGbgSMMBQh61x+pXhfOtV7ERhCppHG+mmnFic9wGz2O
   Sx6gch2ZJVuqVOuAI5id4QUbi0sKL+rsBEcrTjV4U8n/51PYaOVP7hRtP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="241465131"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="241465131"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 09:58:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="618517709"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Dec 2021 09:58:32 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1uGW-0006fj-1i; Mon, 27 Dec 2021 17:58:32 +0000
Date:   Tue, 28 Dec 2021 01:58:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, kernel@openvz.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs4: handle async processing of F_SETLK with FL_SLEEP
Message-ID: <202112280146.yo82FThq-lkp@intel.com>
References: <3a2c6cb9-abe7-ab32-b11c-d78621361555@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a2c6cb9-abe7-ab32-b11c-d78621361555@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Vasily,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vasily-Averin/nfs4-handle-async-processing-of-F_SETLK-with-FL_SLEEP/20211227-184632
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: i386-randconfig-r005-20211227 (https://download.01.org/0day-ci/archive/20211228/202112280146.yo82FThq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 511726c64d3b6cca66f7c54d457d586aa3129f67)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7ae55d384b2f337e6630509e451c35dda45ae185
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vasily-Averin/nfs4-handle-async-processing-of-F_SETLK-with-FL_SLEEP/20211227-184632
        git checkout 7ae55d384b2f337e6630509e451c35dda45ae185
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/nfs/nfs4proc.c:7202:25: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
           if ((request->fl_flags && FL_SLEEP) && IS_SETLK(cmd))
                                  ^  ~~~~~~~~
   fs/nfs/nfs4proc.c:7202:25: note: use '&' for a bitwise operation
           if ((request->fl_flags && FL_SLEEP) && IS_SETLK(cmd))
                                  ^~
                                  &
   fs/nfs/nfs4proc.c:7202:25: note: remove constant to silence this warning
           if ((request->fl_flags && FL_SLEEP) && IS_SETLK(cmd))
                                 ~^~~~~~~~~~~
   1 warning generated.


vim +7202 fs/nfs/nfs4proc.c

  7193	
  7194	static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
  7195	{
  7196		struct nfs_inode *nfsi = NFS_I(state->inode);
  7197		struct nfs4_state_owner *sp = state->owner;
  7198		unsigned char fl_flags = request->fl_flags;
  7199		int status;
  7200	
  7201		request->fl_flags |= FL_ACCESS;
> 7202		if ((request->fl_flags && FL_SLEEP) && IS_SETLK(cmd))
  7203			status = posix_lock_file(request->fl_file, request, NULL);
  7204		else
  7205			status = locks_lock_inode_wait(state->inode, request);
  7206		if (status)
  7207			goto out;
  7208		mutex_lock(&sp->so_delegreturn_mutex);
  7209		down_read(&nfsi->rwsem);
  7210		if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
  7211			/* Yes: cache locks! */
  7212			/* ...but avoid races with delegation recall... */
  7213			request->fl_flags = fl_flags & ~FL_SLEEP;
  7214			status = locks_lock_inode_wait(state->inode, request);
  7215			up_read(&nfsi->rwsem);
  7216			mutex_unlock(&sp->so_delegreturn_mutex);
  7217			goto out;
  7218		}
  7219		up_read(&nfsi->rwsem);
  7220		mutex_unlock(&sp->so_delegreturn_mutex);
  7221		status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
  7222	out:
  7223		request->fl_flags = fl_flags;
  7224		return status;
  7225	}
  7226	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
