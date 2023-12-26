Return-Path: <linux-nfs+bounces-809-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCE81E7D5
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Dec 2023 15:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D9D283040
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Dec 2023 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA04F1E7;
	Tue, 26 Dec 2023 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMP1FSaz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6F4F1E1;
	Tue, 26 Dec 2023 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703600953; x=1735136953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/V03S9qZz7WWKpldGBqkQglLI2Rz0zzpO1EIYz5KXCk=;
  b=RMP1FSaz8beLz9Jy/rc+vi0ZGFzQLPejXCyeTxhKPPk1pAuXzbrO8xrO
   IYHaXMCLHHEgnAHhTUQjr7I7tktuVXwr8656GIaq25m8OT5+yovku9E8P
   E7LMagQz/tOFzZ2W56M2cDl/NoYt9T7pktmqqQhjEOkYvL3FVQSgczeib
   54KU097EKYAUGGNRKvDjKEdvRgoUfkhEaDV2Zc1+S82mU9xNjzTou2o4l
   hHxE5c0RAd6wcBAQfyzofxcFj6XDKghUNJ5NwDn1UyImyW/fDvz68mMiC
   Mmr/YI2C78hW0qZNYXtz4AcLtXe3W2+A5KvqPv//bBiIgnbEU7upZq5Rc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="396086076"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="396086076"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 06:29:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="951246591"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="951246591"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Dec 2023 06:29:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rI8Qa-000EWv-0X;
	Tue, 26 Dec 2023 14:29:04 +0000
Date: Tue, 26 Dec 2023 22:29:00 +0800
From: kernel test robot <lkp@intel.com>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
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
Subject: Re: [PATCH] [v2] SUNRPC: fix some memleaks in gssx_dec_option_array
Message-ID: <202312262220.LMUasLov-lkp@intel.com>
References: <20231226072021.3550114-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226072021.3550114-1-alexious@zju.edu.cn>

Hi Zhipeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhipeng-Lu/SUNRPC-fix-some-memleaks-in-gssx_dec_option_array/20231226-152422
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20231226072021.3550114-1-alexious%40zju.edu.cn
patch subject: [PATCH] [v2] SUNRPC: fix some memleaks in gssx_dec_option_array
config: i386-randconfig-012-20231226 (https://download.01.org/0day-ci/archive/20231226/202312262220.LMUasLov-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312262220.LMUasLov-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312262220.LMUasLov-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/sunrpc/auth_gss/gss_rpc_xdr.c:301:1: warning: unused label 'err' [-Wunused-label]
     301 | err:
         | ^~~~
   1 warning generated.


vim +/err +301 net/sunrpc/auth_gss/gss_rpc_xdr.c

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
   269				err = -ENOSPC;
   270				goto free_creds;
   271			}
   272	
   273			length = be32_to_cpup(p);
   274			p = xdr_inline_decode(xdr, length);
   275			if (unlikely(p == NULL)) {
   276				err = -ENOSPC;
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

