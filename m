Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760B72C10FA
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 17:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390170AbgKWQnA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 11:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389975AbgKWQm7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 11:42:59 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C98C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 08:42:59 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id k9so9413485ejc.11
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 08:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jGMgHPcqG9Dok0jvc5pmiqDVwj1WN6GHZGMzF7Pefk=;
        b=YI55/TpWVVfnkMOaxMB56nuQw20BPPvEI3LnO/6bPKpdjLH598YDA8f6ibX7sx54bO
         O6cRnuGlkHG4F0wTMshX12C85VdBHJw7ldf89r0rJ8P74G9S87NQNDRT/b8Di0vxO2sD
         XzUu9PStn2ezWHR7//f176rWNsuniD1PbxGUDJIOZ8iEKQZFlbwIFb7U3DnRYxkYTA68
         1Pdl46tMu7a3bBTnaXWCDdhipdwuTs778Yh5+RF9LIKLejc4k8QKNBRW17y5LtAncWK1
         bTERO9twwBJpSt2E2dF3N5iOl+sXiQF3JmOyT8idox+X68UbqahhTIELV2TuU0PN13Bp
         +Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jGMgHPcqG9Dok0jvc5pmiqDVwj1WN6GHZGMzF7Pefk=;
        b=BH6Ri66+uTCfjCZDwOO6BXgn6ZbYKsEd+efEoNh+V/jF0sEhjsT+5p2UxwRYMz6/dR
         HO7qfXFVI4L2EnOOYiwtCU5PbUYae9ZMdIFEI98DnGGGLoHMGdwIv/Y/G9Wy7VTcfsni
         qTmH1yjWb8rdv2lOI02ilbHVNRodLW5I6W7dpM6YXNfSOEPHo2w9bAVS9zI694dsFX3k
         I8pV/YZp0pKRp7ii4JKAj8iH2n5a4iIwIBcHnSqBvFB5KB1bqA/dBfoT/0kZ+gTH4CAD
         QyCk0F/XLlYJ0HcNjzIqSTVUmsKPotNbtT+MsRd6pECuXlw1o8E17qIIHx06aK7opbQh
         Qqkg==
X-Gm-Message-State: AOAM532dfSwxlcyxbH0lOXBCyJNjTK6Rzoy3tmYQ6rMZrF3X58Oz9EUq
        Xk+phNPHcz174sX9z8AzvSvXMOwEgpXEAzV+9p1KZO8mzVU=
X-Google-Smtp-Source: ABdhPJx0o+CjSx4Qy7b2JZ9szHar4TB65xGDyE4NiM/JZ4Kr0X64xqFTlWNBokY0lqeX2pcrF+Cq9yF+NNScpmcLA/Q=
X-Received: by 2002:a17:906:1918:: with SMTP id a24mr429611eje.432.1606149777853;
 Mon, 23 Nov 2020 08:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com> <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com> <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com> <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
In-Reply-To: <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 23 Nov 2020 11:42:46 -0500
Message-ID: <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
To:     Frank van der Linden <fllinden@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Frank, Chuck,

I would like your option on how LISTXATTR is supposed to work over
RDMA. Here's my current understanding of why the listxattr is not
working over the RDMA.

This happens when the listxattr is called with a very small buffer
size which RDMA wants to send an inline request. I really dont
understand why, Chuck, you are not seeing any problems with hardware
as far as I can tell it would have the same problem because the inline
threshold size would still make this size inline.
rcprdma_inline_fixup() is trying to write to pages that don't exist.

When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
TCP. RDMA doesn't have anything like that.

Question: Should there be code added to RDMA that will do something
similar when it sees that flag set? Or, should LISTXATTR be re-written
to be like READDIR which allocates pages before calling the code.

