Return-Path: <linux-nfs+bounces-17118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E04FECC47CE
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 17:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58B453011030
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BCA2BE7AB;
	Tue, 16 Dec 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXp+/mLL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509DC271A6D
	for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904238; cv=none; b=biSdEhlS6y/faCR7sEYoJsckDNUx2ZexR6nsbWBIMH3HdgrzqJhL+OXewMjNntrPh3it1YlbrYwZxzeKvzJ11RqeY+ZlGC4GTjeSkfthYKFB2ylXe4v9yn5qVxKAXb1kzrd8KXyn3qkyEaez8RYQprhb5t/QX/Yci1YPOkc+dnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904238; c=relaxed/simple;
	bh=YzWlyQm2b2xAyw7E6gc3ZA1So+rQMiM1v5h5uhvnq7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ajy9sM2nmoXAC9BW6fnHb7kLXTNZ+/Rffmem5K7uJcKZTxg0pdoSqBz06ZZllbbxe2ds+HsMpb8Hz+FojEY/d1y6oWhVbT1qtkwPrmpW20YesYC8Wo9A9ssqF8ROsf1+cnKcDlz/iH7QcKO72wlv3hPbx0A5V5VGjEiioc9ILHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXp+/mLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C9DC4CEF1;
	Tue, 16 Dec 2025 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904237;
	bh=YzWlyQm2b2xAyw7E6gc3ZA1So+rQMiM1v5h5uhvnq7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jXp+/mLLFXw8oqEkfOFTIU8N4owMDALZRH3kKxJ9JpLFtD9b6hEp3gmXbVDadN0UZ
	 QvUN4QbuQmWoKNoCYMcwAQOUhVcSTIujYpdbLTkQ1jntXIHCIR/pMlI9ySJFt1FGFA
	 McF5JoVtw6vOFdQrp/2Kx35pm5+S2+cfzaO+bZvezmf5Ok0nC7gC+HQe9piqkDqH3x
	 4oT7Eb3o25oUrmkNvl27Ofxr2uWoIPFmkW7Sk0whiQGyRqghyoa/0u0FtxUf9KYykd
	 kzeLvsOeyFkQs+j85forUQKhr+6LF+V64VyjyVjw1LPiUdT/YTbx+1WyeHCF9wDnlY
	 EZRdNiiHT/GaA==
Message-ID: <b218ea930cb48529fd3fef7efe20c088a78e7253.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSv4/flexfiles: Layouts are only available if
 specific stripe has a valid mirror
From: Trond Myklebust <trondmy@kernel.org>
To: Jonathan Curley <jcurley@purestorage.com>, Anna Schumaker
 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Tue, 16 Dec 2025 11:57:17 -0500
In-Reply-To: <20251215211404.103349-2-jcurley@purestorage.com>
References: <20251215211404.103349-1-jcurley@purestorage.com>
	 <20251215211404.103349-2-jcurley@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 21:14 +0000, Jonathan Curley wrote:
