Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0C5169C3
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 06:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382274AbiEBE07 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 00:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382115AbiEBE05 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 00:26:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C80317058;
        Sun,  1 May 2022 21:23:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B002321878;
        Mon,  2 May 2022 04:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651465407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=koJtgn8z5L2IKkSD/2s/3JZQSkytsTKZddFVSeo5lv0=;
        b=quHyzEBZI/hFJxAODyZ6SYf7jBWrXNzfFYxaegPRUvURKNtylYs+nubEyujozSqFVvlrV9
        dDJUaO5FlohK4AnSsOUgegd5Uvk3ozxJlqYZ/NeqnKdmPgleKu/KkepA7i3o6X6FBSTx/5
        65czRDVc2g0/LsteAky2c2PcGMFxz+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651465407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=koJtgn8z5L2IKkSD/2s/3JZQSkytsTKZddFVSeo5lv0=;
        b=B+6at1NSyfDjOVtOGy4LUUMtE45pQAIkTmJfepplYFk6VKuyyL/VJglcpgN8v2ExQY7aOP
        ptwxm4CkGGuEnTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E69D13491;
        Mon,  2 May 2022 04:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ClUsDrxcb2LnOgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 May 2022 04:23:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Yang Shi" <shy828301@gmail.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Christoph Hellwig" <hch@lst.de>,
        "Miaohe Lin" <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        "Linux MM" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MM: handle THP in swap_*page_fs()
In-reply-to: <CAHbLzko+9nBem8GnxQJ8RQu7bizQMMmS1TNqbRXcgkjUs+JuMw@mail.gmail.com>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>,
 <165119301488.15698.9457662928942765453.stgit@noble.brown>,
 <CAHbLzko+9nBem8GnxQJ8RQu7bizQMMmS1TNqbRXcgkjUs+JuMw@mail.gmail.com>
Date:   Mon, 02 May 2022 14:23:16 +1000
Message-id: <165146539609.24404.4051313590023463843@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 30 Apr 2022, Yang Shi wrote:
> On Thu, Apr 28, 2022 at 5:44 PM NeilBrown <neilb@suse.de> wrote:
> >
> > Pages passed to swap_readpage()/swap_writepage() are not necessarily all
> > the same size - there may be transparent-huge-pages involves.
> >
> > The BIO paths of swap_*page() handle this correctly, but the SWP_FS_OPS
> > path does not.
> >
> > So we need to use thp_size() to find the size, not just assume
> > PAGE_SIZE, and we need to track the total length of the request, not
> > just assume it is "page * PAGE_SIZE".
>=20
> Swap-over-nfs doesn't support THP swap IIUC. So SWP_FS_OPS should not
> see THP at all. But I agree to remove the assumption about page size
> in this path.

Can you help me understand this please.  How would the swap code know
that swap-over-NFS doesn't support THP swap?  There is no reason that
NFS wouldn't be able to handle 2MB writes.  Even 1GB should work though
NFS would have to split into several smaller WRITE requests.

Thanks,
NeilBrown


