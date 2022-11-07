Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3408D61E871
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 02:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKGBvk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Nov 2022 20:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKGBvi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Nov 2022 20:51:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39B0DF21
        for <linux-nfs@vger.kernel.org>; Sun,  6 Nov 2022 17:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667785896; x=1699321896;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Rfr9dcjP5uzZrwYIFMe66CtwoPmdDOwi6R3P8nAK/+M=;
  b=l9407L/r6QYnWpimJyyKgpnWPC4S7MuOAT8EzytgB4iwylKkQLkkDW0G
   UeZZTh3vUmERGfvd5wTBBAese+wJwul3Vmob0skuYjT6ELFDUCjVOB03V
   cJSlfd63pq0GkcEAJgMJCPhBCfu2IEP4WiG39Ouqcv/sTeCaNeNNdztMf
   VqNi/8huOOFFCBvVjVrQa3XtmlUe/ZljWksArf3+JrxQbQFJoka7EQvNd
   I9HXzG0fqYiOAOaLvJryMJiXDwQCm8K3mR7qRrqHI77V0np91gwBZYooh
   Zb8wx7RY8EW7VqAivPNrha29M4quygbddRfJ2v8rRultK+ae63OP8ZrOL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="293646109"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="293646109"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 17:51:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="668965976"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="668965976"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.214.37]) ([10.254.214.37])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 17:51:22 -0800
Subject: Re: [cel:topic-rpc-with-tls-upcall 12/16] net/sunrpc/xprtsock.c:2544:
 undefined reference to `tls_client_hello_x509'
To:     Chuck Lever III <chuck.lever@oracle.com>,
        kernel test robot <lkp@intel.com>
Cc:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <202211051449.mnJj6fib-lkp@intel.com>
 <55C1634B-3B7E-4671-8A81-F92495256F1E@oracle.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <aa3b8fc7-598c-08e7-a9f0-b5760ca8c2f5@intel.com>
Date:   Mon, 7 Nov 2022 09:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <55C1634B-3B7E-4671-8A81-F92495256F1E@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/6/2022 12:00 AM, Chuck Lever III wrote:
> 
> 
>> On Nov 5, 2022, at 2:05 AM, kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
>> head:   92abd0e9e73597857455026e8312192264aaabf9
>> commit: b39cc345e2d6ed4f37bea31528ccbfaa3dec4f69 [12/16] SUNRPC: Add RPC-with-TLS support to xprtsock.c
>> config: x86_64-rhel-8.3-kvm
>> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>> reproduce (this is a W=1 build):
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=b39cc345e2d6ed4f37bea31528ccbfaa3dec4f69
>>         git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
>>         git fetch --no-tags cel topic-rpc-with-tls-upcall
>>         git checkout b39cc345e2d6ed4f37bea31528ccbfaa3dec4f69
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    ld: net/sunrpc/xprtsock.o: in function `xs_tls_handshake_sync':
>>>> net/sunrpc/xprtsock.c:2544: undefined reference to `tls_client_hello_x509'
>>>> ld: net/sunrpc/xprtsock.c:2539: undefined reference to `tls_client_hello_anon'
>>    pahole: .tmp_vmlinux.btf: No such file or directory
>>    .btf.vmlinux.bin.o: file not recognized: file format not recognized
> 
> I am not able to reproduce this build failure.
> 
> I'm on Fedora 36 with gcc-12.2.1-2
> 
> CONFIG_TLS=m
> CONFIG_TLS_DEVICE=y
> 
> CONFIG_SUNRPC=y
> 
> Any help appreciated!

Hi Chuck,

I can reproduce it with gcc-11/gcc-12 on ubuntu 21.10,
and this issue disappeared if CONFIG_TLS=y.

Best Regards,
Rong Chen

> 
> 
>> vim +2544 net/sunrpc/xprtsock.c
>>
>>   2526	
>>   2527	static int xs_tls_handshake_sync(struct rpc_xprt *lower_xprt, struct xprtsec_parms *xprtsec)
>>   2528	{
>>   2529		struct sock_xprt *lower_transport =
>>   2530					container_of(lower_xprt, struct sock_xprt, xprt);
>>   2531		int rc;
>>   2532	
>>   2533		init_completion(&lower_transport->handshake_done);
>>   2534		set_bit(XPRT_SOCK_IGNORE_RECV, &lower_transport->sock_state);
>>   2535	
>>   2536		lower_transport->xprt_err = -ETIMEDOUT;
>>   2537		switch (xprtsec->policy) {
>>   2538		case RPC_XPRTSEC_TLS_ANON:
>>> 2539			rc = tls_client_hello_anon(lower_transport->sock,
>>   2540						   xs_tls_handshake_done, xprt_get(lower_xprt),
>>   2541						   TLSH_DEFAULT_PRIORITIES);
>>   2542			break;
>>   2543		case RPC_XPRTSEC_TLS_X509:
>>> 2544			rc = tls_client_hello_x509(lower_transport->sock,
>>   2545						   xs_tls_handshake_done, xprt_get(lower_xprt),
>>   2546						   TLSH_DEFAULT_PRIORITIES,
>>   2547						   xprtsec->cert_serial,
>>   2548						   xprtsec->privkey_serial);
>>   2549			break;
>>   2550		default:
>>   2551			rc = -EACCES;
>>   2552		}
>>   2553		if (rc)
>>   2554			goto out;
>>   2555	
>>   2556		rc = wait_for_completion_interruptible_timeout(&lower_transport->handshake_done,
>>   2557							       XS_TLS_HANDSHAKE_TO);
>>   2558		if (rc < 0)
>>   2559			goto out;
>>   2560	
>>   2561		rc = lower_transport->xprt_err;
>>   2562	
>>   2563	out:
>>   2564		xs_stream_reset_connect(lower_transport);
>>   2565		clear_bit(XPRT_SOCK_IGNORE_RECV, &lower_transport->sock_state);
>>   2566		return rc;
>>   2567	}
>>   2568	
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
>> <config.txt>
> 
> --
> Chuck Lever
> 
> 
> 
> 
