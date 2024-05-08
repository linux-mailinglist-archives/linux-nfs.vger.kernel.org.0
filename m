Return-Path: <linux-nfs+bounces-3205-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F68C0073
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 16:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3188E282597
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363986278;
	Wed,  8 May 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXwCxvXb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3D8287A
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179816; cv=none; b=NFqImAyFkXwaifz+XDtV1RlH6gvk/XysfS8tALeyCqGFJwDvbMdBKRP3V+RdDLn29NAtvFEsHKp33vrYUn0AFPF3LPFtYIr0kwwOUFGZ5tBrHWtNydC0A7uquK58Su9dGGSuD/guTQBFRiFmh8UhKo0t9mZnc3EMRmwnAc8ZFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179816; c=relaxed/simple;
	bh=NyogFZ9GnfO3gKszkmshJhpbFtjeGnLzEGjqPlJQIUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKTxT5Gr91M1wbqOkiplle1gr3kuQqVKE5S6GhtTvxgF/wVB7m79Bg+aETKGeu4WErG0OfI8gDswMH+4vesS+mE0qQvm7gz8l1Pm4553PDFUfW2hHdeauFg6J/WMCA6rP59ggRqS664bSEfU0D6S2feVB57M7bMv60T/p6qJfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXwCxvXb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715179813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YH4u3B+oNstpA0630mSi7iIt83wgfubLTmOB3rVS+Dc=;
	b=hXwCxvXbRUD1uHt8zslE+1+3TGP4R7TJlvlYJuDQggb37BjznAjtgkqsIvnYqsIOTVVORk
	0OhCyOO5wCG3rpJTbyxMaVru7IIYOCRe0vDfujbGkksNoxG3UzTelUnw8fkcyAx+MwfU5n
	BJgz570TaZeoh1iA5c9ORQH+JoDR69Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-KEPbGa00O5iIBC8L-xyt3A-1; Wed,
 08 May 2024 10:50:09 -0400
X-MC-Unique: KEPbGa00O5iIBC8L-xyt3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D333C025B7;
	Wed,  8 May 2024 14:50:08 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B553B3C25;
	Wed,  8 May 2024 14:50:07 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] pNFS/filelayout: check layout segment range
Date: Wed, 08 May 2024 10:50:06 -0400
Message-ID: <9D9DB9E5-E772-462B-BD38-7F703459A0FC@redhat.com>
In-Reply-To: <20240507195933.45683-1-olga.kornievskaia@gmail.com>
References: <20240507195933.45683-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 7 May 2024, at 15:59, Olga Kornievskaia wrote:

> From: Olga Kornievskaia <kolga@netapp.com>
>
> Before doing the IO, check that we have the layout covering the range of
> IO.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/filelayout/filelayout.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
> index 85d2dc9bc212..bf3ba2e98f33 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -868,6 +868,7 @@ filelayout_pg_init_read(struct nfs_pageio_descriptor *pgio,
>  			struct nfs_page *req)
>  {
>  	pnfs_generic_pg_check_layout(pgio);
> +	pnfs_generic_pg_check_range(pgio, req);
>  	if (!pgio->pg_lseg) {
>  		pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
>  						      nfs_req_openctx(req),
> @@ -892,6 +893,7 @@ filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
>  			 struct nfs_page *req)
>  {
>  	pnfs_generic_pg_check_layout(pgio);
> +	pnfs_generic_pg_check_range(pgio, req);
>  	if (!pgio->pg_lseg) {
>  		pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
>  						      nfs_req_openctx(req),
> -- 
> 2.39.1

Looks right, less duplication to just call pnfs_generic_pg_check_range()
from pnfs_generic_pg_check_layout() now.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


