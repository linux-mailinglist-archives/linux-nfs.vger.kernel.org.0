Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614CD14A679
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 15:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgA0OqV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 09:46:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37198 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgA0OqV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 09:46:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so7527796qtk.4;
        Mon, 27 Jan 2020 06:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhZyIGrUSX7QKfH5GDBDLfT80oi3L/4yF0ZDw6xMZ0Q=;
        b=d6vyxMZzqfiDJotxiVNIXcfULrPKcEJIs/NrbUFBCBhhP0F8JjtteJtaBkW8Odv+ud
         70vE6zDuvtpPUlrHlFiA4NVAaM3/pZ5d5GUaWmYA5TikIOnqA/a++CJUS+t9nQdtN7gw
         rFAWO/M5OSnAQcCBG++Usy1rEnizXSSqF2l076osk64XX6o1/jfwc+kQ/swgobTHYvTc
         9ALNPiOSv2jwO7FTfWAS/DOV7C4MMzY8bZG4ZBqkVbotAIKGpALQwAJW6BVAR3574rNG
         b5XtnTjNJNcHwvh5V8Xer0M7S0hPHKFqH1a6R5leb7gPYam70yZw/Gtsrt8kzGfbaiR8
         XuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhZyIGrUSX7QKfH5GDBDLfT80oi3L/4yF0ZDw6xMZ0Q=;
        b=XKot6OTdTNIzqGlIXfM6903TWHvVtrW9MAGdbOUQeYeH/pYtGavIW+pfP3iMfoe9DQ
         KCe4ZpQry0YpH0tWFwHlejejtomDmltttA8rzCebaV9BhaJ+pORnM1Xkk0QB3BQCJbbw
         KktX/BePwYEZ8x8ditpxfFfSWfvcO/VTmlSmQecRT6rVbYQfLd1dp+Pn+ITNFBJJ1N4O
         aVn7Z36h7trhGehR/zRHTDFYJuaV9Y0aITwplLb4JnF+mKJ68/SSGH4at3sd/yi9AHn2
         pHh4s+mw5r1VjN6hGM/FXNe8xouOyRu4KkGEfIOPQfMhMErW68tqjqG9XuTRn2H28bIp
         6eow==
X-Gm-Message-State: APjAAAXbslt9gzQT9bpKVU+hUIDLiLN1Mo4pgM7GC4678HnX9M3Kgb+h
        ILJOYC/lZCi1ysoYayu9iKZRD1YNxwQ6VekRH8thPA==
X-Google-Smtp-Source: APXvYqxIuhgjAeirhsVgTOlv0T5lhSn9/++Ec5ioT2YBoxbQ7IlwJrxFy/7/keNdX6Z0829en5gKOjzQs+2OweA2N+4=
X-Received: by 2002:ac8:7695:: with SMTP id g21mr7401759qtr.99.1580136379638;
 Mon, 27 Jan 2020 06:46:19 -0800 (PST)
MIME-Version: 1.0
References: <115c01d5c66d$5dcd7ae0$196870a0$@gmail.com> <041101d5cd50$e398d720$aaca8560$@gmail.com>
 <962370db9ae3ba5a17ba390afe7f9de6cea571d4.camel@hammerspace.com>
 <06bd01d5d12f$0e2288b0$2a679a10$@gmail.com> <76d4ebdbb76c8ac95e79e9db81e86625144d929a.camel@hammerspace.com>
