Return-Path: <linux-nfs+bounces-17006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 185BACB01DC
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 14:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A02813005A81
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB027380A;
	Tue,  9 Dec 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvZ4R2QW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFB285CAD
	for <linux-nfs@vger.kernel.org>; Tue,  9 Dec 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288597; cv=none; b=TQbDUx5yAAsEXCxImab5aCYiOQ/51QiOLtERElFSDy/nACfXxla8BGnJhA3OkkvkjMgtPL5zUqcqvnpKorg3A2fcxta2qy+BJ6jBSpPbxZy+tUGgcOT/3RNXJwkIu3lzhIVN6qZxGu/RgDyJBVaZFa9rSzNqbv22QwuUzWHNf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288597; c=relaxed/simple;
	bh=DDo+cKxTkb5ZWvas2yqnIp0nDs+AXNSlAmtNYMUN9n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7hDcJ76TOQxbAJQ+cQP1bUBhz8Wd3XCFqElyIhfkZ4UUYBu+Pj6ant7bdse9XzQfbS4aTMZbV/krtcRf3Zn7+OLZfiFDAvPRCzF3annYvS4xWremzewYTk6s0j8SW6tPYz8lqC9lOe8tndsio33YVPluje4Js7EOpwcSuWXJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvZ4R2QW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b2cff817aso482682f8f.0
        for <linux-nfs@vger.kernel.org>; Tue, 09 Dec 2025 05:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765288594; x=1765893394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyJc1SZYiHDio8qNRqD/ZJgwhbMfnS6ETYolR/1zdAU=;
        b=lvZ4R2QWosenUamKdaKqGRrQ+uBtfW6HYfA3WfrurKvh9X4qtYKYcp0pJTWF1m9PRK
         fLrXgznYQWDzwFy/Wyi7+lB5XERc4DAvFfRsyZnGbrPYy1xxwmYYUehYXpMv5PLtdVBp
         GwDF1ailH8W6uRz16WHhvaLeFfo/GdUPosxFCGVGMD46waycpspd8eN4ByaY4Zyek35h
         wqT4B6dmWKgw4N/v9qFSI6cy0yEm7fkllIBiiwU2DUYzKRKRjNz2yOlVP8I2dTXocsEZ
         JQetPyMYrVDTTR+/lNhE8qwxZwUVvAJe1a8usGN8X4YgwvMETNNgeMPFmNYHoGX7B7sl
         AjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765288594; x=1765893394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyJc1SZYiHDio8qNRqD/ZJgwhbMfnS6ETYolR/1zdAU=;
        b=K2U5TPEi5Lc6TihLUwctCUkvsuk/iARDpxTSsK4hh4X2E/im9piH5IhrLjrennWi+N
         JSIyrpt8PGd5fEWG5xu49+i250XEgti5C863fRXHeXYTYRIV2snpVEVITJtrhhwpOIVK
         DlNEVwyy07N4oTcKDL8uAM9aJ1BmKDxG/Un1xpjHPoZ4iXBVX9ePAmyKzhVEXRO0DwmV
         PBXnjvHh1zs9Xz8QbucJf0fDEudMzN94UJqucVtW/ij/cAxHcKFFUF4MYGmYNHtKjExV
         D+x+VA7yKEiDZzb3jj9dxjgtwSAqxviVJ3WqT3bbeumxGQND7NbsDNoerdZRUa5Us6kc
         7DkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVxy5LmuCmvOHBnB5h9IsG+RuFap0YnWd9cqDQ/sCxVL707HBeMwghYmN+C/eHNCuPC9KPupE+2ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VJmKKRaTMHpJuDtlHW3Gt9gGny6FFF8JwPdlhPHieGSs6G3s
	nEteXQqBknTGGSj4yQDg//gvYl9YO8ZZV5i+yn+97orqt9hxZEtibBPL1mwbBIaHBC+VXA==
X-Gm-Gg: ASbGncsOQSm3tuhoHPr1SjPxxj5Dz4DoUUsW/UibjxqCIhLkKAUEqE+vApuo8cKmpe3
	8MGOrgiW1UIS5TI6cU4YvGGBpGAPxuRTV2sEc6KNO8XbSRT65p0zD/j4RUYCcF7Kkf1zUqb6emU
	1rfN5cxZOOIHKPcF99q7kbworgrIcIRUe4dsHfQDEj1lo4AAbWNdC/S9xl4F2IVhgvQVVwzswmB
	23brXFL4ovKhLoCaOHdA1ARmw9E3AmJxtMgIuhrCkIStY1exaz+g9QkpXxhIKj9fABoqoBYWbby
	Do7ldLBcBtUl79vD2jQJ1kp1k/7YcQgSZQ+/oeRqQIARro9KltQPa7YokMfPL2xtfHSLGmqpJXt
	XaZ6h11Eg5ErVK3+1MgoclrQ0REa9Ar3wFeAjM9HGs+ev9z3HixEXtBTnSTvaFJq0iY0u2khhh3
	iuAvsQsIaLnnUATfJJj0r6D/Rq9gySCsOgbrASaCof2lYixvxQc02KfDW8TGJUSwMSTR1ZQG2H/
	ZS+e2yxzkRwcaampHKlGMauJuQ=
X-Google-Smtp-Source: AGHT+IFExbUUinOx5olBapVOFt8pUpUWbWpQrJAIGGIbJUmmV7d7OKRw6VaHLwCyPDpJ/ONTsM+01A==
X-Received: by 2002:a05:600c:46cf:b0:477:a977:b8a0 with SMTP id 5b1f17b1804b1-47a7d69abf0mr14209385e9.3.1765288593608;
        Tue, 09 Dec 2025 05:56:33 -0800 (PST)
