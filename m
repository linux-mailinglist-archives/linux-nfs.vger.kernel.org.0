Return-Path: <linux-nfs+bounces-19846-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EZYIO8BMq2k+cAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19846-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:53:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 445712281B7
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6FE03019534
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 21:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E35C346E78;
	Fri,  6 Mar 2026 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAFjg1WM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CED341055
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833981; cv=none; b=DUzgfI+2TTEQGrIf8uru9z4DEs5x4zFgxPxvn4PJ1HlkvvO1tig5rC/yeXygwM97BSnezb15EhQluSRUzSFc1DeAyeQADewQvysKDE1cGWC3Lb6fzdFQsHNHsEmApZ5GYQ2moCKH/WImhFUm2wjO2dFadEe9tqgrUPRyiH1dBAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833981; c=relaxed/simple;
	bh=q75BJraDvs5jzQuZ1x8hJnyGZRdb8gpMeZ2Cshwx4FA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pI1W7reE/XmDK4uWvVqAd1vNO8thgrt9Hq3dMjgYuc6ZUFCr9PoCWp/LkkBrKt7nlBRGvkNNG3kyFTIfJZRmVYhnV8lzA+ntjiw/gRyG94LqyvEqL2vFKgWPvmS/s5JUbv93YslJkWlFI8WPL1l0elQOYx99+ayuqJmbEApg/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAFjg1WM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772833979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77pTeHmcl97+TjBLwU42yfW+sLB3Qe981/43AG+TIO8=;
	b=XAFjg1WMWkoaS9rsJ3VPteRsqZejopm/Qq2I9xBMzSapb/Vb1TJGGuE/pcP3UKwjutdWo/
	6a0OJq4sIECwS1IWCF5t8yVbdiBB0KA2egvGMZdJQ1fzfOpRXfs986IIkrB+w7x0Gagwjy
	XA4IpQZdpSVIxfMcX1DwyZ85UIhNgEA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392--8OOwXShO_2Ye5iHXebxDw-1; Fri,
 06 Mar 2026 16:52:57 -0500
X-MC-Unique: -8OOwXShO_2Ye5iHXebxDw-1
X-Mimecast-MFC-AGG-ID: -8OOwXShO_2Ye5iHXebxDw_1772833976
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAA9D18005B3
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 21:52:56 +0000 (UTC)
Received: from bighat.com (unknown [10.22.64.126])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C4843003E9F
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 21:52:56 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH v2] Revert "nfsrahead: enable event-driven mountinfo monitoring"
Date: Fri,  6 Mar 2026 16:52:54 -0500
Message-ID: <20260306215254.18764-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 445712281B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-19846-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This reverts commit 2b62ac4c273a647df07400dc1126fceb76ad96c0.

Most blktests block/ failed with "Timed out while waiting for
udev queue to empty." [1]

[1] https://lore.kernel.org/linux-block/CAHj4cs8URj2fJ7KyP9ViAm6npVOaMiAErnw2uFyPYEU2wb7G_w@mail.gmail.com/T/#t
---
 tools/nfsrahead/main.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 64953346..b7b889ff 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -16,7 +16,6 @@
 
 #define CONF_NAME "nfsrahead"
 #define NFS_DEFAULT_READAHEAD 128
-#define MNT_NM_TIMEOUT 10000
 
 /* Device information from the system */
 struct device_info {
@@ -118,39 +117,7 @@ out_free_device_info:
 
 static int get_device_info(const char *device_number, struct device_info *device_info)
 {
-	int ret;
-	struct libmnt_monitor *mn = NULL;
-	int timeout_ms = MNT_NM_TIMEOUT;
-
-	ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
-	if (ret == 0)
-		return 0;
-
-	mn = mnt_new_monitor();
-	if (!mn)
-		goto fallback;
-
-	if (mnt_monitor_enable_kernel(mn, 1) < 0) {
-		mnt_unref_monitor(mn);
-		goto fallback;
-	}
-
-	while (timeout_ms > 0) {
-		int rc = mnt_monitor_wait(mn, timeout_ms);
-		if (rc > 0) {
-			ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
-			if (ret == 0) {
-				mnt_unref_monitor(mn);
-				return 0;
-			}
-		} else {
-			break;
-		}
-	}
-	mnt_unref_monitor(mn);
-	return ret;
-
-fallback:
+	int ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
 	for (int retry_count = 0; retry_count < 5 && ret != 0; retry_count++) {
 		usleep(50000);
 		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
-- 
2.53.0


