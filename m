Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6283468A60
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Dec 2021 11:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhLEKq6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Dec 2021 05:46:58 -0500
Received: from mail-eopbgr130134.outbound.protection.outlook.com ([40.107.13.134]:42563
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232943AbhLEKq6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 5 Dec 2021 05:46:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWSExGjxlWvWo/ia/ZLFxUKVxBKzV/AKF+jrbQG7tdPjsVjhAHtLRK28fTmhHqEBX3Pq/8wIgnbaqq2ruLJlV52zxf3iPHLnwEZnTPwcRqvl6VQD0ry3jkTU3Hg+uaVhfOs0Su6PR6ChufW9F/8nFRDcq82wCgy6iIhf3G38qq6FxWhe3wK5dgiKT6ZOE3J9bMUYB6klGoWdCGzxr/YmICtZ9lsM/3j6TCiZEkcF2SLF/b/MEFdkVbg+xSBdxPgv4oAFi/+IDe0j1JcS2myg7izy3zHCG8pzQNZ205iMzjCCgafZPd+W7L9TCkqVWqb31mri8qdKjwGKKDrtCsE97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kB7Eq3dpPfH2JwTgfZ7/Zt6zWxtukEKwpzDp6kGINM=;
 b=DW/DZ2xl3nIjjQZ/pf/wfxYcDEdTCTMUEydCia0kwPuIxFTC7Pk+DsFDPXppIhI11y005Qwj1BbQny54gFfEoOkGuFDDoxB4D3prOszI4t3LjbikEesbsQNVDu1CLQrREvv2ZB7IoosNdPhX1aKqG1bhivNmnyYNpxzhlmlHf74I8E4QnkDEm+t3CPoScTp8Npl+9tUgRP0N8fOq/OwceM2feiV3eIdluLODJ3cH+vynMFRux/yaHp2LIirzIgJELxt8IZJw7SYP7D6hF9jWt3r5y15JFrFrDKpztvhZoMV/cJUKoZZr8Iu/bbRc9F77GC4Is20ZqCWimtQ8TPL1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kB7Eq3dpPfH2JwTgfZ7/Zt6zWxtukEKwpzDp6kGINM=;
 b=sLp/OlphUs5pyiJcaF1iTKKBFOl6HrgIkm850SIWRz992lsHQ1TniOp74u7FMnooO8+ToVble5bBDdqHAkR3Q3epl6fkNr7uNNs8e77MsuOg0KDo+DqXFrGANLqp4hBd3r8VTiZewkWxsjVtY5sGumUMBMkVvUZ2RrXhaFVLlnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB8PR08MB5162.eurprd08.prod.outlook.com (2603:10a6:10:ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Sun, 5 Dec
 2021 10:43:28 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%4]) with mapi id 15.20.4755.021; Sun, 5 Dec 2021
 10:43:28 +0000
