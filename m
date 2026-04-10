Return-Path: <linux-nfs+bounces-20803-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMjgI6iK2GkIewgAu9opvQ
	(envelope-from <linux-nfs+bounces-20803-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 07:29:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F23D24E1
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 07:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EAC230166D8
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 05:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DE33AD81;
	Fri, 10 Apr 2026 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiJttg6A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081C33689E;
	Fri, 10 Apr 2026 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798949; cv=none; b=ilXMNbrPG5aJ9/wyO+D5VunU31io5m6tSvCay0b8sov1AiNkgcGB99Ztop1Vq+1PLCZ+eNOOBjpYPVhdOy/G4bZumMupASMani0UKqW4WQk7VytMw9PWS3I8WzcnEjU50yzR4XyjCPwrES5TtHT6d20GdTSeuhO+kvpx/W6Tix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798949; c=relaxed/simple;
	bh=TJuL6fnKndOq/B2Po1dJCLMG2PxGh8VzGl4t/B/vjgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcNIwbU8tg0FDuNxsH4tq+Q1CnEFktE+WnAf7q2B6Kqp0Dgkq4YjmKp0iBnpTSdAPk9B5XL32hAjlXwS6H1x/5xsfQpe97ytAZhs8nuqGFKpgl8BxcCLoDkr7ng5+p3QU6d9ms2q5GiVIE1ymY6IoGjR1srnlV9dR3YwYRKfUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiJttg6A; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775798948; x=1807334948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TJuL6fnKndOq/B2Po1dJCLMG2PxGh8VzGl4t/B/vjgU=;
  b=hiJttg6A4aOcisTWpn47VotINlGLrYBSmsJlxrU/QnrkGfkCQQbIfFtj
   9q0MiCpuDEjJKJRlsr2Ru/gRuRGpEkHUQXLU4k93IuIhlOJOaO/lp4mld
   BDZKVRR/toGpYaD0xc6vq7f2jAyICo9iw1MqHxWUHqvUDaMUZZKDHMRm+
   dlDnoHjwkioRrTRBoH+6B0FjggZc+bwiqQ22vthljWsC43WjV7GheNvcx
   06MaIG6+5zELqfEuA0HifuqKLOUgn/KwfKjLvi++QJTI52bd9PWgiiJ7W
   f6eUxQ2Fd1e10wF+r7ALNFNYQM7zZwiztYvUD1W3JfqLceKTqXwgR4z6J
   g==;
X-CSE-ConnectionGUID: VxxHLtwETGms8f79GdqCCA==
X-CSE-MsgGUID: ngWze85LS5KktQmjRWNHQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76833435"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76833435"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:29:07 -0700
X-CSE-ConnectionGUID: H61ElRjaSUa3uHxkwwRDXg==
X-CSE-MsgGUID: 0qHPoffYRt2EydB3lDJd5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="266960652"
Received: from lkp-server01.sh.intel.com (HELO 6449335cace3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Apr 2026 22:29:05 -0700
Received: from kbuild by 6449335cace3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wB4QQ-000000003HP-2Tkw;
	Fri, 10 Apr 2026 05:29:02 +0000
Date: Fri, 10 Apr 2026 13:28:46 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Roberts <ben.roberts@gsacapital.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Roberts <ben.roberts@gsacapital.com>
Subject: Re: [PATCH] pNFS: deadlock in pnfs_send_layoutreturn
Message-ID: <202604101309.6eRanxOC-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-20803-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,git-scm.com:url]
X-Rspamd-Queue-Id: E98F23D24E1
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
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20260410/202604101309.6eRanxOC-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260410/202604101309.6eRanxOC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604101309.6eRanxOC-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfs/pnfs.c: In function 'pnfs_send_layoutreturn':
>> fs/nfs/pnfs.c:1364:49: error: expected ';' before 'pnfs_clear_layoutreturn_waitbit'
    1364 |                 pnfs_clear_layoutreturn_info(lo)
         |                                                 ^
         |                                                 ;
    1365 |                 pnfs_clear_layoutreturn_waitbit(lo);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  


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

