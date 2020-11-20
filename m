Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB22BB0B2
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 17:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgKTQhQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 11:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgKTQhP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 11:37:15 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698CDC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 08:37:15 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id y17so13684409ejh.11
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hmzVi/1tRzI/XsCObCxtmJX1bXq9juzVe+g+q89mus=;
        b=n1i0MGGDLPTvws0+c/x16YfZLzjXPac+TeZw7S/HmszfG9bCpdFHPQif+CvpnGk3uL
         9GH5rxxALwwC1e8uklfDutkudKIGUO7hVvs0DNRi6ZZx8OXnKhVq9LkVhdQQ8nkS3cNj
         x9bZZ/+f6Z4SH6gUveEZU88Hrt9J7IBb2v584/qTwtpFdUlkKd+H72l/Qwvk3tcPg5th
         FfrNYat35vnDXpsIYHHJe3kPbwS5LgO1lgxRpt4eqdYNHjoxa3is/4rMZMhCuq2LiDsP
         T9bvkE1wzjmYHVIaCyWmss+9Ds05eNBTteiZHosBbFzS8DUrAJWqlhYy5TkJmE6wdD4W
         yq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hmzVi/1tRzI/XsCObCxtmJX1bXq9juzVe+g+q89mus=;
        b=nWwEcR1CywmPJNB/DuGpSe3IetF9oeJaD/gBfUMq6hH/YHhDB91x9s3Sv7cyaQCWnV
         /kngfMvWxty1UUIE7m5JruiRQ/zPmMItRVV/FUx2ALZ93u0vNJPHVmleqqK3ZkTZ8K87
         IEMUzyIWDTPK0WzpCGOJ5FF1FhPFdnw4Kk+6dALaFYtmqdmu3kNe8DJIOjjLQKko4Gx4
         xRu72XVvdMu+fipg/RO1oIX6ROjk9jiRjFVuXixQ6Ae4ttSWJOnnguIKo2jSRlWsO7V3
         si/xGYrEFqD0sTE1+I+yn0VIYRmb5eX/jSANWggxitSgc7t+dsJ4rKS36mqnL8aVYFW0
         3AeA==
X-Gm-Message-State: AOAM530FqhYHMi7KITFU7R1K+dRwwCvLvnVi3Us8e/gvhUcT/4zCkYWt
        ssmqDYC3fGDtfTN0953i/jNSip9mfjDrWdDWxYM=
X-Google-Smtp-Source: ABdhPJx0tB49LEamjkHeInnZxvKxPjwfrh+H5EMfRbct5H29F4atAISvk3D9I0/N5JMZZ8o7PqulIJgSpXX5iayY814=
X-Received: by 2002:a17:906:14cd:: with SMTP id y13mr15333162ejc.510.1605890233963;
 Fri, 20 Nov 2020 08:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com> <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com> <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com> <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 20 Nov 2020 11:37:02 -0500
