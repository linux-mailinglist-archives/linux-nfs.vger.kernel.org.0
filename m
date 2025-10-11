Return-Path: <linux-nfs+bounces-15144-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7ABCED39
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 02:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02E1E4E1CA9
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 00:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D692B9B9;
	Sat, 11 Oct 2025 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="vafvDzWv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UemyHseb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423E1F5EA
	for <linux-nfs@vger.kernel.org>; Sat, 11 Oct 2025 00:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760143134; cv=none; b=mYhL954ZMRwfwLweVoNSTQ2LLh8+Pc3gKcFCisWo7Ni7jfy7yqBRKpjjj1Cu4zVvPwnohHlX7/OSDhKFPMN72LNcXbn4Xu0nEvdAmVAoqzjpkKhArn88ImDUk/+THPttKEkzHVRc7iKAQzfHSVeYuCZYLdAa2z3ShZUBpp4MGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760143134; c=relaxed/simple;
	bh=PKa1nVat9qxBHrEJtJV1858EEhg6JfhEqz14ynYjWN0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UyMMG5ZHO6DZN7lXkKR0lHSh5Dv6FS/cAEpPdNybGISK0qN9ospI03BEa/XvtBkaw4EbcpHlD+odpXIHIMuOcimSj8FkFLp2xRV8fj8flfXa+ll0ZF6yjRdDJagzQ+vfY+X7hyJpYponDqzUmEEiHR3k20ztniAM2Z4hK8sqVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=vafvDzWv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UemyHseb; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 05A691D0009E;
	Fri, 10 Oct 2025 20:38:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 10 Oct 2025 20:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760143129; x=1760229529; bh=g5IV9JLK7zgHfdRn613OXf9ymE1qZquGGDT
	rPpjuNYM=; b=vafvDzWvxClXOSiSPPoYTtJO6R8nJh9exaZu/chcEn0E7mIYvi+
	Tdfls/jc8qGcfZqilnni+RvWzMGCnPCenE36TJInoRXV7gZETh3EWIlbLFjlraqd
	CCI/hsj8cd+/EZ6Ca9aK1KH5G9Bxb7OdpIoDzUsdm1AN9cL/QMNmTXYjRO8K5Jpn
	tQKA/f2R6jSAHeTQF1utN1idIWPb4SSIY+VbKbgQSpV9mtuPTlgRb7RgxL+eZ+Pr
	sjLyP9RvvMQraRBX0Bfy7boDpuBqrBsa4G0x6quRQ7VtCN8xa4JfeDrmgxb6FWs/
	So5yogipwI58Qy4hxGKKYYR+DwXlkvQiPNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760143129; x=
	1760229529; bh=g5IV9JLK7zgHfdRn613OXf9ymE1qZquGGDTrPpjuNYM=; b=U
	emyHsebRYt7q6KFaW0DOvDdRsHiDIqRkcwJR5inRyT1A7lRjDhXDskLVE6P+l5En
	TnKENXioJuGk824/9PNO1T9bk07FH7obLa4rnBYJz7IdyAmAa0Iac9eGqNeSwsnz
	/pHAOAqviOJsD0o0KGAdrdgnV0xLHWuDw9Wsqwrr1x6C0/V4L6Uh87k+aZ4HHXaJ
	7WxhzenMkpfeQEIxOwb/wt59wMyCg0MlajDR0p1Rqm677dzyFKIhbtJeOYGdjVNy
	vMhudjinnzw1+IVBM3FH7VM/XOZbZDOILMMeRMfdUvUwYOL0XoabLHuJH44TAxQh
	boEnq2CPaxPN8JPEL06Ig==
X-ME-Sender: <xms:GafpaJazVC83wCd24P9ayY10kLsKw1A_2oemx7thgaCNUJq8o_rRNA>
    <xme:GafpaCo_f-G28BX1AgWRk2Zjtc5I3UFuv36QXjrIe35DBAEYYkXtVY7IIUv2-R7En
    1bRZ2IhEcZf5kOwDMVL_wSB_oaWvECtnTIJidn5x-rSCoPAyQ>
