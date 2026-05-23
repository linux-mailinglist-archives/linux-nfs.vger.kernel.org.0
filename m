Return-Path: <linux-nfs+bounces-21851-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCGbK6UFEWp+ggYAu9opvQ
	(envelope-from <linux-nfs+bounces-21851-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:40:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 858FA5BC5DE
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF08B300C02B
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 01:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB407282F2A;
	Sat, 23 May 2026 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCqx65r6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01421638D
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500443; cv=none; b=hpE9O5fv0KS/2DU/ZErCorLD4ek4i1lqCMLOfKXgmNm/jOL/aDjOTG+ZnHMCnDRDkaDRjGWRAKRIW8ABg3XjtQU6kpNo102n1g7unxGnDYfACIcj+PUh34AiDxLybWz0kGw1V+RNSnnodWfnZYLrCObEva4iVK2XsTS0dFC1OAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500443; c=relaxed/simple;
	bh=hnduPY82/gGMnSQk7PIZuYmtQRqZ9KgbG5y9Zo+wlAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJH5Fa79T0YaT42/uN7UIwxIYmhakW34uPZYOSwWlVuJlcQzSqsa1nFrHegGkoHNpy1eJugiQ/WXQaYLNQceFX0UAV2dKCL75koP5VlmFx/j5slWLWFVFfGAmfpi6W89gZZH6ad7ENPwQYHL87hEu+grHADcNl4BuKPNGHTvX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCqx65r6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50fb8e9a4edso93985041cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 18:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779500441; x=1780105241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6cmfWT4Yx0qceSMPkSgJjcCJUqUmrReUf7axDysEWM=;
        b=DCqx65r6vGsgdHDLDLDCz99TB0Y0m4QQfonN4pMO1+OVVQY8CZY4Vd2Ts86lyNJ7yo
         8RDm4FI2vnFEWM1mKf0cZMV8PNNtwxwRa647pOQ7uISsEEEsokDcjXlsxFpGvY+KVmqJ
         Q0BpC/0YVM5hzkCOEzBdPaH0neGnYW2QeaekwDrSqOWxLXzXhp6tWFbyaFTvMzxlUK1F
         zuY8DUSj4PWtTs9H2xKSYsjCKfuOo/bkkeN9C+Z/DHlTrdJ4h14fMGJMH151/ck/oamZ
         rHSsMzgskxJrRgoav0vNmIcv5tq64Q/fcx9qN8wHqUQsptTEbdwvtJckT4Lseqhhgv1U
         6N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779500441; x=1780105241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6cmfWT4Yx0qceSMPkSgJjcCJUqUmrReUf7axDysEWM=;
        b=eH2Jnv+BEqvHh9AxI0oBjAiq1gnc1ar11unWsRChb1UyM2SpZCg5onhje8AdltqvlD
         kAjiuCV2QdsD9VhpK2ACflRpB3jK+HLf2Q1h3VrMLt09gB5cbAXLHCNizfwUkndwMQqF
         SJ65poDLLKc/5Wn/pQYcewIcmwZKprq2NSE8DZcg5VBuEYrarvlbHHki8T1rOXybni1m
         yR2WJlFlQnQYfgJAQ5/hPEWj7IcqI11ARbawEq7mcpJeyVlZ5x0I99dWupTXMo7a506S
         ss1KlrDp3I7Ee8ddwURhINzeuTUmNHBCRvc6s9KWPA93uVgwGNfXWziAdlCP95/SVu3q
         lmeA==
X-Forwarded-Encrypted: i=1; AFNElJ/FBG+cxrS83abWyx+v4FoNceMJl0DBlZLJuYT2Izxy916fj1ZfNBpbRI5Ob/VcT4NQRj9DxUW4SO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQSy67lcSm9zT1aMD/dpBbvqggs5ZlVbzD+20UhigvoGc4xaum
	vgMVHdr4MYVOrdXR8skSBgFQynZSnm1JwpWru+NFpz4KVVXkp9dh1NaB
X-Gm-Gg: Acq92OFqyr/0NsSEhrenkwmxThSZuKQ00WIcONArZcQjKtiv859LabMn2OgYpxZESUS
	KcACZOWA/fHrRu8CYyTvh6HiO0+zvgsZDTWElzgRb9pYzkUKKeXtFoJaof5D8w/Mdh5SYv8gesa
	kJkp/Gb2PSr/E4N5tAvme3VipP8OOO/WatjoauDUmTC4QcfRrj8XwtP1w6v+KFwaF+hzYh+W6Tg
	o+qmd3kAe59AFGe/lLwVmHrLbVLYkXIJg6tkfuO9bAzbnluEgOScevZ2G74W7LmN6JaXjCojess
	tkgjVFem9JrVCyBPQlU0l1fntTJ9xeMCVMUUWHmMyA5lC8aaSZXWpmGCT6OJV5M9gWatpKCGSho
	SHi7KSsSgxBuDxzyWtSRw2ZBSX7DgNkcLCRMoYvIHyRNih8giYL7DN9HiGPePkPeXRn7EA8wJ4R
	ZvbTJnoHdKUaBJFFAuOEtpLADkG+h2H5jD41nM2zsXf7hHxYZ7NoqcglKdPJUilZphbPjd3B4jR
	E0HPQ1r62Z3LngNDsXCFiRnK1nXM9o=
X-Received: by 2002:a05:622a:94:b0:50f:be4f:465b with SMTP id d75a77b69052e-516d46455b3mr84987961cf.33.1779500441203;
        Fri, 22 May 2026 18:40:41 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b247c4sm28559031cf.7.2026.05.22.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:40:40 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Tom Haynes <Thomas.Haynes@primarydata.com>,
	Peng Tao <tao.peng@primarydata.com>,
	Kees Cook <kees@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] NFSv4/flexfile,filelayout: bound multipath DS count in GETDEVICEINFO
