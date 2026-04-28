Return-Path: <linux-nfs+bounces-21242-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJfwA/tt8GmgTQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21242-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 10:21:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2547FE65
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 10:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9B25300BCA4
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625593019C3;
	Tue, 28 Apr 2026 08:15:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1C3939B4
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364122; cv=none; b=C2U+gE/n+4xm2TptbGjNgOfpzE6dxZ8GfdyEC4SrzfZNj5kevt6szPXwUvIJPxEsII4qJuKWS7+KDl2GpC1+rFIjufHldTk5k9FAcglsTu8gOya6+mf2KiMOO/MLEQrtiQcgkCqDyuE8a4ETN9P9BxnAuuVbHpQAMmnB6cMvJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364122; c=relaxed/simple;
	bh=dMEGznMeD5SI/n+SBJkUPVvTOe3AmJ8ow1Qk0cwcovQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hEHr4ku0/pObTgFGWBuD6H7CdDrQeR1MqRkoCRvCIhPLCiSD0uIrbKI/rC6lcZv74ltwjGHSFhVoGEbswophdPhnSkrt4UboXHPEuuzTe18X4PY24egt7Bqda3c6nbhgC3VFbLy/MOLRtISNI4trHF6nLq3BQJgJWy8m/grG+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso102742125e9.3
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 01:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364117; x=1777968917;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OjrpnMuQf6nO5XOspkV8YiLKld+GgahdY+cqhhh3Kc=;
        b=EnNoOlztmKQHrcdb229xIyb0q/B9uPp7awMveKGnP129q6kX++2xBY9gyCtjSUzLWd
         4XowCHDbcNuB63U4aD1x7h8XYYmAw3j3QUBEhkYYmw44YFdTHp8FVw/DLT9m/+ENj2r5
         0iBZhQkIxBO2rCQrhhGB359/kqk0y8mK25fP/PoqEyLBMLLadrl4bqmNqQVGh1uKS57m
         GzV2+UbXUzP1sfYt0hrK76GEHwu9vaZ4MWetKjfaDGYEFT/uZNsenVmAwiNhlC1f5eeN
         VO0ApOEQaqUV9XXY+clPgj7OmiQ2axqzhjtcQS/7yE1Qdss9HGLAW20+YB5Z/H0RfkmX
         eozA==
X-Gm-Message-State: AOJu0YxM+tIOLvBRwDeZVwqUYRu34rBA+Mcox6a3xcg7dgaKQXMPrdva
	AsfGvAB1uu2/pigL7qv2j8p6JchObom4tUeQ2pFawrpVle7crXR6oaB5KFup3g==
X-Gm-Gg: AeBDiet6byt758/ukCyxjlmfx2Ij4c0lRTgjUGB9Nh/1KptfebjvuK1wWG0nUgFAMvz
	p3aoTNaVp5hiqJgRBbD8HXJNapjRjiQbw8lqVGpzfKdNsr9RoxRHaE0ySZqC7kamzg6lgMyaFKr
	f/bTHu79hFni27KpNn3DjjZS5KVEdnqX0UtzLPmE1wjvJNTcxNGG5i0exZt1dKBXtOxU3kBiWwU
	H/QhzVJXKkrUXCCFShu6YSEV3raLrqaMKAoH98/a9IfBuJPRrpfqqaHON3hAxntdHCxAaDL/Qjb
	ERBHP/a3HkDgp2cr2h2vizJaR1qVbwv8SKKq88Wdm3yxUNAnTNkA7TCMNDO+bmugimvkjmi3aZM
	voLg0fEu6HC29mYMbEb8pdkUa1OwLcevlQPGt0t09xJ6gYUqlZbzx/Xcgj7Anb1/YcCfvdQ0F4u
	9Vn043XqDy3CQGerpaZ7wmaYcLp6X7wooDvloOlXKRmOljCXLbWPzoasvVJxpNcY0kZvksUY3V1
	dD494jLKsqpvjhOk0MS9MyxQsg41xvIE4A=
X-Received: by 2002:a05:600c:c048:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-48a77b2266emr22595725e9.23.1777364117366;
        Tue, 28 Apr 2026 01:15:17 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7748f32dsm17150735e9.2.2026.04.28.01.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:15:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH] NFS: show redacted cert_serial and privkey_serial in mount options
Date: Tue, 28 Apr 2026 11:15:14 +0300
Message-ID: <20260428081514.23737-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5CD2547FE65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21242-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[grimberg.me];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sagi@grimberg.me];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.939];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,grimberg.me:email,grimberg.me:replyto,grimberg.me:mid]

mount output should not reveal the contents of the serials, but indicate
they were provided.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7a318581f85b..ffeb8d3075b9 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -509,6 +509,10 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	default:
 		break;
 	}
+	if (clp->cl_xprtsec.cert_serial)
+		seq_puts(m, ",cert_serial=<redacted>");
+	if (clp->cl_xprtsec.privkey_serial)
+		seq_puts(m, ",privkey_serial=<redacted>");
 
 	if (version != 4)
 		nfs_show_mountd_options(m, nfss, showdefaults);
-- 
2.43.0


