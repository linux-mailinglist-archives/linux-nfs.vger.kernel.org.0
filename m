Return-Path: <linux-nfs+bounces-3250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DB8C4405
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 17:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815AA1C20987
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3894C84;
	Mon, 13 May 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/cLTsvd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93216AC0
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613466; cv=none; b=ZGiyXCbRrsIQapJ/6jKaTeAJxYGou9OodpcQ7DWvTtO/SISXteRu0FaIPM+ll0QyK+V5I0KLf57x6FsiBnNCTlWggFstnGmDZBQ2oOnV8C9fzUhMY/OXy87LhvD69QiI1A0bbAdfxtJyNzfA3iYHl5RW263PyxWQC2w5GyWk+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613466; c=relaxed/simple;
	bh=RzGGkG00ZVn/+P8tUKwMnBvs/ytlMn9kwHiGsnUs1Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hikNus/FKlIV6kIEgTK89tIaIxD7XPgGihjA4GICKDaAXmXXG4fSEfwgV+6Jdr7pYLmWSkp/NPVTicx1MH0xxQyNDONlBMSw+qUT+5MVTMwTMnkjM8cVoTSNpvQYW1yQZcraWfldFc6NIIXIT46NQbglox1+rgEN34iQ+LO08PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/cLTsvd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715613464; x=1747149464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RzGGkG00ZVn/+P8tUKwMnBvs/ytlMn9kwHiGsnUs1Mo=;
  b=K/cLTsvd+XEJuN+sA3VHdJZPMC5IEtpXMaev37RKm9OYnN+3ejd8Qjcs
   BPv+cc7t/XP0+mDJUIpbvzYOuwbXCdLedyOn3r5rN//knON19DChCrjhp
   bmT//4RPJK02tHavPs48x2uRkdu3CdFR/quUgd4/RqpxVGLFuIBqwwxip
   WMd3bELz90RLA1pq+7UjB7ctRYCjQfVY+jnFGqpZkq4BvFBn5lfe0wWIg
   buGPqc5Cg7Wt87ysYxKkfHuw/i4bEV2hTqpw6jXcEyAmBRTxYLHAU4gIW
   dwHF3mcntHIpLfiUL9vndxaK/cHNtjpiWezrAcoCfYrbW1ccqSo5afz8j
   w==;
X-CSE-ConnectionGUID: TfkuLpmrROuiFUG2MznlDg==
X-CSE-MsgGUID: kclBakcJQ/uI8iqF5cMCHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11499956"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="11499956"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 08:17:43 -0700
X-CSE-ConnectionGUID: 2fSb6UYER8KiQbhUtFCG8Q==
X-CSE-MsgGUID: IeQwQqq3S+KEIOkkju+Emg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30404049"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 May 2024 08:17:40 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6XQn-000APV-3A;
	Mon, 13 May 2024 15:17:37 +0000
Date: Mon, 13 May 2024 23:16:46 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: change nfsd_create_setattr() to call
 nfsd_setattr() unconditionally
Message-ID: <202405132241.FduJDwA8-lkp@intel.com>
References: <171557896893.4857.2572536847924540881@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171557896893.4857.2572536847924540881@noble.neil.brown.name>

