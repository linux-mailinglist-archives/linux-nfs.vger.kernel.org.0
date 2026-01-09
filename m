Return-Path: <linux-nfs+bounces-17714-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58311D0C65E
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 22:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 925EC3010A97
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3D33D4E3;
	Fri,  9 Jan 2026 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfgz8WZ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E631ED61
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995751; cv=none; b=eEo/p/PVlylTT09o+dfZIbh61cV60/WSQl2FGrCOh8qd8LGOSgrgNMJjxboqfClmKBvrAPUOrxR+OH/oaYG9sPMmS876PC7EEmNOYEwr0lpK9JDVyhtgsLPkgcc7JiUmSzQl1j3HrR2dMIkL+qCXMLz3qDMwSQqBd5PX6GoJDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995751; c=relaxed/simple;
	bh=nxvbnhQ94iieMXFePkCByiBPHnVN8cP0EIPmc3mwLWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWF748QdJXXfc3vW1UV+1399sCTp20wpxXY9iUzAY+ZzI6CflRFffl4tPaXs+Q/DGHxRKwDGatvy3E+zKxGiukCYC9AOp8WB5UeENFLbt0vtIZf0EdTV8JsfAGeOwanx6jx9j3+IZ+glzi8V6D7qndLS6tIdkcQvJ9+zqZ7vNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfgz8WZ1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767995750; x=1799531750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nxvbnhQ94iieMXFePkCByiBPHnVN8cP0EIPmc3mwLWw=;
  b=mfgz8WZ1MVVPFQkccUUBZJ5hLcz2uOtVIqesq9v91D8sRbfjlr400wgr
   Yiu1N6fsNYQOJA9a/aqVwn/skbmUoRvXAmj1vmgdFlTc1dBwLwAFznAq1
   h1fCmO98Vrd4Y4Br5VIuhCMj5QZycRL8tMlOSTx/H/D57gsgEot37+Aex
   fLAr7GZKHt98HfmPdcwymuEFzdro5xwMEBrR/zYCfX55Bu4ByOBB+zCAg
   ZcKchWfGVbKY5Sjur01Fuqqs0vWz+Z2fsexCNYrzUWgTHs+7MS5fRKYKI
   xGzzMkqGLz2jI63cdbd1UTAN1ZF/YUpw0QQ2jCG4v/CYQOm8jj63ponEG
   w==;
X-CSE-ConnectionGUID: wu1pSRhQSUKQJL5Gv+ZuBA==
X-CSE-MsgGUID: j2oeSgNeQ0G6H4u0AEc+Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="80746162"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="80746162"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 13:55:49 -0800
X-CSE-ConnectionGUID: BEYileuBRdifNwGEV9HCjQ==
X-CSE-MsgGUID: OrMHRQArSMyIPJlfp++J0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="203482413"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Jan 2026 13:55:48 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veKSP-000000007lE-3IeG;
	Fri, 09 Jan 2026 21:55:45 +0000
Date: Sat, 10 Jan 2026 05:55:28 +0800
From: kernel test robot <lkp@intel.com>
To: rick.macklem@gmail.com, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Rick Macklem <rmacklem@uoguelph.ca>
Subject: Re: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
Message-ID: <202601100546.EDWB9nf6-lkp@intel.com>
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
[also build test ERROR on linus/master v6.19-rc4 next-20260109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/rick-macklem-gmail-com/Add-entries-to-the-predefined-client-operations-enum/20260103-073239
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260102232934.1560-6-rick.macklem%40gmail.com
patch subject: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260110/202601100546.EDWB9nf6-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260110/202601100546.EDWB9nf6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601100546.EDWB9nf6-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfs/nfs4proc.c: In function 'nfs4_server_supports_acls':
>> fs/nfs/nfs4proc.c:6083:50: error: 'FATTR4_WORD2_POSIX_DEFAULT_ACL' undeclared (first use in this function)
    6083 |                 return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL;
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/nfs4proc.c:6083:50: note: each undeclared identifier is reported only once for each function it appears in
>> fs/nfs/nfs4proc.c:6085:50: error: 'FATTR4_WORD2_POSIX_ACCESS_ACL' undeclared (first use in this function); did you mean 'FATTR4_WORD1_TIME_ACCESS_SET'?
    6085 |                 return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL;
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                  FATTR4_WORD1_TIME_ACCESS_SET


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

