Return-Path: <linux-nfs+bounces-22803-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4l+KDz0OPGpxjQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22803-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:05:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BBE6C0375
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:05:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=J5bDe0R3;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22803-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22803-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B63393008C00
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE335379C26;
	Wed, 24 Jun 2026 17:04:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6DC34FF74
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 17:04:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320697; cv=none; b=Kpx9DyinfHbPIm6WaxzHvavG7A4WCqBUsqRO8P9kSRSMCFGYs2hfzzDUzXYzMvHlv1h3xsG0qK7uikURJ036UsfOXAuxQWXRu+8Z6aSVOxOjAKcRmcnW810DKOnWRxdpmF672DaM8M1/bXdmi9kuAjgk4HOG1v+/qsGuwVr7uSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320697; c=relaxed/simple;
	bh=vZ7ROum0M1dKwzrf/taFJVg0dVFMSoG6dBz1JGME89c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBGoMAGtoI7sNi47R5y2qA2uTONsR7UWTpBCrfVtxZN+cr+SCWFikoZPAe8gTQCa8pKW5fpnSA5E3tWcVf5CSOOdZvaPE7eucQNtTaPEE41rgbobnHK4z4Tdw2aGGXiTnpH0JdTberkFqjb0rMpAJXugIROrFY6/+krnPhniA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=J5bDe0R3; arc=none smtp.client-ip=209.85.210.53
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6da33a561so823989a34.3
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782320694; x=1782925494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8yMOfJa8ZVvwaLMlWF/HT3f/iETJCgel2tSGUPG4uw=;
        b=J5bDe0R3o6cqa/mBywL2/0ooR7bZMNulwMPXPwDwnFxWQZBkfTjqUX5A+lAwyamiLg
         +3cmaVO0lcM6Xr8U9Dit3Snmgrd1hXmI9g0CqHgula8ZPOhlv6WkubUYaNEBUM4s2jQT
         2o074a2wUS7bkC1d3Noj1ay2Ux+feMyC71hQlsevqhBBITvaPueutdzXOTqQga2wiZ9y
         YfuL06DPZWEjVs0n78DTIp++6lLksNhQwYzeT/xTVTcBkj1F5Spn98GrF9OBNtXBf57v
         y094WUBwMZ7Dyx8nDvB0UV3qAXsn4UeF4DVkTzPeTUa7icToQU0pJA39Ias41+OUXuyx
         MQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782320694; x=1782925494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8yMOfJa8ZVvwaLMlWF/HT3f/iETJCgel2tSGUPG4uw=;
        b=oK3iIhG+n960kwtFHVcuXcFIpwd0rn6jiM1MArWTvtAlk/zSw6qrhSUKOlOGJyJM33
         zVH/ZivOGFfqQJ6BHqEuHbTqH08viH2kwAMkyO1Ae5SaFdE3TBWreEcmYNLSZGqnoNS2
         hrdcMx2mU58gjnKz9asXZdwbfRvYGnzK9TPSgSbsGEQH8t+K+cHFfk9W/YwPBnH72+v0
         XeJ/ubs0ERguTxyfH1WBudbb69Xxfi5CcrOu+QEeLENR2k48TwLCNzkenO4IdcPI0ZC5
         A8pQ1n2EIc5EZbFjKzSx2iksJaMKZ51UWHPg0Ee8bW8EZVMx6cOADUXgwll4mZIMYR8u
         qD5g==
X-Forwarded-Encrypted: i=1; AFNElJ88qcmZ6ZkSGfPjmQc/4J497Tiwzg5bdnIqqXUW8zOFQNvv/uh5vb1qii5UE46WTLacrj4wIcOq9Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhgzp/SXmgNggoEUm4LICk8c5WKpCHFYxGKKNU9SukeZmPqTe8
	YqG7zd5C0ADun03AOuYu9rlgELjWHeO0Etm0icu92+VFtTGeFD05yHhKeTObrKbIP9w=
X-Gm-Gg: AfdE7cly1EZsS7xmX7EEreQ8bN6etRujXjNCqHgojbW7KN9lY8O72F6LE5Pawptd79s
	qybaExM89opYMa3/j1E8VaKwv69u850RxK+BO4lveBnvc8W3WoplyZDWUzwbK3GpZdFoUY5nc0U
	Wqwd3vJJtfck/uycckaqrJ0X1CguQzrGbpJ+irl+2x57Nj5qhBFse32C+AMi/GuUDtIhm3j9bYQ
	V3g+LToSWVkf3MlcgYawrKNBKDSQeirOhCloZx58rL7O6d2ATL9aR1V6P8SrvmoEG0RJ6t47mPi
	blbmAKAayB1uq2+dEsHPPJTJQXk+poUuhgE2zkgilFSFZ63dmjteOQUjgca72g7kkGbesAOrzBr
	gvgExFRpq3THUH8JxAVpEZtgleTjWss5e4hup16gDfBDPuA8wkkQnUXPLDHmhFOWBcx4H/QVAuO
	U9pTCEhhdI+O/GYqT5/kSLN1mJ29WscOnE/Tm6TmbE9Tod9+4y
X-Received: by 2002:a05:6830:43a9:b0:7e6:fdea:7ab1 with SMTP id 46e09a7af769-7e9869ec820mr3309935a34.8.1782320693807;
        Wed, 24 Jun 2026 10:04:53 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94429a031sm11959103a34.23.2026.06.24.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:04:53 -0700 (PDT)
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
Subject: [PATCH RFC 1/3] SUNRPC: add a second per-pool ready queue for high-priority transports
Date: Wed, 24 Jun 2026 13:04:48 -0400
Message-ID: <335f2842438344832fb46b2822a6c831119bec0a.1782314746.git.bcodding@hammerspace.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22803-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hammerspace.com:dkim,hammerspace.com:email,hammerspace.com:mid,hammerspace.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49BBE6C0375

A pool's ready transports are tracked in a single lockless queue,
sp_xprts, and dispatched in FIFO order.  A transport's position in that
queue is independent of how much work it already has in flight, so a
connection that keeps many requests pending is serviced on equal terms
with one that has been idle -- the idle flow's next request waits behind
the busy flow's backlog.

Add a second queue, sp_xprts_hi, alongside sp_xprts and initialise it
with each pool.  Nothing is enqueued to it yet, so this is no functional
change; a later patch routes transports with no requests in flight onto
it and drains it ahead of sp_xprts, giving an idle flow's request a
latency floor that a backlogged flow cannot push it below.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 include/linux/sunrpc/svc.h | 1 +
 net/sunrpc/svc.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 3a0152d926fb..89fa90f6d360 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -39,6 +39,7 @@ struct svc_pool {
 	unsigned int		sp_nrthrmin;	/* Min number of threads to run per pool */
 	unsigned int		sp_nrthrmax;	/* Max requested number of threads in pool */
 	struct lwq		sp_xprts;	/* pending transports */
+	struct lwq		sp_xprts_hi;	/* high-priority pending transports */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index dd80a2eaaa74..7ead2db314c7 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -566,6 +566,7 @@ __svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stats,
 
 		pool->sp_id = i;
 		lwq_init(&pool->sp_xprts);
+		lwq_init(&pool->sp_xprts_hi);
 		INIT_LIST_HEAD(&pool->sp_all_threads);
 		init_llist_head(&pool->sp_idle_threads);
 
-- 
2.53.0


