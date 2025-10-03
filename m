Return-Path: <linux-nfs+bounces-14932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44681BB5EA9
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 06:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F2427BB0
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 04:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B819221B9C1;
	Fri,  3 Oct 2025 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF7xxG05"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6921ADB9
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465965; cv=none; b=bRD1SjtBcbBarYtAo4yKXVW6ZaQBb0A1pV4fZG6btjo/jEUHvi0OxWgiFgiOzH5QWvFsg0wTJN5HMcW8yhxMWrOVqzqVSfaSdvSLqUPe6UPqG7CiAeEUhfMtQKynnJisrQ67cv7utBk4KkOqKTKFgTaAL+CoocYKpywS8ish/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465965; c=relaxed/simple;
	bh=3UVQYHiEQ5R5MltmAyxrjBudfQCX1yI39rHghkihzo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JC0eUlPNuRCCtnsl7/m+YnAENVuueNJfIkusIgKG+OHOtlmIWv6ccNZRWWsbIAC8TDHGWq72S634jcgOszzalmRwUxx5bpB05lPRZQwvpnOfZgFIP7V8k9Q1kVtC0wAN7OW+6ot2Cc0d2lajH96pCc7tFuG9z+E2xCDeou1sTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF7xxG05; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so2484068a91.2
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 21:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465963; x=1760070763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUt0lx1wZ3OyjfIx3eBQc3LazcDXGlUQf7VsPfo32Ig=;
        b=PF7xxG05uYv1tozcMG+HMwkdYwVPMs9XLjEE0Op6dEnh9/grp2QFud7GN12N7SGK51
         20sgjf42px0lsXw+ClUkLNvJmi2FCYZo4u7AmBEhcFNz/NwGIICyGTUuhjOsms40F0H4
         GUzYjVgODYng8wsqQnYJM+WrzF6EoVKAll/huLIRi8nwcBykHWg2WMkqdRHlwczyHP5v
         BuS2krMKM6YUEEqWZc9MJlyWEBmGy59JcA+Nx0bTh6wEZTIvcRO2jgkOTrBWuciGOjMN
         FFYb48FfcWYrlqh5u4hAXC0/Zc8cpeIpoEHZNN1lmJsqX+Dt24Lt9onri74RHvcWnxwC
         YivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465963; x=1760070763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUt0lx1wZ3OyjfIx3eBQc3LazcDXGlUQf7VsPfo32Ig=;
        b=k0TMd/2GIP54sDI6etLMXoZcQcmssURVwEyq/WqcS8wuOohOgSDKaPeQcBXNsH4cap
         VlowUoeTRIq6QX3n/LQTfbui9nF6XlT7TT5QfS1WbxALx6Q3Lo/s+QVJfAvpGoHPtNOI
         Oi4jMVLJMRZyTDdASgFTu0gIQgUJjD3DBMCpLphvLG+EaYGat+eqQRSN78AW/62PBaKn
         xJ7SAmGVNCU10qnnawVLMYV8N2+VB+Qp4Ah5/hA6/kfO1NMFKuZ2r1f3wwxmv4JzTHXp
         n4PFWHgnWGkvPJjjTXN0zDJ76VsFXNzM9jKLhEi//Vm2Ch29MRIIh+Ylss9XDODG0hDq
         aAUw==
X-Forwarded-Encrypted: i=1; AJvYcCXHyJU/ei6XsRzw2sUzAwjFmdYMZzAjsd+y/b4qQxKwdGCoKxE0c8gZacer/oBzB7poQuIJwRlJgXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfrZBtFRC34GH+2PQhsWw2NXXumDwkpMU8xOtdHUBjcWflThw
	wA2/2Rp07e6IHRdkX5h8xDf9fPl90mvsvLk16SEUgAU4i+nz6nMpwDTa
