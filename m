Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E627744560
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Jul 2023 01:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjF3Xq6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 19:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjF3Xq6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 19:46:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2EE297C
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 16:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ADD361807
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 23:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D759BC433C9
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 23:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688168814;
        bh=yjdFEMupa6Bu0jGnCop0EKTFFlWUvGThraY+1Ql5IbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GiCznFgNOQdlRcja5o4HUTdBPeLzMXk8NK0VCq09lVeMdlb8UGx69GK2IN1YvGrx8
         HHFv9iR5JZXOrKsNwgSOrHUo9/tx+1Xej3LegF6IALk2Z4Vefpdnj30epvtuJnkevk
         1ZoiuFf7e2XxXRtKbH+gkL63+jdeHvukyFGGc0MvOhocPtAKH9msiLzcABOnnQ/KCR
         x71LHCgqQFlbzES4dzFRHVq12bchyAu1DjEsHvNzqBGmHY9CPWENy/HP1WNmrK6nK/
         rWvaLnyVOBGaOJ6xb2h+PoK39gNzrpe9Qy91ntz5Vyktrqz2rsmKss3Uo2+9/aeFhb
         gxlcP8ny0VQFw==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4034adef329so2833621cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 16:46:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDw7fRDHha2OlanXl/QGf6y7uvPQAnF+gaEdDAZjGY9ddgfMqdFw
        Z7LU+BOLdoPNmjinnj6L7aQ52T+MZtr1DioOxLw=
X-Google-Smtp-Source: ACHHUZ5+xVxBN6S8G7tIixriNLcIZeKM/5RzbytXzpfzpPqwAIlAI6Wxi7uIOGMftPsHcK6oQ6HKefTdBQGunGVKWeg=
X-Received: by 2002:ac8:5890:0:b0:403:3885:b80f with SMTP id
 t16-20020ac85890000000b004033885b80fmr5689587qta.57.1688168813997; Fri, 30
 Jun 2023 16:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230630204240.653492-1-anna@kernel.org> <20230630204240.653492-5-anna@kernel.org>
 <ZJ9etMtEYB+hXfH5@manet.1015granger.net>
