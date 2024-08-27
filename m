Return-Path: <linux-nfs+bounces-5792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5C95FF34
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 04:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367C41F2300D
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 02:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10CC14A8B;
	Tue, 27 Aug 2024 02:37:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E214285;
	Tue, 27 Aug 2024 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726248; cv=none; b=Hyu8SR7pO13tNthI0eEcBy8MrJVlEtitU3F4ItMKwbnkXuhYPYJ+P4E8l5NVBkmuT5eQjtKyxMH0Mt19QoDRHi4+weVf3N/5quANbGsXb8AxXWltur/QZ2aZium/TNtigf3x7+RNzv/+in9ur+MtrUaAwGEGpGOyvbtF7dMQyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726248; c=relaxed/simple;
	bh=W37Dj5xRd1T0iZsMWoSODlphdX9qwEVW28anQXxRFN0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iwt48LhLKHxm4FlCnQrIKcwI6TuVpRb8l7rdBlnrRIOxT1PAcmDSSZeTyw7auxqp3eepQVwL1ece7tAwOkQJKY0KJt4DWD5KsTWoTzkJyC23BbtJq1p+ClfAVYKUOSpFmKQsd8WSqk2nIOrFyoGpGOFD+oLMtUKZYPDEK5vZAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtBTy4GRQzfZ5m;
	Tue, 27 Aug 2024 10:35:18 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D518218007C;
	Tue, 27 Aug 2024 10:37:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 10:37:21 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <akpm@linux-foundation.org>,
	<trondmy@kernel.org>, <anna@kernel.org>, <gregkh@linuxfoundation.org>
CC: <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next v3 0/3]  Add str_true_false()/str_false_true() helper
Date: Tue, 27 Aug 2024 10:45:14 +0800
Message-ID: <20240827024517.914100-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Add str_true_false()/str_false_true() helper to "true" or "false"
string literal. And we found more than 10 cases currently exist
in the tree. So these helpers can be used for these cases.

Patch 1: Introduce the str_true_false()/str_false_true() helper
Patch 2: Use case for str_true_false.
Patch 3: Use case for str_false_true.

v3:
 - Add use cases for these new helpers.

v2: https://lore.kernel.org/all/2024082407-shortlist-ultimate-2102@gregkh/T/#m0222c320c5395252b3f26f57d99b05509a58b74e
 - Squash into a single patch as Andy Shevchenko' suggesstion.

v1: https://lore.kernel.org/all/1deb2bc4-0cd1-41a0-9434-65c02eef77ed@huawei.com/T/

Hongbo Li (3):
  lib/string_choices: Add str_true_false()/str_false_true() helper
  mm: make use of str_true_false helper
  nfs make use of str_false_true helper

 fs/nfs/nfs4xdr.c               | 11 +++++------
 include/linux/string_choices.h |  6 ++++++
 mm/memory-tiers.c              |  3 +--
 3 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.34.1


