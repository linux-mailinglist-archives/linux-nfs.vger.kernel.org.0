Return-Path: <linux-nfs+bounces-14930-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F0BB5E96
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 06:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D337D19C6142
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 04:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED52010EE;
	Fri,  3 Oct 2025 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPLD3Ddt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4F212566
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465953; cv=none; b=bhyFmwCOeolJ78y/PGvD3iyZLjq3BxK8kdKYrNT/F17jcC381U127Nrn4nQu9JAf7MUH8F6trvst3BscjjMdpCH8EiR9OoSh+bpBd0YNfvuW6AETQ149MuwA+ABf4itwtDFXp4Zr7eedbrJDosDQZZxlBE1dtTOsJLPYjzMpF2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465953; c=relaxed/simple;
	bh=7VMPKWz5uYNRKWr5qHgYxgxuacRdmA+VUVAZxwMcJxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TupkcGVVPw9TzdSTgps5Q21kwni8TKRNbD2hDIu6V50SYNMtSIO1+TpkBGFiiJKqB8wJV6xgbfO+d+c9yypSk/Sq8ljeMhN8wM1VSgFWqSmCdtRIO9bggTI8cRrkZC9zYHiNEE014Bzj20lSeEFae0SJ9RK7GyyKsatA3K9X6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPLD3Ddt; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so1210120a91.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465951; x=1760070751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z24lKsLPaefpARjOZTyt8urU57ilAGB24wkoWzevBy8=;
        b=BPLD3DdtB8ezPycD7XV3c2ksupBMXIpPLNXQFJ4fnB4qJJGkL9lu8iUiIqg43OJCSn
         fvX/Ymv4ymYTXYEejadMn/MKhLI3GhPNwY1jYT43Y53la8sjKYvqI+IAf9LxftAnbI2U
         xP+NwaMJb6bhCYTMwFCi6q5Tnu8JO753X+Lr4ddfCraPBWOz2fYFovDUb/LClNhWxu4U
         /y70RHJl5VDQGp7CsZhi2FjF15MNtCI+UeMEzjm8XYkrGCwTOjA4r9uOXncxmQtND3K7
         vT3jkq44UdKrRkSzY/pS5mSZh6WI6wFZRW4fMyfppsdHx9Naxxhl7kicLSXNY71LUBgV
         +6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465951; x=1760070751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z24lKsLPaefpARjOZTyt8urU57ilAGB24wkoWzevBy8=;
        b=gWlEJQZyio85S9quYBLisSQLC3+sqex9d8++MdSYzMvgKAk+smzsKUt484t0IBV71p
         TEuF1SqIEqfdoQ/rXIvcT2RrMUZaiPEVF13hftpxbzTYV7iIcrTVRj3Cer0+sYCtgawl
         A1QEHNvj8SoWxLWZr3FVa8gbgykJiINv8zde9yQws543wCSIuZYwK+EVVnsc/fBwCoxv
         q0XNYP48S/fajS6ruDNTvA5EIOisVC/8GAGDcx9EyHp5ydZwnddRh1/aC4fAywyC0iI7
         /AG8hSOYy1SzCXYSmBlPm1RFYJ/aq1nWEZ4ebFPnWi/bsnxfiQ7zjfAYIXnCUS1M+WHu
         rbGg==
X-Forwarded-Encrypted: i=1; AJvYcCXYlSco3ryW5S6vaTzm9m+GoZORnUZWLlDtzq+GQkctferZcu9oqcpfBZJwsLp0vXRi40/cA6PU5R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTHEM7nH/ErOVhFhSA4z4Q6bvaU5dQGyRyHQqzOREtO2LRCbT
	xaBbm/nCfaraGbs4WU+hINmYaR1/XUkvy+rNfAG9nnmOgRFEHtk6ZtHH
X-Gm-Gg: ASbGncvA7PYfotOvKr9E/PMWtda/zUoHSUUyTArkixGuD5EiGufliyxqoLXPJyVayNA
	B13ZTL1uw/IOHQQlg4BGue+BE1JfWq+w1JTEoHFVRAPWUR2jGGvea/WoN+Pju3ZY46dz7gW6Ie3
	2/z6HCqgOzeBjiggU6sWOAC9TdrQrXLLS0u0wIzsPNeazbunk2JTSblX/IH/1YDbX2u5PntpPps
	qwbbQzLt003IlVKOppCXUi1J9JC+qJLn+t4lyqONUzCONMc2W1JKQ+7h3TrZ+R9xgl3GwXJtqPQ
	L9hEkIp2JEHJ1ZkWgaVhraIviiDiEPYOl2E1+0s3mE32rGIUcLJVd34myNLAO84R/z7XNrK+66v
	449FDadGc2WUGbgR8QXatBUPMkpXIYh6jMRAxrEl5O208tb6BVhm6sS0iSgW7PsDsKREQ4Xb1GC
	sivVX8jS1NDAjYEk0cx5+l0nRRCOTbpDl4iJLba270VTalITqI3PVc
X-Google-Smtp-Source: AGHT+IGILMEf9Tw/o2u8qdi5b+EnvPskNraurbyacR0IziRkBvpz30elIe0oEPrEq1mEn5hgoKypZw==
X-Received: by 2002:a17:90b:1b12:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-339c20c099cmr2180806a91.8.1759465950687;
        Thu, 02 Oct 2025 21:32:30 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:30 -0700 (PDT)
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
Subject: [PATCH v3 4/8] nvmet: Expose nvmet_stop_keep_alive_timer publically
Date: Fri,  3 Oct 2025 14:31:35 +1000
Message-ID: <20251003043140.1341958-5-alistair.francis@wdc.com>
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0dd7bd99afa3..bed1c6ebe83a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -430,6 +430,7 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
+EXPORT_SYMBOL_GPL(nvmet_stop_keep_alive_timer);
 
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
-- 
2.51.0


