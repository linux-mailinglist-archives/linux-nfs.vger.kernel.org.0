Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3252C3451
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 00:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgKXXET (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 18:04:19 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:20587 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbgKXXES (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 18:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606259058; x=1637795058;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=1pX7juUYwRwrflSMjms///yTzx0YswXoEMTnDD+uiYo=;
  b=FdBBEqDGLiHOdqf9xEC91aycoFUHpHzwNVAfk+10VkCRUDLq5WL38BDK
   dTU1meudw4/0GMlUPgmqbU6sLHWRZojxkH8y9Bzhk/C0RjYrSRAo5KuVr
   ZkQaVVusBF+z0pjmVrFYcNbQ+oOYq7jbrRZBF/+oI+Pd58Zoe6efA+W7j
   k=;
X-IronPort-AV: E=Sophos;i="5.78,367,1599523200"; 
   d="scan'208";a="98851586"
Subject: Re: [PATCH v2] NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS
 operation
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 24 Nov 2020 23:04:10 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id D1A22A1DE4;
        Tue, 24 Nov 2020 23:04:08 +0000 (UTC)
Received: from EX13D44UWC002.ant.amazon.com (10.43.162.169) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Nov 2020 23:04:08 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D44UWC002.ant.amazon.com (10.43.162.169) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Nov 2020 23:04:08 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 24 Nov 2020 23:04:08 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 57265C1357; Tue, 24 Nov 2020 23:04:07 +0000 (UTC)
Date:   Tue, 24 Nov 2020 23:04:07 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <trondmy@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
Message-ID: <20201124230407.GA26977@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <160625644245.1700.17147462039179289248.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <160625644245.1700.17147462039179289248.stgit@manet.1015granger.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 05:21:47PM -0500, Chuck Lever wrote:
> 
> 
> By switching to an XFS-backed export, I am able to reproduce the
> ibcomp worker crash on my client with xfstests generic/013.
> 
> For the failing LISTXATTRS operation, xdr_inline_pages() is called
> with page_len=12 and buflen=128.
> 
> - When ->send_request() is called, rpcrdma_marshal_req() does not
>   set up a Reply chunk because buflen is smaller than the inline
>   threshold. Thus rpcrdma_convert_iovs() does not get invoked at
>   all and the transport's XDRBUF_SPARSE_PAGES logic is not invoked
>   on the receive buffer.
> 
> - During reply processing, rpcrdma_inline_fixup() tries to copy
>   received data into rq_rcv_buf->pages because page_len is positive.
>   But there are no receive pages because rpcrdma_marshal_req() never
>   allocated them.
> 
> The result is that the ibcomp worker faults and dies. Sometimes that
> causes a visible crash, and sometimes it results in a transport hang
> without other symptoms.
> 
> RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
> should eventually be fixed or replaced. However, my preference is
> that upper-layer operations should explicitly allocate their receive
> buffers (using GFP_KERNEL) when possible, rather than relying on
> XDRBUF_SPARSE_PAGES.
> 
> Reported-by: Olga kornievskaia <kolga@netapp.com>
> Suggested-by: Olga kornievskaia <kolga@netapp.com>
> Fixes: c10a75145feb ("NFSv4.2: add the extended attribute proc functions.")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Olga kornievskaia <kolga@netapp.com>
> Reviewed-by: Frank van der Linden <fllinden@amazon.com>
> Tested-by: Olga kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs42proc.c |   17 ++++++++++-------
>  fs/nfs/nfs42xdr.c  |    1 -
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> Changes since v1:
> - Added a Fixes: tag
> - Added Reviewed-by:, etc tags
> - Clarified the patch description
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

I missed this in v1 - if you use goto out_free after failing to allocate
the pages array, this will still try to use it when trying to free the
individual pages. Looks like you'll need a second label to goto at the
end for the pages == NULL case.

- Frank
