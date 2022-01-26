Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6707749D4CC
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 23:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiAZWEg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 17:04:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39494 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiAZWEf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 17:04:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B51B1F37C;
        Wed, 26 Jan 2022 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643234674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQbpJm/4YcrM7846Lj5mc4Lilmm6Oo33cVYJ6Jnz2NE=;
        b=kKYSn/j05P7uOembzdhs2DLfQ+JclBWNfYe/3GAiUAUe3qfPOBn62eXAj8p6RTDh6sWWce
        1dBHl8GJWP42YBVqHFjmoDJV5Ou2rpTGNxyctz4XJbCP6wZpdz68fbXsfQYZOftAcXu+kn
        own0h4R9Rcsr+eygyUUwsUEwWPaMGAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643234674;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQbpJm/4YcrM7846Lj5mc4Lilmm6Oo33cVYJ6Jnz2NE=;
        b=cJTivAh/KsF+/5h2VR05WJzv+LAsUuIKmdroeSJCCVC+FXcL3OBPmF27p+BV+igQSIJDpH
        g4nKlaDEQKGdEZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BD7F13E37;
        Wed, 26 Jan 2022 22:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gZ0OLm7F8WFhSgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 26 Jan 2022 22:04:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mark Hemment" <markhemm@googlemail.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        "David Howells" <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/23] MM: submit multipage reads for SWP_FS_OPS swap-space
In-reply-to: <CANe_+UjJOZJwfFLMgenBttssB8G5ZW5fqw7Vi_tohF_HOW5wWg@mail.gmail.com>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>,
 <164299611278.26253.14950274629759580371.stgit@noble.brown>,
 <CANe_+UjJOZJwfFLMgenBttssB8G5ZW5fqw7Vi_tohF_HOW5wWg@mail.gmail.com>
Date:   Thu, 27 Jan 2022 09:04:27 +1100
Message-id: <164323466702.5493.9146602034937551582@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022, Mark Hemment wrote:
> On Mon, 24 Jan 2022 at 03:52, NeilBrown <neilb@suse.de> wrote:
> >
> > swap_readpage() is given one page at a time, but maybe called repeatedly
> > in succession.
> > For block-device swapspace, the blk_plug functionality allows the
> > multiple pages to be combined together at lower layers.
> > That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
> > only active when CONFIG_BLOCK=3Dy.  Consequently all swap reads over NFS
> > are single page reads.
> >
> > With this patch we pass in a pointer-to-pointer when swap_readpage can
> > store state between calls - much like the effect of blk_plug.  After
> > calling swap_readpage() some number of times, the state will be passed
> > to swap_read_unplug() which can submit the combined request.
> >
> > Some caller currently call blk_finish_plug() *before* the final call to
> > swap_readpage(), so the last page cannot be included.  This patch moves
> > blk_finish_plug() to after the last call, and calls swap_read_unplug()
> > there too.
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  mm/madvise.c    |    8 +++-
> >  mm/memory.c     |    2 +
> >  mm/page_io.c    |  102 +++++++++++++++++++++++++++++++++++--------------=
------
> >  mm/swap.h       |   16 +++++++--
> >  mm/swap_state.c |   19 +++++++---
> >  5 files changed, 98 insertions(+), 49 deletions(-)
> >
> ...
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index 6e32ca35d9b6..bcf655d650c8 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -390,46 +391,60 @@ int __swap_writepage(struct page *page, struct writ=
eback_control *wbc,
> >  static void sio_read_complete(struct kiocb *iocb, long ret)
> >  {
> >         struct swap_iocb *sio =3D container_of(iocb, struct swap_iocb, io=
cb);
> > -       struct page *page =3D sio->bvec.bv_page;
> > -
> > -       if (ret !=3D 0 && ret !=3D PAGE_SIZE) {
> > -               SetPageError(page);
> > -               ClearPageUptodate(page);
> > -               pr_alert_ratelimited("Read-error on swap-device\n");
> > -       } else {
> > -               SetPageUptodate(page);
> > -               count_vm_event(PSWPIN);
> > +       int p;
> > +
> > +       for (p =3D 0; p < sio->pages; p++) {
> > +               struct page *page =3D sio->bvec[p].bv_page;
> > +               if (ret !=3D 0 && ret !=3D PAGE_SIZE * sio->pages) {
> > +                       SetPageError(page);
> > +                       ClearPageUptodate(page);
> > +                       pr_alert_ratelimited("Read-error on swap-device\n=
");
> > +               } else {
> > +                       SetPageUptodate(page);
> > +                       count_vm_event(PSWPIN);
> > +               }
> > +               unlock_page(page);
> >         }
> > -       unlock_page(page);
> >         mempool_free(sio, sio_pool);
> >  }
>=20
> Trivial: on success, could be single call to count_vm_events(PSWPIN,
> sio->pages).
> Similar comment for PSWPOUT in sio_write_complete()
>=20
> >
> > -static int swap_readpage_fs(struct page *page)
> > +static void swap_readpage_fs(struct page *page,
> > +                            struct swap_iocb **plug)
> >  {
> >         struct swap_info_struct *sis =3D page_swap_info(page);
> > -       struct file *swap_file =3D sis->swap_file;
> > -       struct address_space *mapping =3D swap_file->f_mapping;
> > -       struct iov_iter from;
> > -       struct swap_iocb *sio;
> > +       struct swap_iocb *sio =3D NULL;
> >         loff_t pos =3D page_file_offset(page);
> > -       int ret;
> > -
> > -       sio =3D mempool_alloc(sio_pool, GFP_KERNEL);
> > -       init_sync_kiocb(&sio->iocb, swap_file);
> > -       sio->iocb.ki_pos =3D pos;
> > -       sio->iocb.ki_complete =3D sio_read_complete;
> > -       sio->bvec.bv_page =3D page;
> > -       sio->bvec.bv_len =3D PAGE_SIZE;
> > -       sio->bvec.bv_offset =3D 0;
> >
> > -       iov_iter_bvec(&from, READ, &sio->bvec, 1, PAGE_SIZE);
> > -       ret =3D mapping->a_ops->swap_rw(&sio->iocb, &from);
> > -       if (ret !=3D -EIOCBQUEUED)
> > -               sio_read_complete(&sio->iocb, ret);
> > -       return ret;
> > +       if (*plug)
> > +               sio =3D *plug;
>=20
> 'plug' can be NULL when called from do_swap_page();
>         if (plug && *plug)

Thanks for catching that!  I actually want it to be
   if (plug)
       sio =3D *plug;

which nicely balances the
   if (plug)
       *plug =3D sio;
at the end of the function.

Thanks,
NeilBrown
