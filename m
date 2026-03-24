Return-Path: <linux-nfs+bounces-20360-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFRiKcOxwmmRkwQAu9opvQ
	(envelope-from <linux-nfs+bounces-20360-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 16:46:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4773431852D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 16:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B67320C475
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE264070F7;
	Tue, 24 Mar 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKuaYiRk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84438AC8D
	for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366247; cv=none; b=WDhOOVKavwquT6oWsuHq2ZsSUxw8+35zvlazlIDk9DKAAQZEsp/MjCumyGmF9ZTzVvjWw7d9RhtV/yXBeXAcroXHus04vOBnFItq2dxp9GvgLA5R7MvifzL85IdJkquXMTISAL8qxNzO5QEItxPX2wG5laBi5zEkYp/SsUtqFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366247; c=relaxed/simple;
	bh=qAMA6Cx9mPQhYM79N+NXd1PhapKY6/Vo4PUKqwiUNQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuDnwLAMPB+5wiIgqFN7RNquJaxRUgEH58nQISKMgz7q9zOnkZeZhPmrcs+ko3SIKL2Z9QDHsnrmhlrIkL3yK8Xvapy9Z4Sl/fzpafr6PSAbRgJPXWeCfvEX1KDuwr7rtVfySn46kaP01awh6jwXx5dopOwIVrgnhEzA+jju8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKuaYiRk; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2c107ef474fso3273988eec.0
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366246; x=1774971046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a51ClirKzzDenotId8TaR0Ai/wpNXRaf05Y+a91QSjg=;
        b=tKuaYiRk+cxcCX6z0Qlv9X3Izs3U7aB5/7JdtX6m1M0bcx7my0viXz1yXOtX/ZYmDp
         bVgAtpRdHGjba7Rr7zydc8KAp1FRmBhVd1orwr8j5IkvrnBMXt/+HiwgLMr5kWYpLQMO
         uPwePo9O2ZAkxi5xfa8SjFhdR2MAIz4fcoz/6l4R0DZqsdHMwnWYMNq+8tegl8A5P6DB
         1WL+D0wcXUQRFAd1KZOtYk/TtDBjDTtpCddO1mA+/gIU4nThXlLKOyKu0IDPXvIj42gQ
         F9KzIUa39GNTaerYMrqbM/07xLj/YOEakeFvPN4x142z4tP4F3RJz4MVEbeniCucmryH
         yBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366246; x=1774971046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a51ClirKzzDenotId8TaR0Ai/wpNXRaf05Y+a91QSjg=;
        b=DQ6oeSBaJTmU5MzXY5WBOZHZp1+g/2u6iHgoeeDiN7GPgU5+zWtMFXHBDvOxrfopbX
         EgZ3sVzZ4hZ3e+UZ1i1aQL9775jYvc/1JU2Qpso/AThtoHlb8YH4AhAornV7gwVGPqEd
         nrEvylkNONceJcGRPOzgimQyOttyrYuz/yHcbL4yBC3GnPXCmX443mYURJV7PbvR/T0c
         c7LXhzyIr/0lfwSmnVkYq83ejuChS69fJP2vj57WZgrekxrDMM8YM9rFlIpJVOchi+Mg
         OJhwOXRQFsfjbOTUgRL1cT2jOr5PsHabJyoZvNQDWT8PRjorrIn0w0jMTum+yj61pd7d
         M4WA==
X-Forwarded-Encrypted: i=1; AJvYcCXCAh4Z/hoC4m/DVokS5O7AiQwdowi+xldvoXpzt/bM23TAdc9ZC+noIH7w5s80dyUUMW6p3btn2hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5COjGjFLadSstvntharFLs5X/WH2T+kn5bJUC1hpoX59L/fe
	2uvvSNL0lVbOlEPA/RAnN3nZYfkjYBUf6ZuWGC7cgCxipp/KoRADF/CO
X-Gm-Gg: ATEYQzzOXsgT+EaksMgBqaBWzpgUtzi8FsgClxpE+DjieEjZKT4j/7Uh+WPuDfrz+id
	+QsvrrM3+LaNQwf5VAK6hXXn50WjUXST5Hyc8OCJm2eeqoad4He2lic60C+rRJ4LeQ2cebxtiLE
	2LgIdjSUUAzVAGQCBBzpO6hMbe55hqVhlVNtG+QYkjJsNYgWbYNkvLsj32PgUsGdg3FWeDQpypj
	NiP9J7wcbVO5aedXSMTJyr1McvZQjWLRcciL/vn9CV+q7V4MApp+9yFUAWKnszjJ1D8kJOgeD2C
	CkbD9kdmhh5HxCMeiNNHenDkhJ2d4gVh4oOofmiHaEhM2Uq0fQS0Ne28HyRp76gSOxF6C8VqQPq
	rrm4BmTWs6BQL200zd2KDsSLziAb/IJ/qAN/z5ou8SP2KaYLhV6RFKOvUG3gMsOg80kOn7ikFaO
	PKWA/fHWZpVW0NBlJ39qr5nblGCtvIru+dEiQg0rIe+Uywb43sMg6wVfS+lcTiSia5i01I5PhmG
	1/zhrBx
X-Received: by 2002:a05:7023:b82:b0:11b:bf3f:5240 with SMTP id a92af1059eb24-12a726572bcmr8336993c88.9.1774366245659;
        Tue, 24 Mar 2026 08:30:45 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b952asm11668865c88.12.2026.03.24.08.30.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:45 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 1/2] net: bridge: replace deprecated simple_strtoul with kstrtoul
Date: Tue, 24 Mar 2026 23:30:35 +0800
Message-ID: <20260324153036.86901-2-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324153036.86901-1-ericterminal@gmail.com>
References: <20260324153036.86901-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=ericterminal@gmail.com; h=from:subject; bh=avaxbwaSm85gGcPuo27n20U2dgBtXUVQ3RMKsRhQtJ4=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqs1bb9Ey5Gr+x/pKgr3LCp5/vneVZF/CiX2D1l1o ud6rNH17pjIwiDGxWAppshy9/++ublet+Zc5z6cCzOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq GRrpGOgYM3BxCsBUb1jO8FfauSe2uLLf7f8uoStpv5b4bSmct4+HsUC+TVelpqz+Qisjw2yVJXX V/MqyrN9THi1/cTxo87vF2Vahc3gnPZnNb/+LlQkA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-20360-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4773431852D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yufan Chen <ericterminal@gmail.com>

In brport_store(), switch to kstrtoul() so parse failures and range errors
return standard errno directly before taking the bridge lock.

This removes a deprecated API and improves error reporting consistency.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
v3:
- Split from mixed series into a dedicated net series.
- No functional changes since v2.

 net/bridge/br_sysfs_if.c |  5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7..cdecc7d12 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
 	struct net_bridge_port *p = kobj_to_brport(kobj);
 	ssize_t ret = -EINVAL;
 	unsigned long val;
-	char *endp;
 
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
 		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
-		val = simple_strtoul(buf, &endp, 0);
-		if (endp == buf)
+		ret = kstrtoul(buf, 0, &val);
+		if (ret)
 			goto out_unlock;
 		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
-- 
2.47.3


