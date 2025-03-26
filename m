Return-Path: <linux-nfs+bounces-10901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E4A71518
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 11:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A29F7A5422
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1281AF0BF;
	Wed, 26 Mar 2025 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEAJMiVz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3F1AE876
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986020; cv=none; b=PJmYDfH5I9TsJ0j7ARcI1ZWUDPvSSuQKBVD2c0vc/QsVVgzxB3LugZxV8dfO1x4taNW2OrvsDgACMqcnwZqELtcL6vhATqyJcgCC0Lw7iFzF1VdudFwpRL9/IR3NYa0spuCtEY3HFt6PBMf2Wpx/R5BUkMa1no6qnFUyJRuN2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986020; c=relaxed/simple;
	bh=pFaKnwY+L5c+wCPH5H/QHGyOBatusOGpyyIjNyPRm3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLQYLOjoKDT5IR5WvY64fn7Vk66fWHh8smg1UWKwRbcMSNLWVrAVY2rQqqtVsj2yst68IO06F6o7IWWnNXLel6MNx89vaZjODLUYFkzvUz7aOwVBYbdKE83by2bY/a4EZJGqVuqkrJrJRXcPexFDIR7jj/WiPu/tvh83Pyp+xsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEAJMiVz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742986017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dlps3Mnuo9mZJWj3wQ2gmyY57kY+jYxAmRYdW6KdBM0=;
	b=KEAJMiVz2/LrtzEedmtrFfk0Q/arZIWTt4y9NtAZpapfvBAFsQMUIol5hCzLnpyetlgVy/
	Xs/wHbiCWm0UwbgEjbUOY13/8CYJAF3b8VU+0DLYtAAgwdOTv4Seo8kDwKWR4ssNTyq834
	EEZXo7yNOSLQubEU8YPbkbg72x71TP8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-JsBTJgqyPG-qXT6ihQeBTQ-1; Wed,
 26 Mar 2025 06:46:52 -0400
X-MC-Unique: JsBTJgqyPG-qXT6ihQeBTQ-1
X-Mimecast-MFC-AGG-ID: JsBTJgqyPG-qXT6ihQeBTQ_1742986011
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA396180025E;
	Wed, 26 Mar 2025 10:46:51 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CB38195609D;
	Wed, 26 Mar 2025 10:46:50 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 5/6] NFSv4: clp->cl_cons_state < 0 signifies an invalid
 nfs_client
Date: Wed, 26 Mar 2025 06:46:48 -0400
Message-ID: <72562E7A-2DF8-4115-8F3A-53BAEA07A212@redhat.com>
In-Reply-To: <7059cac07b2bc3c6a249b66326a86a5858f74214.1742941932.git.trond.myklebust@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
 <7059cac07b2bc3c6a249b66326a86a5858f74214.1742941932.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 25 Mar 2025, at 18:35, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If someone calls nfs_mark_client_ready(clp, status) with a negative
> value for status, then that should signal that the nfs_client is no
> longer valid.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index f1f7eaa97973..272d2ebdae0f 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1403,7 +1403,7 @@ int nfs4_schedule_stateid_recovery(const struct n=
fs_server *server, struct nfs4_
>  	dprintk("%s: scheduling stateid recovery for server %s\n", __func__,
>  			clp->cl_hostname);
>  	nfs4_schedule_state_manager(clp);
> -	return 0;
> +	return clp->cl_cons_state < 0 ? clp->cl_cons_state : 0;
>  }
>  EXPORT_SYMBOL_GPL(nfs4_schedule_stateid_recovery);
>
> -- =

> 2.49.0

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


