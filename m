Return-Path: <linux-nfs+bounces-14496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB5B7C5D5
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200981895C14
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 02:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0F1AF0C8;
	Wed, 17 Sep 2025 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="rGDSCj4g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QY5ptNvW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45204101F2
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076414; cv=none; b=UNV96Bv/K1sHyIEoPnF0Z89nVwqabl2awmXdnFbps+H+k6xKAH6UGZo7PhAXuDnxKRt8maYu9MaDWtlmxARcEae6f4pN7K+DWU/o4u/lyK73XX9aa+IWPxT+LyU6sGNaq5mTOKX050OFy+8ZdFYg3778FZURV/WGv3wjPDWCtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076414; c=relaxed/simple;
	bh=4TEcQI8GqKGQ+yFbHij5LA8J3a6/7bdBVCIPp/u99uY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VYMFAkK597JWDpHvIIUDp0UtG7a0If7BNuhHEZV+9QN3sP1Kx8nrEkBNdiHbm3Kulcw7K0/5uhjer6ueCFPsLQSYNyAa3UMrnHsCvYo90yAqHt6oOvUVDfK/GTOVcHikD18awebwVnHRV3Mk+J+STs45GNIm7WTLa5GbHlCdISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=rGDSCj4g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QY5ptNvW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CFD114001AE;
	Tue, 16 Sep 2025 22:33:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 16 Sep 2025 22:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758076411; x=1758162811; bh=Vp+ghvNhhYSxlodm04eVgpSRHWAyElQ1TBb
	ZAMtTAtY=; b=rGDSCj4gBxm1PdpDGLRIWHjC7KDMEG8MIj+wcycGhlz69wsc7F0
	rIiP0sTabX6Oq4Q2evKs5KeLDygccWK4F0f0KN1rC+7vRri8vlnw8YHINq5dsZzy
	Wp/yu9N1Tie56uSkbeRwbSW+mzBCiSlQK6Mj58fMxmQRM/ZYI8nuMv1hUtrp38tr
	4sgkiJmxuenQaXj54JHVqotyeFZeXfTud3us/RJeoop1mPjrXmmDmw6ayMmxicoB
	HzQTcvrPE4Zw32v+xE+Xh4UtmoI4elafz+/CgvVX11mPdBrNW5CsGpA2TCWBDtoG
	n90nCoHpa+5/2QIIG6jDpMgcLhf3kpVw9Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758076411; x=
	1758162811; bh=Vp+ghvNhhYSxlodm04eVgpSRHWAyElQ1TBbZAMtTAtY=; b=Q
	Y5ptNvWfvqkCpL47fCj4GRPwjCI/NNC4Rqjd4eULO+v7OpV5dK/IKDNTHc/LwRzY
	1X1DaX675HR0F+MyuEE4gWsNNseGnlavOorG2O5gXuo95PJ2GMHs3C7pXVSQ4JRu
	Y13V2eh1oiNufoNTVMX0DYrGz9LuYUcFfhS6nGZ5qlQ6HBQUtlnlJOgOZANlzghV
	zvcMPZZo/LbbyEb60gExaOQOdCi+tLYvPaUKW783/MY0KHM6m+CX3MlskSoTH0H9
	iWF+nBzvdu4ZglRmtgZ2grb6nNOotYkcYiEdKXjcAfNjEtACIpL8j2VKnitTphBp
	ACHDdjDCMli3U3F13CSWA==
X-ME-Sender: <xms:-x3KaMv_sY04DPy0mht2c4cSbuVHOYnCfTcb9l0G3dnpiIlhfKN11w>
    <xme:-x3KaB6mgWIfOq-C2ceQnu4njocnFunnc7lHhz4FLTZ6oB6K3gyzwDtQ39RHtjLaP
    Ld_5MzQVxtgkw>
X-ME-Received: <xmr:-x3KaIMeCHjOQPyzU6KRtTwHOJgReCVGiA7gC2PtmOll1XG64dzeQXP5sSeL2Vysiw1Og-boQhCiMen2xQDi0U2AjLojqBZfa_Ei5Kxronmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurheptgfgggfhvfevufgjfhffkfhrsehtqhertd
    dttdejnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesohifnhhmrghilhdr
    nhgvtheqnecuggftrfgrthhtvghrnhepleejtdefgeeukeeiteduveehudevfeffvedute
    fgteduhfegvdfgtdeigeeuudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtghpth
    htohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnhhfshes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlphgvhidrtg
    homhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-x3KaPt-GIjj47N8dNRv864ntOv32y7nSjMHyAhGcrRXX_8-TK3gdA>
    <xmx:-x3KaLaxFz0XV77gm7EEZURqE_GOZOoZKmaBdeDsOz-3gzjwiTGmnw>
    <xmx:-x3KaBylkAIRpbvfJcTgWUcAc6ojWpMUHciGuWr0fLZAtLTKOm6QPw>
    <xmx:-x3KaDh5i4hqWa0FzOA0jzzPv5JRM-odnWMV38aPWb233HTnGN1f6w>
    <xmx:-x3KaN7-GZGUIFvHmj3zSTWj1n62PUKDJQjMoCck4XqAKuUXwS7zDMXU>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 22:33:29 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: jlayton@kernel.org, okorniev@redhat.com, dai.ngo@oracle.com,
 tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Add array bounds-checking in nfsd_iter_read()
In-reply-to:
 <175803617610.13710.7007300747292684854.stgit@oracle-102.nfsv4bat.org>
References:
 <175803617610.13710.7007300747292684854.stgit@oracle-102.nfsv4bat.org>
Date: Wed, 17 Sep 2025 12:33:27 +1000
Message-id: <175807640765.1696783.8558095889174926392@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 17 Sep 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The *count parameter does not appear to be explicitly restricted
> to being smaller than rsize, so it might be possible to overrun
> the rq_bvec or rq_pages arrays.
>=20
> Rather than overrunning these arrays (damage done!) and then WARNING
> once, let's harden the loop so that it terminates before the end of
> the arrays are reached. This should result in a short read, which is
> OK -- clients recover by sending additional READ requests for the
> remaining unread bytes.
>=20
> Reported-by: NeilBrown <neil@brown.name>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> Changes since v1:
> - Check for overrunning rq_pages as well
> - Move bounds checking to top of the loop
> - Move incrementing to the bottom of the loop
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 714777c221ed..2026431500ec 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1115,18 +1115,20 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> =20
>  	v =3D 0;
>  	total =3D *count;
> -	while (total) {
> +	while (total && v < rqstp->rq_maxpages &&
> +	       rqstp->rq_next_page < rqstp->rq_page_end) {
>  		len =3D min_t(size_t, total, PAGE_SIZE - base);
> -		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
> +		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
>  			      len, base);
> +
>  		total -=3D len;
> +		++rqstp->rq_next_page;
>  		++v;
>  		base =3D 0;
>  	}
> -	WARN_ON_ONCE(v > rqstp->rq_maxpages);
> =20
> -	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> -	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> +	trace_nfsd_read_vector(rqstp, fhp, offset, *count - total);
> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count - total);
>  	host_err =3D vfs_iocb_iter_read(file, &kiocb, &iter);
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }

Very nice - thanks.

Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown

