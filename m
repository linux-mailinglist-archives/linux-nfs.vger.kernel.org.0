Return-Path: <linux-nfs+bounces-11217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F869A97A41
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 00:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8077A19F5
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Apr 2025 22:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4511EE7DD;
	Tue, 22 Apr 2025 22:14:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73197242D69
	for <linux-nfs@vger.kernel.org>; Tue, 22 Apr 2025 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360076; cv=none; b=HhpRxrFpkRm85ro5CKtGWwbqY4JWmXlQqRZZ+tipl+KuCba5SKpHEeLHL2+dKJsOFRNp46uBcns7E78fYXwYauHHpu5D4RmERXNoKrtQ0MSX1rgpokYiEQGgx9c5TOq3AMGdEwg/t7QWVENKWZVrJ1t5Y8dZHJZhUymyjsgyIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360076; c=relaxed/simple;
	bh=sdp3CJEsGi1TWnbFb6iRTz2Gyc01RXZ1ZEUK4kExVRw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tU8L/dzy9/dZnF+Hf75sGyM2EZvW9XLFnP6LiIjwoOgPPC9KY3gt2/k+8vOpF6QC7Q0laX/BOBGIdckxHTwnGuPHbjv71tDn4rodUG43PI1KK/kLSxNPQgyJnEffEVsb5W9rCNGBMfXHZjN5HuWy/FRbdfBXZ57DEN8RsSZ/WCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u7LGY-0002sG-Dg;
	Tue, 22 Apr 2025 21:34:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: cel@kernel.org
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v2 02/10] sunrpc: Add a helper to derive maxpages from sv_max_mesg
In-reply-to: <20250419172818.6945-3-cel@kernel.org>
References: <20250419172818.6945-1-cel@kernel.org>,
 <20250419172818.6945-3-cel@kernel.org>
Date: Wed, 23 Apr 2025 06:48:38 +1000
Message-id: <174535491846.500591.11542398392986089529@noble.neil.brown.name>

On Sun, 20 Apr 2025, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> This page count is to be used to allocate various arrays of pages,
> bio_vecs, and kvecs, replacing the fixed RPCSVC_MAXPAGES value.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 74658cca0f38..5b879c31d7b8 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -159,6 +159,18 @@ extern u32 svc_max_payload(const struct svc_rqst *rqst=
p);
>  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
>  				+ 2 + 1)
> =20
> +/**
> + * svc_serv_maxpages - maximum pages/kvecs needed for one RPC message
> + * @serv: RPC service context
> + *
> + * Returns a count of pages or vectors that can hold the maximum
> + * size RPC message for @serv.
> + */
> +static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
> +{
> +	return ((serv->sv_max_mesg + PAGE_SIZE - 1) >> PAGE_SHIFT) + 2 + 1;
> +}
> +

This looks like it should be
     DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2

Could we document what the "+ 2" is for??

Thanks,
NeilBrown


>  /*
>   * The context of a single thread, including the request currently being
>   * processed.
> --=20
> 2.49.0
>=20
>=20