X-ME-Received: <xmr:GafpaON86edpy8bchjQotriPsnVfqwbz13h0jtowDaCVteeD7LvS_jsW-SwwKLx9sKni268Tq4HGiq1UXP9671wGmjC2MOY7MOtCx7Bt2jH5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    gvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GafpaNqMkQ4G0XTBn_92dXQNuDPUHFm-UTtHVfh1Z9q_SqksC41YrQ>
    <xmx:GafpaDepMSUhgKIJl4yiz68SpeIAinQcEqlaMnrLNTcuNV8u9-o09w>
    <xmx:GafpaDTWLXdgZ4lHTXZozkr0RPSUqBuC3Jcxukg8yDe1kXCMTifGww>
    <xmx:GafpaMZHwfDrvpHW_xMeoLVG3TkIwuowlTTmEVBdvUk53ICYjdWTwQ>
    <xmx:GafpaGV9eXyiNUaemKDwDipby4r3RIqSFwTJXrS_R6qSm9S7mNKMVf5H>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 20:38:47 -0400 (EDT)
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
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 3/5] nfsd: Never cache a COMPOUND when the SEQUENCE
 operation fails
In-reply-to: <20251010135623.1723-4-cel@kernel.org>
References: <20251010135623.1723-1-cel@kernel.org>,
 <20251010135623.1723-4-cel@kernel.org>
Date: Sat, 11 Oct 2025 11:38:45 +1100
Message-id: <176014312562.1793333.12443844357649655554@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 11 Oct 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> RFC 8881 normatively mandates that operations where the initial
> SEQUENCE operation in a compound fails must not modify the slot's
> replay cache.
>=20
> nfsd4_cache_this() doesn't prevent such caching.
>=20
> Fixes: 468de9e54a90 ("nfsd41: expand solo sequence check")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c9053ef4d79f..7b80f00fb32c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3477,16 +3477,26 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_=
setclientid *se, struct svc_r
>  }
> =20
>  /*
> - * Cache a reply. nfsd4_check_resp_size() has bounded the cache size.
> + * Maybe cache a reply. nfsd4_check_resp_size() has bounded the cache size.
>   */
>  static void
>  nfsd4_store_cache_entry(struct nfsd4_compoundres *resp)
>  {
> -	struct xdr_buf *buf =3D resp->xdr->buf;
> +	struct nfsd4_compoundargs *args =3D resp->rqstp->rq_argp;
>  	struct nfsd4_slot *slot =3D resp->cstate.slot;
> +	struct xdr_buf *buf =3D resp->xdr->buf;
>  	unsigned int base;
> =20
> -	dprintk("--> %s slot %p\n", __func__, slot);
> +	/*
> +	 * RFC 5661 Section 2.10.6.1.2:
> +	 *
> +	 * Any time SEQUENCE ... returns an error ... [t]he replier MUST NOT
> +	 * modify the reply cache entry for the slot whenever an error is
> +	 * returned from SEQUENCE ...
> +	 */
> +	if (resp->opcnt =3D=3D 1 && args->ops[0].opnum =3D=3D OP_SEQUENCE &&
> +	    resp->cstate.status !=3D nfs_ok)
> +		return;

This function is only called from nfsd4_sequence_done() when
nfsd4_has_session(), and that can only succeed if a SEQUENCE op
(as the first op) has been performed.

So the OP_SEQUENCE test is redundant.  So args is not necessary.

I think this is the primary bug-fix and should be moved earlier in the
series.

It would be worth noting in the commit message that when SEQUENCE fails,
cstate.data_offset is not set, so the function can access uninitialised
data.

Thanks,
NeilBrown





> =20
>  	slot->sl_flags |=3D NFSD4_SLOT_INITIALIZED;
>  	slot->sl_opcnt =3D resp->opcnt;
> --=20
> 2.51.0
>=20
>=20