> Updates ff_read_layout_has_available_ds to consider the specific
> dss_id to ensure that there is at least one valid mirror for the
> stripe to be read. Otherwise a deadlock can occur.
>=20
> Also updates ff_rw_layout_has_available_ds in case there's any
> performance or availability benefits to considering only the stripe
> required for this particular write.
>=20
> Fixes: a1491919c880 ("NFSv4/flexfiles: Update low level helper
> functions to be DS stripe aware.")
> Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
> ---
> =C2=A0fs/nfs/flexfilelayout/flexfilelayout.c=C2=A0=C2=A0=C2=A0 |=C2=A0 6 =
+--
> =C2=A0fs/nfs/flexfilelayout/flexfilelayout.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
> =C2=A0fs/nfs/flexfilelayout/flexfilelayoutdev.c | 55 +++++++++++---------=
-
> --
> =C2=A03 files changed, 30 insertions(+), 33 deletions(-)
>=20
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> b/fs/nfs/flexfilelayout/flexfilelayout.c
> index b5e6985034cb..4ee1229a617d 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1351,7 +1351,7 @@ static int
> ff_layout_async_handle_error_v4(struct rpc_task *task,
> =C2=A0 rpc_wake_up(&tbl->slot_tbl_waitq);
> =C2=A0 fallthrough;
> =C2=A0 default:
> - if (ff_layout_avoid_mds_available_ds(lseg))
> + if (ff_layout_avoid_mds_available_ds(lseg, dss_id))
> =C2=A0 return -NFS4ERR_RESET_TO_PNFS;
> =C2=A0reset:
> =C2=A0 dprintk("%s Retry through MDS. Error %d\n", __func__,
> @@ -2113,7 +2113,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header
> *hdr)
> =C2=A0 return PNFS_ATTEMPTED;
> =C2=A0
> =C2=A0out_failed:
> - if (ff_layout_avoid_mds_available_ds(lseg))
> + if (ff_layout_avoid_mds_available_ds(lseg, dss_id))
> =C2=A0 return PNFS_TRY_AGAIN;
> =C2=A0 trace_pnfs_mds_fallback_read_pagelist(hdr->inode,
> =C2=A0 hdr->args.offset, hdr->args.count,
> @@ -2195,7 +2195,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header
> *hdr, int sync)
> =C2=A0 return PNFS_ATTEMPTED;
> =C2=A0
> =C2=A0out_failed:
> - if (ff_layout_avoid_mds_available_ds(lseg))
> + if (ff_layout_avoid_mds_available_ds(lseg, dss_id))
> =C2=A0 return PNFS_TRY_AGAIN;
> =C2=A0 trace_pnfs_mds_fallback_write_pagelist(hdr->inode,
> =C2=A0 hdr->args.offset, hdr->args.count,
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h
> b/fs/nfs/flexfilelayout/flexfilelayout.h
> index 17a008c8e97c..4378ce48f75b 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.h
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
> @@ -247,7 +247,7 @@ const struct cred *ff_layout_get_ds_cred(struct
> nfs4_ff_layout_mirror *mirror,
> =C2=A0 const struct pnfs_layout_range *range,
> =C2=A0 const struct cred *mdscred,
> =C2=A0 u32 dss_id);
> -bool ff_layout_avoid_mds_available_ds(struct pnfs_layout_segment
> *lseg);
> +bool ff_layout_avoid_mds_available_ds(struct pnfs_layout_segment
> *lseg, u32 dss_id);
> =C2=A0bool ff_layout_avoid_read_on_rw(struct pnfs_layout_segment *lseg);
> =C2=A0
> =C2=A0#endif /* FS_NFS_NFS4FLEXFILELAYOUT_H */
> diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> index d25bac36dbd9..7d8c56b84ba6 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> @@ -21,7 +21,7 @@
> =C2=A0static unsigned int dataserver_timeo =3D NFS_DEF_TCP_TIMEO;
> =C2=A0static unsigned int dataserver_retrans;
> =C2=A0
> -static bool ff_layout_has_available_ds(struct pnfs_layout_segment
> *lseg);
> +static bool ff_layout_has_available_ds(struct pnfs_layout_segment
> *lseg, u32 dss_id);
> =C2=A0
> =C2=A0void nfs4_ff_layout_put_deviceid(struct nfs4_ff_layout_ds
> *mirror_ds)
> =C2=A0{
> @@ -420,7 +420,7 @@ nfs4_ff_layout_prepare_ds(struct
> pnfs_layout_segment *lseg,
> =C2=A0 lseg->pls_range.length, NFS4ERR_NXIO,
> =C2=A0 OP_ILLEGAL, GFP_NOIO);
> =C2=A0 ff_layout_send_layouterror(lseg);
> - if (fail_return || !ff_layout_has_available_ds(lseg))
> + if (fail_return || !ff_layout_has_available_ds(lseg, dss_id))
> =C2=A0 pnfs_error_mark_layout_for_return(ino, lseg);
> =C2=A0 ds =3D NULL;


NACK. We must not conflate unavailability of a stripe with an inability
to process striped layouts. The former is a server problem. The latter
is a client problem.

The correct way to handle the unavailability of a stripe is to
   1. When reading, look for a mirror, and just report the data server
      as being unavailable using LAYOUTERROR.
   2. When writing, or if there are no mirrors available to read from,
      return the layout, and report the error as part of the flexfiles
      layoutreturn.

If the server has no way to fix the issue, it can signal that by
refusing to hand out a layout when the client asks for a new one for
the same stripe.

--=20
Trond Myklebust Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

