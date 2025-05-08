Return-Path: <linux-nfs+bounces-11610-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C6CAB065E
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 01:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5BD1C24D7F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB121D581;
	Thu,  8 May 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRClHWyG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9C21883C
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746745742; cv=none; b=NAyjx5ixfrpQ1ti87ejM0V/9Q+P6Ilp2/PxcnvI7rDZNuf3Z/mkBFAsrx5B+zzMesqTRHeBFAPjNMPy5ggUyziwhFSpxRy0DHarodYA0dIpE0f3KBcXm9F/uoj2JD2DxHllTTKOvc29GfckP/YwBX2HnnXR0hXA9K8twapjDOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746745742; c=relaxed/simple;
	bh=MRoRgKaaK80dFd9BoaLdxqNIvrjsg6AYGVm60FPhPVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpHIywO2ueotJtPpRKt/lvuNPd6SYlQ3dXzOlo+YfSnqK0PTjR3XcADebiZ6G9FKoIpWWOZvE2Tqe1dcUBgxiLcFtq3FCNS/4eKJnRvOOdVWP0G6MsmVN2nD6IbqJkVf2LqSOT6h1yCluN42TA+KPIeYCDpcQqoDrScPpbRWz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRClHWyG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746745739; x=1778281739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MRoRgKaaK80dFd9BoaLdxqNIvrjsg6AYGVm60FPhPVE=;
  b=FRClHWyGvrkI1YqJQGG87DB6r2P+iiHwEc49Xlz6ZUi7Svkhd1cpBEt1
   ytl6Ub5ohwsyLtmPS8FnCItc9j4EdGvBW925LrXYMlQBiQsQV5dh6DgIe
   Vy0OLn9rZ98rLxEFSidxUsg+Jz5sLo4M04uAePQ/z9DKHF0vUPYnKHBqK
   tXNAYHqMarbhQo33dVcTzM2r3QyOQ6G/TfwtFLteMH7D+WLk0UBXT0+g7
   0/aZLI6bLFmI+hyGPYOhy0LgInEcEig0EmkOcn8NTYRh7ybU83FTagaGs
   EwgP+opj3VFZ5McN7y5dp52uy/n8DDuIkfmIsMr8zQq43v+xXCaheDiAi
   g==;
X-CSE-ConnectionGUID: IbRAjm1ySAWGwEqmmt+YDQ==
X-CSE-MsgGUID: FWqMtEFQSAyI89+awu7CFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48715288"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="48715288"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 16:08:58 -0700
X-CSE-ConnectionGUID: czhanyFAQ8uyoJH+hvnbMg==
X-CSE-MsgGUID: 0QpvmaggSyiuouyNUcFvTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="136449879"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 May 2025 16:08:56 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDAMI-000BSN-0e;
	Thu, 08 May 2025 23:08:54 +0000
Date: Fri, 9 May 2025 07:08:45 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: call svc_fill_write_vector from nfsd_vfs_write
Message-ID: <202505090631.R8lqfckA-lkp@intel.com>
References: <20250507115617.3995150-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507115617.3995150-2-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on trondmy-nfs/linux-next linus/master v6.15-rc5]
[cannot apply to next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/nfsd-use-rq_bvec-instead-of-rq_vec-in-nfsd_vfs_write/20250507-205615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250507115617.3995150-2-hch%40lst.de
patch subject: [PATCH 1/3] nfsd: call svc_fill_write_vector from nfsd_vfs_write
config: x86_64-randconfig-121-20250508 (https://download.01.org/0day-ci/archive/20250509/202505090631.R8lqfckA-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505090631.R8lqfckA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505090631.R8lqfckA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/nfsd/vfs.c:1167:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __be32 @@     got int @@
   fs/nfsd/vfs.c:1167:24: sparse:     expected restricted __be32
   fs/nfsd/vfs.c:1167:24: sparse:     got int

vim +1167 fs/nfsd/vfs.c

  1142	
  1143	__be32
  1144	nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
  1145			loff_t offset, struct xdr_buf *payload, unsigned long *cnt,
  1146			int stable, __be32 *verf)
  1147	{
  1148		struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
  1149		struct file		*file = nf->nf_file;
  1150		struct super_block	*sb = file_inode(file)->i_sb;
  1151		struct svc_export	*exp;
  1152		struct iov_iter		iter;
  1153		errseq_t		since;
  1154		__be32			nfserr;
  1155		int			host_err;
  1156		loff_t			pos = offset;
  1157		unsigned long		exp_op_flags = 0;
  1158		unsigned int		pflags = current->flags;
  1159		rwf_t			flags = 0;
  1160		bool			restore_flags = false;
  1161		unsigned int		nvecs;
  1162	
  1163		trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
  1164	
  1165		nvecs = svc_fill_write_vector(rqstp, payload);
  1166		if (WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec)))
> 1167			return -EIO;
  1168	
  1169		if (sb->s_export_op)
  1170			exp_op_flags = sb->s_export_op->flags;
  1171	
  1172		if (test_bit(RQ_LOCAL, &rqstp->rq_flags) &&
  1173		    !(exp_op_flags & EXPORT_OP_REMOTE_FS)) {
  1174			/*
  1175			 * We want throttling in balance_dirty_pages()
  1176			 * and shrink_inactive_list() to only consider
  1177			 * the backingdev we are writing to, so that nfs to
  1178			 * localhost doesn't cause nfsd to lock up due to all
  1179			 * the client's dirty pages or its congested queue.
  1180			 */
  1181			current->flags |= PF_LOCAL_THROTTLE;
  1182			restore_flags = true;
  1183		}
  1184	
  1185		exp = fhp->fh_export;
  1186	
  1187		if (!EX_ISSYNC(exp))
  1188			stable = NFS_UNSTABLE;
  1189	
  1190		if (stable && !fhp->fh_use_wgather)
  1191			flags |= RWF_SYNC;
  1192	
  1193		iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
  1194		since = READ_ONCE(file->f_wb_err);
  1195		if (verf)
  1196			nfsd_copy_write_verifier(verf, nn);
  1197		host_err = vfs_iter_write(file, &iter, &pos, flags);
  1198		if (host_err < 0) {
  1199			commit_reset_write_verifier(nn, rqstp, host_err);
  1200			goto out_nfserr;
  1201		}
  1202		*cnt = host_err;
  1203		nfsd_stats_io_write_add(nn, exp, *cnt);
  1204		fsnotify_modify(file);
  1205		host_err = filemap_check_wb_err(file->f_mapping, since);
  1206		if (host_err < 0)
  1207			goto out_nfserr;
  1208	
  1209		if (stable && fhp->fh_use_wgather) {
  1210			host_err = wait_for_concurrent_writes(file);
  1211			if (host_err < 0)
  1212				commit_reset_write_verifier(nn, rqstp, host_err);
  1213		}
  1214	
  1215	out_nfserr:
  1216		if (host_err >= 0) {
  1217			trace_nfsd_write_io_done(rqstp, fhp, offset, *cnt);
  1218			nfserr = nfs_ok;
  1219		} else {
  1220			trace_nfsd_write_err(rqstp, fhp, offset, host_err);
  1221			nfserr = nfserrno(host_err);
  1222		}
  1223		if (restore_flags)
  1224			current_restore_flags(pflags, PF_LOCAL_THROTTLE);
  1225		return nfserr;
  1226	}
  1227	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

