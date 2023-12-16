Return-Path: <linux-nfs+bounces-671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E6815892
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 10:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB26B2341C
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C789914291;
	Sat, 16 Dec 2023 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZVZTbeA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782614A85
	for <linux-nfs@vger.kernel.org>; Sat, 16 Dec 2023 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702720403; x=1734256403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zl3Sjolw5+creF+cgklEPgJxLU1GwmW1JYWicSEeNdY=;
  b=DZVZTbeAehlQXVbrIa5niFxfMt76IMzu7y/ilgWv72ivAR0pumjUZgO8
   SF3KKW67dck4nGSlbpKhZJb1HpCW0wmATMvToXd940g8panrpoZsSLd+f
   ZNWVyiDGjPv5Gx6ZfrQNeylvF55qgl9KBj8MuNAahJ2mLygsQ4vOPUS5f
   i6893BE8mddNj/jI5JWgwM23NtEdRMd/SCAqCM+FvZQbdjuSmP/f2HqRP
   d6xtsWGhPlFYV26YEXI5BgJugczxeHM2FfJCUf0po65nSDSNB3EYsMiO/
   4t1Iro4kYJbs7TSUys6VQlst2z0PuzH5ZrUUL/1GhhMNc0Wb/Y35AmFUZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2207244"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="2207244"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 01:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="809248402"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="809248402"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2023 01:53:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rERMD-0001QU-0p;
	Sat, 16 Dec 2023 09:53:17 +0000
Date: Sat, 16 Dec 2023 17:52:45 +0800
From: kernel test robot <lkp@intel.com>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-nfs@stwm.de
Subject: Re: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Message-ID: <202312161749.eBpmnAuH-lkp@intel.com>
References: <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>

Hi Dai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dai-Ngo/SUNRPC-remove-printk-when-back-channel-request-not-found/20231216-055046
base:   linus/master
patch link:    https://lore.kernel.org/r/1702676837-31320-2-git-send-email-dai.ngo%40oracle.com
patch subject: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request not found
config: arc-defconfig (https://download.01.org/0day-ci/archive/20231216/202312161749.eBpmnAuH-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161749.eBpmnAuH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161749.eBpmnAuH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/sunrpc/svcsock.c: In function 'receive_cb_reply':
>> net/sunrpc/svcsock.c:1053:16: warning: variable 'calldir' set but not used [-Wunused-but-set-variable]
    1053 |         __be32 calldir;
         |                ^~~~~~~


vim +/calldir +1053 net/sunrpc/svcsock.c

8f55f3c0a013c4 Alexandros Batsakis 2009-08-20  1045  
586c52cc61b5b8 Trond Myklebust     2009-05-18  1046  static int receive_cb_reply(struct svc_sock *svsk, struct svc_rqst *rqstp)
4cfc7e6019caa3 Rahul Iyer          2009-09-10  1047  {
586c52cc61b5b8 Trond Myklebust     2009-05-18  1048  	struct rpc_xprt *bc_xprt = svsk->sk_xprt.xpt_bc_xprt;
4cfc7e6019caa3 Rahul Iyer          2009-09-10  1049  	struct rpc_rqst *req = NULL;
586c52cc61b5b8 Trond Myklebust     2009-05-18  1050  	struct kvec *src, *dst;
586c52cc61b5b8 Trond Myklebust     2009-05-18  1051  	__be32 *p = (__be32 *)rqstp->rq_arg.head[0].iov_base;
48e6555c7b3bf0 J. Bruce Fields     2011-02-14  1052  	__be32 xid;
48e6555c7b3bf0 J. Bruce Fields     2011-02-14 @1053  	__be32 calldir;
4cfc7e6019caa3 Rahul Iyer          2009-09-10  1054  
4cfc7e6019caa3 Rahul Iyer          2009-09-10  1055  	xid = *p++;
4cfc7e6019caa3 Rahul Iyer          2009-09-10  1056  	calldir = *p;
4cfc7e6019caa3 Rahul Iyer          2009-09-10  1057  
093a1468b6edb0 Trond Myklebust     2014-11-12  1058  	if (!bc_xprt)
586c52cc61b5b8 Trond Myklebust     2009-05-18  1059  		return -EAGAIN;
75c84151a9dc7a Trond Myklebust     2018-08-31  1060  	spin_lock(&bc_xprt->queue_lock);
093a1468b6edb0 Trond Myklebust     2014-11-12  1061  	req = xprt_lookup_rqst(bc_xprt, xid);
093a1468b6edb0 Trond Myklebust     2014-11-12  1062  	if (!req)
75b63ccc0be260 Dai Ngo             2023-12-15  1063  		goto unlock_eagain;
4cfc7e6019caa3 Rahul Iyer          2009-09-10  1064  
586c52cc61b5b8 Trond Myklebust     2009-05-18  1065  	memcpy(&req->rq_private_buf, &req->rq_rcv_buf, sizeof(struct xdr_buf));
586c52cc61b5b8 Trond Myklebust     2009-05-18  1066  	/*
586c52cc61b5b8 Trond Myklebust     2009-05-18  1067  	 * XXX!: cheating for now!  Only copying HEAD.
586c52cc61b5b8 Trond Myklebust     2009-05-18  1068  	 * But we know this is good enough for now (in fact, for any
586c52cc61b5b8 Trond Myklebust     2009-05-18  1069  	 * callback reply in the forseeable future).
586c52cc61b5b8 Trond Myklebust     2009-05-18  1070  	 */
586c52cc61b5b8 Trond Myklebust     2009-05-18  1071  	dst = &req->rq_private_buf.head[0];
586c52cc61b5b8 Trond Myklebust     2009-05-18  1072  	src = &rqstp->rq_arg.head[0];
586c52cc61b5b8 Trond Myklebust     2009-05-18  1073  	if (dst->iov_len < src->iov_len)
093a1468b6edb0 Trond Myklebust     2014-11-12  1074  		goto unlock_eagain; /* whatever; just giving up. */
586c52cc61b5b8 Trond Myklebust     2009-05-18  1075  	memcpy(dst->iov_base, src->iov_base, src->iov_len);
cc248d4b1ddf05 J. Bruce Fields     2012-12-03  1076  	xprt_complete_rqst(req->rq_task, rqstp->rq_arg.len);
586c52cc61b5b8 Trond Myklebust     2009-05-18  1077  	rqstp->rq_arg.len = 0;
75c84151a9dc7a Trond Myklebust     2018-08-31  1078  	spin_unlock(&bc_xprt->queue_lock);
586c52cc61b5b8 Trond Myklebust     2009-05-18  1079  	return 0;
093a1468b6edb0 Trond Myklebust     2014-11-12  1080  unlock_eagain:
75c84151a9dc7a Trond Myklebust     2018-08-31  1081  	spin_unlock(&bc_xprt->queue_lock);
093a1468b6edb0 Trond Myklebust     2014-11-12  1082  	return -EAGAIN;
4cfc7e6019caa3 Rahul Iyer          2009-09-10  1083  }
586c52cc61b5b8 Trond Myklebust     2009-05-18  1084  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

