Return-Path: <linux-nfs+bounces-3842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D2909205
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 19:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F9F1C21A48
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F386179BC;
	Fri, 14 Jun 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h23J0G5h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D513D66;
	Fri, 14 Jun 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387529; cv=none; b=ZMcQkkObXmaWu6kXOg6ocnBYODktgjFp0EQ03ZEP+hkKP7u4hIrZja1WRLsGv+6UUbL5HfZgK7rgj4xUb76QOdbLjnWGIopjkoIPGnbh4eg+JfMSU2d90TAUYMBYV+6llLlDmGbXw7ue6CDwHDgptkLxL0SV3RkkuST/2pQuo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387529; c=relaxed/simple;
	bh=PshLP8F/G7lzbUSaaYUvzQ2G4ZHraykzh3cvrdJcDwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UkUa84ykcR7Yod3NSx1ZU8cGWw17DUzIxhew6mzkmhF/6TFTq4Zra4t2+/3RFdJGTV6pS5rZVK0PqixzPrY0Dvy+cjLe6wOs4fT+2VOm+RG3LgcJRkBPU7c97kpREVR15Zbcm5vJ+lysC8AozUWSiPQagQQMftC0hmMzv7NBtW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h23J0G5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D059C2BD10;
	Fri, 14 Jun 2024 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718387529;
	bh=PshLP8F/G7lzbUSaaYUvzQ2G4ZHraykzh3cvrdJcDwE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=h23J0G5h5hrrJ7WGhU0ptT7zWQzsKadQsf/mP5EjBXnQPm0IquooK2IdBxUgPYUMA
	 3luv8aBRQK+vCEzZ8BeHKFiXPKhyA101913bAjbic9Rv1xGq06lat67uNSoVSI9Lxx
	 cueQiT/FmcYGBp8M/dSBHkAVx3h0a8HNSi9RaFVygENoOF9Kznq4ABoqlZrJ0CwHYI
	 Trnzo0WtFEy5lfUQJNDFoq+0NjFUuJ2ZoPwy3M0eRRJT6+wCkvLeQejBmDxU0aZSF1
	 EThFyY05VL2RL4D1TPs816tGRSk1fCnLoa7SNY2OJoHbXfcHlrEmDSnEvhBp1unUU9
	 Goh/l78Sy+8nA==
Message-ID: <9bfbc01c4cb0d3713a160a5d00e8cc360ee6bb60.camel@kernel.org>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker
	 <anna@kernel.org>
Cc: Steve French <sfrench@samba.org>, Andrew Morton
 <akpm@linux-foundation.org>,  linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-mm@kvack.org
Date: Fri, 14 Jun 2024 13:52:06 -0400
In-Reply-To: <20240614100329.1203579-2-hch@lst.de>
References: <20240614100329.1203579-1-hch@lst.de>
	 <20240614100329.1203579-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-14 at 12:03 +0200, Christoph Hellwig wrote:
> As of Linux 6.10-rc the MM can swap out larger than page size chunks.
> NFS has all code ready to handle this, but has a VM_BUG_ON that
> triggers when this happens.=C2=A0 Simply remove the VM_BUG_ON to fix this
> use case.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> =C2=A0fs/nfs/direct.c | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index bb2f583eb28bf1..90079ca134dd3c 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -141,8 +141,6 @@ int nfs_swap_rw(struct kiocb *iocb, struct
> iov_iter *iter)
> =C2=A0{
> =C2=A0	ssize_t ret;
> =C2=A0
> -	VM_BUG_ON(iov_iter_count(iter) !=3D PAGE_SIZE);
> -
> =C2=A0	if (iov_iter_rw(iter) =3D=3D READ)
> =C2=A0		ret =3D nfs_file_direct_read(iocb, iter, true);
> =C2=A0	else


This definitely seems wrong in a large folio world.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

