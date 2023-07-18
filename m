Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED37B757F5A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjGROWo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGROWn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 10:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE8199
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 07:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE96615D7
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 14:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4899EC433C8
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 14:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689690160;
        bh=i4HNInmrTYJYnPbRezMlIfcHSTpLRMILGA67kTTWNMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xwr2jT+zGhAhJfZcLXBlngfKb2Z/+b74xfpvw/85UVeAga9PjiiMPWQb2kIUvAv4m
         oDUccgcMJ8xzIQ6uurCPMuWyqPmRb8Iis8p3F15M9GzS0MpeusW0x6lxbBS3Rc5veT
         Q6dtFPaThitcs1qR38w+gv7lxyxpFv73aIqABU66/fCxWqu7QQU2PGNAaJuAHGkwN6
         pv6YeOwIT39tN4poQ1ct2VDBeh3tNMWMgjoXubQYBb8HGQ6T96YjNIvXGf41hI0o6N
         biTIhjcnkoDEQsZKE7VzPTHKWJwXsqYkhnv3/pWT9la6nMvkVrIbgrRJPsEgEZTmSK
         XWUn9nxUYsW3A==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-403c653d934so40900241cf.2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 07:22:40 -0700 (PDT)
X-Gm-Message-State: ABy/qLb3F99IT+aOQ3RI/cPWCTdMZixljqeTCOzupPzlG6xHtAvUa6OD
        /yPArO7VZ3cVJzqCqw/tehGSw9wQ2CZN65AJnTY=
X-Google-Smtp-Source: APBJJlGA78LHPyUy7dVUHn0Rvt1IKQqFlOHyobNWw15RlfaGY8KO0e3a0x4AGZtOLJDIeyYMYR3qWa+RLc1OmbLfM2E=
X-Received: by 2002:a05:622a:178e:b0:403:b645:7c21 with SMTP id
 s14-20020a05622a178e00b00403b6457c21mr18537779qtk.46.1689690159389; Tue, 18
 Jul 2023 07:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230717205239.921002-1-anna@kernel.org> <20230717205239.921002-5-anna@kernel.org>
 <ZLabtlXdGw4p4Q4Z@bazille.1015granger.net>
In-Reply-To: <ZLabtlXdGw4p4Q4Z@bazille.1015granger.net>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 18 Jul 2023 10:22:23 -0400
X-Gmail-Original-Message-ID: <CAFX2JfmZ2JFRzdzLTTVWDYnwveQdeX0kWVY327z20V41zVTo1g@mail.gmail.com>
Message-ID: <CAFX2JfmZ2JFRzdzLTTVWDYnwveQdeX0kWVY327z20V41zVTo1g@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] SUNRPC: kmap() the xdr pages during decode
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 18, 2023 at 10:03=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote=
:
>
> On Mon, Jul 17, 2023 at 04:52:38PM -0400, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > If the pages are in HIGHMEM then we need to make sure they're mapped
> > before trying to read data off of them, otherwise we could end up with =
a
> > NULL pointer dereference.
> >
> > The downside to this is that we need an extra cleanup step at the end o=
f
> > decode to kunmap() the last page.
> >
> > Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > v5: Also clean up kmapped pages on the server
> > ---
> >  include/linux/sunrpc/xdr.h |  2 ++
> >  net/sunrpc/clnt.c          |  1 +
> >  net/sunrpc/svc.c           |  2 ++
> >  net/sunrpc/xdr.c           | 17 ++++++++++++++++-
> >  4 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> > index 6bffd10b7a33..60ddad33b49b 100644
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
> > @@ -253,6 +254,7 @@ extern void xdr_truncate_decode(struct xdr_stream *=
xdr, size_t len);
> >  extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
> >  extern void xdr_write_pages(struct xdr_stream *xdr, struct page **page=
s,
> >               unsigned int base, unsigned int len);
> > +extern void xdr_stream_unmap_current_page(struct xdr_stream *xdr);
>
> xdr_stream_unmap_current_page() is now effectively a matching
> book-end for xdr_init_decode(). I think it would be more clear
> (for human readers) if the name matched that organization rather
> than being about the one specific thing it happens to be doing
> now.
>
> Something like xdr_finish_decode() ?

I like xdr_finish_decode() much better! I'll rename that

Thanks,
Anna

>
>
> >  extern unsigned int xdr_stream_pos(const struct xdr_stream *xdr);
> >  extern unsigned int xdr_page_pos(const struct xdr_stream *xdr);
> >  extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *bu=
f,
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index d7c697af3762..8080a1830ff3 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -2602,6 +2602,7 @@ call_decode(struct rpc_task *task)
> >       case 0:
> >               task->tk_action =3D rpc_exit_task;
> >               task->tk_status =3D rpcauth_unwrap_resp(task, &xdr);
> > +             xdr_stream_unmap_current_page(&xdr);
> >               return;
> >       case -EAGAIN:
> >               task->tk_status =3D 0;
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 587811a002c9..5f32817579db 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1370,6 +1370,8 @@ svc_process_common(struct svc_rqst *rqstp)
> >       rc =3D process.dispatch(rqstp);
> >       if (procp->pc_release)
> >               procp->pc_release(rqstp);
> > +     xdr_stream_unmap_current_page(xdr);
> > +
> >       if (!rc)
> >               goto dropit;
> >       if (rqstp->rq_auth_stat !=3D rpc_auth_ok)
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 94bddd1dd1d7..2b972954327f 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -1306,6 +1306,14 @@ static unsigned int xdr_set_tail_base(struct xdr=
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
> > @@ -1323,12 +1331,18 @@ static unsigned int xdr_set_page_base(struct xd=
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
> > @@ -1382,6 +1396,7 @@ void xdr_init_decode(struct xdr_stream *xdr, stru=
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
