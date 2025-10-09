Return-Path: <linux-nfs+bounces-15113-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0ECBCAF9E
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 23:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC1F3A58E6
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35459274B5D;
	Thu,  9 Oct 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcCuH4Iv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE02571C5
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046501; cv=none; b=bi0a/Gy+gacbp0oOEKPVifVmt+SgFGOm7+GlDwXCW2V+Yw5wv6WODQ9+kifhWbG5/KFiGGAac/KL2surYNuEoNHPBC2ocUlfvyogpQQz+5njJQofJQKb/cL2ku77AdpP1702XCH9EfXsnETGAPns5OYYfTwVypTS4optoDUcDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046501; c=relaxed/simple;
	bh=2k32Os9eIrTe7QJPbw6wYOac9zaygttyiU+nsidokpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGZfxho3I/XEHFuAi0avNdlTa1iMC4RyDKQ5fc1/ELugemVLUbgTbejfYA71pcmMYI/olvarAgDaJl6e3PjdN6jHsgrxBg5Fj+isRhQEy5wztKS+vlwNKrf1o3TVag+m/oH4nKZDVN2odD58RGqNnhVhcZQ5vl4pvT/xvu7pY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcCuH4Iv; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-91fbba9a8f5so131149339f.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 Oct 2025 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760046499; x=1760651299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/wlAhB0t7MJI1w6PibKEtk7MCGbcm49V87OzXgTCKs=;
        b=IcCuH4IvdnF9DkOn12SdHcYv7rO3/a3BYLPw6x3tfq/yNj19pUVPnAG6uCFWxNADjC
         BreWB8B/PyTcF8PjJI2gpL/DWxoJmFNzR11Z45of333aCVyLFF7NnzSMgLwbKD1eJ6L3
         6tZScAGH4NoH+Fqfv+fqheVApXnWR7pXklzuOZ7dfHKmVY9vhbspJ9Q8OLNzW3zRqu/p
         DGJF7hQKUFHAZiGpXDj3ouR9AifRIBQJN2eyEMA8jTJF3WYYDgodS43eUdd/VSmntE3b
         B/kr5AVuDEIdPr9nRiMKENJtokaFSunrdHtyy5zSXb9pXbqbZWymWfdl6nyt/iQP3QBq
         E9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046499; x=1760651299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/wlAhB0t7MJI1w6PibKEtk7MCGbcm49V87OzXgTCKs=;
        b=vqWFlZTk6E52ZZJU7uflBj9tgjmJUpRPK5nf57nKs+emADhJEDUs6m24olQlBIIWnC
         StrSW9BdzpZFNbtINI/uPiOhh1uTpjwHthG2iMJ5zkXlLjP0eZE3/qqQ1upV6bjz7e/6
         sJRMOJJa8vr0yVPxCQ2tQWDmQRp33ixdQbSBtH/h8cjAWwNC2PaBrvHmHiIAYWAXvxRO
         hgkijocY3ZAne25EJhx1FckZbKhNJWshJIa14kzXpNS9BTXPJwEaeJIEqxPUG2HhIBce
         Nxj4GlgI/XOVOE2542tA9olOyJeq6Sj6P23OgOwPBVQEGNQdO10j6VC3Bti0Sy/0nyZh
         KHWQ==
X-Gm-Message-State: AOJu0YySxxogEJhFRM910qWVvlOOegc8w0IrvxeFdVz66thy+R6Aa4hJ
	CvmiFOZpZ4/iDNbyBE0Mp2NvV35U5dAPa1cl+zokpE+etvjFswBYOy/qtDyPpw==
X-Gm-Gg: ASbGncs8lfmXSYG/kC3NqF/X0Axv/SQQNJVcl37WLi2CQhBJ2jnte95tNkOCN7hj3Ca
	tsEWXKRMv1CEEuIjZDMZaLtsJAu8gS+8FgNSbrTSJkQslARnQ98Lyk8LQVcxvGakC0mu6H07eyt
	c2LTY6jOH4j+9pUj4Cxah3/HANf56EVqppEvfqziygTZ8pENniQM17kuyZpAsiDWs+f0uWuC3i2
	45gUkYEXIl4iKOlJWth3jaVf8KCWm+tj3b1XKVSH5jzO7n+SkKIDcDkRVRsU8YPWU4E/l3zA1je
	XBzEFnbLy4KyWRMdB6RuOAd/2Twwh/r1ANU+aOmkLJQQbLuBY57Su6XrJnd1soi18EKUV7adEmN
	XOly+MDKkF4ciWSc1uKFfNCclcG2ORCsgZAJiepN4yYGwO+ftNW+HSGw=
X-Google-Smtp-Source: AGHT+IHXtiX23n0b9nObNHBVv/31QlIVfKtOm+fhzHEy/7QgrpvXeK05ovQm7WFtNIZMMKH37P+wAg==
X-Received: by 2002:a05:6e02:248f:b0:42f:8ae3:20c with SMTP id e9e14a558f8ab-42f8ae30b89mr82184375ab.19.1760046498601;
        Thu, 09 Oct 2025 14:48:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::5441])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f72109fdasm214388173.40.2025.10.09.14.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:48:18 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Watt <jpewhacker@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH v2] NFS4: Fix state renewals missing after boot
Date: Thu,  9 Oct 2025 15:48:04 -0600
Message-ID: <20251009214810.966201-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008230935.738405-1-JPEWhacker@gmail.com>
References: <20251008230935.738405-1-JPEWhacker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <jpewhacker@gmail.com>

Since the last renewal time was initialized to 0 and jiffies start
counting at -5 minutes, any clients connected in the first 5 minutes
after a reboot would have their renewal timer set to a very long
interval. If the connection was idle, this would result in the client
state timing out on the server and the next call to the server would
return NFS4ERR_BADSESSION.

Fix this by initializing the last renewal time to the current jiffies
instead of 0.

Signed-off-by: Joshua Watt <jpewhacker@gmail.com>
---
 fs/nfs/nfs4client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 6fddf43d729c..5998d6bd8a4f 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -222,6 +222,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
 	clp->cl_mvops = nfs_v4_minor_ops[cl_init->minorversion];
 	clp->cl_mig_gen = 1;
+	clp->cl_last_renewal = jiffies;
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 	init_waitqueue_head(&clp->cl_lock_waitq);
 #endif
-- 
2.51.0


