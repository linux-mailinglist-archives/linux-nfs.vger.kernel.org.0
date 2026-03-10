Return-Path: <linux-nfs+bounces-19922-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ5JItcMsGnbewIAu9opvQ
	(envelope-from <linux-nfs+bounces-19922-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 13:21:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863ED24D611
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 13:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 710B130D35E9
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BCF38D69B;
	Tue, 10 Mar 2026 11:56:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F04779AA;
	Tue, 10 Mar 2026 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143751; cv=none; b=tB1iAb7iUAVEYmunR/sMTNTA7ql9FNVIKRvGP04jT6DXmcAARPwuTLeNn2HSy8qN9Hv2Kj4rrkk1pVmaexn17I+/k59VNIjDlVaVtrbJs2biZCRClIc43VtqPXdLG7X0TRQW91+6LdCCCTmCRWFRp2+CeWXHT9hPGX7+DoGWQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143751; c=relaxed/simple;
	bh=dZgGx+TJ86HynJEVGMrEA5pIsLW37DebkwtATXmSHOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjCohHE54th+StuAmhFRr04j2wct5MfHsEdngM5oIrtAWa+jgExMxyYYtO1ImW0W3Hp/OBm5LI5eO1jz8wOVAbJ7rHUSEGtSmU9J16RUclzSpL9Vrtev/KE/SmYYGbhXlwUJbnxvTIyc2SUgEG/0jIvTrBmm5reo4S6Q8GgMud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ad-e21d-7f0000032729-7f000001d9e2-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:25 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:25 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:47 +0100
Subject: [PATCH 21/61] lib/test: Prefer IS_ERR_OR_NULL over manual NULL
 check
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-21-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2236; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=dZgGx+TJ86HynJEVGMrEA5pIsLW37DebkwtATXmSHOI=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYdDyn9P9EqiNuLjohkPV9X7iASajPgIoE/Y
 Nuv6AjHInyJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGHQAKCRA0LQZT0ays
 2wT8B/9ExWKAo/Sn9Hy5RU9mMJnGJZfEhSDSh3BrEyzAo8askVVJ9+5gjVv5zubvVRZSl0xsWYD
 ONcBymLUypUnGPDyKoUOhx2btlwnIrxM+A/znjwtFfejlhgahBH8clBf9ppwmWxz+aomfSi8dH0
 gI3DmyyOVIa4OSRnV4I+RdKzJvI1/m5sEwA+61ywfL4pM19NmtFK9XOne0dvmugbwth+SSxAJRb
 vUziX2Dy0AcV+RxD3aCuKKv6tZLzJkBbkKbaQ16k0qyAZb3zbS92hAPdw+yFsGOJMaFjGgEs6OE
 FCCv3wHl+aKzbAwbrH/eK6sw740pLs96xx8NapXtmcrko8Wn
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143725-98670F2F-CE18AF23/0/0
X-purgate-type: clean
X-purgate-size: 2238
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 863ED24D611
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[avm.de : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19922-lists,linux-nfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,avm.de:mid,avm.de:email,atomlin.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Andrew Morton <akpm@linux-foundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
To: Daniel Gomez <da.gomez@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-modules@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 lib/test_firmware.c | 2 +-
 lib/test_kmod.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index b471d720879a70c0db82e605960abe69de28ab4b..fc3177927a02e2d7849915309048529395ece0f8 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -955,7 +955,7 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 		init_completion(&req->completion);
 		req->task = kthread_run(test_fw_run_batch_request, req,
 					     "%s-%u", KBUILD_MODNAME, req->idx);
-		if (!req->task || IS_ERR(req->task)) {
+		if (IS_ERR_OR_NULL(req->task)) {
 			pr_err("Setting up thread %u failed\n", req->idx);
 			req->task = NULL;
 			rc = -ENOMEM;
diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index f0dd092860ea6f9c69a71e10cb1c8b071b1cd1b7..f44a181f6f1ab53cf95a0a0b598b88cb5f8f369d 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -327,7 +327,7 @@ static int try_one_request(struct kmod_test_device *test_dev, unsigned int idx)
 	info->task_sync = kthread_run(run_request, info, "%s-%u",
 				      KBUILD_MODNAME, idx);
 
-	if (!info->task_sync || IS_ERR(info->task_sync)) {
+	if (IS_ERR_OR_NULL(info->task_sync)) {
 		test_dev->test_is_oom = true;
 		dev_err(test_dev->dev, "Setting up thread %u failed\n", idx);
 		info->task_sync = NULL;
@@ -358,7 +358,7 @@ static void test_dev_kmod_stop_tests(struct kmod_test_device *test_dev)
 
 	for (i=0; i < config->num_threads; i++) {
 		info = &test_dev->info[i];
-		if (info->task_sync && !IS_ERR(info->task_sync)) {
+		if (!IS_ERR_OR_NULL(info->task_sync)) {
 			dev_info(test_dev->dev,
 				 "Stopping still-running thread %i\n", i);
 			kthread_stop(info->task_sync);

-- 
2.43.0


