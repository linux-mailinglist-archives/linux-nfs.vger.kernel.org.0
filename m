Return-Path: <linux-nfs+bounces-19420-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHGrGX64oWkYwAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19420-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 16:30:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B44D1B9CAC
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 16:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5813306B1F6
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CC329E7D;
	Fri, 27 Feb 2026 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEwLk5w+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78F43C053
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206023; cv=none; b=LFC9JAE1OSLEIy7d7xotlCYZXEN2BwJMoZf1nU9e8bktYijWxTyNyLiBs8ehGqqepRKWqnQJXvLtH6xubv46h+0ItOp/uhhSYlkC2s1/7qBHxiUuKYnmc0fHEQxJTCB6ljiNTKrBYRl6uuZAj/8Aft3ObVAe/hMK7vpQ2hx0SF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206023; c=relaxed/simple;
	bh=DsCvTnRonbBjO2JlO28mIxQ6YAbIlpWMICrRxDHCp3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u54nH7qYGqnAcwss02JiVUAMk9AJGthpkx0mK9Die4HlVWJ1j+X5uhMYJgVmUM2IzBeIvJ/tQZaTZqM81EAEzkjc6/d3+xVtwAnbQmux9HrW8tLCogVGc0VICHZvgOQB/Ok0c/aT4nz1+WsXnT7uybpJc2/Zwd7FHk9Yl6x00H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEwLk5w+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso1178570b3a.1
        for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 07:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206020; x=1772810820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX9CCCw8zu4UXrbXJRhFhr2cp9sA+7MdybCVq3xcDCE=;
        b=iEwLk5w+Kf3q5yOK6GSPqVYzOPjfJrhuLsFuv4x+oEbMbDj/kQd72GoJS2yLzpy+ai
         SBLsrY7CkHs8AAZwSX0dT5VgVNGMvGGualCq+wcHNoJqM9hQ9fGXp5or+1nixgq/8PVu
         2R6EAixSFyqh6ih6/jcDaqoqdDNaY7Zr6D8zY9+jaAu8fqHAMrt3AkPxEEYoVhCIcLmf
         dPNIIlqhRJFNp7jlhHdd03491thNzNlFNhtYYK7BdLnxW49w1PnhW75/UACsnJbXjY6r
         +/YYoSmXhNMBbH8OMOe4Kt4hIrotYrwffgtMDo3EpOfRnxKphNa+DvKZdk84oFQGW0GZ
         ElOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206020; x=1772810820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rX9CCCw8zu4UXrbXJRhFhr2cp9sA+7MdybCVq3xcDCE=;
        b=bAg10fNrgOT5ez9hbt0zx4ElGYJJnej1N1wenWnEVfx2our08f/pgrgC5LV2F7aPBy
         AYW+rdZyoZR96HMEbhFbCVCRpbVHZvV0oXaUUjfHnoZL6mPlzTXAp6u+02q/U/b0CYta
         zU99l/ikTDtwwbKWMqCQElc5131c3r66E4JM326c3nlcf42QHywDQHK2X3It8tS0L6xM
         hfQyt5zBLxBMiL5421nHuTbRmtL/HOFQTVkabTsU/hceM2C4AS3Tjk7ouEchxsSUq5zw
         8TuDtyl4Dqg3x9UnhQUlE9cJMDqRi1bPH/6yJVFOvOWwJoG4ZJcEPopzaQMFHDRzdXjC
         yRpw==
X-Forwarded-Encrypted: i=1; AJvYcCVtt2xjnVVOyHOFwzGtllKQpFTlhjKWfdmAYr7KAYtRfTLSnLcK18har7ApcBNY9vLgozHcXjw+kzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/Xrhszvq5PspxI2FiXecx1u5jMTJ3RaJSZj/KY7t+vykWT2d
	hYBvYPAqm3sPcMEKa4OUcZYiW7dg8NrWf1WMaxQzSBE6EgJsEn6k38U5
X-Gm-Gg: ATEYQzyOLbtixNbkqNxGZxwUZmqMGQO9nNT165J0TZlpSCQy6HOe8FU5U9EZJTV7AyK
	vn8V5K0k+zQpweXoKZqE+j4FhLMPGAIEtmTnUSP/DR4Mk6N7x15uTFj5gT9oPNoSpkI11aOZ7sK
	V6NAM11QnU3wEKdV9sJwu1M21j5BAGCUQK52P7z4h1KOvg73Q63HjHgL/Q6kI1Zb7merFPEaosg
	F/iDHmkhY1mNcJ9JNWcR8LvwUL2dq4h6YVgIlszGVBVmGRQRCt2o2GgGnAYgvyh+hE5vOypKEg5
	GhXMXSzlWJjud7E3bi7NHQM4zULRbbD+PY6SL98qKvQbcqCC3zDYNByH1hCdVlWoVjOL690woA7
	d80halyKUQRfos7BEdH2YAtqhCObYAIcvN5lM0Cyuzs1ukV9paDyjLiHGGxjg3YsmRZUtZR0tWV
	f7zvD1iPyXWMPkWx3g3o76PCbhE8csEWH2yDJR31f+oHegU+yvuzob8CXsI7jqHbEjZYDWE1DRc
	XIHTas=
X-Received: by 2002:a17:90b:1ccc:b0:340:b912:536 with SMTP id 98e67ed59e1d1-35965cec355mr2681607a91.31.1772206020190;
        Fri, 27 Feb 2026 07:27:00 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm9053211a91.0.2026.02.27.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:26:59 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v4 2/2] net: macb: use ethtool_sprintf to fill ethtool stats strings
Date: Fri, 27 Feb 2026 23:26:24 +0800
Message-Id: <20260227152624.164964-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227152624.164964-1-seanwascoding@gmail.com>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19420-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B44D1B9CAC
X-Rspamd-Action: no action

The RISC-V toolchain triggers a stringop-truncation warning when using
snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.

Convert the driver to use the modern ethtool_sprintf() API from
linux/ethtool.h. This removes the need for manual snprintf() and
memcpy() calls, handles the 32-byte padding automatically, and
simplifies the logic by removing manual pointer arithmetic.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bc35f651ebd..79ca19097b2d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3145,7 +3145,6 @@ static int gem_get_sset_count(struct net_device *dev, int sset)
 
 static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 {
-	char stat_string[ETH_GSTRING_LEN];
 	struct macb *bp = netdev_priv(dev);
 	struct macb_queue *queue;
 	unsigned int i;
@@ -3158,10 +3157,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 			       ETH_GSTRING_LEN);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
-				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
-						q, queue_statistics[i].stat_string);
-				memcpy(p, stat_string, ETH_GSTRING_LEN);
+			for (i = 0; i < QUEUE_STATS_LEN; i++) {
+				ethtool_sprintf(&p, "q%u_%s", q, queue_statistics[i].stat_string);
 			}
 		}
 		break;
-- 
2.34.1


