Return-Path: <linux-nfs+bounces-19454-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X3BnFRCJo2k1GQUAu9opvQ
	(envelope-from <linux-nfs+bounces-19454-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 01:32:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA01C9CFB
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 01:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B3253008219
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB960175A74;
	Sun,  1 Mar 2026 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHvrv3MJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC24C8F0;
	Sun,  1 Mar 2026 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772325132; cv=none; b=XHzprip87SiFik0ZvFWvVQE8X93zeWfdlM1oBdYOOqL1m9oRDDDPv/cIsdYXjvVMBPLGFqkkq8c/BJ9QZWXLNcCVMCrBx7TVDCczv1TFqSWW71+V5S7r65i650iNZ5cnklvIe2g+ZViHdzicvoaktamXRYwFTFRoccuHQ7tTSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772325132; c=relaxed/simple;
	bh=TlSSePKM3GuJDulN8PdgjjrxcYit8AN/yoJ6NfQ3SZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etd3yutUPBuB/K2v282pBdDhjcP/DWa7R68S1+oqslH+3Yxjg76uQZEUBCTsEYHT7DKcj4H08dw0ZWvMFhk+jWYNryl+4PF5z1l4X6JzQzG0EOohrAt2mxOGtW0oF13i4MurB9V/VCuyZQVuK4I3SiXaPa/Uh0DaOUoMz67e3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHvrv3MJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772325130; x=1803861130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TlSSePKM3GuJDulN8PdgjjrxcYit8AN/yoJ6NfQ3SZw=;
  b=fHvrv3MJ5TqRLeXqN0mpG5k6py2uwr9QlhueGZNg0c1csppjty8Re882
   kUIBwfgFr6MisBaOANrcZX4LDJ0J8UxNqNDwce+6cQJ6RAdqXTP5iUPrV
   e16hMFh1L1LklLujsLHd5ZrPs9Tqrv6UARfuAp/yIozgEYIi86hC9eef9
   bAyl5nt62sXWKKIO4nafw3n38mEhW9zbj2Vsat3z+tb0SwZemcCp1sToz
   bx4zQQhynNuIeWdloYtFucY9NIp1oP1OLSS1kDE2BYVkhzOnzkKZki46I
   MEt4kFCFjAcvd0zF6bOHXSr+RDg3/JumCmfzGCMEARL2fnqfW8ETcH6Rz
   Q==;
X-CSE-ConnectionGUID: soEx6cL9RmqsU61jDo2EsA==
X-CSE-MsgGUID: oQ71yKeCQKaXYuc/E3KFtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="84458569"
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="84458569"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 16:32:09 -0800
X-CSE-ConnectionGUID: ftQmhjOyTgS4E1dLQyxjoA==
X-CSE-MsgGUID: BrReWZ8RQpmzGbICru2SAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="247763191"
Received: from lkp-server01.sh.intel.com (HELO 59784f1c7b2a) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Feb 2026 16:32:07 -0800
Received: from kbuild by 59784f1c7b2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwUj5-000000000GD-2Gah;
	Sun, 01 Mar 2026 00:32:03 +0000
Date: Sun, 1 Mar 2026 08:31:05 +0800
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
Message-ID: <202603010808.w3TtG6fC-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-19454-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,01.org:url,git-scm.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67FA01C9CFB
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
config: i386-randconfig-141-20260301 (https://download.01.org/0day-ci/archive/20260301/202603010808.w3TtG6fC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260301/202603010808.w3TtG6fC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603010808.w3TtG6fC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/lockd/svclock.c:163:5: error: call to undeclared function 'nlmdbg_cookie2a'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     163 |                                 nlmdbg_cookie2a(&block->b_call->a_args.cookie));
         |                                 ^
>> fs/lockd/svclock.c:163:5: warning: format specifies type 'char *' but the argument has type 'int' [-Wformat]
     159 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
         |                                                                       ~~
         |                                                                       %d
     160 |                                 block->b_file, fl->c.flc_pid,
     161 |                                 (long long)fl->fl_start,
     162 |                                 (long long)fl->fl_end, fl->c.flc_type,
     163 |                                 nlmdbg_cookie2a(&block->b_call->a_args.cookie));
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:23:28: note: expanded from macro 'dprintk'
      23 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |                            ~~~    ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:55:40: note: expanded from macro 'dfprintk'
      55 | # define dfprintk(fac, ...)             no_printk(__VA_ARGS__)
         |                                                   ^~~~~~~~~~~
   include/linux/printk.h:134:18: note: expanded from macro 'no_printk'
     134 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                         ~~~    ^~~~~~~~~~~
   fs/lockd/svclock.c:202:47: error: call to undeclared function 'nlmdbg_cookie2a'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     202 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |                                                      ^
   fs/lockd/svclock.c:202:47: warning: format specifies type 'char *' but the argument has type 'int' [-Wformat]
     202 |         dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
         |                                    ~~                ^~~~~~~~~~~~~~~~~~~~~~~
         |                                    %d
   include/linux/sunrpc/debug.h:23:28: note: expanded from macro 'dprintk'
      23 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |                            ~~~    ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:55:40: note: expanded from macro 'dfprintk'
      55 | # define dfprintk(fac, ...)             no_printk(__VA_ARGS__)
         |                                                   ^~~~~~~~~~~
   include/linux/printk.h:134:18: note: expanded from macro 'no_printk'
     134 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                         ~~~    ^~~~~~~~~~~
   2 warnings and 2 errors generated.


vim +163 fs/lockd/svclock.c

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
^1da177e4c3f41 Linus Torvalds  2005-04-16  159  		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
eb8ed7c6ab08cd Jeff Layton     2024-01-31  160  				block->b_file, fl->c.flc_pid,
^1da177e4c3f41 Linus Torvalds  2005-04-16  161  				(long long)fl->fl_start,
eb8ed7c6ab08cd Jeff Layton     2024-01-31  162  				(long long)fl->fl_end, fl->c.flc_type,
92737230dd3f14 Trond Myklebust 2006-03-20 @163  				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
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

