Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B31779788
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Aug 2023 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjHKTI1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Aug 2023 15:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjHKTIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Aug 2023 15:08:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2FA2709
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 12:08:24 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDNlAn015227;
        Fri, 11 Aug 2023 19:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ve/Wfef/PqdAqrbsGMBV59sM+J2UdTiQaoh+2VWpcZI=;
 b=Gi4SbY1Jqt1Ayk6nOXIXvmPG5J1yDkYm+l62XrmlVl65GW5k8fmcCc58+jzLvCvbrC3b
 FeZQ5ZZm/sAqvaCJMWyqFPa3ZDGZIhffCfm7JTr5oV7geweVuxabj0Mrj76tqIi/F+kV
 cEXIwb739h2nbHYzx4ikT643P8odwhc7+pmrl3SgPMuXDHdcY5/IAIrxBCwZXVk6srzw
 Fjwmfxhy5MVOn5k7rwPYsDhdHk22y1+0Gn3R/sU0wdkTAPrDQ5AD9ZS7E3nbl/8G5hzd
 fJrg9RacpbihOTCEVRuHxo2BVbu1s6DYKGuFNMUP11vs8GHp4SDTCpb5MZ3AroFb/Xcd dQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8ybhr5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 19:08:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BIIfKm011011;
        Fri, 11 Aug 2023 19:08:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvh6hdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 19:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TApk6lQ0iJ07OPPZyxe/7DD2FHKXaT7uQyW3YvfexXFb9SKavATOtL4xGy4QTrH4NaSUJPgHhcL++7E5467YBWpM6C82Lzk8R6gS8iLpQfQuCYl+GmxKzxTRAD5PXUMl6u7ZkOzdlGvyrvezPNsd0HOfMUV1Je23vZ5hOtauAWLb/mwaOEBmz0qjtGkW6bakv4aB960wGBTHTWFvQheeIbkBKvM9FFTBDY+Wmc2a+y8bigMnvF6svM0QpuarwPSeAN50j4sewh16q+phghOb3yK2iACt1d1kCr1wUPYirI/+ub79HgTHsdFvxxvlbSkVbhU9srwndD5PAoiXJ0I69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve/Wfef/PqdAqrbsGMBV59sM+J2UdTiQaoh+2VWpcZI=;
 b=i5DcQMaPWYKD5QAt60YhXJvB+DTpvhRhcMLs38qNdmwRe+UJdUNzJzxfWyXCGMyl7KIQoDzagZYUCfw62xBFytk4AuIAGfJVMheJckqMqABobeLTTsyjxCMcPyDej86DvFc36NbfVZ3xl4mlVjLxr7X7/kI7qEirSBRZNp0GFIBRSnEzNePuKVTCoGI2Q2hQ+Wk9WqGF2GHAGNieawMF7CkpNe8r/V5CuG/JU5UmNdecTZpmpPqudCjQK66/zEZ5Ce/aOrRZNFzCqeHIap2rV8C4+DfV06FQSk9fMZSjrY+dGJYA9ruQb6gJ82+A9+AjLSvPRVbC0142HCZSvfMwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve/Wfef/PqdAqrbsGMBV59sM+J2UdTiQaoh+2VWpcZI=;
 b=fidkCbsSdG7iDx947WBRBC6EpuelE72SOPISorlkeZpO0GEyH/z1GmP7VW+nO/L248JBh1k162XxrZek9PeKBhHRGHKqo4C0BwtOqr6ges6GpFy4mg8srQ6i3yPIsJshneDRO2d36HjprqT+Jdl/uveHMkPcw8WTh7xvi6gS8W0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7766.namprd10.prod.outlook.com (2603:10b6:510:30c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 19:08:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 19:08:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] NFSD: allow client to use write delegation stateid
 for READ
Thread-Topic: [PATCH v7 2/4] NFSD: allow client to use write delegation
 stateid for READ
Thread-Index: AQHZqvWWVa87zTcsc0+PkdjTnu1klq/lmuUAgAAHBICAABYBAIAAAH4A
Date:   Fri, 11 Aug 2023 19:08:19 +0000
Message-ID: <524E999E-2988-473E-A18B-9617ECD30E12@oracle.com>
References: <1688089960-24568-1-git-send-email-dai.ngo@oracle.com>
 <1688089960-24568-3-git-send-email-dai.ngo@oracle.com>
 <6756f84c4ff92845298ce4d7e3c4f0fb20671d3d.camel@kernel.org>
 <83cd1107-2efe-f16c-2015-3da15aec12a5@oracle.com>
 <41b59c4a1359c5b0224fbe95e9fec062b6d8bdbf.camel@kernel.org>
