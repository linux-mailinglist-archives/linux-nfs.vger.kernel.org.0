Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6513B77F4
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhF2Sk7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 14:40:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55512 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234971AbhF2Sk6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 14:40:58 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TIaCWm028883;
        Tue, 29 Jun 2021 18:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/ktRgLvl9Jca1oNicQKTQrIFJhIga+Dof4yulW1IgTE=;
 b=kFRJVIPW6BREb0W3ZAy4pAvxgqgwphg03ucjbvy8feCrD3mFola5tw22gNalSdNzCT+k
 ECElwr+2lkSkxtIJThCBDlMth2iG3K8kQqfkNG162557s+zAe7IdQM64z5UwAcz6gkBD
 DFvx4J+RnwyYnJYNIiCmAau8+zn5JPLWscxh+4mif+eNSxjR/mWerqmfV6QGmr2zUynM
 0VbJR1QHFMXEgcpmGLcAwT3dUHTrC3q4Y/Y5LCB647hkRWmemCIgfbmSZ/QRbuNdNrEu
 cDRcC5nmQCTtTf/zoOcgc4Y0iK7/pbXbOYCqsWtUim0iTfbOkwv+bjWZ92SaZ3MqDGTw 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6pqca6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 18:38:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15TIZu0G008345;
        Tue, 29 Jun 2021 18:38:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 39ee0vfbs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 18:38:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEq+bSTrQSbB5d7WzG3E2Ipwra6iHQrm02Ww/c5nrVtuOePrHcqW1BWAg+M9lzj59/DRyFk5Rr1nMpfFqMblKUjpdwtm756iRDXHSzUrSECaMEvUNX6VLlhKfeKoGDydGdqEv3B3KfFkDYc6fxX+HBAGK6BVw8rLL6gBbv/X5JcgEpCcEl5+ZPTUmDc2fVunoCiZbHQKkH3opr8A309D+cbsbJL2RwZvbSJqQzgm7siT84HSH1LX8dprfwDOdpB8np8Sqa551vVjnRxuzxwdStg6MPLaOYc1NCjR24/tizPYJyUXQT1HsBV4dryp3majLivuUv8KgqWN7PkW7BvxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ktRgLvl9Jca1oNicQKTQrIFJhIga+Dof4yulW1IgTE=;
 b=H8QNhz1mIplNHjMXLmnnCRqOGAqmtXKI3Io7/FGkmiVep3YBObM4GJ8+AIWCLu+SHpbberGHe+/dp0r4QLgMdmpO82OuWLmzQRHBLVwqFGCbraebh4+OD2nHdo0w/c7Y2hDRLoxlXyfzr1LwE2zoSrYeyqPLptizN69OLTpoiPl8uwZsdyqqCwJEqeTviBydwUYnDtzbt7QaQagDfpJupvpUrcx50CuWEIwAxuAmhh8l0UJN+Jsy4VoCIgwF9Ajv/dDqZOxFO+MIE0uQDXoagQxURcZ0iJVaTfglawycfMpRDMD9cv48IU8MZ+C9sQ7XTGrOMNZI1hBJLpyRBGY3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ktRgLvl9Jca1oNicQKTQrIFJhIga+Dof4yulW1IgTE=;
 b=CG07Yaz8ipFX6mSq3hNN2pkqMHSXT0COnXiYX52mA3JD5127IKg5683JwSwEm9kB4s9TY9Nc1WFMAVwQQmRIsFk/LuaNVPItEFvlSMNT907XH6pCJfWmex4F8z4lZDh8q4HanwP0T+rePwosy3PssbNxh81BapVWVhleDqKl0Y0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4575.namprd10.prod.outlook.com (2603:10b6:a03:2da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Tue, 29 Jun
 2021 18:38:22 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:38:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Hillman, Richie" <Richie.Hillman@cornelisnetworks.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS trace new to 5.13.0 (GA)
Thread-Topic: NFS trace new to 5.13.0 (GA)
Thread-Index: AddtE3KnceyIXtJFQ4q1p77amM2J2QAAn1oA
Date:   Tue, 29 Jun 2021 18:38:22 +0000
Message-ID: <A9DA4F5A-9BA8-4395-82CF-24C071AF1F8C@oracle.com>
References: <CH0PR01MB71539295AEF1947518073D0FF2029@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB71539295AEF1947518073D0FF2029@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6833939-af61-46cc-3104-08d93b2d12d5
x-ms-traffictypediagnostic: SJ0PR10MB4575:
x-microsoft-antispam-prvs: <SJ0PR10MB4575C10E43D2BDF70937907093029@SJ0PR10MB4575.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xj8m1YCgcNZyi+ZFV3QVMrihgfiUwO9KH6KbWLx0XHf4ZsLAjPch9+lE/TaSSzvujziCBPkYE1kRSRmiZxrWejFem2hsWweNlP9Saa7r0bPdWmNhUMeMQZujiS1bytgroLPalzdowN+qHvTjtNqcbKV5MggYHgJDas6YMGMj0sla6/voZ2qYDtBFBcJmoFpUWWPa2HF2dWy6xhzVmWRb34X6aW8jY6gAc69BjcSF1rNP9lIgrhUXKPJkdP4JmgfQ0mtppehVF5SqanHETzsd1AF+TRcul4Px3WSTxemQeLfqwaMgvkQNaCbYsU+iQGygJqJkNhHG1whLhI+xjdMk41hRMTuDMKNG60ZG1FMHc+e1eTg6m8/tA8PBirmQHOL2Mbw4UacHrI6hYdJSB9KSL2oqCuZ9lwS898EZxk9pnGKFWpi3PqU1k7Xo6OXRqkaJzk0xnnxyto7mteBFdiTVMg2/cKZQBT8QQHDZD3XQ+3Qb41IGMQp4jVrIC2C6H+h9G/rx9Y0s8ao2NB89dDYQC5ekmJ8Xr2VPNH6t2uL6VoE6heCH5ViXATr0Jr1san9cGJ2wI0wySgoNkdUI7tKExJqUzIJlha1AyQR5EIEXZcDgh4kXikBVjA9z4wc2gd+iGv/YBbdytwDzqFJdlio/PNoMcznS2X2xb73k7/g09GY+PjsKLGkiloNyaSUoeejOr3B+TCvDkDA0NpcUJ06kNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(5660300002)(6512007)(36756003)(8676002)(71200400001)(53546011)(26005)(66476007)(316002)(54906003)(66556008)(76116006)(4326008)(186003)(64756008)(91956017)(122000001)(66946007)(66446008)(38100700002)(83380400001)(6916009)(6486002)(478600001)(6506007)(33656002)(2616005)(2906002)(8936002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q57k0NeVDEznRjIi5TGBEqCG5/I0s81za9oL3TxKTrvvHZd8ulfcpZPTyWLh?=
 =?us-ascii?Q?9WnmXqu8sPJKeI/s1OGUcDOFBh9j8r700QT9n3366KhCIGAtTrRtySvEzgOB?=
 =?us-ascii?Q?u08p9pR6af+enCNq260vb+lUvDs/nV66XXNzdsis56X8TE6nxX5TzMMsuxy3?=
 =?us-ascii?Q?LS7uBaxB8V4ZHnk3j9mxmhMWcz2eJuEkQaAyahQu9pq6QUDa9XdehjQKMY1u?=
 =?us-ascii?Q?OO3/EqKX1miQyFu89w+K//mQUzRdahrB2gwBwg/1x0j/VwV23UgmKgMtPY5C?=
 =?us-ascii?Q?dn3EgsEirH9qTYnF91vFd8PqKB6ItdmNPw1+GgEyf+yPOVp9OilbnWmnAsvU?=
 =?us-ascii?Q?NWganx1pgxKqCRMSjh5rWkZy1Hll/0iTM9Jl8R82c0yNQjkR+r0Pw3p5eQQo?=
 =?us-ascii?Q?K9SJI2QBaJhtblLzQp0zB3bS86HTiJRQ+HwQLDG8cKFZ/P6xRfu6IYt6DtCM?=
 =?us-ascii?Q?yHovooiAN1ELlylkw83LKoVoVITysvlHdGervBW48d92lGwoEl2EjuL9SrS0?=
 =?us-ascii?Q?8Fk3Iaf5aCq7XM+QK1qL0fsmTNJFsTtjOoanyfAnR/C+HVZkLVkP/EDGQsgA?=
 =?us-ascii?Q?qeEaPwGF/Zj3iqmta+2P9SZnn/bZ3suWFaShkEm3Wj77/s6goawCzQDVJEeA?=
 =?us-ascii?Q?jx2GpeDvGHJka8HvOKXDnDQAptzdAiure/qiUVbO010SRidjd5NK/kFKmKpj?=
 =?us-ascii?Q?QAtGUEx4x9rFE2YForRAINmvTQWuid7bBHIijUs8idb3V381QsFpiybzoYiR?=
 =?us-ascii?Q?8syg1ovhe2jB56/CgxOkiejNty1gE6vPdKnr5ODVWuUzvwinBVAszTjQymrX?=
 =?us-ascii?Q?L7303E/ldQhAE9StESJ9j9ksYUThNoU75DrApM4N/JfiU4+STWLJKTxnb9D/?=
 =?us-ascii?Q?n8PqXd+p+41qUiwKvF7oI+CT+R92VzZxyJEeZn1AyIwwYfkOUGNQjUxNbPZV?=
 =?us-ascii?Q?aS2KbtJs0+/nCKMsUXAq0dTBEX7S3Qz2NbWf5ui2CT++ckNPGeed97UdKvMu?=
 =?us-ascii?Q?M76JpBP03U97Q1+7UgF91G5uwlQU5y/T+CRO/t16V+EpgB6b8JDt514Q3jmV?=
 =?us-ascii?Q?wvfAZKsm9NW9VQ71y/qAMyFo7SZ/4oKWPD+Fnm1vpEai5goZskcItqoGZp20?=
 =?us-ascii?Q?e3xLqLmuBRsF2YUrAR8XERoncYob5WukTA8iokjlc9i67fDo1WBUTzgaYLKD?=
 =?us-ascii?Q?ddA6mMLyYPtpm4xzBAW+oKN2BiqUBUwdWrmDsJemI7wGgonHUIZdOFREjmF5?=
 =?us-ascii?Q?W2MzS+qGV+Fc+t08rgY/spHFAzOWTMolpAnDZLbqRVzLMBKUx2YNX0Em0/6v?=
 =?us-ascii?Q?cO18Tc5v/6VfgMZhWxJS9e+f?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05516A207033B24299B9AFA4FA02D2E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6833939-af61-46cc-3104-08d93b2d12d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 18:38:22.4477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFSmroHYNhf2tcqMfp+GWTJiMsrODw7FEncC2ZbjZh4w2annlmMyyrlkILYtN3OvQQ5UH5KnfnaTyO94FmMN8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4575
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290118
X-Proofpoint-GUID: 8c3pCkYCxoinqsIJ5GVng9eE2Ct79k0h
X-Proofpoint-ORIG-GUID: 8c3pCkYCxoinqsIJ5GVng9eE2Ct79k0h
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Mike-

> On Jun 29, 2021, at 2:28 PM, Marciniszyn, Mike <mike.marciniszyn@cornelis=
networks.com> wrote:
>=20
> During our continuous integration testing on 5.13.0 kernel our testing tr=
ips on NFS testing with the following trace on the client:
>=20
> [32936.156848] INFO: task kworker/9:1:519 blocked for more than 122 secon=
ds.
> [32936.165201]       Tainted: G S                5.13.0 #1
> [32936.171562] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [32936.180773] task:kworker/9:1     state:D stack:    0 pid:  519 ppid:  =
   2 flags:0x00004000
> [32936.190565] Workqueue: events xprt_destroy_cb [sunrpc]
> [32936.196854] Call Trace:
> [32936.200107]  __schedule+0x38e/0x8b0
> [32936.204482]  schedule+0x3c/0xa0
> [32936.208464]  schedule_timeout+0x215/0x2b0
> [32936.213401]  ? check_preempt_curr+0x3f/0x70
> [32936.218518]  ? ttwu_do_wakeup+0x17/0x140
> [32936.223336]  wait_for_completion+0x98/0xf0
> [32936.228396]  __flush_work+0x128/0x1e0
> [32936.232942]  ? worker_attach_to_pool+0xb0/0xb0
> [32936.238351]  ? work_busy+0x80/0x80
> [32936.242555]  __cancel_work_timer+0x110/0x1a0
> [32936.247726]  ? xprt_rdma_bc_destroy+0xc6/0xe0 [rpcrdma]
> [32936.254034]  xprt_rdma_destroy+0x15/0x50 [rpcrdma]
> [32936.259873]  process_one_work+0x1cb/0x360
> [32936.264788]  ? process_one_work+0x360/0x360
> [32936.269915]  worker_thread+0x30/0x370
> [32936.274436]  ? process_one_work+0x360/0x360
> [32936.279526]  kthread+0x116/0x130
> [32936.283534]  ? __kthread_cancel_work+0x40/0x40
> [32936.288924]  ret_from_fork+0x22/0x30
>=20
> The same tests and same servers see no such issue from rc4 to rc7, so the=
 failure seems new.
>=20
> Any thoughts?
>=20
> I'm currently rerunning rc7 just to be sure.

The NFS server in v5.13 is afflicted by a late-breaking bug-fix
to the alloc_pages_bulk_array() API. It's been fixed in Linus'
tree, but that tree is otherwise unstable for me.

Have a look at commit 66d9282523b for a one-liner fix, it should
apply cleanly to v5.13.

--
Chuck Lever



