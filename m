Return-Path: <linux-nfs+bounces-22832-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p/mmOeMZPWoSxAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22832-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 14:06:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F876C561B
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 14:06:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=Lv18f+7O;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22832-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22832-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6300D3031026
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0D3DCD80;
	Thu, 25 Jun 2026 12:05:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51053DEAD8
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 12:05:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389156; cv=none; b=PebwCIbqWCpO2bIq+2kh0xhqRHm9jlfFxuRjfJfbRD+LuNcE9PH1/PMinCT+BlDVHjX9ZfrPsolGMS6YzZgx7m3brcDUyC6R8OKLpNVVwgvtIWDeDMR7YzBwvyOl4Ftb9EJC0R6IdW4XRn7uRBCCzlx8ocGoC/K8PD+W4vagdZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389156; c=relaxed/simple;
	bh=VqrMWYKiVhdDc9+5byTwtPzGENXZ2aNbVXNgkhYYw5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZr7hbNqPkiK32WWHeUvqhaBVKAwGhjrr5Qg4ylpUGCGDz/r4ZRh6+QZ4cq3nMJ+nRKbSGCk4V4//xJYyEPlJW1YNrt2CMEXtj87VKI75p1xVID8vLSFRzM5F21Z4FV3yu4F2Md+Ie7il39O7qjBRorlWeEeFO0NHEF8qs4Rz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Lv18f+7O; arc=none smtp.client-ip=209.85.161.44
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69de16f5e80so1222587eaf.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782389154; x=1782993954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWNfbmVCfLWH94jhYkWf5LIaO9K0uM/VrfK+zELPPpE=;
        b=Lv18f+7OT2D+6ZbZzVigXsdBj4J/uuenVFhk64O9d7dhl3fTzEm1uniOYVkzd1WVlD
         v0zu4m6PPX1IKdxc26iVdY9sRnKREnEakZdeLGYFtNgBRlQgoVe9TVlVAf76MMU44HEu
         91RE4snCEUHIi6u+ThFAD22ch91FbFQ9OiwzkDyQtKpyC17rzfT+iHV67vml1B7yY0vx
         ULHQTjIA7OdjqrqHBsEGXqxXY7mTbRm6LRJfMwji33BautB9d4+AgqWLy+NMExMCDmKC
         ANJF8cxygmv+CGZzaR/vHdfwRmhiokT7yNV0Ptvz0FQs25YuEbz6lpiFedPc/hELaInh
         6ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389154; x=1782993954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mWNfbmVCfLWH94jhYkWf5LIaO9K0uM/VrfK+zELPPpE=;
        b=cq7ELYHYzkq5VMjsnmQphWPJpJGLVllQLBBLX6dqiYG6WSyJ9/NemhbYduppvfG1iN
         9/B2YFdb/Cwt0nm57nfMQSxF7/HEpVfqI1NwmqcG7wLd3BBJykLE0EltRXg8zlf4/4+1
         TIf9PURp6E/PQsL5vR4vV7roNBlWXbRYXaopvN5X9Kvfz9cSUqvQNP7TnhP0q3N/Pe/t
         AHPb+y8p5K0S/ZVH9Tt9I/rxOMPxAcF17R7HNu1M3XZoHeqN6VKKA4ql9G98DyB+yrE5
         d5YwG8IQiIC45ylaYDSl63JsA1KuIBeKaknwcFHucNT3PNY2jFMDPHjMWI0dAZKl5dRS
         vfvg==
X-Gm-Message-State: AOJu0YyNVp/wv4STArw3QpqgqFVGkK5XAM+PHQssYHL6UoDRia1S7GSm
	y5vPleePASjnIZd1hG+Qk48n8oiNP7nv3U9ng/BJTFBw00NGRVLXYLtCXc23qtMsubU=
