Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46FD259D67
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Sep 2020 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgIARki (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Sep 2020 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgIARkd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Sep 2020 13:40:33 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50069C061244
        for <linux-nfs@vger.kernel.org>; Tue,  1 Sep 2020 10:40:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c10so2271015edk.6
        for <linux-nfs@vger.kernel.org>; Tue, 01 Sep 2020 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0SfT1YYyMWAU7BRqh0HQxr7Epb8PYffS7fgo0+UQJc=;
        b=knz0YS9nrNoS2ZqeHsdvaduW4T0qF3bTtDifb7Bdfe17AvnHwwLixdJ29DWtZoquOO
         vDic0Jgf1fezwND7M4iGv5sunAZauEX2jIUz+lT5+XEciaKnPYGSNsxBcHQ4xhztKuRp
         Gw+djVMrHovRuF9EE4nmK25SvbOQJ4K+4loOxryqIR5iqj/Ia+J7Ero/jAA7ZsacQdvH
         Yk23JT+rHHsi+Sj5P+40T6kF2sULQx3C9xFaYfyRY7yPx6iIAatqekPq83dgmpDl9bTi
         bg8t0RV5WiyxX+GJz4YqWfiUS3Y1O5zjJ8EJfXqPleNjcHCeOntgcontoOZSq0YwMyiY
         WSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0SfT1YYyMWAU7BRqh0HQxr7Epb8PYffS7fgo0+UQJc=;
        b=LhS8gx+JEFcxJFyvalHGVt1W3Ys6+0ObbZqOeaPeMFihNRjvKl8D+7bmh1PDh/zWb1
         xB2xZOflqabBP5zQei7UOIypF05pbh1BPUFutD6q3CAeX9bQtrikFIRB1jpLpZoqYPWQ
         z0n+X+ZgwvJWYtn4HtrEFe37kI7XON5Cymr6VfPT5hw3IqKFM1xZZ0Pmhfymogl2FJqB
         kwprro3NwdniInlRgWPvadTPlwjpFcDPE2YKxMujH+ogNhv8FeH/pEKOF8OYjte7dS3p
         LG3DIJ8s8SwHBGLLary6JjV1hfYsnecPN/N/0ICTkLyEqRIhufXKMG43jghl1ErfICaO
         6l1Q==
X-Gm-Message-State: AOAM5306YYdRKS1yWO5SaKcNvj+cjonlwICctt/AQ8aou/+a2FYLsZ/a
        llKV0Z7uj0DIOQBHEdmuwIs+qDm7dmq+UndFMss=
X-Google-Smtp-Source: ABdhPJxkXMAP242zP+Nnek9iGayTAvE+iPoyA4NFEQ+1vTKX6yWHeh73fhm2mKE0zg5dGnE1GUXP4DVUb/hbwwXyMU8=
X-Received: by 2002:aa7:cfda:: with SMTP id r26mr2806180edy.209.1598982031806;
 Tue, 01 Sep 2020 10:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
 <20200817165310.354092-3-Anna.Schumaker@Netapp.com> <20200828212521.GA33226@pick.fieldses.org>
 <20200828215627.GB33226@pick.fieldses.org> <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
 <20200901164938.GC12082@fieldses.org>
In-Reply-To: <20200901164938.GC12082@fieldses.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 1 Sep 2020 13:40:16 -0400
Message-ID: <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 1, 2020 at 12:49 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Aug 31, 2020 at 02:16:26PM -0400, Anna Schumaker wrote:
> > On Fri, Aug 28, 2020 at 5:56 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > >
> > > On Fri, Aug 28, 2020 at 05:25:21PM -0400, J. Bruce Fields wrote:
> > > > On Mon, Aug 17, 2020 at 12:53:07PM -0400, schumaker.anna@gmail.com wrote:
> > > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > >
> > > > > This patch adds READ_PLUS support for returning a single
> > > > > NFS4_CONTENT_DATA segment to the client. This is basically the same as
> > > > > the READ operation, only with the extra information about data segments.
> > > > >
> > > > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > > ---
> > > > >  fs/nfsd/nfs4proc.c | 17 ++++++++++
> > > > >  fs/nfsd/nfs4xdr.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++--
> > > > >  2 files changed, 98 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > index a09c35f0f6f0..9630d33211f2 100644
> > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > @@ -2523,6 +2523,16 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > > > >     return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
> > > > >  }
> > > > >
> > > > > +static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > > > > +{
> > > > > +   u32 maxcount = svc_max_payload(rqstp);
> > > > > +   u32 rlen = min(op->u.read.rd_length, maxcount);
> > > > > +   /* enough extra xdr space for encoding either a hole or data segment. */
> > > > > +   u32 segments = 1 + 2 + 2;
> > > > > +
> > > > > +   return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
> > > >
> > > > I'm not sure I understand this calculation.
> > > >
> > > > In the final code, there's no fixed limit on the number of segments
> > > > returned by a single READ_PLUS op, right?
> > >
> > > I think the worst-case overhead to represent a hole is around 50 bytes.
> > >
> > > So as long as we don't encode any holes less than that, then we can just
> > > use rlen as an upper bound.
> > >
> > > We really don't want to bother encoding small holes.  I doubt
> > > filesystems want to bother with them either.  Do they give us any
> > > guarantees as to the minimum size of a hole?
> >
> > The minimum size seems to be PAGE_SIZE from everything I've seen.
>
> OK, can we make that assumption explicit?  It'd simplify stuff like
> this.

I'm okay with that, but it's technically up to the underlying filesystem.

>
> --b.
