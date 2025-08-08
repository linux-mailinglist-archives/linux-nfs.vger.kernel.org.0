Return-Path: <linux-nfs+bounces-13508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513EB1E841
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 14:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E1416F07E
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0088D277815;
	Fri,  8 Aug 2025 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP5oxIQa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCF275B17
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655947; cv=none; b=NUDhtcR5vxmi9GWjsHkKtVR4XlwTJbndpaC1VbVyHN3d39HyNVoS+0dERWE/QxY/HI5Olr7o1EhnrHRN6m+GY4+pM6lMyAE+JTnMWd0oRocOERQLAD9Z67y2BUmdrASAKRKrCsOsvmR6KuTS97GTlp9W3+0gZu6zRrr2X4eBEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655947; c=relaxed/simple;
	bh=iTfHSUiLfzPC16Po7Brxa3iLH/lCZdsks9A7ncjHzHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpFErykZP73/s99VudsOahhWWh0cfdUQeYEBHWOB91ReV7zvygz/H64EHNFpU8NOAEDWU/c+2L8xWw3e7FopfYYIW0WnAwoAXe4FJG7VPpTIdmaSaPp7wlIqU0w09I1ON50prQEemcxXYIS++hl/yKCVx1C189Syt33JHqmOObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP5oxIQa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754655945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTfHSUiLfzPC16Po7Brxa3iLH/lCZdsks9A7ncjHzHU=;
	b=UP5oxIQaA5eD7pt15UOKpLxC9ws3vPuIqu8ujZWW8ASoYQDXJTVTbWOm8SMR2CUYoHtGYI
	e+1FEF9leo/B5kAbShYKmbeOUYs1efAVmFLqJDfopWdzJt8kp1XMDtuusFd4I6SzitsxMM
	k/yZqHPm7/ioao/TirZRhaxLC9zxHsA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-dKrZ9qpfOq-43DYXAVBhTw-1; Fri,
 08 Aug 2025 08:25:40 -0400
X-MC-Unique: dKrZ9qpfOq-43DYXAVBhTw-1
X-Mimecast-MFC-AGG-ID: dKrZ9qpfOq-43DYXAVBhTw_1754655938
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBFE319560AE;
	Fri,  8 Aug 2025 12:25:38 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 838DE180047F;
	Fri,  8 Aug 2025 12:25:37 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] NFSv4: fix "prefered"->"preferred"
Date: Fri, 08 Aug 2025 08:25:35 -0400
Message-ID: <3BBB1A6E-B7DB-46DC-97EC-3F8BD6EADBA1@redhat.com>
In-Reply-To: <20250808084103.230483-1-zhao.xichao@vivo.com>
References: <20250808084103.230483-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 8 Aug 2025, at 4:41, Xichao Zhao wrote:

> Trivial fix to spelling mistake in comment text.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


