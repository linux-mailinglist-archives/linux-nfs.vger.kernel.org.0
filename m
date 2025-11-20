Return-Path: <linux-nfs+bounces-16614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C39C738CE
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 11:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7AF0C30624
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A90A2BE621;
	Thu, 20 Nov 2025 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+TNDxtU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA52FDC4C
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763635680; cv=none; b=KevKSooalJ7jT6IC/QUXB4Sgaqv5xP4QjNAOMq/9PauFeruGsPsdxzbXfYgvVBkLPUIHx4dYmLDEvZS9q36CFBHJchQmkwfzJlm2wTECrCbHvPQnXJ5F3UF80FVX+dmxpdCPC33kVQAW5hcqAEV3jvNK/YfRTmEqpVXo7XWMDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763635680; c=relaxed/simple;
	bh=+f6vHs801sMrjz5rvjmF+die3pJ8G8Lg9Uz35dtwWfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9uD/by+hcJv7B5Fu9lDtZ/yUKlmh4TgjnP5Fi2zyFu0IaBYs66TGdyXhtc8HcciB0rHNbgP1T98tu+L5MlwG+Mkyo3oxnK8XF+dpWnKsKXtPmILK+Yz5b2RbFwj580h8lQXUXr9YeGij03Xjo8Z2yQDH+qNhXyIy3sujjXrcYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+TNDxtU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763635677; x=1795171677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+f6vHs801sMrjz5rvjmF+die3pJ8G8Lg9Uz35dtwWfI=;
  b=L+TNDxtUey0ucLucx9Bac1Ux6mFSC3aRU6m+7+mXnTstza/11PGppXEB
   R0/lAUbxLMFsP4be3PpbeU8HJZGo9WN3l5ldAUeYflyAQaiyoMb/z6XbN
   xb4BXEWMQcbEbujonC8ZXF/OnQ/Rtgv4x8vlCBnWzuW65E4lufa3qTdhF
   z+IKEqqFnOgXI4cl3TR9Y5fLX5CLwaXIK/r740yIZZ0Ut77uBg/fAa9za
   ro1KkZPvhJgOEcfqkHaminF7mdDGwwgKwSY1yY05WI09WlyF7wekh6BSx
   d+LkUvgOfSmQMx1ZUwyP1kuglcsXHBnbG+0yEXE9hQbgUX3mvgUZE1+Ct
   g==;
X-CSE-ConnectionGUID: PG3IRJzqQ2SudJKEr2ExvA==
X-CSE-MsgGUID: Ac91H3wlRpmu/k4SqHsVfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65786645"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65786645"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 02:47:57 -0800
X-CSE-ConnectionGUID: vpXKtyfoQ6WQqUcPMDH9AQ==
X-CSE-MsgGUID: bTdTU3boSMuumhM/q3xaaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="196297517"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 20 Nov 2025 02:47:55 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM2Cf-0003rn-0m;
	Thu, 20 Nov 2025 10:47:53 +0000
Date: Thu, 20 Nov 2025 18:47:45 +0800
From: kernel test robot <lkp@intel.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Michael Stoler <michael.stoler@vastdata.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/3] NFS: Initialise verifiers for visible dentries in
 _nfs4_open_and_get_state
Message-ID: <202511201835.LXbDRKN5-lkp@intel.com>
References: <4c4b51c67f7b38e4df4cb389007058e37ade0d14.1763560328.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4b51c67f7b38e4df4cb389007058e37ade0d14.1763560328.git.trond.myklebust@hammerspace.com>

