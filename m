Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB2B4B8C74
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 16:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiBPPbU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Feb 2022 10:31:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiBPPbU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Feb 2022 10:31:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD52025FE76;
        Wed, 16 Feb 2022 07:31:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EF4CB81F21;
        Wed, 16 Feb 2022 15:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43651C340EC;
        Wed, 16 Feb 2022 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645025465;
        bh=+mxHrEYwkMd2fk54e3DcdNfYs6uxnmbr/MlR0kHgo3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QBAxkdeqzN+Mt0h2RAGjvupG/fpQXDyq5/WPFnEbX7KMQryTlA04mocuQ522Tppv7
         J84BHaYteO4GdWMfjsNzedmoyn19PXfHR+e7twtgRakCnbhYF+Bl6H/QQwx1UM44d0
         wjgYKrvfgRCdEQB1rF3TlfS+jRvjxizAxRp15FWj8mLEHcAyn6lIuNb38EeHwf9bDz
         X7E9h32UpgejD/CutA9VXecS8kJu/bjjfhEyX5lTYsjfrFtlTUPGXoTsmf+/X7Wnug
         ClhqnzuLsqx+ufu9ANfvdiu67PiV3RUPzc/fI8wtrCYaTDdPL3j+d4aT/JJQOZog4a
         f0gCqKI6++J/A==
Received: by mail-wm1-f50.google.com with SMTP id n8so1437711wms.3;
        Wed, 16 Feb 2022 07:31:05 -0800 (PST)
X-Gm-Message-State: AOAM531GWX3rq0ROS3WzsN9899FcxD+bMXfBHmT1RovExgHDPWN2ldjL
        +jr1riY9alxTFvcqTCQFKRoFK9qvWAOpBMUUAtQ=
X-Google-Smtp-Source: ABdhPJx0WJnNgu54qhwmXqWrHQpM9dfAjLI6++WcxDEGvC95eM6ZCxo+EDdEq+2QyyDFVTgG3HCTGA6W8yZg/rN3uB4=
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id
 c4-20020a7bc844000000b0037bb9867726mr2146608wml.160.1645025463924; Wed, 16
 Feb 2022 07:31:03 -0800 (PST)
MIME-Version: 1.0
References: <1644920224-24966-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1644920224-24966-1-git-send-email-khoroshilov@ispras.ru>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 16 Feb 2022 10:30:47 -0500
X-Gmail-Original-Message-ID: <CAFX2JfkGsjw0PU4LjfFGndQ=Em3o=qobgpQe94bsKHcYuOH_mQ@mail.gmail.com>
Message-ID: <CAFX2JfkGsjw0PU4LjfFGndQ=Em3o=qobgpQe94bsKHcYuOH_mQ@mail.gmail.com>
Subject: Re: [PATCH] NFS: remove unneeded check in decode_devicenotify_args()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Alexey,

On Tue, Feb 15, 2022 at 5:17 AM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
>
> Overflow check in not needed anymore after we switch to kmalloc_array().

Don't we still need the overflow check since 'n' is used in the
for-loop end condition farther down in this function?

Thanks,
Anna

>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: a4f743a6bb20 ("NFSv4.1: Convert open-coded array allocation calls to kmalloc_array()")
> ---
>  fs/nfs/callback_xdr.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
> index f90de8043b0f..8dcb08e1a885 100644
> --- a/fs/nfs/callback_xdr.c
> +++ b/fs/nfs/callback_xdr.c
> @@ -271,10 +271,6 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
>         n = ntohl(*p++);
>         if (n == 0)
>                 goto out;
> -       if (n > ULONG_MAX / sizeof(*args->devs)) {
> -               status = htonl(NFS4ERR_BADXDR);
> -               goto out;
> -       }
>
>         args->devs = kmalloc_array(n, sizeof(*args->devs), GFP_KERNEL);
>         if (!args->devs) {
> --
> 2.7.4
>