Hi NeilBrown,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240510]
[cannot apply to linus/master v6.9 v6.9-rc7 v6.9-rc6 v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfsd-change-nfsd_create_setattr-to-call-nfsd_setattr-unconditionally/20240513-134428
base:   next-20240510
patch link:    https://lore.kernel.org/r/171557896893.4857.2572536847924540881%40noble.neil.brown.name
patch subject: [PATCH] nfsd: change nfsd_create_setattr() to call nfsd_setattr() unconditionally
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240513/202405132241.FduJDwA8-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240513/202405132241.FduJDwA8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405132241.FduJDwA8-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/nfsd/vfs.c:35:
   In file included from fs/nfsd/xdr3.h:11:
   In file included from fs/nfsd/xdr.h:8:
   In file included from fs/nfsd/nfsd.h:15:
   In file included from include/linux/nfs.h:11:
   In file included from include/linux/sunrpc/msg_prot.h:205:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from fs/nfsd/vfs.c:35:
   In file included from fs/nfsd/xdr3.h:11:
   In file included from fs/nfsd/xdr.h:8:
   In file included from fs/nfsd/nfsd.h:15:
   In file included from include/linux/nfs.h:11:
   In file included from include/linux/sunrpc/msg_prot.h:205:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from fs/nfsd/vfs.c:35:
   In file included from fs/nfsd/xdr3.h:11:
   In file included from fs/nfsd/xdr.h:8:
   In file included from fs/nfsd/nfsd.h:15:
   In file included from include/linux/nfs.h:11:
   In file included from include/linux/sunrpc/msg_prot.h:205:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> fs/nfsd/vfs.c:502:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     502 |         if (!(iap->ia_valid ||
         |             ^~~~~~~~~~~~~~~~~~
     503 |               (attr->na_seclabel && attr->na_seclabel->len) ||
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     504 |               (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl) ||
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     505 |               (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     506 |                !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))))
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfsd/vfs.c:616:9: note: uninitialized use occurs here
     616 |         return err != 0 ? err : nfserrno(host_err);
         |                ^~~
   fs/nfsd/vfs.c:502:2: note: remove the 'if' if its condition is always false
     502 |         if (!(iap->ia_valid ||
         |         ^~~~~~~~~~~~~~~~~~~~~~
     503 |               (attr->na_seclabel && attr->na_seclabel->len) ||
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     504 |               (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl) ||
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     505 |               (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     506 |                !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))))
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     507 |                 /* Don't bother with inode_lock() */
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     508 |                 goto out;
         |                 ~~~~~~~~
   fs/nfsd/vfs.c:496:13: note: initialize the variable 'err' to silence this warning
     496 |         __be32          err;
         |                            ^
         |                             = 0
>> fs/nfsd/vfs.c:506:55: warning: variable 'inode' is uninitialized when used here [-Wuninitialized]
     506 |                !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))))
         |                                                              ^~~~~
   include/uapi/linux/stat.h:23:23: note: expanded from macro 'S_ISDIR'
      23 | #define S_ISDIR(m)      (((m) & S_IFMT) == S_IFDIR)
         |                            ^
   fs/nfsd/vfs.c:492:21: note: initialize the variable 'inode' to silence this warning
     492 |         struct inode    *inode;
         |                               ^
         |                                = NULL
   19 warnings generated.


