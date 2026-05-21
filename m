Return-Path: <linux-nfs+bounces-21754-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E2mOFf0DmqmDQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21754-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 14:02:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE75A46ED
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 14:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35E893009B1A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114EC36A350;
	Thu, 21 May 2026 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeKkJez3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084CD28C5CB
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364578; cv=none; b=HPFH2zpL/PGA2R6gL/Ins836DUEWSOy2qjkIi+0SrXCe9xQCkQGD0n+QsZh4OE+yuN2vmgr3DNcLs22B6nZhRUHc8IHKmzUI95VKMv2Jqw9yo9b1j6EDZX1bQVItm9sXYSSvvZz7LI9IQgy6KLN1a2Nv4UqyK2IQGPpgBu+Cmy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364578; c=relaxed/simple;
	bh=7csXHxeHsDUgkLUwGgZgHc7oqSb6L/F8S4VX7J9syoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq39J7BgHEajP2gv3daWG8gwYzre4AH6aDjfxCOl3GpVHC9nldsAyfiAd9zn4KdAiopj5ztSXrPS+TL/+V62rv7tmvCVB4F4Mb4sA8p7dsrZ+Yh4fvW0APfNpRsKosGEPwy69geT0t8RWQMKKpyOE3dDsDpYXMCGGVb4AR+DGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeKkJez3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779364577; x=1810900577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7csXHxeHsDUgkLUwGgZgHc7oqSb6L/F8S4VX7J9syoA=;
  b=UeKkJez3dGzZKJ/GMWWgP9zbebDFKlr6x0Z+J7gcSTUMHDCs8DZ0uuxP
   +t5fIOGAJrXqN4G/NUtcz0FeNPoGZ3fTWWE+RK2j8xMihLxXW+bnTArHG
   npBmxxnGJzpVDI+XYjAAUWUx/eUnI2JOHMzP7HhTIZuiykgjMH1WtzW1p
   sK9qL557UbDHcuhMuEHkaYDWr0uS90CIupN4e2as/GCf7xImyHgHBjQda
   lKZw7UEgtuWQnJXOrgsn+B0g9u9RX47Buvcxi0y3MUCcm/H3gPWtFjUHC
   kJ+wOEQrDw4/+Cr+L8TtrJpPWq7nkw8OPdhMl9SWP8lvi+vHaEuOEwV5M
   Q==;
X-CSE-ConnectionGUID: RGSqgYT4RWu5nOC63ldhUQ==
X-CSE-MsgGUID: ip0yvIwUTNC/cf9VcEPJPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90855032"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="90855032"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 04:56:17 -0700
X-CSE-ConnectionGUID: inzHdNzLQnWERzAIy1Iu9g==
X-CSE-MsgGUID: 1UT2VgUhTIm7pvkwTH5grA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="234170961"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 May 2026 04:56:15 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQ20a-000000000EH-308d;
	Thu, 21 May 2026 11:56:12 +0000
Date: Thu, 21 May 2026 19:56:10 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] xprtrdma: Decouple RPC completion from Send completion
Message-ID: <202605211923.fDxJ0j7x-lkp@intel.com>
References: <20260520175016.29480-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520175016.29480-1-cel@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21754-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[intel.com:server fail,git-scm.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[lkp.intel.com:query timed out];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: 97DE75A46ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuck,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v7.1-rc4 next-20260520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/xprtrdma-Decouple-RPC-completion-from-Send-completion/20260521-025653
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260520175016.29480-1-cel%40kernel.org
patch subject: [PATCH] xprtrdma: Decouple RPC completion from Send completion
config: riscv-randconfig-r112-20260521 (https://download.01.org/0day-ci/archive/20260521/202605211923.fDxJ0j7x-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260521/202605211923.fDxJ0j7x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605211923.fDxJ0j7x-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sunrpc/xprtrdma/rpc_rdma.c:491:20: error: no member named 'bc_pa_lock' in 'struct rpc_xprt'
     491 |                 spin_lock(&xprt->bc_pa_lock);
         |                            ~~~~  ^
>> net/sunrpc/xprtrdma/rpc_rdma.c:492:24: error: no member named 'rq_bc_pa_list' in 'struct rpc_rqst'
     492 |                 list_add_tail(&rqst->rq_bc_pa_list, &xprt->bc_pa_list);
         |                                ~~~~  ^
>> net/sunrpc/xprtrdma/rpc_rdma.c:492:46: error: no member named 'bc_pa_list' in 'struct rpc_xprt'
     492 |                 list_add_tail(&rqst->rq_bc_pa_list, &xprt->bc_pa_list);
         |                                                      ~~~~  ^
   net/sunrpc/xprtrdma/rpc_rdma.c:493:22: error: no member named 'bc_pa_lock' in 'struct rpc_xprt'
     493 |                 spin_unlock(&xprt->bc_pa_lock);
         |                              ~~~~  ^
   4 errors generated.


vim +491 net/sunrpc/xprtrdma/rpc_rdma.c

   469	
   470	/* rl_kref has two owners while a Send is outstanding: the rpc_rqst
   471	 * owner and the sendctx. Replies complete the RPC but do not drop
   472	 * either reference. The req returns to rb_send_bufs only after
   473	 * xprt_rdma_free_slot() or xprt_rdma_bc_free_rqst() has dropped the
   474	 * RPC-layer reference and rpcrdma_sendctx_unmap() has dropped the
   475	 * Send-side reference.
   476	 *
   477	 * Any req held by an rpc_rqst has rl_kref >= 1. Hand-off sites
   478	 * reinitialize rl_kref before assigning a recycled req to a new owner;
   479	 * rpcrdma_prepare_send_sges() then takes the Send-side reference.
   480	 */
   481	static void rpcrdma_req_release(struct kref *kref)
   482	{
   483		struct rpcrdma_req *req =
   484			container_of(kref, struct rpcrdma_req, rl_kref);
   485		struct rpc_rqst *rqst = &req->rl_slot;
   486		struct rpc_xprt *xprt = rqst->rq_xprt;
   487		struct rpcrdma_xprt *r_xprt =
   488			container_of(xprt, struct rpcrdma_xprt, rx_xprt);
   489	
   490		if (bc_prealloc(rqst)) {
 > 491			spin_lock(&xprt->bc_pa_lock);
 > 492			list_add_tail(&rqst->rq_bc_pa_list, &xprt->bc_pa_list);
   493			spin_unlock(&xprt->bc_pa_lock);
   494			return;
   495		}
   496	
   497		/* Re-arm rl_kref before the hand-off so the next owner of
   498		 * this slot sees a positive refcount.
   499		 */
   500		kref_init(&req->rl_kref);
   501		if (!xprt_wake_up_backlog(xprt, rqst)) {
   502			memset(rqst, 0, sizeof(*rqst));
   503			rpcrdma_buffer_put(&r_xprt->rx_buf, req);
   504		}
   505	}
   506	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

