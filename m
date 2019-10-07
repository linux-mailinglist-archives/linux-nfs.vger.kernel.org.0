Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB87CE545
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2019 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfJGObQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Oct 2019 10:31:16 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37282 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGObQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Oct 2019 10:31:16 -0400
Received: by mail-vs1-f67.google.com with SMTP id p13so9029746vsr.4
        for <linux-nfs@vger.kernel.org>; Mon, 07 Oct 2019 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsC4Gu3H+ULy2Wt9mkjcizmVxlS+335Gtso4MQ+PaIQ=;
        b=EOu3erDrPpjaq48GHSt9TPOpkMg+S8aZdTseS7spk+yl9DYPmUqwlVZgBrsjzIt6UE
         4nzPxo6OMh7jU1W1TLJNebdX9+rXJgSNMWsvyPPq6lwHvOY1ExAliXIUTEYFNzlUpW9r
         pJ66a6FejP6xouRGkMXRigNO18oifkren0eEabUdnWYvq0gZL/BEq3O4oWH32wd49NmR
         HZreOqZ+rwWre0UGWyLbRZ7rOFobBnjJQ4FguuXO72Qis0rX9OU3BXHtZX0V7SOE5ul7
         A9vb63l4dG3NIsX/HuKn/l1R1exQ2GsLrd6r6/ob6SBhaZV7Amd0MUfmJ2vOjCBezyJR
         N7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsC4Gu3H+ULy2Wt9mkjcizmVxlS+335Gtso4MQ+PaIQ=;
        b=f6CAsvRttIuYrTeJQW4HIdOw5zH0vh4BLNr2uRNxBaWdnhzI0a4ALw0cqF0A5+dA4/
         diDzwHcuBgOtInWIbctqUZYRGO4xFWIu3P75zBl+uIesERiKE5UD4HEpf05wWYHrYUIx
         H7FB3XEzuvAAdJOOwO262VdqUTZiCuaCSn0S7+u7rRK0EXPO5hoWrmh9J5SS7lyG1CnX
         /q302KQwpoYyz0/FfkZPTLBIzGVRTFZvHG8BEotrvo2sGLTJZNb6fRHopSSn9JdRj9iG
         PqvcJXcG2bFidrQ2OuntT9PHvr/hRXPLO4vLhHMYWzED2VWWlRNvMc/rc95pC0N0RdAT
         1bjg==
X-Gm-Message-State: APjAAAV7jWR3DLCIl3EYXN/tULUjrhsYdccfNjofKn/no4I/rhZ56DOA
        xWHONcf5HWemkO6VeiX8ajginiiXMzD1UnKPz90=
X-Google-Smtp-Source: APXvYqzzJholtSnPXVuVJUtshWyRB/GXSrYu4JNYhQhgrFZzMXXxDgh7v67rGzmJGPcXkCRdvcJw8PfFBWJjvhebeMQ=
X-Received: by 2002:a67:da8e:: with SMTP id w14mr15367177vsj.194.1570458675215;
 Mon, 07 Oct 2019 07:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <20190916211353.18802-19-olga.kornievskaia@gmail.com> <20191002195511.GA21809@fieldses.org>
In-Reply-To: <20191002195511.GA21809@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 7 Oct 2019 10:31:04 -0400
Message-ID: <CAN-5tyEb=YG-5j7bNFSqefaC32vaTh3NQ0QgKPwgVuPg-quVQQ@mail.gmail.com>
Subject: Re: [PATCH v7 18/19] NFSD: allow inter server COPY to have a STALE
 source server fh
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 2, 2019 at 3:55 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Sep 16, 2019 at 05:13:52PM -0400, Olga Kornievskaia wrote:
> > @@ -1956,6 +1964,45 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
> >               - rqstp->rq_auth_slack;
> >  }
> >
> > +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > +static __be32
> > +check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
> > +{
> > +     struct nfsd4_op *op, *current_op, *saved_op;
>
> current_op and saved_op need to be initialized to NULL here.
>
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
> > +                     if (!saved_op)
> > +                             return nfserr_nofilehandle;
>
> Looks like this results in returning an empty compound result with just
> the bare result.  I believe what we need to do is execute all the
> ops preceding the COPY normally, then return the nofilehandle error on
> the COPY.
>
> One approach might be
>
>                 if (!saved_op) {
>                         op->status = nfserr_nofilehandle;
>                         return;
>                 }
>
> and change check_if_stalefh_allowed to have no return value.

Ok thanks. I'm just curious if op->status assignment is necessary or I
can just do a return. When nfsd4_copy() calls nfs4_verify_copy() it
would check
        if (!cstate->save_fh.fh_dentry)
                return nfserr_nofilehandle;

>
> --b.
>
> > +                     putfh = (struct nfsd4_putfh *)&saved_op->u;
> > +                     if (!copy->cp_intra)
> > +                             putfh->no_verify = true;
> > +             }
> > +     }
> > +     return nfs_ok;
> > +}
> ...
> > @@ -2004,6 +2051,9 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
> >               resp->opcnt = 1;
> >               goto encode_op;
> >       }
> > +     status = check_if_stalefh_allowed(args);
> > +     if (status)
> > +             goto out;
>
> >
> >       trace_nfsd_compound(rqstp, args->opcnt);
> >       while (!status && resp->opcnt < args->opcnt) {
