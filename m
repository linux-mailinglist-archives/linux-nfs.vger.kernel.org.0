Return-Path: <linux-nfs+bounces-17406-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD9CF0132
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 15:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B91ED30124DE
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C732D192B;
	Sat,  3 Jan 2026 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5EYiKxn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A322A4FC
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767451042; cv=none; b=Ns484NsE0L2u37ChznArs3BAU57dXck+rVck4as2EEQSHZwXPkD3b45NqzEyA1Az3lS7Zs9hLivIQ+U8t/I1Vb9JDL5hkIoK2PfTsma/k3/SKPuI2ROFMESK3IEfeGBs3j67bEkXoHM1XqYLVoiQwVqE/aOi9BRUa/aWUH7s+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767451042; c=relaxed/simple;
	bh=OCYvqj3BEH4uFBPDHf8X/gmx0oQN0iZRwH5Md5iJsm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AisXVm/WYlipjioPzCvGygr5M9mX+5HdgT833tLFPcHldOn6uoyKQeBqna/n4cDivTHIV8G3nULm5ppVZz2bntPRwgt9r5LbDUg6uquWaMndkmurFPL3gMX5bdevJc7Ur2wZhYRIfm8LcBzLck+ZCuIzRjzsPxKfsh8zXBDeQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5EYiKxn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767451042; x=1798987042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OCYvqj3BEH4uFBPDHf8X/gmx0oQN0iZRwH5Md5iJsm4=;
  b=X5EYiKxnNOQKVdBzMv0cj1yN9Y+d4w3Y0w5vnmCf5vp9BTks0JnMU7oc
   H66rdS3/gQ+K9cF56Yv+A7ueMsgFbVwQ6pZb4tFIIJF2GCGBxSJPQ4oHj
   DhjycJHncqbmF2IrUwosD/It92uz5V+b6szqyACTv0bPW2Qb9qYQGbt6x
   dYRANHgkS3ZXrCWACybL2HttpiLfxJc9Cyr8BbOb3WRxacIOZ6iwmV3tj
   lfpffNFYh02fykqRvItGMz1Po2w3Dv1dQnvlZIdao9GhS6pv+HYQyTK+i
   yJUX/yKFW3WlED4b9aMsIsDtSAAzkZDlvBMKXBRobAKZd8bWhmN50h3Vf
   g==;
X-CSE-ConnectionGUID: NK3geK7XQamrN9CfnyVvEQ==
X-CSE-MsgGUID: 6aXJYkHrSLKsiymAKmJRWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="68640837"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="68640837"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 06:37:21 -0800
X-CSE-ConnectionGUID: pYh4a2KhSJeC6yRyfR4RZA==
X-CSE-MsgGUID: 4qPgkVEpQMuZGozTh8x4xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="201243902"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 03 Jan 2026 06:37:19 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vc2km-000000000iP-3KCD;
	Sat, 03 Jan 2026 14:37:16 +0000
Date: Sat, 3 Jan 2026 15:37:13 +0100
From: kernel test robot <lkp@intel.com>
To: rick.macklem@gmail.com, linux-nfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: Re: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
Message-ID: <202601031506.MX594pma-lkp@intel.com>
References: <20260102232934.1560-6-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102232934.1560-6-rick.macklem@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.16-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/rick-macklem-gmail-com/Add-entries-to-the-predefined-client-operations-enum/20260103-073239
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260102232934.1560-6-rick.macklem%40gmail.com
patch subject: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260103/202601031506.MX594pma-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260103/202601031506.MX594pma-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601031506.MX594pma-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfs/nfs4proc.c:6083:36: error: use of undeclared identifier 'FATTR4_WORD2_POSIX_DEFAULT_ACL'
    6083 |                 return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL;
         |                                                  ^
>> fs/nfs/nfs4proc.c:6085:36: error: use of undeclared identifier 'FATTR4_WORD2_POSIX_ACCESS_ACL'
    6085 |                 return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL;
         |                                                  ^
   fs/nfs/nfs4proc.c:9630:12: warning: variable 'ptr' set but not used [-Wunused-but-set-variable]
    9630 |         unsigned *ptr;
         |                   ^
   1 warning and 2 errors generated.


vim +/FATTR4_WORD2_POSIX_DEFAULT_ACL +6083 fs/nfs/nfs4proc.c

  6071	
  6072	bool nfs4_server_supports_acls(const struct nfs_server *server,
  6073					      enum nfs4_acl_type type)
  6074	{
  6075		switch (type) {
  6076		default:
  6077			return server->attr_bitmask[0] & FATTR4_WORD0_ACL;
  6078		case NFS4ACL_DACL:
  6079			return server->attr_bitmask[1] & FATTR4_WORD1_DACL;
  6080		case NFS4ACL_SACL:
  6081			return server->attr_bitmask[1] & FATTR4_WORD1_SACL;
  6082		case NFS4ACL_POSIXDEFAULT:
> 6083			return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL;
  6084		case NFS4ACL_POSIXACCESS:
> 6085			return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL;
  6086		}
  6087	}
  6088	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

