Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876955677E8
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiGETh0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiGEThZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 15:37:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24319288;
        Tue,  5 Jul 2022 12:37:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265JJuu7027557;
        Tue, 5 Jul 2022 19:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : to : cc : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=kK3qnChyj8/2PckhMIaNTEQzSbRAVqoYempWSs8CWuY=;
 b=UBuqk3uNWotAsztLUxmab8ZDiwW01ur735BkSrO3Hh5HGcOR2oM/66dhNuw003mLy3SH
 tt2FiUBZGY4SqBihxBEuabCfd9NNDWzljrhFMeAywLaAvnNDcCIQq/NmjpKWLWEKt0RV
 SOinj2HkxcjlM/STiQU2Xii30U3mkKhnwoGQw0YvcfFOK9BS+QkZtp2i9WPHEBjWCvtK
 xLZvKFqx1MXk6MvWPKu4IiWmzTM3hpGK7Yvn3wrwT+7Z0fOlRBZsPDliT2zkBAmp26xC
 B5azSiPZPYibeqVu/zkU9eLhfVxUbXMETi0GR2c/xYpqxbxj1SIj3u5jVCLygcc6TI8Q Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby01c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 19:37:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265JLkUc026411;
        Tue, 5 Jul 2022 19:37:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud08960-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 19:37:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5dgwK0q8STZaNzlOCX2qhmQeBGGC1lXWUyzYPTkcaY3IBr2xgScTDpoHP6T1ixmIxG75lq6aoowuWm+J69x1tPQfZyPgANQAsWzrhR0djecH49dqgQJDyD/V/S47kf5urGTZukDGABhw50BHg0rs+6Hvmo0F6mssuWF2wqnhhJt4lynjCP0FhE4Z/QKcHb1s/i7mP3YW6YXgLVzskHZyB2qUYBTxW0Ie+6UcoJg+M5dFFAh7AiYQS88f530ooFUi8AvvJhyJ8nzPalgMjHNn/wNpr0zU5WPjHhTgQ+ua8/qcJ2J4dhhZdD+L2JeNoxfj+/n67u4l20lK1zGJF/C4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK3qnChyj8/2PckhMIaNTEQzSbRAVqoYempWSs8CWuY=;
 b=St3QEZhFZRhlr/s4yXajmOGI04VKWVd6Kh4TXxSJacktJ5LdpxZBx+s2ExusoW/kPLm8NMZvdIznQkg4SFHsOypjTe+oa6vjsRWmA5Mnwbfd+XIkvfBAtcKveplzV06FJ/318g1hD5fAmhGtorVw8N2rnCX/7FbMgc+g3s1LaCi+LvpM0X4rVXzZYYwOOL0f6FkBqR9W+Kdhh0MdlNQIAkQCJ4olFXRj1aTx3DdR44OBKFiuTBSbKzGS+ulUbT3CaNVv9v667lnb0jAv3FHKDgocwUGCclNYmwvOVbPXHptsfwRdzeSPnrI/5tEoxRQpPUEARGTCYHBO8LTyYrfn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK3qnChyj8/2PckhMIaNTEQzSbRAVqoYempWSs8CWuY=;
 b=uWQ6AYGzMHaCdVkTbXZbSk9uWz9gGgavLoYxMWKLqjqa3arwXyEsEiEgNvhuUUFaKMEouLDxMcnfSrYjxrfcdvCYG3kSGNpqyGfBnZKrUCTqr8mL6kF0ZPPyInEl/EuYm7XX52TzWPkzQJH55RGn+tQugudnvWP5skWy4oQPd5g=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4015.namprd10.prod.outlook.com (2603:10b6:208:1ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 19:37:16 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%4]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 19:37:16 +0000
