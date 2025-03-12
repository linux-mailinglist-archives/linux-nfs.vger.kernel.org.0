Return-Path: <linux-nfs+bounces-10569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C514A5E51F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 21:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF803AA44E
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648B2C182;
	Wed, 12 Mar 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpZfg23m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D31C13B
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810531; cv=none; b=CuxvorU1yJ2vlHqrlBryXa2uKiL3nUKJW8rzcy8hNooU1QCnAVhjn3SeWHuMJ51tweu/zMybReXBaglrPPuT2Rx+d7hqVofb2Se6yOSdu4gGM7iPZ5aiylljwfeLipH0BK7jKmZij8e+pVCKrpr4dNpO15bGiorgbcQbVkECggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810531; c=relaxed/simple;
	bh=McRXx8lZLQ/9lvDGsGMYzRX6ZXn5949GmXYxaaFYv54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiufNPkkV2o9ea9NDiU4oxbzYjFjnjo4ZzrdcGnD36x8hthTvtehdW/E5JN648XAb0sELzgQzeFwaB6wi8Y6o69608TB6pdCH/ItvT6/kWc2oHtpmZ4A+n6nJZhMMjQmijUvM+J3XQ7LfBgnmcwmYasAuBW6lTtzQGKS3qgmFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpZfg23m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741810528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYTB5mLchUpIQrqdIMgSb+5u2YPsPMXhFI2vY5znRyc=;
	b=gpZfg23mfXKJq1hXuXIqAqOyeHb+q/ToUuFwBKoMqneYcx05eT2AmiqJf6rEJWJJNArhcV
	8l8GP6f7zuw5TaiTf7LwdRQT8oFJQ8sy6PS9JsHkalqBf9rW0zOzW2+g9n/GwiHdA11wtg
	UwLtIZizA4w7iQv65+oPJXDDLjGwb20=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-1X3ykt5AMOOIrGWFTKlP1Q-1; Wed,
 12 Mar 2025 16:15:26 -0400
X-MC-Unique: 1X3ykt5AMOOIrGWFTKlP1Q-1
X-Mimecast-MFC-AGG-ID: 1X3ykt5AMOOIrGWFTKlP1Q_1741810525
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63E901800349
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 20:15:25 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A289819560AB
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 20:15:24 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Historical reason for NFS_MOUNT_FLAGMASK?
Date: Wed, 12 Mar 2025 16:15:22 -0400
Message-ID: <2F87F080-B9DA-40A8-9AFB-926F39F4CEB8@redhat.com>
In-Reply-To: <37CB7B45-A199-4815-8D4A-95D06CDA2D0C@redhat.com>
References: <37CB7B45-A199-4815-8D4A-95D06CDA2D0C@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12 Mar 2025, at 11:23, Benjamin Coddington wrote:

> I'm looking for some bits in the nfs_mount_data.flags, and wondering why we
> have only 16 bits masked off due to:
>
> #define NFS_MOUNT_FLAGMASK     0xFFFF
>
> Does anyone recall why we've limited the ABI to 16 bits here?

Scott's pointed out that its probably something to do with the legacy binary
interface ABI and how we just OR the flags into the nfs_server's internal
flags..

I wonder how long we have to support the binary interface.

Ben