Date: Fri, 22 May 2026 21:40:33 -0400
Message-ID: <20260523014033.2459677-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523014033.2459677-1-michael.bommarito@gmail.com>
References: <20260523014033.2459677-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21851-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 858FA5BC5DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both the flexfile and the (legacy) file pNFS layout drivers decode a
multipath-DS count from a server-supplied GETDEVICEINFO body and then
iterate it via nfs4_decode_mp_ds_addr() without any upper bound. The
filelayout driver already caps the outer ds_num against
NFS4_PNFS_MAX_MULTI_CNT (== 256) but applies no equivalent cap to the
inner mp_count; the flexfile driver applies no cap on either.

In addition, both inner loops ignore a NULL return from
nfs4_decode_mp_ds_addr(), so once the on-wire data no longer matches
a valid netaddr4 encoding the loop is free to consume the trailing
bytes of the device_addr opaque as garbage netid + uaddr pairs. A
malicious or compromised pNFS metadata server can therefore drive
the inner loop indefinitely (up to 2^32 - 1 iterations) against a
fixed-size 56-byte body, with each iteration triggering an
allocation / kmemdup_nul cycle inside the decoder.

Promote NFS4_PNFS_MAX_MULTI_CNT from the filelayout private header to
include/linux/nfs4.h so both drivers (and any future pNFS layout
driver that decodes a multipath address list) bound the wire-level
field consistently. Apply the cap to the inner mp_count in both
drivers, matching the existing ds_num check, and bail on the first
NULL return so a server that lies about mp_count cannot quietly
extend the loop into the trailing layout-body bytes. This is
defense-in-depth on top of the companion patch which closes the
NULL-deref in nfs4_decode_mp_ds_addr(); either patch alone closes
the kernel-panic shape, both together close the latent
unbounded-decode class.

Cc: stable@vger.kernel.org
Fixes: 35124a0994fc ("Cleanup XDR parsing for LAYOUTGET, GETDEVICEINFO")
Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/nfs/filelayout/filelayout.h            |  2 +-
 fs/nfs/filelayout/filelayoutdev.c         |  7 +++++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 10 ++++++++--
 include/linux/nfs4.h                      |  3 +++
 4 files changed, 17 insertions(+), 5 deletions(-)

With this patch alone the crafted GETDEVICEINFO at multipath_count >= 3
is rejected at the bound check; malformed netaddr in the inner loop
bails on the first NULL return.  Either this patch or the companion
1/2 closes the panic; both together close the unbounded-decode class.

Baseline multipath_count = 1 mount + read completes normally.


diff --git a/fs/nfs/filelayout/filelayout.h b/fs/nfs/filelayout/filelayout.h
index c7bb5da93307d..03298f2e7cd69 100644
--- a/fs/nfs/filelayout/filelayout.h
+++ b/fs/nfs/filelayout/filelayout.h
@@ -39,7 +39,7 @@
  * RFC 5661 multipath_list4 structures.
  */
 #define NFS4_PNFS_MAX_STRIPE_CNT 4096
-#define NFS4_PNFS_MAX_MULTI_CNT  256 /* 256 fit into a u8 stripe_index */
+/* NFS4_PNFS_MAX_MULTI_CNT now in <linux/nfs4.h>; shared with flexfile. */
 
 enum stripetype4 {
 	STRIPE_SPARSE = 1,
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 7226989ee4d53..c58c786dcf011 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -159,10 +159,13 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			goto out_err_free_deviceid;
 
 		mp_count = be32_to_cpup(p); /* multipath count */
+		if (mp_count > NFS4_PNFS_MAX_MULTI_CNT)
+			goto out_err_free_deviceid;
 		for (j = 0; j < mp_count; j++) {
 			da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
-			if (da)
-				list_add_tail(&da->da_node, &dsaddrs);
+			if (!da)
+				break;
+			list_add_tail(&da->da_node, &dsaddrs);
 		}
 		if (list_empty(&dsaddrs)) {
 			dprintk("%s: no suitable DS addresses found\n",
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c40395ae08142..faed05cbe9f1c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -78,12 +78,18 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		goto out_err_drain_dsaddrs;
 	mp_count = be32_to_cpup(p);
 	dprintk("%s: multipath ds count %d\n", __func__, mp_count);
+	if (mp_count > NFS4_PNFS_MAX_MULTI_CNT) {
+		dprintk("%s: multipath count %u greater than supported maximum %d\n",
+			__func__, mp_count, NFS4_PNFS_MAX_MULTI_CNT);
+		goto out_err_drain_dsaddrs;
+	}
 
 	for (i = 0; i < mp_count; i++) {
 		/* multipath ds */
 		da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
-		if (da)
-			list_add_tail(&da->da_node, &dsaddrs);
+		if (!da)
+			break;
+		list_add_tail(&da->da_node, &dsaddrs);
 	}
 	if (list_empty(&dsaddrs)) {
 		dprintk("%s: no suitable DS addresses found\n",
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index d87be1f25273a..bfc30baa8159a 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -767,6 +767,9 @@ enum pnfs_block_extent_state {
 	PNFS_BLOCK_NONE_DATA		= 3,
 };
 
+/* Maximum NFSv4.1 pNFS multipath data-server address count */
+#define NFS4_PNFS_MAX_MULTI_CNT		256
+
 /* on the wire size of a block layout extent */
 #define PNFS_BLOCK_EXTENT_SIZE \
 	(7 * sizeof(__be32) + NFS4_DEVICEID4_SIZE)
-- 
2.53.0


