Return-Path: <linux-nfs+bounces-22569-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AX2wLBziMGo8YQUAu9opvQ
	(envelope-from <linux-nfs+bounces-22569-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 07:41:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1305668C3A6
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 07:41:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=Q7an+WR3;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22569-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22569-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=synology.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A63CB310EAA6
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 05:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA91D3D6467;
	Tue, 16 Jun 2026 05:40:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F403D567C
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 05:40:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588442; cv=none; b=RjmE61wv1H6wyP3+1976DyR7VQeQt/McH2AuN4vuVyWnxuB7uM9X4XTHWMtkP3CP4gHdoKCAdduMpTE3MJjGsR66nDNswzjk2/3BFojOZ08xnZTznXrBdfFCmvlkJC/cuPZ7yPOmarHPfcGB28W39kzfF+1bPbCoAcQSNd1MmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588442; c=relaxed/simple;
	bh=vcfMEHTLKTg2Tbp5VAW4ocN3NsNZI2+xsRt95eBN4uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baWArdPCGrhK02b0YnYVzAU8dB6ppUOTmF2NVlk4aee6MTyFDZ9o6blBeCgOF3wmSYOb3zdVeTDk10MRPIf+qEGwi6Pq6FjbTcRYNwrOT39hCEu/enGR/jNLon8ihOqo8oRONCuZbIerSBSsYP3z+qfjTH9pyVji8SmSqyfka6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=Q7an+WR3; arc=none smtp.client-ip=211.23.38.101
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1781588437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+Gm/UutmguKUhkqOeWJZPTGtyJpcnsBWxq/TWe1UCo=;
	b=Q7an+WR3aIw52UIhsdUuk5DpkJY2UhwBEQOJpn0d4ugrQdKHfnhDEBB53q/lftsAvtd/me
	YHWbjpsXeLkAllDSktWbEeefz14FThYj+Qpa1st5g6TO6Hy2w2wXpaVsH29n08Z1kVDjz9
	6BdReOhSJOH89x8S8XnOzxgUDgG/oks=
To: linux-nfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH v3 3/3] nfsd: use NSEC_PER_SEC in nfsd4_decode_nfstime4()
Date: Tue, 16 Jun 2026 13:40:00 +0800
Message-ID: <20260616054027.2360930-3-robbieko@synology.com>
In-Reply-To: <20260616054027.2360930-1-robbieko@synology.com>
References: <20260616054027.2360930-1-robbieko@synology.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Auth: pass
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22569-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:robbieko@synology.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[robbieko@synology.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robbieko@synology.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,synology.com:dkim,synology.com:email,synology.com:mid,synology.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1305668C3A6

From: Robbie Ko <robbieko@synology.com>

nfsd4_decode_nfstime4() open-codes the nanoseconds upper bound as the
literal (u32)1000000000. Use the named constant NSEC_PER_SEC instead,
matching the NFSv3 setattr check and improving readability.

The original code cast the literal to u32 to force an unsigned
comparison, which matters on 32-bit where tv_nsec is a 32-bit signed
long: an out-of-range u32 wire nseconds (>= 0x80000000) assigned to it
becomes negative and a signed compare against NSEC_PER_SEC (a signed
long) would wrongly pass. Keep that protection by casting tv_nsec to
unsigned long, the same width as tv_nsec, matching timespec64_valid().
No functional change.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2a0946c630e1..db17bd3e45d6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -244,7 +244,7 @@ nfsd4_decode_nfstime4(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 		return nfserr_bad_xdr;
 	p = xdr_decode_hyper(p, &tv->tv_sec);
 	tv->tv_nsec = be32_to_cpup(p++);
-	if (tv->tv_nsec >= (u32)1000000000)
+	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
 		return nfserr_inval;
 	return nfs_ok;
 }
-- 
2.43.0


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

