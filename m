Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3412CDCAC
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 18:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgLCRss (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 12:48:48 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:30522 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgLCRss (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 12:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1607017728; x=1638553728;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=aagvWXDmTgQMqPBa5ZsyWNUT44a2f7u4WlVD6WqnwDo=;
  b=kEhcUKEiMt4t0OEaCgB0f3c0TdxjNkPe01FnWPn37YluTBHUl39hi8PU
   R+IHjVxOL7L2Sx+qDaTmroAdL6/QkvgVd3OZvXsQeGaH5Ms4w3DQC+JpP
   7RCGVcf/Qhj99peL0IumPwa8GrYaKdeAWXUa3PUea7TuMT5r0P9zsj6NM
   M=;
X-IronPort-AV: E=Sophos;i="5.78,390,1599523200"; 
   d="scan'208";a="67191298"
Subject: Re: Kernel OPS when using xattr
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 03 Dec 2020 17:48:01 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 72322A18FE;
        Thu,  3 Dec 2020 17:47:59 +0000 (UTC)
Received: from EX13D31UEA001.ant.amazon.com (10.43.61.114) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 3 Dec 2020 17:47:58 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D31UEA001.ant.amazon.com (10.43.61.114) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 3 Dec 2020 17:47:58 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 3 Dec 2020 17:47:58 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 4328FC1321; Thu,  3 Dec 2020 17:47:57 +0000 (UTC)
Date:   Thu, 3 Dec 2020 17:47:57 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Message-ID: <20201203174757.GA2605@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de>
 <3e8c5334cca58c92e92d7ac2af95cf4e5141df08.camel@hammerspace.com>
 <305212825.2047189.1607011487661.JavaMail.zimbra@desy.de>
 <3b6276e9afe5e2dc2fa9c1f11b607bc031071554.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3b6276e9afe5e2dc2fa9c1f11b607bc031071554.camel@hammerspace.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 05:13:26PM +0000, Trond Myklebust wrote:
[...]
> You probably need this one in addition to the first patch.
> 8<----------------------------------------------------
> From fec77469f373fbccb292c2d522f2ebee3b9011a8 Mon Sep 17 00:00:00 2001
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Thu, 3 Dec 2020 12:04:51 -0500
> Subject: [PATCH] NFSv4.2: Fix up the get/listxattr calls to
>  rpc_prepare_reply_pages()
> 
> Ensure that both getxattr and listxattr page array are correctly
> aligned, and that getxattr correctly accounts for the page padding
> word.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs42xdr.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index 8432bd6b95f0..103978ff76c9 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -191,7 +191,7 @@
> 
>  #define encode_getxattr_maxsz   (op_encode_hdr_maxsz + 1 + \
>                                  nfs4_xattr_name_maxsz)
> -#define decode_getxattr_maxsz   (op_decode_hdr_maxsz + 1 + 1)
> +#define decode_getxattr_maxsz   (op_decode_hdr_maxsz + 1 +
> pagepad_maxsz)
>  #define encode_setxattr_maxsz   (op_encode_hdr_maxsz + \
>                                  1 + nfs4_xattr_name_maxsz + 1)
>  #define decode_setxattr_maxsz   (op_decode_hdr_maxsz +
> decode_change_info_maxsz)
> @@ -1476,17 +1476,18 @@ static void nfs4_xdr_enc_getxattr(struct
> rpc_rqst *req, struct xdr_stream *xdr,
>         struct compound_hdr hdr = {
>                 .minorversion = nfs4_xdr_minorversion(&args-
> >seq_args),
>         };
> +       uint32_t replen;
>         size_t plen;
> 
>         encode_compound_hdr(xdr, req, &hdr);
>         encode_sequence(xdr, &args->seq_args, &hdr);
>         encode_putfh(xdr, args->fh, &hdr);
> +       replen = hdr.replen + op_decode_hdr_maxsz + 1;
>         encode_getxattr(xdr, args->xattr_name, &hdr);
> 
>         plen = args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
> 
> -       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> -           hdr.replen);
> +       rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> replen);
>         req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
> 
>         encode_nops(&hdr);
> @@ -1520,14 +1521,15 @@ static void nfs4_xdr_enc_listxattrs(struct
> rpc_rqst *req,
>         struct compound_hdr hdr = {
>                 .minorversion = nfs4_xdr_minorversion(&args-
> >seq_args),
>         };
> +       uint32_t replen;
> 
>         encode_compound_hdr(xdr, req, &hdr);
>         encode_sequence(xdr, &args->seq_args, &hdr);
>         encode_putfh(xdr, args->fh, &hdr);
> +       replen = hdr.replen + op_decode_hdr_maxsz + 2 + 1;
>         encode_listxattrs(xdr, args, &hdr);
> 
> -       rpc_prepare_reply_pages(req, args->xattr_pages, 0, args-
> >count,
> -           hdr.replen);
> +       rpc_prepare_reply_pages(req, args->xattr_pages, 0, args-
> >count, replen);
> 
>         encode_nops(&hdr);
>  }
> --
> 2.28.0

Hm.. that doesn't seem to match other, similar functionality.
Why is the additional padding and op_decode_hdr_maxsz needed?

- Frank
