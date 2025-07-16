Return-Path: <linux-nfs+bounces-13094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D2B06AFA
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 03:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69DE1A65531
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670A6481B1;
	Wed, 16 Jul 2025 01:09:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547C219E8
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628180; cv=none; b=tES/Sd+s0p8CTli/2WaXKiANWJlE0ruSgJPm+tGrx6WxEKmj/oEx4qsPbh8P5mE9sg0vg8cXsZxGjUaF3q38oojDyx96KSkoukEFho+Zq2cgZ6L/l8as5r/jL3U3mYgvqTfkVxKqT6a6PhUC1ncVLBmaaOUCQ2Hqh6YFmLUyxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628180; c=relaxed/simple;
	bh=aKX9oX6VHEH9Z3noRm6FoQqWp9OLyYZYPHSA1wpFRxU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=nXSc4e5dbAF053CCCe9fdUaZ3Kz/YfgiDEP4ZTVeFpcTvDHlF3sUEEr3lMbm1m2aE1gGleKRVeobru3IoqSDxaku1yLdKiMOZxAbRTXvDwjqT1U7U7aC5MUJxW4Cl77X61DaoUAlcuJj9YD3uuVljE2bYUPXpcrJCgX27boIEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqeL-002AMR-L0;
	Wed, 16 Jul 2025 01:09:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Trond Myklebust" <trondmy@kernel.org>
Cc: "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/3] NFS/localio: nfs_close_local_fh() fix check for file closed
In-reply-to: =?utf-8?q?=3C22ed73dbab3897d63f88849ea92db672a267945e=2E1752618?=
 =?utf-8?q?161=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E?=
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>, 
 =?utf-8?q?=3C22ed73dbab3897d63f88849ea92db672a267945e=2E1752618161=2Egit=2E?=
 =?utf-8?q?trond=2Emyklebust=40hammerspace=2Ecom=3E?=
Date: Wed, 16 Jul 2025 11:09:35 +1000
Message-id: <175262817515.2234665.17111966773278658899@noble.neil.brown.name>

On Wed, 16 Jul 2025, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> If the struct nfs_file_localio is closed, its list entry will be empty,
> but the nfs_uuid->files list might still contain other entries.
>=20
> Acked-by: Mike Snitzer <snitzer@kernel.org>
> Tested-by: Mike Snitzer <snitzer@kernel.org>
> Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and =
nfs_close_local_fh()")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs_common/nfslocalio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 05c7c16e37ab..64949c46c174 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -314,7 +314,7 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
>  		rcu_read_unlock();
>  		return;
>  	}
> -	if (list_empty(&nfs_uuid->files)) {
> +	if (list_empty(&nfl->list)) {

Yes of course... This must match:

		/* Remove nfl from nfs_uuid->files list */
		list_del_init(&nfl->list);
		spin_unlock(&nfs_uuid->lock);

in nfs_uuid_put().  If nfs_uuid_put() disconnects nfl from the list
first, nfs_close_local_fh() must skip the closing and wait for
->nfs_uuid to become NULL.  So it really must be testing the same
list_head.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

