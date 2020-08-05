Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1508C23CFCC
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgHETZL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 15:25:11 -0400
Received: from mail-bl2gcc02on2100.outbound.protection.outlook.com ([40.107.89.100]:13185
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728480AbgHERZA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Aug 2020 13:25:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zls+5OCJnQrHhKyXSVz6mSVWP41lIXlw7/xZUtXVsygmn0z4r/aFpinV7S9EWNIuFBDA2Yi1XYZMKcWwHAraxZTDKeaJVgaGuc0jDB6DifqyCWW+11RRsjeRR877FMAXXIy+21M5O78tbGfSZUMBFjYdSOGRMsS3bOg/fB2dppJM0deMFKOnOv+cnmA932rmn12JUK9+/76XIQVneWSyGvGH17OVYlGU+XZqlUiEiJKrEt0vZ/gcm4LgQMzpv2lTRArvxIhZxyvjMmXUp6DuHrlMR5/UulkFgm6XomRVHiOjPhYk0IH6u+9tOAdqnUZANZarAo/9lNAOfi9HF2QZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4arCMDOOUSag1T8TbanRx7boco2hW4Uj6Q03FUAuT/c=;
 b=CynvIa4Ak3o1JODWmUkQGa/ZpqC3emx5NVywAJ6yo5P/5hKbY5mJWgEGRT7vNh5k6sqxTOI5N+q8cBWSJj/FdnMKW7uQZYSuqx5X+eGPE0gMXvwspDAeZ/uHmCN1pndzZhtdyLVoRLqnfOeqLqbdEGwC5O7XD7zVyy68Q7ERaF5JIODcb4lI+EI1e2Ire73jREYrvd86LQuaS0nQcAZcyZOvl8cFm3B1///sR+62/T2C2NhPa7ssBhydUsq6lduk84ZJa9/RoPx0MS66hFsOfESn6kb3F09sLSrs/pRJGzBCgYvuPPCVEmIpFP+vA5BIn3VPwkSJcrpayLs8xFXZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starlab.io; dmarc=pass action=none header.from=starlab.io;
 dkim=pass header.d=starlab.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=starlab.io;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4arCMDOOUSag1T8TbanRx7boco2hW4Uj6Q03FUAuT/c=;
 b=RFp2Cfj5KOYxrOdLhgDiotjSVmCBQx1rsr4MIaQ1cgm27NlArcNxnJZZ1xc4lVPlf2tO2DKgyS668Y5Aei2grrUoEz7nXwAD0FwEJiIcuTQ+OnoPaSypiFV5qGWZNTlHfc/hNb2WCwWDSzAJE9/BjeGZre5XmVb/k/Qysy0DRO0=
Authentication-Results: starlab.io; dkim=none (message not signed)
 header.d=none;starlab.io; dmarc=none action=none header.from=starlab.io;
Received: from SA9PR09MB5246.namprd09.prod.outlook.com (2603:10b6:806:4b::9)
 by SA9PR09MB4687.namprd09.prod.outlook.com (2603:10b6:806:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 5 Aug
 2020 17:24:23 +0000
Received: from SA9PR09MB5246.namprd09.prod.outlook.com
 ([fe80::b199:d616:504f:9b6e]) by SA9PR09MB5246.namprd09.prod.outlook.com
 ([fe80::b199:d616:504f:9b6e%2]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 17:24:23 +0000
From:   Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: [PATCH] nfs: Fix getxattr kernel panic and memory overflow
Date:   Wed,  5 Aug 2020 12:23:19 -0500
Message-Id: <20200805172319.12633-2-jeffrey.mitchell@starlab.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805172319.12633-1-jeffrey.mitchell@starlab.io>
References: <20200805172319.12633-1-jeffrey.mitchell@starlab.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:806:d2::29) To SA9PR09MB5246.namprd09.prod.outlook.com
 (2603:10b6:806:4b::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jeffrey-work-20 (99.61.31.14) by SA0PR11CA0084.namprd11.prod.outlook.com (2603:10b6:806:d2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 17:24:23 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [99.61.31.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad8817d-a1bc-493d-ab48-08d839646577
X-MS-TrafficTypeDiagnostic: SA9PR09MB4687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA9PR09MB4687FD21219B45E4B07479CBF84B0@SA9PR09MB4687.namprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUGUAj3j/Y1GDbt3yC0uM0kSulO2C5KQpLDvRq3OfitndUZso8XWK4peGCgG4TDor6c8CiP6R5k+kuNVgnfbTDH+vyZjExYvR6RU0h8NM9YIIMhzYXo0fBEMS3EKejZ5Q1UiyjxsqR3kfOnpN9RptDIyuqLf9KrcyDPYjo4XR/7mlOvsmvEIsPzqwKjd6Wj0hNX9SDfjbygUBVuj1cInxNso095x353S1Bg9BX0FQTX0RKf7n3fDbqElQNXxIuh9sozGz8++v2SzMHrNA3UPC0CBHHaEhvz8IaUY9gM3/vA4R8//K+krEyM14aMOZz0G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA9PR09MB5246.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39830400003)(366004)(376002)(136003)(346002)(36756003)(1076003)(26005)(44832011)(186003)(6666004)(956004)(2616005)(86362001)(2906002)(5660300002)(16526019)(107886003)(6486002)(66556008)(66476007)(6496006)(52116002)(110136005)(316002)(8936002)(478600001)(8676002)(66946007)(4326008)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: DPTBO+F1mWI4N9ACvvFxdxa+jVs/EGIxqHGz1hDyKrFpNv3E+ttBXUQhPu+d3YPojsFFbZ/IQLQVT6pP8wv/i6q4CdkCPW8Pqp8JPOvfaXX+b/kwQejUYmg2HDmrNYmjhO7G181AW9UyeotsHd5uMnX7dbfSbU7YgusX20jPfPaPahqPBNa1tVdzFIXCYDdSD/9TJm++qlDodO4VFnUDEoYBJZMi/hw3lmwbWrtoa5PoK0yoe2xsW6k2b6+FYZJNUO5hdTrfRxpDkjhJYXnFdDVPbq+usr5EjYCT7KnunLrELw6I+pjED7kQG081AfVLNnBk99xF86RFVz9i4+bgWFDydl+1TYQdsZ4tZSmCaY1H1DemzabJnywBxt3mq9kY2LLmTFVHBCAyPhieLX4kheWXZbfFv8Ge9mp45mkSi8X/S3ioxjHScHTgB6+FIGzgP0IqvhLjt/yeZ56qjYpYDsPtN75YdUnfFjRWEqqyof7OfS1XQHgKDDRL2uUI9+nRqdU6idi6cTBWdDH0efU9YykeubK0S3d2HKs08IJ2QuzBaLLtXIOOSO/51Z4kVo/3qcQmJpgbEJPXoiyUIGWwxEHXCexPY3QGPMn0li0aAwUd6i+li46aiFd4lm1mW/V0c/6FlciecfR9pBigKtIXLA==
X-OriginatorOrg: starlab.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad8817d-a1bc-493d-ab48-08d839646577
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5246.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:24:23.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e611933-986f-4838-a403-4acb432ce224
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbzyzlNvtr8F8ij/oyx1Tj04gzmY1oXRsWJrdFqOTjN5yV4CqhiK87ie6wRT58+JhyVrwFdsJubYbz09o/JYuI5R5NDL3fs97kM/AAcgck0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR09MB4687
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move the buffer size check to decode_attr_security_label() before memcpy()
Only call memcpy() if the buffer is large enough

Signed-off-by: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
---
 fs/nfs/nfs4proc.c | 2 --
 fs/nfs/nfs4xdr.c  | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2e2dac29a9e9..45e0585e0667 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5845,8 +5845,6 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 		return ret;
 	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
 		return -ENOENT;
-	if (buflen < label.len)
-		return -ERANGE;
 	return 0;
 }
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 47817ef0aadb..50162e0a959c 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4166,7 +4166,10 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 			return -EIO;
 		if (len < NFS4_MAXLABELLEN) {
 			if (label) {
-				memcpy(label->label, p, len);
+				if (label->len && label->len < len)
+					return -ERANGE;
+				if (label->len)
+					memcpy(label->label, p, len);
 				label->len = len;
 				label->pi = pi;
 				label->lfs = lfs;
-- 
2.25.1