Subject: Re: [PATCH] nfs4: skip locks_lock_inode_wait() in nfs4_locku_done if
 FL_ACCESS is set
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@openvz.org
References: <4088a4fe-1c1e-7b9b-0685-dac367094b61@virtuozzo.com>
Message-ID: <596e1570-5c21-44be-dfe9-b992a7e54827@virtuozzo.com>
Date:   Sun, 5 Dec 2021 13:43:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <4088a4fe-1c1e-7b9b-0685-dac367094b61@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0102.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::43) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
Received: from [172.29.1.17] (130.117.225.5) by AM6P194CA0102.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Sun, 5 Dec 2021 10:43:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b3e4140-b78d-432f-3c77-08d9b7dc1255
X-MS-TrafficTypeDiagnostic: DB8PR08MB5162:
X-Microsoft-Antispam-PRVS: <DB8PR08MB5162D5AAD508334B0710B7D6AA6C9@DB8PR08MB5162.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqlN+ql8ofQOi/JEiMARq0/wZHhfwqVr4X8nUKeMGBFN2oR6p5x/OhspmvOvbKUMtvm+k4GC/2FZUcT8JIVzD5hX2JvTj1YdJ1tIpp9+Ji1CNsWFsrnnhUojZ4yMLlS4B/kcEwCECAvwftR0FJG7ephBGBMtFvEUrB0HwZa31xFeejsUwgD6V8fkcwf4xnTo45oJrZ123Aj5126wBN1BcXfqQB1TfxHl42toEUqtqm0SjhFrDruIWgPQ95ck0iN32caAiPZR73Ab9XPtGwI9b4tmtal5qHqXSDVLD0YWnBnPbSrQo+CLTHp6M9t2z32FNnu+5QVWaNLABcNKD8wkFFaGf78NUty+HCw9N3O5buo+SJb0oWYWoWKDXzzzYe+/tiOibz8oBHppib0kQQ30wlK6FNpsZqpy05xJBxLuMx/q02XDM8wz3pkfZJwWYoO9XvSToQOYW+Twzl0t2F1R2UgiVpiC7rrbuT0nWbvxCBjjo32jL9FkIIrXDSJXerAjI2pXJ2BWBM+GBNZUk30SWDDg/+YMNUWKVrT5EQ9lwwXnCRi1rcKpSrmsFrQ8t3t9gvh7foi4hE9/QwwV+qheK9i8NRa7lJSnE+qLrhFjVR2LDWW/wB0sD+MMv1MtFsXt45iPkfEPOlDbdougplgEtM8SzUOxvOflu0uwRsOcfw1HzxsKLuSRUMshr3TEAqb9M6V7Hw7/nwo4afUCoRdvQGWq3DQUlojdy9GvmwvNYUT8LZbaRoGwqpbB1s67ObzhOmqxkMOrGcm+KzqgrMUilw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6486002)(52116002)(316002)(31686004)(2906002)(8936002)(66556008)(66476007)(66946007)(508600001)(110136005)(2616005)(36756003)(5660300002)(107886003)(53546011)(38350700002)(38100700002)(26005)(8676002)(956004)(186003)(4326008)(16576012)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0pSWFVaQTRnY01wZFJKL1FON2c3bXZYVlYxQnZlMWlPZnREa0NOaFB6WDJh?=
 =?utf-8?B?MGg1cSs4TXUvMm04UDFyMEpJSEFrTHRMNnI2OXllQkhWYmhRYUtCYndwd2ha?=
 =?utf-8?B?OTNZWERoNUo1ZFFrdEdpK3I1QldobEVBZlhlRXovUzhOZzNrUGQ3ZXVjdUd2?=
 =?utf-8?B?ZzZhZ25XclhFVi80QXppcTJNNy9lT2l0Zmw4TVZTTWZVT3MrNWsxVXhSZU9G?=
 =?utf-8?B?Q0pNZnZUMnNMMENQMkd3TEJHanA2bkliUG9CRWVyL2VBM1ZCYU5tYXg2WU5a?=
 =?utf-8?B?ZERSRFBRWFA1TnFQbE9HSEVPV3NPK3hMR1R3NStZUUNjSEpJTzlrU2pSK01h?=
 =?utf-8?B?NzFBRlJnZGJmRU14WHozRTFXSnJMMzdmaUxlWUxGdDFFV2pxSlN4RkdOZXNu?=
 =?utf-8?B?WXhoUnBGQXlPbnVMT25Zc0NhMHlldm55NG5oQmZwK3c4TjVQSERRZkZ2TXRZ?=
 =?utf-8?B?a0lBOXZQdlBVMG42RUgveE9EU2EyMVZ2MzEyalh4OGlnRmxZZklpY054czJW?=
 =?utf-8?B?V0JxMUhVLzdxMUNJKzRtQWxHNUwzekNtRlBkQisxRXdDSW1qc295YzduNDNu?=
 =?utf-8?B?NjlxK3dMbjh3SWw1aC9DdmVVaWdWd2xiWWhwNy9Ebk5jNFpnb1lSaWRsaXoy?=
 =?utf-8?B?MDFVb2JNOVF5TWc0WnQvUFdBZjNqZ0xWMXpSc2NSV1g2UHRDTWJhclM5TFh0?=
 =?utf-8?B?amRqK0k1dUZaNmdyQzRRRjhubGs0NTJoZ3hZWk1OVUcxZ2Fzd3pqS3hhVzEx?=
 =?utf-8?B?Z0JDbEhxQmdIeGtySHNCcG02azQ3NDhTajFQbmZLOHFNdjA5NHpjN0JhaEFm?=
 =?utf-8?B?VUxUTTBKaENESW9MRE8zM2ZTczlCOGxhNnhJV1VOek1MOGR5Y0NmRVBuNlVR?=
 =?utf-8?B?ZWxxVjFKZ0NkdGZRZUJnMUNOaXRqc3UzV3RabVptUndodk1naHRPZFJnb2Z4?=
 =?utf-8?B?ekQ4OUxCREVSMVZQd1NnazB1ZGE5ZHpmOFBlTTBzbXZBM1gxOHlhdW5YVzBK?=
 =?utf-8?B?RnIrbm1lZmQ2NVltcXZ1R3NLRytSZlFZazBoMmtIL21wVXdyM1poU1cxZVoz?=
 =?utf-8?B?VGxxSkkvM1VVZys5RlZaZmp6UjR3WFZLcHgvRzdBeE8xZjFMYytlcmF6WUpt?=
 =?utf-8?B?K05keGdnQzFmRlhYWEJaZzZCNTFFa2FjZFM3NEgyWFgvV2JNckdSSktRSnZ3?=
 =?utf-8?B?Y2xpMmd0b2dsa0hBV3JjcUJNbU5SbTg2N0ZWdWVXa1NNWG1xcXJra0ppd2d1?=
 =?utf-8?B?WU55RXZWb2xLdktPZGZpZ2NTL2FmSENHWEhzZFhMZnRiR0RUT2cxSHZSMXc1?=
 =?utf-8?B?c3I2ZVBBOHJWY0E1R3ZiSFY3VWUwNVhyTlF2SWpqWUwxT2owVVUvS3h6ZEV5?=
 =?utf-8?B?aGR5U0FyeWIvZXZnOU1TWWpObEp6RS9ZTUJOMkticFhtYkxhVDhzc0ZnbnJI?=
 =?utf-8?B?dlZFNk9mYmlDZEoxanNyTXhMLzJwa1c3WlVpSzZpM1pmQmtZV2szQ1RaR01D?=
 =?utf-8?B?MS80aVVjT1o2b3hpRldNdDB1MUdmaEx6bDlXelVaOWZEM2M2YUR1TENxc0lP?=
 =?utf-8?B?Smt1L3NCY0FYa2lZV0g3UW1ydzdVSFpBOEdxb1IvTkJxM28zeXppdis5RmZL?=
 =?utf-8?B?ZXN4cmlmME03NVRLcTMzaVNUaWcyQ3U5alpaUC9YTlFCeWxJc0hKNXpXNmZr?=
 =?utf-8?B?R2NTSXNsUHBDNWVFbkFueVVUaUxmbUhVbUdiMjlBaTJFSXAxSEVqUGRwQ1Mr?=
 =?utf-8?B?WGU3Z2hIdHEwenJNSkFnV1VmSndpWlpGbjIyOTNkbC9qOE5sMjlwajFWU2xQ?=
 =?utf-8?B?UlVzaXNQY3pRdHFNQzdqODZVNDF1eFFsYzI5NS81N0JZWmhDU1YzZmZwVTN3?=
 =?utf-8?B?NHljdEN1Wmh3dWhscXExSy9MbnZMZ1lXaEpYWSs3Z0k1SkZHeGhvR1g0UWo3?=
 =?utf-8?B?QTB6YXQvWUFnd05XM1JUcXlYcmwyeWVhYTU4UjRORlRMeU9kUTNXRlQ3cSs3?=
 =?utf-8?B?WWQ5WXVyblBwRG90ZHg5S0N1MEZXeU85NjJWazhScEQ0THdTNVRkRVNFaFBp?=
 =?utf-8?B?MllZb241aS92QzMySGVaUk5wQmEwMjFpVHdnYW5uTUFEWGRhVElVWFNUNEFO?=
 =?utf-8?B?c2hzYy84M2lobFRrWDFLWDFjVXF2NnZibXZ4OHdpdHRZRWFzS3VkVXVDcVhK?=
 =?utf-8?Q?EDRJLOSDuBn7ngyUfg8DpCU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3e4140-b78d-432f-3c77-08d9b7dc1255
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2021 10:43:27.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrLIjk/wYeR2Mmys2ix9TpM3kdfUDaziN7Id5vSjhr2eIVPYxY17Fcgp4wTcMLzwPUq84VWejp7t00qU5/4Eyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5162
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 05.12.2021 13:12, Vasily Averin wrote:
> In 2006 Trond Myklebust added support for the FL_ACCESS flag,
> commit 01c3b861cd77 ("NLM,NFSv4: Wait on local locks before we put RPC
> calls on the wire"), as a result of which _nfs4_proc_setlk() began
> to execute _nfs4_do_setlk() with modified request->fl_flag where
> FL_ACCESS flag was set.
> 
> It was not important not till 2015, when commit c69899a17ca4 ("NFSv4:
> Update of VFS byte range lock must be atomic with the stateid update")
> added do_vfs_lock call into nfs4_locku_done().
> nfs4_locku_done() in this case uses calldata->fl of nfs4_unlockdata.
> It is copied from struct nfs4_lockdata, which in turn uses the fl_flag
> copied from the request->fl_flag provided by _nfs4_do_setlk(), i.e. with
> FL_ACCESS flag set.
> 
> FL_ACCESS flag is removed in nfs4_lock_done() for non-cancelled case.
> however rpc task can be cancelled earlier.
> 
> As a result flock_lock_inode() can be called with request->fl_type F_UNLCK
> and fl_flags with FL_ACCESS flag set.
> Such request is processed incorectly. Instead of expected search and
> removal of exisiting flocks it jumps to "find_conflict" label and can call
> locks_insert_block() function.
> 
> On kernels before 2018, (i.e. before commit 7b587e1a5a6c
> ("NFS: use locks_copy_lock() to copy locks.")) it caused a BUG in
> __locks_insert_block() because copied fl had incorrectly linked fl_block.

originally it was foudn during processing of real customers bugreports on
RHEL7-based OpenVz7 kernel.
 kernel BUG at fs/locks.c:612!
 CPU: 7 PID: 1019852 Comm: kworker/u65:43 ve: 0 Kdump: loaded Tainted: G        W  O   ------------   3.10.0-1160.41.1.vz7.183.5 #1 183.5
 Hardware name: Supermicro X9DRi-LN4+/X9DR3-LN4+/X9DRi-LN4+/X9DR3-LN4+, BIOS 3.3 05/23/2018
 Workqueue: rpciod rpc_async_schedule [sunrpc]
 task: ffff9d50e5de0000 ti: ffff9d3c9ec10000 task.ti: ffff9d3c9ec10000
 RIP: 0010:[<ffffffffbe0d590a>]  [<ffffffffbe0d590a>] __locks_insert_block+0xea/0xf0
 RSP: 0018:ffff9d3c9ec13c78  EFLAGS: 00010297
 RAX: 0000000000000000 RBX: ffff9d529554e180 RCX: 0000000000000001
 RDX: 0000000000000001 RSI: ffff9d51d2363a98 RDI: ffff9d51d2363ab0
 RBP: ffff9d3c9ec13c88 R08: 0000000000000003 R09: ffff9d5f5b8dfcd0
 R10: ffff9d5f5b8dfd08 R11: ffffbb21594b5a80 R12: ffff9d51d2363a98
 R13: 0000000000000000 R14: ffff9d50e5de0000 R15: ffff9d3da03915f8
 FS:  0000000000000000(0000) GS:ffff9d55bfbc0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f93d65ee1e8 CR3: 00000029a04d6000 CR4: 00000000000607e0
 Call Trace:
  [<ffffffffbe0d5939>] locks_insert_block+0x29/0x40
  [<ffffffffbe0d6d5b>] flock_lock_inode_wait+0x2bb/0x310
  [<ffffffffc01c7470>] ? rpc_destroy_wait_queue+0x20/0x20 [sunrpc]
  [<ffffffffbe0d6dce>] locks_lock_inode_wait+0x1e/0x40
  [<ffffffffc0c9f5c0>] nfs4_locku_done+0x90/0x190 [nfsv4]
  [<ffffffffc01bb750>] ? call_decode+0x1f0/0x880 [sunrpc]
  [<ffffffffc01c7470>] ? rpc_destroy_wait_queue+0x20/0x20 [sunrpc]
  [<ffffffffc01c74a1>] rpc_exit_task+0x31/0x90 [sunrpc]
  [<ffffffffc01c9654>] __rpc_execute+0xe4/0x470 [sunrpc]
  [<ffffffffc01c99f2>] rpc_async_schedule+0x12/0x20 [sunrpc]
  [<ffffffffbdec1b25>] process_one_work+0x185/0x440
  [<ffffffffbdec27e6>] worker_thread+0x126/0x3c0
  [<ffffffffbdec26c0>] ? manage_workers.isra.26+0x2a0/0x2a0
  [<ffffffffbdec9e31>] kthread+0xd1/0xe0
  [<ffffffffbdec9d60>] ? create_kthread+0x60/0x60
  [<ffffffffbe5d2eb7>] ret_from_fork_nospec_begin+0x21/0x21
  [<ffffffffbdec9d60>] ? create_kthread+0x60/0x60
 Code: 48 85 d2 49 89 54 24 08 74 04 48 89 4a 08 48 89 0c c5 c0 ee 09 bf 49 89 74 24 10 5b 41 5c 5d c3 90 49 8b 44 24 28 e9 80 ff ff ff <0f> 0b 0f 1f 40 00 66 66 66 66 90 55 48 89 e5 41 54 49 89 f4 53
 RIP  [<ffffffffbe0d590a>] __locks_insert_block+0xea/0xf0
 RSP <ffff9d3c9ec13c78>

In crashdump I've found nfs4_lockudata and (already freed but not reused) nfs4_lockdata
both have fl->fl_flags = 0x8a.

Thank you,
	Vasily Averin
i.e  have set FL_SLEEP, FL_ACCESS and FL_FLOCK.
fl_flags = 0x8a,
