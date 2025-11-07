Return-Path: <linux-nfs+bounces-16180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228EC40948
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D6F1889D3A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92692239E9E;
	Fri,  7 Nov 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshua.hu header.i=@joshua.hu header.b="i8d+q1qi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC43271EF
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529304; cv=none; b=Df4Q1KXsYnh9qGc8L/DPCDLnsqxvz+I1REkuMt+Sv2RXeO6GwJtyTRNQCmKM7PJk2UJIbgC0JPrEegcbxhrGlcFflSsbzelDxIhOdxFcQpFUkqmCfIIkTgFM0We1RNmxx5HjcXakok2nisPd0lVuQ06yJ36sBZ+GNK/701josmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529304; c=relaxed/simple;
	bh=hJzS02rP0AnAnJ60/YAmGtiQoi39f08YIZAT89xXNec=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTr+H20CgbU+DuVhdrlTJixHVbtF1TAjTMycrxfShEMVrxYMFsHBFuUGFRKRe+999BxrCS06cKCzsOTDxgM0XatzFx4rUQac/lxfyYQzzJKD7fFuS2YJvN5qA/eTXGKF2TEOM6urCHVDAWdNXQqBT/XoKRCGan83fPBIi+7cNb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joshua.hu; spf=pass smtp.mailfrom=joshua.hu; dkim=pass (2048-bit key) header.d=joshua.hu header.i=@joshua.hu header.b=i8d+q1qi; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joshua.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshua.hu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joshua.hu;
	s=protonmail2; t=1762528993; x=1762788193;
	bh=hJzS02rP0AnAnJ60/YAmGtiQoi39f08YIZAT89xXNec=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i8d+q1qiIRpbZCv40S650IAOS12bBYlDFmd1VwB0OTrSwFsPkbDAAULwC0vh8JHbk
	 wCoIyXLZkxQ6iA9immHHXgMzuxd3bd389tWHKu4/+m7GEKYD9DFrcz+CW4IqRVMNKa
	 OJuWSLX2VXgANyMDhCR74lscGNAUvRTSEQI8Y5XLS0mIZP+/OjRo0VORi9/nL18EA6
	 S1wLreb71snEWtZYASxoBTL1LDE0LtR1F1Kmn57R1UQjB+xzfoBnuQzgn6cJI7pNki
	 vQ7m3p7Q48tfmar6HvyP0ja02iADilF8HKGeQF4SZnF9LxRIfc8w7Ky+4giNNhiU9F
	 BRAFFVKW0+l5Q==
Date: Fri, 07 Nov 2025 15:23:06 +0000
To: Chuck Lever <cel@kernel.org>
From: Joshua Rogers <reszta@joshua.hu>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joshua Rogers <linux@joshua.hu>
Subject: Re: [PATCH 1/3] svcrdma: use rc_pageoff for memcpy byte offset
Message-ID: <fxcda7FkdbPG_fttyXlSupjn11fncefYSlmcpQVVhEqZtDujhBlOxPADG_Havmcju29ZqPMXVwmMI980FtUVWs9jDUYiy-JWbaClISNNwQk=@joshua.hu>
In-Reply-To: <20251107150949.3808-1-cel@kernel.org>
References: <20251107150949.3808-1-cel@kernel.org>
Feedback-ID: 126372902:user:proton
X-Pm-Message-ID: b8c332fb05f9bf71f35e34d3d2e7a48fc888e7f1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Apologies: is it possible to slightly change the commit msg to include "Fou=
nd with ZeroPath"? As this bug was, indeed, found with a tool called ZeroPa=
th. If not, it's OK, thought I'd ask.

Thank you.


On Friday, 7 November 2025 at 23:09, Chuck Lever <cel@kernel.org> wrote:

>=20
>=20
> From: Joshua Rogers linux@joshua.hu
>=20
>=20
> svc_rdma_copy_inline_range added rc_curpage (page index) to the page
> base instead of the byte offset rc_pageoff. Use rc_pageoff so copies
> land within the current page.
>=20
> Fixes: 8e122582680c ("svcrdma: Move svc_rdma_read_info::ri_pageno to stru=
ct svc_rdma_recv_ctxt")
> X-Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Rogers linux@joshua.hu
>=20
> Signed-off-by: Chuck Lever chuck.lever@oracle.com
>=20
> ---
> net/sunrpc/xprtrdma/svc_rdma_rw.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_=
rdma_rw.c
> index 661b3fe2779f..945fbb374331 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -848,7 +848,7 @@ static int svc_rdma_copy_inline_range(struct svc_rqst=
 *rqstp,
> head->rc_page_count++;
>=20
>=20
> dst =3D page_address(rqstp->rq_pages[head->rc_curpage]);
>=20
> - memcpy(dst + head->rc_curpage, src + offset, page_len);
>=20
> + memcpy((unsigned char *)dst + head->rc_pageoff, src + offset, page_len)=
;
>=20
>=20
> head->rc_readbytes +=3D page_len;
>=20
> head->rc_pageoff +=3D page_len;
>=20
> --
> 2.51.0

