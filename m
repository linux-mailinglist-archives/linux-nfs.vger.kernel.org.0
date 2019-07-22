Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9C70A3B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2019 22:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbfGVUAf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jul 2019 16:00:35 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36950 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbfGVUAf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jul 2019 16:00:35 -0400
Received: by mail-ua1-f68.google.com with SMTP id z13so15932642uaa.4
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2019 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hS6Nw3jezE2dmpmrFy1yqWvlRMAaDsyZpwkCrzVFJM4=;
        b=iiY7QV/tyj72HzSGY/W2oEpvNl/eqDhEtXYjUBx0nSi1xNGVmdbLNVAi4xcGsQNkOH
         asBM8MKamicppt03/3rxaburAp/Z9lTqky72ay5stBUGmKTbMY8dX6Yakk7ZwAelJCx9
         t7HtnAtkZlT6WVLueqf9RYQLkqMnZ0QClpGsWwWWEQE4SyTh7PwvNzrW1hNsT3Dam6lU
         ZShttiT6qLm/co6wXHq3tYHKAFUZ98slHvrcwpYCTaw7UgACvX+dWpgiD19ndkx2iKCp
         NozVFNjXHtv1fSJolXVYzs/0lg4tUmcQIs6zofvvqfYmfmZxJ4ZOgr4u9n5FvYnfTxWc
         oiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hS6Nw3jezE2dmpmrFy1yqWvlRMAaDsyZpwkCrzVFJM4=;
        b=TlTJmLRIXfhAHUgNryq2keALmSf0F4PtgI2pSBgrbeCk8jeJhaMC7cZKdJNrWPGGGF
         Dwii/+gkzmkQcHkUtNqt79JaM7D+UtjkJuxur8Ln1Xb44YXVN1UpZiljEqNWjFwRhZnY
         BIKj/NX9qtTMLCuKMVUIg4VwcfUqZ+3c/6kLAhRilbOZTyjWTQjXaQluorXxFvnDKUHQ
         GVnV4GyYYMJb6hkiC1DFnrPmvgzKuXXDVxGHFCJij/Y6w+2nWsy4POuNyQ32SWFhoJsA
         sQOzfF9RnkUIznPW9MGQM4R+OFMVC8sVM4y4HhSAaT158HYi/CuDYwwx4FhsKD4u8KAu
         umQg==
X-Gm-Message-State: APjAAAWbkWsQAL/qBc5i22ZjQm8oblOapkDU7SlhCv2gsyZPUrdy91Nk
        vwxtCRERBCxulww62qV13gBTwyiRp6se8kMRQr1Jow==
X-Google-Smtp-Source: APXvYqxkRFq1P+mrcZtq+2ljl02dNDSJ0udUiSksbtF0IXJBVa/i71OcRHYAt2F1yGUEZZ7hEWniT0nXys51Nzz45C0=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr44613509uag.40.1563825633295;
 Mon, 22 Jul 2019 13:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-3-olga.kornievskaia@gmail.com> <20190717214036.GN24608@fieldses.org>
