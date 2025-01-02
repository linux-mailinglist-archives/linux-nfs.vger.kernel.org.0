Return-Path: <linux-nfs+bounces-8875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932999FFB12
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 16:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6981D160F05
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E8C190068;
	Thu,  2 Jan 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQ1uhJ6i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4518FC79
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832341; cv=none; b=t++WoAX1koO2e3Lkyr94LEHQ+SNSiOfJd5VJBTICLxF6L0AVYnwp6OKe93a48XwwAL6UPkB55NcEFT8XzFzWd6FMdEx3yzC/sgdhsKvEbAQAbsB+mcJ7tJgO2ozJuimo+wCd5v8cDaMT319Wg1G5QmBRTAwYeboYPohOOpEQgOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832341; c=relaxed/simple;
	bh=DadL3Mx2532ZKtoftKbQD4KbjXUaSjGXbYb/gB51GZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ce2bsbQb36sqFUs9VqrAFTfp65sSZOUbJqpK8vE6DBbCGybyfOlant4tM4rcEaiQz7WX3c6SCmAx39eSg80bHldWohl+1YfGfSv1P5Brdh7EucvYGS1RQMchYryw0meFcVwdAz1IhWUVawJZVa5S9fN7URa6D7WXMiymR2pz/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQ1uhJ6i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735832338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vy+5PEWpuuwhp3mEaHYHuyaolfKfrBfIILh3cWOfp3M=;
	b=TQ1uhJ6i1PXoQApWtRphu6UoFaMAcCZ7x+o/XUliDXSpyvZe5d8Q1q9q7R3JI4DWiknkuZ
	1WyXsWgX0iE5XsDiFSca0Q6AjdzDnbPBIBvaXkMH8Aer4mSuyWqs7kH/uvd95c18Cca/KH
	jCd1cLQ1YTTN0FvcVlzDMpQ0FCsA+/c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-hvk-vgQ2PiGXCZB5Axikew-1; Thu,
 02 Jan 2025 10:38:55 -0500
X-MC-Unique: hvk-vgQ2PiGXCZB5Axikew-1
X-Mimecast-MFC-AGG-ID: hvk-vgQ2PiGXCZB5Axikew
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D8961955D4B;
	Thu,  2 Jan 2025 15:38:54 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09D4C19560AA;
	Thu,  2 Jan 2025 15:38:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Linux NFSv4.1/4.2 client source code structure?
Date: Thu, 02 Jan 2025 10:38:51 -0500
Message-ID: <5A440646-9BA0-4EE1-9AF3-D9C7DDAA1DA4@redhat.com>
In-Reply-To: <CALWcw=HDd06aQi5TXZjVgYDD7+fiheErCqDt2_6cd_c5iieCZw@mail.gmail.com>
References: <CALWcw=HDd06aQi5TXZjVgYDD7+fiheErCqDt2_6cd_c5iieCZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 26 Dec 2024, at 19:45, Takeshi Nishimura wrote:

> Dear list,
>
> Is there a document which explains the structure of the Linux
> NFSv4.1/4.2 client source code?

No, I don't believe there is any such document.

> And where can I find the code which negotiates between NFSv4.1 and
> NFSv4.2 versions, and a potential NFSv4.3?

For the client, that code is in the nfs-utils tree in the mount.nfs binary,
source in utils/mount/stropts.c - look for "nfs_autonegotiate()".  If the
mount command does not specify exactly the minor version, then a mount is
tried with decreasing minor versions.

Ben


