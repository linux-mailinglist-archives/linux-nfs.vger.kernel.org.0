Return-Path: <linux-nfs+bounces-3240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55108C37D2
	for <lists+linux-nfs@lfdr.de>; Sun, 12 May 2024 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7201C2088E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 May 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8F84B5AE;
	Sun, 12 May 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSlyGTD0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716F46BA6
	for <linux-nfs@vger.kernel.org>; Sun, 12 May 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536328; cv=none; b=JAnsQO9x1T1GAMdGr3rtP/Bpgjsy0aLB+dtKqwiC4YwQGRivzhGuw9R6qQqe0SEMKXYIv6MeCOGGdbjBiu3hvaVfueNvlrMt2nMYwVMrLNgDKX9gKBQIG/4dulpnrlZm9V/llXW5YGbzSITP47ypWmQe3yyNdWrJhQh/QPs1MxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536328; c=relaxed/simple;
	bh=bE0CCVeH5nNdWOoghl2oxlkKIdUC+GGfUa1T1yy0+S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loCQlYKvlOtt1+6bTkT1wwtQyVG4kamXrIK8T1LhtheDH2gPIoiWWaVKbGJ8/g1J0O+6aK07VQmZENaMTCFz34yJM1n7yPtmrf3olMBPi4l4G+72ZpGnIQkdi24QVrh0DRNEvl3FX7HquYOZpJ8iAOoyDeS5LTH0E6c4mI7tKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSlyGTD0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715536327; x=1747072327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bE0CCVeH5nNdWOoghl2oxlkKIdUC+GGfUa1T1yy0+S0=;
  b=OSlyGTD0ydWvtfrzjDO2fM/ew6O+5dSrkCkBgBEOXZUIiFsfvhhiHzkR
   Cfo6hW/QFK1Pjr3YnAvhuzDx+wJ8Chh83Ba6hCHdlqxxkeh2j0gG39oOo
   JEKZRiF8f5+/cyVAqiA/T3BXW24LK7j3sLlgx5O2JHzGuHJf/b/wkipBL
   yKRjTKr+SPCrca3sK8zI5IYir92jQAcvom6p7Q8jcHIX7fC+0K6DUnaSC
   gIe/8yXHj+5mSLqRt1m3oEKDChdUAwwse6zO8xxl7Qaq+VOcACK/I4TKK
   6nUlZf5hW/mRlk0AoYqWVJyCrHd4th7yMyf+YQAhEM67LWkPWwwM01JPm
   w==;
X-CSE-ConnectionGUID: 2dNE9srrTmu/HOoZ96mzyA==
X-CSE-MsgGUID: F14/iIyQQDWlwqAyRsodJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11687848"
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="11687848"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 10:52:06 -0700
X-CSE-ConnectionGUID: vJLdLRUiQ4i0LJQ7rUddeQ==
X-CSE-MsgGUID: xWb0F1b5TfmeugCaBjaPCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="34799617"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 May 2024 10:52:04 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6DMg-0008nr-0L;
	Sun, 12 May 2024 17:52:02 +0000
