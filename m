Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31D214F2F8
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 20:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgAaT4k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 14:56:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39882 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAaT4k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 14:56:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so10073772wrt.6
        for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2020 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUj4ab2DfB29eIwo9xVRwyvp566jZIzjyPmVFO8N0sg=;
        b=nKpVch2s5SoUvwEFvY2dvlbJqu3IqkmNRnQhIxQU7V4t9qtR+quz695eLtMtcVwJ3o
         BtwPMsIO/YTGV2WCJyA/Kg13vN2wXVFwdw1uhhTaaiqO4kLGL+X5YYfu4FEcm78QOItK
         JVUbPxRpoCYYJ4+jU5mq7YVgeSjmhmyiCUXyGdFAn7o4HO2qGU3L680XmxUb/U7nCaQw
         1nzVy3XguDtNcNgvNEXIt3uq9iYFWMn3OxLqezo/SaqQMgGYOQMBj5/G2hXIY4aS+MqI
         wOuLfDrTfeWrcE3zcqkdzX+27+uz86R2/LlIsQZ2hETi0aaFcf75PzsRKUM2Y0dc2KTD
         t4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUj4ab2DfB29eIwo9xVRwyvp566jZIzjyPmVFO8N0sg=;
        b=Vl1vKHafeQ/tAvT4QmC6Yp2HrDDtaAg3U6pwXRQ6veYbXsO9UOyelgptgD6l7raHhi
         wBj9rh5MJ8YO4A2aBSZP8sSjxrMy7EYAeyNjeGlua+oBet6ALfJVjZT2QA7h4VuhEqVw
         cv77uPQlV+uwpRD16Ml8TyWxOtdxa8L5Ig27lzGXonJY2kMuG/NgLe5GfvDVG364HGRq
         zKxJetRc9KFzJm9iudBG+FU/w6vA+w3wahOzm4AUMfhXtgcbhIXhUnTxVHGxEpjhpUDk
         BqjdDXAPYAcMV3crtJZPkZcdKnKIa4Pw0mYTrR3+LSM4XPZ8SwJaB7lPPaa+8ozRQ3Xz
         Ce6w==
X-Gm-Message-State: APjAAAUVFOqALL0tRWA5U7h+8zbPUfx4F0RBDzCmkbtMzxtqLWPB9mt0
        czA9YRIxBJBpER+nP6TVNHw7P8O5PR68NjArIRYMFw==
X-Google-Smtp-Source: APXvYqxw8aF78EK/0Jw4ld/Dp+NY6sMBGGBgWyA//AZxwzZzdzQ4/9DrSE40qZh52PFiKnPCgZOp17Fx/ztT5S17ORs=
X-Received: by 2002:a5d:53c4:: with SMTP id a4mr41120wrw.403.1580500598947;
 Fri, 31 Jan 2020 11:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 31 Jan 2020 14:56:28 -0500
Message-ID: <CAN-5tyEy52P6yvQGoV1sTQoWPQu3pZn+3QcYrF5jray4JaOnOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond, Anna,

If it's not too late then I'd like to re-tract this patch. I
understand if somebody else would really like to have this
functionality in then please speak up. If it's too late to pull I also
understand but I need to at least try.

Thank you.

On Thu, Jan 16, 2020 at 2:09 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 460d625..4df3fb0 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -881,7 +881,7 @@ static int nfs4_set_client(struct nfs_server *server,
>
>         if (minorversion == 0)
>                 __set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
> -       else if (proto == XPRT_TRANSPORT_TCP)
> +       if (proto == XPRT_TRANSPORT_TCP)
>                 cl_init.nconnect = nconnect;
>
>         if (server->flags & NFS_MOUNT_NORESVPORT)
> --
> 1.8.3.1
>
