Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56184855F0
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 16:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiAEPgX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 10:36:23 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:42936 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbiAEPgW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jan 2022 10:36:22 -0500
Received: by mail-yb1-f175.google.com with SMTP id m19so101609192ybf.9;
        Wed, 05 Jan 2022 07:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBMNSgExD0Tj/azeAle5jU9X1q6jJgFdJEmqq1NLnrI=;
        b=cUJqW7BG+k3RyB5PZX4J0IWnM3p03Fmfu5zV3hH/VV66Rv3K4OVjQKJ6ScjRHX3hqP
         UL6LFUbMcGjW7VBX1byeflQ4iuliGXEdFN1jaRThZvCCR/Q5s0E3B7hHvkgqfT2qsZVv
         bb/CNr59tgWsofvuul9Oo9u2pD9EQpOi7kM/42nEz+uE0FoL7LcY4QDluxLpzO+wpVUk
         EiSUOehHjW0MYwGNgeafwOFTWhN15WDNX0nuL9v+OHqijeSCLi3PFbSOshV7VV1fcS5C
         853ug5/pAXsNg7nN/Z0q4PZENPoyg1AoYcQp0XrzTTi1kJjQqi8oN0thUEwprKdVsdXZ
         CL2w==
X-Gm-Message-State: AOAM531O2g65bZDYCYn9dRq0dg6/Ok6UPyrbQlTwmgFsb/qXV+Q0ObSB
        Yam+huxA8xvuSTUMbjJ6/R3NXSmOdkq6ss5FjMU=
X-Google-Smtp-Source: ABdhPJxGf4OaoMBrYLsJqTLS30iSdml+T4x9C3fleAwlc1jgt4xSCjbaYI+Txsz65y3G81aSx2FenzJ7Y69VIbmo9WU=
X-Received: by 2002:a25:6884:: with SMTP id d126mr43732815ybc.355.1641396981809;
 Wed, 05 Jan 2022 07:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20211230063444.586292-1-luo.penghao@zte.com.cn>
In-Reply-To: <20211230063444.586292-1-luo.penghao@zte.com.cn>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Wed, 5 Jan 2022 10:36:05 -0500
Message-ID: <CAFX2Jfk3B_sWRsLKu4GZb5NyWVFGUX-s5fX2SSyfFyeQ6MS4VA@mail.gmail.com>
Subject: Re: [PATCH linux] nfs: Remove unnecessary ret assignment
To:     cgel.zte@gmail.com
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Luo,

On Fri, Dec 31, 2021 at 5:05 AM <cgel.zte@gmail.com> wrote:
>
> From: luo penghao <luo.penghao@zte.com.cn>
>
> Subsequent if judgments will assign new values to ret, so the
> statement here should be deleted
>
> The clang_analyzer complains as follows:
>
> fs/nfs/callback.c:
>
> Value stored to 'ret' is never read

The "else if (xprt->ops->bc_setup)" branch doesn't touch 'ret', so it
seems to me like the clang_analyzer is falsely reporting this.

Thanks,
Anna
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>  fs/nfs/callback.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 86d856d..1c1c82a 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -209,7 +209,6 @@ static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
>                 goto err_bind;
>         }
>
> -       ret = 0;
>         if (!IS_ENABLED(CONFIG_NFS_V4_1) || minorversion == 0)
>                 ret = nfs4_callback_up_net(serv, net);
>         else if (xprt->ops->bc_setup)
> --
> 2.15.2
>
>
