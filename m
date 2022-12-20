Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEBB6521A6
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Dec 2022 14:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiLTNoE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Dec 2022 08:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiLTNoB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Dec 2022 08:44:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B6E1A073
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 05:44:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o5so11787460wrm.1
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 05:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qb8KUPS0oeSxFKMXM7QL9P9dPC93LY4lqMV3Xlc+Azs=;
        b=6E209t0wFzuEl6XvR9yI9R4VH1OE2fluuYIwZqdv3Fz20aU7xVx2fqZKzLu1vKqpW4
         XDm3gsAbELW1VrA3I0mj/wJsbKU/LQYgLvB0cg211IAwvoZfbRygq9ouACbVgZZvBqM9
         6IlTre76Nq189wUDMDndcSehADdgo7MM7r6p5y6ApkqWNsidQF2CYTkO8QQu6EiTDYFE
         KIRLWQ7O/RUo8BA/RS4IBVNfKZ+a7jZHnDeL15uFkae2H4u5LFrusREFtqrOrfYreHlB
         YkIKT5R74qvbpDBliWkHOyA1mDluO57cstDNcJ2af1ObbKQ6RKE9BgBhTmBciIZ5XqLz
         YK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb8KUPS0oeSxFKMXM7QL9P9dPC93LY4lqMV3Xlc+Azs=;
        b=lURKdhBf4Rjy+1HJGMlclLemhIRXjphTX0kB57w4t16iVONcjYGibp86svHnVSL7jh
         nXPYEhnfQyGI4eUvZFg54kDClxUUUwlGUp0pHMpSLZbQjJk7fHcqVHVeduZF8Bav6ojX
         Q3IgZwfZUSnJZ43r9lj3Qdrh8YDt5/eAufncTKm+mdsIVwNTDd5f7QnM0dBJ7pz3vX3I
         NFrnfsPV9pIqyKW6OW5XeWqYRKl1MWBlCGYXFQXsxBqGRV5eC9Pn4bhAORlG2R65Q/ej
         zjyQn2jrJhljoQwJWgNkpwaKdccCKGi7OgxPm7B2rHULXMxt7HGYCCo2fkS+WktcFRF1
         VVIw==
X-Gm-Message-State: ANoB5pnR+5OH+Ra/ttbhuu2M/2rHXW5AvstHjWrBt54RMXTJIK3uorjm
        Z98aJIlI0IdpL1dK7XdWOhN7oA==
X-Google-Smtp-Source: AA0mqf6fKmmQj+6KNyXZQWS9Vh/hRwbFH/YN04tOEDfQiEu+JKRBUgm71a18IVw4nqFnv8sc+3d1Bg==
X-Received: by 2002:adf:f0ca:0:b0:241:fd48:dccd with SMTP id x10-20020adff0ca000000b00241fd48dccdmr28895454wro.63.1671543838772;
        Tue, 20 Dec 2022 05:43:58 -0800 (PST)
Received: from [10.94.1.166] ([185.109.18.135])
        by smtp.gmail.com with ESMTPSA id ck5-20020a5d5e85000000b00257795ffcc8sm12868345wrb.73.2022.12.20.05.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:43:58 -0800 (PST)
Message-ID: <936effe2-1268-42ab-886e-649b7c501828@arrikto.com>
Date:   Tue, 20 Dec 2022 15:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is
 unmounted
Content-Language: en-US
To:     trondmy@kernel.org, "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
References: <20210313210847.569041-1-trondmy@kernel.org>
From:   Nikos Tsironis <ntsironis@arrikto.com>
In-Reply-To: <20210313210847.569041-1-trondmy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/13/21 23:08, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> In order to ensure that knfsd threads don't linger once the nfsd
> pseudofs is unmounted (e.g. when the container is killed) we let
> nfsd_umount() shut down those threads and wait for them to exit.
> 
> This also should ensure that we don't need to do a kernel mount of
> the pseudofs, since the thread lifetime is now limited by the
> lifetime of the filesystem.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---

Hello,

This patch was merged in kernel v5.13, but the issue exists in older
kernels too.

Is there a reason that the patch was never backported to older stable
kernels?

Thanks,
Nikos.
