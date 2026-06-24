Return-Path: <linux-nfs+bounces-22820-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HW4oAyw1PGoclQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22820-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:51:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA6E6C11A3
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:51:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=pFGIGds6;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22820-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22820-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0897300F1B9
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDAC305E28;
	Wed, 24 Jun 2026 19:51:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476B3CB911
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 19:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330665; cv=none; b=CSh8XK4yFxo3U46wTu9ZDXEPiGZrXJnm9y827ulKa8qesgvTtJ64tPDvFt22M9R1ahKS6wiYG1ETKng6xqltkIAf2M6zidD8fqKB0ZIbfPGCJCh72furNicz7SIyREgVuMnQFehu2zqGCwuz3yboWvXgT2GiS5WCGcAl7784/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330665; c=relaxed/simple;
	bh=JfRZE8OFCSFXuoM6g95motjyZRPDA5/PtChlGnnlrFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljBRSJ445X9G8rzkQlphoMbnBthcOxU04757g6VfP8s6f9QA0U9upklxK5v6t3608fGZ6g8rXrGAJXQdlFSpzIluvt6Clf7PuXuX3OGXnksPLaEYGlJaP0n5CF+C8qpJadIfZ2hW0iPOaJ4ed9Rp1I0Ey8Y+g6GS+YBeJcAbwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=pFGIGds6; arc=none smtp.client-ip=209.85.160.47
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43d3454f643so690744fac.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782330663; x=1782935463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHKg1F6vPAf4hnHk29a0TQCPGUJ0KuX6PsMDG7TfdVQ=;
        b=pFGIGds6wrFLz/V+SGl5qrIxrWNcG+FvZONKJ7GLhPSOW41LEk/UQiEXe7UBVvRHtN
         nfve3INvWLTB7k5NhqANt6/479sPk3Oh20SlnNiG1qielYl8FXKnWAZciONs/UwYZPBr
         ln9yxzSocelebDjpt321vV7f/vYI/OWDdflGsAmTiX4QwzNTpiVJWqM6MVSr1K3Wg2ko
         1Jv2KRbKgb1y6Ysr0i6giovjz3K/gvoe2bR0AqXCxQlt07+sVrKbiy1teSkI/wXfPKP+
         4InqDwwF+LLkkMMIR/YynQwAF9fDstFGsBll73Gpbbpp9UZxM9LDGSbgLWPNY4D5Nfg/
         davA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330663; x=1782935463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHKg1F6vPAf4hnHk29a0TQCPGUJ0KuX6PsMDG7TfdVQ=;
        b=r2Ncnq89S+HeYep6ZEQzXY5xSChkBko3zRAXkJFCJihzyjTPn9i8Jp2A4jtobIKi8v
         n3fOmAEW6ot+iWxtQsrOC7SMRViPDbdKHHNQ9E/fNMYHnw9LeePo9K7l3BHRyoaUd99k
         3o9UjhfiZXbvsBHvroZ3YQ4hM5+KGdxiBTtv/hqgeIVaDSzEghEJ77nStZJGLwLoNVmN
         ZJoPPKmRp4jbN7Djf9I1bgnB8jjBBWuBSASx/s2oC/RSpfKV4x/5SYYEeBhm+fJAhgwN
         hepL1betA+L3Zs0w59DNNm69XcrUqog9DVZo6D1G+Zq0wnClNBeLKq5qJ99aRwCFpXi4
         Q6AA==
X-Gm-Message-State: AOJu0YxV5rV6XUiFWsHRTN4+3+ung8SL08CBl2kmEwv+UjhPTuRG/SjC
	OabdUxOBO9bzSZsQLQI2iL0PUuYeOJsgEoEr/Ontg/T+l5JmOEfhgdMJmc1FaPr3DrbAEToErtn
	aihJh