>=20
> >
> > Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  mm/page_io.c |   23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index c132511f521c..d636a3531cad 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -239,6 +239,7 @@ struct swap_iocb {
> >         struct kiocb            iocb;
> >         struct bio_vec          bvec[SWAP_CLUSTER_MAX];
> >         int                     pages;
> > +       int                     len;
> >  };
> >  static mempool_t *sio_pool;
> >
> > @@ -261,7 +262,7 @@ static void sio_write_complete(struct kiocb *iocb, lo=
ng ret)
> >         struct page *page =3D sio->bvec[0].bv_page;
> >         int p;
> >
> > -       if (ret !=3D PAGE_SIZE * sio->pages) {
> > +       if (ret !=3D sio->len) {
> >                 /*
> >                  * In the case of swap-over-nfs, this can be a
> >                  * temporary failure if the system has limited
> > @@ -301,7 +302,7 @@ static int swap_writepage_fs(struct page *page, struc=
t writeback_control *wbc)
> >                 sio =3D *wbc->swap_plug;
> >         if (sio) {
> >                 if (sio->iocb.ki_filp !=3D swap_file ||
> > -                   sio->iocb.ki_pos + sio->pages * PAGE_SIZE !=3D pos) {
> > +                   sio->iocb.ki_pos + sio->len !=3D pos) {
> >                         swap_write_unplug(sio);
> >                         sio =3D NULL;
> >                 }
> > @@ -312,10 +313,12 @@ static int swap_writepage_fs(struct page *page, str=
uct writeback_control *wbc)
> >                 sio->iocb.ki_complete =3D sio_write_complete;
> >                 sio->iocb.ki_pos =3D pos;
> >                 sio->pages =3D 0;
> > +               sio->len =3D 0;
> >         }
> >         sio->bvec[sio->pages].bv_page =3D page;
> > -       sio->bvec[sio->pages].bv_len =3D PAGE_SIZE;
> > +       sio->bvec[sio->pages].bv_len =3D thp_size(page);
> >         sio->bvec[sio->pages].bv_offset =3D 0;
> > +       sio->len +=3D thp_size(page);
> >         sio->pages +=3D 1;
> >         if (sio->pages =3D=3D ARRAY_SIZE(sio->bvec) || !wbc->swap_plug) {
> >                 swap_write_unplug(sio);
> > @@ -371,8 +374,7 @@ void swap_write_unplug(struct swap_iocb *sio)
> >         struct address_space *mapping =3D sio->iocb.ki_filp->f_mapping;
> >         int ret;
> >
> > -       iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages,
> > -                     PAGE_SIZE * sio->pages);
> > +       iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages, sio->len);
> >         ret =3D mapping->a_ops->swap_rw(&sio->iocb, &from);
> >         if (ret !=3D -EIOCBQUEUED)
> >                 sio_write_complete(&sio->iocb, ret);
> > @@ -383,7 +385,7 @@ static void sio_read_complete(struct kiocb *iocb, lon=
g ret)
> >         struct swap_iocb *sio =3D container_of(iocb, struct swap_iocb, io=
cb);
> >         int p;
> >
> > -       if (ret =3D=3D PAGE_SIZE * sio->pages) {
> > +       if (ret =3D=3D sio->len) {
> >                 for (p =3D 0; p < sio->pages; p++) {
> >                         struct page *page =3D sio->bvec[p].bv_page;
> >
> > @@ -415,7 +417,7 @@ static void swap_readpage_fs(struct page *page,
> >                 sio =3D *plug;
> >         if (sio) {
> >                 if (sio->iocb.ki_filp !=3D sis->swap_file ||
> > -                   sio->iocb.ki_pos + sio->pages * PAGE_SIZE !=3D pos) {
> > +                   sio->iocb.ki_pos + sio->len !=3D pos) {
> >                         swap_read_unplug(sio);
> >                         sio =3D NULL;
> >                 }
> > @@ -426,10 +428,12 @@ static void swap_readpage_fs(struct page *page,
> >                 sio->iocb.ki_pos =3D pos;
> >                 sio->iocb.ki_complete =3D sio_read_complete;
> >                 sio->pages =3D 0;
> > +               sio->len =3D 0;
> >         }
> >         sio->bvec[sio->pages].bv_page =3D page;
> > -       sio->bvec[sio->pages].bv_len =3D PAGE_SIZE;
> > +       sio->bvec[sio->pages].bv_len =3D thp_size(page);
> >         sio->bvec[sio->pages].bv_offset =3D 0;
> > +       sio->len +=3D thp_size(page);
> >         sio->pages +=3D 1;
> >         if (sio->pages =3D=3D ARRAY_SIZE(sio->bvec) || !plug) {
> >                 swap_read_unplug(sio);
> > @@ -521,8 +525,7 @@ void __swap_read_unplug(struct swap_iocb *sio)
> >         struct address_space *mapping =3D sio->iocb.ki_filp->f_mapping;
> >         int ret;
> >
> > -       iov_iter_bvec(&from, READ, sio->bvec, sio->pages,
> > -                     PAGE_SIZE * sio->pages);
> > +       iov_iter_bvec(&from, READ, sio->bvec, sio->pages, sio->len);
> >         ret =3D mapping->a_ops->swap_rw(&sio->iocb, &from);
> >         if (ret !=3D -EIOCBQUEUED)
> >                 sio_read_complete(&sio->iocb, ret);
> >
> >
> >
>=20
