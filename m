Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5948012C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 16:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhL0PyJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 10:54:09 -0500
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:39662
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239995AbhL0PwI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Dec 2021 10:52:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsbQgs8uoUAcYyNdCzsM2EfGbFgkDD5EK9C5R3uZPnXnxOysEyQctZadGL7fWvNvDDNC4lKjces+u6GwlLJllBJ5BXm2eNZsXvXmwTr5gDSpbQsTFM4sfi5U25FyltFh+cRnrV3cOi18mM8Ymjyw1JSG/04pC6N2lD9KBIh/VtfunycRXX15GTZRTTi37uleExBjNr/nlsaKlBxGiMiB6r0v2BDr4ZOz1YoZQ4PTCo8MXD2mfPUdrjCeWi6qFoJ6mVqAq/VBwnXMzo4YkZXKm1pO7a3cEUlmvf4iiz35PUQ/iDvqGc5I54LS+otMu+j/Tm9tMmB5rGUi2zBujweR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxCCnlcD7mKs61GXoTK0MNkIAax9e7AIeQwS6xhBD3E=;
 b=G4KV2cCrNVnJ6T4dd+W5cQnp19joOCvitx1I9rNEgjbaxVLoARBF4UcpogOhRgbP787G2nejzDJS9uWEAzvpYpa3SYy9CU4ayrSJtE3KCsR1xTyXKFa/4968fWVFmGYSWJWJaW4LrcQO5p17xLW7V8yRDNMKmRBR+88hWZ8OJSIWO4zl4vl1tkxDgLgnGObwFjmBPwX201RFA1S6dLdo+05V7gtPOWqToaoVBrisCio7cc3mpA35Oak66brOvMUZMKdpRzVCRk+UZF+QbTtvBmvDrB9O2gVZXB96DWEfsOwHmVQdU+Zbo9YrOYtDXY83rHyxYJerFIVD9g5j33++xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxCCnlcD7mKs61GXoTK0MNkIAax9e7AIeQwS6xhBD3E=;
 b=te9FHHHqXh73Bb+vC/Jx+Z8iGVgtEgT5D14SJsFfg8En+VAbr/8c54mN/aAUs3fNRjZT31DEfDUqv1/LCWAMYMsiiCdDb/n/pDhhWhVnYSaa2W5Pl1winxbqx7LGXe/mV3Gp1zn0Hrd0hD+6JkZFUQhMdStgleOXTiAXi3tvbaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Mon, 27 Dec
 2021 15:51:33 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 15:51:33 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] nfs4: handle async processing of F_SETLK with FL_SLEEP
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     kernel@openvz.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3a2c6cb9-abe7-ab32-b11c-d78621361555@virtuozzo.com>
Message-ID: <c2ef5a47-85b2-3a98-020f-766f153a65d0@virtuozzo.com>
Date:   Mon, 27 Dec 2021 18:51:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <3a2c6cb9-abe7-ab32-b11c-d78621361555@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0032.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::45) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c75821b-4ed0-4122-49f4-08d9c950c193
X-MS-TrafficTypeDiagnostic: AM8PR08MB5732:EE_
X-Microsoft-Antispam-PRVS: <AM8PR08MB573208F3A879F0A6B886DA8BAA429@AM8PR08MB5732.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrLWQt23luWFp6JBprBReCilGBsmJJyKAxR+ksM+sJntaeWnKYOdnpmyeTJmDWUpx81dOiXhp2VLParRGupq4NSSSwCTOURp4SXwNx30LPC3o4eASlh5FccO8Go3N1Irn0Nodq/axE2eehC8AsNbsVUow+TejHsWxWnZyhL9CQMhnXvsqLImKfvD3SqxbxN8beM5Ygop3mrGsf2PideH6S6UbwIprX+mydg5gJR2Nn9886csKyh21dXxUVAqiWAPOydgvEeLc5wJVM1BJI9scJmpvrOgJZpWZ8a7WWy/jly7atgH+Hj0PRWgWtOnAaBYI6SBanBv3CzMDygdhPZ7HJ2k1lU7Z8hZCiD1pSjBvPfXWr3ZvMiGyFc+bx5czpLGaork66YUjzt+bxnAG4OFjPEM6VkMaZ0vCDZ7F/0VZzyx18A8eg11hXE71SwIWlKFE3ozfdOYvIxvyFAFO3MwnFAgITIqknJ1FXJi0SFLG20jJpA8bhIjmPwXKT4PCkLRQOwDT28O0BUfR8wRUU7QXGy5Nokl0xXVGxCGktFYoYIG5Ysqz+/m+BEC9zRSP9P+12Ifyt/358DfCp1yhJJOZ+39fYSoU7yRRv2S1+lVBF5Y6dpnxXQRxoav8vJXRGgcso21Xqmw0t1n+67xkc7w3aBziO86HN7POiQsm4i4muilpoSVnqQ2wbTV4+0Y7oHRpYkWvzb/ZWc0A8+Du/s8eC1fkrv5lC3nmwb5O0spbGn4F7xUQIpzBcRlvzHmdY3kBSkbkBbTqL3DMrtwJQCBk5lVrWOhHc+2ye04pCauCXeSgvXIYdMDW9IrLHEt3iChSvDz9HQozpCOAbJq/09pO2cDYXB3GnCZ6P5n0E/qc7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(4326008)(186003)(6486002)(38100700002)(38350700002)(6512007)(5660300002)(31686004)(52116002)(83380400001)(2616005)(6506007)(8676002)(86362001)(66946007)(26005)(66476007)(66556008)(316002)(8936002)(36756003)(966005)(2906002)(110136005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZWTy9nWmxqSzg4UWlNOFg1QXovd256OW5zcUZ0MEV5RWREZERnUEVWNUl4?=
 =?utf-8?B?dXFoNFNSSlBZWUFpcHJNdnBGbExaVWUvTU9XN1RUZXgyQmxXdHpvMGRoN3lX?=
 =?utf-8?B?M3ZDb1Q3diszdkFmdTlOM1JIdFE0ODBkUHJVRVRWRCs2bEFLRzA5NTU0NWF3?=
 =?utf-8?B?TGN0RlNmQ2QrMHVDMktZTkprUHBqRnZ0bnIvWDBybVAra3FpMGdvcjhrckdy?=
 =?utf-8?B?ak95MTRobHdibVFiMFdGcTJaZU92c2dvN3JudzVKdnlXREE0Q2d3Y1ZpN3I3?=
 =?utf-8?B?aHBhenNNREJhTjhwM1FsYThsNGJ1MGRSUktCa3U1emJRUGgzeENwVHJXOHJ2?=
 =?utf-8?B?Z3p1VkNORmlUVkZKbDRxdUs3K0NMTlFXNUt0TER0RE5oQ1d6WmIrazA5cE1B?=
 =?utf-8?B?alVaclVUbGJ5cmNjakd4cW5LSjJhc2lnRWh3WjFRZmRraGpHeHVlMTBja3hh?=
 =?utf-8?B?V1VVc002eHB4dURkVDhGOWpmSmtjdk5TTWhMZ0FWbTd1cWVDc2RYaExDOWtT?=
 =?utf-8?B?UXZ3MFA0Z0IrcVlMa2NWWG9zNFVub3ArTHVoV3RDcURiR0c3TVNRNnZqT1lZ?=
 =?utf-8?B?WStpM2E5SkRKUTR3ckE3YkN1QXpXb2ZPMmpKY2hRcjhKT0RFYXZ5dkFRZTNp?=
 =?utf-8?B?NWVhaHV3L1RRL0NhTS9rbTExZHBqejRNY2w0d2dEVG9XUUJKVnhpcm01ZXp0?=
 =?utf-8?B?TWNMN01lTkdiU095bU52VDBUb2pXNjlLV3FiUStzNk56SDV2cHhUWEVEbGYx?=
 =?utf-8?B?dWFDWnFRY3d2cWdORGdwS1h5VFdiY2IybU1NSVkwSmNHeHhZcTZxSDlmZXBF?=
 =?utf-8?B?M3pLQ2s1eXpRME1UMHAwak1QRjlqN09sbVEzWjFiUitMNktROXJvWXhCc3J4?=
 =?utf-8?B?Smw3dkRTb1I4OURCMDFjaWk0MHNsd2QzbWNyZFBzY3BmKzZOZXJ4TTBmK0pI?=
 =?utf-8?B?eXI3NEJLdVgvZjYvWXlHWEJPbks5RmhUYldsK1JPamV4c1JVS1ZKVHczMGZI?=
 =?utf-8?B?cFEzNWx4cGN1SGRYbSt6QUU1NitmbDZzZDV2Mkkrdlh4emxPTTJtRE1QaHpw?=
 =?utf-8?B?dHZjTDJiNndEWlNuTGZjSVNCOHBpZ2NWTXJDaTJWZEtFaWZzWi9OSVFUR2FN?=
 =?utf-8?B?a3NJMWtocStwU1cvZGc0NnVGUUxYYXFsdFhReTUwZ0R5WnN2YTFtWWdKQi82?=
 =?utf-8?B?N1NZYmlXcDZVL2lycHhEYW9DbHg3V2xhNHRyVXIwSkh3aFQyT0RyN1N6TmdJ?=
 =?utf-8?B?QlZOTExxU3hSVVNVS2s1UXhTMXhHZFlGcFhZZk9ENURQbFl1L3pyeUVlY2t0?=
 =?utf-8?B?eG4zQjc5YnFDbTZYY0ZTNUxqbFBZVFBGZHpmL1BSZXl4NTRtRm40VXdYWjhN?=
 =?utf-8?B?eEpqMGt4bjhjZCtpLzBTRkZwMnNvdi81cjJLVmhQdjEzTnVBKytPSkJaT3BW?=
 =?utf-8?B?UFFuZ3E3Tk5BNXRzVms3U0psVEpkZGNiMTl1NnoxYVpwWGRVc0dMakxCOTN3?=
 =?utf-8?B?ZlYzQ2NSZklCNWlDOUpjdGhGR044ZDlQb1hSdjF6V1RjTS9HbTZaS3B2RzhE?=
 =?utf-8?B?QWhONE1reEVPdjJ3SlVLUGZ5Slpsbk42UmJxNVpKMFl0NUlEdW9kMG5aRXkv?=
 =?utf-8?B?ZXI5Uzk3dUFLcXN5WlRxM1FpUzVwcVlacmxTWUR1K2k2cGd0a3lJMmJBKzlO?=
 =?utf-8?B?ZnpzSlFxVHdZTkpvNllQc2ZFWS9saDNtekdJcmU2OFhZOVY1SS9rYy9RblZF?=
 =?utf-8?B?ZXZpenFQaDJZMUM1L0dxUGdIcGRERVpuU3JDRmttd0dXLzVPUzV5K0VyMC9C?=
 =?utf-8?B?ZnFyWUtZUVZwbG93SWNrNWFyM1YrT2psSkRzTjJSRXdHMTQ3K3hCc28zb2hy?=
 =?utf-8?B?bVJzUWRJOE42TWpHRW9nQm9xZDBUSDdyc2xXN1pXQmJUK251TTVZMEgrTmtV?=
 =?utf-8?B?bE52UUhzWVNkT1NTdlNyWmhPK2w2MkF6QnBReDZYdHpFNmRPU0wvSCsrNU5Y?=
 =?utf-8?B?V2F0U3Z2ZEUrWXMzNC96LzFKTGtnUmEwZU5xWmhWc0c0VFhIWHZkUS9WcEYw?=
 =?utf-8?B?N0JtOTFCY3VFdktqSUNINmtJdmFyNHgzN2dKeW5CeGZGQzFLaUNaekV1Z0c2?=
 =?utf-8?B?VFZQZlNpRUQzWjNNcGF2cGVzaVV4aFVELzc1M2cvOEZoRlJIc24wZkd1U01z?=
 =?utf-8?Q?mdk3xTNDfNuwIQCsfppFsYU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c75821b-4ed0-4122-49f4-08d9c950c193
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 15:51:33.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LS4jzcQoYI3Carod6j4coxh4UTVESOQSjuSaTuaC78aiXSuK+3T83403cEvU3CLS5d4TnpDxsNyP8HlM3R9+mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5732
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
asynchronous processing of blocking locks.

Currently nfs4 use locks_lock_inode_wait() function blocked on such requests.
To handle such requests properly, non-blocking posix_file_lock()
function should be used instead.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
VvS: I'm not sure that request->fl_file points to the same state->inode
used in locks_lock_inode_wait(). If it is not, posix_lock_inode() can be
used here, but this function is static currently and should be exported first.

v2: fixed 'fl_flags && FL_SLEEP' => 'fl_flags & FL_SLEEP'
---
 fs/nfs/nfs4proc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ee3bc79f6ca3..f899f4bcdae5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7200,8 +7200,11 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	int status;
 
 	request->fl_flags |= FL_ACCESS;
-	status = locks_lock_inode_wait(state->inode, request);
-	if (status < 0)
+	if ((request->fl_flags & FL_SLEEP) && IS_SETLK(cmd))
+		status = posix_lock_file(request->fl_file, request, NULL);
+	else
+		status = locks_lock_inode_wait(state->inode, request);
+	if (status)
 		goto out;
 	mutex_lock(&sp->so_delegreturn_mutex);
 	down_read(&nfsi->rwsem);
-- 
2.25.1

