Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492EC2B9E4C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 00:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgKSX0y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 18:26:54 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:47055 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgKSX0y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Nov 2020 18:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605828414; x=1637364414;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=+V8vKuTKM3F9DFqyHGbFoA7iE5hzjYMK4TWRLwU2EDI=;
  b=IespnO7Fc8h7znAhkJAdEGTwHd4fBokRLNFd3hBHQ7CX8tSfDkNzYj0o
   CvaHhftaIKhDG3jN8sZxMkWsXDNW+pfQF5KDckEDLLLKoGzb90FP8dQrL
   eZL4jIBK2JDm5ivQr+WlcFdzzY7usDMSC3YlA2p3n2T7aznjABlXmPF1G
   Q=;
X-IronPort-AV: E=Sophos;i="5.78,354,1599523200"; 
   d="scan'208";a="88936573"
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 19 Nov 2020 23:26:48 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id E2BA7A188A;
        Thu, 19 Nov 2020 23:26:47 +0000 (UTC)
Received: from EX13D23UWA002.ant.amazon.com (10.43.160.40) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 19 Nov 2020 23:26:47 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D23UWA002.ant.amazon.com (10.43.160.40) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 19 Nov 2020 23:26:47 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 19 Nov 2020 23:26:46 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 22DBAC67FD; Thu, 19 Nov 2020 23:26:47 +0000 (UTC)
Date:   Thu, 19 Nov 2020 23:26:47 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
 <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
 <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 19, 2020 at 11:19:05AM -0500, Chuck Lever wrote:
> > On Nov 19, 2020, at 10:09 AM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > On Thu, Nov 19, 2020 at 9:37 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >> Hi Olga-
> >>
> >>> On Nov 18, 2020, at 4:44 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >>>
> >>> Hi Chuck,
> >>>
> >>> The first problem I found was from 5.10-rc3 testing was from the fact
> >>> that tail's iov_len was set to -4 and reply_chunk was trying to call
> >>> rpcrdma_convert_kvec() for a tail that didn't exist.
> >>>
> >>> Do you see issues with this fix?
> >>>
> >>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> >>> index 71e03b930b70..2e6a228abb95 100644
> >>> --- a/net/sunrpc/xdr.c
> >>> +++ b/net/sunrpc/xdr.c
> >>> @@ -193,7 +193,7 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned int offset,
> >>>
> >>>       tail->iov_base = buf + offset;
> >>>       tail->iov_len = buflen - offset;
> >>> -       if ((xdr->page_len & 3) == 0)
> >>> +       if ((xdr->page_len & 3) == 0 && tail->iov_len)
> >>>               tail->iov_len -= sizeof(__be32);
> >>>
> >>>       xdr->buflen += len;
> >>
> >> It's not clear to me whether only the listxattrs encoder is
> >> not providing a receive tail kvec, or whether all the encoders
> >> fail to provide a tail in this case.
> >
> > There is nothing specific that listxattr does, it just calls
> > rpc_prepare_pages(). Isn't tail[0] always there (xdr_buf structure has
> > tail[1] defined)?
> 
> Flip the question on its head: Why does xdr_inline_pages() work
> fine for all the other operations? That suggests the problem is
> with listxattrs, not with generic code.
> 
> 
> > But not all requests have data in the page. So as
> > far as I understand, tail->iov_len can be 0 so not checking for it is
> > wrong.
> 
> The full context of the tail logic is:
> 
>  194         tail->iov_base = buf + offset;
>  195         tail->iov_len = buflen - offset;
>  196         if ((xdr->page_len & 3) == 0)
>  197                 tail->iov_len -= sizeof(__be32);
> 
> tail->iov_len is set to buflen - offset right here. It should
> /always/ be 4 or more. We can ensure that because the input
> to this function is always provided by another kernel function
> (in other words, we control all the callers).
> 
> Why is buflen == offset for listxattrs? 6c2190b3fcbc ("NFS:
> Fix listxattr receive buffer size") is trying to ensure
> tail->iov_len is not zero -- that the math here gives us a
> positive value every time.
> 
> In nfs4_xdr_enc_listxattrs() we have:
> 
> 1529         rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
> 1530             hdr.replen);
> 
> hdr.replen is set to NFS4_dec_listxattrs_sz.
> 
> _nfs42_proc_listxattrs() sets args->count.
> 
> I suspect the problem is the way _nfs42_proc_listxattrs() is
> computing the length of xattr_pages. It includes the trailing
> EOF boolean, but so does the decode_listxattrs_maxsz macro,
> for instance.
> 
> We need head->iov_len to always be one XDR_UNIT larger than
> the position where the xattr_pages array starts. Then the
> math in xdr_inline_pages() will work correctly. (sidebar:
> perhaps the documenting comment for xdr_inline_pages() should
> explain that assumption).
> 
> So, now I agree with the assessment that 6c2190b3fcbc ("NFS:
> Fix listxattr receive buffer size") is probably not adequate.
> There is another subtlety to address in the way that
> _nfs42_proc_listxattrs() computes args->count.

The only thing I see wrong so far is that I believe that
decode_listxattrs_maxsz is wrong - it shouldn't include the EOF
word, which is accounted for in the page data part.

But, it seems that this wouldn't cause the above problem. I'm
also uncertain why this happens with RDMA, but not otherwise.
Unfortunately, I can't test RDMA, but when I ran listxattr tests,
I did so with KASAN enabled, and didn't see issues.

Obviously there could be a bug here, it could be that the code
just gets lucky, but that the bug is exposed on RDMA.

Is there a specific size passed to listxattr that this happens with?

- Frank
