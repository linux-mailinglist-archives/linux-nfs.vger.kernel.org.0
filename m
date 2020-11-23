Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC952C194D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 00:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgKWXOa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 18:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbgKWXO3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 18:14:29 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF6C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 15:14:27 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id k27so25699128ejs.10
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 15:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqzJi8A5sI/l3TbQhRfs9IyuwvXPrh7Hqnc/5UBuz7A=;
        b=UeoN1wgcYJSq8CojczbNkePVepAE29mXLXQ7bbpODF1FIZuVtoPSM2SemcSOz70JBK
         RcuLcUjk3oDaXFKKWXJ10v90Wxo5+5cnubxqXq8eQCvhN5wcy8Mp4MeJc20ExjHoiTIg
         0vCyX7UgT8h3MZNJhYZmcaihNn45I8RvpeN40CQYmViU0TVVoW6LC/BG5ugYXuY09Lod
         OkFW1y3UQYMKwTPcnIUWP74RCV/luuCGTofv+7CLReM1ZP/XPk2xi49CI3HEbRz87tL4
         YZMu0rVpifj/zPRGgCN/AfcT/mSCw1Vnq/2cH3PeU/P0M2zivRpS3GTQ5HVV7Zo7d0d6
         i8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqzJi8A5sI/l3TbQhRfs9IyuwvXPrh7Hqnc/5UBuz7A=;
        b=C26UkOOZYFlLfk71aIJcf9UD7z3S3mKFW2eJ/uk4fLic0QxRRK0D5JtRkl8xX0qzoe
         7ymzgwiGNewAicVCz5nlBgfz+/aAzqPmBqzLrJKQD6mjQr4Ix8hZL/ocmiOyrF3Mh5mj
         1cU2Tpi06HTw39GChPKep7sqOBGa6rzosRWg6cc++JgSdAsremh7ChimgLlVjU19IwnV
         oFDLQ0SF+BBySxAtIDT/byyt/E9mRirYUOGuAXViKSazs/JB+ik5UQYpoeeD+sYXcGWx
         Xl58qurmy5fe+OehET2APjd6Rt5NTJ0tQ3m3MdFspGnCW62o9o1zq+I/JTf79cn+9x38
         b+Hw==
X-Gm-Message-State: AOAM5338BqxYkGr7Qa62hnNn5CoeLBSnOfz5FxA+WuDaKf8GeSyyrZl/
        ArXgiiRNhrmBWYMZiOcA2juo3MCO5m5JWO8Nl4k=
X-Google-Smtp-Source: ABdhPJx7yYOEnwojH2yV9z8FDxyJCq5gzZcZ9aVCu3toe9B9uCWChMmcX+heU7/1LdZNb/8RUy7AJ3hjrfgKKqE0c/4=
X-Received: by 2002:a17:906:e96:: with SMTP id p22mr1659544ejf.451.1606173265820;
 Mon, 23 Nov 2020 15:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com> <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com> <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com> <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
 <4687FA42-6294-418D-9835-EDE809997AE3@oracle.com> <CAN-5tyEd8iDfEW0WsXyPsoM73tUSAXQgyhAfRbRbRZCem_cwPw@mail.gmail.com>
 <F85397C8-3FFD-4A7F-92E4-DB84D80F6387@oracle.com>
In-Reply-To: <F85397C8-3FFD-4A7F-92E4-DB84D80F6387@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 23 Nov 2020 18:14:14 -0500
Message-ID: <CAN-5tyFe-FBb_UWUmWokotEzNiYj5zJaWiu1oK+54H-1HQRurw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 23, 2020 at 1:09 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Nov 23, 2020, at 12:59 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > On Mon, Nov 23, 2020 at 12:37 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Nov 23, 2020, at 11:42 AM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >>>
> >>> Hi Frank, Chuck,
> >>>
> >>> I would like your option on how LISTXATTR is supposed to work over
> >>> RDMA. Here's my current understanding of why the listxattr is not
> >>> working over the RDMA.
> >>>
> >>> This happens when the listxattr is called with a very small buffer
> >>> size which RDMA wants to send an inline request. I really dont
> >>> understand why, Chuck, you are not seeing any problems with hardware
> >>> as far as I can tell it would have the same problem because the inline
> >>> threshold size would still make this size inline.
> >>> rcprdma_inline_fixup() is trying to write to pages that don't exist.
> >>>
> >>> When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
> >>> will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
> >>> TCP. RDMA doesn't have anything like that.
> >>>
> >>> Question: Should there be code added to RDMA that will do something
> >>> similar when it sees that flag set?
> >>
> >> Isn't the logic in rpcrdma_convert_iovs() allocating those pages?
> >
> > No, rpcrdm_convert_iovs is only called for when you have reply chunks,
> > lists etc but not for the inline messages. What am I missing?
>
> So, then, rpcrdma_marshal_req() is deciding that the LISTXATTRS
> reply is supposed to fit inline. That means rqst->rq_rcv_buf.buflen
> is small.
>
> But if rpcrdma_inline_fixup() is trying to fill pages,
> rqst->rq_rcv_buf.page_len must not be zero? That sounds like the
> LISTXATTRS encoder is not setting up the receive buffer correctly.
>
> The receive buffer's buflen field is supposed to be set to a value
> that is at least as large as page_len, I would think.

Here's what the LISTXATTR code does that I can see:
It allocates pointers to the pages (but no pages). It sets the
page_len to the hdr.replen so yes it's not zero (setting of the value
as far as i know is correct). So for RDMA nothing allocates those
pages because it's an inline request. TCP code will allocate those
pages because the code was added. You keep on saying that you don't
think this is it but I don't know how to prove to you that Kasan's
message of "wild-memory access" means that page wasn't allocated. It's
a bogus address. The page isn't there. Or at least that's how I read
the Kasan's message. I don't know how else to interpret it (but also
know that code never allocates the memory I believe is a strong
argument).

NFS code can't know that request is inline. It does assume something
will allocate that memory but RDMA doesn't allocate memory for the
inline messages.

While I'm not suggesting this is a correct fix but this is a fix that
removes the oops.

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 2b2211d1234e..faab6aedeb42 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1258,6 +1258,15 @@ static ssize_t _nfs42_proc_listxattrs(struct
inode *inode, void *buf,
                __free_page(res.scratch);
                return -ENOMEM;
        }
+       if (buflen < 1024) {
+               int i;
+               for (i = 0; i < np; i++) {
+                       pages[i] = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
+                       if (!pages[i])
+                               return -ENOMEM;
+               }
+       }
+

        arg.xattr_pages = pages;
        arg.count = xdrlen;


Basically since I know that all RDMA less than 1024 (for soft Roce)
will be inline, I need to allocate pages for them. This doesn't
interfere with the TCP mounts as the code checks if pages are
allocated and only allocates them if they are not.

But of course this is not a solution as it's unknown what's the rdma's
inline threshold is at the NFS layer.



> >>> Or, should LISTXATTR be re-written
> >>> to be like READDIR which allocates pages before calling the code.
> >>
> >> AIUI READDIR reads into the directory inode's page cache. I recall
> >> that Frank couldn't do that for LISTXATTR because there's no
> >> similar page cache associated with the xattr listing.
> >>
> >> That said, I would prefer that the *XATTR procedures directly
> >> allocate pages instead of relying on SPARSE_PAGES, which is a hack
> >> IMO. I think it would have to use alloc_page() for that, and then
> >> ensure those pages are released when the call has completed.
> >>
> >> I'm not convinced this is the cause of the problem you're seeing,
> >> though.
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>
