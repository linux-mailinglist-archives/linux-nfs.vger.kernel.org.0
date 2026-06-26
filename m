Return-Path: <linux-nfs+bounces-22856-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jWOdAQlhPmp9EwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22856-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 13:22:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FE6CC60F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 13:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="nCSmY/08";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22856-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22856-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DF55300BDA1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79523B71D3;
	Fri, 26 Jun 2026 11:18:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89030D411
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 11:18:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472738; cv=none; b=s9gFfgFWT34z71SUeqVkjUbkkGZWtOEqjiSMOpoH8nwCUa4Sd/9nXxHbvKBEwJOlBOp/wRlW7JnyGO4IXCVeVD67YgY/cBOv2G8+kxT07Y0X2KqdNYcqdl57jXmc1wunpYcLKGMnz816xdzocyvAk3GXSmPzN9VEsPH4k59Qca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472738; c=relaxed/simple;
	bh=j8tXvhVXl5VsjZ4EPOXEppaVIITYED/956UvnbMvBWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaH777398UCT5SA1hC7pSspVMjTc2deRGcrfZExybzfvenf5rolGVc8RjNBhUzKqZcuLa5LwG4YClbu+YhrZcI5FrodDjDIhp5E8lsS3gzUs43vok07iczyI+RgqUDkVP3SKclZNCI7bCwZ3vAg7LIlIZP4NzZ08lBbTx3TFBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCSmY/08; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9157ec935c5so128632985a.2
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 04:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782472736; x=1783077536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxJIvq+g7H6el8NcBfAoJLykiMZ4bnApj4YAS7qHipM=;
        b=nCSmY/08+O/ECzr9b4ieIyPUXNJIjP5IDNb1ayXy7D3/Y7ino17MctNdICYVqR74F9
         k+IKgsEML6qf/vr/DnBQQpeWdOiMHzOndKjCj2eqngSMSvfehOyk97Ij886EbON8Sjti
         ztibI5kmI4/aUToUXKLlGdFzCX/d3hkKM041IeEgbzKnyVXsDsVzWitVQoHqCMC0adl0
         dy8ehsGLlyO5yxdXkSrzVcZtwLU159NYV1TmfGgVNJGxkoD47EbqrHYs83T7tX1x0GLW
         n4J/qp/EGOSKvKg017ryjYaaaARhjN0QnpCZyNwFHQpxLyjWjtE1OEBRAkH8KBmQq57k
         +3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472736; x=1783077536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kxJIvq+g7H6el8NcBfAoJLykiMZ4bnApj4YAS7qHipM=;
        b=nS52GDkG/xvN9JYn9s008NBACnp/rBH7Z+c+UmRmKsLlegFa8Yhaz3fJVSRfa6aynC
         zJlWj/rGCyfjEjCO/keGFiaPTo4UTRJEmGVzIl7lUQzezVWdkw7RHekh5FPs6E61+iW4
         menKH8S//TVWneug15er0XG/+LHvu82QGKP9ubw88my2gMBi4COWdL47jd2qx8XpOpUi
         mRvW7XkpNZ+ehbX6iFQTNsCzzepPOfYwpivUYyKxzwyYJmBsqImT5SA160sVAmc+Ey9Y
         Hd9LX7421axSIBx5DdtKOJaa9I3Y0T3SCSjcvJaoHow1I/o3ymENb7W8UquboFE5XjKD
         C1vQ==
X-Forwarded-Encrypted: i=1; AFNElJ+x5B7d7IAL9EJKQAlTHyezlUASKqHQZbfKtSp7btaLdflHwq7lNOg8302/5o4bbhVtipWTq7LjPYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvCGHr96hg5bQxVOR3TonYG7q5BFK30/lL33zpmNvEwIuABHVk
	hf8YJDOpcP23fuG1PDdqzTKPUcINvmsxJHQZqLMH+eWJrwwZSUNNdulW
X-Gm-Gg: AfdE7ckjHUQtAWIUoNUHDmuDbXTTeoC6f6z0vI1Dx4HNZsFeUZAInmDEN6+ZzFS53GQ
	cmaM2ci9SDbt8KHI0x1dhAWuICvopzhFJ0NyPvtCV3A99xFINmwhil1q7ysTPfpgYD0FozleYsW
	EnrRQ8At5ZU9ZLwghVrHS5VpOLFow4XGcT51g+wxu90iWT52+12U3m78o13GsRYAmHF5aD8KuI0
	usaYnINrK1zJfsC/sWSdrmFDZN3vBdDSgHDflSq9ib4+Qln3jUndkd2d2atLjamemzRXEZ3nckE
	/vfQw5PZczezNmXHJQfdNl1x/a7pnMSZK+kWMK37lKrI3eGk85Bmt+mWzec7RBIaosX2kBTG9kk
	T1f87k7HPhduk2H8kB+52JGl1I4m68lj9gqE18hDj5528VwJp4/F9w95odapze93D+K0vm9e2wf
	GrMPeEB4rirhWcXc+lg9939Sssjp6JQAFHMcS/M9Ud3RgZfgihWm/nsaOvvZ+HR0OdwW9CEo2Uq
	ZcBfFpM477j0tCQoybsoAdZcQQWrRyD
