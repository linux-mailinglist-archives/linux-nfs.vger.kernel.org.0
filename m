Return-Path: <linux-nfs+bounces-17407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ACDCF0194
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 16:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14E1B300160B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5945191F92;
	Sat,  3 Jan 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTzr3Y7E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C2E55C
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767453383; cv=none; b=Suh9qX+/yrfYJOQUlMgC1wO1yIBbfgiekb6p3pWDyVn80+Yc4seOps2DCAEU9VjtGjrXx50sS3k5DnUqaH0YzCRzZqwFPsiqtRUW/22oUvMxPcx20poABtvtHxBgbXMq/yHPYAMTVtqBOi8AwZUovqS1u50xjiECQLxQ/G2oeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767453383; c=relaxed/simple;
	bh=WA47E2M1Val9QGYZXc/26+ZRFqYTuqueR4HcUVIvX6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF6aulMQIbkjZPLHeyc68oGy/lXJ/TVRgJO84ioj4i6S3mwWptYSbkeIjZIUJ4D3mrlC11LRsQBFGS2Y+xEAk2IePM2yeWRV0D2H7uqiwXbINtkZuIfgnJRCF5kkg4afbHNIjNwMKCGAEcfHm7PFqGG/EhOyqZOx6frADELvbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTzr3Y7E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767453381; x=1798989381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WA47E2M1Val9QGYZXc/26+ZRFqYTuqueR4HcUVIvX6Q=;
  b=mTzr3Y7E1TaWmhH++hYgC0hASg9vGkRlIqwgE04jEjBY4QifXSjffTYp
   27JvdFvFDjbL3C/xUphxEvymUiQqCOGi0ZYJS1NY/UcSimUeqFqe43x8N
   HYOrxhidg69gWC5SEd6DbH6wTlzX8h6rE1TIAfClFWNmh2BsF9CTmxAm2
   aiTjci6lndzLB+l5HEgi0Ab05l52RK2A00koedikuFcknFyDiqBi8oVh2
   A7OcYwjLG6QpFckBdudX4Tpnv0L/g+ABUeWZmUPdZdpWWqFPQSovSJV5x
   TaFzL9WT2b9YhaJ+hyOS9pQpeXt+6BU6Edhmv6ptIMEMQiUnBJpbPOCYS
   Q==;
X-CSE-ConnectionGUID: bosNggLfQqaKwPhGHLLLvQ==
X-CSE-MsgGUID: gT9paoAsQ5+l7ON9KzpR6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="71480989"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="71480989"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 07:16:20 -0800
X-CSE-ConnectionGUID: ttISP+njRxGC+mIimTDmUA==
X-CSE-MsgGUID: YUYexHeJRve/5uFg0Wum+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="201150554"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 03 Jan 2026 07:16:19 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vc3MW-000000000ib-3vxv;
	Sat, 03 Jan 2026 15:16:16 +0000
Date: Sat, 3 Jan 2026 16:15:29 +0100
From: kernel test robot <lkp@intel.com>
To: rick.macklem@gmail.com, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Rick Macklem <rmacklem@uoguelph.ca>
Subject: Re: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
Message-ID: <202601031639.zIQYLs4h-lkp@intel.com>
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
[also build test ERROR on linus/master v6.19-rc3 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/rick-macklem-gmail-com/Add-entries-to-the-predefined-client-operations-enum/20260103-073239
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260102232934.1560-6-rick.macklem%40gmail.com
patch subject: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260103/202601031639.zIQYLs4h-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260103/202601031639.zIQYLs4h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601031639.zIQYLs4h-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/nfs/nfs4proc.c: In function 'nfs4_server_supports_acls':
>> fs/nfs/nfs4proc.c:6083:50: error: 'FATTR4_WORD2_POSIX_DEFAULT_ACL' undeclared (first use in this function)
    6083 |                 return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL;
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/nfs4proc.c:6083:50: note: each undeclared identifier is reported only once for each function it appears in
>> fs/nfs/nfs4proc.c:6085:50: error: 'FATTR4_WORD2_POSIX_ACCESS_ACL' undeclared (first use in this function); did you mean 'FATTR4_WORD1_TIME_ACCESS_SET'?
    6085 |                 return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL;
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                  FATTR4_WORD1_TIME_ACCESS_SET
   fs/nfs/nfs4proc.c: In function 'nfs4_proc_create_session':
   fs/nfs/nfs4proc.c:9630:19: warning: variable 'ptr' set but not used [-Wunused-but-set-variable]
    9630 |         unsigned *ptr;
         |                   ^~~
   fs/nfs/nfs4proc.c: In function 'nfs4_server_supports_acls':
>> fs/nfs/nfs4proc.c:6087:1: warning: control reaches end of non-void function [-Wreturn-type]
    6087 | }
         | ^


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
> 6087	}
  6088	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

