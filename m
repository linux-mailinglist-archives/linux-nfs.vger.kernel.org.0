Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70CACEBA3
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2019 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfJGSUZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Oct 2019 14:20:25 -0400
Received: from fieldses.org ([173.255.197.46]:46146 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfJGSUZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 7 Oct 2019 14:20:25 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A8C07EC; Mon,  7 Oct 2019 14:20:24 -0400 (EDT)
Date:   Mon, 7 Oct 2019 14:20:24 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 18/19] NFSD: allow inter server COPY to have a STALE
 source server fh
Message-ID: <20191007182024.GB22450@fieldses.org>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <20190916211353.18802-19-olga.kornievskaia@gmail.com>
 <20191002195511.GA21809@fieldses.org>
 <CAN-5tyEb=YG-5j7bNFSqefaC32vaTh3NQ0QgKPwgVuPg-quVQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyEb=YG-5j7bNFSqefaC32vaTh3NQ0QgKPwgVuPg-quVQQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 07, 2019 at 10:31:04AM -0400, Olga Kornievskaia wrote:
> On Wed, Oct 2, 2019 at 3:55 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Sep 16, 2019 at 05:13:52PM -0400, Olga Kornievskaia wrote:
> > > @@ -1956,6 +1964,45 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
> > >               - rqstp->rq_auth_slack;
> > >  }
> > >
> > > +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > > +static __be32
> > > +check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
> > > +{
> > > +     struct nfsd4_op *op, *current_op, *saved_op;
> >
> > current_op and saved_op need to be initialized to NULL here.
> >
> > > +     struct nfsd4_copy *copy;
> > > +     struct nfsd4_putfh *putfh;
> > > +     int i;
> > > +
> > > +     /* traverse all operation and if it's a COPY compound, mark the
> > > +      * source filehandle to skip verification
> > > +      */
> > > +     for (i = 0; i < args->opcnt; i++) {
> > > +             op = &args->ops[i];
> > > +             if (op->opnum == OP_PUTFH)
> > > +                     current_op = op;
> > > +             else if (op->opnum == OP_SAVEFH)
> > > +                     saved_op = current_op;
> > > +             else if (op->opnum == OP_RESTOREFH)
> > > +                     current_op = saved_op;
> > > +             else if (op->opnum == OP_COPY) {
> > > +                     copy = (struct nfsd4_copy *)&op->u;
> > > +                     if (!saved_op)
> > > +                             return nfserr_nofilehandle;
> >
> > Looks like this results in returning an empty compound result with just
> > the bare result.  I believe what we need to do is execute all the
> > ops preceding the COPY normally, then return the nofilehandle error on
> > the COPY.
> >
> > One approach might be
> >
> >                 if (!saved_op) {
> >                         op->status = nfserr_nofilehandle;
> >                         return;
> >                 }
> >
> > and change check_if_stalefh_allowed to have no return value.
> 
> Ok thanks. I'm just curious if op->status assignment is necessary or I
> can just do a return. When nfsd4_copy() calls nfs4_verify_copy() it
> would check
>         if (!cstate->save_fh.fh_dentry)
>                 return nfserr_nofilehandle;

Catching the error here might be a little safer if you think there's
ever a risk of messing up the later logic?  But, really, either should
work.

Since a real client is never going to hit any interesting cases here, it
could be useful to have a pynfs test or two that sent some weird illegal
compounds.

--b.

> 
> >
> > --b.
> >
> > > +                     putfh = (struct nfsd4_putfh *)&saved_op->u;
> > > +                     if (!copy->cp_intra)
> > > +                             putfh->no_verify = true;
> > > +             }
> > > +     }
> > > +     return nfs_ok;
> > > +}
> > ...
> > > @@ -2004,6 +2051,9 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
> > >               resp->opcnt = 1;
> > >               goto encode_op;
> > >       }
> > > +     status = check_if_stalefh_allowed(args);
> > > +     if (status)
> > > +             goto out;
> >
> > >
> > >       trace_nfsd_compound(rqstp, args->opcnt);
> > >       while (!status && resp->opcnt < args->opcnt) {
