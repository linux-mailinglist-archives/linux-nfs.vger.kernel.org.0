Return-Path: <linux-nfs+bounces-4141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8FC9103D7
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16485282A03
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DC1802E;
	Thu, 20 Jun 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaBNWx5O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062A46BF
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885841; cv=none; b=NSKKb/B/YhQd10ag65y8n2yEANOW1vzjWfxemxx754yMlZ2d7Gh5mjdemdES+y6XbMQG08yA4mDGfvlnekHL8MtzbpxYyRmQj9lett/I/5hr/ZNtkxmIHn7a72VSux+729K2lhF9NoU9MeSQtbch0AprXDOl/AzyL8hnkF1IvDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885841; c=relaxed/simple;
	bh=XMBSYG0nfFQcsc++U7xwWPYTe2a9ndfk9R1c46tH3zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJ255xKqAUPJZC8BAsktNTXKLT60qIGJet9heU/BO8tkns+t62cois756y+Vs2mbwHcQeDIlV4eeTNbK9UszPWlwcpQcivUMqXZm6Mz+H/zOqPMLZaXDG8aTxZFJwWIsfqS9JaP351/Lr9RaZ2wbXFetSVpqFw1KopU8cRDLz2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaBNWx5O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718885838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zpRmXbekRjvS9R+er0QEM5uZzIRZ/bvP0RY3aD6/YI=;
	b=SaBNWx5OQslYvunePJ4nFw+qWv07ZDEdpBylHGbyj5Bf0Nj2FvVLXATfZHavtygIvMOLW3
	MQ9INj4m68wUFLDU2dU0JyH/62Mge9OJ2U7SyIZAHTAQphjJbrIWcQtjbb2xMQoNIJ4hEg
	aeMaHIAdbw/b1p3dNan61fVzE+H0n/0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-t2N7-T8CNFOWfs1NF0hOfA-1; Thu,
 20 Jun 2024 08:17:17 -0400
X-MC-Unique: t2N7-T8CNFOWfs1NF0hOfA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4376B1955F1D;
	Thu, 20 Jun 2024 12:17:16 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFC651956048;
	Thu, 20 Jun 2024 12:17:14 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 2/4] nfs/blocklayout: Report only when /no/ device is
 found
Date: Thu, 20 Jun 2024 08:17:12 -0400
Message-ID: <89E1818D-3CCA-48B0-AF12-14B0EBD2C350@redhat.com>
In-Reply-To: <20240619173929.177818-8-cel@kernel.org>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 19 Jun 2024, at 13:39, cel@kernel.org wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> Since f931d8374cad ("nfs/blocklayout: refactor block device
> opening"), an error is reported when no multi-path device is
> found. But this isn't a fatal error if the subsequent device open
> is successful. On systems without multi-path devices, this message
> always appears whether there is a problem or not.
>
> Instead, generate less system journal noise by reporting an error
> only when both open attempts fail. The new error message is more
> actionable since it indicates that there is a real configuration
> issue to be addressed.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/blocklayout/dev.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index b3828e5ee079..356bc967fb5d 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -318,7 +318,7 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
>  	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
>  					NULL, NULL);
>  	if (IS_ERR(bdev_file)) {
> -		pr_warn("pNFS: failed to open device %s (%ld)\n",
> +		dprintk("failed to open device %s (%ld)\n",
>  			devname, PTR_ERR(bdev_file));
>  	}
>
> @@ -348,8 +348,11 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
>  	bdev_file = bl_open_path(v, "dm-uuid-mpath-0x");
>  	if (IS_ERR(bdev_file))
>  		bdev_file = bl_open_path(v, "wwn-0x");
> -	if (IS_ERR(bdev_file))
> +	if (IS_ERR(bdev_file)) {
> +		pr_err("pNFS: no device found for volume %*phN\n",

pr_warn is more appropriate here because there can be clients mounting that
that don't have block devices for the filesystem.  That's not necessarily a
configuration problem.

Ben

> +			v->scsi.designator_len, v->scsi.designator);
>  		return PTR_ERR(bdev_file);
> +	}
>  	d->bdev_file = bdev_file;
>  	bdev = file_bdev(bdev_file);
>
> -- 
> 2.45.1


