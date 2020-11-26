Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9BC2C5C9F
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Nov 2020 20:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgKZTdA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Nov 2020 14:33:00 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:3128 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgKZTc7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Nov 2020 14:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606419177; x=1637955177;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=TrkPAT481UeaRHq0GlaP0LeNmuHJIsKYcgcJMvUgXmY=;
  b=dN92riFjO+tONZPzeyU/P09slnfA9ZaxmxqMfE6R+umkAV9BKlbVHFSO
   HcdBzrGwWN/3JHekjxTC11V5YKVuTVeeTCFVluxZxI9LXhVvapXbA1K7u
   ibDEXbdAuxQaS1JK+9xELV46KHXUs3iKaH+fxUdSkem3P1cOqRcTdC9sA
   Y=;
X-IronPort-AV: E=Sophos;i="5.78,373,1599523200"; 
   d="scan'208";a="66264617"
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS
 operation
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 26 Nov 2020 19:32:50 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 2EE23A05E2;
        Thu, 26 Nov 2020 19:32:50 +0000 (UTC)
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.118) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 19:32:48 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 26 Nov 2020 19:32:48 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1A8D4C136A; Thu, 26 Nov 2020 19:32:48 +0000 (UTC)
Date:   Thu, 26 Nov 2020 19:32:48 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20201126193248.GA6578@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
 <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B1CF6271-B168-4571-B8E4-0CAB0A0B40FB@netapp.com>
 <20201124211926.GB14140@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <5571DE63-1276-4AF6-BB8F-EE36878B06E5@netapp.com>
 <20201126002149.GA2339@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B791B088-49C4-42F3-8721-A022027625D3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B791B088-49C4-42F3-8721-A022027625D3@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 26, 2020 at 12:10:21PM -0500, Chuck Lever wrote:
