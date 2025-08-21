Return-Path: <linux-nfs+bounces-13828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D402B2F7E1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 14:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18223BD7E8
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21D530DD3E;
	Thu, 21 Aug 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAnJSUQV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D62E11D7
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779072; cv=none; b=XqX/S+QgB1lWfdUEH6P8jTrcqbsl4LQ/UY/FXO2H5uj9U5X2YsOvejP8q5baZPA437pxGF4hV2F5Z99043GQ1+JVRRVur95YlG45j+RbhBlZ0Knija36q1gX79AS0r4w8gW453PN0Y/7xWDJEnYPD3AG+MpuKWgrzkw6AB62MPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779072; c=relaxed/simple;
	bh=wG8VfiPgfaLF3MQddC3tcuNLM3zb8W9b7r/s95qL7AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qN/jQ7Vax4Zk9ZQdbfnxBWzPaRzdBajVzW8/8PxYKsR0dca67hiWqZ3U1gJ469ya4FiGMf4nqR0QFcQd0H6nXGu3gjUJGcCrTcZQ6Neo+NI2uDr/DxkpdLe37rw0AjKLjaqDOXr8E5uy+vb+kgcPDz1864Zmq/oFYfd9HMx/Mzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAnJSUQV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755779068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxDzc6gr2f4+1PVFN1riwwzGNxE4MTYm2uhFnV2byWE=;
	b=VAnJSUQVbCRtPyqOfS99YQ5Fl/DBDp+eG9OPgeheJNq/WbCV/TPNFMSdPGmfxgg1FQnBdq
	BqWC3ZZj78B/Sd7jbI4ETr204/DA9n36fTs6I0uuuf7dQR0RfGJ4Z2dM5DpO6QX8smW4xf
	Hm3pH1BVOKAZO+pX94nicr4laInIDg0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-DTjdEIK5Ow2WPDh0Erd2IQ-1; Thu, 21 Aug 2025 08:24:27 -0400
X-MC-Unique: DTjdEIK5Ow2WPDh0Erd2IQ-1
X-Mimecast-MFC-AGG-ID: DTjdEIK5Ow2WPDh0Erd2IQ_1755779067
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71fb2d5c95bso11958417b3.3
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 05:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779067; x=1756383867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxDzc6gr2f4+1PVFN1riwwzGNxE4MTYm2uhFnV2byWE=;
        b=cGrPHua5CiA2PltpNdEGtaf/zHakb9yqJmDy1g9EmJVUnbJnjVgYVcav9H2xcK4KaN
         NBIXbl5W90a6KSND+q++kRYeszdfRr2PcmRYEQmuO87sb5DeQE6NwTA3QoSgsiJFkqz+
         VdDz1yB0SPX5hEn3GD41VJoFKqU3V6apHpCxNY9JgThe/YVbe3iPhudUrPGIRYg7uByx
         WEv1HnbxqAgq1ATP3pS1yoKkE9SzFPxvtr/76PUtkjBr7M20YF2F63ce2YJAxeDOUtxS
         +MzgwmDGfQVSud6CC+5W16OAwTGQ2qvzQNSVAX3Vc3ND69aKleRcO30iheiGrHDbnecP
         QHcA==
X-Gm-Message-State: AOJu0YwXSZtY3SJ+UadpUMpZKk1TfcRqXdmnSITskrSEIYGKJL8eaH7+
	AivN8se7RFQOudIZ2Z1/YhepJ+87IpMeSX4Q/zdgp0yG7gf+Puz+86cOUkCOONAFz3bY6aYQd/1
	+UieXbSsCfj10EEOQDJzjS+vCXEfmrYmtQBCB8fiOullGP+iYaUiHIN0xwciQkg==
X-Gm-Gg: ASbGnctprgT28TBPLOe+LFPDGvGiLw4uo9eiPgpy03V7ASLUH02m9Jym/uAznEtCktn
	TxCyMWMaqay//Hq3PJLcpmyz6v15XbVWkjcT59xkTlbnhnhHWymATuqDLbBwF5R7ZFlVUpW7jJ4
	pTuf/VocZeE+9I4o1P+9vPAlHi+qkEz1SIYTK3Lh6jyS1UKbeyqCWCUjg1glHInJuoujRspW+LP
	IPKllJq2zwR1Mnvn5jpuOn3cwrR0n6P9IydOnsLX+R7/wHBn25uFdCMY+SXSuN5A1ig2puMRkc2
	urrd03qG2TJKZtmq8StW4cWijGd53bmRl9K0nXOr
X-Received: by 2002:a05:6902:6c14:b0:e93:3184:a67f with SMTP id 3f1490d57ef6-e950890f4f3mr2663945276.16.1755779066258;
        Thu, 21 Aug 2025 05:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaJLeIBv9vwj7FOLxBc0gQ8x7uwHWuZTLllfoXxW2iuH78Ru8pU6kpnBI643nAGomh/aNU1Q==
X-Received: by 2002:a05:6902:6c14:b0:e93:3184:a67f with SMTP id 3f1490d57ef6-e950890f4f3mr2663896276.16.1755779065292;
        Thu, 21 Aug 2025 05:24:25 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.250.115])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9515993be9sm242640276.16.2025.08.21.05.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 05:24:24 -0700 (PDT)
Message-ID: <e508e4d3-659f-402b-862f-ef4b1ed06299@redhat.com>
Date: Thu, 21 Aug 2025 08:24:23 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Libtirpc-devel] [PATCH 01/12] Convert old-style function
 definitions into modern-style definitions
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20250818150829.1044948-1-steved@redhat.com>
 <20250818150829.1044948-2-steved@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250818150829.1044948-2-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Sorry for the repost... ]

steved.

