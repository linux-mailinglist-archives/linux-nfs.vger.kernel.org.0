Return-Path: <linux-nfs+bounces-21253-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHvBCWfC8GloYQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21253-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 16:21:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4CC486D2C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C24DC30036D9
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62753386578;
	Tue, 28 Apr 2026 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwpbGlKl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD969238D54
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383765; cv=none; b=bPUL6X8F7XeRjadjrAx3mnLZbzrQFLFhDjLoxiwOfDX0SSxNDndFHk6IPaFaEG/PhYphEL79PfL59X0tW6HzioQre/6UkPo7abv4CQAP0o1FrEPKHdSrMD0LmHdRlLFX/KFS5nfLSriEISG44R26lKjcBVY3ZWMYysMQffZM9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383765; c=relaxed/simple;
	bh=3fTJZcmes/th6YUY+hR5wNK8VA/ILbEaybzo8AGKjK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFHWSlNo5Wc76OMfgjCrRzLqt1mkTti0LK9SfBVWFf7G0HbYSr98r2qgbfu2Nut1EiECbxfQa33c8ybVMOVsiw+vGyS8OmsArGlHBNTQ7LI9KnpF4T7/UdgP4P4ALQKeQB1YMYCO4vUgZG5R0Wlx3s8ew50z4E2tjEei0Id6SmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwpbGlKl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so105150775e9.0
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777383761; x=1777988561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJADsQL6+j0VWedbBviJoQt3A3fje4Hd8xa4kVveAGQ=;
        b=gwpbGlKllUIfflZgiqn36LzIWT8Vnybuj5rrMdNW6666t0q5BqkwfBoj/WDmDsFfGF
         +LjU6yaU2C/mDaYvwI15fNzdzPDqrBxt69bOQ0kgnSloIUrSChpDMkM3FXDu0Yr/qm1f
         X+GRj0ai2Je3KOQjzyDr0JmrNiIyLMnMvPfmk9d9UYC6v5ompKdxGMyWY6oqYu7Osiho
         LhUfjN0TjMAEaK7I9vfRYueYMuDMnBE9H0zqdIqQ1BizpcXFGKrsLEcMI3HmttSTofs0
         90gtnFiOQ2x+yQDbE0IohKdKH2l5YNzMQ+UVwDjKz9UROWBkK2sDszwlfGRNEt090xOw
         rn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383761; x=1777988561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJADsQL6+j0VWedbBviJoQt3A3fje4Hd8xa4kVveAGQ=;
        b=nhCNA6d0q+3nI4KIGXyaGN/YBG6O0Rv9n8O5J1sIfRMQgwdMWprs7qylaNfO8VqG7W
         kXSuo0KYztWuXDuA64JSgRdEVj5TYyDoBAmwnLI+MGqqbpQWI7wq4QNObWFTnmdXQf2/
         uYUp8ffx2did63bzZGGxnjeX1DdI/nG5Bsq6EMlWGn6VBWMffbiTVQZQDfq116nA0/Bu
         0JP+Z6SRUxODRpXgPYnKhg4mdBQz+IVI8o3S5bh+ABs9P2WdhB9aWpTxlYIw6MZgJFNF
         D+VjbkmNVYOSFr2M2xVoGIgDXt6I5Z8dycycfHYxmaKL7VzAf+WkBi8r+g7rb3jGC5jE
         PszQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PPn0rQnuc3kUFnFJWjNsgQmRkOAQXiUUEKULD0P5jEVtjj4av4jROf/Dk8SqjiAHlzrrHwFyHEu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQT/r5HmGVlXdiXpgbPx0MnEya9ydDo17FRgdhBE5UTfjJkNY7
	kEo6cuDQbhXRQWkQcAE0l3Z78RvNJGGOE2/BIVPmgzk7sgeYF45W27Ha
X-Gm-Gg: AeBDietiViWuhm14qKvDn5+fifSbSVucr9IlPaydM0zFS5e0sleShqGOlCsTa+khoE+
	pF3LppsXUY2bXgBHnUiiVuwL7dyL0Pl1wcLWthYn/Lj3Qt9ThpzanMBJb1PA2VjroDC6Xitm4Qb
	vQhHr8EBt+LHnPVXyQWvjGw174zqJlcQfEH15BDX2OZEkcjn77xBj/Ugw/hxEh/81zanI/CY3w6
	cdx1BfUHH8t/YHrqOcBVS/FnpuzREOz1YI1XCwUgfv6F5Jinzy8fzY8nXCGU5objrBQe/ssc2/3
	1rlL5/ZUAfEzdXuPrlvAd7wy2E3jDfH/jXOBJ4sUqQypCmVhOGLwjvX5jJ2ngDnnXeK6lo+SL6A
	45ffDrEmhOmYx3PoO0rlx6SdYfjgRuQmzW/yMqCpD6P37e/tEcNRMnWnVzkVgToTaBi6ffwF3IP
	O/7XdQabTq5AXxVNskgX4Goyd7/+WIEgniwoYlELGZcoDN9lxNRailQvemPh772OJr556Fn+tgM
	/l5aXLk1FYTcQ0LKZdO
X-Received: by 2002:a05:600c:19d3:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-48a77b240aamr52281015e9.22.1777383761006;
        Tue, 28 Apr 2026 06:42:41 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-205-63.cust.vodafonedsl.it. [2.37.205.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77aeb47csm51114445e9.1.2026.04.28.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:42:39 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
Subject: [PATCH] net: sunrpc: fix slab-out-of-bounds read in cache_seq_start_rcu
Date: Tue, 28 Apr 2026 15:42:24 +0200
Message-ID: <20260428134230.136533-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C4CC486D2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21253-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessandrozanni87@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,60cfa08822470bbebe44];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]

Syzbot reported slab-out-of-bounds read in cache_seq_start_rcu().

The issue happens in function __cache_seq_start() when is invoked
hlist_for_each_entry_rcu() and the hash value is greater than the
hash_size.

This fix verifies that the hash index is within the hash_size value
before dereferencing the hash table: if the hash index is out of
bounds return NULL, otherwise access the value.

Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection rather than the r/w spinlock")
Reported-by: syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60cfa08822470bbebe44
Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 net/sunrpc/cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 7081c1214e6c..aac5f03112f5 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1348,6 +1348,9 @@ static void *__cache_seq_start(struct seq_file *m, loff_t *pos)
 	hash = n >> 32;
 	entry = n & ((1LL<<32) - 1);
 
+	if (hash >= cd->hash_size)
+		return NULL;
+
 	hlist_for_each_entry_rcu(ch, &cd->hash_table[hash], cache_list)
 		if (!entry--)
 			return ch;
-- 
2.47.3


