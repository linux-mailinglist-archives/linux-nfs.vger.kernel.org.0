Return-Path: <linux-nfs+bounces-19972-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBM+DXwgsGmCgAIAu9opvQ
	(envelope-from <linux-nfs+bounces-19972-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 14:45:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 859FF250B4A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 14:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CB0237051BE
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602683D8914;
	Tue, 10 Mar 2026 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmIj1MST"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE93D8908
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146190; cv=none; b=KrtzvWlSuxnfM6rUpfWcfpsPfw/SWBSE7nKPnF/Y/z5Cj93yORwAEjj/AJeQbNq80KWu04pPMkWeUTDeVVs7ClP3XNXMk4rU726A3sb1/+EF0vngnpFk+1QG7DgQc43YmD8E2Axrot068w0bDduWTJxCWlxV5TBX4gjFTiC085E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146190; c=relaxed/simple;
	bh=Xsbd9wd471AvLXiu4pK92aLaMAWeTv0o2d+ouZkVNJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WkkCZKkdqNuQ6bJTNnh1UkOmZiYbfn8PpNySOUS+bOOYTS4qTNlYYUWHDvzpyprL3D+JYYnHvlxdJPbqiwUeH4Ndkkp5HjVFndWqRGi7oiZKEibcytdWI2t9ssoBvl9IOrOnwo2VIw7WIdFiVOfhuUVPI5f0A4DHbco3iWs0Xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmIj1MST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773146187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UenEFph8luTT58DpFDNvbsExey/qZUYK9YkteekufNc=;
	b=GmIj1MSTE/Bu0H2wfbyxktBkzxoF0rOeanEcm8YWutOIZXVuqcW1BjACssmG0IxZracgL5
	IdEOVCSH5B7f36jaWp7zTPSQOOHGUFLUHUvKvcK5EBcmIQTC04CMkDpSRB457vdlHd1CNG
	qFOUPRf+hybbYo0+UMQRvKHH81FGk+4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-mQMppihdOWyADtAuNV5SwA-1; Tue,
 10 Mar 2026 08:36:26 -0400
X-MC-Unique: mQMppihdOWyADtAuNV5SwA-1
X-Mimecast-MFC-AGG-ID: mQMppihdOWyADtAuNV5SwA_1773146185
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C478180035D
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 12:36:25 +0000 (UTC)
Received: from bighat.com (unknown [10.22.89.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3022C19560B7
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 12:36:25 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] Revert "nfsrahead: enable event-driven mountinfo monitoring and skip non-NFS devices"
Date: Tue, 10 Mar 2026 08:36:23 -0400
Message-ID: <20260310123623.53580-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 859FF250B4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-19972-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fedoraproject.org:url]
X-Rspamd-Action: no action

Process 869 (nfsrahead) of user 0 dumped core.
 Module /usr/libexec/nfsrahead from rpm nfs-utils-2.8.6-0.fc43.x86_64
 Module libpcre2-8.so.0 from rpm pcre2-10.47-1.fc43.x86_64
 Module libselinux.so.1 from rpm libselinux-3.9-5.fc43.x86_64
 Module libblkid.so.1 from rpm util-linux-2.41.3-7.fc43.x86_64
 Module libmount.so.1 from rpm util-linux-2.41.3-7.fc43.x86_64
 Stack trace of thread 869:
 #0  0x00007f1a867653cc __pthread_kill_implementation (libc.so.6 + 0x743cc)
 #1  0x00007f1a8670b15e raise (libc.so.6 + 0x1a15e)
 #2  0x00007f1a866f26d0 abort (libc.so.6 + 0x16d0)
 #3  0x00007f1a866f373b __libc_message_impl.cold (libc.so.6 + 0x273b)
 #4  0x00007f1a8676f665 malloc_printerr (libc.so.6 + 0x7e665)
 #5  0x00007f1a8676f684 malloc_printerr_tail (libc.so.6 + 0x7e684)
 #6  0x00005624543b1d32 main (/usr/libexec/nfsrahead + 0xd32)
 #7  0x00007f1a866f45b5 __libc_start_call_main (libc.so.6 + 0x35b5)
 #8  0x00007f1a866f4668 __libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x3668)
 #9  0x00005624543b1fb5 _start (/usr/libexec/nfsrahead + 0xfb5)
ELF object binary architecture: AMD x86-64

https://bodhi.fedoraproject.org/updates/FEDORA-2026-e033b6bafe

This reverts commit 0f5fe65d83f7455112aea82bf96f99523cb03ca7.
---
 tools/nfsrahead/main.c | 55 +-----------------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 78cd2581..b7b889ff 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-#include <time.h>
 
 #include <libmount/libmount.h>
 #include <sys/sysmacros.h>
@@ -18,8 +17,6 @@
 #define CONF_NAME "nfsrahead"
 #define NFS_DEFAULT_READAHEAD 128
 
-#define MNT_NM_TIMEOUT 10000
-
 /* Device information from the system */
 struct device_info {
 	char *device_number;
@@ -120,57 +117,7 @@ out_free_device_info:
 
 static int get_device_info(const char *device_number, struct device_info *device_info)
 {
-	int ret;
-	struct libmnt_monitor *mn = NULL;
-	struct timespec start, now;
-	int remaining_ms = MNT_NM_TIMEOUT;
-
-	/*
-	 * Fast-path rejection:
-	 * NFS backing devices always use the anonymous block device major number (0).
-	 * If the device number does not start with "0:", it is a physical block device
-	 * and will never be an NFS mount. Exit immediately to prevent blocking udev.
-	 */
-	if (strncmp(device_number, "0:", 2) != 0)
-		return -ENODEV;
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
-	clock_gettime(CLOCK_MONOTONIC, &start);
-
-	while (remaining_ms > 0) {
-		int rc = mnt_monitor_wait(mn, remaining_ms);
-		if (rc > 0) {
-			ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
-			if (ret == 0) {
-				mnt_unref_monitor(mn);
-				return 0;
-			}
-		} else {
-			break;
-		}
-
-		clock_gettime(CLOCK_MONOTONIC, &now);
-		long elapsed_ms = (now.tv_sec - start.tv_sec) * 1000 +
-				  (now.tv_nsec - start.tv_nsec) / 1000000;
-		remaining_ms = MNT_NM_TIMEOUT - elapsed_ms;
-	}
-
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


