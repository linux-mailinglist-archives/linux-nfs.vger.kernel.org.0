Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31A972AAD2
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jun 2023 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjFJKNZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Jun 2023 06:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJKNY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Jun 2023 06:13:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4F2358E
        for <linux-nfs@vger.kernel.org>; Sat, 10 Jun 2023 03:13:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9745d99cfccso454785366b.1
        for <linux-nfs@vger.kernel.org>; Sat, 10 Jun 2023 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686392001; x=1688984001;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwSqoduq5T39O40D94Vu5C1QaAzbF3WUkQpZySO6WBs=;
        b=RgA725oDMIwZpl+itXuA+3lQA8dvpQLluxWQvfSpy97f3+Nr4RjX4qR0qZgn5NrAAx
         ht4f46PZvv4thJgVtlggKMkTgOMHAsAHN6PW2KX81OXJgOnLdnXnvP68HzceziDkfGQz
         1XzNZnWQ4TAOtVuq1Zf1PdF5IJuje+QnBQJgHozPqiOQXuyou8TWXsaq0620vxPfwyEz
         t+vrZz/LEF52S3oSP8DnwzIS0DZqdL7dKpFvPEy9B9xLjOywHk1L/TUrGSKwtPehf4YY
         /BCOt2PdXao/jM7HOY4PXSJVXKUZIG7RH/vvs240y3i62Fv7YOqLg2Yfu/JVum4hwCW8
         vnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686392001; x=1688984001;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwSqoduq5T39O40D94Vu5C1QaAzbF3WUkQpZySO6WBs=;
        b=V9hdUiS2gwLUJ+eoKuWlDOOQpy5Dv60gsqKcFURbeNkrTuYot9U5L3XMMfOEdzucx9
         ndhR0sA99zcohejlGD3AWwkAuyBChk+7BmqTdyN1YeBjsooy47RZDJe58+uAt9fAy5y1
         35gVK1tU1/EcXOuI7s00alYwcVgd/MHxiHaApCDuNaCmE/cmp/qeunMrkHdo0R5lKZIN
         5Ui2hgblXva0QZamUYEp4wo2PqC02c1t1i6YVF5bL5HomThof8XUhj/Rt5bHgsZdNyCP
         9XkEXuxZLEgfe5vazD2RzU+79wsOzSmUizbonVwb/VAdL+10XS4bFzjFguGYcd5A+VDO
         5+cA==
X-Gm-Message-State: AC+VfDzBz/bDDJJul8d2Jicr9unF/tu/ARX1Hd0or5bwRvRXz1jkdmEx
        plOOp/Y/Wk+roDWRnwFQF4vpf+En7tmhZuwGeD4=
X-Google-Smtp-Source: ACHHUZ5iKLlvwsC4h7DK67SuikxCz8ucri5Nb47YuWjyj8TznFb9TGsjWFsTaM4V+6G6DgB1pQQFHw==
X-Received: by 2002:a17:907:70a:b0:96f:a935:8997 with SMTP id xb10-20020a170907070a00b0096fa9358997mr4933639ejb.12.1686392001548;
        Sat, 10 Jun 2023 03:13:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j25-20020aa7c0d9000000b005148f0e8568sm2717953edp.39.2023.06.10.03.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 03:13:21 -0700 (PDT)
Message-ID: <c6e8ecea-d85c-dc12-34c0-6070f104d61b@linaro.org>
Date:   Sat, 10 Jun 2023 12:13:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 3/3] NFSv4.2: Rework scratch handling for READ_PLUS
 (again)
Content-Language: en-US
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com
References: <20230609200013.849882-1-anna@kernel.org>
 <20230609200013.849882-3-anna@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609200013.849882-3-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 09/06/2023 22:00, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> I found that the read code might send multiple requests using the same
> nfs_pgio_header, but nfs4_proc_read_setup() is only called once. This is
> how we ended up occasionally double-freeing the scratch buffer, but also
> means we set a NULL pointer but non-zero length to the xdr scratch
> buffer. This results in an oops the first time decoding needs to copy
> something to scratch, which frequently happens when decoding READ_PLUS
> hole segments.
> 
> I fix this by moving scratch handling into the pageio read code. I
> provide a function to allocate scratch space for decoding read replies,
> and free the scratch buffer when the nfs_pgio_header is freed.
> 
> Krzysztof Kozlowski hit a bug a while ago with similar symptoms,
> and I'm hopeful that this patch fixes his issue.

Unfortunately it does not help. Same NULL ptr, next-20230609 with this
patchset:


[   26.780433] Unable to handle kernel NULL pointer dereference at virtual address 00000004 when read

[   27.124547] mmiocpy from xdr_inline_decode (net/sunrpc/xdr.c:1424 net/sunrpc/xdr.c:1459) 
[   27.129643] xdr_inline_decode from nfs4_xdr_dec_read_plus (fs/nfs/nfs42xdr.c:1069 fs/nfs/nfs42xdr.c:1152 fs/nfs/nfs42xdr.c:1365 fs/nfs/nfs42xdr.c:1346) 
[   27.136147] nfs4_xdr_dec_read_plus from call_decode (net/sunrpc/clnt.c:2592) 
[   27.142124] call_decode from __rpc_execute (include/asm-generic/bitops/generic-non-atomic.h:128 net/sunrpc/sched.c:952) 
[   27.147232] __rpc_execute from rpc_async_schedule (include/linux/sched/mm.h:368 net/sunrpc/sched.c:1033) 
[   27.152864] rpc_async_schedule from process_one_work (include/linux/atomic/atomic-arch-fallback.h:444 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/workqueue.h:108 kernel/workqueue.c:2599) 
[   27.158935] process_one_work from worker_thread (include/linux/list.h:292 kernel/workqueue.c:2746) 
[   27.164476] worker_thread from kthread (kernel/kthread.c:381) 
[   27.169329] kthread from ret_from_fork (arch/arm/kernel/entry-common.S:134)

Best regards,
Krzysztof

