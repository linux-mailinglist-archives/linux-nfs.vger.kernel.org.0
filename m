Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358332C3262
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 22:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgKXVOY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 16:14:24 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:51358 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgKXVOX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 16:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606252463; x=1637788463;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=rH+Y8HW6Z0VW1dsGZMCcCHnlayU08zxnTumBkVz3yuE=;
  b=BSxfEYbt72mlt7qkbKjVu87/f93++AtTNR9sbpiBXStEpUEkWhvX51bF
   lFUUuoac6fEAlvfRzVgn/9NiXZZwOJKpknoGFXs3tWOwo1C3/GsDHw8Ik
   DE94aFEMVwxCtxAsqHE7MTkY8QXbjX6ZZgyU/4DMrxZX8heyaFfdDA68/
   Q=;
X-IronPort-AV: E=Sophos;i="5.78,367,1599523200"; 
   d="scan'208";a="90556246"
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS
 operation
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 24 Nov 2020 21:14:07 +0000
Received: from EX13MTAUEB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id CC8EEA48D8;
        Tue, 24 Nov 2020 21:14:05 +0000 (UTC)
Received: from EX13D28UEB001.ant.amazon.com (10.43.60.81) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Nov 2020 21:14:04 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D28UEB001.ant.amazon.com (10.43.60.81) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Nov 2020 21:14:04 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 24 Nov 2020 21:14:04 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id E86C3C133E; Tue, 24 Nov 2020 21:14:03 +0000 (UTC)
Date:   Tue, 24 Nov 2020 21:14:03 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20201124211403.GA14140@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
 <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <10EFE633-374C-4BB1-8877-424579564C55@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10EFE633-374C-4BB1-8877-424579564C55@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 03:18:55PM -0500, Chuck Lever wrote:
> > On Nov 24, 2020, at 3:06 PM, Frank van der Linden <fllinden@amazon.com> wrote:
> >
> > On Tue, Nov 24, 2020 at 12:26:32PM -0500, Chuck Lever wrote:
> >> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> >>
> >>
> >>
> >> By switching to an XFS-backed export, I am able to reproduce the
> >> ibcomp worker crash on my client with xfstests generic/013.
> >>
> >> For the failing LISTXATTRS operation, xdr_inline_pages() is called
> >> with page_len=12 and buflen=128. Then:
> >>
> >> - Because buflen is small, rpcrdma_marshal_req will not set up a
> >>  Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
> >>  get invoked at all.
> >>
> >> - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
> >>  copy received data into rq_rcv_buf->pages, but they're missing.
> >>
> >> The result is that the ibcomp worker faults and dies. Sometimes that
> >> causes a visible crash, and sometimes it results in a transport
> >> hang without other symptoms.
> >>
> >> RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
> >> should eventually be fixed or replaced. However, my preference is
> >> that upper-layer operations should explicitly allocate their receive
> >> buffers (using GFP_KERNEL) when possible, rather than relying on
> >> XDRBUF_SPARSE_PAGES.
> >>
> >> Reported-by: Olga kornievskaia <kolga@netapp.com>
> >> Suggested-by: Olga kornievskaia <kolga@netapp.com>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> fs/nfs/nfs42proc.c |   17 ++++++++++-------
> >> fs/nfs/nfs42xdr.c  |    1 -
> >> 2 files changed, 10 insertions(+), 8 deletions(-)
> >>
> >> Hi-
> >>
> >> I like Olga's proposed approach. What do you think of this patch?
> >>
> >>
> >> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> >> index 2b2211d1234e..24810305ec1c 100644
> >> --- a/fs/nfs/nfs42proc.c
> >> +++ b/fs/nfs/nfs42proc.c
> >> @@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
> >>                .rpc_resp       = &res,
> >>        };
> >>        u32 xdrlen;
> >> -       int ret, np;
> >> +       int ret, np, i;
> >>
> >>
> >>        res.scratch = alloc_page(GFP_KERNEL);
> >> @@ -1253,10 +1253,14 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
> >>                xdrlen = server->lxasize;
> >>        np = xdrlen / PAGE_SIZE + 1;
> >>
> >> +       ret = -ENOMEM;
> >>        pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
> >> -       if (pages == NULL) {
> >> -               __free_page(res.scratch);
> >> -               return -ENOMEM;
> >> +       if (pages == NULL)
> >> +               goto out_free;
> >> +       for (i = 0; i < np; i++) {
> >> +               pages[i] = alloc_page(GFP_KERNEL);
> >> +               if (!pages[i])
> >> +                       goto out_free;
> >>        }
> >>
> >>        arg.xattr_pages = pages;
> >> @@ -1271,14 +1275,13 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
> >>                *eofp = res.eof;
> >>        }
> >>
> >> +out_free:
> >>        while (--np >= 0) {
> >>                if (pages[np])
> >>                        __free_page(pages[np]);
> >>        }
> >> -
> >> -       __free_page(res.scratch);
> >>        kfree(pages);
> >> -
> >> +       __free_page(res.scratch);
> >>        return ret;
> >>
> >> }
> >> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> >> index 6e060a88f98c..8432bd6b95f0 100644
> >> --- a/fs/nfs/nfs42xdr.c
> >> +++ b/fs/nfs/nfs42xdr.c
> >> @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
> >>
> >>        rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
> >>            hdr.replen);
> >> -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
> >>
> >>        encode_nops(&hdr);
> >> }
> >>
> >>
> >
> > I can see why this is the simplest and most pragmatic solution, so it's
> > fine with me.
> 
> Thanks. I've added Olga's Reviewed/Tested-by to my local copy.
> May I add a Reviewed-by from you?

