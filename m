Return-Path: <linux-nfs+bounces-15737-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06404C172E9
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 23:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB77F1B23405
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA802DE6E3;
	Tue, 28 Oct 2025 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UpSjd+qL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N3bYXqao"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88E2E764E
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690117; cv=none; b=ZZjfVcm3RMGG3QkTeoYWZJAcbyi22Mm+tu+9Z20vcKRnXXWoUW+oP800wa+rP/aMwR+RHUQ+L8EQC4yChk2ejnTWG3sC0pxYmNPKvztkZ/0qNbK/Pud6XGCbybC6aIoY1Jh4ZCuWyb9nFPtdTAPH1haMmLFMJTZnZnLwVcKFBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690117; c=relaxed/simple;
	bh=pyfuDLc7YYzcWAJp9wwdQbUpVzeEcAyrh/sIKNQ8j3E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=E8KMAqFHsUDIinN/uafI6vKmreyI80HFT6+Hl3NS0JAam8dgc7DCbBd8YvFEo4sc3XjTLqBNhE6VHD5luSsQjiljdRq25jiH5Qk8Dpu9Z1OGcP5T5BSEESz2KiNUDEFa0XC49HDYG8BBAhoHb4SBMILBGPw19lbiLjL93drqgZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UpSjd+qL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N3bYXqao; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4FF207A0112;
	Tue, 28 Oct 2025 18:21:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 28 Oct 2025 18:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761690114; x=1761776514; bh=081H6NmZ8boIWsB3DsB9ar9hBIfaZDSUDNz
	eyaMCGUU=; b=UpSjd+qLnnx5TOvs4QUqleT8rLaDMX6fyu8m/u55StFRjk+/vx/
	07gAGS8cgl/nWZ23AjdrRPmQSNSM8ogHeDu6EUrDwUOu4/tahiPBGzLSUM1rtJuj
	DPopHNaOvVYro0+PYFPyNAOnGvmDQvz9oxhVx7WvBm8Eycpy1xdL0bKmCZkQe0fT
	TEuytbFeTEMXGoHWPdv+Q0fpFik+MG418gJdon6zFBVC8uAK4JwVP6R1h+1L704U
	wbOruaGj2yDcnzoh4f/kRcASr0q30AcV1+GBRHkAWXhiulLLCNzIqQJRGAStYE9g
	9GJNGnVydzfD8dwNWcKSuxMdRCkRXXRfIjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761690114; x=
	1761776514; bh=081H6NmZ8boIWsB3DsB9ar9hBIfaZDSUDNzeyaMCGUU=; b=N
	3bYXqaoUfKg3JwseVeddAFCYgJsdKvM3lS+51uhfdY1hHqo2C7OwmuroH/fRVmfc
	xUlJSNDbJwBdB5lqBDtFLN/52Vq8DYd3zlusnKiUAwFimJRmU6vFKsEm6cMlmSsU
	MocKFc+M/LoBvlc4IJA7UeKEc5dw7PVoNPq2cv2yF9/EsCw0jyY8wHMH5q7nozuG
	eBxWzqXlVQMkPASpPMPRkBFQaOZ80f7idk356yfRSzVQl9WUYroItNICSSEoMLOZ
	6C+WhugS2nLN20kloITDE23ouerr3AGoHgiFF5e60ZMFKy228v8KmIJRE6Erx/2f
	OZGw1yZRYZhsZYH0o2CwA==
X-ME-Sender: <xms:AUIBaSvIaOB-u5T-Lz1qLsxkIefXKVRh0cC8cC4CF5-6mLrHRn2hGg>
    <xme:AUIBaeecRuXeuaPV2_bTrw8IRGJ9snEpL-ptc5B9PMNgXsSuHrp3Y4DpjuC0fD_Vb
    PJ9w6oz4WsTyaHqh6TJOsMlVfmaIV73xIZJM304nrKO8NiwIw>
X-ME-Received: <xmr:AUIBaSxm5nSKttoxXLpaJdauvJGRsqAkaQbQ-dwdQBbKAI10Ig7bmuDbw5BPlihI-9ses8ihewUl6W3okaZ0t__tEow9ej6Bz9ywef6UAX0S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhies
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsrggssggvnhgvkeejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AUIBacEWlfeKBzLTu-i39XgXRE7Zib6n-_2iH4ugn14zxjJNjW6Z9g>
    <xmx:AUIBaexLGWLzp3l6k_tC12ouVeWqjgVmRjKA1BYhb2n8Bq5Nhwc6gA>
    <xmx:AUIBaVupIXPys_AYdkRnO6vr3mCGnD4hOzTJ-Pm424jt3m6ujq1Rdw>
    <xmx:AUIBaT3xS9W2duXdoKKaYni8Lc45yz4npn0Je55jkASruMG2nb7fig>
    <xmx:AkIBaQisUnCibtW6d1Ha-3usIEdcS78vvTbwOG4luO1vlgTXvvBBYvNC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 18:21:52 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Trond Myklebust" <trondmy@kernel.org>
Cc: "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org,
 "Stephen Abbene" <sabbene87@gmail.com>
Subject:
 Re: [PATCH v2 1/2] NFSv2/v3: Fix error handling in nfs_atomic_open_v23()
In-reply-to: =?utf-8?q?=3C03e3a5a82187cfc7936b87ce92ee001b27e18878=2E1761686?=
 =?utf-8?q?833=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E?=
References: =?utf-8?q?=3C03e3a5a82187cfc7936b87ce92ee001b27e18878=2E17616868?=
 =?utf-8?q?33=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E?=
Date: Wed, 29 Oct 2025 09:21:50 +1100
Message-id: <176169011068.1793333.14036175509882587080@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 29 Oct 2025, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> When nfs_do_create() returns an EEXIST error, it means that a regular
> file could not be created. That could mean that a symlink needs to be
> resolved. If that's the case, a lookup needs to be kicked off.
>=20
> Reported-by: Stephen Abbene <sabbene87@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220710
> Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC corr=
ectly.")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 46d9c65d50f8..ea9f6ca8f30f 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2268,11 +2268,12 @@ int nfs_atomic_open_v23(struct inode *dir, struct d=
entry *dentry,
>  		return -ENAMETOOLONG;
> =20
>  	if (open_flags & O_CREAT) {
> -		file->f_mode |=3D FMODE_CREATED;
>  		error =3D nfs_do_create(dir, dentry, mode, open_flags);
> -		if (error)
> +		if (!error) {
> +			file->f_mode |=3D FMODE_CREATED;
> +			return finish_open(file, dentry, NULL);
> +		} else if (error !=3D -EEXIST || open_flags & O_EXCL)
>  			return error;
> -		return finish_open(file, dentry, NULL);
>  	}
>  	if (d_in_lookup(dentry)) {
>  		/* The only flags nfs_lookup considers are

This relies on the fact that we always get a d_in_lookup() dentry in the
O_CREATE case - subtle but safe.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown



> --=20
> 2.51.0
>=20
>=20


