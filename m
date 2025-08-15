Return-Path: <linux-nfs+bounces-13687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4CB287F6
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC4E5680C8
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9A421D3EA;
	Fri, 15 Aug 2025 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faNrEmUt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9381B87C0;
	Fri, 15 Aug 2025 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294555; cv=none; b=svBiI53W/N+gnG8O0mFcY6H61jBXTULEaLdbgVRYvd5bG9zrE+ZfJapiGTm2e9pyBsbhD7mXoNjam6TRyuXa8SflEYXyM+vEPX2HTj1FLnRTNOKC2IHx349K2Jok4U8GQga5aQf4p1tcn/9wVzE+vVBkaxR7xNeDnz+QuCTQgLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294555; c=relaxed/simple;
	bh=7/DESvwD3138OtQA65/DUWMV7oCqWuC7zjK3tOXv16k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkWifaw6K+sqA4+w+D0IqjNJZKyYu5OGqQTOM6x3Pbp+UR2m3Hs7f8yLDmOStW3mgMcC89tDT0rVnR4H8X3U5SNcQrdTYq0JXGUzaWc/vnHhRm/gTAapC172nwp4Bo5QhXKfHfT9KwL2lT/3fH/Z4NI/0FL/kCyhvh4+oTwjk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faNrEmUt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755294554; x=1786830554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/DESvwD3138OtQA65/DUWMV7oCqWuC7zjK3tOXv16k=;
  b=faNrEmUtnTP59Ltdp3yGuxOYVUXFSGDrqMi3T0kA4Uv0ECBjL5VBlMil
   NtT8CWPDJb8oX061NxG4NcmyTL8Nhj9SGSDyFxaOp3DLzkhIPtaTf4mwn
   1599mXqS7MRcHkLNkwxETN9r77/nLoLdEsNivInhPucC5uwoBLCJnSpJR
   UtgxRoJr3T65MwhI6OtENfn0+X6SP2KwrNZNjnUJkt6z7SmA5lr7JRGQm
   TkLtO++28xHfDncK6tfvwxSDDCRTcA7wclpdz8afE6xa+HJG6K5JWzO/D
   CCZQdCYlIbqeb9JNQkvi4V9kUVI4DLfT8IIhF0a5DmOwWMj01IQeTiaRy
   A==;
X-CSE-ConnectionGUID: CmdGQ7m8Rn2zdjq1mo/BqQ==
X-CSE-MsgGUID: hg5IUbAGSY+CRdjoe7nLbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68220427"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68220427"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:49:13 -0700
X-CSE-ConnectionGUID: QnRETjyrRLavnrXXHKJkKg==
X-CSE-MsgGUID: p65L7qcuScGyVUlLkIq0Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166321491"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:49:10 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un2IM-000CNc-0o;
	Fri, 15 Aug 2025 21:49:06 +0000
Date: Sat, 16 Aug 2025 05:48:51 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/8] net/handshake: Expose handshake_sk_destruct_req
 publically
Message-ID: <202508160510.XOTeniWX-lkp@intel.com>
References: <20250815050210.1518439-4-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815050210.1518439-4-alistair.francis@wdc.com>

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
patch link:    https://lore.kernel.org/r/20250815050210.1518439-4-alistair.francis%40wdc.com
patch subject: [PATCH 3/8] net/handshake: Expose handshake_sk_destruct_req publically
config: arm-mps2_defconfig (https://download.01.org/0day-ci/archive/20250816/202508160510.XOTeniWX-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160510.XOTeniWX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160510.XOTeniWX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/handshake/request.c:312:6: warning: no previous prototype for function 'handshake_req_cancel' [-Wmissing-prototypes]
     312 | bool handshake_req_cancel(struct sock *sk)
         |      ^
   net/handshake/request.c:312:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     312 | bool handshake_req_cancel(struct sock *sk)
         | ^
         | static 
>> net/handshake/request.c:349:6: warning: no previous prototype for function 'handshake_sk_destruct_req' [-Wmissing-prototypes]
     349 | void handshake_sk_destruct_req(struct sock *sk)
         |      ^
   net/handshake/request.c:349:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     349 | void handshake_sk_destruct_req(struct sock *sk)
         | ^
         | static 
   2 warnings generated.


vim +/handshake_sk_destruct_req +349 net/handshake/request.c

   344	
   345	/**
   346	 * handshake_sk_destruct_req - destroy an existing request
   347	 * @sk: socket on which there is an existing request
   348	 */
 > 349	void handshake_sk_destruct_req(struct sock *sk)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