In-Reply-To: <ZJ9etMtEYB+hXfH5@manet.1015granger.net>
From:   Anna Schumaker <anna@kernel.org>
Date:   Fri, 30 Jun 2023 19:46:38 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkJkJjw=AYh3rHRCjg81QKMc1Oynu6ZPf6-Hvesauv5bQ@mail.gmail.com>
Message-ID: <CAFX2JfkJkJjw=AYh3rHRCjg81QKMc1Oynu6ZPf6-Hvesauv5bQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] SUNRPC: kmap() the xdr pages during decode
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 30, 2023 at 7:01=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On Fri, Jun 30, 2023 at 04:42:40PM -0400, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > If the pages are in HIGHMEM then we need to make sure they're mapped
> > before trying to read data off of them, otherwise we could end up with =
a
> > NULL pointer dereference.
> >
> > Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  include/linux/sunrpc/xdr.h |  2 ++
> >  net/sunrpc/clnt.c          |  1 +
> >  net/sunrpc/xdr.c           | 17 ++++++++++++++++-
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> > index d917618a3058..f562aab468f5 100644
> > --- a/include/linux/sunrpc/xdr.h
> > +++ b/include/linux/sunrpc/xdr.h
> > @@ -228,6 +228,7 @@ struct xdr_stream {
> >       struct kvec *iov;       /* pointer to the current kvec */
> >       struct kvec scratch;    /* Scratch buffer */
> >       struct page **page_ptr; /* pointer to the current page */
> > +     void *page_kaddr;       /* kmapped address of the current page */
> >       unsigned int nwords;    /* Remaining decode buffer length */
> >
> >       struct rpc_rqst *rqst;  /* For debugging */
> > @@ -254,6 +255,7 @@ extern void xdr_truncate_decode(struct xdr_stream *=
xdr, size_t len);
> >  extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
> >  extern void xdr_write_pages(struct xdr_stream *xdr, struct page **page=
s,
> >               unsigned int base, unsigned int len);
> > +extern void xdr_stream_unmap_current_page(struct xdr_stream *xdr);
> >  extern unsigned int xdr_stream_pos(const struct xdr_stream *xdr);
> >  extern unsigned int xdr_page_pos(const struct xdr_stream *xdr);
> >  extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *bu=
f,
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index d2ee56634308..3b7e676d8935 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -2590,6 +2590,7 @@ call_decode(struct rpc_task *task)
> >       case 0:
> >               task->tk_action =3D rpc_exit_task;
> >               task->tk_status =3D rpcauth_unwrap_resp(task, &xdr);
> > +             xdr_stream_unmap_current_page(&xdr);
>
> The server uses xdr_inline_decode() as well. Wouldn't it also need
> some kind of clean up?

It would, yeah. I'll add that in for the next version of this patch.

>
> I'm curious why this issue hasn't been a problem until now.

I think it's a combination of factors:
  - Not many people use 32 bit machines these days
  - Most NFS operations try to align the pages with some data payload
so the highmem stuff could be done for us deeper in the networking
stack, and we never needed to think about it
  - Not every page on 32 bit is a highmem page, so operations like
readdir that use the xdr pages during decoding might not have been
dealing with highmem pages

Thanks for the comments! Out of the 4 patches, this one is definitely
the one that needs the closest look.

Anna

>
>
> >               return;
> >       case -EAGAIN:
> >               task->tk_status =3D 0;
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 391b336d97de..fb5203337608 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -1308,6 +1308,14 @@ static unsigned int xdr_set_tail_base(struct xdr=
_stream *xdr,
> >       return xdr_set_iov(xdr, buf->tail, base, len);
> >  }
> >
> > +void xdr_stream_unmap_current_page(struct xdr_stream *xdr)
> > +{
> > +     if (xdr->page_kaddr) {
> > +             kunmap_local(xdr->page_kaddr);
> > +             xdr->page_kaddr =3D NULL;
> > +     }
> > +}
> > +
> >  static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
> >                                     unsigned int base, unsigned int len=
)
> >  {
> > @@ -1325,12 +1333,18 @@ static unsigned int xdr_set_page_base(struct xd=
r_stream *xdr,
> >       if (len > maxlen)
> >               len =3D maxlen;
> >
> > +     xdr_stream_unmap_current_page(xdr);
> >       xdr_stream_page_set_pos(xdr, base);
> >       base +=3D xdr->buf->page_base;
> >
> >       pgnr =3D base >> PAGE_SHIFT;
> >       xdr->page_ptr =3D &xdr->buf->pages[pgnr];
> > -     kaddr =3D page_address(*xdr->page_ptr);
> > +
> > +     if (PageHighMem(*xdr->page_ptr)) {
> > +             xdr->page_kaddr =3D kmap_local_page(*xdr->page_ptr);
> > +             kaddr =3D xdr->page_kaddr;
> > +     } else
> > +             kaddr =3D page_address(*xdr->page_ptr);
> >
> >       pgoff =3D base & ~PAGE_MASK;
> >       xdr->p =3D (__be32*)(kaddr + pgoff);
> > @@ -1384,6 +1398,7 @@ void xdr_init_decode(struct xdr_stream *xdr, stru=
ct xdr_buf *buf, __be32 *p,
> >                    struct rpc_rqst *rqst)
> >  {
> >       xdr->buf =3D buf;
> > +     xdr->page_kaddr =3D NULL;
> >       xdr_reset_scratch_buffer(xdr);
> >       xdr->nwords =3D XDR_QUADLEN(buf->len);
> >       if (xdr_set_iov(xdr, buf->head, 0, buf->len) =3D=3D 0 &&
> > --
> > 2.41.0
> >
