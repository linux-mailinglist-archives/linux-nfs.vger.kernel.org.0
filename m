Return-Path: <linux-nfs+bounces-255-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33C801AF8
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Dec 2023 07:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B431F21143
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Dec 2023 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185BBE58;
	Sat,  2 Dec 2023 06:14:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291AE1B3
	for <linux-nfs@vger.kernel.org>; Fri,  1 Dec 2023 22:14:15 -0800 (PST)
Received: from dggpemd200001.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sj03m2DBQzWhpP;
	Sat,  2 Dec 2023 14:13:24 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 2 Dec 2023 14:14:12 +0800
Message-ID: <f658a8b4-e762-51d4-1735-c0e79f22e9a9@huawei.com>
Date: Sat, 2 Dec 2023 14:14:11 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To: <linux-nfs@vger.kernel.org>, <trondmy@gmail.com>,
	<Anna.Schumaker@Netapp.com>, <sashal@kernel.org>
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
Subject: Inquiry about NFS Patch "NFS: Don't call generic_error_remove_page()
 while holding locks"
CC: yangerkun <yangerkun@huawei.com>, <zhangxiaoxu5@huawei.com>, yi zhang
	<yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)
X-CFilter-Loop: Reflected

Dear Developers,

I hope this message finds you well. I've recently been examining an NFS
patch (linux-stable-v4.19.298 commit ID: fecb9d534dee) that I find
intriguing, and I was hoping to gain some clarity on a few of its
details.

The commit message states, "The NFS read code can trigger writeback
while holding the page lock. If an error then triggers a call to
nfs_write_error_remove_page(), we can deadlock." In the context as I
understand it, I'm having trouble conceptualizing the specific scenario
where this could lead to a deadlock.

I've scrutinized the relevant functions and code, including nfs_readpage
and generic_error_remove_page(), but I can't seem to pinpoint the exact
scenario where lock contention could lead to a deadlock.

I would greatly appreciate if you could help me understand this issue
and how this patch addresses it. What were the specific workloads or
system states you encountered in this process? Was this problem
discovered under specific hardware or configurations? Or does the
problem trigger under a certain sequence of operations?

Thank you for your assistance in advance, and I look forward to your
response.

Link: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.19.y&id=fecb9d534deed3680bfaff0b86ac83470946b710

Best regards,
ZhaoLong Wang

