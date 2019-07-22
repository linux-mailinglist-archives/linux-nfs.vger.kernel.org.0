Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869D170A4A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2019 22:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfGVUDv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jul 2019 16:03:51 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34864 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbfGVUDt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jul 2019 16:03:49 -0400
Received: by mail-ua1-f65.google.com with SMTP id j21so15937456uap.2
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2019 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OphZp6tZGdy/5IC/XsUavEknYw16Cuaz8+wzjR9hwZ4=;
        b=Hr3GY4U2wDTB4sGQEmJlQTpYV9z05qzKiLE65xcW4WTc3CcNGPT4bsKVeoRs43kI8L
         lrRE86k3g64tzmYBXc9V2nEclw4C8njwrnalB1YJPv5uLCRrafqF1dczZN1Fg0VB9g+Y
         SXYsXveJNUyW2cyzcM/UpSLwr1NB/yXYikI3ipuS0yhR7jy25JeLwppwJ5zo2OAz65V1
         Ecvd1EKWVJBIQNMnTSRGEp0So8GZYm2brSeADtVvL1g/SpbsYl2gpf3bpN52TgftIOke
         ETIVYJl3YlANEcm6HB67+5UNWl+U3ZEIeYfWsV5KrCvsPHFA6OLVhIm84ykKNcqpHXpC
         xhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OphZp6tZGdy/5IC/XsUavEknYw16Cuaz8+wzjR9hwZ4=;
        b=LeWbbbNdLxD26gGoQI7cRpkVj8bCQefz4hL5eg+ViETGQuS9z3D6yPkMwMG2vvCTLX
         6naYkoPWXju6/NncqdbTE38Hb+ZAzq9Wx27a6FhBZOTxgGgyF5tdxq2qHomNWNPfa0GY
         rHgURCYtjdSoluoufbXpmFHcOJerkKxAQ7PQsM3AMdKlqMHxQSjNn70WFqAmD3TtjfBq
         jBtxm3C7Jn5//5H8m0QXD7OqiSrUYLlBmCzklXzoY6H4z5Ny/Xz9NqJY8hNah1+NXa5O
         DNmF5ICDFk8X7vhUi4hwwj+5QILehNm4sp1EyC8c7fkTpw0LDN7BzlSmD/GUwxSrOR9J
         RxCQ==
X-Gm-Message-State: APjAAAWXrhDl+KWiUNRgabxUkeYj+JZywpcXkJ2u06KKT6KBNagzzl+v
        w4jBQxK7T4b/FhXJEl8bqylxPAW/aNTB6ZAZQyQ=
X-Google-Smtp-Source: APXvYqxj826HoMq0dzLsIy3HiojRfZDeyKeXiX88CAhXPsoWKqUJ1QIj9hyRbx5QROB5io+3QBMWRe3ovvqCx2UR72g=
X-Received: by 2002:ab0:3159:: with SMTP id e25mr26359458uam.81.1563825829018;
 Mon, 22 Jul 2019 13:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-5-olga.kornievskaia@gmail.com> <20190717221507.GP24608@fieldses.org>
In-Reply-To: <20190717221507.GP24608@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 22 Jul 2019 16:03:38 -0400
Message-ID: <CAN-5tyHU2EkNsqzSVHcNZfnJ4cHKJaYk9F98O3Ur97uQMyOrbw@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] NFSD add COPY_NOTIFY operation
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 17, 2019 at 6:15 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jul 08, 2019 at 03:23:48PM -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Introducing the COPY_NOTIFY operation.
> >
> > Create a new unique stateid that will keep track of the copy
> > state and the upcoming READs that will use that stateid. Keep
> > it in the list associated with parent stateid.
> >
> > Return single netaddr to advertise to the copy.
> >
> > Signed-off-by: Andy Adamson <andros@netapp.com>
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfsd/nfs4proc.c  | 71 +++++++++++++++++++++++++++++++++++----
> >  fs/nfsd/nfs4state.c | 64 +++++++++++++++++++++++++++++++----
> >  fs/nfsd/nfs4xdr.c   | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/nfsd/state.h     | 18 ++++++++--
> >  fs/nfsd/xdr4.h      | 13 +++++++
> >  5 files changed, 247 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index cfd8767..c39fa72 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/falloc.h>
> >  #include <linux/slab.h>
> >  #include <linux/kthread.h>
> > +#include <linux/sunrpc/addr.h>
> >
> >  #include "idmap.h"
> >  #include "cache.h"
> > @@ -1033,7 +1034,8 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
> >  static __be32
> >  nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >                 stateid_t *src_stateid, struct file **src,
> > -               stateid_t *dst_stateid, struct file **dst)
> > +               stateid_t *dst_stateid, struct file **dst,
> > +               struct nfs4_stid **stid)
> >  {
> >       __be32 status;
> >
> > @@ -1050,7 +1052,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
> >
> >       status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
> >                                           dst_stateid, WR_STATE, dst, NULL,
> > -                                         NULL);
> > +                                         stid);
>
> Doesn't this belong with the previous patch?

I could. I think what Andy did was first changed the code to add
ability to add to the nfs4_stid and this patch actually uses it.
Sounds like you prefer this to be in the previous patch?

>
> --b.
