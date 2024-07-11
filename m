Return-Path: <linux-nfs+bounces-4814-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D487A92EAF7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E82283B9D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 14:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D0E169AE3;
	Thu, 11 Jul 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOi0kKqp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B51684A8
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709071; cv=none; b=r/MiaG2GJGkjkU4kq2PmzIBnAouH284j6ayJFEk+GsEDSA8F6bhAK0T3dGLXuw7enzrwCMp0EbgA6x3NQTYWVk3GYLKoAPN77J3sKbvjaDLn0qZNZkg1yUQYgQTdjcQt5mD5XNJom6VEs0MeYHKIaoQGPpoX9i0I1QL+ATDiyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709071; c=relaxed/simple;
	bh=6KzNZle/EaU96fUVZHnKaYkFfGdzKhjLLjV4w8Z8whw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6IEKCBrWG2rgV6MEjc+765YCuNK4dtemV/sNO8nOo+oWuj3bIbipCedbvH3HGxZGpqjOEOxXFLP6BBFIlUX9nJ1JQGK84CWHlIOzYh+xs9WdT06ya2OdZrRLjVO0mpvsODvXRpYet9kiYQ8Osp1wDTd9GWTyHenoNCQt7Bvjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOi0kKqp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720709068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8AMhzzMfD9XqUK42Jiu/wDAMwE04jIynatkNmJpsTk=;
	b=hOi0kKqpKcVHSuYkI9qvih5hRxQ9HRZQl5CaMgyX1bGJnBOJRQA1VAjTrsPVnBXjMTRukj
	0+G4SciAz1suTPdIdusuUsA03hxPkfY9GUpFzDHNoM568dQ5e7mncaHJPnN2ySORnx5KKv
	hYH7+H8FF1pPBmZR5o2SnSywceGJ8PU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-QWf2_tqDO5qlfeIoElq0fQ-1; Thu,
 11 Jul 2024 10:44:23 -0400
X-MC-Unique: QWf2_tqDO5qlfeIoElq0fQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 231F319772EF;
	Thu, 11 Jul 2024 14:44:14 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 767C819652A8;
	Thu, 11 Jul 2024 14:43:50 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: do not extent writes to the entire folio
Date: Thu, 11 Jul 2024 10:43:48 -0400
Message-ID: <F0256127-61A4-47B0-B8F8-FC34A7A0A399@redhat.com>
In-Reply-To: <20240705054251.2043864-1-hch@lst.de>
References: <20240705054251.2043864-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 5 Jul 2024, at 1:42, Christoph Hellwig wrote:

> nfs_update_folio has code to extend a write to the entire page under
> certain conditions.  With the support for large folios this now
> suddenly extents to the variable sized and potentially much larger folio.
> Add code to limit the extension to the page boundaries of the start and
> end of the write, which matches the historic expecation and the code
> comments.
>
> Fixes: b73fe2dd6cd5 ("nfs: add support for large folios")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


