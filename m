Return-Path: <linux-nfs+bounces-4813-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C7192EA35
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E181C20DD5
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03D1607A1;
	Thu, 11 Jul 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpP1Iso6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3814BFA2
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706700; cv=none; b=pQmVWujD5gDqLhw++bdLa5ijg4DtdtnyeVfNpTW/XmI3pPPoIU9EP2JEGOUnUdLLqcJKChxaYkx6i/WLp6FgDnCmwTlJsgndjdARaIIBVg2CuaWdIQSkbAnq8A54msj772iOIHNjEEprt3mglvIYvMqF3c26BZ5SEACUY+Ji6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706700; c=relaxed/simple;
	bh=PTT2Ogmm/UeMZTkt7/nHubJ1aLUuAtMkfPihjHUbdjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRnXNAGtfcVF48veT/349vOskZI/5QzDVqpgkTGgTbHCPGl3CMWWbVSf5le3wU7gnphhFngmuRS8Tavr+RCJfCMFAhHb2rzJT6IFvv6teb3oixIYd7UhAojQ7tKYrBfLXN83c6dRQPRqpXf47MHgBQ5igvbBFK+F2AP5+M/FlB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpP1Iso6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720706697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tfS97n7AexsVvVkSJ1CGLe2Fc6ABFU7K7eZ6dzCRSF0=;
	b=EpP1Iso6DKCQ1cZAgBJm71F/YNsrP7p7Ko9qtRkwSo8zebQ51tjfgEyDYGq6UDfCDdyHBv
	8OMMpLYbWdvdOSGaKFxcb1/aE4+c5OsrZsGmh1f5hA+Va/keAKsZgYTWlhdTPif7IaXuEg
	4c/XgBp1bbgDuinZJ4U9ZJnmDKipCg0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ZSDzcnCUNCWixWDspj3CIg-1; Thu,
 11 Jul 2024 10:04:54 -0400
X-MC-Unique: ZSDzcnCUNCWixWDspj3CIg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DB5E1944B38;
	Thu, 11 Jul 2024 14:04:51 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 930FB1955F3B;
	Thu, 11 Jul 2024 14:04:49 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nfs/blocklayout: add support for NVMe
Date: Thu, 11 Jul 2024 10:04:47 -0400
Message-ID: <8B5CD261-CC15-4834-88A9-05C67668279F@redhat.com>
In-Reply-To: <20240705165141.2248305-1-hch@lst.de>
References: <20240705165141.2248305-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 5 Jul 2024, at 12:51, Christoph Hellwig wrote:

> Look for the udev generated persistent device name for NVMe devices
> in addition to the SCSI ones and the Redhat-specific device mapper
> name.
>
> This is the client side implementation of RFC 9561 "Using the Parallel
> NFS (pNFS) SCSI Layout to Access Non-Volatile Memory Express (NVMe)
> Storage Devices".
>
> Note that the udev rules for nvme are a bit of a mess and udev will only
> create a link for the uuid if the NVMe namespace has one, and not the
> NGUID.  As the current RFCs don't support UUID based identifications this
> means the layout can't be used on such namespaces out of the box.  A
> small tweak to the udev rules can work around it, and as the real fix I
> will submit a draft to the IETF NFSv4 working group to support UUID-based
> identifiers for SCSI and NVMe.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Woot!

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>A

Ben


