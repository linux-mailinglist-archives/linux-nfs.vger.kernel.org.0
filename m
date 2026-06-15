Return-Path: <linux-nfs+bounces-22556-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NDxAAjhSL2rH+QQAu9opvQ
	(envelope-from <linux-nfs+bounces-22556-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 03:15:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C797682B4B
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 03:15:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=ZgZ+o1lM;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22556-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22556-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=synology.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 964F93005173
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3480F23A562;
	Mon, 15 Jun 2026 01:15:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C472153EA
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2026 01:15:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486133; cv=none; b=HcfqJgGMC4hcjQRgwChVqp5h+6Ps3RqoWBJKhWhqbasylmzECRBOgHpG61wiCWRE4+DpJkQ2NrsSnCmU2RGRUZcTF+yY8heAaDZ12etrWChK+O1JaPcYcnTy3nugx492vL57uyWIanZ5GvuI/6llPWU8gJu37ti35vuCZnj8zrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486133; c=relaxed/simple;
	bh=C4O5eh911wP6iGFMfO68vm3WXi2RaLn9obx89VBM5og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nAAzsBs0AbAWavHOkU7IUjoFddC1h0uaFinlL6GIxgSQOfkF6E0dsgywUJHLy9+ZJl+Kg43b3bPfPhRLwwVG+4LaySE/0+7eZplorfqpQVpOIX6Eftvb9K+JJHX7iRoGr03hX92de6iqYEpAD1SX8EwE8x/eU0U0eEp1xhO++Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=ZgZ+o1lM; arc=none smtp.client-ip=211.23.38.101
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1781486123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PrImzXFzOxjjyVixkgdnLAXalfQU79ghYTb3RabM7MI=;
	b=ZgZ+o1lMRyMKJHKY4Kkl+idDTsdYFcpxhl1lWP0fjmR7y+N4xn1aT1fMItPndF03MXSwh3
	NUml0YbqZzFr7K8zSu5bQLsCvpVrYJNSAcMrSrXE7Yk50lGfqaHsMVnSkmaOLZilY7BKKa
	lXSByMYTkpqUcE99Wc0ZgVkcZ2G21qM=
To: linux-nfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH v2 1/2] nfsd: reject out-of-range nseconds in setattr atime/mtime
Date: Mon, 15 Jun 2026 09:14:36 +0800
Message-ID: <20260615011520.1477943-1-robbieko@synology.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Auth: pass
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22556-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C797682B4B

From: Robbie Ko <robbieko@synology.com>

A client can send a SETATTR (and, for NFSv3, a file creation) carrying
an atime or mtime whose nseconds field is out of range. The value is
well-formed on the wire and decodes cleanly into a valid uint32, but it
is not a valid timespec64: tv_nsec must be less than NSEC_PER_SEC.

Nothing in the path clamps it. notify_change() runs the time through
timestamp_truncate(), which does not reduce tv_nsec below NSEC_PER_SEC
when the filesystem supports nanosecond granularity (s_time_gran == 1),
and the inode atime/mtime setters store it verbatim (only ctime is
normalized, via inode_set_ctime_to_ts()).

The un-normalized value then corrupts on-disk metadata. ext4's
ext4_encode_extra_time() shifts tv_nsec left by EXT4_EPOCH_BITS; an
out-of-range value overflows the 32-bit extra field and clobbers the
seconds-epoch bits, so the stored seconds (and thus the year) are wrong
on read-back. XFS with bigtime mis-stores the timestamp for the same
reason. There is no WARN_ON anywhere in the path to catch it.

Validate the client-supplied atime/mtime in nfsd_setattr(), which is
the common choke point for SETATTR and for the create paths (via
nfsd_create_setattr()), and covers both NFSv2 and NFSv3. The check is
done up front, before any resources are acquired, so no cleanup path is
involved; RFC 1813 Section 2.6 leaves error precedence to the
implementation. Return NFS3ERR_INVAL, which RFC 1813 lists for SETATTR
and describes as the error for a value the server 'can not store ... in
its own representation'. The client maps this to EINVAL.

tv_nsec is a long, so the comparison casts it to unsigned long (the same
width) rather than to u32, matching timespec64_valid(). A u32 cast would
be wrong on both ends: on 32-bit it cannot widen, and on 64-bit it would
truncate the NFSv2 value (svcxdr_decode_sattr() computes tv_nsec as
tmp2 * NSEC_PER_USEC, which can exceed the u32 range). The unsigned long
cast also rejects a value that became negative when an out-of-range u32
wire nseconds was assigned to a 32-bit long.

RFC 1094 does not define NFSERR_INVAL for NFSv2; its stat enum has no
value 22. Map nfserr_inval to nfserr_io in nfsd_map_status() so the
NFSv2 reply stays within the RFC 1094 status set, the same way that
function already folds other internal statuses with no NFSv2 equivalent.
NFSv3 (and NFSv4) leave the INVAL status as is, since it is valid there.

Only client-supplied times are checked: SET_TO_SERVER_TIME requests
carry no client value and are filled in by the server. The NFSv2 Sun
'set both to now' convention clears ATTR_[AM]TIME_SET in the SETATTR
proc before nfsd_setattr() runs, so it is unaffected. The sattrguard3
ctime is deliberately left alone: an out-of-range guard simply never
matches the object's ctime and yields NFS3ERR_NOT_SYNC via the existing
guardtime comparison, which is the protocol-correct outcome rather than
rejecting the request.

NFSv4 already rejects such values in nfsd4_decode_nfstime4(), so they do
not reach this check on that path.

The lack of validation is long-standing and predates the git history of
this code, so no Fixes: tag is provided. This is a data-integrity fix
and is a candidate for LTS backport.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/nfsd/nfsproc.c |  1 +
 fs/nfsd/vfs.c     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 8873033d1e82..3c8da3f1af6c 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -33,6 +33,7 @@ static __be32 nfsd_map_status(__be32 status)
 		break;
 	case nfserr_symlink:
 	case nfserr_wrong_type:
+	case nfserr_inval:
 		status = nfserr_io;
 		break;
 	}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eafdf7b7890f..dd0bbf7aad1b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -515,6 +515,20 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_vfs_setattr(rqstp, fhp, iap, guardtime);
 
+	/*
+	 * Reject a client-supplied atime or mtime whose tv_nsec is out of
+	 * range. Such a value is well-formed on the wire but is not a valid
+	 * timespec64; storing it verbatim can corrupt on-disk timestamps
+	 * (for example, ext4 packs tv_nsec << 2 alongside epoch bits).
+	 * Reject it before acquiring any resources. RFC 1813 Section 2.6
+	 * leaves error precedence to the implementation.
+	 */
+	if (((iap->ia_valid & ATTR_ATIME_SET) &&
+	     (unsigned long)iap->ia_atime.tv_nsec >= NSEC_PER_SEC) ||
+	    ((iap->ia_valid & ATTR_MTIME_SET) &&
+	     (unsigned long)iap->ia_mtime.tv_nsec >= NSEC_PER_SEC))
+		return nfserr_inval;
+
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
 		ftype = S_IFREG;
-- 
2.43.0


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

