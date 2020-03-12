Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25EA182D98
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 11:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLK23 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 06:28:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:14344 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLK23 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Mar 2020 06:28:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 03:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="236591105"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2020 03:28:26 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jCL4j-000Asb-Ro; Thu, 12 Mar 2020 18:28:25 +0800
Date:   Thu, 12 Mar 2020 18:28:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     kbuild-all@lists.01.org, bfields@fieldses.org,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 10/14] nfsd: implement the xattr procedure functions.
Message-ID: <202003121820.IaQtjmvN%lkp@intel.com>
References: <20200311195954.27117-11-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311195954.27117-11-fllinden@amazon.com>
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

   fs/nfsd/nfs4proc.c:1541:24: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __be32 [assigned] [usertype] status @@    got e] status @@
   fs/nfsd/nfs4proc.c:1541:24: sparse:    expected restricted __be32 [assigned] [usertype] status
   fs/nfsd/nfs4proc.c:1541:24: sparse:    got int
>> fs/nfsd/nfs4proc.c:2122:13: sparse: sparse: incorrect type in assignment (different base types) @@    expected int ret @@    got restricted __int ret @@
>> fs/nfsd/nfs4proc.c:2122:13: sparse:    expected int ret
>> fs/nfsd/nfs4proc.c:2122:13: sparse:    got restricted __be32
>> fs/nfsd/nfs4proc.c:2129:16: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
>> fs/nfsd/nfs4proc.c:2129:16: sparse:    expected restricted __be32
>> fs/nfsd/nfs4proc.c:2129:16: sparse:    got int ret
   fs/nfsd/nfs4proc.c:2145:13: sparse: sparse: incorrect type in assignment (different base types) @@    expected int ret @@    got restricted __int ret @@
   fs/nfsd/nfs4proc.c:2145:13: sparse:    expected int ret
   fs/nfsd/nfs4proc.c:2145:13: sparse:    got restricted __be32
   fs/nfsd/nfs4proc.c:2148:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
   fs/nfsd/nfs4proc.c:2148:24: sparse:    expected restricted __be32
   fs/nfsd/nfs4proc.c:2148:24: sparse:    got int ret
   fs/nfsd/nfs4proc.c:2165:13: sparse: sparse: incorrect type in assignment (different base types) @@    expected int ret @@    got restricted __int ret @@
   fs/nfsd/nfs4proc.c:2165:13: sparse:    expected int ret
   fs/nfsd/nfs4proc.c:2165:13: sparse:    got restricted __be32
   fs/nfsd/nfs4proc.c:2171:16: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
   fs/nfsd/nfs4proc.c:2171:16: sparse:    expected restricted __be32
   fs/nfsd/nfs4proc.c:2171:16: sparse:    got int ret

vim +2122 fs/nfsd/nfs4proc.c

  2111	
  2112	static __be32
  2113	nfsd4_setxattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  2114		   union nfsd4_op_u *u)
  2115	{
  2116		struct nfsd4_setxattr *setxattr = &u->setxattr;
  2117		int ret;
  2118	
  2119		if (opens_in_grace(SVC_NET(rqstp)))
  2120			return nfserr_grace;
  2121	
> 2122		ret = nfsd_setxattr(rqstp, &cstate->current_fh, setxattr->setxa_name,
  2123				    setxattr->setxa_buf, setxattr->setxa_len,
  2124				    setxattr->setxa_flags);
  2125	
  2126		if (!ret)
  2127			set_change_info(&setxattr->setxa_cinfo, &cstate->current_fh);
  2128	
> 2129		return ret;
  2130	}
  2131	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
