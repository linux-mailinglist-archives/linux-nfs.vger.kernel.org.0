Return-Path: <linux-nfs+bounces-14473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7C1B58D73
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 06:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4028648319C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 04:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4682E7BCF;
	Tue, 16 Sep 2025 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Xjumc0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052C2E7162
	for <linux-nfs@vger.kernel.org>; Tue, 16 Sep 2025 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998151; cv=none; b=UEKhPqqPUU6kR/zWlxbnMmE9U0Gh96i/4LcRAKy49TdJk6xeir1fLe3r3Yua9OVoj+LlAI61CL4JgWJZvf06E/znrMySciifZTuxCWQUQLXyfvteM3cvCeYchSoupYiU7kja7y66VTtbCHAdY01hmbOxBZgA8/WPWNl8PG8WdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998151; c=relaxed/simple;
	bh=A1DaGpRAAYNdE/JnkBcpbGGz1TWyQSRA1+c5fRETaCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9DmOHhQMEVGANZzuBnsusYAa6+0b2TnwpiKTsLSO1vnhvFxctJX4+a3GVs4vF/7FqzEdTyLcMLLbfT+m5WCWQCDiQfAK/0jkR8m+qhlBNWuyZB3aweeb5jPfTjP5DOPx3EkNN5+QfOkExrOvvQawURpN+dKEBt2UAy2/cnMgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4Xjumc0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54acc8c96eso3347757a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 21:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998147; x=1758602947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp+N7RFYdL+M8U5Aod5ZJl4PoDAFL89oD30EaW4MsNY=;
        b=K4Xjumc0nBcco5KyK7TayYg1GVB3J8fMW7YfmCjhgTTUc/fPIDKia1bI2dpOo4Dlpx
         o0oYiCFoIl/qnLukCt0JaKCTycIs9+9f38sOAgldyz8tQIGpDGM4I5xSF1yz9foe5Y+0
         2p4TuTz/xI8E76jU6e6NUTzqr4tF4KFkj0cyt03nQJvtbqEvTMv5/6XrYgnXmNQLeb+O
         sDFNMQP/6B3RWiK8Q1KWu4oWPdcxqbwd7gQ0AyvjLj19qMjmrrjdeeVtI4h+aCXWk442
         XnCfLw3QPsQeRmrhv0yiLaCyo05omJolYFv4x6BgsEMJUeoyH1rHSkFxKz1mCDro3W3Y
         TL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998147; x=1758602947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp+N7RFYdL+M8U5Aod5ZJl4PoDAFL89oD30EaW4MsNY=;
        b=ssaygIQrBKe3qdD4i/ICNtWYNyfG+WAHq0LQ+1GzoOaaA9d6FayFGKYGsjB6ECzt+F
         AsMHbivZlr8eBJsUKahm3VLYDtwGJ8eWyEvyGF0XPKaxUZ8VMd6YUKMGFKWhO0Rq5B0N
         Fis50THonUXV5flXJqXexWI1s/dixOD/RYF09dg+dXRw5xY089Ok7hSVdMAamn3AVaGA
         JH5MEv0iURLrqs4mdH9Cb/m2ClMVhTnbpQbOB5ZFT6mD+oU8ZU3upBvSJF1LyFUR5rY2
         d22ay9lA/ShenQF2SN8oamnFlS1iTTp1AFD6vtv7TIyR+sO8FrF0UjAGC+BYBbL3j0gP
         rVsw==
X-Forwarded-Encrypted: i=1; AJvYcCUZmdwvsOWhTb6eHwuFOuAcvHnxlTTrf4nHtotOSlalOtuO6fJFZU4jt1Pe/LMc6Dz8nMbkZpVz1Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3M6IKTQhW+JilKiIFyRrNQShSoLHow7OCNmUvoSIsTZrNqUOl
	lFBdajGccC0qLayJA9N7qHmEkEQEJ6fM3vln9KuFTOxJOGPQx9bnj7qD
X-Gm-Gg: ASbGnct9s9cJH52MMwezSk4wSsElhu3dvsX/PMhNm37r/mtsSoSVp1YIYsFxHcx5OV4
	2vEvaGL+qM+KHW27wxG5RB8QU39c2UVyp7yh9eNbXUEMdx4SWPFiI9hIm+OH4h8qOS9IKEp+BvW
	eeeWjZW6GpEcnbeXpLNfpTjhVY+qjdpzxJtlPluSHyiFGvhhlZbtSnhNMqBvbcH23ISBc3mFMLR
	rvpItZtJwTuMPGgRW+qRJTMCGjxHGhhthij5waxc2AEszvJivOGgBGqdBkL/WA/Nlx3goIzG1PG
	k8Xms+20RU6L5JW10Nt3ZSlc4wrlaKAQWr3XMRM5w44Y3Htc/wVCYPDgJG9zH9Wwj1lcY9JV4W7
	t9NrmSrQlJrxd+10S9+9DSagtDzNL9uEzx3xJyuA=
X-Google-Smtp-Source: AGHT+IFqD7sgMgos1nHHN1tffY5PC8RBagTW/SlAHYpHIH6iPNz9WSa7pJxkI6T7wvTsG+plknRS6A==
X-Received: by 2002:a17:902:f70e:b0:266:120a:29c7 with SMTP id d9443c01a7336-266120a3078mr75581275ad.6.1757998147150;
        Mon, 15 Sep 2025 21:49:07 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:06 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 08/14] cgroup: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:29 +0800
Message-Id: <20250916044735.2316171-9-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 --
 kernel/cgroup/debug.c  | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..db9e00a559df 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2944,14 +2944,12 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 
 	/* look up all src csets */
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	task = leader;
 	do {
 		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
 		if (!threadgroup)
 			break;
 	} while_each_thread(leader, task);
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 
 	/* prepare dst csets and commit */
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..81ea38dd6f9d 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -49,7 +49,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		return -ENODEV;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	refcnt = refcount_read(&cset->refcount);
 	seq_printf(seq, "css_set %pK %d", cset, refcnt);
@@ -67,7 +66,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
 			  css, css->id);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	cgroup_kn_unlock(of->kn);
 	return 0;
@@ -95,7 +93,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		return -ENOMEM;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
 		struct cgroup *c = link->cgrp;
@@ -104,7 +101,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "Root %d group %s\n",
 			   c->root->hierarchy_id, name_buf);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	kfree(name_buf);
 	return 0;
-- 
2.34.1


