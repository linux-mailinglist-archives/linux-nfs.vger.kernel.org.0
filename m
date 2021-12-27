Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27FB480109
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 16:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbhL0Pws (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 10:52:48 -0500
Received: from mail-eopbgr60123.outbound.protection.outlook.com ([40.107.6.123]:63715
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241371AbhL0Puo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Dec 2021 10:50:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO0KQqvYZjmmCGkhugoCtFnovaywiFMLg08B08R2yXhDy3LAUP2GTgrUhWbe+HLVACyD02OpP2CBRRNNFtPAOGfW/GGUPKkI0PluIYmOxuLm1Y6vy+NRJjQDlxO16/cFn+DHRuF7L4SRICA01QRvKhJG3Q1TXAxbz1ypSt9xCbXfONEFZmONhojJaTuAIjMJgTPQ5q9FxMBJ2VWaRS9pPVUsBSSE/YYamyoAxDFho8BrApMHq4QRcq+Azb7DsjJDpodAXy6CYEWMale+2eh3YCSBLlQ9//KZt1kZeuKu5wvpDZyTb6W5HkSsnuWq9viL338o3W8TWcURcpqQE2d8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpZ2mWkNhQrdF25BsqIPQmFUXbB0oAdiW8gmQRvH0vw=;
 b=eZ7te1UAxOi/MZ+dxexmkn2HvkPfbOLWAGDfJ/UBqXqm01ihDAZUJBrYhvwGFQHoHaEYJAPo/MDYOhUuIUCe38IfaCVgexODAFqtEBMJp9dtIp7MvQOWAvouvJ46ULCSxZJZhz8P7MNkpB+4Cu19RNWmpjyqpbsShpRDVMfRcZ/3LVHIuapCwpwn4uA3YuoaQwTm0cp/JgrqT5L1pN4Ysd5sLRbghyWuaxDTDDYbXe/svyTE+K5nGuQV2sXQVKQhckDlt2UXy5Z2AHxle2mYtnZObtjMr4T6Biz5lt6sv5SMbKTwZUWWl8SRbcbGCHb7yss/ldADTBYlDuG8rZJNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpZ2mWkNhQrdF25BsqIPQmFUXbB0oAdiW8gmQRvH0vw=;
 b=aP/R5c6Tmc7gOsqLTOTz+lpZZ8eIWD6yhsjj7iIQ2VVI8TEvbWj3IriIcMfSjPiYvvKkrDt8mH4K/ojm+UmUGmiJEXvF9onaQEkK9GIUzHbncO5xHkKrCZWqGesejj4kZUlzX8mnXRRO+Jt4QMROWboQiHq1as60FcqdtjubsDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Mon, 27 Dec
 2021 15:50:42 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 15:50:42 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] nfs: local_lock: handle async processing of F_SETLK with
 FL_SLEEP
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     kernel@openvz.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202112272042.Xlz50x0x-lkp@intel.com>
Message-ID: <3e5d6777-9365-c853-071f-3e9fc4df922c@virtuozzo.com>
Date:   Mon, 27 Dec 2021 18:50:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <202112272042.Xlz50x0x-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0002.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::15) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4688f9fd-bbc8-4b9e-16ce-08d9c950a318
X-MS-TrafficTypeDiagnostic: AM8PR08MB5732:EE_
X-Microsoft-Antispam-PRVS: <AM8PR08MB57328B500D57199041A44147AA429@AM8PR08MB5732.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcXxmFPFgVD0UwWNsW5BweuzkkCI5QtEsy23ctCqTs1/80UyhEajLAAFQKPwgMUFfbYDVndjkbTyTdwfxPS5U0xnscSdfIG17NPsthr1SkY0pDdPVdBqwLHbRVPA+q35wd8qMxRaJMtcNVVNJ0E39HNDylyXTs1uwbGnCVUtWG+GgVEjXHp3zzdSNDGdA6gJHP6B77AqGOhMaDke0jr6h2TVlcpkHpbmTDDv8Y1F/n+MbmWY5tOYZcRoG3FXLDXIJfm4IeJNnxP4AlO485KawkkooRvPor+Qx06rZXgaZCYDk9oLeqArlWAG6e8C6oWoUX7QOGklkb9obtOE1s3sEVuUR1q79+QaUKNgZ7aCZ66IZicbbt6XTeP4NL2gfqqQ8OVC9S0MXnZ2zbPQd4GuF6BTxFhZZg5d23x4SYYjrm8YXes31B3m7Kk/d9fZsBKgC6ZpMqSB8PncuSoqgMYMrNLjn5zJG5wu8AnCj4ZHAG6Zizu6SIZxTn7RliGZy+G16mV9CuFezWLr8D82exSwXid9+4RA5/PYZ8T+iIec7FlHe4TjoHIoOE2BT067ip5HLrub4TOSuKcT7Vxqj8X22jNKJZCQbJoGd4aCTVbaZe8O+AA5ytQC82G46mM4Xc8jEnLO1dK72HdtnqS0pwK//+GLZaKLLvRxdHpUnCWgc4N/m2tTrT+56sgKS6msgpc3JTlMCqu5yu3ePqL73PZG9I9Xw0rI03FK5Jh6OIjt9nilwG+IFjtCANsNSKI22Vn3Hfb+ti5cdm5APr+diSy7gdk1aejvTEwGZLULhR6s0v3fbHpgZ3ZhT0I1way9kkfh1VW7p2jKCse89ts6Jj0XXM+7fIM2RS2LFeCzvgd5QK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(4326008)(186003)(6486002)(38100700002)(38350700002)(6512007)(5660300002)(31686004)(52116002)(83380400001)(2616005)(6506007)(8676002)(86362001)(66946007)(26005)(66476007)(66556008)(316002)(8936002)(36756003)(966005)(2906002)(110136005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlcwSkdvWm1CNyt6WHVLUlZ1ekhtNUpPMWhFSVdnZ2xNdE9PQjRRR3EzTFlS?=
 =?utf-8?B?V2UraGtvQitHU2p1UnA4M1VBL1dMRjVoMmtFRWducERCV0MzOFBNdWxYaGE0?=
 =?utf-8?B?dTMrWC9oc01GN0gvVnI0M1FOb0h0RTB5QU9UUklFdjY2QlJPVm5DYWFIVjBx?=
 =?utf-8?B?WWUwQlg5WHZ1RDdzSWhzNzR0dFpjWjdPdDFVdHd0Nkw2M3F3cjVoRFZ2WHBk?=
 =?utf-8?B?YUxVOHc1WFM3OHRsV3VHYi95TXN6NEhLZE1mcnc1RWtsaWR4MCtQbDdyQVJ6?=
 =?utf-8?B?ZTlXWG5PRWF1MEc3dG85N1lDcUhsSGNzMzVjU1BwV0V2b0VYQ2w3dEs5UVkr?=
 =?utf-8?B?YjF3L3NncFVjN1R6SURXZ3R1eFBKMGJjaWZkZ0tCeDdEeFR6ejRHaXA4ZHVT?=
 =?utf-8?B?Q2tFUnFGb3hJU0xOd2FQU3lMUG9kZ0JMdnJJQkptYzQ0czhGZ2xvOUtySWpm?=
 =?utf-8?B?eGF6cHZ1OG5tTjVwWE9wVXNabVUrSzhHWXdicVo3Q1ZTdXZjRGhhOHpYaFdl?=
 =?utf-8?B?d1hTNnJna2NDV2J0RndKQlI2ME9hSTA0QzB3S1orYzh3czFGMVJNNXg0SzYr?=
 =?utf-8?B?LzZRTDQ3bXlzaHNKQVVSK1E0dW53OU4za3gxdGlILzZIVDl0RDdHcTBUanU3?=
 =?utf-8?B?QWthbUthY2ttNjR3RmNMaThXL0g5Q1c4bzVlVTNDZ1p5NVk5UUlNZjBNZnRM?=
 =?utf-8?B?TFJEa2QzaFlCeUhYNTRKTVFlU2RkRGxqNmpMcXlVanFmQ3dSR2kwTlZuN0ZO?=
 =?utf-8?B?Q2RLRkZrNmpUUzNtcmJjY3dKdkNFY0NRT0h6ZE9yS2lpQzZrUEpoQXpiK0Vq?=
 =?utf-8?B?UUh0SGlYYXFSYmhaN2VyWkJ1c21KYVdVdlQ3NmFUN0didTk0dFhFZGlGUjJ5?=
 =?utf-8?B?VGF1b3RJQlpVVmlZVFdpVW11dlppNGw2TGJDOWlUWUoxWVNwVkluRUJ4SE9Y?=
 =?utf-8?B?VmwzbDNjcUt5MTZtalQ3K0twb2VoRFJlcGFJbTNzNG5oV1NCTElNZmVSUGZE?=
 =?utf-8?B?Q1JPMEp0bkxGVXFoL0hKM1AwaUNRR282NEJlR29zSnZaWDgvdFVEYVRWRUpB?=
 =?utf-8?B?T3pZRURqNllwYXUxVDV3UEFRanUzNWFIOTNnd0ptTTR1ZUYvVkd3enlXbkpL?=
 =?utf-8?B?SUsrMkpwL0pCOGgzMGVjL0YyUStSVmZ2NDliS25IU081eVltZHVhZGp2aWVD?=
 =?utf-8?B?Y09hd0hOR3M2M0ZvL1FIUEtBUkxOQW5NaWkwK1hQeDZETWpyWjFId291ZG1M?=
 =?utf-8?B?blZMRHpYYloyUEh0akRxTGgwVUpzUUJzeDVmYTEyV092RmZBTXJWaDhZTVRz?=
 =?utf-8?B?UTRldlEySHNiTVpLZ1VFR3hWR25rTmtxZ29TejBsUm5LOEFmWUprMGVhVGxv?=
 =?utf-8?B?WjRtZGFydUZEUnpGbHF5ejRlNlZUdXRYSVRFTXlYYUtYTnRBelZIa2kxZkFy?=
 =?utf-8?B?MTBmYjRKSFhnUjI1Wm1BaTdleEQvdVJSR1RFbDVzbmRjdWNVNFkyWmovV21v?=
 =?utf-8?B?UmNXSU1YOEZSWHlZMUFTYStIUUI2aGh0SFNUOTdDUlZOempsN0xLNUJLNEp3?=
 =?utf-8?B?MHp6Zm9DQ2NtK21vS216eDhVdnJMdDVQS0t3UTJJZXpEN3BzYVM2ZGtEWDJH?=
 =?utf-8?B?UnNUN2FNYzZMQ3IyelhmSUNRWDhNem9zUWhDaGtxUUNHZlN1SzN0SDlzSG9T?=
 =?utf-8?B?ZW9OVkFDRWF0Zy9VL3RVUVd4akViQXQ4NFVNWW5nM2grTGMxdS90VjlieW05?=
 =?utf-8?B?UG5uaEl5T3UxVlZSMTdMSE1qNldLNGkxU2pvVTBHZFFabXFKY3dFKzF2QmxQ?=
 =?utf-8?B?dHJuL3BwcXo2MzhONUs1ZXlTN2lJc3FWS001aGZtYWRKam5DT2N6L1ZJcDVi?=
 =?utf-8?B?c04yUHlwSW8rN00zcm9NdWd5VXVPMnNCcFVTVEVIdlIzOUxOWGxEblplQmUw?=
 =?utf-8?B?RElMOWF5OFlycW9UeHloeVNKN0dqTDlndXUvbzZUeng4ZHgrbE9uNDZydEIx?=
 =?utf-8?B?M0YxdDlxTlR2QW5Telo5c25hbzFLZlhtcmMvQzNybURFWXhiS3oycFdFNk11?=
 =?utf-8?B?MjdjRFJXb0d0cXhmRXBwNUNxcHZvdm15K1hZWk1zTXFybzNTdzFiNHBwRlov?=
 =?utf-8?B?VEhPMHhxeS9XS0x4YmtjYk5yYjFVdE5oQWp2UE1DdFhpMGlaNzBJbWg3T0hj?=
 =?utf-8?Q?BlZGGH5mB8iuVCATZaofUoU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4688f9fd-bbc8-4b9e-16ce-08d9c950a318
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 15:50:42.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjbRTuzaoYRQeb3ylJanlwh6V7yhypVX4BzWGYQwCqkZ/s+kHTz22q1oWX9JoHJy+I0uSyThiHuZPivS91iKyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5732
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
asynchronous processing of blocking locks.

Currently nfs mounted with 'local_lock' option use locks_lock_file_wait()
function blocked on such requests.

To handle such requests properly, non-blocking posix_file_lock()
function should be used instead.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
v2: fixed 'fl_flags && FL_SLEEP' => 'fl_flags & FL_SLEEP'
---
 fs/nfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 24e7dccce355..38e1821cff5d 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -769,9 +769,11 @@ do_setlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 	 */
 	if (!is_local)
 		status = NFS_PROTO(inode)->lock(filp, cmd, fl);
+	else if ((fl->fl_flags & FL_SLEEP) && IS_SETLK(cmd))
+		status = posix_lock_file(filp, fl, NULL);
 	else
 		status = locks_lock_file_wait(filp, fl);
-	if (status < 0)
+	if (status)
 		goto out;
 
 	/*
-- 
2.25.1

