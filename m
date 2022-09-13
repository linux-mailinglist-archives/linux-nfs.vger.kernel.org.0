Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9C25B7C0B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 22:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIMUMh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 16:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIMUMg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 16:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CC2642D3
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663099951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlDffOjPp/dJRIPod5iWybuO2XoF2R+8bw+WQ5xElDs=;
        b=B/YajhLgcbTX1k6OfMkxEYR6sOIebR3Y4nuN0b4GoVPcaOIeHZHcpicZgaInKxoI0c0evR
        MXy3g6Nnvo5IWWPLcSQx/OmVUoBdAPCmQ094Iqkxm4nwH0Nw1vXafr3cerRg4uEA4I/RDR
        BaUHhgxYeFmo6sIeVWQRdLK6/+dIoqU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-AK8akMnUM-We1SHgh7I1Iw-1; Tue, 13 Sep 2022 16:12:30 -0400
X-MC-Unique: AK8akMnUM-We1SHgh7I1Iw-1
Received: by mail-io1-f69.google.com with SMTP id q10-20020a0566022f0a00b00688d703717bso7907893iow.9
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 13:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JlDffOjPp/dJRIPod5iWybuO2XoF2R+8bw+WQ5xElDs=;
        b=3PbdJubHlYpGITCn4eS02RktYk84sm8xu/D6VPdTunQT9b0HjMweczOR9zZEFXL7en
         tu8QJ3wEaxmbce7wF6lf3+yoiWvnlotKjboimv6Y9667Vt06jOXm3BDs1/6Ds4LfutIo
         edU9xtqmfgad6E+m5srFQsPNLqVxbNi2iAOxzrQfaUN1PlWVjvJRrrqV82U1eSN1gZjN
         x4DYG6HHVLVDtwlQVJ7snukK3KOJ+TbjeQTwwIldMxYa29O63eKTkG0DxzpoAdKLkNqo
         1+4Qy0lL8jEHQAVGB+sqEFtcXam2t4q7iUKRzp8UOyVxar7WeZXGFgdP6NSNyRE28YXO
         dixQ==
X-Gm-Message-State: ACgBeo2Os5b7NslBbuw6j2YcZSpGqUMBgxunbiQEjIOEuUvbc/VpHofr
        R0pbNS8+Kr61bejRXtUu0mJ8PsKBESGnEOwH+aXGFREVDSx2hizRVwSr+xksKQv8KySN68ApRym
        YGLJnQqGPNJxZeSLDs5p23ezYYsHo35oH6LRp
X-Received: by 2002:a05:6e02:144a:b0:2f0:bc65:fd45 with SMTP id p10-20020a056e02144a00b002f0bc65fd45mr12842135ilo.73.1663099948769;
        Tue, 13 Sep 2022 13:12:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5HuOj4a6MCtHHkRSDAL0Zr93vJD38hVUqrZbDxcSXD+V4FYTv+a5xyMG+3A9IShRKhzS9nyLVegfjqvDmrwZo=
X-Received: by 2002:a05:6e02:144a:b0:2f0:bc65:fd45 with SMTP id
 p10-20020a056e02144a00b002f0bc65fd45mr12842117ilo.73.1663099948235; Tue, 13
 Sep 2022 13:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220904090557.1901131-1-dwysocha@redhat.com> <20220904090557.1901131-4-dwysocha@redhat.com>
 <ee3a688f91de937e7cb78e8e698f466e1aee1ac7.camel@kernel.org>
 <CALF+zOm8zBdO5Wm05xtsyb1ERUXAFkJjk5epMjjDvUgbign3kA@mail.gmail.com> <20b4aaec4f4de0fd3b325a4ecd2ceb567ce1ea9d.camel@kernel.org>
