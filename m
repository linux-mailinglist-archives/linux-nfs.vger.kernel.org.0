Return-Path: <linux-nfs+bounces-9117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EA6A09C4F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 21:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1349416B429
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E742236F8;
	Fri, 10 Jan 2025 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBivUgq4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A172236EB
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540276; cv=none; b=jDD7y0DMP9phhe3YciE+ECG+DAwnWqtchCoKHz/2pKVvKDQs42BkUE0siznxKZnS5jAQ8hoqRvLMn5O2Y88t4t/PtWxBhWkGeiD/5lbCBVVRNMV1z816S6sheTLDVliZ7eYarZxpO9vIc+akMDMbt8JS/47vtK+dee/ZvUmgO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540276; c=relaxed/simple;
	bh=vkCuZJnBsxDQLqJ47S6NPb80TRvQzuyc8PAAk+QPE6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVlr6x2CY756Kh/43vHgQ71kPquNDHBGOVFJcNMEbHR3PqkBpzAQMHY6P03aHn6ezE4cXChrvpRJINrqiP5JMMgn1roa1MZmUoHEYP2foTlkO/I51+sLBDEmBQwe/kL7RD7sMapyKt5MbxS2JodLlBydS9wLZIDa6H2/r8bvimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBivUgq4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736540273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zm+q9B/ns/mb5CHSBMCxNjtLMWbALmVhYXwGL1jdRHE=;
	b=JBivUgq4BG8AA2Bhll/3m9yN+MHfH7O5ozgSaaGZfG9dDsv/0dI9kXb5rfWqbbou9G3FTj
	vt2Oqt+keTaA3DCrc22aAZ1p3+mqYAtvjMbsst5Ju8oChrUMZZ32ByQr6DqFHS/A0RkFsE
	2EPVEWQYf39TQ9kVwHyMydnwCOynotE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-1xnLshmCO8G4VT_577AQXQ-1; Fri,
 10 Jan 2025 15:17:50 -0500
X-MC-Unique: 1xnLshmCO8G4VT_577AQXQ-1
X-Mimecast-MFC-AGG-ID: 1xnLshmCO8G4VT_577AQXQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FF4819560B0;
	Fri, 10 Jan 2025 20:17:49 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.211])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03E24195E3DE;
	Fri, 10 Jan 2025 20:17:49 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 0CF792EA238;
	Fri, 10 Jan 2025 15:17:47 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v2 0/2] nfsdctl version handling fixes
Date: Fri, 10 Jan 2025 15:17:44 -0500
Message-ID: <20250110201746.869995-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Two changes in how nfsdctl does version handling.  The first patch makes
the 'nfsdctl version' command behave according to the man page for w.r.t
handling +4/-4, e.g.

# utils/nfsdctl/nfsdctl
nfsdctl> threads 0
nfsdctl> version
+3.0 +4.0 +4.1 +4.2
nfsdctl> version -4
nfsdctl> version
+3.0 -4.0 -4.1 -4.2
nfsdctl> version +4
nfsdctl> version
+3.0 +4.0 +4.1 +4.2
nfsdctl> version -4 +4.2
nfsdctl> version
+3.0 -4.0 -4.1 +4.2
nfsdctl> ^D

The second patch makes nfsdctl's handling of the nfsd version options in
nfs.conf behave like rpc.nfsd's.  This is important since the systemd
service file will fall back to rpc.nfsd if nfsdctl fails.  I'll send a
test script and test results in a followup email.

-Scott

Scott Mayhew (2):
  nfsdctl: tweak the version subcommand behavior
  nfsdctl: tweak the nfs.conf version handling

 utils/nfsdctl/nfsdctl.c | 69 +++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

-- 
2.45.2


