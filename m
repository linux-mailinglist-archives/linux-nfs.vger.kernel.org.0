Return-Path: <linux-nfs+bounces-11788-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F113DABABE4
	for <lists+linux-nfs@lfdr.de>; Sat, 17 May 2025 20:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD83F3AEAE5
	for <lists+linux-nfs@lfdr.de>; Sat, 17 May 2025 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A21DF973;
	Sat, 17 May 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/Rc8ZiT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEEC202C30;
	Sat, 17 May 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507211; cv=none; b=b+rxd6oncXpmWXAsvFJRr2j2Wa2UYYvbkZDllDqG6uMStPOrg3dcAT5WRs+N0pRxh0UFAEWN3vUBtbx3JQ/bZRX3Xv4nJXLQNVrDPTeA2h6LXX/lH+oLFQ4Mh+gQkca2Qo7Ca5Fdg1gMPCiFXX7elrDWCBTKtvX9WwfYIjJEeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507211; c=relaxed/simple;
	bh=WKWVRy2+m4H/11NZG/n7a5Udgxg8ZMFS/sbQyU1Y3uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+ZeMvHdCowWl+vCgoHtBJX6GrPlM8wEdGAFf5zIPj/NcSvGBFEGbpm5iP5ItIuU442W1nRFHRqRWlJZHUlttnC6qkfoBjtrrbLZokhoxmoMj7uGjyPuqUl+0iFPnqhN3J6GJGrinV8usrw7CJICfGjgpvqf1jJ4LFPFObQnBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/Rc8ZiT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747507210; x=1779043210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKWVRy2+m4H/11NZG/n7a5Udgxg8ZMFS/sbQyU1Y3uI=;
  b=K/Rc8ZiTIgaiof+NC71tFPzDy91bAGdVUDn/EOhsEXJ0+KGRvEZkXt42
   Y+eHYCSKTB5s2U0cnAVac2DjjxEHK/ZRqDbo8DiYwMXe+MkougYHD6NrX
   DdzC/632s7foXHyNvrl5JxEDgFIz+dllzyTAWgpnyFMy3tRqAT4Lp+9r/
   rMMrAL1tZtp3WqXywP6J0FR8pm5PZDGzEXMtQEiUIswTnlCMZHBNHR4Ls
   15cFjSyFsl4yoAMvrTShISmtd7ZgU8hTilDVk6wtm8MZy0ToXATXXEsDx
   dPYiIp/KQrlvlfoWoWP3oKGv+71kNv+5cIChNivp85wP7tUPKpAsVB7kv
   Q==;
X-CSE-ConnectionGUID: FjlUhkqVSsSfJA0q1yWO0A==
X-CSE-MsgGUID: 6DiXwZjhT9++oc5avwnKZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="52083155"
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="52083155"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 11:40:09 -0700
X-CSE-ConnectionGUID: K48QIeBGTROHuSU/nsiaQg==
X-CSE-MsgGUID: UvIeephWRPCQMHfXINH/zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="144233359"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 May 2025 11:40:07 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGMS4-000KLP-1s;
	Sat, 17 May 2025 18:40:04 +0000
Date: Sun, 18 May 2025 02:39:26 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
Message-ID: <202505180251.Qt2Rlaed-lkp@intel.com>
References: <20250515115107.33052-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515115107.33052-3-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.15-rc6 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/nfs-create-a-kernel-keyring/20250515-205131
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250515115107.33052-3-hch%40lst.de
patch subject: [PATCH 2/2] nfs: create a kernel keyring
config: sh-sh03_defconfig (https://download.01.org/0day-ci/archive/20250518/202505180251.Qt2Rlaed-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250518/202505180251.Qt2Rlaed-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505180251.Qt2Rlaed-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: init_nfs_fs+0x18c (section: .init.text) -> exit_misc_binfmt (section: .exit.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

