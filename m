Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799B4691A2A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Feb 2023 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjBJIl5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Feb 2023 03:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjBJIly (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Feb 2023 03:41:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD5DF75F
        for <linux-nfs@vger.kernel.org>; Fri, 10 Feb 2023 00:41:49 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o18so4289345wrj.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Feb 2023 00:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHt2sN5kO9hTQMM0zKIWDb2eKk7HLoKLk5HWb9UMPzk=;
        b=xI5nNS/1Sy5Z8YKlq0NWCzBMvQJxcvAV4j8doFPi7NxzGBsmP/CWHWxs6Sbny+etv/
         o1aDz9tJrv6h8gRxCDb7FsPuIIMWcgMYG5pvktD95XlKuz+8miiN9a+lbGSI0Svfe3iQ
         ktHXSLd53igly2rAC7fHSNHytLpjl6OG2DuvaLF7YEkZUXaX4EYrXVkRUCLvN5nZ7V2j
         SB8+FimB8+f/69yscL9MqCWbwnGwfos/NjsxryGXGnFHUiATTbKrr8jEqqHOBiBe1fh/
         u31mtO6Xf9dm6cadwz9VySa0RP+CtKzRBRaWJoTWLUy+vVAjOoNrCH/Q3vrABH5IaWcS
         cZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHt2sN5kO9hTQMM0zKIWDb2eKk7HLoKLk5HWb9UMPzk=;
        b=AFav2/Mh7yEo5/ZNkfj53hqy1r6FNGWFEl3HxTg3vk1cU22rReU0fCvha+FOKE2gJ6
         0RMtkVlA3R0uiCkLBy1cKlC1wRh0aPQ1Isr9WkYUKA4n82clJC5hKCMMMf5oYtKoYYHN
         GREAXZ0tIahGWu3MSp0SPw5NKkgddBfoIYX0TfSMZnI/pwDiRgB+2P7uPkxcatPQk1sL
         JpxsL5SYtVQnF1HSVkwEL17CyijxGw2takv+SgctssZxE2NcIenqCY7vfnhUOVDKbOJA
         St0AkfQUAJ+T8smiRQhGa+vxIMaJ3YcSEh9vWpM963EY8wVCTHaxHGfxxFBDX457IPz8
         h+xw==
X-Gm-Message-State: AO0yUKUsKAMxpUN8bkuAb1xupswDJ00famLm5EZodgNyKdicXrmNIMAz
        aCnq0Wf6/rP36ASp1WUVpJ+xBazCSYYdZ3I2
X-Google-Smtp-Source: AK7set/GOeOoLANqVTqDZ1w9vIy7Ub5h/QS/XqgjhJmxzJZ/4/26II9FP9IQC7yNotgVpx0V/qc2ag==
X-Received: by 2002:adf:fa50:0:b0:2c3:d032:5b29 with SMTP id y16-20020adffa50000000b002c3d0325b29mr4193096wrr.12.1676018507664;
        Fri, 10 Feb 2023 00:41:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e7-20020adfe7c7000000b002bdfe3aca17sm3211692wrn.51.2023.02.10.00.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 00:41:47 -0800 (PST)
Message-ID: <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org>
Date:   Fri, 10 Feb 2023 09:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
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
 <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org>
 <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
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

On 09/02/2023 19:22, Anna Schumaker wrote:
> Hi Krzysztof,
> 
> On Mon, Jan 23, 2023 at 2:58 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 22/01/2023 23:25, Anna Schumaker wrote:
>>> Hi Krzysztof,
>>>
>>> On Mon, Jan 9, 2023 at 3:46 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
>>>>> On 08/01/2023 18:09, Trond Myklebust wrote:
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>>
>>>>>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification]
>>>>>>>
>>>>>>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
>>>>>>>> KConfig value for READ_PLUS") as one leading to NULL pointer exception
>>>>>>>> when mounting NFS root on NFSv4 client:
>>>>>>>>
>>>>>>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>>>>>>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
>>>>>>>> argument
>>>>>>>> [   26.199478] 8<--- cut here ---
>>>>>>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
>>>>>>>> virtual address 00000004
>>>>>>>> ...
>>>>>>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>>>>>>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/0x358
>>>>>>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>>>>>
>>>>>>>> Full OOPS attached. Full log available here:
>>>>>>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>>>>>>>
>>>>>>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commit is
>>>>>>>> not the cause, but rather making it default caused the regression.
>>>>>>>>
>>>>>>>> I did not make the bisect yet which commit introduced it, if every
>>>>>>>> config includes NFS_V4_2_READ_PLUS.
>>>>>>>
>>>>>>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed to:
>>>>>>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>>>>>>>
>>>>>>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
>>>>>>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>> Date:   Thu Jul 21 14:21:34 2022 -0400
>>>>>>>
>>>>>>>    NFS: Replace the READ_PLUS decoding code
>>>>>>>
>>>>>>>    We now take a 2-step process that allows us to place data and hole
>>>>>>>    segments directly at their final position in the xdr_stream without
>>>>>>>    needing to do a bunch of redundant copies to expand holes. Due to the
>>>>>>>    variable lengths of each segment, the xdr metadata might cross page
>>>>>>>    boundaries which I account for by setting a small scratch buffer so
>>>>>>>    xdr_inline_decode() won't fail.
>>>>>>>
>>>>>>>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>>    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>
>>>>>>> With a trace:
>>>>>>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
>>>>>>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
>>>>>>> argument
>>>>>>> [   25.986237] random: crng init done
>>>>>>> [   26.264564] 8<--- cut here ---
>>>>>>> [   26.266823] Unable to handle kernel NULL pointer dereference at
>>>>>>> virtual address 00000fe8
>>>>>>> ...
>>>>>>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>>>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
>>>>>>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
>>>>>>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x790
>>>>>>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
>>>>>>> [   26.625570]  worker_thread from kthread+0xf4/0x128
>>>>>>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>>>>>>>
>>>>>>
>>>>>> Is this test being run against a 6.2-rc2 server, or is it an older server platform? We know there were bugs in older server implementations, so the question is whether this might be a problem with handling a bad/corrupt RPC reply from the server, or whether it is happening against code that is supposed to have been fixed?
>>>>>
>>>>> I would say that buggy server should not cause NULL pointer dereferences
>>>>> on the client. Otherwise this is a perfect recipe for a rogue server in
>>>>> the network to start crashing clients and running exploits... Imagine a
>>>>> compromised machine (through some other means) in a local company
>>>>> network running now a server with NFS share "HR salary data" or "HR
>>>>> planned layoffs", where unsuspected people in that network access it
>>>>> leading to exploit of NFS code on their side...
>>>>>
>>>>> Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
>>>>>
>>>>> Which points that it is not latest stable, so anyway I need to update.
>>>>
>>>> I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
>>>> latest stable and I can reproduce the issue. Therefore:
>>>> 1. It is visible on two stable (one new, one old) kernels on the server,
>>>> 2. Buggy or rogue server should not cause NULL pointer on remote devices...
>>>
>>> I'm still working on this issue, but I haven't been able to reproduce
>>> it with my setup at all yet. I was hoping I could ask you a couple of
>>> questions?
>>>
>>> - Are both client and server run on a Raspberry Pi 3?
>>
>> No, server is Rpi3, client is Odroid HC1.
>>
>>> - Is there a specific workload that triggers the bug, or is it just
>>> during boot when using nfsroot?
>>
>> No specific workload - mounting system with nfsroot. You have there full
>> logs as it is reproducible every time.
>>
>>> - Would it be possible to get a Wireshark network trace of the crash
>>> (you'll have to run this on the server due to nfsroot).
>>
>> I'll check.
> 
> Any luck getting the wireshark trace? I don't have access to the
> Odroid HC1 board, so all my attempts at reproducing the problem have
> been with qemu & libvirt, which doesn't seem to be hitting this issue.

I'll send pcap dump off list. Failure is in similar place:
[   23.876714] systemd[1]: Hostname set to <odroidhc1>.
[   24.061568] systemd[1]: bpf-lsm: BPF LSM hook not enabled in the
kernel, BPF LSM not supported
[   24.078774] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL,
pid=1 'systemd'
[   24.220531] 8<--- cut here ---
[   24.222333] Unable to handle kernel NULL pointer dereference at
virtual address 00000004 when read


> 
> I was also wondering if it would be possible to turn on KASAN in your
> kernel, which should give us a little more info?

I'll try with KASAN.

Best regards,
Krzysztof

