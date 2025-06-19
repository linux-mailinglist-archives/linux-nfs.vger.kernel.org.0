Return-Path: <linux-nfs+bounces-12573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F62AE05FC
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 14:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7889C18830F7
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A3229B02;
	Thu, 19 Jun 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKavyMzr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6123A9A0
	for <linux-nfs@vger.kernel.org>; Thu, 19 Jun 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336439; cv=none; b=Prcwdxhe3dDP+2s+pQ5S0nLGijwejPqVhRp3G6hRa2H4sm+qONlhFneN+4qyQH9m++fxF9yPVL/QV1vSme7xnGq/+g8d1SAfN9dZAheR7l+cwL4q7eg0q33h7KIPd0zDVXbQXmksYl9A2EQX48Uk13BuRygnLcomb4Z6rWR8Ocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336439; c=relaxed/simple;
	bh=NRGKABP8PYE5W+gDt/rlo6MJFKCxz/Agwa923Xcep/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1qlIxrjrAluQzLKKwsQaZOevG9/7KcT6rWVnhABCRjniqZkIXAbtyqlI+CEpBVjPvy56/zfbymH7NhNc8vWZYiVfapTadvi0qvtk4Jid4vpf329KTmUJqy1/ZkmsgYNREFIbDsOx71eOy1ovn2fhTP32HeD3haP3L78jk+lwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKavyMzr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750336437; x=1781872437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NRGKABP8PYE5W+gDt/rlo6MJFKCxz/Agwa923Xcep/0=;
  b=OKavyMzrkBVPcrp1LgT/k0xX4o6vIuonG3j7wyJzRPdkMHTOx+RTeY+8
   mTZAZAWRdzglRFDfJK4AhfcMaQQmIeVvOinAgxaT0Bn/0qmxhruxZ5dDp
   vrZaSvqvrSODY0+NHNaNZzGx3uAmHJf1eHO/vxETSFG6J5EEv9w8HpvoH
   i1t2BbJrfv7Mv6P/EmSe091YXLKO4af6PIVSbnfzEp5svxFa4CWK8+u6C
   aLcsIbxjLY5j1IYJjEF3UMF17lUwK6076Yh6my4RxZAGuLMjvERZDVXfX
   UfwQ+UzGXIRPNDAmCRpoFdwlUIJHsIYMPbmBkGgsC0Y0g1p/qLQeQ/qhS
   g==;
X-CSE-ConnectionGUID: SEtExOgYQSa0tuGbuNlONg==
X-CSE-MsgGUID: YKpGCKa2S9OJzCHmtKwdJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52290402"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="52290402"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 05:33:56 -0700
X-CSE-ConnectionGUID: phIflv5VSOmAOqJLXuoShg==
X-CSE-MsgGUID: hl4fN0GETZe1LcQyXGFCdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="150077947"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 19 Jun 2025 05:33:53 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSESk-000Kkg-2O;
	Thu, 19 Jun 2025 12:33:50 +0000
Date: Thu, 19 Jun 2025 20:33:49 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: Re: [PATCH 3/3] nfsd: split nfsd_mutex into one mutex per
 net-namespace.
Message-ID: <202506192052.L9tj28RJ-lkp@intel.com>
References: <20250618213347.425503-4-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618213347.425503-4-neil@brown.name>

Hi NeilBrown,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on trondmy-nfs/linux-next linus/master v6.16-rc2 next-20250619]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfsd-provide-proper-locking-for-all-write_-function/20250619-053514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250618213347.425503-4-neil%40brown.name
patch subject: [PATCH 3/3] nfsd: split nfsd_mutex into one mutex per net-namespace.
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250619/202506192052.L9tj28RJ-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250619/202506192052.L9tj28RJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506192052.L9tj28RJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfsd/nfsctl.c:1891:14: warning: variable 'nn' is uninitialized when used here [-Wuninitialized]
    1891 |         mutex_lock(&nn->nfsd_info.mutex);
         |                     ^~
   fs/nfsd/nfsctl.c:1877:21: note: initialize the variable 'nn' to silence this warning
    1877 |         struct nfsd_net *nn;
         |                            ^
         |                             = NULL
   1 warning generated.


vim +/nn +1891 fs/nfsd/nfsctl.c

  1867	
  1868	/**
  1869	 * nfsd_nl_version_get_doit - get the enabled status for all supported nfs versions
  1870	 * @skb: reply buffer
  1871	 * @info: netlink metadata and command arguments
  1872	 *
  1873	 * Return 0 on success or a negative errno.
  1874	 */
  1875	int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
  1876	{
  1877		struct nfsd_net *nn;
  1878		int i, err;
  1879		void *hdr;
  1880	
  1881		skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
  1882		if (!skb)
  1883			return -ENOMEM;
  1884	
  1885		hdr = genlmsg_iput(skb, info);
  1886		if (!hdr) {
  1887			err = -EMSGSIZE;
  1888			goto err_free_msg;
  1889		}
  1890	
> 1891		mutex_lock(&nn->nfsd_info.mutex);
  1892		nn = net_generic(genl_info_net(info), nfsd_net_id);
  1893	
  1894		for (i = 2; i <= 4; i++) {
  1895			int j;
  1896	
  1897			for (j = 0; j <= NFSD_SUPPORTED_MINOR_VERSION; j++) {
  1898				struct nlattr *attr;
  1899	
  1900				/* Don't record any versions the kernel doesn't have
  1901				 * compiled in
  1902				 */
  1903				if (!nfsd_support_version(i))
  1904					continue;
  1905	
  1906				/* NFSv{2,3} does not support minor numbers */
  1907				if (i < 4 && j)
  1908					continue;
  1909	
  1910				attr = nla_nest_start(skb,
  1911						      NFSD_A_SERVER_PROTO_VERSION);
  1912				if (!attr) {
  1913					err = -EINVAL;
  1914					goto err_nfsd_unlock;
  1915				}
  1916	
  1917				if (nla_put_u32(skb, NFSD_A_VERSION_MAJOR, i) ||
  1918				    nla_put_u32(skb, NFSD_A_VERSION_MINOR, j)) {
  1919					err = -EINVAL;
  1920					goto err_nfsd_unlock;
  1921				}
  1922	
  1923				/* Set the enabled flag if the version is enabled */
  1924				if (nfsd_vers(nn, i, NFSD_TEST) &&
  1925				    (i < 4 || nfsd_minorversion(nn, j, NFSD_TEST)) &&
  1926				    nla_put_flag(skb, NFSD_A_VERSION_ENABLED)) {
  1927					err = -EINVAL;
  1928					goto err_nfsd_unlock;
  1929				}
  1930	
  1931				nla_nest_end(skb, attr);
  1932			}
  1933		}
  1934	
  1935		mutex_unlock(&nn->nfsd_info.mutex);
  1936		genlmsg_end(skb, hdr);
  1937	
  1938		return genlmsg_reply(skb, info);
  1939	
  1940	err_nfsd_unlock:
  1941		mutex_unlock(&nn->nfsd_info.mutex);
  1942	err_free_msg:
  1943		nlmsg_free(skb);
  1944	
  1945		return err;
  1946	}
  1947	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

