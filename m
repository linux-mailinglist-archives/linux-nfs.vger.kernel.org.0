Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE88696997
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfHTTkr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 15:40:47 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:40282 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfHTTkq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Aug 2019 15:40:46 -0400
X-Greylist: delayed 2779 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 15:40:46 EDT
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x7KIsOnE056106
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Aug 2019 14:54:25 -0400
Received: by mail-lf1-f53.google.com with SMTP id j17so4937319lfp.3;
        Tue, 20 Aug 2019 11:54:25 -0700 (PDT)
X-Gm-Message-State: APjAAAXDVqMnMY/VUh71YC9MAaUg3v+AsPdC8apTM/AoGtHxZacks+UQ
        1r0+44WcqBPQCCQn8aUMpKWfS/QpBCPpuE1T1OY=
X-Google-Smtp-Source: APXvYqyXYab+vfd5fRIYnwb+fZMMDdkpt6E9BbmrMBpQqeq78/BR/mO8CFP3tFaozOVeHNsowMDj447564dbUEq/jUY=
X-Received: by 2002:a19:4c88:: with SMTP id z130mr16540511lfa.149.1566327263894;
 Tue, 20 Aug 2019 11:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <1566287651-11386-1-git-send-email-wenwen@cs.uga.edu> <bf426508041337ff4059ca2cf02022a151134e5a.camel@netapp.com>
In-Reply-To: <bf426508041337ff4059ca2cf02022a151134e5a.camel@netapp.com>
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Tue, 20 Aug 2019 14:53:47 -0400
X-Gmail-Original-Message-ID: <CAAa=b7c=1ZtsFVhmxHrX7_AVG6=8OPOZ98R=vket0nCJZDqQNg@mail.gmail.com>
Message-ID: <CAAa=b7c=1ZtsFVhmxHrX7_AVG6=8OPOZ98R=vket0nCJZDqQNg@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: Fix a memory leak bug
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Wenwen Wang <wenwen@cs.uga.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 20, 2019 at 9:41 AM Schumaker, Anna
<Anna.Schumaker@netapp.com> wrote:
>
> Hi Wenwen,
>
> On Tue, 2019-08-20 at 02:54 -0500, Wenwen Wang wrote:
> > In nfs4_try_migration(), if nfs4_begin_drain_session() fails, the
> > previously allocated 'page' and 'locations' are not deallocated,
> > leading to
> > memory leaks. To fix this issue, free 'page' and 'locations' before
> > returning the error.
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  fs/nfs/nfs4state.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> > index cad4e06..37823dc 100644
> > --- a/fs/nfs/nfs4state.c
> > +++ b/fs/nfs/nfs4state.c
> > @@ -2095,8 +2095,12 @@ static int nfs4_try_migration(struct
> > nfs_server *server, const struct cred *cred
> >         }
> >
> >         status = nfs4_begin_drain_session(clp);
> > -       if (status != 0)
> > +       if (status != 0) {
> > +               if (page != NULL)
> > +                       __free_page(page);
> > +               kfree(locations);
> >                 return status;
>
> Thanks for the suggestion! I think a better option would be to switch
> the "return status" into a "goto out" so we can keep all our cleanup
> code in a single place in case we ever need to change it in the future.
>
> What do you think?

Thanks for your comments! I will rework the patch.

Wenwen

> Anna
>
> > +       }
> >
> >         status = nfs4_replace_transport(server, locations);
> >         if (status != 0) {
> > --
> > 2.7.4
> >
