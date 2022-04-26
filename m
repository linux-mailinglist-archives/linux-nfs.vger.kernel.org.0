Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CD750EE60
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Apr 2022 03:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiDZCBw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Apr 2022 22:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiDZCBv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Apr 2022 22:01:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5057685678;
        Mon, 25 Apr 2022 18:58:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2B46210E6;
        Tue, 26 Apr 2022 01:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650938323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W56qHWh5atZr7qX9LectLL9QyYdxoZqmGcchx2rNVB4=;
        b=ogqpgOIm+QovqHgwGLsn9RVn9CyEzzokAjwoArjc0FitdWnkOX8V4EN9eIa5JXd1zom9/w
        BKmc/0RNe4fQgG/geFApwuWx0c+ez1vhbzfb6Gl41N3OXAXS0rOg58JN+oTJLKnnwDm/RM
        MlqqJbvANe/Nq9sY4aQCB9pAuWLHQ0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650938323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W56qHWh5atZr7qX9LectLL9QyYdxoZqmGcchx2rNVB4=;
        b=BuMEFM+hfm66Z/j3I5avfIiqZkmeyrUkcBGq3lyfGbZ51Qxqd0VwInnFDlXpWOuEdZuGgc
        PtQcE7PMEG1QHFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A75BD13A97;
        Tue, 26 Apr 2022 01:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VfdrGNFRZ2LhDgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Apr 2022 01:58:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "David Howells" <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH 09/10] MM: submit multipage write for SWP_FS_OPS swap-space
In-reply-to: <033ccf1a-c6b5-fd77-0ad0-4915ff07bc15@huawei.com>
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>,
 <164859778128.29473.5191868522654408537.stgit@noble.brown>,
 <033ccf1a-c6b5-fd77-0ad0-4915ff07bc15@huawei.com>
Date:   Tue, 26 Apr 2022 11:58:37 +1000
Message-id: <165093831774.1648.3187486020864614234@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 18 Apr 2022, Miaohe Lin wrote:
> On 2022/3/30 7:49, NeilBrown wrote:
> > swap_writepage() is given one page at a time, but may be called repeatedly
> > in succession.
> > For block-device swapspace, the blk_plug functionality allows the
> > multiple pages to be combined together at lower layers.
> > That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
> > only active when CONFIG_BLOCK=3Dy.  Consequently all swap reads over NFS
> > are single page reads.
> >=20
> > With this patch we pass a pointer-to-pointer via the wbc.
> > swap_writepage can store state between calls - much like the pointer
> > passed explicitly to swap_readpage.  After calling swap_writepage() some
> > number of times, the state will be passed to swap_write_unplug() which
> > can submit the combined request.
> >=20
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> ...
> > =20
> >  static int swap_writepage_fs(struct page *page, struct writeback_control=
 *wbc)
> >  {
> > -	struct swap_iocb *sio;
> > +	struct swap_iocb *sio =3D NULL;
> >  	struct swap_info_struct *sis =3D page_swap_info(page);
> >  	struct file *swap_file =3D sis->swap_file;
> > -	struct address_space *mapping =3D swap_file->f_mapping;
> > -	struct iov_iter from;
> > -	int ret;
> > +	loff_t pos =3D page_file_offset(page);
> > =20
> >  	set_page_writeback(page);
> >  	unlock_page(page);
> > -	sio =3D mempool_alloc(sio_pool, GFP_NOIO);
> > -	init_sync_kiocb(&sio->iocb, swap_file);
> > -	sio->iocb.ki_complete =3D sio_write_complete;
> > -	sio->iocb.ki_pos =3D page_file_offset(page);
> > -	sio->bvec[0].bv_page =3D page;
> > -	sio->bvec[0].bv_len =3D PAGE_SIZE;
> > -	sio->bvec[0].bv_offset =3D 0;
> > -	iov_iter_bvec(&from, WRITE, &sio->bvec[0], 1, PAGE_SIZE);
> > -	ret =3D mapping->a_ops->swap_rw(&sio->iocb, &from);
> > -	if (ret !=3D -EIOCBQUEUED)
> > -		sio_write_complete(&sio->iocb, ret);
> > -	return ret;
> > +	if (wbc->swap_plug)
> > +		sio =3D *wbc->swap_plug;
> > +	if (sio) {
> > +		if (sio->iocb.ki_filp !=3D swap_file ||
> > +		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE !=3D pos) {
> > +			swap_write_unplug(sio);
> > +			sio =3D NULL;
> > +		}
> > +	}
> > +	if (!sio) {
> > +		sio =3D mempool_alloc(sio_pool, GFP_NOIO);
> > +		init_sync_kiocb(&sio->iocb, swap_file);
> > +		sio->iocb.ki_complete =3D sio_write_complete;
> > +		sio->iocb.ki_pos =3D pos;
> > +		sio->pages =3D 0;
> > +	}
> > +	sio->bvec[sio->pages].bv_page =3D page;
> > +	sio->bvec[sio->pages].bv_len =3D PAGE_SIZE;
>=20
> Many thanks for your patch. And sorry for late responding and newbie questi=
on. Does swap_writepage_fs
> support transhuge page now? We could come across transhuge page here. But b=
v_len =3D=3D PAGE_SIZE and pages
> =3D=3D 1 is assumed here. Do we need something like below:
>=20
> sio->bvec[sio->pages].bv_len =3D thp_size(page);
> sio->pages +=3D thp_nr_pages(page);

Yes, that probably makes sense.  I'll have a closer look and maybe
resend later this week.

Thanks,
NeilBrown


>=20
> Thanks! :)
>=20
> > +	sio->bvec[sio->pages].bv_offset =3D 0;
> ...
> > .
> >=20
>=20
>=20
