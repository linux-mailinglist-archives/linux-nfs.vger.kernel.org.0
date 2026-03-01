Return-Path: <linux-nfs+bounces-19453-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHRtKSyEo2kIFwUAu9opvQ
	(envelope-from <linux-nfs+bounces-19453-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 01:11:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2BC1C9CA9
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 01:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31A41301A7D4
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 00:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B713D503;
	Sun,  1 Mar 2026 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOf4GYwD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D84A35898;
	Sun,  1 Mar 2026 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772323871; cv=none; b=IXtfbZZI8lNEEuC8N/U6KKw6b0RxDU0szvnWD2QDPtijpSO3vBJT2Kr3BmVUDKZ1A/qK9ObcX3MNIchYsFuRtjLIFsiEUr6gJOhmv9rSLBgLi/mhG5smdTXnxf53KkebuLQKloDMOMlE+2/yN6VDC+ZKeGYXHGSX9WQsAyigCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772323871; c=relaxed/simple;
	bh=ONXxzno6W70i0D0754aFp8dUFcYS/UIq6kWcD5txpaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZlqzjkjQZi2FkWF2Ku6MMWJhlLqwTvCwb7W5xdS+t/hOF5oWuT7dvxlyt73Q4yKvX6+3brUE1AmreIvIwdVB4FMkjgtbS1nM0Vvt5hZsdHbv/lVpTe/KokuxmkEoLRhwyhoVIVozqIcuA3dNrNqnXuh5fi4SBMGiki3OLBjBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOf4GYwD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772323870; x=1803859870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ONXxzno6W70i0D0754aFp8dUFcYS/UIq6kWcD5txpaU=;
  b=XOf4GYwD9JW4NEL/BChjhgsPG8TIMaSv1AljURTa7S8PXxt5Sak8jYuk
   1VVz10FU0uCyjMSi9mM2LeLc4kIPqtQNTNqbsAWEfBUsPk5IbnRS854Db
   zZZaHTymoVqXEyjyZ659ipGkB+cFtRiF04y+ogTz1Uya9ZyWcLgVqxWV1
   Wjfhi3fW5D4dUGWnzvyR67ER6MT7QEjnsLE7XG9jNfqS+nwks73+G7mY0
   kMv/3TT10YGpSgZKOMIQUUsOfKEN11z1/Y+0lxceVUK/O4KLhrOiGm7t0
   fQLakIH+PbLNTVsgl+yyEd5vWT40iusYJK15L6ciGLYtHidAZKem+YxLc
   A==;
X-CSE-ConnectionGUID: lz1w/S3vRzWd2/BJuwxNbg==
X-CSE-MsgGUID: 8JJWMeF3Ss+BfcGxUr/LcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="95991622"
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="95991622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 16:11:09 -0800
X-CSE-ConnectionGUID: QLR4EjE4SoOY4E4QaBnIDw==
X-CSE-MsgGUID: WVMtBAvYSgmyO0557LZ29Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="244465085"
Received: from lkp-server01.sh.intel.com (HELO 59784f1c7b2a) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2026 16:11:06 -0800
Received: from kbuild by 59784f1c7b2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwUOl-000000000Ff-0oJN;
	Sun, 01 Mar 2026 00:11:03 +0000
Date: Sun, 1 Mar 2026 08:10:27 +0800
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
Message-ID: <202603010852.3RKXCwyF-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-19453-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: 2E2BC1C9CA9
X-Rspamd-Action: no action

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on trondmy-nfs/linux-next net/main net-next/main linus/master v7.0-rc1 next-20260227]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Chang/sunrpc-simplify-dfprintk-macros-and-fix-nfsd-build-error/20260301-040617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260228180821.811683-2-seanwascoding%40gmail.com
patch subject: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd build error
config: i386-randconfig-001-20260301 (https://download.01.org/0day-ci/archive/20260301/202603010852.3RKXCwyF-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260301/202603010852.3RKXCwyF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603010852.3RKXCwyF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:31,
                    from arch/x86/include/asm/bug.h:193,
                    from include/linux/bug.h:5,
                    from include/linux/slab.h:15,
                    from fs/lockd/svclock.c:25:
   fs/lockd/svclock.c: In function 'nlmsvc_lookup_block':
>> fs/lockd/svclock.c:163:33: error: implicit declaration of function 'nlmdbg_cookie2a' [-Wimplicit-function-declaration]
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
   fs/lockd/svclock.c:159:25: warning: format '%s' expects argument of type 'char *', but argument 7 has type 'int' [-Wformat=]
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


vim +/nlmdbg_cookie2a +163 fs/lockd/svclock.c

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

