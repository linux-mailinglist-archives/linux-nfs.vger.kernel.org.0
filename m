Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A60334B29
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Mar 2021 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhCJWJh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Mar 2021 17:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhCJWJd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Mar 2021 17:09:33 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31821C061574
        for <linux-nfs@vger.kernel.org>; Wed, 10 Mar 2021 14:09:33 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l12so121503edt.3
        for <linux-nfs@vger.kernel.org>; Wed, 10 Mar 2021 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nZ+CJUvQLSEhh/6LgtvvnqJnY34E7jnLFEOHyDCIVo=;
        b=NlQ9A/6DJyXWxwb0iXsvJm0c/6/CvLzFy5sTdbtjSvJ0RHdZRMZNqF52D+FTgJ80lr
         mew2L0xUX2RY6JrmYi07GX5RNOBfvoXYgjG252xyVy1Pe1REe89doUJmP+7jmwcXjA8n
         MN3HrQwmaLpbaxW4oqZm1ZKRhKP18geGMt+BvoguAmTnIH6AidT1yIVDIvy8oFeXldcS
         cT7TAoErbZ59vyhD/NBQ69lzPEyJXcm5SX8Und36/kb5eFOsQoOLksO0zp7nhr2cZGgC
         xTL3WxUuuJo0Ow122R6Rt0mT+JdI9siYHtgeWe2slXcIY3QAIuBQsxoERYCfxRdRynec
         PrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nZ+CJUvQLSEhh/6LgtvvnqJnY34E7jnLFEOHyDCIVo=;
        b=SPIxq+emrFz3+zOJ8zFDyHRR0nEAGjQY/K/YM6z8qZw2+9eNCuOAkP0GyCNakdUmsb
         JBLdCiaA+0IJYVvwHUFPvrs0H8H39WTbReZ3k+GGpJSAlexCLPea12HMA+BhhUO7VWQ/
         0aA4gg4DvZj+6JQzI6L08u3urv99jEBzKu66c6UjZs5D48OlPfJeeD90nuyftZohmfuf
         k0YiH8v2cO0D8StjAEsKGjyVMq9xlwwi6MQQRuH5nuKJpu+va3w07Uo/kTPmhOG5mH2C
         GiBlDrvT9yJMxyFncoWdyTXnDagddzioLg+k6oYxWrkkaoip4ZyBN6I4uL4V3lr04t5I
         kz1g==
X-Gm-Message-State: AOAM532sWl30gZYfWZa7FUqDUJaMtv//AV4oNM6uhsqPMVOaw4q21vX1
        zXBPtQVQ5rRVxQPmmOeYoM0u3sd9hwVHExH31dE=
X-Google-Smtp-Source: ABdhPJx6vgo9T+t7/iMxKuGxmMIzS4H9JqFPHIBg1hwto04QVjlID41nlK9kUd88HZGAxvZiiXx9ZV6teozbysz6vYs=
X-Received: by 2002:a05:6402:9:: with SMTP id d9mr5496504edu.67.1615414171923;
 Wed, 10 Mar 2021 14:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
 <YEeWK+gs4c8O7k0u@pick.fieldses.org> <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
 <CAN-5tyFttTHRdnELORJwCER_KPGBNk4W3eLwG0Z=QkwmPQh1UQ@mail.gmail.com>
 <d205a6a77273534666b3c33065934b9f66e7b103.camel@hammerspace.com> <YEjb9ZadFqa9Vu9O@pick.fieldses.org>
In-Reply-To: <YEjb9ZadFqa9Vu9O@pick.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 10 Mar 2021 17:09:20 -0500
Message-ID: <CAN-5tyFZ8fS6fjOJEu2NkRYUX6HrA5XNKPWyWN+UVtQT6Gp4kQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 10, 2021 at 9:47 AM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Tue, Mar 09, 2021 at 08:59:51PM +0000, Trond Myklebust wrote:
> > On Tue, 2021-03-09 at 15:41 -0500, Olga Kornievskaia wrote:
> > > On Tue, Mar 9, 2021 at 3:22 PM Trond Myklebust <
> > > trondmy@hammerspace.com> wrote:
> > > >
> > > > On Tue, 2021-03-09 at 10:37 -0500, J. Bruce Fields wrote:
> > > > > On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia
> > > > > wrote:
> > > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > > >
> > > > > > When the server tries to do a callback and a client fails it
> > > > > > due to
> > > > > > authentication problems, we need the server to set callback
> > > > > > down
> > > > > > flag in RENEW so that client can recover.
> > > > >
> > > > > I was looking at this.  It looks to me like this should really be
> > > > > just:
> > > > >
> > > > >         case 1:
> > > > >                 if (task->tk_status)
> > > > >                         nfsd4_mark_cb_down(clp, task->tk_status);
> > > > >
> > > > > If tk_status showed an error, and the ->done method doesn't
> > > > > return 0
> > > > > to
> > > > > tell us it something worth retrying, then the callback failed
> > > > > permanently, so we should mark the callback path down, regardless
> > > > > of
> > > > > the
> > > > > exact error.
> > > >
> > > > I disagree. task->tk_status could be an unhandled NFSv4 error (see
> > > > nfsd4_cb_recall_done()). The client might, for instance, be in the
> > > > process of returning the delegation being recalled. Why should that
> > > > result in the callback channel being marked as down?
> > > >
> > >
> > > Are you talking about say the connection going down and server should
> > > just reconnect instead of recovering the callback channel. I assumed
> > > that connection break is something that's not  recoverable by the
> > > callback but perhaps I'm wrong.
> >
> > No. I'm saying that nfsd4_cb_recall_done() will return a value of '1'
> > for both task->tk_status == -EBADHANDLE and -NFS4ERR_BAD_STATEID. I'm
> > not seeing why either of those errors should be handled by marking the
> > callback channel as being down.
> >
> > Looking further, it seems that the same function will also return '1'
> > without checking the value of task->tk_status if the delegation has
> > been revoked or returned. So that would mean that even NFS4ERR_DELAY
> > could trigger the call to nfsd4_mark_cb_down() with the above change.
>
> Yeah, OK, that's wrong, apologies.
>
> I'm just a little worried about the attempt to enumerate transport level
> errors in nfsd4_cb_done().  Are we sure that EIO, ETIMEDOUT, EACCESS is
> the right list?

Looking at call_transmit_status error handling, I don't think
connection errors are returned. Instead the code tries to fix the
connection by retrying unless the rpc_timeout is reached and then only
EIO,TIMEDOUT is returned.

Can then my original patch be considered without resubmission?

>
> --b.
>
> >
> > >
> > > > >
> > > > > --b.
> > > > >
> > > > > >
> > > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > ---
> > > > > >  fs/nfsd/nfs4callback.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > > > index 052be5bf9ef5..7325592b456e 100644
> > > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > > @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task
> > > > > > *task, void *calldata)
> > > > > >                 switch (task->tk_status) {
> > > > > >                 case -EIO:
> > > > > >                 case -ETIMEDOUT:
> > > > > > +               case -EACCES:
> > > > > >                         nfsd4_mark_cb_down(clp, task-
> > > > > > >tk_status);
> > > > > >                 }
> > > > > >                 break;
> > > > > > --
> > > > > > 2.27.0
> > > > > >
> > > > >
> > > >
> > > > --
> > > > Trond Myklebust
> > > > Linux NFS client maintainer, Hammerspace
> > > > trond.myklebust@hammerspace.com
> > > >
> > > >
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
>
