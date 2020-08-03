Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059CB23AD67
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 21:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHCTiQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 15:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgHCTiP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 15:38:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39688C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 12:38:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so39863738ejj.10
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjdWzxA18k+zTNZZxtPPihNSkZrVBU5Rfc5b6kxvL4c=;
        b=vN8aa0m+uqDl1vM8HM1Jgbf7z9JJ52rOmcGikgfTAToEuVTRVK9YjCTnX5kovTmp27
         RhkP9SkFJCr0rpCkX6ynAatuOuXCK9EGtcBjYBE9ROs1Wqhj4LnrCW0dp5h/6lD7ZC/d
         dIVRNdBn/J1n25NT/qLhX/poBmENlK91UqL4xWOsLECV7Cw2Mru8NsaDs4c49JkQlBez
         +4+EoGBEkv0/I0d0toae7D0UrRXmfqTa4oT9RYVTMrn7mB6RAj7SkXMp/KmBqBRqmtTr
         B7XIwA7jSo1skVotaaafSpS8Ix0leBisREFn4XwnkUQR3YVyo3+11U2BqfV46CC70+yu
         o0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjdWzxA18k+zTNZZxtPPihNSkZrVBU5Rfc5b6kxvL4c=;
        b=Q1ipe4bSCKz8qFeTWdfJI189t9sVkvuYUgF26nubnrnf+RMtC32fp4iMNNz/zGmQI6
         50OsJrUkFpGjvh5KR/rztvrV16L/638Abzt2OIh6/zAgv5R6UlO/ySI9AFgvYunMj2aF
         5s61H6Bh6ZvWWeQSEaEbhF9TCbKGOHIzFLlwfkpjYZa/begPyleQ8P8jWGQNBsedvMR+
         XvGgPIHIXaifqs0PokegyjqKGQQjNFzZ7sOLF1NJH0s0paQdIo6fWSCV8CowAKSPdbfn
         7xhshHEmx+EGV06+IfCHgigmRw/+YXqIaBfEaYx9vsMNSdTdXpfLvavC3FKY/dhNunIL
         YfVg==
X-Gm-Message-State: AOAM5334w3FdslBohBsW1pRVm4RgYxfoTJxr2IoMf2KJj+IDGK4RPVs7
        gKTy1M71k23VWi1RyRHeeY70cGr/VfbKNjWr4Ik=
X-Google-Smtp-Source: ABdhPJx3gLrX7KZsGns9/gUz/yytI6XmShAxyrtFvKBdqaHTO3iCHAjBn7lx0gQSJTE1w18hT35ZPbjygxASV2GIwPk=
X-Received: by 2002:a17:906:d042:: with SMTP id bo2mr17518001ejb.152.1596483493846;
 Mon, 03 Aug 2020 12:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
 <20200803165954.1348263-2-Anna.Schumaker@Netapp.com> <DEB91DA9-0DCE-4C95-8B87-D8167AB57F65@oracle.com>
In-Reply-To: <DEB91DA9-0DCE-4C95-8B87-D8167AB57F65@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 3 Aug 2020 15:37:57 -0400
Message-ID: <CAFX2JfnObW2z1wPgvQK1_WceaKS-gcS5b1YqUgZGg1uxnLdU3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] SUNRPC: Implement xdr_reserve_space_vec()
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Mon, Aug 3, 2020 at 3:21 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Anna-
>
> > On Aug 3, 2020, at 12:59 PM, schumaker.anna@gmail.com wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > Reserving space for a large READ payload requires special handling when
> > reserving space in the xdr buffer pages. One problem we can have is use
> > of the scratch buffer, which is used to get a pointer to a contiguous
> > region of data up to PAGE_SIZE. When using the scratch buffer, calls to
> > xdr_commit_encode() shift the data to it's proper alignment in the xdr
> > buffer. If we've reserved several pages in a vector, then this could
> > potentially invalidate earlier pointers and result in incorrect READ
> > data being sent to the client.
> >
> > I get around this by looking at the amount of space left in the current
> > page, and never reserve more than that for each entry in the read
> > vector. This lets us place data directly where it needs to go in the
> > buffer pages.
>
> Nit: This appears to be a refactoring change that should be squashed
> together with 2/6.

My default was to leave sunrpc and nfs changes as separate patches,
but I can squash them together if you want me to!

Anna
>
>
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > include/linux/sunrpc/xdr.h |  2 ++
> > net/sunrpc/xdr.c           | 45 ++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 47 insertions(+)
> >
> > diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> > index 22c207b2425f..bac459584dd0 100644
> > --- a/include/linux/sunrpc/xdr.h
> > +++ b/include/linux/sunrpc/xdr.h
> > @@ -234,6 +234,8 @@ typedef int       (*kxdrdproc_t)(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
> > extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf,
> >                           __be32 *p, struct rpc_rqst *rqst);
> > extern __be32 *xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes);
> > +extern int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec,
> > +             size_t nbytes);
> > extern void xdr_commit_encode(struct xdr_stream *xdr);
> > extern void xdr_truncate_encode(struct xdr_stream *xdr, size_t len);
> > extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index be11d672b5b9..6dfe5dc8b35f 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -648,6 +648,51 @@ __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
> > }
> > EXPORT_SYMBOL_GPL(xdr_reserve_space);
> >
> > +
> > +/**
> > + * xdr_reserve_space_vec - Reserves a large amount of buffer space for sending
> > + * @xdr: pointer to xdr_stream
> > + * @vec: pointer to a kvec array
> > + * @nbytes: number of bytes to reserve
> > + *
> > + * Reserves enough buffer space to encode 'nbytes' of data and stores the
> > + * pointers in 'vec'. The size argument passed to xdr_reserve_space() is
> > + * determined based on the number of bytes remaining in the current page to
> > + * avoid invalidating iov_base pointers when xdr_commit_encode() is called.
> > + */
> > +int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec, size_t nbytes)
> > +{
> > +     int thislen;
> > +     int v = 0;
> > +     __be32 *p;
> > +
> > +     /*
> > +      * svcrdma requires every READ payload to start somewhere
> > +      * in xdr->pages.
> > +      */
> > +     if (xdr->iov == xdr->buf->head) {
> > +             xdr->iov = NULL;
> > +             xdr->end = xdr->p;
> > +     }
> > +
> > +     while (nbytes) {
> > +             thislen = xdr->buf->page_len % PAGE_SIZE;
> > +             thislen = min_t(size_t, nbytes, PAGE_SIZE - thislen);
> > +
> > +             p = xdr_reserve_space(xdr, thislen);
> > +             if (!p)
> > +                     return -EIO;
> > +
> > +             vec[v].iov_base = p;
> > +             vec[v].iov_len = thislen;
> > +             v++;
> > +             nbytes -= thislen;
> > +     }
> > +
> > +     return v;
> > +}
> > +EXPORT_SYMBOL_GPL(xdr_reserve_space_vec);
> > +
> > /**
> >  * xdr_truncate_encode - truncate an encode buffer
> >  * @xdr: pointer to xdr_stream
> > --
> > 2.27.0
> >
>
> --
> Chuck Lever
>
>
>
