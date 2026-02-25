Return-Path: <linux-nfs+bounces-19229-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +otkENxunmk+VQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19229-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 04:39:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C51913B0
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 04:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A52353025162
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A827D29AAFA;
	Wed, 25 Feb 2026 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlgskxDC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06CA28C864
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990737; cv=none; b=nbBwFTv0gnbQ7/gbbWZMOj/BuvKkBsaIAIvMjHhP40AmN5lr+ljJGmW6vn9G+FusHbBE/vSY6qW1TP8/I/71W+F4iWxZTA0EAfIpVuY1dsczhFrOBORGvcbUoMqkUdgQt78tfA0EEzJ7MxSsb1qNk3F1FtyVnHr7mui21GbL4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990737; c=relaxed/simple;
	bh=ioQkH6Kq3BaHcNNHYkbSQWOm2Z0hguUCzLEhgRepsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB6BtqJhfcj5ggrVhk++HDKs4m6afcSJg5kWs7xpbQ3OInek5nXqCJ5USxp523fNFEsKZfpXlEo74cUoLMleq58LQZCcXpqRt/5luXKeUWBYSkGFcrquotc2lzne+d0NIAjLc6AUx9neSSSHrLFSUhz9SuKjVfkcrdXUzl2ND64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlgskxDC; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so172862a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990735; x=1772595535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRulitact7LuRkcM6p1wuTRq7YmEiipbfGs7cAozTt0=;
        b=YlgskxDCaagXqLqBWNR32RcGuHpKpYOSiknLrzppzx9jdMQLim4rYz540m4ElxQbL3
         ERewl5Y56lZNqRu0Kw/1C6AF2IDjJgYka6Yhf5iRvnqTB/ka//gKILEsux4Fy3D3lV5K
         uTG9en2lXeo+kRyg7ePdsIKWDZ9R5UDJV8RjwstCCKYioxO8kRYYBQiSLNlZRw0dxM+x
         WWRqp3Ss5M2+3N+XtOHjpxllkwAALttF+qPFTNP7QDonlrEovwdrGdVL/riuSt+PIt/F
         WRNv2A6Qz0bOjUqA4J/b1OUdWbrMFSWvQpjt1bjPZh/niWN9dqNk9alrq7x+qU7+jfGm
         Ff2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990735; x=1772595535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pRulitact7LuRkcM6p1wuTRq7YmEiipbfGs7cAozTt0=;
        b=a7w5USyHVGHqLaeYsAQC+2O9tRodXAxzBrbJRywuXoMDdijHqv46rC0/w265j0r1/z
         VAnhSLMuR4fjlYNQkE7F6YdJoz7g1AoUqUAubBLKjA0YaF/+q65//s/V1wQ2Bch34zYB
         Hegie/jMj5meR/1T5ZOS9Y+uD4GJIZ7nCwxILOHcnJgnMKtqiHIbY8sXLTxw5eUtd/Xe
         PoGxNM1bHedZYLqBmQt7DJAVRPialajj2Njyx+pvFv8jkzH9c7uhj5QHPcJA3YVKYmAj
         zNNJV2/p14d7UzcRWprdQOo1+yAycCvwMI9GuKS1EK3VMpyUbFet7Lsn0dAhC4XENxUY
         4dUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOpvkpLT6Sf67YZ5A/ma/oNLbhF5n3OzGimv0+8JE9SEbL5e+3rRpU3KidzNKXAuik1tjYmVCKfnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DqI5xmNOlc9rDbjIl/gyV3soZaDY4djYulHNgfvRVi3AqxdN
	mEDGyquCBbnbScxymXjfyRztlHFjYUpEHc5hKTawvESHbo2MTpONKxwf
