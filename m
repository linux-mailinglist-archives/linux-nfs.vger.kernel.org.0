Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6CC661579
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 14:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAHNZq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 08:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAHNZp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 08:25:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDE51005D
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 05:25:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso1633579wmb.3
        for <linux-nfs@vger.kernel.org>; Sun, 08 Jan 2023 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDnBglhmzrQ+ClSXJPmLD7+J1IxdL5cQgOysiOvvUiw=;
        b=eNEHVpDt9oHcojHcitkH0RCFZbeCHiKuUEagDi9ApI0PQk7B6q6TOUmIbbLEdM1o1c
         lrTJWPTi9nP3BTxC4nE+BQ3kpUS9/WmalhvXEVg3Ixw8aSv5GGpOww4ujobdhkNLmzW4
         JLypJU8j7d6X7lL5kUfl7yWzn+04gMiE41Ny3txm70Rts0Zr8I2Ax+qoorYRoTD1Vg7H
         5j7zosyfyOD9XwWxIm4VIqAe3vHRg1aw/lP8LC8BvDenCovDeKCMm8/N+slPLTRRnPUE
         u3jBE9/Sw2cH6tHHcNG6wpuBpbPxEe+onr6Kh69FHruG98LFVJcVQfkBr4ZuTXuNczSt
         /ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDnBglhmzrQ+ClSXJPmLD7+J1IxdL5cQgOysiOvvUiw=;
        b=GDt1UqrEiGyyJWnfs7AxH14kf3GKeKp28BRf8jWPQucZgkRmnhmIMNPyuPmZTNvh6Y
         oj5Rysbm8CtxY8321sybcWlHcGuG1bcaT9hbscH9BFX5MQu0FBT+K9tP17WgNt2VevGl
         JDSyQ3evI7S4tlpIe8uJqcgU828tbeAM601WePUbdotWF9QX0PoKlMn8qo9YJ7ceDP/0
         I+eEIK/h5uvl95Yk+0RKq/679LzJzXpx8pqb8Uri3WbGwyd/IolnuhSFl3bl1uJJWTuT
         CgtJfzqx304xMFn2WHmtyc0nJg/+S/SZfZQkiG1n+x8D1ccpf8+MO7uKj2UKEMUq+fVb
         TGEg==
X-Gm-Message-State: AFqh2koeTjheyggBSijVynLf48xMxwqlT7YVLZUHWxINYM9BBqItgtuy
        NCRyzfRcIXCVZBzCqorXr/I9Nt98V+zT2smO
X-Google-Smtp-Source: AMrXdXvmxxT+2bZviglEVMaCStY9tOI31zWc9TENsTM9uSLk3EaKSggauRRgvpQ6d98KRB5ltb90jA==
X-Received: by 2002:a05:600c:4e04:b0:3d2:381f:2db5 with SMTP id b4-20020a05600c4e0400b003d2381f2db5mr42893495wmq.22.1673184339665;
        Sun, 08 Jan 2023 05:25:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm4060240wmq.9.2023.01.08.05.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 05:25:39 -0800 (PST)
Message-ID: <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
Date:   Sun, 8 Jan 2023 14:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
In-Reply-To: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
> Hi,
> 
> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
> KConfig value for READ_PLUS") as one leading to NULL pointer exception
> when mounting NFS root on NFSv4 client:
> 
> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
> argument
> [   26.199478] 8<--- cut here ---
> [   26.201366] Unable to handle kernel NULL pointer dereference at
> virtual address 00000004
> ...
> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/0x358
> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
> 
> Full OOPS attached. Full log available here:
> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
> 
> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commit is
> not the cause, but rather making it default caused the regression.
> 
> I did not make the bisect yet which commit introduced it, if every
> config includes NFS_V4_2_READ_PLUS.

When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed to:
d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")

commit d3b00a802c845a6021148ce2e669b5a0b5729959
Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
Date:   Thu Jul 21 14:21:34 2022 -0400

    NFS: Replace the READ_PLUS decoding code

    We now take a 2-step process that allows us to place data and hole
    segments directly at their final position in the xdr_stream without
    needing to do a bunch of redundant copies to expand holes. Due to the
    variable lengths of each segment, the xdr metadata might cross page
    boundaries which I account for by setting a small scratch buffer so
    xdr_inline_decode() won't fail.

    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

With a trace:
[   25.898462] systemd[1]: Set hostname to <odroidhc1>.
[   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
argument
[   25.986237] random: crng init done
[   26.264564] 8<--- cut here ---
[   26.266823] Unable to handle kernel NULL pointer dereference at
virtual address 00000fe8
...
[   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
[   26.603222]  call_decode from __rpc_execute+0xd0/0x890
[   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
[   26.613960]  rpc_async_schedule from process_one_work+0x294/0x790
[   26.620030]  process_one_work from worker_thread+0x54/0x518
[   26.625570]  worker_thread from kthread+0xf4/0x128
[   26.630336]  kthread from ret_from_fork+0x14/0x2c


Best regards,
Krzysztof

