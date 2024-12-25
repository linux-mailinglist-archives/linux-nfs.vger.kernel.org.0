Return-Path: <linux-nfs+bounces-8780-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE49FC653
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 19:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08B7162BFD
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263683208;
	Wed, 25 Dec 2024 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqta5z0c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD420DF4
	for <linux-nfs@vger.kernel.org>; Wed, 25 Dec 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735150671; cv=none; b=CnphWPEM1XxeHL/PIavjyOx+8aiQ6cu8v3ntTu9GSFH2C3Fco0Rc5USXnRtHN4nffrwOlrspfKtkPJslHb8MgxsYJGW2y1/Beztuad5BSjUEIUEGMqeJuPT1xqnMew9ZJp1pWKsCAxTYbTNQKEASF3ec++sJs+5tsDURZbC0X5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735150671; c=relaxed/simple;
	bh=sv0SfwNRezfA1dAi3A/s+Y15TiwifCvBHu/dNmEmdxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GHZdbNi5K7xdG7Ug88ZRNdm25NpvClKLBiPqCj5zZeEhB1hIkIXj0OM4PYC19pJMWRD/nd7kWam5ysQckQYfR+BzEkhqnO2JsPlPOoG3eL1qFPoErkM7v4ctN8Awp2NxrQfoXDvMWYXHRcPWLJAdCgFo/m6HcF7zz8NGC5VR1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqta5z0c; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735150669; x=1766686669;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sv0SfwNRezfA1dAi3A/s+Y15TiwifCvBHu/dNmEmdxA=;
  b=nqta5z0cGEMKe9cxmnXRFgB3PTYeu8V3MGfVPtZPlPWmdZXuqnpugNtO
   947TEIDZpSfZaU9gl1DuwcuXq2r1mAGZpjF3evni5uISJ1iEIEbYL/ETq
   g1vPRESqATCQjNbJyPbfJDpDAp26hkTGHLVwDkeBXcE8VUeocr+4I1i3Q
   K4g3G1aWnP5/aEuw90tGwCr4bqNK4BOCOxcxqI6lFt5gJ2eyo4k+ykXx0
   oYrQjYJ70ER98OkGUTxkpJMTMBBcdv82IeSu9x/XOEg98f39vB71wMltw
   oHvT0i5VYZH5AM9QlbpGClEljex2E0rJ/vUcx4omSv0RNQW6P5CzJAxO/
   w==;
X-CSE-ConnectionGUID: vdSu2+gARDqJsthxo/kZrg==
X-CSE-MsgGUID: 6sM54ifkTpWOdNTd91Pg2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="46963646"
X-IronPort-AV: E=Sophos;i="6.12,264,1728975600"; 
   d="scan'208";a="46963646"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 10:17:49 -0800
X-CSE-ConnectionGUID: imsLCiM6SaK+2mS9KTd+6g==
X-CSE-MsgGUID: o0zVLLTdRU2Nuy8LV/zW6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="104834465"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Dec 2024 10:17:48 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQVx3-00024K-0n;
	Wed, 25 Dec 2024 18:17:45 +0000
Date: Thu, 26 Dec 2024 02:17:28 +0800
From: kernel test robot <lkp@intel.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [trondmy-nfs:testing 3/3] net/sunrpc/debugfs.c:78:21: sparse:
 sparse: cast removes address space '__rcu' of expression
Message-ID: <202412260244.W95nZtZp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git testing
head:   12e66773269367f89700972348d41910369b60f4
commit: 12e66773269367f89700972348d41910369b60f4 [3/3] SUNRPC: display total RPC tasks for RPC client
config: sh-randconfig-r111-20241225 (https://download.01.org/0day-ci/archive/20241226/202412260244.W95nZtZp-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241226/202412260244.W95nZtZp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412260244.W95nZtZp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/sunrpc/debugfs.c:78:21: sparse: sparse: cast removes address space '__rcu' of expression
--
>> net/sunrpc/clnt.c:3332:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/sunrpc/clnt.c: note: in included file (through include/linux/module.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +/__rcu +78 net/sunrpc/debugfs.c

    70	
    71	static void
    72	tasks_stop(struct seq_file *f, void *v)
    73		__releases(&clnt->cl_lock)
    74	{
    75		struct rpc_clnt *clnt = f->private;
    76		spin_unlock(&clnt->cl_lock);
    77		seq_printf(f, "clnt[%pISpc] RPC tasks[%d]\n",
  > 78			   (struct sockaddr *)&clnt->cl_xprt->addr,
    79			   atomic_read(&clnt->cl_task_count));
    80	}
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

