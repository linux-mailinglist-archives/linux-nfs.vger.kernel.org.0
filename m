Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A06445B066
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 00:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhKWXoC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 18:44:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14644 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhKWXoC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 18:44:02 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMinaH029976;
        Tue, 23 Nov 2021 23:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=owp/cpUkawJLzGGdIzNA7BDsxNfsvqpoclTHerhyuFE=;
 b=e3lX87URePA3WDqjd98kyts6/N8zp1vJDv75v0vJHdkAXXRXhPWY+IBoOsWCnzEX71Hb
 CpKVOO90V6oNgs9Kk7fPD+WTyjDvNhG4yMUIgSbbUxkRKGsm8Pbbsxn4mXFS81UF+ZSG
 0kGhPlkYDdI+ZGx/aMlhjptY1/nJgkgDYzlFTa9fFf7DUl83ZBuK7W1x6zz3vlx42YqN
 dKDXAfMtlsHYKvj0oGijW/rbOXG/jvOLwHhAavj6Y+gWKrBBLqTR+DV8+WhAObMaRVLM
 Vpk7bE0OMhc9rH3/XW4paK942Y3/TTcUvDhVI/Q3ZcWfsixLlGyaCwBozWAOA9LasEfG 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg55g5ybw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 23:40:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANNZZIn190962;
        Tue, 23 Nov 2021 23:40:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3ch5tgbbbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 23:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lULq0Cl0yOqqsVpXt2FUZ88QuGJxaTCa5evFjs/qKeo3WS5fjhKc9ewK5aHNDEXuX6Q2WyzmV9Ir8NafQFWXLoWvai62ScGIc2bN3o1amW50tNJhaNOsCalkvoQ9bhnrT11Zzldc19vJk5JkN0csy7VI1piAWgzZirSGwZOiL9TeRPXZd0Bfkrz5tMPKQ7Hy3vpPkIAqaO1PS1Arj5grAFmGCgJvxrkLlgJg+6CWgNps7Ag+iY2wyISeB9P/XFI3WUuK0yXn3SVdhr5j19d8sawifmkrYblbyz2wKRrhovyOGXBCiJUxGROspNqGmIqdCPsmjF4N0TsKxbEDXbBTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owp/cpUkawJLzGGdIzNA7BDsxNfsvqpoclTHerhyuFE=;
 b=X1SIAtJx0Ml7tZLbOv0SeiOcRnk/l0He56zH94Hxt13jZCSuHHcercSSC1r6dmZKBGiMkPPGy+TailEOU41PGP2IEOPmLIDq7Ct+TYEg57Z3eLYLpc36qP+WBbNbjwNouqInA26Ue99SGmsZJ9SViyuION0e2uCABtg5zy2nPSEdzq6qWHw9I8X1Dm4FMKm8ywRyehUBkKsOR4Hl/hpHJmSjsnEYdy6x4WfBGJjdFwybB90ZeSv6o+IQxmbRmFBcJrhy5VEOAO/6m5sZgkw3ur+qyrn/emLuXDcNnKt/tVcSrg7Mrz1N67q8tFO6lBl3uTwFEnoUPZy4bsuOkpFgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owp/cpUkawJLzGGdIzNA7BDsxNfsvqpoclTHerhyuFE=;
 b=YVET0CxKkPjN9JEtTkYiIQcM94fK91y0y68hj39D3vzPY/+jrTeF8tddcXOICgVIMvhvNzvKXYgHqkwyY9/RmnwyimQ2pgwgsENCebAO+wKtchbI2BmKAvyWBlRFKHWvyw8vvQfORcjwAh5DiTTBgmfd6d0EG/HViq9GKNttUNM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2645.namprd10.prod.outlook.com (2603:10b6:a02:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 23:40:45 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 23:40:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS problem in 5.16 merge content
Thread-Topic: NFS problem in 5.16 merge content
Thread-Index: AQHX4LgnWG/+assTSEixxDsrQufScawRxZ+A
Date:   Tue, 23 Nov 2021 23:40:44 +0000
Message-ID: <82433C4A-3F4A-4A24-861B-DE85D806B850@oracle.com>
References: <87202f9a-3fe1-dd12-63bb-4f9e8a835a12@cornelisnetworks.com>
In-Reply-To: <87202f9a-3fe1-dd12-63bb-4f9e8a835a12@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad1e9f1f-04b0-47cc-418d-08d9aedaab51
x-ms-traffictypediagnostic: BYAPR10MB2645:
x-microsoft-antispam-prvs: <BYAPR10MB2645505CDF1811CAD5A862EE93609@BYAPR10MB2645.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeDSyoU6gzyL6Ze9KGyjpSS2R7sTKhcL1WKSfLOIxEdtEGXNCTIB/HEi7+WA1ICF4hcJA3OUKX0xrvLGqvYFDbJeLd64AtHVw49Pu3Uw4K0bZ/KaKmnSKJ3kZHmq3RKrzcHoF95yYDvwlFPx6fiMucARQ1WyLaTiyQW9/4w/OwIKyBdAogZ7ETKnnaPElNLE7ctTPUrpjq+Es1rbIUG+eyt426EOSi6XzNcM/aJErfL38+XmUJGySVM/awrZL4CMbNGfjNm7dfRqTI+FcI7BbsJ40VnMrMX5u0+ZcpOWR2BNR2gRIze7sl26pQjEXHU7YQx0lW9zoHTl8KfNArANI0GaeiRfUki0R4bFZx14fmNbeX2NKOQc6x5Kjc+YFkNt1IZzdiw5Sb2KJtX8IPNgxv+mmSiXpuOQjpUCp5kYdK4UD4aHGf14MppZA8rCDudmR0Ao8Kklw7cGZ80aF5n1xljegCa4V1nnuBgp6x8Wv5sNDjiOPIfNBbX8TkNsIyAfeXk7eXPuULbqjGlPwF+cxA+2ZreehpSZFoEN+NceK2fdnYrVYXZeX2wGhJzdwr8GjPbrOy8mEuMOIHgFT80mtuzKpY2APbYLPDIT4IbCih8/xg6nl8kio7AjRCJZ246n8XS+RGqmcWg594ZdbK7hCg530d4/LUj3fy9K+ivdU7c8PiYYQrYqUwK8yFLzPDIOX1tJdwJWYLS/AFMbsOeM3tuODu+7Spm8JSJ9vj9lRnyuhO1yLkcId1wcSy7OmKy9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(2616005)(91956017)(76116006)(33656002)(4326008)(122000001)(26005)(53546011)(38070700005)(6506007)(38100700002)(5660300002)(54906003)(71200400001)(508600001)(316002)(86362001)(6916009)(186003)(6486002)(6512007)(66446008)(66946007)(66556008)(66476007)(8676002)(64756008)(83380400001)(2906002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mZdJV8pGi4wW5hB0JH8xc9poOfslYdxJwB+Mst3j/aODtvk6/TuQlvVCNUp/?=
 =?us-ascii?Q?95jLQBqN9aPO367cXXVXoGptuXTui1hHwydwxcp4e7e9SveHT8nlb8eyBLBL?=
 =?us-ascii?Q?091xUQuy0Du0//uJeryvaDc//pKOdkytTIAr18Sjq76DEa8ZMLV/w3zb/9ex?=
 =?us-ascii?Q?9EMDJAWzCcEMV0KqToa4cI5K64+/nrHfiqXi0W6A/QuXourJ3aaMxPmU1Ziy?=
 =?us-ascii?Q?+aHobTGZkdh9PbIFsgpjgIGnNhxAQCc08U2dkU3ELQU2KbHUNx8yxU2UTh76?=
 =?us-ascii?Q?aeat/r59Wxr/m56sa1KfGoRwDN6R/m4eoQ2LJys9u3cYQXfI2lenmK6t86DL?=
 =?us-ascii?Q?g+cwTTXh5RL1uyVke65G2NOGY1MpOzYVUYmoMmPAh7iTTDZDxK7MCi1R8CwQ?=
 =?us-ascii?Q?fh4i+K3UwVirNmVB1r5Fd0UQLB86dlLsbfSGT4uCsLyuOKG9PaIFHoEPHxlB?=
 =?us-ascii?Q?FT7692Rn5nY7YmdfCBgX4J9Q4k/nVUHoaTkP83dMgdbOcWAJ0HvwFLtiDtq8?=
 =?us-ascii?Q?MWL8cCG1VxXBeIr9iMzViRxg9oGxLSfnGw2CFr/p2XsHTgadMxq1/jpY8X7b?=
 =?us-ascii?Q?Q9cMXfNw3a9PYCHlq2G8ZzZCd1VMs63LdH55ipV6dx70miyOrdCjNv0QCYzj?=
 =?us-ascii?Q?PFLcivdtkIl7fIocGkAoPqVeGdBxdpgNZ7iZQp3TVdySb1MwiFuDeEc5waCM?=
 =?us-ascii?Q?NKkxrrkO/Hh/6YM4IGfjn2c3hmUAOHzBF9YKtCcDMrs0ZVusNIrD4JIf2HhF?=
 =?us-ascii?Q?a1parWzKlgBTcnOC4nQ5dza4BPiB9BPZDxYMTXLoMmbAy6qDOf35RIzxrZdv?=
 =?us-ascii?Q?s03PRZyxvb3eQn+MW36PzffI1Z/3o2Vnh103It8VjZeOw+WwQhiRGxCkDDaj?=
 =?us-ascii?Q?ekhKXp7+/iaSsdCFtQNsr3GZ9Tq8dWFmJ3j5wFzcWInepigdWljLtl3UWLEj?=
 =?us-ascii?Q?MO6shPxbpT4f9pK6lFXDrm3c57uFjowCoaUBE7neUVEI+RTrKBsmiEDqiHMI?=
 =?us-ascii?Q?q1FP+FqUuwbdDIwxuEWH6Onaq2sxbyMPZT40y9XvEAzuquFrh1e3wq5KsaRt?=
 =?us-ascii?Q?nixelz0hrxdFWyINkwfahFJuslLEziBSyfwebwGaTkCGul0P7Kk6SuKOUOqY?=
 =?us-ascii?Q?xYQ8Prf/3kaPsIy5eA6gL8cRrN+l8TIQJe9gQnwzisLYw1KaQm0x3lR4w3X1?=
 =?us-ascii?Q?WRhWV5ClL/3uwiYFVkft8FsEB4xEfXcViN9Rn/z+ulatCLY/u5/T1ZUcZvLM?=
 =?us-ascii?Q?r/OPEPoQsG7l3b1GI8U38vcv9FXZo2qVZr/glMhwHMuKGmJVSZhdlEWuTBlu?=
 =?us-ascii?Q?y7WMeaqalsqwanN4hqnwQT7qBmuq8Kkx07qZNeKJBX/lxNufx80oQ9bZenCC?=
 =?us-ascii?Q?okk/SQF+NfmXGhcMM+cIHypM55qVcbmcU1E0fGq9JmYvZwUXZTZdvjL3JG65?=
 =?us-ascii?Q?7cQYv6numpmqqoloakq/jP9Ypib1kCsSfZGkYbzJ+nrTx7I5BqzGKCAAcIKo?=
 =?us-ascii?Q?tU4R9IBG8RGsMScAj+3/wXTVWU0g+fIYagZmq/LGf+yhMPRR8amvbXHBcFOa?=
 =?us-ascii?Q?zNzeTK51ZzBPI8f9xv0aHCNkMM6hOdnJ594ZrSqIVKnoSJgzC8+z251Dy9wr?=
 =?us-ascii?Q?DDSfBU6cIS9t9OLPxepF0Zo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7002885DEAA95E4EA08B3B741D57178F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1e9f1f-04b0-47cc-418d-08d9aedaab51
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 23:40:44.8345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /m7QOhxhfgFCKi5TFwu0YO5fi40InEEdPt1Wqz1dPxd/PYJ4wrMx4jvb4WAxW9DRqeb+jrnmkoAOQh00wzGNEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2645
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=969
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230115
X-Proofpoint-ORIG-GUID: Rp05PSgod85BnRY0VvnLLSqeVbwrNJfe
X-Proofpoint-GUID: Rp05PSgod85BnRY0VvnLLSqeVbwrNJfe
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dennis-

> On Nov 23, 2021, at 5:19 PM, Dennis Dalessandro <dennis.dalessandro@corne=
lisnetworks.com> wrote:
>=20
> Seeing NFS RDMA failures after pulling 5.16 content. Does this thing any =
bells?

No bells here.... but I don't see anything RDMA-related below.

If you can reproduce the issue:

1. # trace-cmd record -e sunrpc -e rpcrdma -e rdma_core -e rdma_cma

2.  ... reproduce ...

3.  ^C trace-cmd

4. Compress and e-mail the trace.dat file to me.


> [30847.409411] INFO: task kworker/u129:4:797744 blocked for more than 122=
 seconds.
> [30847.417999]       Tainted: G S                5.16.0-rc1+ #1
> [30847.424735] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this
> message.
> [30847.433914] task:kworker/u129:4  state:D stack:    0 pid:797744 ppid: =
    2
> flags:0x00004000
> [30847.443870] Workqueue: rpciod rpc_async_schedule [sunrpc]
> [30847.450418] Call Trace:
> [30847.453625]  <TASK>
> [30847.456388]  __schedule+0x3e3/0x9a0
> [30847.460769]  ? _raw_spin_lock_irqsave+0x17/0x40
> [30847.466219]  schedule+0x44/0xc0
> [30847.470093]  xprt_request_dequeue_xprt+0xd1/0x140 [sunrpc]
> [30847.476719]  ? init_wait_var_entry+0x50/0x50
> [30847.481904]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
> [30847.488238]  xprt_release+0x26/0x140 [sunrpc]
> [30847.493575]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
> [30847.499920]  rpc_release_resources_task+0xe/0x50 [sunrpc]
> [30847.506352]  __rpc_execute+0x25d/0x460 [sunrpc]
> [30847.511825]  rpc_async_schedule+0x29/0x40 [sunrpc]
> [30847.517627]  process_one_work+0x1cb/0x3a0
> [30847.522472]  worker_thread+0x30/0x380
> [30847.526895]  ? process_one_work+0x3a0/0x3a0
> [30847.531896]  kthread+0x167/0x190
> [30847.535845]  ? set_kthread_struct+0x40/0x40
> [30847.540850]  ret_from_fork+0x22/0x30
> [30847.545164]  </TASK>
>=20
> -Denny

--
Chuck Lever



