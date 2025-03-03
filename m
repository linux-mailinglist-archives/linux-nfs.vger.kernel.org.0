Return-Path: <linux-nfs+bounces-10414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49842A4C2BD
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 15:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06387A5D0E
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C23212D6A;
	Mon,  3 Mar 2025 14:03:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B782135C2;
	Mon,  3 Mar 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010629; cv=none; b=jnfxbuILbMSIC2px+RHh8v1nVOGemlbDHgHFyZDwRKIDKp0P0RvybMawIx63KqVH1v8+y9rGgIa8CdZcx936MhE9evoZrv8SlCcifhdepKVwBHAqMXgynKtDHqb0evwwsdnEaf0L3E43yIHGIwnjFzQ4sBSpJR+KnSBgI1A0V8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010629; c=relaxed/simple;
	bh=n+ydm7VR2FIaW1UnONRA2sOWMUu6PJ5ey91y2Va08oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnBC+/YvXUWemUkhOv3v8WODARE9JmIUr+DAdtCP97B67ysEyoTkZ776ghL0JXFYVbu4xqqp/uapswB/amTcCld8N1IFGA22hdtxDnSK0wIJBTyD215Jml6Ad/5Z9A9K9PVsUpDT4Bi9gnPbcBn+iMiITG9B0ekGZ1NS9zkx2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowADX38u8tsVnnlnBEQ--.27843S2;
	Mon, 03 Mar 2025 22:03:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] NFS: handle wait_on_bit_action() errors in nfs_vm_page_mkwrite()
Date: Mon,  3 Mar 2025 22:03:14 +0800
Message-ID: <20250303140314.1650-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX38u8tsVnnlnBEQ--.27843S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtr48Kw43XFW8GFy5XrykuFg_yoW8Jr1UpF
	1fG34UWFZ3Xw1fKr4kKrs0va1Ygas5tF4UWFWxWw1ay3Z5Kr1rKFs5tr1kAFWUJrWruFs7
	XF4UKrW5ua4UZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcBMtUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUKA2fFmdgfzQABsw

Add error handling for wait_on_bit_action() failures in the page
fault path. Return VM_FAULT_SIGBUS instead of proceeding with
folio operations when wait_on_bit_action() fails.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 fs/nfs/file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1bb646752e46..9e492391687b 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -590,6 +590,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct file *filp = vmf->vma->vm_file;
 	struct inode *inode = file_inode(filp);
 	unsigned pagelen;
+	int r;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
 	struct address_space *mapping;
 	struct folio *folio = page_folio(vmf->page);
@@ -607,9 +608,13 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out;
 	}
 
-	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
+	r = wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
 			   nfs_wait_bit_killable,
 			   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+	if (r) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
 
 	folio_lock(folio);
 	mapping = folio->mapping;
-- 
2.42.0.windows.2