In-Reply-To: <41b59c4a1359c5b0224fbe95e9fec062b6d8bdbf.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7766:EE_
x-ms-office365-filtering-correlation-id: 895eab78-8aa9-4615-16cf-08db9a9e52fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ShVFxaguUOOsQjidibhWqkj3tntqO2L4H9ysBn2CVw2WksXc3iPW6KYv6fH44YLBcZNkpc2LUCAxh5zrT/5hgrfsJMJWP8zZFKwCxFT7XSZeVG6OnY7PyleqG1bkZZSoSvkI5dR7rke4CU646SqAEslb6frte9B2KDXlaPnd/7nSSrIdJrOCJpueNmk+/3nguaX12YIRW2iAZOtueWtRu5GRQqspMCg3p+tmVKD8dzw4Tq13sRgUxWafViAcx0BzuLQ4rknC6FY2z99z8WeNtxUrulAVM0OQif11fYmFbDGN4qwrr/9LYRb1J3J70Qo898tqPtxhO2K2WuYBtUjz2Rrp/3b2PiCIhgVgM5zReCDPT7htWyRdacJ0TDs0zXLMmmhD2xlXUsMfKl2EC87QkOp2SKvd275wIZJuMuJ+C3NZdM0U88k7laft0auyfesAC/lub9ZFPU1exGERHkgnetUqKKJZqFvBnh2J4pw0zWpClQWhXxS70vLYdPvINZVkucI8QSHprcYIlsgsZF9zLW1I/HsxZO6v5pYMe2xRI55KzBm8sphqAZ1p8LiPgnOtsiC626x/cJNvIX53Uskgba4t1kAgp7iAYNqtlfnzUOr9j6kVfsB5+MpMIa6hc6LNfZFAnlI8xfjXFgwDCsumQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(346002)(396003)(1800799006)(186006)(451199021)(71200400001)(478600001)(6486002)(6512007)(6506007)(53546011)(38070700005)(2616005)(26005)(2906002)(4744005)(41300700001)(66946007)(64756008)(316002)(66476007)(54906003)(66556008)(76116006)(8676002)(66446008)(4326008)(5660300002)(8936002)(86362001)(91956017)(6916009)(38100700002)(122000001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i1VtgLor5RqW4hxOVkMfWSExWfWBwfhtsPNSMbPmf9JldpS3hV+yZ9xRaKet?=
 =?us-ascii?Q?MqQQApBHhVVGO43KdCrGIDO/y0rla8YmJcO4WdFg9Au1J4ak7B7lib6TNxnt?=
 =?us-ascii?Q?lvuAoVybOh6PPPKZgwYX5Y5hBYk8AFtom332IGB7QkLxFShDdczncsiNBkTv?=
 =?us-ascii?Q?UxIglBM7qnw+lED04Bb9RHNUPREKbo5JShvs8t/NN96JW9Y52YF7bfPF/iZY?=
 =?us-ascii?Q?R2IUGDAB4Xp7lCocDOp2sPjJjgStrue9EGEpxg4HtRKj8nolKuWb/Qz0V4wl?=
 =?us-ascii?Q?qHlvGRbM0JOa49o3pg2vLryMT1eETf9q+QNvsfdIvvswlIGGwiyRU/BetmZi?=
 =?us-ascii?Q?HzpxpUg6/35lfkGpe1e4pY510/j7vzjBKJaNbT0+UCRcquYBePjeFH716V7F?=
 =?us-ascii?Q?r1Jt7meDE2TL/7aweyA6Mb6buiyYAbOgzPEmvwNZSJ3rtpgu49vf0MNf2nmB?=
 =?us-ascii?Q?TitpQAdLjQ7BhH3xq/GGO1K/9fQm+iRx3LF5ZagTnVR33xDtlRJNkNtyuj4l?=
 =?us-ascii?Q?7oYqyGosTEgG16M6SLz4wBfa6zJ62+oLiPDJFTHgso2MCrsev1IlV8rtC6w0?=
 =?us-ascii?Q?H/JKkngDQmb8WUC2s1GgSPNOtIh1dfwwTRJtold88lhGTT7CREHhv6APUn6B?=
 =?us-ascii?Q?u4bR6glAcwlsNwycY7eyjqdU4ctSJIWmJsuoS1eBmi0Hbx6WUCYWWXSkWTgz?=
 =?us-ascii?Q?8EyjAHKrzG49WC32PKdsrlaiMzkeqqjA1s3suIhLIVJ4SlVOzenSZqs5TfqR?=
 =?us-ascii?Q?Wkn3O4S0Rn5XMuAsq1WN32Y7x/bhNsegtdleGoLU1wpmC9HytBT/2YMZrY1x?=
 =?us-ascii?Q?wqzLXC/57T9wWUsw1Yggdf0vIxnuz8gmX/LVYcnhShoSOhg1yV6zqXFfoykW?=
 =?us-ascii?Q?EoKv6bTSvVJLtnfelbajgjc96TW0JkNXk73pKMRYZJUTGICwZL+3+TkVQBgt?=
 =?us-ascii?Q?ZW5k59KjC4ewa8Si0V78hNbuYEX+tkjHCXqCuLqZjDGt9IEOHPdvg1tFPvcq?=
 =?us-ascii?Q?rGCEurWAO+jPnbZ9HMMuU58JIA4pXqFHJEWrcud8wtjsBsSFJMhwkcjqLbcO?=
 =?us-ascii?Q?pvoXyE08NxES4WOr0pfZqqSnN93qGIgxQ3+nhYX/7snJvqKm7PSX1AtDehXf?=
 =?us-ascii?Q?NgjsGFicy9/QWGQeY/yOawR8SY4v3XmcqFD0ZXKLjfXLTZuD/O4im4q478N5?=
 =?us-ascii?Q?wXT8CAFolSb5tpTkFjQRIukiJ1JwKv5Z4tGX8n9v3wIZnlGDDYKhzQM7i90w?=
 =?us-ascii?Q?8oPZbjkwCnHbpPu1qB/idG7+cuPcjFGQVRtWbg6Vcmx4caj+4r44+/P2EyKn?=
 =?us-ascii?Q?AEybJBJQW78/tJ0JE87Zz9XNKQ71PMISbph2CYXx/vgj87KEHvGwOS8xaIjO?=
 =?us-ascii?Q?azi1+D30LzG+buTs70Hi45F8f9SjvHEzIx70fA6MnN+p92+SifzxmhqtUc5L?=
 =?us-ascii?Q?JVmy+u0LKXvIz/WSYqPMYeAPdsUaLs6QNOzd+jWC8R68eMTHCQ5VRPIsKqp7?=
 =?us-ascii?Q?AC6DTiGKk05Pyw51LEijiZBfwvIa/rziSFat/L7AZ/mlPyaCKzn24GbDXtlJ?=
 =?us-ascii?Q?sH6RAtZvdZIjHcMbnMFglbXffB/77BaJkzGx3N1vsiqNDtjZZglEnauDJwko?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3225DFBC9298F4E929A18A109878DE2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cr3t8dTiCGQFoF4ZWrcg6gdcuaxc8cyAuQM5+5rqvNQHvwOVY/DEXB2j+Ow0nGOE1HdsVOmxQtHG6MMGhDE4p6hEameEzhHllrn+h5epvaZ4rxPeaR01MVom/Xb24DqaUP0Yj3mHjn7Uf1uL1XaP75/9AlW2nDNzlc6CEcjKTTCdBxgPmzzW5lTOT8+rAuw5gDkXPOJxqecBz+Y24a58xWyxgNZfYhpjM/vxMAUHZ1KeHGUZqxyoLMVo3j99xDV0PyA4QcYrM9DUJZd1MIMM1cOmr6WNrDWqcbZDot5SBbnmePVaC2eCvleCj8yTkbXBgQhMJqvPWVwtSrkSpqkvC5LkWi6sQnBmAo6pdHjT4owM141h19GaUxUWCd6Bofazp6772FEU64uHaOKMFQCU3Y5kPSWHtSYzUcnErMssQOzLAWaGltAntvTzvYRO6s+/EvYtrqA6hV1aT6IrVV+0fIlbWnTnhHLNQeWSO49WRvUOSMomQPmwMLXHQNnsa1DiN5Qfu1J70MCgUJhsNiI48bbQ2pMEYWWumEyJau3iwt9JgT3VUwtz53y7T1+lBGEYBptdqsintmURmByxBjAMEyBqAmkzzwOidA/iFghR6GH4nzTPuZZzg1rXRnAs4zWJMEU76JaJo6iulyOzVDQIG67bfvkWp+pHxoQDna2nLzT6aNSpY0CjMps4GGlSlAijyoWjoW0293o7ygpdLman2lseixtw7S64ylitKlzVwsYxmqTZSrAZBXYGzAR36ZMoWCwEQ/d1vncBMJdwAIMDuFaGVzB+WveRSnxKMh8Ped8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895eab78-8aa9-4615-16cf-08db9a9e52fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 19:08:19.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPUXVQTOyF7QlY+zveJO19Mue14kTWB4+H9vdRjwYwpKNmqvbxyZNDtM7eqWyZFfdvMRLk7sY0RTwydQ+as3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=779 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110175
X-Proofpoint-GUID: Qzu24MtDfrLgC83GysDKdh2RbEz2GSoj
X-Proofpoint-ORIG-GUID: Qzu24MtDfrLgC83GysDKdh2RbEz2GSoj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 11, 2023, at 3:06 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Yep. Reverting that patch seemed to fix the problem. Chuck, mind just
> dropping this patch from nfsd-next?

I can, but let's make sure that doesn't break anything else first.
Send me any test results, and I'll run some tests here too.


--
Chuck Lever


