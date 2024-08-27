Return-Path: <linux-nfs+bounces-5790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C8D95FF32
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF51284C04
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 02:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B392C152;
	Tue, 27 Aug 2024 02:37:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B414A8B;
	Tue, 27 Aug 2024 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726248; cv=none; b=W1qUffLGXXBh0q/SnKLxeh0HxmDK4yDJBLQLb89HyVP1AYnmidK9VudpwoYDwQUsujzR5FQFJRIqAYVqTsNwRjkQbXniS8bvHQhh2PxUMEhhhkZn2onjtEVHBp4zjDe6EihPu0WAaFpZgosjBR9ohdcEQCoZwQQX6vEX6JurJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726248; c=relaxed/simple;
	bh=94q1IxgnDlbGmOsZaC7Jqd196CY59EzdBy0PqI7hpGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbJNbmMYRm6dwIi1GHTFklVERfBEICKEamQ0fYmdykzQhDcsXQvOX/nZu0m3PUFi3TNDflEMmVCQtVjf/0oMHnb2mtYMk2IPmGcehSjk+D7LU7kj3UcKDz6Zb6inEWKB9wOBkY6RuGa9j7sEuHKFCnd6lnrI2mMUsaw4zPFPdXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtBWS6H3rzyQTf;
	Tue, 27 Aug 2024 10:36:36 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EF5118007C;
	Tue, 27 Aug 2024 10:37:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 10:37:23 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <akpm@linux-foundation.org>,
	<trondmy@kernel.org>, <anna@kernel.org>, <gregkh@linuxfoundation.org>
CC: <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next v3 2/3] mm: make use of str_true_false helper
Date: Tue, 27 Aug 2024 10:45:16 +0800
Message-ID: <20240827024517.914100-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827024517.914100-1-lihongbo22@huawei.com>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The helper str_true_false is introduced to reback "true/false"
string literal. We can simplify this format by str_true_false.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 mm/memory-tiers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 2a642ea86cb2..66ea9099dd63 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -940,8 +940,7 @@ bool numa_demotion_enabled = false;
 static ssize_t demotion_enabled_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%s\n",
-			  numa_demotion_enabled ? "true" : "false");
+	return sysfs_emit(buf, "%s\n", str_true_false(numa_demotion_enabled));
 }
 
 static ssize_t demotion_enabled_store(struct kobject *kobj,
-- 
2.34.1


