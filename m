Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828F76D988C
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbjDFNss (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 09:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbjDFNsg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 09:48:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B79AB
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 06:48:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3366wcvG002657;
        Thu, 6 Apr 2023 13:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LrW/umWE2CSWXh0qZqPXd3ZmFNv+kEbwmbvUT+p91cg=;
 b=Ch/mJQEfy1eai/VcYQphRPtKOdv9qepf2XO4rQPEdLTXLM+ptIKMVM8yd41ULQBbMLWO
 xHEGtg21Rly9/wQrRi1JLUI78pr/GGyyugtzFyOqs3wES4R8hL7IIn3v2VDnSed6Vn9H
 6wxft8cKG3opLRN5/DgRs5GKh0s52uxyIGjSZawI0WwSFGKPR4ySBNmBD/8Mqi2UZc5j
 POHjJq7eopwPNOaNMRRZENlqA4zGml0vOr7dYxK51Ea8B5tAx26qBZ2pI2UVTaBlzYNb
 ci+EppBBlSaBlJX9ZjF0JusEiERhbFsJMpM8nFH63zykSrUPV8q2A05vOtu4eMp+Tn0F pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgatv36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 13:48:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336DVarg036535;
        Thu, 6 Apr 2023 13:48:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptpa8hxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 13:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7GQX2Nab5ddwhQE3LmZ/zyFJr//4ql+Iyl7JtIQgp5FmxtBVASvGw+AmX6JT1dkoB1Yt85ILLBhZ3oAfHar9mZBvdysA9lYmwc9PztcJ4XG2GXPncLQ3KaUrwjudLRoj1rWJrAKUVMqU0Zn3/rnvRnrQT9dm8+8h850RWlt4o+Wudyj6AFecMpOVu7IZyePjMbHnG9gak5w+u7gcMw1MGicTCrwZm7qlbW+f227QT5ZvdmYejmkHvBu/Sz6kg2eEdfRuVaTgr1jHwNLHTv+vdJpeq39FFazQJEVS7zKGfnHNtcgY3qZZiPOcfVQmXwqNvHHhks0UcHs9z0bYOGIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrW/umWE2CSWXh0qZqPXd3ZmFNv+kEbwmbvUT+p91cg=;
 b=C88zp4HBk82MDvVeO02QkUb4O/SZ9yoUG/ypfedHSHE25yD5BfvzBMo0iTuwWW0/YDVaPlg0+oMB61gT/WN7jr+ulPQQ+wn20tMmxdq2IPiHlbwm8LmbZ5ObljcG9h7p7G4EzQBjdq/5ABm5wXb94p7B9R0YYp7vyZ5mR4Y2m6C8hXbMcKtHd+l2qoniLhA8AojQjTDuabf2qS8/wTBEEs1kpYi9UTbnuBzuCeQ8QE8Z6gVgX3au6MYiqVykqZXTpqB/w31kMNbAMeSwbKCRqchOGrwo5HcYO9DNY/s+NLQbGMi/OdnxoYiPytroRJSIe1kAUl0ZQ5fara3NUXAJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrW/umWE2CSWXh0qZqPXd3ZmFNv+kEbwmbvUT+p91cg=;
 b=T84VbFBm5FJdztXnoMx5tVFBI1O4oS22T7dKCbc6GobiZJZDZpXj6sesf8g6BUV+RoBeaC61vYrhncjgZsUm/nb1ScYxfg9ulCgOZ25yQQnj84feXkgBlSSYIVlHykSlDXcxDg80WQbgjq4VCpgJCCM0lueXk0doM1TZ0+J7oyo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5017.namprd10.prod.outlook.com (2603:10b6:610:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Thu, 6 Apr
 2023 13:48:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 13:48:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Herzog <herzog@phys.ethz.ch>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: file server freezes with all nfsds stuck in D state after upgrade
 to Debian bookworm
Thread-Topic: file server freezes with all nfsds stuck in D state after
 upgrade to Debian bookworm
Thread-Index: AQHZaHlTRrbt4X56/UeV6X78Hvk59K8eS9UA
Date:   Thu, 6 Apr 2023 13:48:06 +0000
Message-ID: <6785EFE7-2CE1-45CD-8643-C40CCCDADEB8@oracle.com>
References: <ZC6oX7FxdJd86rF7@phys.ethz.ch>
In-Reply-To: <ZC6oX7FxdJd86rF7@phys.ethz.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5017:EE_
x-ms-office365-filtering-correlation-id: 794adf4e-63d2-4573-ff56-08db36a58d08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NGvFuEXRUCYP6FX2Vo3OeVxGX0vOM2xVgLcDq35qWzNy/2Mr8C1cFX2kV+Z6Q0r2S0HChxRV3TfcsZ0bmmDkQWd1yOIstDRJwmO1T1UDp6nLK9tXXZsEPl0vbwrahBQAkvVuKdjRMv5u8t1LNms10wyCrBOgiCjpbchmQWTbCk3NxApWPMR+kEUCJeXHSuiO5sGmxAkcsFsRxVT7IBqC0g0kWd2aTitZAUBuwaZTFr1RpxUNQbTH5cGCrG6WDBjvNnlrUXLcrG1KTzhZvGrB0wezM34m3Knk6AivqHDOzQkXzDfwGxqkrK0kID/tdCuZ/WjTWpEdl3mIlGieUy+wmKVC00V51Da2z2B1KPbBvAcfS8LIpDn4SW1WlRvQCtRjsQaC65Cdqlw1hdEY7Y5xmeyCY/nwP4j8L9IKIZCDnJEicJHqIxE+AnpCmEM8Pw/JFlQbNzGwZ34HW2sPFW9p3olk8KXATX1AmLa0u1JWMVqDE7FMieH7KTy2Ya78YOWgQwM4FIb1i7+TztsQ8Js5uptfnQGTuoOCsgw/0ut/6dG2Wq+zTXc9JTy7NediQtXI+4omrTE3LQS5HJEOfDrKOUGS/cwxCjyk4CTLwIkPBlqM2h1KFlMjbtiwqux9tpvh/9n7pQhcDIS1kaYdhpJe5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(38100700002)(5660300002)(64756008)(66556008)(122000001)(186003)(86362001)(71200400001)(83380400001)(478600001)(316002)(2616005)(6486002)(6506007)(26005)(966005)(53546011)(6512007)(33656002)(66946007)(38070700005)(6916009)(41300700001)(8676002)(91956017)(36756003)(4326008)(8936002)(66476007)(76116006)(66446008)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HL4/ULJf5Vtr8nHriksfp7LUcJIHnmC/KBu3dVPN+sFJpOxNMg14GOuZYFjF?=
 =?us-ascii?Q?rX+PFqX7HsuxuxowEP8cuA+vrPGnZopLsVyyglK4xupkI4AzF0VaxrjMB9Cn?=
 =?us-ascii?Q?c9MNANT3H9RG/sKu5IEOiBIZqsmTVmyzsZZqKX2vNmVZCulo383XAAM79CwY?=
 =?us-ascii?Q?gcSGuH93gOS9uB1fuW91voLijGELb79ICf6veI9sSqjehkxuLe1ZOASldrN2?=
 =?us-ascii?Q?hkcceGa17i4H4WQ6nWEDK9jhNf2C08Nmx73ArsAobCQtMvfeXnmLYAGJm+ki?=
 =?us-ascii?Q?OBLzxKUoNRsrZhtJpW/UwCT5QMXfKkIO3sE8mOfJjkPrKE3N6962IWFIGU2g?=
 =?us-ascii?Q?gMJqqqqYmucSzLUUHAbczvX43lj6FeKUdIsThaGHf/6AMZ7+GkVDsrBtUfOO?=
 =?us-ascii?Q?wkdI8SatjOsx0Fp/4GZzt0whu6nIbltXaO+Ng1bs4dJM8Rp2WUUOiTMwopHc?=
 =?us-ascii?Q?Y94st73n6gri205h+cG7d5vEeMfHXwnkZxyBMfKbHbZHbSmC2QEX7HmS3QAw?=
 =?us-ascii?Q?YNuHRApsY5JaB171ucpT15Ahk5Ny7PsQ4RgoR6jNbC1Y2BqwZjBX7TjPJm4M?=
 =?us-ascii?Q?2SgKeGckX2PAdDbXSUyzwIg7bC/mzUS9S+rrBg64+2QxcdI2chLMB+Gt0si9?=
 =?us-ascii?Q?T20A8qFVLepmA4Fd7zHJ5WXQwQdcfn1cGakx5ZlwfIyIlZ8W3Hpws9eqpeG1?=
 =?us-ascii?Q?/XcQyOmWX/BMQWabxEtV2zX3wzrzBTBf2uPrLDega6aEZX/ZG+11/E0jTlcJ?=
 =?us-ascii?Q?ys+pIxl0xlrJUwlubP7h4Ssl+8ezgjfuwP9ynbDq8fEfjMnBfc9embMcBXWY?=
 =?us-ascii?Q?H4fV1zOy9cizzamOR15bczbkydNd7uhFLY8up4hOr6MHOTqoe2je/nXEnj4c?=
 =?us-ascii?Q?wIP8FRMS5E3yzcVkFOSWI3TTItY0LXg6gz9w49Y4p8cIg2eYpRCBKFTslBAm?=
 =?us-ascii?Q?m6NsU4u93G2IYZfELgwDe/qBP26mHIDRXqAZMJl0NZVXVBtCkIrm0VkghBCI?=
 =?us-ascii?Q?0SSLODcwNPH0cd7qQQPQ2o1fjm9lDlLjgUHg+TAL2qSf2iWbpgc6T3hCBiTa?=
 =?us-ascii?Q?IUNuFe2QaNzCy1Cne9UC5WruTiRBLUuXuLQr0Gj4LjX3nV9ccGKcpnedROUb?=
 =?us-ascii?Q?DzKE5I54vipjDuic44ri0yAvgfAS8HjqkKWkN7Htv9Bf2hSfGMOumV+0+7ay?=
 =?us-ascii?Q?hOTxIOqXOzCYuFjR123PwYEzBQPOCe0DKfNIo8AyBlWy48iv5WYlkJGdiX6I?=
 =?us-ascii?Q?PW7BljqnEwerhzRzKDCeC7XIKrW+37JM0LUem4NtUtXvhqfZg0vd1bbRWYqf?=
 =?us-ascii?Q?jgIgkcwCerW3sEsq1CvrH3UOsYs6S0t9d+YWKmLA0cdUbcnDZz/3+5/DkhJu?=
 =?us-ascii?Q?le11gV7nMIBAoBZhCuLiCMP0mRCgiebOdXDw2hNcOEkOc9Jo2jPRm/OLUcFP?=
 =?us-ascii?Q?OVqNBDz8WLRuQEhewj5VeasS4/xCzbMHZkFEeL6FQvStaxAmsf3i+Dj4J/GT?=
 =?us-ascii?Q?31TB9UF24WN1GUyOi520ZDZOYrh8VtLQGPeyKGTkCa0OAv0sT6Hdn08QkI5l?=
 =?us-ascii?Q?x7yKciqEc8DrY708Dq6rwWribGG9U+x+noYvZxUm9nzKzFMfQIMVcbazq9KP?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3002A49D05A4924B91CFD85FEBF554DC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: luhkofSu4pFJeP3SpO8cKWuto6YUEKqSlKsA2Hc2Ij8RwcPXWUpZ8d1NZER8/d88SXiMYRhJt0WrA5EHDC9eA4e0WebKfmXB/3C/52qMp9b95BHlbyaNIIGrSjq2yQUftOd/2DX5fOa9UCJQnMyxwyofP00rAz41woOgJj3MbUypWRauVomUsYoshePt/SWe1NLLiGaCLTLKb5AQARm7DR148GUmWKRZzRxVhkUPwBM2RdY6ML2ERB0qWdi5hKpWJD1Xxm2KTZCNhkUMYhSwmC0XQ1Lme17V8U26uO1dRHKFGvYXw0QP/1/hMIclIr5LSaRfU28yQQMcCLr7H3OjP5VRRqbjL5LRWkl+gtUJq7w1jleru7RjSrus1ss6LaoO4Mc+UGDGcy8adDFzmeTs2RRn4yrCks0451rTtoUHP8BBuAFgtZs9o65GUWX0uZr9DMYH5mKXADHYtdl/JGzSk9Zaoae0QsebUOoIU80gmYSe0jNYAKpFvDgvaJZPC5VBzxtwI85LBEgmuEYssrqL44EcG5Yi9vJ/4Rc//qu1/egy+eM2niWMFtdoO908q1ORXjBeqkAcu6GDncASAeRtOzo5Y5SRsIoWDTDYYwOeLtsTvdat3tYo3jotmmvAejDUvQv+JnLEq3IbS0s31PZEWWLN3nysdg4cxLdGHHw3UZB/RFyTC991/et1Q6QXbZOI4W6wamIqfxf3fEvv1PakeaIyyZ7q46j4gfB4u+Gjg2AjlYQZA3FxmOM98M6qnMat/oFHf7kV4wnhMtpmg0unO0h7w1cX7/ZO1GS6Rzdfqyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794adf4e-63d2-4573-ff56-08db36a58d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 13:48:06.6343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iPMQQsPJKuXyLFojFZSWEcIfZGhXGaV9UgRqDuz/YGer2Fh3UvGuXpy/sBeur58itLmF3feOswEwWdvbfMSilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_07,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060122
X-Proofpoint-GUID: sZjZqi8ZgzxqsQSVrcseT9KFYUeyIUNF
X-Proofpoint-ORIG-GUID: sZjZqi8ZgzxqsQSVrcseT9KFYUeyIUNF
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 6, 2023, at 7:09 AM, Christian Herzog <herzog@phys.ethz.ch> wrote:
>=20
> Dear all,
>=20
> for our researchers we are running file servers in the hundreds-of-TiB to
> low-PiB range that export via NFS and SMB. Storage is iSCSI-over-Infiniba=
nd
> LUNs LVM'ed into individual XFS file systems. With Ubuntu 18.04 nearing E=
OL,
> we prepared an upgrade to Debian bookworm and tests went well. About a we=
ek
> after one of the upgrades, we ran into the first occurence of our problem=
: all
> of a sudden, all nfsds enter the D state and are not recoverable. However=
, the
> underlying file systems seem fine and can be read and written to. The onl=
y way
> out appears to be to reboot the server. The only clues are the frozen nfs=
ds
> and strack traces like
>=20
> [<0>] rq_qos_wait+0xbc/0x130
> [<0>] wbt_wait+0xa2/0x110

Hi Christian, you have a pretty deep storage stack!
rq_qos_wait is a few layers below NFSD. Jens Axboe
and linux-block are the folks who maintain that.


> [<0>] __rq_qos_throttle+0x20/0x40
> [<0>] blk_mq_submit_bio+0x2d3/0x580
> [<0>] submit_bio_noacct_nocheck+0xf7/0x2c0
> [<0>] iomap_submit_ioend+0x4b/0x80
> [<0>] iomap_do_writepage+0x4b4/0x820
> [<0>] write_cache_pages+0x180/0x4c0
> [<0>] iomap_writepages+0x1c/0x40
> [<0>] xfs_vm_writepages+0x79/0xb0 [xfs]
> [<0>] do_writepages+0xbd/0x1c0
> [<0>] filemap_fdatawrite_wbc+0x5f/0x80
> [<0>] __filemap_fdatawrite_range+0x58/0x80
> [<0>] file_write_and_wait_range+0x41/0x90
> [<0>] xfs_file_fsync+0x5a/0x2a0 [xfs]
> [<0>] nfsd_commit+0x93/0x190 [nfsd]
> [<0>] nfsd4_commit+0x5e/0x90 [nfsd]
> [<0>] nfsd4_proc_compound+0x352/0x660 [nfsd]
> [<0>] nfsd_dispatch+0x167/0x280 [nfsd]
> [<0>] svc_process_common+0x286/0x5e0 [sunrpc]
> [<0>] svc_process+0xad/0x100 [sunrpc]
> [<0>] nfsd+0xd5/0x190 [nfsd]
> [<0>] kthread+0xe6/0x110
> [<0>] ret_from_fork+0x1f/0x30
>=20
> (we've also seen nfsd3). It's very sporadic, we have no idea what's trigg=
ering
> it and it has now happened 4 times on one server and once on a second.
> Needless to say, these are production systems, so we have a window of a f=
ew
> minutes for debugging before people start yelling. We've thrown everythin=
g we
> could at our test setup but so far haven't been able to trigger it.
> Any pointers would be highly appreciated.
>=20
>=20
> thanks and best regards,
> -Christian
>=20
>=20
>=20
> cat /etc/os-release=20
> PRETTY_NAME=3D"Debian GNU/Linux 12 (bookworm)"
>=20
> uname -vr
> 6.1.0-7-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.20-1 (2023-03-19)
>=20
> apt list --installed '*nfs*'
> libnfsidmap1/testing,now 1:2.6.2-4 amd64 [installed,automatic]
> nfs-common/testing,now 1:2.6.2-4 amd64 [installed]
> nfs-kernel-server/testing,now 1:2.6.2-4 amd64 [installed]
>=20
> nfsconf -d
> [exportd]
> debug =3D all
> [exportfs]
> debug =3D all
> [general]
> pipefs-directory =3D /run/rpc_pipefs
> [lockd]
> port =3D 32769
> udp-port =3D 32769
> [mountd]
> debug =3D all
> manage-gids =3D True
> port =3D 892
> [nfsd]
> debug =3D all
> port =3D 2049
> threads =3D 48
> [nfsdcld]
> debug =3D all
> [nfsdcltrack]
> debug =3D all
> [sm-notify]
> debug =3D all
> outgoing-port =3D 846
> [statd]
> debug =3D all
> outgoing-port =3D 2020
> port =3D 662
>=20
>=20
>=20
> --=20
> Dr. Christian Herzog <herzog@phys.ethz.ch>  support: +41 44 633 26 68
> Head, IT Services Group, HPT H 8              voice: +41 44 633 39 50
> Department of Physics, ETH Zurich          =20
> 8093 Zurich, Switzerland                     http://isg.phys.ethz.ch/

--
Chuck Lever