X-Gm-Gg: ASbGncugTr5vcRfublBisFWFDk/3/fCxeJnV5CzggxKFr/IIYu+MLBoUtICLWuIYo97
	wnFriTTxvj2mazfgS72nFMZLtifriWHSpBxHc1L70VUFZXQXtNM4pZv7HIJ/pcFiRc/G1qDn8y4
	ajs9vQvEvtIds/q6Is+PR82ScwiIHdaN6Ms9mO3Q7acJTJuIuIxbZP4XcZ9o7a5iIP/Jr2dZlPl
	AXznQ7/CbDJQWaugGLXObeoQfTPwxZdws7C97YV2e5Td97vgJovwijl6J6I/5xdbuQTb/1uFBob
	CFqqBPkQx/fiDfjvzciu5c30U+u5v8+vIEICiZtXOV6vGOC1fKlT+JB4nVVQhjgAq+Rpa7VnN30
	SfLerzL+mJNac5m/Bj7HiMEfBjFqBMeHI/Hoqevpsrl92JjeWPDZbOSbs2y5MQhXj8UYuh+nqte
	YloRVJ3iIDOKWeukXtMNLBsPneTN2iIFDpxtqmHWS57gkM2AtqsIzm
X-Google-Smtp-Source: AGHT+IGhaBIUtKtuD6q+A3yD/rdltrPoLDs9xzkO82sKW85fbk3aQyiXoU7SizhTuE7KWD6NguZsNA==
X-Received: by 2002:a17:90b:17cf:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-339c274fd63mr2279693a91.15.1759465963241;
        Thu, 02 Oct 2025 21:32:43 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 6/8] nvme-tcp: Support KeyUpdate
Date: Fri,  3 Oct 2025 14:31:37 +1000
Message-ID: <20251003043140.1341958-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
on an KeyUpdate event.

If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe target sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - Don't cancel existing handshake requests
v2:
 - Don't change the state
 - Use a helper function for KeyUpdates
 - Continue sending in nvme_tcp_send_all() after a KeyUpdate
 - Remove command message using recvmsg

 drivers/nvme/host/tcp.c | 60 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b07401ad68eb..4f27319f0078 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -172,6 +172,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		user_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -211,6 +212,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
 			      key_serial_t pskid,
 			      handshake_key_update_type keyupdate);
+static void update_tls_keys(struct nvme_tcp_queue *queue);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -394,6 +396,14 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	do {
 		ret = nvme_tcp_try_send(queue);
 	} while (ret > 0);
+
+	if (ret == -EKEYEXPIRED) {
+		update_tls_keys(queue);
+
+		do {
+			ret = nvme_tcp_try_send(queue);
+		} while (ret > 0);
+	}
 }
 
 static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
@@ -1346,6 +1356,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 done:
 	if (ret == -EAGAIN) {
 		ret = 0;
+	} else if (ret == -EKEYEXPIRED) {
+		goto out;
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
@@ -1381,17 +1393,45 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
 		}
 	} while (result >= 0);
 
-	if (result < 0 && result != -EAGAIN) {
+	if (result == -EKEYEXPIRED) {
+		return -EKEYEXPIRED;
+	} else if (result == -EAGAIN) {
+		result = 0;
+	} else if (result < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"receive failed:  %d\n", result);
 		queue->rd_enabled = false;
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-	} else if (result == -EAGAIN)
-		result = 0;
+	}
 
 	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
 }
 
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
+	cancel_work(&queue->io_work);
+
+	nvme_stop_keep_alive(&(queue->ctrl->ctrl));
+	flush_work(&(queue->ctrl->ctrl).async_event_work);
+
+	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+				 queue, queue->ctrl->ctrl.tls_pskid,
+				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to update the keys %d\n", ret);
+		nvme_tcp_fail_request(queue->request);
+		nvme_tcp_done_send_req(queue);
+	}
+}
+
 static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
@@ -1407,15 +1447,21 @@ static void nvme_tcp_io_work(struct work_struct *w)
 			mutex_unlock(&queue->send_mutex);
 			if (result > 0)
 				pending = true;
-			else if (unlikely(result < 0))
+			else if (unlikely(result < 0)) {
+				if (result == -EKEYEXPIRED)
+					update_tls_keys(queue);
 				break;
+			}
 		}
 
 		result = nvme_tcp_try_recvmsg(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
-			return;
+		else if (unlikely(result < 0)) {
+			if (result == -EKEYEXPIRED)
+				update_tls_keys(queue);
+			break;
+		}
 
 		/* did we get some space after spending time in recv? */
 		if (nvme_tcp_queue_has_pending(queue) &&
@@ -1723,6 +1769,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->user_session_id = user_session_id;
 	}
 
 out_complete:
@@ -1752,6 +1799,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);
-- 
2.51.0


