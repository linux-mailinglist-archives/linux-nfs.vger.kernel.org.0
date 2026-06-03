Return-Path: <linux-nfs+bounces-22239-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XDk8LSFIIGpf0AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22239-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:28:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3004F639301
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:28:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=cUv1qfRe;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22239-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22239-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896FA3215FA4
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE33A8FF6;
	Wed,  3 Jun 2026 15:09:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2AF3CD8C7
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 15:09:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499393; cv=none; b=KFw4SJh5u0RvhqBtsCXUGkYW3A2G6vktB4NZsdB3XrmHnzVXidT2sDvVgx3A3wCFmKuw1Fq/aEHa0e2xQsJHOeiB3AEEVd6k7XsUqV6PbG4LirlII4eGAYA425Cue4IjxnPRcB9rXNiwd4/puC0Vb5xTo7dSvARC26EUKqk0faU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499393; c=relaxed/simple;
	bh=Di2X3eCnm0TUFkLPZG5xZvyZHEJZIZMDUmWU53Aj5/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCnd5j7cN2MV7X4r8yUm3nuf111YrzmR3MPGwU61R+941cbVRj3n2RaT9Y+Lu6VfZXN9ddRYBS21NOYPF8IKSG3WWr29iazz9MM8vVffcTtjiycsSXj74eQ7Oy9vH/jSyGX0Y5YbiBwpZMzKowNe6dwrCbfKptRh6u1BPa7PbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cUv1qfRe; arc=none smtp.client-ip=209.85.160.50
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43b7e186a0cso3915669fac.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780499391; x=1781104191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ak18w+oJSVNcJ/GQ0eVatn/ZAfgMQz0FlNCgUmJJ6kQ=;
        b=cUv1qfReqNkphrO68HCi6jAZr1PZMdNDAUjIBKKcuZ+OEbIL1V+2XEktpRuUI6Ymk3
         1WBx3ktGKn36VG6DZr8gWV0EafPRuoWWAkqxYJmTboGcMCr0DogLVXeem/LfZ9FW7f84
         NSoKS+o2r46LbMXdgYJcD9cHY8apEgBpiqd+6UwN2Gjx/eQnRTRQYFM5fvwVcRRPlIZX
         lLnWtRzV/5Yzeb0tnT08WlGWHyH2M/YJMmvUC6OQ7PPQTM7Cs5FdTJ37ehIL9Scry4yX
         rx32ALJ9Qi7by7SML4FngbWm3DF7OrclJyhifBx6sIgqmlJHXJoub+OxBchTjF94Idjw
         gcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499391; x=1781104191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ak18w+oJSVNcJ/GQ0eVatn/ZAfgMQz0FlNCgUmJJ6kQ=;
        b=DONEt1b8i8q48JrNHEl0siVGLtIc1XYz5RgFT3LnrwfcOdZturBtoCrl5/eHhPQQrN
         +Q9B/Sy1nVmFdBZWj+u2/02f69b0dHkdvASU09ODr/Y2Q9tT4OAvN5jcsvz7wVGamFPb
         XigcIHT1e628dpep0FOw1ODQOAfgptl/OWKryEInZJNnMVvF5LUXtDujRChHxFKua44U
         RMpgEJL5FgmS1XtkPT1QKJSrI3OPCWpZ3fXIa/C5xFNAWKeon/XGuD1afj27BycydENC
         FwrxiqsmEyUa/Ih+1ldqUvesEICdrkLr/IG76kBGdLTOzjHbUzNNs1k67FHJIl3cOH8x
         klkg==
X-Gm-Message-State: AOJu0YyTGWceicQAA26ILkcJpWX1O8QYL//yNtmw4bDgYcw/9lQWrcne
	Tm75LAGBCgsZGT7fnW7LRkrLzXhHOnnPT5nvdz3YuMBIVPUqwCtay+SU9KBWYlXE9xE=
