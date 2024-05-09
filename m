Return-Path: <linux-nfs+bounces-3225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C18C1771
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 22:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613ED1C21DA8
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 20:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBF82871;
	Thu,  9 May 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3eZy0K9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAACE82876;
	Thu,  9 May 2024 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286208; cv=none; b=bHADHbe6WLtay5NAhJUW6YuH7C65skXEOzh1pdrY0jX7h7OPRCmSLxW2h0flwY5vO8M0FI0YkGHa7sQ7zgur3EzwCVmxOWNXTzTz9LnT9AtSILxskGsRZwNSTKUrgdNtnW8W+9O9zDnrwa64OrzMddSgcmYaYEghhl7pUBbaHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286208; c=relaxed/simple;
	bh=rtE9Cf6G7+LfHndtSwMnyj8o++JOJ/aihDJUuBRTqS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1NHlnd7IUAGb6pFaT2p8E5vMwn/v0asPXWDIi7nbw8bzTdedniwD9H1k71zkuWWx+48Zk4pZv+1URKFvkElpKsEjxXlVzbjB7AmqtNtGE61zloLd+ZEQB35z7ERiyEUjWZPi5I+O5KvfO6wtNTPaoX7q1EiHPmIkswAWRognUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3eZy0K9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715286206; x=1746822206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rtE9Cf6G7+LfHndtSwMnyj8o++JOJ/aihDJUuBRTqS8=;
  b=N3eZy0K9/P+zL0hTwWqB6jG5n0uevPoTcyzpumRYinRf1kG+9M/YrV6J
   VOZswxP1TRbYqVAJ7YlrMIQmwMdHFElhnDjYgCP7HX7B/t1lfYjj4Nx+p
   Mb/O+fiOyZYVHd+1YU5LIm2yEh0vSLRONwIUcTcNo/myErIC8z6qjPTQU
   fJgTSq3RovwYdhl+ZDzcIkVBvwyD3OHBSlex49+F6TIcwfIEyWUf5nvmM
   YJGtVhqNnciR9N5+Y8A/EvAUvrjk6Mra59gOUrCvWBTsWl2HHXkKoGu6c
   5IvtrzYFIpxfIHLDvykJhIJnp04lQ6PYGG6f5OIynRLG9aKXaaxsapTkm
   A==;
X-CSE-ConnectionGUID: Lb1bzANCRyWokt4HILNs1Q==
X-CSE-MsgGUID: 2E5YprSQR8KSnjfvv0ierQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11364532"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="11364532"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 13:23:25 -0700
X-CSE-ConnectionGUID: 1i+ljtUbQvG1Olqyld1EgA==
X-CSE-MsgGUID: sB5oPA6UQRCnvoAR7X8dow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="29316777"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 May 2024 13:23:22 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5AIR-0005KD-1v;
	Thu, 09 May 2024 20:23:19 +0000
Date: Fri, 10 May 2024 04:22:23 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <error27@gmail.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: oe-kbuild-all@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] SUNRPC: prevent integer overflow in XDR_QUADLEN()
Message-ID: <202405100445.DwegLXyZ-lkp@intel.com>
References: <bbf929d6-18d2-4b7e-a660-a19460af0a3c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf929d6-18d2-4b7e-a660-a19460af0a3c@moroto.mountain>

Hi Dan,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.9-rc7 next-20240509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Carpenter/SUNRPC-prevent-integer-overflow-in-XDR_QUADLEN/20240509-185141
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/bbf929d6-18d2-4b7e-a660-a19460af0a3c%40moroto.mountain
patch subject: [PATCH 1/2] SUNRPC: prevent integer overflow in XDR_QUADLEN()
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240510/202405100445.DwegLXyZ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405100445.DwegLXyZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405100445.DwegLXyZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sunrpc/clnt.h:22,
                    from net/sunrpc/auth_unix.c:15:
>> include/linux/sunrpc/auth.h:33:25: error: initializer element is not constant
      33 | #define UNX_CALLSLACK   (21 + XDR_QUADLEN(UNX_MAXNODENAME))
         |                         ^
   net/sunrpc/auth_unix.c:225:27: note: in expansion of macro 'UNX_CALLSLACK'
     225 |         .au_cslack      = UNX_CALLSLACK,
         |                           ^~~~~~~~~~~~~
   include/linux/sunrpc/auth.h:33:25: note: (near initialization for 'unix_auth.au_cslack')
      33 | #define UNX_CALLSLACK   (21 + XDR_QUADLEN(UNX_MAXNODENAME))
         |                         ^
   net/sunrpc/auth_unix.c:225:27: note: in expansion of macro 'UNX_CALLSLACK'
     225 |         .au_cslack      = UNX_CALLSLACK,
         |                           ^~~~~~~~~~~~~
