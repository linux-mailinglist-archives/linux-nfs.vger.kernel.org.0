Return-Path: <linux-nfs+bounces-15168-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58855BD161A
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 06:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DE43BDB77
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 04:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE00D286415;
	Mon, 13 Oct 2025 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="DM+Ofeks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKT+7lJJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AAF1EF091
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760329906; cv=none; b=lYoFpR/TCaOLxdOR9y3QdVTRmj8TuuVAaBxDgDJD0W/yh/JUT8ivHexh50MPQci0W0K+NT2ZQVcIEzZm4GQChKliI5gSy/NNmUjyVee1UT/du4dYMnxRXfCnxc1iBHcxxYv8Xa4F8ET0/QBA3uPmLdN2K5+0IxvlTzzZ+cWfxTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760329906; c=relaxed/simple;
	bh=arx2svJtILuFBg4dJY5x1hL5hxrBmu/83sCgDaZfQOM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=t5cNqchjiMhsP1LTYm0lGuuGurzPRoeDQg4osKc3aDX5O6SUgOn8Z5JsyCbpjB/EmNxQbIomEO9m32ykiLmfKaUKDK0iZgEj+np4aqDhZ60U4V9G0YCa6Prvkfli68ByG6s2kMf9+kMIZEZpECsoOnktoInNqpxmmtXLQlsPwy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DM+Ofeks; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKT+7lJJ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A58FC1D00039;
	Mon, 13 Oct 2025 00:31:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 13 Oct 2025 00:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760329903; x=1760416303; bh=Snp9HZSKWzaHvsjZcOLyonxu5+p5Vl6vQq7
	XwqstOAk=; b=DM+Ofeks8X7Akhl6M1Z1Z7AmJZ1UOmRit9ENNPVa8Fwiw4luz/t
	Ij1R8Zip3X/mh3GBzisZXUmKRRqDiIQ5ujU6JLwJacFf+XrEnMrHhOVUPBpS1Jui
	paN9RU7mMNObVIN+u6gqo9m36FaMC+tB/tek8oqyxsXtq7xZaTfz70WbBS2CFNRU
	Ktcg60q9Q8peG3cDvp4jtnieIrO1D9xz8g6ZsY9bPhBZhiUApAShwworkkdR6HDb
	/wSyFdqfQb7Zjh53C0hnEL4VAtD8aCrK7Ag/TgmrkFw8AbTVbUSNS6t5E6dfsd33
	IIK8cuvRnY0014DuegVes93TecQO5EpWIzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760329903; x=
	1760416303; bh=Snp9HZSKWzaHvsjZcOLyonxu5+p5Vl6vQq7XwqstOAk=; b=L
	KT+7lJJr3WvYnjL55Nlf3c3qwjGhq3F+J9meZR4Yre+R/T9u29RLi2Viz3fJ2lIY
	jiau3TBbxsLddMTJjLmpwL4/CAD31zTZ2BNT57acQRY8k8ox4l0sPlZIKpdhz3Pl
	vKLtWC89BDUnoMCfuNGmNiSXaMlBkeuJ2p2Wh8oaPSd+MVv+atTxnkf7dtdTQR5g
	ALnRHoC8y09ImdvEEUZGuudYQ6BBYHJw2nFpSg4aLCti2GUArePgtsuPMujFZpiZ
	072N/H0U3Zf9mkprrEXMz41zIzeqHt9JdYMcBoej6+FbY91C9uQFzLIF53pt3kir
	+OX6M7WtkH1+xQJ8N7TiQ==
X-ME-Sender: <xms:r4DsaFlQegtmKueSMzS_T5Rz2GErqwrebEGrXr7Fz0iJu_H2a0Bnsw>
    <xme:r4DsaK1JOXxGJZI1rBKMahge9hbHh73PyTurtUhLZTbaui4OOfbcoQixtd4ys83KY
    8OnWDJxBlquxhBOgwuF2z7zhHVkS486G0wNjwQNJblBczwCSzY>
X-ME-Received: <xmr:r4DsaCRbUHbV7SHVtep78wi2e7flujZRxJ0yyWBkscUlrGzvUCA3qb7g5b0AOVoDqdn7cq02IiQUQYGJACLAuV3bwr2wUmgF6XR_Vws1QXCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeijedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhu
    tghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehrthhmsegtshgrihhlrdhmihhtrdgvughu
X-ME-Proxy: <xmx:r4DsaDwkAbBSf6yqFwloZ_pSX9b6spWpb2BGePoi2VR0_V_sIiHy3g>
    <xmx:r4DsaCCmHemoHo6fzBT3LETnVzlnkVtRC6xs6KMjeywIYu2c8i3Teg>
    <xmx:r4DsaPFbFP25a0ougtvF449cmzAEpZpmTBiEpK2O3tPEGm9jC3Lm3w>
    <xmx:r4DsaJOAj1O4808VM_2aIEe4EWZMGenYya9ddJvFp-mvhccJxx4PlQ>
    <xmx:r4DsaEDPg92xliYDFXntT1rS3DNzD5HWwfU9ZHARkf0sJEr09Dkc7X_h>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 00:31:40 -0400 (EDT)
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, rtm@csail.mit.edu
Subject: Re: [PATCH v4 2/4] NFSD: Never cache a COMPOUND when the SEQUENCE
 operation fails
In-reply-to: <20251012170746.9381-3-cel@kernel.org>
References: <20251012170746.9381-1-cel@kernel.org>,
 <20251012170746.9381-3-cel@kernel.org>
Date: Mon, 13 Oct 2025 15:31:39 +1100
Message-id: <176032989914.1793333.8589291321025694985@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 13 Oct 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> RFC 8881 normatively mandates that operations where the initial
> SEQUENCE operation in a compound fails must not modify the slot's
> replay cache.
>=20
> nfsd4_cache_this() doesn't prevent such caching. So when SEQUENCE
> fails, cstate.data_offset is not set, allowing
> read_bytes_from_xdr_buf() to access uninitialized memory.
>=20
> Reported-by: <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/linux-nfs/c3628d57-94ae-48cf-8c9e-49087a28c=
ec9@oracle.com/T/#t
> Fixes: 468de9e54a90 ("nfsd41: expand solo sequence check")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

> ---
>  fs/nfsd/nfs4state.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c9053ef4d79f..4b4467e54ec9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3486,7 +3486,20 @@ nfsd4_store_cache_entry(struct nfsd4_compoundres *re=
sp)
>  	struct nfsd4_slot *slot =3D resp->cstate.slot;
>  	unsigned int base;
> =20
> -	dprintk("--> %s slot %p\n", __func__, slot);
> +	/*
> +	 * RFC 5661 Section 2.10.6.1.2:
> +	 *
> +	 * Any time SEQUENCE ... returns an error ... [t]he replier MUST NOT
> +	 * modify the reply cache entry for the slot whenever an error is
> +	 * returned from SEQUENCE ...
> +	 *
> +	 * Because nfsd4_store_cache_entry is called only by
> +	 * nfsd4_sequence_done(), nfsd4_store_cache_entry() is called only
> +	 * when a SEQUENCE operation was part of the COMPOUND.
> +	 * nfs41_check_op_ordering() ensures SEQUENCE is the first op.
> +	 */
> +	if (resp->opcnt =3D=3D 1 && resp->cstate.status !=3D nfs_ok)
> +		return;
> =20
>  	slot->sl_flags |=3D NFSD4_SLOT_INITIALIZED;
>  	slot->sl_opcnt =3D resp->opcnt;
> --=20
> 2.51.0
>=20
>=20


