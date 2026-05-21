Return-Path: <linux-nfs+bounces-21751-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN2sGCHlDmopDAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21751-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 12:57:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A25A3ACC
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 12:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 479EA31538E6
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBAA38C2A5;
	Thu, 21 May 2026 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCTOrLCy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8D3A0EB8
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359658; cv=none; b=ZOX1lrJN7V4xrUvoQRZNbDN3QVoKgi6n1/QgwCGs79vXViRYJGUoI3wkHTen7fF55r4VKfLCO6YyX6WlIX7J/xIA80oYBW8va6zpzU+XxtMp7AkLKsL6Q/JOc1vpQJOqfYz1x5Rbw7wsNUvmi2TrsVeXSHEdBEJdAKtPJyvE8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359658; c=relaxed/simple;
	bh=i6dOJimL7UoM3Ig6Uc87lfZZDGEaj8t6BZY/dhGsuo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZjJvG86piGTq5byAd+R/eWXVYXUudOzuJPdOKllNFEzpzldOcNkGtUiGCQs9BY+xr2vaXKyCOfqLn7cXtP5x2R6COxYcaMVYAmtQwRiMg9F7bkTJqK6MAhPq0kpwSv9AfSZhY12bsEQCfiYjw9SO6P1ejHUGql5ytRwon6Eedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCTOrLCy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779359657; x=1810895657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i6dOJimL7UoM3Ig6Uc87lfZZDGEaj8t6BZY/dhGsuo0=;
  b=GCTOrLCy+d47nDL2O3cm/TAyMsGK2qmyVbNpCtdiSIhaifCZRldFXa8W
   02CLypnqglrIeRmIi6uUOpwGLLMFiZGauYG9AcgBQ05OVUtIc8lnEQoTY
   TFsoaMqL+6Y6GVpYlNFM5WRPMYaarKmoen0TQilUEx7obUCjMU6yRgjyh
   oqTrqJerfnrVdd6So7V9ebI6zAaHk/VAcF7ARyvVZ9Hn8nmwGHKi21JUc
   4UE92T1zneCJsrSvLKUwfUcAegt4+hV+PKegKWJ0Tq/1zIwA1OQOYCO4G
   Adev+utTY3tJPfQEZWg37pBZhsnF+sXrxNfK5p6gVPCK3XFWZCiFZluSg
   Q==;
X-CSE-ConnectionGUID: tjn4ImWsSFSbMssjIp/jxg==
X-CSE-MsgGUID: 8kWh4EUeTKOe3pbRDHryjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80004695"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80004695"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:34:16 -0700
X-CSE-ConnectionGUID: 3AaGs3WiRrqYxKKxBxhfHQ==
X-CSE-MsgGUID: NexNmXv+RAu8a+xh1yh/gw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 May 2026 03:34:14 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQ0jE-0000000007v-0CAW;
	Thu, 21 May 2026 10:34:12 +0000
Date: Thu, 21 May 2026 18:33:43 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] xprtrdma: Decouple RPC completion from Send completion
Message-ID: <202605211828.lbkVyryr-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21751-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,git-scm.com:url]
X-Rspamd-Queue-Id: A71A25A3ACC
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
config: nios2-randconfig-r123-20260521 (https://download.01.org/0day-ci/archive/20260521/202605211828.lbkVyryr-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260521/202605211828.lbkVyryr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605211828.lbkVyryr-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/sunrpc/xprtrdma/rpc_rdma.c: In function 'rpcrdma_req_release':
>> net/sunrpc/xprtrdma/rpc_rdma.c:491:20: error: 'struct rpc_xprt' has no member named 'bc_pa_lock'; did you mean 'queue_lock'?
      spin_lock(&xprt->bc_pa_lock);
                       ^~~~~~~~~~
                       queue_lock
>> net/sunrpc/xprtrdma/rpc_rdma.c:492:24: error: 'struct rpc_rqst' has no member named 'rq_bc_pa_list'; did you mean 'rq_enc_pages'?
      list_add_tail(&rqst->rq_bc_pa_list, &xprt->bc_pa_list);
                           ^~~~~~~~~~~~~
                           rq_enc_pages
>> net/sunrpc/xprtrdma/rpc_rdma.c:492:44: error: 'struct rpc_xprt' has no member named 'bc_pa_list'
      list_add_tail(&rqst->rq_bc_pa_list, &xprt->bc_pa_list);
                                               ^~
   net/sunrpc/xprtrdma/rpc_rdma.c:493:22: error: 'struct rpc_xprt' has no member named 'bc_pa_lock'; did you mean 'queue_lock'?
      spin_unlock(&xprt->bc_pa_lock);
                         ^~~~~~~~~~
                         queue_lock


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

