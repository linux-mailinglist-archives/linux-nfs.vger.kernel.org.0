Return-Path: <linux-nfs+bounces-13686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E69B286DE
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 22:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5FF7B8167
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 20:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6EE29B76F;
	Fri, 15 Aug 2025 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJb3AlOk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2426F44D;
	Fri, 15 Aug 2025 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288248; cv=none; b=MT83VmRL7YJxNT53B//zls0RTev9YM+oSdUDMjHUFBE4sVQmIahjNZgoSq2yv602dYWnRYcZGr5fHwoICFf/qfA1AkYAA8F5qoIOb4dPbdgCKQ+zKrmyk6DO5BNsZ4HYhXLjkuvKih63pKum5B9YatAPgqCuxen7Fa9dQ2glcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288248; c=relaxed/simple;
	bh=KdoNFM0JyALmDBeXeK9bjvyngTHO5qk2sJ3MRHhIr5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2KGvfEMNCBSwPhrQCwwdNKXDJ2LXzrjXSd/0il+YdWce6JrxYc4xM8tWNUlFL8IGUIwk+mPxPOV+tKEVXmR0ZRChBI2KRtpwberGPuAvR+I5D8X7m5Ha624454FaATMNvUdHqNlz6Uc+46G47GWrHi4+JufSFoea6/H3uVv+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJb3AlOk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755288247; x=1786824247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KdoNFM0JyALmDBeXeK9bjvyngTHO5qk2sJ3MRHhIr5Y=;
  b=IJb3AlOkwuwTKo2lScWfnVce0Lqy6O0lB2Cr+LTB74a86UVpLM27/C0o
   stH6XifF8Ezm2BreCe5VF4z0pP3h4vBbScP6QOrDb+YW4Ykg0zd0TwhGV
   IkP6ZbdkdTPWS6IAyqlO4RGSXGqvnGXCoa+FKn2xyjaNl+8F6pQeYdwjM
   Xay4SXTjdriMdwl+/wRIQzO3wbYSf3vz8qd3BcY4Az0D8vYP4FHrlW5nS
   b6pa/7O4EHkWW6l1TuIA31mS0oel9Xois5NynKc+XXdhZCwKY8I+2sD8A
   Cotzu+2FIjnBLRL2A6uwTreYJV4XOstgxTZZlYVmTAGfnWxZ33ob3M6fP
   g==;
X-CSE-ConnectionGUID: 4lWAmQuqTHK/B2aGtTZcaA==
X-CSE-MsgGUID: lthB33xtSbyt5pYTu4gsiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57716990"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57716990"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 13:04:06 -0700
X-CSE-ConnectionGUID: p62lv+19RGmetwWyYZhq1A==
X-CSE-MsgGUID: ipz8qSBhSIme0DYb3mWaXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167048938"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2025 13:04:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un0eZ-000CIy-2g;
	Fri, 15 Aug 2025 20:03:57 +0000
Date: Sat, 16 Aug 2025 04:03:19 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/8] net/handshake: Make handshake_req_cancel public
Message-ID: <202508160354.iNoLUr4h-lkp@intel.com>
References: <20250815050210.1518439-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815050210.1518439-3-alistair.francis@wdc.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on net/main net-next/main linus/master linux-nvme/for-next v6.17-rc1 next-20250815]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20250815-130804
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250815050210.1518439-3-alistair.francis%40wdc.com
patch subject: [PATCH 2/8] net/handshake: Make handshake_req_cancel public
config: arm-mps2_defconfig (https://download.01.org/0day-ci/archive/20250816/202508160354.iNoLUr4h-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160354.iNoLUr4h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160354.iNoLUr4h-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/handshake/request.c:312:6: warning: no previous prototype for function 'handshake_req_cancel' [-Wmissing-prototypes]
     312 | bool handshake_req_cancel(struct sock *sk)
         |      ^
   net/handshake/request.c:312:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     312 | bool handshake_req_cancel(struct sock *sk)
         | ^
         | static 
   1 warning generated.


vim +/handshake_req_cancel +312 net/handshake/request.c

3b3009ea8abb71 Chuck Lever 2023-04-17  300  
3b3009ea8abb71 Chuck Lever 2023-04-17  301  /**
3b3009ea8abb71 Chuck Lever 2023-04-17  302   * handshake_req_cancel - Cancel an in-progress handshake
3b3009ea8abb71 Chuck Lever 2023-04-17  303   * @sk: socket on which there is an ongoing handshake
3b3009ea8abb71 Chuck Lever 2023-04-17  304   *
3b3009ea8abb71 Chuck Lever 2023-04-17  305   * Request cancellation races with request completion. To determine
3b3009ea8abb71 Chuck Lever 2023-04-17  306   * who won, callers examine the return value from this function.
3b3009ea8abb71 Chuck Lever 2023-04-17  307   *
3b3009ea8abb71 Chuck Lever 2023-04-17  308   * Return values:
3b3009ea8abb71 Chuck Lever 2023-04-17  309   *   %true - Uncompleted handshake request was canceled
3b3009ea8abb71 Chuck Lever 2023-04-17  310   *   %false - Handshake request already completed or not found
3b3009ea8abb71 Chuck Lever 2023-04-17  311   */
3b3009ea8abb71 Chuck Lever 2023-04-17 @312  bool handshake_req_cancel(struct sock *sk)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

