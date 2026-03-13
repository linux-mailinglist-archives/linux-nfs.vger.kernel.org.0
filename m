Return-Path: <linux-nfs+bounces-20153-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO1SFKdKtGk4kAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20153-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 18:34:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A694B288299
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 18:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6773D31218F4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B33CA4AF;
	Fri, 13 Mar 2026 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOFxjPoY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987B3C661F;
	Fri, 13 Mar 2026 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423135; cv=none; b=tfTC1oOy0ypLyV4oVavbMiocwiTnELxjDqilWWD8dAsyKF2AOxDosfHQ2OtMRxQtmvtsCzQ2j9dEBgh+TDFp8xbaOPtfxgk3lHpaD3V3zxaG1IK9luf8rVDb11lMNfyixrOeimvCgbcGAav1bodGztcR6l/+24zBLEMmWSwmqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423135; c=relaxed/simple;
	bh=HJwwVv2RA2dbg+i/2rH99tF219pPYLKATfbktrRH93c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcDMx8Oc+cGXpVTVmkLHIIIicYEXwaN2OcAAOfMtdTHGESn4SawP7ppZNVjqMDKHA0REylhf+7DbkDfvzi6TDc9lbvwF6oS+/kFQCYGelsonwWYyF9cOuQavJv8ynfs9hUkL3mpaPFlagfcnI7F63eN5PFWHHFn1ZZJ/yinyk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOFxjPoY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773423132; x=1804959132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HJwwVv2RA2dbg+i/2rH99tF219pPYLKATfbktrRH93c=;
  b=SOFxjPoYnT36Y3g0MUic19T/Nnonp/9BFusszJv/1L5XdtKylMVFz31q
   7ACve32KvB0feCwz/0FcyqpFUnl7MR7OvjjX60SQJEq8ooQ9o1MRrLq0P
   DHP+G+xTEd2RqZLzEM5QmNO9xePzRdeZPv5DdITvGSKa17FpwPGsxwh4+
   r6pvbx/3GImU6dKY7O4FGEHVZRbNcei6KhT5EbyrPa85F6SehEiXsIuaK
   pcNCVeECyX3hZop8j0NkQOGVR0I0lchaHZ1UzYD6V6U1Pw00ZdvUs+1uF
   EsEjhthHAifVBTj3puVQ/fKm3UK3q1U2EGM2hEWK0qAqI69oA5kJVWnwp
   A==;
X-CSE-ConnectionGUID: yB7Z55fNQYqdZkzOP7dRLQ==
X-CSE-MsgGUID: ut+aFmNXQbWdb5+ejWH/xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74428853"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74428853"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:32:11 -0700
X-CSE-ConnectionGUID: QwWhFS3uSxSSMwSkJMJApw==
X-CSE-MsgGUID: hExZxTDcQhqhnsBrhfq2Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225920696"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Mar 2026 10:32:05 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w16Mj-0000000045v-3Gee;
	Fri, 13 Mar 2026 17:32:01 +0000
Date: Sat, 14 Mar 2026 01:31:03 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/2] svcrdma: Use contiguous pages for RDMA Read sink
 buffers
Message-ID: <202603140114.GgjjcDjb-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20153-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,lst.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,git-scm.com:url]
X-Rspamd-Queue-Id: A694B288299
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260314/202603140114.GgjjcDjb-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603140114.GgjjcDjb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603140114.GgjjcDjb-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/sunrpc/xprtrdma/svc_rdma_rw.c: In function 'svc_rdma_fill_contig_bvec':
>> net/sunrpc/xprtrdma/svc_rdma_rw.c:813:17: error: implicit declaration of function 'svc_rqst_page_release'; did you mean 'svc_rdma_cc_release'? [-Wimplicit-function-declaration]
     813 |                 svc_rqst_page_release(rqstp,
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 svc_rdma_cc_release


vim +813 net/sunrpc/xprtrdma/svc_rdma_rw.c

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

