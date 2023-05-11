Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F06FF288
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbjEKNS7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 May 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbjEKNSI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 May 2023 09:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA817106E0
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683810939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7GdN215yNA43SzrNgI0qnS3dew63bkmnn0zBwKGt4M=;
        b=jIURgN4dRC4mayhdFQPmJ2pRl01Mmks7qnRDe4j+mnWcWt0pQBY7xpLLNtPkbHTwSfAWHX
        new2Jw8VAWY232p2hj2ro+npPA6p7ROdv+OTgElCeLrorjiscXBTYPGaJuKZHNrzYrmp5O
        hCjpBKr9sXnrzSDn37YqSwMegFBnSrQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-xop2eY-1PySRaqm_tbUlHg-1; Thu, 11 May 2023 09:15:38 -0400
X-MC-Unique: xop2eY-1PySRaqm_tbUlHg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-621189941cdso8487416d6.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 06:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683810937; x=1686402937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7GdN215yNA43SzrNgI0qnS3dew63bkmnn0zBwKGt4M=;
        b=F6TQ7I3SD3WWiZOwLensW0RrJ8TlhQHRLgBbMrh8P4847JV1iek80Lz1ZQZ250RWvt
         iXOh81DXNZ025yZrpqzVBjK8KU7gHH3SA4OeR0s8Y7eaY2CCilBltrNSRBnzXcgFId6Y
         vQOwCO7NuVkLpUXDB8AbnLXB4IX7iAlKfuz9a8gzwPLbVo3EJ3osWqaJWiHYPzuYpHWj
         d7NDb6FGF394RcbOWZzbpNPZR4JYEh1wiq426x72ZrxtyvYpDRfgJ2v24OPqapdbtV+s
         TjZvJcR/xiWZfeWSKUWGYNcEL4oxJNpbC6TECxzzi//3rLrD9gwlp7TjNnOuox0afzG0
         cwLg==
X-Gm-Message-State: AC+VfDx4s675z8UdI712oBwZ1CnH647lFhLpHN6XV7fxbYrsFmity+5Q
        ZY+odbXTPfYyLG6m0Y8LaPgyrYGd1rW3gIj/hAIMsH/+Dx1DpRF/NbLMZGvi1hMkHcHE8Eh604s
        kAR1CM5h90UDuYFxJkpOIBm9lZ8Wz
X-Received: by 2002:a05:6214:4017:b0:61b:6b8e:16e0 with SMTP id kd23-20020a056214401700b0061b6b8e16e0mr27925085qvb.1.1683810937690;
        Thu, 11 May 2023 06:15:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QrDuh1/3VnUeK77k+XBHREIqjDJBgvF7m/Cgt+2BZot4AWIC4wi4ZCroOdjQoYSYMlcYXjA==
X-Received: by 2002:a05:6214:4017:b0:61b:6b8e:16e0 with SMTP id kd23-20020a056214401700b0061b6b8e16e0mr27925049qvb.1.1683810937318;
        Thu, 11 May 2023 06:15:37 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.154.41])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a13a700b00758c1bd6d9esm969296qki.133.2023.05.11.06.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 06:15:36 -0700 (PDT)
Message-ID: <76403fb4-87f2-88cb-ab0c-ba63feacbeee@redhat.com>
Date:   Thu, 11 May 2023 09:15:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: LTP: tirpc_rpcb_rmtcall is failing
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>
Cc:     libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        ltp@lists.linux.it
References: <20230504101619.GA3801922@pevik>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230504101619.GA3801922@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Petr,

On 5/4/23 6:16 AM, Petr Vorel wrote:
> Hi Steve,
> 
> tirpc_rpcb_rmtcall is failing. I was able to reproduce it on
> * openSUSE Tumbleweed with libtirpc 1.3.3
> * Debian stable  11 (bullseye) with libtirpc 1.3.1-1
> 
> OTOH SLE 15-SP4 with libtirpc 1.2.6 is working.
> 
> PATH="/opt/ltp/testcases/bin:$PATH" rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> rpc_test 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> rpc_test 1 TINFO: add local addr 10.0.0.2/24
> rpc_test 1 TINFO: add local addr fd00:1:1:1::2/64
> rpc_test 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> rpc_test 1 TINFO: add remote addr 10.0.0.1/24
> rpc_test 1 TINFO: add remote addr fd00:1:1:1::1/64
> rpc_test 1 TINFO: Network config (local -- remote):
> rpc_test 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> rpc_test 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> rpc_test 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> rpc_test 1 TINFO: timeout per run is 0h 5m 0s
> rpc_test 1 TINFO: check registered RPC with rpcinfo
> rpc_test 1 TINFO: registered RPC:
>     program vers proto   port  service
>      100000    4   tcp    111  portmapper
>      100000    3   tcp    111  portmapper
>      100000    2   tcp    111  portmapper
>      100000    4   udp    111  portmapper
>      100000    3   udp    111  portmapper
>      100000    2   udp    111  portmapper
>      100005    1   udp  20048  mountd
>      100005    1   tcp  20048  mountd
>      100005    2   udp  20048  mountd
>      100005    2   tcp  20048  mountd
>      100005    3   udp  20048  mountd
>      100005    3   tcp  20048  mountd
>      100024    1   udp  37966  status
>      100024    1   tcp  43643  status
>      100003    3   tcp   2049  nfs
>      100003    4   tcp   2049  nfs
>      100227    3   tcp   2049  nfs_acl
>      100021    1   udp  59603  nlockmgr
>      100021    3   udp  59603  nlockmgr
>      100021    4   udp  59603  nlockmgr
>      100021    1   tcp  39145  nlockmgr
>      100021    3   tcp  39145  nlockmgr
>      100021    4   tcp  39145  nlockmgr
> rpc_test 1 TINFO: using libtirpc: yes
> rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly
> 1
> 
> The problem is in tirpc_rpcb_rmtcall.c [1], which calls rpcb_rmtcall(), which
> returns 1 (I suppose RPC_CANTENCODEARGS - can't encode arguments - enum
> clnt_stat from tirpc/rpc/clnt_stat.h):
> 
> 	cs = rpcb_rmtcall(nconf, argc[1], progNum, VERSNUM, PROCNUM,
> 			  (xdrproc_t) xdr_int, (char *)&var_snd,
> 			  (xdrproc_t) xdr_int, (char *)&var_rec, tv, &svcaddr);
> 
> 	test_status = (cs == RPC_SUCCESS) ? 0 : 1;
> 
> 	//This last printf gives the result status to the tests suite
> 	//normally should be 0: test has passed or 1: test has failed
> 	printf("%d\n", test_status);
> 
> 	return test_status;
> 
> Any idea what could be wrong with these very old tests?
No... No idea... but I'm unable to reproduce it. It appears
you are using different repo that the one I found on
github [1]. But...

Looking code, RPC_CANTENCODEARGS is returned when
there is an xdr problem which might means a
memory problem??

With that said... commits 21718bbb^..fa153d63 did
make a lot of changes in the locking and cache
management.

steved.

[1] https://github.com/linux-test-project/ltp
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/blob/12765c115f11026c090ab0ee5dd79b38d95ef31f/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c#L91-L93
> 

