Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D772C4BF9
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Nov 2020 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgKZAV7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 19:21:59 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2848 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKZAV7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 19:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606350118; x=1637886118;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=xShX6oBJo6P5nnH3QRWk8ovUW5DCv/2O1Z+1VdizbU0=;
  b=GgNpGdbDySXpCchqzrIjdz+Q80tHLpXQ/rQ/TNbVDoQr+UZ0l5veXkP4
   RUzdsrrdyfK71MAhLHcpjJjBhD7vYc84d696kJhgSzomP2fVZ211NXJLJ
   jsM4bLWSX4MMHIFf+0Q2rGS73/iPbbd8MheODldkV3muOGz8/4Np80Rym
   8=;
X-IronPort-AV: E=Sophos;i="5.78,370,1599523200"; 
   d="scan'208";a="99297745"
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS
 operation
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 26 Nov 2020 00:21:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id B95A9A2177;
        Thu, 26 Nov 2020 00:21:50 +0000 (UTC)
Received: from EX13D30UEA003.ant.amazon.com (10.43.61.28) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 00:21:50 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D30UEA003.ant.amazon.com (10.43.61.28) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 00:21:49 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 26 Nov 2020 00:21:50 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 88505C21EF; Thu, 26 Nov 2020 00:21:49 +0000 (UTC)
Date:   Thu, 26 Nov 2020 00:21:49 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Message-ID: <20201126002149.GA2339@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
 <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B1CF6271-B168-4571-B8E4-0CAB0A0B40FB@netapp.com>
 <20201124211926.GB14140@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <5571DE63-1276-4AF6-BB8F-EE36878B06E5@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5571DE63-1276-4AF6-BB8F-EE36878B06E5@netapp.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 10:40:25PM +0000, Kornievskaia, Olga wrote:
