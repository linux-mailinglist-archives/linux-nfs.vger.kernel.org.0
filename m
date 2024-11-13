Return-Path: <linux-nfs+bounces-7934-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666B9C786C
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 17:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB7428D5CE
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026B158DC4;
	Wed, 13 Nov 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIaCEHPh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E333171C9
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514396; cv=none; b=STYbneo11dLtxfr7nMyETYNzK83bd6AqUrxLVdbjNJbr6gDo+hBfkLY5mDddTpqOpMynXpxv39k7MI0IwDd5y6GVDU84Gi9o8jOVTg8tDw5w8sLz7sJJWtjB9hwCsYIUDbioOR057teSM6BHwNFC024V12Oqj8XzKuzpXWdqhEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514396; c=relaxed/simple;
	bh=klQbYb0IGOBm8SMpvmyb8NI5S/fwiE6lhaQ03iZgfh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRW6I4dbgsJG6v7pbGVPf4dAxO9y4Jw1LBoJKJcB6/1yodxnqNMGlHsUO0sjY4SSTebEuaP8YuO3TADO62cKmcnIJ4EAZabxRiISrZNEZWJBJSJg6TKWeiq7iDThQ/0upYRRoal5DPPUSX4HtUTCyG4ONrGhE+oN7NYFvmbKgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIaCEHPh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731514393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VjsvdpSTlH+pPj/Kd57q9g0n5gstw5kb0G/DO8xfmB0=;
	b=gIaCEHPhl9JYaW9NZlYHfHPI+y6Yn8PvGKr6ZuDnH1dHB1jncOjUGKz8V+51nqBTGvfAnp
	fYTIRL/mTe6TI9yjQIGjgC1BApAsw8heqkmKGVtE3CRLFxwunFyHyUT6TneqIqWqfQIpC1
	/LWJeU/3EwnZIbhVvAcdtzVEuIjrfzw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-0U24hn5YNheWRkTBAj4MZg-1; Wed,
 13 Nov 2024 11:13:12 -0500
X-MC-Unique: 0U24hn5YNheWRkTBAj4MZg-1
X-Mimecast-MFC-AGG-ID: 0U24hn5YNheWRkTBAj4MZg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 686F01955F41
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 16:13:11 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8A9C1955F43;
	Wed, 13 Nov 2024 16:13:10 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs-utils: fixup statd testing simulator host arg
Date: Wed, 13 Nov 2024 11:13:09 -0500
Message-ID: <e8a429e2957d3771031d6d944981eaa16ea9feab.1731514372.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The getopt setup for the host arg was not expecing a value, update it as
expected

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 tests/nsm_client/nsm_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nsm_client/nsm_client.c b/tests/nsm_client/nsm_client.c
index 8dc059179806..b757209c3769 100644
--- a/tests/nsm_client/nsm_client.c
+++ b/tests/nsm_client/nsm_client.c
@@ -72,7 +72,7 @@ static struct timeval retrans_interval =
 static struct option longopts[] =
 {
 	{ "help", 0, 0, 'h' },
-	{ "host", 0, 0, 'H' },
+	{ "host", 1, 0, 'H' },
 	{ "name", 1, 0, 'n' },
 	{ "program", 1, 0, 'P' },
 	{ "version", 1, 0, 'v' },
@@ -136,7 +136,7 @@ main(int argc, char **argv)
 	my_name[0] = '\0';
 	host[0] = '\0';
 
-	while ((arg = getopt_long(argc, argv, "hHn:P:v:", longopts,
+	while ((arg = getopt_long(argc, argv, "hH:n:P:v:", longopts,
 				  NULL)) != EOF) {
 		switch (arg) {
 		case 'H':

base-commit: 38b46cb1f28737069d7887b5ccf7001ba4a4ff59
prerequisite-patch-id: 8e580f79b2ce8a4c0771e250fcc7c67f943b309b
-- 
2.47.0


