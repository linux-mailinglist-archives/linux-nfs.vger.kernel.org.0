Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32182CDD98
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 19:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502068AbgLCS0M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 13:26:12 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:48107 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502109AbgLCS0L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 13:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1607019970; x=1638555970;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=p0y0hYuf4Aqm0Vy/Vh0fzV2lvoYD1QGxeeaqqO7K34U=;
  b=kbH6yZp1IJpUNovXleZxKhinPBOOae7GrZ82V4UXvG+3MaHenm011IQo
   V/z2GBLY7jwV5X/Oj42BX1FCcwen0D8hwNuKwz9iBhVbm4hpKG3o+RPbF
   ebWgOjiI0urwQgwvyshVdwjsdOee4alkcdF0Hhik91/zUvYXCwPekd5pV
   A=;
X-IronPort-AV: E=Sophos;i="5.78,390,1599523200"; 
   d="scan'208";a="900399097"
Subject: Re: Kernel OPS when using xattr
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-16425a8d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 03 Dec 2020 18:25:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-16425a8d.us-east-1.amazon.com (Postfix) with ESMTPS id 653AF10114C;
        Thu,  3 Dec 2020 18:25:21 +0000 (UTC)
Received: from EX13D50UWA004.ant.amazon.com (10.43.163.5) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 3 Dec 2020 18:25:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D50UWA004.ant.amazon.com (10.43.163.5) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 3 Dec 2020 18:25:20 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 3 Dec 2020 18:25:20 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id A5682C1321; Thu,  3 Dec 2020 18:25:20 +0000 (UTC)
Date:   Thu, 3 Dec 2020 18:25:20 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Message-ID: <20201203182520.GA5535@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de>
 <3e8c5334cca58c92e92d7ac2af95cf4e5141df08.camel@hammerspace.com>
 <305212825.2047189.1607011487661.JavaMail.zimbra@desy.de>
 <3b6276e9afe5e2dc2fa9c1f11b607bc031071554.camel@hammerspace.com>
 <20201203174757.GA2605@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <43574879eae405b934fa4c37a482b004adbb2aa9.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <43574879eae405b934fa4c37a482b004adbb2aa9.camel@hammerspace.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 06:23:24PM +0000, Trond Myklebust wrote:
> 
> 
> On Thu, 2020-12-03 at 17:47 +0000, Frank van der Linden wrote:
> > On Thu, Dec 03, 2020 at 05:13:26PM +0000, Trond Myklebust wrote:
> > [...]
> > > You probably need this one in addition to the first patch.
> > > 8<----------------------------------------------------
> > > From fec77469f373fbccb292c2d522f2ebee3b9011a8 Mon Sep 17 00:00:00
> > > 2001
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Date: Thu, 3 Dec 2020 12:04:51 -0500
> > > Subject: [PATCH] NFSv4.2: Fix up the get/listxattr calls to
> > >  rpc_prepare_reply_pages()
> > >
> > > Ensure that both getxattr and listxattr page array are correctly
> > > aligned, and that getxattr correctly accounts for the page padding
> > > word.
> > >
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > >  fs/nfs/nfs42xdr.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > index 8432bd6b95f0..103978ff76c9 100644
> > > --- a/fs/nfs/nfs42xdr.c
> > > +++ b/fs/nfs/nfs42xdr.c
> > > @@ -191,7 +191,7 @@
> > >
> > >  #define encode_getxattr_maxsz   (op_encode_hdr_maxsz + 1 + \
> > >                                  nfs4_xattr_name_maxsz)
> > > -#define decode_getxattr_maxsz   (op_decode_hdr_maxsz + 1 + 1)
> > > +#define decode_getxattr_maxsz   (op_decode_hdr_maxsz + 1 +
> > > pagepad_maxsz)
> > >  #define encode_setxattr_maxsz   (op_encode_hdr_maxsz + \
> > >                                  1 + nfs4_xattr_name_maxsz + 1)
> > >  #define decode_setxattr_maxsz   (op_decode_hdr_maxsz +
> > > decode_change_info_maxsz)
> > > @@ -1476,17 +1476,18 @@ static void nfs4_xdr_enc_getxattr(struct
> > > rpc_rqst *req, struct xdr_stream *xdr,
> > >         struct compound_hdr hdr = {
> > >                 .minorversion = nfs4_xdr_minorversion(&args-
> > > > seq_args),
> > >         };
> > > +       uint32_t replen;
> > >         size_t plen;
> > >
> > >         encode_compound_hdr(xdr, req, &hdr);
> > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > >         encode_putfh(xdr, args->fh, &hdr);
> > > +       replen = hdr.replen + op_decode_hdr_maxsz + 1;
> > >         encode_getxattr(xdr, args->xattr_name, &hdr);
> > >
> > >         plen = args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
> > >
> > > -       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> > > -           hdr.replen);
> > > +       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> > > replen);
> > >         req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
> > >
> > >         encode_nops(&hdr);
> > > @@ -1520,14 +1521,15 @@ static void nfs4_xdr_enc_listxattrs(struct
> > > rpc_rqst *req,
> > >         struct compound_hdr hdr = {
> > >                 .minorversion = nfs4_xdr_minorversion(&args-
> > > > seq_args),
> > >         };
> > > +       uint32_t replen;
> > >
> > >         encode_compound_hdr(xdr, req, &hdr);
> > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > >         encode_putfh(xdr, args->fh, &hdr);
> > > +       replen = hdr.replen + op_decode_hdr_maxsz + 2 + 1;
> > >         encode_listxattrs(xdr, args, &hdr);
> > >
> > > -       rpc_prepare_reply_pages(req, args->xattr_pages, 0, args-
> > > > count,
> > > -           hdr.replen);
> > > +       rpc_prepare_reply_pages(req, args->xattr_pages, 0, args-
> > > > count, replen);
> > >
> > >         encode_nops(&hdr);
> > >  }
> > > --
> > > 2.28.0
> >
> > Hm.. that doesn't seem to match other, similar functionality.
> > Why is the additional padding and op_decode_hdr_maxsz needed?
> >
> 
> It isn't extra padding. It is the same padding, but after the cleanup
> that removes the confusing behaviour of rpc_prepare_reply_pages(), the
> caller is supposed to supply the actual offset for the beginning of the
> page data instead of adding the padding to that offset:
> https://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=9ed5af268e88f6e5b65376be98d652b37cb20d7b

Ahh, that makes a lot of sense, thanks for fixing rpc_prepare_reply_pages.

- Frank