--
>> net/sunrpc/rpcb_clnt.c:100:33: error: initializer element is not constant
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:996:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
     996 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:100:33: note: (near initialization for 'rpcb_procedures3[1].p_arglen')
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:996:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
     996 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
>> net/sunrpc/rpcb_clnt.c:100:33: error: initializer element is not constant
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1006:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1006 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:100:33: note: (near initialization for 'rpcb_procedures3[2].p_arglen')
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1006:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1006 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
>> net/sunrpc/rpcb_clnt.c:100:33: error: initializer element is not constant
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1016:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1016 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:100:33: note: (near initialization for 'rpcb_procedures3[3].p_arglen')
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1016:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1016 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:92:33: error: initializer element is not constant
      92 | #define RPCB_addr_sz            (1 + XDR_QUADLEN(RPCBIND_MAXUADDRLEN))
         |                                 ^
   net/sunrpc/rpcb_clnt.c:111:33: note: in expansion of macro 'RPCB_addr_sz'
     111 | #define RPCB_getaddrres_sz      RPCB_addr_sz
         |                                 ^~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:1017:35: note: in expansion of macro 'RPCB_getaddrres_sz'
    1017 |                 .p_replen       = RPCB_getaddrres_sz,
         |                                   ^~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:92:33: note: (near initialization for 'rpcb_procedures3[3].p_replen')
      92 | #define RPCB_addr_sz            (1 + XDR_QUADLEN(RPCBIND_MAXUADDRLEN))
         |                                 ^
   net/sunrpc/rpcb_clnt.c:111:33: note: in expansion of macro 'RPCB_addr_sz'
     111 | #define RPCB_getaddrres_sz      RPCB_addr_sz
         |                                 ^~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:1017:35: note: in expansion of macro 'RPCB_getaddrres_sz'
    1017 |                 .p_replen       = RPCB_getaddrres_sz,
         |                                   ^~~~~~~~~~~~~~~~~~
>> net/sunrpc/rpcb_clnt.c:100:33: error: initializer element is not constant
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1029:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1029 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:100:33: note: (near initialization for 'rpcb_procedures4[1].p_arglen')
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1029:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1029 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
>> net/sunrpc/rpcb_clnt.c:100:33: error: initializer element is not constant
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1039:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1039 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:100:33: note: (near initialization for 'rpcb_procedures4[2].p_arglen')
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1039:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1039 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
>> net/sunrpc/rpcb_clnt.c:100:33: error: initializer element is not constant
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1049:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1049 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:100:33: note: (near initialization for 'rpcb_procedures4[3].p_arglen')
     100 | #define RPCB_getaddrargs_sz     (RPCB_program_sz + RPCB_version_sz + \
         |                                 ^
   net/sunrpc/rpcb_clnt.c:1049:35: note: in expansion of macro 'RPCB_getaddrargs_sz'
    1049 |                 .p_arglen       = RPCB_getaddrargs_sz,
         |                                   ^~~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:92:33: error: initializer element is not constant
      92 | #define RPCB_addr_sz            (1 + XDR_QUADLEN(RPCBIND_MAXUADDRLEN))
         |                                 ^
   net/sunrpc/rpcb_clnt.c:111:33: note: in expansion of macro 'RPCB_addr_sz'
     111 | #define RPCB_getaddrres_sz      RPCB_addr_sz
         |                                 ^~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:1050:35: note: in expansion of macro 'RPCB_getaddrres_sz'
    1050 |                 .p_replen       = RPCB_getaddrres_sz,
         |                                   ^~~~~~~~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:92:33: note: (near initialization for 'rpcb_procedures4[3].p_replen')
      92 | #define RPCB_addr_sz            (1 + XDR_QUADLEN(RPCBIND_MAXUADDRLEN))
         |                                 ^
   net/sunrpc/rpcb_clnt.c:111:33: note: in expansion of macro 'RPCB_addr_sz'
     111 | #define RPCB_getaddrres_sz      RPCB_addr_sz
         |                                 ^~~~~~~~~~~~
   net/sunrpc/rpcb_clnt.c:1050:35: note: in expansion of macro 'RPCB_getaddrres_sz'
    1050 |                 .p_replen       = RPCB_getaddrres_sz,
         |                                   ^~~~~~~~~~~~~~~~~~
