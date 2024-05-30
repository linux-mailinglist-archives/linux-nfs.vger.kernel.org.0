Return-Path: <linux-nfs+bounces-3490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00E8D4D36
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 15:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3671C22900
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA4F176243;
	Thu, 30 May 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjXwOiNu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946817624F
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077073; cv=none; b=S1XGa9683ly5WM2cgKB4/ipFRhB8IYDHbmEXxgE8dCJfSpmmsVw7DEubiOjPmL/+Cu889NVj/jrwmrN87ZnncNnidf24w+0PoIFQNVzPY3xRCGUd2CcCP2dIm5tGBk/cHm7mwmwCVzZBIqzc3BRo98lQBqkTZ/fTEHFio9+bC30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077073; c=relaxed/simple;
	bh=3YQiVhchcbAi9t9KcGVYCLDWv6oo9440sDv5iJ6nP3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlwCj/Qz9PI1dk96V8tF4hJpK0pY1bkxC1GBExF10fxkeLt1bzCc3INQ+uEcXSnvZwq4uaXlbpEmPdvQckzJgLb4jazD/0pKCnUMbUnfJQFyfRUDnzgHZOA9vm2NgUQUOpdbUvQD07dUbsmnBiV618m2Szo7fSIiSxuIghFU5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjXwOiNu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717077070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rfH6J+unj4wiAyGr8YPH3c+mpYBhFPxh4d8Ykt6wN8=;
	b=DjXwOiNuduQK9fYZcdOAJ/EVnuyticwF02/e7tEPER3AiEKbNTc7UeBU2f1QP+ailGW1j9
	xwbgI9b5UIX2oX1gz/cLW/95JPrsP2V+npSO3ZMKqflC+j7hBCe456v2tnOn0Aqjb1kgul
	VQ0Cg/MQ1PZpNtMq0edXOht0T+USdvk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-vSnflq2qMyuLs9UoYyH_kw-1; Thu,
 30 May 2024 09:51:06 -0400
X-MC-Unique: vSnflq2qMyuLs9UoYyH_kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 876AB3806701;
	Thu, 30 May 2024 13:51:05 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-11.rdu2.redhat.com [10.22.0.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C654F200A35C;
	Thu, 30 May 2024 13:51:03 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: return proper error from gss_wrap_req_priv
Date: Thu, 30 May 2024 09:51:02 -0400
Message-ID: <E6007B79-DBB0-413A-9C46-6860AA25782D@redhat.com>
In-Reply-To: <20240523084716.524-1-chenhx.fnst@fujitsu.com>
References: <20240523084716.524-1-chenhx.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 23 May 2024, at 4:47, Chen Hanxiao wrote:

> don't return 0 if snd_buf->len really greater than snd_buf->buflen
>
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>

Fixes: 0c77668ddb4e ("SUNRPC: Introduce trace points in rpc_auth_gss.ko")
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

more below ..


> ---
>  net/sunrpc/auth_gss/auth_gss.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> index c7af0220f82f..369310909fc9 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -1875,8 +1875,10 @@ gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
>  	offset = (u8 *)p - (u8 *)snd_buf->head[0].iov_base;
>  	maj_stat = gss_wrap(ctx->gc_gss_ctx, offset, snd_buf, inpages);
>  	/* slack space should prevent this ever happening: */
> -	if (unlikely(snd_buf->len > snd_buf->buflen))
> +	if (unlikely(snd_buf->len > snd_buf->buflen)) {
> +		status = -EIO;
>  		goto wrap_failed;

Maybe Chuck intended to jump to bad_wrap in 0c77668ddb4e?  Interesting that
you found this considering "slack space should prevent this ever happening".

Ben


