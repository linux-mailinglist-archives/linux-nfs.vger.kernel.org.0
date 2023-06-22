Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0011F73A552
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jun 2023 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjFVPpb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jun 2023 11:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFVPp2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jun 2023 11:45:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226AE1713;
        Thu, 22 Jun 2023 08:45:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7pnQV016198;
        Thu, 22 Jun 2023 15:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=G1sXpp0i1mhVN7LNv8lcYZj/yr00iFw4VzJeMiw4pXk=;
 b=LOX7xjIg4LgwltUfWuKTxQvWb4EGeui1kEgfjbi/g25qp7JdjBTULAZpnXLyJBtDfzjo
 DFcgaqC18zTgQyuaf/3I3eMBWdLUFfmTdpgFkUQIL4o++3fn9rEPtcexMRHMhvQ/C69w
 jwtDiAqwUiNlOhsEy3FmVyaeKHo3S0uRAFy55/CXi4K3b3+5H9fAgCwRCREcfR4dq28I
 YLqJw1Yc/8LBjolM7+h/p3uGAVptaKITsC21KHnh9zQg5QP1jxZEpVR7V5Ku7y/bhM1D
 40NBBACyvrvZ3csjMAjStHM8LPiPu+qzh+05ote2e9+VH8Ue5SvSy8IJ0kS8kufrihEA ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa9y4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 15:45:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35MFaOeu008185;
        Thu, 22 Jun 2023 15:45:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93981f61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 15:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEwM69Mxq1OHM/H715nC59ejf5/BkRfq9kMXYFioFNbLXzO11QI72zR4R96lZ9pdeSPqM1LEE8m8YQPxND6uCcr0AlKYIt8u6IqAW3GI/wGuHUhznmZiZggjCrsG/nX++kdGp3YEEcKqms3efBusdlbos5vaKpejlVe7MUx8q2Q3LQAGDMLdAcEugUCO+L9Vn9bcAFIh2z3f0MXGr+WOS3YaAeSy384/b7CSQi7kRFJQpSZZ2wq44nGXIEdEPdEL/Pd2PwLWKY+n44On89hFSSVRlrcFdv1I5EY1SR6/rltLx2TrMTFRe//YBS57zd8KOmt9mfsrRSUfQrLcZTt3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1sXpp0i1mhVN7LNv8lcYZj/yr00iFw4VzJeMiw4pXk=;
 b=TsT/aX3XOU2XfoOdJkfO8ZzRKwqdtHpGExXhsqZSqZBp7thgSxczqtzRcqcJstiXXmzAo1il3mIbEffhnjzmGPPp8KYNC8hi3O2F3PUtNtvQ/6OeSGwZWUehidUx2uostO94Mjp4lK9ol/MD59PjwtfghM3t+fI3FOYLbTdWT0bmyx/GK/4dJvBAnl0RbTEDE76PRlaWfPzOCXRMtGa76cTeT59IVJXdmXkg0Xd82TMj7ag+paHCfzE1GLDb/zYJfyIUwU1Zz/xIxFgd21DyAPALjUKtzssy2mwZF4d62f21TG5jOCQsGqusc/g1V1X7wgH6DT+UNOn9BvH7/soDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1sXpp0i1mhVN7LNv8lcYZj/yr00iFw4VzJeMiw4pXk=;
 b=HW1Je/xIGF1M4en9YUdf47bnn1y0J1Z8e1dKZRsn16Gr8+3lfuHLhlVwF5xkolf56qAPzASLb5SSlUjqJQu6+ko5TlCO49gWE+v1TgftDaU2nSagMH0CQfDr5qEK1S+4A6GtYkjVcYyvq/t1GzkVr3JHJ09Kd0gpy28Kvn0SFvg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:45:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 15:45:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tejun Heo <tj@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: contention on pwq->pool->lock under heavy NFS workload
