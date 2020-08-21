Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40E324E06C
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Aug 2020 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHUTEd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Aug 2020 15:04:33 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55176 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUTEb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Aug 2020 15:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598036670; x=1629572670;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=+wFqY0VAJJu/iAUFoMuX3M9CMAfrg4lPz6d6KmIde9A=;
  b=Ts/nxhFzF4Km2IQHRRn5PwQ7QUscTKuF42azKTf75VASAzeRsZnpTMry
   z0XNX//Ze6+5Tk+P23vDB34WgBbhsbnNrp2TThA3uM4Qp9AoQn74l3BhU
   tkPhzTeCEzW76/xZFgsocF6KYP1mIVRWjWCbHt16aIyPN0cvS/uJNTKqE
   c=;
X-IronPort-AV: E=Sophos;i="5.76,338,1592870400"; 
   d="scan'208";a="49189913"
Subject: Re: [PATCH] NFSD: Fix listxattr receive buffer size
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 21 Aug 2020 19:04:26 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id EE3B9A1F79;
        Fri, 21 Aug 2020 19:04:24 +0000 (UTC)
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 21 Aug 2020 19:04:23 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Fri, 21 Aug 2020 19:04:23 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 6B39AC14DA; Fri, 21 Aug 2020 19:04:23 +0000 (UTC)
Date:   Fri, 21 Aug 2020 19:04:23 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20200821190423.GA16632@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <159803139578.514751.6905262413915309673.stgit@manet.1015granger.net>
 <8F5EBDEC-BBF5-4B15-8EE2-E6B57CC7BBCF@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8F5EBDEC-BBF5-4B15-8EE2-E6B57CC7BBCF@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 21, 2020 at 02:59:32PM -0400, Chuck Lever wrote:
> Oops. Short description should read:
> 
> NFS: Fix listxattr receive buffer size
> 
> 
> > On Aug 21, 2020, at 1:36 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > Certain NFSv4.2/RDMA tests fail with v5.9-rc1.
> >
> > rpcrdma_convert_kvec() runs off the end of the rl_segments array
> > because rq_rcv_buf.tail[0].iov_len holds a very large positive
> > value. The resultant kernel memory corruption is enough to crash
> > the client system.
> >
> > Callers of rpc_prepare_reply_pages() must reserve an extra XDR_UNIT
> > in the maximum decode size for a possible XDR pad of the contents
> > of the xdr_buf's pages. That guarantees the allocated receive buffer
> > will be large enough to accommodate the usual contents plus that XDR
> > pad word.
> >
> > encode_op_hdr() cannot add that extra word. If it does,
> > xdr_inline_pages() underruns the length of the tail iovec.
> >
> > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for extended attributes")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> > fs/nfs/nfs42xdr.c |    4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > index cc50085e151c..d0ddf90c9be4 100644
> > --- a/fs/nfs/nfs42xdr.c
> > +++ b/fs/nfs/nfs42xdr.c
> > @@ -179,7 +179,7 @@
> >                                1 + nfs4_xattr_name_maxsz + 1)
> > #define decode_setxattr_maxsz   (op_decode_hdr_maxsz + decode_change_info_maxsz)
> > #define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
> > -#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1)
> > +#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + 1)
> > #define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
> >                                 nfs4_xattr_name_maxsz)
> > #define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
> > @@ -504,7 +504,7 @@ static void encode_listxattrs(struct xdr_stream *xdr,
> > {
> >       __be32 *p;
> >
> > -     encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz + 1, hdr);
> > +     encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz, hdr);
> >
> >       p = reserve_space(xdr, 12);
> >       if (unlikely(!p))
> >
> >
> 
> --
> Chuck Lever

A detail of the sunrpc/xdr code I wasn't familiar with.. thanks for
fixing this.

- Frank
