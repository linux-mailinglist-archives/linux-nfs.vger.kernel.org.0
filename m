Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7675A2906
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbiHZODV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiHZODT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 10:03:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58952BD0B8;
        Fri, 26 Aug 2022 07:03:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QDceVt006859;
        Fri, 26 Aug 2022 14:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DdwzQwGIc0MXYUNKf+ZcQtbiHGwZ47h/4fGKgMNC/Nk=;
 b=0tiWReJgFnv7H5pRAtaJWd+sF8Y2D0a6+V7Db6ssFDoHwvHtnwqz6TMkNwt4+OCn7sxH
 kA4P6KCOlcacUn7X212MTGGdruo8BqrK8aDae7fT+QVyoDO4cWCdFrUIktQ7yHYF1cM5
 s6G6UOpH1fz3LUgcEFDI3YalM8KNK0f+7YWMo8FJitTNtlo/gtapohHkbaeJnt4dymKE
 jozApprTsHMhIgXujAvv/pGqoV8c2xFOeN7KaCuK+H2C7eIcIU34ZIw7ZcsyFbfkYtT6
 SJR+iTBSoci7U+tMhKEE6zN3txC3hiP8PZvdTw435CMk1FE7ruUlAiv9loXiFS3u0B0u uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w241qy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 14:03:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QDqIvu029815;
        Fri, 26 Aug 2022 14:03:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5qud9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 14:03:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPxqs7v+oM2uk2GK6NK/GT6Q0Nbq/q1gU/M2SrOye8uLA4KgM+g6BzcKIdGnnILqHgtdzVoo7MHzaG1TTPqDelqxVaZMBGfp3e3obgwUZZIK9Gc1o7Qq2noHFxuND933V14b9QLX4LIpuWMzkXhHjVHDV5O8dGw/T5qStJ6iTNq7C+AoZtUgk6BeKTjoo2Im6i0Pw44ysiKcSP7tF7C/SaOzKKAlHzanPckIeq0EUuEGhqEUJGbum6U6BKWRwgkGUOkIOnAH7D+SOH5bA9Hh1ISoYXFOz1U5nQHC2WaSHrCTeA2xzqLHnXvTW71fWHknRDx+L8Ye9yINJwGJsmHXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdwzQwGIc0MXYUNKf+ZcQtbiHGwZ47h/4fGKgMNC/Nk=;
 b=gS8k/vVO4mbnLoOQHPx3y85tDcUAxxi6wH69llTxcwb3wlwe01pLKSFMJGl1m25B0eoXmtntG/RgwnRrZjZ64Cz8sX4G+sPtbnXLehBbR50md6rgqu5XARhZDIJSzDKRF368sOJ/dknVoBNEhyM2tfxXma8IVj8pyruOFkaGpw1R/NhO4BTfuS7yspXLjEHOizFvgcb1/YiawVByCTezO+xbmRIt4f47fw+REBjjA7W5XhDfyK/V4spGTS4HWD4AGUJkIjY6oPDbEqwvHFLOJtJhA7t9+cVF3AsiOOSB5JOu8cuMkz6B1qpOvoSaX4rSmh1fVEzs6kDgdMUFuWFVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdwzQwGIc0MXYUNKf+ZcQtbiHGwZ47h/4fGKgMNC/Nk=;
 b=H5+s6RWqwRQEKI7Y04O8DXa9IfSVE9ZJ+5HI0qVHHSHIsw/jNHaWJC7i3MXlxTwmlDCKUXc7qqfMwiFVANjmfOlVYqt51Hy3N9aZcKW/pmn4imVKj0O7zV0cVosW8jaCsxEbeFClEJ8xYe4Q8uGzK8Izx6fO330jKkderNM7CY0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB2833.namprd10.prod.outlook.com (2603:10b6:208:78::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:03:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:02:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Thread-Topic: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on
 addr_wq
Thread-Index: AQHYtjxDHzOcFbDad0CgCtqOY9xpUa28It+AgABhkYCAAUS4AIAAULmAgAMZTACAAAltAA==
Date:   Fri, 26 Aug 2022 14:02:55 +0000
Message-ID: <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
 <YwSLOxyEtV4l2Frc@unreal> <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
 <YwXtePKW+sn/89M6@unreal> <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
 <YwjKpoVbd1WygWwF@nvidia.com>
In-Reply-To: <YwjKpoVbd1WygWwF@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6364e4e-71bc-408a-aaa7-08da876bac8b
x-ms-traffictypediagnostic: BL0PR10MB2833:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Va9rlC7kqj77XDCfTY2u6+oLyOXM5gyDC+gLm4t9Q5dnrQgRsDimq4dj50DiWJBbDmE8fi3eared0dOqE06PXgweNtXeD/hGqExZMHmCktbGtZKtMbEbaffIOfx5GFMoTD23ju05mDgOX5wkLSkp3HsS1dZatfrMFoXy5W6fS5IFutvmrqUyNlthwxKumgkk77niXsmTIFd42rzcC8WSe6lu8rx/fliSvrDMwv5CVR+Ovg8lTzHLJtHlbaLRXqlTQXsNsssBYYZbHbsy+MFvDnonDGOqqG/fBNe6pJWRtI992Y9k/V3dvJGBL/p5wQ4npJYeJrcMpS7IynA3FZj8LBhkI9jH7USrhLalRqLHlOYPGEognDB/CH0ZsnBgOU+axuaS9Z8Da8EtdIB7BT8SWNV52sn4XoydDml8wlbq6BMeCvP+BEcRSMfq8obr8EBn9EN2oSZg9N5vKcL95RbfPixd3jusC2/UDdWt2vi3YIcDmjkGVUjlG501S8vwcoaDFgqUIw5u2Mn68U6WCkQbLY7RBR1zGVCdW0SHq4hI7xdG47BQ/dZL3CwjXFckmoewnHrteUyDRK8MG3wKG1X9SORD8O6JTVZqSexh1hap+zN6M7XQcLtFj0mFf12IWUv3JyvWHuFFfbgecCLbdtp3khV4gSKI6/EyHSv73e/GlL7dHuVzjkZa1uE9nsuZSc9KP1n1WIudW4NkahbWMXg81wj0wg6RwpO8ToSotOuXrPLb8m/ttRXCKUkAQdVti3K+L9wOvhRQZHKjksNpsyIRXQl8KxAhxSKOvz8UBoMwWxw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(38100700002)(66476007)(2616005)(5660300002)(83380400001)(478600001)(66446008)(66556008)(6486002)(4326008)(8676002)(91956017)(76116006)(33656002)(6512007)(38070700005)(8936002)(64756008)(66946007)(86362001)(53546011)(122000001)(6506007)(2906002)(26005)(54906003)(41300700001)(186003)(36756003)(71200400001)(6916009)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fYCARzWEAAGrReDqL8pdtRLNJ6G7QpNiDroiXrT8kPGF3f2X/wU4xTp/eAGm?=
 =?us-ascii?Q?CojuIsciU1uy8QEfowUuTPqGMfE+W5Wrwj1NTmdYJm6IHsSZ9MoAoTChp16g?=
 =?us-ascii?Q?DolRmsoyOmwnSrquJU0NE752ShyQiykEEq4BU0kdva56uJZWwgkawqBS/A6s?=
 =?us-ascii?Q?9ijxaIZDPdrj2+cHeSuWZWxAKh6L4hP5rvFXRZ9XyGPoDTuLmmIPt0Ez8Grw?=
 =?us-ascii?Q?XMrqwUrgsgZdatAXUFBCNVC/z/3Qbwf75fCcHRtTGQV4SWv8Jt+bH2x3dgoy?=
 =?us-ascii?Q?IbltPiM2rpOANh8lMh1teCharxbkSDPZTji6z0Gyq/NPy5sO4/+1RNoD4KK5?=
 =?us-ascii?Q?xXnEu8+Zirjnx7cJBXMYnzSs00ZuD0CnjWRJtdkY1QNfdDlgzbDx57TA3Bct?=
 =?us-ascii?Q?BOkhwvF/bHWre50JScBuvAu+t0puYiMXWl7XotpdpXvyfsW9B+OHum56ibHM?=
 =?us-ascii?Q?zPcFxwOAIMBuvvsuR/IkmAMBYaUP7RepLbPSEQXy/wQHPF1YgC9zX3Rh6It5?=
 =?us-ascii?Q?9tm3L//zq9kfTTZrzybFu9CpLENZa0tuQi1MsMG/yrdSe02JbzF9k2ReN0xb?=
 =?us-ascii?Q?BtTg+U0WfJQtvRJJZRXUuRRtQdGvh9VTrn9uV7a+Csd2Df3jOXpkGFk1TT9y?=
 =?us-ascii?Q?cMzB0mg7DC7ZCv+TM5SgeE9BdFQvXqXIXes7ZY2nXq1xJgClG3o7pdUEBf9q?=
 =?us-ascii?Q?GUKho6TK6ERbtrfHstilZBN47QbKtL8yrPrQtJvGj7f1Woyi6RKxrPFlX4Vt?=
 =?us-ascii?Q?W0yk4y9o/GFjNmFvWi0lRijBeZ99D2fsxiVpn55jKnfPh57/QyY73KgoOzqW?=
 =?us-ascii?Q?1r4wTiTphZpVWuZbcBnUqXdFKVNWf87EHylykGYYE4NDDO3tuQtySHRpY/OP?=
 =?us-ascii?Q?DlyymuU14NvFPlqKWXzcph6+IsTsbAwKDpu9DnwOprryTc6D+Gq0AHffwqT6?=
 =?us-ascii?Q?1dt4VdmIfDe/9z7FdXPZ2SpiDjCX8YkFW20gorOFG93Zu9gz3dzrx7N4jed/?=
 =?us-ascii?Q?6lQKUjEy5O1AhKFNm6/Isfh+eLoMluoROY7xaSonkkZz3q6HgXH20yvd2cbt?=
 =?us-ascii?Q?aGo6ux94TWGI0dsy7iVnaEvAVCPaKmJtxRKYv+h8yDctxv5a+V3X+wm0AByW?=
 =?us-ascii?Q?qyMvXybChUpUsF6y67l61348zGupyy/F1VQt9hJdbH7i/M9HONA2K7mF9vsg?=
 =?us-ascii?Q?kMe9PxxLm4EnHcEhFctm9pwtkIMVC8/eo+Zx7ohC7jinrEfB65HqGhpxsNr/?=
 =?us-ascii?Q?hKZWlOhYATxJHqe8BJfFD3evRRQITO4mWnaXIjW/mG8d3nPigSpgZmy1Pyy4?=
 =?us-ascii?Q?kcNGlpwHtR9KuslF0gCWSe3Tk830QFu2E4j2x9XpDQBmfcdWsDLVyZwBXrq1?=
 =?us-ascii?Q?T7Qa0QeZtPDfuftejQotFNXj+ZFhnJI2aNMPS71qWgPW/s0Xvi9X1AJQ53XM?=
 =?us-ascii?Q?Bt+eIW1pMzK86iwx7mPfLpCRSZvQzJQAX3tZBDcsgov/YSiUg2qR96jwv8Ly?=
 =?us-ascii?Q?BY5SGrZCrpYnIsr+tXSe9U/cu9Eg6Pt9N+KjiZN9y0374nHh6irFTGQ0iff9?=
 =?us-ascii?Q?BfB7LTYU4dp70ZXNyxRZSSoQ3eu7UQKQcjE2ljP6fUshUGhW46Bg/G6feQ+t?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <300CA441EC7673459C3C310B55ADA320@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6364e4e-71bc-408a-aaa7-08da876bac8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 14:02:55.1373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGdL4Vwea5mjINBqbSllShPV/8snRgvibsQPsaKb+oe1LACgj0Idfh81NtzblrUMVzWFdOKsVO6Mju1V0OXZlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260059
X-Proofpoint-ORIG-GUID: xbTgS6acvNov5wIO1zWidHcFoCBA2iz2
X-Proofpoint-GUID: xbTgS6acvNov5wIO1zWidHcFoCBA2iz2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 26, 2022, at 9:29 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Wed, Aug 24, 2022 at 02:09:52PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Aug 24, 2022, at 5:20 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>>=20
>>> On Tue, Aug 23, 2022 at 01:58:44PM +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Aug 23, 2022, at 4:09 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>>>>=20
>>>>> On Mon, Aug 22, 2022 at 11:30:20AM -0400, Chuck Lever wrote:
>>>=20
>>> <...>
>>>=20
>>>>>> The xprtiod work queue is WQ_MEM_RECLAIM, so any work queue that
>>>>>> one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
>>>>>> prevent a priority inversion.
>>>>>=20
>>>>> But why do you have WQ_MEM_RECLAIM in xprtiod?
>>>>=20
>>>> Because RPC is under a filesystem (NFS). Therefore it has to handle
>>>> writeback demanded by direct reclaim. All of the storage ULPs have
>>>> this constraint, in fact.
>>>=20
>>> I don't know, this ib_addr workqueue is used when connection is created=
.
>>=20
>> Reconnection is exactly when we need to ensure that creating
>> a new connection won't trigger more memory allocation, because
>> that will immediately deadlock.
>>=20
>> Again, all network storage ULPs have this constraint.
>=20
> IMHO this whole concept is broken.
>=20
> The RDMA stack does not operate globally under RECLAIM, nor should it.
>=20
> If you attempt to do a reconnection/etc from within a RECLAIM context
> it will deadlock on one of the many allocations that are made to
> support opening the connection.
>=20
> The general idea of reclaim is that the entire task context working
> under the reclaim is marked with an override of the gfp flags to make
> all allocations under that call chain reclaim safe.
>=20
> But rdmacm does allocations outside this, eg in the WQs processing the
> CM packets. So this doesn't work and we will deadlock.
>=20
> Fixing it is a big deal and needs more that poking WQ_MEM_RECLAIM here
> and there..
>=20
> For instance, this patch is just incorrect, you can't use
> WQ_MEM_RECLAIM on a WQ that is doing allocations and expect anything
> useful to happen:
>=20
> addr_resolve()
> addr_resolve_neigh()
>  fetch_ha()
>   ib_nl_fetch_ha()
>     ib_nl_ip_send_msg()
>       	skb =3D nlmsg_new(len, GFP_KERNEL);
>=20
> So regardless of the MEM_RECLAIM the *actual work* being canceled can
> be stuck on an non-reclaim-safe allocation.

I see recent commits that do exactly what I've done for the reason I've don=
e it.

4c4b1996b5db ("IB/hfi1: Fix WQ_MEM_RECLAIM warning")
533d2e8b4d5e ("nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush durin=
g queue teardown")

I accept that this might be a long chain to pull, but we need a plan
to resolve this. Storage ULPs go to a lot of trouble to pre-allocate
resources to avoid deadlocking in reclaim -- handling reclaim properly
is supposed to be designed into this stack.


--
Chuck Lever



