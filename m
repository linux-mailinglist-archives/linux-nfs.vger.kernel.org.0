Return-Path: <linux-nfs+bounces-23251-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8enWH+JbUmr1OgMAu9opvQ
	(envelope-from <linux-nfs+bounces-23251-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 17:06:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEAE741DD2
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 17:06:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Yu2cwe9C;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23251-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23251-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 859BF3012CC4
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB44D2C21E6;
	Sat, 11 Jul 2026 15:06:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67C285068
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jul 2026 15:06:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782361; cv=none; b=W1AmuZY1m99M5/33fXfv1WnyC5IUPG64ejDFIdm67dCKmFxLAxcZqpHZSD96QABFdkstViZtYXPficsKGwLVH3dafpJLpoTg5EjUxb6zkaHvL+RmX8aRo89/C+loZk9j0J/h13O6N7Eekd3Cl05hU0R2e8+ccwm0qMr+wPrcPY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782361; c=relaxed/simple;
	bh=k+E/AHBP+Zx+ARWbImRQV03XJYhigmgrMOmIGmqx1Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsKwjNyv6k/jzN7kV15j+QwjKf+0FYxJFMmUQhAMwGJfaNthr6D48BLvx3nXRYnWwaEUHCz9mxKVQEqfb0s9eB6Up0FJ3p4F0xw/HS6s/0ZanaRknmzHsbf2ER+e260nDQhlhbGgeyX7vHiN5GaAf/ptDC+jssPWKDHFUKy2TYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu2cwe9C; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ff88549786so19270636d6.3
        for <linux-nfs@vger.kernel.org>; Sat, 11 Jul 2026 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782359; x=1784387159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EAx8OQB6mwEunipzmDLE3fqBbjdRzmKEhIwMzOXLjyg=;
        b=Yu2cwe9CgjNJcezcO2S9Wp5HtW7MDg72sEj4Fvk+AsL9oB97DPCJpfmq2URFboPnSZ
         VEA2bYF2qE9Nd5BIkLWYfJkvI5zVrkfG9mOCJeoSBeR2oYpQF4U/R3wnbEPVksDSMnZE
         yZ5IY4wr9KtDgZMTJpkd3h9zWBML/YyLAKc8dALb14kI/6ie4SJGcIgQdYW95atC3ZFS
         Qxd4RsGd6AubRgrYec8uJrnPjyraw9mG+eemTI0G/rvIXlh9MEZk4XQrJVg1VrZt09Ec
         rLj8NDwJtpm7OIvMMPEijdMRK273/sEkVdGnFBsCluS+TBOyDpCj/Q5PgZSnjDtMEQFr
         1xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782359; x=1784387159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EAx8OQB6mwEunipzmDLE3fqBbjdRzmKEhIwMzOXLjyg=;
        b=GT+RENvrb0uQzXjoCgiddMqHQj7wdjzus6tZUyPERTGJH/O00YQ+H68CAcpnW10Gt7
         9yIbYHa+2iJkTcTnJUWowUshU13Yh/hQToWVa2f7IziKnp3+4u2FSJf+2rZSKc1eDNCC
         4kq6cKPnx3WZBbui6l6jwXMBV3Q/XjBwjfh8hCqNgiYu+2GfJ4FHFK4DTpGqemIbhr5d
         quAYG994+K/9Y5Qb+8aQiES3Fn9bCU44hapry3zo35vUSq5Q3FBg6L0WKGxtoWFa8SsH
         6j4jh4HI/UsRgcR7LldBDf/Qu3XUsr2487o7FWyclUISuESIqc1tI/1wf5Gq7Z+6KqO4
         J9Xw==
X-Gm-Message-State: AOJu0Yw+DckH3ZD8TZpEgsoCtAusEYfpviprY4yi4tuA2qPq7Jpp972W
	rtmsA9rrbFV7JmRzuhKImfq0zNFZnemOXSk7sRQK33LNdOHYtiwreYya
X-Gm-Gg: AfdE7ck5bb/MOrjYij9iuOurmiO1nexwZAoawJcIAZWYaRY42aRagVfjbvanJ5xM4jK
	R1vzZAEBrol0blti6cJJTuK7yTMWG2nd/GAkdyVeNkF3OLi+h/ff5z0ClzVQclFPEMTnkOtqN3m
	Pd8QzfQMGglbWmwhWeISLE0XMn4Sv0BNSmWLCfeThRGYhmZedgrclDD2Q0EAlzb5H+366KGTtmg
	Zj0zr0sEvMdFweesy6t9Fv9riLbTritCLaJ+CzxKOMcQ5Zc21WEzKjCnGDt2WSuQlaydOZxIOnk
	0HIFcttvIhXhogx6qMN+klifBi4yTp/QgujcjVDaexu4T38sgjQKt9v/U6wVt+vLFX/xYIflBYa
	c1d17F+pvuD3sw4mUGgx5U6w5Xm/WI0jWfsCWkSbr8zoFNeJt8RZbBL5GJsaHl4y0UfXFAWRZh1
	70obTO6WvRsBH/+OdPVymDvaJgRWoG0nOIX4rzxRJOlLK9RpF3ezwY6JnLEjJuBwCKkt4GLmxyH
	4wfFo6nVQ==
X-Received: by 2002:a05:6214:509a:b0:8fd:6e22:c7ee with SMTP id 6a1803df08f44-90402e69077mr35450716d6.63.1783782358994;
        Sat, 11 Jul 2026 08:05:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b91sm68559686d6.19.2026.07.11.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:05:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pnfs/blocklayout: reject zero chunk_size and volumes_count in GETDEVICEINFO
Date: Sat, 11 Jul 2026 11:05:47 -0400
Message-ID: <20260711150547.2912006-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23251-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEEAE741DD2

nfs4_block_decode_volume() in fs/nfs/blocklayout/dev.c decodes stripe
parameters from GETDEVICEINFO XDR without checking for zero values.
A malicious pNFS server returning chunk_size=0 causes a division-by-
zero panic in bl_map_stripe() via div_u64(offset, dev->chunk_size).
Separately, volumes_count=0 passes the existing upper-bound check
and causes a second division-by-zero via div_u64_rem(chunk,
dev->nr_children=0).

Impact: a malicious or compromised pNFS blocklayout server can panic an
affected Linux NFS client after the client mounts/uses the server and maps
I/O through the poisoned blocklayout. An in-kernel parser/mapper KUnit
reproducer is available privately.

Reject both zero values at decode time with -EIO.

Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR parsing")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/nfs/blocklayout/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index cc6327d97a91a..fc60669db3ec4 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -183,8 +183,11 @@ nfs4_block_decode_volume(struct xdr_stream *xdr, struct pnfs_block_volume *b)
 			return -EIO;
 
 		p = xdr_decode_hyper(p, &b->stripe.chunk_size);
+		if (!b->stripe.chunk_size)
+			return -EIO;
 		b->stripe.volumes_count = be32_to_cpup(p++);
-		if (b->stripe.volumes_count > PNFS_BLOCK_MAX_DEVICES) {
+		if (!b->stripe.volumes_count ||
+		    b->stripe.volumes_count > PNFS_BLOCK_MAX_DEVICES) {
 			dprintk("Too many volumes: %d\n", b->stripe.volumes_count);
 			return -EIO;
 		}
-- 
2.53.0

