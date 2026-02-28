Return-Path: <linux-nfs+bounces-19452-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Rt6ZEINzo2n+DQUAu9opvQ
	(envelope-from <linux-nfs+bounces-19452-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 00:00:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D263E1C9955
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 00:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8DCB300DCC8
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A217A2E3B15;
	Sat, 28 Feb 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9A9V+MP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8122301;
	Sat, 28 Feb 2026 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772319610; cv=none; b=T8QLoneh9LuJtN8FdzYD62sEoGLCAa49Rfef2nkyDclcrj/J+6pXTlwHH93kMB4peFevo3eHbEYwFMYGuODdEGOC7ULQ7tinZd2Kl3rQiL1wChlxG7/aiz2kUDdd6a62hexc25q7RN9jrH/3/phVgJunVlT/iB2U29Qx4HLQT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772319610; c=relaxed/simple;
	bh=CA41Vn24wX6RSeEc5LWDsLgaRnDDgxClpHN45ZDUJNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6b2fF4nAbonCxWofmgZfMxlJCzvJ1fzOH3iJ7BsMehhHPZrcxV+hODAeQeoaR0+AWHP4luEHvsgkaKLRNQjgxFsGLjtWxLmrnp3gqFzfy9mM7vRSskChHTnHqeTOJ+cmvzGSCfMmC8qiuW/iwa/aVaojU2eln1jGFBDPxBpR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9A9V+MP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772319608; x=1803855608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CA41Vn24wX6RSeEc5LWDsLgaRnDDgxClpHN45ZDUJNg=;
  b=T9A9V+MPS2OLe0Js8bTcyhkgLLMsq/CCOxO2aUuoalAGkxPgO40+LIn3
   nI+DNcU8nko5MnW/1C3eo53TlmLziUUrCDxIsmV53I969nJm+OjOo/1xy
   iSsiOFH7dEIvPT9Jd+udKoheQIE6SZVj6cWLCt8dwXrTzt2TykRJ8fujF
   +HVnR6uOYAXKkXdwpvN9+yvasjxN8mquj46ft5PRFiBs6njcQjS1mgitC
   zeGdAkSFjWx55gywqIC4NdYCvuFGHMFLzngT0L2nHWg8fOMFq4YMXWrXh
   Plkx5va55/ci+2UwpWI2rcraG+qlTsF8w6GAs4yRZwCgLW2dhhNt4Naxn
   g==;
X-CSE-ConnectionGUID: BmC3h41gTD2ezvzttOXjYw==
X-CSE-MsgGUID: Kbjp18EjQLac1AC/jW3rNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="84006700"
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="84006700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 15:00:07 -0800
X-CSE-ConnectionGUID: dRm9DMVSQa+hyaYT/9mLTw==
X-CSE-MsgGUID: qi+SwdjYSQatF3kPr1p8PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="215338553"
Received: from lkp-server01.sh.intel.com (HELO 59784f1c7b2a) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Feb 2026 15:00:04 -0800
Received: from kbuild by 59784f1c7b2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwTI1-000000000Eb-3UU7;
	Sat, 28 Feb 2026 23:00:01 +0000
Date: Sun, 1 Mar 2026 06:59:13 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Chang <seanwascoding@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: Re: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd
 build error
Message-ID: <202603010612.uRmHYMsi-lkp@intel.com>
References: <20260228180821.811683-2-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228180821.811683-2-seanwascoding@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-19452-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,oracle.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: D263E1C9955
X-Rspamd-Action: no action

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on trondmy-nfs/linux-next net/main net-next/main linus/master v7.0-rc1 next-20260227]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Chang/sunrpc-simplify-dfprintk-macros-and-fix-nfsd-build-error/20260301-040617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260228180821.811683-2-seanwascoding%40gmail.com
patch subject: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd build error
config: i386-randconfig-001-20260301 (https://download.01.org/0day-ci/archive/20260301/202603010612.uRmHYMsi-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260301/202603010612.uRmHYMsi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603010612.uRmHYMsi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:31,
                    from arch/x86/include/asm/bug.h:193,
                    from include/linux/bug.h:5,
                    from include/linux/slab.h:15,
                    from fs/lockd/svclock.c:25:
   fs/lockd/svclock.c: In function 'nlmsvc_lookup_block':
   fs/lockd/svclock.c:163:33: error: implicit declaration of function 'nlmdbg_cookie2a' [-Wimplicit-function-declaration]
     163 |                                 nlmdbg_cookie2a(&block->b_call->a_args.cookie));
         |                                 ^~~~~~~~~~~~~~~
   include/linux/printk.h:134:32: note: in definition of macro 'no_printk'
     134 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                                ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:23:9: note: in expansion of macro 'dfprintk'
      23 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/lockd/svclock.c:159:17: note: in expansion of macro 'dprintk'
     159 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                 ^~~~~~~
