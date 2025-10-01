Return-Path: <linux-nfs+bounces-14832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB23BAEE9F
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 02:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900D9170ED3
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 00:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551BA229B2A;
	Wed,  1 Oct 2025 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="M23gpHFD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XST06X58"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4822D4F1
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759280051; cv=none; b=QVpkevPvSa9NetC4VS10gti9XLc7ZHkgm+1izHSHoAL2mI1iwRHKgFvzjn66Bqy+oy2NbRbqvgtcF0ltGNFjsIuaAA/ZDuOEJRQ1QFy6BNCuBmoL4KiqMA4To9GMmX/28L0pcttRPRdQGFHbON3xLEC9Z8r98LFcZonh29wvDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759280051; c=relaxed/simple;
	bh=VcRaMKbZT8NY0itF10Nog7Lm1fJSI/gDUAoom4gNMmc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bWPoTI0Ff1j7TPsiyGnov7JM+iy/jI+/bgYxu4woZw+23WupAhwBH/AHtw9XfIKTzjCydl4YFa86q8uDrnrKrKSkepiMEgySZlT+pK1r6Tqs5mRDwZoKaPpibIl51qL4AUmYNXjsj6qZ3l6FnT7PymOZe2+pO38tSVh7eXin82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=M23gpHFD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XST06X58; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB91F140010B;
	Tue, 30 Sep 2025 20:54:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Sep 2025 20:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759280047; x=1759366447; bh=DqI0+wGq7ZJLYtXFXi53in9ZUWDYp1ahOoA
	EfSiqxIw=; b=M23gpHFDvNmOWLwrkPFn1mAoprHrts3pnws6qO+ZV+tyseLH5Px
	64s43Az0izOy+ij9qOjYxiyImUHoDSuYjQlC4ecpEH4j+RPSjT3qlN4t8tZ0PxKK
	sLelbfkQU0lL4fsGR/SXAsFTuCibzgrLjpnG9cfBpT0gSs3CyK0cYbMZHm27ZYr9
	sxfxbu8PPgH6x9YyRr+4kct0SyLaomz6OndMp4SeZpoSHfM/dJItC1iS2RgdDBdI
	xljnB5MEM7kZtvQTh/hS2V2CJ65NGUexWQau0Lxkc5vq7m9yJtO6SbkePVrYN8KO
	1uT5SdXU37WCE6e/Bl1R9cJ8qMjDZa58McQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759280047; x=
	1759366447; bh=DqI0+wGq7ZJLYtXFXi53in9ZUWDYp1ahOoAEfSiqxIw=; b=X
	ST06X58Xi1QcFgM39xiHD5wXczGv2B0jyOB02Tcmuh3gaARlga0eYm4w9Qo/YO96
	HUXJHQrbmieW6ENhtLU79jpdGaJQaiDHcu/c4c60VjNk57OGfX0JfgsGKks2BgOn
	/WIFaxLs6OAkEHQ4we0KqLbhun7y219+j9blhZ8E7mc69L7kXnFk2XdozWsE3n4J
	CnIpiycHEHgDH8ytRAU6pL8yARuClu7RyeCKONfTWIQsxOHxLHj2VeheGVdgyGxe
	IG/T15pUHsELnrvOL1UE4Hvvomv0YW+0aA/Z3WE97HEvqf8H7QdnBpM7YIjvH3+A
	abxtJJ+xXQkeoipZZhVkw==
X-ME-Sender: <xms:r3vcaIb8Iexu2Zd3SiIFcM1WTjkvslRkFDvHamDn2URr7Hxz_IYW9g>
    <xme:r3vcaFrtrhEZozcT2wqfwUSxAwqUzjwkvMV3cWpY2vUGht7ZdPRYf8byleKEjHuro
    G8Suq3xyZUZoe7e-CMf_Z0APFZX4_Qd4Q0ZAmmPpFu_qCemtA>
X-ME-Received: <xmr:r3vcaFPH9XbCYEot2VCIS1Shiy8eKKHdkydLqHSr6hVAp9tD0uGCMouvbJqRpdlTI9TE35jmouVnKGXA7W7QJtcFb8_aMdu4zkGSNuTbDdKX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r3vcaIre7cDuQOipdGKI9RjPUF1ZCOprgwKATEOvWFVhG0Ip8nChNg>
    <xmx:r3vcaCeRJPaKBDvMe9sUX1PpixSdN2czXfAQQIG5d-_sqLN78HglRw>
    <xmx:r3vcaGQ3PJwN955H_Ek5deyGK6PiKK8wgAh0dN_D8gewtrDXe6yZQg>
    <xmx:r3vcaDbJcdtomu0FLSpOzZwUB6Bqqwg1z-23gTzuWxeRJXetKIQGaA>
    <xmx:r3vcaJXHjvdPgdr0HbXH12vOkQyU5m70o9gFOaznkdnANFNXTi9wLPJ6>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 20:54:05 -0400 (EDT)
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
Subject: Re: [PATCH v1] NFSD: Fix crash in nfsd4_read_release()
In-reply-to: <20250930140520.2947-1-cel@kernel.org>
References: <20250930140520.2947-1-cel@kernel.org>
Date: Wed, 01 Oct 2025 10:53:57 +1000
Message-id: <175928003792.1696783.17556773248679753110@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 01 Oct 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> When tracing is enabled, the trace_nfsd_read_done trace point
> crashes during the pynfs read.testNoFh test.
>=20
> Fixes: 87c5942e8fae ("nfsd: Add I/O trace points in the NFSv4 read proc")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index e466cf52d7d7..f9aeefc0da73 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -988,10 +988,11 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
>  static void
>  nfsd4_read_release(union nfsd4_op_u *u)
>  {
> -	if (u->read.rd_nf)
> +	if (u->read.rd_nf) {
> +		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> +				     u->read.rd_offset, u->read.rd_length);
>  		nfsd_file_put(u->read.rd_nf);
> -	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> -			     u->read.rd_offset, u->read.rd_length);
> +	}
>  }

I must say this looks a bit weird.  rd_nf isn't used in the trace but if
it isn't set, you say the trace crashes...

That is because rd_fhp being NULL (because there is no current_fh) is
one thing that results in rd_nf being NULL.  Seems a bit indirect.
Did you consider
   if (u->read.rd_fhp)
       trace .....
   if (u->read.rd_nf)
       nfsd_file_put....

??
Or maybe
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -444,7 +444,7 @@ DECLARE_EVENT_CLASS(nfsd_io_class,
 	),
 	TP_fast_assign(
 		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
-		__entry->fh_hash =3D knfsd_fh_hash(&fhp->fh_handle);
+		__entry->fh_hash =3D fhp ? 0 : knfsd_fh_hash(&fhp->fh_handle);
 		__entry->offset =3D offset;
 		__entry->len =3D len;
 	),


That would make all IO event trace points robust.

I'm almost tempted to suggest knfsd_fh_hash() be changed to receive a
svc_fh and test for NULL, but there are 2 places where there isn't a
svc_fh handy.

NeilBrown