X-Received: by 2002:a05:620a:1720:b0:915:9a1b:83df with SMTP id af79cd13be357-9293e6e089bmr949718185a.57.1782472736504;
        Fri, 26 Jun 2026 04:18:56 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c3257sm1154325385a.29.2026.06.26.04.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:18:55 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] NFSv4.1/pnfs: bound layout-type count in decode_pnfs_layout_types
Date: Fri, 26 Jun 2026 07:18:52 -0400
Message-ID: <20260626111853.801493-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622124836.1696330-1-michael.bommarito@gmail.com>
References: <20260622124836.1696330-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22856-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D5FE6CC60F

decode_pnfs_layout_types() reads a server-controlled u32 count and then
hand-decodes that many layout types, reserving 4 * count bytes:

	fsinfo->nlayouttypes = be32_to_cpup(p);
	...
	p = xdr_inline_decode(xdr, fsinfo->nlayouttypes * 4);

The multiplication is u32, so a count >= 0x40000000 wraps and
xdr_inline_decode() reserves too few bytes; the NFS_MAX_LAYOUT_TYPES cap
is applied only afterwards, so the subsequent reads run past the short
reservation.

This open-codes xdr_stream_decode_uint32_array(), which reads the count,
rejects a length that would overflow the size calculation, decodes the
array, zero-fills the remainder, and bounds the result against the
destination size. Use it. A server advertising more than
NFS_MAX_LAYOUT_TYPES stays non-fatal as before by treating -EMSGSIZE as
a cap.

A malicious NFSv4.1+ server returning a crafted FATTR4_FS_LAYOUT_TYPES
attribute triggers the original overflow on the client during FSINFO
decode.

Fixes: ca440c383a58 ("pnfs: add a new mechanism to select a layout driver according to an ordered list")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: use xdr_stream_decode_uint32_array() instead of an open-coded count
    read and manual bound, per Trond Myklebust's review of v1
    (https://lore.kernel.org/all/20260622124836.1696330-1-michael.bommarito@gmail.com/).
    v1 added a hand-rolled U32_MAX guard; the helper already does the
    overflow-safe count read, array decode, and destination bound.

Reproduced on a UML KASAN build: a crafted FATTR4_FS_LAYOUT_TYPES with
nlayouttypes=0x40000001 made the v1/original u32 multiply wrap and the
decode read past xdr->end (KASAN slab-out-of-bounds read). With this
patch xdr_stream_decode_uint32_array() rejects the length (-EBADMSG ->
-EIO) before any over-read; a valid small count still decodes, and a
count > NFS_MAX_LAYOUT_TYPES is capped as before. Before/after logs
available on request.

 fs/nfs/nfs4xdr.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c23c2eee1b5c4..4c1beef30522a 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4891,32 +4891,20 @@ static int decode_getfattr(struct xdr_stream *xdr, struct nfs_fattr *fattr,
 static int decode_pnfs_layout_types(struct xdr_stream *xdr,
 				    struct nfs_fsinfo *fsinfo)
 {
-	__be32 *p;
-	uint32_t i;
-
-	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p))
-		return -EIO;
-	fsinfo->nlayouttypes = be32_to_cpup(p);
-
-	/* pNFS is not supported by the underlying file system */
-	if (fsinfo->nlayouttypes == 0)
-		return 0;
-
-	/* Decode and set first layout type, move xdr->p past unused types */
-	p = xdr_inline_decode(xdr, fsinfo->nlayouttypes * 4);
-	if (unlikely(!p))
-		return -EIO;
+	ssize_t ret;
 
-	/* If we get too many, then just cap it at the max */
-	if (fsinfo->nlayouttypes > NFS_MAX_LAYOUT_TYPES) {
-		printk(KERN_INFO "NFS: %s: Warning: Too many (%u) pNFS layout types\n",
-			__func__, fsinfo->nlayouttypes);
+	ret = xdr_stream_decode_uint32_array(xdr, fsinfo->layouttype,
+					     NFS_MAX_LAYOUT_TYPES);
+	if (ret == -EMSGSIZE) {
+		/* Server listed more types than we support; keep the first
+		 * NFS_MAX_LAYOUT_TYPES, as before.
+		 */
 		fsinfo->nlayouttypes = NFS_MAX_LAYOUT_TYPES;
+		return 0;
 	}
-
-	for(i = 0; i < fsinfo->nlayouttypes; ++i)
-		fsinfo->layouttype[i] = be32_to_cpup(p++);
+	if (ret < 0)
+		return -EIO;
+	fsinfo->nlayouttypes = ret;
 	return 0;
 }
 

base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.53.0


