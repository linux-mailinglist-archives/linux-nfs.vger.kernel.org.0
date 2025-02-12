Return-Path: <linux-nfs+bounces-10074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D12A33324
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 00:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AF11679AE
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 23:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F14E1FF7D8;
	Wed, 12 Feb 2025 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8Akmw68"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E3204582
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739401357; cv=none; b=qdWhjSAdBi5v19+Wr7OAvo4KGN8iq1a3blE+iqh6+C5389z4w2wQOdE5CahzOLTR+CWv7mVGl64fO7iGP6aUwYZ5jsb9I8WmXwrQ8Fw7BW5026HwSHKIP9frJ2/dVp2z5U4x2ZVi1Nx8MqK7RQr0wd7+a/lz/WuOibAtq3ZP760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739401357; c=relaxed/simple;
	bh=TEvVmM4zMc6TYvffsXVU3qpXN59WmyLouTYB7IGslYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEkgdKqu3LgoRFPHGb3W9gXY0RPnvBj4psb3tPXuLElm6PMEQlRAHw9X2HS+lEYiylHIORjF+L9Cn8ttATDQ/2Curqz8V4TDyF25H4aLfVdYneWCR/6+A+Uc37kH9Qv3cdAck7iZaPvO2H7sFN7587Z0Ya2GMbP6vI6F+MfhQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8Akmw68; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739401354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1GTFMtmXq71odI04ldQ7/LvGaa7Lm50CgoiSV2FD7s=;
	b=L8Akmw685RCbgG4ShaOxGBSMr4ep/+/NItYoZA0zX2WCR6JC0diDNINLsugPN1g4jGNjyf
	FCaTVP0YpRePE/90DlTr+N2Rz5SR0fIcHk+f2Exdo4H9pwyJD//67zvPuFB9RugcRD+IxI
	AgibNxUKQTfWH74Z68fJBW7alVoMyTs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-C-WzmcFzN0CLSU58QldO-Q-1; Wed,
 12 Feb 2025 18:02:30 -0500
X-MC-Unique: C-WzmcFzN0CLSU58QldO-Q-1
X-Mimecast-MFC-AGG-ID: C-WzmcFzN0CLSU58QldO-Q_1739401349
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB9AE1956089;
	Wed, 12 Feb 2025 23:02:29 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9AF319560A3;
	Wed, 12 Feb 2025 23:02:28 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Handle -ETIMEDOUT return from tlshd
Date: Wed, 12 Feb 2025 18:02:26 -0500
Message-ID: <B617C7BC-DE18-479A-B0B0-3E75F75A2CA1@redhat.com>
In-Reply-To: <CAFX2JfnS1-LtjTSOYc7bOJMVxw4M4gyAH8MqruSekE_-KMVAEA@mail.gmail.com>
References: <614d3c3bcceeedb933400bdc00f812518c05a4a6.1739294902.git.bcodding@redhat.com>
 <CAFX2JfnS1-LtjTSOYc7bOJMVxw4M4gyAH8MqruSekE_-KMVAEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12 Feb 2025, at 15:38, Anna Schumaker wrote:

> Hi Ben,
>
> On Tue, Feb 11, 2025 at 12:32 PM Benjamin Coddington
> <bcodding@redhat.com> wrote:
>>
>> If the TLS handshake attempt returns -ETIMEDOUT, we currently translate
>> that error into -EACCES.  This becomes problematic for cases where the RPC
>> layer is attempting to re-connect in paths that don't resonably handle
>> -EACCES, for example: writeback.  The RPC layer can handle -ETIMEDOUT quite
>> well, however - so if the handshake returns this error let's just pass it
>> along.
>
> Do you think it would be reasonable to add:
>         Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport class")
> to this patch?

Yes, that's probably reasonable.  Thanks Anna, I should have added it.

Ben


