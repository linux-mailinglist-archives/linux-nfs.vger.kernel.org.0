Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3F2CB19D
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Dec 2020 01:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgLBAhd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 19:37:33 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:53412 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgLBAhc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 19:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606869452; x=1638405452;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=DPL5vClCfQqITfS9On23vLPz8P0aktLF0c1pqIZD1Fk=;
  b=HI6ndoZsaWVova6xwNJQMmC0sTcPGJpnnpQzfLQ1CVodOuaLkB/hx/p6
   e/tIwG9KuoFFugvW3WES3UPdQ+i4+oaCKeuR6hwFuUUCQ8xQTnZ5i9N/g
   50TDKmDPKL2o2BFA78RFJIHtFDz7HnjJZEXp0e6mI3VcjgnC3wQuegNO4
   E=;
X-IronPort-AV: E=Sophos;i="5.78,385,1599523200"; 
   d="scan'208";a="100973487"
Subject: Re: [PATCH] NFSv4.2: improve page handling for GETXATTR
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 02 Dec 2020 00:36:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id BF9E7A042C;
        Wed,  2 Dec 2020 00:36:44 +0000 (UTC)
Received: from EX13D03UEA003.ant.amazon.com (10.43.61.39) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Dec 2020 00:36:44 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D03UEA003.ant.amazon.com (10.43.61.39) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Dec 2020 00:36:44 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 2 Dec 2020 00:36:44 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id D3B46C1321; Wed,  2 Dec 2020 00:36:43 +0000 (UTC)
Date:   Wed, 2 Dec 2020 00:36:43 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Message-ID: <20201202003643.GB720@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201201213128.13624-1-fllinden@amazon.com>
 <ea48cd1ddad6097901597356e22f88227d487886.camel@hammerspace.com>
 <CAN-5tyGxTi0uLMWmMwZdfFMvobBb_aw9Pa4J7sYJW__jaOvv_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAN-5tyGxTi0uLMWmMwZdfFMvobBb_aw9Pa4J7sYJW__jaOvv_g@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 06:03:31PM -0500, Olga Kornievskaia wrote:
> On Tue, Dec 1, 2020 at 5:15 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Tue, 2020-12-01 at 21:31 +0000, Frank van der Linden wrote:
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
> > > @@ -1176,11 +1176,9 @@ static ssize_t _nfs42_proc_getxattr(struct
> > > inode *inode, const char *name,
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
> > > @@ -1189,12 +1187,31 @@ static ssize_t _nfs42_proc_getxattr(struct
> >
> > Why can't we set up the page array in nfs42_proc_getxattr()? This means
> > that if we get a retryable error from the server, then we perform
> > multiple allocations of the same buffer.
> 
> I wonder if the same then is needed for the LISTXATTR as we allocated
> pages in _nfs42_proc_listxattr() and instead should do it in
> nfs42_proc_listxattr()....

There are a few more places of which this is true, yep. getactl is the
other one.

In any case, fixed for the getxattr case in v2.

- Frank
