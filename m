Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37E332C52
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 17:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCIQkd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 11:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhCIQkC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 11:40:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B32C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  9 Mar 2021 08:40:01 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id dx17so29492118ejb.2
        for <linux-nfs@vger.kernel.org>; Tue, 09 Mar 2021 08:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69i+Kqm2tSQribVksdoEZn878zwrWbYDQHP9bZFzNds=;
        b=AhD/ey358MwoaB/ac9Jwun2keZfqgpxFjGmrRxi8lZR8RIxwCI7Fkx8xYAf8A7Zj19
         Lw9t++ISn8WaPuN+p04c97bHSTk/A1du4dqKwmuQawDLFy6J7Rgy0pTs9aLHF4SWiZaC
         DssOLXvA5zb1QVKmECsgNAvc0dnpTvATu1Z0SW3GtcF0XegQtvM2JAk9DrsThDhB+iUc
         2lqkK0fHO1vfQxyYHHkWfarulgyHy6iPeUCJnONdCYtprl04As1mNg9Elw/cFsek4nWv
         V1MSiDQtiXWupgyfnLcvRdRNfTECWAPNP1VK73XJI/LX9kjt7Njwq7TfPIfp9leNv225
         3elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69i+Kqm2tSQribVksdoEZn878zwrWbYDQHP9bZFzNds=;
        b=eCB5SBxFJVCKxfdTpC/rGoD3iy8iC/9kgBp/qyLsklQM7qAKQKJSVyEG3JAIkW12iQ
         W9cc8EerQrkq7Y7Uq8jWpYwtgEameX9tqHUwggMPacSwDWReuPeSnWOPi2LFf7CgsM72
         GzTvWHqQswXy+liyCnQox04roOGTczLdJKogY6tMICNlqZwbkHUHxYc1jBk3/9s/lNUd
         bUwXN4xNx9Jl6ZQJuGii2ZbKS054yDAL4llYslEklPydC4j+q8oLES3LVCBKs18nBwKh
         uRRw5YE0aBiuxUxq1RgWmX0SAIBd2Ppj0QTMDkFXrUDe4AZO3t/QBsVvzwAvMbN3Jn50
         yKSA==
X-Gm-Message-State: AOAM5319EeLRutENKlp9NOPc2pCSS6SiYk5DS1HDmk5PUsUbH+fGZ2we
        wETGfA+B4/RTMjwSm2t5cwrQWtdOXPFX4BPF4L8=
X-Google-Smtp-Source: ABdhPJwHKy9bjz5HgqzSHTbtRMoHhUVH5tdPgQ94rkFCOU6ednrM36dlj4c1e+EEOfzNeApV1sPE/MEb4/b+l0D4nlc=
X-Received: by 2002:a17:906:e2d4:: with SMTP id gr20mr21529681ejb.432.1615308000013;
 Tue, 09 Mar 2021 08:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com> <YEeWK+gs4c8O7k0u@pick.fieldses.org>
In-Reply-To: <YEeWK+gs4c8O7k0u@pick.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 9 Mar 2021 11:39:48 -0500
Message-ID: <CAN-5tyEFRiA2xcHBy63cgD+zAKDOR56A+Vo3te0zmdWVD72gDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 9, 2021 at 10:37 AM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > When the server tries to do a callback and a client fails it due to
> > authentication problems, we need the server to set callback down
> > flag in RENEW so that client can recover.
>
> I was looking at this.  It looks to me like this should really be just:
>
>         case 1:
>                 if (task->tk_status)
>                         nfsd4_mark_cb_down(clp, task->tk_status);
>
> If tk_status showed an error, and the ->done method doesn't return 0 to
> tell us it something worth retrying, then the callback failed
> permanently, so we should mark the callback path down, regardless of the
> exact error.

Ok. v2 coming (will change the title to make it 4.0 callback)

>
> --b.
>
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfsd/nfs4callback.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 052be5bf9ef5..7325592b456e 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
> >               switch (task->tk_status) {
> >               case -EIO:
> >               case -ETIMEDOUT:
> > +             case -EACCES:
> >                       nfsd4_mark_cb_down(clp, task->tk_status);
> >               }
> >               break;
> > --
> > 2.27.0
> >
>
