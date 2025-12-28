Return-Path: <linux-nfs+bounces-17335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1337CE4941
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 06:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85FBF30019C6
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 05:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB51EB5E1;
	Sun, 28 Dec 2025 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUnLHpVb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCD20ED
	for <linux-nfs@vger.kernel.org>; Sun, 28 Dec 2025 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766899075; cv=none; b=nxCv9oxSDu8RCeJboAaK1UlmA+Y+iSxBrx71c13ys9FygCfT99cRhOa9W5RjLaTAkrBJUi+tbZekXLdwGoTmm8sA3DcUga91Nj10Spq0tiZgYqjaXvbrRVGanPXI0IQCMrEWOKd122dskprk5ZQoccY94yjxNcrfovYcSJL4AS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766899075; c=relaxed/simple;
	bh=8SPQGL4UPSiR/d26uvQjzey7vqt1cAI7qHZE6oLjAgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUM5r+QkZmeTd5N8sxEThKiFvtAospOz1bttDGwRQaCX2tMMii7q4AjXWS3tLPrJ6pKlfGRi8I8A70vMqJDUxbSHB4dtEb1kD/uKNGBkCh4+zCUhIHSLpD6dEd1L1PvsCyMwsZ3+rJ2xUkOX/BlUQuWIwudJtZDn3IkwyNIzwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUnLHpVb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766899074; x=1798435074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8SPQGL4UPSiR/d26uvQjzey7vqt1cAI7qHZE6oLjAgA=;
  b=XUnLHpVbKkFU1tBiJvprw6i7aCb99KfBypa7K+7Dksu1yDSEyNaBISmR
   LSpA1vCs26n6G3hMxGSUVg21MqZdv206gAp3VCbdGL9wVcHgIbhlmcbSP
   Cn59T2vxZ+y5RRL4Iu7fSn6hjyj0BHm/OP9MjdSHNra7X/aSyjcnbboRc
   TaqEqEc4FSVueQqDPA2/ezui/F/z+L+vExeoi6TDta3FijXuZYXev4+QX
   MgETvUqVzMyBcxvwR/1Lk6XdgmJ/rFx7OHFd8TpWuQn/qsljlmnZ3lzjZ
   r0Nh3+Kv8RcqZA55Fu0i2IJyFnSH9asm2XhWFxhqeTX1ZVRLHSNgW65tJ
   A==;
X-CSE-ConnectionGUID: 4v6l5XHSQ8+C2eXTe64RAw==
X-CSE-MsgGUID: PJ7MA1rqR7qbJDl9zXcBOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="72415533"
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="72415533"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 21:17:53 -0800
X-CSE-ConnectionGUID: ESaTSnn2SQuim7KbBrkvtg==
X-CSE-MsgGUID: 8LHZkiokTBOXuqq3KgiJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="231324218"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Dec 2025 21:17:51 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZjA4-000000006GX-3Zh8;
	Sun, 28 Dec 2025 05:17:48 +0000
Date: Sun, 28 Dec 2025 13:17:07 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Coddington <bcodding@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 6/7] NFSD: Add filehandle crypto functions and helpers
Message-ID: <202512281330.lPQZAymu-lkp@intel.com>
References: <0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding@hammerspace.com>

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on trondmy-nfs/linux-next linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/nfsd-Convert-export-flags-to-use-BIT-macro/20251228-010753
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding%40hammerspace.com
patch subject: [PATCH v1 6/7] NFSD: Add filehandle crypto functions and helpers
config: arm-randconfig-004-20251228 (https://download.01.org/0day-ci/archive/20251228/202512281330.lPQZAymu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251228/202512281330.lPQZAymu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512281330.lPQZAymu-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfsd/nfsfh.c:282:5: warning: no previous prototype for 'fh_encrypt' [-Wmissing-prototypes]
     282 | int fh_encrypt(struct svc_fh *fhp)
         |     ^~~~~~~~~~
   fs/nfsd/nfsfh.c:294:12: warning: 'fh_decrypt' defined but not used [-Wunused-function]
     294 | static int fh_decrypt(struct svc_fh *fhp)
         |            ^~~~~~~~~~
   In file included from include/linux/string.h:386,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/sched.h:37,
                    from include/linux/sunrpc/svcauth_gss.h:12,
                    from fs/nfsd/nfsfh.c:13:
   fs/nfsd/nfsfh.c: In function 'fh_crypto.constprop':
>> include/linux/compiler_types.h:630:45: error: call to '__compiletime_assert_1035' declared with attribute error: min(sizeof(iv), key_len(fh->fh_raw[2])) signedness error
     630 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/fortify-string.h:627:48: note: in definition of macro '__fortify_memcpy_chk'
     627 |         const size_t __fortify_size = (size_t)(size);                   \
         |                                                ^~~~
   fs/nfsd/nfsfh.c:189:17: note: in expansion of macro 'memcpy'
     189 |                 memcpy(iv, fh_fsid(fh), min(sizeof(iv), key_len(fh->fh_fsid_type)));
         |                 ^~~~~~
   include/linux/compiler_types.h:618:9: note: in expansion of macro '__compiletime_assert'
     618 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:630:9: note: in expansion of macro '_compiletime_assert'
     630 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
      98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
     105 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   fs/nfsd/nfsfh.c:189:41: note: in expansion of macro 'min'
     189 |                 memcpy(iv, fh_fsid(fh), min(sizeof(iv), key_len(fh->fh_fsid_type)));
         |                                         ^~~


vim +/__compiletime_assert_1035 +630 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  616  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  617  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  618  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  619  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  620  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  621   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  622   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  623   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  624   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  625   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  626   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  627   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  628   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  629  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @630  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  631  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

