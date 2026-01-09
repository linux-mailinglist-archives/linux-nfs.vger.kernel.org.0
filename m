Return-Path: <linux-nfs+bounces-17712-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F8D0C453
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 22:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B55B302D2AB
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 21:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D68072631;
	Fri,  9 Jan 2026 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fM+ZPXCa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A031D735
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993287; cv=none; b=Vo/aLKCmmeVYmsjGNMVnVNu5ErtlEuBISLIEYSZbJNlughkOP1RuJJcgEsShZmfzCoYFCSK56G8DxmmoQ2cAItxsaqK2+utQd3nKzURJ/2LbcwiVpN5Ufrk6kzF/ae/x2U93GoaqetjsI/o0etx27WZd7EtiPFH0K/Va4Ai6lSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993287; c=relaxed/simple;
	bh=uXj3V04W9NErkTksKPhD6kasE5KK4IVeJr//78OCCFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgvF64xe0UcC3wFFM2Q6SjmNtok4nh21Ze6GUhsRtsOlrbre8/7IEIAMTwUWNxXn8WHGVagqEA6RfAIIkaxhrOEyoL+8rUiiLmO5dCS7u758f/PT3RLnr2xH7uzrsLtLaDT6CsA8WP/RL/E994l/w7ynh7Hxo7DTWELmFMkefks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fM+ZPXCa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767993287; x=1799529287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uXj3V04W9NErkTksKPhD6kasE5KK4IVeJr//78OCCFo=;
  b=fM+ZPXCajJ0IRlvqgPNAlKrXTVTf8Wq3yPsHyjehYREG3W7/WnSW4lwY
   V+qw5sv8l8qwTCGtn/Sdwx2DCHdXsqwFMkUZV/ydBpLN0PZdGCTc7aA2u
   gtF0WZUci6AFz/z4T+BiB7Dgf81HFCriewvJ5nhfGmYYtd+vy4DeefyHR
   Rp/7c9E5bUJ88haGM3VKGKVkYqOJRqHjAQFwiN+Uyk6nZ2gnRl/ZQ4nr7
   Bg5798OwE1oDBD3j0vDOK3aXav2bQXn4Fgtt3J3eBCTHRONhruveeKPN9
   61mRH6jIEnAFVL85+I2QAM86rEc3sZhFbORoPmnZC1ReXxFXzWChqKA4I
   Q==;
X-CSE-ConnectionGUID: DXvVnffLRN2i+17h6RYNvQ==
X-CSE-MsgGUID: d00+gKo1Qk6cbKyc825rEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="56930550"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="56930550"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 13:14:46 -0800
X-CSE-ConnectionGUID: uR6ka200TgarzR72ollcow==
X-CSE-MsgGUID: WcK6dYxlRJyBqpPc25XT9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="234765394"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Jan 2026 13:14:45 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veJog-000000007jc-2sdM;
	Fri, 09 Jan 2026 21:14:42 +0000
Date: Sat, 10 Jan 2026 05:14:04 +0800
From: kernel test robot <lkp@intel.com>
To: rick.macklem@gmail.com, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Rick Macklem <rmacklem@uoguelph.ca>
Subject: Re: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
Message-ID: <202601100435.4dwE5mYV-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.19-rc4 next-20260109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/rick-macklem-gmail-com/Add-entries-to-the-predefined-client-operations-enum/20260103-073239
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260102232934.1560-6-rick.macklem%40gmail.com
patch subject: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20260110/202601100435.4dwE5mYV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260110/202601100435.4dwE5mYV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601100435.4dwE5mYV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nfs/nfs4proc.c: In function 'nfs4_server_supports_acls':
   fs/nfs/nfs4proc.c:6083:50: error: 'FATTR4_WORD2_POSIX_DEFAULT_ACL' undeclared (first use in this function)
    6083 |                 return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL;
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/nfs4proc.c:6083:50: note: each undeclared identifier is reported only once for each function it appears in
   fs/nfs/nfs4proc.c:6085:50: error: 'FATTR4_WORD2_POSIX_ACCESS_ACL' undeclared (first use in this function); did you mean 'FATTR4_WORD1_TIME_ACCESS_SET'?
    6085 |                 return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL;
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                  FATTR4_WORD1_TIME_ACCESS_SET
>> fs/nfs/nfs4proc.c:6087:1: warning: control reaches end of non-void function [-Wreturn-type]
    6087 | }
         | ^


vim +6087 fs/nfs/nfs4proc.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  6071  
2f4c5fc884fcb1 Rick Macklem    2026-01-02  6072  bool nfs4_server_supports_acls(const struct nfs_server *server,
7b8b44eb7710e3 Trond Myklebust 2022-05-14  6073  				      enum nfs4_acl_type type)
aa1870af92d8f6 J. Bruce Fields 2005-06-22  6074  {
7b8b44eb7710e3 Trond Myklebust 2022-05-14  6075  	switch (type) {
7b8b44eb7710e3 Trond Myklebust 2022-05-14  6076  	default:
7b8b44eb7710e3 Trond Myklebust 2022-05-14  6077  		return server->attr_bitmask[0] & FATTR4_WORD0_ACL;
7b8b44eb7710e3 Trond Myklebust 2022-05-14  6078  	case NFS4ACL_DACL:
7b8b44eb7710e3 Trond Myklebust 2022-05-14  6079  		return server->attr_bitmask[1] & FATTR4_WORD1_DACL;
7b8b44eb7710e3 Trond Myklebust 2022-05-14  6080  	case NFS4ACL_SACL:
7b8b44eb7710e3 Trond Myklebust 2022-05-14  6081  		return server->attr_bitmask[1] & FATTR4_WORD1_SACL;
2f4c5fc884fcb1 Rick Macklem    2026-01-02  6082  	case NFS4ACL_POSIXDEFAULT:
2f4c5fc884fcb1 Rick Macklem    2026-01-02  6083  		return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL;
2f4c5fc884fcb1 Rick Macklem    2026-01-02  6084  	case NFS4ACL_POSIXACCESS:
2f4c5fc884fcb1 Rick Macklem    2026-01-02  6085  		return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL;
7b8b44eb7710e3 Trond Myklebust 2022-05-14  6086  	}
aa1870af92d8f6 J. Bruce Fields 2005-06-22 @6087  }
aa1870af92d8f6 J. Bruce Fields 2005-06-22  6088  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

