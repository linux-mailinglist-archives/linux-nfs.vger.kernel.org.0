Return-Path: <linux-nfs+bounces-5528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2F95A277
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A354FB29D1F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A31A178395;
	Wed, 21 Aug 2024 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3Dv9+kb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D82158A23
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256296; cv=none; b=noT8DEj7nkf1oXc/Qfube0RhL6zMzP459dRVodXH0xW68Hmsksq5E10CYsyPJYercxbQY7+5x1akmdv+gGV0ZaR5c1UrN6ZkvpJMnTlT40iw++r3cifyR9ThXFiP1UQgyMV1XKCboYkSdOtsvFc4kUfKzy9SrmPUMlq55myui8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256296; c=relaxed/simple;
	bh=DZeCTfaZ17INExVmNQ/bq0au4+KSLai92ATB3zWiLn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tk4te2xsY+3hR5ymN7JVUFd7th2e4ULbI6i3XoWKlx4OTg9vktbCfGYEt6Q/WBvkO8EVSgXqj6iriqxvh9JwJQAL05nA6HpOIiICaNcRO+KB9hAV/nnBN+b5aFCKVheU3yc2wO9msPMI7ddUArbbHXlj5j7B9JmZsHa6UHHMiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3Dv9+kb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724256293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DZeCTfaZ17INExVmNQ/bq0au4+KSLai92ATB3zWiLn8=;
	b=i3Dv9+kbPxUWGrrarwPCIas+xibBYbgY5a+Oz8id5T/tY7vP4pW317HjuHBLJSQMcHeZhF
	vcHYiUZGO0lu29vuXxh2mAqd5QqUCljoQw++NzUVbo4wT1of8TCmpm2lX02GETYDSkU/1a
	8+quztSInP5oWgAkHsNbAQRdf5DdudY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-vpcd1BAnNNKaLmcSYW7XDQ-1; Wed,
 21 Aug 2024 12:04:47 -0400
X-MC-Unique: vpcd1BAnNNKaLmcSYW7XDQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AD1B1954B23;
	Wed, 21 Aug 2024 16:04:46 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4B6E300019C;
	Wed, 21 Aug 2024 16:04:44 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS
Date: Wed, 21 Aug 2024 12:04:42 -0400
Message-ID: <74650085-DEEE-4483-8754-EE409649E574@redhat.com>
In-Reply-To: <20240815141841.29620-1-jlayton@kernel.org>
References: <20240815141841.29620-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 15 Aug 2024, at 10:18, Jeff Layton wrote:

> The client doesn't properly request FATTR4_OPEN_ARGUMENTS in the initial
> SERVER_CAPS getattr. Add FATTR4_WORD2_OPEN_ARGUMENTS to the initial
> request.
>
> Fixes: 707f13b3d081 (NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS attribute)
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Clearly correct, save for slight style mismatch.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


