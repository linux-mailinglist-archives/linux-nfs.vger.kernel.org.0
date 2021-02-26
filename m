Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6696D326492
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 16:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBZPQr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 10:16:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33266 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBZPQq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Feb 2021 10:16:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QFFlni109739;
        Fri, 26 Feb 2021 15:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BmoYIt5zUUBZMXPJrI8sBlxp+StmxWV1mytC0+hiiwI=;
 b=ryN44qNPdRuCUSgeZqZg7y8G8qvsLSIaXwWdU3JV//l9I00+pdH6upmbPsnz6jOOvLEF
 R0d1ZG97mEq+cYJndeK6VxrpCA6q1ZSAcIGL78UJhFKK3ebrolqLeBKDaOyGaoweI6xt
 jxod7BFA+ZDO3BTdCpU6Iud5EPt86rhy15bl/OOJeYgfFQ/tyfqMugcE9C9isX9sjDlG
 VbLOergJMgF6jHNFjJrV4pWpr8bmksZsIK/UjephTQrXG2U0+ZepsoU4DxwcBNqaOjmf
 hNeMNK3KEFPAUFntjwS+M8CoV2lqLNVIhEtdWzHm7r7D79+oVUzpL7O9+jPX2wSmMP1n yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36tsura9pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 15:15:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QFAjM9025583;
        Fri, 26 Feb 2021 15:15:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 36ucb3h7h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 15:15:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csVAQVDf1LMODtnUTTw4WFJUPadces9dTuG8QDfFkHkZxXz2bfKYl7Xgt9RO7YSA2Agzq4KjP4iDGCJ3/inuwPNYv1mQLr+ZZiiWeKUcJdtu8v/un7dj9+X1l+BiGYOMy3XnqJVYOQgBCt6fR7zqWbLUMJHNd9dWzTkJHpkfzuBi/shO3C8/tp4xZqNEgbBtIgtsyfziqMBzj2V9BJUOt0EbZr/8DPbQ7lxjizlcpTRoWCWlMPhtyv+vdYjDSB+9BAaW5gPjwX2rk6RPCltIaKecgUWgrtUl0Pn8o4vntZSxpJB8g5XjorEYEZNMhIIWVQz80uXnFm/WLS7R+upevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmoYIt5zUUBZMXPJrI8sBlxp+StmxWV1mytC0+hiiwI=;
 b=KQzX8kM7pyKSANFBRm4XTP2Kv5jDwldULk8ZwpSB1Lb8w1QhFVH9t4j09Tw1A28Kta61BnilVLW4hv799vTZxUsjbMxyQQuhGxqv0G7bpZaq/qjfTfQwhZ3zeLqqh72MeeITraC6jBeLND/XwOyzNNCKsi9FJLQe2xEapuVu6smZjufpaz4eR8tZup81xfTb/rHbvdbkIrixTTVvpA2ZZx/sFy6kkzkfghNs/6LEYJLwSE/i6qzkyVS2/6lNCNtB60MeyozcwuEtV6nUukR65i2WQ34e2x1RppfRaNvfqFzduLmzBKh/BichCs+mHhCcBcUb9VSBsDTWWr8iV/Nwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmoYIt5zUUBZMXPJrI8sBlxp+StmxWV1mytC0+hiiwI=;
 b=t+DiIhpLEJbdKGLc1+pvumlawSYpD3INa4/sYbzj5/JwcHJqjLTIOtAvDOgfTjJoLsEG+K/eSG4FV2BtcCZUa7cnxBT5Qh1R6FoJ9GONWDMBfpvEIZuYCbJjcSF+veftHjt/BZvSL/1MUWamyNtvUUiBj1uPm5cuIUWJtTVuenY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2439.namprd10.prod.outlook.com (2603:10b6:a02:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Fri, 26 Feb
 2021 15:15:46 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 15:15:46 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Joe Korty <joe.korty@concurrent-rt.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Bruce Fields <bfields@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Repair misuse of sv_lock in 5.10.16-rt30.
Thread-Topic: [PATCH] Repair misuse of sv_lock in 5.10.16-rt30.
Thread-Index: AQHXDFArNpUDpBnnO0SmlDmeu86JQ6pqi+GA
Date:   Fri, 26 Feb 2021 15:15:46 +0000
Message-ID: <AA751435-2DB2-467F-B0EC-133BE62A8581@oracle.com>
References: <20210226143820.GA49043@zipoli.concurrent-rt.com>
 <YDkNFKmzb7rbumYf@pick.fieldses.org>
In-Reply-To: <YDkNFKmzb7rbumYf@pick.fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: concurrent-rt.com; dkim=none (message not signed)
 header.d=none;concurrent-rt.com; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dce97c76-539f-4470-0174-08d8da6964a0
x-ms-traffictypediagnostic: BYAPR10MB2439:
x-microsoft-antispam-prvs: <BYAPR10MB2439066B28B2DD493CE11FFE939D9@BYAPR10MB2439.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFVkuOytvUXjUHxOAq/jqCIE1wQE5istH+TSa60L68PVSIv5NJIA/JqIRaJAVSd8K6xpk+ph+m13RdJtBdWek27oTUpd/FyXGljIogTIy9YRKCudwBvoHrP/hfDv3NxehubwTQI+tLJ5FZppA8BgzWUAZNP6zQ6hUhrorvak2mrx0McSe8ylhmgTlmlB8OUMvgMaXLz19m4YcqWqcJsfunSpkdmaoKjSVAi4OSVlSz6hW3l8voBRy3BOCCAmenG0/kzAWiX2NgOLTzqsBhN9NPwYLSl2Vv9/jSTchF41Ex5IZeNMrBN4pU1p91wMGWkOPEBqQLuFn0vNG8pVjnY3Ws3sOpM516ZdrMW9/l5eO3hh/+MBXg1/oTirGzSlnnozoAmpA3JP4lrXxgvqubVKuVeEb+8fTkm3xzF5bc5PHpuQnd/joH0W2rgIjmb3v7rCloz9SbnXx9bl+0gz29ekphtssp2h1eZSzbMMYIbYAR8+N9G+6XA8wcC2PmVJeKYTQUPyUHG1fmlOZC4RpNHUuYjNbfMZ4yzKeII48ZNkq3BZs95uKNs81giWWKIQNwnqWYfsnsanC3r8Yz9UBbKnMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39860400002)(396003)(54906003)(316002)(6916009)(8676002)(53546011)(66446008)(83380400001)(478600001)(44832011)(6506007)(6512007)(2616005)(2906002)(6486002)(33656002)(186003)(5660300002)(8936002)(26005)(71200400001)(66556008)(76116006)(66946007)(86362001)(91956017)(64756008)(66476007)(4326008)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3OGCiYA19RUCnYFG2ZitVx9IQTl2eAefvnV9jZxvQ4fjQc3hjtVJJ799KQiS?=
 =?us-ascii?Q?AWXfEZZyLKf8s4kAQ17F1FUL2pzrnlV9RRVAMmvVie3+G9jMyITZNo4VxvRd?=
 =?us-ascii?Q?tMzb08RGPWoPzBbBNPJ2jdaYJADaHIjx1/dlKg3NQ3jBB5wxWeItbKR3ZZmy?=
 =?us-ascii?Q?bX2DAAFGL37gI/9jRqIFcZGRpMOxfMCBmKVynfcFqzaILOSLsYyDqFfhmCIc?=
 =?us-ascii?Q?R2MVtMSkLKttEQHxmDejP9Va8DiIvBNduCmqheiTf3KwUW6hKaO6kNrE0oFs?=
 =?us-ascii?Q?CF0FwZkNCZs7UsSuPet0RVyO7hAo7U9n3XPVpVPvadeOUaHAihNbZUG+XhJv?=
 =?us-ascii?Q?Guy8gRvvbDR/7y01jQyTPDqZUzUEkQ4nSHNFjccmQn+KlKPfavfvG71Wyedi?=
 =?us-ascii?Q?KPLlavvWo9LvGK1MsLytj1XHNBi4q6AL4CCeaSpbUnJp/mmqDOx7kC1+z8BE?=
 =?us-ascii?Q?ZIvB5AYZ388Od0o4Yxy6a+tKK3oWS6xzbkdvTT2SxZ9WJihMLLT5KpmaC9J9?=
 =?us-ascii?Q?7Xhk2adEBb6irfC036qaQjE4tx+6bR85JERp8eXvBXg+QG/IkGvvtmY3aTr5?=
 =?us-ascii?Q?QLTeX4E+VYJQv/7T3J56yft32M0yJqh2WuP4cHVFo0f98OvrlW83O7+an2Fu?=
 =?us-ascii?Q?QvL8pKNirGHB76jJ0syoraUhiboZDt8XtY/M4tfFeZZIKj9+rHFIkolVnQSZ?=
 =?us-ascii?Q?HjaYUWEgzp70ib12tpnPGke2w47VITFyRpj66qiHyfvh1Kkodu664hJe8SdS?=
 =?us-ascii?Q?PHrF4I0s4isnfJEEMsQJ3CA2iDxYXSDx6dwYkwOy1H84shYZrt/hnfRoud+6?=
 =?us-ascii?Q?o0HNhmjBIfEIsQBIj7T6C1G4yM/P5DqHwGhFMXayCEMRNpyemNLvqDWHr7F3?=
 =?us-ascii?Q?c/7H9ygEF5Ta73m560nli00CTd9XxT6N2SSsRXDspZipPRSOhVsVBWyTLqK7?=
 =?us-ascii?Q?L3bTRAyLcvogOKJXGqqj6Cxi5/10P3YogwBiUiGMFiuiQ3C1QT6dVuQCaHwo?=
 =?us-ascii?Q?VyBbshsraYdFSsb2LkDXOPmiqhhdihJDmAjRtASx0dbCWDp6yREyEQTkzQ53?=
 =?us-ascii?Q?ZjHv6++qJ9yD8wOjKuy1/sVStQRw2Iin6VVek7jzWfWbxZfNTYRibzJPUAMD?=
 =?us-ascii?Q?qR4WguE/NkLxDg/Agr8pn/cJEHZzFxWK3IwzbqwQJl31PShNRfKAx7hv3As1?=
 =?us-ascii?Q?zrotZ7nBH8hON5PKfpp86+mLpcX/3lxU69hMApcIUIIG9g5A/ktqpAKGLjVI?=
 =?us-ascii?Q?HP/SqzBbKm0ygs8K0Zg71E84xlwcVBUFjRlsgNC/SJodudfQMVn3c6rgi2zb?=
 =?us-ascii?Q?BQ2XTGUmuZiBrOMGFYuuXSir?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <581026D233933544930285DB8594FD7D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce97c76-539f-4470-0174-08d8da6964a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 15:15:46.5901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BpFfoFg6Wcm2bRDbHk5rYPaYiKT7hPQsy7aMLBcBvDja15QGhfkBQ5Q2hubLBOG2ngKppQH2vnc0t8DuONAoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2439
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 26, 2021, at 10:00 AM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> Adding Chuck, linux-nfs.
>=20
> Makes sense to me.--b.

