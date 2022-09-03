Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15B5ABC98
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 05:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiICDfM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 23:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiICDfL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 23:35:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771F4362A
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 20:35:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e18so4973916edj.3
        for <linux-nfs@vger.kernel.org>; Fri, 02 Sep 2022 20:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9NPnwf0YcDNwVLAp7Apg60ndJm93+ECIz/VNkLfbU1o=;
        b=FPXvRFcZcH14Ac/JFLt8ys9BXl7OjpALFg0FBH3y9oy9fiFw+3QGZu/aWdXgs3ICES
         ksjq6hd77GewP7Dj4SqULPfXqJqcu4wRf8OXbX0s1QB6tsR2iLjW60tbkrurtZL8FspP
         TsZD+l62V/pKepqmHmK1nIV7Er7xGAaeL0e3DYkKLfLhZhzJfLR0ag4kKL/C4ANEjNR0
         TAoP/sKz6lcfrXncPy7TBMe/Cl9ILZsKljSqzeqGI0sAFfm74N++1i0n9sI++aT9G+kQ
         EBUkIO2NUOy81Ep6z6aWYFGdUQkAdDby9jFNvr5JwL7zVd0Ceg2znfsvZNHjR/2rWypH
         O6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9NPnwf0YcDNwVLAp7Apg60ndJm93+ECIz/VNkLfbU1o=;
        b=xw/atDG8Sb2tVCKOozzVZH0xK0W04VFD7UWKUdzG/guYimJq3feMpdFLcgOpIVmBaR
         GU8oiWWSBCNs6WUgShvt3Y5GCOufmOCGqmWpbzYeE3SClbl7M6VotFbq7u6jh9HFPZ1Y
         kkKkwmSPsc/9atXCKt3iYRxYBhbl4eExlz4LONp2TB2a7gH19d6Qk1Xw8r8pWDoT88oX
         SSVMwhHh7lIsHM99CynYqzgIjHgfM7I1+8XEzw8eA9AnWpFZU2l2niZ1bh3dKHVDhJvS
         hpeciesiUWrBBn8gUIeAfmn0soioFkBr7qZrSfh9XmDxtipHC1h1PxaVcJ49pG3Fz2W+
         VaJA==
X-Gm-Message-State: ACgBeo29+ccqIkvlyc7jhI+jA+6h2LqnGs+hV5XL3guk/ArnjinkYwky
        AABBEPamtHSLFfHBHY3/cpON/iia0Tl+P0LO9fM=
X-Google-Smtp-Source: AA6agR7SMwjCWjIvAXkYH+1gbX4LzWzsy4F5BgLNCExdeBcMbs5iW0Di79Zq2X4OXYv1r+WnVsZzpT54kOqT9qRCxnE=
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id
 fj8-20020a0564022b8800b0043a6c586c64mr36038178edb.348.1662176106138; Fri, 02
 Sep 2022 20:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com> <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <6DC1F4DF-8242-480B-813A-5F87D64593A6@redhat.com> <2E6F8E3F-C14C-44C7-8B72-744A5F6E8F7F@oracle.com>
 <1D65FB47-EC61-45FB-972D-D68832B54C47@redhat.com>
In-Reply-To: <1D65FB47-EC61-45FB-972D-D68832B54C47@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 2 Sep 2022 23:34:54 -0400
Message-ID: <CAN-5tyHCuKcUEhBZUmA9VsckaA-Ogr0jsEPriQL8xhXJpc6OUw@mail.gmail.com>
Subject: Re: Is this nfsd kernel oops known?
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

Ok so I won't be trying Ben's idea but I'm sort of confused is the
thought that NFS is somehow at fault in incorrectly using the "new"
code introduced by the new patches. Isn't it possible that the new
patches are wrong? I haven't had time to try and revert the patch(es)
to see if that makes the oops go away. I won't get around to it until
about tuesday with the holidays.

