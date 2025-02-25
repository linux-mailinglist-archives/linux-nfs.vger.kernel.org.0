Return-Path: <linux-nfs+bounces-10346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AC1A44F24
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 22:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD11C7A8643
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 21:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F7D517;
	Tue, 25 Feb 2025 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKhn2Cb9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A63209
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519976; cv=none; b=DX3xUEfMO3bba/yStmGXXi7Oka1J5t1LPKkbhotZzb3+6iNgTMuM6HD+yohbipE/mLstr6JI1uYN90UDpRV6dY4aHdTdfqm/h6/ds600R2WolVk3izlxt/lNpcmMOm7hK4bnEryRPNWE3QzH4b9YoX6tAs2r7l0JyiqSgLHH4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519976; c=relaxed/simple;
	bh=zSriwY16DTNnB01WqzILr9kXr0z5P5Br8JLt/ZLhr8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FylsmRaD56ajyRDta9glht6DYPd3tFi1TIqe3AAE2S8R4ThXcLhSMeTeZWv2WL6x1E4WSGxzo06RJldXb42w9QeSSQ32rbeY0Hnvr0IWx9GnGXETYCfjm6VkJ/lc/3pB4IreNzNoMifPh4eiU8NHpAOl3n4rgUClgGwd+WF/Ias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKhn2Cb9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740519973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8bBO1KQxiODSihgwCZywAr3+4imP+UNjdEv4NzSfD64=;
	b=YKhn2Cb9jK9RGcofNkdqN3Zq2XxKXlY+iTHnnrnvWOHday54W9vdB7W0C/c2t2RDDrQQ1B
	B1zT7QQj4rZigE2jMXYUR/0ICP8LQjDnen/LYFZO65IqTcPEuOr2+xSTbCqXHYwt9rITpQ
	X8yCrvRbRYA2sl8navzRfopVQdH9W7I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-2el00xaDPzeog3Tu3qnmrA-1; Tue,
 25 Feb 2025 16:46:11 -0500
X-MC-Unique: 2el00xaDPzeog3Tu3qnmrA-1
X-Mimecast-MFC-AGG-ID: 2el00xaDPzeog3Tu3qnmrA_1740519971
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E926C1800373
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 21:46:10 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB99C1800357;
	Tue, 25 Feb 2025 21:46:09 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 0/2] nfs-utils: gssd: do not use krb5_initialize
Date: Tue, 25 Feb 2025 16:46:05 -0500
Message-Id: <20250225214607.20449-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

It was discovered that on parallel upcalls to gssd for uid=0,
one of the upcalls would fail because krb5_cc_initialize() is
not concurrency safe.

It was suggested that instead gssd is changed to use a different
sequence of api calls that kinit uses.

https://mailman.mit.edu/pipermail/krbdev/2025-February/013708.html

Olga Kornievskaia (2):
  nfs-utils: gssd: unconditionally use krb5_get_init_creds_opt_alloc
  nfs-utils: gssd: do not use krb5_cc_initialize

 utils/gssd/krb5_util.c | 140 ++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 80 deletions(-)

-- 
2.47.1


