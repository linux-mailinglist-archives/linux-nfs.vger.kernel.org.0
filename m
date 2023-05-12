Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB971700518
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 12:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjELKTk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 06:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjELKTj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 06:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2625BBF
        for <linux-nfs@vger.kernel.org>; Fri, 12 May 2023 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683886730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+auYZQ/G+iwFFTT/VdJPo4gysgHFMS413cVUjjVlyys=;
        b=PlatVZ7eIY7lkxwHXJ4h2MpbXPUVw28JExPSg1otoZfnf+9kp7ytl+AqIKoCVevD5MRUXc
        gHnN63AlrARuiKmI4GanX+67Gz6H5DlCaL2r6Lvz5iWmrdPA0BTiEq448iCnDH2z/DXwig
        UhIuYruI/Ov8FZFhTUsirpfnIw0htLc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-n2JwQOJkO_SNYVLDkkj05A-1; Fri, 12 May 2023 06:18:49 -0400
X-MC-Unique: n2JwQOJkO_SNYVLDkkj05A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62143c665cbso6706586d6.0
        for <linux-nfs@vger.kernel.org>; Fri, 12 May 2023 03:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886728; x=1686478728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+auYZQ/G+iwFFTT/VdJPo4gysgHFMS413cVUjjVlyys=;
        b=SimXM8JkD0SqH6b1/UWfAyvd9fJnbf3d2ooExFAvTMLsOaxPz+fs3VeEnxoSIl/Fyt
         /rC8khg1zQy6RBBf1LYAHrqbaUMvtA4goqvMlxj8eHZpWKnB5Xauvp2Qhqct+9aNEc+3
         Z8SqJN5DfuuxbSnB/+I4ZChNzPnp8kYqX3O7kSH6peUOWf7HMI4viZBdqjdwhFZjdj4B
         C0yi8x140J8phMvMh+uvuN8dSXaiPQakocHDPEi+yXsTGd6MHFrTa43xD1agVj/NLPw0
         C7SHNz5FuhJkDx+ewdBGOavYC30lgk+wNfaESL+WqdD0SsH83Ql8FOJSuwAaJeXsrTFb
         pNoA==
X-Gm-Message-State: AC+VfDxtiixjmGkZj0C2Y6T2ki3huvjvrnhDuBmK9vGgT9HPoGWOCO78
        Fo3igTBIyssZ/viQU5+7p6OcFL7Ogk2PQnfY0u95XCuYuYzuyFd+XV1shWsgzRVZq3C52B6hu2k
        SpgRLx7MXyoNNixel+FBj7icaBIpH
X-Received: by 2002:a05:622a:1807:b0:3f3:98b7:7df with SMTP id t7-20020a05622a180700b003f398b707dfmr19423471qtc.6.1683886728107;
        Fri, 12 May 2023 03:18:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NYowodSmUKmQS4Y0ySnIrOzgHEF4Guxlvz0OBOore+qTzlCJatbtf2vCCWvr3nvFbfOE4Wg==
X-Received: by 2002:a05:622a:1807:b0:3f3:98b7:7df with SMTP id t7-20020a05622a180700b003f398b707dfmr19423457qtc.6.1683886727841;
        Fri, 12 May 2023 03:18:47 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.245.71])
        by smtp.gmail.com with ESMTPSA id r22-20020ac85e96000000b003bd0f0b26b0sm2938792qtx.77.2023.05.12.03.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 03:18:47 -0700 (PDT)
Message-ID: <3ec79840-b34e-bef0-14ec-301829e9e95e@redhat.com>
Date:   Fri, 12 May 2023 06:18:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: LTP: tirpc_rpcb_rmtcall is failing
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>
Cc:     libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        ltp@lists.linux.it
References: <20230504101619.GA3801922@pevik>
 <76403fb4-87f2-88cb-ab0c-ba63feacbeee@redhat.com>
 <20230512074314.GB30010@pevik>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230512074314.GB30010@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 5/12/23 3:43 AM, Petr Vorel wrote:
> Hi Steve,
> 
>> Hello Petr,
> 
>> On 5/4/23 6:16 AM, Petr Vorel wrote:
>>> Hi Steve,
> 
>>> tirpc_rpcb_rmtcall is failing. I was able to reproduce it on
>>> * openSUSE Tumbleweed with libtirpc 1.3.3
>>> * Debian stable  11 (bullseye) with libtirpc 1.3.1-1
> 
>>> OTOH SLE 15-SP4 with libtirpc 1.2.6 is working.
> 
>>> PATH="/opt/ltp/testcases/bin:$PATH" rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
>>> rpc_test 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
>>> rpc_test 1 TINFO: add local addr 10.0.0.2/24
>>> rpc_test 1 TINFO: add local addr fd00:1:1:1::2/64
>>> rpc_test 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
>>> rpc_test 1 TINFO: add remote addr 10.0.0.1/24
>>> rpc_test 1 TINFO: add remote addr fd00:1:1:1::1/64
>>> rpc_test 1 TINFO: Network config (local -- remote):
>>> rpc_test 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
>>> rpc_test 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
>>> rpc_test 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
>>> rpc_test 1 TINFO: timeout per run is 0h 5m 0s
>>> rpc_test 1 TINFO: check registered RPC with rpcinfo
>>> rpc_test 1 TINFO: registered RPC:
>>>      program vers proto   port  service
>>>       100000    4   tcp    111  portmapper
>>>       100000    3   tcp    111  portmapper
>>>       100000    2   tcp    111  portmapper
>>>       100000    4   udp    111  portmapper
>>>       100000    3   udp    111  portmapper
>>>       100000    2   udp    111  portmapper
>>>       100005    1   udp  20048  mountd
>>>       100005    1   tcp  20048  mountd
>>>       100005    2   udp  20048  mountd
>>>       100005    2   tcp  20048  mountd
>>>       100005    3   udp  20048  mountd
>>>       100005    3   tcp  20048  mountd
>>>       100024    1   udp  37966  status
>>>       100024    1   tcp  43643  status
>>>       100003    3   tcp   2049  nfs
>>>       100003    4   tcp   2049  nfs
>>>       100227    3   tcp   2049  nfs_acl
>>>       100021    1   udp  59603  nlockmgr
>>>       100021    3   udp  59603  nlockmgr
>>>       100021    4   udp  59603  nlockmgr
>>>       100021    1   tcp  39145  nlockmgr
>>>       100021    3   tcp  39145  nlockmgr
>>>       100021    4   tcp  39145  nlockmgr
>>> rpc_test 1 TINFO: using libtirpc: yes
>>> rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly
>>> 1
> 
>>> The problem is in tirpc_rpcb_rmtcall.c [1], which calls rpcb_rmtcall(), which
>>> returns 1 (I suppose RPC_CANTENCODEARGS - can't encode arguments - enum
>>> clnt_stat from tirpc/rpc/clnt_stat.h):
> 
>>> 	cs = rpcb_rmtcall(nconf, argc[1], progNum, VERSNUM, PROCNUM,
>>> 			  (xdrproc_t) xdr_int, (char *)&var_snd,
>>> 			  (xdrproc_t) xdr_int, (char *)&var_rec, tv, &svcaddr);
> 
>>> 	test_status = (cs == RPC_SUCCESS) ? 0 : 1;
> 
>>> 	//This last printf gives the result status to the tests suite
>>> 	//normally should be 0: test has passed or 1: test has failed
>>> 	printf("%d\n", test_status);
> 
>>> 	return test_status;
> 
>>> Any idea what could be wrong with these very old tests?
>> No... No idea... but I'm unable to reproduce it. It appears
>> you are using different repo that the one I found on
>> github [1]. But...
> 
> Thanks a lot for looking into the issue.
> BTW on which Fedora/RHEL/CentOS version did you test?
Fedora 38... but I will keep trying...
> 
> No, I'm also using the official LTP repository on github [1].
> And I compile on recent glibc (> 2.32, which removed SUN-RPC) and with libtirpc:
> 
> ./configure
> ...
> libtirpc: yes
> glibc SUN-RPC: no
> 
>> Looking code, RPC_CANTENCODEARGS is returned when
>> there is an xdr problem which might means a
>> memory problem??
> 
>> With that said... commits 21718bbb^..fa153d63 did
> That was released on 1.3.3, but I'm able to reproduce it on
> Debian stable  11 (bullseye) with libtirpc 1.3.1-1.
Good to know... thanks!

steved.
> 
> Kind regards,
> Petr
> 
>> make a lot of changes in the locking and cache
>> management.
> 
>> steved.
> 
>> [1] https://github.com/linux-test-project/ltp
> 
>>> Kind regards,
>>> Petr
> 
>>> [1] https://github.com/linux-test-project/ltp/blob/12765c115f11026c090ab0ee5dd79b38d95ef31f/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c#L91-L93
> 
> 