On Fri, Sep 2, 2022 at 8:38 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 2 Sep 2022, at 17:13, Chuck Lever III wrote:
>
> >> On Sep 2, 2022, at 4:58 PM, Benjamin Coddington <bcodding@redhat.com>
> >> wrote:
> >>
> >> Olga, does this fix it up for you?  I'm testing now, but I think it
> >> might be
> >> a little harder for me to hit.
> >>
> >> Ben
> >>
> >> 8<------------------------------------------------
> >> From 6bea39a887495b1748ff3b179d6e2f3d7e552b61 Mon Sep 17 00:00:00
> >> 2001
> >> From: Benjamin Coddington <bcodding@redhat.com>
> >> Date: Fri, 2 Sep 2022 16:49:17 -0400
> >> Subject: [PATCH] SUNRPC: Fix svc_tcp_sendmsg bvec offset calculation
> >>
> >> The xdr_buf's bvec member points to an array of struct bio_vec, let's
> >> fixup the calculation to the start of the bio_vec for non-zero
> >> page_base.
> >>
> >> Fixes: bad4c6eb5eaa ("SUNRPC: Fix NFS READs that start at
> >> non-page-aligned offsets")
> >> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> >> ---
> >> net/sunrpc/svcsock.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> >> index 2fc98fea59b4..ecafc9c4bc5c 100644
> >> --- a/net/sunrpc/svcsock.c
> >> +++ b/net/sunrpc/svcsock.c
> >> @@ -1110,7 +1110,7 @@ static int svc_tcp_sendmsg(struct socket *sock,
> >> struct xdr_buf *xdr,
> >>                unsigned int offset, len, remaining;
> >>                struct bio_vec *bvec;
> >>
> >> -               bvec = xdr->bvec + (xdr->page_base >> PAGE_SHIFT);
> >> +               bvec = &xdr->bvec[xdr->page_base >> PAGE_SHIFT];
> >
> > Color me skeptical.
> >
> > I'm not sure these two expressions are different. This variety
> > of pointer arithmetic is used throughout the XDR layer:
>
> Yeah, you know what - it did crash in the same place with this change.
>
> My thinking was that if you have (for example) page_base = 8192, and
> xdr->bvec of, say 0xffff4500, then what you want is to set the local
> bvec var
> to 0xfff4500 + sizeof(struct bio_vec)*2, but the code looks like it
> would
> set the local bvec to 0xffff4502, which is not the same thing..
>
> There must be a hole in my head,  I guess I need to dig out my K&R,
> sorry
> for the noise.  I will figure it out.
>
> > net/sunrpc/xdr.c:       pgto = pages + (pgto_base >> PAGE_SHIFT);
> > net/sunrpc/xdr.c:       pgfrom = pages + (pgfrom_base >> PAGE_SHIFT);
> > net/sunrpc/xdr.c:       pgto = pages + (pgto_base >> PAGE_SHIFT);
> > net/sunrpc/xdr.c:       pgfrom = pages + (pgfrom_base >> PAGE_SHIFT);
> > net/sunrpc/xdr.c:       pgto = pages + (pgbase >> PAGE_SHIFT);
> > net/sunrpc/xdr.c:       pgfrom = pages + (pgbase >> PAGE_SHIFT);
> > net/sunrpc/xdr.c:       page = pages + (pgbase >> PAGE_SHIFT);
> > net/sunrpc/xdr.c:       xdr->page_ptr = buf->pages + (new >>
> > PAGE_SHIFT);
> > net/sunrpc/xdr.c:               ppages = buf->pages + (base >>
> > PAGE_SHIFT);
> > net/sunrpc/xprtrdma/rpc_rdma.c: ppages = buf->pages + (buf->page_base
> > >> PAGE_SHIFT);
> > net/sunrpc/xprtrdma/rpc_rdma.c: ppages = xdrbuf->pages +
> > (xdrbuf->page_base >> PAGE_SHIFT);
> > net/sunrpc/xprtrdma/rpc_rdma.c: ppages = xdr->pages + (xdr->page_base
> > >> PAGE_SHIFT);
> > net/sunrpc/xprtrdma/rpc_rdma.c: ppages = xdr->pages + (xdr->page_base
> > >> PAGE_SHIFT);
>
> Hmm.. there's clearly something wrong with me.
>
> > Commit bad4c6eb5eaa is from v5.11. Wouldn't this issue have
> > shown up in earlier kernels? At the very least, the patch
> > description needs to explain why this computation is not a
> > problem for kernels 5.11 through 5.19.
>
> I totally agree.  I figured it was rare to have a non-zero page_base,
> and
> maybe a client change is now creating that.
>
> Ben
>