--
>> fs/lockd/svcproc.c:548:17: error: initializer element is not constant
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:571:34: note: in expansion of macro 'Ck'
     571 |                 .pc_xdrressize = Ck+St+2+No+Rg,
         |                                  ^~
   fs/lockd/svcproc.c:548:17: note: (near initialization for 'nlmsvc_procedures[1].pc_xdrressize')
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:571:34: note: in expansion of macro 'Ck'
     571 |                 .pc_xdrressize = Ck+St+2+No+Rg,
         |                                  ^~
>> fs/lockd/svcproc.c:548:17: error: initializer element is not constant
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:581:34: note: in expansion of macro 'Ck'
     581 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svcproc.c:548:17: note: (near initialization for 'nlmsvc_procedures[2].pc_xdrressize')
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:581:34: note: in expansion of macro 'Ck'
     581 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
>> fs/lockd/svcproc.c:548:17: error: initializer element is not constant
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:591:34: note: in expansion of macro 'Ck'
     591 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svcproc.c:548:17: note: (near initialization for 'nlmsvc_procedures[3].pc_xdrressize')
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:591:34: note: in expansion of macro 'Ck'
     591 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
>> fs/lockd/svcproc.c:548:17: error: initializer element is not constant
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:601:34: note: in expansion of macro 'Ck'
     601 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svcproc.c:548:17: note: (near initialization for 'nlmsvc_procedures[4].pc_xdrressize')
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:601:34: note: in expansion of macro 'Ck'
     601 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
>> fs/lockd/svcproc.c:548:17: error: initializer element is not constant
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:611:34: note: in expansion of macro 'Ck'
     611 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svcproc.c:548:17: note: (near initialization for 'nlmsvc_procedures[5].pc_xdrressize')
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:611:34: note: in expansion of macro 'Ck'
     611 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
>> fs/lockd/svcproc.c:548:17: error: initializer element is not constant
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:761:34: note: in expansion of macro 'Ck'
     761 |                 .pc_xdrressize = Ck+St+1,
         |                                  ^~
   fs/lockd/svcproc.c:548:17: note: (near initialization for 'nlmsvc_procedures[20].pc_xdrressize')
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:761:34: note: in expansion of macro 'Ck'
     761 |                 .pc_xdrressize = Ck+St+1,
         |                                  ^~
>> fs/lockd/svcproc.c:548:17: error: initializer element is not constant
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:771:34: note: in expansion of macro 'Ck'
     771 |                 .pc_xdrressize = Ck+St+1,
         |                                  ^~
   fs/lockd/svcproc.c:548:17: note: (near initialization for 'nlmsvc_procedures[21].pc_xdrressize')
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:771:34: note: in expansion of macro 'Ck'
     771 |                 .pc_xdrressize = Ck+St+1,
         |                                  ^~
>> fs/lockd/svcproc.c:548:17: error: initializer element is not constant
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:781:34: note: in expansion of macro 'Ck'
     781 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svcproc.c:548:17: note: (near initialization for 'nlmsvc_procedures[22].pc_xdrressize')
     548 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svcproc.c:781:34: note: in expansion of macro 'Ck'
     781 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
--
>> fs/lockd/mon.c:536:25: error: initializer element is not constant
     536 | #define SM_mon_sz       (SM_mon_id_sz+SM_priv_sz)
         |                         ^
   fs/lockd/mon.c:545:35: note: in expansion of macro 'SM_mon_sz'
     545 |                 .p_arglen       = SM_mon_sz,
         |                                   ^~~~~~~~~
   fs/lockd/mon.c:536:25: note: (near initialization for 'nsm_procedures[2].p_arglen')
     536 | #define SM_mon_sz       (SM_mon_id_sz+SM_priv_sz)
         |                         ^
   fs/lockd/mon.c:545:35: note: in expansion of macro 'SM_mon_sz'
     545 |                 .p_arglen       = SM_mon_sz,
         |                                   ^~~~~~~~~
   fs/lockd/mon.c:534:25: error: initializer element is not constant
     534 | #define SM_mon_id_sz    (SM_mon_name_sz+SM_my_id_sz)
         |                         ^
   fs/lockd/mon.c:554:35: note: in expansion of macro 'SM_mon_id_sz'
     554 |                 .p_arglen       = SM_mon_id_sz,
         |                                   ^~~~~~~~~~~~
   fs/lockd/mon.c:534:25: note: (near initialization for 'nsm_procedures[3].p_arglen')
     534 | #define SM_mon_id_sz    (SM_mon_name_sz+SM_my_id_sz)
         |                         ^
   fs/lockd/mon.c:554:35: note: in expansion of macro 'SM_mon_id_sz'
     554 |                 .p_arglen       = SM_mon_id_sz,
         |                                   ^~~~~~~~~~~~
