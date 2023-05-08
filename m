Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4D46F9DDB
	for <lists+linux-nfs@lfdr.de>; Mon,  8 May 2023 04:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjEHCuh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 May 2023 22:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHCuf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 May 2023 22:50:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE45FC1
        for <linux-nfs@vger.kernel.org>; Sun,  7 May 2023 19:50:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f00d41df22so26393616e87.1
        for <linux-nfs@vger.kernel.org>; Sun, 07 May 2023 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20221208.gappssmtp.com; s=20221208; t=1683514233; x=1686106233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omFhmpWfBFJG0jkrfHOXVs2//eYJEOe02UXxq4pKYA8=;
        b=uDJ+sjSb0CuQi5GnnrqUR9h9rKMW7xJMfg4kMFpcSToQBlkhFiTQOhvMaKjB/P9szY
         ac+Fad1fu7JszhAUD3SRsDHnVa+jn/Bd7A/DNYYpsC7QRQbeh5LI/zDmAYPZOjbILEqF
         Ucz29HJ0/axngV41J5sCWyUYZJY4Ake4ENlTRAcvhZunK+axdR/FRG5WMudrvjLHGzHP
         eVdkGJWKeDTTeLyes/ZBBtV/exVPgSjv7GIMb7AZv0pdL0Hp0Q9MrswEcF+PXax2BQqD
         m8eIcjGmyRyphyaczMG/jU+axi+zgV9xxY9Wy5Oc6iBYNpk992WHHgPGbdj7cCnucWm+
         wKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683514233; x=1686106233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omFhmpWfBFJG0jkrfHOXVs2//eYJEOe02UXxq4pKYA8=;
        b=WyTSPVTsgREmUJVjOVMh5mgU9mnpG+8RglgTbRTDLT/MQzxzRNHNN7yt07fUkQ1fBA
         MTRHwnjfxK6Cv0W8p8EuyVtdccWLc78Rl7/egZCvzZ3oFM+feW3wPE/SIAfDI8ddr7kK
         5M0uLhkicpchIqJ/0tlMYyfB2tiGaF6HX+eBPis1I0LetOmPQ39GfAn9zHzuljjro9yS
         k6/6sieauyVPjtVGLYe44yJuQ8LeRu0VhVh9DSuFFdYMNv3eyAeNfpYewAJ//Dp/Gjyi
         GmxIwaNmi1C3EWiyl3BdTuo/hnD/zQxsS03/LLbvrw8v9ieZtndrRseFUYLIDjpzOOlW
         DAzg==
X-Gm-Message-State: AC+VfDwGK1Ry3DgsM5rWYQh/ZNVSywSot1hTmImHb72M3hLkzMkrW4GH
        TkD22XGpfGo5vPtyb1ojdmMJBw==
X-Google-Smtp-Source: ACHHUZ7/7LsA1qi8V7FDWQkIqlJeKKgdJSpCGRN0J3H9cSrGKPBKWdcRg9t16DSKLshSMqYqm3qM0w==
X-Received: by 2002:a2e:8ed2:0:b0:2a7:80d5:a43c with SMTP id e18-20020a2e8ed2000000b002a780d5a43cmr2166694ljl.5.1683514232751;
        Sun, 07 May 2023 19:50:32 -0700 (PDT)
Received: from [192.168.8.148] ([85.193.100.38])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e3612000000b002a8c4a26960sm1013180lja.75.2023.05.07.19.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 19:50:32 -0700 (PDT)
Message-ID: <81826e4f-aa4c-1213-8b2e-28ef57caf1a3@cogentembedded.com>
Date:   Mon, 8 May 2023 08:50:29 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, Jeff Layton <jlayton@kernel.org>
Cc:     ltp@lists.linux.it, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org,
        Steve Dickson <steved@redhat.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
References: <20230502075921.3614794-1-pvorel@suse.cz>
 <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
 <20230502134146.GA3654451@pevik>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20230502134146.GA3654451@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>> rpcbind was obviously written in a time before namespaces were even a
>> thought to anyone. I wonder if there is something we can do in rpcbind
>> itself to guard against these sorts of shenanigans? Probably not, I
>> guess...
> 
> Maybe Steve or Neil have some idea.
> 
>> Is /var shared between namespaces in this test for some particular
>> reason?
> 
> I hope I got , we talk about /var/run/netns/ltp_ns, which is symlink to
> /proc/$pid/ns/net. Or is it really about /run/rpcbind.sock vs
> /var/run/rpcbind.sock?

The overall picture is:

- by design, filesystem namespaces and network namespaces are independent, it is pretty ok for two 
processes to share filesystem namespace and be in different network namespaces, or vice versa.

- the code in question, while being in the kernel for ages, is breaking this basic design, by using 
filesystem path to contact a network service,

- thus the fix is: just not do that.

I consider kernel contacting rpcbind via AF_UNIX being a bug in the kernel namespace implementation. So 
this is a rare case when a test suite (LTP) helped to find a non-obvious kernel bug. Just need to fix 
that bug, if not yet.

Rpcbind listens both via AF_INET and via AP_UNIX, and did so for ages.
It is even not possible to disable AF_INET listening without patching code. By stopping contacting it 
via AF_UNIX, it is virtually impossible to break anything.

Nikita
