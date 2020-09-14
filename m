Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C682690B2
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Sep 2020 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgINPyT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Sep 2020 11:54:19 -0400
Received: from mail-bl2gcc02on2098.outbound.protection.outlook.com ([40.107.89.98]:21878
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbgINPu4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Sep 2020 11:50:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGcqYEhEcqWrJD0+pzXEa/RJkswYyXaaBMV0kmsJnGJ3Lzru4yrWtrZSin+ecF0ji/xMFf9ncgQXmtNhFMHxbsYeK0Fz50+oGqrMwKFHjYSZ30Sz8VtaEBKIvYqcH7Xr98HZECpsvJaZGlfVBwBrN1GTCv65Ni9/nezMCMaoq+8pbWTjD9BqMkXVKQCNJXmWzxWiD8GQj7upHZ+9uj6bg2w3G/KJfeG/TGqWvFdtHk7jFtBx8QUwZVgUzDCDUAX5DxVq2HhvWCHtfaCylEd5Ag/dG3pBjOYPy6O9xCphWkEuoY9AHyG+GC3DEo8zR3TBhMAjFkeVnM84FhTQIFRMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxpY/d6JPz+ql5xBGidv4TaiwBVS8DAaMXHmH9tQ9vE=;
 b=H5Lh9FL7CDYGrFR/4Y9SfdcDW8MJCCxgZMbIwqTGN8qUQ5237Ga0asKnYKltNooD5WowO0JDH8m8Urd+lrYUITZPN6ZVl/VNmPVwzZWgc126+s6JvBBK271yA8m07MRqAKoJIKnNsIprxnyHJZCmOa62Z5G6p4PxPaKD6Bm6pEJhC4kaRQtfcF8VaTd0Uz2AsGQBX+nxwF6o5jTOkrMnOrERg7aIyhp/OkJXYwfYcdrU+5Gm5NktzkonbwP6nyhgLyqB+Qvg/SqjviW0X666g6Lgddl7uu4H0JiEAxGwdYw6RfvkmNe7aQ/UkN6Iano3MX5yOs0FTG1j7D8pPUv1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starlab.io; dmarc=pass action=none header.from=starlab.io;
 dkim=pass header.d=starlab.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=starlab.io;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxpY/d6JPz+ql5xBGidv4TaiwBVS8DAaMXHmH9tQ9vE=;
 b=JElpoDcuA+2FZLgc9dp6ByiG2fYTeWIqu9ZrMn/O8k5GMg2ADVppD0N52vnWoGS7PWDLiAvpGPj0ZK0hNoNOYOR9GLh3dem8pjKvJc48+nrWLvByNEKeCuHP5ttEQoMI4LrWjJhb+1M9JSXvWgL299JNTwlUsXRm15Ulqp3o5nY=
Authentication-Results: starlab.io; dkim=none (message not signed)
 header.d=none;starlab.io; dmarc=none action=none header.from=starlab.io;
Received: from SA9PR09MB5246.namprd09.prod.outlook.com (2603:10b6:806:4b::9)
 by SA0PR09MB6444.namprd09.prod.outlook.com (2603:10b6:806:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 14 Sep
 2020 15:50:19 +0000
Received: from SA9PR09MB5246.namprd09.prod.outlook.com
 ([fe80::e90f:c1b7:2964:d2ac]) by SA9PR09MB5246.namprd09.prod.outlook.com
 ([fe80::e90f:c1b7:2964:d2ac%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 15:50:19 +0000
From:   Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: [PATCH] nfs: Fix security label length not being reset
Date:   Mon, 14 Sep 2020 10:49:58 -0500
Message-Id: <20200914154958.55451-2-jeffrey.mitchell@starlab.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914154958.55451-1-jeffrey.mitchell@starlab.io>
References: <20200914154958.55451-1-jeffrey.mitchell@starlab.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:20::8) To SA9PR09MB5246.namprd09.prod.outlook.com
 (2603:10b6:806:4b::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jeffrey-work-20 (75.1.70.238) by SA9PR03CA0003.namprd03.prod.outlook.com (2603:10b6:806:20::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 15:50:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [75.1.70.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5631b83a-ed99-4877-6d59-08d858c5e169
X-MS-TrafficTypeDiagnostic: SA0PR09MB6444:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR09MB64444E9EA9784C5C88032AE0F8230@SA0PR09MB6444.namprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f14onsQbuqtoQxYaW+PG663cPye5cJOJ2WcD3bXXaupQsggOKh7b5D9qrPPbrhlQdttfOZ3yoLhY7OpUvXDdT4LMZ6KOYb3QFkHDUOJ8m6RmlWgRmWdb2OkH+Mj0V52u1cYodb+JqmWxv0+YXDzJ55XVgzagZ4tjOEYnojs5dxkj2cJkQCg7VShFqxTlkt6OlY1rEkCTv3tDHg/PAy1UWaz/nNVWjhxF5KL99K2Kz1EqvLeIuRv1U6nPRSX1jAVHYty4Tng1nKBPqeOHBtj65aeS7+1p9EQzajG5fG25NzYBY/qeEKyQpMIbb1qiDf9hLqww542VUa196lD6FXUXVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA9PR09MB5246.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39830400003)(4744005)(5660300002)(1076003)(66946007)(66556008)(86362001)(83380400001)(66476007)(4326008)(956004)(6666004)(478600001)(316002)(44832011)(2906002)(2616005)(26005)(15650500001)(110136005)(52116002)(36756003)(6496006)(107886003)(8936002)(6486002)(8676002)(186003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5Jjc+62UgX7vIHvkQrtPmBCg/dHx/t9tLy7zDR/1A91MHbHCu9O+AE8NFwgbpvzNjw+YtN8prF1CxwY1Z7Wn6cKh73zFnhcoDskk36KfUPGhiemyZGXpenCocKa1jCqSlez06ODAkV6h9VxeMIBeTzsnJ/9e0M2ceRBpiGsUK2fC0fcAsDP0wFT/ULWoAHOm2l6VsZ85XHaLsGpYhw6dg34oExtRAS4ZMkiuO77i8H0zH4dB0u46chLB15PaRBZmUeSvQwg2VfWwKDLX2VWqUTR5trF7j2ZqUMBJijLkkmLinO/XlgdwOSq5vz4Z2ThRE6bv83SFM+ix7eupMwa8lyvn+7buQ8VZsoV0TrBLJhuEYoDaF2gRhDiTZkCsvWiI15XF3QOQX/SdptmDcov9kBp8yCIIdBcO75sk7okB+qkMVYlw+38LdA4bljrjhnTvd8oRlM8bfYpVPhx9Jjskpwy7FbI7be/de7Aq9VsYSbxguXpNvrD98BZarI/K1B+gDOpsEdo452vCWT7K750toxoMYzx+ycg7ROKUxdF+jS420xqNycndDMRUPr4LWP0g6XQzqIi5jgmGbtOeT8m+1edGl5UFelFtnWLk38+5ceAgk22WcGZKHW82Prk9RCtuRRkWz1yIKL7KBnoNs24Hog==
X-OriginatorOrg: starlab.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 5631b83a-ed99-4877-6d59-08d858c5e169
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5246.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 15:50:18.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e611933-986f-4838-a403-4acb432ce224
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l+LiAoZGqaQtsdDB/uwn9qT7ZS8dofixZmm6L8dD7oxu8vNy3bc/NPXLeFFSMo+cysAkTpVbl6/815OBZJIUL47dw1LsxH12lknZdgY5w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR09MB6444
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In nfs_readdir_page_filler(), reset security label buffer length before
every reuse

Signed-off-by: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
---
 fs/nfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a12f42e7d8c7..5ff6af4478a5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -579,6 +579,9 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
 
 	do {
+		if (entry->label)
+			entry->label->len = NFS4_MAXLABELLEN;
+
 		status = xdr_decode(desc, entry, &stream);
 		if (status != 0) {
 			if (status == -EAGAIN)
-- 
2.25.1