> 
> 
> ﻿On 11/24/20, 4:20 PM, "Frank van der Linden" <fllinden@amazon.com> wrote:
> 
>     On Tue, Nov 24, 2020 at 08:50:36PM +0000, Kornievskaia, Olga wrote:
>     >
>     >
>     > On 11/24/20, 3:06 PM, "Frank van der Linden" <fllinden@amazon.com> wrote:
>     >
>     >     On Tue, Nov 24, 2020 at 12:26:32PM -0500, Chuck Lever wrote:
>     >     >
>     >     >
>     >     >
>     >     > By switching to an XFS-backed export, I am able to reproduce the
>     >     > ibcomp worker crash on my client with xfstests generic/013.
>     >     >
>     >     > For the failing LISTXATTRS operation, xdr_inline_pages() is called
>     >     > with page_len=12 and buflen=128. Then:
>     >     >
>     >     > - Because buflen is small, rpcrdma_marshal_req will not set up a
>     >     >   Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
>     >     >   get invoked at all.
>     >     >
>     >     > - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
>     >     >   copy received data into rq_rcv_buf->pages, but they're missing.
>     >     >
>     >     > The result is that the ibcomp worker faults and dies. Sometimes that
>     >     > causes a visible crash, and sometimes it results in a transport
>     >     > hang without other symptoms.
>     >     >
>     >     > RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
>     >     > should eventually be fixed or replaced. However, my preference is
>     >     > that upper-layer operations should explicitly allocate their receive
>     >     > buffers (using GFP_KERNEL) when possible, rather than relying on
>     >     > XDRBUF_SPARSE_PAGES.
>     >     >
>     >     > Reported-by: Olga kornievskaia <kolga@netapp.com>
>     >     > Suggested-by: Olga kornievskaia <kolga@netapp.com>
>     >     > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>     >     > ---
>     >     >  fs/nfs/nfs42proc.c |   17 ++++++++++-------
>     >     >  fs/nfs/nfs42xdr.c  |    1 -
>     >     >  2 files changed, 10 insertions(+), 8 deletions(-)
>     >     >
>     >     > Hi-
>     >     >
>     >     > I like Olga's proposed approach. What do you think of this patch?
>     >     >
>     >     >
>     >     > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>     >     > index 2b2211d1234e..24810305ec1c 100644
>     >     > --- a/fs/nfs/nfs42proc.c
>     >     > +++ b/fs/nfs/nfs42proc.c
>     >     > @@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>     >     >                 .rpc_resp       = &res,
>     >     >         };
>     >     >         u32 xdrlen;
>     >     > -       int ret, np;
>     >     > +       int ret, np, i;
>     >     >
>     >     >
>     >     >         res.scratch = alloc_page(GFP_KERNEL);
>     >     > @@ -1253,10 +1253,14 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>     >     >                 xdrlen = server->lxasize;
>     >     >         np = xdrlen / PAGE_SIZE + 1;
>     >     >
>     >     > +       ret = -ENOMEM;
>     >     >         pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
>     >     > -       if (pages == NULL) {
>     >     > -               __free_page(res.scratch);
>     >     > -               return -ENOMEM;
>     >     > +       if (pages == NULL)
>     >     > +               goto out_free;
>     >     > +       for (i = 0; i < np; i++) {
>     >     > +               pages[i] = alloc_page(GFP_KERNEL);
>     >     > +               if (!pages[i])
>     >     > +                       goto out_free;
>     >     >         }
>     >     >
>     >     >         arg.xattr_pages = pages;
>     >     > @@ -1271,14 +1275,13 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>     >     >                 *eofp = res.eof;
>     >     >         }
>     >     >
>     >     > +out_free:
>     >     >         while (--np >= 0) {
>     >     >                 if (pages[np])
>     >     >                         __free_page(pages[np]);
>     >     >         }
>     >     > -
>     >     > -       __free_page(res.scratch);
>     >     >         kfree(pages);
>     >     > -
>     >     > +       __free_page(res.scratch);
>     >     >         return ret;
>     >     >
>     >     >  }
>     >     > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
>     >     > index 6e060a88f98c..8432bd6b95f0 100644
>     >     > --- a/fs/nfs/nfs42xdr.c
>     >     > +++ b/fs/nfs/nfs42xdr.c
>     >     > @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
>     >     >
>     >     >         rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
>     >     >             hdr.replen);
>     >     > -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
>     >     >
>     >     >         encode_nops(&hdr);
>     >     >  }
>     >     >
>     >     >
>     >
>     >     I can see why this is the simplest and most pragmatic solution, so it's
>     >     fine with me.
>     >
>     >     Why doesn't this happen with getxattr? Do we need to convert that too?
>     >
>     > [olga] I don't know if GETXATTR/SETXATTR works. I'm not sure what tests exercise those operations. I just ran into the fact that generic/013 wasn't passing. And I don't see that it's an xattr specific tests. I'm not sure how it ends up triggering is usage of xattr.
> 
>     I'm attaching the test program I used, it should give things a better workout.
> 
> [olga] I'm not sure if I'm doing something wrong but there are only 2 GETXATTR call on the network trace from running this application and both calls are returning an error (ERR_NOXATTR). Which btw might explain why no problems are seen since no decoding of data is happening. There are lots of SETXATTRs and REMOVEXATTR and there is a LISTXATTR (which btw network trace is marking as malformed so there might something bad there). Anyway...
> 
> This is my initial report: no real exercise of the GETXATTR code as far as I can tell.

True, the test is heavier on the setxattr / listxattr side. And with caching,
you're not going to see a lot of GETXATTR calls. I used the same test program
with caching off, and it works fine, though.

In any case, after converting GETXATTR to pre-allocate pages, I noticed that,
when I disabled caching, I was getting EIO instead of ERANGE back from
calls that test the case of calling getxattr() with a buffer length that
is insufficient. The behavior is somewhat strange - if you, say, set an xattr
of length 59, then calls with lengths 56-59 get -ERANGE from decode_getxattr
(correct), but calls with lengths 53-55 get EIO (should be -ERANGE).

E.g. non-aligned values to rpc_prepare_reply_pages make the RPC call error
out early, even before it gets to decode_getxattr.

I noticed that all other code always seems to specify multiples of PAGE_SIZE
as the length to rpc_prepare_reply_pages. But the code itself suggests that
it certainly *intends* to be prepared to handle any length, aligned or not.

However, apparently, it at least doesn't deal with non-aligned lengths,
making things fail further along down the line.

I need to look at this a bit more.

- Frank
