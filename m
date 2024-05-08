Return-Path: <linux-nfs+bounces-3207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15DB8C00E6
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 17:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D426289415
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3F128815;
	Wed,  8 May 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQKw3TSq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6211272B5
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181943; cv=none; b=hIZy90dbozsDnB0OM6EKTCGoKukThuvoBhkCRBuLj9DkKsa66bpzEKGZftDrv7P0YKFBDhrJ7ol63cpGiKCWcYSw97HxmesYmM9VIUIGQpJgJL47Oav96z/PNDGEkm8LIkMjNliYfCCTuZ3tMeaYO6JgVpG3+6cWP9wCADEkkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181943; c=relaxed/simple;
	bh=GyAsR4zUyrKJUCZvJsaiYdE3wYRduWdkbVyVblodEf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2FDd5kIZpKQyfuzjDgIZdTsiJcDZAJXaUC8e2pcCn5BrZq8x5EvJFYW+IdL+CnrnTvxgvTGEOVjk+SHmab2DzLac3xfdPWghPMkitWOuIvJLJ+aXTV7rzXVdVlmu17LeXnSBZy/b3/RDUETxE12pyxZS2GfkSI7ndxjYFiTbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQKw3TSq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715181940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt94wEM0yvPBo7AaF3dlWsASKnixoM5XFvhDNyNhYwQ=;
	b=fQKw3TSqjezafIhQ0eC3qjevow3gMMEZG9SD+tIB62IeVLCubSRJP0t6nrTja5AaMeG3ov
	A4raazO8j+dhw2XJDtmxSsnwdzb4y7TZHH6fDpyr4+4G4icWFQ5DWTK34g05pZPnKV4YvI
	OnWCD9EvICEgjvEQfCu3VZS2r349DAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-6kWYg_9sPdWsj-IwiLFbWA-1; Wed, 08 May 2024 11:25:39 -0400
X-MC-Unique: 6kWYg_9sPdWsj-IwiLFbWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F03C80021D;
	Wed,  8 May 2024 15:25:38 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D26011C07406;
	Wed,  8 May 2024 15:25:37 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] pNFS/filelayout: fixup pNfs allocation modes
Date: Wed, 08 May 2024 11:25:36 -0400
Message-ID: <35158E21-2724-4C1A-950F-5A6A616C862A@redhat.com>
In-Reply-To: <20240507151545.26888-1-olga.kornievskaia@gmail.com>
References: <20240507151545.26888-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 7 May 2024, at 11:15, Olga Kornievskaia wrote:

> From: Olga Kornievskaia <kolga@netapp.com>
>
> Change left over allocation flags.
>
> Fixes: a245832aaa99 ("pNFS/files: Ensure pNFS allocation modes are cons=
istent with nfsiod")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/filelayout/filelayout.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelay=
out.c
> index cc2ed4b5a4fd..85d2dc9bc212 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -875,7 +875,7 @@ filelayout_pg_init_read(struct nfs_pageio_descripto=
r *pgio,
>  						      req->wb_bytes,
>  						      IOMODE_READ,
>  						      false,
> -						      GFP_KERNEL);
> +						      nfs_io_gfp_mask());
>  		if (IS_ERR(pgio->pg_lseg)) {
>  			pgio->pg_error =3D PTR_ERR(pgio->pg_lseg);
>  			pgio->pg_lseg =3D NULL;
> @@ -899,7 +899,7 @@ filelayout_pg_init_write(struct nfs_pageio_descript=
or *pgio,
>  						      req->wb_bytes,
>  						      IOMODE_RW,
>  						      false,
> -						      GFP_NOFS);
> +						      nfs_io_gfp_mask());
>  		if (IS_ERR(pgio->pg_lseg)) {
>  			pgio->pg_error =3D PTR_ERR(pgio->pg_lseg);
>  			pgio->pg_lseg =3D NULL;
> -- =

> 2.39.1

Looks fine, but I didn't think you could get here from rpciod/nfsiod
context.  I might be missing something, how did you get here from there?

Ben


