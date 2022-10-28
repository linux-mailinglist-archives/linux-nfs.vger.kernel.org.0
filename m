Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70805610E8A
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 12:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJ1Kef (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJ1Kee (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 06:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE11B65D4
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666953216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9uk+UYhAa3jQRoZ61Y7+EdWkXdIPFLbr3gxr6x2ocAc=;
        b=IrS/uAm18bU9yG3lGvkJv3UndqbupCxXHXrZD9Pu1cQw+tFQGw1Z61y6tsGiBciQWO8zR6
        /kqgx5eyHkglzu96qvP3L7+n/eO3bBdbImBhqSN5tBH7qYhh5s/bZsfjEeXc1Bzz9jcu3a
        dqFSg03+xV+mMakBXTKuyhVQmjLixzo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-296-nb90BKVVNg6ARhbAfWgJtw-1; Fri, 28 Oct 2022 06:33:35 -0400
X-MC-Unique: nb90BKVVNg6ARhbAfWgJtw-1
Received: by mail-pf1-f199.google.com with SMTP id i19-20020aa787d3000000b0056bd68d713cso2383666pfo.17
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 03:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uk+UYhAa3jQRoZ61Y7+EdWkXdIPFLbr3gxr6x2ocAc=;
        b=piy57i+4XWojN5CDEa1zON2Ig9rjuqRyhlj0hWP42puQSDpX4uaVWy+QFwJGB2gb6/
         HKoPklmV4uFrqlmgF5xxZVHKb1gzi+WB+z1rV9Sin40ON8Fm+DQxYDnMnPzML5GnpQtU
         yfshxtfgdhxWRKt5dpC9btalaBV1hhaoAYae6PIBaiHgEfjAJCZ4/VDXI19OjIKl0Msi
         BvgPS0xEw9fNSYPsLTjYZ6GVa6tX91z3xewJeOGeVp/jUSWNlFeGXAJwPp7mLq/QAX43
         sy4veythLAtsqiu2zYJqeMm5tdLA7LJ0mdV3+jONcrUy5FkTW10CIMZDyJPkOrRYKYsB
         ISKw==
X-Gm-Message-State: ACrzQf2f0Rna91rKRd5umPPgKpt0psVtTrSEGeAPf5Ra2R6TnR2HC1Af
        FMuMKwZaE0XjSKxgV9xaBOrR6BbAbARyGUM2YjYFxpEmsV0fSdn4emr9H1hMurQEXxuZUXxNeYl
        eLuDvg72ag6Wah0nu6S/b1AeaejU2tohMN5h6
X-Received: by 2002:a63:8aca:0:b0:461:25fe:e7c5 with SMTP id y193-20020a638aca000000b0046125fee7c5mr5528931pgd.395.1666953214199;
        Fri, 28 Oct 2022 03:33:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7CDUGlxiti4C8hgOHRguFAQ3QHMrWUKDeS0p8ygNaYojJN5ZX9Wa2//oSKhF2YkC4g3bgZL1f+aTZ/8Mqb+9I=
X-Received: by 2002:a63:8aca:0:b0:461:25fe:e7c5 with SMTP id
 y193-20020a638aca000000b0046125fee7c5mr5528907pgd.395.1666953213864; Fri, 28
 Oct 2022 03:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221017105212.77588-1-dwysocha@redhat.com> <20221017105212.77588-2-dwysocha@redhat.com>
 <010f7996fde7dc4aa7a21e4b2b835d5ae7084771.camel@kernel.org>
In-Reply-To: <010f7996fde7dc4aa7a21e4b2b835d5ae7084771.camel@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 28 Oct 2022 06:32:57 -0400
Message-ID: <CALF+zOkC4F-g5sW1-v5eyyFph_JuSuSrLMbQ-3Uk71_QN2d75Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] NFS: Rename readpage_async_filler to nfs_pageio_add_page
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 27, 2022 at 2:07 PM Trond Myklebust <trondmy@kernel.org> wrote:
>
> On Mon, 2022-10-17 at 06:52 -0400, Dave Wysochanski wrote:
> > Rename readpage_async_filler to nfs_pageio_add_page to
> > better reflect what this function does (add a page to
> > the nfs_pageio_descriptor), and simplify arguments to
> > this function by removing struct nfs_readdesc.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfs/read.c | 60 +++++++++++++++++++++++++------------------------
> > --
> >  1 file changed, 30 insertions(+), 30 deletions(-)
> >
> > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > index 8ae2c8d1219d..525e82ea9a9e 100644
> > --- a/fs/nfs/read.c
> > +++ b/fs/nfs/read.c
> > @@ -127,11 +127,6 @@ static void nfs_readpage_release(struct nfs_page
> > *req, int error)
> >         nfs_release_request(req);
> >  }
> >
> > -struct nfs_readdesc {
> > -       struct nfs_pageio_descriptor pgio;
> > -       struct nfs_open_context *ctx;
> > -};
> > -
> >  static void nfs_page_group_set_uptodate(struct nfs_page *req)
> >  {
> >         if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
> > @@ -153,7 +148,8 @@ static void nfs_read_completion(struct
> > nfs_pgio_header *hdr)
> >
> >                 if (test_bit(NFS_IOHDR_EOF, &hdr->flags)) {
> >                         /* note: regions of the page not covered by a
> > -                        * request are zeroed in
> > readpage_async_filler */
> > +                        * request are zeroed in nfs_pageio_add_page
> > +                        */
> >                         if (bytes > hdr->good_bytes) {
> >                                 /* nothing in this request was good,
> > so zero
> >                                  * the full extent of the request */
> > @@ -281,8 +277,10 @@ static void nfs_readpage_result(struct rpc_task
> > *task,
> >                 nfs_readpage_retry(task, hdr);
> >  }
> >
> > -static int
> > -readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
> > +int
> > +nfs_pageio_add_page(struct nfs_pageio_descriptor *pgio,
> > +                   struct nfs_open_context *ctx,
> > +                   struct page *page)
>
> If we're going to rename this function, then let's not give it a name
> that suggests it belongs in pagelist.c. It's not a generic helper
> function, but is still very much specific to the pagecache read
> functionality.
>

How about nfs_read_add_page()?




> >  {
> >         struct inode *inode = page_file_mapping(page)->host;
> >         unsigned int rsize = NFS_SERVER(inode)->rsize;
> > @@ -302,15 +300,15 @@ readpage_async_filler(struct nfs_readdesc
> > *desc, struct page *page)
> >                         goto out_unlock;
> >         }
> >
> > -       new = nfs_create_request(desc->ctx, page, 0, aligned_len);
> > +       new = nfs_create_request(ctx, page, 0, aligned_len);
> >         if (IS_ERR(new))
> >                 goto out_error;
> >
> >         if (len < PAGE_SIZE)
> >                 zero_user_segment(page, len, PAGE_SIZE);
> > -       if (!nfs_pageio_add_request(&desc->pgio, new)) {
> > +       if (!nfs_pageio_add_request(pgio, new)) {
> >                 nfs_list_remove_request(new);
> > -               error = desc->pgio.pg_error;
> > +               error = pgio->pg_error;
> >                 nfs_readpage_release(new, error);
> >                 goto out;
> >         }
> > @@ -332,7 +330,8 @@ readpage_async_filler(struct nfs_readdesc *desc,
> > struct page *page)
> >  int nfs_read_folio(struct file *file, struct folio *folio)
> >  {
> >         struct page *page = &folio->page;
> > -       struct nfs_readdesc desc;
> > +       struct nfs_pageio_descriptor pgio;
> > +       struct nfs_open_context *ctx;
> >         struct inode *inode = page_file_mapping(page)->host;
> >         int ret;
> >
> > @@ -358,29 +357,29 @@ int nfs_read_folio(struct file *file, struct
> > folio *folio)
> >
> >         if (file == NULL) {
> >                 ret = -EBADF;
> > -               desc.ctx = nfs_find_open_context(inode, NULL,
> > FMODE_READ);
> > -               if (desc.ctx == NULL)
> > +               ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
> > +               if (ctx == NULL)
> >                         goto out_unlock;
> >         } else
> > -               desc.ctx =
> > get_nfs_open_context(nfs_file_open_context(file));
> > +               ctx =
> > get_nfs_open_context(nfs_file_open_context(file));
> >
> > -       xchg(&desc.ctx->error, 0);
> > -       nfs_pageio_init_read(&desc.pgio, inode, false,
> > +       xchg(&ctx->error, 0);
> > +       nfs_pageio_init_read(&pgio, inode, false,
> >                              &nfs_async_read_completion_ops);
> >
> > -       ret = readpage_async_filler(&desc, page);
> > +       ret = nfs_pageio_add_page(&pgio, ctx, page);
> >         if (ret)
> >                 goto out;
> >
> > -       nfs_pageio_complete_read(&desc.pgio);
> > -       ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
> > +       nfs_pageio_complete_read(&pgio);
> > +       ret = pgio.pg_error < 0 ? pgio.pg_error : 0;
> >         if (!ret) {
> >                 ret = wait_on_page_locked_killable(page);
> >                 if (!PageUptodate(page) && !ret)
> > -                       ret = xchg(&desc.ctx->error, 0);
> > +                       ret = xchg(&ctx->error, 0);
> >         }
> >  out:
> > -       put_nfs_open_context(desc.ctx);
> > +       put_nfs_open_context(ctx);
> >         trace_nfs_aop_readpage_done(inode, page, ret);
> >         return ret;
> >  out_unlock:
> > @@ -391,9 +390,10 @@ int nfs_read_folio(struct file *file, struct
> > folio *folio)
> >
> >  void nfs_readahead(struct readahead_control *ractl)
> >  {
> > +       struct nfs_pageio_descriptor pgio;
> > +       struct nfs_open_context *ctx;
> >         unsigned int nr_pages = readahead_count(ractl);
> >         struct file *file = ractl->file;
> > -       struct nfs_readdesc desc;
> >         struct inode *inode = ractl->mapping->host;
> >         struct page *page;
> >         int ret;
> > @@ -407,25 +407,25 @@ void nfs_readahead(struct readahead_control
> > *ractl)
> >
> >         if (file == NULL) {
> >                 ret = -EBADF;
> > -               desc.ctx = nfs_find_open_context(inode, NULL,
> > FMODE_READ);
> > -               if (desc.ctx == NULL)
> > +               ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
> > +               if (ctx == NULL)
> >                         goto out;
> >         } else
> > -               desc.ctx =
> > get_nfs_open_context(nfs_file_open_context(file));
> > +               ctx =
> > get_nfs_open_context(nfs_file_open_context(file));
> >
> > -       nfs_pageio_init_read(&desc.pgio, inode, false,
> > +       nfs_pageio_init_read(&pgio, inode, false,
> >                              &nfs_async_read_completion_ops);
> >
> >         while ((page = readahead_page(ractl)) != NULL) {
> > -               ret = readpage_async_filler(&desc, page);
> > +               ret = nfs_pageio_add_page(&pgio, ctx, page);
> >                 put_page(page);
> >                 if (ret)
> >                         break;
> >         }
> >
> > -       nfs_pageio_complete_read(&desc.pgio);
> > +       nfs_pageio_complete_read(&pgio);
> >
> > -       put_nfs_open_context(desc.ctx);
> > +       put_nfs_open_context(ctx);
> >  out:
> >         trace_nfs_aop_readahead_done(inode, nr_pages, ret);
> >  }
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

