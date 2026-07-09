Return-Path: <linux-nfs+bounces-23205-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mSQOBw7uT2oqqgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23205-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:53:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A470F7348F9
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:53:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="OBzdGi/U";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23205-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23205-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6A64307F341
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB63B8D40;
	Thu,  9 Jul 2026 18:47:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5A3B42CE;
	Thu,  9 Jul 2026 18:47:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622875; cv=none; b=NH+eSx6/QLanWgLjq/W1Pa/BXYTVK3E0NBBUFjNXHJRDWPaU4lxSDdSOdIjmST7Y7CeKNp0voLm859URwJ1DD7FLLbxve+bnuAutu94Ba4tOQewMtPlljrNy1CqtjrcDWbLFeC0ppcvCb0Tt9NE3OBFcxp9jr3y/CJC6XufygBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622875; c=relaxed/simple;
	bh=Sz2LMgcQvHwgc5A6WpVLpFF7304tQx5qcH4SiERKf9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5dE6U+AyFjILyxvVCDyP315HG+FINWu5GmKkg4sgDk5qDaX3X4Bbfb7L1Dp+naGujTo4oyvGmTaylDDPewdb2xODA31zBEqgaJq5U1wKWRvCZnRob/aW0ihWGZbGFtXh6Enkz7Ae/JO24GR7QrGps59NzPZEGAtZTPACO20vyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBzdGi/U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEFD1F000E9;
	Thu,  9 Jul 2026 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622874;
	bh=82/w5SBRaBkM2WwnNYQrjw8sXLjbyUS55lx23z+zi6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OBzdGi/UvlvWy/XC25dlTql5oLdxfWmXUEbXOQnrEptobUd7y3WBCyLpq3FkziWi8
	 jic7NQ1bpSmIO3NepRUJEk+omVckn0lvgCRaVoB/V78Iu8fdmU+PqhLwro0G8ZSIS0
	 x8JTq5OEaATVjCOSYJ5neqvUbnrll+XJHHWVjxCoHmdhebDSLb55U6kgm9Nimo7hcv
	 /b4Dw2DgcX89zQ4KWRCF/svlvwqre3NqsK6e8uP1TwyaoFZVHzWxYYzi8wdSkUjyqx
	 +low9ql3Rha5ZZ27AcX+ienkEUtzFFCXE3sqk6cweF9bvwOrEBTffkeWiblzqs6oaI
	 VPj7cxaBIpPnQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 14:47:40 -0400
Subject: [PATCH v2 03/10] nfsd: fix stale s2s_cp_stateids IDR entry for
 async COPY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nfsd-testing-v2-3-0a1ba233bf87@kernel.org>
References: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
In-Reply-To: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Sz2LMgcQvHwgc5A6WpVLpFF7304tQx5qcH4SiERKf9U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT+zUi6fIz2nr+XsZOi7bWTkGQOWAiUmLc8qwP
 11sCviKP0+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/s1AAKCRAADmhBGVaC
 FVtTD/9sUBXHSbz0HVAYBtj0C6rv1+w5l4Qik6fxuVI0vZOsT/jt+sM7HTdMZ9oa6ZSh0GL0lIu
 EnXL/I8NLERAb5stbbGRNSIlxojkMhBoqtinftcFatVvKmI1+qC34eOZrZeOd/1h8kM+ILauGTW
 /h0463/KVDmNRE+fGVqIUhrrV1LQ+IXGXzzZrQ+OiEqinJz4dy0fs7lsruZGjKPuZYN81qDTUDt
 3JbOCK4u9qTxvkkl2rSuydQcEPQM8GCYMGElD74cIA8/sqtx3MRYL/hHXOroWg73VPVcpIgDOI5
 hjbl0PDjhrYhG9/dziJGvK6FqkQ3nIgUvRNmSdQf5IZojZo0pZ6WSJ9LxuFB05c+7pQLOlGKDHO
 oMACWzYJL6ECwGzDKNF50ENerBNtqk6LpUVZCn1yxLPySNOY5jA/e6IcEsY4bxP3stGdnLQw3nc
 hOHnS64YixHhjxx50FeuXq8Agp2nrlaumbt7l1WjMUWUuqG7bhO36aUZTRMY6QxDXGTkoxyc60T
 yrrH+HVj6dY71BypU9kk7SjUHDAl8QiW0bjul0DZq2MXbQCRj4339X3jFSottxtZU6MiZvRShFB
 /snwlmgO6QE4zB4XzjVvXN86Eu3gswqIxffstKHMR7kJW5SDG1W9+dSXvvUC4aYEjOAxrCuR5JC
 s9SHnX6FAtTKgag==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23205-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A470F7348F9

For an async COPY, nfsd4_copy() called nfs4_init_copy_state() before
dup_copy_fields(), so the s2s_cp_stateids IDR was pointed at
&u->copy->cp_stateid -- memory in the per-rqstp COMPOUND buffer that is
reused by the next request. dup_copy_fields() copies only the value into
async_copy, so the IDR slot dangled at the transient buffer for the whole
background copy. Any IDR walker then dereferences reused request memory:
the laundromat reads cs_type from it and, if the bytes look like an
expired NFS4_COPYNOTIFY_STID, follows into
refcount_dec()/idr_remove()/kfree() on garbage; manage_cpntf_state() has
the same exposure via idr_find().

Duplicate the fields first, then register the stateid on the stable
async_copy. result->cb_stateid is unchanged.

Fixes: e0639dc5805a ("NFSD introduce async copy feature")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index fad01d67bf3f..1c674479d4ca 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2272,11 +2272,21 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy->cp_src = kmalloc_obj(*async_copy->cp_src);
 		if (!async_copy->cp_src)
 			goto out_dec_async_copy_err;
-		if (!nfs4_init_copy_state(nn, copy))
+		dup_copy_fields(copy, async_copy);
+		/*
+		 * Register the copy stateid on the long-lived async_copy
+		 * rather than on the transient COMPOUND argument buffer
+		 * (&u->copy). nfs4_init_copy_state() installs a pointer to
+		 * the copy_stateid_t in nn->s2s_cp_stateids, and that pointer
+		 * outlives this call (it is removed only when the background
+		 * copy finishes). Pointing it at &u->copy would leave a stale
+		 * pointer into reused request memory that the laundromat and
+		 * OFFLOAD_CANCEL later dereference.
+		 */
+		if (!nfs4_init_copy_state(nn, async_copy))
 			goto out_dec_async_copy_err;
-		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
+		memcpy(&result->cb_stateid, &async_copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
-		dup_copy_fields(copy, async_copy);
 		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
 			       FMODE_NOCMTIME) != 0)
 			async_copy->attr_update = true;

-- 
2.55.0


