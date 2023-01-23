Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F666775E9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 08:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjAWH6x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 02:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjAWH6u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 02:58:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC74C11EAA
        for <linux-nfs@vger.kernel.org>; Sun, 22 Jan 2023 23:58:46 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so7856302wms.2
        for <linux-nfs@vger.kernel.org>; Sun, 22 Jan 2023 23:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ga+VvRSpJu4l76oKd4H9Up9XpN0x+8jxuTj2ZPdTkg=;
        b=dJxCi1AFS3cpFWEya02piMDot6FG94QU9gzI/eijeZa4WNFhAPMYqMU5QocVY9k3bs
         aMDKXMvB9l/ZvKbzOusS9/jBpetySiLY3JnmiwjWlxi2ueG+d2ePL2BDMTIxx/4oQkOa
         0XTvHCod9lcbRZRjTR0WWOlO5tJhsIpJwMzst3tUrkXKikgSBZxQGsasLjYpc1URtfdR
         8EyssugnEYt5OOghTrIoOHiCX7pIc6gRvlDS+Hd3gNL5ykj7xyM8AxVmLeHJy8WPQzf5
         M4ymJCLiqs8khjE5gIZFEFKPtN1m5sKFalMDqUAsQuOqeau7Zgp/CRsqVfQFFGxsqQZI
         blOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ga+VvRSpJu4l76oKd4H9Up9XpN0x+8jxuTj2ZPdTkg=;
        b=n8n5HLdyXXwKvcp5q4ESMOXUNcFdLng3oQ6/av0eLj/nTtB7fCnrKKiceFS/VYSEfU
         8BhOFVg7C0a+8Ebp/QP1ZZtEZAGAjflC3HaBO7NFx4WUqzs4QnHcozd6QEjktvhZoiK1
         I6MsqC1KfyxPBhTNGIlZKePN7n/DNnRsJCR5yDrrDNECVoLlvq9Xy/KIAiI29OdAAIzq
         fhH0QIz1V2HDb0VTxfA+twEUZh9m4NELy1rvGM1HD4dW7xhfUCO0YDunJGL6Cn16yGhC
         lvSTnrABVfBIVpQ6Y8utaJNJaZ8fjDl+JNwVbeV8N5mVcNPGLpkCCvSke4ikhl9h/MNT
         1tiA==
X-Gm-Message-State: AFqh2kryByCK/HsxMSzT+Dsaa3rZ4m8LPF6pf/Jtpu4O4nh2KjklW6fD
        32+4srQNctT4rlJfWEmaBz85jw==
X-Google-Smtp-Source: AMrXdXtPj+YoxxIqpGGDDb+F0QTBLzAVI28vB9NS3SW+G61KVEYNL/4Mrxs2O/Q7iBQLYu2hPluudA==
X-Received: by 2002:a05:600c:c10:b0:3da:f5e6:a320 with SMTP id fm16-20020a05600c0c1000b003daf5e6a320mr28059723wmb.22.1674460725302;
        Sun, 22 Jan 2023 23:58:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003cffd3c3d6csm10649776wmq.12.2023.01.22.23.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 23:58:44 -0800 (PST)
Message-ID: <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org>
Date:   Mon, 23 Jan 2023 08:58:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Content-Language: en-US
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
 <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22/01/2023 23:25, Anna Schumaker wrote:
> Hi Krzysztof,
> 
> On Mon, Jan 9, 2023 at 3:46 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
>>> On 08/01/2023 18:09, Trond Myklebust wrote:
>>>> Hi Krzysztof,
>>>>
>>>>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification]
>>>>>
>>>>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
>>>>>> KConfig value for READ_PLUS") as one leading to NULL pointer exception
>>>>>> when mounting NFS root on NFSv4 client:
>>>>>>
>>>>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>>>>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
>>>>>> argument
>>>>>> [   26.199478] 8<--- cut here ---
>>>>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
>>>>>> virtual address 00000004
>>>>>> ...
>>>>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>>>>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/0x358
>>>>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>>>
>>>>>> Full OOPS attached. Full log available here:
>>>>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>>>>>
>>>>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commit is
>>>>>> not the cause, but rather making it default caused the regression.
>>>>>>
>>>>>> I did not make the bisect yet which commit introduced it, if every
>>>>>> config includes NFS_V4_2_READ_PLUS.
>>>>>
>>>>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed to:
>>>>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>>>>>
>>>>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
>>>>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>> Date:   Thu Jul 21 14:21:34 2022 -0400
>>>>>
>>>>>    NFS: Replace the READ_PLUS decoding code
>>>>>
>>>>>    We now take a 2-step process that allows us to place data and hole
>>>>>    segments directly at their final position in the xdr_stream without
>>>>>    needing to do a bunch of redundant copies to expand holes. Due to the
>>>>>    variable lengths of each segment, the xdr metadata might cross page
>>>>>    boundaries which I account for by setting a small scratch buffer so
>>>>>    xdr_inline_decode() won't fail.
>>>>>
>>>>>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>
>>>>> With a trace:
>>>>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
>>>>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
>>>>> argument
>>>>> [   25.986237] random: crng init done
>>>>> [   26.264564] 8<--- cut here ---
>>>>> [   26.266823] Unable to handle kernel NULL pointer dereference at
>>>>> virtual address 00000fe8
>>>>> ...
>>>>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
>>>>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
>>>>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x790
>>>>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
>>>>> [   26.625570]  worker_thread from kthread+0xf4/0x128
>>>>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>>>>>
>>>>
>>>> Is this test being run against a 6.2-rc2 server, or is it an older server platform? We know there were bugs in older server implementations, so the question is whether this might be a problem with handling a bad/corrupt RPC reply from the server, or whether it is happening against code that is supposed to have been fixed?
>>>
>>> I would say that buggy server should not cause NULL pointer dereferences
>>> on the client. Otherwise this is a perfect recipe for a rogue server in
>>> the network to start crashing clients and running exploits... Imagine a
>>> compromised machine (through some other means) in a local company
>>> network running now a server with NFS share "HR salary data" or "HR
>>> planned layoffs", where unsuspected people in that network access it
>>> leading to exploit of NFS code on their side...
>>>
>>> Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
>>>
>>> Which points that it is not latest stable, so anyway I need to update.
>>
>> I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
>> latest stable and I can reproduce the issue. Therefore:
>> 1. It is visible on two stable (one new, one old) kernels on the server,
>> 2. Buggy or rogue server should not cause NULL pointer on remote devices...
> 
> I'm still working on this issue, but I haven't been able to reproduce
> it with my setup at all yet. I was hoping I could ask you a couple of
> questions?
> 
> - Are both client and server run on a Raspberry Pi 3?

No, server is Rpi3, client is Odroid HC1.

> - Is there a specific workload that triggers the bug, or is it just
> during boot when using nfsroot?

No specific workload - mounting system with nfsroot. You have there full
logs as it is reproducible every time.

> - Would it be possible to get a Wireshark network trace of the crash
> (you'll have to run this on the server due to nfsroot).

I'll check.

> - Can you share your export options from /etc/exports and the mount
> options that the client uses?

exports are the same since like 5 years or more:

/srv/nfs/odroidhc1	192.168.1.0/24(rw,async,no_root_squash,no_subtree_check)
/srv/nfs/odroidhc1-home
192.168.1.0/24(rw,async,no_root_squash,no_subtree_check)


> 
> Thanks,
> Anna
> 
>>
>> Best regards,
>> Krzysztof
>>

Best regards,
Krzysztof

