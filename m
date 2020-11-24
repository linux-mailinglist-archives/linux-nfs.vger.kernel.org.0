Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFC2C31AD
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 21:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgKXUGv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 15:06:51 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:13159 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgKXUGv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 15:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606248411; x=1637784411;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=6+85ndIY+Mt46znb8PshLbDJvgm6Q6Mm/bRNp6T8MMU=;
  b=lPeyDrGWzDAE+9OjjeTZC2DfE5Bfh+2Mf8ycUr2miIoNuBcaWTRBH2rd
   MY/hKrK4Tssah35s8zfaDjDiVPDpvWD04lTurTXxoboRcJ4GAihP2Xw1b
   dZpGZoSzUfwkvep3Gd0+KofKx9fxJLmk9+dYaLALH7eDojV5QhsUh8BRc
   Q=;
X-IronPort-AV: E=Sophos;i="5.78,366,1599523200"; 
   d="scan'208";a="97532490"
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS
 operation
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 24 Nov 2020 20:06:44 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 5389EA244E;
        Tue, 24 Nov 2020 20:06:41 +0000 (UTC)
Received: from EX13D11UWC001.ant.amazon.com (10.43.162.151) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Nov 2020 20:06:41 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D11UWC001.ant.amazon.com (10.43.162.151) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Nov 2020 20:06:41 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 24 Nov 2020 20:06:41 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 7D87BC1392; Tue, 24 Nov 2020 20:06:41 +0000 (UTC)
Date:   Tue, 24 Nov 2020 20:06:41 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <kolga@netapp.com>, <linux-nfs@vger.kernel.org>
Message-ID: <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 12:26:32PM -0500, Chuck Lever wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> By switching to an XFS-backed export, I am able to reproduce the
> ibcomp worker crash on my client with xfstests generic/013.
> 
> For the failing LISTXATTRS operation, xdr_inline_pages() is called
> with page_len=12 and buflen=128. Then:
> 
> - Because buflen is small, rpcrdma_marshal_req will not set up a
>   Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
>   get invoked at all.
> 
> - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
>   copy received data into rq_rcv_buf->pages, but they're missing.
> 
> The result is that the ibcomp worker faults and dies. Sometimes that
> causes a visible crash, and sometimes it results in a transport
> hang without other symptoms.
> 
> RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
> should eventually be fixed or replaced. However, my preference is
> that upper-layer operations should explicitly allocate their receive
> buffers (using GFP_KERNEL) when possible, rather than relying on
> XDRBUF_SPARSE_PAGES.
> 
> Reported-by: Olga kornievskaia <kolga@netapp.com>
> Suggested-by: Olga kornievskaia <kolga@netapp.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfs42proc.c |   17 ++++++++++-------
>  fs/nfs/nfs42xdr.c  |    1 -
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> Hi-
> 
> I like Olga's proposed approach. What do you think of this patch?
> 
> 
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 2b2211d1234e..24810305ec1c 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>                 .rpc_resp       = &res,
>         };
>         u32 xdrlen;
> -       int ret, np;
> +       int ret, np, i;
> 
> 
>         res.scratch = alloc_page(GFP_KERNEL);
> @@ -1253,10 +1253,14 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>                 xdrlen = server->lxasize;
>         np = xdrlen / PAGE_SIZE + 1;
> 
> +       ret = -ENOMEM;
>         pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
> -       if (pages == NULL) {
> -               __free_page(res.scratch);
> -               return -ENOMEM;
> +       if (pages == NULL)
> +               goto out_free;
> +       for (i = 0; i < np; i++) {
> +               pages[i] = alloc_page(GFP_KERNEL);
> +               if (!pages[i])
> +                       goto out_free;
>         }
> 
>         arg.xattr_pages = pages;
> @@ -1271,14 +1275,13 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>                 *eofp = res.eof;
>         }
> 
> +out_free:
>         while (--np >= 0) {
>                 if (pages[np])
>                         __free_page(pages[np]);
>         }
> -
> -       __free_page(res.scratch);
>         kfree(pages);
> -
> +       __free_page(res.scratch);
>         return ret;
> 
>  }
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index 6e060a88f98c..8432bd6b95f0 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
> 
>         rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
>             hdr.replen);
> -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
> 
>         encode_nops(&hdr);
>  }
> 
> 

I can see why this is the simplest and most pragmatic solution, so it's
fine with me.

Why doesn't this happen with getxattr? Do we need to convert that too?

The basic issue here is that the RPC code does not deal with inlined data
that exceeds PAGE_SIZE. That can only be done with raw pages. 

Since the upper layer has already allocated a buffer in the case of listxattr
and getxattr, I would love to be able to just XDR code in to that buffer,
and void the whole alloc+copy situation. But sadly, it might be > PAGE_SIZE,
so the XDR code doesn't allow it. It's not all bad, having to use pages
allows them to be directly hooked in to the cache in the case of getxattr,
but for listxattr, decoding directly in to the provided buffer would be nice.

Hm, I wonder if that restriction actually holds for listxattr - the invidual
XDR items (xattr names) should never exceed PAGE_SIZE..

- Frank
