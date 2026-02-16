Return-Path: <linux-nfs+bounces-18949-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CUGKnxZk2k73wEAu9opvQ
	(envelope-from <linux-nfs+bounces-18949-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 18:53:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1E146CF2
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 18:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9626A30557CC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D72D838C;
	Mon, 16 Feb 2026 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivz/fJ0B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50942DE6FF
	for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264228; cv=none; b=GbMfIsdjjFtb3QCu/bqAJySCKc01J+aq9lp6+uvfEgVfPSf9rPU5anM/8dhO/IavHUIaZSMu4RyqVndqhHpgM2I3mpzbw0B4ZYnR/i/WSOl8kVl7l02pZ4KHHxlsM+puhPt0QT2M0iVDCJ25NZ8hJuSv7kNyHzoGwxSzoqo/jMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264228; c=relaxed/simple;
	bh=cujykqPOBu+XGtNA+zO+7zyBEgJZokZ8DEo9uvViBa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dB4SzXP21kSR2bUs8OrpIRt+bBusYdNrYiv7BuzLkW1IzaXbCwazLToKfjOiyIwBGjAGOJXntfAwiWSWQKfGH1Oe7lD/sYMDN/UccdPqMOwP6f5t79Nl9aNOANzJeS/SQOY2zOKeFSVhJBgAg1r8AiA4EpI1nS279fPXgk+7oGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivz/fJ0B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso15435795ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 09:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771264225; x=1771869025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DWA1/aPqaOkHhu0W7RZladxowlGqP9OIjIydQ8ofSc=;
        b=ivz/fJ0BKnFkmKH1zOzwGBc03SCpZjuwHC//JXstEM/L56HVvimavEXIVZvvJ7/fuU
         kfcJVdauwWB/mnFkm6YK0Fgcd3DVvcDui4vYPh0zH5/J5RK1BN4JwqWlBeUw25pi8Olg
         kbAj7EbX9HONjVKGX1ZKVeNEjwuXHb5i0GabqwlMNSatn812eSVGREPWSZVhYyTCNDzM
         3Tmime9A95Ta7Xa1eM5zr13hOBNgTIdiC2vuF8OPmpCu6d7MQFVj38CZz6nzHKOi7Xtc
         U14WGTGV5j82aCQCnMw8iJk63RnfIX8DXusimVQM/j5YcmJy3wlFjCqFAos4EmUmEI22
         qrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771264225; x=1771869025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DWA1/aPqaOkHhu0W7RZladxowlGqP9OIjIydQ8ofSc=;
        b=QcHbk6zB9NMn47YDmQvuYV/ENWN8rMgXx4pnd5rUqRmekh+sbR1fSO9eEcv6SwnlBH
         r6cD6S5NhhoP061pz/Ohze8alV246eY6RoHkmW0RnFrbLejYcB6A28G+kCWSgsfWaFiH
         3BcQLDeXATZp/EMx/fdQ/vLTPnj6Sk3GJz8/MB8Ym8QIkv1ai6h2O8mkCKyRAeV8adwa
         kmASDC7YmCv5KtgXuhymPnOoldW+qZeLpVLr6iAd32rcHX380gDaTHjxyd62rtYmF7+H
         aGgbUr7oUgfS0J6zR8DwrEyUpmeSRSY4zYarALg3ScrCoEYAHZlgD7JWkQQnHFJ+6l+4
         CvBA==
X-Forwarded-Encrypted: i=1; AJvYcCVxMKvQPH5CGRZvSFo5FrH2GA5Qt14gej8Y/7yJY0jpWN/fs639HUtnsv3SbDrmg62xnBwW56WpdiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNIE66fjTLsZ36BSGPa+hVRJS6Ru2JqFZm+Dbq/PPo+LavY1a/
	s8sF4yx8m7+OUdiXloLACOu5RrEVogsSy4ZZ/xredOKoRb474l26JX1A
X-Gm-Gg: AZuq6aJDlBJhvLk1p1vI0T4sRQAjBUzUvwEl7X9vBBiCHzYdMjgI7z+NyO+W4Dhs+4o
	SsrMTE/MXsllBTrZSyaNmKT56XRB9//3gwXBN/TWI6CtK4D2Ud/e58WDKWOoZ/wvHMIQON81ONg
	+PPb/bVV37k1JIX07q3jWqfH0pnm+sVPC34gDxmCQPClmSbIegJCL8s0V7QmHJKLhrWgAuAhTvC
	AX+0xpL15ZuF6Gdue/5IcEY3g/ITArfPNTfOQjti4P6dGWp428jlTCXm3+X9qgqYMRm6PbrhhiD
	LQ1AU/sWGNn4/+kZzWGvmWjx9rYlV4BeSmKDsQgEG4se9sqd6Pvg7itsC1YvIaStbxyXeSV0VvC
	X5zoGfBBsl5rMHU6V67+U3WJNNQJFdpswJ5MHWqi3RD+6/BF9rBRRAFbDKKhdqdnM19wX4WnAfn
	Bol13OTLKSDXfR2hqoSreaN8NPaFgbz7ScxzSUvXDFpXPKrmUIB3BjOHoN80wYQpO3umwE
X-Received: by 2002:a17:902:f542:b0:246:7a43:3f66 with SMTP id d9443c01a7336-2ab504d5addmr118963865ad.7.1771264225341;
        Mon, 16 Feb 2026 09:50:25 -0800 (PST)
Received: from sean-All-Series.. (1-160-221-65.dynamic-ip.hinet.net. [1.160.221.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c58sm80759155ad.59.2026.02.16.09.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:50:25 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 2/2] net: macb: fix format-truncation warning
Date: Tue, 17 Feb 2026 01:49:50 +0800
Message-Id: <20260216174950.455244-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216174950.455244-1-seanwascoding@gmail.com>
References: <20260216174950.455244-1-seanwascoding@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-18949-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14E1E146CF2
X-Rspamd-Action: no action

Use a precision specifier in snprintf to ensure the generated
string fits within the ETH_GSTRING_LEN (32 bytes) buffer.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
v2:
- Split the original treewide patch into subsystem-specific commits.
- Added more detailed commit descriptions to satisfy checkpatch.

 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..26f9ccadd9f6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3159,8 +3159,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
-				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
-						q, queue_statistics[i].stat_string);
+				snprintf(stat_string, ETH_GSTRING_LEN, "q%u_%.19s",
+					 q, queue_statistics[i].stat_string);
 				memcpy(p, stat_string, ETH_GSTRING_LEN);
 			}
 		}
-- 
2.34.1