Received: from Mac.localdomain.com (walt-26-b2-v4wan-170690-cust332.vm13.cable.virginm.net. [82.19.157.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d2eb5a2sm20521545e9.0.2025.12.09.05.56.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Dec 2025 05:56:33 -0800 (PST)
From: Robert Milkowski <rmilkowski@gmail.com>
To: trondmy@kernel.org
Cc: anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Robert Milkowski <rmilkowski@gmail.com>
Subject: [PATCH] pnfs/filelayout: handle data server op_status errors
Date: Tue,  9 Dec 2025 13:56:20 +0000
Message-ID: <20251209135620.27492-1-rmilkowski@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Data servers can return NFS-level status in op_status, but the file layout
driver only looked at RPC transport errors. That means session errors,
layout-invalidating statuses, and retry hints from the DS can be ignored,
leading to missed session recovery, stale layouts, or failed retries.

Pass the DS op_status into the async error handler and handle the same set
of NFS status codes as flexfiles (see commit 38074de35b01,
"NFSv4/flexfiles: Fix handling of NFS level errors in I/O"). Wire the
read/write/commit callbacks to propagate op_status so the file layout driver
can invalidate layouts, trigger session recovery, or retry as appropriate.

Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/filelayout/filelayout.c | 54 ++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 5c4551117c58..2808baa19f83 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -121,6 +121,7 @@ static void filelayout_reset_read(struct nfs_pgio_header *hdr)
 }
 
 static int filelayout_async_handle_error(struct rpc_task *task,
+					 u32 op_status,
 					 struct nfs4_state *state,
 					 struct nfs_client *clp,
 					 struct pnfs_layout_segment *lseg)
@@ -130,6 +131,48 @@ static int filelayout_async_handle_error(struct rpc_task *task,
 	struct nfs4_deviceid_node *devid = FILELAYOUT_DEVID_NODE(lseg);
 	struct nfs4_slot_table *tbl = &clp->cl_session->fc_slot_table;
 
+	if (op_status) {
+		switch (op_status) {
+		case NFS4_OK:
+		case NFS4ERR_NXIO:
+			break;
+		case NFS4ERR_BADSESSION:
+		case NFS4ERR_BADSLOT:
+		case NFS4ERR_BAD_HIGH_SLOT:
+		case NFS4ERR_DEADSESSION:
+		case NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+		case NFS4ERR_SEQ_FALSE_RETRY:
+		case NFS4ERR_SEQ_MISORDERED:
+			dprintk("%s op_status %u, Reset session. Exchangeid "
+				"flags 0x%x\n", __func__, op_status,
+				clp->cl_exchange_flags);
+			nfs4_schedule_session_recovery(clp->cl_session,
+						      op_status);
+			goto out_retry;
+		case NFS4ERR_DELAY:
+		case NFS4ERR_GRACE:
+		case NFS4ERR_RETRY_UNCACHED_REP:
+			rpc_delay(task, FILELAYOUT_POLL_RETRY_MAX);
+			goto out_retry;
+		case NFS4ERR_ACCESS:
+		case NFS4ERR_PNFS_NO_LAYOUT:
+		case NFS4ERR_STALE:
+		case NFS4ERR_BADHANDLE:
+		case NFS4ERR_ISDIR:
+		case NFS4ERR_FHEXPIRED:
+		case NFS4ERR_WRONG_TYPE:
+		case NFS4ERR_NOMATCHING_LAYOUT:
+		case NFSERR_PERM:
+			dprintk("%s Invalid layout op_status %u\n", __func__,
+				op_status);
+			pnfs_destroy_layout(NFS_I(inode));
+			rpc_wake_up(&tbl->slot_tbl_waitq);
+			goto reset;
+		default:
+			goto reset;
+		}
+	}
+
 	if (task->tk_status >= 0)
 		return 0;
 
@@ -196,6 +239,8 @@ static int filelayout_async_handle_error(struct rpc_task *task,
 			task->tk_status);
 		return -NFS4ERR_RESET_TO_MDS;
 	}
+
+out_retry:
 	task->tk_status = 0;
 	return -EAGAIN;
 }
@@ -208,7 +253,8 @@ static int filelayout_read_done_cb(struct rpc_task *task,
 	int err;
 
 	trace_nfs4_pnfs_read(hdr, task->tk_status);
-	err = filelayout_async_handle_error(task, hdr->args.context->state,
+	err = filelayout_async_handle_error(task, hdr->res.op_status,
+					    hdr->args.context->state,
 					    hdr->ds_clp, hdr->lseg);
 
 	switch (err) {
@@ -318,7 +364,8 @@ static int filelayout_write_done_cb(struct rpc_task *task,
 	int err;
 
 	trace_nfs4_pnfs_write(hdr, task->tk_status);
-	err = filelayout_async_handle_error(task, hdr->args.context->state,
+	err = filelayout_async_handle_error(task, hdr->res.op_status,
+					    hdr->args.context->state,
 					    hdr->ds_clp, hdr->lseg);
 
 	switch (err) {
@@ -346,7 +393,8 @@ static int filelayout_commit_done_cb(struct rpc_task *task,
 	int err;
 
 	trace_nfs4_pnfs_commit_ds(data, task->tk_status);
-	err = filelayout_async_handle_error(task, NULL, data->ds_clp,
+	err = filelayout_async_handle_error(task, data->res.op_status,
+					    NULL, data->ds_clp,
 					    data->lseg);
 
 	switch (err) {

base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
-- 
2.47.1


