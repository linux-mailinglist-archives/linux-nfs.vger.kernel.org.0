Return-Path: <linux-nfs+bounces-15783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ADDC1E2F2
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 04:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316153BD08A
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 03:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170442D0636;
	Thu, 30 Oct 2025 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Oe1Jv4Ai"
X-Original-To: linux-nfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248532C941
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793458; cv=none; b=uHv3HoxP4gREae2pPWGl5ZXxNVOMfqmdQuAbDFsTsgojQcP2yM9ptPqoi8hCA7ySI9PGefsJFgLepAGf2qBICg4sS1T2jxr2ZARb6S3dKK7hYr8M/Nreq6Kc+LqrA2J0Mt3gADBEQoDEFrUzgcXNr2jlruFFwa0vKEupQ1PQ7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793458; c=relaxed/simple;
	bh=w1K6a6GisC6Y1KEGAPFyM8N3x956g3lBPbr4nrj81n8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qGp4StnVJZ3N2kHRmzmvm8ajehUVUaC1UIqSy5N1fB4ZDwmQPMMKQ4yq5qIOF5186ouJwr67VoFmHM78ZyTbQnf091y/bcOTOoksqiub7/RNR2WkFk3YBBvdPQoYzivQPrbWNigIGxdoW8V6kZx9M8umgk7aU3/LMG9tMBiIdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Oe1Jv4Ai; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SP
	ixLbOU4Q064kZxSObKd53p0xCpQIo4Hay49pvWmdY=; b=Oe1Jv4Ai1wgLzw81sU
	il8s1r51bTkvv8p2lW6YtrBgP1iyq4GLpNgQax7wAGcoi+gcgvuUpm3GLapi0zq4
	kUTKTZeH4KfhxfnAP/qB+d5oGAjJPsnDXjqs0De08oSubHeg6GBkKxYzjHGzxix7
	wKotey5w7uepW/Iq07z/UlGZQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnj9J+1QJpIZB4AQ--.1378S2;
	Thu, 30 Oct 2025 11:03:27 +0800 (CST)
From: Yang Xiuwei <yangxiuwei2025@163.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	bcodding@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] NFS: sysfs: fix leak when nfs_client kobject add fails
Date: Thu, 30 Oct 2025 11:03:25 +0800
Message-Id: <20251030030325.157674-1-yangxiuwei2025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj9J+1QJpIZB4AQ--.1378S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrCFW8Aw4fXr1rCF1kKF17Wrg_yoWxXFc_GF
	WxWrWkuw45JF15Gr4xC3y0q398X3y8uw48CrZayrsrtFWUtryxAw4qyw4Yyr9rW392vFyr
	Cr1v93sFkr1YyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8aXdUUUUUU==
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwh9vAGkC1X+yNAAA31

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

If adding the second kobject fails, drop both references to avoid sysfs
residue and memory leak.

Fixes: e96f9268eea6 ("NFS: Make all of /sys/fs/nfs network-namespace unique")

Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 545148d42dcc..ea6e6168092b 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -189,6 +189,7 @@ static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 			return p;
 
 		kobject_put(&p->kobject);
+		kobject_put(&p->nfs_net_kobj);
 	}
 	return NULL;
 }
-- 
2.25.1


