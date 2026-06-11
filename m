Return-Path: <linux-nfs+bounces-22455-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mh8RGxg1KmovkAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22455-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 06:10:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92E66E20E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 06:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=ZLzqT6LF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22455-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22455-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=synology.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9305E30B73EE
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 04:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30625F7B9;
	Thu, 11 Jun 2026 04:09:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479F40D595
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 04:09:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150997; cv=none; b=ULxnYJId+vl+YZfDldNEbIVZUiPqItZiSDnz2FjZdjZEebTq04X1ihpwQbIwqcWt2uMJfzuJUS/Zkblyq5seY6hQNNym2zZKOrPoiz9WCB3Py/IZui/ATuNuiBe3FRjnAPPub45oP01NRdGn7qYN7uEwOhTASD1L1PDJ0NyO4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150997; c=relaxed/simple;
	bh=85W1iMEANVpBfQ+CFpt5caHnQx0INOIyMvLZVs/h4Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k6F0Og3vMPtX6QF16LM5WmNFT1nBQIj/lXJO6qKnyPio3eIjlaGI/WE8cLTpxKVAyLwoPP0jX4zlEb9tiRfAd+/4OJNwW7ct5XUeeoyzSGjTQBeJtItI2Hz5AgssIrpqClsSQagTS5RB5nOSgagenlGOW6wn3aDr3hU7DAjPqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=ZLzqT6LF; arc=none smtp.client-ip=211.23.38.101
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1781150988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q2i7ilYGviIFo3XyThL4uOAO3wh5ZUOKDFmUY3yw7FI=;
	b=ZLzqT6LFFtZ5T2xAzC3ZZiU1l42ioWluYiuz1wB9+aqeC9bpfPvvwYPUy7RYoLrsrm+WOR
	mAVrE2E+LDf1/McawwMqt04/ugza9OxwRUJ19VbPjMTy21VG2oqjRlTsEqOvDF2m8vshc6
	vhGGMs2fwqtmj3Ogq63hA7BzSRX81AE=
To: linux-nfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH] nfsd: reject out-of-range nseconds in NFSv3 nfstime3 decode
Date: Thu, 11 Jun 2026 12:09:19 +0800
Message-ID: <20260611040946.3507020-1-robbieko@synology.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22455-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:robbieko@synology.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,synology.com:dkim,synology.com:email,synology.com:mid,synology.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF92E66E20E

From: Robbie Ko <robbieko@synology.com>

The NFSv3 nfstime3 decoder svcxdr_decode_nfstime3() accepts the 32-bit
nseconds field from the wire without validating its range. RFC 1813
does not constrain the value, but a tv_nsec >= NSEC_PER_SEC is not a
valid timespec64. The NFSv4 decoder nfsd4_decode_nfstime4() already
rejects such values with NFS4ERR_INVAL; NFSv3 had no equivalent check.

A malicious or buggy client can therefore send a SETATTR carrying an
out-of-range nseconds (up to 4294967295). The value flows through
nfsd_setattr() -> notify_change() -> timestamp_truncate(), which does
not clamp tv_nsec to < NSEC_PER_SEC when the filesystem supports
nanosecond granularity (s_time_gran == 1). The inode atime/mtime
setters store it verbatim (only ctime is normalized via
inode_set_ctime_to_ts()).

The un-normalized value then corrupts on-disk metadata: ext4's
ext4_encode_extra_time() shifts tv_nsec left by EXT4_EPOCH_BITS, which
overflows the 32-bit extra field and clobbers the seconds-epoch bits,
so the stored seconds (year) are wrong on read-back. XFS with bigtime
mis-stores the timestamp for the same reason. This is silent, with no
WARN_ON anywhere in the path to catch it.

Validate the decoded nseconds in svcxdr_decode_nfstime3() and fail the
XDR decode if it is out of range, mirroring the NFSv4 behavior.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/nfsd/nfs3xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 2ff9a991a8fb..59e82ce03c20 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -64,6 +64,8 @@ svcxdr_decode_nfstime3(struct xdr_stream *xdr, struct timespec64 *timep)
 		return false;
 	timep->tv_sec = be32_to_cpup(p++);
 	timep->tv_nsec = be32_to_cpup(p);
+	if (timep->tv_nsec >= (u32)1000000000)
+		return false;
 
 	return true;
 }
-- 
2.43.0


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