--
>> fs/lockd/svc4proc.c:514:17: error: initializer element is not constant
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:537:34: note: in expansion of macro 'Ck'
     537 |                 .pc_xdrressize = Ck+St+2+No+Rg,
         |                                  ^~
   fs/lockd/svc4proc.c:514:17: note: (near initialization for 'nlmsvc_procedures4[1].pc_xdrressize')
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:537:34: note: in expansion of macro 'Ck'
     537 |                 .pc_xdrressize = Ck+St+2+No+Rg,
         |                                  ^~
>> fs/lockd/svc4proc.c:514:17: error: initializer element is not constant
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:547:34: note: in expansion of macro 'Ck'
     547 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svc4proc.c:514:17: note: (near initialization for 'nlmsvc_procedures4[2].pc_xdrressize')
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:547:34: note: in expansion of macro 'Ck'
     547 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
>> fs/lockd/svc4proc.c:514:17: error: initializer element is not constant
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:557:34: note: in expansion of macro 'Ck'
     557 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svc4proc.c:514:17: note: (near initialization for 'nlmsvc_procedures4[3].pc_xdrressize')
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:557:34: note: in expansion of macro 'Ck'
     557 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
>> fs/lockd/svc4proc.c:514:17: error: initializer element is not constant
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:567:34: note: in expansion of macro 'Ck'
     567 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svc4proc.c:514:17: note: (near initialization for 'nlmsvc_procedures4[4].pc_xdrressize')
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:567:34: note: in expansion of macro 'Ck'
     567 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
>> fs/lockd/svc4proc.c:514:17: error: initializer element is not constant
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:577:34: note: in expansion of macro 'Ck'
     577 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svc4proc.c:514:17: note: (near initialization for 'nlmsvc_procedures4[5].pc_xdrressize')
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:577:34: note: in expansion of macro 'Ck'
     577 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
>> fs/lockd/svc4proc.c:514:17: error: initializer element is not constant
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:727:34: note: in expansion of macro 'Ck'
     727 |                 .pc_xdrressize = Ck+St+1,
         |                                  ^~
   fs/lockd/svc4proc.c:514:17: note: (near initialization for 'nlmsvc_procedures4[20].pc_xdrressize')
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:727:34: note: in expansion of macro 'Ck'
     727 |                 .pc_xdrressize = Ck+St+1,
         |                                  ^~
>> fs/lockd/svc4proc.c:514:17: error: initializer element is not constant
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:737:34: note: in expansion of macro 'Ck'
     737 |                 .pc_xdrressize = Ck+St+1,
         |                                  ^~
   fs/lockd/svc4proc.c:514:17: note: (near initialization for 'nlmsvc_procedures4[21].pc_xdrressize')
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:737:34: note: in expansion of macro 'Ck'
     737 |                 .pc_xdrressize = Ck+St+1,
         |                                  ^~
>> fs/lockd/svc4proc.c:514:17: error: initializer element is not constant
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:747:34: note: in expansion of macro 'Ck'
     747 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
   fs/lockd/svc4proc.c:514:17: note: (near initialization for 'nlmsvc_procedures4[22].pc_xdrressize')
     514 | #define Ck      (1+XDR_QUADLEN(NLM_MAXCOOKIELEN))       /* cookie */
         |                 ^
   fs/lockd/svc4proc.c:747:34: note: in expansion of macro 'Ck'
     747 |                 .pc_xdrressize = Ck+St,
         |                                  ^~
..


vim +33 include/linux/sunrpc/auth.h

4500632f60fa0d Chuck Lever    2016-03-01  27  
24a9a9610ce3ba Jeff Layton    2015-08-03  28  /*
24a9a9610ce3ba Jeff Layton    2015-08-03  29   * Size of the nodename buffer. RFC1831 specifies a hard limit of 255 bytes,
24a9a9610ce3ba Jeff Layton    2015-08-03  30   * but Linux hostnames are actually limited to __NEW_UTS_LEN bytes.
24a9a9610ce3ba Jeff Layton    2015-08-03  31   */
24a9a9610ce3ba Jeff Layton    2015-08-03  32  #define UNX_MAXNODENAME	__NEW_UTS_LEN
4500632f60fa0d Chuck Lever    2016-03-01 @33  #define UNX_CALLSLACK	(21 + XDR_QUADLEN(UNX_MAXNODENAME))
5786461bd8ea81 Kinglong Mee   2017-02-07  34  #define UNX_NGROUPS	16
^1da177e4c3f41 Linus Torvalds 2005-04-16  35  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

