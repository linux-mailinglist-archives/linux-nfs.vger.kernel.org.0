Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DBB6FD3E3
	for <lists+linux-nfs@lfdr.de>; Wed, 10 May 2023 04:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEJCo0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 May 2023 22:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEJCoY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 May 2023 22:44:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A58273C
        for <linux-nfs@vger.kernel.org>; Tue,  9 May 2023 19:44:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2acb6571922so47954711fa.0
        for <linux-nfs@vger.kernel.org>; Tue, 09 May 2023 19:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20221208.gappssmtp.com; s=20221208; t=1683686661; x=1686278661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2XOAZShFq8RdiQ/JcdpE0C0lZjWyHGZgNTXx8hfjF8=;
        b=k+NwNKT47qVXF5SB+5jaJgZ68vytuEen6cXJRqJdvN55QPDagMivHS1JEziXJnVGCp
         pcFv6t8jNfYbzhjCDWnAipVtm7VELVVaOQ+oQLYPQP5OUjsQ6PYuB0fwLWod1odGVfEN
         6rbATTibKrwj5elLbDQSDxnqk7QIwGQsuLMsdaveIaZIJ8IvvLpvhou4EuOsdtsJr2n1
         000Yodsg085rID1m+TaW8Lc4kEiYBJHLFN/RTi7PsYZ/wfKCXYvxsGvDBi+JoPhZDbuI
         IllEsVvtPNrnEnBasseB8XoBPDo2Z04MHI63Fi2o6+qvgBYRloxREJ9kDM/FnUT0HpXp
         SHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683686661; x=1686278661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2XOAZShFq8RdiQ/JcdpE0C0lZjWyHGZgNTXx8hfjF8=;
        b=Ul6OjgR91ehfctpnXHsXdSbU6E8ZkA1LcdYCzLm5EcqTTdXqGv2kqhFfyFUufpttyJ
         VemY80S8iWnJVzxQxfTphcTtMJRBPGlcuwY+2TmiQdBCPc7RYmZr4O6em8nD5l1ecn95
         L2WZiWMF+8dTrTs00ZJU673T81R8XJXUP2vldwXMQ1n1oVhOlhPx1ZlJ91gVlhGa1lap
         ecFvCQy2ZpDINclDXZw8hWZ+mcD15MhnlWc2xfeD/HllFtm1m+2cSEhzO+5kVvxnRCFF
         PrA0xGDkTuLD4dkkK4EchbI2dQ3oedcugT8CJAI657kqw4bpxU0b1fwUUC+RXcDRFHDe
         mB6A==
X-Gm-Message-State: AC+VfDzaM5mO8bgFvJ6ztDu9xejBBM/Spj69LaJ4jjqtxz3aJcwRKA+l
        S3kx+38ecRfe/xBkdj2awwy1Aw==
X-Google-Smtp-Source: ACHHUZ5/UgJSsNisMjjiVB+kpsbIVgeNwhiqSO3VQFx885KqxGdWVUnre0HiyrjMuXZkKron5g2OZw==
X-Received: by 2002:a2e:918c:0:b0:2ac:7d78:3465 with SMTP id f12-20020a2e918c000000b002ac7d783465mr1548638ljg.15.1683686661474;
        Tue, 09 May 2023 19:44:21 -0700 (PDT)
Received: from [192.168.8.148] ([85.193.100.38])
        by smtp.gmail.com with ESMTPSA id u17-20020a2e9b11000000b002adb0164258sm165813lji.112.2023.05.09.19.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 19:44:21 -0700 (PDT)
Message-ID: <f7bb2f33-ef06-b372-b296-49dc70d37c95@cogentembedded.com>
Date:   Wed, 10 May 2023 08:44:18 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Petr Vorel <pvorel@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
        linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
References: <20230502075921.3614794-1-pvorel@suse.cz>
 <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
 <20230502134146.GA3654451@pevik>
 <81826e4f-aa4c-1213-8b2e-28ef57caf1a3@cogentembedded.com>
 <168367324318.15152.8314945101964061099@noble.neil.brown.name>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <168367324318.15152.8314945101964061099@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>> The overall picture is:
>>
>> - by design, filesystem namespaces and network namespaces are independent, it is pretty ok for two
>> processes to share filesystem namespace and be in different network namespaces, or vice versa.
>>
>> - the code in question, while being in the kernel for ages, is breaking this basic design, by using
>> filesystem path to contact a network service,
> 
> Not just in the kernel, but also in user-space.  The kernel contacts
> rpcbind to find how to talk to statd.  statd talks to rpcbind to tell it
> how it where it can be reached.

AFAIR the badness happens when in-kernel nfsd registers itself in rpcbind, using AF_LOCAL to contact it. 
When nfsd is started for a child network namespace, it immediately breaks nfsd running in the root 
network namespace, because ports used by the later get overwritten inside rpcbind and become no longer 
available for local or remote clients.

I'd say it is userspace responsibility to make entire setup consistent against the used namespaces, but 
it is kernel responsibility to keep namespaces isolation while executing individual operations. In the 
case of registering in-kernel nfsd being started, using namespace-safe way to do it looks more important 
for me than the reasoning outlined in commit 7402ab19cdd5 ("SUNRPC: Use AF_LOCAL for rpcbind upcalls") 
that you mention.

And, this won't be fixed by trying to an abstract AF_LOCAL socket before using a filepath-bound one, 
since if one is not available, the nfsd running in the root namespace will still get broken by starting 
nfsd in a child namespace.

Maybe, the way used to reach rpcbind to register in-kernel services shall be special cased.

Nikita
