Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A752CAFE9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 23:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgLAWZl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 17:25:41 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:14015 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgLAWZl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 17:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606861541; x=1638397541;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=fU4kihANxnzK5rBLkCxcnr0sD9r82ocW9P15usCxXEE=;
  b=n6NiX218mwTrpbbg1L7XEK/zWLPOXpRtGL21uEkYBS5iR3a6INnIC1Vi
   ZSf0aYTMpPymFU/Nj6L5jMMtSXx7IXVyiLoeC9Jq/rPPqVYZwj2XcWbdL
   MWhrilrntJc9lHVB2tNAYKfE94I6ir864B2Yj5M4CbWRbG0mPgULJHGfR
   4=;
X-IronPort-AV: E=Sophos;i="5.78,385,1599523200"; 
   d="scan'208";a="67066376"
Subject: Re: [PATCH] NFSv4.2: improve page handling for GETXATTR
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 01 Dec 2020 22:24:15 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id B5717A20F6;
        Tue,  1 Dec 2020 22:24:12 +0000 (UTC)
Received: from EX13D40UWC002.ant.amazon.com (10.43.162.191) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Dec 2020 22:24:12 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D40UWC002.ant.amazon.com (10.43.162.191) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Dec 2020 22:24:11 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 1 Dec 2020 22:24:11 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id C5472C1321; Tue,  1 Dec 2020 22:24:11 +0000 (UTC)
Date:   Tue, 1 Dec 2020 22:24:11 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Message-ID: <20201201222411.GA16772@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201201213128.13624-1-fllinden@amazon.com>
 <CAN-5tyF8P9J8DhHZhFyEq97BpjAe9bFg786QH6eF_1r0jPi-Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAN-5tyF8P9J8DhHZhFyEq97BpjAe9bFg786QH6eF_1r0jPi-Fg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 05:03:46PM -0500, Olga Kornievskaia wrote:
> 
> On Tue, Dec 1, 2020 at 4:44 PM Frank van der Linden <fllinden@amazon.com> wrote:
> >
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
> > @@ -1176,11 +1176,9 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
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
> > @@ -1189,12 +1187,31 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
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
> > +
> > +       pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
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
> >         ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
> >             &res.seq_res, 0);
> >         if (ret < 0)
> > -               return ret;
> > +               goto out_free;
> > +
> > +       ret = res.xattr_len;
> >
> >         /*
> >          * Normally, the caching is done one layer up, but for successful
> > @@ -1209,16 +1226,20 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
> >         nfs4_xattr_cache_add(inode, name, NULL, pages, res.xattr_len);
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
> 
> Looking at Chuck's page for listxattr, I think we need to check if
> (pages[np) before freeing?
> 
> Otherwise, looks fine to me. Reviewed-by.

Hm, originally, yes, because of SPARSE_PAGES use. So that was actually
a bug in the original code, which is now fixed. In other words, we
need a Cc: -stable here (which I assume we want anyway, since this
fixes RDMA).

It's not needed anymore, and it's not needed for listxattr anymore either,
although there the code was originally correct.

- Frank
