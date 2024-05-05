Return-Path: <linux-nfs+bounces-3161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AB48BC316
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B438B20D30
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAE25569;
	Sun,  5 May 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="SGBUQ2+5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E91755C
	for <linux-nfs@vger.kernel.org>; Sun,  5 May 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714934314; cv=none; b=uV1UpjsHLgUFEs6lYkFAtIsBBPPq1rozF0tHLby6NxnXGeJ8P7yXvUQMYjviKht8iuFrjR9a87uwYXr/D2HOfpHF1KfQIjsHhtW0IbjAisYtOE9GsGU5I0CRECtfw3k+ycW41LTm4W8bTe4F2YSbyXEmBT6ylo4aDo9ZPLi+BFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714934314; c=relaxed/simple;
	bh=iS+fwradBm35TkDyTjuS3CQoTsaoGLrMBXzFshmtYbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIV7lk0GMoubR+EnV7FStRvxhh4bxs5h0AqyGnDRf/uaxptKD77TxJXo9uBLMHbsQE2+NkJz15TBZeVDaInidc+Q1/+NNNN4NoLdn5rAPw9LnEuFD34YlTFktCIBRxhw1Z/xPQWVg5Ep7eSMWNjVIvVUtPCpfN7Hhht3WcD5xAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=SGBUQ2+5; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7f34ebbcde4so402153241.3
        for <linux-nfs@vger.kernel.org>; Sun, 05 May 2024 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1714934311; x=1715539111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJdGQ/gESnaB243sML9xdsnZnAr2OUffmaa7nku1eOk=;
        b=SGBUQ2+5/LsmDlItuNlFfwyMOSt1q/nMBuHQj8BqDnO4/6Pd8W+kp0oti85BOX+d+s
         /WrZdQ1Imq592xWw0g2QbqOxpbrZSz1xedytZLdP/PsnwbAqKkiwtoGvZKLFnPkk4QJM
         W4gmzNIuryCEzXkL9o9fWEW/C/Bql1Yjs2dWiqXey+9HXLg/5Bw/n176In+ZPCiWO+pe
         aagf3HeafCGJRkgqxwx8iz1pxzJ6Uj5yzyWhGz5EMTK9dztxQfNACVj+WtTB4hilMSLA
         cQ+ObcX5DW/ISW+L6mD5GUvAuoIRqUX1U1w9mPxB0feZcUYiTMUTrBDRAB+Pf61ZvUg7
         TBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714934311; x=1715539111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJdGQ/gESnaB243sML9xdsnZnAr2OUffmaa7nku1eOk=;
        b=xRopy7UChYCzfhdSmsM3qa8RIQLfLtdFjq9VcMR6/Su2Ju3+ItvJR0JRXXYBzhnZ83
         em/+BW+o4HCVwNjXmYyokmal/hqdiu4DD+EgCPiw+UBuFftmN+FWnUNLcspv2nzIGn7E
         f6ar3rnViFZnd5o/5yjxYfzVnpqOQKlb0VW1ckyYGhXsfXW+V0Gv1ObNHkKDzGkB38IW
         Z/osUaoFE1CwKcel1B9mQUTieKu+vQGJ25JYbAhKkM6isiYQJXNWSkz2LvefmEnfd5pr
         tC2gj0nb6Ztt02b0+jg62vrymBU8sf6EXeP53FFDoE6HTWDG1G0PKYRItPeAL4F+n8v0
         LqQA==
X-Gm-Message-State: AOJu0YwZeipacBbg8c3BRJUMRWiTymvyUplPn1EDQJLtcIXbgdWQtilU
	4+nPUUaRCWe5DKsg89ltTAvfTrGIhDCfMz46v4Ks0pNDMjAcHBNkbjFYQaeP8HsG7DXcm8YbDXj
	1
X-Google-Smtp-Source: AGHT+IFkW20OqJb/ryXt6k90HXvy22SmS7dZO2lDxYQPzUIN8OGFFjGkcONd1fHZ7oJhAXdic3NdQg==
X-Received: by 2002:a67:fbcf:0:b0:47f:1166:fa13 with SMTP id o15-20020a67fbcf000000b0047f1166fa13mr3571760vsr.12.1714934310946;
        Sun, 05 May 2024 11:38:30 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.220])
        by smtp.gmail.com with ESMTPSA id ew9-20020a056122494900b004d348293090sm928193vkb.8.2024.05.05.11.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 11:38:30 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] rpcrdma: decref EP only if ESTABLISHED and handle DEVICE_REMOVAL
Date: Sun,  5 May 2024 21:38:26 +0300
Message-Id: <20240505183826.2300475-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240505183628.g2hhzkrtna5asz6b@gmail.com>
References: <20240505183628.g2hhzkrtna5asz6b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under the scenario of IB device bonding, when bringing down one of the
ports, or all ports, we saw xprtrdma entering a non-recoverable state
where it is not even possible to complete the disconnect and shut it
down the mount, requiring a reboot.

If a DEVICE_REMOVAL happened, it may be irrespective of whether the
CM_ID is connected, and ESTABLISHED may not have happened, so we need
to avoid a decref, plus make sure connect path is woken up.

Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/xprtrdma/verbs.c     | 9 +++++++--
 net/sunrpc/xprtrdma/xprt_rdma.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4f8d7efa469f..43d7d6604c30 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -244,12 +244,15 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		pr_info("rpcrdma: removing device %s for %pISpc\n",
 			ep->re_id->device->name, sap);
-		fallthrough;
+		ep->re_connect_status = -ENODEV;
+		wake_up_all(&ep->re_connect_wait);
+		goto disconnected;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		ep->re_connect_status = -ENODEV;
 		goto disconnected;
 	case RDMA_CM_EVENT_ESTABLISHED:
 		rpcrdma_ep_get(ep);
+		ep->re_connect_ref = true;
 		ep->re_connect_status = 1;
 		rpcrdma_update_cm_private(ep, &event->param.conn);
 		trace_xprtrdma_inline_thresh(ep);
@@ -272,7 +275,9 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
 		rpcrdma_force_disconnect(ep);
-		return rpcrdma_ep_put(ep);
+		if (ep->re_connect_ref)
+			return rpcrdma_ep_put(ep);
+		return 0;
 	default:
 		break;
 	}
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index da409450dfc0..1553ef69a844 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -84,6 +84,7 @@ struct rpcrdma_ep {
 	unsigned int		re_max_inline_recv;
 	int			re_async_rc;
 	int			re_connect_status;
+	bool			re_connect_ref;
 	atomic_t		re_receiving;
 	atomic_t		re_force_disconnect;
 	struct ib_qp_init_attr	re_attr;
-- 
2.39.3