Message-ID: <c09e1af7-7d1f-1bbf-5562-ead9a4d99562@oracle.com>
Date:   Tue, 5 Jul 2022 12:37:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     linux-btrfs@vger.kernel.org
Cc:     gniebler@suse.com,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: bug in btrfs during low memory testing.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0043.namprd05.prod.outlook.com
 (2603:10b6:803:41::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1958ad08-4617-4d6d-c9f2-08da5ebdc44c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TZfDPYFZA+ZSzt03QzQRyJeq5b6FzIBwabYCwgCHEBS8PSgw04GjR6XTxUrIM0hPg+oNTW6jKt5Dp3cqkI/yU04CVb90nLiTB+RaRWDuuFhmgcqQfwsBpPnjZBZblEtCKPuVt57gy0s45D1XHbd4xokkYKCEA6w2WY9/ZXNPhsPrd/aDRT/a0IxF7/OyToJWbKjKJJ2y0fJe5gSsC5OT+UL6808TPMJW07v1vZpb/8oTDfqpLwjFJqI6xiih1x0wtqksr4uzZxuIKfFGsxMYESm8TFs+KT5qW4GIedtpwcU7jixGzGkEqLJWE1x+s7bvwrNnCcolawEf8yiw09b46QKxb3L/JJmNj+6wbJzh+5e6dx09OmtoEt23GV0PgJ0BlPdCM+hp9F1mQfExZ3nzQYH3Y/JgqYA1vsE0fOhH/Cd81qVBfeGayVaHNlPAfNGWa3qq0oRt2MoiEo7gcxjxnuZI1rdSiCxGfdELCCh82/aJZk5lIrZRpmsA8xZNuyepg8ob7EaNqNPWdywiN7ZZ6gGw7Elo4TxWvnunqHLhtZw09gRoFQnpBsq2vsLDPkJglOXt50omdCIfixxI97SFXQTAoQs/atabPd5Tb4EFhiTm6kglq99lS+YdIT9007IcMyNfulwNgXz7jI/q7V+2gjs3M61g+v2He2sIkxAsHhsSj6YCfGrcf/nm772f7cXOqhH2QzufxTHOSnaYSdhxIqi1Rm4XyjNIpHEqFTIQ5iEWdbxbrBMFP8JUOpGEP5123njLKi2M+AJggyW7n4xJcOvtCJ9vpeHcMYIup37nB2hnTWo1XvpQZcC+ACFiVP7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(8936002)(31696002)(38100700002)(6486002)(86362001)(478600001)(66946007)(6512007)(4326008)(8676002)(9686003)(66476007)(66556008)(5660300002)(2616005)(26005)(186003)(316002)(36756003)(6916009)(31686004)(2906002)(41300700001)(6506007)(83380400001)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dSsrYWpEdUNqYXphWHBwVXdublQyVjJFQTlCVnlmU2lMVTVJc3gyeDg3ZG1p?=
 =?utf-8?B?dUJtV2U3TEZ3c213SVdPNTlMdUxYZDRNdmk5T3lYS3R2WENFYk1SdFVDV0Js?=
 =?utf-8?B?R0VUbUthUzZvR29sMkdNQnRudWY0SnM0ZGdTZkJ3TU5UN29YYW5Sc1lxYnNu?=
 =?utf-8?B?dVV3WEF2d0hzSTdIOGZCTktTb3pkbnB2NVE3ZEpNWUZKMDlWVnpHakhGZWw4?=
 =?utf-8?B?UTZPQWlUSGRzK2dtZXNMWXg3Ri9aUTJ6Z3h6UFIzN1JXZHBvQTJRTXJTNmM3?=
 =?utf-8?B?VitpN3luM2d4ak1NZmprV2VVNkEvSC8yRGJtRUo3dGRGUi9aL2lqWEI0eW9j?=
 =?utf-8?B?WFNHUFowUHloY3liODVwdzBQdHNiUkJTMEFaZXdGTzN6bFBjeHZhNE9RSGxN?=
 =?utf-8?B?dUhoaHZUemFoQWlXbE1aY2xzRzBQTXBteXRuVXE0RWN4ZDRwVmxmT1Ezc1lv?=
 =?utf-8?B?STViby92L01UUCs3bGRiVncxSGNYS2RRYzdDTk9JV3V2aVQ2SUlaTkNUZjFi?=
 =?utf-8?B?dDkvNDNrSWxYeThMM0pINmFYdlRtYmdwSXJYOVdIZ3ZVYWcvbHRPOEI0aUMx?=
 =?utf-8?B?VXVzRlUzZWxwcURsT3Jzd201K3QrUmVMRlVwckZIU1pHUDc1MHRLaElsUjJQ?=
 =?utf-8?B?TEtIZDJnRlJ5clNJSGRzS0NGakRycEhIakVMOHBIZlFjNXJuVHBaMkJCUk9F?=
 =?utf-8?B?cHh3ZDJiMG5JemFVNVBtUEVVT0NPNUx1VDJzZEp3cE95ZDllczlwa0FqaTRS?=
 =?utf-8?B?b0hOZS8zcnJVckx3UHdxUmZOd0p4NDNUTWFQN04zbEEvL2NwSjdXOVZxQWFM?=
 =?utf-8?B?aENpY21Qc2lmTU9FdzkxckFmUDZJdXVicWdIRTFRcCsrclZUSWtVS2o4ZVZs?=
 =?utf-8?B?dUphVXZVaU9GMUpkWk9VTUMyaXFzSW51ZnBRWGFEOWk5TzMwdnFxbDBkOTVZ?=
 =?utf-8?B?bElEcGhTb002NVVTOFdnaXphNFAxdGtDWEpodG1pcStwemw4aENiaEhjN2Jj?=
 =?utf-8?B?bExndlh0OXN3cjJyc1FwZk5PbkdrWnRhSFMrWnhtR3c0d0JwTVVra0xIZW4w?=
 =?utf-8?B?U2ZYYzNGVUxBcitvWXV2dXViSnJQcFN2eU5tUFlVK3grZ0tmRzhOYkR5aHo2?=
 =?utf-8?B?YmhmU05udlg5YTBUSFY5Qzd0TWc5YjJWVzRyUzl0V3Jld2cxbTNlUmw2eVhx?=
 =?utf-8?B?aDlQMkhUQ3FmeDE4NjJCSU11b1o3c3VQR3hwTWdOQWNVRDJxM2xVRDFnYmdJ?=
 =?utf-8?B?TVdrZFV0eUEyczFOcHgzQlI1UzN6UmE4TTFLd1pwbkhjN1hEUzAxSjAySFBw?=
 =?utf-8?B?L1ZkV2VIdUhDTmQxYjhxK1kwaE9HR3lUb0ZjTUFKVHpqeHpTcUxzeVdIbjZB?=
 =?utf-8?B?ay9pa3gvTmNIZVZxV3I2bDF6c3pnM0d1REZRaW0zM0N6VVptc3RmQ0piV0Zq?=
 =?utf-8?B?N1YvTXJCWXIvSTlQekxFcDJXNEZNU1dhOVpDWCtKL0ZKRnR6SXhOTTBHODVG?=
 =?utf-8?B?QTVYK1pndXFOS25mSUZhUVlBVkpLQnlUZjdRV2VOdFd4ZTBGUFd6MlE1eGxB?=
 =?utf-8?B?V28vMTQ2TXpRdzRJQ0NUUk92UkROZmoyN3k2dzQ1cnZFU25PVGZUTjJSZ2Zy?=
 =?utf-8?B?Z2tDZFd6ZHFtWWlTK0plcEsvK2xxTmR0MTdaV0NQZFdpaG9hU2hldXJsWExm?=
 =?utf-8?B?bFdQSC94bTNTZDR5MlFmNjhrTjFNMGhQSmU2cDlONGw0Z3l0MjZUMEUzZGJB?=
 =?utf-8?B?MUNKc3lENWJQQk1ydjcyckpaR29ITzNvRFNlSGR2RGtHMFgyWFArWTJDQmZl?=
 =?utf-8?B?UHJ6akJJdytZbVZnOXNDc0MzVmFCNEZMR2I0TG40L1VwYm4zS0FMYi9MV1Uw?=
 =?utf-8?B?Q084WjQxY2V5aE9zck1pQWRHZFhrMWMwZDhvSDUwMFBUWVdrZDZGT1lqQmRZ?=
 =?utf-8?B?NFRhYjV3bEpjL2pJNmxCMkJwdU5uTmc0ZDNhVk41aHlKakNuTDhSTk9xdTFP?=
 =?utf-8?B?VmhQd0pvNVpzQ0RldUF6L1pOeFV2b21NWnBpL0IzSjAvaWMyNHYxT1NTaGY4?=
 =?utf-8?B?RUo3ckM5eU9kR0dPSTQ4dHphM2krSHkvMVFYa1dCZ0pxTjZjVmJxQ1NnSlg5?=
 =?utf-8?Q?/a5YyqzMcoui63t0/2Jbf2ZFr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1958ad08-4617-4d6d-c9f2-08da5ebdc44c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:37:16.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: augGw+ZMcDtoC7SS6XrdlyzRYa0vWd5fclv10n5m/O3OLGiV90WGWLC2Gj0G+AKQs8eU5HhOFRUayJfmtpysMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_16:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=963 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207050084
X-Proofpoint-ORIG-GUID: lMjBGBpvdCHNSZMsGo4CeewnC2gS2ccy
X-Proofpoint-GUID: lMjBGBpvdCHNSZMsGo4CeewnC2gS2ccy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

During my low memory testing with 5.19.0-rc4, I ran into this
problem in btrfs where the thread tries to sleep on invalid
context:


Jul  3 04:08:44 nfsvmf24 kernel: BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
Jul  3 04:08:44 nfsvmf24 kernel: in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4308, name: nfsd
Jul  3 04:08:44 nfsvmf24 kernel: preempt_count: 1, expected: 0
Jul  3 04:08:44 nfsvmf24 kernel: RCU nest depth: 0, expected: 0
Jul  3 04:08:44 nfsvmf24 kernel: 4 locks held by nfsd/4308:
Jul  3 04:08:44 nfsvmf24 kernel: #0: ffff8881052d4438 (sb_writers#14){.+.+}-{0:0}, at: nfsd4_setattr+0x17f/0x3c0 [nfsd]
Jul  3 04:08:44 nfsvmf24 kernel: #1: ffff888141e5aa50 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at:  nfsd_setattr+0x56a/0xe00 [nfsd]
Jul  3 04:08:44 nfsvmf24 kernel: #2: ffff8881052d4628 (sb_internal#2){.+.+}-{0:0}, at: btrfs_dirty_inode+0xda/0x1d0
Jul  3 04:08:44 nfsvmf24 kernel: #3: ffff888105ed6628 (&root->inode_lock){+.+.}-{2:2}, at: btrfs_get_or_create_delayed_node+0x27a/0x430

Jul  3 04:08:44 nfsvmf24 kernel: Preemption disabled at:
Jul  3 04:08:44 nfsvmf24 kernel: [<0000000000000000>] 0x0
Jul  3 04:08:44 nfsvmf24 kernel: CPU: 0 PID: 4308 Comm: nfsd Kdump: loaded Not tainted 5.19.0-rc4+ #1
Jul  3 04:08:44 nfsvmf24 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Jul  3 04:08:45 nfsvmf24 kernel: Call Trace:
Jul  3 04:08:45 nfsvmf24 kernel: <TASK>
Jul  3 04:08:45 nfsvmf24 kernel: dump_stack_lvl+0x57/0x7d
Jul  3 04:08:45 nfsvmf24 kernel: __might_resched.cold+0x222/0x26b
Jul  3 04:08:45 nfsvmf24 kernel: kmem_cache_alloc_lru+0x159/0x2c0
Jul  3 04:08:45 nfsvmf24 kernel: __xas_nomem+0x1a5/0x5d0
Jul  3 04:08:45 nfsvmf24 kernel: ? lock_acquire+0x1bb/0x500
Jul  3 04:08:45 nfsvmf24 kernel: __xa_insert+0xff/0x1d0
Jul  3 04:08:45 nfsvmf24 kernel: ? __xa_cmpxchg+0x1f0/0x1f0
Jul  3 04:08:45 nfsvmf24 kernel: ? lockdep_init_map_type+0x2c3/0x7b0
Jul  3 04:08:45 nfsvmf24 kernel: ? rwlock_bug.part.0+0x90/0x90
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_get_or_create_delayed_node+0x295/0x430
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_delayed_update_inode+0x24/0x670
Jul  3 04:08:45 nfsvmf24 kernel: ? btrfs_check_and_init_root_item+0x1f0/0x1f0
Jul  3 04:08:45 nfsvmf24 kernel: ? start_transaction+0x219/0x12d0
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_update_inode+0x1aa/0x430
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_dirty_inode+0xf7/0x1d0
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_setattr+0x928/0x1400
Jul  3 04:08:45 nfsvmf24 kernel: ? mark_held_locks+0x9e/0xe0
Jul  3 04:08:45 nfsvmf24 kernel: ? _raw_spin_unlock+0x29/0x40
Jul  3 04:08:45 nfsvmf24 kernel: ? btrfs_cont_expand+0x9a0/0x9a0
Jul  3 04:08:45 nfsvmf24 kernel: ? fh_update+0x1e0/0x1e0 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? current_time+0x88/0xd0
Jul  3 04:08:45 nfsvmf24 kernel: ? timestamp_truncate+0x230/0x230
Jul  3 04:08:45 nfsvmf24 kernel: notify_change+0x4b3/0xe40
Jul  3 04:08:45 nfsvmf24 kernel: ? down_write_nested+0xd4/0x130
Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_setattr+0x984/0xe00 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: nfsd_setattr+0x984/0xe00 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? lock_downgrade+0x680/0x680
Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_permission+0x310/0x310 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? __mnt_want_write+0x192/0x270
Jul  3 04:08:45 nfsvmf24 kernel: nfsd4_setattr+0x1df/0x3c0 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? percpu_counter_add_batch+0x79/0x130
Jul  3 04:08:45 nfsvmf24 kernel: nfsd4_proc_compound+0xce8/0x23e0 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: nfsd_dispatch+0x4ed/0xc10 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? svc_reserve+0xb5/0x130 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: svc_process_common+0xd3f/0x1b00 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: ? svc_generic_rpcbind_set+0x4d0/0x4d0 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_svc+0xc50/0xc50 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? svc_sock_secure_port+0x37/0x50 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: ? svc_recv+0x1096/0x2350 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: svc_process+0x361/0x4f0 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: nfsd+0x2d6/0x570 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: kthread+0x2a1/0x340
Jul  3 04:08:45 nfsvmf24 kernel: ? kthread_complete_and_exit+0x20/0x20
Jul  3 04:08:45 nfsvmf24 kernel: ret_from_fork+0x22/0x30
Jul  3 04:08:45 nfsvmf24 kernel: </TASK>
Jul  3 04:08:45 nfsvmf24 kernel:


I think the problem was introduced by commit 253bf57555e
btrfs: turn delayed_nodes_tree into an XArray.

The spin_lock(&root->inode_lock) was held while xa_insert tries
to allocate memory and block.

-Dai

