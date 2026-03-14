Return-Path: <linux-nfs+bounces-20165-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPwOKSXttGm/uQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20165-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 06:07:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3617A28BAEB
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 06:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52E08304C2E3
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 05:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6C34EF17;
	Sat, 14 Mar 2026 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lflj/3Eo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7634EF11;
	Sat, 14 Mar 2026 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773464813; cv=none; b=Jk2SQ6yISyWleHdru+NE+elJDCn/FhCDbhMI2w02Plu8mMh3TvZxa8Y75lxcPNSeYEyJm+9Tet2yJvGnfFFRAXEtLNxHwYJc1+4iqmtcGQmF0Kc7OUMty263ISvKPyskdvdkcVs+uKZInX2Su9AKXD2gwWbtOje/vE/4V8O19E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773464813; c=relaxed/simple;
	bh=919cWECtI9nDP95JX3t80/DiyeQ2NSU98r0FTBoXwlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ1ywSyYtVoIeAq5MgSLwltnbdqfI0e5OAZs6TuBjQUiPPkCIZW5AFTp1FpOkHroh+v/n1SuVZWiciGNSwIqKYlJiUhXZm508X7UbcYC04lOkfHGpYJaaLFKcqFjsNIEVwpQzyuSJs06JB3IftbskWFbkjmdaq403zTfhxUGVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lflj/3Eo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773464811; x=1805000811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=919cWECtI9nDP95JX3t80/DiyeQ2NSU98r0FTBoXwlk=;
  b=Lflj/3EoeVgy3N09JaKR0MgICN0aBts8S7CQGO1KZgvUR3Y8fPUU52qb
   y7c+pVeLbpQ2iBtGLYFYw/7nXKCYhGe4rcdydLI5eI8PJtYxGeOl199HE
   k2+YCymmXnypA21THoDK6GVm6gHGuxEwxOUdBU03JcCOpzpoZlmhpHZA9
   ypN5TE+MRwsYwR5KWdkTVlibGEdNokFzdBNQ0L/7aWHiCUujQ7ZRemfap
   2dyR/DGspcvHGF2UK0v3bPT8eTxz6NgpWHDFw7eNG0P94Xe3/a15mlgiH
   0xf4BSEu7doqgjI/TT6zW+bPzWikj8/uiEABz5Rgs2OfkfbNZo3MBaqhT
   g==;
X-CSE-ConnectionGUID: v+DxYJzVRnSbhkMdxFiU7g==
X-CSE-MsgGUID: l0bjWR3EQdaWfSYmajb81Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="62136401"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="62136401"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 22:06:50 -0700
X-CSE-ConnectionGUID: ty5fyfgcTXOqimCeP2E0mQ==
X-CSE-MsgGUID: DuJcevY8REuf3+NBH17ceQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="246456319"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Mar 2026 22:06:47 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1HD2-000000004fb-0fYu;
	Sat, 14 Mar 2026 05:06:44 +0000
Date: Sat, 14 Mar 2026 13:06:04 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/2] svcrdma: Use contiguous pages for RDMA Read sink
 buffers
Message-ID: <202603141225.oTCKSz8H-lkp@intel.com>
References: <20260312134008.7387-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312134008.7387-3-cel@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20165-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,lst.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3617A28BAEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuck,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0-rc1]
[also build test ERROR on next-20260311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/RDMA-rw-Fix-MR-pool-exhaustion-in-bvec-RDMA-READ-path/20260313-085521
base:   v7.0-rc1
patch link:    https://lore.kernel.org/r/20260312134008.7387-3-cel%40kernel.org
patch subject: [PATCH v2 2/2] svcrdma: Use contiguous pages for RDMA Read sink buffers
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260314/202603141225.oTCKSz8H-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603141225.oTCKSz8H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603141225.oTCKSz8H-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sunrpc/xprtrdma/svc_rdma_rw.c:813:3: error: call to undeclared function 'svc_rqst_page_release'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   svc_rqst_page_release(rqstp,
                   ^
   net/sunrpc/xprtrdma/svc_rdma_rw.c:813:3: note: did you mean 'svc_rdma_cc_release'?
   net/sunrpc/xprtrdma/svc_rdma_rw.c:193:6: note: 'svc_rdma_cc_release' declared here
   void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
        ^
   1 error generated.


vim +/svc_rqst_page_release +813 net/sunrpc/xprtrdma/svc_rdma_rw.c

   779	
   780	/*
   781	 * svc_rdma_fill_contig_bvec - Replace rq_pages with a contiguous allocation
   782	 * @rqstp: RPC transaction context
   783	 * @head: context for ongoing I/O
   784	 * @bv: bvec entry to fill
   785	 * @pages_left: number of data pages remaining in the segment
   786	 * @len_left: bytes remaining in the segment
   787	 *
   788	 * On success, fills @bv with a bvec spanning the contiguous range and
   789	 * advances rc_curpage/rc_page_count. Returns the byte length covered,
   790	 * or zero if the allocation failed or would overrun rq_maxpages.
   791	 */
   792	static unsigned int
   793	svc_rdma_fill_contig_bvec(struct svc_rqst *rqstp,
   794				  struct svc_rdma_recv_ctxt *head,
   795				  struct bio_vec *bv, unsigned int pages_left,
   796				  unsigned int len_left)
   797	{
   798		unsigned int order, alloc_nr, chunk_pages, chunk_len, i;
   799		struct page *page;
   800	
   801		page = svc_rdma_alloc_read_pages(pages_left, &order);
   802		if (!page)
   803			return 0;
   804		alloc_nr = 1 << order;
   805	
   806		if (head->rc_curpage + alloc_nr > rqstp->rq_maxpages) {
   807			for (i = 0; i < alloc_nr; i++)
   808				__free_page(page + i);
   809			return 0;
   810		}
   811	
   812		for (i = 0; i < alloc_nr; i++) {
 > 813			svc_rqst_page_release(rqstp,
   814					      rqstp->rq_pages[head->rc_curpage + i]);
   815			rqstp->rq_pages[head->rc_curpage + i] = page + i;
   816		}
   817	
   818		chunk_pages = min(alloc_nr, pages_left);
   819		chunk_len = min_t(unsigned int, chunk_pages << PAGE_SHIFT, len_left);
   820		bvec_set_page(bv, page, chunk_len, 0);
   821		head->rc_page_count += chunk_pages;
   822		head->rc_curpage += chunk_pages;
   823		return chunk_len;
   824	}
   825	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

