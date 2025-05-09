Return-Path: <linux-nfs+bounces-11619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A003CAB116E
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 13:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4FF17EB5D
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A328D82F;
	Fri,  9 May 2025 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PG3TiC8L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE8F272E55
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788647; cv=none; b=acqlAW+/lXwAGIplhQEJ2/QDT9quYRfdRBRMuW87NyKfD8TC1OKbE2fWv6lEkW7GzEQs3y5CxJsx3sXpoAzPdnqoz3Ss1RmlRyF5oBPkz5UYeIRihNQ++sbgKk+syvD60jSVs33PQLxkWII0K4vSn9FOQeWYo97xHm45jnJaAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788647; c=relaxed/simple;
	bh=C497MzSJln+BEudKccHZvGHDpgPrALAGE20vXvzdYCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkSTfWtWm+oOS6ulCb9qxDiNiSw1o6LNNdlvH394nK1189u0GRvMreJ6N9ecTG/XbVrmOhBPgSZStHUwO6vhKbj4kTl27A/D8aG0CAtRzNc7WhEcFVbQslwTPT7zDfMKYtaspuhfASiCsWx9YBw+gNuymc+AKkkUOsRgoE5/on4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PG3TiC8L; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746788645; x=1778324645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C497MzSJln+BEudKccHZvGHDpgPrALAGE20vXvzdYCU=;
  b=PG3TiC8L+7Wi481apIt2cOJzfEY/p/5o5mjkKGjqBmvNxOSGKfVolitx
   MXatOvpLl5fzXXgOKDjQu4dy6i31GSd2KQc1zQikdYgHMni4vggGyMmTq
   tM6tpMWOmncMj1+bJy2uWuwO0OPUrWQUPQFoYg2vdj2FWy2N6z9oNtceA
   xuT18l/lB84341UHdWjZuo0PRJ3/MwqzdxyTX+elCZFIb2t80CmDaQq4L
   Nn8tYX6JX5sLW+sibVFVd7sacGDomnYf+5S9Qqv/DnPsiMiTOOGdfGINv
   HAan7eEu6bFws1gpMv4bq7F8EQer6Mk9yVIYGAM8abbPhEu4Lytq6Pymc
   g==;
X-CSE-ConnectionGUID: Ovyj4yMSTpuMl2jlIsxB1w==
X-CSE-MsgGUID: dqGxDxZWRTi0o5pFErRRKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="36241435"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="36241435"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:04:05 -0700
X-CSE-ConnectionGUID: kUcKfIBCS0iYMmyizglDiA==
X-CSE-MsgGUID: 90wzbuhcSju6vV0akIwiVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136975769"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 May 2025 04:04:02 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDLWJ-000Bz1-2y;
	Fri, 09 May 2025 11:03:59 +0000
Date: Fri, 9 May 2025 19:03:53 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: oe-kbuild-all@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/6] nfs_localio: change nfsd_file_put_local() to take a
 pointer to __rcu pointer
Message-ID: <202505091849.42eZCL5e-lkp@intel.com>
References: <20250509004852.3272120-7-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509004852.3272120-7-neil@brown.name>

Hi NeilBrown,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.15-rc5]
[cannot apply to trondmy-nfs/linux-next next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfs_localio-use-cmpxchg-to-install-new-nfs_file_localio/20250509-085046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250509004852.3272120-7-neil%40brown.name
patch subject: [PATCH 6/6] nfs_localio: change nfsd_file_put_local() to take a pointer to __rcu pointer
config: i386-buildonly-randconfig-002-20250509 (https://download.01.org/0day-ci/archive/20250509/202505091849.42eZCL5e-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505091849.42eZCL5e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505091849.42eZCL5e-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfsd/filecache.c:382: warning: Function parameter or struct member 'pnf' not described in 'nfsd_file_put_local'
>> fs/nfsd/filecache.c:382: warning: Excess function parameter 'nf' description in 'nfsd_file_put_local'


vim +382 fs/nfsd/filecache.c

65294c1f2c5e72 Jeff Layton  2019-08-18  372  
a61e147e6be6e7 Mike Snitzer 2024-09-05  373  /**
b33f7dec3a6721 Mike Snitzer 2024-11-15  374   * nfsd_file_put_local - put nfsd_file reference and arm nfsd_net_put in caller
c840b8e1f039e9 Mike Snitzer 2024-11-13  375   * @nf: nfsd_file of which to put the reference
a61e147e6be6e7 Mike Snitzer 2024-09-05  376   *
c840b8e1f039e9 Mike Snitzer 2024-11-13  377   * First save the associated net to return to caller, then put
c840b8e1f039e9 Mike Snitzer 2024-11-13  378   * the reference of the nfsd_file.
a61e147e6be6e7 Mike Snitzer 2024-09-05  379   */
c840b8e1f039e9 Mike Snitzer 2024-11-13  380  struct net *
100c0943040501 NeilBrown    2025-05-09  381  nfsd_file_put_local(struct nfsd_file __rcu **pnf)
a61e147e6be6e7 Mike Snitzer 2024-09-05 @382  {
100c0943040501 NeilBrown    2025-05-09  383  	struct nfsd_file *nf;
100c0943040501 NeilBrown    2025-05-09  384  	struct net *net = NULL;
a61e147e6be6e7 Mike Snitzer 2024-09-05  385  
100c0943040501 NeilBrown    2025-05-09  386  	nf = unrcu_pointer(xchg(pnf, NULL));
100c0943040501 NeilBrown    2025-05-09  387  	if (nf) {
100c0943040501 NeilBrown    2025-05-09  388  		net = nf->nf_net;
a61e147e6be6e7 Mike Snitzer 2024-09-05  389  		nfsd_file_put(nf);
100c0943040501 NeilBrown    2025-05-09  390  	}
c840b8e1f039e9 Mike Snitzer 2024-11-13  391  	return net;
a61e147e6be6e7 Mike Snitzer 2024-09-05  392  }
a61e147e6be6e7 Mike Snitzer 2024-09-05  393  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

