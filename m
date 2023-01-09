Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737C9661FBD
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjAIIOX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 03:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjAIIOW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 03:14:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185EE81
        for <linux-nfs@vger.kernel.org>; Mon,  9 Jan 2023 00:14:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so7284444wrz.12
        for <linux-nfs@vger.kernel.org>; Mon, 09 Jan 2023 00:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jr2FwX3P1iZIyqTb6rsoFPPaAUL6NdJrS167QJ230/w=;
        b=q5yusg2aaBnoLvE8zqqsgCYfgiuoc56g8R/6j5yEJkQi341zVqAzU0hkRjqHqP+iFC
         Fw40130ftwNQEYVmGKzjNBsZYgnhpEAcaQmfNHeIBYwopToKdSdeulO9rWKW00Ybicwk
         sVoDRO8j1AZc4Z5i31nSgtvBAG1AjNwkmvGK8wrk5SdbrVNHdEPDeuRtMjaiMwtTse1q
         bSmKVxGKaKYujgJOsGk33szMTMWhNZgcBF7XiKlI4f64b+rXj9aw/MeAgoN4xijvHAAN
         jSun29i7Degpwzq0+DGNKpQK4xGBhgWQKjLkakEN/5ODBtO4YbkQzlRHofHyLcogPDMd
         c3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr2FwX3P1iZIyqTb6rsoFPPaAUL6NdJrS167QJ230/w=;
        b=esnQWT9IzsGQydD+0mn0az6qPoAVy0iWzfUAOdHVOfbLvt7HguYRN/+IXRYJrgY8cs
         tDt4iFWcVdjelb7qGlTjXd3eRPmgnGrgbHvNKF/UYxI8O5D4FWEihLVRsm39fniGXEF6
         ryMs6ziBLxJOHPw/pq8+rBXvQBqZjOQZKku2lT61MGG1mu+rs5/+5n1J95lZzCX5ChTQ
         wPH2vBGU4n5QJqEeEbw6xOdQO94f89aneIu0qP4t9HaMYLV522DKM/3IKVxnHgM3wbcC
         aSD6JG+Zc4pk/cSqVJuCxZ3aK29sFYtpGfj34/nbTFBExjEtupcjXcG2GEDyTnOPzKlc
         TJUg==
X-Gm-Message-State: AFqh2krlqvUQn6ttvHYJ+n9/2lswOsMxtqL4FHFKlOfa82enw6PbdTI8
        1/po8wF9a+H0pji5COc1m1aw5LUBZceXmbfP
X-Google-Smtp-Source: AMrXdXuBT//WvM7GCSkw/bEgSnHDiNUBAR2qEQhZ1dxgYHAS3iU3EvBb01ARoB8OicYbWn71UCJl7g==
X-Received: by 2002:a05:6000:60d:b0:2a5:6244:329e with SMTP id bn13-20020a056000060d00b002a56244329emr13639467wrb.40.1673252058065;
        Mon, 09 Jan 2023 00:14:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d678d000000b002bbe8686d6fsm3923501wru.117.2023.01.09.00.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:14:17 -0800 (PST)
Message-ID: <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
Date:   Mon, 9 Jan 2023 09:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
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

On 08/01/2023 18:09, Trond Myklebust wrote:
> Hi Krzysztof,
> 
>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification]
>>
>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
>>> KConfig value for READ_PLUS") as one leading to NULL pointer exception
>>> when mounting NFS root on NFSv4 client:
>>>
>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
>>> argument
>>> [   26.199478] 8<--- cut here ---
>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
>>> virtual address 00000004
>>> ...
>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/0x358
>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>
>>> Full OOPS attached. Full log available here:
>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>>
>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commit is
>>> not the cause, but rather making it default caused the regression.
>>>
>>> I did not make the bisect yet which commit introduced it, if every
>>> config includes NFS_V4_2_READ_PLUS.
>>
>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed to:
>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>>
>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> Date:   Thu Jul 21 14:21:34 2022 -0400
>>
>>    NFS: Replace the READ_PLUS decoding code
>>
>>    We now take a 2-step process that allows us to place data and hole
>>    segments directly at their final position in the xdr_stream without
>>    needing to do a bunch of redundant copies to expand holes. Due to the
>>    variable lengths of each segment, the xdr metadata might cross page
>>    boundaries which I account for by setting a small scratch buffer so
>>    xdr_inline_decode() won't fail.
>>
>>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> With a trace:
>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
>> argument
>> [   25.986237] random: crng init done
>> [   26.264564] 8<--- cut here ---
>> [   26.266823] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000fe8
>> ...
>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x790
>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
>> [   26.625570]  worker_thread from kthread+0xf4/0x128
>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>>
> 
> Is this test being run against a 6.2-rc2 server, or is it an older server platform? We know there were bugs in older server implementations, so the question is whether this might be a problem with handling a bad/corrupt RPC reply from the server, or whether it is happening against code that is supposed to have been fixed?

I would say that buggy server should not cause NULL pointer dereferences
on the client. Otherwise this is a perfect recipe for a rogue server in
the network to start crashing clients and running exploits... Imagine a
compromised machine (through some other means) in a local company
network running now a server with NFS share "HR salary data" or "HR
planned layoffs", where unsuspected people in that network access it
leading to exploit of NFS code on their side...

Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH

Which points that it is not latest stable, so anyway I need to update.

Best regards,
Krzysztof