Joe, I can add this to nfsd-5.12-rc. Would it be appropriate to add:

Fixes: 719f8bcc883e ("svcrpc: fix xpt_list traversal locking on shutdown")


> On Fri, Feb 26, 2021 at 09:38:20AM -0500, Joe Korty wrote:
>> Repair misuse of sv_lock in 5.10.16-rt30.
>>=20
>> [ This problem is in mainline, but only rt has the chops to be
>> able to detect it. ]
>>=20
>> Lockdep reports a circular lock dependency between serv->sv_lock and
>> softirq_ctl.lock on system shutdown, when using a kernel built with
>> CONFIG_PREEMPT_RT=3Dy, and a nfs mount exists.
>>=20
>> This is due to the definition of spin_lock_bh on rt:
>>=20
>> 	local_bh_disable();
>> 	rt_spin_lock(lock);
>>=20
>> which forces a softirq_ctl.lock -> serv->sv_lock dependency.  This is
>> not a problem as long as _every_ lock of serv->sv_lock is a:
>>=20
>> 	spin_lock_bh(&serv->sv_lock);
>>=20
>> but there is one of the form:
>>=20
>> 	spin_lock(&serv->sv_lock);
>>=20
>> This is what is causing the circular dependency splat.  The spin_lock()
>> grabs the lock without first grabbing softirq_ctl.lock via local_bh_disa=
ble.
>> If later on in the critical region,  someone does a local_bh_disable, we
>> get a serv->sv_lock -> softirq_ctrl.lock dependency established.  Deadlo=
ck.
>>=20
>> Fix is to make serv->sv_lock be locked with spin_lock_bh everywhere, no
>> exceptions.
>>=20
>> Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>
>>=20
>>=20
>>=20
>>=20
>> [  OK  ] Stopped target NFS client services.
>>         Stopping Logout off all iSCSI sessions on shutdown...
>>         Stopping NFS server and services...
>> [  109.442380]=20
>> [  109.442385] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [  109.442386] WARNING: possible circular locking dependency detected
>> [  109.442387] 5.10.16-rt30 #1 Not tainted
>> [  109.442389] ------------------------------------------------------
>> [  109.442390] nfsd/1032 is trying to acquire lock:
>> [  109.442392] ffff994237617f60 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, =
at: __local_bh_disable_ip+0xd9/0x270
>> [  109.442405]=20
>> [  109.442405] but task is already holding lock:
>> [  109.442406] ffff994245cb00b0 (&serv->sv_lock){+.+.}-{0:0}, at: svc_cl=
ose_list+0x1f/0x90
>> [  109.442415]=20
>> [  109.442415] which lock already depends on the new lock.
>> [  109.442415]=20
>> [  109.442416]=20
>> [  109.442416] the existing dependency chain (in reverse order) is:
>> [  109.442417]=20
>> [  109.442417] -> #1 (&serv->sv_lock){+.+.}-{0:0}:
>> [  109.442421]        rt_spin_lock+0x2b/0xc0
>> [  109.442428]        svc_add_new_perm_xprt+0x42/0xa0
>> [  109.442430]        svc_addsock+0x135/0x220
>> [  109.442434]        write_ports+0x4b3/0x620
>> [  109.442438]        nfsctl_transaction_write+0x45/0x80
>> [  109.442440]        vfs_write+0xff/0x420
>> [  109.442444]        ksys_write+0x4f/0xc0
>> [  109.442446]        do_syscall_64+0x33/0x40
>> [  109.442450]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  109.442454]=20
>> [  109.442454] -> #0 ((softirq_ctrl.lock).lock){+.+.}-{2:2}:
>> [  109.442457]        __lock_acquire+0x1264/0x20b0
>> [  109.442463]        lock_acquire+0xc2/0x400
>> [  109.442466]        rt_spin_lock+0x2b/0xc0
>> [  109.442469]        __local_bh_disable_ip+0xd9/0x270
>> [  109.442471]        svc_xprt_do_enqueue+0xc0/0x4d0
>> [  109.442474]        svc_close_list+0x60/0x90
>> [  109.442476]        svc_close_net+0x49/0x1a0
>> [  109.442478]        svc_shutdown_net+0x12/0x40
>> [  109.442480]        nfsd_destroy+0xc5/0x180
>> [  109.442482]        nfsd+0x1bc/0x270
>> [  109.442483]        kthread+0x194/0x1b0
>> [  109.442487]        ret_from_fork+0x22/0x30
>> [  109.442492]=20
>> [  109.442492] other info that might help us debug this:
>> [  109.442492]=20
>> [  109.442493]  Possible unsafe locking scenario:
>> [  109.442493]=20
>> [  109.442493]        CPU0                    CPU1
>> [  109.442494]        ----                    ----
>> [  109.442495]   lock(&serv->sv_lock);
>> [  109.442496]                                lock((softirq_ctrl.lock).l=
ock);
>> [  109.442498]                                lock(&serv->sv_lock);
>> [  109.442499]   lock((softirq_ctrl.lock).lock);
>> [  109.442501]=20
>> [  109.442501]  *** DEADLOCK ***
>> [  109.442501]=20
>> [  109.442501] 3 locks held by nfsd/1032:
>> [  109.442503]  #0: ffffffff93b49258 (nfsd_mutex){+.+.}-{3:3}, at: nfsd+=
0x19a/0x270
>> [  109.442508]  #1: ffff994245cb00b0 (&serv->sv_lock){+.+.}-{0:0}, at: s=
vc_close_list+0x1f/0x90
>> [  109.442512]  #2: ffffffff93a81b20 (rcu_read_lock){....}-{1:2}, at: rt=
_spin_lock+0x5/0xc0
>> [  109.442518]=20
>> [  109.442518] stack backtrace:
>> [  109.442519] CPU: 0 PID: 1032 Comm: nfsd Not tainted 5.10.16-rt30 #1
>> [  109.442522] Hardware name: Supermicro X9DRL-3F/iF/X9DRL-3F/iF, BIOS 3=
.2 09/22/2015
>> [  109.442524] Call Trace:
>> [  109.442527]  dump_stack+0x77/0x97
>> [  109.442533]  check_noncircular+0xdc/0xf0
>> [  109.442546]  __lock_acquire+0x1264/0x20b0
>> [  109.442553]  lock_acquire+0xc2/0x400
>> [  109.442564]  rt_spin_lock+0x2b/0xc0
>> [  109.442570]  __local_bh_disable_ip+0xd9/0x270
>> [  109.442573]  svc_xprt_do_enqueue+0xc0/0x4d0
>> [  109.442577]  svc_close_list+0x60/0x90
>> [  109.442581]  svc_close_net+0x49/0x1a0
>> [  109.442585]  svc_shutdown_net+0x12/0x40
>> [  109.442588]  nfsd_destroy+0xc5/0x180
>> [  109.442590]  nfsd+0x1bc/0x270
>> [  109.442595]  kthread+0x194/0x1b0
>> [  109.442600]  ret_from_fork+0x22/0x30
>> [  109.518225] nfsd: last server has exited, flushing export cache
>> [  OK  ] Stopped NFSv4 ID-name mapping service.
>> [  OK  ] Stopped GSSAPI Proxy Daemon.
>> [  OK  ] Stopped NFS Mount Daemon.
>> [  OK  ] Stopped NFS status monitor for NFSv2/3 locking..
>> Index: b/net/sunrpc/svc_xprt.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -1062,7 +1062,7 @@ static int svc_close_list(struct svc_ser
>> 	struct svc_xprt *xprt;
>> 	int ret =3D 0;
>>=20
>> -	spin_lock(&serv->sv_lock);
>> +	spin_lock_bh(&serv->sv_lock);
>> 	list_for_each_entry(xprt, xprt_list, xpt_list) {
>> 		if (xprt->xpt_net !=3D net)
>> 			continue;
>> @@ -1070,7 +1070,7 @@ static int svc_close_list(struct svc_ser
>> 		set_bit(XPT_CLOSE, &xprt->xpt_flags);
>> 		svc_xprt_enqueue(xprt);
>> 	}
>> -	spin_unlock(&serv->sv_lock);
>> +	spin_unlock_bh(&serv->sv_lock);
>> 	return ret;
>> }
>>=20
>>=20
>=20

--
Chuck Lever