In-Reply-To: <20b4aaec4f4de0fd3b325a4ecd2ceb567ce1ea9d.camel@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 13 Sep 2022 16:11:52 -0400
Message-ID: <CALF+zOnC2SY5rYRPV0ApKGWkU9OKhg78Cf667UkpjBfg_ET_Cg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] NFS: Convert buffered read paths to use netfs when
 fscache is enabled
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 6, 2022 at 6:53 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sun, 2022-09-04 at 15:51 -0400, David Wysochanski wrote:
> > On Sun, Sep 4, 2022 at 9:59 AM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Sun, 2022-09-04 at 05:05 -0400, Dave Wysochanski wrote:
> > > > Convert the NFS buffered read code paths to corresponding netfs APIs,
> > > > but only when fscache is configured and enabled.
> > > >
> > > > The netfs API defines struct netfs_request_ops which must be filled
> > > > in by the network filesystem.  For NFS, we only need to define 5 of
> > > > the functions, the main one being the issue_read() function.
> > > > The issue_read() function is called by the netfs layer when a read
> > > > cannot be fulfilled locally, and must be sent to the server (either
> > > > the cache is not active, or it is active but the data is not available).
> > > > Once the read from the server is complete, netfs requires a call to
> > > > netfs_subreq_terminated() which conveys either how many bytes were read
> > > > successfully, or an error.  Note that issue_read() is called with a
> > > > structure, netfs_io_subrequest, which defines the IO requested, and
> > > > contains a start and a length (both in bytes), and assumes the underlying
> > > > netfs will return a either an error on the whole region, or the number
> > > > of bytes successfully read.
> > > >
> > > > The NFS IO path is page based and the main APIs are the pgio APIs defined
> > > > in pagelist.c.  For the pgio APIs, there is no way for the caller to
> > > > know how many RPCs will be sent and how the pages will be broken up
> > > > into underlying RPCs, each of which will have their own return code.
> > > > Thus, NFS needs some way to accommodate the netfs API requirement on
> > > > the single response to the whole request, while also minimizing
> > > > disruptive changes to the NFS pgio layer.  The approach taken with this
> > > > patch is to allocate a small structure for each nfs_netfs_issue_read() call
> > > > to keep the final error value or the number of bytes successfully read.
> > > > The refcount on the structure is used also as a marker for the last
> > > > RPC completion, updated inside nfs_netfs_read_initiate(), and
> > > > nfs_netfs_read_done(), when a nfs_pgio_header contains a valid pointer
> > > > to the data.  Then finally in nfs_read_completion(), call into
> > > > nfs_netfs_read_completion() to update the final error value and bytes
> > > > read, and check the refcount to determine whether this is the final
> > > > RPC completion.  If this is the last RPC, then in the final put on
> > > > the structure, call into netfs_subreq_terminated() with the final
> > > > error value or the number of bytes successfully transferred.
> > > >
> > > > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > ---
> > > >  fs/nfs/fscache.c         | 241 ++++++++++++++++++++++++---------------
> > > >  fs/nfs/fscache.h         |  94 +++++++++------
> > > >  fs/nfs/inode.c           |   2 +
> > > >  fs/nfs/internal.h        |   9 ++
> > > >  fs/nfs/pagelist.c        |  12 ++
> > > >  fs/nfs/read.c            |  51 ++++-----
> > > >  include/linux/nfs_page.h |   3 +
> > > >  include/linux/nfs_xdr.h  |   3 +
> > > >  8 files changed, 263 insertions(+), 152 deletions(-)
> > > >
> > > > diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> > > > index a6fc1c8b6644..9b7df3d61c35 100644
> > > > --- a/fs/nfs/fscache.c
> > > > +++ b/fs/nfs/fscache.c
> > > > @@ -15,6 +15,9 @@
> > > >  #include <linux/seq_file.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/iversion.h>
> > > > +#include <linux/xarray.h>
> > > > +#include <linux/fscache.h>
> > > > +#include <linux/netfs.h>
> > > >
> > > >  #include "internal.h"
> > > >  #include "iostat.h"
> > > > @@ -184,7 +187,7 @@ void nfs_fscache_init_inode(struct inode *inode)
> > > >   */
> > > >  void nfs_fscache_clear_inode(struct inode *inode)
> > > >  {
> > > > -     fscache_relinquish_cookie(netfs_i_cookie(&NFS_I(inode)->netfs), false);
> > > > +     fscache_relinquish_cookie(netfs_i_cookie(netfs_inode(inode)), false);
> > > >       netfs_inode(inode)->cache = NULL;
> > > >  }
> > > >
> > > > @@ -210,7 +213,7 @@ void nfs_fscache_clear_inode(struct inode *inode)
> > > >  void nfs_fscache_open_file(struct inode *inode, struct file *filp)
> > > >  {
> > > >       struct nfs_fscache_inode_auxdata auxdata;
> > > > -     struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
> > > > +     struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
> > > >       bool open_for_write = inode_is_open_for_write(inode);
> > > >
> > > >       if (!fscache_cookie_valid(cookie))
> > > > @@ -228,119 +231,169 @@ EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
> > > >  void nfs_fscache_release_file(struct inode *inode, struct file *filp)
> > > >  {
> > > >       struct nfs_fscache_inode_auxdata auxdata;
> > > > -     struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
> > > > +     struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
> > > >       loff_t i_size = i_size_read(inode);
> > > >
> > > >       nfs_fscache_update_auxdata(&auxdata, inode);
> > > >       fscache_unuse_cookie(cookie, &auxdata, &i_size);
> > > >  }
> > > >
> > > > -/*
> > > > - * Fallback page reading interface.
> > > > - */
> > > > -static int fscache_fallback_read_page(struct inode *inode, struct page *page)
> > > > +int nfs_netfs_read_folio(struct file *file, struct folio *folio)
> > > >  {
> > > > -     struct netfs_cache_resources cres;
> > > > -     struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
> > > > -     struct iov_iter iter;
> > > > -     struct bio_vec bvec[1];
> > > > -     int ret;
> > > > -
> > > > -     memset(&cres, 0, sizeof(cres));
> > > > -     bvec[0].bv_page         = page;
> > > > -     bvec[0].bv_offset       = 0;
> > > > -     bvec[0].bv_len          = PAGE_SIZE;
> > > > -     iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
> > > > -
> > > > -     ret = fscache_begin_read_operation(&cres, cookie);
> > > > -     if (ret < 0)
> > > > -             return ret;
> > > > -
> > > > -     ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
> > > > -                        NULL, NULL);
> > > > -     fscache_end_operation(&cres);
> > > > -     return ret;
> > > > +     if (!netfs_inode(folio_inode(folio))->cache)
> > > > +             return -ENOBUFS;
> > > > +
> > > > +     return netfs_read_folio(file, folio);
> > > >  }
> > > >
> > > > -/*
> > > > - * Fallback page writing interface.
> > > > - */
> > > > -static int fscache_fallback_write_page(struct inode *inode, struct page *page,
> > > > -                                    bool no_space_allocated_yet)
> > > > +int nfs_netfs_readahead(struct readahead_control *ractl)
> > > >  {
> > > > -     struct netfs_cache_resources cres;
> > > > -     struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
> > > > -     struct iov_iter iter;
> > > > -     struct bio_vec bvec[1];
> > > > -     loff_t start = page_offset(page);
> > > > -     size_t len = PAGE_SIZE;
> > > > -     int ret;
> > > > -
> > > > -     memset(&cres, 0, sizeof(cres));
> > > > -     bvec[0].bv_page         = page;
> > > > -     bvec[0].bv_offset       = 0;
> > > > -     bvec[0].bv_len          = PAGE_SIZE;
> > > > -     iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
> > > > -
> > > > -     ret = fscache_begin_write_operation(&cres, cookie);
> > > > -     if (ret < 0)
> > > > -             return ret;
> > > > -
> > > > -     ret = cres.ops->prepare_write(&cres, &start, &len, i_size_read(inode),
> > > > -                                   no_space_allocated_yet);
> > > > -     if (ret == 0)
> > > > -             ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
> > > > -     fscache_end_operation(&cres);
> > > > -     return ret;
> > > > +     struct inode *inode = ractl->mapping->host;
> > > > +
> > > > +     if (!netfs_inode(inode)->cache)
> > > > +             return -ENOBUFS;
> > > > +
> > > > +     netfs_readahead(ractl);
> > > > +     return 0;
> > > >  }
> > > >
> > > > -/*
> > > > - * Retrieve a page from fscache
> > > > - */
> > > > -int __nfs_fscache_read_page(struct inode *inode, struct page *page)
> > > > +atomic_t nfs_netfs_debug_id;
> > > > +static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *file)
> > > >  {
> > > > -     int ret;
> > > > +     rreq->netfs_priv = get_nfs_open_context(nfs_file_open_context(file));
> > > > +     rreq->debug_id = atomic_inc_return(&nfs_netfs_debug_id);
> > > >
> > > > -     trace_nfs_fscache_read_page(inode, page);
> > > > -     if (PageChecked(page)) {
> > > > -             ClearPageChecked(page);
> > > > -             ret = 1;
> > > > -             goto out;
> > > > -     }
> > > > +     return 0;
> > > > +}
> > > >
> > > > -     ret = fscache_fallback_read_page(inode, page);
> > > > -     if (ret < 0) {
> > > > -             nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
> > > > -             SetPageChecked(page);
> > > > -             goto out;
> > > > -     }
> > > > +static void nfs_netfs_free_request(struct netfs_io_request *rreq)
> > > > +{
> > > > +     put_nfs_open_context(rreq->netfs_priv);
> > > > +}
> > > >
> > > > -     /* Read completed synchronously */
> > > > -     nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
> > > > -     SetPageUptodate(page);
> > > > -     ret = 0;
> > > > -out:
> > > > -     trace_nfs_fscache_read_page_exit(inode, page, ret);
> > > > -     return ret;
> > > > +static inline int nfs_netfs_begin_cache_operation(struct netfs_io_request *rreq)
> > > > +{
> > > > +     return fscache_begin_read_operation(&rreq->cache_resources,
> > > > +                                         netfs_i_cookie(netfs_inode(rreq->inode)));
> > > >  }
> > > >
> > > > -/*
> > > > - * Store a newly fetched page in fscache.  We can be certain there's no page
> > > > - * stored in the cache as yet otherwise we would've read it from there.
> > > > - */
> > > > -void __nfs_fscache_write_page(struct inode *inode, struct page *page)
> > > > +static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequest *sreq)
> > > >  {
> > > > -     int ret;
> > > > +     struct nfs_netfs_io_data *netfs;
> > > > +
> > > > +     netfs = kzalloc(sizeof(*netfs), GFP_KERNEL_ACCOUNT);
> > > > +     if (!netfs)
> > > > +             return NULL;
> > > > +     netfs->sreq = sreq;
> > > > +     refcount_set(&netfs->refcount, 1);
> > > > +     return netfs;
> > > > +}
> > > >
> > > > -     trace_nfs_fscache_write_page(inode, page);
> > > > +static bool nfs_netfs_clamp_length(struct netfs_io_subrequest *sreq)
> > > > +{
> > > > +     size_t  rsize = NFS_SB(sreq->rreq->inode->i_sb)->rsize;
> > > >
> > > > -     ret = fscache_fallback_write_page(inode, page, true);
> > > > +     sreq->len = min(sreq->len, rsize);
> > > > +     return true;
> > > > +}
> > > >
> > > > -     if (ret != 0) {
> > > > -             nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
> > > > -             nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_UNCACHED);
> > > > -     } else {
> > > > -             nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
> > > > +static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
> > > > +{
> > > > +     struct nfs_pageio_descriptor pgio;
> > > > +     struct inode *inode = sreq->rreq->inode;
> > > > +     struct nfs_open_context *ctx = sreq->rreq->netfs_priv;
> > > > +     struct page *page;
> > > > +     int err;
> > > > +     pgoff_t start = (sreq->start + sreq->transferred) >> PAGE_SHIFT;
> > > > +     pgoff_t last = ((sreq->start + sreq->len -
> > > > +                      sreq->transferred - 1) >> PAGE_SHIFT);
> > > > +     XA_STATE(xas, &sreq->rreq->mapping->i_pages, start);
> > > > +
> > > > +     nfs_pageio_init_read(&pgio, inode, false,
> > > > +                          &nfs_async_read_completion_ops);
> > > > +
> > > > +     pgio.pg_netfs = nfs_netfs_alloc(sreq); /* used in completion */
> > > > +     if (!pgio.pg_netfs)
> > > > +             return netfs_subreq_terminated(sreq, -ENOMEM, false);
> > > > +
> > > > +     xas_lock(&xas);
> > > > +     xas_for_each(&xas, page, last) {
> > > > +             /* nfs_pageio_add_page() may schedule() due to pNFS layout and other RPCs  */
> > > > +             xas_pause(&xas);
> > > > +             xas_unlock(&xas);
> > > > +             err = nfs_pageio_add_page(&pgio, ctx, page);
> > > > +             if (err < 0)
> > > > +                     return netfs_subreq_terminated(sreq, err, false);
> > > > +             xas_lock(&xas);
> > > >       }
> > > > -     trace_nfs_fscache_write_page_exit(inode, page, ret);
> > > > +     xas_unlock(&xas);
> > > > +     nfs_pageio_complete_read(&pgio);
> > > > +     nfs_netfs_put(pgio.pg_netfs);
> > > >  }
> > > > +
> > > > +void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr)
> > > > +{
> > > > +     struct nfs_netfs_io_data        *netfs = hdr->netfs;
> > > > +
> > > > +     if (!netfs)
> > > > +             return;
> > > > +
> > > > +     nfs_netfs_get(netfs);
> > > > +}
> > > > +
> > > > +void nfs_netfs_readpage_done(struct nfs_pgio_header *hdr)
> > > > +{
> > > > +     struct nfs_netfs_io_data        *netfs = hdr->netfs;
> > > > +
> > > > +     if (!netfs)
> > > > +             return;
> > > > +
> > > > +     if (hdr->res.op_status)
> > > > +             /*
> > > > +              * Retryable errors such as BAD_STATEID will be re-issued,
> > > > +              * so reduce refcount.
> > > > +              */
> > > > +             nfs_netfs_put(netfs);
> > > > +}
> > > > +
> > > > +void nfs_netfs_readpage_release(struct nfs_page *req)
> > > > +{
> > > > +     struct inode *inode = d_inode(nfs_req_openctx(req)->dentry);
> > > > +
> > > > +     /*
> > > > +      * If fscache is enabled, netfs will unlock pages.
> > > > +      */
> > > > +     if (netfs_inode(inode)->cache)
> > > > +             return;
> > > > +
> > > > +     unlock_page(req->wb_page);
> > > > +}
> > > > +
> > > > +void nfs_netfs_read_completion(struct nfs_pgio_header *hdr)
> > > > +{
> > > > +     struct nfs_netfs_io_data        *netfs = hdr->netfs;
> > > > +     struct netfs_io_subrequest      *sreq;
> > > > +
> > > > +     if (!netfs)
> > > > +             return;
> > > > +
> > > > +     sreq = netfs->sreq;
> > > > +     if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
> > > > +             __set_bit(NETFS_SREQ_CLEAR_TAIL, &sreq->flags);
> > > > +
> > > > +     if (hdr->error)
> > > > +             netfs->error = hdr->error;
> > > > +     else
> > > > +             atomic64_add(hdr->res.count, &netfs->transferred);
> > > > +
> > > > +     nfs_netfs_put(netfs);
> > > > +     hdr->netfs = NULL;
> > > > +}
> > > > +
> > > > +const struct netfs_request_ops nfs_netfs_ops = {
> > > > +     .init_request           = nfs_netfs_init_request,
> > > > +     .free_request           = nfs_netfs_free_request,
> > > > +     .begin_cache_operation  = nfs_netfs_begin_cache_operation,
> > > > +     .issue_read             = nfs_netfs_issue_read,
> > > > +     .clamp_length           = nfs_netfs_clamp_length
> > > > +};
> > > > diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
> > > > index 38614ed8f951..fb782b917235 100644
> > > > --- a/fs/nfs/fscache.h
> > > > +++ b/fs/nfs/fscache.h
> > > > @@ -34,6 +34,49 @@ struct nfs_fscache_inode_auxdata {
> > > >       u64     change_attr;
> > > >  };
> > > >
> > > > +struct nfs_netfs_io_data {
> > > > +     /*
> > > > +      * NFS may split a netfs_io_subrequest into multiple RPCs, each
> > > > +      * with their own read completion.  In netfs, we can only call
> > > > +      * netfs_subreq_terminated() once for each subrequest.  Use the
> > > > +      * refcount here to double as a marker of the last RPC completion,
> > > > +      * and only call netfs via netfs_subreq_terminated() once.
> > > > +      */
> > > > +     refcount_t                      refcount;
> > > > +     struct netfs_io_subrequest      *sreq;
> > > > +
> > > > +     /*
> > > > +      * Final disposition of the netfs_io_subrequest, sent in
> > > > +      * netfs_subreq_terminated()
> > > > +      */
> > > > +     atomic64_t      transferred;
> > > > +     int             error;
> > > > +};
> > > > +
> > > > +static inline void nfs_netfs_get(struct nfs_netfs_io_data *netfs)
> > > > +{
> > > > +     refcount_inc(&netfs->refcount);
> > > > +}
> > > > +
> > > > +static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
> > > > +{
> > > > +     /* Only the last RPC completion should call netfs_subreq_terminated() */
> > > > +     if (refcount_dec_and_test(&netfs->refcount)) {
> > > > +             netfs_subreq_terminated(netfs->sreq,
> > > > +                                     netfs->error ?: atomic64_read(&netfs->transferred),
> > > > +                                     false);
> > > > +             kfree(netfs);
> > > > +     }
> > > > +}
> > > > +static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
> > > > +{
> > > > +     netfs_inode_init(&nfsi->netfs, &nfs_netfs_ops);
> > > > +}
> > > > +extern void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr);
> > > > +extern void nfs_netfs_readpage_done(struct nfs_pgio_header *hdr);
> > > > +extern void nfs_netfs_read_completion(struct nfs_pgio_header *hdr);
> > > > +extern void nfs_netfs_readpage_release(struct nfs_page *req);
> > > > +
> > > >  /*
> > > >   * fscache.c
> > > >   */
> > > > @@ -44,9 +87,8 @@ extern void nfs_fscache_init_inode(struct inode *);
> > > >  extern void nfs_fscache_clear_inode(struct inode *);
> > > >  extern void nfs_fscache_open_file(struct inode *, struct file *);
> > > >  extern void nfs_fscache_release_file(struct inode *, struct file *);
> > > > -
> > > > -extern int __nfs_fscache_read_page(struct inode *, struct page *);
> > > > -extern void __nfs_fscache_write_page(struct inode *, struct page *);
> > > > +extern int nfs_netfs_readahead(struct readahead_control *ractl);
> > > > +extern int nfs_netfs_read_folio(struct file *file, struct folio *folio);
> > > >
> > > >  static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
> > > >  {
> > > > @@ -54,34 +96,11 @@ static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
> > > >               if (current_is_kswapd() || !(gfp & __GFP_FS))
> > > >                       return false;
> > > >               folio_wait_fscache(folio);
> > > > -             fscache_note_page_release(netfs_i_cookie(&NFS_I(folio->mapping->host)->netfs));
> > > > -             nfs_inc_fscache_stats(folio->mapping->host,
> > > > -                                   NFSIOS_FSCACHE_PAGES_UNCACHED);
> > > >       }
> > > > +     fscache_note_page_release(netfs_i_cookie(&NFS_I(folio->mapping->host)->netfs));
> > > >       return true;
> > > >  }
> > > >
> > > > -/*
> > > > - * Retrieve a page from an inode data storage object.
> > > > - */
> > > > -static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
> > > > -{
> > > > -     if (netfs_inode(inode)->cache)
> > > > -             return __nfs_fscache_read_page(inode, page);
> > > > -     return -ENOBUFS;
> > > > -}
> > > > -
> > > > -/*
> > > > - * Store a page newly fetched from the server in an inode data storage object
> > > > - * in the cache.
> > > > - */
> > > > -static inline void nfs_fscache_write_page(struct inode *inode,
> > > > -                                        struct page *page)
> > > > -{
> > > > -     if (netfs_inode(inode)->cache)
> > > > -             __nfs_fscache_write_page(inode, page);
> > > > -}
> > > > -
> > > >  static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
> > > >                                             struct inode *inode)
> > > >  {
> > > > @@ -118,6 +137,14 @@ static inline const char *nfs_server_fscache_state(struct nfs_server *server)
> > > >  }
> > > >
> > > >  #else /* CONFIG_NFS_FSCACHE */
> > > > +static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi) {}
> > > > +static inline void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr) {}
> > > > +static inline void nfs_netfs_readpage_done(struct nfs_pgio_header *hdr) {}
> > > > +static inline void nfs_netfs_read_completion(struct nfs_pgio_header *hdr) {}
> > > > +static inline void nfs_netfs_readpage_release(struct nfs_page *req)
> > > > +{
> > > > +     unlock_page(req->wb_page);
> > > > +}
> > > >  static inline void nfs_fscache_release_super_cookie(struct super_block *sb) {}
> > > >
> > > >  static inline void nfs_fscache_init_inode(struct inode *inode) {}
> > > > @@ -125,16 +152,19 @@ static inline void nfs_fscache_clear_inode(struct inode *inode) {}
> > > >  static inline void nfs_fscache_open_file(struct inode *inode,
> > > >                                        struct file *filp) {}
> > > >  static inline void nfs_fscache_release_file(struct inode *inode, struct file *file) {}
> > > > -
> > > > -static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
> > > > +static inline int nfs_netfs_readahead(struct readahead_control *ractl)
> > > >  {
> > > > -     return true; /* may release folio */
> > > > +     return -ENOBUFS;
> > > >  }
> > > > -static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
> > > > +static inline int nfs_netfs_read_folio(struct file *file, struct folio *folio)
> > > >  {
> > > >       return -ENOBUFS;
> > > >  }
> > > > -static inline void nfs_fscache_write_page(struct inode *inode, struct page *page) {}
> > > > +
> > > > +static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
> > > > +{
> > > > +     return true; /* may release folio */
> > > > +}
> > > >  static inline void nfs_fscache_invalidate(struct inode *inode, int flags) {}
> > > >
> > > >  static inline const char *nfs_server_fscache_state(struct nfs_server *server)
> > > > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > > > index aa2aec785ab5..b36a02b932e8 100644
> > > > --- a/fs/nfs/inode.c
> > > > +++ b/fs/nfs/inode.c
> > > > @@ -2249,6 +2249,8 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
> > > >  #ifdef CONFIG_NFS_V4_2
> > > >       nfsi->xattr_cache = NULL;
> > > >  #endif
> > > > +     nfs_netfs_inode_init(nfsi);
> > > > +
> > > >       return VFS_I(nfsi);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nfs_alloc_inode);
> > > > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > > > index 273687082992..e5589036c1f8 100644
> > > > --- a/fs/nfs/internal.h
> > > > +++ b/fs/nfs/internal.h
> > > > @@ -453,6 +453,10 @@ extern void nfs_sb_deactive(struct super_block *sb);
> > > >  extern int nfs_client_for_each_server(struct nfs_client *clp,
> > > >                                     int (*fn)(struct nfs_server *, void *),
> > > >                                     void *data);
> > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > +extern const struct netfs_request_ops nfs_netfs_ops;
> > > > +#endif
> > > > +
> > > >  /* io.c */
> > > >  extern void nfs_start_io_read(struct inode *inode);
> > > >  extern void nfs_end_io_read(struct inode *inode);
> > > > @@ -482,9 +486,14 @@ extern int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh *mntfh, bool
> > > >
> > > >  struct nfs_pgio_completion_ops;
> > > >  /* read.c */
> > > > +extern const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
> > > >  extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
> > > >                       struct inode *inode, bool force_mds,
> > > >                       const struct nfs_pgio_completion_ops *compl_ops);
> > > > +extern int nfs_pageio_add_page(struct nfs_pageio_descriptor *pgio,
> > > > +                            struct nfs_open_context *ctx,
> > > > +                            struct page *page);
> > > > +extern void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio);
> > > >  extern void nfs_read_prepare(struct rpc_task *task, void *calldata);
> > > >  extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
> > > >
> > > > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > > > index 317cedfa52bf..e28754476d1b 100644
> > > > --- a/fs/nfs/pagelist.c
> > > > +++ b/fs/nfs/pagelist.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include "internal.h"
> > > >  #include "pnfs.h"
> > > >  #include "nfstrace.h"
> > > > +#include "fscache.h"
> > > >
> > > >  #define NFSDBG_FACILITY              NFSDBG_PAGECACHE
> > > >
> > > > @@ -68,6 +69,10 @@ void nfs_pgheader_init(struct nfs_pageio_descriptor *desc,
> > > >       hdr->good_bytes = mirror->pg_count;
> > > >       hdr->io_completion = desc->pg_io_completion;
> > > >       hdr->dreq = desc->pg_dreq;
> > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > +     if (desc->pg_netfs)
> > > > +             hdr->netfs = desc->pg_netfs;
> > > > +#endif
> > > >       hdr->release = release;
> > > >       hdr->completion_ops = desc->pg_completion_ops;
> > > >       if (hdr->completion_ops->init_hdr)
> > > > @@ -846,6 +851,9 @@ void nfs_pageio_init(struct nfs_pageio_descriptor *desc,
> > > >       desc->pg_lseg = NULL;
> > > >       desc->pg_io_completion = NULL;
> > > >       desc->pg_dreq = NULL;
> > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > +     desc->pg_netfs = NULL;
> > > > +#endif
> > > >       desc->pg_bsize = bsize;
> > > >
> > > >       desc->pg_mirror_count = 1;
> > > > @@ -940,6 +948,7 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
> > > >       /* Set up the argument struct */
> > > >       nfs_pgio_rpcsetup(hdr, mirror->pg_count, desc->pg_ioflags, &cinfo);
> > > >       desc->pg_rpc_callops = &nfs_pgio_common_ops;
> > > > +
> > > >       return 0;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nfs_generic_pgio);
> > > > @@ -1360,6 +1369,9 @@ int nfs_pageio_resend(struct nfs_pageio_descriptor *desc,
> > > >
> > > >       desc->pg_io_completion = hdr->io_completion;
> > > >       desc->pg_dreq = hdr->dreq;
> > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > +     desc->pg_netfs = hdr->netfs;
> > > > +#endif
> > > >       list_splice_init(&hdr->pages, &pages);
> > > >       while (!list_empty(&pages)) {
> > > >               struct nfs_page *req = nfs_list_entry(pages.next);
> > > > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > > > index 525e82ea9a9e..c74c5fcba87d 100644
> > > > --- a/fs/nfs/read.c
> > > > +++ b/fs/nfs/read.c
> > > > @@ -30,7 +30,7 @@
> > > >
> > > >  #define NFSDBG_FACILITY              NFSDBG_PAGECACHE
> > > >
> > > > -static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
> > > > +const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
> > > >  static const struct nfs_rw_ops nfs_rw_read_ops;
> > > >
> > > >  static struct kmem_cache *nfs_rdata_cachep;
> > > > @@ -74,7 +74,7 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
> > > >
> > > > -static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
> > > > +void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
> > > >  {
> > > >       struct nfs_pgio_mirror *pgm;
> > > >       unsigned long npages;
> > > > @@ -110,20 +110,13 @@ EXPORT_SYMBOL_GPL(nfs_pageio_reset_read_mds);
> > > >
> > > >  static void nfs_readpage_release(struct nfs_page *req, int error)
> > > >  {
> > > > -     struct inode *inode = d_inode(nfs_req_openctx(req)->dentry);
> > > >       struct page *page = req->wb_page;
> > > >
> > > > -     dprintk("NFS: read done (%s/%llu %d@%lld)\n", inode->i_sb->s_id,
> > > > -             (unsigned long long)NFS_FILEID(inode), req->wb_bytes,
> > > > -             (long long)req_offset(req));
> > > > -
> > > >       if (nfs_error_is_fatal_on_server(error) && error != -ETIMEDOUT)
> > > >               SetPageError(page);
> > > > -     if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
> > > > -             if (PageUptodate(page))
> > > > -                     nfs_fscache_write_page(inode, page);
> > > > -             unlock_page(page);
> > > > -     }
> > > > +     if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))
> > > > +             nfs_netfs_readpage_release(req);
> > > > +
> > > >       nfs_release_request(req);
> > > >  }
> > > >
> > > > @@ -177,6 +170,8 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
> > > >               nfs_list_remove_request(req);
> > > >               nfs_readpage_release(req, error);
> > > >       }
> > > > +     nfs_netfs_read_completion(hdr);
> > > > +
> > > >  out:
> > > >       hdr->release(hdr);
> > > >  }
> > > > @@ -187,6 +182,7 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
> > > >                             struct rpc_task_setup *task_setup_data, int how)
> > > >  {
> > > >       rpc_ops->read_setup(hdr, msg);
> > > > +     nfs_netfs_initiate_read(hdr);
> > > >       trace_nfs_initiate_read(hdr);
> > > >  }
> > > >
> > > > @@ -202,7 +198,7 @@ nfs_async_read_error(struct list_head *head, int error)
> > > >       }
> > > >  }
> > > >
> > > > -static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
> > > > +const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
> > > >       .error_cleanup = nfs_async_read_error,
> > > >       .completion = nfs_read_completion,
> > > >  };
> > > > @@ -219,6 +215,7 @@ static int nfs_readpage_done(struct rpc_task *task,
> > > >       if (status != 0)
> > > >               return status;
> > > >
> > > > +     nfs_netfs_readpage_done(hdr);
> > > >       nfs_add_stats(inode, NFSIOS_SERVERREADBYTES, hdr->res.count);
> > > >       trace_nfs_readpage_done(task, hdr);
> > > >
> > > > @@ -294,12 +291,6 @@ nfs_pageio_add_page(struct nfs_pageio_descriptor *pgio,
> > > >
> > > >       aligned_len = min_t(unsigned int, ALIGN(len, rsize), PAGE_SIZE);
> > > >
> > > > -     if (!IS_SYNC(page->mapping->host)) {
> > > > -             error = nfs_fscache_read_page(page->mapping->host, page);
> > > > -             if (error == 0)
> > > > -                     goto out_unlock;
> > > > -     }
> > > > -
> > > >       new = nfs_create_request(ctx, page, 0, aligned_len);
> > > >       if (IS_ERR(new))
> > > >               goto out_error;
> > > > @@ -315,8 +306,6 @@ nfs_pageio_add_page(struct nfs_pageio_descriptor *pgio,
> > > >       return 0;
> > > >  out_error:
> > > >       error = PTR_ERR(new);
> > > > -out_unlock:
> > > > -     unlock_page(page);
> > > >  out:
> > > >       return error;
> > > >  }
> > > > @@ -355,6 +344,10 @@ int nfs_read_folio(struct file *file, struct folio *folio)
> > > >       if (NFS_STALE(inode))
> > > >               goto out_unlock;
> > > >
> > > > +     ret = nfs_netfs_read_folio(file, folio);
> > > > +     if (!ret)
> > > > +             goto out;
> > > > +
> > > >       if (file == NULL) {
> > > >               ret = -EBADF;
> > > >               ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
> > > > @@ -368,8 +361,10 @@ int nfs_read_folio(struct file *file, struct folio *folio)
> > > >                            &nfs_async_read_completion_ops);
> > > >
> > > >       ret = nfs_pageio_add_page(&pgio, ctx, page);
> > > > -     if (ret)
> > > > -             goto out;
> > > > +     if (ret) {
> > > > +             put_nfs_open_context(ctx);
> > > > +             goto out_unlock;
> > > > +     }
> > > >
> > > >       nfs_pageio_complete_read(&pgio);
> > > >       ret = pgio.pg_error < 0 ? pgio.pg_error : 0;
> > > > @@ -378,12 +373,12 @@ int nfs_read_folio(struct file *file, struct folio *folio)
> > > >               if (!PageUptodate(page) && !ret)
> > > >                       ret = xchg(&ctx->error, 0);
> > > >       }
> > > > -out:
> > > >       put_nfs_open_context(ctx);
> > > > -     trace_nfs_aop_readpage_done(inode, page, ret);
> > > > -     return ret;
> > > > +     goto out;
> > > > +
> > > >  out_unlock:
> > > >       unlock_page(page);
> > > > +out:
> > > >       trace_nfs_aop_readpage_done(inode, page, ret);
> > > >       return ret;
> > > >  }
> > > > @@ -405,6 +400,10 @@ void nfs_readahead(struct readahead_control *ractl)
> > > >       if (NFS_STALE(inode))
> > > >               goto out;
> > > >
> > > > +     ret = nfs_netfs_readahead(ractl);
> > > > +     if (!ret)
> > > > +             goto out;
> > > > +
> > > >       if (file == NULL) {
> > > >               ret = -EBADF;
> > > >               ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
> > > > diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> > > > index ba7e2e4b0926..8eeb16d9bacd 100644
> > > > --- a/include/linux/nfs_page.h
> > > > +++ b/include/linux/nfs_page.h
> > > > @@ -101,6 +101,9 @@ struct nfs_pageio_descriptor {
> > > >       struct pnfs_layout_segment *pg_lseg;
> > > >       struct nfs_io_completion *pg_io_completion;
> > > >       struct nfs_direct_req   *pg_dreq;
> > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > +     void                    *pg_netfs;
> > > > +#endif
> > >
> > >
> > > Would it be possible to union this new field with pg_dreq? I don't think
> > > they're ever both used in the same desc. There are some places that
> > > check for pg_dreq == NULL that would need to be converted to use a new
> > > flag or something, but that would allow us to avoid growing this struct.
> > >
> >
> > Yeah it's a good point, though I'm not sure how easy it is.
> > I was also thinking about whether to drop the #ifdefs in the two structures
> > since the netfs NULL pointers are benign if unused.
> >
> > Do you mean something like the below - bit fields to indicate whether
> > the pointer is used or not?  There is an "io_flags" field inside
> > nfs_pageio_descriptor.  However, it is used for FLUSH_* flags,
> > so a new flag involving union members validity doesn't seem to fit there.
> > Not sure if this helps, but another way maybe to look at it is that
> > after this change, we could have 3 possibilities for nfs_pageio_descriptors
> > - netfs: right now only fscache enabled buffered READs are handled
> > - direct IO
> > - everything else: (neither direct nor netfs)
> >
> > It may be possible to unionize, but looks a bit tricky with things like
> > pnfs resends (see pnfs.c and callers of nfs_pageio_init_read and
> > nfs_pageio_init_write).  Might need to update the init functions for
> > nfs_pageio_descriptor and nfs_pgio_header and looks a bit messy.
> > Might be worth it but not sure - may take some time to work it out
> > safely.
> >
>
> I didn't put a lot of thought into the suggestion. I just noticed that
> the two fields aren't used at the same time and count potentially be
> unioned.
>
> My thinking was to use the pg_ioflags, but you're right that they are
> all named with FLUSH_* prefixes. They could be renamed though. The
> bitfield flags are another option tool.
>
> I'm not sure I follow the difficulty with nfs_pageio_init_{read,write}.
>
Once we get away from a NULL pointer dreq meaning something,
we get into issues with pnfs_read_done_resend_to_mds(),
pnfs_read_resend_pnfs(), and pnfs_write_done_resend_to_mds()
because a new nfs_pageio_descriptor is initialized from
nfs_pgio_header.  So then we need flags inside struct
nfs_pgio_header too.


> In any case, I'll leave it up to Trond/Anna whether they want this done
> before merging.
>
I took a stab at this but did not address the issues with nfs_pgio_header.
I am not sure about this type of change because it gets into refactoring
the main NFS IO path, which I think Trond has objected to.  Personally
I don't think this saving of a pointer is worth it, unless we get into other
refactoring of the IO path, and maybe add helpers for initializers of
these structures.  Plus there are other pointers in nfs_pageio_descriptor
as well that may or may not get used like "pg_lseg" so adding pg_netfs
seems reasonable to me.

Trond or Anna, any thoughts here?


---
 fs/nfs/direct.c          |  4 ++++
 fs/nfs/fscache.c         |  2 ++
 fs/nfs/pagelist.c        | 19 ++++++++-----------
 fs/nfs/pnfs.c            |  2 +-
 include/linux/nfs_page.h | 11 +++++++----
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1707f46b1335..92930280485d 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -324,6 +324,8 @@ static ssize_t
nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
                  &nfs_direct_read_completion_ops);
     get_dreq(dreq);
     desc.pg_dreq = dreq;
+    desc.pg_dreq_valid = 1;
+    desc.pg_netfs_valid = 0;
     inode_dio_begin(inode);

     while (iov_iter_count(iter)) {
@@ -526,6 +528,8 @@ static void nfs_direct_write_reschedule(struct
nfs_direct_req *dreq)
     nfs_pageio_init_write(&desc, dreq->inode, FLUSH_STABLE, false,
                   &nfs_direct_write_completion_ops);
     desc.pg_dreq = dreq;
+    desc.pg_dreq_valid = 1;
+    desc.pg_netfs_valid = 0;

     list_for_each_entry_safe(req, tmp, &reqs, wb_list) {
         /* Bump the transmission count */
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 9b7df3d61c35..9231815dd543 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -313,6 +313,8 @@ static void nfs_netfs_issue_read(struct
netfs_io_subrequest *sreq)
                  &nfs_async_read_completion_ops);

     pgio.pg_netfs = nfs_netfs_alloc(sreq); /* used in completion */
+    pgio.pg_netfs_valid = 1;
+    pgio.pg_dreq_valid = 0;
     if (!pgio.pg_netfs)
         return netfs_subreq_terminated(sreq, -ENOMEM, false);

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index e28754476d1b..461fc0c395a7 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -68,11 +68,10 @@ void nfs_pgheader_init(struct nfs_pageio_descriptor *desc,
     hdr->io_start = req_offset(hdr->req);
     hdr->good_bytes = mirror->pg_count;
     hdr->io_completion = desc->pg_io_completion;
-    hdr->dreq = desc->pg_dreq;
-#ifdef CONFIG_NFS_FSCACHE
-    if (desc->pg_netfs)
+    if (desc->pg_dreq_valid)
+        hdr->dreq = desc->pg_dreq;
+    if (desc->pg_netfs_valid)
         hdr->netfs = desc->pg_netfs;
-#endif
     hdr->release = release;
     hdr->completion_ops = desc->pg_completion_ops;
     if (hdr->completion_ops->init_hdr)
@@ -851,9 +850,7 @@ void nfs_pageio_init(struct nfs_pageio_descriptor *desc,
     desc->pg_lseg = NULL;
     desc->pg_io_completion = NULL;
     desc->pg_dreq = NULL;
-#ifdef CONFIG_NFS_FSCACHE
     desc->pg_netfs = NULL;
-#endif
     desc->pg_bsize = bsize;

     desc->pg_mirror_count = 1;
@@ -920,7 +917,7 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
         }
     }

-    nfs_init_cinfo(&cinfo, desc->pg_inode, desc->pg_dreq);
+    nfs_init_cinfo(&cinfo, desc->pg_inode, desc->pg_dreq_valid ?
desc->pg_dreq : NULL);
     pages = hdr->page_array.pagevec;
     last_page = NULL;
     pageused = 0;
@@ -1368,10 +1365,10 @@ int nfs_pageio_resend(struct
nfs_pageio_descriptor *desc,
     LIST_HEAD(pages);

     desc->pg_io_completion = hdr->io_completion;
-    desc->pg_dreq = hdr->dreq;
-#ifdef CONFIG_NFS_FSCACHE
-    desc->pg_netfs = hdr->netfs;
-#endif
+    if (desc->pg_dreq_valid)
+        desc->pg_dreq = hdr->dreq;
+    if (desc->pg_netfs_valid)
+        desc->pg_netfs = hdr->netfs;
     list_splice_init(&hdr->pages, &pages);
     while (!list_empty(&pages)) {
         struct nfs_page *req = nfs_list_entry(pages.next);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 035bf2eac2cf..d48a97df6f6b 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2708,7 +2708,7 @@ pnfs_generic_pg_init_read(struct
nfs_pageio_descriptor *pgio, struct nfs_page *r
     pnfs_generic_pg_check_layout(pgio);
     pnfs_generic_pg_check_range(pgio, req);
     if (pgio->pg_lseg == NULL) {
-        if (pgio->pg_dreq == NULL)
+        if (!pgio->pg_dreq_valid && pgio->pg_dreq == NULL)
             rd_size = i_size_read(pgio->pg_inode) - req_offset(req);
         else
             rd_size = nfs_dreq_bytes_left(pgio->pg_dreq);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 8eeb16d9bacd..82bb77ba57b7 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -100,10 +100,11 @@ struct nfs_pageio_descriptor {
     const struct nfs_pgio_completion_ops *pg_completion_ops;
     struct pnfs_layout_segment *pg_lseg;
     struct nfs_io_completion *pg_io_completion;
-    struct nfs_direct_req    *pg_dreq;
-#ifdef CONFIG_NFS_FSCACHE
-    void            *pg_netfs;
-#endif
+    union {
+        struct nfs_direct_req   *pg_dreq;  /* see pg_dreq_valid */
+        void                    *pg_netfs; /* see pg_netfs_valid */
+    };
+
     unsigned int        pg_bsize;    /* default bsize for mirrors */

     u32            pg_mirror_count;
@@ -113,6 +114,8 @@ struct nfs_pageio_descriptor {
     u32            pg_mirror_idx;    /* current mirror */
     unsigned short        pg_maxretrans;
     unsigned char        pg_moreio : 1;
+    unsigned char        pg_dreq_valid: 1;  /* pg_dreq is in use */
+    unsigned char        pg_netfs_valid: 1; /* pg_netfs is in use */
 };

 /* arbitrarily selected limit to number of mirrors */
-- 
2.35.3

