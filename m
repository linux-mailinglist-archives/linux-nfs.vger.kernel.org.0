Return-Path: <linux-nfs+bounces-11602-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63CAAFF6C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F521BC39A0
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81A27A464;
	Thu,  8 May 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/fPBYXh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9027A137
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719004; cv=none; b=VcWePxCkH3Krr1PHsB/AE0SCmK/HaMbGT9KLg6HY32Rytvk5mn1FdCnXRKorsff9T+lIefox+Jrasna+aqJkkOhZHL1HoLp3UF/QJIhPmw5AOzT/Tia+cbL+puG3+QZWuEXYHf+6QxywXR1xnfaw1u7L8iMDt9GmHOUopeGfobI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719004; c=relaxed/simple;
	bh=YuzFY5iIeE/5SyS+rcd6EVV7jCbQGUHQiVQ4+7iLZTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERayGgSV4DO00xDpBbV3ETu8UwNpsXPQtoHbgo2QyLcunX8wVHns3RgoPiSLeTa3IdfcTE4Nh7FH1qKGtJobYCKZs0EqkF8kouGtfrJZOQmIVkWnbTVGyqqHkeHlDd4AGUH8cpgQhy8CQgmHn4e0jzBWTPYIrTn3CIpDTu8G4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/fPBYXh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746719003; x=1778255003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YuzFY5iIeE/5SyS+rcd6EVV7jCbQGUHQiVQ4+7iLZTM=;
  b=a/fPBYXhzbBqm2DUXSYS6vDT+G0Z9Q1QJAEpRlCnSTQgHi17o9Yr5ujz
   P6R/oAWrUmsrDsBhYjTlPvRoon2y+WvEpxChwnn+Mgi3nwMuq8uVjaooK
   cxG+Qu059huDpEKARntp5is8jBe4uTIIXRJdnAzP+/Trz1zl4gFSKca+i
   zoyADrF8wromv9aykPfaUQpsS3ApTI/8nMLev2G2xaCk0XoPpsfctIZPq
   iqSvDnXXdP0Oe/j67XDZQnOGUb3Gscr5g/L1HDQDZY6JmdXVSNIr1XCsr
   2booFzPS9NjEX61J4bTd84CT1x3mYiiqR/SBs89rygZRfmZbegQukKYQ6
   Q==;
X-CSE-ConnectionGUID: Nf1DbWOUTsGycwNTIWporQ==
X-CSE-MsgGUID: 1gwsN+yLRBib9go+KGgJxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48675975"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="48675975"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 08:43:18 -0700
X-CSE-ConnectionGUID: OBx61r3WTq6//JvgDGZtjw==
X-CSE-MsgGUID: DzpXdOVTR0eyOwi05XsawA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136262748"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2025 08:43:14 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uD3Oy-000B7D-29;
	Thu, 08 May 2025 15:43:12 +0000
Date: Thu, 8 May 2025 23:42:18 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] nfsd: use rq_bvec instead of rq_vec in nfsd_vfs_write
Message-ID: <202505082324.vojWBNIq-lkp@intel.com>
References: <20250507115617.3995150-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507115617.3995150-3-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on trondmy-nfs/linux-next linus/master v6.15-rc5]
[cannot apply to next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/nfsd-use-rq_bvec-instead-of-rq_vec-in-nfsd_vfs_write/20250507-205615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250507115617.3995150-3-hch%40lst.de
patch subject: [PATCH 2/3] nfsd: use rq_bvec instead of rq_vec in nfsd_vfs_write
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20250508/202505082324.vojWBNIq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505082324.vojWBNIq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505082324.vojWBNIq-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xdr_buf_to_bvec" [fs/nfsd/nfsd.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

