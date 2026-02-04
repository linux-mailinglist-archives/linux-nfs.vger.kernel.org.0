Return-Path: <linux-nfs+bounces-18683-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IzVFqnxgmmWfQMAu9opvQ
	(envelope-from <linux-nfs+bounces-18683-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 08:13:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE20DE2910
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 08:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51F0E302F712
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 07:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5938B7A9;
	Wed,  4 Feb 2026 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgBCh9h1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE216226863;
	Wed,  4 Feb 2026 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189186; cv=none; b=RdnVBOh0h9a5ROdgm79nC9OAu7i7A6hpZal52sKnUTiCjwanEr7l3+f4Qc0RJLxunsgp33XbbvG6/vyK5ja5Xto/EaftI8MFSGzYqm5n/zMUOQZaSaw7sGzxGOimS7rqK9Q9uKFwi9isJIyVjr/ewH1b3WP1safdxjuNHaeJv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189186; c=relaxed/simple;
	bh=02qV1wRhkupr57wdfslXPJ7GaoBObNT0IGEKd2BaOXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J36m5B0VybqXlqExH9P4iBNTgJykhLaHIdBbKkcMyRTPu+4oaBgq7zfwHOOEyOlH7O5xZ0NCcoalyCfp3Yd8EiblwO4K8+Zfo1XmEMLK7VvPr9PcxNHiB6cvEw51dJ995U5aM8p35xyMah8QnYV8c+X2N6nSy5mBqERYyBkC94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgBCh9h1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770189187; x=1801725187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=02qV1wRhkupr57wdfslXPJ7GaoBObNT0IGEKd2BaOXg=;
  b=WgBCh9h125ff1pAB21guMZv2yBLRl4VUAQQgTUFqj63QIU6w+GEBb2BU
   I7BY00JfHDjZlGlvzqeQQmGTTyikv3nRtGIDqzrj5g38Wyikuc16lMtEs
   evoW1gUObbapPiX8W9JvLEZlVdIS6O9BwaYVmpWaVVRmIBPojccaeKxmY
   BCazRHabfX9vc+ntF++XJk0iJryBVRB1yoIqJaDo7ULw6doqyRi6T+Wf9
   PVpp/uDMtUmAtSfpsNDhTswt3FDOCJIN4j2KVw6Zd9FpKFRZ67kaTiRn6
   sDK8nRNQjfEAJ3K1ZSoVmKavinr94vlGk0d97/BWuZkTSit37nXwgOBCv
   g==;
X-CSE-ConnectionGUID: r1NAbIcySQuAcYK/gaTumw==
X-CSE-MsgGUID: C4wIfq2OQ9CqekOhDS7QuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71096869"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71096869"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 23:13:06 -0800
X-CSE-ConnectionGUID: +YL51UHGReKn9pvGG2pz4Q==
X-CSE-MsgGUID: 8kwQ20YORa2sIOOD1RQT+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214624061"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 03 Feb 2026 23:13:02 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnX4N-000000003ev-1pmm;
	Wed, 04 Feb 2026 07:12:59 +0000
Date: Wed, 4 Feb 2026 08:12:01 +0100
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] sunrpc: Fix compilation error (`make W=1`) when
 dprintk() is no-op
Message-ID: <202602040816.q9CtxevA-lkp@intel.com>
References: <20260204010415.2149607-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204010415.2149607-1-andriy.shevchenko@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,oracle.com,talpey.com,kernel.org,gmail.com,google.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-18683-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE20DE2910
X-Rspamd-Action: no action

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.19-rc8 next-20260203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/sunrpc-Fix-compilation-error-make-W-1-when-dprintk-is-no-op/20260204-091033
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260204010415.2149607-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260204/202602040816.q9CtxevA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602040816.q9CtxevA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602040816.q9CtxevA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfsd/nfsfh.c:110:45: error: use of undeclared identifier 'buf'
     110 |                         svc_print_addr(rqstp, buf, sizeof(buf)));
         |                                                           ^
   fs/nfsd/nfsfh.c:110:33: error: use of undeclared identifier 'buf'
     110 |                         svc_print_addr(rqstp, buf, sizeof(buf)));
         |                                               ^
   2 errors generated.


vim +/buf +110 fs/nfsd/nfsfh.c

9d7ed1355db5b0 J. Bruce Fields 2018-03-08  101  
6fa02839bf9412 J. Bruce Fields 2007-11-12  102  static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
b0d87dbd8bd311 NeilBrown       2024-09-05  103  					  struct svc_cred *cred,
6fa02839bf9412 J. Bruce Fields 2007-11-12  104  					  struct svc_export *exp)
6fa02839bf9412 J. Bruce Fields 2007-11-12  105  {
6fa02839bf9412 J. Bruce Fields 2007-11-12  106  	/* Check if the request originated from a secure port. */
b0d87dbd8bd311 NeilBrown       2024-09-05  107  	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
5216a8e70e25b0 Pavel Emelyanov 2008-02-21  108  		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
a48fd0f9f77b6e Kinglong Mee    2014-05-29  109  		dprintk("nfsd: request from insecure port %s!\n",
6fa02839bf9412 J. Bruce Fields 2007-11-12 @110  		        svc_print_addr(rqstp, buf, sizeof(buf)));
6fa02839bf9412 J. Bruce Fields 2007-11-12  111  		return nfserr_perm;
6fa02839bf9412 J. Bruce Fields 2007-11-12  112  	}
6fa02839bf9412 J. Bruce Fields 2007-11-12  113  
6fa02839bf9412 J. Bruce Fields 2007-11-12  114  	/* Set user creds for this exportpoint */
b0d87dbd8bd311 NeilBrown       2024-09-05  115  	return nfserrno(nfsd_setuser(cred, exp));
6fa02839bf9412 J. Bruce Fields 2007-11-12  116  }
6fa02839bf9412 J. Bruce Fields 2007-11-12  117  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

