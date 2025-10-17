Return-Path: <linux-nfs+bounces-15318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FED2BE64CE
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3468E3AA4DE
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 04:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16483112B6;
	Fri, 17 Oct 2025 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBOoQ82Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8331077A
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675051; cv=none; b=Z/UbgbbVzGsPs5kLAXqt6oHpancEO3c54TUCE3vu9Zc6xJIHaIZnaO+rKKAZBQpG8kiGGPQBiRpwqbE8QRwJZGdQo8hG1uXXjWQHfQWujsCG8G2KLNwS9bjm4Xg/xwL209kAhBX79ZIJ96/JZmpmYbkQBzrQhgG2A8xinACKeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675051; c=relaxed/simple;
	bh=5mK2M0hVJGfdiN3VSfq9BCNgQdVTn70R+CbJkNedk+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eqg4jp6VG8UZQ6XgcNrgOlbA74iqKVby0CMlIRZWZDzHsYo10jQULg5zLJizj16eGcy7qICSu119cPBJvdJURkyiSqbPCJC5y/SpZBsKtLaTkdJxMffz1ix6iYK+QDR5A7nvAnHzqHFREZsFyRSVfmPSjNchvrg7qeoThpLaczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBOoQ82Q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698d47e776so11045525ad.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 21:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675049; x=1761279849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29Lq2xnZtj+6Sy2WBmqrd6RHyzvurjh80XYGtTuJrGI=;
        b=WBOoQ82Q4+Y7rN+a2ZN8npcIO/l+yLJQ6aVHATOYgZu5YaeOwiL6j/PCDF7dImrvk/
         Tg5mzfp4pKJHgdCC1qGeds/l87hbTpDZomv+lxCB91j50UiWagLFmrXtPhLokPiBAHG0
         deTiBVSOVrJEeL+eFGMV9w6rEgAOvnDR1u+XB+54Dq7XJ5e21RybUfVgQHqZRINX6X18
         56FxyIjftAjfsQulyPGrnCTdtWP1u5rCwo3dlidDUWwVDCN0FNpaDDzcN9ze5pXKuvEa
         s2bE07HQo+uC6rljxA/y+loGfAP9Z5/d4yd/lXTnK4RJ5FMyD6zayucReRLQwyWSq2xP
         X5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675049; x=1761279849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29Lq2xnZtj+6Sy2WBmqrd6RHyzvurjh80XYGtTuJrGI=;
        b=QmfzG58P2pElbY99H/gfUrHMFDRReCpaM8IuioNXKHfGXFLtO4U4ykewF5r3PAVzQH
         AMnrY/CHiXreP6knxast7nrgNU5kQkg7YuLyXuTofvJNTIBaEHwTRwvDEqQpksFrQjGx
         h4xv1Dywvt8dnd5Dyk12yc6ctB3adgd6SIzFTJbb6u4ChR2ccJ/co8lyBFV/uPA9t2dD
         kqse3CMqdkIKZmKlbTwwPwoFGku09nPIN46SU5RbykvUYvl2F8kENdTs4kDiToAJmJzB
         iGkOFTx5XbNrn7jn6RmlJv6VEV57vqT8myCgluRJtZMiiGwSB2Er3kxjyj1KI6U21hjN
         2h8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJkvBDCMgFsg169GiHXm418Mt2HpCjHn4Dn6ZCzdzwOXFqdtZ6X0ycsHmXAF95CnP+QCFecqfN61s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jWu9ouA2r1oMYWbyY/SjOeW5d8KeJmSZWtWwbwEyooJZqIiK
	OfbmuPaK8HOvDww0cEaRY9NkMx42m38xGhXByg2GNirOm35vpjUUOebr
