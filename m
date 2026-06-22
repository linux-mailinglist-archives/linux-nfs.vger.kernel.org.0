Return-Path: <linux-nfs+bounces-22768-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ef6JNA95OWr6twcAu9opvQ
	(envelope-from <linux-nfs+bounces-22768-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 20:03:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5975C6B1A8C
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 20:03:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=medichon.fr header.s=ovhmo3801317-selector1 header.b=aoBnTfFo;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22768-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22768-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DF82302A1B2
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5343446C5;
	Mon, 22 Jun 2026 18:03:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from 2.mo560.mail-out.ovh.net (2.mo560.mail-out.ovh.net [188.165.53.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FA42BEC4E
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 18:03:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151424; cv=none; b=CuxVOOBGT+NtzFXWNd8P7oTp75Zz/N0llXF7NuGExkPqzr4Q56YUz2gbYW4nC2P6AlceYLsytNFBQ7gACmJcPmwZQZIdGJarQ50nguGnT1KwZ5UJHffszXW0BxvQX1FDvY0HKTFRZpZ+v3WZriZq9DPtKpP+OiKuH7CcUON+BhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151424; c=relaxed/simple;
	bh=nwulTDzi+Eo0CIuDO5yxVG+mlsVeJZY6Ue1ApKi52ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVZoYozOV6kgsqjud2hUO982Li2JzIcVPzSrT+ynAmXxUIQwNYYPE6tLM5o+UoFLQNLY4JFC2BmoXz3xa/pF/NJa0b2IbR39jbNpI2anKiJHJb03igYPqUZGUJtAXjAsBsYva4sLXT2y7EmUq4ZfYHp3whv2HvJMg6WlnNgKGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=medichon.fr; spf=pass smtp.mailfrom=medichon.fr; dkim=pass (2048-bit key) header.d=medichon.fr header.i=@medichon.fr header.b=aoBnTfFo; arc=none smtp.client-ip=188.165.53.149
Received: from director6.ghost.mail-out.ovh.net (unknown [10.110.0.178])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4gkbW852vHzB9SY
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 17:57:08 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-ghq26 (unknown [10.110.188.223])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 72CC2801BD;
	Mon, 22 Jun 2026 17:57:08 +0000 (UTC)
Received: from medichon.fr ([37.59.142.101])
	by ghost-submission-7d8d68f679-ghq26 with ESMTPSA
	id evTZOl53OWrOIhsAiGv3aQ:T3
	(envelope-from <abo@medichon.fr>); Mon, 22 Jun 2026 17:57:08 +0000
X-OVh-ClientIp:88.190.90.129
From: Arnaud Bonnet <abo@medichon.fr>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	code@agatha.dev,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Arnaud Bonnet <abo@medichon.fr>
Subject: [PATCH 2/2] nfs: refactor pNFS functions using clear_and_wake_up_bit
Date: Mon, 22 Jun 2026 19:55:11 +0200
Message-ID: <929ff54c0c212b22620d10e6d8bef2a01bc6fa30.1782148639.git.abo@medichon.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782148639.git.abo@medichon.fr>
References: <cover.1782148639.git.abo@medichon.fr>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8607504791617429086
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEY6vVJqlsQ7805Av3UYlFmpVf0/jjD4WlfKU2L/XZIZkKnREVk33dSjev8frkzfuTED3MeqGVaXd1O2msw2GthCjbQ6ql/hUS10gUF4Pd0HXx1+aqL/HFwmYxAhTa8br3myS5JCeffUGh6ab6T/8VmZjSjgKWQPS6+Mm9fX/KIBuuTrYPhrhprYwYRqqCo3rQBOiR0B4d3YQpCF0iZtlssx81HqnZo40ShlrW45toMoHolN9SCwCKg8s07mReFtwcSiHgL5zueCidvUCCb699i7QfrSf/CgWjrF1ffcdctbVaazLqELkuw89buEXf+pR+Pv4rBGIsGQ9jhYQ5A5iCnbh7YketIYLj8LbSthXkzrNlMvkh4DiderIjjeCnAtdFUT0gE1G0kBd15gLjXvg7CwBMR7EaexVeGiWD07kyeUX5Uc2tm+MBBj5sR/SyJif8NPtnYOIfOltnEChfOY2Dmh4zk0XbeBRK7wez7X1hvdG9uxdjz2jSE7jnJbAzMSq5jJhjhgPHtpdbkmErZFwJEYi8SZl/anN/N0iqtwB6BXdz0wBt/1qEXnStxaTbodaBGe4vyJK2++Tn20b5Kq2GpObPoc6YwgxecTWZlUHfzTkZKH8i9pMDRUTbAR3Zo38VHFVyQi2QOHQXK1INF41zdWRFEL6fpFQu2cUkPxiwhRQ
DKIM-Signature: a=rsa-sha256; bh=akmQC6Fqv9/jp8JQRHX0+7MKf1Fh9g8lAkcmkuiXV4c=;
 c=relaxed/relaxed; d=medichon.fr; h=From; s=ovhmo3801317-selector1;
 t=1782151028; v=1;
 b=aoBnTfFoKXRR30GxEyFGtyDZHSuwpELAClX72XEsi0jwNyqkUDrZhNol8QhzmLjDBmVrnwZf
 5bMgYq7Zy9Izlx3UYSAYBIdrbZqU549iL04MqvxJzzSdSgzJ2XaSQNwA+SLPxdTjSvmjlFNgjIn
 p/TYiJT2wZdrkKeSrKYei+Gyb2TsbBkwq5yjIKh0Xr3CWJIcEfRLOtyzqlt+jqQ2hLubQxfob51
 2oq2d1NGaRrxtMKN4dW7GC3P6r9b6hubpiJ0mbK1NgmhHvHpFEwQ32AHfqjUXJK7wq6htTzs3/e
 SdVYA7E8zCiYro30jdCJlC1xcdyiiJMSZTW+ZRV1DQ65g==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[medichon.fr:s=ovhmo3801317-selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,agatha.dev,linuxfoundation.org,brighamcampbell.com,xs4all.nl,medichon.fr];
	TAGGED_FROM(0.00)[bounces-22768-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:code@agatha.dev,m:skhan@linuxfoundation.org,m:me@brighamcampbell.com,m:jkoolstra@xs4all.nl,m:abo@medichon.fr,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[medichon.fr];
	FORGED_SENDER(0.00)[abo@medichon.fr,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[medichon.fr:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abo@medichon.fr,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5975C6B1A8C

Commit 8236b0ae31c83 ("bdi: wake up concurrent wb_shutdown() callers.")
introduces the clear_and_wake_up_bit() helper as a wrapper for the
common clear -> barrier -> wake up bitops sequence.

The file pnfs.c has several helpers with identical contents. Thus they
are replaced with the more recent clean_and_wake_up_bit() global helper
which describes accurately its effects at the call and still specifies
the cleared bit. This also homogenizes the code with other subsystems.

Since the helpers are no longer used after this, they can be safely
removed.

Suggested-by: Agatha Isabelle Moreira <code@agatha.dev>
Link: https://kernelnewbies.org/Beginner%20Cleanup%20and%20Refactor%20Tasks%20by%20Agatha%20Isabelle%20Moreira#task_007
Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---
 fs/nfs/pnfs.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 743467e9ba20..96ee18af1ebf 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2100,15 +2100,6 @@ static bool pnfs_is_first_layoutget(struct pnfs_layout_hdr *lo)
 	return test_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
 }
 
-static void pnfs_clear_first_layoutget(struct pnfs_layout_hdr *lo)
-{
-	unsigned long *bitlock = &lo->plh_flags;
-
-	clear_bit_unlock(NFS_LAYOUT_FIRST_LAYOUTGET, bitlock);
-	smp_mb__after_atomic();
-	wake_up_bit(bitlock, NFS_LAYOUT_FIRST_LAYOUTGET);
-}
-
 static void _add_to_server_list(struct pnfs_layout_hdr *lo,
 				struct nfs_server *server)
 {
@@ -2284,7 +2275,8 @@ pnfs_update_layout(struct inode *ino,
 					iomode, lo, lseg,
 					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
 			nfs4_schedule_stateid_recovery(server, ctx->state);
-			pnfs_clear_first_layoutget(lo);
+			clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
+				&lo->plh_flags);
 			pnfs_put_layout_hdr(lo);
 			goto lookup_again;
 		}
@@ -2353,7 +2345,8 @@ pnfs_update_layout(struct inode *ino,
 			if (!exception.retry)
 				goto out_put_layout_hdr;
 			if (first)
-				pnfs_clear_first_layoutget(lo);
+				clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
+					&lo->plh_flags);
 			trace_pnfs_update_layout(ino, pos, count,
 				iomode, lo, lseg, PNFS_UPDATE_LAYOUT_RETRY);
 			pnfs_put_layout_hdr(lo);
@@ -2365,7 +2358,7 @@ pnfs_update_layout(struct inode *ino,
 
 out_put_layout_hdr:
 	if (first)
-		pnfs_clear_first_layoutget(lo);
+		clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
 	trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
 				 PNFS_UPDATE_LAYOUT_EXIT);
 	pnfs_put_layout_hdr(lo);
@@ -2457,7 +2450,7 @@ static void _lgopen_prepare_attached(struct nfs4_opendata *data,
 	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &current_stateid, &rng,
 					     nfs_io_gfp_mask());
 	if (!lgp) {
-		pnfs_clear_first_layoutget(lo);
+		clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
 		nfs_layoutget_end(lo);
 		pnfs_put_layout_hdr(lo);
 		return;
@@ -2561,7 +2554,8 @@ void nfs4_lgopen_release(struct nfs4_layoutget *lgp)
 {
 	if (lgp != NULL) {
 		if (lgp->lo) {
-			pnfs_clear_first_layoutget(lgp->lo);
+			clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
+				&lgp->lo->plh_flags);
 			nfs_layoutget_end(lgp->lo);
 		}
 		pnfs_layoutget_free(lgp);
@@ -3273,15 +3267,6 @@ pnfs_generic_pg_readpages(struct nfs_pageio_descriptor *desc)
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_pg_readpages);
 
-static void pnfs_clear_layoutcommitting(struct inode *inode)
-{
-	unsigned long *bitlock = &NFS_I(inode)->flags;
-
-	clear_bit_unlock(NFS_INO_LAYOUTCOMMITTING, bitlock);
-	smp_mb__after_atomic();
-	wake_up_bit(bitlock, NFS_INO_LAYOUTCOMMITTING);
-}
-
 /*
  * There can be multiple RW segments.
  */
@@ -3306,7 +3291,7 @@ static void pnfs_list_write_lseg_done(struct inode *inode, struct list_head *lis
 		pnfs_put_lseg(lseg);
 	}
 
-	pnfs_clear_layoutcommitting(inode);
+	clear_and_wake_up_bit(NFS_INO_LAYOUTCOMMITTING, &NFS_I(inode)->flags);
 }
 
 void pnfs_set_lo_fail(struct pnfs_layout_segment *lseg)
@@ -3446,7 +3431,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	spin_unlock(&inode->i_lock);
 	kfree(data);
 clear_layoutcommitting:
-	pnfs_clear_layoutcommitting(inode);
+	clear_and_wake_up_bit(NFS_INO_LAYOUTCOMMITTING, &NFS_I(inode)->flags);
 	goto out;
 }
 EXPORT_SYMBOL_GPL(pnfs_layoutcommit_inode);
-- 
2.53.0