Yep, thanks.

> > Why doesn't this happen with getxattr? Do we need to convert that too?
> 
> If a GETXATTR request can be generated such that buflen is less than
> a page, but page_len > 0, then yes, it will happen there too. As Olga
> says, NFS is unaware of the transport's inline threshold setting, so
> there will always be some buflen value under which bad things happen.
> 
> Either way, I would prefer to see GETXATTR converted to avoid using
> XDRBUF_SPARSE_PAGES. Does NFSv4 GETACL provide a good example?

Hm, in that case, it should be converted. That's easy enough to do.
I'll send a small patch.

> 
> 
> > The basic issue here is that the RPC code does not deal with inlined data
> > that exceeds PAGE_SIZE. That can only be done with raw pages.
> >
> > Since the upper layer has already allocated a buffer in the case of listxattr
> > and getxattr, I would love to be able to just XDR code in to that buffer,
> > and void the whole alloc+copy situation.
> 
> Do you mean like the READDIR entry encoders and decoders?

It works out for READDIR - you use page cache fillers that do the XDR
decoding in to pages that are part of i_mapping. For xattrs, that's
not a good fit - I looked at it, but it would have been messy.

The main thing I'm complaining about here is that the upper-layer xattr
code already kvallocs a buffer, but because of restrictions in the XDR
code, you always end up doing an extra copy for get/set, since you need
to allocate pages. But, this doesn't apply to listxattr.


> 
> 
> > But sadly, it might be > PAGE_SIZE,
> > so the XDR code doesn't allow it. It's not all bad, having to use pages
> > allows them to be directly hooked in to the cache in the case of getxattr,
> > but for listxattr, decoding directly in to the provided buffer would be nice.
> >
> > Hm, I wonder if that restriction actually holds for listxattr - the invidual
> > XDR items (xattr names) should never exceed PAGE_SIZE..
> 
> You'll have to worry about XDR data items crossing page boundaries.
> Our XDR code uses a scratch buffer for that, so it can be handled
> transparently.

Yep, and this is what listxattr does. I was confusing the get/set and list
cases, sorry about the confusion.

Let me just quickly convert getxattr.

- Frank
