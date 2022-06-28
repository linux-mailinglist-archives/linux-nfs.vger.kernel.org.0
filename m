Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3455F15F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jun 2022 00:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiF1WRW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jun 2022 18:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiF1WPi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jun 2022 18:15:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28E83A1A3;
        Tue, 28 Jun 2022 15:15:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SLn8Uk016550;
        Tue, 28 Jun 2022 22:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=e41d1RcqoaNZcNRgyF75WS3CUpPTKjRa76NitT7Gr1Y=;
 b=qLAusV7wmheG5/NcOvhJrSlmymKqI+ti3zh750aolgc5OZdBEMNGQdog58bcaAYquWMZ
 wvjx5ttIBP+j4FZh1bpzQqrzaSsyKkIov0xW0YrHdtG9rQ3aR48UPOGSMqvl35XPN0wY
 yLPGzNtx40yIQQECvgHWHPxB1PVgCqcdxzCH2Bnm4mSr7EGg2TZ5QPAOsjJdMLatSVoh
 UzA3XSK4Rddg+j+u4lN4R5zfxvP56fg50nUlnP6bCkpu2RlKoba5dj05OgA5AdIMwMlp
 k+1P62ubzRGY1fwHKUpT3v605SAywBcllvGvt8Vp6b/y2qwWhjj/84zXxWV7UZtm5oy6 Zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscfdj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 22:14:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25SM4pdI016720;
        Tue, 28 Jun 2022 22:14:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt2ry1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 22:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA96Sz8AINX/pUjQEf2Xntfk/rlViWpAP/p4liqkmQgHoKNUhrm2cl4MNmLb6e2jBufpgQKz0g/Pw2aejoDHgpPP1C7ekawdtdxffVEa7JBCGOHzdwdlxrQ/PPZY8ehOBsg+4u/KEvsOcrfa/4eVbIoziGoy9vJAkp121b7mj9ThcPRzmoZjh8cohawF/0+QkZKCLlC1Ta3Env7v5jvEoztZ5/bVGJceclBgNZCAMcMqTWDBaVl/p4xZ7eNYG3W6d92hE7SKTobWpadu0K0uv/xZMTQY2KwARb/AUily53Cr6UbOsM3AJ3jh94fk+MSgFR4jKDacg5ZFhs/QsBsbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e41d1RcqoaNZcNRgyF75WS3CUpPTKjRa76NitT7Gr1Y=;
 b=CAoJ8lPUodUxNwz2O0j93G5AcmlzcG5spCKlCi9bVsc2uGTqJPqZC7T2jLcOER+s3/RI56yMD8b8ejHkKhfE75v/8LdcUEHW/m/mCGnp4fUJUUw0/iaFlhjG/I8QVrWsPEcTws5m6y0+RpF8O/n55QfEA3vcKCha9kF8+rp8fpzJxjGFmD42UMPnbhU4+Tz8gkjXi6LmAW3qBSeCI1NZnVqnvQ5uzayjjK3bYiLZ0WYGojdofDy9/Tz03u3esCKPMwYdrO+63h8bUQ6QupC5oCLwXJME+IWk0udBwAOlRsT1qwKfRw8wukvc9Pk6/PEgTBY4YNub8gC8kXc8JzZh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e41d1RcqoaNZcNRgyF75WS3CUpPTKjRa76NitT7Gr1Y=;
 b=Xq9f+d7mi/M+UJ981wx4x7AQOqvGa8Uqm+QwOjfwevZwYoaCqgrMZXJz7AiZFkIsJsdxFGxiaVcMLRXruPeKLXicNhbRTeqrOBOTrywhedrWI8+dpSvIk/DVcHXjCluWKOylLlHizckRcxNaiYOibbUKWOeS3bya5MAVPOnyWT8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN7PR10MB2449.namprd10.prod.outlook.com (2603:10b6:406:cd::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 22:14:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 22:14:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: remove redundant assignment to variable len
Thread-Topic: [PATCH] nfsd: remove redundant assignment to variable len
Thread-Index: AQHYizWZNXdLxoX3hUaViRLsHbHsZa1lYpKA
Date:   Tue, 28 Jun 2022 22:14:56 +0000
Message-ID: <75A2391D-B69B-4078-84F9-FB499A0A29B1@oracle.com>
References: <20220628212525.353730-1-colin.i.king@gmail.com>
In-Reply-To: <20220628212525.353730-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61cad3df-6182-429e-7055-08da5953a206
x-ms-traffictypediagnostic: BN7PR10MB2449:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6mNfsl/dsJY9ScXO4DPZHZmsJM/kKgfkTsyaqH9Ilv1L2fOhLdWOmM/wtLA8prDNUrIjCJpDNzKk4yR/qooDPSUZxuBPIPpxqW/I0kOBFpxxzxjIUJMuAjmy3Erc3dIW2NbjXV90AKAvKJftZ1S5FC3vinXyChVoP+FePtouWLrvhF81TxJb8T7NLP9yraR525JrzObjFu/UJlHUomkUBjBY3Xhxgw7pGKBL8kgPjWZle01wUDM+FYRa6FEVHBDyPwmp1r7FetkOibYx69/clqXnJT80hxOxNcmE+jdRMRsePrvbKqDomKk1aJCAvc+T1D7TElgRqZzJyg5dvIhn7G0GXwsIIU2TlI1MX0po7IwwC8necg6ZecBMJ5xVqKDfAED+K9cp/5Wa653ZrpdOv9iK0yOS8Y56bv0O2HPO1k/ctc97gv2+4BPchKoxEbf168Z3twPwx2IVElQ61A1Yj734czjf4a3GTt5WlyPY1TOcDwWiLqueubJz5Ys9El8xt0C22EoULXZMi8LvJIAz72QcNM+1hURayoddNQW1KQO6Giw2PS6YXH0Cx5VFRZWcjOlAuNFOVFMUq6Zj+eEeZexMR5SrNAo5hItzy4lyxXfLazwq04Y+mDlDQfJZLi1dRm5im0nyivPB/FbtYEIQV887ytmdF5ZL5VsaN7yxPsGRMHaU4yUicZIrFSTW8UPEH9KMbnwv6a0OPUJ6c6pdcKywNUemGR9bngu+YUdLB7/uRvsTXLgdoEAeITJm5G7XX3KQ2RV9iFxNY+BVXv8Id/2bB8AA//1aU07NnbvxHJIuJYOLe2ilxqJ1X4rpPIO2BlkxhmaXT9CbfkAdkJ6qiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(346002)(136003)(39860400002)(2616005)(38100700002)(4744005)(54906003)(83380400001)(316002)(122000001)(2906002)(186003)(66476007)(5660300002)(76116006)(8936002)(6916009)(66946007)(66556008)(64756008)(38070700005)(6506007)(53546011)(66446008)(4326008)(91956017)(8676002)(41300700001)(478600001)(71200400001)(6486002)(33656002)(26005)(36756003)(86362001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u8w62O5PnQ9OQ94Vpjkdrq2FlTrFREn6ArkauHVlEx+NmlkMb1To5qF1Wrse?=
 =?us-ascii?Q?sVfVniD080LH8bXX/iOAJ990yKLxi9FtnbRDxXtAt0T5o9pZtHHusYsvP4fe?=
 =?us-ascii?Q?VkpPQyD9VeRKqW0stOcnFbSztGmuYHkAu6mpyciHdCXf9J0ySNz31Zh2dFKZ?=
 =?us-ascii?Q?6cLpUJgoCFhHfcfq1prh/vCYyyx9J9cjZkUo3LTiu9jJuGNCcQvMFji/KnYV?=
 =?us-ascii?Q?jQIT4LJ3KgMa4MnvgBR7E1GjcGsRjfZnW1vgpMKo2iAmmiNTs4q057OskuXB?=
 =?us-ascii?Q?nYf5ZokHTplAVCL2ajoBqRLa4Hjj7HIRUIb/SxoX+d5j51TzV9I8v1FJYRAd?=
 =?us-ascii?Q?FX5Q9OYN9j/NWBmR6h2gAfeQXP6DlTcRrAZLu8LZ43CuaBIQZxIRlf3zZF+4?=
 =?us-ascii?Q?eedSnDrZ4je/OaLZbdb7utmc0guP2DL++ejI33NJX83g+oNT5L5bdh9qp1IE?=
 =?us-ascii?Q?7WAD5sJooxzzQdwuKcYmPXp+Bz5raV82DyK8aiz9ABqZfZ11hpTHybD2W8xE?=
 =?us-ascii?Q?WCYcSTzIcyUXe0NmdiUHKRqJ4JRKJvGWgHurdwdJoykgjBMZUj3ZfjZnC0vW?=
 =?us-ascii?Q?9goXB4H1XJS2MRNIZde0xMTTPmrSZO6oHlJbMnsNePAzrLV4k0UDCghZvxSd?=
 =?us-ascii?Q?lpiXNn69uUNv1M8fpOe8mV25+xCU0wU0URwqEzVmnjVb7eg2Bk+Zc4TB16yT?=
 =?us-ascii?Q?5fAgYUfTaydht+FSpLQw+SeiT8KLmzfN8dyKha+cBpa9fukyPGpewmzx9780?=
 =?us-ascii?Q?wIVj9Z+PAazktxi+hbX5cV27phoCOCbO5XAZ3lB9hDOr6aPADW1e3Lg2V83p?=
 =?us-ascii?Q?rzj9C7hIf7oD3Srl6gxXmlrbLBg6uiCBhbpNwMlYBOe6un5gp0SINFCvL3Rp?=
 =?us-ascii?Q?4xxQUidb7YxX83Wmh7p57Ba9cu8W9crDSxpMy6oAxmgaHWD65WT1dzPmrzbE?=
 =?us-ascii?Q?dvWpAy3gRLrFcr0PIDcPGvq202ht7PDhVDLRPnNNHAJKncHVQf0FgIXm++Fx?=
 =?us-ascii?Q?kzP6jrIpX0L5THEMspbCFC8/NGfidm32uBz/cduPlvuq0xnhfWjTjK6k+Exq?=
 =?us-ascii?Q?nNF0BFhzRPRoi3CzitYBh8U6WTBcbhFpAGbfoHAChaC+8Xvv3ZY6ekw5315Z?=
 =?us-ascii?Q?8lquGtHe+CjnuX6AhI95VEzyco/sJRgd6HCVeAH+C382ldA+hp7lBGKAvqfK?=
 =?us-ascii?Q?3yhK6Xc0yyeOKEarrZV3ILxvUbcMzmx2QUwRZfySbdJqOl6W50J5manRBEN1?=
 =?us-ascii?Q?/RaEzaTGy7lwUwcAb/cEKqAn3c0kifAbENKQOmsqM/0x7igeiF1gM4a+LOO0?=
 =?us-ascii?Q?BCLzZcLlA4lUXCX1Wt7KP2uvlMmn06q6gr97fFRS+f5YK5vWuusSW4R3V3y7?=
 =?us-ascii?Q?8P3S2mMFTW+tZG99W4XIbpfs7jfn5KEoHGU4xKhG5NVpsMCN61T89WIbnAaf?=
 =?us-ascii?Q?z4HCqckoogzLubbzqu4q0c2FkcjmD6kVwHIH2cfpIkUgmGux1zOFkAOb92RW?=
 =?us-ascii?Q?WiuT3lALhA5GQWhH3KGD4eAKsR8d4cgrQwxrUezzhOj+3rLI8MeggQuIQOwf?=
 =?us-ascii?Q?gJG/g9pOOYQd8kCFLbA96YfIdkXGnTH5e0P8NVolhkUywwXTiS5pyxttSLCe?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA108E6733CA994AB0B9824D59645F56@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cad3df-6182-429e-7055-08da5953a206
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 22:14:56.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LFzPxiNya/bIQXMQ51Lrpyg2LPljnbTkcDd6FZowPio8agrRSsJKD+xZP1STyldc3UMTf5LRMW1xaKEj28yuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2449
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-28_11:2022-06-28,2022-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206280087
X-Proofpoint-ORIG-GUID: V_b1nQiE0NJO_lCgjsR5L7PFZ9UiBRNe
X-Proofpoint-GUID: V_b1nQiE0NJO_lCgjsR5L7PFZ9UiBRNe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 28, 2022, at 5:25 PM, Colin Ian King <colin.i.king@gmail.com> wrot=
e:
>=20
> Variable len is being assigned a value zero and this is never
> read, it is being re-assigned later. The assignment is redundant
> and can be removed.
>=20
> Cleans up clang scan-build warning:
> fs/nfsd/nfsctl.c:636:2: warning: Value stored to 'len' is never read
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, applied to the NFSD for-next branch.


> ---
> fs/nfsd/nfsctl.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 0621c2faf242..66c352bf61b1 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -633,7 +633,6 @@ static ssize_t __write_versions(struct file *file, ch=
ar *buf, size_t size)
> 	}
>=20
> 	/* Now write current state into reply buffer */
> -	len =3D 0;
> 	sep =3D "";
> 	remaining =3D SIMPLE_TRANSACTION_LIMIT;
> 	for (num=3D2 ; num <=3D 4 ; num++) {
> --=20
> 2.35.3
>=20

--
Chuck Lever



