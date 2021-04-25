Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC54B36A85B
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Apr 2021 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhDYQVw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Apr 2021 12:21:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42240 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhDYQVv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Apr 2021 12:21:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13PGL7qG147725;
        Sun, 25 Apr 2021 16:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=O1ShRh+zM+bVOQk+4SX1ngmO4V3C3LV2xar0oAig3RI=;
 b=XnAtCxsoaBja8ZE/5WAW2OqQdzPjicZ7+fo6UBvJIyoiFxhmnNYrhWPQkKEolGuZfcvc
 V9PUHaKIgLZznOStRawqkiLVy8hbznfv94LA5E5jNRTPx+qAvjT/iQoKqPDaEBbAcx69
 +4jZEyQceqs10PIs2m8hhDB2D3KVDPdGKUHuLah++4qDdDMKwMCnb+LKPn78EAl2eQ4a
 AKmWcTGfJZ/PlfHTxihjIP5c0gTedZMmM4k1Z/wq0ER20+gvnY6Ue+7hrxZuBk2i+5v1
 JF8+BmznKdNQlrfnLMmd2NC4I1PdWr8t3rCy3JdWvKYeutFFqrmjI/cuFBVB6sV60TuF 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 385afpr2j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Apr 2021 16:21:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13PGGUeo181619;
        Sun, 25 Apr 2021 16:21:06 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
        by userp3030.oracle.com with ESMTP id 3848eue39f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Apr 2021 16:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htnBVx/OFjvAC0gZwCmOJfI/v9w2qiMaBAXaSQzYOIMuhZqIAOORNERAugUVOj1xlJru/I7tQEQVI2fDsPhype7TDusPLDJNa7yjZAfIXio7fURgve0fufHmUEDUNHisHpuI0RIkc8XT6LXakUoSzJGQhOpMtPxs8axjiCEjBepcAqihSqQINux2dx3fu/+d9pxoNR1YFdjx9jaEpwxa2wGErDMNRUYoLysWb1fIxh13YSyAuZ68FOGpKduYZ8zMZ4VaFnh6rgxlvinVh5DbTsKgYSwwaAR2qSAzoYRtxAMcRhIU5jMJ/V68v3HLKbPVsa/6XwM6QpDedfJyg3S5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1ShRh+zM+bVOQk+4SX1ngmO4V3C3LV2xar0oAig3RI=;
 b=PwBqLbsml/SBB2jI80WL1negrauYBRSBWPa0kKBftGZqxDuMTo5KPrSCRPTBGpbsZzgpw+rH3zYz+9diqBKLcdTl+D0nGqm7dwhw3UjHSC8Fvm8zAObm8NkLOgFqqIOQvmR3mqLENrMPbe09+3am/ov4pS+Ougsp8qYyk7adY20bhNOyxrYPHuD2jpJfsxTob2a5Ae3FCgVXSk8J4i4Z6kTw2VgWhm1qgt756RNmlptiiutaytEjW46Dha5762fMojDuQGmFpT7uFliZHZ0KvHBwFJXAwPMOBRvxRMuV9hMlJSu2ZfVmwtCehEUi1iR00+I4m48RtbRG6Qyrj6Lg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1ShRh+zM+bVOQk+4SX1ngmO4V3C3LV2xar0oAig3RI=;
 b=QnezY+KrQtmU4pjZJ1TePGhtD0zPg/IyBFjtRzlK1CToKcsuK+ADPQMmt7el1rk1QeG8B28I1fPzH1Ea7AAopndZYAlHeP/oe+Yg0DsS2S3oDfz72JUMGJnij86KF6klJZ6megMF8th78Sh1YdgANWFR89SVa2wGP0xPZwnkkRI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3463.namprd10.prod.outlook.com (2603:10b6:a03:118::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sun, 25 Apr
 2021 16:21:03 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4065.026; Sun, 25 Apr 2021
 16:21:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Aloni <dan@kernelim.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 15/26] xprtrdma: Do not recycle MR after
 FastReg/LocalInv flushes
Thread-Topic: [PATCH v3 15/26] xprtrdma: Do not recycle MR after
 FastReg/LocalInv flushes
Thread-Index: AQHXNUZHEhmEE4Cgt0qSzZHRZJLJNarFUWMAgAAiCAA=
Date:   Sun, 25 Apr 2021 16:21:03 +0000
Message-ID: <53AD14DC-65A2-4E93-A467-1DE43894DC03@oracle.com>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
 <161885539285.38598.13978652738422395833.stgit@manet.1015granger.net>
 <20210425141914.6govk2lm2hfosdie@gmail.com>
