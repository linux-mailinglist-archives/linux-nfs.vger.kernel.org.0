Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7879E706
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Sep 2023 13:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbjIMLky (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Sep 2023 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbjIMLkx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Sep 2023 07:40:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60AB10E6
        for <linux-nfs@vger.kernel.org>; Wed, 13 Sep 2023 04:40:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04725C433C7;
        Wed, 13 Sep 2023 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694605249;
        bh=qd5gBiyrK150ugsfoHUQJLyFJ28E/xMTIMNMAIByo8g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vqtlaon3HffdVhuKyOCYG6vkEaNLgDbYRjNKl+Zsj7xsFfvB0mk06SVvHRhiUH/Fp
         hdrM9kaB/o9Dl9gkPw/O27aDlUOyWAHxmohQlDBsm9ZcdJJozRuoIdhQvCg6oP6LlR
         n1YpyM3g+Rovb/ORmHIHuGhLaj3lzdlw12A3XSNLU+aWJ1d8ASQIVYLpVYL5V2JpyC
         M5kQELb8zavR1F5ZOYEzD71i8RLd87wWc0H7lM4hcGJIzLXm194zLaOd35WsGqz6kW
         oBf4K5L9t1lNl3XbWcz3Mh8m54/tcf/56qrObruIbMbr4d2OYgBouIhfWfhqjuIzOe
         45sdDQbk4RB6Q==
Message-ID: <1e47cd45f01fc996873387a6021a98874c0ee030.camel@kernel.org>
Subject: Re: [PATCH] netfs: Only call folio_start_fscache  time for each
 folio
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>
Date:   Wed, 13 Sep 2023 07:40:47 -0400
In-Reply-To: <3d7271bdcb81239fac471bdb2c4e4ff63d3a65b3.camel@kernel.org>
References: <20230608214137.856006-1-dwysocha@redhat.com>
         <3d7271bdcb81239fac471bdb2c4e4ff63d3a65b3.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-09-11 at 13:02 -0400, Jeff Layton wrote:
> On Thu, 2023-06-08 at 17:41 -0400, Dave Wysochanski wrote:
> > If a network filesystem using netfs implements a clamp_length()
> > function, it can set subrequest lengths smaller than a page size.
> > When we loop through the folios in netfs_rreq_unlock_folios() to
> > set any folios to be written back, we need to make sure we only
> > call folio_start_fscache() once for each folio.  Otherwise,
> > this simple testcase:
> >   mount -o fsc,rsize=3D1024,wsize=3D1024 127.0.0.1:/export /mnt/nfs
> >   dd if=3D/dev/zero of=3D/mnt/nfs/file.bin bs=3D4096 count=3D1
> >   1+0 records in
> >   1+0 records out
> >   4096 bytes (4.1 kB, 4.0 KiB) copied, 0.0126359 s, 324 kB/s
> >   cat /mnt/nfs/file.bin > /dev/null
> >=20
> > will trigger an oops similar to the following:
> > ...
> >  page dumped because: VM_BUG_ON_FOLIO(folio_test_private_2(folio))
> >  ------------[ cut here ]------------
> >  kernel BUG at include/linux/netfs.h:44!
> > ...
> >  CPU: 5 PID: 134 Comm: kworker/u16:5 Kdump: loaded Not tainted 6.4.0-rc=
5
> > ...
> >  RIP: 0010:netfs_rreq_unlock_folios+0x68e/0x730 [netfs]
> > ...
> >  Call Trace:
> >   <TASK>
> >   netfs_rreq_assess+0x497/0x660 [netfs]
> >   netfs_subreq_terminated+0x32b/0x610 [netfs]
> >   nfs_netfs_read_completion+0x14e/0x1a0 [nfs]
> >   nfs_read_completion+0x2f9/0x330 [nfs]
> >   rpc_free_task+0x72/0xa0 [sunrpc]
> >   rpc_async_release+0x46/0x70 [sunrpc]
> >   process_one_work+0x3bd/0x710
> >   worker_thread+0x89/0x610
> >   kthread+0x181/0x1c0
> >   ret_from_fork+0x29/0x50
> >=20
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  fs/netfs/buffered_read.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> > index 3404707ddbe7..0dafd970c1b6 100644
> > --- a/fs/netfs/buffered_read.c
> > +++ b/fs/netfs/buffered_read.c
> > @@ -21,6 +21,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request=
 *rreq)
> >  	pgoff_t last_page =3D ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
> >  	size_t account =3D 0;
> >  	bool subreq_failed =3D false;
> > +	bool folio_started;
>=20
> nit: I'd move this declaration inside the xas_for_each loop, and just
> initialize it to false there.
>=20
> > =20
> >  	XA_STATE(xas, &rreq->mapping->i_pages, start_epage);
> > =20
> > @@ -53,6 +54,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request=
 *rreq)
> > =20
> >  		pg_end =3D folio_pos(folio) + folio_size(folio) - 1;
> > =20
> > +		folio_started =3D false;
> >  		for (;;) {
> >  			loff_t sreq_end;
> > =20
> > @@ -60,8 +62,10 @@ void netfs_rreq_unlock_folios(struct netfs_io_reques=
t *rreq)
> >  				pg_failed =3D true;
> >  				break;
> >  			}
> > -			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
> > +			if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->f=
lags)) {
> >  				folio_start_fscache(folio);
> > +				folio_started =3D true;
> > +			}
> >  			pg_failed |=3D subreq_failed;
> >  			sreq_end =3D subreq->start + subreq->len - 1;
> >  			if (pg_end < sreq_end)
>=20
>=20
> The logic looks correct though.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

David, can you review/merge this patch? This apparently fixes a panic
with NFS and fscache.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
