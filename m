Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88644810E9
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Dec 2021 09:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbhL2IY5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Dec 2021 03:24:57 -0500
Received: from mail-eopbgr50124.outbound.protection.outlook.com ([40.107.5.124]:37187
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239288AbhL2IY4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Dec 2021 03:24:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/oeqWSIe1VtLmxkNF1YSx26nwrLByke0A7myNErp65NELw6tcgo/Ykf9pZFAKI7QAdueCuftjfH+M0x8nszBrbKEoMP5YZWI9dw24i7LLFq7XGqko/Fkx13zBL69r0wzAjUzj9IJWki73SSW1akvhWJ2Ou+KzM9X5+8iAelVxEYN3ojRF9oeQ6/VOw8An1AzlW4V+rGCudgY8eEgJn2uphYG3je7AuuHEESEH0I5A40c28pCdI2iMh3XmHQW6iv7WrQf0Pe0uxjOGxhI3JVUVE7J+IM9EYJ39TpbJ8gooey2Lr8g3oxwnx1XAqUiKOemvPsa0PULeGxwOcfJUHNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFtYv61gifHj2eYDE2zO5bD/6CRdCAwwtdrXtaH2uOI=;
 b=HfwyvuB4dHywF19yKgCvBOhz9g40gQYJ92kHMme2AxHD0pG/ntKzSFnnOCvO4QNdUWQEoSxEduu+41fGO8Klhe5TnTyq2P1VXsl4mBPsdDAOf1o1dfvpfruMUhzk/tYYvP7ZF1Yro3mYOcCWJN0K6rtGtC05pP9A4GNL6wIzBFshB30b5oFBtd5s//Lk2/31GAqqNTpFyDLliWqNZFSibY8FrEa74phoQLElKqVhAIiPtpASLaaOybOfNg1dk1Nt4MH0UFpNMDxLtccJGrlgh3L1pi8H6L/I7i2myb3niR2tqfgpn6oyYMOVtzuHzyTriwpADME2j00ZOz5sdg2G1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFtYv61gifHj2eYDE2zO5bD/6CRdCAwwtdrXtaH2uOI=;
 b=FYff8gJCKHlrI6VqJTiW5cITuxrSvevsSlJSIj2RcntKVmtmhZggaq0Yw8k3Xu/B2Jy5mahYuXD2UBd6/FJiDSymkoA4RwIfABJe3j0vMVlp1lRcOF60Ag3DgtlCiNMOmzYHyl2K3ilSG9bZGO2Va0yaGBuZuSZqKbq3DbGcOwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM0PR08MB2964.eurprd08.prod.outlook.com (2603:10a6:208:5d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 08:24:54 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%4]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 08:24:54 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v3 3/3] nfs v2/3: nlmclnt_lock: handle async processing of
 F_SETLK with FL_SLEEP
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     kernel@openvz.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
Message-ID: <dc99ce3c-d73f-b21b-b92f-d0b1025c4567@virtuozzo.com>
Date:   Wed, 29 Dec 2021 11:24:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0066.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::11) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ca2f042-71bf-4f6c-561e-08d9caa4b132
X-MS-TrafficTypeDiagnostic: AM0PR08MB2964:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB2964C65FD548265EACCEE8ACAA449@AM0PR08MB2964.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9O9+EkdgNSQfvTZc16ChL8KBeVAKUF3544epYl1d3v3kfszANKYO6C8XKKv5aQNUEszemNCcbGZjfGLUHnlyzWSdML27eddaQyaSfcHKX6xAYWjiPwMetimnJTVKMVDqjsbEcXLP3MY6KPrhWh7lGVVWWucGHulMb2v6SkxAE61kRSVogXZhmykdCbkHC+qRKMR1E16S72up3x8WeUTohNge3EbvnygCZM5wHwRB9x+gcvN3k02OmYx1zv47j6HBsQnTBGiFSckpZjaINmjlZxIBmlxyuZ62bsiV9OAyLC0KH9Qzsa/vnsmrS/OAGY63X2S6dw0RPL7pkdYKiW49mmsmQGdsqPFkB+FjbRD7bzsJrRpwsWAxANdiESVZ6wDAz/U973BqfQUhNwJb6Ae5kAL+RCcR/rJLfu3AyuLrroqjZjP6Perv1rxJ4mL4aCfcnvzRyg3wW02FIlByGexeDq2uWnWQ2UyH0m/E6wg5km264QKagFAzocIZtiBTT34k5U/2188Uzr6mrh6fTezOyndgZ7j+jyL4jEAgz231FCMv8fJyXlN8rhu6yC1VSkQAuZfKPgW90QMNOtmty8YNkTXBQX62U8AkxFpr8xoQ70PILHMvOO+Hfig8bK2bbUik/Xnomt3qgCa95aQ5oyMs1W1wgpXTgQLcYR3nkPf0wcG50ehyin486cEOQZReN6+p/tBKZzgEkVO1UAGOLQhXXaiyYH9qFpnIDhNbT3tZkIirP05+FQS5zMxbARXmZ2kdTZgOW67ea5AaXF/j8sNahQCPmUS+RiZ4ygiwncVeCreZB5kKWe33LVHtuVf+RmThww9nLG5DKF1od+Pzfe8fqyNBy3jU+8auhAfDmh3vqTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(2616005)(8936002)(6486002)(31696002)(2906002)(8676002)(6506007)(5660300002)(4326008)(86362001)(110136005)(83380400001)(66476007)(52116002)(66946007)(26005)(508600001)(966005)(66556008)(31686004)(36756003)(316002)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVV1YXhqamxmYTF6eUdZTnFrY0VOeXFzejZDaS9vdFRlWEp1OEw4TC9STUpQ?=
 =?utf-8?B?VkdPTUlUOG81VlFvNEYrUkJZK1RzSnpRWjdUVWNTcm4xbDJoU2lmUkJ1cFFv?=
 =?utf-8?B?NjdSWTZLQWxwYXNxS0R5eXdZRlRISU5xOTUvWVNDb1Y3S1JuMmNtMC9sTkp5?=
 =?utf-8?B?b1huQ0gvVDY2WTFyODNpc2txekEyb2pqQTlKRis0cWs0SGdyUW12Q3BXOWkz?=
 =?utf-8?B?N0hpZHNOQ1AyREpHTXFWTUU0UzJxY3h1SEVnckJXOUEvcDg2clVmQktaU0dK?=
 =?utf-8?B?NmRveTRaSkh2VEFDVHpyZHZ4QityMEZFM2E5d2VKczRrYXY0VXFwMjJnb0wx?=
 =?utf-8?B?aUFaYzhyYk8wQWdmZGlyRFhPQ01KdmlNNHN1dzM1NEcyUmdQWnlCa0FOL2du?=
 =?utf-8?B?SXVlSEMwQmtBMTB6STlEbTJzQ1NicTRDdUc5dWJXL0lKWEppUmg5MTBvN3U4?=
 =?utf-8?B?Qit5QWp0SGdhc1RrN2p1akdYUjBrMWR1WUM2UHJVc2FERGYrVmdodWo4THJy?=
 =?utf-8?B?dnRxV3RpY2FxbmM4OFN4ZTJWS1pPY3BPTGJONExnSjZaZFhBN0g2aXJjb29z?=
 =?utf-8?B?MXlRMEVGay90eXcxNVFnd1RydGVIQTNla05SZUh5T1hNRmFhaWRFblBFc3lU?=
 =?utf-8?B?YzJxTndkWjZ0K0o3TXo0Y2lEZG0zek9CbUM4bEhMM3JDZWRQMWxYSTRkamRG?=
 =?utf-8?B?R29xT0hlaHlTOFJUcS9DSkNuMzZVdkVPcmxncFZxMlhjZDFVd2RTODUxNTd3?=
 =?utf-8?B?M25BZk1tbFFFRWx5QlcyRW5LeE1GZEZGVmd4ekE0d04vbHFqY0FuUjdqTlBO?=
 =?utf-8?B?N1ZVMG5oeTlVZzE3LzJiU254ZDlnODVIUU1pQVFGTXFvQjZKOHA5YTFlM2kr?=
 =?utf-8?B?MWlrTmp0Znh1YlgzaVNLV2ZiZnd1MGUrWmQ3enA1dThSMTk2K25YTnpzNE41?=
 =?utf-8?B?d0R0RDRqNzJ4b0V2MXZOQXNHMU8zdHM0QmNZeXYrRW1SS3JEMzhjWnhaRDg0?=
 =?utf-8?B?SUxJd2pON3VCQ01tUFpOc1JCZXFnSHBoOFdaU2I3OW1wMDYwc3JnOXdRcU1G?=
 =?utf-8?B?SHhMdVpJTkEwVUpWR0FDdlN2ZlZkc3h6OFduT0xmUHhYdDFpTU5Wdi9QaE1I?=
 =?utf-8?B?bWRLenIzMklkV1BvZmlHNUovVTZkVDBycVQ1cWlDTGsybk84SVZJN0NJL3ZK?=
 =?utf-8?B?NHVhVnViZmFtNjRxRUFhZXo3RHp3eGEvcnVZditqRUZSblVwWWlHYzVOU2Jl?=
 =?utf-8?B?TElUdjlySHJScVRkaDUyQk5HSWRXOTVJQzRwQk9nVEo3c2VPRjNoNmZ1ZHZG?=
 =?utf-8?B?SzcvNTVYVklrTG5rMk15Z2F1SjlYZ09RODdYNVEyS0xVTUZQNy9SZ1E3WWdQ?=
 =?utf-8?B?OXlwZjc5VTRjZFFHNGZGYzI2RnRreUNKdDBpNXpmU09jeGpyK2MxRVpFRkl3?=
 =?utf-8?B?dFNlNFhpekNGd05OU0MvZUwrYXZBd1Q5STJMK2Y5Q3N5cCtGNGpvNGZVSUJ2?=
 =?utf-8?B?ajhvTUxlTDVlUTFwVkZCVVdhc3VzSFIycDBPZ3lXK2JBbUZ0TzA2MkJCbURu?=
 =?utf-8?B?QXJESU03aE9tbC84MmU4d0ZkVG9ySmJDVGNBaVAyWEFNZVYxMWxvQUVZZ0kv?=
 =?utf-8?B?aFNoQmZPWkJlaGRFWm85b0N0eVJwcnhXNUJheVprM1loa2UxQ1ptSkRBMXI2?=
 =?utf-8?B?akV4Q3FGRmt3WlVKWSt1K0d1TWhSaEQ4WHpINHNnVFZDQTVEc3FYbDFsWmk0?=
 =?utf-8?B?cFc5dUtXRk93V250elFielFwTTd2OTBtRk5CeFNSSXdEWVlmWlFHMG5PVXp2?=
 =?utf-8?B?Qm5tSEp1Ymd3QWd5VGU5eGhCbmF0aGJ1NVZYUTNIZjlQd1dWYVQ5Q0JxOVZr?=
 =?utf-8?B?R0ErcUZuVXRscTRpNkl0ZEs4THVzWXpVTUs4eDRjSXZ6SEpNNG42N21aOGww?=
 =?utf-8?B?WVBXeFIzVUhkbDJYSzBYSTA2YzdwYytMd3l6ZjRmRTcyVXMwSEdoYUVqQlB6?=
 =?utf-8?B?MnVCbmdGY1FNVUh0dHFLTlJxZzZBQysrTkpBaTdPbUNDVEhOdnZ1UnBWa0tw?=
 =?utf-8?B?K0VMSG94Q00yQnhMOGNrYVhCa3IxM2M2enFmNHZELzBIVFQzRFAvYWd2YVgy?=
 =?utf-8?B?SnpZVkk5dm1mN3phWDd2Q3NyYjBkNXJZM3dMK1ZwWWp6WHAwSjduMmswUEFy?=
 =?utf-8?Q?GNOCFjKIET+Dh0zJHAGLJBc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca2f042-71bf-4f6c-561e-08d9caa4b132
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 08:24:54.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prgjBVC0Nv3DG/8oPhkuQPcPQkEUaeGBkA+RuBuEKd8TlaTROeRCbgWxQqMJ5VgaHsoXeybNOtIEE7NX6Xtwyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2964
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
asynchronous processing of blocking locks.