In-Reply-To: <20210425141914.6govk2lm2hfosdie@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d06e4b62-c5e8-4090-ba80-08d908061f21
x-ms-traffictypediagnostic: BYAPR10MB3463:
x-microsoft-antispam-prvs: <BYAPR10MB346344E577F00CC946EB099993439@BYAPR10MB3463.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THomjh3L+iqKOsxZXVVgZxKKR3oUZ8rVniTFs2660u9ChppSmVQhjc6cgh4bACIx+eqq62mPxtFnh2MxsQVO88SWwd255rGNRsmg/j1Q8QxE6dnZ/i22GzKTeEDntDNwYzidDGEAF0/LxzHD+Ef+yNlvoNADjQnqPX6qez8G5Pa8Qh3IkKG0kTgo9LrdieGGhUiWkZCViZOOLc7rbORn46ktxnT9hP0CAPLrHJvPka6O8HVLfNeb8o3Jt9iSzip5mqv0o0j35Z/jkX0ccJtrMcsrhLVEbPbVxSrPvrm41Zkvf4u9eNbLxOglf29lViWs3QS9MFhA+O+7xoCuGmUAop7WEbjGX8ozshnmPkFGyRCktN4nMUkCWugSdt/+XP/eRCbD82qQXU0ZL+Iczmxuoj4a2NfPD4Tar2UsEP17WVpDUY4NOvIpFcGpL6C/+YJQOvmLhfivJ+RMMNgyAXLPAdW7Khq02SApbZcZRDlXbilKE3Tp5NM5tRxjO6/7NMfjHLjjKifJDb6F8sahRz2iEunK5/qbzU7JgBy6JwJHGwxUn4kjyqgHRpAjEgegPcI3zcqHorK+jBAoh+RV/JSDnIIl4wyIcSlXp7igvrhgRjstoEUh9Bp0fPjnWhdfh7sJx+tMUmZiL8QP/qmXhe2bZzZDC78X1NB5dXSwzcTsv9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(376002)(366004)(136003)(53546011)(122000001)(6506007)(2906002)(4326008)(38100700002)(6512007)(6486002)(478600001)(36756003)(8936002)(54906003)(71200400001)(186003)(26005)(86362001)(66446008)(5660300002)(66476007)(66556008)(66946007)(91956017)(8676002)(64756008)(76116006)(316002)(83380400001)(6916009)(2616005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XR+iwz2NLwE35HMUnyDMq+dwqnuOdF7+mrwMnciZgH6BfIytSLBVrZ1b2CiG?=
 =?us-ascii?Q?24xvWEnwcSaO863cWsVPwc/dFvvSFPRSuQaiXlHMHD9HhNzO4mhOPtIY1hkn?=
 =?us-ascii?Q?ZIZZczK6X3US3/8vd+/RKYwidPzYSsLAtV1vqncACpe0CB5rgLpWice5VJNR?=
 =?us-ascii?Q?Dah+H2a0BQ3RcbbHlZhHXkNajU68L4FaiOqONcjojm/HtMWfxLvPrYconX+N?=
 =?us-ascii?Q?f4f6apUbNm7qwS3rAyaVtcYY13IlydtjLS0bbqcZQm3pSxFAyAcHs+8KZ1T3?=
 =?us-ascii?Q?ZqvaXJtA/RWacPB8XHDXlRhMEmwGR9kcRdnSV7lXsh015cqLlPEwsejAd0Nd?=
 =?us-ascii?Q?GZk1NYQUIX+41NTcuSP9dbzH65WXxS6DJZuJ9ViI9Y+rroj2QYRukZCoBHCC?=
 =?us-ascii?Q?accd5UOfVGLw4abO5ZT27boiammx39XjtMu9Aw47lSt8ffp3UO/wQFqZcvPl?=
 =?us-ascii?Q?xm7CM/wIz+CZMOo3F7xxYxRFnOBosQKjHQyztqOytYHXiNq675iS06JbeYuZ?=
 =?us-ascii?Q?jAob/c2d7paaoCNbjThhSecZixC+lhgVbMXXVV8SopKjpeVtEPIkPp81F9w6?=
 =?us-ascii?Q?v0nj2tGu5zMRNRgAswJn6vwWPGuQQ1q59vJ5sjutPrwfa8m1YbPhjxxC8wq8?=
 =?us-ascii?Q?FwASJZdUCMv+JQ1O3LlOYUO/h/5/vxmKQWTXvQ3k9/iVSrPEg4fkAXIBc2wN?=
 =?us-ascii?Q?7A9Dc60OLq9cut9WePzxDOXScSz9vOXJ+dI0RkjX2ssY/9lY/Bluy1FdXoMJ?=
 =?us-ascii?Q?SCzH84bnUTSdD93sfE/5CfqxSFgZAZYseJ5tYJr2GrOv2+bIEZzM4MNHbNNO?=
 =?us-ascii?Q?5qcHbUygbI1yCvYtS8GFD2+aa3Wi5LKh30Z/x7wnaWRSD2JdoPdBNYIXXuY1?=
 =?us-ascii?Q?UEVDDZbgdOmqm6QiUs/Z1Z9IRyvgypLxiBY7Q4W7TLlFFjhBC5bf8GloR1r+?=
 =?us-ascii?Q?I0a+886zjJYwLRUQLtQck6HV1WSJTWp//RW5l69UQbxsZ7qOsDwnezaldbg1?=
 =?us-ascii?Q?CoBcHK81wet6TbfcM3omstjxLHuWg06B6h6Sq+pQ2sHfZYf0VmzKIZfBFtBx?=
 =?us-ascii?Q?Qip/SZgoY8WCmWrII7UfgGhza0RYo65DEuGDVm2/CUtfbqUcfzTEvujax0K+?=
 =?us-ascii?Q?9qzdRhkCTzwNSuRHwHCtRO1+Xnn9gX33+2SD9y4DuQ1FE/pbcb5r5QUxBWz+?=
 =?us-ascii?Q?ZGi9tAfdjm24hdcVFUr1dRFzw4fJLEyA5CQI1fIOGgELao46NCkg9GjL7cHH?=
 =?us-ascii?Q?sBvflAsvKiN8TF7bAVilM49O2RAPsQNGpX4gHQn751GRAA3+d+iaOGJHPR2S?=
 =?us-ascii?Q?hjW9z0x5zTQXOt9tQH+PrFSa?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B657390B1B32B64F9B37DFC3B022D164@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06e4b62-c5e8-4090-ba80-08d908061f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 16:21:03.4387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXhcnHXAiInFh1FR8AufLQKg5H+SVF2ebsAZBbhB5+K6tk4sz02HteqlQo1TelRfPKuKFQdnPVQlOCEHSNgIfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3463
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9965 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104250121
X-Proofpoint-ORIG-GUID: mHDttCCktirgkH19W9cc0s-SCaJ6Frcq
X-Proofpoint-GUID: mHDttCCktirgkH19W9cc0s-SCaJ6Frcq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9965 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104250121
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 25, 2021, at 10:19 AM, Dan Aloni <dan@kernelim.com> wrote:
>=20
> On Mon, Apr 19, 2021 at 02:03:12PM -0400, Chuck Lever wrote:
>> Better not to touch MRs involved in a flush or post error until the
>> Send and Receive Queues are drained and the transport is fully
>> quiescent. Simply don't insert such MRs back onto the free list.
>> They remain on mr_all and will be released when the connection is
>> torn down.
>>=20
>> I had thought that recycling would prevent hardware resources from
>> being tied up for a long time. However, since v5.7, a transport
>> disconnect destroys the QP and other hardware-owned resources. The
>> MRs get cleaned up nicely at that point.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> Is this a fix for the crash below?

Yes, it is plausible. That is a familiar backtrace.

However, it's usually because the provider called the LocalInv
completion handler twice for the same CQE. Which provider is this?


> I just wonder if it appeared for
> others in the wild, and the fix is not just theoretical.
>=20
>    WARNING: CPU: 5 PID: 20312 at lib/list_debug.c:53 __list_del_entry+0x6=
3/0xd0
>    list_del corruption, ffff9df150b06768->next is LIST_POISON1 (dead00000=
0000100)
>=20
>    Call Trace:
>     [<ffffffff99764147>] dump_stack+0x19/0x1b
>     [<ffffffff99098848>] __warn+0xd8/0x100
>     [<ffffffff990988cf>] warn_slowpath_fmt+0x5f/0x80
>     [<ffffffff9921d5f6>] ? kfree+0x106/0x140
>     [<ffffffff99396953>] __list_del_entry+0x63/0xd0
>     [<ffffffff993969cd>] list_del+0xd/0x30
>     [<ffffffffc0bb307f>] frwr_mr_recycle+0xaf/0x150 [rpcrdma]
>     [<ffffffffc0bb3264>] frwr_wc_localinv+0x94/0xa0 [rpcrdma]
>     [<ffffffffc067d20e>] __ib_process_cq+0x8e/0x100 [ib_core]
>     [<ffffffffc067d2f9>] ib_cq_poll_work+0x29/0x70 [ib_core]
>     [<ffffffff990baf9f>] process_one_work+0x17f/0x440
>     [<ffffffff990bc036>] worker_thread+0x126/0x3c0
>     [<ffffffff990bbf10>] ? manage_workers.isra.25+0x2a0/0x2a0
>     [<ffffffff990c2e81>] kthread+0xd1/0xe0
>     [<ffffffff990c2db0>] ? insert_kthread_work+0x40/0x40
>     [<ffffffff99776c37>] ret_from_fork_nospec_begin+0x21/0x21
>     [<ffffffff990c2db0>] ? insert_kthread_work+0x40/0x40
>=20
> --=20
> Dan Aloni

--
Chuck Lever