Date: Mon, 13 May 2024 01:51:43 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Aloni <dan.aloni@vastdata.com>, chuck.lever@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] rpcrdma: don't decref EP if a ESTABLISHED did not happen
Message-ID: <202405130122.S5dgt6et-lkp@intel.com>
References: <20240505124910.1877325-1-dan.aloni@vastdata.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505124910.1877325-1-dan.aloni@vastdata.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Aloni/rpcrdma-don-t-decref-EP-if-a-ESTABLISHED-did-not-happen/20240505-205016
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20240505124910.1877325-1-dan.aloni%40vastdata.com
patch subject: [PATCH] rpcrdma: don't decref EP if a ESTABLISHED did not happen
config: parisc-randconfig-r081-20240512 (https://download.01.org/0day-ci/archive/20240513/202405130122.S5dgt6et-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405130122.S5dgt6et-lkp@intel.com/

smatch warnings:
net/sunrpc/xprtrdma/verbs.c:254 rpcrdma_cm_event_handler() warn: inconsistent indenting

vim +254 net/sunrpc/xprtrdma/verbs.c

87cfb9a0c85ce4 Chuck Lever         2016-09-15  213  
ae38288eb73c52 Chuck Lever         2018-10-01  214  /**
ae38288eb73c52 Chuck Lever         2018-10-01  215   * rpcrdma_cm_event_handler - Handle RDMA CM events
ae38288eb73c52 Chuck Lever         2018-10-01  216   * @id: rdma_cm_id on which an event has occurred
ae38288eb73c52 Chuck Lever         2018-10-01  217   * @event: details of the event
ae38288eb73c52 Chuck Lever         2018-10-01  218   *
ae38288eb73c52 Chuck Lever         2018-10-01  219   * Called with @id's mutex held. Returns 1 if caller should
ae38288eb73c52 Chuck Lever         2018-10-01  220   * destroy @id, otherwise 0.
ae38288eb73c52 Chuck Lever         2018-10-01  221   */
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  222  static int
ae38288eb73c52 Chuck Lever         2018-10-01  223  rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  224  {
745b734c9bb805 Chuck Lever         2020-02-21  225  	struct sockaddr *sap = (struct sockaddr *)&id->route.addr.dst_addr;
e28ce90083f032 Chuck Lever         2020-02-21  226  	struct rpcrdma_ep *ep = id->context;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  227  
ae38288eb73c52 Chuck Lever         2018-10-01  228  	might_sleep();
ae38288eb73c52 Chuck Lever         2018-10-01  229  
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  230  	switch (event->event) {
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  231  	case RDMA_CM_EVENT_ADDR_RESOLVED:
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  232  	case RDMA_CM_EVENT_ROUTE_RESOLVED:
93aa8e0a9de80e Chuck Lever         2020-02-21  233  		ep->re_async_rc = 0;
93aa8e0a9de80e Chuck Lever         2020-02-21  234  		complete(&ep->re_done);
316a616e788658 Chuck Lever         2018-10-01  235  		return 0;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  236  	case RDMA_CM_EVENT_ADDR_ERROR:
93aa8e0a9de80e Chuck Lever         2020-02-21  237  		ep->re_async_rc = -EPROTO;
93aa8e0a9de80e Chuck Lever         2020-02-21  238  		complete(&ep->re_done);
316a616e788658 Chuck Lever         2018-10-01  239  		return 0;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  240  	case RDMA_CM_EVENT_ROUTE_ERROR:
93aa8e0a9de80e Chuck Lever         2020-02-21  241  		ep->re_async_rc = -ENETUNREACH;
93aa8e0a9de80e Chuck Lever         2020-02-21  242  		complete(&ep->re_done);
316a616e788658 Chuck Lever         2018-10-01  243  		return 0;
bebd031866caa4 Chuck Lever         2017-04-11  244  	case RDMA_CM_EVENT_DEVICE_REMOVAL:
745b734c9bb805 Chuck Lever         2020-02-21  245  		pr_info("rpcrdma: removing device %s for %pISpc\n",
745b734c9bb805 Chuck Lever         2020-02-21  246  			ep->re_id->device->name, sap);
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  247  		fallthrough;
e28ce90083f032 Chuck Lever         2020-02-21  248  	case RDMA_CM_EVENT_ADDR_CHANGE:
93aa8e0a9de80e Chuck Lever         2020-02-21  249  		ep->re_connect_status = -ENODEV;
e28ce90083f032 Chuck Lever         2020-02-21  250  		goto disconnected;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  251  	case RDMA_CM_EVENT_ESTABLISHED:
2acc5cae292355 Chuck Lever         2020-06-15  252  		rpcrdma_ep_get(ep);
c58f2c9a4198e3 Dan Aloni           2024-05-05  253                 ep->re_connect_ref = true;
93aa8e0a9de80e Chuck Lever         2020-02-21 @254  		ep->re_connect_status = 1;
745b734c9bb805 Chuck Lever         2020-02-21  255  		rpcrdma_update_cm_private(ep, &event->param.conn);
745b734c9bb805 Chuck Lever         2020-02-21  256  		trace_xprtrdma_inline_thresh(ep);
93aa8e0a9de80e Chuck Lever         2020-02-21  257  		wake_up_all(&ep->re_connect_wait);
31e62d25b5b815 Chuck Lever         2018-10-01  258  		break;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  259  	case RDMA_CM_EVENT_CONNECT_ERROR:
93aa8e0a9de80e Chuck Lever         2020-02-21  260  		ep->re_connect_status = -ENOTCONN;
af667527b0e349 Chuck Lever         2020-06-27  261  		goto wake_connect_worker;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  262  	case RDMA_CM_EVENT_UNREACHABLE:
93aa8e0a9de80e Chuck Lever         2020-02-21  263  		ep->re_connect_status = -ENETUNREACH;
af667527b0e349 Chuck Lever         2020-06-27  264  		goto wake_connect_worker;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  265  	case RDMA_CM_EVENT_REJECTED:
93aa8e0a9de80e Chuck Lever         2020-02-21  266  		ep->re_connect_status = -ECONNREFUSED;
0a90487bf7182c Chuck Lever         2017-02-08  267  		if (event->status == IB_CM_REJ_STALE_CONN)
4cf44be6f1e86d Chuck Lever         2020-06-27  268  			ep->re_connect_status = -ENOTCONN;
af667527b0e349 Chuck Lever         2020-06-27  269  wake_connect_worker:
af667527b0e349 Chuck Lever         2020-06-27  270  		wake_up_all(&ep->re_connect_wait);
af667527b0e349 Chuck Lever         2020-06-27  271  		return 0;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  272  	case RDMA_CM_EVENT_DISCONNECTED:
93aa8e0a9de80e Chuck Lever         2020-02-21  273  		ep->re_connect_status = -ECONNABORTED;
31e62d25b5b815 Chuck Lever         2018-10-01  274  disconnected:
c487eb7d8e4157 Chuck Lever         2020-06-15  275  		rpcrdma_force_disconnect(ep);
c58f2c9a4198e3 Dan Aloni           2024-05-05  276  		if (ep->re_connect_ref)
2acc5cae292355 Chuck Lever         2020-06-15  277  			return rpcrdma_ep_put(ep);
c58f2c9a4198e3 Dan Aloni           2024-05-05  278  		return 0;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  279  	default:
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  280  		break;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  281  	}
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  282  
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  283  	return 0;
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  284  }
c56c65fb67d646 \"Talpey, Thomas\   2007-09-10  285  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

