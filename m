Return-Path: <linux-nfs+bounces-13295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30C0B14674
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 04:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525427A0584
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 02:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F9217648;
	Tue, 29 Jul 2025 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNuvCED7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7132144C9;
	Tue, 29 Jul 2025 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753757032; cv=none; b=bU2fiZWzrNY+jAVVOGVSWpmvDsNPDc1ZYYGZviKdMo5FU73mfb9XrpzDZO9RnIAAfWBy812hnO7zK8zfSFQ/bvHs80zrJe5AEhrPvK6/SS4CnkYusJsZFLzkLE8qCzoIiQOXWf/vgBmULuoG/mM2k8TzbG24eswprhl9ColFC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753757032; c=relaxed/simple;
	bh=l1v2UzDTGF6SZCH5BGbDUHWH2BX0eFO3PYu1YlOwF5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ3ERYwU03mSfbHMgV9AdS9eqbfmT9K1Wb1q0TXash2tY7Lu9G9w5Mcc6YJm/K891PEqVDRpw/grFAiX1HJpDtcBSN3yZg/TEA4JXh0VovIb6YILntOp+fxyCltvtk5YNl55x2Yx10VUtvpEALebUcF8n7D/xOaSUdMx17zT6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNuvCED7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2401b855980so14728825ad.1;
        Mon, 28 Jul 2025 19:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753757030; x=1754361830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKApX5AD9aIEi6uewJIQf4uaw0UGX/OqxGUTe4X6NvU=;
        b=HNuvCED7sISefPcBcZiqFxrua7D51BdEeqi2bA2Dl5emuUMZC8c4kEJX6pttSIWc3v
         H3QmHurgc3HG41XGn6oigHZGmWbhmclHTRKnBKOyc8jDNwZK6++/HGkiqXG9yYQ3Pqa9
         L1GORsGborJQUTGMRq9jL5K6LvwY1Otfnyj6GXOr/akqado1lgOGQ5gKqVWKrEkm0Hyp
         KmWiiCNw2b5rrO5ue+/Y/6/PbF3cfAZ3VXF6ZeBvHGFTKq8r35l0kgTcqJgO49Umuhij
         tSJAoaMLO9Rh062diHXkNpIG31Ga6Pq2tMnxCDdOig1ZkJi1iilBtNeGoeUlJBoy5NPv
         CS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757030; x=1754361830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKApX5AD9aIEi6uewJIQf4uaw0UGX/OqxGUTe4X6NvU=;
        b=pe3Vsyc+hAzU9z3DVUdGWnJLNMHa6ExIiG+BPgCbmC0upYZRNNTqhfpFyfp6A4xje8
         J2ELiTtdb8NuvAUrO5AsnC2YC5mCvqstDRqB7JYhkwGhP2F5bAKLPxMtG+S8/2qYzpRt
         8Ko+dEXcPgCJALMt+X6xr6xn2hBQcsjk6ZUveHl/AHSX0YDySZH+OMpiQdFCHlsox2OL
         GXBjn4hWeuD5WbT7oHzgevw/1/1eKs8dlMx06WO5O0Wu/NaCo/W9pmAvB2Geajmr9ccR
         ZETU+s1ugI4yz+2GQX9238pN2NYMKkU0MxbXhj9X8rlyJ5YgpTLvC0c/yxyx7lh7bL7v
         bRRw==
X-Forwarded-Encrypted: i=1; AJvYcCVUZrK1KcacLiLByju8va545C0a4OyL0vA5fR0WPYesKrJkbpqEY/7qosA9ZUyL6jC6duGdYuG9MYk7@vger.kernel.org, AJvYcCVkRVXFiQQKPLbvl7pdDcS7QZEq8jN9nYidBPXq9SpOmzPhzwSf5UBBaf62q7dXBY3z52x3UuSM@vger.kernel.org, AJvYcCWXbCHDOqWFSsx95Qi9NzO/M5dIXfDSpUhCyyEvR6NKXkLO09edPt8lauCfUTdqVyYrscrWlv989NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BuBP186yGNKQO4LMOiFDytyl0x0Bb6r7LoWfXUHiJhYpcP9q
	riw38jIJsjhD1iOWUk/nK6GBuAK4CFGWA1wKOy88I8xIzo/hC3gYRciK
X-Gm-Gg: ASbGnct7ejHBPd5Oj1ITd8dhuUwYG+RuN/ZtZrOB//zK89vwQc7ljs59k24wp8TXbL4
	wnhL46t42PWsPJY7VAEFrfRmw3K1kWiGVpDGXjIDKhUewAAzxokLUSIle+E+4SepkRU1slf6eoy
	CV6zJJTVbsIBRuJzB9UE9wWpsNd/8jFMlWv7DOYPdPFj0djZMcRoSiKtzu9uvIwaZrl67JiW5JR
	CW8N9kZbYZybrd4mFF2GJaaRCzdyQ4DO2LgHL9QXNA82anQec8/RXV6r5gFrAWyBmOQTPT4WtNG
	kbqc+GcNpVsQ5NWB+ogA2i/bZk3YBcmk0mUbtQCLuRV9nTZn+CDmW25f/Rvdx0ko4QYy0YjN9jb
	ZG1ref1bLQmMvQDqtsOW7TFQhqQ==
X-Google-Smtp-Source: AGHT+IHdjXTtHTwMGQwZ9/tvr6W/g4hhHNiDFkExB3KA8O1wMz4OUmUJOvFvEzI8mjgHYmK3eABYWQ==
X-Received: by 2002:a17:902:ef4e:b0:240:b28:22a3 with SMTP id d9443c01a7336-2400b282b9amr114633395ad.29.1753757030520;
        Mon, 28 Jul 2025 19:43:50 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:50 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 3/4] nvme/host/tcp: set max record size in the tls context
Date: Tue, 29 Jul 2025 12:41:51 +1000
Message-ID: <20250729024150.222513-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729024150.222513-2-wilfred.opensource@gmail.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a tls handshake, a host may specify the tls record size limit
using the tls "record_size_limit" extension. Currently, the NVMe TCP
host driver does not specify this value to the tls layer.

This patch adds support for setting the tls record size limit into the
tls context, such that outgoing records may not exceed this limit
specified by the endpoint.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/host/tcp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 65ceadb4ffed..84a55736f269 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1677,6 +1677,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			      size_t tls_record_size_limit)
 {
 	struct nvme_tcp_queue *queue = data;
+	struct tls_context *tls_ctx = tls_get_ctx(queue->sock->sk);
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
 	int qid = nvme_tcp_queue_id(queue);
 	struct key *tls_key;
@@ -1700,6 +1701,20 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+
+		/* Endpoint has specified a maximum tls record size limit */
+		if (tls_record_size_limit > TLS_MAX_PAYLOAD_SIZE) {
+			dev_err(ctrl->ctrl.device,
+				"queue %d: invalid tls max record size limit: %zd\n",
+				nvme_tcp_queue_id(queue), tls_record_size_limit);
+			queue->tls_err = -EINVAL;
+			goto out_complete;
+		} else if (tls_record_size_limit > 0) {
+			tls_ctx->tls_record_size_limit = (u32)tls_record_size_limit;
+			dev_dbg(ctrl->ctrl.device,
+				"queue %d: target specified tls_record_size_limit %u\n",
+				nvme_tcp_queue_id(queue), tls_ctx->tls_record_size_limit);
+		}
 	}
 
 out_complete:
-- 
2.50.1