In-Reply-To: <76d4ebdbb76c8ac95e79e9db81e86625144d929a.camel@hammerspace.com>
From:   Robert Milkowski <rmilkowski@gmail.com>
Date:   Mon, 27 Jan 2020 14:46:08 +0000
Message-ID: <CALbTx=E=pOO1wvzigRqWDZNCyksVYrhS2R6u-8OjaV9CVKHVUA@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 23 Jan 2020 at 19:33, Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2020-01-22 at 14:20 +0000, Robert Milkowski wrote:
> > > -----Original Message-----
> > > From: Trond Myklebust <trondmy@hammerspace.com>
> > > Sent: 17 January 2020 17:24
> > > To: linux-nfs@vger.kernel.org; rmilkowski@gmail.com
> > > Cc: anna.schumaker@netapp.com; linux-kernel@vger.kernel.org;
> > > chuck.lever@oracle.com
> > > Subject: Re: [PATCH v2] NFSv4: try lease recovery on
> > > NFS4ERR_EXPIRED
> > >
> > > On Fri, 2020-01-17 at 16:12 +0000, Robert Milkowski wrote:
> > > > Anyone please?
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: Robert Milkowski <rmilkowski@gmail.com>
> > > > Sent: 08 January 2020 21:48
> > > > To: linux-nfs@vger.kernel.org
> > > > Cc: 'Trond Myklebust' <trondmy@hammerspace.com>; 'Chuck Lever'
> > > > <chuck.lever@oracle.com>; 'Anna Schumaker' <
> > > > anna.schumaker@netapp.com
> > > > > ;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
> > > >
> > > > From: Robert Milkowski <rmilkowski@gmail.com>
> > > >
> > > > Currently, if an nfs server returns NFS4ERR_EXPIRED to open(),
> > > > etc.
> > > > we return EIO to applications without even trying to recover.
> > > >
> > > > Fixes: 272289a3df72 ("NFSv4: nfs4_do_handle_exception() handle
> > > > revoke/expiry of a single stateid")
> > > > Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> > > > ---
> > > >  fs/nfs/nfs4proc.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c index
> > > > 76d3716..2478405
> > > > 100644
> > > > --- a/fs/nfs/nfs4proc.c
> > > > +++ b/fs/nfs/nfs4proc.c
> > > > @@ -481,6 +481,10 @@ static int nfs4_do_handle_exception(struct
> > > > nfs_server *server,
> > > >                                           stateid);
> > > >                           goto wait_on_recovery;
> > > >                   }
> > > > +                 if (state == NULL) {
> > > > +                         nfs4_schedule_lease_recovery(clp);
> > > > +                         goto wait_on_recovery;
> > > > +                 }
> > > >                   /* Fall through */
> > > >           case -NFS4ERR_OPENMODE:
> > > >                   if (inode) {
> > > > --
> > > > 1.8.3.1
> > > >
> > > >
> > >
> > > Does this apply to any case other than NFS4ERR_EXPIRED in the
> > > specific
> > > case of nfs4_do_open()? I can't see that it does. It looks to me as
> > > if
> > > the open recovery routines already have their own handling of this
> > > case.
> >
> > I only observed the issue with open(). After further
> > review I think you are right and it only applies to nfs4_do_open().
> >
> >
> > > If so, why not just add it as a special case in the nfs4_do_open()
> > > error
> > > handling? Otherwise this patch will end up overriding other generic
> > > cases where we have an inode, but no open state.
> > >
> >
> > Fair point.
> > So perhaps, few lines further instead of:
> >
> >                       if (inode) {
> > ...
> >                       if (state == NULL) {
> >                                       break;
> >                       }
> >
> > There should be:
> >
> >                       if (inode) {
> > ...
> >                       if (state == NULL) {
> >                               nfs4_schedule_lease_recovery(clp);
> >                               goto wait_on_recovery;
> >                       }
> >
> >
> >
> > This way we know that inode cannot be null at this point, and it's a
> > case where both inode and state are NULL.
> > This would be a little bit more general in case we reach this point.
> >
> > But if you think it is better to move it to nfs4_do_open() then I've
> > just tested the following patch:
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 76d3716..b7c4044 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3187,6 +3187,11 @@ static struct nfs4_state *nfs4_do_open(struct
> > inode *dir,
> >                         exception.retry = 1;
> >                         continue;
> >                 }
> > +               if (status == -NFS4ERR_EXPIRED) {
> > +                       nfs4_schedule_lease_recovery(server-
> > >nfs_client);
> > +                       exception.retry = 1;
> > +                       continue;
> > +               }
> >                 if (status == -EAGAIN) {
> >                         /* We must have found a delegation */
> >                         exception.retry = 1;
> >
>
> This looks like what I'm asking for, yes. That seems like the minimal
> patch that addresses the problem you're describing.
>

Ok, will submit later today or tomorrow.
Thanks.

-- 
Robert Milkowski
