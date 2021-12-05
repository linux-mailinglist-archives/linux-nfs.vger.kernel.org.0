Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219C7468A4D
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Dec 2021 11:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhLEKQA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Dec 2021 05:16:00 -0500
Received: from mail-eopbgr40110.outbound.protection.outlook.com ([40.107.4.110]:20718
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232546AbhLEKQA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 5 Dec 2021 05:16:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LshohFza42S9fMp/vvWWcXuFxaohXRCyDX7yIX+9fEJlw+M+ao5ZEZPsBDI09kzZ0/II85F9fH7k4iVL0n89gpUoklvGOlZ4Df9aPb7mxCCofNpXD1Sva+zoQ0S11vxUIs04+U4nCDFtJQ8ie7ELU8OogSLAhlcoKk0tJ9lq4cL/YpLJ2qP5RxW8N7P8X7Hlu6DDYo0AB/JU/R9OtAkPRgbzcojEhTRNZyQFOCR3g4o2escg3p41BPN32Zo1lFsR3dD4QpD6nP1ZwNSTkkzhKwLV2zcqeYkpYqdURCZyS2lp/knicd+zqy2XreY71CFECduDYA0v4k1x0tocgZl9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDeY7BYj8O7bvOmMh4WVZgW+PPS9VnW3pUPywTQ/CBE=;
 b=NLeD/XrrWjEODEfllZ2lp1b1416LxSrM66S9/CiJbHDOs2oqViBfTSKOO3MbXm7SqPmrJuskWbbXzfcqXcMRARYFkmb8RT/AaIlgCoCXNGGevYMhxdW0FDqpaARCWvFC0xx2cxaocfkSFtpJSvFztj6xrMH56M4nhfwuoeETpSHAq4Hq8jilmg6hiMuF63FXr3GAuKvW4FdMn+2E2/ZUMBZDKwsze4aCboegHkF9Aiktfdnh+qVt3+GOgzr1lXenEvfxvK2obnsPm1SnTpQQSa25GsZapMzSDLovVFyblJEMWAfizdVqH4YKtm9xDHadmRPnd0R0fvtYT97RkGYJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDeY7BYj8O7bvOmMh4WVZgW+PPS9VnW3pUPywTQ/CBE=;
 b=ZDdNYroPQmajuDpCHypml8v97tdGkWhU/paUNjbzh+sRgBgAI9XY0Em/mbp699JaQ6vNV+hOIdb+0Fjt7LijdcGw3j6VuEf5++b7K1+oMUxqUG9FW5XS847M5EwRrAUKJpVJtLsB0aODR8ggQyTnAamHhMwnZSGBd1i+QjINNek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB8PR08MB5163.eurprd08.prod.outlook.com (2603:10a6:10:e8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Sun, 5 Dec
 2021 10:12:30 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%4]) with mapi id 15.20.4755.021; Sun, 5 Dec 2021
 10:12:30 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] nfs4: skip locks_lock_inode_wait() in nfs4_locku_done if
 FL_ACCESS is set
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@openvz.org
Message-ID: <4088a4fe-1c1e-7b9b-0685-dac367094b61@virtuozzo.com>
Date:   Sun, 5 Dec 2021 13:12:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0029.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::42) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
Received: from [172.29.1.17] (130.117.225.5) by AM6P194CA0029.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Sun, 5 Dec 2021 10:12:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5990eedd-fde1-479b-32fc-08d9b7d7bed2
X-MS-TrafficTypeDiagnostic: DB8PR08MB5163:
X-Microsoft-Antispam-PRVS: <DB8PR08MB51636E79659343F2A47265CAAA6C9@DB8PR08MB5163.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOgEDkc5ndC8WL8tphi2IyuIA5tn/rneOg4fLbRL1xHeq72svTR9NunLBVttFYLSFjZKMt1WwjYvBDyjadxlqxYCTS2Q/t+GBasE+TkfbtF+LsgT2L8xkzLv1Bqc9XIKz31dtMCQmGygv9TQIy9F3a75/BF9lowqrRRf7GdVJdM9LBctMlPM7q1ksLhAYkZnen/bUZ5Ow+Fe78o3EQB4OofXlHawQXNUFhbv1hTcQTQ8BaCzBbu0h1ZS7GNFYeOqrW47E+VGK2Qk2p1k5agUQTyyTN8zcwcPcXEU3cYCP3s9Ie1GFbIlH6YyTU836YRYDZ2t9mfmjpSmIaVeRdhDD9aghgYK+8UmyXwtntEewGhM+Kp2vuDmQaUCs0FLcPar9meuWMNA5yzDVZ+B39HC8ER1eO83G8AHQqV5vPjHfgoby6YqzvFddzEj5dCpySS1jdTOQH7887fLsHfIJ9uxU2Vmyat9KIlFoC85Qoq9quj5BAx8HTAq4I1yteLo+WscdvkEfwp6yXo3Yo70By+cuTOXWXptSaBdpr3ZLkRTQRn1GDm19ZNFI+HxnbvyDAY8qGUnHkTunswAWNBdCcOK0b99C628M8IU6P7qjn2Y7WNe0z+Od+P3N+X3+tNam7DZzq2SrXs5/Jlm6Cfx1rQPxmT8zTIvPGF1ehca2XTReNGAUIcN1yb8LusmDwD1PGhPLaj9lJ1lCYp1kCXxculVufTgvbTzv1kSQJi3uXDLd0esK+/cXygIFcjkVqyremdXXkCTu64BEjzvekqcjpjUPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(956004)(6486002)(107886003)(86362001)(2616005)(508600001)(83380400001)(2906002)(5660300002)(4326008)(16576012)(8936002)(186003)(31686004)(316002)(36756003)(110136005)(26005)(8676002)(66946007)(66476007)(66556008)(31696002)(38100700002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE9SKzIxOHNNdktOTk5jYUMvMTliWmJ6cndpdVRCRkhaMWY0WXRzOTNVcVZU?=
 =?utf-8?B?UnhZd3ZCWUxTdzZjQlZaZGJmWXZBNnVkRTNjQlYxaFBocDQ0eXY0Vk44S0tY?=
 =?utf-8?B?bzJ2aDJCMHBBSElJMVhMQlg1b2hBQUlrK1czS3k5UjU0anlvYXBWdFZORk9a?=
 =?utf-8?B?cjYyaWtqck0zZ0NicGcyWktDZUJQeE1vY005TVR4UXNkcTNwb2VnN0FIOFR5?=
 =?utf-8?B?ejBKTVlITGZSeVNVTTFUK3dPMWI3dGFBTnhwSXZsdElBU25xMkxRRjhCU0k3?=
 =?utf-8?B?Y213alpVaUpVclkvaHJSRHJZSkQwQ0RobjNzd0lDSjZnSUlWdnZMNTVyT1BB?=
 =?utf-8?B?VlBTendnYkpKMDJ6ZGdVclo0a2wxZTZlU3ZuQkJlWS9UK1VNYm9lTThmcHY0?=
 =?utf-8?B?cjRqSlQ4b3F2TElTbk0wbW9waXlva09VbEhvYndSUkJUd3FpeTVubHFRYTFU?=
 =?utf-8?B?am5QYTNNdlVMcXFWeEk2aU9DeXJhZ0w3TCt3Wmt3OFhXdm9GY2VQYkI5azlo?=
 =?utf-8?B?L2QyUm9kT1J3c0RROEtXQTdJN2d1QXdYV1k4cENIdzhnOHMzdEhCV010N0U1?=
 =?utf-8?B?UkpabHMvbk5MN2t4clVpajlpdVBOZWdBa0YwcmZ4U29zU0FhSnQ5UVY2RUdi?=
 =?utf-8?B?SzVJNUJtQkNtcU1TbXlMTVNvemI0SmNsMTZQbGxaR0ViM1lDd2lNN1BobVBl?=
 =?utf-8?B?SS9FM3ZRemUzS3dsMjlOQzE3Mm0rOFVVODlHK1ptcWFOdzA4V1NIMDJJZlNy?=
 =?utf-8?B?V1JpSk5nN2x1YktxYXoyeU5QOXRJSHNlalQwUFdBUVJwQ0lmbjNOdHV0ZllK?=
 =?utf-8?B?VVdHM2FkSmE5OVRnUWp0VEZSVitTNTE2ak55S0dJTEdKT25qQ0ZGUEJlbXFC?=
 =?utf-8?B?aFVSRVNWdEhaZ29BLzhNRjV4eDhlVElnRzhwMmllMTNjZlMxVUZFMmRwckRC?=
 =?utf-8?B?dlRrZGxqamZRZmVyUG0rcmlqVS9xRjRyQkNZTUZLa2FNYXoxT3J4Q2QxZm5i?=
 =?utf-8?B?eWxNRkNWdHJFYncyL0N6dFl2OFRVWUtTRHBjTmVlU3BQOGRWWjVleG5Va3Zv?=
 =?utf-8?B?SUMzNmFCVk01MmxpMDlOTGNJTkdqRlRvUlBmMEptL252TWN6dUFwWEZQMUhO?=
 =?utf-8?B?OUgxSVBKbUQ3cEJVTnVVYnJuVEZ1NjlQelNlL0dlWlRWdWkraDA2S3Nhd1ZI?=
 =?utf-8?B?Tk5vczlnMmNyZTlJdVJ1MzBodXByRG93VWkweHFIL09KdHpjd29SbmI5cXE4?=
 =?utf-8?B?MEhtZzBVcGtXQkxyNWZZRmt6aFJtNzlRdzZObkUzZ2ZWUUFiSUlJR01MbDgx?=
 =?utf-8?B?aldaMXROSHNDcEwwQ3NwV1dUK2ZMcithQ004cEk4TEo0L1p4VE5IeTREUWZ6?=
 =?utf-8?B?eHFaanBaOW11VjNYMVlUS3lGcmdNcGErZndwSXEya3dDNjVRUFRDbDRIYlRo?=
 =?utf-8?B?VlBBN0RPVFJGY2ZmZTdVRC9UZk1QTFF3bWlqRklvVDZqYU5hL3RxRHF3N1RR?=
 =?utf-8?B?RXV1QlRlbkxpZDRtenB5MUdWbFVWaThoYXBUSjd0Y1FrQ3BvZDZHKzkzenYv?=
 =?utf-8?B?ay9OamhHN0xVT3BEM1VsY045aVZOdVRUOGVwVlhPSTVsOGRLNU5lM1dxSUdj?=
 =?utf-8?B?YUtWWmh0R0RUUEhuNTJPR2xXOVFvSExaemVSdmljYmx6OCtIdmhZZGU5dnN5?=
 =?utf-8?B?WlR5NFJ5bTZmVlQwb3pyeEF1b1l6NU9SOGg2cjE2SitqNmtyOUk1OFozYWJn?=
 =?utf-8?B?SEswbEZwZER1ekhHNHVrRVg3NHg4bTlIWitIQkZZRkJ0aHFpSnhack0wNmNm?=
 =?utf-8?B?TlI3dWU4WmxPZi9RUEdWcXJ2MGhWdkxxbVUvQWVTcmxsV0ZZL21qem9sNGF3?=
 =?utf-8?B?Yk1kOVRsMkhQZ3JQazE2QTYzOEQ5ak8wZXo2U2NHTXhPb04vRm8wdEVxalpw?=
 =?utf-8?B?Zlh1UGt3WWxMaStJcE14OFh2eFVkTjl3NW4zR3dmNDEwMEFpb3RRRytlQ2ZE?=
 =?utf-8?B?dW5wUHRGbmZKaHV3T1VDZVUyZjJFcHpWVG1nM2NpS0JwWHdoWGFjditQQjZF?=
 =?utf-8?B?NnNRWi9aV0VFM3NNWUcyeURhMVBpeFA3MzUzWW1kbFp6Qld4UnR0RUcyNXk5?=
 =?utf-8?B?bDhCYnB2b1l1NWhpT1lkOE9tUFJtSlhzUWdHb0dVVXluNmlhdnE4UWlJTW1X?=
 =?utf-8?Q?GwG666BCeAUSOHrNiNZAyxg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5990eedd-fde1-479b-32fc-08d9b7d7bed2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2021 10:12:29.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcKwNstSWrIP/oKNbjB2U/hgrzNRDjpTreq6ZkHHwjowt8XQwfleSL6rUYzDURb3d59sWodCYoBnikB3w50OVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5163
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In 2006 Trond Myklebust added support for the FL_ACCESS flag,
commit 01c3b861cd77 ("NLM,NFSv4: Wait on local locks before we put RPC
calls on the wire"), as a result of which _nfs4_proc_setlk() began
to execute _nfs4_do_setlk() with modified request->fl_flag where
FL_ACCESS flag was set.

It was not important not till 2015, when commit c69899a17ca4 ("NFSv4:
Update of VFS byte range lock must be atomic with the stateid update")
added do_vfs_lock call into nfs4_locku_done().
nfs4_locku_done() in this case uses calldata->fl of nfs4_unlockdata.
It is copied from struct nfs4_lockdata, which in turn uses the fl_flag
copied from the request->fl_flag provided by _nfs4_do_setlk(), i.e. with
FL_ACCESS flag set.

FL_ACCESS flag is removed in nfs4_lock_done() for non-cancelled case.
however rpc task can be cancelled earlier.

As a result flock_lock_inode() can be called with request->fl_type F_UNLCK
and fl_flags with FL_ACCESS flag set.
Such request is processed incorectly. Instead of expected search and
removal of exisiting flocks it jumps to "find_conflict" label and can call
locks_insert_block() function.

On kernels before 2018, (i.e. before commit 7b587e1a5a6c
("NFS: use locks_copy_lock() to copy locks.")) it caused a BUG in
__locks_insert_block() because copied fl had incorrectly linked fl_block.

On new kernels all lists are properly initialized and no BUG occur,
however any any case, such a call does nothing useful.

If I understand correctly locks_lock_inode_wait(F_UNLCK) call is required
to revert locks_lock_inode_wait(F_LCK) request send from nfs4_lock_done().
An additional F_UNLCK request is dangerous, because of it can remove flock
set not by canceled task but by some other concurrent process.

So I think we need to add FL_ACCESS check in nfs4_locku_done
and skip locks_lock_inode_wait() executing if this flag is set.

Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be atomic with the stateid update")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/nfs/nfs4proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ee3bc79f6ca3..4417dde69202 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6728,7 +6728,9 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
 	switch (task->tk_status) {
 		case 0:
 			renew_lease(calldata->server, calldata->timestamp);
-			locks_lock_inode_wait(calldata->lsp->ls_state->inode, &calldata->fl);
+			if (!(calldata->fl.fl_flags & FL_ACCESS))
+				locks_lock_inode_wait(calldata->lsp->ls_state->inode,
+						      &calldata->fl);
 			if (nfs4_update_lock_stateid(calldata->lsp,
 					&calldata->res.stateid))
 				break;
-- 
2.25.1