On 8/18/25 11:08 AM, Steve Dickson via Libtirpc-devel wrote:
> With newer compilers (gcc 15.1.1) -Wold-style-definition
> flag is set by default which causes warnings for
> most of the functions in these files.
> 
>      warning: old-style function definition [-Wold-style-definition]
> 
> The warnings are remove by converting the old-style
> function definitions into modern-style definitions
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>   src/xdr.c           | 224 ++++++++++++++++++++++----------------------
>   src/xdr_array.c     |  26 ++---
>   src/xdr_float.c     |  12 +--
>   src/xdr_mem.c       |  74 +++++++--------
>   src/xdr_rec.c       | 121 +++++++++++-------------
>   src/xdr_reference.c |  20 ++--
>   src/xdr_sizeof.c    |  30 ++----
>   src/xdr_stdio.c     |  54 +++++------
>   8 files changed, 270 insertions(+), 291 deletions(-)
> 
> diff --git a/src/xdr.c b/src/xdr.c
> index 28d1382..27b5d8d 100644
> --- a/src/xdr.c
> +++ b/src/xdr.c
> @@ -66,9 +66,9 @@ static const char xdr_zero[BYTES_PER_XDR_UNIT] = { 0, 0, 0, 0 };
>    * Not a filter, but a convenient utility nonetheless
>    */
>   void
> -xdr_free(proc, objp)
> -	xdrproc_t proc;
> -	void *objp;
> +xdr_free(
> +	xdrproc_t proc,
> +	void *objp)
>   {
>   	XDR x;
>   	
> @@ -91,9 +91,9 @@ xdr_void(void)
>    * XDR integers
>    */
>   bool_t
> -xdr_int(xdrs, ip)
> -	XDR *xdrs;
> -	int *ip;
> +xdr_int(
> +	XDR *xdrs,
> +	int *ip)
>   {
>   	long l;
>   
> @@ -121,9 +121,9 @@ xdr_int(xdrs, ip)
>    * XDR unsigned integers
>    */
>   bool_t
> -xdr_u_int(xdrs, up)
> -	XDR *xdrs;
> -	u_int *up;
> +xdr_u_int(
> +	XDR *xdrs,
> +	u_int *up)
>   {
>   	u_long l;
>   
> @@ -153,9 +153,9 @@ xdr_u_int(xdrs, up)
>    * same as xdr_u_long - open coded to save a proc call!
>    */
>   bool_t
> -xdr_long(xdrs, lp)
> -	XDR *xdrs;
> -	long *lp;
> +xdr_long(
> +	XDR *xdrs,
> +	long *lp)
>   {
>   	switch (xdrs->x_op) {
>   	case XDR_ENCODE:
> @@ -174,9 +174,9 @@ xdr_long(xdrs, lp)
>    * same as xdr_long - open coded to save a proc call!
>    */
>   bool_t
> -xdr_u_long(xdrs, ulp)
> -	XDR *xdrs;
> -	u_long *ulp;
> +xdr_u_long(
> +	XDR *xdrs,
> +	u_long *ulp)
>   {
>   	switch (xdrs->x_op) {
>   	case XDR_ENCODE:
> @@ -196,9 +196,9 @@ xdr_u_long(xdrs, ulp)
>    * same as xdr_u_int32_t - open coded to save a proc call!
>    */
>   bool_t
> -xdr_int32_t(xdrs, int32_p)
> -	XDR *xdrs;
> -	int32_t *int32_p;
> +xdr_int32_t(
> +	XDR *xdrs,
> +	int32_t *int32_p)
>   {
>   	long l;
>   
> @@ -227,9 +227,9 @@ xdr_int32_t(xdrs, int32_p)
>    * same as xdr_int32_t - open coded to save a proc call!
>    */
>   bool_t
> -xdr_u_int32_t(xdrs, u_int32_p)
> -	XDR *xdrs;
> -	u_int32_t *u_int32_p;
> +xdr_u_int32_t(
> +	XDR *xdrs,
> +	u_int32_t *u_int32_p)
>   {
>   	u_long l;
>   
> @@ -258,9 +258,9 @@ xdr_u_int32_t(xdrs, u_int32_p)
>    * XDR unsigned 32-bit integers
>    */
>   bool_t
> -xdr_uint32_t(xdrs, uint32_p)
> -	XDR *xdrs;
> -	uint32_t *uint32_p;
> +xdr_uint32_t(
> +	XDR *xdrs,
> +	uint32_t *uint32_p)
>   {
>   	return (xdr_u_int32_t(xdrs, (u_int32_t *)uint32_p));
>   }
> @@ -270,9 +270,9 @@ xdr_uint32_t(xdrs, uint32_p)
>    * XDR short integers
>    */
>   bool_t
> -xdr_short(xdrs, sp)
> -	XDR *xdrs;
> -	short *sp;
> +xdr_short(
> +	XDR *xdrs,
> +	short *sp)
>   {
>   	long l;
>   
> @@ -300,9 +300,9 @@ xdr_short(xdrs, sp)
>    * XDR unsigned short integers
>    */
>   bool_t
> -xdr_u_short(xdrs, usp)
> -	XDR *xdrs;
> -	u_short *usp;
> +xdr_u_short(
> +	XDR *xdrs,
> +	u_short *usp)
>   {
>   	u_long l;
>   
> @@ -331,9 +331,9 @@ xdr_u_short(xdrs, usp)
>    * XDR 16-bit integers
>    */
>   bool_t
> -xdr_int16_t(xdrs, int16_p)
> -	XDR *xdrs;
> -	int16_t *int16_p;
> +xdr_int16_t(
> +	XDR *xdrs,
> +	int16_t *int16_p)
>   {
>   	long l;
>   
> @@ -361,9 +361,9 @@ xdr_int16_t(xdrs, int16_p)
>    * XDR unsigned 16-bit integers
>    */
>   bool_t
> -xdr_u_int16_t(xdrs, u_int16_p)
> -	XDR *xdrs;
> -	u_int16_t *u_int16_p;
> +xdr_u_int16_t(
> +	XDR *xdrs,
> +	u_int16_t *u_int16_p)
>   {
>   	u_long l;
>   
> @@ -392,9 +392,9 @@ xdr_u_int16_t(xdrs, u_int16_p)
>    * XDR unsigned 16-bit integers
>    */
>   bool_t
> -xdr_uint16_t(xdrs, uint16_p)
> -	XDR *xdrs;
> -	uint16_t *uint16_p;
> +xdr_uint16_t(
> +	XDR *xdrs,
> +	uint16_t *uint16_p)
>   {
>   	return (xdr_u_int16_t(xdrs, (u_int16_t *)uint16_p));
>   }
> @@ -404,9 +404,9 @@ xdr_uint16_t(xdrs, uint16_p)
>    * XDR 8-bit integers
>    */
>   bool_t
> -xdr_int8_t(xdrs, int8_p)
> -	XDR *xdrs;
> -	int8_t *int8_p;
> +xdr_int8_t(
> +	XDR *xdrs,
> +	int8_t *int8_p)
>   {
>   	long l;
>   
> @@ -435,9 +435,9 @@ xdr_int8_t(xdrs, int8_p)
>    * XDR unsigned 8-bit integers
>    */
>   bool_t
> -xdr_u_int8_t(xdrs, uint8_p)
> -	XDR *xdrs;
> -	uint8_t *uint8_p;
> +xdr_u_int8_t(
> +	XDR *xdrs,
> +	uint8_t *uint8_p)
>   {
>   	u_long l;
>   
> @@ -466,9 +466,9 @@ xdr_u_int8_t(xdrs, uint8_p)
>    * XDR unsigned 8-bit integers
>    */
>   bool_t
> -xdr_uint8_t(xdrs, uint8_p)
> -	XDR *xdrs;
> -	uint8_t *uint8_p;
> +xdr_uint8_t(
> +	XDR *xdrs,
> +	uint8_t *uint8_p)
>   {
>   	return (xdr_u_int8_t(xdrs, (uint8_t *)uint8_p));
>   }
> @@ -478,9 +478,9 @@ xdr_uint8_t(xdrs, uint8_p)
>    * XDR a char
>    */
>   bool_t
> -xdr_char(xdrs, cp)
> -	XDR *xdrs;
> -	char *cp;
> +xdr_char(
> +	XDR *xdrs,
> +	char *cp)
>   {
>   	int i;
>   
> @@ -496,9 +496,9 @@ xdr_char(xdrs, cp)
>    * XDR an unsigned char
>    */
>   bool_t
> -xdr_u_char(xdrs, cp)
> -	XDR *xdrs;
> -	u_char *cp;
> +xdr_u_char(
> +	XDR *xdrs,
> +	u_char *cp)
>   {
>   	u_int u;
>   
> @@ -514,9 +514,9 @@ xdr_u_char(xdrs, cp)
>    * XDR booleans
>    */
>   bool_t
> -xdr_bool(xdrs, bp)
> -	XDR *xdrs;
> -	bool_t *bp;
> +xdr_bool(
> +	XDR *xdrs,
> +	bool_t *bp)
>   {
>   	long lb;
>   
> @@ -544,9 +544,9 @@ xdr_bool(xdrs, bp)
>    * XDR enumerations
>    */
>   bool_t
> -xdr_enum(xdrs, ep)
> -	XDR *xdrs;
> -	enum_t *ep;
> +xdr_enum(
> +	XDR *xdrs,
> +	enum_t *ep)
>   {
>   	enum sizecheck { SIZEVAL };	/* used to find the size of an enum */
>   
> @@ -570,10 +570,10 @@ xdr_enum(xdrs, ep)
>    * cp points to the opaque object and cnt gives the byte length.
>    */
>   bool_t
> -xdr_opaque(xdrs, cp, cnt)
> -	XDR *xdrs;
> -	caddr_t cp;
> -	u_int cnt;
> +xdr_opaque(
> +	XDR *xdrs,
> +	caddr_t cp,
> +	u_int cnt)
>   {
>   	u_int rndup;
>   	static int crud[BYTES_PER_XDR_UNIT];
> @@ -622,11 +622,11 @@ xdr_opaque(xdrs, cp, cnt)
>    * If *cpp is NULL maxsize bytes are allocated
>    */
>   bool_t
> -xdr_bytes(xdrs, cpp, sizep, maxsize)
> -	XDR *xdrs;
> -	char **cpp;
> -	u_int *sizep;
> -	u_int maxsize;
> +xdr_bytes(
> +	XDR *xdrs,
> +	char **cpp,
> +	u_int *sizep,
> +	u_int maxsize)
>   {
>   	char *sp = *cpp;  /* sp is the actual string pointer */
>   	u_int nodesize;
> @@ -687,9 +687,9 @@ xdr_bytes(xdrs, cpp, sizep, maxsize)
>    * Implemented here due to commonality of the object.
>    */
>   bool_t
> -xdr_netobj(xdrs, np)
> -	XDR *xdrs;
> -	struct netobj *np;
> +xdr_netobj(
> +	XDR *xdrs,
> +	struct netobj *np)
>   {
>   
>   	return (xdr_bytes(xdrs, &np->n_bytes, &np->n_len, MAX_NETOBJ_SZ));
> @@ -707,12 +707,12 @@ xdr_netobj(xdrs, np)
>    * If there is no specific or default routine an error is returned.
>    */
>   bool_t
> -xdr_union(xdrs, dscmp, unp, choices, dfault)
> -	XDR *xdrs;
> -	enum_t *dscmp;		/* enum to decide which arm to work on */
> -	char *unp;		/* the union itself */
> -	const struct xdr_discrim *choices;	/* [value, xdr proc] for each arm */
> -	xdrproc_t dfault;	/* default xdr routine */
> +xdr_union(
> +	XDR *xdrs,
> +	enum_t *dscmp,		/* enum to decide which arm to work on */
> +	char *unp,		/* the union itself */
> +	const struct xdr_discrim *choices,	/* [value, xdr proc] for each arm */
> +	xdrproc_t dfault)	/* default xdr routine */
>   {
>   	enum_t dscm;
>   
> @@ -756,10 +756,10 @@ xdr_union(xdrs, dscmp, unp, choices, dfault)
>    * of the string as specified by a protocol.
>    */
>   bool_t
> -xdr_string(xdrs, cpp, maxsize)
> -	XDR *xdrs;
> -	char **cpp;
> -	u_int maxsize;
> +xdr_string(
> +	XDR *xdrs,
> +	char **cpp,
> +	u_int maxsize)
>   {
>   	char *sp = *cpp;  /* sp is the actual string pointer */
>   	u_int size;
> @@ -839,9 +839,9 @@ xdr_string(xdrs, cpp, maxsize)
>    * routines like clnt_call
>    */
>   bool_t
> -xdr_wrapstring(xdrs, cpp)
> -	XDR *xdrs;
> -	char **cpp;
> +xdr_wrapstring(
> +	XDR *xdrs,
> +	char **cpp)
>   {
>   	return xdr_string(xdrs, cpp, RPC_MAXDATASIZE);
>   }
> @@ -858,9 +858,9 @@ xdr_wrapstring(xdrs, cpp)
>    * XDR 64-bit integers
>    */
>   bool_t
> -xdr_int64_t(xdrs, llp)
> -	XDR *xdrs;
> -	int64_t *llp;
> +xdr_int64_t(
> +	XDR *xdrs,
> +	int64_t *llp)
>   {
>   	u_long ul[2];
>   
> @@ -892,9 +892,9 @@ xdr_int64_t(xdrs, llp)
>    * XDR unsigned 64-bit integers
>    */
>   bool_t
> -xdr_u_int64_t(xdrs, ullp)
> -	XDR *xdrs;
> -	u_int64_t *ullp;
> +xdr_u_int64_t(
> +	XDR *xdrs,
> +	u_int64_t *ullp)
>   {
>   	u_long ul[2];
>   
> @@ -926,9 +926,9 @@ xdr_u_int64_t(xdrs, ullp)
>    * XDR unsigned 64-bit integers
>    */
>   bool_t
> -xdr_uint64_t(xdrs, ullp)
> -	XDR *xdrs;
> -	uint64_t *ullp;
> +xdr_uint64_t(
> +	XDR *xdrs,
> +	uint64_t *ullp)
>   {
>   	return (xdr_u_int64_t(xdrs, (u_int64_t *)ullp));
>   }
> @@ -938,9 +938,9 @@ xdr_uint64_t(xdrs, ullp)
>    * XDR hypers
>    */
>   bool_t
> -xdr_hyper(xdrs, llp)
> -	XDR *xdrs;
> -	longlong_t *llp;
> +xdr_hyper(
> +	XDR *xdrs,
> +	longlong_t *llp)
>   {
>   
>   	/*
> @@ -955,9 +955,9 @@ xdr_hyper(xdrs, llp)
>    * XDR unsigned hypers
>    */
>   bool_t
> -xdr_u_hyper(xdrs, ullp)
> -	XDR *xdrs;
> -	u_longlong_t *ullp;
> +xdr_u_hyper(
> +	XDR *xdrs,
> +	u_longlong_t *ullp)
>   {
>   
>   	/*
> @@ -972,9 +972,9 @@ xdr_u_hyper(xdrs, ullp)
>    * XDR longlong_t's
>    */
>   bool_t
> -xdr_longlong_t(xdrs, llp)
> -	XDR *xdrs;
> -	longlong_t *llp;
> +xdr_longlong_t(
> +	XDR *xdrs,
> +	longlong_t *llp)
>   {
>   
>   	/*
> @@ -989,9 +989,9 @@ xdr_longlong_t(xdrs, llp)
>    * XDR u_longlong_t's
>    */
>   bool_t
> -xdr_u_longlong_t(xdrs, ullp)
> -	XDR *xdrs;
> -	u_longlong_t *ullp;
> +xdr_u_longlong_t(
> +	XDR *xdrs,
> +	u_longlong_t *ullp)
>   {
>   
>   	/*
> @@ -1005,9 +1005,9 @@ xdr_u_longlong_t(xdrs, ullp)
>    * XDR quad_t
>    */
>   bool_t
> -xdr_quad_t(xdrs, llp)
> -	XDR *xdrs;
> -	int64_t *llp;
> +xdr_quad_t(
> +	XDR *xdrs,
> +	int64_t *llp)
>   {
>   	return (xdr_int64_t(xdrs, (int64_t *)llp));
>   }
> @@ -1017,9 +1017,9 @@ xdr_quad_t(xdrs, llp)
>    * XDR u_quad_t
>    */
>   bool_t
> -xdr_u_quad_t(xdrs, ullp)
> -	XDR *xdrs;
> -	u_int64_t *ullp;
> +xdr_u_quad_t(
> +	XDR *xdrs,
> +	u_int64_t *ullp)
>   {
>   	return (xdr_u_int64_t(xdrs, (u_int64_t *)ullp));
>   }
> diff --git a/src/xdr_array.c b/src/xdr_array.c
> index 7fc8fb8..d95512b 100644
> --- a/src/xdr_array.c
> +++ b/src/xdr_array.c
> @@ -55,13 +55,13 @@
>    * xdr procedure to call to handle each element of the array.
>    */
>   bool_t
> -xdr_array(xdrs, addrp, sizep, maxsize, elsize, elproc)
> -	XDR *xdrs;
> -	caddr_t *addrp;		/* array pointer */
> -	u_int *sizep;		/* number of elements */
> -	u_int maxsize;		/* max numberof elements */
> -	u_int elsize;		/* size in bytes of each element */
> -	xdrproc_t elproc;	/* xdr routine to handle each element */
> +xdr_array(
> +	XDR *xdrs,
> +	caddr_t *addrp,		/* array pointer */
> +	u_int *sizep,		/* number of elements */
> +	u_int maxsize,		/* max numberof elements */
> +	u_int elsize,		/* size in bytes of each element */
> +	xdrproc_t elproc)	/* xdr routine to handle each element */
>   {
>   	u_int i;
>   	caddr_t target = *addrp;
> @@ -133,12 +133,12 @@ xdr_array(xdrs, addrp, sizep, maxsize, elsize, elproc)
>    * > xdr_elem: routine to XDR each element
>    */
>   bool_t
> -xdr_vector(xdrs, basep, nelem, elemsize, xdr_elem)
> -	XDR *xdrs;
> -	char *basep;
> -	u_int nelem;
> -	u_int elemsize;
> -	xdrproc_t xdr_elem;	
> +xdr_vector(
> +	XDR *xdrs,
> +	char *basep,
> +	u_int nelem,
> +	u_int elemsize,
> +	xdrproc_t xdr_elem)	
>   {
>   	u_int i;
>   	char *elptr;
> diff --git a/src/xdr_float.c b/src/xdr_float.c
> index c86d516..280f606 100644
> --- a/src/xdr_float.c
> +++ b/src/xdr_float.c
> @@ -95,9 +95,9 @@ static struct sgl_limits {
>   #endif /* vax */
>   
>   bool_t
> -xdr_float(xdrs, fp)
> -	XDR *xdrs;
> -	float *fp;
> +xdr_float(
> +	XDR *xdrs,
> +	float *fp)
>   {
>   #ifndef IEEEFP
>   	struct ieee_single is;
> @@ -197,9 +197,9 @@ static struct dbl_limits {
>   
>   
>   bool_t
> -xdr_double(xdrs, dp)
> -	XDR *xdrs;
> -	double *dp;
> +xdr_double(
> +	XDR *xdrs,
> +	double *dp)
>   {
>   #ifdef IEEEFP
>   	int32_t *i32p;
> diff --git a/src/xdr_mem.c b/src/xdr_mem.c
> index ecdc932..9ece51f 100644
> --- a/src/xdr_mem.c
> +++ b/src/xdr_mem.c
> @@ -88,11 +88,11 @@ static const struct	xdr_ops xdrmem_ops_unaligned = {
>    * memory buffer.
>    */
>   void
> -xdrmem_create(xdrs, addr, size, op)
> -	XDR *xdrs;
> -	char *addr;
> -	u_int size;
> -	enum xdr_op op;
> +xdrmem_create(
> +	XDR *xdrs,
> +	char *addr,
> +	u_int size,
> +	enum xdr_op op)
>   {
>   
>   	xdrs->x_op = op;
> @@ -104,16 +104,15 @@ xdrmem_create(xdrs, addr, size, op)
>   
>   /*ARGSUSED*/
>   static void
> -xdrmem_destroy(xdrs)
> -	XDR *xdrs;
> +xdrmem_destroy(XDR *xdrs)
>   {
>   
>   }
>   
>   static bool_t
> -xdrmem_getlong_aligned(xdrs, lp)
> -	XDR *xdrs;
> -	long *lp;
> +xdrmem_getlong_aligned(
> +	XDR *xdrs,
> +	long *lp)
>   {
>   
>   	if (xdrs->x_handy < sizeof(int32_t))
> @@ -125,9 +124,9 @@ xdrmem_getlong_aligned(xdrs, lp)
>   }
>   
>   static bool_t
> -xdrmem_putlong_aligned(xdrs, lp)
> -	XDR *xdrs;
> -	const long *lp;
> +xdrmem_putlong_aligned(
> +	XDR *xdrs,
> +	const long *lp)
>   {
>   
>   	if (xdrs->x_handy < sizeof(int32_t))
> @@ -139,9 +138,9 @@ xdrmem_putlong_aligned(xdrs, lp)
>   }
>   
>   static bool_t
> -xdrmem_getlong_unaligned(xdrs, lp)
> -	XDR *xdrs;
> -	long *lp;
> +xdrmem_getlong_unaligned(
> +	XDR *xdrs,
> +	long *lp)
>   {
>   	u_int32_t l;
>   
> @@ -155,9 +154,9 @@ xdrmem_getlong_unaligned(xdrs, lp)
>   }
>   
>   static bool_t
> -xdrmem_putlong_unaligned(xdrs, lp)
> -	XDR *xdrs;
> -	const long *lp;
> +xdrmem_putlong_unaligned(
> +	XDR *xdrs,
> +	const long *lp)
>   {
>   	u_int32_t l;
>   
> @@ -171,10 +170,10 @@ xdrmem_putlong_unaligned(xdrs, lp)
>   }
>   
>   static bool_t
> -xdrmem_getbytes(xdrs, addr, len)
> -	XDR *xdrs;
> -	char *addr;
> -	u_int len;
> +xdrmem_getbytes(
> +	XDR *xdrs,
> +	char *addr,
> +	u_int len)
>   {
>   
>   	if (xdrs->x_handy < len)
> @@ -186,10 +185,10 @@ xdrmem_getbytes(xdrs, addr, len)
>   }
>   
>   static bool_t
> -xdrmem_putbytes(xdrs, addr, len)
> -	XDR *xdrs;
> -	const char *addr;
> -	u_int len;
> +xdrmem_putbytes(
> +	XDR *xdrs,
> +	const char *addr,
> +	u_int len)
>   {
>   
>   	if (xdrs->x_handy < len)
> @@ -201,8 +200,7 @@ xdrmem_putbytes(xdrs, addr, len)
>   }
>   
>   static u_int
> -xdrmem_getpos(xdrs)
> -	XDR *xdrs;
> +xdrmem_getpos(XDR *xdrs)
>   {
>   
>   	/* XXX w/64-bit pointers, u_int not enough! */
> @@ -210,9 +208,9 @@ xdrmem_getpos(xdrs)
>   }
>   
>   static bool_t
> -xdrmem_setpos(xdrs, pos)
> -	XDR *xdrs;
> -	u_int pos;
> +xdrmem_setpos(
> +	XDR *xdrs,
> +	u_int pos)
>   {
>   	char *newaddr = xdrs->x_base + pos;
>   	char *lastaddr = (char *)xdrs->x_private + xdrs->x_handy;
> @@ -225,9 +223,9 @@ xdrmem_setpos(xdrs, pos)
>   }
>   
>   static int32_t *
> -xdrmem_inline_aligned(xdrs, len)
> -	XDR *xdrs;
> -	u_int len;
> +xdrmem_inline_aligned(
> +	XDR *xdrs,
> +	u_int len)
>   {
>   	int32_t *buf = 0;
>   
> @@ -241,9 +239,9 @@ xdrmem_inline_aligned(xdrs, len)
>   
>   /* ARGSUSED */
>   static int32_t *
> -xdrmem_inline_unaligned(xdrs, len)
> -	XDR *xdrs;
> -	u_int len;
> +xdrmem_inline_unaligned(
> +	XDR *xdrs,
> +	u_int len)
>   {
>   
>   	return (0);
> diff --git a/src/xdr_rec.c b/src/xdr_rec.c
> index 676cc82..f088062 100644
> --- a/src/xdr_rec.c
> +++ b/src/xdr_rec.c
> @@ -152,15 +152,15 @@ static bool_t	realloc_stream(RECSTREAM *, int);
>    * calls expect that they take an opaque handle rather than an fd.
>    */
>   void
> -xdrrec_create(xdrs, sendsize, recvsize, tcp_handle, readit, writeit)
> -	XDR *xdrs;
> -	u_int sendsize;
> -	u_int recvsize;
> -	void *tcp_handle;
> +xdrrec_create(
> +	XDR *xdrs,
> +	u_int sendsize,
> +	u_int recvsize,
> +	void *tcp_handle,
>   	/* like read, but pass it a tcp_handle, not sock */
> -	int (*readit)(void *, void *, int);
> +	int (*readit)(void *, void *, int),
>   	/* like write, but pass it a tcp_handle, not sock */
> -	int (*writeit)(void *, void *, int);
> +	int (*writeit)(void *, void *, int))
>   {
>   	RECSTREAM *rstrm = mem_alloc(sizeof(RECSTREAM));
>   
> @@ -220,9 +220,9 @@ xdrrec_create(xdrs, sendsize, recvsize, tcp_handle, readit, writeit)
>    */
>   
>   static bool_t
> -xdrrec_getlong(xdrs, lp)
> -	XDR *xdrs;
> -	long *lp;
> +xdrrec_getlong(
> +	XDR *xdrs,
> +	long *lp)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)(xdrs->x_private);
>   	int32_t *buflp = (int32_t *)(void *)(rstrm->in_finger);
> @@ -244,9 +244,9 @@ xdrrec_getlong(xdrs, lp)
>   }
>   
>   static bool_t
> -xdrrec_putlong(xdrs, lp)
> -	XDR *xdrs;
> -	const long *lp;
> +xdrrec_putlong(
> +	XDR *xdrs,
> +	const long *lp)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)(xdrs->x_private);
>   	int32_t *dest_lp = ((int32_t *)(void *)(rstrm->out_finger));
> @@ -268,10 +268,10 @@ xdrrec_putlong(xdrs, lp)
>   }
>   
>   static bool_t  /* must manage buffers, fragments, and records */
> -xdrrec_getbytes(xdrs, addr, len)
> -	XDR *xdrs;
> -	char *addr;
> -	u_int len;
> +xdrrec_getbytes(
> +	XDR *xdrs,
> +	char *addr,
> +	u_int len)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)(xdrs->x_private);
>   	int current;
> @@ -296,10 +296,10 @@ xdrrec_getbytes(xdrs, addr, len)
>   }
>   
>   static bool_t
> -xdrrec_putbytes(xdrs, addr, len)
> -	XDR *xdrs;
> -	const char *addr;
> -	u_int len;
> +xdrrec_putbytes(
> +	XDR *xdrs,
> +	const char *addr,
> +	u_int len)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)(xdrs->x_private);
>   	size_t current;
> @@ -322,8 +322,7 @@ xdrrec_putbytes(xdrs, addr, len)
>   }
>   
>   static u_int
> -xdrrec_getpos(xdrs)
> -	XDR *xdrs;
> +xdrrec_getpos(XDR *xdrs)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)xdrs->x_private;
>   	off_t pos;
> @@ -348,9 +347,9 @@ xdrrec_getpos(xdrs)
>   }
>   
>   static bool_t
> -xdrrec_setpos(xdrs, pos)
> -	XDR *xdrs;
> -	u_int pos;
> +xdrrec_setpos(
> +	XDR *xdrs,
> +	u_int pos)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)xdrs->x_private;
>   	u_int currpos = xdrrec_getpos(xdrs);
> @@ -387,9 +386,9 @@ xdrrec_setpos(xdrs, pos)
>   }
>   
>   static int32_t *
> -xdrrec_inline(xdrs, len)
> -	XDR *xdrs;
> -	u_int len;
> +xdrrec_inline(
> +	XDR *xdrs,
> +	u_int len)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)xdrs->x_private;
>   	int32_t *buf = NULL;
> @@ -419,8 +418,7 @@ xdrrec_inline(xdrs, len)
>   }
>   
>   static void
> -xdrrec_destroy(xdrs)
> -	XDR *xdrs;
> +xdrrec_destroy(XDR *xdrs)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)xdrs->x_private;
>   
> @@ -439,8 +437,7 @@ xdrrec_destroy(xdrs)
>    * this procedure to guarantee proper record alignment.
>    */
>   bool_t
> -xdrrec_skiprecord(xdrs)
> -	XDR *xdrs;
> +xdrrec_skiprecord(XDR *xdrs)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)(xdrs->x_private);
>   	enum xprt_stat xstat;
> @@ -475,8 +472,7 @@ xdrrec_skiprecord(xdrs)
>    * after consuming the rest of the current record.
>    */
>   bool_t
> -xdrrec_eof(xdrs)
> -	XDR *xdrs;
> +xdrrec_eof(XDR *xdrs)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)(xdrs->x_private);
>   
> @@ -499,9 +495,9 @@ xdrrec_eof(xdrs)
>    * pipelined procedure calls.)  TRUE => immmediate flush to tcp connection.
>    */
>   bool_t
> -xdrrec_endofrecord(xdrs, sendnow)
> -	XDR *xdrs;
> -	bool_t sendnow;
> +xdrrec_endofrecord(
> +	XDR *xdrs,
> +	bool_t sendnow)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)(xdrs->x_private);
>   	u_long len;  /* fragment length */
> @@ -525,10 +521,10 @@ xdrrec_endofrecord(xdrs, sendnow)
>    * Return true if a record is available in the buffer, false if not.
>    */
>   bool_t
> -__xdrrec_getrec(xdrs, statp, expectdata)
> -	XDR *xdrs;
> -	enum xprt_stat *statp;
> -	bool_t expectdata;
> +__xdrrec_getrec(
> +	XDR *xdrs,
> +	enum xprt_stat *statp,
> +	bool_t expectdata)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)(xdrs->x_private);
>   	ssize_t n;
> @@ -615,9 +611,9 @@ __xdrrec_getrec(xdrs, statp, expectdata)
>   }
>   
>   bool_t
> -__xdrrec_setnonblock(xdrs, maxrec)
> -	XDR *xdrs;
> -	int maxrec;
> +__xdrrec_setnonblock(
> +	XDR *xdrs,
> +	int maxrec)
>   {
>   	RECSTREAM *rstrm = (RECSTREAM *)(xdrs->x_private);
>   
> @@ -632,9 +628,9 @@ __xdrrec_setnonblock(xdrs, maxrec)
>    * Internal useful routines
>    */
>   static bool_t
> -flush_out(rstrm, eor)
> -	RECSTREAM *rstrm;
> -	bool_t eor;
> +flush_out(
> +	RECSTREAM *rstrm,
> +	bool_t eor)
>   {
>   	u_int32_t eormask = (eor == TRUE) ? LAST_FRAG : 0;
>   	u_int32_t len = (u_int32_t)((u_long)(rstrm->out_finger) -
> @@ -652,8 +648,7 @@ flush_out(rstrm, eor)
>   }
>   
>   static bool_t  /* knows nothing about records!  Only about input buffers */
> -fill_input_buf(rstrm)
> -	RECSTREAM *rstrm;
> +fill_input_buf(RECSTREAM *rstrm)
>   {
>   	char *where;
>   	u_int32_t i;
> @@ -675,10 +670,10 @@ fill_input_buf(rstrm)
>   }
>   
>   static bool_t  /* knows nothing about records!  Only about input buffers */
> -get_input_bytes(rstrm, addr, len)
> -	RECSTREAM *rstrm;
> -	char *addr;
> -	int len;
> +get_input_bytes(
> +	RECSTREAM *rstrm,
> +	char *addr,
> +	int len)
>   {
>   	size_t current;
>   
> @@ -708,8 +703,7 @@ get_input_bytes(rstrm, addr, len)
>   }
>   
>   static bool_t  /* next two bytes of the input stream are treated as a header */
> -set_input_fragment(rstrm)
> -	RECSTREAM *rstrm;
> +set_input_fragment(RECSTREAM *rstrm)
>   {
>   	u_int32_t header;
>   
> @@ -734,9 +728,9 @@ set_input_fragment(rstrm)
>   }
>   
>   static bool_t  /* consumes input bytes; knows nothing about records! */
> -skip_input_bytes(rstrm, cnt)
> -	RECSTREAM *rstrm;
> -	long cnt;
> +skip_input_bytes(
> +	RECSTREAM *rstrm,
> +	long cnt)
>   {
>   	u_int32_t current;
>   
> @@ -756,8 +750,7 @@ skip_input_bytes(rstrm, cnt)
>   }
>   
>   static u_int
> -fix_buf_size(s)
> -	u_int s;
> +fix_buf_size(u_int s)
>   {
>   
>   	if (s < 100)
> @@ -769,9 +762,9 @@ fix_buf_size(s)
>    * Reallocate the input buffer for a non-block stream.
>    */
>   static bool_t
> -realloc_stream(rstrm, size)
> -	RECSTREAM *rstrm;
> -	int size;
> +realloc_stream(
> +	RECSTREAM *rstrm,
> +	int size)
>   {
>   	ptrdiff_t diff;
>   	char *buf;
> diff --git a/src/xdr_reference.c b/src/xdr_reference.c
> index 13f6410..9c7b24e 100644
> --- a/src/xdr_reference.c
> +++ b/src/xdr_reference.c
> @@ -58,11 +58,11 @@
>    * proc is the routine to handle the referenced structure.
>    */
>   bool_t
> -xdr_reference(xdrs, pp, size, proc)
> -	XDR *xdrs;
> -	caddr_t *pp;		/* the pointer to work on */
> -	u_int size;		/* size of the object pointed to */
> -	xdrproc_t proc;		/* xdr routine to handle the object */
> +xdr_reference(
> +	XDR *xdrs,
> +	caddr_t *pp,		/* the pointer to work on */
> +	u_int size,		/* size of the object pointed to */
> +	xdrproc_t proc)		/* xdr routine to handle the object */
>   {
>   	caddr_t loc = *pp;
>   	bool_t stat;
> @@ -115,11 +115,11 @@ xdr_reference(xdrs, pp, size, proc)
>    *
>    */
>   bool_t
> -xdr_pointer(xdrs,objpp,obj_size,xdr_obj)
> -	XDR *xdrs;
> -	char **objpp;
> -	u_int obj_size;
> -	xdrproc_t xdr_obj;
> +xdr_pointer(
> +	XDR *xdrs,
> +	char **objpp,
> +	u_int obj_size,
> +	xdrproc_t xdr_obj)
>   {
>   
>   	bool_t more_data;
> diff --git a/src/xdr_sizeof.c b/src/xdr_sizeof.c
> index 79d6707..af3c313 100644
> --- a/src/xdr_sizeof.c
> +++ b/src/xdr_sizeof.c
> @@ -44,9 +44,7 @@
>   
>   /* ARGSUSED */
>   static bool_t
> -x_putlong(xdrs, longp)
> -	XDR *xdrs;
> -	long *longp;
> +x_putlong(XDR *xdrs, const long *longp)
>   {
>   	xdrs->x_handy += BYTES_PER_XDR_UNIT;
>   	return (TRUE);
> @@ -54,36 +52,31 @@ x_putlong(xdrs, longp)
>   
>   /* ARGSUSED */
>   static bool_t
> -x_putbytes(xdrs, bp, len)
> -	XDR *xdrs;
> -	char  *bp;
> -	u_int len;
> +x_putbytes(
> +	XDR *xdrs,
> +	const char  *bp,
> +	u_int len)
>   {
>   	xdrs->x_handy += len;
>   	return (TRUE);
>   }
>   
>   static u_int
> -x_getpostn(xdrs)
> -	XDR *xdrs;
> +x_getpostn(XDR *xdrs)
>   {
>   	return (xdrs->x_handy);
>   }
>   
>   /* ARGSUSED */
>   static bool_t
> -x_setpostn(xdrs, pos)
> -	XDR *xdrs;
> -	u_int pos;
> +x_setpostn(XDR *xdrs, u_int pos)
>   {
>   	/* This is not allowed */
>   	return (FALSE);
>   }
>   
>   static int32_t *
> -x_inline(xdrs, len)
> -	XDR *xdrs;
> -	u_int len;
> +x_inline(XDR *xdrs, u_int len)
>   {
>   	if (len == 0) {
>   		return (NULL);
> @@ -117,8 +110,7 @@ harmless()
>   }
>   
>   static void
> -x_destroy(xdrs)
> -	XDR *xdrs;
> +x_destroy(XDR *xdrs)
>   {
>   	xdrs->x_handy = 0;
>   	xdrs->x_base = 0;
> @@ -130,9 +122,7 @@ x_destroy(xdrs)
>   }
>   
>   unsigned long
> -xdr_sizeof(func, data)
> -	xdrproc_t func;
> -	void *data;
> +xdr_sizeof(xdrproc_t func, void *data)
>   {
>   	XDR x;
>   	struct xdr_ops ops;
> diff --git a/src/xdr_stdio.c b/src/xdr_stdio.c
> index 846c7bf..699de39 100644
> --- a/src/xdr_stdio.c
> +++ b/src/xdr_stdio.c
> @@ -74,10 +74,10 @@ static const struct xdr_ops	xdrstdio_ops = {
>    * Operation flag is set to op.
>    */
>   void
> -xdrstdio_create(xdrs, file, op)
> -	XDR *xdrs;
> -	FILE *file;
> -	enum xdr_op op;
> +xdrstdio_create(
> +	XDR *xdrs,
> +	FILE *file,
> +	enum xdr_op op)
>   {
>   
>   	xdrs->x_op = op;
> @@ -92,17 +92,16 @@ xdrstdio_create(xdrs, file, op)
>    * Cleans up the xdr stream handle xdrs previously set up by xdrstdio_create.
>    */
>   static void
> -xdrstdio_destroy(xdrs)
> -	XDR *xdrs;
> +xdrstdio_destroy(XDR *xdrs)
>   {
>   	(void)fflush((FILE *)xdrs->x_private);
>   		/* XXX: should we close the file ?? */
>   }
>   
>   static bool_t
> -xdrstdio_getlong(xdrs, lp)
> -	XDR *xdrs;
> -	long *lp;
> +xdrstdio_getlong(
> +	XDR *xdrs,
> +	long *lp)
>   {
>   	int32_t mycopy;
>   
> @@ -114,9 +113,9 @@ xdrstdio_getlong(xdrs, lp)
>   }
>   
>   static bool_t
> -xdrstdio_putlong(xdrs, lp)
> -	XDR *xdrs;
> -	const long *lp;
> +xdrstdio_putlong(
> +	XDR *xdrs,
> +	const long *lp)
>   {
>   	int32_t mycopy;
>   
> @@ -132,10 +131,10 @@ xdrstdio_putlong(xdrs, lp)
>   }
>   
>   static bool_t
> -xdrstdio_getbytes(xdrs, addr, len)
> -	XDR *xdrs;
> -	char *addr;
> -	u_int len;
> +xdrstdio_getbytes(
> +	XDR *xdrs,
> +	char *addr,
> +	u_int len)
>   {
>   
>   	if ((len != 0) && (fread(addr, (size_t)len, 1, (FILE *)xdrs->x_private) != 1))
> @@ -144,10 +143,10 @@ xdrstdio_getbytes(xdrs, addr, len)
>   }
>   
>   static bool_t
> -xdrstdio_putbytes(xdrs, addr, len)
> -	XDR *xdrs;
> -	const char *addr;
> -	u_int len;
> +xdrstdio_putbytes(
> +	XDR *xdrs,
> +	const char *addr,
> +	u_int len)
>   {
>   
>   	if ((len != 0) && (fwrite(addr, (size_t)len, 1,
> @@ -157,17 +156,16 @@ xdrstdio_putbytes(xdrs, addr, len)
>   }
>   
>   static u_int
> -xdrstdio_getpos(xdrs)
> -	XDR *xdrs;
> +xdrstdio_getpos(XDR *xdrs)
>   {
>   
>   	return ((u_int) ftell((FILE *)xdrs->x_private));
>   }
>   
>   static bool_t
> -xdrstdio_setpos(xdrs, pos)
> -	XDR *xdrs;
> -	u_int pos;
> +xdrstdio_setpos(
> +	XDR *xdrs,
> +	u_int pos)
>   {
>   
>   	return ((fseek((FILE *)xdrs->x_private, (long)pos, 0) < 0) ?
> @@ -176,9 +174,9 @@ xdrstdio_setpos(xdrs, pos)
>   
>   /* ARGSUSED */
>   static int32_t *
> -xdrstdio_inline(xdrs, len)
> -	XDR *xdrs;
> -	u_int len;
> +xdrstdio_inline(
> +	XDR *xdrs,
> +	u_int len)
>   {
>   
>   	/*


