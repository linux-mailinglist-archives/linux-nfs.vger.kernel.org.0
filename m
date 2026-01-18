Return-Path: <linux-nfs+bounces-18081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCBFD39756
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 16:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54FF9300304C
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEA332C94D;
	Sun, 18 Jan 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5oDbiJt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A878334692
	for <linux-nfs@vger.kernel.org>; Sun, 18 Jan 2026 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768748702; cv=none; b=qdGg5CtmApF14TpeRjeFpMCvBTqy3rNqqMSbPM5xCghd2j2iACZjcANeRoykLJyfprTcNn1Ck7eAqNhuGsonWYUo2t5YYUxpb59HJQH0hLhUNO6y1YvdDps9dEofg7KRNTKNpn11pydEuloHGaA4MK1vnpt4FAwcGr1E3ZFH8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768748702; c=relaxed/simple;
	bh=uY7oUEj43QHrenJlx7kgb8nGG0MFFIFOA1p/OYxOr2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmGLFUuenM4jGnx/zSG7L8ji8PvUBoV6l8oqQziJPssuZvW0c3XwprahTNsz/kFKbatuSOgBsZu39ID8DJhwarVcZ4lfgQzMsIshk4a85EvMlnu66P03BywsHzt1430lqifdez7mFcbztneYs7X409Dck1nPyO20OdlCUE5j1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5oDbiJt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768748699; x=1800284699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uY7oUEj43QHrenJlx7kgb8nGG0MFFIFOA1p/OYxOr2w=;
  b=M5oDbiJt66Ecx4emEXhk2VihMbcKFe1oo7HYMJBbGi4aFNbCjCQ2w5d2
   t7fxM1TK3zFxO2rwNiR08QjGB0QS+IQbn2sxLKmH1ZLWa52+yjVIDhm1p
   QhODJOWruKrimJzI+ZMzHy2KzWQmjWkdvpVmFAa5Lcl32HULCC/x0uMN2
   5Zc8SWM/uvDK6Y7A9YeRZU+/rGDhucEybfZRQB5n7a0LWvAMgKjRj5uWi
   EXnX1CMzpNsLu2O90Pr+FBRHDQdbTC8JS4rEeCNVXniDfIdG0ZrEhZpgq
   oKNNOazHefTb+/g628/zobozL/9+k/CgFNP6dIZ8GfAAs6nFv9LLo1QvP
   Q==;
X-CSE-ConnectionGUID: BWD+m6JpQXeE3V6dYSnQrQ==
X-CSE-MsgGUID: nJHNSjGOTSeibsnHDAbXsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="80701918"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="80701918"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 07:04:58 -0800
X-CSE-ConnectionGUID: jJvwc85uTiyj4SNiVy48PQ==
X-CSE-MsgGUID: XB/PaP/CSsi7iRf4ccXKbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="243216538"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Jan 2026 07:04:57 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhUKk-00000000N1g-2S6p;
	Sun, 18 Jan 2026 15:04:54 +0000
Date: Sun, 18 Jan 2026 23:04:28 +0800
From: kernel test robot <lkp@intel.com>
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: oe-kbuild-all@lists.linux.dev, anna@kernel.org
Subject: Re: [PATCH v1 03/14] NFS: Split out the nfs40_nograce_recovery_ops
 into nfs40proc.c
Message-ID: <202601182218.0ksoeCgb-lkp@intel.com>
References: <20260116215135.846062-4-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116215135.846062-4-anna@kernel.org>

Hi Anna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.19-rc5]
[also build test WARNING on linus/master next-20260116]
[cannot apply to trondmy-nfs/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anna-Schumaker/NFS-Move-nfs40_call_sync_ops-into-nfs40proc-c/20260117-055642
base:   v6.19-rc5
patch link:    https://lore.kernel.org/r/20260116215135.846062-4-anna%40kernel.org
patch subject: [PATCH v1 03/14] NFS: Split out the nfs40_nograce_recovery_ops into nfs40proc.c
config: i386-randconfig-r134-20260118 (https://download.01.org/0day-ci/archive/20260118/202601182218.0ksoeCgb-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260118/202601182218.0ksoeCgb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601182218.0ksoeCgb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/nfs/nfs4proc.c:1839:13: sparse: sparse: function 'nfs_state_clear_open_state_flags' with external linkage has definition

vim +/nfs_state_clear_open_state_flags +1839 fs/nfs/nfs4proc.c

  1838	
> 1839	extern void nfs_state_clear_open_state_flags(struct nfs4_state *state)
  1840	{
  1841		clear_bit(NFS_O_RDWR_STATE, &state->flags);
  1842		clear_bit(NFS_O_WRONLY_STATE, &state->flags);
  1843		clear_bit(NFS_O_RDONLY_STATE, &state->flags);
  1844		clear_bit(NFS_OPEN_STATE, &state->flags);
  1845	}
  1846	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

