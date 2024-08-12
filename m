Return-Path: <linux-nfs+bounces-5325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5794F746
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 21:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CCD1C20AA1
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 19:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095E1917F8;
	Mon, 12 Aug 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUgScQHS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC218FC75
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489773; cv=none; b=mHBVUK8uk7z23TFz8AXCby7XJlGhh8VRZsLgEZIOJmdwvCnwvf0v9k9M5P6orLkIBon7L1PrvM5nUnlJwa7YE6Tpw8mvbxUIGpsJRNc7MvGIx6+Jtq0vgRNo6Z/hFuSxMr7BGLzJJGHNQUTE1fj+PnVcIPxMEO2HhffSOBKnJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489773; c=relaxed/simple;
	bh=hl3zhelEZdSlFNb3HG51ao21RebGZxdvqI3dcz3HA+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDfko7vrodXEoZa4k5nb7jt5IJWt1tzq8iBpUXYIS7IUOD6hUp2P5vpVh4XeqIYXyBPUQ9wR489GQZcITxsSFuk2tRxWHCP/0Zz1MyteB/1cOwgaKgu4Vf3z6YOMyNUFUze94WzEhUvysEDxK9yfqw6Lcqrr/KHHbCmrrnVCuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUgScQHS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723489769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8rWSMdZMas+2CGR4Nj0Z/BwCy53ptGF3/CJIWkdpz7c=;
	b=KUgScQHSabhgeoZFdmqp8gJ/8yUjrxjEZ5H2KBRPIEFmjFkD2wd36MYzVuSUsSTn6daaHN
	zkb6kSPr9xX0LWk7DVnUiqTd50at+XCl9uH/g2FYCE4LsOfWIpBaKpXbUx3Dag/VNF4Ogp
	FBuuw1Zj2rWua4ucDMMGUAIGuJDy/yY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-KQI689RTOCyZN-kQkQ07Ew-1; Mon,
 12 Aug 2024 15:09:23 -0400
X-MC-Unique: KQI689RTOCyZN-kQkQ07Ew-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D2F11944F0A;
	Mon, 12 Aug 2024 19:09:22 +0000 (UTC)
Received: from [10.22.33.123] (unknown [10.22.33.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA7161955F6E;
	Mon, 12 Aug 2024 19:09:19 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: Remove unnecessary NULL check before kfree()
Date: Mon, 12 Aug 2024 15:09:16 -0400
Message-ID: <B6F7413C-FCF5-441D-81E5-B08766CBC2FC@redhat.com>
In-Reply-To: <20240811121809.127561-2-thorsten.blum@toblux.com>
References: <20240811121809.127561-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11 Aug 2024, at 8:18, Thorsten Blum wrote:

> Since kfree() already checks if its argument is NULL, an additional
> check before calling kfree() is unnecessary and can be removed.
>
> Remove it and thus also the following Coccinelle/coccicheck warning
> reported by ifnullfree.cocci:
>
>   WARNING: NULL check before some freeing functions is not needed
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Correct, of course.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


