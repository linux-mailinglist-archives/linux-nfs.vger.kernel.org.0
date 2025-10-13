Return-Path: <linux-nfs+bounces-15166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7C4BD15F3
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 06:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0472188FC59
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 04:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C919E27FD52;
	Mon, 13 Oct 2025 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OsmKBbBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UdoDt0dE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656121A23A0
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760329696; cv=none; b=KUIYwmtNW9HVH6Rg5GCOCNMfPOOD924K9yztUQhg5KxEWrkfeVekwjydXwe0UfFNPU097/AgSGslxOKkimY7tCSJg2dzcC5RblOKvA62MSWP4vkfX8UqtIrmB8JsAMmGT+XeXEpauW+hPBUiFrIHJ1U3ZI9teLlfPRxevEmIOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760329696; c=relaxed/simple;
	bh=ZXa27mav8eXXj4OTUMZINVn2G90vb3IC6RByvYTqS6c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RJA4fRj/T2MYRNOiUzg42n0M/F1fYWbFi1nd5NGbuw8G5Dkmd9qAM9Y6dZI0DssW6JaSeeKM7VpoqFYAZdh+CE82TTnTUV81tURgD0+4MVN8ESvrzuJyBm9o4rVYCebJoxZLIFdeYgebFUWquGesQ9e7IA/Gdb60MfK8GzMd0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OsmKBbBF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UdoDt0dE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 480D37A00CC;
	Mon, 13 Oct 2025 00:28:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 13 Oct 2025 00:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760329692; x=1760416092; bh=K5BmjYz9ZaIXOBxXvlUWZhIa0rbWs9ZKQeB
	wf3oW6SU=; b=OsmKBbBFgj4nJsRqJ4LgNbnZ6L338UvAH1YL6+xcw8o2S9or08N
	1hHGL2xmSraa+bIYXXG6QtstAmZeQ+JKq6rFpwh5Q4aRy7/ee/ewNbGZ/LHUPoBB
	flpOIPhvwuiTNa8bEQt8nPvwxO54r/10LWXoP+z9ik/HczL0ZczxVmwsLnjx0oU/
	3z41xl2QNTeHDor4eiP/BzS36Pu39AwVDaba/IOMgJl3Y6ww2ZVe1Du6vXnunkfe
	oPTrAkiXoTSgWvXkRVjwaat3iaXXTck/Bx29oAaEvvUNXEPNA/ce+eM5Nu4iEMI3
	SXkEvGfJXYnTjINajBRG7a+rSnUyFV3302g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760329692; x=
	1760416092; bh=K5BmjYz9ZaIXOBxXvlUWZhIa0rbWs9ZKQeBwf3oW6SU=; b=U
	doDt0dE3K4H/WNU4iSd2cy/1l9B/BlrFzUL811ghVFKvW2A5ZiH7N2LMKK2PuA+Z
	aCpiYiAJ+d1FqxZZjY8G1IwBpoVcy+u4b0y+IqFRXkMLaiLkSiRsVZ57LaR0vklx
	zzZw4y1xz3C3BbC4E+OPwAodnYFI8HFzZ0anVUnBNSlljf1vlLYyMzKahL9eomsJ
	how4Rpp5YOjNZZQTTBLzzNFvABkLZrIBnvIEja8HUUR39A4HJWnoxfu/I+wdc9RN
	YrjKFxZsaFsf6Quz8GV/H/68gMSBV9pN6XgneW+jn7bgOcN2nSdJPVOaPmrE3/nT
	sMx2tPx5uqlAhCXew6tjg==
X-ME-Sender: <xms:23_saARY6533h2o30_ggVWy4zQVbxMsOa3mGuNsZpYWcLUDpiB0OnQ>
    <xme:23_saC-gNnIa7gsWQRkGBlKkPr1cIi92vU4A_1UcPYspgbKP29Itsv_hs-R2Szbwl
    15nNJXHZKHNszcJgBhFdCqYBtr7n-SreE5P0PD_sK1cbR8Flw>
X-ME-Received: <xmr:23_saOtrOAOpA-1EJMI5BM6aC6Npt5gi3GXnJbP5edli-B0MrCK0grI5dFkezp_PzSBAxqeCVytC14yXFjkSMv2lxo6S3BZsyz4vDEmK7pEN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeiieelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:23_saKNlYtmjeI0UoXaQmBPqqcMwB5eESks18NC_ny_BeMoaPpSBew>
    <xmx:23_saLiYLTW-iqQBRC3hdUPDzMuBfZO7w5VG5oLDECwFH25QCqCFeA>
    <xmx:23_saE4rXXzR3T9mj3-hWoupHu0wBRhnjg34K_vLe9PwWrJz5Qcy7A>
    <xmx:23_saK05CEZAG2Yp9X_z2CnF1zREiCd4C4wmBML7jWcK9vjqTcxBUQ>
    <xmx:3H_saIosk_asgKOGXb2lxKnZganzWCPo0bj86yeE0bqZlP2nIsn-rGam>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 00:28:09 -0400 (EDT)
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
Subject:
 Re: [PATCH v4 1/4] NFSD: Skip close replay processing if XDR encoding fails
In-reply-to: <20251012170746.9381-2-cel@kernel.org>
References: <20251012170746.9381-1-cel@kernel.org>,
 <20251012170746.9381-2-cel@kernel.org>
Date: Mon, 13 Oct 2025 15:28:01 +1100
Message-id: <176032968141.1793333.13161955919759841575@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 13 Oct 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The close replay logic added by commit 9411b1d4c7df ("nfsd4: cleanup
> handling of nfsv4.0 closed stateid's") cannot be done if encoding
> failed due to a short send buffer; there's no guarantee that the
> operation encoder has actually encoded the data that is being copied
> to the replay cache.
>=20

Nit: I don't think this is just for "close" replay.  I think it is for
reply for any "sequence id mutating" operation that uses an open-owner.

But the patch itself is good.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

> Reported-by: <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/linux-nfs/c3628d57-94ae-48cf-8c9e-49087a28c=
ec9@oracle.com/T/#t
> Fixes: 9411b1d4c7df ("nfsd4: cleanup handling of nfsv4.0 closed stateid's")
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 230bf53e39f7..85b773a65670 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5937,8 +5937,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp=
, struct nfsd4_op *op)
>  		 */
>  		warn_on_nonidempotent_op(op);
>  		xdr_truncate_encode(xdr, op_status_offset + XDR_UNIT);
> -	}
> -	if (so) {
> +	} else if (so) {
>  		int len =3D xdr->buf->len - (op_status_offset + XDR_UNIT);
> =20
>  		so->so_replay.rp_status =3D op->status;
> --=20
> 2.51.0
>=20
>=20


