Return-Path: <linux-nfs+bounces-1420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD1783CCEA
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327C9B23969
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38F135A45;
	Thu, 25 Jan 2024 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JMQaxR8s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E771350EE
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212429; cv=none; b=GvZHfbgpAwgfNHxDSJO9crZZsTbiTsEvvDu+XJf9JyGsmEPtt3Zr9u1PDzBQ5TKN8uVQxesxr5A1WNvaSmmwPMYuGe7ilrVSRIOdWhMsMPfCt8KGu3jUX2QhrPxXYL906DQKdxqWDE7jROvII27+2IEmAKp9rl/pEL7BKYXxWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212429; c=relaxed/simple;
	bh=3SsWqV/5EIVOO4foAtM76z534ziowrHVUYxtts28L8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+fDhsi55ANUhLPlsjezTZf8+FX3qUKOfY6oKasIKiKV3McNl9LBvHC/fSs9L0pVEmah52o+CvsOtLlGD6nZDw4garTnsYxISpX4YoJiLU9RXf6IzKAuvs5vthCw1KXhaJusCxN2Y9WHeKaEEDcYdF9QyDEhuc18lwCjB3KiZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JMQaxR8s; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc226bad48cso5172344276.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212426; x=1706817226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAC6z9QLfDSrDi4k1JAIOPF/ceu4/dSJ0FAYR6smJ0Y=;
        b=JMQaxR8shOJcZcsV8fmZIjTwsy07T3ZArmJFtkiu8E57MnWqNWP5gZqmQPkZp//Xzb
         Rn2p6JTUSiz3VIfugVrDBiM9vVI2vhlx3wGbk0eWMfNCz3eXEnTolz+SKgm1ueoM33Wh
         S3C6VwoFPtY0AkAVYq89m8U+1LaQ6Lv7tD2WPTaBXShYlUsxTSFPmUMPVHdpAS2fecy9
         7BCSkWRMKKIW9iDOn3LCmBTt44X/p0MsLXSpXdIQXn2e86RuInMVCmqsIKSIh3+dWlaR
         Yqzi8ha/7LS6ZnR1iQOFXVdDQtKTWZyC7XydJzxYTNOkxqvTlm21AMPvSW3N/YmHXNL5
         ZeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212426; x=1706817226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAC6z9QLfDSrDi4k1JAIOPF/ceu4/dSJ0FAYR6smJ0Y=;
        b=W/51I6ZHs4N/5WMNQycjFbLr8QiK9iWelCF8eGRII9N5aA1NOav1JkPdKH4fKYYP5F
         QwgNMJBrdPSonWID06MSPhnETEk8frcai5yqzqb4ECqxj5BYCNqqIAu8ODIPIWN146nL
         TfEwnpnqiczvTA5rtgevkbp1rvz3RHWVqtEaK8W7XpW5IXnmlHVCCdIHDSlUbNqL9QwE
         X/ALvL7VuW1wX+FsRMFMULHyjUNU+07eZ4uyHZkv8CXT3a8ajgr29If5XuQl1Wo+ZKD0
         ju4yTlfhxxLhmy0RQndKcqP9epa9g5FYmB2po2c2w/iIjFlMZGsPnJSHIrqyzFiU430t
         wviw==
X-Gm-Message-State: AOJu0Yy7tk2rhGweaxQ33iivASnseuf34uZ1hHV226tCubO9tkkYQ5Wm
	n8pLUmBv2U4b27e5hV006jPaKKtdTuXmcCqORdkSDEgzjcoZKReILVnDXrfgZ0CNnt1bcFrZOJ7
	s
X-Google-Smtp-Source: AGHT+IEIOiPRjx4bgmHMLRKhEdE6J7edCtBZvrDGcbBQOGw1xkABTl2Lu3tgyf02LRJ1bJ8qIy+MGw==
X-Received: by 2002:a05:6902:2806:b0:dc2:65e1:706 with SMTP id ed6-20020a056902280600b00dc265e10706mr416409ybb.74.1706212426123;
        Thu, 25 Jan 2024 11:53:46 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d82-20020a254f55000000b00dbd9eee633dsm3701478ybb.59.2024.01.25.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:45 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
Date: Thu, 25 Jan 2024 14:53:20 -0500
Message-ID: <0fa7bf5b5bbc863180e50363435b5a56c43dc5e3.1706212208.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706212207.git.josef@toxicpanda.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the last global stat, move it into nfsd_net and adjust all the
users to use that variant instead of the global one.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfsd/netns.h  | 3 +++
 fs/nfsd/nfssvc.c | 4 ++--
 fs/nfsd/stats.c  | 4 ++--
 fs/nfsd/stats.h  | 6 ------
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0cef4bb407a9..8d3f4cb7cab4 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -179,6 +179,9 @@ struct nfsd_net {
 	/* Per-netns stats counters */
 	struct percpu_counter    counter[NFSD_STATS_COUNTERS_NUM];
 
+	/* number of available threads */
+	atomic_t                 th_cnt;
+
 	/* longest hash chain seen */
 	unsigned int             longest_chain;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index d98a6abad990..0961b95dcef6 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -924,7 +924,7 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
-	atomic_inc(&nfsdstats.th_cnt);
+	atomic_inc(&nn->th_cnt);
 
 	set_freezable();
 
@@ -940,7 +940,7 @@ nfsd(void *vrqstp)
 		nfsd_file_net_dispose(nn);
 	}
 
-	atomic_dec(&nfsdstats.th_cnt);
+	atomic_dec(&nn->th_cnt);
 
 out:
 	/* Release the thread */
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 44e275324b06..360e6dbf4e5c 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -27,7 +27,6 @@
 
 #include "nfsd.h"
 
-struct nfsd_stats	nfsdstats;
 struct svc_stat		nfsd_svcstats = {
 	.program	= &nfsd_program,
 };
@@ -47,7 +46,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_WRITE]));
 
 	/* thread usage: */
-	seq_printf(seq, "th %u 0", atomic_read(&nfsdstats.th_cnt));
+	seq_printf(seq, "th %u 0", atomic_read(&nn->th_cnt));
 
 	/* deprecated thread usage histogram stats */
 	for (i = 0; i < 10; i++)
@@ -112,6 +111,7 @@ void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
 
 int nfsd_stat_counters_init(struct nfsd_net *nn)
 {
+	atomic_set(&nn->th_cnt, 0);
 	return nfsd_percpu_counters_init(nn->counter, NFSD_STATS_COUNTERS_NUM);
 }
 
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index c24be4ddbe7d..5675d283a537 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,12 +10,6 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-struct nfsd_stats {
-	atomic_t	th_cnt;		/* number of available threads */
-};
-
-extern struct nfsd_stats	nfsdstats;
-
 extern struct svc_stat		nfsd_svcstats;
 
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
-- 
2.43.0


