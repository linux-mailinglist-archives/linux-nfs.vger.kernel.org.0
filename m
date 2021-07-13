Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3641D3C7047
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jul 2021 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhGMMbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Jul 2021 08:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbhGMMbB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Jul 2021 08:31:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3193BC0613DD
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jul 2021 05:28:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id c17so41048828ejk.13
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jul 2021 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OacGeq25oX7gTagxZjVzlTDfmbhAnDqzHfJ1lJ0V89I=;
        b=UpovnbupOtT9ct8oeISdpcypp4s+IA4uxUI3fxAKt05GTbORoKZAGvKyOq+frcwUtQ
         oaf9V4S4XflW4anEyd38X7UL4V82ZwUnpaXhXmJyLATYKA87gdqnj52U3+ZtfC9NqKDc
         2UQ+915DpaMtt/NQ8VV/WP3J8PCcEtiFIviCzdz+Vhf5phuXzKb0GULKRE+OTvoVtBm2
         EX98AVHkFvRDdNynfZvUwOT294BHT6qxuDCNSYNSLv9PEJV/mxefmyxN0rmkc40njSLV
         Ngvl86W8M75uuOob/d8YUNHEz6DjyYxRnkQ7E7CTIVbCsFhhD74CEz3LVmmFTPDhPdBS
         YtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OacGeq25oX7gTagxZjVzlTDfmbhAnDqzHfJ1lJ0V89I=;
        b=ovYvNeYTUONLwFx//B2s2tSrFNstW2PRQ7zw7O6S9TNK1cGL5Pmx5sD3dO6i0zWyF2
         nkgXgf96iUOQ+rG6vue7kgSc4iWYWqVoRRA4ZUplyqxfybHwmilK/eODfvDFzn2fwMYH
         dmK0aooIKICj9a/sxThmzTOnkjf6bmUJb4WYd4xynHt1HOXsq/0iFfjfwDq1zcHmdKBZ
         WsEJfp1qJvrbXYG0i6ky/wlGZRJYiM8siYOx+5YpH7gTKYii1v46+LGXmIBGNv3kEF5w
         F7f2tUO9f9f+R0gm0xipSSBmEWcx7g3nmSxXYOtDl5KT+Fa/Fg4/l882gMzqt+GTEos2
         MHwQ==
X-Gm-Message-State: AOAM5324NrgksIB993fG8dshomQwj3yb9L2mAKxaZUwdekfX1DLzb0Dw
        DZw8SpUYX1sCVBIDUT47T3QGUFu74O5fpNPFNCiqQg==
X-Google-Smtp-Source: ABdhPJxBKXfH1csokWmzdzXpI+BTlIRoSOhkuB5eOu7CoYzaCOsbh8Mgfbegr8XV/OTFpHkclnjX//OPQ6d9C80Y8xo=
X-Received: by 2002:a17:906:c49:: with SMTP id t9mr5211421ejf.405.1626179289792;
 Tue, 13 Jul 2021 05:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>
 <162510089174.7211.449831430943803791@noble.neil.brown.name>
 <CAPt2mGMgCHwvmy2MA4c2E316xVYPiRy4pRdcX4-1EAALfcxz+A@mail.gmail.com>
 <162513954601.3001.5763461156445846045@noble.neil.brown.name>
 <CAPt2mGNCV7Sh0uXA0ihpuSVcecXW=5cMUAfiS0tYr_cTQ0Du8w@mail.gmail.com>
 <162535340922.16506.4184249866230493262@noble.neil.brown.name>
 <CAPt2mGNOMh0uWozi=L5H6X7aKUuh_+-QxJ7OK9e6ELiKnSh1hg@mail.gmail.com>
 <162562036711.12832.7541413783945987660@noble.neil.brown.name>
 <CAPt2mGM6mcqM9orzHuyTVgX2pnG5Y7nLeM85tdZ5LoDO9XozBA@mail.gmail.com>
 <162569314954.31036.11087071768390664533@noble.neil.brown.name>
 <CAPt2mGPSeK6YHPQ8r6Z0UJv4mJnRAcEEc4VmLaENo91-K8P=fQ@mail.gmail.com> <162569993532.31036.942509527308749032@noble.neil.brown.name>
In-Reply-To: <162569993532.31036.942509527308749032@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 13 Jul 2021 13:27:33 +0100
Message-ID: <CAPt2mGMToMVpMEhMQ-xHuuyePwSMsXXz6yaG49CfJYPfzU5+KQ@mail.gmail.com>
Subject: Re: [PATCH/rfc v2] NFS: introduce NFS namespaces.
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 8 Jul 2021 at 00:19, NeilBrown <neilb@suse.de> wrote:
> sorry - my bad..
>
> I think I've found it.  Rather than sending the whole patch, here is the
> incremental fix.  But not clearing this pointer, I risk the value in it
> being freed twice.  That might lead to what you saw.
>
> Thanks,
> NeilBrown
>
>
>
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 7c644a31d304..9e34af223ce6 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -1451,6 +1451,7 @@ static int nfs_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
>         ctx->nfs_server.export_path     = NULL;
>         ctx->nfs_server.hostname        = NULL;
>         ctx->fscache_uniq               = NULL;
> +       ctx->namespace                  = NULL;
>         ctx->clone_data.fattr           = NULL;
>         fc->fs_private = ctx;
>         return 0;
>

Yep, I think that has done the trick. I haven't crashed it with the
same workload yet....

I can do some more thorough testing now. Thanks!

Daire
