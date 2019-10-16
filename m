Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2BDA027
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 00:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392600AbfJPWIc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 18:08:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439085AbfJPWIb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Oct 2019 18:08:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92831AF6A;
        Wed, 16 Oct 2019 22:08:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@gmail.com>, linux-nfs@vger.kernel.org
Date:   Thu, 17 Oct 2019 09:08:22 +1100
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH 3/3] SUNRPC: Destroy the back channel when we destroy the host transport
In-Reply-To: <20191016141546.32277-3-trond.myklebust@hammerspace.com>
References: <20191016141546.32277-1-trond.myklebust@hammerspace.com> <20191016141546.32277-2-trond.myklebust@hammerspace.com> <20191016141546.32277-3-trond.myklebust@hammerspace.com>
Message-ID: <87sgnspcmh.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16 2019, Trond Myklebust wrote:

> When we're destroying the host transport mechanism, we should ensure
> that we do not leak memory by failing to release any back channel
> slots that might still exist.
>
> Reported-by: Neil Brown <neilb@suse.de>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/xprt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 8a45b3ccc313..41df4c507193 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -1942,6 +1942,11 @@ static void xprt_destroy_cb(struct work_struct *wo=
rk)
>  	rpc_destroy_wait_queue(&xprt->sending);
>  	rpc_destroy_wait_queue(&xprt->backlog);
>  	kfree(xprt->servername);
> +	/*
> +	 * Destroy any existing back channel
> +	 */
> +	xprt_destroy_backchannel(xprt, UINT_MAX);
> +

This will cause xprt->bc_alloc_max to become meaningless.
That isn't really a problem as the xprt is about to be freed, but it
still seems a little untidy - fragile maybe.
How about another line in the comment:

   * Note: this corrupts ->bc_alloc_max, but it is too late for that to
   * matter.
??

Also, possibly add
 WARN_ON(atomic_read(&xprt->bc_slot_count);
either before or after the xprt_destroy_backchannel - because there
really shouldn't be any requests by this stage.

Thanks,
NeilBrown


>  	/*
>  	 * Tear down transport state and free the rpc_xprt
>  	 */
> --=20
> 2.21.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2nlNcACgkQOeye3VZi
gbk+Eg//ZQqXhWg0FBjoaDCiNvatLbCmR8H3rATecZU1mjJl3qxbf6kAyIPAwTnT
UnC7ExvaiNFFpYj5nS3OBaLOQQLtt558C4V+KXYDTddemZ5IbRSCYje3fh1ASq+V
LPzNxxcEfnbIOGHnhEpDccr8oua6V0drN10N6sYw/Zc+CeX7GQ9Xc0QanVuWMCbs
z3spFOvYqIN+hQIPI1yDpBvqM/bd3yuus55qAp/Loti1+5iY7hRGXixfw/59dWwx
IbOi+CWUzQ5gh0sMUM3GPZJg391l5zUXQP+TxPaVr6WRHykrvDKv00N2CJm0VIGW
PXgzCcCXLizGnj+0DDDhL6ahqH186Sy0IU5VFAgtFxf2xQmsBM8f4MRqdjn1so/7
XwP7VUzkPL32gW3zwGWF8+iQ3uZUNE0/PB5zsZcok5pEwE+O4SJzb+SFPtyMO8jI
3mUtZFKHmrvUuiAURR4SS2SR+dWljDF8wG9jJvu35gAecJHSptVQK7NUNxbSuJMS
c8opfZ2Gp+lFzWDCk9qRcO13eXLo4WpBxZdd0nVd0CnKSzYrptJH2mVtesPmS8fz
XZuoADRGEWqURG/Nxq/wsm5LuTHXnDzlnsFvNuIszc3haZJJpU4VddMmQdJTb0pN
KkTplKte2ytJZTAjxYwfLYtERuwudgV4PmLjVLNZuD2khyAj95Q=
=ovy/
-----END PGP SIGNATURE-----
--=-=-=--