X-Gm-Gg: ASbGncvNRdTGBe9gMnHbo6vA5PuWmS40kkLUaNcnV+XrgsNnYm9dutRqKv2MjnctEca
	Flzeqj41ayjfaIcnkHxQR9QsHwdRmzBopeEm6xQxg9WpK1rznHuNzFo+kh2CRBCnUjiFTzIM+VQ
	WTmh4IjViU/A8PBsaO/qUb2hE6Yj4G3TZvIf8WFh43JL2prsaXgHH/WGt12Q3XEQFjSsoGlIHzR
	qlEbHa9PrTlgmFPqSb2wjLdaKXkwMRHizarvdp9B7ROJln3+mD8VDoT6tSaasopU6yztlBQNAvb
	zY0V2wCY7Xbpskj6B4e3nOeuq7C3uLMxvpxcwd5qeWaCDXCDjg4BRti3ZrSV9joJB/8ORgdAacF
	vCCF2SXlRaLbBO+j7CVs/2pE90c9FKXCj+CWg1A673YkTXFLVN3npV04VhlkHuwolUvKXAkPGQW
	ynJXtoPzN7bKeIFYMzShkYaiESFBjpAxG/dVEQ+U0zeXRLmD3pbA7nad4qjeikEzINkq/WoF4Mj
	wu1Y83Lm85isKjnQfNS
X-Google-Smtp-Source: AGHT+IE3Loe/21tReTiMC1KE1PN6nnxQShPQ2aeX3VGqy1tfwwjN0OSJDK1WmyW+Y1kgS8QPEPO/LQ==
X-Received: by 2002:a17:903:1250:b0:290:dd1f:3d60 with SMTP id d9443c01a7336-290dd1f3fc8mr6269945ad.51.1760675048710;
        Thu, 16 Oct 2025 21:24:08 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:24:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 6/7] nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs
Date: Fri, 17 Oct 2025 14:23:11 +1000
Message-ID: <20251017042312.1271322-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace to trigger a KeyUpdate via debugfs. This patch exposes a
key_update file that can be written to with the queue number to trigger
a KeyUpdate on that queue.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v4:
 - No change
v3:
 - New patch

 drivers/nvme/host/tcp.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 791e0cc91ad8..f5c7b646d002 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -11,6 +11,7 @@
 #include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
+#include <linux/debugfs.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
@@ -1429,6 +1430,75 @@ static void update_tls_keys(struct nvme_tcp_queue *queue)
 	}
 }
 
+#ifdef CONFIG_NVME_TCP_TLS
+#define NVME_DEBUGFS_RW_ATTR(field) \
+	static int field##_open(struct inode *inode, struct file *file) \
+	{ return single_open(file, field##_show, inode->i_private); } \
+	\
+	static const struct file_operations field##_fops = { \
+		.open = field##_open, \
+		.read = seq_read, \
+		.write = field##_write, \
+		.release = single_release, \
+	}
+
+static int nvme_ctrl_key_update_show(struct seq_file *m, void *p)
+{
+	seq_printf(m, "0\n");
+
+	return 0;
+}
+
+static ssize_t nvme_ctrl_key_update_write(struct file *file, const char __user *buf,
+					  size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct nvme_ctrl *nctrl = m->private;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	char kbuf[16] = {0};
+	int queue_nr, rc;
+	struct nvme_tcp_queue *queue;
+
+	if (count > sizeof(kbuf) - 1)
+		return -EINVAL;
+	if (copy_from_user(kbuf, buf, count))
+		return -EFAULT;
+	kbuf[count] = 0;
+
+	rc = kstrtouint(kbuf, 10, &queue_nr);
+	if (rc)
+		return rc;
+
+	if (queue_nr >= nctrl->queue_count)
+		return -EINVAL;
+
+	queue = &ctrl->queues[queue_nr];
+
+	update_tls_keys(queue);
+
+	return count;
+}
+NVME_DEBUGFS_RW_ATTR(nvme_ctrl_key_update);
+#endif
+
+static void nvme_tcp_debugfs_init(struct nvme_ctrl *ctrl,
+			    const char *dev_name)
+{
+	struct dentry *parent;
+
+	/* create debugfs directory and attribute */
+	parent = debugfs_create_dir(dev_name, NULL);
+	if (IS_ERR(parent)) {
+		pr_warn("%s: failed to create debugfs directory\n", dev_name);
+		return;
+	}
+
+#ifdef CONFIG_NVME_TCP_TLS
+	debugfs_create_file("key_update", S_IWUSR, parent, ctrl,
+			    &nvme_ctrl_key_update_fops);
+#endif
+}
+
 static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
@@ -3065,6 +3135,8 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 
+	nvme_tcp_debugfs_init(&ctrl->ctrl, dev_name(dev));
+
 	return &ctrl->ctrl;
 
 out_uninit_ctrl:
-- 
2.51.0


