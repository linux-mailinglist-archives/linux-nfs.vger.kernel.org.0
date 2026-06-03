Return-Path: <linux-nfs+bounces-22236-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WwzeNUtPIGog0wAAu9opvQ
	(envelope-from <linux-nfs+bounces-22236-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:59:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5026397DC
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:59:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=lH9Lu454;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22236-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22236-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B00A43152A49
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA013B38AC;
	Wed,  3 Jun 2026 15:09:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30B3A9DA4
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 15:09:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499389; cv=none; b=lrLmDEpZYpVAe1yiFZDsZbn2jwQhmyc45vzsF4cGxVBgqU6RdERCnoq5h6KRXp3JQAYFJ5Rm4Wb+4NLMlINbWl3McyunLpImzZw9t+hNWNUalSqZX8uYCQu460JBZgzNnjQ7aI0Vu4uwIYOmiW+gWlPGb3lvuDaDJ+hTdkwIOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499389; c=relaxed/simple;
	bh=uM2ODqi6tHc4GyL6VBA2m8DjoNpwKtr8gV7lXmy5v8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4cznL3vFo03L8T7Xc3G9uKwhcn+4D0xxrI4AjqiwCSa/uBvUczFXlnlZM8GQwTI76psLb4yEwiJ4GDMarAX2Iv1wipUQ8HYD0LkJHor6bCL2BR0dC4khoegowFgEzbvm5Dh59MnGFHe1g0yKPOpsdwPgafbttULAg6qeSCFPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=lH9Lu454; arc=none smtp.client-ip=209.85.167.169
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-486621f0adbso489645b6e.2
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780499386; x=1781104186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eruePonWmIta7xChb/NftJ39yVl7K4oH6624VUSCPzo=;
        b=lH9Lu454hv+I/qlSsz5kmja+DaP7qL1k0WTk3npjrxTY0WfN8Rq6W8Jql+PvX1QcXC
         uf8aL7qFu3xyK2yJAO2EQr/HgULDkMQWfCzmDM4jNWn1gsS9WfofB6Xhlvf/uq7OVorp
         PLKpby0pyT3GsUlea0pAONL8jPikAEopEVygF5PZtDJSQS2T+pdVgVz9pPER4DvFffvq
         qZv7DXqwAGMrSuXSi5wJqSmTtPucs5Dvag/KjGgRcNCHQn/lrRLKiLs6wCGPgyVA2dQA
         kqnLsjl6WduXlS4cmQjypGpw8XTQ5n2LxX9sCcAD8eiqfaB7LBUDFprUuyNEcLLwMPed
         FY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499386; x=1781104186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eruePonWmIta7xChb/NftJ39yVl7K4oH6624VUSCPzo=;
        b=BCRATPCBMAxkB2bFXmjgKWPO//AgTuxtr3zg6oZH4qqZCDuRwpzztwSkCOpgk2a+4b
         9xDmMJYVfnhUzDaE3Yikh6YNjARgzol2ijbHFZfkWgUPFIFjiwoH6SlS3255ykXMjFhS
         iU4AGQnZ0Cebpx+dHZEqMiU2YkKlRdtMiUcWTmZEeYKtAJQyglWLPnR6uOBuwetKMObs
         iCBOzEdjSurqTS3I3ZkFKRLdFBDDPVnq0SKqkBilsyVoTjsgQc1RwHxn8ADVG9Xdk6fU
         Sda8gqEW0Det+NqNAdH6ep/yH3rOEreZVH58ZzgFvBbLPYKda7j1kgXxw4EIymlsIlBW
         E3sg==
X-Gm-Message-State: AOJu0YzSRwRxAWwRaJdErm1OoYSKGVeySrje6mTT8pazswJ5d8B2sSHb
	qLuFPOPoVIEuhPtzzEhRmB8B77ARprt3xO9z4jSB0K5hJcCxjqVzyJ+E+jwFpdi8PxZToml//Hh
	pQLRS
X-Gm-Gg: Acq92OH1ZZGzO+j8ap51n624T7YvHZ9HsEI2xQP99hRA/UlKQByTyLq6ZrICDyY2Wb9
	6OQWIIeQlegmz34Aq9TiQ+52kGiZTVQSuULctqhLgAlBLlXDkqtX0d+NHwHdm/2GatxzDByc9WB
	1XX6YHswqbHWvTW5UOdj6BNqe+Uf7MyDo2XKq0FEi4F87YriaLyj5SgT8Tlt4d8kZzk8slzNF9A
	tdi4sVVq2jpgWOe1p9oxUeT6mxXHTgzyxgGge+Dq66pe2I4oB3EeHKM9lJMHvP8Hpn8NX23iiki
	viXPBo5NT/tYe0+BeE3ljQL/ilRhGvBWkoi2QBF7I4qkm61k7nMXXaeBaLi3sVpY+0tUzuufqS2
	SLp/ZGZSBCxpcMWfnNvECABSTpk3Imz0MXqCpr2VLRxVUYNrRQYtmOYrzy+ieRkpo5elLonUQkc
	Xdd345VPFlDGo/v4L+a/3NzPtK2xLCsJPMvX5fVrF8j60lNpl8aAOMxyu+uLArNEC9i3TkXA==
X-Received: by 2002:a05:6808:1b0a:b0:486:4892:d568 with SMTP id 5614622812f47-4865ac5063fmr2145180b6e.39.1780499386464;
        Wed, 03 Jun 2026 08:09:46 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d84c0ce2sm2917634fac.16.2026.06.03.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:09:45 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: linux-nfs@vger.kernel.org,
	Daire Byrne <daire@brahma.io>
Subject: [PATCH RFC 1/4] sunrpc: add a per-transport fairness key to svc_xprt
Date: Wed,  3 Jun 2026 11:09:39 -0400
Message-ID: <bd45e015132b2d8beaeb0e4013d0bc4e5061932b.1780498019.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780498019.git.bcodding@hammerspace.com>
References: <cover.1780498019.git.bcodding@hammerspace.com>
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
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,m:linux-nfs@vger.kernel.org,m:daire@brahma.io,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22236-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:from_mime,hammerspace.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,anthropic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB5026397DC

The server dispatches ready transports from a single per-pool FIFO
(svc_pool.sp_xprts), so a client's share of the service threads scales
with the number of connections it holds: a client with K connections is
served roughly K times as often as a single-connection client.  The unit
of fairness is the transport, not the client.

As the first step toward per-client fair queueing, give every transport
an opaque fairness key.  sunrpc supplies a default derived from the
peer's source address; the source port is deliberately excluded so that
a client's several connections (nconnect, or a fan of data movers) share
one key.  An upper layer that knows a better identity may overwrite
xpt_fairq_key, and a nonzero value takes precedence over the default.

Also union a list_head (xpt_fairq) over xpt_ready for linking a transport
into a fair-queue bucket; a transport is only ever on one of the two
ready structures.  Nothing uses either yet, so there is no functional
change.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
---
 include/linux/sunrpc/svc_xprt.h | 46 ++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index da2a2531e110..67d0c5d9b92c 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -55,7 +55,13 @@ struct svc_xprt {
 	struct kref		xpt_ref;
 	ktime_t			xpt_qtime;
 	struct list_head	xpt_list;
-	struct lwq_node		xpt_ready;
+	union {
+		struct lwq_node		xpt_ready;	/* lockless FIFO (default) */
+		struct list_head	xpt_fairq;	/* fair-queue bucket link */
+	};
+	unsigned long		xpt_fairq_key;	/* opaque per-client fairness
+						 * identity; 0 => derive from
+						 * source address (xpt_remote) */
 	unsigned long		xpt_flags;
 
 	struct svc_serv		*xpt_server;	/* service for transport */
@@ -157,6 +163,44 @@ static inline bool svc_xprt_is_dead(const struct svc_xprt *xprt)
 		(test_bit(XPT_CLOSE, &xprt->xpt_flags) != 0);
 }
 
+/*
+ * Per-transport fairness key.  The fair-queue dispatcher groups ready
+ * transports by this key and round-robins across keys, so that service is
+ * shared per client rather than per transport.
+ *
+ * sunrpc supplies a default derived from the peer's source *address*; the
+ * source port is deliberately excluded so that a client's several connections
+ * (e.g. nconnect, or a fan of data movers) share a single key.  An upper layer
+ * that knows a better identity -- e.g. nfsd stamping an NFSv4.1 clientid in
+ * nfsd4_init_conn() -- may set xpt_fairq_key directly; a nonzero value
+ * overrides the default.
+ */
+static inline unsigned long svc_xprt_fairq_default_key(const struct svc_xprt *xprt)
+{
+	const struct sockaddr *sa = (const struct sockaddr *)&xprt->xpt_remote;
+
+	switch (sa->sa_family) {
+	case AF_INET:
+		return (unsigned long)
+			((const struct sockaddr_in *)sa)->sin_addr.s_addr;
+	case AF_INET6: {
+		const struct in6_addr *a =
+			&((const struct sockaddr_in6 *)sa)->sin6_addr;
+
+		return (unsigned long)(a->s6_addr32[0] ^ a->s6_addr32[1] ^
+				       a->s6_addr32[2] ^ a->s6_addr32[3]);
+	}
+	default:
+		return (unsigned long)sa->sa_family;
+	}
+}
+
+static inline unsigned long svc_xprt_fairq_key(const struct svc_xprt *xprt)
+{
+	return xprt->xpt_fairq_key ? xprt->xpt_fairq_key
+				   : svc_xprt_fairq_default_key(xprt);
+}
+
 int	svc_reg_xprt_class(struct svc_xprt_class *);
 void	svc_unreg_xprt_class(struct svc_xprt_class *);
 void	svc_xprt_init(struct net *, struct svc_xprt_class *, struct svc_xprt *,
-- 
2.53.0


