Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02EAC14D
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 22:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394442AbfIFURR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 16:17:17 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39841 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394415AbfIFURQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 16:17:16 -0400
Received: by mail-ua1-f67.google.com with SMTP id s15so2461883uaq.6
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 13:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/JymfspIiylA2FNWAdAkYK/nD4TgUcKe+QaWMOxnfA=;
        b=CYW1q4AdpJz0v9mF44/n1yPL9+wfvHWCyQpghmtck+asE4CAXStqCc1iIGi0YJ1Zmi
         6A3mdqhYv23yGssjwDd3E81VZe/q2zJMIB4ybby9Upuiwqyg3DYc96f6x1ixDIinCJta
         5Ij+wqVuJSJbDk96hc0lqIWOPtz6e/94efJ+f/VqVg7FAgMQ+tZT2ogFG5Gko+Jkis50
         G7cNBrwOCV8YxedsCVVDlpnPtBSrkgpmlZkPeoIwdkgWf77846Et7/VhLkFDQl80Khmv
         7nn6P7gYbJRvQeAfPO3x5UivhrPdwfSo7LlF1DJXqP8LC2S3+VwGXUmLpp3Plw6CVc7+
         qzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/JymfspIiylA2FNWAdAkYK/nD4TgUcKe+QaWMOxnfA=;
        b=NKnO8bkiB3xBqRxgpfBEkFw1KTd0XyweRcJXVtDSkBJdVtANAjsdXfa8w98c7CsQBE
         aBxT02nSgkRKiPQsKI/gbLCWUqR/pk5lQTEfJj7giX0SINFA7lcYe//eXeCKKgOqC8ct
         d1okvpmkyJ5xI3qrT3II/c50rfuzBno2h8LEr2wHOB9Y4OLkrthnB6aRLQlXmD8jl+y/
         935Hl4sQ++T5NiJXYTr5yC8rTqHMKLYq58FerEXtqPS6KJSaV8HgON1h8RxdypNOsB9z
         lTUi8peUE9tB+HBP49qJfFfbJhpjgKMqxllu8mfxwXfc8GA31NcGb/R/DfKg371/ePlZ
         iW1A==
X-Gm-Message-State: APjAAAWG9eIvfRTzMx7yOr3d/uVXra4i2XmFeOpAbs6jygF2+VG/1uRY
        McZho7tw1VsnItOz36BvuYmPfHNa0fGM2v8BMipURCs9
X-Google-Smtp-Source: APXvYqxd/+9oabEejHaQuFgD39xliVZLgH+tmlOACEqaaGA8HMZT+ZEue0OhfcpVBUlIhyP3bd+ZIVFhNjRjHvWdcd8=
X-Received: by 2002:ab0:1c0b:: with SMTP id a11mr5417062uaj.65.1567801035300;
 Fri, 06 Sep 2019 13:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180530180553.38769-1-trond.myklebust@hammerspace.com>
 <20180530180553.38769-2-trond.myklebust@hammerspace.com> <20180530180553.38769-3-trond.myklebust@hammerspace.com>
 <20180530180553.38769-4-trond.myklebust@hammerspace.com> <20180530180553.38769-5-trond.myklebust@hammerspace.com>
 <CAN-5tyGKCoRKLW2_KVP8_eMx0mqC7U2yEYNr=jj5_ybM+vaL6Q@mail.gmail.com> <3a4eafca05bfa82c7993990681f5184c0c3d09d3.camel@hammerspace.com>
In-Reply-To: <3a4eafca05bfa82c7993990681f5184c0c3d09d3.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 6 Sep 2019 16:17:03 -0400
Message-ID: <CAN-5tyE0G-0uHOtvxY7d7VROFZFdNwduUydHcu-cwaQYFD5eiw@mail.gmail.com>
Subject: Re: [PATCH 04/19] pnfs: Add layout driver flag PNFS_LAYOUTGET_ON_OPEN
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 31, 2018 at 8:41 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2018-05-30 at 16:10 -0400, Olga Kornievskaia wrote:
> > Hi Trond,
> >
> > This feature is enabled for Flexfiles layout type. Is there a reason
> > that it shouldn't be generic for all pnfs?
>
> Yes and no. It relies on use of the "current stateid" feature, which
> has not previously seen heavy use, and the ability of the pNFS server
> to handle layoutget races correctly (when the client sends 2 layoutget
> requests in parallel, both using the open stateid). If the server is
> invalidating one of the resulting layout stateids as it should, then it
> had better either have a good fencing mechanism, or it must recall that
> layout stateid before handing out the second layout.
>
> For that reason, I'd like to ensure that we at least test the existing
> pNFS implementations to ensure we don't see regressions before we
> enable the feature.

Hi Trond,

I'm getting back to trying to add LAYOUTGET to the OPEN compound for
the file layout type. I'm looking at your reply and trying to figure
out what kind of testing I should try to do. You mention a race where
a client sends 2 layoutget requests in parallel. You say "using the
open stateid", but when the LAYOUTGET is added to the OPEN, it'll be
using as you said current stateid. So is the problem sending 2
concurrent OPENs for the same file (same owner)? Then server should
issue the reply to the 1st, then a layout recall and reply to the 2nd?

But for the testing is your suggestion to instrument sending 2
concurrent opens with the new code and see that happens?

Thank you.

> > On Wed, May 30, 2018 at 2:05 PM, Trond Myklebust <trondmy@gmail.com>
> > wrote:
> > > From: Fred Isaman <fred.isaman@gmail.com>
> > >
> > > Driver can set flag to allow LAYOUTGET to be sent with OPEN.
> > >
> > > Signed-off-by: Fred Isaman <fred.isaman@gmail.com>
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > >  fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
> > >  fs/nfs/pnfs.h                          | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> > > b/fs/nfs/flexfilelayout/flexfilelayout.c
> > > index c75ad982bcfc..3ae038d9c292 100644
> > > --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> > > +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> > > @@ -2347,6 +2347,7 @@ static struct pnfs_layoutdriver_type
> > > flexfilelayout_type = {
> > >         .id                     = LAYOUT_FLEX_FILES,
> > >         .name                   = "LAYOUT_FLEX_FILES",
> > >         .owner                  = THIS_MODULE,
> > > +       .flags                  = PNFS_LAYOUTGET_ON_OPEN,
> > >         .set_layoutdriver       = ff_layout_set_layoutdriver,
> > >         .alloc_layout_hdr       = ff_layout_alloc_layout_hdr,
> > >         .free_layout_hdr        = ff_layout_free_layout_hdr,
> > > diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
> > > index daf6cbf5c15f..f71a55f11b97 100644
> > > --- a/fs/nfs/pnfs.h
> > > +++ b/fs/nfs/pnfs.h
> > > @@ -110,6 +110,7 @@ enum layoutdriver_policy_flags {
> > >         PNFS_LAYOUTRET_ON_SETATTR       = 1 << 0,
> > >         PNFS_LAYOUTRET_ON_ERROR         = 1 << 1,
> > >         PNFS_READ_WHOLE_PAGE            = 1 << 2,
> > > +       PNFS_LAYOUTGET_ON_OPEN          = 1 << 3,
> > >  };
> > >
> > >  struct nfs4_deviceid_node;
> > > --
> > > 2.17.0
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-
> > > nfs" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-nfs"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
