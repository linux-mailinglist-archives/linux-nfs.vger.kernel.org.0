Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9735662076
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 09:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbjAIIoX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 03:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbjAIImn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 03:42:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A814036
        for <linux-nfs@vger.kernel.org>; Mon,  9 Jan 2023 00:42:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so5989430wms.4
        for <linux-nfs@vger.kernel.org>; Mon, 09 Jan 2023 00:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDNqtXzc1k5JQX+5JmREIHtLjz5O91JN1ujAKPT/qRs=;
        b=xpqWwCHHW4ovQD4zDO88o6zcHbCIBCNQbysQOiw6VisUPPSCqGrgJspH8xdUAWrKX7
         X6if6R8bnFVxYJpGylaiUPzi2cFm+6+rzjCQFf1hQRYYfs6SzIc66SjAvfi1qe9my/bg
         B3LS60rZ/jSK4MUs8yeuBSEwwLUY2mABUbWx+QPE9XIbgzHtGdEETBVgu96JQcvHBF0e
         xPmWKjPBI95RTtrBba+wFJrgTOjXyUhPIl6dejo8/eEinOs0qUrddLh95IFvtQPosw9a
         9CLHAgDqc4btZQoNTdupqaXAp1Y7dmqOvLDzDhGEuMRfqnPCwq4LiYZhPkdkiAU36Nw0
         /4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDNqtXzc1k5JQX+5JmREIHtLjz5O91JN1ujAKPT/qRs=;
        b=IESEt/zxffaXgNTQBcJUS9h75MQyEnEkDlFswYm8GH5/PaSTmgkt2rCTvas7H1rtl5
         YYyK6HJm2tRziBAisj8RahrjV0b5g4sPj7CNm4Frqj3Lx/6qP1y4EH2ZXL+fpvxLF4jW
         4i7bzegfiiYPspfFsxnKXf6hQiUqAFVGnZR42PNRBOVFmAB4A23rimY+XL6wstc1xWIO
         L3TMuoyTFg+o8qlWP6VsvYy3F6OIplpOdxlmns5mm5L0vBD9ctNJwZscn62TtgrN6Nlw
         c7qECn+bAcGfq1XziHNpyVokO+masc46T5vnNgY30Xm0yUH7WAw9TsjeHYlqzZXa3ttW
         j06Q==
X-Gm-Message-State: AFqh2kqQFZXi86/Gov8hr/CxV4m6SVhHpT8SQ0VGUciJ8PatPL9Lg/Ja
        Hicw8k88lb+kyR9XHDBPcc3sMyQxlqZ1j+Y9
X-Google-Smtp-Source: AMrXdXs74Hl49op2dbDkPETVxdYir/RFfSNCaTDjwTZAvf1XlwniEiIe42JcO/fF72xSWzZtXpEqRQ==
X-Received: by 2002:a05:600c:5108:b0:3d1:ce35:4224 with SMTP id o8-20020a05600c510800b003d1ce354224mr45314615wms.11.1673253752193;
        Mon, 09 Jan 2023 00:42:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6bd12ac27sm11944698wmq.37.2023.01.09.00.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:42:31 -0800 (PST)
Message-ID: <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
Date:   Mon, 9 Jan 2023 09:42:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
In-Reply-To: <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
> On 08/01/2023 18:09, Trond Myklebust wrote:
>> Hi Krzysztof,
>>
>>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification]
>>>
>>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>>>> Hi,
>>>>
>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
>>>> KConfig value for READ_PLUS") as one leading to NULL pointer exception
>>>> when mounting NFS root on NFSv4 client:
>>>>
>>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
>>>> argument
>>>> [   26.199478] 8<--- cut here ---
>>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 00000004
>>>> ...
>>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/0x358
>>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>
>>>> Full OOPS attached. Full log available here:
>>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>>>
>>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commit is
>>>> not the cause, but rather making it default caused the regression.
>>>>
>>>> I did not make the bisect yet which commit introduced it, if every
>>>> config includes NFS_V4_2_READ_PLUS.
>>>
>>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed to:
>>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>>>
>>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
>>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>> Date:   Thu Jul 21 14:21:34 2022 -0400
>>>
>>>    NFS: Replace the READ_PLUS decoding code
>>>
>>>    We now take a 2-step process that allows us to place data and hole
>>>    segments directly at their final position in the xdr_stream without
>>>    needing to do a bunch of redundant copies to expand holes. Due to the
>>>    variable lengths of each segment, the xdr metadata might cross page
>>>    boundaries which I account for by setting a small scratch buffer so
>>>    xdr_inline_decode() won't fail.
>>>
>>>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> With a trace:
>>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
>>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
>>> argument
>>> [   25.986237] random: crng init done
>>> [   26.264564] 8<--- cut here ---
>>> [   26.266823] Unable to handle kernel NULL pointer dereference at
>>> virtual address 00000fe8
>>> ...
>>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
>>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
>>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x790
>>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
>>> [   26.625570]  worker_thread from kthread+0xf4/0x128
>>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>>>
>>
>> Is this test being run against a 6.2-rc2 server, or is it an older server platform? We know there were bugs in older server implementations, so the question is whether this might be a problem with handling a bad/corrupt RPC reply from the server, or whether it is happening against code that is supposed to have been fixed?
> 
> I would say that buggy server should not cause NULL pointer dereferences
> on the client. Otherwise this is a perfect recipe for a rogue server in
> the network to start crashing clients and running exploits... Imagine a
> compromised machine (through some other means) in a local company
> network running now a server with NFS share "HR salary data" or "HR
> planned layoffs", where unsuspected people in that network access it
> leading to exploit of NFS code on their side...
> 
> Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
> 
> Which points that it is not latest stable, so anyway I need to update.

I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
latest stable and I can reproduce the issue. Therefore:
1. It is visible on two stable (one new, one old) kernels on the server,
2. Buggy or rogue server should not cause NULL pointer on remote devices...

Best regards,
Krzysztof