Currently nfs v2/3 handles such requests by using nlmclnt_lock() ->
do_vfs_lock() -> locks_lock_inode_wait() function which is blocked
if request have FL_SLEEP flag set.

To handle them correctly FL_SLEEP flag should be temporarily reset
before executing the locks_lock_inode_wait() function.

Additionally block flag is forced to set, to translate blocking lock to
remote nfs server, expecting it supports async processing of the blocking
locks too.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/lockd/clntproc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 99fffc9cb958..5941aa7c9cc9 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -519,11 +519,18 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	unsigned char fl_flags = fl->fl_flags;
 	unsigned char fl_type;
 	int status = -ENOLCK;
+	bool async = false;
 
 	if (nsm_monitor(host) < 0)
 		goto out;
 	req->a_args.state = nsm_local_state;
 
+	async = !req->a_args.block &&
+		((fl_flags & FL_SLEEP_POSIX) == FL_SLEEP_POSIX);
+	if (async) {
+		fl->fl_flags &= ~FL_SLEEP;
+		req->a_args.block = 1;
+	}
 	fl->fl_flags |= FL_ACCESS;
 	status = do_vfs_lock(fl);
 	fl->fl_flags = fl_flags;
@@ -573,8 +580,11 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 			up_read(&host->h_rwsem);
 			goto again;
 		}
-		/* Ensure the resulting lock will get added to granted list */
-		fl->fl_flags |= FL_SLEEP;
+		if (async)
+			fl->fl_flags &= ~FL_SLEEP;
+		else
+			/* Ensure the resulting lock will get added to granted list */
+			fl->fl_flags |= FL_SLEEP;
 		if (do_vfs_lock(fl) < 0)
 			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __func__);
 		up_read(&host->h_rwsem);
-- 
2.25.1

