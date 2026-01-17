Return-Path: <linux-nfs+bounces-18070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BADBD38C06
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 05:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B9EB302FBC6
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 04:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA4E29D260;
	Sat, 17 Jan 2026 04:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yb2Dwb5y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8252F88;
	Sat, 17 Jan 2026 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768622624; cv=none; b=DRl1ev9VHZ0DpvnFXFBco/7nXLrKX6qg0sWt81bCxxhdMPXB/WUAnPz5WG3+5HuJJyWOhFXLZ1/2lrJD+Tn4ATxir6zq98DZY1BrOujt27p8COAGqJ+4I12ayVpExvopmXfx9ixIQ5ILwswVnpXqrtqPD93VPMAaPtihbqfipEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768622624; c=relaxed/simple;
	bh=o2qctAVvXh/9Vl33kymJtTohqLUBkoH6VdAaDc8/AdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDJzwglGz/9zESIhAJEYawxNMDQ+ZMN264yGXsm8/ivOdqoj3/4pa9CnnfymfXRYJs0o6NKIHaJCkEW7rx0y3rzNDhuHInL3HhY7VdaSvHbE7FG+QWohMgihAW7JxUIWLKl3l9RFLbfs4d5MLvz4aySOLQyHAQJx2bTTUEYLGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yb2Dwb5y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768622622; x=1800158622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o2qctAVvXh/9Vl33kymJtTohqLUBkoH6VdAaDc8/AdA=;
  b=Yb2Dwb5y9uFJ2X4nptUifah/BITlebaimKy1oFXSIW3Y0nwbeXQ61Br0
   RLRIGo61JJ2tDVY0+Q1ZUZ3RlLeyvfjPPe2sUamL8B8rM20wmDbCYIEo6
   9m3rL6OUwziJiUSRecqSgQOuIQPFiOUsUm0p1l+7T1slqV+MdkYKPSdYD
   rnniJbq3Un/F4F1VPaZpRAm9EVBVuCuNxc197TnzTVgfCixQNZOu5noEX
   wZptlZ10GXvJGhCJApJmEKmB0fUmm0lDR9QFfHdpDhdLpbL697QtrMxS1
   wg4fd+fhuviRqvhJxdmNEmXIjPd2mgtjH2vtf+kruehl6wqJONQ9LrOcU
   w==;
X-CSE-ConnectionGUID: G5rKGyJuR8ieBtV2T4VbsQ==
X-CSE-MsgGUID: dzDolOxwS8Wn65Z10Av4FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69982896"
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="69982896"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 20:03:42 -0800
X-CSE-ConnectionGUID: 9hAiUDdSQTCIHoPINYO2VQ==
X-CSE-MsgGUID: L+lRrGODRlqIEz0VgGdvnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="228393086"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jan 2026 20:03:39 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgxXE-00000000LY8-1qLn;
	Sat, 17 Jan 2026 04:03:36 +0000
Date: Sat, 17 Jan 2026 12:03:14 +0800
From: kernel test robot <lkp@intel.com>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: fix NULL pointer dereference in check_export()
Message-ID: <202601171105.1nmOHcdX-lkp@intel.com>
References: <20260116-nfsd-fixes-v1-1-019689b72747@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-nfsd-fixes-v1-1-019689b72747@kernel.org>

Hi Jeff,

kernel test robot noticed the following build errors:

[auto build test ERROR on 983d014aafb14ee5e4915465bf8948e8f3a723b5]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Layton/nfsd-fix-NULL-pointer-dereference-in-check_export/20260117-022519
base:   983d014aafb14ee5e4915465bf8948e8f3a723b5
patch link:    https://lore.kernel.org/r/20260116-nfsd-fixes-v1-1-019689b72747%40kernel.org
patch subject: [PATCH] nfsd: fix NULL pointer dereference in check_export()
config: arm64-randconfig-002-20260117 (https://download.01.org/0day-ci/archive/20260117/202601171105.1nmOHcdX-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601171105.1nmOHcdX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601171105.1nmOHcdX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfsd/export.c:408:28: error: initializing 'struct export_operations *' with an expression of type 'const struct export_operations *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     408 |         struct export_operations *export_op = inode->i_sb->s_export_op;
         |                                   ^           ~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +408 fs/nfsd/export.c

   404	
   405	static int check_export(const struct path *path, int *flags, unsigned char *uuid)
   406	{
   407		struct inode *inode = d_inode(path->dentry);
 > 408		struct export_operations *export_op = inode->i_sb->s_export_op;
   409	
   410		/*
   411		 * We currently export only dirs, regular files, and (for v4
   412		 * pseudoroot) symlinks.
   413		 */
   414		if (!S_ISDIR(inode->i_mode) &&
   415		    !S_ISLNK(inode->i_mode) &&
   416		    !S_ISREG(inode->i_mode))
   417			return -ENOTDIR;
   418	
   419		/*
   420		 * Mountd should never pass down a writeable V4ROOT export, but,
   421		 * just to make sure:
   422		 */
   423		if (*flags & NFSEXP_V4ROOT)
   424			*flags |= NFSEXP_READONLY;
   425	
   426		/* There are four requirements on a filesystem to be exportable:
   427		 * 1: It must define sb->s_export_op
   428		 * 2: We must be able to identify the filesystem from a number.
   429		 *       either a device number (so FS_REQUIRES_DEV needed)
   430		 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
   431		 * 3: We must be able to find an inode from a filehandle.
   432		 *       This means that s_export_op must be set.
   433		 * 4: We must not currently be on an idmapped mount.
   434		 */
   435		if (!export_op) {
   436			dprintk("%s: fs doesn't define export_operations!\n", __func__);
   437			return -EINVAL;
   438		}
   439	
   440		if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
   441		    !(*flags & NFSEXP_FSID) &&
   442		    uuid == NULL) {
   443			dprintk("exp_export: export of non-dev fs without fsid\n");
   444			return -EINVAL;
   445		}
   446	
   447		if (!exportfs_can_decode_fh(export_op)) {
   448			dprintk("exp_export: export of invalid fs type.\n");
   449			return -EINVAL;
   450		}
   451	
   452		if (is_idmapped_mnt(path->mnt)) {
   453			dprintk("exp_export: export of idmapped mounts not yet supported.\n");
   454			return -EINVAL;
   455		}
   456	
   457		if (export_op->flags & EXPORT_OP_NOSUBTREECHK &&
   458		    !(*flags & NFSEXP_NOSUBTREECHECK)) {
   459			dprintk("%s: %s does not support subtree checking!\n",
   460				__func__, inode->i_sb->s_type->name);
   461			return -EINVAL;
   462		}
   463		return 0;
   464	}
   465	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

