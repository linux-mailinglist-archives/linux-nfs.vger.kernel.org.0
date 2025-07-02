Return-Path: <linux-nfs+bounces-12855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FDAF599A
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 15:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6D04A348F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0762127D782;
	Wed,  2 Jul 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTtEH+AI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EC279DDE;
	Wed,  2 Jul 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463199; cv=none; b=doo2gdLeC6+g1Rd+bYxk43x5XTafUqrzDph4o5GS/RSJFgD4YbP5gduzR8Zc9vU2HydsHengkoSzCZitSMZGJB85yN+qQIehqCJEpjnWe/MCQ4YPrwFEiTnfmNNIFdOCS8TygBeOk3DptBfAGBjyxjyt5BlEJ3E8QLFg5uK8grA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463199; c=relaxed/simple;
	bh=m73SrJe9xK4ND8q0YawG5Yh5XCh7jqbD7zPC22rjn1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8643mZ/QPICrA/gA5PGb7VIuvgK3ppgKZA6vAGvQQ6DM+rekr1vJ4FdeVBSHEnHI3EyMb04efaZLZT5Cfjka4tDEYojT0N95OFFgKUCkVH7VBlFHancwAu92tP/8uqdJuSTwvcT7+9PJhhQEb54T/n//NTW5RbC1Ex2MEsgjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTtEH+AI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so8607574e87.1;
        Wed, 02 Jul 2025 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751463196; x=1752067996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rMtgRnDiBAM4XVarNEG1UtN9Q6JeflagLHeOXHOrlZE=;
        b=MTtEH+AIpOnyKncJM4mwdwhneood1XJ9o7VlJXXg3+NlsKn2Gkvm6lZiM9l2C0+FyR
         wvA9JWwBnTf/pku7T4KJmq4JPi/SWH/KYlwLkh+nqZv5Tt9AnEPlb3Y0jWGR464l8gHF
         I732qgXBEvp5eAPgmLsDVzHedO4gf6ByvImh0dbr738QzS15HbNoV8nqFwoM8+gow96A
         Ba0Ke3ST6pT0oEMusQyrSQ0RvPsqkIXGAVS1YbBZhc8tHbFRnmI45xon4zjS6IPuiaPw
         PZvbhqD6DWrF5JEm1ukl4ElYPBP2NGVsoV3pRjGlGGIiYsZy4LDw5DVjPjyWKzFAnkI4
         GvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751463196; x=1752067996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMtgRnDiBAM4XVarNEG1UtN9Q6JeflagLHeOXHOrlZE=;
        b=tQOOxniFlDq8YkHtAniFNL0yGtutwVbbFbBPMdL7yGHchBY5cV7qHW89X4qoGiiLqC
         vh3EtuYwgXslfaCi55qFIdzj9EsDxf9/7bpXc2LAgU0a3Gq3jY0zTbtrUVPEb2GuKlI5
         m5TpprVEgci7jzNbo7Yd8ZaAufSgZydihBpB7Tyw53O1ZYCW8FlR10QlFjue7rPw8FhY
         vvWS4qFPCmWYADcq8Gmh5tvFteuWthNTTzZOs+1R1r5FZP/pDXbEjGX38cJATfbOOHW7
         7++SBVSdI+3Udpo7KfNH8Kr2rTJ2TEwiL1pjCG7kBS2tVWfN2lVzTcSe+7bR4HS9Ifbp
         cK8w==
X-Forwarded-Encrypted: i=1; AJvYcCXvu2UCKCCeX9PRZPZaNzegidMt7jW/OVugrXaym3XfHcBl4fs+ZgCzegKfacta76uPT/JS86nc42TTNKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdsomW7mTPCJ+/2tX8zEopQ0oe5QjzwU3KoV2Nbqf7NyNYPta
	BaqSX9ogEWxcA2T52KojspKepZ+9ijVT1S1ixZ0XmcAmj5X+t5fAJxXA
X-Gm-Gg: ASbGncsotR9mNttgJYdwABkH1a/yPLGmj5zIyfIM85FiMsrZp2ymDb0DPgkMOWdeSft
	/ORUhnavatTkUQta1x/HTYelYMn8HZh/LAKgyormhTEdWJbetTLl2Y6VKOMFAr1ha29ioNJRMsq
	VMbrrE9bfZAG258pevznykPjyAJ3FXUdTB/wpaDCmjmCyU4rUdJ9bHxTcVgeohhGozBeDCReoZS
	Q4EHT5Elkw72ON0MsfdJompn5DGigTXAh+HHWNPlvrZ0A3uvSH36sm7FWWIDbk7W2/WlzgndTQO
	HTsd+nMW9Q/qJ/2FPjaJGFPvTDh4YfMZ8YVacHciTSiBIbtlzYBbAYDG7Xnbfkn1uJj220E61RH
	6lz5jUsC0NNHA1w==
X-Google-Smtp-Source: AGHT+IH6PzjiqqGXg3RonE8QCL7askIRZwW0UMnw53TSZ2jCDf0Z/9L8ruPAnI1nkkIVpcqHhmg8oQ==
X-Received: by 2002:ac2:4f13:0:b0:553:2159:8716 with SMTP id 2adb3069b0e04-55628f1c34bmr1082796e87.26.1751463195923;
        Wed, 02 Jul 2025 06:33:15 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.201.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b24e431sm2153712e87.72.2025.07.02.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:33:15 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH] pNFS: Fix disk addr range check in block/scsi layout
Date: Wed,  2 Jul 2025 16:32:21 +0300
Message-ID: <20250702133226.212537-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the end of the isect translation, disc_addr represents the physical
disk offset. Thus, end calculated from disk_addr is also a physical disk
offset. Therefore, range checking should be done using map->disk_offset,
not map->start.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfs/blocklayout/blocklayout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 47189476b553..5d6edafbed20 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -149,8 +149,8 @@ do_add_page_to_bio(struct bio *bio, int npg, enum req_op op, sector_t isect,
 
 	/* limit length to what the device mapping allows */
 	end = disk_addr + *len;
-	if (end >= map->start + map->len)
-		*len = map->start + map->len - disk_addr;
+	if (end >= map->disk_offset + map->len)
+		*len = map->disk_offset + map->len - disk_addr;
 
 retry:
 	if (!bio) {
-- 
2.43.0