X-Gm-Gg: AfdE7clS7KPk8vIymc4jAJ5uDPh0Y/0r0Cp5+bncsnhJmHGJUWlVyHBoRTqQPb48lqZ
	95IkcfQf7SGqTSY6cjb1KTAgP6fohdMh5DZ1e39+bdydkTp+dk4qml/O0+NQzfNimnVTJ9TbjGg
	/hGbwAUqvAEFsdS5a7uqaOqKR+TUbzWmOC3fz3BQPL7QX4pKmMvQ5LJ+8xCsxRrVHfbbwHtu1rL
	wpjQc62EBSSGqZ/WJvuZhdY/epEvw+GtObbITSzNwnYe753285WQt10qtpO+CO3zST96QdcGsJZ
	g+oKUZJNtCcuv92t2UiLYmb/MJl5a8uT/E07nuDuihzL4Mn4RBLU5DXOkhx/xZZEuduUlvDomdk
	hKlY9D81dvTCK27Tnbsfn48ueuEyHMHRW1Pw5kbRU9OsQ8jobOK8IJhLAwD8aTrdfvFVdfrTjAR
	vNHgrbn0eA0CznlpBb7zt2xQluRQe9NyBM4FeY5+BL2CY86hGG
X-Received: by 2002:a4a:ec44:0:b0:69e:3c79:6e7c with SMTP id 006d021491bc7-6a1230640d3mr2982469eaf.46.1782330663016;
        Wed, 24 Jun 2026 12:51:03 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a11e6ef161sm2902890eaf.5.2026.06.24.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:51:02 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSv4/flexfiles: report cancelled I/O as a layout error
Date: Wed, 24 Jun 2026 15:50:58 -0400
Message-ID: <5c889ef9a3766960f2cc6f61b1054ba1e71bbb81.1782329389.git.bcodding@hammerspace.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22820-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:dkim,hammerspace.com:email,hammerspace.com:mid,hammerspace.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBA6E6C11A3

When a layout is recalled or revoked the client cancels its in-flight I/O
so the layout can be returned.  The metadata server needs to learn that
this I/O to the storage device did not complete, so that it can reconcile
the affected mirror instance (or, if none remains, take other action).

The cancellation completed with -EAGAIN, which ff_layout_io_track_ds_error()
does not recognise: it fell through the switch and recorded nothing, so no
error was reported to the server.

-EAGAIN is overloaded in the RPC layer, so rather than key the reporting on
it, cancel the I/O with -ECANCELED and map that to NFS4ERR_NXIO in
ff_layout_io_track_ds_error() -- the status the client already reports for
the transport errors that leave an in-flight write incomplete.  The
cancelled I/O is then reported to the server via LAYOUTERROR / LAYOUTRETURN.

Unlike a genuine transport error, though, we aborted the I/O ourselves and
have no evidence the device is at fault, so once the error is recorded we
skip marking the device unreachable and forcing a further layout return.

The retry disposition is unchanged from the original -EAGAIN cancellation:
both NFS4ERR_NXIO and -ECANCELED are no-ops in ff_layout_async_handle_error(),
which still resets the I/O to pNFS (or the MDS), so it is re-driven as before.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8b1559171fe3..2e04d85a6286 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1526,6 +1526,17 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -EACCES:
 			*op_status = status = NFS4ERR_ACCESS;
 			break;
+		case -ECANCELED:
+			/*
+			 * In-flight I/O we cancelled to return a recalled or
+			 * revoked layout.  Report it as a failure to reach the
+			 * device (NFS4ERR_NXIO), like the transport errors
+			 * above, so the server can reconcile the affected mirror
+			 * instance.  We aborted the I/O ourselves rather than
+			 * observe the device fail, so don't condemn it below.
+			 */
+			*op_status = status = NFS4ERR_NXIO;
+			break;
 		default:
 			return;
 		}
@@ -1536,6 +1547,15 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 				       mirror, dss_id, offset, length, status, opnum,
 				       nfs_io_gfp_mask());
 
+	/*
+	 * I/O we cancelled ourselves to return a recalled or revoked layout
+	 * is reported above so the server can reconcile the mirror, but we
+	 * have no evidence the device is at fault: don't mark it unreachable
+	 * or force a return.
+	 */
+	if (error == -ECANCELED)
+		goto out;
+
 	switch (status) {
 	case NFS4ERR_DELAY:
 	case NFS4ERR_GRACE:
@@ -1555,6 +1575,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 						  lseg);
 	}
 
+out:
 	dprintk("%s: err %d op %d status %u\n", __func__, err, opnum, status);
 }
 
@@ -2429,7 +2450,7 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
 			clnt = ds_clp->cl_rpcclient;
 			if (!clnt)
 				continue;
-			if (!rpc_cancel_tasks(clnt, -EAGAIN,
+			if (!rpc_cancel_tasks(clnt, -ECANCELED,
 					      ff_layout_match_io, lseg))
 				continue;
 			rpc_clnt_disconnect(clnt);
-- 
2.53.0


