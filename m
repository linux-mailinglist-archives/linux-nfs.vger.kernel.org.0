Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F4570AE9
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiGKTsH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 15:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKTsG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 15:48:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77AA57235
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 12:48:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BIY3Om015252;
        Mon, 11 Jul 2022 19:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0koUZwod8SOsL/SAu4kD8tUoiz7fxReGO4Zhcwe6UZ0=;
 b=qXT9Jgz8jlLF5o3/LXJOc362rA7J11iFFcvj6HlzobSxjto7/t7fn6fQn3tWNt3RToAO
 +dzSSc4nImjPZFVqx6Saa1J8AATEKOhOgGOC5ud1kbUjziTSm7FVTkw0qAwhOEoO63qR
 md7LGkfmK+sdMSKVllMxGGQ7iRv6eJ5irGTPVs0OLHS1cQLDL94Jcks0tUpxaJ6OmHH4
 ExnTJNCHcsgYxRaxegM5Gkbjj7Shxg6mxKNmi28eiwkcq49qXoVxPdtxjojlp4TT1vCp
 xM3p0o1HQlERaZBPJRsT8HrKlwXDi98yItRaqZPTr9y94gJU9ZZW/g/NeZKLrmbFuWsH Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc4kps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 19:47:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BJb6U1003433;
        Mon, 11 Jul 2022 19:47:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7042fmfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 19:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+drtouM6tJvTpxZo7KCq9D3wU6CSC4XhaUZ/bnVn2nryfE9/j5KRv+9xhnnhS6zbfPtey42C9lsav1z4AI4c7BK6UMPV3vu+a7dD2QMkeECG7TgNSPvYkSZ2c/g3EqmhDu/eNkbG8/fs9pmmatl6dahpZzG+yiTUj/zcU7l2+D6kMKCQ0bvk/IwVQznyEZS5HwKq63EvgzPcK6lIZAc+XM9UaZqVs5RDsAPoUKbquERMrfIjNZGvxPJyZW/HBqXGlD4ypyYLPXlRlv/fEj6O/U2NOwjNw+yU2+xTP+jZLR/SUU47xL9BWFsj2qFOHQvbvanKqUsgi/8lQA0+hJ0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0koUZwod8SOsL/SAu4kD8tUoiz7fxReGO4Zhcwe6UZ0=;
 b=L23yeM+51HjOtBITdBFzzdP2MCWmhZT0Dtgf9U0X3u7AuvhSYOrYZQXC6vqC8AgXK1wIN1rVR6JVoea9c8ZcAuuz7jerPyoyTGld0H6rrXcdkoH8RygJs9Mol/57jc8Sqwtu7fmBnBFsE+LQsY4qMASAQdhmJ4zvlXYjDZYhvFK0K8wKZY/fegWoE/NLgHmU/aib+pcsGh2HaFUG5Cchl4A33DrBqMgkX22miCvqFMRBYEEjad5bzD8KJV4ZuvDR1c8O/HTsVTCOasgvIqvFBpydQOOfOK4cySdnwJ9u22ieJrrY3NnXUGHMyTeQdcfLMX668AcxHNB+cfv9wjonSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0koUZwod8SOsL/SAu4kD8tUoiz7fxReGO4Zhcwe6UZ0=;
 b=qypyFjjinXBUUR9rrj6vUppUNOmFW/1LsAMBxblvEfLdsvVOzmYSPBYh51gDZg52JvrhfgKxJ/xGyCA8WaC76HcN109K/cYZxd07bR7u5H+zNjFXY4V4t5PzIIfJxKHzlVapCVtEg6N98xeo8EBKexn9BXPtxph1DLEjkSZlZJ4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR1001MB2379.namprd10.prod.outlook.com (2603:10b6:4:30::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 11 Jul
 2022 19:47:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 19:47:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>
Subject: Re: [PATCH 0/2] lockd: fix hang on shutdown when there are active
 locks
Thread-Topic: [PATCH 0/2] lockd: fix hang on shutdown when there are active
 locks
Thread-Index: AQHYlVRHs4Srxdi+TEupsHx0CAQu7q15k5IA
Date:   Mon, 11 Jul 2022 19:47:57 +0000
Message-ID: <EE221E7E-8FEB-459A-86BC-B21AB4D662C8@oracle.com>
References: <20220711183014.15161-1-jlayton@kernel.org>
In-Reply-To: <20220711183014.15161-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68b9ce0b-7e7c-4316-f97b-08da63764107
x-ms-traffictypediagnostic: DM5PR1001MB2379:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6boYtgwMbbzJKQHWjIcL8wcEB4Mq80jjR+OnbEyl6qTt6DzFCe1ezWOyaacBeuuFgP6qOOCaXb5alDdSDPFJEhPn0zN4I14IkBM8QCuOcWsPqsPXaHO0RM6v7mar40+PVKjOzmpoEfkSwSti/AxHamnwWyD9xDptWSpOUAaNlvZ3RgN7Dc72EPm2N2vBJ+1PG3t4mJhbieRDWnRpQSVKQj+5abk4jvyTWhfmvKEdFaZSduCCKdlmDHJgU1xvF52wKdWGfgTmrprIOJ+HxUCbfnPUmZuxctuuNXIiCpM/RP2hm1u1EMpssX5vO9g4E6aYF8piY+QGH6EZkns5VzGs1GhDQSBfYSMeHdKdOQouI931+VEeKWUiwBoO3hjbCg9cELcRipAElD9kM9P+3iAGWW+Y8GU2RoDyP2uHthxGE9yjpBKeVUrCQebK+9kdTjXx3X2VbYL4Z/YjaWUdNN+RtuHGZNlMMpiIu42pMKW7YshWgMH0WGopfnse+1S3CYhgQoWxiUyolNxOW8grx6vMb092opRKI9kJyOBynFWYIT/5UZ8QMSw6pazUl2kRa5hAN375uLXlTHPofHnfPbmE3w8P+iwth4a/sLqdT148nYQaC1JMYCcHJDjETKe2W3lgDFKF9+dW0Fh9KjheniLrAi646SnH/2G/FuJ2Wr8zw4fbvH0K+oyc5FcysUNJvPWqFdNnvSRRePrDYkk4wbEcLWGJspMqURmfz14G7qq4+zU5EMi8OJ4Cw0DwE+IBNKdo609O1XUplJc1SQA26Cdyhu7kjm3lya+gAnWKrlYAGqurjT1snZCdgQbELnqL1/0q5UYjQUW5m1RlcVyLtgqYXVuLtsOhssvzk0goKpd7Vu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(136003)(366004)(39860400002)(83380400001)(6512007)(38100700002)(86362001)(186003)(26005)(122000001)(41300700001)(38070700005)(66556008)(33656002)(6506007)(66446008)(478600001)(6486002)(91956017)(53546011)(66476007)(316002)(64756008)(66946007)(36756003)(8936002)(2616005)(4744005)(8676002)(5660300002)(4326008)(2906002)(71200400001)(54906003)(6916009)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kcirRV4GzlHkKuAD1DHpNgIFSgbx+aLKRcpQT7kvUuRsW8j0BT0/HfmXubnn?=
 =?us-ascii?Q?XrZbkgps+jjn8+2NZ9fQt7J34t6yMIdneIbW3FaLtCpqkTLSwPTjpmx+0SJb?=
 =?us-ascii?Q?ggeKrn/pSu7hu1VTTyPh7fGeEOkuzjnjJRDQ7A0eKV/Xa0IKqae8Pi/BjzM3?=
 =?us-ascii?Q?pH9B2bD4OHDQi4cvxaHBVHrLsvpEJV1ucV4XzeoQriPb6RGVaqm0ea8NZ2e5?=
 =?us-ascii?Q?9+DzOCo8QPVeNEwlFKrmGlJe341D78IRQ1pOqGga/EqMgVVgWmITecQChQQy?=
 =?us-ascii?Q?1uSbrOjoEyAFMdSCSIStluTwQfOOgPd6k1rLq1sjCdyn4UMIwfOIibp/0gV9?=
 =?us-ascii?Q?BC0REjB2sRNn/wv/Ry+pUWsNRmvS/9hoXNUmAuO4qnNAiCFKrP0AJeFvgee+?=
 =?us-ascii?Q?6nIaTYyTr0L1lcH7XbG2Nrc6opl71JJk/OO6gGtvLItYCci9sFejQBV/84Fd?=
 =?us-ascii?Q?727XF8uSon9lF1jz6yJDrnL1L5VvMqjXFkr5q62j4uAj6MuaPeytCwOr08q1?=
 =?us-ascii?Q?Yi+sNhR86ClagneosvX+FBtH1q//lExBARhmH+fnQavMtS2M3293UaCTtmI9?=
 =?us-ascii?Q?3DsgSWf0TXxcPLPV9HeDWpcql5paIoy3GZcU0a9wB29DSYa9+8i8emjQ13V0?=
 =?us-ascii?Q?0EEWpGvBPJDMZRUhqLKKtk3IWpumTC8EuNOxMYeXUJtwfBSf/RkUdonasXrz?=
 =?us-ascii?Q?y053eEuXtsYV5u9UQnrhsKbXGn1c0OqrgqSr12osxAiGP0WxW8pzRD26V8Hz?=
 =?us-ascii?Q?3edRhvlZCAZZnj9BpOoEfUZ7Ujga1ja/ed08xP/MiU8GY4Vfw/efUhMNFaJH?=
 =?us-ascii?Q?0ldhSUpV1nZlCnXPurZ7YLYQCKGXNDSnWwv70iRXnSFLrw0XXTilDd5wS1u2?=
 =?us-ascii?Q?IfXaGNON+wpOMMPEX+/7m/ks4ZV7O3RY2VErNr/BJPpnEIOqcDem26MgN4VG?=
 =?us-ascii?Q?7Q1UxieLUFxd53XaOCuJ4fDfnX/LN9zanr7NjbEqAFgmr5k7c5mRBwAnqpIh?=
 =?us-ascii?Q?1lfqsHITZEWesll81a2C4eD2xC12VavoBJL26I+TpZDuJpzhB+gtLfuPs3ia?=
 =?us-ascii?Q?eTbddbuF0bw9Nnf5ZUMEvfoTp2b7yePIqEkbOuJRDHYHNurIvTZQXNtvV1Ow?=
 =?us-ascii?Q?T4TVnceG8JxCQuXQII5qVv3O2KG7wGN6BMv7YrAYWE0arqP7hTlJUpHmng0A?=
 =?us-ascii?Q?l8HvPpYHDi2vRVx2QAGq39FT2Jj3vryBxyDbNYbIaRNF0UoZuxbHFwvrSjvu?=
 =?us-ascii?Q?ZU3IqYW805oE77hQmbGstoC5vHb6iqzcZNg/2IxyCiOAPLahrTGUROV6gdiX?=
 =?us-ascii?Q?fD2/7gXcw9h2DzbjvTQb0CgxxueKR6yDa3keFZYAebarY9b6vctSpzHyHClx?=
 =?us-ascii?Q?95jGc9wrRgFUtN1wLbK5Md1scR0DxvGfg23c1psCFAm/OaKVYBHt1Pi7VMs8?=
 =?us-ascii?Q?AwD95xFS7beM4LOiPxiZa75JzLriSIg3hPQi0WyVJQPYtOwoX1l8n1gbsl53?=
 =?us-ascii?Q?YbQkR6qFV/OMjky5CWR8Oz1Fit1N5b6zWU36AeBeJC6ZxlxmHcJ6TKPC9OlY?=
 =?us-ascii?Q?5ZBhXmHEZX19NFth66V2HCFQsl7WD9XjHeBAs4sxgQ4je355YERb4vXb2SSj?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1096FE89ED66440BBFE70AADFD7A4EA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b9ce0b-7e7c-4316-f97b-08da63764107
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 19:47:57.4054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLK0oRjlqR2lKNTLHJIrO8jvdIOpF+oNSEyra0JouafqupP4BkdB79JDwcmpWS+17lM+2MozeKnaFsvu/0r1nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2379
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_24:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=994 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110082
X-Proofpoint-GUID: qx3Pa-WYyEZJG-9vDrHpjc69fY8kkEdv
X-Proofpoint-ORIG-GUID: qx3Pa-WYyEZJG-9vDrHpjc69fY8kkEdv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2022, at 2:30 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> We had a report that shutting down nfsd would hang when there were
> active NFSv3 locks. The first patch fixes that.  While testing that I
> hit a crash in nlm_close_files. The second patch fixes that one.
>=20
> Jeff Layton (2):
>  lockd: set fl_owner when unlocking files
>  lockd: fix nlm_close_files
>=20
> fs/lockd/svcsubs.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

Grabbed both for the next 5.18-rc PR.

--
Chuck Lever



