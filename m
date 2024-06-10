Return-Path: <linux-nfs+bounces-3628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EAB902185
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 14:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5181C212ED
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6737F499;
	Mon, 10 Jun 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biyd+hYL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E17F7C6
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022102; cv=none; b=HVIQoRdSb3cJCbKt8Ken1vcpBYS2dgiAolDl/SycHlnEBkj/lUVN0ETFvP2AjYxiJUNTgE7caojzDDXuPuKzMNSBf70kUn0znebHe1bfD1HkAZr9/5bLt5Elr2GZ+1VGGiL9qwUn98PZdFiW5BV2Q1vSXeizSBs3nCicDDrvLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022102; c=relaxed/simple;
	bh=3ixPS2CoFpF1Evucbd5egsI/P5ahevKi50HuuhvLcY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAAyC5phRKThTbz0kW1D91lbHF1Aoja8BwuTv8UFStT6nb4GHwBMuGpdkgf8Q14LAptgY8uM6msiMRrEfgy/mHiOQdAHb8V7d4dzDk1wdnUAF0I2XPP9si/tvdPJ6fnl0sWDmnVj65jYNRgItSnGBnzu/jN5/+7YxL5zSXVYD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biyd+hYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8853C2BBFC;
	Mon, 10 Jun 2024 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718022102;
	bh=3ixPS2CoFpF1Evucbd5egsI/P5ahevKi50HuuhvLcY0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=biyd+hYL7cyohLYJCi0qHbL9f4yeThdbMqI/mvTjXvL4y5HzuFyfF+GsSv9DKSv0y
	 Mwr4JRyXqugQzm2x2QxW5TyWWYz/j9T1j4KtinFujqakTo1d+21NlrcZ/+xLVJl7es
	 RAhlFlRRZ3FrOFY3kLhxmy96S/bjhSUfzej7bvFu52JS2ug4SipOdedfabiI1SZNaZ
	 P4wtbVOBRUKqK9EGSnTQ8UxsB6Zf5gUWdJxMI6yPgMEhJHQVJmzConRn2LSNL4Lnkm
	 OH/6YsVir9AKZfdEkT1a2fb3uYgOQZP1KYj7mIeI1e9WYj+97rz3/6lb4g/jqBMt6o
	 DBywnhl/mwZ6A==
Message-ID: <903610ef28512c03fd8db6b4b57e65b3a8bda8a9.camel@kernel.org>
Subject: Re: [for-6.11 PATCH 04/29] sunrpc: handle NULL req->defer in
 cache_defer_req
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
	 <trondmy@hammerspace.com>, snitzer@hammerspace.com, neilb@suse.de
Date: Mon, 10 Jun 2024 08:21:40 -0400
In-Reply-To: <20240607142646.20924-5-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
	 <20240607142646.20924-5-snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 10:26 -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> Dont crash with a NULL pointer dereference when req->defer isn't
> set. This is needed for the localio path.
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0net/sunrpc/cache.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 95ff74706104..b757b891382c 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -714,6 +714,8 @@ static bool cache_defer_req(struct cache_req
> *req, struct cache_head *item)
> =C2=A0			return false;
> =C2=A0	}
> =C2=A0
> +	if (!req->defer)
> +		return false;
> =C2=A0	dreq =3D req->defer(req);
> =C2=A0	if (dreq =3D=3D NULL)
> =C2=A0		return false;

I've gone over it many times, but I still don't quite "get" the
deferral handling code. I think the above is probably safe, but please
do Cc Neil Brown on later postings of this series since he has a better
grasp of that code.
--=20
Jeff Layton <jlayton@kernel.org>

