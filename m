Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE00A4D9FE4
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347577AbiCOQX0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiCOQXX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 12:23:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB956777;
        Tue, 15 Mar 2022 09:22:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFS2Rw000760;
        Tue, 15 Mar 2022 16:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8t9SojcGZkJwc9RHhlG0Ghj2oqwJdl0dTeJ0gmPDdX4=;
 b=mRSQqqbrEoc6ZM6Xi0zHOdj8SYgCKxIy97lSj56LtMuBbcMnpjOIEH3K7fNy3a2iJyLg
 yM4EnXN9drckFiuK31Rm6DeHmIbT7ZJEghQTQF0nj1kz+ULCuPm2yDfTp3MN6L2Z60BS
 UGd4QBB3VbbswFphV/8MJYfGuikzdSDwanZM4o/QcnqsAnZbfd1DvbdiOCsTHvxOdlCH
 GaQRW0aNMem7LSzI4Oerxy7n0SQGkDhZdO9Z4wokz8APkLaMc3iief27QjPrRPAvtVRE
 Zc0coFUID+Ri5SiaHkSVjw03aFGu3ANvzB3nDlATyn0oS7aldhFniyfUUlVWcheKXygA 2g== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu3ru1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:22:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FFuTwa155608;
        Tue, 15 Mar 2022 16:22:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 3et64tq6an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAI6BEp8ZXnLPHknbGNXTc4H3dED+O6G+FMxIfY1X8HP7N6+cwF9YD/j1OPvPynrMhVkPgy08L9Sy7AjrRE5WsPEbb5EWcTAl7VW6esazsyzmBC69zzbvX3xVnR/TcQZSQ5CQwGPtVTvb+nsbuYDwEqBYu+Sc8M0qpWkW3Tp4rbmx+pNnWJ8/Tf1gY1zJ6MmKRpqcEUAeB64P3cDnzb7ckyaRe/Y1w+xyEob6IBTB6L54wGRf9Qv9+h5Zi3nwKAMvmxmKJtf3HB/uAF5S0MWlKXhIk5laEK6CrnqlalqcBCE3A+hnj1riwJC1S5s+Mbn1v9qA85NqqolupE3SQKDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t9SojcGZkJwc9RHhlG0Ghj2oqwJdl0dTeJ0gmPDdX4=;
 b=dOjAZBlNblsZfVhKrWEisd7LrnMUsBe9c1ap0jrjzciKv7TuXYSNw3+zZmd4Y2YqahNy1dRlV9TjvlH9FZLwxryhxXdWY6htuUecN81lD+YP4DXK79fAe7t11FTjlS/nEPLyEp0SjWDQp2yCHwFHR/mW8ouH8Wl/PDWrU8Cyf9KMji2xC6Vh3gJaJWqgvA/luymuZcm5bTKoIiPFO2dji4npS24ZbLkf9s5JlxZEYbshOEfITNX+V6/KNi08MxAuIhisv+cy0d1yWTG2Ld+/lppC1oNiLzM/nylU+wZNzOVnhquX9AuseXCfBNuD8v6q12zDqEXhHu93d2oft98BIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t9SojcGZkJwc9RHhlG0Ghj2oqwJdl0dTeJ0gmPDdX4=;
 b=BtKAqtJJ4FtRLCKQDvnak/fTJZux0/cmIyU35jVUALqcb2MRZwzLd3Vq0UdCP1/0Ga6WDlbvRduFRphihuwV7Aozwp0sCRpZtUAHQZ+JDgThlBsRbv9yacv9JiWFHjKF0Oq/Hxt81yIJHJoLNZ2cRyV3gOViR9g5UnnX5tuNxf8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1536.namprd10.prod.outlook.com (2603:10b6:300:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 16:22:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 16:22:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <anna@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: prevent integer overflow on 32 bit systems
Thread-Topic: [PATCH v2] NFSD: prevent integer overflow on 32 bit systems
Thread-Index: AQHYOIIiG1b4nLELAUOop5poNWiQ3KzAoJWA
Date:   Tue, 15 Mar 2022 16:22:03 +0000
Message-ID: <C81665CA-D2FB-45EC-BE01-7384B567356B@oracle.com>
References: <20220315153406.GA1527@kili>
In-Reply-To: <20220315153406.GA1527@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8167c4b-faf2-4df4-4676-08da069ff08b
x-ms-traffictypediagnostic: MWHPR10MB1536:EE_
x-microsoft-antispam-prvs: <MWHPR10MB15365C68968EE4BCBD6CF52193109@MWHPR10MB1536.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5OJBCofAN3Fui7iz8kIuh3xf8wXACtf4falbZJbrXdPlJu7I6++g1FKUwaBJ5qH2RuvV+eVyx20OjZ0/ExpCKAvpu/5tgbLRWQtmpQ8YtU/fMBtlH176A6zRBn6VEk8pjiFqcr8GKWMVmm6/NPhFxeo5o2AvSjP4erSO2+btnUGvmsvmMi9zbvAYrojitsbInVPmfpzFPg5076v10ITW/HqUk9RHkjMUNxe0bYsdW5jKEesOAgBE2JibnS6DdyIsNllOhaa11/coXY6HUGyYmDW4I7DzTKA5i4sJStOb0TUnETH6YlHuxVCMx2hMsM2AA8K3VDt9k/K3pQtml06CaxBw2Ytoa2jLLHShqcn5TxBaGNFYESQXfJMyFuFz78BMm3dtc6GSwdhdhvQ2wnY/oNANGpqHN5Lo52bHis0jg2dr8MrA1pB/l/icRywIwBGi25sWBgXb5f9i14i2HQSExxmrGxFcOvo4ubVsAbpT+l8CNKAA/kEUDdT88SWIafNxULj3bISJNpE8oRthNlE5/nX6vNMTZEqaJPSQugPrjNKDad4tjjGCU6Wn/E4Rkrz9zv3Gu3RHfZ37wJG8pyZkIQX96FTBdEU8jBFYtU6K5YoWU4uy9to8/leyS1m9w2PzpimuoR7flRYD05/Yy6Lr5vJUoVCLz3TDihnEGj9eyFgspc6pGOCbpXQ/RGWffOPso436gm5Lo0XfkeK2PocZ85t2Pa3N321BIFp0hI2mRRXV1ZK3/+KrxY4l1DkuikX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(5660300002)(4744005)(76116006)(66946007)(66556008)(2616005)(54906003)(186003)(26005)(316002)(66476007)(8936002)(66446008)(64756008)(33656002)(8676002)(6916009)(86362001)(6486002)(4326008)(36756003)(6506007)(71200400001)(122000001)(91956017)(508600001)(53546011)(2906002)(38100700002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zok3DDAFn9ytzZ8i/U/zAgyE33SVCr+OTEj/yBmMSeOYqQ/Q1qXyZW7X5Q1z?=
 =?us-ascii?Q?h2wc6oKDKCRpZ5XqBGp7niyAOEIhJL7wiYIeeA4IrfgHuBiBtWxy9BH8Myen?=
 =?us-ascii?Q?rhoU7jBLbcEuYcOMhPRxkj0to5JcfMxTeSqQKnAXEoQf7d/HNyoyTw0tFzgy?=
 =?us-ascii?Q?XTrkWZkxkxlJXsuEZxIeume3hsG/XtlNpp82mvZ/ss3WPF9rjoraYVIVy5vx?=
 =?us-ascii?Q?43qUtAOBsX1eYaNDjDc8P59QnZS5GKztUJOtL3HgRuKTwA/qrDpCIAhKZLdD?=
 =?us-ascii?Q?Gr2lzcojl3b8w/wh2dVC41cbbNKJBgafz2FbWpBQGYvgx42BFNBwqGA5/Vyj?=
 =?us-ascii?Q?byItAs3rQ9lRf8pKDP5Q4u34AS04I+oamJ42fNzLeV6a31pFIGPHAeLg7Jny?=
 =?us-ascii?Q?guw7bYZJE+rCPQnInKlV3x2xpm8dRO+dd0BZNknk9TxfDeD4sDjnt5rAfVZJ?=
 =?us-ascii?Q?ljipY8OTZPWs82XCkLS0A5jabr7+7t29c7JuEZ/OQ1N39nxUnIKDY8CbdRgc?=
 =?us-ascii?Q?UFXy05uOAcadTUGnjLBEJYBdSrHTak8snAoN1qvvJGJT0lpt9CfVrjy+qpyb?=
 =?us-ascii?Q?3qjtakK0Es1wRT13nhxNyUER6VFHji/gaAB8hU1LnmbpSDFIUZWwQh+0cwb2?=
 =?us-ascii?Q?JQPNa/m6s06MIsRfkAWhRSv02I9LhGY97gmV4ag2eQiDDX4q/3SSmez8uEzI?=
 =?us-ascii?Q?MJDzvmvl8tVOjEC9q2tqxj2GFobtKt3QKgJWFtAPb2A38gFEdnwqfpbOM2vb?=
 =?us-ascii?Q?Wc9TwM5w9OyQ8aIOtdRSRdtYwOor2ho+UG+uQXEACJzX8aqyYean85qkPxOI?=
 =?us-ascii?Q?vpnC6n8bzKgUqfcoQl0e0ZnaOD3+tGJtQAWuZTQpf5EftfyXtbqee4rIQ1/i?=
 =?us-ascii?Q?dljR8EE5tLhkx+mAXcg7WiGezEkAuiBgNEjjgUmluCdC5L32l3YMqjdfVdlk?=
 =?us-ascii?Q?Ce69VX7ON9aYr4W5LApRB+L8fBRoaqt3yhHhcrhG0jWQaEwRqLn3R07AkMin?=
 =?us-ascii?Q?B1BsPQWosqxUweIARL3S4WP8d/lzDYeXbn9LcHWEwjiuqll9IFmQR0Qcq1MG?=
 =?us-ascii?Q?LR0Z/qvPwWdZq9lbc02DP5RejFz7L++z4d0XXgeeLSYwpfDW4IiHFySqpVEI?=
 =?us-ascii?Q?pvOLUJ2Yg3D/iq0D4F45RqROTYOYXP27enREUg9o0O6eATfIUV2S51+XtDrS?=
 =?us-ascii?Q?bkuC9FL2CLuTxVX96rOTXB1XKWpr8Ws+ZqcBC7Lzz/XIz4q8NMvqY9m+moTb?=
 =?us-ascii?Q?Aspq12CF5bp+Ia0RjvyJp6SGFdt5sZOLz7CONKoXRFiQnkZLBJTR17GclKY3?=
 =?us-ascii?Q?4JWgVhcHvq4UqQl1XkBUw8uhs8TOjVyvjbuKOQ5GYsBEytGmaJlWECD3/DlL?=
 =?us-ascii?Q?u0mDLbjU8DVy1DqiwHVBdKuVy5afT9/YA5omcbm8TLoeHnj+a51o85lk2fb4?=
 =?us-ascii?Q?Vk9i/LWIArJJWbIyABT5b65zNdzJQzmn3R1XvMU81LSNVLIbb6zrAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A74260340AB6F4A869A1B376FC8CAC4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8167c4b-faf2-4df4-4676-08da069ff08b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 16:22:03.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gR1cXM8dit3cXPSQL9cH1OH2c3zbk7qe9DO30gI7NzlmpiVksQ/5I3PtvwSJ1Ew1AnbyIFYyKWEwtAFbXhKVZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1536
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150102
X-Proofpoint-GUID: H6gzMVwxEpw8vO9qh65ezSqc6FF2PhM2
X-Proofpoint-ORIG-GUID: H6gzMVwxEpw8vO9qh65ezSqc6FF2PhM2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 15, 2022, at 11:34 AM, Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>=20
> On a 32 bit system, the "len * sizeof(*p)" operation can have an
> integer overflow.
>=20
> c: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Trond, this patch was To: me, but either you or I can take this.
Please let me know your preference.


> ---
> v2: add stable to the CC.  Use SIZE_MAX.
>=20
> include/linux/sunrpc/xdr.h | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index b519609af1d0..4417f667c757 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -731,6 +731,8 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr=
,
>=20
> 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
> 		return -EBADMSG;
> +	if (len > SIZE_MAX / sizeof(*p))
> +		return -EBADMSG;
> 	p =3D xdr_inline_decode(xdr, len * sizeof(*p));
> 	if (unlikely(!p))
> 		return -EBADMSG;
> --=20
> 2.20.1
>=20

--
Chuck Lever



