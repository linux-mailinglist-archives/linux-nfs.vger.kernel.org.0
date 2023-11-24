Return-Path: <linux-nfs+bounces-69-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1535B7F77A2
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 16:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452C71C20FE4
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466382E859;
	Fri, 24 Nov 2023 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJHJApno"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C5A1985
	for <linux-nfs@vger.kernel.org>; Fri, 24 Nov 2023 07:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700839434; x=1732375434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aSMAd96UxnFLC2BcbLO42dfmEc4kLcDCRLdxbYcF6lk=;
  b=aJHJApnoMnUnz9cUdDDHCApLVSWQkx6+a+NfzAsIS/vYW2CBhpakrKdU
   o9wzyKEN6qkKZr/BUo/2k0KCp+N+GYoXUy+cT4vZFJsutDz/cl6Hh5e5M
   8H9MjsWWuiqOsT93k2XDMfm4Uqhmgd62odAq11Wxl1vXisZ/cM2dJ5Emf
   i74m2XT9YV2LKFXULQww2pvU6wdfqED/2G62yHSv+UXJB1zUzxQWbOozW
   gHsh4Kqx+rXFgNGVMh2I4dKZHlyEm8CRQ6YERM/QkOIadHJYmHrHakXV9
   fx3XQi7Ic1wJRQJMUhVLN7ZeDaT51hnUNqTS128kkXLn3grF1Z0mpZuaJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="5660664"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="5660664"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="16002341"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Nov 2023 07:23:52 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6Y21-0002wc-31;
	Fri, 24 Nov 2023 15:23:49 +0000
Date: Fri, 24 Nov 2023 23:23:39 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 11/11] nfsd: allow layout state to be admin-revoked.
Message-ID: <202311241708.t3tyrrzD-lkp@intel.com>
References: <20231124002925.1816-12-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124002925.1816-12-neilb@suse.de>

Hi NeilBrown,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfsd-hold-cl_lock-for-hash_delegation_locked/20231124-123723
base:   linus/master
patch link:    https://lore.kernel.org/r/20231124002925.1816-12-neilb%40suse.de
patch subject: [PATCH 11/11] nfsd: allow layout state to be admin-revoked.
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20231124/202311241708.t3tyrrzD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241708.t3tyrrzD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241708.t3tyrrzD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/nfsd/export.c:24:
>> fs/nfsd/pnfs.h:94:46: warning: 'struct nfs4_layout_stateid' declared inside parameter list will not be visible outside of this definition or declaration
      94 | static inline void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
         |                                              ^~~~~~~~~~~~~~~~~~~
   fs/nfsd/export.c: In function 'exp_rootfh':
   fs/nfsd/export.c:1016:34: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
    1016 |         struct inode            *inode;
         |                                  ^~~~~


vim +94 fs/nfsd/pnfs.h

    86	
    87	static inline void nfsd4_return_all_client_layouts(struct nfs4_client *clp)
    88	{
    89	}
    90	static inline void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
    91			struct nfs4_file *fp)
    92	{
    93	}
  > 94	static inline void nfsd4_close_layout(struct nfs4_layout_stateid *ls)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