On Fri, Nov 20, 2020 at 11:37 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 6:26 PM Frank van der Linden
> <fllinden@amazon.com> wrote:
> >
> > On Thu, Nov 19, 2020 at 11:19:05AM -0500, Chuck Lever wrote:
> > > > On Nov 19, 2020, at 10:09 AM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> > > >
> > > > On Thu, Nov 19, 2020 at 9:37 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> > > >>
> > > >> Hi Olga-
> > > >>
> > > >>> On Nov 18, 2020, at 4:44 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> > > >>>
> > > >>> Hi Chuck,
> > > >>>
> > > >>> The first problem I found was from 5.10-rc3 testing was from the fact
> > > >>> that tail's iov_len was set to -4 and reply_chunk was trying to call
> > > >>> rpcrdma_convert_kvec() for a tail that didn't exist.
> > > >>>
> > > >>> Do you see issues with this fix?
> > > >>>
> > > >>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > > >>> index 71e03b930b70..2e6a228abb95 100644
> > > >>> --- a/net/sunrpc/xdr.c
> > > >>> +++ b/net/sunrpc/xdr.c
> > > >>> @@ -193,7 +193,7 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned int offset,
> > > >>>
> > > >>>       tail->iov_base = buf + offset;
> > > >>>       tail->iov_len = buflen - offset;
> > > >>> -       if ((xdr->page_len & 3) == 0)
> > > >>> +       if ((xdr->page_len & 3) == 0 && tail->iov_len)
> > > >>>               tail->iov_len -= sizeof(__be32);
> > > >>>
> > > >>>       xdr->buflen += len;
> > > >>
> > > >> It's not clear to me whether only the listxattrs encoder is
> > > >> not providing a receive tail kvec, or whether all the encoders
> > > >> fail to provide a tail in this case.
> > > >
> > > > There is nothing specific that listxattr does, it just calls
> > > > rpc_prepare_pages(). Isn't tail[0] always there (xdr_buf structure has
> > > > tail[1] defined)?
> > >
> > > Flip the question on its head: Why does xdr_inline_pages() work
> > > fine for all the other operations? That suggests the problem is
> > > with listxattrs, not with generic code.
> > >
> > >
> > > > But not all requests have data in the page. So as
> > > > far as I understand, tail->iov_len can be 0 so not checking for it is
> > > > wrong.
> > >
> > > The full context of the tail logic is:
> > >
> > >  194         tail->iov_base = buf + offset;
> > >  195         tail->iov_len = buflen - offset;
> > >  196         if ((xdr->page_len & 3) == 0)
> > >  197                 tail->iov_len -= sizeof(__be32);
> > >
> > > tail->iov_len is set to buflen - offset right here. It should
> > > /always/ be 4 or more. We can ensure that because the input
> > > to this function is always provided by another kernel function
> > > (in other words, we control all the callers).
> > >
> > > Why is buflen == offset for listxattrs? 6c2190b3fcbc ("NFS:
> > > Fix listxattr receive buffer size") is trying to ensure
> > > tail->iov_len is not zero -- that the math here gives us a
> > > positive value every time.
> > >
> > > In nfs4_xdr_enc_listxattrs() we have:
> > >
> > > 1529         rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
> > > 1530             hdr.replen);
> > >
> > > hdr.replen is set to NFS4_dec_listxattrs_sz.
> > >
> > > _nfs42_proc_listxattrs() sets args->count.
> > >
> > > I suspect the problem is the way _nfs42_proc_listxattrs() is
> > > computing the length of xattr_pages. It includes the trailing
> > > EOF boolean, but so does the decode_listxattrs_maxsz macro,
> > > for instance.
> > >
> > > We need head->iov_len to always be one XDR_UNIT larger than
> > > the position where the xattr_pages array starts. Then the
> > > math in xdr_inline_pages() will work correctly. (sidebar:
> > > perhaps the documenting comment for xdr_inline_pages() should
> > > explain that assumption).
> > >
> > > So, now I agree with the assessment that 6c2190b3fcbc ("NFS:
> > > Fix listxattr receive buffer size") is probably not adequate.
> > > There is another subtlety to address in the way that
> > > _nfs42_proc_listxattrs() computes args->count.
> >
> > The only thing I see wrong so far is that I believe that
> > decode_listxattrs_maxsz is wrong - it shouldn't include the EOF
> > word, which is accounted for in the page data part.
> >
> > But, it seems that this wouldn't cause the above problem. I'm
> > also uncertain why this happens with RDMA, but not otherwise.
> > Unfortunately, I can't test RDMA, but when I ran listxattr tests,
> > I did so with KASAN enabled, and didn't see issues.
>
> There isn't nothing special to run tests on RDMA, you just need to
> compile the RXE driver and the rdma-core package have everything you
> need to run soft Roce (or soft iwarp). This is how I'm testing.
>
> > Obviously there could be a bug here, it could be that the code
> > just gets lucky, but that the bug is exposed on RDMA.
> >
> > Is there a specific size passed to listxattr that this happens with?
>
> First let me answer the last question, I'm running xfstest generic/013.
>
> The latest update: updated to Trond's origing/testing which is now
> based on 5.10-rc4.
>
> 1. I don't see the oops during the encoding of the listxattr
> 2. I'm still seeing the oops during the rdma completion. This happens
> in the following scenario. Normally, there is a request for listxattr
> which passes in buflen of 65536. This translates into rdma request
> with a reply chunk with 2 segments. But during failure there is a
> request for listxattr which passes buflen of only 8bytes. This
> translates into rdma inline request which later oops in
> rpcrdma_inline_fixup.
>
> What I would like to know: (1) should _nf42_proc_listxattrs() be doing
> some kind of sanity checking for passed in buflen? (2) but of course
> I'm assuming even if passed in buffer is small the code shouldn't be
> oops-ing.
>
> >
> > - Frank
