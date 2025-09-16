Return-Path: <linux-nfs+bounces-14479-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0AEB58D98
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 06:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DE4188D592
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 04:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9034E2F290C;
	Tue, 16 Sep 2025 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL+Xia8W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94492EFDA8
	for <linux-nfs@vger.kernel.org>; Tue, 16 Sep 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998191; cv=none; b=JvnYVyosnBwRbN/QAoStcakYKq6eXJYPcqfAG6i5T+Ltk+KQAyF5c6O7lI4X31ui+oHm4Pv4a2fpF7tm0gm/LCTGSVRQryS6jtR1nYlrT3FksJyhdy0tYWan34jzAo7AXEAf75cDadrJusJcOn7nrFQnrL87Q9sv9QsU/juMBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998191; c=relaxed/simple;
	bh=slyVnZPzDDOXEcpF4QZOR3I7YB3yd3f7Gxtzb+FU87Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpbSRmJ8LwMjm8SZE21makvqfyPvPI+9De98y9uyzxSJZJFllAIGcYrKcsDfivTtMmtPSHjOmy3q8aLVjxBKM/U/kU/3Ii/vpb/wZ5++DVQTwySLW5c4M0cT3X8/KxqG3FxFVejXhwf41cjslcQHBdOxfa19cysfQn5PHhMijT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL+Xia8W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26763bb9a92so13926995ad.2
        for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998187; x=1758602987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=JL+Xia8W4uyroTDLgoFXQGcvga86g7+1VEKz2roIDSxQwxKuGGI1kJw0E5mRvO2QSO
         m/1WcvkXEpAacTm9jy5S7c5V4Dczrr3meBJOyddNip27HVCCCOgthvtb5FLtkxbvF41s
         iGlUzzPGymDg3T5amMQJm6PDCBR7n+L0ahtyEay0NJYWIu7m2vFg6tr2ajT32yaanfBd
         xDtJu+c4X/3CeTjTCyDCOh+jJ9IMVyUrOd4EWhGGuGTa3TWSp3+no8CtHQqAuwI3rWWA
         BuIdQSsCM/Xgm1YsJeGbAazZkNWV/RcrZ3PBFtpntXLtYH4Vrd8FCoda8o0sXcMxI94o
         +OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998187; x=1758602987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=a7mR2tV+bvLrUH7AT5/NMgDH/FqjbWwiDqjPYaVwBPAo7azPdCUMre+Gtqk+TXvY5T
         bssAkgVlF/3s+rYsTsCSLq63L27xd829/2fPDhluBJEdNJg3h8q+2kmcYhGYz0Xif2sE
         oGQLqpYj+XVbzTL27oKqppWA/TgQ+eJ4U1SeYP7jA4sCTGd01prs6NlOIPtT4QW2f0sI
         muvqMgt0AFRwQs5/QcyWLvsJAaZ6sipgChVStkGnaKR4eBrRRnHwTplYMr8I2MtGzHde
         dyuFvx8ioEukzwug2UEqWdN8tFAcLTfAMKEb76BmN8wNjUDIjOSWeruGfpHnoXtcCG1q
         1YHw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Z0cLpwaYg95mXswEfEe8f63AWTbSNfXtrPd8MMBGTuftwQ5EYBVspR7kMggRf0N49C5FkXIX2W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL33dwtvpO99vkH0YEnN40BOhnSmc4eD4ylw5GLFQJDhDKJgEW
	xLZ5chgfrHUQLBAJ0pHZeWcn9eeYdXmq8LulC9kC8sn2I/JE/1x0kcGc
X-Gm-Gg: ASbGncv1ThM1EPeLqtgWRmcwd5JrvigKywaL2fuC2Q5r/Gx8uqjA2SqQn1bUoxywuTp
	aF8IjHAoNjt5h9lydRIavoPsTZr8cawn7lNrsmXd+WrP6HBY1B7FtxTnAQgN+lrcRMEHGigG1Tz
	KDeskn46z1hPU/rv0qxRuhvFB9EIZy63ZNW98I/EAzSxLiGLIY+mJphS+fWDs5vd3t08OPHIB/y
	Nq32QimaOgso3JgBxiaWEYT956mjqUdq464q98FqNT58T2R0pc/SKEyaH30SBZ8qRuq4xyetgul
	G+HFYADJdF1iVGVjR+oOu9nclBUvB+6J5P8bPS0UiBXXn9YvY2Y9nDAiuBlYA7nGwow0WcO3A8s
	kn/8BqEPRqlvY8IUDdq5GLbDXQPLg+l4tyZlgGc/GJDSqqbLtMg==
X-Google-Smtp-Source: AGHT+IFV4zbzh4iycIfH4WDU92suC0bCanMglT0Ogl2GwpwL8kM68NHrYSygkh1AIkIcAzvJhqwslA==
X-Received: by 2002:a17:903:2f4f:b0:24c:99bd:52bb with SMTP id d9443c01a7336-25d267641camr179941415ad.30.1757998187203;
        Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:46 -0700 (PDT)
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
	"Toke" <toke@toke.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:35 +0800
Message-Id: <20250916044735.2316171-15-dolinux.peng@gmail.com>
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

Cc: "Toke" <toke@toke.dk>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 0ac9212e42f7..4a0f465aa2fe 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1993,7 +1993,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 
 	ieee80211_txq_schedule_start(hw, txq->mac80211_qnum);
 	spin_lock_bh(&sc->chan_lock);
-	rcu_read_lock();
 
 	if (sc->cur_chan->stopped)
 		goto out;
@@ -2011,7 +2010,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 	}
 
 out:
-	rcu_read_unlock();
 	spin_unlock_bh(&sc->chan_lock);
 	ieee80211_txq_schedule_end(hw, txq->mac80211_qnum);
 }
-- 
2.34.1


