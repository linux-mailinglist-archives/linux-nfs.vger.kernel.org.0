Return-Path: <linux-nfs+bounces-20727-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gISyEe0+1mm6CggAu9opvQ
	(envelope-from <linux-nfs+bounces-20727-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 13:41:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EF23BB646
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C31EC3022F44
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831513B960B;
	Wed,  8 Apr 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9cSIVQY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE83B960C;
	Wed,  8 Apr 2026 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648403; cv=none; b=Gl1mSysWfGNSnbij+W3yFUTriigU/Yf+VuXOerag01IYyiZ2Dis7THO6isWfot1+1SXr/9RldP8EMMsUFy2wuURGBY4RdQt/PtSSSR9xUjtM90w0zNDFUEa4ug4bWWPqUGsV6kV48nnGd/OHa3K8eqLkbYHjP4NmvG+7WcA4TrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648403; c=relaxed/simple;
	bh=BUioR/XgKoUAPtzCym7DZM1FsOS/cvLTkuYQ6tBQKgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CstMoacm7PyG78hoK+IU2+qwKutQwuWYL5ulw2E7Xhe648HPPdznWd3xNoEM4ivxtXvLo8P4YJ+S/9CWhfF0Y+DFxFMWFWdSNPHh9YxNyFgBGahzK6G//Ngpg8TCltvKBsCOChcs5So/bSJD9otDCA5c0Ev1KgQHztZid6ITTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9cSIVQY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775648398; x=1807184398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BUioR/XgKoUAPtzCym7DZM1FsOS/cvLTkuYQ6tBQKgM=;
  b=D9cSIVQYqA3hLX1UnnQ9eC7BRbolnZogZIWg6WOQ8h80OAGsdW/ezcEP
   xM49FIFubxs0ANMnBwC9C+ChCYEwR6B60Wor9GCvMhD7Rj+nFhgT0Hw5B
   qnihH8lcuC91BO6nZmKUT8QX26f2MWv7aTT+5rVG597Lyw5wxFWjFudNm
   uOv0ztif3hCh4zhgBaOuYiuX0Mc0Mb+q8uG6YvQdAiPlubGlGlzIuH48T
   xTIgtb3bwZ+W7Avpyap3rjdmYw2QJRIUrbEfP5nxqkFB4KLW2BDtY4F+o
   TwC4XbeXh2YK2beA+pN1QxuQUyxfe6te9rzUrtBg9NzQiJavK5M0mHe2t
   A==;
X-CSE-ConnectionGUID: ivkealkFRIGPT3mU3D3VCw==
X-CSE-MsgGUID: wSWGZpIpQqq+WBVlHHOyUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="86919984"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="86919984"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 04:39:56 -0700
X-CSE-ConnectionGUID: uKkfM7wQQjaSs+vzkvblNg==
X-CSE-MsgGUID: HCxBRTACRd+9WDQgXFj35Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="230116189"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Apr 2026 04:39:53 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wARGA-000000001nJ-3X2T;
	Wed, 08 Apr 2026 11:39:50 +0000
Date: Wed, 8 Apr 2026 19:39:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Roberts <ben.roberts@gsacapital.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ben Roberts <ben.roberts@gsacapital.com>
Subject: Re: [PATCH] pNFS: deadlock in pnfs_send_layoutreturn
Message-ID: <202604081929.yB1AglTU-lkp@intel.com>
References: <20260407152035.4034628-1-ben.roberts@gsacapital.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407152035.4034628-1-ben.roberts@gsacapital.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-20727-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: B0EF23BB646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ben,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v7.0-rc7 next-20260407]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Roberts/pNFS-deadlock-in-pnfs_send_layoutreturn/20260408-135718
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260407152035.4034628-1-ben.roberts%40gsacapital.com
patch subject: [PATCH] pNFS: deadlock in pnfs_send_layoutreturn
config: powerpc-motionpro_defconfig (https://download.01.org/0day-ci/archive/20260408/202604081929.yB1AglTU-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c80443cd37b2e2788cba67ffa180a6331e5f0791)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604081929.yB1AglTU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604081929.yB1AglTU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfs/pnfs.c:1364:35: error: expected ';' after expression
    1364 |                 pnfs_clear_layoutreturn_info(lo)
         |                                                 ^
         |                                                 ;
   1 error generated.


vim +1364 fs/nfs/pnfs.c

  1345	
  1346	static int
  1347	pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo,
  1348			       const nfs4_stateid *stateid,
  1349			       const struct cred **pcred,
  1350			       enum pnfs_iomode iomode,
  1351			       unsigned int flags)
  1352	{
  1353		struct inode *ino = lo->plh_inode;
  1354		struct pnfs_layoutdriver_type *ld = NFS_SERVER(ino)->pnfs_curr_ld;
  1355		struct nfs4_layoutreturn *lrp;
  1356		const struct cred *cred = *pcred;
  1357		int status = 0;
  1358	
  1359		*pcred = NULL;
  1360		lrp = kzalloc_obj(*lrp, nfs_io_gfp_mask());
  1361		if (unlikely(lrp == NULL)) {
  1362			status = -ENOMEM;
  1363			spin_lock(&ino->i_lock);
> 1364			pnfs_clear_layoutreturn_info(lo)
  1365			pnfs_clear_layoutreturn_waitbit(lo);
  1366			spin_unlock(&ino->i_lock);
  1367			put_cred(cred);
  1368			pnfs_put_layout_hdr(lo);
  1369			goto out;
  1370		}
  1371	
  1372		pnfs_init_layoutreturn_args(&lrp->args, lo, stateid, iomode);
  1373		lrp->args.ld_private = &lrp->ld_private;
  1374		lrp->clp = NFS_SERVER(ino)->nfs_client;
  1375		lrp->cred = cred;
  1376		if (ld->prepare_layoutreturn)
  1377			ld->prepare_layoutreturn(&lrp->args);
  1378	
  1379		status = nfs4_proc_layoutreturn(lrp, flags);
  1380	out:
  1381		dprintk("<-- %s status: %d\n", __func__, status);
  1382		return status;
  1383	}
  1384	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

