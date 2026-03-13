Return-Path: <linux-nfs+bounces-20143-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GSxFGTQs2ncbAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20143-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 09:52:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C448227FF9C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 09:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 128CB3066E7A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F01D555;
	Fri, 13 Mar 2026 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmQgJS4R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7C36DA10;
	Fri, 13 Mar 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391947; cv=none; b=FS6SnOI6MRLD5SVlLJj7EcmdLeRZqExGPht4FGytwNjLKc5LNMfjhJ2ijRG++vZ2HjQhs+CcTp93deySBRWnRBvcn2oTJX2GA/txug47kE6ZbXdcoyg/AHz0ZpMMlJ5VVbcvzXrXNw4I2NGcyd2I3mhJPr8PsptDCIFSVomBP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391947; c=relaxed/simple;
	bh=lZ3lBGbYmfesU6djG9QpJJr/DfqPJsN9/UjRCQexuZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2Mk24ClKpxZqjlmF2XxNPJbLTBY3D2qmA0+sELv2dx0xIe9UuxXIRDWus0Yxu6DcWkumzqSHcKCuRu2BRKlC2CZfJ8mOAEjnSl8Gwgd+M8NUzSQVCHCyH5t5XkQpc7sUkAP33x9zGLucrldO2lo6/0CvNp4V5zjMpFNuHL5cGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmQgJS4R; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773391941; x=1804927941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lZ3lBGbYmfesU6djG9QpJJr/DfqPJsN9/UjRCQexuZM=;
  b=dmQgJS4Rq2WUSBc6iXre7kT3g9JvZwkWFHLZMwKQSYQLnRRJxVuNCFWK
   Tr9pL1CMmV4LU0s3/T1tRrZXjEL7Xj4/TL77rj0hQnHTv/0f1BZizqeno
   T748IzxYRJNfIwwuIddcY5wQImsTJ3qt0dBOdWO4GdUzW3hgn+yDigEZO
   QmibXImyi9eXY3541gFOc05H00Idrnr71/kVIpQI7i2Oz4Y7UJBsN+v2G
   1JVYj7ZqRuz8TsWTYjibxxCHRNsSNKAaYD7xGHzgbamgTLdQynw9Lmac0
   f8B9/vwYlGWLr4ysHBvG8WOT4cEztqkGrrhc8YAq9PcRmo6cW8pnYoB7K
   w==;
X-CSE-ConnectionGUID: DnCb5mT0R5moaLTwlGD+zg==
X-CSE-MsgGUID: o30i6/TsQy+Yi4201He01g==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="77104866"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="77104866"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:52:19 -0700
X-CSE-ConnectionGUID: ashUcFW0TQiqhBKTa0kdxQ==
X-CSE-MsgGUID: cjHnzSbRQyK+lxmiMZsmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="220183772"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 13 Mar 2026 01:52:12 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0yFd-000000003dx-1idq;
	Fri, 13 Mar 2026 08:52:09 +0000
Date: Fri, 13 Mar 2026 09:51:23 +0100
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
Message-ID: <202603130922.uCz0Ofwx-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-20143-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: C448227FF9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuck,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0-rc1]
[also build test ERROR on next-20260312]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/RDMA-rw-Fix-MR-pool-exhaustion-in-bvec-RDMA-READ-path/20260313-085521
base:   v7.0-rc1
patch link:    https://lore.kernel.org/r/20260312134008.7387-3-cel%40kernel.org
patch subject: [PATCH v2 2/2] svcrdma: Use contiguous pages for RDMA Read sink buffers
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260313/202603130922.uCz0Ofwx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260313/202603130922.uCz0Ofwx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603130922.uCz0Ofwx-lkp@intel.com/

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