X-Gm-Gg: ATEYQzztYA/bGKyCW2TahQB9i82uX7gu7Yogbm/6VAXMzeqF6GS1qVoXhBhX3oO85cH
	Qzn09W3F7T799T2+sdXsj0r9C2FhEC1Z8+siSl0O8NpqLCYBk9IlpqStMF3AGKmLyiIH3yxjb2t
	98xh03RXbms9Jhqk/FKSp/62WW/tpGiUOf/pNnlT5xJaPJ9TX+M4uRiCrg+8bZbLjJMKxPNbJVK
	/ne5hocAwU3hzxkw9goD5sRr4mcLdn8Cn84wDPEh0iibmKbwYLdJq9VTnX3W4XWwMKQUp75efUa
	oTkwuxoRRsxVPx5OAxUL4vZoPYwfyPrLi2FxSeHqbxgQ56ToOa6BP7P6KLl15enKzUErV+yjrW/
	rtiNAB+MOdkjjKTWU7mNH5Q2JedwE+dNjFa923qtqrzWzqfZz2vEjiuH8RCaV5mzVadSQiZk41U
	sEqcEIlreUh33oUVNYJJpcMr271FYTCUbSGE7eb62aCg2XcCgGtBLibmKvw2y+VvoE6LRO0Q==
X-Received: by 2002:a17:90b:530d:b0:32e:72bd:6d5a with SMTP id 98e67ed59e1d1-359037f3512mr2134249a91.1.1771990735285;
        Tue, 24 Feb 2026 19:38:55 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:38:54 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 2/4] 9p/trans_xen: replace simple_strto* with kstrtouint
Date: Wed, 25 Feb 2026 11:38:38 +0800
Message-ID: <20260225033840.33000-3-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225033840.33000-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=ericterminal@gmail.com; h=from:subject; bh=ULBANr6zOAUiLxfBQ+XUgxxtzikjVOyTnngJAb6RsoQ=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5Mv3PZGZ5rZi2trbn3b/meXvM21X0ZzD/hIHVHnU j+hlrfcraOUhUGMi0FWTJHl7v99c3O9bs25zn04F2YOKxPIEAYuTgGYyAFhhr+iYfnVLu2vlgl9 9Lm+6VXxTJlXa/TrWIMsHp+NPXTYLvgIw1+pWW6lZxMq+642FKwxSdu3MvZ8S+y6r4dllvUskXi 4sJ0VAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,kernel.org,oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19229-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C97C51913B0
X-Rspamd-Action: no action

From: Yufan Chen <ericterminal@gmail.com>

In xen_9pfs_front_init(), parse the backend version list as comma-separated
tokens with kstrtouint(). This improves error reporting and ensures strict
token validation while explicitly requiring protocol version 1.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/9p/trans_xen.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 85b9ebfaa..f9fb2db7a 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -413,23 +413,29 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	int ret, i;
 	struct xenbus_transaction xbt;
 	struct xen_9pfs_front_priv *priv;
-	char *versions, *v;
-	unsigned int max_rings, max_ring_order, len = 0;
+	char *versions, *v, *token;
+	bool version_1 = false;
+	unsigned int max_rings, max_ring_order, len = 0, version;
 
 	versions = xenbus_read(XBT_NIL, dev->otherend, "versions", &len);
 	if (IS_ERR(versions))
 		return PTR_ERR(versions);
-	for (v = versions; *v; v++) {
-		if (simple_strtoul(v, &v, 10) == 1) {
-			v = NULL;
-			break;
+	for (v = versions; (token = strsep(&v, ",")); ) {
+		if (!*token)
+			continue;
+
+		ret = kstrtouint(token, 10, &version);
+		if (ret) {
+			kfree(versions);
+			return ret;
 		}
-	}
-	if (v) {
-		kfree(versions);
-		return -EINVAL;
+		if (version == 1)
+			version_1 = true;
 	}
 	kfree(versions);
+	if (!version_1)
+		return -EINVAL;
+
 	max_rings = xenbus_read_unsigned(dev->otherend, "max-rings", 0);
 	if (max_rings < XEN_9PFS_NUM_RINGS)
 		return -EINVAL;
-- 
2.47.3


