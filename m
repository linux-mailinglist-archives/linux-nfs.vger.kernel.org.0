Return-Path: <linux-nfs+bounces-3227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E407C8C1879
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 23:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99381286865
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 21:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D91292E6;
	Thu,  9 May 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjAeEoVP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE53129A67;
	Thu,  9 May 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290532; cv=none; b=VLp5qsW9KIVltr38/yR1pVNrP2pT+Q72uenBlBLd4tSzijrUZMxwJv1FO9JhaVSF61myAC9xqi3JuipKxW64OjpKUMd/ZgHK4bOe4FbWSuI3mzYjm2FP5PAsXmDrmx7kNIhnAEqlSXn/8Zu5iFowk5MydYWZUx6keT5JAxd8/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290532; c=relaxed/simple;
	bh=lPh/nEqoGgLssGU9u/530CpaLB+yT+jCGmsBtzdaaQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhkCXmnxHsfP0PpoNCRvwynh5Imq9BD8MypjLpapDMKyfOaFB9KvygLzRrRZnOuZPBLOBdRDJ/JeFTHqtej4XrO1WUHVywsbDCEyhBCyAe+3g5SUwnvN2Me8TsdeT7hqidhUEaAPqoNYJtYKEXwW/RzTmlKfQ8Yb7rC8AYzNptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjAeEoVP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715290530; x=1746826530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lPh/nEqoGgLssGU9u/530CpaLB+yT+jCGmsBtzdaaQ8=;
  b=LjAeEoVPVAFUC+99WvJfi0yLkaY84DyHdVIakvpW2Cj1LfteC6SjXcQi
   TGfannFZGBSlkyZ97vo9w5iC+zNbJZzf2+8hNnnznc3tY7f8H8sYV1JNl
   t39/SPnkIzvOjfmSN5+tcuThbbHFJqN479ZzQjb1cKsW836s3oWsESj6j
   zj9rYAs6uUFRfAw2tIxJx6VyRWD5uVgJALucieUGzCFjnjZnWJhG5r+W2
   aqn7+QtZiXcYg+WCP0/kduMZ5Ww3XT5H3S+g7MIDbmDxPcYKk45qgsopX
   kwnLZMcMxuXtHof6M0u0ogFQIQ2ljoVGBOx+PF/cFMGX8K6+Lcrp6mzaJ
   Q==;
X-CSE-ConnectionGUID: OGv083x5SsOGUdCjNtyzEA==
X-CSE-MsgGUID: UxWGLMjAQQ2oF/T9DU2NgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="14195728"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="14195728"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 14:35:30 -0700
X-CSE-ConnectionGUID: jZEUWdnKQRWUgZS/vlvJXg==
X-CSE-MsgGUID: NoyrwYZmT1qL4g3agHmioQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="34240486"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 May 2024 14:35:26 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5BQA-0005OV-2x;
	Thu, 09 May 2024 21:35:22 +0000
Date: Fri, 10 May 2024 05:34:57 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <error27@gmail.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] SUNRPC: prevent integer overflow in XDR_QUADLEN()
Message-ID: <202405100514.9QcoLUdp-lkp@intel.com>
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
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240510/202405100514.9QcoLUdp-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405100514.9QcoLUdp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405100514.9QcoLUdp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/nfsd/nfs4callback.c:34:
   In file included from include/linux/nfs4.h:19:
   In file included from include/linux/sunrpc/msg_prot.h:205:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from fs/nfsd/nfs4callback.c:34:
   In file included from include/linux/nfs4.h:19:
   In file included from include/linux/sunrpc/msg_prot.h:205:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from fs/nfsd/nfs4callback.c:34:
   In file included from include/linux/nfs4.h:19:
   In file included from include/linux/sunrpc/msg_prot.h:205:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> fs/nfsd/nfs4callback.c:832:2: error: initializer element is not a compile-time constant
     832 |         PROC(CB_OFFLOAD,        COMPOUND,       cb_offload,     cb_offload),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfsd/nfs4callback.c:819:15: note: expanded from macro 'PROC'
     819 |         .p_arglen  = NFS4_enc_##argtype##_sz,                           \
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:133:1: note: expanded from here
     133 | NFS4_enc_cb_offload_sz
         | ^~~~~~~~~~~~~~~~~~~~~~
   fs/nfsd/xdr4cb.h:43:33: note: expanded from macro 'NFS4_enc_cb_offload_sz'
      43 | #define NFS4_enc_cb_offload_sz          (cb_compound_enc_hdr_sz +       \
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      44 |                                         cb_sequence_enc_sz +            \
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      45 |                                         enc_nfs4_fh_sz +                \
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      46 |                                         enc_stateid_sz +                \
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      47 |                                         enc_cb_offload_info_sz)
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~
   17 warnings and 1 error generated.


vim +832 fs/nfsd/nfs4callback.c

^1da177e4c3f415 Linus Torvalds    2005-04-16  824  
499b4988109e91b Christoph Hellwig 2017-05-12  825  static const struct rpc_procinfo nfs4_cb_procedures[] = {
7d93bd71cb3e262 Chuck Lever       2010-12-14  826  	PROC(CB_NULL,	NULL,		cb_null,	cb_null),
7d93bd71cb3e262 Chuck Lever       2010-12-14  827  	PROC(CB_RECALL,	COMPOUND,	cb_recall,	cb_recall),
c5c707f96fc9a6e Christoph Hellwig 2014-09-23  828  #ifdef CONFIG_NFSD_PNFS
c5c707f96fc9a6e Christoph Hellwig 2014-09-23  829  	PROC(CB_LAYOUT,	COMPOUND,	cb_layout,	cb_layout),
c5c707f96fc9a6e Christoph Hellwig 2014-09-23  830  #endif
a188620ebd294b1 Jeff Layton       2016-09-16  831  	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
9eb190fca8f9056 Olga Kornievskaia 2018-07-20 @832  	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
3959066b697b5df Dai Ngo           2022-11-16  833  	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
^1da177e4c3f415 Linus Torvalds    2005-04-16  834  };
^1da177e4c3f415 Linus Torvalds    2005-04-16  835  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