> 
> 
> > On Nov 25, 2020, at 7:21 PM, Frank van der Linden <fllinden@amazon.com> wrote:
> >
> > On Tue, Nov 24, 2020 at 10:40:25PM +0000, Kornievskaia, Olga wrote:
> >>
> >>
> >> ﻿On 11/24/20, 4:20 PM, "Frank van der Linden" <fllinden@amazon.com> wrote:
> >>
> >>    On Tue, Nov 24, 2020 at 08:50:36PM +0000, Kornievskaia, Olga wrote:
> >>>
> >>>
> >>> On 11/24/20, 3:06 PM, "Frank van der Linden" <fllinden@amazon.com> wrote:
> >>>
> >>>    On Tue, Nov 24, 2020 at 12:26:32PM -0500, Chuck Lever wrote:
> >>>>
> >>>>
> >>>>
> >>>> By switching to an XFS-backed export, I am able to reproduce the
> >>>> ibcomp worker crash on my client with xfstests generic/013.
> >>>>
> >>>> For the failing LISTXATTRS operation, xdr_inline_pages() is called
> >>>> with page_len=12 and buflen=128. Then:
> >>>>
> >>>> - Because buflen is small, rpcrdma_marshal_req will not set up a
> >>>>  Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
> >>>>  get invoked at all.
> >>>>
> >>>> - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
> >>>>  copy received data into rq_rcv_buf->pages, but they're missing.
> >>>>
> >>>> The result is that the ibcomp worker faults and dies. Sometimes that
> >>>> causes a visible crash, and sometimes it results in a transport
> >>>> hang without other symptoms.
> >>>>
> >>>> RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
> >>>> should eventually be fixed or replaced. However, my preference is
> >>>> that upper-layer operations should explicitly allocate their receive
> >>>> buffers (using GFP_KERNEL) when possible, rather than relying on
> >>>> XDRBUF_SPARSE_PAGES.
> >>>>
> >>>> Reported-by: Olga kornievskaia <kolga@netapp.com>
> >>>> Suggested-by: Olga kornievskaia <kolga@netapp.com>
> >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>> ---
> >>>> fs/nfs/nfs42proc.c |   17 ++++++++++-------
> >>>> fs/nfs/nfs42xdr.c  |    1 -
> >>>> 2 files changed, 10 insertions(+), 8 deletions(-)
> >>>>
> >>>> Hi-
> >>>>
> >>>> I like Olga's proposed approach. What do you think of this patch?
> >>>>
> >>>>
> >>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> >>>> index 2b2211d1234e..24810305ec1c 100644
> >>>> --- a/fs/nfs/nfs42proc.c
> >>>> +++ b/fs/nfs/nfs42proc.c
> >>>> @@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
> >>>>                .rpc_resp       = &res,
> >>>>        };
> >>>>        u32 xdrlen;
> >>>> -       int ret, np;
> >>>> +       int ret, np, i;
> >>>>
> >>>>
> >>>>        res.scratch = alloc_page(GFP_KERNEL);
> >>>> @@ -1253,10 +1253,14 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
> >>>>                xdrlen = server->lxasize;
> >>>>        np = xdrlen / PAGE_SIZE + 1;
> >>>>
> >>>> +       ret = -ENOMEM;
> >>>>        pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
> >>>> -       if (pages == NULL) {
> >>>> -               __free_page(res.scratch);
> >>>> -               return -ENOMEM;
> >>>> +       if (pages == NULL)
> >>>> +               goto out_free;
> >>>> +       for (i = 0; i < np; i++) {
> >>>> +               pages[i] = alloc_page(GFP_KERNEL);
> >>>> +               if (!pages[i])
> >>>> +                       goto out_free;
> >>>>        }
> >>>>
> >>>>        arg.xattr_pages = pages;
> >>>> @@ -1271,14 +1275,13 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
> >>>>                *eofp = res.eof;
> >>>>        }
> >>>>
> >>>> +out_free:
> >>>>        while (--np >= 0) {
> >>>>                if (pages[np])
> >>>>                        __free_page(pages[np]);
> >>>>        }
> >>>> -
> >>>> -       __free_page(res.scratch);
> >>>>        kfree(pages);
> >>>> -
> >>>> +       __free_page(res.scratch);
> >>>>        return ret;
> >>>>
> >>>> }
> >>>> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> >>>> index 6e060a88f98c..8432bd6b95f0 100644
> >>>> --- a/fs/nfs/nfs42xdr.c
> >>>> +++ b/fs/nfs/nfs42xdr.c
> >>>> @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
> >>>>
> >>>>        rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
> >>>>            hdr.replen);
> >>>> -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
> >>>>
> >>>>        encode_nops(&hdr);
> >>>> }
> >>>>
> >>>>
> >>>
> >>>    I can see why this is the simplest and most pragmatic solution, so it's
> >>>    fine with me.
> >>>
> >>>    Why doesn't this happen with getxattr? Do we need to convert that too?
> >>>
> >>> [olga] I don't know if GETXATTR/SETXATTR works. I'm not sure what tests exercise those operations. I just ran into the fact that generic/013 wasn't passing. And I don't see that it's an xattr specific tests. I'm not sure how it ends up triggering is usage of xattr.
> >>
> >>    I'm attaching the test program I used, it should give things a better workout.
> >>
> >> [olga] I'm not sure if I'm doing something wrong but there are only 2 GETXATTR call on the network trace from running this application and both calls are returning an error (ERR_NOXATTR). Which btw might explain why no problems are seen since no decoding of data is happening. There are lots of SETXATTRs and REMOVEXATTR and there is a LISTXATTR (which btw network trace is marking as malformed so there might something bad there). Anyway...
> >>
> >> This is my initial report: no real exercise of the GETXATTR code as far as I can tell.
> >
> > True, the test is heavier on the setxattr / listxattr side. And with caching,
> > you're not going to see a lot of GETXATTR calls. I used the same test program
> > with caching off, and it works fine, though.
> 
> I unintentionally broke GETXATTR while developing the LISTXATTRS fix,
> and generic/013 rather aggressively informed me that GETXATTR was no
> longer working. There is some test coverage there, fwiw.

Oh, the coverage was good - in my testing I also used a collection of
small unit test programs, and I was the one who made the xattr tests
in xfstests work on NFS.

> 
> 
> > In any case, after converting GETXATTR to pre-allocate pages, I noticed that,
> > when I disabled caching, I was getting EIO instead of ERANGE back from
> > calls that test the case of calling getxattr() with a buffer length that
> > is insufficient.
> 
> Was TCP the underlying RPC transport?

Yes, this was TCP. I have set up rdma over rxe, which I'll test too if I
can get this figured out. It might be a long standing bug in xdr_inline_pages,
as listxattr / getxattr seem to be simply the first ones to pass in a
length that is not page aligned.

It does make some sense to round the length up to PAGE_SIZE, and just check if
the received data fits when decoding, like other calls do. It improves your
chances of getting a result that you can still cache, even if it's too big for
the length that was asked for. E.g. if the result is > requested_length, but
< ROUND_UP(requested_length, PAGE_SIZE), you can cache it, even though you
have to return -ERANGE to the caller.

- Frank
