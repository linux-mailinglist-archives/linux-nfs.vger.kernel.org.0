Return-Path: <linux-nfs+bounces-5793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4063695FF35
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 04:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1098284CBB
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 02:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BEBC8FE;
	Tue, 27 Aug 2024 02:37:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B7171AF;
	Tue, 27 Aug 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726253; cv=none; b=ffD6vTA80zdwhfzNxk78W7mt9pvtv5dzAB5HGS1QOFkpebABQqWaCGM17ztM3kJrDP3apJqOsGpSZH+8xhlngHeJ2ctwF3L5hoIbyPSbFj7AAz97cwMybfO3rT35vwd+JxSHqmlEncV397cVx7hjotkoUDhPRZ4ZY64U2/DW5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726253; c=relaxed/simple;
	bh=HlCYNVV+ZYEU/IX37+aSnawheDXViiIVFCyOubw06a0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsPoL4+fQkKrLUtM7aWklNoU9ddknptNEpygaHgrEn0y6+JksUBXzVFsVYOFvH354z0e3OCD9cJjm2Kuoq2yyLMeX4XO5aSJlTaGgxjNnoqC8lOjySk8CyAjwtD9G5IuQSoeCfYTZheAJ5UQuo4N7C1EluIzJOpJqa3D6O46KwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtBXB04wrz1j7HJ;
	Tue, 27 Aug 2024 10:37:14 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 696DC1A0188;
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
Subject: [PATCH -next v3 1/3] lib/string_choices: Add str_true_false()/str_false_true() helper
Date: Tue, 27 Aug 2024 10:45:15 +0800
Message-ID: <20240827024517.914100-2-lihongbo22@huawei.com>
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

Add str_true_false()/str_false_true() helper to return "true" or
"false" string literal.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 1320bcdcb89c..ebcc56b28ede 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -48,6 +48,12 @@ static inline const char *str_up_down(bool v)
 }
 #define str_down_up(v)		str_up_down(!(v))
 
+static inline const char *str_true_false(bool v)
+{
+	return v ? "true" : "false";
+}
+#define str_false_true(v)		str_true_false(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.34.1


