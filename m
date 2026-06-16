Return-Path: <linux-nfs+bounces-22568-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ntcpDd/hMGo4YQUAu9opvQ
	(envelope-from <linux-nfs+bounces-22568-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 07:40:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D2C68C398
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 07:40:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=aytDN7ox;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22568-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22568-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=synology.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A5CD3004DB3
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 05:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E93D6494;
	Tue, 16 Jun 2026 05:40:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F443D6467
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 05:40:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588441; cv=none; b=XVWtSzuFRmdFVQ4+SC+RVweimHLhhCTU839zX+g4cCnRsLr614SoXgOnqwrzuTUt/9rvBa+Zoq5SG7On7Q/DLyuLQ1dstUfPak/HfSIQrv7RFzIsZIxYm/rg2cddxepNDYP7zv+K7woUfnotflu0mGijhFyr+7urjUXO5m+98e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588441; c=relaxed/simple;
	bh=dJ1ED7T+Te64oSRF2JqK4BfIshgGW7mGUvTsAJGyOdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X57iHMmjJyz2KrnNVTVLrI2y2bafm5yZ1zyX1r5q/DpDqiNi3NGWlruC2I4CkiTCLhCraZxvIDFt5MjH2tw7KzwpfwUHDcAc7bLAUpz9llOCBLRTsMlbuh8DeIN6PY67IZcwb+GviGSsbNplR0IBGul9o0LuRGl6uxU9TTQJAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=aytDN7ox; arc=none smtp.client-ip=211.23.38.101
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1781588435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNTh6bjmluqZC1GYMKXLVwQpoLjT5JuY8kfvYt5n02c=;
	b=aytDN7oxauJP4LtYphyKeuRZwMPvq2EtFmdnZSm/A0Gb7/x6GJSlRBjAv12iooUuHF15C5
	Oqo82IKAOMmw+yTnllBVgYMZLDEhh90Pf4/qFFgUkkMR8KGVEI/ZNwlxpNe18fKOSinoeo
	pYK16vjy4FdLmB3GfQgrKf7FyKN+OHQ=
To: linux-nfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH v3 2/3] nfsd: reject out-of-range nseconds in NFSv3 SETATTR and create ops
Date: Tue, 16 Jun 2026 13:39:59 +0800
Message-ID: <20260616054027.2360930-2-robbieko@synology.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22568-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 35D2C68C398

From: Robbie Ko <robbieko@synology.com>

A client can send an NFSv3 SETATTR, CREATE, MKDIR, SYMLINK or MKNOD
carrying an atime or mtime whose nseconds field is out of range. The
value is well-formed on the wire and decodes cleanly into a valid
uint32, but it is not a valid timespec64: tv_nsec must be less than
NSEC_PER_SEC.

Nothing in the setattr path clamps it. notify_change() runs the time
through timestamp_truncate(), which does not reduce tv_nsec below
NSEC_PER_SEC when the filesystem supports nanosecond granularity
(s_time_gran == 1), and the inode atime/mtime setters store it verbatim
(only ctime is normalized, via inode_set_ctime_to_ts()). The
un-normalized value then corrupts on-disk metadata: ext4's
ext4_encode_extra_time() shifts tv_nsec left by EXT4_EPOCH_BITS, which
overflows the 32-bit extra field and clobbers the seconds-epoch bits, so
the stored seconds (and thus the year) are wrong on read-back. XFS with
bigtime mis-stores the timestamp for the same reason.

Validate the client-supplied atime/mtime in the proc handlers and return
NFS3ERR_INVAL before anything is changed. RFC 1813 lists NFS3ERR_INVAL
for SETATTR and describes it as the error for a value the server 'can
not store ... in its own representation'; the client maps it to EINVAL.

Checking in the proc handlers, rather than in nfsd_setattr(), keeps the
rejection in front of object creation. The create operations create the
object before nfsd_create_setattr() runs, so a late failure would leave
the new object behind and turn a non-idempotent request into a namespace
change that reports failure. The check is therefore done up front, for
the create operations before the object is created.

tv_nsec is a long, so the comparison casts it to unsigned long (the same
width) rather than to u32, matching timespec64_valid(). A u32 cast would
truncate on 64-bit; the unsigned long cast also rejects a value that
became negative when an out-of-range u32 wire nseconds was assigned to a
32-bit long.

Only client-supplied times are checked: SET_TO_SERVER_TIME requests
carry no client value. The sattrguard3 ctime is deliberately left alone:
an out-of-range guard simply never matches the object's ctime and yields
NFS3ERR_NOT_SYNC via the existing guardtime comparison, which is the
protocol-correct outcome rather than rejecting the request.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/nfsd/nfs3proc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 42adc5461db0..32d6b51dbe53 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -29,6 +29,25 @@ static int	nfs3_ftypes[] = {
 	S_IFIFO,		/* NF3FIFO */
 };
 
+/*
+ * Reject a client-supplied atime or mtime whose nanoseconds field is out
+ * of range. Such a value is well-formed on the wire but is not a valid
+ * timespec64, and storing it verbatim can corrupt on-disk timestamps.
+ * tv_nsec is a long, so it is cast to unsigned long (the same width) to
+ * catch both an over-large value and one that became negative when an
+ * out-of-range u32 wire nseconds was assigned to a 32-bit long.
+ */
+static bool nfsd3_time_in_range(const struct iattr *iap)
+{
+	if ((iap->ia_valid & ATTR_ATIME_SET) &&
+	    (unsigned long)iap->ia_atime.tv_nsec >= NSEC_PER_SEC)
+		return false;
+	if ((iap->ia_valid & ATTR_MTIME_SET) &&
+	    (unsigned long)iap->ia_mtime.tv_nsec >= NSEC_PER_SEC)
+		return false;
+	return true;
+}
+
 static __be32 nfsd3_map_status(__be32 status)
 {
 	switch (status) {
@@ -101,9 +120,14 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 				SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
+	if (!nfsd3_time_in_range(&argp->attrs)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	if (argp->check_guard)
 		guardtime = &argp->guardtime;
 	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
+out:
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
@@ -265,6 +289,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_vfs_create(rqstp, fhp, S_IFREG, argp->name, argp->len);
 
+	if (!nfsd3_time_in_range(iap))
+		return nfserr_inval;
 	if (isdotent(argp->name, argp->len))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
@@ -400,8 +426,13 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
+	if (!nfsd3_time_in_range(&argp->attrs)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, S_IFDIR, 0, &resp->fh);
+out:
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
@@ -415,6 +446,10 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 		.na_iattr	= &argp->attrs,
 	};
 
+	if (!nfsd3_time_in_range(&argp->attrs)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	if (argp->tlen == 0) {
 		resp->status = nfserr_inval;
 		goto out;
@@ -471,6 +506,11 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 		goto out;
 	}
 
+	if (!nfsd3_time_in_range(&argp->attrs)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
+
 	type = nfs3_ftypes[argp->ftype];
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, type, rdev, &resp->fh);
-- 
2.43.0


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

