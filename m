Return-Path: <linux-nfs+bounces-13793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9922BB2D196
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 03:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478031BC7425
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 01:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E4277023;
	Wed, 20 Aug 2025 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGuRkmiM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE870823
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654771; cv=none; b=OOYglUWLdPp20JuqrlreOQqXyy4jKv0f/fdFFcuW9pPfnKPE7m8mTq/OA0IWDgpFmQQjG0TWcmkZq8FtEqXwmVQUFJjdXvG5DZOVKVx38kZGRwrqN9f9TlhDMOjwI/Y65IULj96JvivEOIoFzYLwDbn2nPeRDcaM2AnfS/BRkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654771; c=relaxed/simple;
	bh=v8ZGXl6i7+GLgabNixEXW2doyPJq5x/LtU4JXwrlAlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQ/PD99bwyhg9CkuFwjMEF9I2otUSf/VdfTf6o5E8vEPfA0TwJ5582+6XnToy+MhL6J4HCjdUVesU9i/P5gd2h6ZiL0jxHvjPl+pOwpNnSEPSs0zmpebF8tC2ckhMviKJvhhkmQVXHdMala4NJbMvBFyj4gl0CEWx1XBjrngR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGuRkmiM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755654770; x=1787190770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v8ZGXl6i7+GLgabNixEXW2doyPJq5x/LtU4JXwrlAlw=;
  b=RGuRkmiMXWJZ82w6cHFYF+nLs1T7A2SCHVicoK5hDOb0kzoouu3kHTdB
   4iE5wwLBwlXXq4MSvj01jOT0C575Gas8IKMBzKdiQEosyN3gn4YRtwJTy
   ii/cXuoPI3/JQAwzCglJo4p/kD/m4pFCRAWtQbFeZ1eVT6vm/FWwUulNy
   Ap8o6qzAgdPWTQLInsNghWnk5efr0mPUQZqq73THJp8UOOLDL46Hr+bgl
   qULKu+vPNTPzMT0k/pFxtj58cERaz+0/e5Ry5jlmRlI4zxGxoIpz/IsWq
   Mm0YdcyK/UKK26CQcqPcMEpfr3kLRy7daiSWE0aSi2KHIepacZwt6ND6B
   w==;
X-CSE-ConnectionGUID: XZcjfligQ0+aAnvstsBRsQ==
X-CSE-MsgGUID: u1GXY6tUQYCNWYS80FsT1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69361487"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69361487"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 18:52:50 -0700
X-CSE-ConnectionGUID: TkRZCz6cSDinc9d0n4cW6A==
X-CSE-MsgGUID: VsXVtfzDTjS5afh4pXuaGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168801216"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Aug 2025 18:52:48 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoY0L-000Hwd-1l;
	Wed, 20 Aug 2025 01:52:45 +0000
Date: Wed, 20 Aug 2025 09:52:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Curley <jcurley@purestorage.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/9] NFSv4/flexfiles: Update low level helper functions
 to be DS stripe aware.
Message-ID: <202508200945.mrU2bex2-lkp@intel.com>
References: <20250818220750.47085-5-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818220750.47085-5-jcurley@purestorage.com>

Hi Jonathan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.16]
[cannot apply to trondmy-nfs/linux-next v6.17-rc2 v6.17-rc1 linus/master next-20250819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Curley/NFSv4-flexfiles-Remove-cred-local-variable-dependency/20250819-061041
base:   v6.16
patch link:    https://lore.kernel.org/r/20250818220750.47085-5-jcurley%40purestorage.com
patch subject: [PATCH 4/9] NFSv4/flexfiles: Update low level helper functions to be DS stripe aware.
config: powerpc-randconfig-002-20250820 (https://download.01.org/0day-ci/archive/20250820/202508200945.mrU2bex2-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250820/202508200945.mrU2bex2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508200945.mrU2bex2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/nfs/flexfilelayout/flexfilelayoutdev.c:374 function parameter 'dss_id' not described in 'nfs4_ff_layout_prepare_ds'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

