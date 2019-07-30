Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0357ACB5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfG3PtB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 11:49:01 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34929 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732477AbfG3PtB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Jul 2019 11:49:01 -0400
Received: by mail-ua1-f66.google.com with SMTP id j21so25650350uap.2
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2019 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziL44huRt2ONNIIFxN595caMb3duG5rpzusSJrByuc0=;
        b=sTjVD5pXRYf/6FHJrLHZ+8JBY9J3+STof8ZrTmvPljQJ5w9xKRkPxBjWgySPLb1BDK
         UAKCZAo7SWsse7f/8rGsumAKFn0tYlDhN28UN95UPFqARstwMPc9Kux8EQ+LBaZoRHgm
         cjXkF1ZZSGsfptgbmXfBz+xN0cO4xH3MBjFvc/aWhCSQwUAJCGbIXz38Fxs5tr6BQJwd
         8UNuhhlzbtXBWjpho9DB8EbGDZ3MmoNhTEsxitZqpkGvBbckJ/ysFW1NuUX/ELFK0Ffd
         HNd6T9WCuKFguP4+sscJ5kb9ymz1pvbbgFV79oXCrXCTdqLud2H69n3Xv/b6BRoorKOc
         +ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziL44huRt2ONNIIFxN595caMb3duG5rpzusSJrByuc0=;
        b=tq/6kKQRqkW10Rmecu9ccxmdykZDJtd9xd9GXZhTnt2ha7cb/LVPRk9fx7OuthF77+
         z8Z5PjYuRXFKhr00uwEUAwXhaB1gbBqG+8LjOSFGIMsKP9RciE4r6nJdVTY4IqbMxd5r
         IKbijlY5rKZU69MC7VsR3PItDvszJqkDhanroQ9ed5HeuD8685ezyAXbQS6kb+23nw3y
         RGxlJ2xFA184Fk2xrWw2DzQ15cc0IfTyFBq0dT4EJe8FWMeNG285tQYEnyli0qn4cW4q
         TGyt9JE6waOWTmg4nNMtVTXQJ2fOdDPzJVYNhNaB4aqLQSnptI7k653hnnD3zzifbruF
         8shA==
X-Gm-Message-State: APjAAAXqr78SLJzELPeWNOx3ZBoRfFaNu+eWAQ5M4sbHdn35h5ENYTE1
        S8k03BBmbNzGvW5/VFAJ+KTmQI1A2qqstNjZJ98=
X-Google-Smtp-Source: APXvYqyyuGCwncuodU7EpN0LgkHfd1xuHZN4yqR1eND6+BNX6lywFIhZYHsbH9GjgngKnGq70xuhbVXK6O8fYmQO6ZE=
X-Received: by 2002:ab0:760e:: with SMTP id o14mr53021742uap.93.1564501739978;
 Tue, 30 Jul 2019 08:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-8-olga.kornievskaia@gmail.com> <20190723213502.GA20438@fieldses.org>
