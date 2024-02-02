Return-Path: <linux-nfs+bounces-1709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B58471AF
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 15:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3F41C2344C
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202177654;
	Fri,  2 Feb 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJLkH3F+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE414532F
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883211; cv=none; b=rv6DkgYeidtUmfb9UFUyo5sBoll0dz9XAIGwZp0+03cHaQwXwTwEW3uXq8/BM+JATIeCIs1xRVi8Q6z3vIpEsC8zCgNE7RwxgGwD/7NcsTJA0+J6L9jE8gLo4mYcdxdbFMYsAVfmyT2Rjsa1J5N+7MyfM6S7cdRSw0V1oE0s63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883211; c=relaxed/simple;
	bh=aIO6FgmURKrdOF4ruReg1GtNa/bXXSe3uycsd+RcgnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6i5uV0kvsssXRjroZJ+Odmxk08qObL7z6rhy+kklQ4CjhKZ6KiIDpEIm5J2SFou3rsE1OT+vJd6wcXBB48ouNkqArV6L6BgWEukc90TcUxQ+ZO9Sdg5e5RJfpyXrZMbc7FICKafVT6g1so0wIFU+9+L+ErIM7pdRD2eO8uC+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJLkH3F+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706883208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kyb11mpWZpH4YtnbyfMVFqYQ8LuQ/k68oU8pYlRkDos=;
	b=hJLkH3F+kQM4T3kVIGdxrtrBMi2rk5wAvYEocOLH5ftsnUpPCbrkcb6EHzzE+r/gEOmkOo
	dP5Wd9Lur8SKLfCoiq4OXI2Ppz/eHcU2s69dx8TAH1J7xhQ3aKznJ1DCFqaANSFK4bGVRB
	NOxeShsx0x4KRIIA0PP4jyKWraFCrSk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-vISL8_zhNE6gd2-JfbE3jg-1; Fri, 02 Feb 2024 09:13:25 -0500
X-MC-Unique: vISL8_zhNE6gd2-JfbE3jg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BB8085A58B;
	Fri,  2 Feb 2024 14:13:24 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D799492BE2;
	Fri,  2 Feb 2024 14:13:22 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Simplify the allocation of slab caches in
 nfsd_drc_slab_create
Date: Fri, 02 Feb 2024 09:13:21 -0500
Message-ID: <94F7DA15-6D4C-4205-9A23-E4593A4A2312@redhat.com>
In-Reply-To: <20240201081935.200031-1-chentao@kylinos.cn>
References: <20240201081935.200031-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 1 Feb 2024, at 3:19, Kunwu Chan wrote:

> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> Make the code cleaner and more readable.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  fs/nfsd/nfscache.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index 5c1a4a0aa605..64ce0cc22197 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -166,8 +166,7 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, st=
ruct nfsd_cacherep *rp,
>
>  int nfsd_drc_slab_create(void)
>  {
> -	drc_slab =3D kmem_cache_create("nfsd_drc",
> -				sizeof(struct nfsd_cacherep), 0, 0, NULL);
> +	drc_slab =3D KMEM_CACHE(nfsd_cacherep, 0);
>  	return drc_slab ? 0: -ENOMEM;
>  }
>
> -- =

> 2.39.2

I don't agree that the code is cleaner or more readable like this.  I rea=
lly
dislike having to parse through the extra "simplification" to see what's
actually being called and sent.

Just my .02 worth.

Ben


