Return-Path: <linux-nfs+bounces-13593-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC8FB23ACC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 23:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4733A3962
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E632F0661;
	Tue, 12 Aug 2025 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXdN8v4c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D112D0618
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034711; cv=none; b=nw7WVdBxOThO+xAQ15dRIV3lmolsfiq6ac6N/BvTQv9SV7UH/l08rqZIU2I7SdfqAIBmeJdR8+RvU21892wTFM1yd8VUQ8FTmj9RijuYsCFkcg3SoqZTYJjnOAGeG8Hxg198jSQjuPxb7ex28eLGmVr8vu7KSoTPKJTS5gywgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034711; c=relaxed/simple;
	bh=zrcNdbqwFxasgEHpfjq7To71wBNAxo6gnEKahJ8pP+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huhQ2QGbLrum2FQ3PD4mYNRAGF28VrTpL4VBI7lT2K1dHCA+jUhMQfZ8uuqsNz8OhWvvjd2s1cae68M8SISXhJH8muGmlE0rFkCqHqvq1r08TQ49RJSIqFZFhvBBNu2fyP2ZEiQaUf1Vjy/hhxfZqILvHmd8SjRGKLsL9aSRavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXdN8v4c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755034709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oEuIZtwk5nlstzv/3AvGWbPy5sVy/y3wf4vmyz9yARI=;
	b=SXdN8v4cs0NqbagY2SsrMR32mA87cxwPCiN64vFtk8Gb+wchk7JsfVq4S9dJ/SFEo9wQ/y
	hhkBl78n9/GAX7FRspSR2nVkKtp150kuTCdCioXKYu6aC7w0xbGqdbdhax+FCtNdEjfqMT
	v1v4VLL63G29BXRFQeesvff/cqAMwP0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-BIgW-_1pNkKxjyZr8rMyVQ-1; Tue,
 12 Aug 2025 17:38:28 -0400
X-MC-Unique: BIgW-_1pNkKxjyZr8rMyVQ-1
X-Mimecast-MFC-AGG-ID: BIgW-_1pNkKxjyZr8rMyVQ_1755034707
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C53E195604F
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 21:38:27 +0000 (UTC)
Received: from tbecker-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.180])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D162219560AB;
	Tue, 12 Aug 2025 21:38:25 +0000 (UTC)
From: tbecker@redhat.com
To: steved@redhat.com,
	linux-nfs@vger.kernel.org
Cc: Thiago Becker <tbecker@redhat.com>
Subject: [PATCH] nfsrahead: modify get_device_info logic
Date: Tue, 12 Aug 2025 18:38:22 -0300
Message-ID: <20250812213822.403844-1-tbecker@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thiago Becker <tbecker@redhat.com>

There are a few reports of failures by nfsrahead to set the read ahead
when the nfs mount information is not available when the udev event
fires. This was alleviated by retrying to read mountinfo multiple times,
but some cases where still failing to find the device information. To
further alleviate this issue, this patch adds a 50ms delay between
attempts. To not incur into unecessary delays, the logic in
get_device_info is reworked.

While we are in this, remove a second loop of reptitions of
get_device_info.

Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfsrahead/main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 8a11cf1a..b7b889ff 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -117,9 +117,11 @@ out_free_device_info:
 
 static int get_device_info(const char *device_number, struct device_info *device_info)
 {
-	int ret = ENOENT;
-	for (int retry_count = 0; retry_count < 10 && ret != 0; retry_count++)
+	int ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+	for (int retry_count = 0; retry_count < 5 && ret != 0; retry_count++) {
+		usleep(50000);
 		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+	}
 
 	return ret;
 }
@@ -135,7 +137,7 @@ static int conf_get_readahead(const char *kind) {
 
 int main(int argc, char **argv)
 {
-	int ret = 0, retry, opt;
+	int ret = 0, opt;
 	struct device_info device;
 	unsigned int readahead = 128, log_level, log_stderr = 0;
 
@@ -163,11 +165,7 @@ int main(int argc, char **argv)
 	if ((argc - optind) != 1)
 		xlog_err("expected the device number of a BDI; is udev ok?");
 
-	for (retry = 0; retry <= 10; retry++ )
-		if ((ret = get_device_info(argv[optind], &device)) == 0)
-			break;
-
-	if (ret != 0 || device.fstype == NULL) {
+	if ((ret = get_device_info(argv[optind], &device)) != 0 || device.fstype == NULL) {
 		xlog(D_GENERAL, "unable to find device %s\n", argv[optind]);
 		goto out;
 	}
-- 
2.43.5


