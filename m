Return-Path: <linux-nfs+bounces-22805-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z00TCgoPPGqIjQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22805-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:08:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 718A86C03C1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:08:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=SoFxbBET;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22805-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22805-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E013303BB27
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A68379C5A;
	Wed, 24 Jun 2026 17:05:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE03783A1
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 17:04:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320700; cv=none; b=Z2VvD5RsI0BwnIhwhJ9U6Qq3/ooQG7ehmPgbHh8kerW/WlmZeAINwvmO/IqTNC/rv+B3KTXx/lPLnH3AJc8iPRzJCIwZaausXs5IOdKbcKduss9hRX8sji3Z4XcLQOwDMxKX6K74C+yRoe+6pDie5UUi6uCHEyWRjrNMIcIY9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320700; c=relaxed/simple;
	bh=f4XXfEg9EkSIV9TvyGgaKfyAqm57C+xwNdBcZpJU0Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNfJCXwArN9k/1zHH/cmCw5ldTWm4tuuTs9+cveHgUxrYEddZ+/Kyumf/Xk3uZiU6YTQvJsBD6y67SppFr/7z6Oht8NcyQhS1pqC7RM6tAKFNGdDGzvYgkw6w3yDNQSkFREHWNvmanvaf0dfxNOvoAbGVN4hyHW5aFAJJwL0Wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=SoFxbBET; arc=none smtp.client-ip=209.85.210.41
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e93d1dd156so653445a34.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782320696; x=1782925496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrFjH1dLnJGqAQgCyIJd/ck0yaqgBAkS8DGvIqjcyzI=;
        b=SoFxbBETsSoiJnd2I67EnzTAB9StH4dYoObUES9jlb5xf9zhSDbBzDapc08CVWQUNK
         O6Hzvjad/1mlqYJFyPWHkZyPfTfF7Q0weZbz/fv2uagMkFjGN24ffaEuD2AGP4OBp6C6
         5de56N4nbrmbYln8ITHIHqVfUPx/FgWa6oL7T0T0PX6jNUcMn4wUXWmWPzFFzIY20jTT
         Rf1QUYvBlS3AYvHKTqN8OXgoPzOHaJ8dNUxqt8uCShyEzyy05tG4V/guFg12HqdvD2Kx
         p2intOzaRnM2fMZNXu358wBW3SJmfZPOYKrdqSZaTAcVoGuBDdiCO51RgoqLayewhfDB
         MrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782320696; x=1782925496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xrFjH1dLnJGqAQgCyIJd/ck0yaqgBAkS8DGvIqjcyzI=;
        b=BqLkUxa1Zzc8foLvg5kJpMGZahx7kXOdGwxpYNi6j45G+2jvj7DF5kg3JEubMWp4mg
         dcC7JsRFaHIMI/21ujWeHg+pwWb5iIHyVadCNKpLURpQEiS+fOsEyjm3VF8Eq9kBTlrx
         BzzUFvgFYYntMFrQYhQtVnBVLK37wei+i2NkZmkL0ySYH8hRlUn0TL+Q0voW5IHyUc76
         /vttnLNBXFnElsb9Hz691lr92YvtFlGI0M0BNx+TfYI9gK7XLONcmTrt77etayv9Elz+
         JUc09jE2iVA+Nc/4gENzfN9p3vilejgCE5pvuhEJd/eopih7BCLJja0UnTejxSVdSzVE
         jrnw==
X-Forwarded-Encrypted: i=1; AFNElJ/Vv80xtNoQMxlkFdcUq57iQ93NY8zJ95VHFOVY7eWZbvED+NjiBoAAicPpp+5RIFnjktEwrNuVqs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpT4NytOGWnjlIqMxCi0NABQWKWNeOlXM8N4VBWLOG4xbH+xDC
	ICM+hUUsy5qoLpalWefLMiJj/6CgdPrezB2uroHdvY2VkNFzUKDga6Gt+JpBa9p/s8Y=
