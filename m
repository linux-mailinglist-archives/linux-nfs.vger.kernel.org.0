Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC071829DA
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 08:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbgCLHiI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 03:38:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:11534 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387930AbgCLHiI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Mar 2020 03:38:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 00:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,543,1574150400"; 
   d="scan'208";a="277694851"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 Mar 2020 00:37:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jCIPc-0002Dq-Tb; Thu, 12 Mar 2020 15:37:48 +0800
Date:   Thu, 12 Mar 2020 15:37:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     kbuild-all@lists.01.org, bfields@fieldses.org,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/14] nfsd: define xattr functions to call in to their
 vfs counterparts
Message-ID: <202003121557.ixk2m2K3%lkp@intel.com>
References: <20200311195954.27117-7-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311195954.27117-7-fllinden@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Frank,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on nfsd/nfsd-next]
[also build test WARNING on nfs/linux-next linus/master v5.6-rc5 next-20200311]
[cannot apply to cel/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Frank-van-der-Linden/server-side-user-xattr-support-RFC-8276/20200312-064928
base:   git://linux-nfs.org/~bfields/linux.git nfsd-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-174-g094d5a94-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/nfsd/vfs.c:2102:13: sparse: sparse: incorrect type in assignment (different base types) @@    expected int err @@    got restricted __int err @@
>> fs/nfsd/vfs.c:2102:13: sparse:    expected int err
>> fs/nfsd/vfs.c:2102:13: sparse:    got restricted __be32
>> fs/nfsd/vfs.c:2104:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
>> fs/nfsd/vfs.c:2104:24: sparse:    expected restricted __be32
>> fs/nfsd/vfs.c:2104:24: sparse:    got int err
   fs/nfsd/vfs.c:2108:21: sparse: sparse: incorrect type in assignment (different base types) @@    expected int err @@    got restricted __int err @@
   fs/nfsd/vfs.c:2108:21: sparse:    expected int err
   fs/nfsd/vfs.c:2108:21: sparse:    got restricted __be32
   fs/nfsd/vfs.c:2112:16: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
   fs/nfsd/vfs.c:2112:16: sparse:    expected restricted __be32
   fs/nfsd/vfs.c:2112:16: sparse:    got int err
   fs/nfsd/vfs.c:2121:13: sparse: sparse: incorrect type in assignment (different base types) @@    expected int err @@    got restricted __int err @@
   fs/nfsd/vfs.c:2121:13: sparse:    expected int err
   fs/nfsd/vfs.c:2121:13: sparse:    got restricted __be32
   fs/nfsd/vfs.c:2123:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
   fs/nfsd/vfs.c:2123:24: sparse:    expected restricted __be32
   fs/nfsd/vfs.c:2123:24: sparse:    got int err
   fs/nfsd/vfs.c:2128:21: sparse: sparse: incorrect type in assignment (different base types) @@    expected int err @@    got restricted __int err @@
   fs/nfsd/vfs.c:2128:21: sparse:    expected int err
   fs/nfsd/vfs.c:2128:21: sparse:    got restricted __be32
   fs/nfsd/vfs.c:2132:16: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
   fs/nfsd/vfs.c:2132:16: sparse:    expected restricted __be32
   fs/nfsd/vfs.c:2132:16: sparse:    got int err
   fs/nfsd/vfs.c:2148:13: sparse: sparse: incorrect type in assignment (different base types) @@    expected int err @@    got restricted __int err @@
   fs/nfsd/vfs.c:2148:13: sparse:    expected int err
   fs/nfsd/vfs.c:2148:13: sparse:    got restricted __be32
   fs/nfsd/vfs.c:2150:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
   fs/nfsd/vfs.c:2150:24: sparse:    expected restricted __be32
   fs/nfsd/vfs.c:2150:24: sparse:    got int err
   fs/nfsd/vfs.c:2172:13: sparse: sparse: incorrect type in assignment (different base types) @@    expected int err @@    got restricted __int err @@
   fs/nfsd/vfs.c:2172:13: sparse:    expected int err
   fs/nfsd/vfs.c:2172:13: sparse:    got restricted __be32
   fs/nfsd/vfs.c:2174:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
   fs/nfsd/vfs.c:2174:24: sparse:    expected restricted __be32
   fs/nfsd/vfs.c:2174:24: sparse:    got int err

vim +2102 fs/nfsd/vfs.c

  2094	
  2095	__be32
  2096	nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
  2097		      void *buf, int *lenp)
  2098	{
  2099		ssize_t lerr;
  2100		int err;
  2101	
> 2102		err = fh_verify(rqstp, fhp, 0, NFSD_MAY_READ);
  2103		if (err)
> 2104			return err;
  2105	
  2106		lerr = vfs_getxattr(fhp->fh_dentry, name, buf, *lenp);
  2107		if (lerr < 0)
  2108			err = nfsd_xattr_errno(lerr);
  2109		else
  2110			*lenp = lerr;
  2111	
  2112		return err;
  2113	}
  2114	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
