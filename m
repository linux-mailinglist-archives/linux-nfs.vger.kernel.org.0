Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45D333022
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 21:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCIUmY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 15:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhCIUl4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 15:41:56 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12201C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  9 Mar 2021 12:41:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mj10so31526920ejb.5
        for <linux-nfs@vger.kernel.org>; Tue, 09 Mar 2021 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUs5AXez+GqIfXKh0i9+Sqa+L4Zox1Pjn2F6dvA2LUg=;
        b=ulxUD87PnT6XI9/ACJ0S7s5vct64mbhh+bv7M4ellDA1yaWpEEduSvlPDpm8Se2lG1
         YHlprJQ1ZVhenOJgpSd0JIDJDxnjNcf+P4Mu7ibQjHDVtHAqrJDiiP59dzYtTMJeE+4G
         bvH+iZfysmdMABCN2cOVfhb/25seMB6+VYJ6WJ1FS5rsP9HflKvOMmB8ONBkegVyVXra
         dKg9d5bBz+0woNmIB0ag6oFBFslS840n0WcJ5AcdZylhz96WHxRzlT+KmLxPwdIEtGsP
         T8vroW2TsKPAwGvGXUDcFuzINPnoqijkAuqR3IBYzqTeljILCVBNqKgsS6hXge4DrY+4
         WFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUs5AXez+GqIfXKh0i9+Sqa+L4Zox1Pjn2F6dvA2LUg=;
        b=iUOvoHBft7xDzKYAUS3wo+P6XZCgnHAbYpgJdY2tFfTYjraG7jfX0Wc7/PkAjlPCZI
         luWObi65dvJQp7N37w+yfGf0WjVApTWx2rXuxiOX8mTX1K/Mwjlj7vtri69NZHr6Frhu
         0fn6VOSJj1uikeqR3Be7Xwr4Sgt7tgc/2OGVhs3ircHO65/SesLuSb0fNQPAggDMyO9F
         YkCnsT87GsVWCNV29MsXxF58ukJa9Zq2vc3F0CDvPSgJbkbUdS7WjajB5ZDU4jcTUqeM
         81naKBqKg8RiwQQ9w2Fp0ih7KHEvMH+ueipbRymxqPqPyVF2bhoOTfFJ7PXGhGG9AXmL
         2i2g==
X-Gm-Message-State: AOAM532bypa0f6fX0J4aNsWGxSIGFv4ZCHcol7ounPbCzSFhuWJRuLAl
        aBdrqL3fMpWYjvq4C82y4O28CsgmJMY14OhI/8TlaSMY
X-Google-Smtp-Source: ABdhPJzHhw5OZTx6ObuGqtUOHVHH6O6j7BUW1x6Qx90tvZKyEhx5m6wn2p5hmK9+bdEHxEJJhMbamqOp6yZYLUUnN8I=
X-Received: by 2002:a17:906:e2d4:: with SMTP id gr20mr22683317ejb.432.1615322514811;
 Tue, 09 Mar 2021 12:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
 <YEeWK+gs4c8O7k0u@pick.fieldses.org> <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
In-Reply-To: <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 9 Mar 2021 15:41:43 -0500
Message-ID: <CAN-5tyFttTHRdnELORJwCER_KPGBNk4W3eLwG0Z=QkwmPQh1UQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@redhat.com" <bfields@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 9, 2021 at 3:22 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2021-03-09 at 10:37 -0500, J. Bruce Fields wrote:
> > On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > When the server tries to do a callback and a client fails it due to
> > > authentication problems, we need the server to set callback down
> > > flag in RENEW so that client can recover.
> >
> > I was looking at this.  It looks to me like this should really be
> > just:
> >
> >         case 1:
> >                 if (task->tk_status)
> >                         nfsd4_mark_cb_down(clp, task->tk_status);
> >
> > If tk_status showed an error, and the ->done method doesn't return 0
> > to
> > tell us it something worth retrying, then the callback failed
> > permanently, so we should mark the callback path down, regardless of
> > the
> > exact error.
>
> I disagree. task->tk_status could be an unhandled NFSv4 error (see
> nfsd4_cb_recall_done()). The client might, for instance, be in the
> process of returning the delegation being recalled. Why should that
> result in the callback channel being marked as down?
>

Are you talking about say the connection going down and server should
just reconnect instead of recovering the callback channel. I assumed
that connection break is something that's not  recoverable by the
callback but perhaps I'm wrong.

> >
> > --b.
> >
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  fs/nfsd/nfs4callback.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index 052be5bf9ef5..7325592b456e 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task
> > > *task, void *calldata)
> > >                 switch (task->tk_status) {
> > >                 case -EIO:
> > >                 case -ETIMEDOUT:
> > > +               case -EACCES:
> > >                         nfsd4_mark_cb_down(clp, task->tk_status);
> > >                 }
> > >                 break;
> > > --
> > > 2.27.0
> > >
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
