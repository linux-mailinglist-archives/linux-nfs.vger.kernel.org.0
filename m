Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A262478538
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 07:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhLQGlI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 01:41:08 -0500
Received: from mail-eopbgr50091.outbound.protection.outlook.com ([40.107.5.91]:21825
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233294AbhLQGlI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Dec 2021 01:41:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KG6GDb7qk7jW/mJt5NET5Sii/TuywJ/KnKZjPUEuUxVBsb+83HQY//hT7qvs0ggITGT7D0bUhUudbqdsdgr4+WjXcPNSuLRIbHfNB8+iyB6Syi81Bfk/qf0vbxN07l7Omp+xuqx3G9DpjpLHbrSxKdpOwTwQ1eTQlEL9uWxH1Ogc/0k/qlHjSjaAZwb6F1LNXY70IKkD0XBra/2t06SvWkoLpfrJ625rXxWCy++ugkXbpXLO72mUzarcd/eEp/KxfPXh25XVSjJXrXpmY3LWNAgX5Iuf5cfjyhwJWCus30mZAZadJb1dXsdHV2cW//8x3FNtCub9sFkJYf8Pjws4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaw662dgSd13F4Go5AbBAMP4+FGVfdNa4fh64LgkQ5U=;
 b=etLtVo3Bud7Jje2/O0iIcvN75uSiieakQsUbjESUEv8uxMShcyp7fi+2RtYHjNhqM7zGEKZW6K1ta3X/WdyF5AUbGqlxqNzhXG99dpP7PoZo1do5oRJ2Ejhc3BNTSPhSILXL9/h6CsBkEy65BsQz0bYmLuH9cRcl/OcrHk8z4KrJe6tc/WEhYeX23Zafc9n+1OTmhnNZRpPe3P/aniOJJQerrqA0zjdhI7wqx8PHTWan5W5erItGtPen4DrmQv2MaPQSsOXJLOUHKQCAEpOKk4B8tJ0y51gBNpbfHXEwvdvtHdeQlzyqCRrr3tgT8A38GPPSeXNkxWLTC6E/c2gibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaw662dgSd13F4Go5AbBAMP4+FGVfdNa4fh64LgkQ5U=;
 b=RyZkvMbMHTbi5k68QUC1R4jytRe3ZJfuQXpQEEFTQcdQE5jzWxo7irRvr03JBOHvhUIwhFi6qH9CcBuz7lKLOeS+q3siQBWwCRIRhA/EsD27FC1Tez7I+eBnnDjVIaHJomr4XYG5dziZU+5uik6B3fG2DDuDDuTuXYRuUong5vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DBBPR08MB4727.eurprd08.prod.outlook.com (2603:10a6:10:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Fri, 17 Dec
 2021 06:41:05 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 06:41:05 +0000
Subject: Re: [PATCH] nfs: block notification on fs with its own ->lock
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "Denis V. Lunev" <den@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
References: <20211216172013.GA13418@fieldses.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <bb7b5a71-6ddf-5e22-e555-8ae22e5930fe@virtuozzo.com>
Date:   Fri, 17 Dec 2021 09:41:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211216172013.GA13418@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::26) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25c5cbf0-d9c2-4557-6254-08d9c1283305
X-MS-TrafficTypeDiagnostic: DBBPR08MB4727:EE_
X-Microsoft-Antispam-PRVS: <DBBPR08MB472796627078FEFF94825330AA789@DBBPR08MB4727.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsnRNBsPsWRd2IH8B/LLDlO5npCOQXmI6pIdy2iHiOgYacVmhaBM+6E74RxucCWVAgLvkskEdB1YSNDVT2GmRMllv34DVlAEEpG8yzoEG4ZOdN9bDowkGRXcwvzeQuWyhnjyocrLVycZlT57zmV8UfvGq1VZ24AniQaJpR9lDMngL177wbxa2aKdqU6M9fmKjDdb4VyhggcIrbUMiK5GH3x2Q5Te8K/y/1a8irT2/8l+p9gYKKMYUyQ2uZ6sTUcSm0elY/f3+4EBDKMKQV7NmOTiAt9w4nKXfNTRtmDVdL4+kA585/M6Q0nv6w6CHFI29IgbywH677ksQrpSi3+kYm0dczrNJc2mz+wIMsUUAYefuPutX7TgX8T73rZ0aMX5y/wxn2xVBAkokSh7sIv7xbldyv/7MLPeOze9g9zZW+n6Brkvx2VPG6EEzEqh/xQH4CC11lDiiuSiILAz+BiUliNhSvI9MLliJK1e6+FDCn5t7ZPWa472eLQgPIDdSsx/jseLsHwRi8wK+e2nIUxRWgnlRKIkfx78GDUI0SvsrFUSqPiggiKKCAhXt89EPUKoEM8POiaTDC6d1WatiQg/fYvSbkEap1mSBUp1Ze7TPijWe6ZTxZ2eMtXwxPwOYG7Vy4WGangoD7X6a0MXC9UslLYANTOPyCjSkjTM0tl/+W7pcB+yRWZMgJEL1rSyfn6TcRU0N+haxnkXBtgn7r8b9xrMDdkY25Ph23Em0Z/p5U4+24QbveaqDfTp28ud9PIOXBs9Hq0C05Cri7/yLjeolQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(316002)(66946007)(8676002)(54906003)(66476007)(38100700002)(2906002)(52116002)(5660300002)(66556008)(4326008)(6486002)(107886003)(508600001)(186003)(2616005)(31696002)(38350700002)(26005)(110136005)(8936002)(6512007)(36756003)(31686004)(15650500001)(53546011)(6506007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2tJdHlMR3dmWUN0NFl5b2xHb0pNTE9tcXJQUHAvV1dBSlc0L3pxNWllTWlo?=
 =?utf-8?B?eldobzM0eVdyMDZxT0dCV1dDcDNOanp0MzNRR1NsckJ5VlllZUJwQnQyTFg0?=
 =?utf-8?B?dTN2Z1ZlUmtDNTdROEg4SG5NSGlhZ2RLVEJpaGtQYWZJbzhHTW16SU1oTDg3?=
 =?utf-8?B?ZC9TZDA4aURpYWw1MjZhQWhpSHpzK0ZsTmhvc0VzTm9uQXRUd29ZRExIMG14?=
 =?utf-8?B?cXNKbTVHeWJnZHhWL1lNYkkzNWR3VE1BSVVRMzc0TG42ZlZOYStWY2lKa3pP?=
 =?utf-8?B?M2czRWk4aDkvZ1VYRXVWZytVdFRZRzVhaDA3cEgvQTdhN3c0S0pqby9aeEI3?=
 =?utf-8?B?bHZGcVBNSFNzMkJrTzVERmwyakNtZldSWENSSG44emJabVVJWS9FRHlVNFZp?=
 =?utf-8?B?ODJBYVB2ZTlzaktYaU93U0FHYzhSUlBXenpPVDlqU29vYVFwc2RSY2RKd011?=
 =?utf-8?B?M3NrZFp3SHVPZ043VnNIaW5tYVNUank1RWFCaWh3UWZxMTIwZG96eUs1RVhx?=
 =?utf-8?B?NUkrQVBGVVZiZUdabjNXVHBUMkg0MzMwNEt0TnJFRG41NGpTTXhJQzZnOHZn?=
 =?utf-8?B?dVV3TE84eGczdEVxTkJKSjJtbDRtSkpXME9JWmp4SHVuSlhZcXBSNllvWkh3?=
 =?utf-8?B?Q3VEaHpTWmlXSm9VL3hQQXI4TDJZcmlTZkk2TjlwMlkraVRYVGZoclJ0N0F1?=
 =?utf-8?B?TXhVUDFSdFJXOENKVTk5UjBoN1BNZ3FIdkJaOC9FeVk0QVp5elAzQkdFVEdr?=
 =?utf-8?B?ZDBnUitKOFQxWnNsS280ZFdmM2dJWVo2eWZtUmRXdGZmWDR6Tm4rZnI5SDRj?=
 =?utf-8?B?Vi81aUhDTmk2UXBOS24wZE5vd21yS1U3SHAwTnpPaVJHNm1UN0lwUWczVi9s?=
 =?utf-8?B?QXRLY0tWYXk4NzZoK29aRW81Y01FbzNjckNmRkdKRWs4Ykc3NS85L1BlY1l2?=
 =?utf-8?B?MXpZanh3M3A0RysxS3FvbG9OeXZZZ2I5Q1oweWJGWFNzd0NiOUJ5SWdvS3Rh?=
 =?utf-8?B?aFV4Y2xvZWRPN1A4Q2YzUkttZ28rUUZKSVJYSnE5LzhzTUhBSUV6Y0Zkd1FQ?=
 =?utf-8?B?Z3BXRS9sV1R1bWNVRDlOb3RSSnFYUFJvbzNETThBVHFDcm01dW1sWktaQWFz?=
 =?utf-8?B?S25LaTZlV09ZelVMcUJzc01mN1hZV3B3eG1SajE5d24yaTgwbFNVUGpGcjVx?=
 =?utf-8?B?NjBnMGZnNXlBdVVFMXNwazhFZ3I5bHdpb3lNTHI5STF3MDgvVmRXOHF3VXlj?=
 =?utf-8?B?bGl4WTY1MjNjZUhSZFdDeHhQbWtiN2lJYWF6VFRja3QxVWs5RUpURk1mdDBp?=
 =?utf-8?B?SkMzVjFPaXZSS080UklFQitBRFMwK01Hc05PSjgyeVI3Q0dpMHcxelRQWnFG?=
 =?utf-8?B?OERRQzRaaTk4ZkNnV3VNQ0c2enRkbUErUG0vTmt1RVN6aUh6SEdKSU00VzVq?=
 =?utf-8?B?bGt5R2ljMFRReGNkOXVCSzJIMi82cjBQdGJFTm1aQ0pjaENGUzl4bzUyRDRP?=
 =?utf-8?B?SnZhSFZtdlkzekxzRjFVUlJWQnZvZWhwdmg4bVJsc0pNcy9meTVYNnQ5ZTRr?=
 =?utf-8?B?S3BrYXNkdVBDeWpEeUV6TlFiVS9FV2x1ZnpJZG9QVXVYdjJDRWNRNjNCSk41?=
 =?utf-8?B?M3N6YjIrNC9PcHZpRlVya012SzZ1SVdhUUhRRWtnaGtKc3hjQS9CdkFTdW9B?=
 =?utf-8?B?aGNrM3dkWjd1SWhGUHJjY09tQ0ZtN3ZCSjRDVWQvbjJBT0UxRnVydWV3YjR2?=
 =?utf-8?B?M0ZzQ0VjVXdNSmNYamw2VXArenlUcnRERVlTaXZXSjBGc3dJdjFINlVvY01z?=
 =?utf-8?B?aVgyVldDOTlTWHRCWStPRURyajVHRDc2OVZ1LzMzY3lqc3pXU3F3QU1iNjdC?=
 =?utf-8?B?UG1udG1TWWxvQTZyd3M3LzVIc1U1aXg2R0ZwdGs5Y2c3Qmk2cFhUQm14MTlx?=
 =?utf-8?B?RVVKQmFna3k3cE9GWkZOZTlFek5NVzRETHJmZWtXME81czFzTkN5N0p0T1FL?=
 =?utf-8?B?djBoOWM1Z0dkbGg5bzhyWjVtbWtwWkJwRjJKV3g2d1EwRnUzR0Y4S3NEcHMy?=
 =?utf-8?B?VmV5ci93ZkprcnBQd0w3T1E1QjZ0Z2hIWkdxQXRubkZFOXNrOGg5QTlpd2l2?=
 =?utf-8?B?SlpZWWhjNm51L243ZnhKTDJxK2NJYk9QN0ZpNXl4SWt3L0pSV2cyTjVqQWM2?=
 =?utf-8?Q?JRRmFA4VsieT5JDemHnXCfM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c5cbf0-d9c2-4557-6254-08d9c1283305
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 06:41:05.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8r6DJpsQw5In+YeV17PtBTeGcPV3zYU4ZBjZu8Gc4dIUPYxxqjAsbL7lCOiH2jqayulZeSN9ktKi9xr+nBNHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4727
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16.12.2021 20:20, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> NFSv4.1 supports an optional lock notification feature which notifies
> the client when a lock comes available.  (Normally NFSv4 clients just
> poll for locks if necessary.)  To make that work, we need to request a
> blocking lock from the filesystem.
> 
> We turned that off for NFS in f657f8eef3ff "nfs: don't atempt blocking
> locks on nfs reexports" because it actually blocks the nfsd thread while
> waiting for the lock.
> 
> Thanks to Vasily Averin for pointing out that NFS isn't the only
> filesystem with that problem.
> 
> Any filesystem that leaves ->lock NULL will use posix_lock_file(), which
> does the right thing.  Simplest is just to assume that any filesystem
> that defines its own ->lock is not safe to request a blocking lock from.
> 
> So, this patch mostly reverts f657f8eef3ff and b840be2f00c0, and instead
> uses a check of ->lock (Vasily's suggestion) to decide whether to
> support blocking lock notifications on a given filesystem.  Also add a
> little documentation.
> 
> Perhaps someday we could add back an export flag later to allow
> filesystems with "good" ->lock methods to support blocking lock
> notifications.
> 
> Reported-by: Vasily Averin <vvs@virtuozzo.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Reviewed-by: Vasily  Averin <vvs@virtuozzo.com>