X-Gm-Gg: AfdE7cllaDdT99g28WKp/F9yOSHkhZ0/Aph/nDjdSYzFMkNYkB1M2AE3x02tRO3EW2r
	usq0GBNzKx/OjUaNCedDY2nddNACRkH+CRmQy+YjdPsFm2KjGhQ8mj49rAElv4ZQpC7wP8p3t1x
	fcRRvYRECWVbS6fMwHvIiXdMPstBmBhtc/Vk92f6iqKxkeH8SKrM5S5yQUsXBWTMCXThEltSyC+
	pZl8qnaM4QKvH2DDgl2+VbZCskHfae2Cnrw413aNgs62TbqRud1cAVrDhgeQkpy/2rqmaab+LL5
	z4VI2+mzFTbcAn3iyE9rEW6M+qTVWz8ReQmndp4Tq169rqz5yvnLrwfc7kLElUk3FQVFC7hGhoV
	7Rs1btmSsIeZdYACoUJZHW9ud2RhRHoAdbozVCli9hzaMrJJmVh3dKQWOYyQAQ+P+7toV4nGyTB
	vArOFj3cS8UuxWMlk1V9nkV1u//URd/5qpz/OkH+Ciom4jZTHw
X-Received: by 2002:a05:6830:4c01:b0:7e6:c819:22e9 with SMTP id 46e09a7af769-7e98688aac7mr3739758a34.17.1782320696225;
        Wed, 24 Jun 2026 10:04:56 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94429a031sm11959103a34.23.2026.06.24.10.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:04:55 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Daire Byrne <daire@dneg.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 3/3] SUNRPC: grant an idle flow a burst allowance on the high-priority queue
Date: Wed, 24 Jun 2026 13:04:50 -0400
Message-ID: <fdd0e8541cdf8a37cbb97e5c33730593a1649eb6.1782314746.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782314746.git.bcodding@hammerspace.com>
References: <cover.1782314746.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22805-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:daire@dneg.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:dkim,hammerspace.com:email,hammerspace.com:mid,hammerspace.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 718A86C03C1

Routing only the leading request of a flow to the high-priority queue
protects single, isolated round trips but not interactive work: one
client request -- a syscall, a page fault against an NFS-backed file --
fans out into many correlated RPCs.  With a budget of one, the first
jumps the queue and the rest fall to the bulk queue and finish at the
aggressor's rate, so the command completes no sooner than before.

Grant a transport a budget of SVC_XPRT_HI_BURST high-priority dispatches
when it becomes active after idling (xpt_nr_rqsts == 0 at enqueue),
spending one credit per dispatch and falling back to the bulk queue once
the budget is gone.  The whole burst a request fans out into is now
serviced ahead of backlogged flows, not just its leading edge.

The budget refills only on an idle-to-active transition, so a flow that
stays continuously backlogged spends its budget once and then lives in
the bulk queue: a client cannot hold the high-priority queue by keeping
its connections busy or by opening more of them.  xpt_hi_credit is
touched only under the XPT_BUSY serialisation in svc_xprt_enqueue, so it
needs no atomic or lock.

SVC_XPRT_HI_BURST is a fixed 64 for now -- generous enough to cover a
typical request's RPC fan-out, and cheap to over-provision since a
backlogged flow rides the high-priority queue for at most that many
dispatches per idle period.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 include/linux/sunrpc/svc_xprt.h |  1 +
 net/sunrpc/svc_xprt.c           | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index da2a2531e110..18b2c4237f1f 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -61,6 +61,7 @@ struct svc_xprt {
 	struct svc_serv		*xpt_server;	/* service for transport */
 	atomic_t    	    	xpt_reserved;	/* space on outq that is rsvd */
 	atomic_t		xpt_nr_rqsts;	/* Number of requests */
+	int			xpt_hi_credit;	/* high-priority dispatch budget */
 	struct mutex		xpt_mutex;	/* to serialize sending data */
 	spinlock_t		xpt_lock;	/* protects sk_deferred
 						 * and xpt_auth_cache */
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index ec4c05094e9a..6b0da45aede6 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -499,6 +499,10 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
 	return false;
 }
 
+/* High-priority dispatch budget granted to a flow when it becomes active
+ * after idling -- sized to cover an interactive request's burst of RPCs. */
+#define SVC_XPRT_HI_BURST	64
+
 /**
  * svc_xprt_enqueue - Queue a transport on an idle nfsd thread
  * @xprt: transport with data pending
@@ -523,10 +527,14 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 
 	percpu_counter_inc(&pool->sp_sockets_queued);
 	xprt->xpt_qtime = ktime_get();
-	if (atomic_read(&xprt->xpt_nr_rqsts))
-		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
-	else
+	if (atomic_read(&xprt->xpt_nr_rqsts) == 0)
+		xprt->xpt_hi_credit = SVC_XPRT_HI_BURST;
+	if (xprt->xpt_hi_credit > 0) {
+		xprt->xpt_hi_credit--;
 		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts_hi);
+	} else {
+		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
+	}
 
 	svc_pool_wake_idle_thread(pool);
 }
-- 
2.53.0


