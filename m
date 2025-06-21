Return-Path: <linux-nfs+bounces-12606-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC5AE2909
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A174189A4A6
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677C15C158;
	Sat, 21 Jun 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCWhDjqk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD720101F
	for <linux-nfs@vger.kernel.org>; Sat, 21 Jun 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750510978; cv=none; b=T6kwzrGgE2lb8LZqYUkNODIYYPBn1JXfXN7Y9hoMSDEvj4HJg4Tlh/nts0luZVSVbFgAT1pJ+vdwMSyo3/RRMnDkp9b5b7ZJHevUhWOwP217SZ3w8tRFiCmXvYMyjBhIHxmJkDaoQS1LFW9Yzi1XKx7Z1GQMKw9nX8Z5iX3VsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750510978; c=relaxed/simple;
	bh=bIAbaa1hcrbXGdLOCG9bBGbCTsWp6a8ZVSPoaIhtwHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGKEYR7fIv5ytd4ZtkynAzWB/W605Dzc93Dt/jK7Ah3NIMhbvYgkp+6IIrNsq0vS3GfsM7upgxxcASqiTzwV1eAFWDjnu66hcBKBbb2LIijuEx5/5bzmBrUYb5FqJ5LV0hjJnwD4D3Povd5KLw1aSaIj4uGJZgwsPP8dx9SEGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCWhDjqk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750510976; x=1782046976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bIAbaa1hcrbXGdLOCG9bBGbCTsWp6a8ZVSPoaIhtwHI=;
  b=mCWhDjqkPMqua8+aBAiTauLBs5ANQZ7MVbsSYF37JIiJdbXyNE2M9FnT
   AfvS1PmEHyc1tvKCz1vMs0kYRjkvR40r6H+sCxBkWAmA5jBHn0pPMzNz5
   YKeMm3iqVG3H/dTOpaUgcIyrxD+VuXtsVAmF1SW++dgMRniF+vXKBVaay
   niDHCERYOFfN/0r/fURoC/B1WD5SGLG69BJogRWcmmqguWharHDg9J53J
   QV92Rw/rATnh/lWGAZSauKjLKE3+pygzuhPpESSHHEZ6ZLAPSdcu75yCC
   d4jojkSO92UUzfztu4x6NSMOU6eziHmDaSYNeE+4qWdlfUJkgYVJ6gXOi
   w==;
X-CSE-ConnectionGUID: Z6ejebo8RVKFoHG/wR3o8g==
X-CSE-MsgGUID: 2+Y4EQx1STy3Oor2NkDo9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="63029294"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="63029294"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 06:02:56 -0700
X-CSE-ConnectionGUID: kMJ85cQVToG3OAaSrU6XOg==
X-CSE-MsgGUID: E/NRupenT76+Cy7GDXRLXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="150741998"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Jun 2025 06:02:52 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSxru-000Md0-14;
	Sat, 21 Jun 2025 13:02:50 +0000
Date: Sat, 21 Jun 2025 21:02:10 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: Re: [PATCH 3/3] nfsd: split nfsd_mutex into one mutex per
 net-namespace.
Message-ID: <202506212005.LpUsPRa3-lkp@intel.com>
References: <20250620233802.1453016-4-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620233802.1453016-4-neil@brown.name>