In-Reply-To: <20190717214036.GN24608@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 22 Jul 2019 16:00:22 -0400
Message-ID: <CAN-5tyEju4eM+f1oR8mzrQ9pYBZDL23G+eh8V_uQEcs__Sad-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] NFSD add ca_source_server<> to COPY
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 17, 2019 at 5:40 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jul 08, 2019 at 03:23:46PM -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Decode the ca_source_server list that's sent but only use the
> > first one. Presence of non-zero list indicates an "inter" copy.
> >
> > Signed-off-by: Andy Adamson <andros@netapp.com>
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfsd/nfs4xdr.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/nfsd/xdr4.h    | 12 +++++----
> >  2 files changed, 80 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 52c4f6d..15f53bb 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/utsname.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/sunrpc/svcauth_gss.h>
> > +#include <linux/sunrpc/addr.h>
> >
> >  #include "idmap.h"
> >  #include "acl.h"
> > @@ -1744,11 +1745,58 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
> >       DECODE_TAIL;
> >  }
> >
> > +static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
> > +                                   struct nl4_server *ns)
> > +{
> > +     DECODE_HEAD;
> > +     struct nfs42_netaddr *naddr;
> > +
> > +     READ_BUF(4);
> > +     ns->nl4_type = be32_to_cpup(p++);
> > +
> > +     /* currently support for 1 inter-server source server */
> > +     switch (ns->nl4_type) {
> > +     case NL4_NAME:
> > +     case NL4_URL:
> > +             READ_BUF(4);
> > +             ns->u.nl4_str_sz = be32_to_cpup(p++);
> > +             if (ns->u.nl4_str_sz > NFS4_OPAQUE_LIMIT)
> > +                     goto xdr_error;
> > +
> > +             READ_BUF(ns->u.nl4_str_sz);
> > +             COPYMEM(ns->u.nl4_str,
> > +                     ns->u.nl4_str_sz);
> > +             break;
>
> Do we actually have plans to use this case?  If not, it's probably not
> worth saving these fields.

We don't use them. They were there for "completeness".  I can remove
them to simplify the code.

>
> --b.
>
> > +     case NL4_NETADDR:
> > +             naddr = &ns->u.nl4_addr;
> > +
> > +             READ_BUF(4);
> > +             naddr->netid_len = be32_to_cpup(p++);
> > +             if (naddr->netid_len > RPCBIND_MAXNETIDLEN)
> > +                     goto xdr_error;
> > +
> > +             READ_BUF(naddr->netid_len + 4); /* 4 for uaddr len */
> > +             COPYMEM(naddr->netid, naddr->netid_len);
> > +
> > +             naddr->addr_len = be32_to_cpup(p++);
> > +             if (naddr->addr_len > RPCBIND_MAXUADDRLEN)
> > +                     goto xdr_error;
> > +
> > +             READ_BUF(naddr->addr_len);
> > +             COPYMEM(naddr->addr, naddr->addr_len);
> > +             break;
> > +     default:
> > +             goto xdr_error;
> > +     }
> > +     DECODE_TAIL;
> > +}
> > +
> >  static __be32
> >  nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
> >  {
> >       DECODE_HEAD;
> > -     unsigned int tmp;
> > +     struct nl4_server *ns_dummy;
> > +     int i, count;
> >
> >       status = nfsd4_decode_stateid(argp, &copy->cp_src_stateid);
> >       if (status)
> > @@ -1763,8 +1811,31 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
> >       p = xdr_decode_hyper(p, &copy->cp_count);
> >       p++; /* ca_consecutive: we always do consecutive copies */
> >       copy->cp_synchronous = be32_to_cpup(p++);
> > -     tmp = be32_to_cpup(p); /* Source server list not supported */
> > +     count = be32_to_cpup(p++);
> >
> > +     copy->cp_intra = false;
> > +     if (count == 0) { /* intra-server copy */
> > +             copy->cp_intra = true;
> > +             goto intra;
> > +     }
> > +
> > +     /* decode all the supplied server addresses but use first */
> > +     status = nfsd4_decode_nl4_server(argp, &copy->cp_src);
> > +     if (status)
> > +             return status;
> > +
> > +     ns_dummy = kmalloc(sizeof(struct nl4_server), GFP_KERNEL);
> > +     if (ns_dummy == NULL)
> > +             return nfserrno(-ENOMEM);
> > +     for (i = 0; i < count - 1; i++) {
> > +             status = nfsd4_decode_nl4_server(argp, ns_dummy);
> > +             if (status) {
> > +                     kfree(ns_dummy);
> > +                     return status;
> > +             }
> > +     }
> > +     kfree(ns_dummy);
> > +intra:
> >       DECODE_TAIL;
> >  }
> >
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index feeb6d4..513c9ff 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -516,11 +516,13 @@ struct nfsd42_write_res {
> >
> >  struct nfsd4_copy {
> >       /* request */
> > -     stateid_t       cp_src_stateid;
> > -     stateid_t       cp_dst_stateid;
> > -     u64             cp_src_pos;
> > -     u64             cp_dst_pos;
> > -     u64             cp_count;
> > +     stateid_t               cp_src_stateid;
> > +     stateid_t               cp_dst_stateid;
> > +     u64                     cp_src_pos;
> > +     u64                     cp_dst_pos;
> > +     u64                     cp_count;
> > +     struct nl4_server       cp_src;
> > +     bool                    cp_intra;
> >
> >       /* both */
> >       bool            cp_synchronous;
> > --
> > 1.8.3.1
