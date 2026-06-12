Return-Path: <linux-nfs+bounces-22521-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gGweKNWhK2paAwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22521-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 08:06:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82812676DC4
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 08:06:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=GrhZYejD;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22521-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22521-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=synology.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52F1C3012347
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 06:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF33B585F;
	Fri, 12 Jun 2026 06:06:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32863B8BD4
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 06:05:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244364; cv=none; b=WNB/VxSvlUMyMHyxT8FWXublwqRXtZ2NwiFQ5NRyFKwBKDSR4bJMaxEyfU6+YMAHotQnToIHfXT4FsS+ZStHL8DUFBF2EXkev4SvOJlzpYSlX6DOqYjDHwf6rZOwngBCuHKORGxuOgxDrFzOhJuBPV1L+45Cj874EMNd/1VKx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244364; c=relaxed/simple;
	bh=CEIWwopG7VCj3AryexCOCAn/MSclU7rTs3elimyiFL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxX3MSzebaufUmW9N+4cMLMemKRTFIa5gCcHs2Tpe/k65h8pj86p311bdDtbMBXXgbcBYn41VnLA1lZ1oTpQHPx0zpLaojkx3zG0Med7kQbZTvhf1wnxhn62vlJhXVYnc9cKYwCkFy82M9up0aQ6rFdsq4O3ur0FtoGo1DPijMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=GrhZYejD; arc=none smtp.client-ip=211.23.38.101
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1781244351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4rViTvpIdvG2pVgyr7e5p+In0RCQPMguEXHbX6TVHc=;
	b=GrhZYejDNSwSDrV3sdg1DjqKNVJpjA7NyLL4LugD+nTngAMUQDIKPhAnzaVEWf21v03Hfr
	/3o0ZDlZAaoUEw4wyfJ4EZBeQPAh8G4T6H7jpyJe3xIjy+vIDNc0CrO2dFKz6jSEJ6jhIi
	plxNUuPlHJlCNws714otVThhPe4HvN8=
To: linux-nfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH 2/2] nfsd: use NSEC_PER_SEC in nfsd4_decode_nfstime4()
Date: Fri, 12 Jun 2026 14:05:09 +0800
Message-ID: <20260612060539.4137523-2-robbieko@synology.com>
In-Reply-To: <20260612060539.4137523-1-robbieko@synology.com>
References: <20260612060539.4137523-1-robbieko@synology.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22521-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,synology.com:dkim,synology.com:email,synology.com:mid,synology.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82812676DC4

From: Robbie Ko <robbieko@synology.com>

nfsd4_decode_nfstime4() open-codes the nanoseconds upper bound as the
literal (u32)1000000000. Use the named constant NSEC_PER_SEC instead,
matching the out-of-range check added for the NFSv2/NFSv3 setattr path
and improving readability. No functional change.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2a0946c630e1..f88c26cd459f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -244,7 +244,7 @@ nfsd4_decode_nfstime4(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 		return nfserr_bad_xdr;
 	p = xdr_decode_hyper(p, &tv->tv_sec);
 	tv->tv_nsec = be32_to_cpup(p++);
-	if (tv->tv_nsec >= (u32)1000000000)
+	if (tv->tv_nsec >= NSEC_PER_SEC)
 		return nfserr_inval;
 	return nfs_ok;
 }
-- 
2.43.0


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

