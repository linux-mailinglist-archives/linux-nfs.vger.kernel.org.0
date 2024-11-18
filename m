Return-Path: <linux-nfs+bounces-8045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77F9D1987
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73851282AB3
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 20:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0731E0DD4;
	Mon, 18 Nov 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nr6GPwJ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4619DF64
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961148; cv=none; b=K0o81F3itWHj7YuKcLOQUMaxQkOCynMphcca9tilhHXPDedu1ymB7VC+3e8QuPW4chCBYdEbAtfSKdHSAR1aK78kNdwjKkV/4TIK6DriP1o3RIuyES8DZyZVduaEKhF6Tw43//iB3MVMfSpIHlW81nY7xWcj8Vj4WtpN8AKMDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961148; c=relaxed/simple;
	bh=ueaUJqK5MEAFlcaRAwt6I/qxPl5UhkDxWsqjiUtXLHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZjMhMVq0qC9ttaLKLp2MwsFjgmb2rkacdsut9GlhoCISVKSWI8CIhhex3QFJ2enm5Wieg1wl+LT7z6gnHafJPkzCLL3EkuToAwXImYAetUTm+FMep8n0RJ/6i6wgxEW2TMowemC5+FuAsSoFA9vUIPZEsJqK8jSnwNObfirVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nr6GPwJ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731961146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5w8PjxUG/4A5Jov1W9WageSl5YW7s4brHDnbwQIFAVY=;
	b=Nr6GPwJ21uPZ0GHZL7mHZkLn1Fhcl5+m+XhFfzOPK0w1VTRvFoX0AeJgOKi/mzMr94TJNe
	FmKMRtKlDRsUvh4Na1MpBmv05RDv2LXJWWenSCOJxRBQm1zuKHPeCRFtaqcHwpEjvc4Drw
	Wcnc9EteObbSc5OfsKuH72UYD7STFJ8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102--VfuQnsLPFGU4nes0prdJA-1; Mon,
 18 Nov 2024 15:19:04 -0500
X-MC-Unique: -VfuQnsLPFGU4nes0prdJA-1
X-Mimecast-MFC-AGG-ID: -VfuQnsLPFGU4nes0prdJA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDAA819541AE
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:19:03 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A77B530001A0;
	Mon, 18 Nov 2024 20:19:03 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 2C295222553;
	Mon, 18 Nov 2024 15:19:02 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 0/2] nfsdctl fixes
Date: Mon, 18 Nov 2024 15:19:00 -0500
Message-ID: <20241118201902.1115861-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Two minor fixes for things I noticed while experimenting with nfsdctl.

Scott Mayhew (2):
  nfsdctl: fix up the help text in version_usage()
  nfsdctl: clarify when versions can be set on the man page

 utils/nfsdctl/nfsdctl.8    | 12 ++++++++++--
 utils/nfsdctl/nfsdctl.adoc |  2 ++
 utils/nfsdctl/nfsdctl.c    |  4 ++--
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.46.2


