Return-Path: <linux-nfs+bounces-11659-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81CAB2B41
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 23:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB53018967FD
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B0F38DF9;
	Sun, 11 May 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0F7mKV/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365F3A1DB
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746997229; cv=none; b=jzK7LwOS8anrhdNcdwccggabRZIwWtmxB5c5Snmb++2PVu1tZxcpghT1PR777xXQA9idoBM4Xl2A3mmO+BeAt9DEf5NfQs+d30agjLQ1WVzJqQ4pMlOZOLjpycSVN+uuGVS/N6vBhJFqv7u3pRTY1ReRS9UGyApx56/KFl1ejbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746997229; c=relaxed/simple;
	bh=SnLtOL4VnTAPExi03uVjScviiH9gJ9/DViYjtUC9N1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAT5UdQb6m5uaFJUbc08pS0Te5uBdevX9opqG2hs5fks8irl0PAUE550G0c6c81fAauFqAyguLDpke5PafsJtw6D+ge3HghV2rCbRdPVg42lSQLLQTi1vVupro4wTY8/unvAmDhDYf2HabTKNtBDkvO+4fnO22r7gvxRzFfySwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0F7mKV/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746997227; x=1778533227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SnLtOL4VnTAPExi03uVjScviiH9gJ9/DViYjtUC9N1w=;
  b=l0F7mKV/7as3OKxIGHtsw/oA+9MRSo4IEOx4bjlfNGnR8P6EnriDQuh2
   f+PyOxCw5pf6LnY+e0eKoMRgpqBc0ODCTM/sCbistUMiTLJ/mTXDpBx6a
   K7CBdT5zv9Tv/CRD9cZi7EKSWF6+nLBjISuvF+TwAoOqzCckhAASM47FQ
   2zPpvZD253dGA795mrdUIP7fW0R/GQ7JwiX5OIWBQ8HYgX+5q/49zwhka
   /laKyMvO8tqQBjyLBEL4x+delfR7Mw2T0ytfgT0AcKk/xTYVx+YlwFIfv
   NjfPE5u+hNwZNKa3FxGVQr8SKUbBYJg+yZhCqhFjzgEakjL4DjBRaO699
   w==;
X-CSE-ConnectionGUID: qcxfr9usQXivdeisgcwGKw==
X-CSE-MsgGUID: +9jdLQfpSTCvtO5drrFKhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="66188807"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="66188807"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 14:00:27 -0700
X-CSE-ConnectionGUID: e4J656JaTz2Xx8fWLoDPjg==
X-CSE-MsgGUID: SAcdSkjGQGOxSEYyK3eW7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="141937974"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 May 2025 14:00:27 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEDmZ-000DzP-2h;
	Sun, 11 May 2025 21:00:23 +0000
Date: Mon, 12 May 2025 04:59:27 +0800
From: kernel test robot <lkp@intel.com>
To: trondmy@kernel.org, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] NFS/pnfs: Fix the error path in
 pnfs_layoutreturn_retry_later_locked()
Message-ID: <202505120404.RyxNoBfS-lkp@intel.com>
References: <7a4abcb32bb29ad463638bf1d2d0600a3d9e357c.1746970073.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4abcb32bb29ad463638bf1d2d0600a3d9e357c.1746970073.git.trond.myklebust@hammerspace.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.15-rc5 next-20250509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/trondmy-kernel-org/NFS-pnfs-Fix-the-error-path-in-pnfs_layoutreturn_retry_later_locked/20250511-212905
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/7a4abcb32bb29ad463638bf1d2d0600a3d9e357c.1746970073.git.trond.myklebust%40hammerspace.com
patch subject: [PATCH] NFS/pnfs: Fix the error path in pnfs_layoutreturn_retry_later_locked()
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20250512/202505120404.RyxNoBfS-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250512/202505120404.RyxNoBfS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505120404.RyxNoBfS-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfs/pnfs.c: In function 'pnfs_layoutreturn_retry_later_locked':
>> fs/nfs/pnfs.c:1254:17: error: implicit declaration of function 'pnfs_reset_return_info'; did you mean 'pnfs_set_plh_return_info'? [-Wimplicit-function-declaration]
    1254 |                 pnfs_reset_return_info(lo);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 pnfs_set_plh_return_info


vim +1254 fs/nfs/pnfs.c

  1245	
  1246	static void
  1247	pnfs_layoutreturn_retry_later_locked(struct pnfs_layout_hdr *lo,
  1248					     const nfs4_stateid *arg_stateid,
  1249					     const struct pnfs_layout_range *range,
  1250					     struct list_head *freeme)
  1251	{
  1252		if (pnfs_layout_is_valid(lo) &&
  1253		    nfs4_stateid_match_other(&lo->plh_stateid, arg_stateid))
> 1254			pnfs_reset_return_info(lo);
  1255		else
  1256			pnfs_mark_layout_stateid_invalid(lo, freeme);
  1257		pnfs_clear_layoutreturn_waitbit(lo);
  1258	}
  1259	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

