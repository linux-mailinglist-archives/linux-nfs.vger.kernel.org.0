Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB40077EEF0
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 04:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjHQCI3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Aug 2023 22:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHQCIG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Aug 2023 22:08:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF771FE2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 19:08:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GNfGqP020577;
        Thu, 17 Aug 2023 02:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7W0kgr9aPQgmlykhClOKz43MbpjkqLjb6c0oWRG42Ug=;
 b=pRVDcDCGmxCXsImfys5SjydplcYo9gJXDZDXoYj6ZcFiIZ3HBU9TnTb4GLg74goEsycF
 pXo3x/mybHLXi7Ylo4AgBCNApsKBO9JkgBeQvuNVWZ4997+M/bKhREuF7a+ov0Xsi3NI
 HKvDOHVVwI+JjG8ZroAb8wOw/F2eyyNywbqzOyjv4CYEtYbFYerAwQES4ZOQiur0OfGT
 lsl4INiqcBqLogUIEFNhG1zUfGnuQe33oaYIPCoSn3wxTVHL91CaHVyAhq/APKB3TIJF
 FDhncu7qhCI3lZgJttSjyuJhVqp+oPCzM2j3RUZwTkd8DDCWqZuDC6QKFox17Zj5Ohw1 Ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfrc5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 02:07:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37H144kp027683;
        Thu, 17 Aug 2023 02:07:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1u7pc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 02:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5k4m45OGAMbR3MVGCYVXcc0laIrogj4ycUK12KmwAdtS6oI0IIHMU7cY2FuFY9mDtZ6j26VEt3DRk5NPrP/3CAewmQLsjzSl6Azkx/Bbsc9wmjWGEi9ScX4F0Owa/RtERvnrCQMcLUnSN35mXM9qEVkim7jqyIHusBwwF9Oi2W2s5cU03d+ZQfuKa8NxshcnwXIlBVQbEalrWNGD9Tz5Kh1Rwc+VoZR+qzsW36/9RndXgbuVYHLyMXW7KG+KcZUDLfJ+ew9stRvokOFFbY4UUI5lzie/fNYscMhE1PKsZOjb/RZUaGaLLVirEy0GhU83bKiOyOqIcw86mxAI7Dg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W0kgr9aPQgmlykhClOKz43MbpjkqLjb6c0oWRG42Ug=;
 b=ZKIj5G9hJlitWt1caINKJOO8klxv7lVvr15TyGn/rRLL984HZpE88LJ2pzeo36ERqT3b8w+Hlb7/blJp0jYhjx6auWYZdGVhKYoe9gVX+7ilxqnXloJT7GmIU/C9dHgNtg9p39CS4p9KB4keL8krFn5JZs8UE56+TriIfD5xSe7J/eryByq2aQ+L2ZhtA+2OMSQcR18mGySgCmhS09i7Zvrs+7jLWaIoGswdclPfyxSAd1ulpGvKHQMohso69T1VtsW8pVuN2qXgxBYUrC3Gn57sUmi43xlAtqtmH7LoS2pMO3syLPl9jF0VJH/39j/o3CoRevHQAtS9RB/Ic5cDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W0kgr9aPQgmlykhClOKz43MbpjkqLjb6c0oWRG42Ug=;
 b=EL0siHXJ6Hlck6qFYAKp9xitee6JzXfkGpgy5ZjGgUAvR2SaHw2IvFA4sqxkmDioFIiam4XuwDKwIMUwyiDtSNdSP/9KsIvRWvPsedJJsS3C/5IuB7hx7ltj8IWi3lJaSTDLi1+0HIGMo+9o+y54qh1mLfTKixVQi72VCfGlG2E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7078.namprd10.prod.outlook.com (2603:10b6:510:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Thu, 17 Aug
 2023 02:07:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 02:07:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jordan Rife <jrife@google.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Avoid address overwrite with eBPF NAT
Thread-Topic: [PATCH] SUNRPC: Avoid address overwrite with eBPF NAT
Thread-Index: AQHZ0K0Gf4LZTbzHYUi/lgu/SnrTja/tvdqA
Date:   Thu, 17 Aug 2023 02:07:51 +0000
Message-ID: <82F595C8-76C1-4718-AA54-68E5A63D7F3E@oracle.com>
References: <20230817014808.3494465-2-jrife@google.com>
In-Reply-To: <20230817014808.3494465-2-jrife@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB7078:EE_
x-ms-office365-filtering-correlation-id: e65d7e5f-0ffa-4e7e-b58f-08db9ec6c323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQlaeBd9mDpRYjYs+pQG/mwde7lP42Zj1nsZifp50ih4OfQuSFB3c9nSO5f/iLOeCGdTbEA6ARklTNYCsiCgQW1lHr9ZmZto3XE+cBzmCfOZKli8qa4ltG8HHg3CVotuxrLczZRm5AzJpb77+xVHGO69uwa7CM7ViJ29KP6v78UqrfZDGIlQD+zMrvLjhB4kk4o09M7IQ4ntCaTPrtrGtY2MN9bfUdgSKAgKvBWJ/3R1eXDWxNoOXdQ8oePHzVjoU4v/s8QLzF/e4B7ZyiFBnO8sVll3D668ymFh1K8iKvA1QHLDcEhrUt7z6W0NLrfseD6mNYbNMW5FJi24ru/3zwh4XkOlWVIHSvPoXcLywWBdLZl4uweF3vNMcY2xFKdYGJaWJrwvXyPCBpRomDOgMgJxvzeaSm/vGPNFqLj6R2IPbunh8WoK8nPejzIItjNVREFfmzCfQFdUeMIVkecykonZ6pTmkEkkP3xLeQx+H2ia62sxt113CQoTleAKIrlxZNbCgLqlN9ioU8sr45PZqI0iWOcvfcEbb2LGZw2CPGauVoeRNvUiHPAMSePQIvHKMXse1f9MIhG+D/+5EwY6MFdnJqZFp/mC+f+1s89NR8JnpzyTCEkFpg09FzGMMlXGRv5NDx7yIc32CzFUS40uxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(91956017)(66556008)(66946007)(66476007)(64756008)(76116006)(66446008)(122000001)(966005)(5660300002)(41300700001)(38100700002)(38070700005)(4326008)(8936002)(8676002)(26005)(2906002)(83380400001)(478600001)(86362001)(53546011)(6512007)(33656002)(36756003)(6506007)(71200400001)(6486002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F8styHff17euUlICUSrFVAw3NeYwz9dTnekDwP2MObVrps2OzgZwf3zNjtsM?=
 =?us-ascii?Q?0XMMpEwhwU52NQn9dcPCV4uqy2E4ba3QLf9dIAL6xqNafq418rEYCoQd3tdD?=
 =?us-ascii?Q?3poHcGvDdH8zXLRxJTvB3HC1w+k9psWaJkHAtxeta5Y3A+ekWbytwY+tCrwE?=
 =?us-ascii?Q?nfy/FhGanbOTl2HA9w3Vv5I7DqhWEhpay3kALo5mDwPf/dLGzzBMBfBRScFS?=
 =?us-ascii?Q?aZOMs077mG5X20x5yT3sEf3XMN5prIAXiwzFcyFgM0Y8GeHIwDtQIpvX9hvz?=
 =?us-ascii?Q?HD/PC+7eCy592gVbt0cOA3+1Yz8pEAU3rtoEwy2u+NGyURfdtnfcMNEsbCgU?=
 =?us-ascii?Q?eOZlkY+BSEmiPz6bnEnSeKjC8Mp884a1qQv60tvgbH+MrgchWZDbJlOVlr0c?=
 =?us-ascii?Q?gp7FqiCm04GsAHiJAEjgwAupnpF+w6wLmmX7zs01QhFu0+FUJgUHZWLFCdhb?=
 =?us-ascii?Q?tQ9lbiNnCQNO9d6EsFTUjZD7GUKD7q3FAYitY2i+8vPlH4YFJ8JmldHbQEz3?=
 =?us-ascii?Q?adcV6fFQPj77scVH5FUNVPpiiI4OAJdaRClxbPJZJCsinB7DJSsYxL38dys6?=
 =?us-ascii?Q?CC61q2I0Wp2jGP+IZYiYl7550H3sI2a7PJs79Gubb1gbLuQr/dZxMdotKM/5?=
 =?us-ascii?Q?qkkbAHSYIwpBCCY7XhKethBjgfuyyE7gRITYDFi7qU4tl6yO5UdnIiI2UoLV?=
 =?us-ascii?Q?mL4vviiJU4YnJTwNIG5KDt/H5hBsLtSMbn/qBF9vetiqHgdnxdaAUiPkUpLl?=
 =?us-ascii?Q?A3rR4JSvxEJqtyWpbYrcILX+umOUKBE94Hf27ErD9fwnxtoXD9ggP6NC7kho?=
 =?us-ascii?Q?dN63DXpgQO+obGWtMJk+ieSBtZQeGmWUkJ27q3Qe56nP8IFc1qRPQZeDzkTy?=
 =?us-ascii?Q?ZmovIfbYTs3MZFNgJJPtil/bpfrvzL0AgPHbrikz+1Ej9rleIb647oAGb267?=
 =?us-ascii?Q?jkV4g2v7GcS/DHHGV+TaRfTy7STt4zmlcoHQ/42QcQfeI5T9++q6yR2cq9Wx?=
 =?us-ascii?Q?B5LjCWCRl/jnROTDJ++OxLrcMwmn9Zs2zrPfCYVQpJNjdX5hpqDkeUqiilfP?=
 =?us-ascii?Q?vsITSOkhfmzIdC8aNt05+QPXlvh9Y6UvuVS5E4Nt1dOsaHODcdE5nw1gcRvI?=
 =?us-ascii?Q?sEfGC8eTMoledJii+QjuZ/rsmrDtavrJh8SV7Ib1dEwVeSIV4tZxSL10NkvX?=
 =?us-ascii?Q?hjFKKpM/lsr4yhfHW4+ukkoPLEZUZyPuxFtcQ1CZWHN2ViSmqeJkkl6hMpso?=
 =?us-ascii?Q?v6KmR0fiZVi20wFOf7RpL8bwei+YXok5L0vjhiUkAlWrjFruRn7JvgTv0in2?=
 =?us-ascii?Q?KBwKJPalH18dDCmflvBwHcjpZs6g0h3F4DkMJtQAGdARmXXNHy6pOYNkZGHo?=
 =?us-ascii?Q?ixQbMURcRAp0F5hjaoSDXjeK+/0oPR5IvQVYspvBj1ws4OIES+HMJxlJ7S0E?=
 =?us-ascii?Q?C80ji/BJTk5733QfdBU4EOXNQij2p07ETPunBIiVFmbc4s1OMhcxgRKF1zyA?=
 =?us-ascii?Q?/eZ1iR4oW7w+N7siPhhfzyaLlZeZV3wbydqsIq5TeZRVuqzoJ8fThD/DvZWO?=
 =?us-ascii?Q?z8rwFwveEiRpx03JP8/LeSo5sOwB6aaU0jEN4oliw2dlU2ncackV5FeQu3AJ?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC61ACE97E9F474DAF5FC1E3DBA8F0AE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zET58aHb6UtNnCMZ0RjctgyFd9keaRF5LrBHdDPtSZwe2OWVHeTrUuNNhvrvFSIBFqkK/IZ63VqZ9Mpvam42PqDfnoaEMo+YssqvslIFNKmS0WzmSABlF5Lk1ypV3EnSwMStPWLQ/xfLGw7qVvhgwJo1cyRHY233PmNv10BxVWUwJWcivZPOFz7CJgXKRSWJZGO7QHg3LhtMsKxRdblqNguWYrj4kkH35YtT3bknSLIrdQsdQc8HyRFO1sumGdm9/dnxJ6XHWK35KHRTnNlA0jPB55CfcKlqsHQpVcXIZsto2KRXqPYEqFEJs6L+9pTcM6jolq7U7g3a92NKovD2/6/SRgB1fyRCVjnuizQRwZS6TQXmZBogjRusZicMKzIp9zUyHshy7PIIoF7Rf31PpVSRmU/Rb3nHWM7GwPpbXtneu3WJIbBJBAhfD0df25irZlnnXq6yd6bCS9hp+2xX6W3HEzilPC2PUemEOIRo/H7BWGY7eJnSW4uMzEEwAJFqMdHZRPKIeaFhu8z0lBXL9jsWts6PpVEcs7CZlpgYuOqPC65VvOY6EwJTHUjpZhyqWPac0sin7o6MF4/0xcf37B34U4QmaRJ3r/iVQwwol8sUhfuXNdqb2r78SuOZLB8pDhYl/Y9vB572zaVqYXzXcRPzapaF2RRY+RxTZxblRKaMjAlmvsbhdJvXUfDQba6h39J2fxR3tG1e6Z+Di38C7IrqTK+3Rb+Gw8J7dnYoZw4bmNWbF4VPJ1Xk74QdQTj+GX1yW3HgJFydHLfSNzU9R5Fg75zC5smEL4gILn3hT/oQUUKKddLMBKH50sEy5D10OWTiNjk9G2mZIiBEd9chGA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65d7e5f-0ffa-4e7e-b58f-08db9ec6c323
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 02:07:51.7385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rb7zqmhmgX1Grk91Om9x+oYegmRzbN6moRmIslMCtxKGxFeUaYTrfbyGT3KXEWLn9vJYnWYgjESIocEA0dSQZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=997 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170016
X-Proofpoint-ORIG-GUID: kdSJ7-gaxwf5ctBzdrKtaYNGAnNnxTX7
X-Proofpoint-GUID: kdSJ7-gaxwf5ctBzdrKtaYNGAnNnxTX7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 16, 2023, at 9:48 PM, Jordan Rife <jrife@google.com> wrote:
>=20
> kernel_connect() will modify the rpc_xprt socket address in contexts
> where eBPF programs perform NAT instead of iptables. In these contexts,
> it is common for an NFS mount to be mounted to be a static virtual IP
> while the server has an ephemeral IP leading to a problem where the
> virtual IP gets overwritten and forgotten. When the endpoint IP changes,
> reconnect attempts fail and the mount never recovers.
>=20
> This patch protects addr from being modified in these scenarios, allowing
> NFS reconnects to work as intended.
>=20
> Link: https://github.com/cilium/cilium/issues/21541#issuecomment-13868573=
38
> Signed-off-by: Jordan Rife <jrife@google.com>

Hello Jordan, since kernel_connect() is used exclusively
by the RPC client, I suggest directing your patch to
Trond and Anna.

<trondmy@hammerspace.com <mailto:trondmy@hammerspace.com>>
<anna@kernel.org <mailto:anna@kernel.org>>

Does the RPC/RDMA client also have this issue? It does
not use kernel_connect().


> ---
> include/linux/sunrpc/xprt.h |  1 +
> net/sunrpc/xprtsock.c       | 17 +++++++++++++++--
> 2 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index b52411bcfe4e7..ddde79b025c53 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -211,6 +211,7 @@ struct rpc_xprt {
>=20
> const struct rpc_timeout *timeout; /* timeout parms */
> struct sockaddr_storage addr; /* server address */
> + struct sockaddr_storage m_addr;      /* mutable server address */
> size_t addrlen; /* size of server address */
> int prot; /* IP protocol */
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 9f010369100a2..4100e0bf5ebba 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -236,6 +236,18 @@ static inline struct sockaddr *xs_addr(struct rpc_xp=
rt *xprt)
> return (struct sockaddr *) &xprt->addr;
> }
>=20
> +static inline struct sockaddr *xs_m_addr(struct rpc_xprt *xprt)
> +{
> +    /* kernel_connect() may modify the address in contexts where NAT is
> +     * performed by eBPF programs instead of iptables. Make a copy to en=
sure
> +     * that our original address, xprt->addr, is not modified. Without t=
his,
> +     * NFS reconnects may fail if the endpoint address changes.
> +     */
> + memcpy(&xprt->m_addr, &xprt->addr, xprt->addrlen);
> +
> + return (struct sockaddr *) &xprt->m_addr;
> +}
> +
> static inline struct sockaddr_un *xs_addr_un(struct rpc_xprt *xprt)
> {
> return (struct sockaddr_un *) &xprt->addr;
> @@ -1954,7 +1966,7 @@ static int xs_local_finish_connecting(struct rpc_xp=
rt *xprt,
>=20
> xs_stream_start_connect(transport);
>=20
> - return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, 0);
> + return kernel_connect(sock, xs_m_addr(xprt), xprt->addrlen, 0);
> }
>=20
> /**
> @@ -2334,7 +2346,8 @@ static int xs_tcp_finish_connecting(struct rpc_xprt=
 *xprt, struct socket *sock)
>=20
> /* Tell the socket layer to start connecting... */
> set_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
> - return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
> +
> + return kernel_connect(sock, xs_m_addr(xprt), xprt->addrlen, O_NONBLOCK)=
;
> }
>=20
> /**
> --=20
> 2.42.0.rc1.204.g551eb34607-goog
>=20

--
Chuck Lever


