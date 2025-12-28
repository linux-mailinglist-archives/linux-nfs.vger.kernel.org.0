Return-Path: <linux-nfs+bounces-17340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B20E0CE5517
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 18:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 667913007C7A
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7290E1FBEA8;
	Sun, 28 Dec 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRaNN1Pi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830A757EA
	for <linux-nfs@vger.kernel.org>; Sun, 28 Dec 2025 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766944392; cv=none; b=Ye8S10LQpSKl3qSHhWiLFnDg1WkxXhPKF6OBLTI3/Kpt+KosRFvvG1FL4NGxNts86S/t6QgQu3BQ78GxgQKaoRKbZHKJjCs9G7zqDA8Y5FRvTtyODFdfMoV2MupgDNKIOkam5SqacXbDtvMQ4l4rg0cw03CXKlFTl7w4U2IFyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766944392; c=relaxed/simple;
	bh=83kM32nBtUOWKPsf82ZFspN6FGeHn090bCGfINx/sFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEdFe8TL40Je0UCKeIHEFWmCZi4ceQCXZImgDZKIG6fU68cTZEYRAN+ToBHv6M+0u7si0iW3M3BIuPNyU4PWkDJvLBMd7cfj2PO5C+4oqb3+dyL+sikmtlTdIQybGW6RzTfWUbzujQ7VA49+FhDwyAi5IQVML5jYJ+Pxrslnwso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRaNN1Pi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766944391; x=1798480391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83kM32nBtUOWKPsf82ZFspN6FGeHn090bCGfINx/sFg=;
  b=cRaNN1Pi+4xAnl1MFBb3KcjWKnzlNHfXky9/HujVtCKTS6o8Imj5DV/t
   LAAip63e0vXW9faMWNKSYjN+jQ2V4bJexPTr84d7IHqvIoLrO9yyka8us
   8a6tH/Rtml2hhhRv2C9UmMSltsozcvoNUZXoAIFI6TdWad4T0bBy5w9AD
   Afjh0BVaxP8nDtMI/8xomoehGdmxYghEkzcwu8V09Npuh/ICMoaSX4pWI
   nnwKUWTnDG35oB4LKT1KElwMkNIN0vpF087cnUQi9TBk1jf40qV9SvlWg
   aZGZWHYOTuc0zaJZXAm/Cd2aZ2H+ECbQL4Wd17yZBD86qTAdTP92j3w5+
   Q==;
X-CSE-ConnectionGUID: Vwo4lMEbSWaF4miHQfNaUg==
X-CSE-MsgGUID: ygEap4F6R7SY2ZxE8kLvtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="94051093"
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="94051093"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 09:53:10 -0800
X-CSE-ConnectionGUID: 1AqeHVCPSu2RlHLw8zzJfQ==
X-CSE-MsgGUID: u8NibnRrR/eFHQzHm7KEsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="200652956"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 28 Dec 2025 09:53:08 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZux0-000000006cT-0hew;
	Sun, 28 Dec 2025 17:53:06 +0000
Date: Mon, 29 Dec 2025 01:52:28 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Coddington <bcodding@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 4/7] NFSD: Add a per-knfsd reusable encfh_buf
Message-ID: <202512290151.LBKUBvUx-lkp@intel.com>
References: <5b7bf494b1ec816111ab34416dcde85c0bc01a0a.1766848778.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7bf494b1ec816111ab34416dcde85c0bc01a0a.1766848778.git.bcodding@hammerspace.com>

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on trondmy-nfs/linux-next linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/nfsd-Convert-export-flags-to-use-BIT-macro/20251228-010753
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/5b7bf494b1ec816111ab34416dcde85c0bc01a0a.1766848778.git.bcodding%40hammerspace.com
patch subject: [PATCH v1 4/7] NFSD: Add a per-knfsd reusable encfh_buf
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20251229/202512290151.LBKUBvUx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251229/202512290151.LBKUBvUx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512290151.LBKUBvUx-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfsd/nfsxdr.c: In function 'svcxdr_decode_fhandle':
>> fs/nfsd/nfsxdr.c:66:9: error: too few arguments to function 'fh_init'
      66 |         fh_init(fhp, NFS_FHSIZE);
         |         ^~~~~~~
   In file included from fs/nfsd/vfs.h:11,
                    from fs/nfsd/nfsxdr.c:8:
   fs/nfsd/nfsfh.h:256:1: note: declared here
     256 | fh_init(struct svc_fh *fhp, int maxsize, struct svc_rqst *rqstp)
         | ^~~~~~~


vim +/fh_init +66 fs/nfsd/nfsxdr.c

a887eaed2a96475 Chuck Lever 2020-10-23  48  
635a45d34706400 Chuck Lever 2020-11-17  49  /**
635a45d34706400 Chuck Lever 2020-11-17  50   * svcxdr_decode_fhandle - Decode an NFSv2 file handle
635a45d34706400 Chuck Lever 2020-11-17  51   * @xdr: XDR stream positioned at an encoded NFSv2 FH
635a45d34706400 Chuck Lever 2020-11-17  52   * @fhp: OUT: filled-in server file handle
635a45d34706400 Chuck Lever 2020-11-17  53   *
635a45d34706400 Chuck Lever 2020-11-17  54   * Return values:
635a45d34706400 Chuck Lever 2020-11-17  55   *  %false: The encoded file handle was not valid
635a45d34706400 Chuck Lever 2020-11-17  56   *  %true: @fhp has been initialized
635a45d34706400 Chuck Lever 2020-11-17  57   */
635a45d34706400 Chuck Lever 2020-11-17  58  bool
ebcd8e8b28535b6 Chuck Lever 2020-10-21  59  svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp)
ebcd8e8b28535b6 Chuck Lever 2020-10-21  60  {
ebcd8e8b28535b6 Chuck Lever 2020-10-21  61  	__be32 *p;
ebcd8e8b28535b6 Chuck Lever 2020-10-21  62  
ebcd8e8b28535b6 Chuck Lever 2020-10-21  63  	p = xdr_inline_decode(xdr, NFS_FHSIZE);
ebcd8e8b28535b6 Chuck Lever 2020-10-21  64  	if (!p)
ebcd8e8b28535b6 Chuck Lever 2020-10-21  65  		return false;
ebcd8e8b28535b6 Chuck Lever 2020-10-21 @66  	fh_init(fhp, NFS_FHSIZE);
d8b26071e65e80a NeilBrown   2021-09-02  67  	memcpy(&fhp->fh_handle.fh_raw, p, NFS_FHSIZE);
ebcd8e8b28535b6 Chuck Lever 2020-10-21  68  	fhp->fh_handle.fh_size = NFS_FHSIZE;
ebcd8e8b28535b6 Chuck Lever 2020-10-21  69  
ebcd8e8b28535b6 Chuck Lever 2020-10-21  70  	return true;
ebcd8e8b28535b6 Chuck Lever 2020-10-21  71  }
ebcd8e8b28535b6 Chuck Lever 2020-10-21  72  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

