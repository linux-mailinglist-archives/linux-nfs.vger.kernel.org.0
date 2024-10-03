Return-Path: <linux-nfs+bounces-6820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3116098F247
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6397D1C215B8
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C821A2C32;
	Thu,  3 Oct 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+Rrnns0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192991A01BC
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968500; cv=none; b=kA4za7m8q3oP/VqaWAdxLz0lHrhyPA/M0jNVp/P24eFkKU/bW/CgTZGAGuinMx/y21uKuSEPU0HeIYVzu7nAmmFBORI5ln6MHfAsZGbI/k0L7ySJxeN6dyH+5XW8vTr4qml+vPZlSSncP3/nSQlwZMoIuJ7c9g6g2CqwNyquL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968500; c=relaxed/simple;
	bh=7Yq4cy07ZquN0NM6WX4wVc7UDGlhgQy4ek2vgUtUTfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhUXIG2KBBjUyajTcFRg+lWoeQOdpNG/EuxyMJkWAjf7k4zjaMu1yf57fiogCGA6O/p/Viui2wuun2GRgENmJP7YNdeFh26PwKmYEE0fPv6y/H3bmPLYuGMNVgTGV7d1fuhXJPMm0KBxgHqxc1SzaTTaMMduaDipo6IF2MComCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+Rrnns0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727968498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Q6u1Q1puTLpWggqtqfruJ5S7u7WGLMO+5A9Gghea7s=;
	b=G+Rrnns0NxN6hZvgYqnME/Cb438/zxL+u9Z2+zWnTey6tZMPMwicevoLMToiuckVKDijqJ
	S0KOtMZQ3mFi5VsSXmNfKFJEmH7mNIb2RzRUqDJKVmEjMNZB+jxt5uoQV95bElynDLSMvy
	Ikp6qr36mOJIKg5llj0FMZBenI/BAYM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-kKU9KgzcMMmnOaCgr5cSgw-1; Thu,
 03 Oct 2024 11:14:53 -0400
X-MC-Unique: kKU9KgzcMMmnOaCgr5cSgw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5AD419560BE;
	Thu,  3 Oct 2024 15:14:50 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AF2D19560A3;
	Thu,  3 Oct 2024 15:14:49 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: trondmy@kernel.org
Cc: anna@kernel.org,
	bcodding@redhat.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-nfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] nfs: kobject: use generic helpers and ownership
Date: Thu,  3 Oct 2024 11:14:31 -0400
Message-ID: <20241003151435.3753959-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

I currently have pending patches for fs/dlm (Distributed Lock Manager)
subsystem to introduce some helpers to udev. However, it seems it takes
more time that I can bring those changes upstream. I put those out now
and already figured out that nfs can also take advantage of those changes.

With this patch-series I try to try to reduce my patch-series for DLM
and already bring part of it upstream and nfs will be a user of it.

The ownership callback, I think it should be set as the
kset_create_and_add() sets this callback as default. I never had any
issues with it, but there might be container corner cases that requires
those changes?

- Alex

Alexander Aring (4):
  kobject: add kset_type_create_and_add() helper
  kobject: export generic helper ops
  nfs: sysfs: use kset_type_create_and_add()
  nfs: sysfs: use default get_ownership() callback

 fs/nfs/sysfs.c          | 30 +++----------------
 include/linux/kobject.h | 10 +++++--
 lib/kobject.c           | 65 ++++++++++++++++++++++++++++++-----------
 3 files changed, 60 insertions(+), 45 deletions(-)

-- 
2.43.0