X-Gm-Gg: AfdE7cmpFGcbXq2XfszPPxm71D6c6CaNJ2Jg/XU7o/xOxpMqo0BA432FpQVklk8iwP3
	RxcafVi/lJ9EO6KDQH0H6Jpt7DA09RjcrZmLZdC0plCAlxY6joNenBfeHd8N28CLnCkb1FTKfud
	4G9qGFU186AYQfPf4mOMahQZRq3vp+iRcDv60rRvDNAhrQVw0PR+40jm3Ry4BUXrQYUeX2OemrV
	5NYPjv9b45Ylir5i9GIkmVHhj0TzuxwvAg7yntKseo9zsmHIoJcfkY8HyFIJHfEpiAWrfhQXtKx
	DHG6X8v/mr0BHo8JEu+l8lMWnIk2NKukw3K6/MqLno8dFAVnURI28GP8NE0+B7v+kxXJgM5Nwvb
	2V4mTFY5zVxfuifl3TKrZROnq0QZbaV1rfw90iuV9sCvYHV1bd72yItp5N3Eb1dCEhTKwJnnxKN
	BAIVPLmJBfrWyUovtSCJD0TITIn0JZAHNf5DAbelHgNejikBDb
X-Received: by 2002:a05:6820:2107:b0:6a1:11fd:acbd with SMTP id 006d021491bc7-6a13521098bmr2017599eaf.27.1782389153575;
        Thu, 25 Jun 2026 05:05:53 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472e79af8fsm11123405fac.0.2026.06.25.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:05:53 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] pNFS: report clora_changed in the cb_layoutrecall_file tracepoint
Date: Thu, 25 Jun 2026 08:05:48 -0400
Message-ID: <803e9c53ad96cbfa54dc09ffe5a7a7c3630d9f4c.1782388900.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782388900.git.bcodding@hammerspace.com>
References: <cover.1782388900.git.bcodding@hammerspace.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22832-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:dkim,hammerspace.com:email,hammerspace.com:mid,hammerspace.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88F876C561B

A CB_LAYOUTRECALL carries the clora_changed flag (RFC 8881, Section
20.3.3), which tells the client whether the server is changing the
layout (and therefore whether the client should flush modified data to
the storage devices before returning, or stop writing to them and go
through the metadata server). The client decodes this into
cbl_layoutchanged, but it is otherwise invisible.

Give nfs4_cb_layoutrecall_file its own event definition and report
clora_changed, so the intent of a recall can be observed in a trace.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfs/callback_proc.c |  2 +-
 fs/nfs/nfs4trace.h     | 55 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 10f2354ba304..f5cf76d36367 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -317,7 +317,7 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 	nfs_iput_and_deactive(ino);
 out_noput:
 	trace_nfs4_cb_layoutrecall_file(clp, &args->cbl_fh, ino,
-			&args->cbl_stateid, -rv);
+			&args->cbl_stateid, args->cbl_layoutchanged, -rv);
 	return rv;
 }
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 1ed677810d9d..e679507eccb6 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1515,7 +1515,60 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 			), \
 			TP_ARGS(clp, fhandle, inode, stateid, error))
 DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_recall);
-DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_layoutrecall_file);
+
+TRACE_EVENT(nfs4_cb_layoutrecall_file,
+		TP_PROTO(
+			const struct nfs_client *clp,
+			const struct nfs_fh *fhandle,
+			const struct inode *inode,
+			const nfs4_stateid *stateid,
+			unsigned int changed,
+			int error
+		),
+
+		TP_ARGS(clp, fhandle, inode, stateid, changed, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__string(dstaddr, clp ? clp->cl_hostname : "unknown")
+			__field(int, stateid_seq)
+			__field(u32, stateid_hash)
+			__field(unsigned int, changed)
+		),
+
+		TP_fast_assign(
+			__entry->error = error < 0 ? -error : 0;
+			__entry->fhandle = nfs_fhandle_hash(fhandle);
+			if (!IS_ERR_OR_NULL(inode)) {
+				__entry->fileid = inode->i_ino;
+				__entry->dev = inode->i_sb->s_dev;
+			} else {
+				__entry->fileid = 0;
+				__entry->dev = 0;
+			}
+			__assign_str(dstaddr);
+			__entry->stateid_seq =
+				be32_to_cpu(stateid->seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(stateid);
+			__entry->changed = changed;
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"stateid=%d:0x%08x dstaddr=%s clora_changed=%u",
+			-__entry->error,
+			show_nfs4_status(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash,
+			__get_str(dstaddr), __entry->changed
+		)
+);
 
 #define show_stateid_type(type) \
 	__print_symbolic(type, \
-- 
2.53.0


