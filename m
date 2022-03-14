Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA704D8D95
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 20:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbiCNT7n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 15:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244473AbiCNT7m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 15:59:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C643AFD36;
        Mon, 14 Mar 2022 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647287911; x=1678823911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZvtWyq6NUGvNj5osgER37WrvoGpAL79tCPZIhK8DII=;
  b=ZV8+1idyOccFv0zrFkjRFdYqeOmN9G3uzCfIP2+E6+8S/KOznSWnskit
   tittZdJtqJSlB8fGttA+g+tpAlfya8UkIytMWaQl2H3Sp5y5Hw47+ABfh
   RqpobG4rY6hMsRAOF5RgzM3zGPJ/13VZkznV7iB2rqg0LYsJ514USgtRi
   xr1sSW+AQM2/mVePmYGZFnzsqlGyn7L2Z4OUgntIxKhFVIDOko4PKlpv+
   jlp5BQOOEI3lJnGoCh6SK2LM/+Ro2LDdGyZLrNB+7Dmzn5SOx3EjljRu3
   Y0ua3twQqOZ0grWHBkUAzaoBCkQWMq6H+Q/up9ksEOG1bSfSX6g8nNzkP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255863798"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255863798"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="713875781"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Mar 2022 12:58:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTqpm-000ABd-Fc; Mon, 14 Mar 2022 19:58:26 +0000
Date:   Tue, 15 Mar 2022 03:57:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Message-ID: <202203150321.2NA8SWEv-lkp@intel.com>
References: <20220314140958.GE30883@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314140958.GE30883@kili>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v5.17-rc8 next-20220310]
[cannot apply to cel-2.6/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dan-Carpenter/NFSD-prevent-integer-overflow-on-32-bit-systems/20220314-221126
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: s390-randconfig-r044-20220314 (https://download.01.org/0day-ci/archive/20220315/202203150321.2NA8SWEv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3e4950d7fa78ac83f33bbf1658e2f49a73719236)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/455f80f80ed34963bae40e552834c7483bcec80a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dan-Carpenter/NFSD-prevent-integer-overflow-on-32-bit-systems/20220314-221126
        git checkout 455f80f80ed34963bae40e552834c7483bcec80a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash net/ipv4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/ipv4/ipconfig.c:45:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from net/ipv4/ipconfig.c:45:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from net/ipv4/ipconfig.c:45:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   In file included from net/ipv4/ipconfig.c:59:
   In file included from include/linux/nfs_fs.h:31:
   In file included from include/linux/sunrpc/auth.h:13:
   In file included from include/linux/sunrpc/sched.h:19:
>> include/linux/sunrpc/xdr.h:734:10: warning: result of comparison of constant 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           if (len > ULONG_MAX / sizeof(*p))
               ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
   13 warnings generated.


vim +734 include/linux/sunrpc/xdr.h

   712	
   713	/**
   714	 * xdr_stream_decode_uint32_array - Decode variable length array of integers
   715	 * @xdr: pointer to xdr_stream
   716	 * @array: location to store the integer array or NULL
   717	 * @array_size: number of elements to store
   718	 *
   719	 * Return values:
   720	 *   On success, returns number of elements stored in @array
   721	 *   %-EBADMSG on XDR buffer overflow
   722	 *   %-EMSGSIZE if the size of the array exceeds @array_size
   723	 */
   724	static inline ssize_t
   725	xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
   726			__u32 *array, size_t array_size)
   727	{
   728		__be32 *p;
   729		__u32 len;
   730		ssize_t retval;
   731	
   732		if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
   733			return -EBADMSG;
 > 734		if (len > ULONG_MAX / sizeof(*p))
   735			return -EBADMSG;
   736		p = xdr_inline_decode(xdr, len * sizeof(*p));
   737		if (unlikely(!p))
   738			return -EBADMSG;
   739		if (array == NULL)
   740			return len;
   741		if (len <= array_size) {
   742			if (len < array_size)
   743				memset(array+len, 0, (array_size-len)*sizeof(*array));
   744			array_size = len;
   745			retval = len;
   746		} else
   747			retval = -EMSGSIZE;
   748		for (; array_size > 0; p++, array++, array_size--)
   749			*array = be32_to_cpup(p);
   750		return retval;
   751	}
   752	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