Thread-Topic: contention on pwq->pool->lock under heavy NFS workload
Thread-Index: AQHZpFS9Q4z69UfUdkyWw4ptMMUQRK+VxgUAgAEyXAA=
Date:   Thu, 22 Jun 2023 15:45:18 +0000
Message-ID: <CF5AF0E6-5213-489D-87CD-8E8325A6560F@oracle.com>
References: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
 <ZJNrht3NlLyPn2A0@slm.duckdns.org>
In-Reply-To: <ZJNrht3NlLyPn2A0@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7683:EE_
x-ms-office365-filtering-correlation-id: 34f35f11-39ee-4018-be50-08db7337ae75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFRHAOmqww5XC6KgZ2WQ6E0qyiIfpvm2Je5sTFMfPUEGfQNHAweb6b+gXAahbWaX4gxA2ZDacQ+zDEvb1FpqWljKofi/yHZeVBgFZLlXrTo5qfkR8Aj8NWH4bYwKnOfaeB1W7KrbgVr6oL2iQyMZ78kISn5TCgcAuOAq9cXTHdjTc2Ma5dXjbEJMO2PJU9DzAhd8zJehtlelR/RySmdss10vCWfdewbL4PGvQXfDWwx5DFeNkQOzKiX26qVhl8epWYjOTH13ThaiaXoGcYUyOS7uu+7s2H4aQCXaCmqOc9FBs83g4QrbsHjXYMMtdT9dBVYo0h7oHttSwSmnW5DZwIOQvixu8pzriVxru7ThzrTtFG2kKbD2AgYqjLy2uPkqwgz70WjqBnx2RdwzKeSvpX+wv4bbW1vKajEpdHdanz1gWLZ7e3U51iJyclxcGXx6gteGmcsdAt0A32HvX4OZcMccBUnKLDy4AeKiIvQAiRva+XWfv5sK+9IvR+uQBr9vqlWZMP0XRotHXmOWRDvGhnKXpnvcUEBdjd0mgqCM7TaZ4C+SzOcZWmERgIEVaRTqgCwwP0DoSp8dHx1BuL84ITZiRpFu3iGkOXfIea+JcRS4m7nldk9ESneFmh6lBROTBjy6UcFUW16nq/j44ezs8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(36756003)(316002)(66556008)(66946007)(64756008)(66476007)(66446008)(6916009)(4326008)(33656002)(8936002)(8676002)(38070700005)(478600001)(5660300002)(76116006)(2906002)(966005)(86362001)(54906003)(41300700001)(6486002)(38100700002)(186003)(53546011)(26005)(6512007)(6506007)(83380400001)(71200400001)(122000001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s47eMeAokGCoKP8WGezt8pT2LwMWD1meiMzMg8GaxLyT41rkhjRXwsptSaFD?=
 =?us-ascii?Q?2pCnAVQbTMfWpvrtIGsT/ClOMgv06NjwyEN3NjbWHl41eS2GAiuelj+40gLL?=
 =?us-ascii?Q?sv5dIG7ZBVz85Uk/u0Cy/sq910D+HvEm3aH9cw8rdd+5N8yOmifqcI+lHoAG?=
 =?us-ascii?Q?s9XVG6VcRMZfvQOfd66YHe+GJDJpKbEPUl3Rt8lPW46nnnWhhTJAk7d0Dy8X?=
 =?us-ascii?Q?Eb0SEjL1x7L2P5bx5HX8U5luLcFnF2DrO0yVZF6Kx5GsIBGbzo5FAaPKduYt?=
 =?us-ascii?Q?v0vsAPLyHA2941UQcb9DCjlVaSKbbvsoEy00znd9IOMdVssxBjU4iBg5Cg12?=
 =?us-ascii?Q?Ex+5SDbCZG+hn3rEliCC0s3NOkA88yBZDpphAIo9mfK83TWUnAKzuaqZD5Bz?=
 =?us-ascii?Q?jvk5jMWmJTy+NOQwZh7CVND3pxgSyl6vXzoHuaPr4yiFunLtqO7jqP4QP09y?=
 =?us-ascii?Q?WlZhuhL7JGYT55zesIvty3OrmFAXhMtneKvHHk/NJGUy96GpnyjM4ARaJCHu?=
 =?us-ascii?Q?wRjqL6xIilPfe7bVtLs6Lpl1qMNI7fh8nmb6yy2o85VdZt+A/lnzLK7R5QGl?=
 =?us-ascii?Q?KYQr7fDc4G1GR+PgbRd/m4Xs3/W+NfKbq3jTRxvIW+VpsG3AmQ+LrF95xGAC?=
 =?us-ascii?Q?BBVfsVPjnkqbEmebzotgeMhKp+dsNcG81K7uguZpbCqMOwldcEAetWqM7uYX?=
 =?us-ascii?Q?0rhLUefEvJmh+IVMd0EmsX0t9jfiUdLa1Q19gBtOU5i5khlZSjIMyk6q9NRH?=
 =?us-ascii?Q?rfaQ6kb+9i59/KyQm9AgFo0XSIlDU7hD+DWfrrB9CMIdJ/TC3KO28HDK4iEt?=
 =?us-ascii?Q?gNyXpsKeqnlOUUk6RdnCk2h92DvEglwQRJuncCmzmf4fGqP273+MPE6KfX0x?=
 =?us-ascii?Q?VlbTXNK6Mpaf8JVn+8f7xNij0sVm7WOD+aeZDtLrpcDmyvH5rQkdAF/Hj343?=
 =?us-ascii?Q?uIs2YbtQy3wNpC3YRHRMdkyLoWDwtGRhRBIky0SV/CgPzTLixHzVwkhz6aF+?=
 =?us-ascii?Q?76xKKr+hYbzA8LgpSRGKvXev3vwi1w8UTQ2vERhJyQQ6Y8yTVNaQUtOweJzh?=
 =?us-ascii?Q?erfF/pEY4KdfRuSf//QVXMST9BzmXQqHWsvEkZe7Ghz+inw7dcAyyXteY/Fk?=
 =?us-ascii?Q?yGMhAmlLW5lCcWOtqd7PxAT4E44ijqCcuoSEZs8ShB2qmKalr4CZdg9yIlY+?=
 =?us-ascii?Q?jQgba6032s5wHvR6soudpzLCZuEBJAEbbz1mlOnv0zbOPa9gc9M+nko/QIhR?=
 =?us-ascii?Q?sRi6LsN2Bb9RP5TdnnSJM5mJjb92OPNEt+DB4NRoHj9lqUBatvdnio/rIgdi?=
 =?us-ascii?Q?63rUtAiKiXqiE3BLjx6N4C+hxLbpwETf+0432l56zoRwZCLd6sNjIfwjGv/J?=
 =?us-ascii?Q?N0Hs328zw5MN4q99dLXuKQuQqP7sBSdFMYUTFfCoBROLJ+Er4ahCd2Hour3a?=
 =?us-ascii?Q?ovQj9xlbhwQKjKThET5VKmmJd48WrsE7TpXOmiu5swDS9ZsVFJybpUhVrWrv?=
 =?us-ascii?Q?OtgrCPrbwu1UiDya8Pv6JJlNbgW96UaGsrZNWspUGUoD2jPPbN2PipXlyMqR?=
 =?us-ascii?Q?fYaIh1BjVIoZYqD+6+eYcPQ1nRmGWg4YeP27Mgc7ipak6zMT6r2XLQKLBNaa?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A30CEF6AD513D4BA38B11AC676F7B6C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: krF8eus6x3O3PSZFY/Pdav0j6klTdi+Vl/HStXufacBDo0qtqrWM+pjy+Vl5gLOsm0u49WdJBIMefOudD+MHFh6lnVPkXmMIlIlvuA0R3Mwd6rQ9qn48XvHnylmJbli/JVWWxyyrb+tx9J+G3kXgCz9Al1IDY221ZbgFbGAUSm2CSg2xzC6bRULeyC+wIhTPnvJXOv1MZgmCuBmkBqcR3bcx6Jbrwrdq6dDb5ocQAStRH6lMLxfkWPpOvqgar3rFIdyE/v21MNLWKyWWrbpbtRY73Q+VKyubhLsc4uaicHAejnIpI9seMM9KmaFB0VgM17Z0rqLwRW+wXppeVa/w8U4KpT11QGBxJFASDrKbJSnele0dbo+N6GnMsQRmnhHIfok4+1uDlmLpPs9Rg0X2iwgXXQvFZIGKU+ZWJcrZObJKuX98vUphCN7hrsLhXVAhLE0JJtC2xQDVea7Ue4Qoo75L8+GaoINPKtF9Vb+nezQmNbUIIsQTTVaxmD1lfAn4zYPKjb0qdKnJiGqpilLjNywN11QfCF4Q3ls783wM+y9+KfY2tNNb1KHc5P7/2gFgtxM6HvYpZ6uRVvufoCe3qIUBngMpf0/7+KL1Eexd+c1EHOfsln3rc25vR2E9ZvDUrJ9MxKqEnWqlndL671vS5yPkbDD9/9h3uDQLa5AK+A6AxyN+OpibpAPA+f/Lcz8PlTO0jd+5H+qbUDzmPSu4EvBQJR9QLCDOXiiXDjvHLDYxakJHoTGkdwrfjlaEbcT9rh7tSLnNB12irQ9JYoCmKVA3NDhDiQEfMEywSNEqUDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f35f11-39ee-4018-be50-08db7337ae75
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 15:45:18.9819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrJw5jHzsELkIkAcGMkbQhH9nPmD0O6AwEi7/9HuBomkcMMaMnuag1sCJfaIUJaubiBP2rM/u4wskwa/rZleTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_10,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220133
X-Proofpoint-GUID: e7BSW8I6sBqC0cUzc-kQKHGTmW38Oq3V
X-Proofpoint-ORIG-GUID: e7BSW8I6sBqC0cUzc-kQKHGTmW38Oq3V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 21, 2023, at 5:28 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> Hello,
>=20
> On Wed, Jun 21, 2023 at 03:26:22PM +0000, Chuck Lever III wrote:
>> lock_stat reports that the pool->lock kernel/workqueue.c:1483 is the hig=
hest
>> contended lock on my test NFS client. The issue appears to be that the t=
hree
>> NFS-related workqueues, rpciod_workqueue, xprtiod_workqueue, and nfsiod =
all
>> get placed in the same worker_pool, so they have to fight over one pool =
lock.
>>=20
>> I notice that ib_comp_wq is allocated with the same flags, but I don't s=
ee
>> significant contention there, and a trace_printk in __queue_work shows t=
hat
>> work items queued on that WQ seem to alternate between at least two diff=
erent
>> worker_pools.
>>=20
>> Is there a preferred way to ensure the NFS WQs get spread a little more =
fairly
>> amongst the worker_pools?
>=20
> Can you share the output of lstopo on the test machine?
>=20
> The following branch has pending workqueue changes which makes unbound
> workqueues finer grained by default and a lot more flexible in how they'r=
e
> segmented.
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-v=
2
>=20
> Can you please test with the brnach? If the default doesn't improve the
> situation, you can set WQ_SYSFS on the affected workqueues and change the=
ir
> scoping by writing to /sys/devices/virtual/WQ_NAME/affinity_scope. Please
> take a look at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/tree/Documentat=
ion/core-api/workqueue.rst?h=3Daffinity-scopes-v2#n350
>=20
> for more details.

The good news:

On stock 6.4-rc7:

fio 8k [r=3D108k,w=3D46.9k IOPS]

On the affinity-scopes-v2 branch (with no other tuning):

fio 8k [r=3D130k,w=3D55.9k IOPS]


The bad news:

pool->lock is still the hottest lock on the system during the test.


I'll try some of the alternate scope settings this afternoon.


--
Chuck Lever


