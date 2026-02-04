Return-Path: <linux-nfs+bounces-18681-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF8SF7PrgmnqewMAu9opvQ
	(envelope-from <linux-nfs+bounces-18681-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 07:48:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F0E26A8
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 07:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0E773005EAA
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 06:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187A3859C1;
	Wed,  4 Feb 2026 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjlHxljS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA16385538;
	Wed,  4 Feb 2026 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187695; cv=none; b=haHMNueKrH1YCvotMQpTRVCmllC1JI0hrEfhnYrDqmH5p3GBIO/DDYho/5ME2U0I9ryvpdS43uZlMRNLmZNfAEaDq7aP7+99nbKs9PPmlyB0y9Yv4sV8eAkeHz0QogtMTFjXIgLhW/BKvwWfNNPKGBq4FEtETAzy88Ob9gXW3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187695; c=relaxed/simple;
	bh=eytSjQEfJS2BR7JXneGwEakI7L9aPPxzFGImmVRbu00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6cv977gvBQbjm390BgPwRiQgF8zQsoSj0+E/r8RyE4MO8uM1NpNCKY/JESUM0+V31hz9Tru7478LBbmJUb+ScaZdaHgQNKTMU76gCkUj1dxfSqPaZtbZ1NqrShk0CMcyr58+JinNQqiShJNrsPgqHX7Bm4zW6g60cAUEa+oj8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjlHxljS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770187695; x=1801723695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eytSjQEfJS2BR7JXneGwEakI7L9aPPxzFGImmVRbu00=;
  b=NjlHxljScijMNJuB2e3lVehPSIG5CqoAQ2/XdzabQ2wc4y+mgggXK2DL
   kugADza4QXx5FX1aInN0wS4ZLWrX5j2ZIg4QW5YekYNBe5iuU6Yh5ZoeN
   wiIUQYyFxgbTyfn2EGIc6f8T3Q+M6/W6ThzsspoL5SRPSaEcc5tNaiX7D
   17WrrtAFhULK3Id4sy/KnH3aW/vOffRxUOH+R00HnjqlnYaAWZQtaqgth
   CXml1ZZARI/VMU9vy/7BtUdiWdWlc+WuKFUOhApHeRXAANqBlH4zW/Z1d
   kodwUoWsCzDYCtuPILgIZ3IaoeEWQoIlsyxAmE1C1WuY3QC8PUpFGz8MR
   g==;
X-CSE-ConnectionGUID: tQS54p14Q4aUW04wWVwIlA==
X-CSE-MsgGUID: 5CaxSXuuR7ueLd1BNmwvOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82000551"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82000551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 22:48:14 -0800
X-CSE-ConnectionGUID: c3DbAFxLQ5qLBZdkxtyp9w==
X-CSE-MsgGUID: QQmNdES5TvauQATEWcQWAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="247674423"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Feb 2026 22:48:11 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnWgJ-00000000hX2-2ior;
	Wed, 04 Feb 2026 06:48:07 +0000
Date: Wed, 4 Feb 2026 14:48:00 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Olga Kornievskaia <okorniev@redhat.com>,
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
Message-ID: <202602041401.iqlBqvkr-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,oracle.com,talpey.com,kernel.org,gmail.com,google.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-18681-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB8F0E26A8
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
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20260204/202602041401.iqlBqvkr-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602041401.iqlBqvkr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602041401.iqlBqvkr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:31,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/m68k/include/asm/processor.h:11,
                    from include/linux/sched.h:13,
                    from include/linux/sunrpc/svcauth_gss.h:12,
                    from fs/nfsd/nfsfh.c:13:
   fs/nfsd/nfsfh.c: In function 'nfsd_setuser_and_check_port':
>> fs/nfsd/nfsfh.c:110:47: error: 'buf' undeclared (first use in this function); did you mean 'btf'?
     110 |                         svc_print_addr(rqstp, buf, sizeof(buf)));
         |                                               ^~~
   include/linux/printk.h:135:32: note: in definition of macro 'no_printk'
     135 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                                ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/nfsd/nfsfh.c:109:17: note: in expansion of macro 'dprintk'
     109 |                 dprintk("nfsd: request from insecure port %s!\n",
         |                 ^~~~~~~
   fs/nfsd/nfsfh.c:110:47: note: each undeclared identifier is reported only once for each function it appears in
     110 |                         svc_print_addr(rqstp, buf, sizeof(buf)));
         |                                               ^~~
   include/linux/printk.h:135:32: note: in definition of macro 'no_printk'
     135 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                                ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/nfsd/nfsfh.c:109:17: note: in expansion of macro 'dprintk'
     109 |                 dprintk("nfsd: request from insecure port %s!\n",
         |                 ^~~~~~~


vim +110 fs/nfsd/nfsfh.c

9d7ed1355db5b00 J. Bruce Fields 2018-03-08  101  
6fa02839bf9412e J. Bruce Fields 2007-11-12  102  static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
b0d87dbd8bd311d NeilBrown       2024-09-05  103  					  struct svc_cred *cred,
6fa02839bf9412e J. Bruce Fields 2007-11-12  104  					  struct svc_export *exp)
6fa02839bf9412e J. Bruce Fields 2007-11-12  105  {
6fa02839bf9412e J. Bruce Fields 2007-11-12  106  	/* Check if the request originated from a secure port. */
b0d87dbd8bd311d NeilBrown       2024-09-05  107  	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
5216a8e70e25b01 Pavel Emelyanov 2008-02-21  108  		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
a48fd0f9f77b6e1 Kinglong Mee    2014-05-29  109  		dprintk("nfsd: request from insecure port %s!\n",
6fa02839bf9412e J. Bruce Fields 2007-11-12 @110  		        svc_print_addr(rqstp, buf, sizeof(buf)));
6fa02839bf9412e J. Bruce Fields 2007-11-12  111  		return nfserr_perm;
6fa02839bf9412e J. Bruce Fields 2007-11-12  112  	}
6fa02839bf9412e J. Bruce Fields 2007-11-12  113  
6fa02839bf9412e J. Bruce Fields 2007-11-12  114  	/* Set user creds for this exportpoint */
b0d87dbd8bd311d NeilBrown       2024-09-05  115  	return nfserrno(nfsd_setuser(cred, exp));
6fa02839bf9412e J. Bruce Fields 2007-11-12  116  }
6fa02839bf9412e J. Bruce Fields 2007-11-12  117  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