Message-ID: <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 19, 2020 at 6:26 PM Frank van der Linden
<fllinden@amazon.com> wrote:
>
> On Thu, Nov 19, 2020 at 11:19:05AM -0500, Chuck Lever wrote:
> > > On Nov 19, 2020, at 10:09 AM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> > >
> > > On Thu, Nov 19, 2020 at 9:37 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> > >>
> > >> Hi Olga-
> > >>
> > >>> On Nov 18, 2020, at 4:44 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> > >>>
> > >>> Hi Chuck,
> > >>>
> > >>> The first problem I found was from 5.10-rc3 testing was from the fact
> > >>> that tail's iov_len was set to -4 and reply_chunk was trying to call
> > >>> rpcrdma_convert_kvec() for a tail that didn't exist.
> > >>>
> > >>> Do you see issues with this fix?
> > >>>
> > >>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > >>> index 71e03b930b70..2e6a228abb95 100644
> > >>> --- a/net/sunrpc/xdr.c
> > >>> +++ b/net/sunrpc/xdr.c
> > >>> @@ -193,7 +193,7 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned int offset,
> > >>>
> > >>>       tail->iov_base = buf + offset;
> > >>>       tail->iov_len = buflen - offset;
> > >>> -       if ((xdr->page_len & 3) == 0)
> > >>> +       if ((xdr->page_len & 3) == 0 && tail->iov_len)
> > >>>               tail->iov_len -= sizeof(__be32);
> > >>>
> > >>>       xdr->buflen += len;
> > >>
> > >> It's not clear to me whether only the listxattrs encoder is
> > >> not providing a receive tail kvec, or whether all the encoders
> > >> fail to provide a tail in this case.
> > >
> > > There is nothing specific that listxattr does, it just calls
> > > rpc_prepare_pages(). Isn't tail[0] always there (xdr_buf structure has
> > > tail[1] defined)?
> >
> > Flip the question on its head: Why does xdr_inline_pages() work
> > fine for all the other operations? That suggests the problem is
> > with listxattrs, not with generic code.
> >
> >
> > > But not all requests have data in the page. So as
> > > far as I understand, tail->iov_len can be 0 so not checking for it is
> > > wrong.
> >
> > The full context of the tail logic is:
> >
> >  194         tail->iov_base = buf + offset;
> >  195         tail->iov_len = buflen - offset;
> >  196         if ((xdr->page_len & 3) == 0)
> >  197                 tail->iov_len -= sizeof(__be32);
> >
> > tail->iov_len is set to buflen - offset right here. It should
> > /always/ be 4 or more. We can ensure that because the input
> > to this function is always provided by another kernel function
> > (in other words, we control all the callers).
> >
> > Why is buflen == offset for listxattrs? 6c2190b3fcbc ("NFS:
> > Fix listxattr receive buffer size") is trying to ensure
> > tail->iov_len is not zero -- that the math here gives us a
> > positive value every time.
> >
> > In nfs4_xdr_enc_listxattrs() we have:
> >
> > 1529         rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
> > 1530             hdr.replen);
> >
> > hdr.replen is set to NFS4_dec_listxattrs_sz.
> >
> > _nfs42_proc_listxattrs() sets args->count.
> >
> > I suspect the problem is the way _nfs42_proc_listxattrs() is
> > computing the length of xattr_pages. It includes the trailing
> > EOF boolean, but so does the decode_listxattrs_maxsz macro,
> > for instance.
> >
> > We need head->iov_len to always be one XDR_UNIT larger than
> > the position where the xattr_pages array starts. Then the
> > math in xdr_inline_pages() will work correctly. (sidebar:
> > perhaps the documenting comment for xdr_inline_pages() should
> > explain that assumption).
> >
> > So, now I agree with the assessment that 6c2190b3fcbc ("NFS:
> > Fix listxattr receive buffer size") is probably not adequate.
> > There is another subtlety to address in the way that
> > _nfs42_proc_listxattrs() computes args->count.
>
> The only thing I see wrong so far is that I believe that
> decode_listxattrs_maxsz is wrong - it shouldn't include the EOF
> word, which is accounted for in the page data part.
>
> But, it seems that this wouldn't cause the above problem. I'm
> also uncertain why this happens with RDMA, but not otherwise.
> Unfortunately, I can't test RDMA, but when I ran listxattr tests,
> I did so with KASAN enabled, and didn't see issues.

There isn't nothing special to run tests on RDMA, you just need to
compile the RXE driver and the rdma-core package have everything you
need to run soft Roce (or soft iwarp). This is how I'm testing.

> Obviously there could be a bug here, it could be that the code
> just gets lucky, but that the bug is exposed on RDMA.
>
> Is there a specific size passed to listxattr that this happens with?

First let me answer the last question, I'm running xfstest generic/013.

The latest update: updated to Trond's origing/testing which is now
based on 5.10-rc4.

1. I don't see the oops during the encoding of the listxattr
2. I'm still seeing the oops during the rdma completion. This happens
in the following scenario. Normally, there is a request for listxattr
which passes in buflen of 65536. This translates into rdma request
with a reply chunk with 2 segments. But during failure there is a
request for listxattr which passes buflen of only 8bytes. This
translates into rdma inline request which later oops in
rpcrdma_inline_fixup.

What I would like to know: (1) should _nf42_proc_listxattrs() be doing
some kind of sanity checking for passed in buflen? (2) but of course
I'm assuming even if passed in buffer is small the code shouldn't be
oops-ing.

>
> - Frank
