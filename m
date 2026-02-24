Return-Path: <linux-nfs+bounces-19182-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBvXEdnZnWk0SQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19182-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:03:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E72EE18A418
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3854C31F9886
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415703A962E;
	Tue, 24 Feb 2026 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5lf/U2e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C853AA1A1
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952109; cv=none; b=HOieWuRJRoaOkuIsNnF5U/EXQz+JjljiUX/ALVLknDe8oVKyz4JIk8AIIt4Mx/50okWeboIwZKPualclPEl6BEoBGaLuTBuX32pm314WfJGJnrw2WIekeQnjBytRGlDcfgBLkwv7b70SScN8YGH9c3qB5IUYxk94V0O9iwptT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952109; c=relaxed/simple;
	bh=6D2xm2u7a0Ard8UD5jhMoGvejwPvgyeFwzrZ6ep9k/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ry7jNC8LNu8fbWmT3t4+XTyD4TizvLvVGa687Nj43EadNYaRs66oUp6kiacS5IkcvfFYp++2pgtaefsQjpGjhPziBSM222yDCjGrhNI8LCNqrwa0DPzdhBHFCDmTCJhBMkUF0DpOuNOMI8onGcEu7FlsNfjrClTaRIqT/p0L6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5lf/U2e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a871daa98fso40830085ad.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771952107; x=1772556907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dk99oPBkOKQC4NJdNNbbUKUujZV8OZzxFj2+2UXmSY=;
        b=b5lf/U2e+Fzcg26x6XgKDfQlnHZEW4cshIEkFjtlRi33fVqo5AS8ha4h8ABOtZaB/U
         xy3UjcOwnWvjtcqFAtYbVsdOSgn/SClA3t5l1GSkiwGooJgqJj13kPmriGJdwpAAMPU0
         ipfXes1XdEzintpKmD+dZ1jBjI1Ccek1GDWOmFy8nFJIsA3TN2EKzryC52qYNvvm0iQJ
         ADF33DVBdCTyGSSmS0GtWDIBtNv2PO5i1yeDJcTsQi1YEZ5vOJIJOk7BFQrfd3Rgm8Vm
         yW40PBck7HXrZmRw+QFJdhc9aD9nKm8kETdQg8BN4rEvo/dwlm2Sl0tot9aJnhrpakmZ
         n3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952107; x=1772556907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/dk99oPBkOKQC4NJdNNbbUKUujZV8OZzxFj2+2UXmSY=;
        b=tR/n4eqO9RQFmILV35pkM3jaafgFoeQrUe+cbSTn8T9zkrCtD0h0DEyUOikUj3sygF
         QuBLZJVW+yZdPY2agSc3vjT6+j3HImjlzDgKjGHaYhwQTkCT897UivLUIuPzu2fnY1v5
         uqYeQzk6ydF+bfaJw6aHsgz0CDzZYKnpOkslOeZ2Q7q1fpqJQWRTUbvuUNCgLK5SzUT5
         eTO4i8HwOwOuN4B4D+ypdF+bXgPlfR1val/ORQZ0lTUQZhv4vnnDV5TNtqiyjunsjOxa
         siuACi2GYR7h7pXrQ1/9VYx/gnGzvPe67XjlU1zreYlNV44y5lS6b4s4zI/C0zBKzXFZ
         gH+w==
X-Forwarded-Encrypted: i=1; AJvYcCVTFoEdnmeHNJXw38BNGM+g+sh0wavwnJWubAre5JVOY3ozIW4ZQA6T41dpX+Ozd0+kz1NlpZzhzG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQy8DCVhKh9lb2bDzuBPxkndkyte5eSv9VYnWEUU24YEAoW7X
	cz12mHj0Ccel4de535HExP+/gvpsXBspHssfF4vtdP9w5RLjVA1yc6Cc
X-Gm-Gg: ATEYQzwXzoRCyfOZPZQ9NKhPB4LFHG0WFPaP015v+zgJYAa69D5xZY/yZIWhsO8W0Dn
	VZJsuz/blUXyKaiqK1H905aGaUZXS4+oRYqkRrBiYm5qp+bFakpeIuYAsAY87QDJb9Op84t+mg+
	Fsk14DQZWrcU0g297iLr7wRWIqcF+wMv3PVKuYk7eMRcYkRh8pMYtIHXPlsaqABxLiv7tlhBmGu
	3llc2gV1YVRipA5eNgrJJ1g+48AcOA8AzGbxbKyp7cI2MubtjVJ0ez4h56btkG0R9t6OqNKWwXQ
	Rq7MMzpvOTvgZB27VQF807Pmcw8R12z7sEIHOnW0t2nOqHE/Wp5DvygZrTtFXQKtMXKwHJJsyAf
	pg0pFlhbvaN36gB24eHfZExW9D2s5KdYT1qenPxgM5SzCjiEQVuvyC9u3cpeMRkNHn+Bp4Izcyt
	i3MpZwekUcpqMlGrvwyiWz8ozTI3PYM9sXlAzajZLiNLX8aLICBJl03aZNjY/JY8l5cHmiHqipn
	g==
X-Received: by 2002:a17:903:285:b0:2ab:2bc5:4365 with SMTP id d9443c01a7336-2ad74464438mr87550565ad.19.1771952107313;
        Tue, 24 Feb 2026 08:55:07 -0800 (PST)
Received: from sean-All-Series.. (59-115-199-112.dynamic-ip.hinet.net. [59.115.199.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7256f32sm12364083a12.27.2026.02.24.08.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:55:06 -0800 (PST)
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
Subject: [PATCH v3 2/2] net: macb: use ethtool_sprintf to fill ethtool stats strings
Date: Wed, 25 Feb 2026 00:54:35 +0800
Message-Id: <20260224165435.17648-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224165435.17648-1-seanwascoding@gmail.com>
References: <20260224165435.17648-1-seanwascoding@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19182-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[seanwascoding.gmail.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E72EE18A418
X-Rspamd-Action: no action

The RISC-V toolchain triggers a stringop-truncation warning when using
snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.

Convert the driver to use the modern ethtool_sprintf() API from
linux/ethtool.h. This removes the need for manual snprintf() and
memcpy() calls, handles the 32-byte padding automatically, and
simplifies the logic by removing manual pointer arithmetic.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..616823e9fc5b 100644
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


