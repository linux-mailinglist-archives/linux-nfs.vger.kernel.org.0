Return-Path: <linux-nfs+bounces-806-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C387B81E1EA
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 18:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016991C20A87
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E152F97;
	Mon, 25 Dec 2023 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imjIsMJH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F952F89;
	Mon, 25 Dec 2023 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703527010; x=1735063010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c5WnwSj/pGFg6EsfD20VqFkZJ5FQAgS830qZCY8nWrU=;
  b=imjIsMJHj2LCpbqlwZZxZVKJLzTBuXNGsPs5w6pDuwVj5VET/5meLEw1
   PSpIT0+xa4Exxh2jv8YlLkxo/uapHus7zAYIB24otDrAjF8keTg0RPZEk
   adofO3WuLx4R4TrGgPW+h0Z5tadQgexuHqhQxvLP9foIE5gCHG3UZpff+
   aow68B08abAaVKnoLHtXBZ7cAQeTRCn1DAA4/yuRMOzEQ1f+oC5toNiUN
   J2v57s6rBjfU0pA1o1xDCZ5iLqpQ7an4CY3Ou3j8beo8hcOR0K7xAHS0i
   Arg48wv5kH0i9Cj1q22ZCqtRaD04mA9RnU0h63ILZ4La+HhriYDimLqC1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="393458090"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="393458090"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 09:56:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="781283964"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="781283964"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 25 Dec 2023 09:56:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHpB0-000DWp-2B;
	Mon, 25 Dec 2023 17:56:17 +0000
Date: Tue, 26 Dec 2023 01:53:13 +0800
From: kernel test robot <lkp@intel.com>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: oe-kbuild-all@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Simo Sorce <simo@redhat.com>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: fix some memleaks in gssx_dec_option_array
Message-ID: <202312260138.JJkoofSt-lkp@intel.com>
References: <20231224082424.3539726-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224082424.3539726-1-alexious@zju.edu.cn>

Hi Zhipeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhipeng-Lu/SUNRPC-fix-some-memleaks-in-gssx_dec_option_array/20231225-152918
base:   linus/master
patch link:    https://lore.kernel.org/r/20231224082424.3539726-1-alexious%40zju.edu.cn
patch subject: [PATCH] SUNRPC: fix some memleaks in gssx_dec_option_array
config: nios2-randconfig-r081-20231225 (https://download.01.org/0day-ci/archive/20231226/202312260138.JJkoofSt-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260138.JJkoofSt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260138.JJkoofSt-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/sunrpc/auth_gss/gss_rpc_xdr.c: In function 'gssx_dec_option_array':
>> net/sunrpc/auth_gss/gss_rpc_xdr.c:270:25: error: expected ';' before 'goto'
     270 |                         goto free_creds;
         |                         ^~~~
   net/sunrpc/auth_gss/gss_rpc_xdr.c:277:25: error: expected ';' before 'goto'
     277 |                         goto free_creds;
         |                         ^~~~
>> net/sunrpc/auth_gss/gss_rpc_xdr.c:301:1: warning: label 'err' defined but not used [-Wunused-label]
     301 | err:
         | ^~~


vim +270 net/sunrpc/auth_gss/gss_rpc_xdr.c

   228	
   229	static int gssx_dec_option_array(struct xdr_stream *xdr,
   230					 struct gssx_option_array *oa)
   231	{
   232		struct svc_cred *creds;
   233		u32 count, i;
   234		__be32 *p;
   235		int err;
   236	
   237		p = xdr_inline_decode(xdr, 4);
   238		if (unlikely(p == NULL))
   239			return -ENOSPC;
   240		count = be32_to_cpup(p++);
   241		if (!count)
   242			return 0;
   243	
   244		/* we recognize only 1 currently: CREDS_VALUE */
   245		oa->count = 1;
   246	
   247		oa->data = kmalloc(sizeof(struct gssx_option), GFP_KERNEL);
   248		if (!oa->data)
   249			return -ENOMEM;
   250	
   251		creds = kzalloc(sizeof(struct svc_cred), GFP_KERNEL);
   252		if (!creds) {
   253			err = -ENOMEM;
   254			goto free_oa;
   255		}
   256	
   257		oa->data[0].option.data = CREDS_VALUE;
   258		oa->data[0].option.len = sizeof(CREDS_VALUE);
   259		oa->data[0].value.data = (void *)creds;
   260		oa->data[0].value.len = 0;
   261	
   262		for (i = 0; i < count; i++) {
   263			gssx_buffer dummy = { 0, NULL };
   264			u32 length;
   265	
   266			/* option buffer */
   267			p = xdr_inline_decode(xdr, 4);
   268			if (unlikely(p == NULL)) {
   269				err = -ENOSPC
 > 270				goto free_creds;
   271			}
   272	
   273			length = be32_to_cpup(p);
   274			p = xdr_inline_decode(xdr, length);
   275			if (unlikely(p == NULL)) {
   276				err = -ENOSPC
   277				goto free_creds;
   278			}
   279	
   280			if (length == sizeof(CREDS_VALUE) &&
   281			    memcmp(p, CREDS_VALUE, sizeof(CREDS_VALUE)) == 0) {
   282				/* We have creds here. parse them */
   283				err = gssx_dec_linux_creds(xdr, creds);
   284				if (err)
   285					goto free_creds;
   286				oa->data[0].value.len = 1; /* presence */
   287			} else {
   288				/* consume uninteresting buffer */
   289				err = gssx_dec_buffer(xdr, &dummy);
   290				if (err)
   291					goto free_creds;
   292			}
   293		}
   294		return 0;
   295	
   296	free_creds:
   297		kfree(creds);
   298	free_oa:
   299		kfree(oa->data);
   300		oa->data = NULL;
 > 301	err:
   302		return err;
   303	}
   304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