In-Reply-To: <20190723213502.GA20438@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 30 Jul 2019 11:48:49 -0400
Message-ID: <CAN-5tyFkyNgta37zXxJCn8YNwje2f_=+jYfNpsaSSQ_UMKhLDQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] NFSD: allow inter server COPY to have a STALE
 source server fh
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 23, 2019 at 5:35 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jul 08, 2019 at 03:23:51PM -0400, Olga Kornievskaia wrote:
> > The inter server to server COPY source server filehandle
> > is a foreign filehandle as the COPY is sent to the destination
> > server.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfsd/Kconfig    | 10 ++++++++++
> >  fs/nfsd/nfs4proc.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++----
> >  fs/nfsd/nfsfh.h    |  5 ++++-
> >  fs/nfsd/xdr4.h     |  1 +
> >  4 files changed, 64 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > index d25f6bb..bef3a58 100644
> > --- a/fs/nfsd/Kconfig
> > +++ b/fs/nfsd/Kconfig
> > @@ -132,6 +132,16 @@ config NFSD_FLEXFILELAYOUT
> >
> >         If unsure, say N.
> >
> > +config NFSD_V4_2_INTER_SSC
> > +     bool "NFSv4.2 inter server to server COPY"
> > +     depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
> > +     help
> > +       This option enables support for NFSv4.2 inter server to
> > +       server copy where the destination server calls the NFSv4.2
> > +       client to read the data to copy from the source server.
> > +
> > +       If unsure, say N.
> > +
> >  config NFSD_V4_SECURITY_LABEL
> >       bool "Provide Security Label support for NFSv4 server"
> >       depends on NFSD_V4 && SECURITY
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 8c2273e..1039528 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -504,12 +504,20 @@ static __be32 nfsd4_open_omfg(struct svc_rqst *rqstp, struct nfsd4_compound_stat
> >           union nfsd4_op_u *u)
> >  {
> >       struct nfsd4_putfh *putfh = &u->putfh;
> > +     __be32 ret;
> >
> >       fh_put(&cstate->current_fh);
> >       cstate->current_fh.fh_handle.fh_size = putfh->pf_fhlen;
> >       memcpy(&cstate->current_fh.fh_handle.fh_base, putfh->pf_fhval,
> >              putfh->pf_fhlen);
> > -     return fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
> > +     ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
> > +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > +     if (ret == nfserr_stale && putfh->no_verify) {
> > +             SET_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN);
> > +             ret = 0;
> > +     }
> > +#endif
> > +     return ret;
> >  }
> >
> >  static __be32
> > @@ -1956,6 +1964,41 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
> >               - rqstp->rq_auth_slack;
> >  }
> >
> > +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > +static void
> > +check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
> > +{
> > +     struct nfsd4_op *op, *current_op, *saved_op;
> > +     struct nfsd4_copy *copy;
> > +     struct nfsd4_putfh *putfh;
> > +     int i;
> > +
> > +     /* traverse all operation and if it's a COPY compound, mark the
> > +      * source filehandle to skip verification
> > +      */
> > +     for (i = 0; i < args->opcnt; i++) {
> > +             op = &args->ops[i];
> > +             if (op->opnum == OP_PUTFH)
> > +                     current_op = op;
> > +             else if (op->opnum == OP_SAVEFH)
> > +                     saved_op = current_op;
> > +             else if (op->opnum == OP_RESTOREFH)
> > +                     current_op = saved_op;
> > +             else if (op->opnum == OP_COPY) {
> > +                     copy = (struct nfsd4_copy *)&op->u;
> > +                     putfh = (struct nfsd4_putfh *)&saved_op->u;
> > +                     if (!copy->cp_intra)
> > +                             putfh->no_verify = true;
>
> Won't this crash on a compound with a COPY but no preceding PUTFH and
> SAVEFH?  Or is that checked elsewhere?  I was expecting a check in that
> last clause like

Yes it will crash. I will check and return ERR_NOFILEHANDLE if no
filehandle was stored.


>
>         if (!saved_op)
>                 /* return some error */
>                 /* or just continue and let nfsd4_copy catch the error */
>
> --b.
>
> > +             }
> > +     }
> > +}
> > +#else
> > +static void
> > +check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
> > +{
> > +}
> > +#endif
> > +
> >  /*
> >   * COMPOUND call.
> >   */
> > @@ -2004,6 +2047,7 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
> >               resp->opcnt = 1;
> >               goto encode_op;
> >       }
> > +     check_if_stalefh_allowed(args);
> >
> >       trace_nfsd_compound(rqstp, args->opcnt);
> >       while (!status && resp->opcnt < args->opcnt) {
> > @@ -2019,13 +2063,14 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
> >                               op->status = nfsd4_open_omfg(rqstp, cstate, op);
> >                       goto encode_op;
> >               }
> > -
> > -             if (!current_fh->fh_dentry) {
> > +             if (!current_fh->fh_dentry &&
> > +                             !HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
> >                       if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
> >                               op->status = nfserr_nofilehandle;
> >                               goto encode_op;
> >                       }
> > -             } else if (current_fh->fh_export->ex_fslocs.migrated &&
> > +             } else if (current_fh->fh_export &&
> > +                        current_fh->fh_export->ex_fslocs.migrated &&
> >                         !(op->opdesc->op_flags & ALLOWED_ON_ABSENT_FS)) {
> >                       op->status = nfserr_moved;
> >                       goto encode_op;
> > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > index 755e256..b9c7568 100644
> > --- a/fs/nfsd/nfsfh.h
> > +++ b/fs/nfsd/nfsfh.h
> > @@ -35,7 +35,7 @@ static inline ino_t u32_to_ino_t(__u32 uino)
> >
> >       bool                    fh_locked;      /* inode locked by us */
> >       bool                    fh_want_write;  /* remount protection taken */
> > -
> > +     int                     fh_flags;       /* FH flags */
> >  #ifdef CONFIG_NFSD_V3
> >       bool                    fh_post_saved;  /* post-op attrs saved */
> >       bool                    fh_pre_saved;   /* pre-op attrs saved */
> > @@ -56,6 +56,9 @@ static inline ino_t u32_to_ino_t(__u32 uino)
> >  #endif /* CONFIG_NFSD_V3 */
> >
> >  } svc_fh;
> > +#define NFSD4_FH_FOREIGN (1<<0)
> > +#define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
> > +#define HAS_FH_FLAG(c, f) ((c)->fh_flags & (f))
> >
> >  enum nfsd_fsid {
> >       FSID_DEV = 0,
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index 9d7318c..fbd18d6 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -221,6 +221,7 @@ struct nfsd4_lookup {
> >  struct nfsd4_putfh {
> >       u32             pf_fhlen;           /* request */
> >       char            *pf_fhval;          /* request */
> > +     bool            no_verify;          /* represents foreigh fh */
> >  };
> >
> >  struct nfsd4_open {
> > --
> > 1.8.3.1