Hi NeilBrown,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on trondmy-nfs/linux-next linus/master v6.16-rc2 next-20250620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfsd-provide-proper-locking-for-all-write_-function/20250621-073955
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250620233802.1453016-4-neil%40brown.name
patch subject: [PATCH 3/3] nfsd: split nfsd_mutex into one mutex per net-namespace.
config: i386-buildonly-randconfig-003-20250621 (https://download.01.org/0day-ci/archive/20250621/202506212005.LpUsPRa3-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250621/202506212005.LpUsPRa3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506212005.LpUsPRa3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfsd/nfsctl.c:1699:3: error: cannot jump from this goto statement to its label
    1699 |                 goto err_free_msg;
         |                 ^
   fs/nfsd/nfsctl.c:1702:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1702 |         guard(mutex)(&nn->config_mutex);
         |         ^
   include/linux/cleanup.h:338:15: note: expanded from macro 'guard'
     338 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:45:1: note: expanded from here
      45 | __UNIQUE_ID_guard1097
         | ^
   fs/nfsd/nfsctl.c:1825:3: error: cannot jump from this goto statement to its label
    1825 |                 goto err_free_msg;
         |                 ^
   fs/nfsd/nfsctl.c:1829:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1829 |         guard(mutex)(&nn->config_mutex);
         |         ^
   include/linux/cleanup.h:338:15: note: expanded from macro 'guard'
     338 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:68:1: note: expanded from here
      68 | __UNIQUE_ID_guard1099
         | ^
   fs/nfsd/nfsctl.c:2044:3: error: cannot jump from this goto statement to its label
    2044 |                 goto err_free_msg;
         |                 ^
   fs/nfsd/nfsctl.c:2048:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    2048 |         guard(mutex)(&nn->config_mutex);
         |         ^
   include/linux/cleanup.h:338:15: note: expanded from macro 'guard'
     338 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:118:1: note: expanded from here
     118 | __UNIQUE_ID_guard1101
         | ^
   3 errors generated.


vim +1699 fs/nfsd/nfsctl.c

924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1677  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1678  /**
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1679   * nfsd_nl_threads_get_doit - get the number of running threads
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1680   * @skb: reply buffer
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1681   * @info: netlink metadata and command arguments
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1682   *
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1683   * Return 0 on success or a negative errno.
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1684   */
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1685  int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1686  {
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1687  	struct net *net = genl_info_net(info);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1688  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1689  	void *hdr;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1690  	int err;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1691  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1692  	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1693  	if (!skb)
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1694  		return -ENOMEM;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1695  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1696  	hdr = genlmsg_iput(skb, info);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1697  	if (!hdr) {
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1698  		err = -EMSGSIZE;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23 @1699  		goto err_free_msg;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1700  	}
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1701  
40677c06f2c6a4 NeilBrown        2025-06-21  1702  	guard(mutex)(&nn->config_mutex);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1703  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1704  	err = nla_put_u32(skb, NFSD_A_SERVER_GRACETIME,
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1705  			  nn->nfsd4_grace) ||
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1706  	      nla_put_u32(skb, NFSD_A_SERVER_LEASETIME,
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1707  			  nn->nfsd4_lease) ||
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1708  	      nla_put_string(skb, NFSD_A_SERVER_SCOPE,
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1709  			  nn->nfsd_name);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1710  	if (err)
40677c06f2c6a4 NeilBrown        2025-06-21  1711  		goto err_free_msg;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1712  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1713  	if (nn->nfsd_serv) {
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1714  		int i;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1715  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1716  		for (i = 0; i < nfsd_nrpools(net); ++i) {
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1717  			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1718  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1719  			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
60749cbe3d8ae5 NeilBrown        2024-07-15  1720  					  sp->sp_nrthreads);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1721  			if (err)
40677c06f2c6a4 NeilBrown        2025-06-21  1722  				goto err_free_msg;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1723  		}
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1724  	} else {
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1725  		err = nla_put_u32(skb, NFSD_A_SERVER_THREADS, 0);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1726  		if (err)
40677c06f2c6a4 NeilBrown        2025-06-21  1727  			goto err_free_msg;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1728  	}
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1729  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1730  	genlmsg_end(skb, hdr);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1731  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1732  	return genlmsg_reply(skb, info);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1733  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1734  err_free_msg:
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1735  	nlmsg_free(skb);
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1736  
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1737  	return err;
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1738  }
924f4fb003ba11 Lorenzo Bianconi 2024-04-23  1739  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

