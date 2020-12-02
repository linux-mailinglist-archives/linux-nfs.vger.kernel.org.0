Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878982CB19B
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Dec 2020 01:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgLBAgL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 19:36:11 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:47789 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLBAgL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 19:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606869370; x=1638405370;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=Bl6TYxCw9ma1EYbf22C98ZDNgtbslfesQq1vP5eRtz0=;
  b=cTHW1ExtGhPJljy9if7vhabvuAve0B9srRCY6no/YL6rEm6KhqiQzgm6
   uRtG96a3epvGiOI+fi5O/HaGTZzIz7ouvCqkXUQ5uRzrPfOqzep6P9uVF
   mdyYtdgbgkEvqfIjIIFL4isos/8Dnw9+j0/OAfIRXQaz7Qw3wruT9TT8G
   8=;
X-IronPort-AV: E=Sophos;i="5.78,385,1599523200"; 
   d="scan'208";a="99708926"
Subject: Re: [PATCH] NFSv4.2: improve page handling for GETXATTR
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 02 Dec 2020 00:35:21 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id C67AEA1DB6;
        Wed,  2 Dec 2020 00:35:18 +0000 (UTC)
Received: from EX13D36UWA002.ant.amazon.com (10.43.160.24) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Dec 2020 00:35:17 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D36UWA002.ant.amazon.com (10.43.160.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Dec 2020 00:35:17 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 2 Dec 2020 00:35:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 9E65DC1321; Wed,  2 Dec 2020 00:35:17 +0000 (UTC)
Date:   Wed, 2 Dec 2020 00:35:17 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Message-ID: <20201202003517.GA720@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201201213128.13624-1-fllinden@amazon.com>
 <ea48cd1ddad6097901597356e22f88227d487886.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea48cd1ddad6097901597356e22f88227d487886.camel@hammerspace.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 10:15:47PM +0000, Trond Myklebust wrote:
> On Tue, 2020-12-01 at 21:31 +0000, Frank van der Linden wrote:
> > XDRBUF_SPARSE_PAGES can cause problems for the RDMA transport,
> > and it's easy enough to allocate enough pages for the request
> > up front, so do that.
> >
> > Also, since we've allocated the pages anyway, use the full
> > page aligned length for the receive buffer. This will allow
> > caching of valid replies that are too large for the caller,
> > but that still fit in the allocated pages.
> >
> > Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> > ---
> >  fs/nfs/nfs42proc.c | 39 ++++++++++++++++++++++++++++++---------
> >  fs/nfs/nfs42xdr.c  | 22 +++++++++++++++++-----
> >  2 files changed, 47 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index 2b2211d1234e..bfe15ac77bd9 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -1176,11 +1176,9 @@ static ssize_t _nfs42_proc_getxattr(struct
> > inode *inode, const char *name,
> >                                 void *buf, size_t buflen)
> >  {
> >         struct nfs_server *server = NFS_SERVER(inode);
> > -       struct page *pages[NFS4XATTR_MAXPAGES] = {};
> > +       struct page **pages;
> >         struct nfs42_getxattrargs arg = {
> >                 .fh             = NFS_FH(inode),
> > -               .xattr_pages    = pages,
> > -               .xattr_len      = buflen,
> >                 .xattr_name     = name,
> >         };
> >         struct nfs42_getxattrres res;
> > @@ -1189,12 +1187,31 @@ static ssize_t _nfs42_proc_getxattr(struct
> 
> Why can't we set up the page array in nfs42_proc_getxattr()? This means
> that if we get a retryable error from the server, then we perform
> multiple allocations of the same buffer.
> 
> > inode *inode, const char *name,
> >                 .rpc_argp       = &arg,
> >                 .rpc_resp       = &res,
> >         };
> > -       int ret, np;
> > +       ssize_t ret, np, i;
> > +
> > +       arg.xattr_len = buflen ?: XATTR_SIZE_MAX;
> > +
> > +       ret = -ENOMEM;
> > +       np = DIV_ROUND_UP(arg.xattr_len, PAGE_SIZE);
> 
> Please just use nfs_page_array_len(). It should be more efficient than
> the above.
> 
> > +
> > +       pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
> 
> Perhaps do this as kmalloc_array() so we don't have to zero out the
> array? If the alloc_page() fails below, you can always just truncate
> the value of 'np' before jumping to 'out_free'.
> 
> Also note that we prefer to use 'sizeof(*pages)' rather than
> sizeof(struct page *).
> 
> > +       if (pages == NULL)
> > +               return ret;
> > +
> > +       for (i = 0; i < np; i++) {
> > +               pages[i] = alloc_page(GFP_KERNEL);
> > +               if (!pages[i])
> > +                       goto out_free;
> > +       }
> > +
> > +       arg.xattr_pages = pages;
> >
> >         ret = nfs4_call_sync(server->client, server, &msg,
> > &arg.seq_args,
> >             &res.seq_res, 0);
> >         if (ret < 0)
> > -               return ret;
> > +               goto out_free;
> > +
> > +       ret = res.xattr_len;
> >
> >         /*
> >          * Normally, the caching is done one layer up, but for
> > successful
> > @@ -1209,16 +1226,20 @@ static ssize_t _nfs42_proc_getxattr(struct
> > inode *inode, const char *name,
> >         nfs4_xattr_cache_add(inode, name, NULL, pages,
> > res.xattr_len);
> >
> >         if (buflen) {
> > -               if (res.xattr_len > buflen)
> > -                       return -ERANGE;
> > +               if (res.xattr_len > buflen) {
> > +                       ret = -ERANGE;
> > +                       goto out_free;
> > +               }
> >                 _copy_from_pages(buf, pages, 0, res.xattr_len);
> >         }
> >
> > -       np = DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
> > +out_free:
> >         while (--np >= 0)
> >                 __free_page(pages[np]);
> >
> > -       return res.xattr_len;
> > +       kfree(pages);
> > +
> > +       return ret;
> >  }
> >
> >  static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void
> > *buf,
> > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > index 6e060a88f98c..8dfe674d1301 100644
> > --- a/fs/nfs/nfs42xdr.c
> > +++ b/fs/nfs/nfs42xdr.c
> > @@ -489,6 +489,12 @@ static int decode_getxattr(struct xdr_stream
> > *xdr,
> >                 return -EIO;
> >
> >         len = be32_to_cpup(p);
> > +
> > +       /*
> > +        * Only check against the page length here. The actual
> > +        * requested length may be smaller, but that is only
> > +        * checked against after possibly caching a valid reply.
> > +        */
> >         if (len > req->rq_rcv_buf.page_len)
> >                 return -ERANGE;
> >
> > @@ -1483,11 +1489,17 @@ static void nfs4_xdr_enc_getxattr(struct
> > rpc_rqst *req, struct xdr_stream *xdr,
> >         encode_putfh(xdr, args->fh, &hdr);
> >         encode_getxattr(xdr, args->xattr_name, &hdr);
> >
> > -       plen = args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
> > -
> > -       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> > -           hdr.replen);
> > -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
> > +       /*
> > +        * The GETXATTR op has no length field in the call, and the
> > +        * xattr data is at the end of the reply.
> > +        *
> > +        * Since the pages have already been allocated, there is no
> > +        * downside in using the page-aligned length. It will allow
> > +        * receiving and caching xattrs that are too large for the
> > +        * caller but still fit in the page-rounded value.
> > +        */
> > +       plen = round_up(args->xattr_len, PAGE_SIZE);
> 
> This is the wrong place to be recalculating page buffer sizes. This
> function should have no idea what was allocated or by whom. Please just
> set the correct value for args->xattr_len in nfs42_proc_getxattr().
> 
> > +       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> > hdr.replen);
> >
> >         encode_nops(&hdr);
> >  }
> 
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

Thanks for the comments - v2 sent.

- Frank