X-Gm-Gg: Acq92OFJrNE0hP98m5ZZSahAhn4ch5yAZib96Kmf/xJZxigKMtv2QpORUgCmRfllp/Z
	R4TyV/YJFKEbjUHWjeO6xbimMqUe/5/F4AbIOHqGNzK9LRBIYQ3j7fjM8EiTeI1rYtdBJ80EHaL
	OiFFubLU/E/0fnEeR6RBxL1j9gTJ6AQqmDlho05+YyeEqFoq2ngL5Mo902bIMeHC9RoucRVaN7V
	Naz7QzyFCGsFtAvwrYLPKGqdONhy7QbR328kzJk48rZ6Vqj3bpPgvsmcQLg0TmXaJxp92Es5qr1
	Jl+nd0JvNBfvxPJoHFJ3Q33jVkk+FIrAT8zdkd0qkdjqIod7GpLuuriWh0ALgShu706Vd3zas23
	Hv6IJU7UwOmvRkzTOYz+KKPwJkcRmbjqZ/MiFJFnpNpZdXD09alqenlGY9NLPGzXvVm8dP/DWrK
	/1mQTP6hdRzIujil31LP/EJ0tRJRSWVvioWmIH3dYC4+ZK1UsgDxveaoJRI6Sx2y35B08sPQ==
X-Received: by 2002:a05:6870:d152:b0:434:72:28b9 with SMTP id 586e51a60fabf-440db49632amr2404230fac.7.1780499390454;
        Wed, 03 Jun 2026 08:09:50 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d84c0ce2sm2917634fac.16.2026.06.03.08.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:09:49 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: linux-nfs@vger.kernel.org,
	Daire Byrne <daire@brahma.io>
Subject: [PATCH RFC 4/4] nfsd: key NFSv4.1 connections by clientid for fair queueing
Date: Wed,  3 Jun 2026 11:09:42 -0400
Message-ID: <5f3a6acbc4f5347ddc231d5ed33500128a85c547.1780498019.git.bcodding@hammerspace.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,m:linux-nfs@vger.kernel.org,m:daire@brahma.io,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22239-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3004F639301

An NFSv4.1 client may bind several connections to its session.  Stamp
each such transport's fairness key with a value derived from the clientid
in nfsd4_init_conn(), so that all of a client's connections share one key
and the fair-queue dispatcher schedules them as a single client rather
than per transport.  A multi-connection v4.1 client is thereby held to
the same per-client share as a single-connection client.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
---
 fs/nfsd/nfs4state.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5982fc9eb6b1..52bd9bc5cdbd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2351,11 +2351,28 @@ static int nfsd4_register_conn(struct nfsd4_conn *conn)
 	return register_xpt_user(conn->cn_xprt, &conn->cn_xpt_user);
 }
 
+/*
+ * Derive the transport fairness key from the v4.1 clientid, so that all of a
+ * client's connections (bound to its session) share one key and the sunrpc
+ * fair-queue dispatcher schedules them as a single client rather than per
+ * transport.  cl_boot is the server's boot time and is effectively always
+ * nonzero, so this overrides the source-address default that
+ * svc_xprt_fairq_key() would otherwise use.
+ */
+static unsigned long nfsd4_fairq_key(const clientid_t *clid)
+{
+	u64 id = ((u64)clid->cl_boot << 32) | clid->cl_id;
+
+	return (unsigned long)(id ^ (id >> 32));
+}
+
 static void nfsd4_init_conn(struct svc_rqst *rqstp, struct nfsd4_conn *conn, struct nfsd4_session *ses)
 {
 	int ret;
 
 	nfsd4_hash_conn(conn, ses);
+	conn->cn_xprt->xpt_fairq_key =
+		nfsd4_fairq_key(&ses->se_client->cl_clientid);
 	ret = nfsd4_register_conn(conn);
 	if (ret)
 		/* oops; xprt is already down: */
-- 
2.53.0