vim +502 fs/nfsd/vfs.c

   472	
   473	/**
   474	 * nfsd_setattr - Set various file attributes.
   475	 * @rqstp: controlling RPC transaction
   476	 * @fhp: filehandle of target
   477	 * @attr: attributes to set
   478	 * @guardtime: do not act if ctime.tv_sec does not match this timestamp
   479	 *
   480	 * This call may adjust the contents of @attr (in particular, this
   481	 * call may change the bits in the na_iattr.ia_valid field).
   482	 *
   483	 * Returns nfs_ok on success, otherwise an NFS status code is
   484	 * returned. Caller must release @fhp by calling fh_put in either
   485	 * case.
   486	 */
   487	__be32
   488	nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
   489		     struct nfsd_attrs *attr, const struct timespec64 *guardtime)
   490	{
   491		struct dentry	*dentry;
   492		struct inode	*inode;
   493		struct iattr	*iap = attr->na_iattr;
   494		int		accmode = NFSD_MAY_SATTR;
   495		umode_t		ftype = 0;
   496		__be32		err;
   497		int		host_err = 0;
   498		bool		get_write_count;
   499		bool		size_change = (iap->ia_valid & ATTR_SIZE);
   500		int		retries;
   501	
 > 502		if (!(iap->ia_valid ||
   503		      (attr->na_seclabel && attr->na_seclabel->len) ||
   504		      (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl) ||
   505		      (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
 > 506		       !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))))
   507			/* Don't bother with inode_lock() */
   508			goto out;
   509	
   510		if (iap->ia_valid & ATTR_SIZE) {
   511			accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
   512			ftype = S_IFREG;
   513		}
   514	
   515		/*
   516		 * If utimes(2) and friends are called with times not NULL, we should
   517		 * not set NFSD_MAY_WRITE bit. Otherwise fh_verify->nfsd_permission
   518		 * will return EACCES, when the caller's effective UID does not match
   519		 * the owner of the file, and the caller is not privileged. In this
   520		 * situation, we should return EPERM(notify_change will return this).
   521		 */
   522		if (iap->ia_valid & (ATTR_ATIME | ATTR_MTIME)) {
   523			accmode |= NFSD_MAY_OWNER_OVERRIDE;
   524			if (!(iap->ia_valid & (ATTR_ATIME_SET | ATTR_MTIME_SET)))
   525				accmode |= NFSD_MAY_WRITE;
   526		}
   527	
   528		/* Callers that do fh_verify should do the fh_want_write: */
   529		get_write_count = !fhp->fh_dentry;
   530	
   531		/* Get inode */
   532		err = fh_verify(rqstp, fhp, ftype, accmode);
   533		if (err)
   534			return err;
   535		if (get_write_count) {
   536			host_err = fh_want_write(fhp);
   537			if (host_err)
   538				goto out;
   539		}
   540	
   541		dentry = fhp->fh_dentry;
   542		inode = d_inode(dentry);
   543	
   544		nfsd_sanitize_attrs(inode, iap);
   545	
   546		/*
   547		 * The size case is special, it changes the file in addition to the
   548		 * attributes, and file systems don't expect it to be mixed with
   549		 * "random" attribute changes.  We thus split out the size change
   550		 * into a separate call to ->setattr, and do the rest as a separate
   551		 * setattr call.
   552		 */
   553		if (size_change) {
   554			err = nfsd_get_write_access(rqstp, fhp, iap);
   555			if (err)
   556				return err;
   557		}
   558	
   559		inode_lock(inode);
   560		err = fh_fill_pre_attrs(fhp);
   561		if (err)
   562			goto out_unlock;
   563	
   564		if (guardtime) {
   565			struct timespec64 ctime = inode_get_ctime(inode);
   566			if ((u32)guardtime->tv_sec != (u32)ctime.tv_sec ||
   567			    guardtime->tv_nsec != ctime.tv_nsec) {
   568				err = nfserr_notsync;
   569				goto out_fill_attrs;
   570			}
   571		}
   572	
   573		for (retries = 1;;) {
   574			struct iattr attrs;
   575	
   576			/*
   577			 * notify_change() can alter its iattr argument, making
   578			 * @iap unsuitable for submission multiple times. Make a
   579			 * copy for every loop iteration.
   580			 */
   581			attrs = *iap;
   582			host_err = __nfsd_setattr(dentry, &attrs);
   583			if (host_err != -EAGAIN || !retries--)
   584				break;
   585			if (!nfsd_wait_for_delegreturn(rqstp, inode))
   586				break;
   587		}
   588		if (attr->na_seclabel && attr->na_seclabel->len)
   589			attr->na_labelerr = security_inode_setsecctx(dentry,
   590				attr->na_seclabel->data, attr->na_seclabel->len);
   591		if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl)
   592			attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
   593							dentry, ACL_TYPE_ACCESS,
   594							attr->na_pacl);
   595		if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
   596		    !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))
   597			attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
   598							dentry, ACL_TYPE_DEFAULT,
   599							attr->na_dpacl);
   600	out_fill_attrs:
   601		/*
   602		 * RFC 1813 Section 3.3.2 does not mandate that an NFS server
   603		 * returns wcc_data for SETATTR. Some client implementations
   604		 * depend on receiving wcc_data, however, to sort out partial
   605		 * updates (eg., the client requested that size and mode be
   606		 * modified, but the server changed only the file mode).
   607		 */
   608		fh_fill_post_attrs(fhp);
   609	out_unlock:
   610		inode_unlock(inode);
   611		if (size_change)
   612			put_write_access(inode);
   613	out:
   614		if (!host_err)
   615			host_err = commit_metadata(fhp);
   616		return err != 0 ? err : nfserrno(host_err);
   617	}
   618	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

