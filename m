Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F672CB06C
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 23:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgLAWqI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 17:46:08 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:47881 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLAWqH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 17:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606862767; x=1638398767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LSpbu691iu7fyprnkM0MkcDuPCfpFPDF6/WbgTJ6Qsc=;
  b=RNrO4cfpuDso2Ak3zCHqpPgWJiAzlVC9EREZGuoedni7uKHqmaKjpWR5
   o1Ys9LHelw15jq+m3WwMxsUSwW0jzBLtU4v8KaqAGNvubeoeuJ8rd++4X
   jDG/jimmDhbMz0zgOHRoKgCFr9r2+Bz3GHtaUeaALDP1Wx78qP2PY9jcO
   E=;
X-IronPort-AV: E=Sophos;i="5.78,385,1599523200"; 
   d="scan'208";a="99673455"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 01 Dec 2020 22:45:20 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 7A0E3C061E;
        Tue,  1 Dec 2020 22:45:19 +0000 (UTC)
Received: from EX13D05UEB002.ant.amazon.com (10.43.60.76) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Dec 2020 22:45:19 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D05UEB002.ant.amazon.com (10.43.60.76) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Dec 2020 22:45:18 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 1 Dec 2020 22:45:18 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 6E38BC1321; Tue,  1 Dec 2020 22:45:17 +0000 (UTC)
Date:   Tue, 1 Dec 2020 22:45:17 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] NFSv4.2: improve page handling for GETXATTR
Message-ID: <20201201224517.GB16772@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201201213128.13624-1-fllinden@amazon.com>
 <CAN-5tyF8P9J8DhHZhFyEq97BpjAe9bFg786QH6eF_1r0jPi-Fg@mail.gmail.com>
 <20201201222411.GA16772@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201201222411.GA16772@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 10:24:11PM +0000, Frank van der Linden wrote:
> On Tue, Dec 01, 2020 at 05:03:46PM -0500, Olga Kornievskaia wrote:
> > 
> > On Tue, Dec 1, 2020 at 4:44 PM Frank van der Linden <fllinden@amazon.com> wrote:
> > >
> > > XDRBUF_SPARSE_PAGES can cause problems for the RDMA transport,
> > > and it's easy enough to allocate enough pages for the request
> > > up front, so do that.
> > >
> > > Also, since we've allocated the pages anyway, use the full
> > > page aligned length for the receive buffer. This will allow
> > > caching of valid replies that are too large for the caller,
> > > but that still fit in the allocated pages.
> > >
> > > Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> > > ---
> > >  fs/nfs/nfs42proc.c | 39 ++++++++++++++++++++++++++++++---------
> > >  fs/nfs/nfs42xdr.c  | 22 +++++++++++++++++-----
> > >  2 files changed, 47 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > index 2b2211d1234e..bfe15ac77bd9 100644
> > > --- a/fs/nfs/nfs42proc.c
> > > +++ b/fs/nfs/nfs42proc.c
> > > @@ -1176,11 +1176,9 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
> > >                                 void *buf, size_t buflen)
> > >  {
> > >         struct nfs_server *server = NFS_SERVER(inode);
> > > -       struct page *pages[NFS4XATTR_MAXPAGES] = {};
> > > +       struct page **pages;
> > >         struct nfs42_getxattrargs arg = {
> > >                 .fh             = NFS_FH(inode),
> > > -               .xattr_pages    = pages,
> > > -               .xattr_len      = buflen,
> > >                 .xattr_name     = name,
> > >         };
> > >         struct nfs42_getxattrres res;
> > > @@ -1189,12 +1187,31 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
> > >                 .rpc_argp       = &arg,
> > >                 .rpc_resp       = &res,
> > >         };
> > > -       int ret, np;
> > > +       ssize_t ret, np, i;
> > > +
> > > +       arg.xattr_len = buflen ?: XATTR_SIZE_MAX;
> > > +
> > > +       ret = -ENOMEM;
> > > +       np = DIV_ROUND_UP(arg.xattr_len, PAGE_SIZE);
> > > +
> > > +       pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
> > > +       if (pages == NULL)
> > > +               return ret;
> > > +
> > > +       for (i = 0; i < np; i++) {
> > > +               pages[i] = alloc_page(GFP_KERNEL);
> > > +               if (!pages[i])
> > > +                       goto out_free;
> > > +       }
> > > +
> > > +       arg.xattr_pages = pages;
> > >
> > >         ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
> > >             &res.seq_res, 0);
> > >         if (ret < 0)
> > > -               return ret;
> > > +               goto out_free;
> > > +
> > > +       ret = res.xattr_len;
> > >
> > >         /*
> > >          * Normally, the caching is done one layer up, but for successful
> > > @@ -1209,16 +1226,20 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
> > >         nfs4_xattr_cache_add(inode, name, NULL, pages, res.xattr_len);
> > >
> > >         if (buflen) {
> > > -               if (res.xattr_len > buflen)
> > > -                       return -ERANGE;
> > > +               if (res.xattr_len > buflen) {
> > > +                       ret = -ERANGE;
> > > +                       goto out_free;
> > > +               }
> > >                 _copy_from_pages(buf, pages, 0, res.xattr_len);
> > >         }
> > >
> > > -       np = DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
> > > +out_free:
> > >         while (--np >= 0)
> > >                 __free_page(pages[np]);
> > 
> > Looking at Chuck's page for listxattr, I think we need to check if
> > (pages[np) before freeing?
> > 
> > Otherwise, looks fine to me. Reviewed-by.
> 
> Hm, originally, yes, because of SPARSE_PAGES use. So that was actually
> a bug in the original code, which is now fixed. In other words, we
> need a Cc: -stable here (which I assume we want anyway, since this
> fixes RDMA).

Oh, no, actually the original code was fine - it only freed the pages
based on the actual returned result - so no issue there.

Let me address Trond's comments, though, I'll send a v2.

Frank
