Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467B379BDDB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355548AbjIKWAn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjIKRCl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 13:02:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01AF127
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 10:02:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA91C433C7;
        Mon, 11 Sep 2023 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694451756;
        bh=SmBjocv8IcfIoepIrvAtFygjn3bdJe4VUU/7MxLBt/k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mquS37rcCZD8TTy2GV6rUK6VSOQfoqMmIJUDHUTpDJZ9F4/CgDOWADrA8aZPk1KDP
         xGv0XbLQq8f+f14VKDFshC1EXa2GkNOaqIsoON2U0aUlRNd1QXOIF3XccAB3PDWMg1
         Sjp2TPBRAYbwXgM0/ysZ3xlIbgfACiJg7KBbW1neGWEA0GRv3Q/RhdVy/nw9iWuPEz
         jbcteseNf0P/y0zy4Rdh1L3EWLUet1hkL46+679b3l/VVdS52/P5erG8QQRvOGROQn
         P2a9yskTqUzZsx+9NlBqSfQ76jZAtnjWRfLNmkKugm+0fDq7pBuskrYf8sfsin2lfb
         XcLqINfcEw62w==
Message-ID: <3d7271bdcb81239fac471bdb2c4e4ff63d3a65b3.camel@kernel.org>
Subject: Re: [PATCH] netfs: Only call folio_start_fscache  time for each
 folio
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Wysochanski <dwysocha@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Date:   Mon, 11 Sep 2023 13:02:34 -0400
In-Reply-To: <20230608214137.856006-1-dwysocha@redhat.com>
References: <20230608214137.856006-1-dwysocha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-06-08 at 17:41 -0400, Dave Wysochanski wrote:
> If a network filesystem using netfs implements a clamp_length()
> function, it can set subrequest lengths smaller than a page size.
> When we loop through the folios in netfs_rreq_unlock_folios() to
> set any folios to be written back, we need to make sure we only
> call folio_start_fscache() once for each folio.  Otherwise,
> this simple testcase:
>   mount -o fsc,rsize=3D1024,wsize=3D1024 127.0.0.1:/export /mnt/nfs
>   dd if=3D/dev/zero of=3D/mnt/nfs/file.bin bs=3D4096 count=3D1
>   1+0 records in
>   1+0 records out
>   4096 bytes (4.1 kB, 4.0 KiB) copied, 0.0126359 s, 324 kB/s
>   cat /mnt/nfs/file.bin > /dev/null
>=20
> will trigger an oops similar to the following:
> ...
>  page dumped because: VM_BUG_ON_FOLIO(folio_test_private_2(folio))
>  ------------[ cut here ]------------
>  kernel BUG at include/linux/netfs.h:44!
> ...
>  CPU: 5 PID: 134 Comm: kworker/u16:5 Kdump: loaded Not tainted 6.4.0-rc5
> ...
>  RIP: 0010:netfs_rreq_unlock_folios+0x68e/0x730 [netfs]
> ...
>  Call Trace:
>   <TASK>
>   netfs_rreq_assess+0x497/0x660 [netfs]
>   netfs_subreq_terminated+0x32b/0x610 [netfs]
>   nfs_netfs_read_completion+0x14e/0x1a0 [nfs]
>   nfs_read_completion+0x2f9/0x330 [nfs]
>   rpc_free_task+0x72/0xa0 [sunrpc]
>   rpc_async_release+0x46/0x70 [sunrpc]
>   process_one_work+0x3bd/0x710
>   worker_thread+0x89/0x610
>   kthread+0x181/0x1c0
>   ret_from_fork+0x29/0x50
>=20
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/netfs/buffered_read.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 3404707ddbe7..0dafd970c1b6 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -21,6 +21,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *=
rreq)
>  	pgoff_t last_page =3D ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
>  	size_t account =3D 0;
>  	bool subreq_failed =3D false;
> +	bool folio_started;

nit: I'd move this declaration inside the xas_for_each loop, and just
initialize it to false there.

> =20
>  	XA_STATE(xas, &rreq->mapping->i_pages, start_epage);
> =20
> @@ -53,6 +54,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *=
rreq)
> =20
>  		pg_end =3D folio_pos(folio) + folio_size(folio) - 1;
> =20
> +		folio_started =3D false;
>  		for (;;) {
>  			loff_t sreq_end;
> =20
> @@ -60,8 +62,10 @@ void netfs_rreq_unlock_folios(struct netfs_io_request =
*rreq)
>  				pg_failed =3D true;
>  				break;
>  			}
> -			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
> +			if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->fla=
gs)) {
>  				folio_start_fscache(folio);
> +				folio_started =3D true;
> +			}
>  			pg_failed |=3D subreq_failed;
>  			sreq_end =3D subreq->start + subreq->len - 1;
>  			if (pg_end < sreq_end)


The logic looks correct though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
