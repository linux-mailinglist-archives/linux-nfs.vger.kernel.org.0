Return-Path: <linux-nfs+bounces-1459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D53583DB27
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 14:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4E11F24D89
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF4C1B81D;
	Fri, 26 Jan 2024 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2VHabwz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E81B940
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706276899; cv=none; b=lq01gwkvGrjY0Bk0H2LPfcuRYt0TxQIvD+z202qeiUV2ziSiMvHowQU/KAfdphwksXR2vYYDMq8a6CvkRUUchdDH7FCpmjlTzmYC2/PM7T0X5CfOXgmBQsEnRnrAZBkHuADzi+YPiXfrBIxkYn4/Ntc1lngqQYuPgRBABt7Nv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706276899; c=relaxed/simple;
	bh=4H+svnX6SCBUiMljn1namd99+r6dQeWPM0wWmcCFzFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L53tM+YIMmRJIjZ7AuEDjB+BB0Qn85sva1BWN+DMXvTGGUTKQrTOlc6ar2ympoArNoLsqwF0bbJq3sg42WLyG6UitVaPf9mwxGBo0/SmRNHK+pKV7XVuK+ZCaXmoXLWzfz0UIVP56tfZJwYPnDBpCdlOVBEPki/mjZuCnDrRAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2VHabwz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706276896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/YqsJhNk4UB5zgevm7MliQES8TZ6hp9lZZ899EYuV7U=;
	b=b2VHabwz2tGQ56NgoB9NdwgjkWyhCuJkj0my1eV3nhex4yXieUEE444msiRmaouVceHU3R
	c06VuRmWni9UhPdAcmcLEXDBnK2l5xGZszDUNNz+3F53eoHNy7CqlRVA677JMZlc86wPFj
	65BYnVXP/J5vERULgh5RrHXdAFPybMU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-RvLksoXtPHGSiSTfhCJQ6w-1; Fri, 26 Jan 2024 08:48:13 -0500
X-MC-Unique: RvLksoXtPHGSiSTfhCJQ6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2479D101A526;
	Fri, 26 Jan 2024 13:48:13 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F438AD1;
	Fri, 26 Jan 2024 13:48:12 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jorge Mora <jmora1300@gmail.com>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
 anna@kernel.org
Subject: Re: [PATCH] NFSv4.2: fix listxattr maximum XDR buffer size
Date: Fri, 26 Jan 2024 08:48:11 -0500
Message-ID: <FE38CC90-A3BE-40CF-9365-557CA706376E@redhat.com>
In-Reply-To: <20240125145128.12945-1-mora@netapp.com>
References: <20240125145128.12945-1-mora@netapp.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 25 Jan 2024, at 9:51, Jorge Mora wrote:

> Switch order of operations to avoid creating a short XDR buffer:
> e.g., buflen = 12, old xdrlen = 12, new xdrlen = 20.
>
> Having a short XDR buffer leads to lxa_maxcount be a few bytes
> less than what is needed to retrieve the whole list when using
> a buflen as returned by a call with size = 0:
>     buflen = listxattr(path, NULL, 0);
>     buf = malloc(buflen);
>     buflen = listxattr(path, buf, buflen);
>
> For a file with one attribute (name = '123456'), the first call
> with size = 0 will return buflen = 12 ('user.123456\x00').
> The second call with size = 12, sends LISTXATTRS with
> lxa_maxcount = 12 + 8 (cookie) + 4 (array count) = 24. The
> XDR buffer needs 8 (cookie) + 4 (array count) + 4 (name count)
> + 6 (name len) + 2 (padding) + 4 (eof) = 28 which is 4 bytes
> shorter than the lxa_maxcount provided in the call.
>
> Fixes: 04a5da690e8f ("NFSv4.2: define limits and sizes for user xattr handling")
> Signed-off-by: Jorge Mora <mora@netapp.com>
> ---
>  fs/nfs/nfs42.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
> index b59876b01a1e..32ee9ad6a560 100644
> --- a/fs/nfs/nfs42.h
> +++ b/fs/nfs/nfs42.h
> @@ -55,11 +55,14 @@ int nfs42_proc_removexattr(struct inode *inode, const char *name);
>   * They would be 7 bytes long in the eventual buffer ("user.x\0"), and
>   * 8 bytes long XDR-encoded.
>   *
> - * Include the trailing eof word as well.
> + * Include the trailing eof word as well and make the result a multiple
> + * of 4 bytes.
>   */
>  static inline u32 nfs42_listxattr_xdrsize(u32 buflen)
>  {
> -	return ((buflen / (XATTR_USER_PREFIX_LEN + 2)) * 8) + 4;
> +	u32 size = 8 * buflen / (XATTR_USER_PREFIX_LEN + 2) + 4;
> +
> +	return (size + 3) & ~3;

Maybe XDR_QUADLEN(size) here?  Otherwise, looks correct.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


