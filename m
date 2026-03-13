Return-Path: <linux-nfs+bounces-20164-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD9vHcWStGkNqgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20164-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 23:42:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A489928A81E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 23:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B770303AA92
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BFD37DE99;
	Fri, 13 Mar 2026 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiiHfdy5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114E8379ECF
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441730; cv=none; b=nIU2R7W1a4fY1S4HIfOQWjYvro/9Ol+lkoMjkq5U3qZo4zlUUMY7feirGUTjpX0f6HDCwv6Qs6TvsjtMG+sYav3TGXVa5bkpgJYipwtc7M/eKR/HYCJq2mQpQ0/BKcKYr/bwrXL+UgJDF+otm7+56CCQ1gyGq4WwRJNOKaCR3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441730; c=relaxed/simple;
	bh=1OrsoQ6UCfjOXjKK/Szv2TGw4XmqShgMGuj6FCDnYGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UsXq1HigsrdT+6LlIQYksQTl4kBYtPidlguEdn05/hf7is1Or5O20m+8iH3ilOyLhTPdeCmBsXfnuNem/pWOHugRbxIg5epIij1uRYu6XIk7nbr4ltTPaL5p5ncygudHPCtfRT43ZX8Bl3z+cPb4Aqau51Pr3Un6x9dX9A5iPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiiHfdy5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6f21c2d81so260308285a.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773441728; x=1774046528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppd5aLnCbFC12f1SYvX8QWWGBv+ktEGtycjh6wNXZTg=;
        b=BiiHfdy5iJXy3xCHb45ENGVgSh3d10c/i2dttEDirj9Ng+9ZKR8WacUhqc4Le+Q0m2
         8oo1sNPnYqrGg+/XXyDeLWukG/WxxilGLiez6GhfZ/dm4IjhNEkOg25+Zskk+rnnwo19
         Tqoy8lLy2ZF/MZfmXnMO9B1qHXvwfmDmZHoq50n181ApriwWmFVCHGndKvEA3I8QfXkB
         3gMxHeOuk6L0fmqW0PxymD/w+/wpDQn8bU+3s4xu9gWxeRnuBIynCacUU67fjRMXLXlV
         MDQ2OSmQJ16JxyZbHtSSNqeeoQubq5VxLSFWhO5oF6KWWbkGihDg9fqAD9/I2HRv+hNt
         EIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441728; x=1774046528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppd5aLnCbFC12f1SYvX8QWWGBv+ktEGtycjh6wNXZTg=;
        b=N1+0pXzc7Kyn227lg7si0Pl6qZfwlk15foCmqC9R3IXq8X2DjQaYhjtrx7xP/e4h+w
         ZfjQo8OqfpDTnH2X7/duqV5VJ6KTfPMIQXItvpZfIQrsnSOpL0pWsDZJuFPCabOEALfC
         H0H2r8BTz0sOfAcE9mG6Nm67uomskux2v7ap1Ra0g9DqEjGBldpeEVWkQ974Z73qanxN
         yH18J275f9ycwZ76YAYNgLR8DAwRmFrdHUMiXV9FTePj33tfSVvTwx+a1vJ+KjSxS3Xh
         lYxo/znhvuJtAKkPoRsYIPfFyDoVuy5hkMxsofF+dUawDiin7qzaU21cCnb6Z4buIvNK
         n7Vw==
X-Gm-Message-State: AOJu0YzgMYGSBYDYv9/MvRUdjDRxdZpB2sc3SY1/7S0FVWXGwDLmKHzy
	3qHZEpE7Xp6nnDzK9oduEsTViTuMwmSMtiAK3ro6H03tsVs3IlP4T09P
X-Gm-Gg: ATEYQzzMs1nAEXLGIfdW7ZmS9Fzx1MUmbtILxhqCz32YrTQfkda0JKA2fHSuE6Xd9oI
	4GSMcbD3UamDb5xo+/ZB4KuPw+G2a4cy8dmHmHeNBYoTIUETu+j57A94TjjVZrQsLEBTJv1Ojj6
	WxnJ08djx8RoLU2FLdJKz2efrVGo2R0UXH2sjsvncnaUaT0nt12JbHxMoaEQosI5MWYoI49aiKv
	MbgE481XM+zh5mLJvJ5yaIUfFogf3Vif7uPS5T3IUl2jgOvlIAFUyGJJmcyZqupqyvhXnw5Cdrh
	spvQ4SovgEi5691XxsYZOFrFkjdwOPlSF4PCHE9HWvZ09KqoVILrJPo8ndSIt1OQYFVXtGUb9HB
	aiaa5E2hEGGr2ZTG/f/dNdBBcrtSc9qEH7PgyltRYk/SRh+7znarU5BVpyMfl832uUhT+rTo3/x
	nHAe1nGvopXfLQK+TZwebJAFRE/qCkk38k6Q==
X-Received: by 2002:a05:620a:d50:b0:8cd:b629:8d33 with SMTP id af79cd13be357-8cdb629ce93mr515578885a.72.1773441728008;
        Fri, 13 Mar 2026 15:42:08 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21348e2sm658046785a.35.2026.03.13.15.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:42:07 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	klaudia@vidocsecurity.com,
	dawid@vidocsecurity.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH] pnfs/flexfiles: validate ds_versions_cnt is non-zero
Date: Fri, 13 Mar 2026 22:42:07 +0000
Message-Id: <20260313224207.4065796-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20164-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,vidocsecurity.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qguanni@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vidocsecurity.com:email]
X-Rspamd-Queue-Id: A489928A81E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfs4_ff_alloc_deviceid_node() reads version_count from XDR without
checking it is non-zero. When a malicious NFS server sends a pNFS
LAYOUTGET response with version_count=0, kcalloc(0, ...) returns
ZERO_SIZE_PTR (0x10). The subsequent ds_versions[0] access in
nfs4_ff_layout_ds_version() and other callers dereferences this
invalid pointer, causing an out-of-bounds read.

Add a check for version_count == 0 after parsing it from XDR, before
the allocation.

The OOB read was confirmed with KASAN: null-ptr-deref in range
[0x0000000000000010-0x0000000000000017] from accessing ZERO_SIZE_PTR.

Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Reported-by: Klaudia Kloc <klaudia@vidocsecurity.com>
Reported-by: Dawid Moczadło <dawid@vidocsecurity.com>
Tested-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index e58bedfb1dcc..ee48920208e2 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -97,6 +97,11 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	if (unlikely(!p))
 		goto out_err_drain_dsaddrs;
 	version_count = be32_to_cpup(p);
+
+	if (version_count == 0) {
+		ret = -EINVAL;
+		goto out_err_drain_dsaddrs;
+	}
 	dprintk("%s: version count %d\n", __func__, version_count);
 
 	ds_versions = kcalloc(version_count,
-- 
2.34.1


