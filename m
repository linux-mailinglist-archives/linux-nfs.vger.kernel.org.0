Return-Path: <linux-nfs+bounces-8675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EEA9F8644
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 21:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78963188FA3D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 20:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F160017799F;
	Thu, 19 Dec 2024 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0FOPvH1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7F1805E
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641370; cv=none; b=c3Od+pGTAqA6Ite0xmYsaqvKxjATtc+OAhfaysZDa4Yemk0pXHhQx/262e3ARltHwH1w7b+7GK3VBJEfo6+Z28tvqh5N/eAPOSK+vUOjDLBc9Sf0b/t8ZAYnnT/SGL32L+rf5wUf1ygN9s5yESBNaTKutFv7C06a+hyBi3ayhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641370; c=relaxed/simple;
	bh=I16U9Ka0UkrrE8JhNecpPXCLu6buhqkdvnAbJRwU138=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xd2M3Y1zbHvuhUQBMa1XzFVKfpdPDBFxG1SGWg7ZpEraIrygC69ZYEkLsJwMoirlpBDb5kWYMquc9AmwZm94GViPLRKvylSpDEj3Ujcoq1tKG4HN53ZI1fyCroZ5H/BzxM7gO6WJQlaRqkkWn0nuRIcsGXPThacwEb6vG9kwsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0FOPvH1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734641366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hpWWxI44lNevslAdQPBuHjpe1UDbgCB9jFqV5/QHYs=;
	b=F0FOPvH1pn/QHr/gfvcsFl3OcJfrfj0aBaJChpraAHfvXRilDDFPUIzcD8PXY6tlbD/rd3
	DpRkpZmKfYDOBqJZ0Vl06XcY/J6Jm3ly+2BS5XTOSrWd1UJ1SJkpd3R0G95gGsWt2nK8xM
	ZmB74uHoRqjapKbxI3+DOdNRvB5AC4w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-ye8l5-vwOZqlceb1f3agaA-1; Thu,
 19 Dec 2024 15:49:24 -0500
X-MC-Unique: ye8l5-vwOZqlceb1f3agaA-1
X-Mimecast-MFC-AGG-ID: ye8l5-vwOZqlceb1f3agaA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFCCD19560A5;
	Thu, 19 Dec 2024 20:49:23 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.13])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7573195605F;
	Thu, 19 Dec 2024 20:49:22 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: fix decoding in nfs4_xdr_dec_cb_getattr
Date: Thu, 19 Dec 2024 15:49:20 -0500
Message-ID: <473D340A-8ADE-4638-A7B4-4440B8C77EDF@redhat.com>
In-Reply-To: <20241219201204.10367-1-okorniev@redhat.com>
References: <20241219201204.10367-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 19 Dec 2024, at 15:12, Olga Kornievskaia wrote:

> If a client were to send an error to a CB_GETATTR call, the code
> erronously continues to try decode past the error code. It ends
> up returning BAD_XDR error to the rpc layer and then in turn
> trigger a WARN_ONCE in nfsd4_cb_done() function.
>
> Fixes: 6487a13b5c6b ("NFSD: add support for CB_GETATTR callback")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4callback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 3877b53e429f..f24d8654393d 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -647,7 +647,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
>  		return status;
>
>  	status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
> -	if (status)
> +	if (status || cb->cb_status)
>  		return status;
>  	if (xdr_stream_decode_uint32_array(xdr, bitmap, 3) < 0)
>  		return -NFSERR_BAD_XDR;
> -- 
> 2.43.5

Yep!

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