>> fs/lockd/svclock.c:159:25: warning: format '%s' expects argument of type 'char *', but argument 7 has type 'int' [-Wformat=]
     159 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ......
     163 |                                 nlmdbg_cookie2a(&block->b_call->a_args.cookie));
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/printk.h:134:25: note: in definition of macro 'no_printk'
     134 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                         ^~~
   include/linux/sunrpc/debug.h:23:9: note: in expansion of macro 'dfprintk'
      23 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/lockd/svclock.c:159:17: note: in expansion of macro 'dprintk'
     159 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                 ^~~~~~~
   fs/lockd/svclock.c:159:72: note: format string is defined here
     159 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                                                                       ~^
         |                                                                        |
         |                                                                        char *
         |                                                                       %d
   fs/lockd/svclock.c: In function 'nlmsvc_find_block':
   fs/lockd/svclock.c:202:17: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'int' [-Wformat=]
     202 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~~~~~~~~~~~~~~~~~~~~
         |                                                      |
         |                                                      int
   include/linux/printk.h:134:25: note: in definition of macro 'no_printk'
     134 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                         ^~~
   include/linux/sunrpc/debug.h:23:9: note: in expansion of macro 'dfprintk'
      23 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~
   fs/lockd/svclock.c:202:9: note: in expansion of macro 'dprintk'
     202 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |         ^~~~~~~
   fs/lockd/svclock.c:202:37: note: format string is defined here
     202 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |                                    ~^
         |                                     |
         |                                     char *
         |                                    %d


vim +159 fs/lockd/svclock.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  141  
^1da177e4c3f41 Linus Torvalds  2005-04-16  142  /*
d9f6eb75d49007 Trond Myklebust 2006-03-20  143   * Find a block for a given lock
^1da177e4c3f41 Linus Torvalds  2005-04-16  144   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  145  static struct nlm_block *
d9f6eb75d49007 Trond Myklebust 2006-03-20  146  nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
^1da177e4c3f41 Linus Torvalds  2005-04-16  147  {
68a2d76cea4234 Olaf Kirch      2006-10-04  148  	struct nlm_block	*block;
^1da177e4c3f41 Linus Torvalds  2005-04-16  149  	struct file_lock	*fl;
^1da177e4c3f41 Linus Torvalds  2005-04-16  150  
^1da177e4c3f41 Linus Torvalds  2005-04-16  151  	dprintk("lockd: nlmsvc_lookup_block f=%p pd=%d %Ld-%Ld ty=%d\n",
eb8ed7c6ab08cd Jeff Layton     2024-01-31  152  				file, lock->fl.c.flc_pid,
^1da177e4c3f41 Linus Torvalds  2005-04-16  153  				(long long)lock->fl.fl_start,
eb8ed7c6ab08cd Jeff Layton     2024-01-31  154  				(long long)lock->fl.fl_end,
eb8ed7c6ab08cd Jeff Layton     2024-01-31  155  				lock->fl.c.flc_type);
be2be5f7f44364 Alexander Aring 2023-07-20  156  	spin_lock(&nlm_blocked_lock);
68a2d76cea4234 Olaf Kirch      2006-10-04  157  	list_for_each_entry(block, &nlm_blocked, b_list) {
92737230dd3f14 Trond Myklebust 2006-03-20  158  		fl = &block->b_call->a_args.lock.fl;
^1da177e4c3f41 Linus Torvalds  2005-04-16 @159  		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
eb8ed7c6ab08cd Jeff Layton     2024-01-31  160  				block->b_file, fl->c.flc_pid,
^1da177e4c3f41 Linus Torvalds  2005-04-16  161  				(long long)fl->fl_start,
eb8ed7c6ab08cd Jeff Layton     2024-01-31  162  				(long long)fl->fl_end, fl->c.flc_type,
92737230dd3f14 Trond Myklebust 2006-03-20  163  				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
^1da177e4c3f41 Linus Torvalds  2005-04-16  164  		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
6849c0cab69f5d Trond Myklebust 2006-03-20  165  			kref_get(&block->b_count);
be2be5f7f44364 Alexander Aring 2023-07-20  166  			spin_unlock(&nlm_blocked_lock);
^1da177e4c3f41 Linus Torvalds  2005-04-16  167  			return block;
^1da177e4c3f41 Linus Torvalds  2005-04-16  168  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  169  	}
be2be5f7f44364 Alexander Aring 2023-07-20  170  	spin_unlock(&nlm_blocked_lock);
^1da177e4c3f41 Linus Torvalds  2005-04-16  171  
^1da177e4c3f41 Linus Torvalds  2005-04-16  172  	return NULL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  173  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  174  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

