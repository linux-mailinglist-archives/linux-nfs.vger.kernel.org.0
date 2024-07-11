Return-Path: <linux-nfs+bounces-4825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94AA92EC01
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6981C227AA
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECC8479;
	Thu, 11 Jul 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwJN54eF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB316C856
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713153; cv=none; b=ue/PcCKnJv4UjST5T45QQTi1CbU8BKiCdlb8bCe8OvVc+2kMqN5SOLz+KrxvOEvY93eD6Rm2jeNobtEPOnttUwR3UMi2lq5iamXMCgyvjdelk+gEJ9IrmHl6hx+Tu1BdAMUXNs7Q1nzUI7az67ymRAOW6fpFu7SHjLD75/haji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713153; c=relaxed/simple;
	bh=2q4MLguFzl9Av9BWNza8PfEcDFD43RZ/JY2+wWgl1TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEpoQlM7Z7UEzt54OGgY4aOaZKf28BEH2MB1No5nwNqHqztmFgVDSiyxI6L4C4pP+Y3mJrKZbBhUzIH5E4/4PWSzubv5mOtTCjbsYgEhHARJSNzN6gDs1QmEBtuMen3f3v3MsH0GBEZXouHM2f/e+G+zjpr/2wSuZxHzURLiVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwJN54eF; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so1058444276.2
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720713151; x=1721317951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dii1a8vBELo5bie0AVf64Osw//xbexhTZ6XrEjZHEc8=;
        b=GwJN54eFio8YHo8LOpd0yCJIzz5ao3gg/+x3XO3UBnwo0PAr1gyXSBbN6Id41S8LRf
         uVKqj+MnG62KXPkuf9VzTd/c2LHNXppkzEGjIBHNJstpqIEI6PsVkCIRih/A7IdU6yEZ
         Qt0C0PTd9iwfAQ07Od3a4hGf9qvAeAU927WP9BmpWKvcpSlC3ewzdVA8tCMseilm+L1e
         jgFSYnrsOz1ujKEGTqOH1flYNwE3qeJY6nQcCFBEZPEaKuA4ioyrdfMfm/5F12hfQDUV
         zGVXBx/4LtlCSnVYoPO/DhSh+QJP/KhFvtpbSouOQmI6/ZvzUSc6+eMp/mJQ8pBt3/SI
         BIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713151; x=1721317951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dii1a8vBELo5bie0AVf64Osw//xbexhTZ6XrEjZHEc8=;
        b=SXtkRSVZM/FGNeAFZHOTdYirII6mBy2mPoUpdJWHyMskHvRKXJimJoAtU1eqK+roQw
         cJnJwfP5GuDtg718rw50sJv90ie1G62pOqnBOmQ1J1I8UhDydaGgUVrP6EeQ3mnWdWn3
         QXSmPgtgFPa5VIuKElS89uXEXASW90SJuB6cDv5yZYDlMQeFDKRPuvQOmKm4kbEdZKcj
         LE7o2ZpkXQVEUc6kT0TaKfCvWQPYymeqllo3cxIvMpjJgkLoTqCBmnMe8eIr9gd33O8K
         rSJ9FjIC1rWlLdwspmu60fN6gGFbBHsXoXc9V1ClpiQRKD0iLWSMyMBJRGuxNDOPCfgJ
         FzPg==
X-Forwarded-Encrypted: i=1; AJvYcCUHdBDju/zGoGPypAudfy/4F/8zqrwGJ/ObaDZBfBMCjCq/qYjAS+Ex0gNBNPlr7v5iC6G/few9cEKSn1BB2EaJcCc3auYJBFNL
X-Gm-Message-State: AOJu0YwXxctkbGdKdyiWcSIVeX+1wMJ/tjEe8iANhxkpMu2YgXq10MLm
	Th30H2IOL2mfzcMEzcpzbU2PQ2BQVpob8dDoHOQbMn917kTFGBeUNbfxHA==
X-Google-Smtp-Source: AGHT+IFZ5pTQX4LSpD3vpSNvOLGpNBBtl95GWxWxYt0pRrVnpr2SbHB9n/VPtJiB0YPbOpyf3vDogw==
X-Received: by 2002:a25:e084:0:b0:e03:a5d0:b1e with SMTP id 3f1490d57ef6-e041b059475mr10517643276.22.1720713150579;
        Thu, 11 Jul 2024 08:52:30 -0700 (PDT)
Received: from ubuntu-dev.mathworks.com ([144.212.138.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4c0dsm26665846d6.15.2024.07.11.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 08:52:30 -0700 (PDT)
From: Youzhong Yang <youzhong@gmail.com>
To: chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org
Cc: Youzhong Yang <youzhong@gmail.com>
Subject: [PATCH] nfsd: use system_unbound_wq for nfsd_file_gc_worker()
Date: Thu, 11 Jul 2024 11:51:33 -0400
Message-ID: <20240711155215.84162-1-youzhong@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After many rounds of changes in filecache.c, the fix by commit
ce7df055(NFSD: Make the file_delayed_close workqueue UNBOUND)
is gone, now we are getting syslog messages like these:

[ 1618.186688] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 4 times, consider switching to WQ_UNBOUND
[ 1638.661616] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 8 times, consider switching to WQ_UNBOUND
[ 1665.284542] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 16 times, consider switching to WQ_UNBOUND
[ 1759.491342] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 32 times, consider switching to WQ_UNBOUND
[ 3013.012308] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 64 times, consider switching to WQ_UNBOUND
[ 3154.172827] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 128 times, consider switching to WQ_UNBOUND
[ 3422.461924] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 256 times, consider switching to WQ_UNBOUND
[ 3963.152054] workqueue: nfsd_file_gc_worker [nfsd] hogged CPU for >13333us 512 times, consider switching to WQ_UNBOUND

Consider use system_unbound_wq instead of system_wq for
nfsd_file_gc_worker().

Signed-off-by: Youzhong Yang <youzhong@gmail.com>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ad9083ca144b..e7faa373d45e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -111,7 +111,7 @@ static void
 nfsd_file_schedule_laundrette(void)
 {
 	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
-		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
+		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
 				   NFSD_LAUNDRETTE_DELAY);
 }
 
-- 
2.45.2


