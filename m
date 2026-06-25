Return-Path: <linux-nfs+bounces-22834-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3PoyIu0ZPWoVxAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22834-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 14:07:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12246C5626
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 14:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=S1FzVnyQ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22834-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22834-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D7830C51FC
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612213BB11C;
	Thu, 25 Jun 2026 12:05:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F93DDDC3
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 12:05:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389159; cv=none; b=OHQj01qYF1HzHjxOk+u4n/mpLZWyq2xzqZ/771bMd25WrIEfHc+0+pdL/yVz0Wpv63Z4bnv3wOAlx302BScLb+2exhVU7kf0U5IHU9qojcEKrsu5m2Ye1BdeEAneCNef5C/3lJRZ/K54guAMP89InZcDAsMgw/70Hp/j4fZRgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389159; c=relaxed/simple;
	bh=Wa+fpGjS5/ibCIDbRTqRwwY/khk4s7wVbVH0srL6hfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riV3/DX3DAu++I1/IqAR03pfCPfCBdMG6tZ0OSf5R8Pld2wSnyTF4bf+uOhsJzvv6MQ/35sIr5ca8FOboamplAcCcgqc8AeEYpnQzeix5wdDrSwRweTpUdXAV0h07pewFj0fdgXC8TpfKiNpRuSmgbppTH4N/mBO2yrL2wYh2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=S1FzVnyQ; arc=none smtp.client-ip=209.85.160.45
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43fc82b52afso1343957fac.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782389157; x=1782993957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeLqvVdd/ordrUU0pk1YjK8tqQrgS9wJ6KIItZyhlY8=;
        b=S1FzVnyQHYR1TE84GEuNqqVgJ5ACYTsyif4UsBf899Xz45jQhD2uOZC6qNZKo8e7x3
         WQW1X0qGu7M+3ujQrO49SN252XxvWNzzy/NT9SwVtW5lcENyhx5O3bYinJTwRzEVKzol
         iLuFIml7SpwnEGLhdRoyVBQdQ4CKNqht95MnVND+obYp4SHK+PJ4DfOmdq/uet7OtlJ+
         1HxSOnHvSqotxA2NMBoCGp85Twf1/JfXOqhyjXcw9UbaJqQXB+KW7SsdSgd3m+AcwTtj
         Ysdv1NAHPyA6CiLlJFTLMCY4+BZbeOy8jGdYnXj39EEYU/qL7JUC7Pmay2B41JwnU4Sj
         aH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389157; x=1782993957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oeLqvVdd/ordrUU0pk1YjK8tqQrgS9wJ6KIItZyhlY8=;
        b=hA+wnL1m0CfoKATEmmt/xAhtNp1E8k3WMp7YOdVK9oRFXaCFmAN0Iz4xKq7NLa890k
         TisZqDmGDuno5RurWVx4ilSAZ9mIRrOMF2zbix8/GUpNcscENn5nBnkrA9wKCkd1vvtu
         rIM+xtq9gGMVE7batQCtuDujtUVaonInZ6MTQeWdPfIw2G3BIHDlzPPmVeM0iAJBJfbY
         HAK1Sn57pK4KkkKVEho9qrFIa8WE/vQIiPYWl+XFTVYeZr1XWoSnan+UvIG61Oj5w7+P
         faUCGMYsKWJA1mOVt1QDtgOAHFQlcV1CVXbbyAoOezbOMKZ2dc3vbRbI/PuPa1iWHh14
         S4ow==
X-Gm-Message-State: AOJu0Yzm1U58kKHQkAEkHnjbrJMd2ugyfX6eUFNO6VlgQnsNX9c/k72K
	XoahSIGFj4UM4o2FcVF37uwm7fbm2z0/TF35jJA6Z+5sq7basoRXPJtt41SdwU8AKYg=
X-Gm-Gg: AfdE7ckxxzbL29Xb0C4QheS8KFnuJkig8pXzniL49frbI3LIllvUnHKWD3F3R1lpp3O
	YH7MHkOCjKhuUZssMTGZwkyxlgKTUc80CS5bj+7eUxvsvo0R7PaBXBCnKpZa9U/iAYVxhMS5xr7
	6hmH45pDQee6RGkkFgCC2NdL2xKPSFfBMzJT2EbinS57Ll9mz+jA26TvJuNeQqApdlAAWI75cLL
	PLTE9gju38tX57veAYzyqOUw5Po0ImJYaNErAv2gDVTY77PU5uFenpDOh//ARSntrGbksIwWAa3
	qfWLt78vuU5DKEqGJGP7OW/sYuUl1XmEUBobEg+Ct8965KvmCri1vJa8Q86Eb2Znw2kJy8DO77r
	3L0+KoMAyszHWH6wJdH2zNtWvR4IboU3HFfPc9UQqXHKvnxruzTN/tsc4G2EMT4VRcP2FINR7pK
	7e8T20n8mq/USYO1OT9XogyzXriVzJcQ0C+D1dy0OpOe7qPbSO
X-Received: by 2002:a05:6870:45a7:b0:447:7ad3:329b with SMTP id 586e51a60fabf-448117a48f0mr1755480fac.6.1782389156755;
        Thu, 25 Jun 2026 05:05:56 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472e79af8fsm11123405fac.0.2026.06.25.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:05:56 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] NFSv4/flexfiles: report cancelled I/O as a layout error
Date: Thu, 25 Jun 2026 08:05:50 -0400
Message-ID: <b5ed2050a2fa573ad9a2bcf7769f23397e480f2a.1782388900.git.bcodding@hammerspace.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22834-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:dkim,hammerspace.com:email,hammerspace.com:mid,hammerspace.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E12246C5626

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
index c4aa995026f6..c8072f333236 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1543,6 +1543,17 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
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
@@ -1553,6 +1564,15 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
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
@@ -1572,6 +1592,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 						  lseg);
 	}
 
+out:
 	dprintk("%s: err %d op %d status %u\n", __func__, err, opnum, status);
 }
 
@@ -2462,7 +2483,7 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
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