Hi Trond,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.18-rc6 next-20251119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Trond-Myklebust/NFS-Initialise-verifiers-for-visible-dentries-in-readdir-and-lookup/20251119-222523
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/4c4b51c67f7b38e4df4cb389007058e37ade0d14.1763560328.git.trond.myklebust%40hammerspace.com
patch subject: [PATCH 3/3] NFS: Initialise verifiers for visible dentries in _nfs4_open_and_get_state
config: hexagon-randconfig-6002-20251120 (https://download.01.org/0day-ci/archive/20251120/202511201835.LXbDRKN5-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511201835.LXbDRKN5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511201835.LXbDRKN5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfs/nfs4proc.c:3188:19: warning: variable 'dentry' is uninitialized when used here [-Wuninitialized]
    3188 |         nfs_set_verifier(dentry, dir_verifier);
         |                          ^~~~~~
   fs/nfs/nfs4proc.c:3152:23: note: initialize the variable 'dentry' to silence this warning
    3152 |         struct dentry *dentry;
         |                              ^
         |                               = NULL
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_GPIO
   Depends on [n]: GPIOLIB [=y] && OF [=n] && HAS_IOMEM [=y]
   Selected by [y]:
   - GPIO_TB10X [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && (ARC_PLAT_TB10X || COMPILE_TEST [=y])
   WARNING: unmet direct dependencies detected for MFD_STMFX
   Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
   Selected by [y]:
   - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && OF_GPIO [=y] && HAS_IOMEM [=y]
   WARNING: unmet direct dependencies detected for GPIO_SYSCON
   Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF [=n]
   Selected by [y]:
   - GPIO_SAMA5D2_PIOBU [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF_GPIO [=y] && (ARCH_AT91 || COMPILE_TEST [=y])


vim +/dentry +3188 fs/nfs/nfs4proc.c

aa53ed541a1fec Jeff Layton       2007-06-05  3146  
c21443c2c792cd Trond Myklebust   2013-02-07  3147  static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
d564d2c4c2445c ChenXiaoSong      2022-09-23  3148  		struct nfs_open_context *ctx)
c21443c2c792cd Trond Myklebust   2013-02-07  3149  {
c21443c2c792cd Trond Myklebust   2013-02-07  3150  	struct nfs4_state_owner *sp = opendata->owner;
c21443c2c792cd Trond Myklebust   2013-02-07  3151  	struct nfs_server *server = sp->so_server;
275bb307865a31 Trond Myklebust   2013-05-29  3152  	struct dentry *dentry;
c21443c2c792cd Trond Myklebust   2013-02-07  3153  	struct nfs4_state *state;
1bf85d8c987564 Trond Myklebust   2019-06-27  3154  	fmode_t acc_mode = _nfs4_ctx_to_accessmode(ctx);
cf5b4059ba7197 Trond Myklebust   2020-02-05  3155  	struct inode *dir = d_inode(opendata->dir);
cf5b4059ba7197 Trond Myklebust   2020-02-05  3156  	unsigned long dir_verifier;
c21443c2c792cd Trond Myklebust   2013-02-07  3157  	int ret;
c21443c2c792cd Trond Myklebust   2013-02-07  3158  
cf5b4059ba7197 Trond Myklebust   2020-02-05  3159  	dir_verifier = nfs_save_change_attribute(dir);
c21443c2c792cd Trond Myklebust   2013-02-07  3160  
3b65a30df9b3f1 Fred Isaman       2016-09-19  3161  	ret = _nfs4_proc_open(opendata, ctx);
dca780016dab84 Trond Myklebust   2014-10-23  3162  	if (ret != 0)
c21443c2c792cd Trond Myklebust   2013-02-07  3163  		goto out;
c21443c2c792cd Trond Myklebust   2013-02-07  3164  
ae55e59da0e401 Trond Myklebust   2018-05-22  3165  	state = _nfs4_opendata_to_nfs4_state(opendata);
c21443c2c792cd Trond Myklebust   2013-02-07  3166  	ret = PTR_ERR(state);
c21443c2c792cd Trond Myklebust   2013-02-07  3167  	if (IS_ERR(state))
c21443c2c792cd Trond Myklebust   2013-02-07  3168  		goto out;
a974deee477af8 Trond Myklebust   2017-02-08  3169  	ctx->state = state;
c21443c2c792cd Trond Myklebust   2013-02-07  3170  	if (server->caps & NFS_CAP_POSIX_LOCK)
c21443c2c792cd Trond Myklebust   2013-02-07  3171  		set_bit(NFS_STATE_POSIX_LOCKS, &state->flags);
a8ce377a5db8d3 Jeff Layton       2016-09-17  3172  	if (opendata->o_res.rflags & NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK)
a8ce377a5db8d3 Jeff Layton       2016-09-17  3173  		set_bit(NFS_STATE_MAY_NOTIFY_LOCK, &state->flags);
43245eca6e670e Olga Kornievskaia 2022-02-02  3174  	if (opendata->o_res.rflags & NFS4_OPEN_RESULT_PRESERVE_UNLINKED)
43245eca6e670e Olga Kornievskaia 2022-02-02  3175  		set_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(state->inode)->flags);
c21443c2c792cd Trond Myklebust   2013-02-07  3176  
cf5b4059ba7197 Trond Myklebust   2020-02-05  3177  	switch(opendata->o_arg.claim) {
cf5b4059ba7197 Trond Myklebust   2020-02-05  3178  	default:
cf5b4059ba7197 Trond Myklebust   2020-02-05  3179  		break;
cf5b4059ba7197 Trond Myklebust   2020-02-05  3180  	case NFS4_OPEN_CLAIM_NULL:
cf5b4059ba7197 Trond Myklebust   2020-02-05  3181  	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
cf5b4059ba7197 Trond Myklebust   2020-02-05  3182  	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
cf5b4059ba7197 Trond Myklebust   2020-02-05  3183  		if (!opendata->rpc_done)
cf5b4059ba7197 Trond Myklebust   2020-02-05  3184  			break;
820620516993c1 Trond Myklebust   2024-06-16  3185  		if (opendata->o_res.delegation.type != 0)
cf5b4059ba7197 Trond Myklebust   2020-02-05  3186  			dir_verifier = nfs_save_change_attribute(dir);
26573137bc0af6 Trond Myklebust   2025-11-19  3187  	}
cf5b4059ba7197 Trond Myklebust   2020-02-05 @3188  	nfs_set_verifier(dentry, dir_verifier);
26573137bc0af6 Trond Myklebust   2025-11-19  3189  
26573137bc0af6 Trond Myklebust   2025-11-19  3190  	dentry = opendata->dentry;
26573137bc0af6 Trond Myklebust   2025-11-19  3191  	if (d_really_is_negative(dentry)) {
26573137bc0af6 Trond Myklebust   2025-11-19  3192  		struct dentry *alias;
26573137bc0af6 Trond Myklebust   2025-11-19  3193  		d_drop(dentry);
26573137bc0af6 Trond Myklebust   2025-11-19  3194  		alias = d_splice_alias(igrab(state->inode), dentry);
26573137bc0af6 Trond Myklebust   2025-11-19  3195  		/* d_splice_alias() can't fail here - it's a non-directory */
26573137bc0af6 Trond Myklebust   2025-11-19  3196  		if (alias) {
26573137bc0af6 Trond Myklebust   2025-11-19  3197  			dput(ctx->dentry);
26573137bc0af6 Trond Myklebust   2025-11-19  3198  			nfs_set_verifier(alias, dir_verifier);
26573137bc0af6 Trond Myklebust   2025-11-19  3199  			ctx->dentry = dentry = alias;
26573137bc0af6 Trond Myklebust   2025-11-19  3200  		}
275bb307865a31 Trond Myklebust   2013-05-29  3201  	}
275bb307865a31 Trond Myklebust   2013-05-29  3202  
af9b6d7570ca9a Trond Myklebust   2018-06-29  3203  	/* Parse layoutget results before we check for access */
af9b6d7570ca9a Trond Myklebust   2018-06-29  3204  	pnfs_parse_lgopen(state->inode, opendata->lgp, ctx);
af9b6d7570ca9a Trond Myklebust   2018-06-29  3205  
d564d2c4c2445c ChenXiaoSong      2022-09-23  3206  	ret = nfs4_opendata_access(sp->so_cred, opendata, state, acc_mode);
c21443c2c792cd Trond Myklebust   2013-02-07  3207  	if (ret != 0)
c21443c2c792cd Trond Myklebust   2013-02-07  3208  		goto out;
c21443c2c792cd Trond Myklebust   2013-02-07  3209  
0460253913e50a Trond Myklebust   2024-02-24  3210  	if (d_inode(dentry) == state->inode)
c45ffdd2696130 Trond Myklebust   2013-05-29  3211  		nfs_inode_attach_open_context(ctx);
2409a976a2990e Fred Isaman       2016-10-06  3212  
c21443c2c792cd Trond Myklebust   2013-02-07  3213  out:
2135e5d56278ff Trond Myklebust   2022-08-02  3214  	if (!opendata->cancelled) {
6949493884fe88 Trond Myklebust   2022-05-14  3215  		if (opendata->lgp) {
6949493884fe88 Trond Myklebust   2022-05-14  3216  			nfs4_lgopen_release(opendata->lgp);
6949493884fe88 Trond Myklebust   2022-05-14  3217  			opendata->lgp = NULL;
6949493884fe88 Trond Myklebust   2022-05-14  3218  		}
ae55e59da0e401 Trond Myklebust   2018-05-22  3219  		nfs4_sequence_free_slot(&opendata->o_res.seq_res);
2135e5d56278ff Trond Myklebust   2022-08-02  3220  	}
c21443c2c792cd Trond Myklebust   2013-02-07  3221  	return ret;
c21443c2c792cd Trond Myklebust   2013-02-07  3222  }
c21443c2c792cd Trond Myklebust   2013-02-07  3223  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

