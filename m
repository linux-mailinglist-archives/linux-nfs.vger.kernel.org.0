Return-Path: <linux-nfs+bounces-22818-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2bZ5CC01PGodlQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22818-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:51:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0BD6C11A7
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:51:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=OW2v6rMj;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22818-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22818-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96CE43037E4F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0745C305E28;
	Wed, 24 Jun 2026 19:51:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB563BBFBF
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 19:51:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330663; cv=none; b=FZOz741sGbCb6GplkA8eWznUpF+nT2BUaoL5d1wkbHfGpcdQCNz2Nc3yi62Ai83cRD272+DP7F2pqOZALwClCZ5WUVdXLewtWKmp309rnlVRCaP2vQsegOEaEe5SvYuGloC0l8tEdZUspFzBNpjXscyYcJjC3GxK1Yx273pEn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330663; c=relaxed/simple;
	bh=zKslC9PnXc9psUsPuxLg9uipEBgcly5LZ1/gvbty7yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhN4wssqAUQvNAiO4SakTd9zRHeQSgJ7czXaEtpFvMDfnhQHJtmmZbl1sFgljslSpgetE0415LSJOcRC706OzVOQTeh3klCFZ/DLgJN0deQMjHl07I282KFAvhcUGmAM5mXH4WCmkutVNaSZLNO0OKXDriIZ039rhhhxjAM2X8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OW2v6rMj; arc=none smtp.client-ip=209.85.160.41
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-447e3abe5edso168611fac.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 12:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782330661; x=1782935461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ystvzER4aSuufLJVMaIOUIeP6KZStAF+Zt5X4NLj5Ak=;
        b=OW2v6rMjizsc2tiIKOsb6GvBDfSeBzYYzbBKNFHRJsBAmPKT9JCnPUazsojMQrutDN
         HNh2cRQu89it0TNhl3DksMsHUI4PzyXAUkP2bUXV6/QgsldQ7QOz/6HrmAfeq/8joDIj
         hoi5Er1f/iAT1qUTEQn8IUBZ4z0p17JCg7/w7jVvDAWrMEIiFLW9XONlWpl6qcFDpWoe
         QBOr/whes0pUwLZ2j0e2MXDiq7v7Op5KkrhZJRhbLifdyRpP7wQFsEDgZbEReqE1PeEp
         7bU/2aA8iirONUeWZ5GiJNviaZcALQ6N8uuUbFtkvwK5xSvD+XTXSIsOLKtzuixlP4Ii
         t7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330661; x=1782935461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ystvzER4aSuufLJVMaIOUIeP6KZStAF+Zt5X4NLj5Ak=;
        b=fJE1cvo8/dsRmqQRYjsIP1lQLovt6U6mBDHKhTTsyj268cD8afcsw+bH80DV1/zZvW
         ypiojg9CEQUWshGPc4pKDmq7PLTh7ehZTFGv2ivx5SUURQFBpT9Owv0MJ5f4A1GlIySe
         FiYPC9XP7DpBG+oPzeJKD4+eDqKcK95vvaTCwiFugU1k/AojN3miIJXlXPurn3ZaG4Fy
         LfeYQUooqbB3QLO05TS6/Y/QIly3a2mzWfHTckDy1hJ5OZIyYVIf6OCgeHwNZ8M7POOb
         22+omDIpxIGvbG0IlpHqzlRXEVPWhbQ3FlsolGeQktMOQ9GPtFPxymQlzW0PukhN/kXy
         bYIA==
X-Gm-Message-State: AOJu0YxXtCAnyitUXqbnCTu8n/NzV7jdSUNnBRaxbt5p7qiT8/jK+hNJ
	dPfI83Bh4Eh8PNYDP+7TLmkJAwmzrJdJhnyEQqDkDqAT+Kxfw9piWRjYGNSiQWYA4bA=
X-Gm-Gg: AfdE7ckdPGvUppjiT4cWDIF02p7ixpTwR90dHKIPAf19rabMF2g0fTeNqdmTroWegZq
	NWmeQ+WcKF1WiaOg8GLe/Ugo4n4YHjiNF7pv2Wq1MBf07O0w0gHXCaU2suKP0QEyb1JFL5/6inn
	pyTEejDTEq9j6ks4FUC+D3Ky3u1g6WSh4w3n2WTO4PvET/B9PGodobmfNfVEJTTjrDS+N6mzzun
	4n0sICmFfwaIrG2AUVVpKh2tdJpcbpmznfSAPJdRE3ak5Hhng9RW/clH9B7hTHk7FLMcSrWixzH
	/bGIvEMQAPfvqTUwEfWcnAYAMBaik6+dhpvxI8lNmXLjnyrqi6XZ7zhRMMu9D1j+XXGrb9on6mS
	SjVKDD34u2GghzLcqZtpupuIx2kFCsi+YXEaLmNh11Vt+zo0I0gleYdMCvh/27nItP4ul7gAaJl
	TiYt8kR2ObSC4Ye2h677zYEDNMkHr4SJZgMPSCKYADAgTw9qtB
X-Received: by 2002:a05:6820:1693:b0:69e:f950:294b with SMTP id 006d021491bc7-6a12d890d44mr981626eaf.24.1782330661394;
        Wed, 24 Jun 2026 12:51:01 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a11e6ef161sm2902890eaf.5.2026.06.24.12.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:51:01 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] pNFS: report clora_changed in the cb_layoutrecall_file tracepoint
Date: Wed, 24 Jun 2026 15:50:56 -0400
Message-ID: <fd8dbaed67881b7813ab9e77bbacc71a30d6de4b.1782329389.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782329389.git.bcodding@hammerspace.com>
References: <cover.1782329389.git.bcodding@hammerspace.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22818-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hammerspace.com:dkim,hammerspace.com:email,hammerspace.com:mid,hammerspace.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C0BD6C11A7

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
index 4ea9221ded42..021572312b0e 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -316,7 +316,7 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 	nfs_iput_and_deactive(ino);
 out_noput:
 	trace_nfs4_cb_layoutrecall_file(clp, &args->cbl_fh, ino,
-			&args->cbl_stateid, -rv);
+			&args->cbl_stateid, args->cbl_layoutchanged, -rv);
 	return rv;
 }
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index c939533b9881..18a5708c17fc 100644
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
+				__entry->fileid = NFS_FILEID(inode);
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


