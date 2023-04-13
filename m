Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46166E0F6A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Apr 2023 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjDMN6r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Apr 2023 09:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjDMN6l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Apr 2023 09:58:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95DF83DD;
        Thu, 13 Apr 2023 06:58:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DCxRjk023415;
        Thu, 13 Apr 2023 13:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PQVnrMmHgI89vhHDuBZfsj7BLAfQO3lNeQLz05yVwEU=;
 b=FDeS/sQNZP+yEz2bWcwzoOKpD4hPdywOulvlr6aZhdZ/CfDdyikTUXWLC2TnJETL+G1e
 N4KX8QExuy4dlN8CH8QHAOQT7IxX7eehOEzFeDCm8SvtVo2I1UnZYwDgtgLAW7QXt4Ek
 vJgLoD0L6Jg76/+Jv6ZwxRrbwTvKWQNrWX+SSKbQz/z6Hwpe5OyMfhnabv/OUFlpsYiU
 XzVIsU6ybhDAnhr9PijxZMuFjrydiytvdJeb2x0ZEqyB0yODxzkFqW53x/48a8lAyiFA
 A0LOfPlWXtmtvVO6/DPt7l1rN7V7Zs7zbQGLl3CXMzAQEDn8LUIWHlC+gpbrHDtagj9G EQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0ettvm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 13:58:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DCNILt012676;
        Thu, 13 Apr 2023 13:58:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puweat2qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 13:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX1hnhLmNaRdHDRId1yWirpZhGYYJ+3Rm2cEITS0in/aczrAGyLntaD06cSZGu0cJjU8g5GlRihhP2FXVukoWrL3RoCzVkdYhnMzzggenjlNrIeQza7tX7/FGkjucA9Lg1HXI9dPHE0nVWtBTEAZl98C3o3KBfCvU5ft0nEyAasO7apJ0TK5LXogS5jRwSRt8tdmRLktyAlVz8iDLlew2Nf4Xy2KY6cxk2tsfNaJ52PlIOuFZsaZlntRCKCeHL0a/VjAZfcIBpczGFXf9U9T75St1r/SZ9QqxUKIc/Bz7NKDDXnc2YNxNn89GxU8oKjgKE8xXEqJ6ndm8mr/hTar+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQVnrMmHgI89vhHDuBZfsj7BLAfQO3lNeQLz05yVwEU=;
 b=Y3FPbx3yQ6jcyft8VDK095UkISQ5N6xCyirTX3N7zzmYdvBK1YhzikasO3zdh3fxr4OL9jNjJtLgCju2KgHSCO7+htaBkipM3n0Y53wOZgkWA9noxHuZUDvvlxDUJvgo4CkCqVx/yKQhxLjOpBoDqI6HIwOb2GU7oS9SOxok0QqgRtbd8JZPG19Di/a7xRufmDeBZJYPrWJ+6vdOHfyeYrFkpa/UL5HnFKh8nh3LSVEC6H5hbnL1b6/LaFEavZgjpZOEJ/wm1RJEPt+izKhI8kCCF8GbwEx5lsrTYbNiUCj0n3o5oaRcoT1ZVkr4krksol4YVahEXE6YKk6iuQODLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQVnrMmHgI89vhHDuBZfsj7BLAfQO3lNeQLz05yVwEU=;
 b=nIDiG1DIoK2frIC+8E5IAmSDUbJKmg2lM5NG7yPTQ2EIUCkllLRhzjZ0Ar9d3Txb2kaEv6mKK+XL58L0f1htZc3AW2KDmols2can/UVtQRz/q9XvdXVWC35LdWbliOphFf50RqK5huIZbp7bhUKM5grgnl66yalMZYiQJhUTPcY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 13:58:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 13:58:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Howells <dhowells@redhat.com>
CC:     Scott Mayhew <smayhew@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: Fix RFC6803 encryption test
Thread-Topic: [PATCH] sunrpc: Fix RFC6803 encryption test
Thread-Index: AQHZbg8kxXVDLyEa0UeUNTJmfmNujK8pQ98A
Date:   Thu, 13 Apr 2023 13:58:26 +0000
Message-ID: <1CFEE00F-FD42-4900-9080-3E084F60FD74@oracle.com>
References: <1078410.1681393916@warthog.procyon.org.uk>
In-Reply-To: <1078410.1681393916@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4413:EE_
x-ms-office365-filtering-correlation-id: 7fea062a-8ebe-430e-071d-08db3c272790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YaPNbMmBFjoj5QNGVqXtwyigP+4jHpsA5NqeD3fmoRbNhSXlyuKKjqgDRPGIoEaiT0W8nCmhC2cvheO69jcp71K6Ita4ihefb5+UArWj0XVJ3HBTeCFpz5HhpF8Fwxk8fq4b4l32roAQfQeykaQO7vdrmnyb2XRq7R56PzNBIsllEmW2uJi6f1Q7VDKi50Tk7Uz83Re/CXjTnNo80LTlS1VxbWmP2Skahyqj8BllPRTmPuTcs43Tur78XCQG4bIC1uyCqZO7VaIfWGQwMhwVBrocU1GBuPjGMGTyLzq9ny36rfqvcc9GMUlvsqEmnBT2SVjzGA+FFMpFvKVrdZBiKu5U/Wy8MqZsiT0nm2mYzUtVyuIP14ltcvz1kKUSKxbqX5VAkubmudyNo6iiBCKwPvnW11bsJ3VoR0Hz33lMBQFdPWHFsIukCfxO+Q0dabz9CobORQ3i+J+/rx/7XctLBN/dpOh+7uSDVyTWX6bbDyE+YUXZecI35crAMNJJ2dkzq+8YHc4jHmCWoH88VAWobxLwbS+nANR+2WlF+pfGGJ82BE80o6zwf6a3zl+pel8VyshIJk9oH8PTRWCAwa53+spruC3b2jabutO3Oka4SooPtmBVTr4WSUngieqBAqWR35wEnMkOkceOnu4Jqq1yKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(316002)(38100700002)(6916009)(4326008)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(91956017)(2616005)(5660300002)(41300700001)(71200400001)(36756003)(966005)(86362001)(6486002)(54906003)(6512007)(6506007)(26005)(186003)(53546011)(38070700005)(2906002)(8676002)(8936002)(478600001)(33656002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?65MOZSLG+Q8ubm0uGNz0JoW8qCPNzAo1FyCwZBbCU8PDOBRWinkF6JZvng1P?=
 =?us-ascii?Q?hyQBys9Ebz+iY/wUN7TjK5xlm/FxXTeLca1Orsve9aitkwPsnKWxDNpt1qHm?=
 =?us-ascii?Q?t2Lct4mQBLfxlBk5uu7c48i6xciYlra2z/7lX5+sZu2PUEPPc9GGOWsIjach?=
 =?us-ascii?Q?qqfehqAo9kYrxQu5cZ4JzWeODAXE1YJjJIJeRS1LwPLeYqSSjVQRgIYmH3Is?=
 =?us-ascii?Q?braobB4esyKq9B/AT47SQE6VXT3x8CRye0HZUSIABzKdI39dls4EOOyOzuvL?=
 =?us-ascii?Q?rZE8VQTm4Nu/ig9TQ84JyyGaRwUXoInJkYLL+AN8t8L/KnLWypFTh46VSxsZ?=
 =?us-ascii?Q?UMPVQNRmDNWCM51oEL5CgCSzeYU29cq5XZ4vVbWs7eRVqG2AkecYg7zD2qER?=
 =?us-ascii?Q?COgogJC1vcKISpRBMcs59lTfjGL2+tGdTMBXwbeMyGdCkx5AJoqSZ95QUJpK?=
 =?us-ascii?Q?R8pAOKMdKrmk1PC9rZN8iMAX+aSaFoZuEEEqNXpXMzuPqyhl+LYJx3SgrAMN?=
 =?us-ascii?Q?XFaXwWKDYnsQk+wcJ8uNsDdbcolka+fQlQjT2uiJWFl+ooCv570YLUFixMcX?=
 =?us-ascii?Q?eFWEPWPfn+scZ6PKyYZAja0uaw2XvMtfnYT7Gyyfy+lmCTCWYIrQ+UAQI0WE?=
 =?us-ascii?Q?/5RQ/O2lCEK6570D2VCmXF2iE65v93jEPxyVsOfakG5EJ7IqmaLRa1M8dJK5?=
 =?us-ascii?Q?H45ohVgy58bshlkB7vYOSq0yGLVXnhi+wEkEj24yspIE1TyEbzwz8x/ZN5f6?=
 =?us-ascii?Q?L1ks2cShIs2TEVi31tWhK4dfzIsdiPkYUfoSsvPs9H3aMWdcBlQrC3bPEPkY?=
 =?us-ascii?Q?clNkGzD900MnOT/kCbPlZF0/O4N2zZ3Tai3Vxj+6YkPdeaDfdGDirLZ7rF7C?=
 =?us-ascii?Q?OUR53KEmqp6oZ5mcjjD3iFjwqrHMpUrEixaeprCNbUle2ei6INIr8P8aO0FI?=
 =?us-ascii?Q?Ma+IkRX82N44kmlRTpcdlWYQQUC2PaBsAxTNv5pS+p55/HukrRVq6Xqefo2f?=
 =?us-ascii?Q?/GxqTOreC4pxw4IbcdDuyIYSWmnzjbv4ub7cxJWh6mB47yw5VDCqOrLh5yyG?=
 =?us-ascii?Q?F7Gy3lu7a8UeWFvwmjx+z5yJ46l9oIJ/njXdfbpfdHURrq6RYWuUmxLrY/d1?=
 =?us-ascii?Q?IvQwTKq1P7yVw4OHOAX5cTSZY5VWr6cnZwsrqmsAd80kw8xy+yBqOXhH9bHy?=
 =?us-ascii?Q?nLEeOBRamGdDyiz00TE2dL2mRwBqreQKPRYLeGY9e3pLjPUOU8F2xPuml6X6?=
 =?us-ascii?Q?XxJijlQ2QDLk7NLdIOEX/Ob3Szy1PBNb/HMgsfVVdloLrJsHP5nOLuroo3um?=
 =?us-ascii?Q?kTKJ0bl1Qx23E9rR/3yvXj/JHoPQDA+kVi3D7FiqdhNJqYp5UO9/bdqQG93V?=
 =?us-ascii?Q?CtWfkKsXU4nh8e55Sxn5N3I/4vHReJRzfHxFKg/7kZA3mjL+GjKc5W0y49et?=
 =?us-ascii?Q?Jm3gyWVUUIBY/TuWUIxKe2LX3jQHAnouX4TQTIkAadA6zCXUOD0+Ng4mP+Y7?=
 =?us-ascii?Q?Mh/QUNOuRdW5nTWORcCA4bIfhEDTSPHPcDsLbgXSHvEpK96flQlCtlw268z1?=
 =?us-ascii?Q?D+kDBMwwakr9cBpUbGwnBalLP6aowW1se+AmJG+DJhbOjxSSJUhtbJS92Ilm?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADCD8F7C2C9E544E9565DDEAFF4FB879@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Io3nW26UXxf8yS2p1ktC4UGkIc/6kkLW+HkkIvsznxLSnfBDZSTz4h6Yj74ilxEcPf1XbkwWTrKh1wZ+xQEDKACCP6H7UWv2YOvn/oRmcfwRHMRuZ8Cypz/naQFKH7YRC3TS5ykDBvPpP/VUeR10zSRpq2SVOc0dF6UlIJCSQgX85H2mms4C1vMp+/2pbIeyi6yl5DPOaYYZvG4T+7/VU/kkF38kurxSn1C2GF2YpFZ0V1JLHuhDuMjV6bI4x0/QlpkAl1t0oJClIT9nxjL/gKgyc5w8JyKLzwXx6O9VHLfMDJyrQ6LYgBdEbU5CZFtpadtGTImRLMsTWQYvxGfhgJrPm09cOKhaAZL3BVgUwkVkEk8xM7aUnrwcEOMIkaCZFF6B3wtSSAFSc/b9mxior5WXrtscW3ukDNiqCTbg+0WUVYAKPK5Ft0zxiDtZeS0zBqIbH4FLussgbk71J06nHpSr8pjxvDi0hN4y5mj3nrsEeQu+j033Wkd6i4xsMNocIqBztdrUymg2phAiWP4SYGvfcN9ddbyJ5Pin8UC4VWw5idRdJb+5dCD6HVVnMWiswrx/YPdR2ceMdSRY4si8sE8S2zGOXhrKyW6I9bdlUf/xvnmP6bcWmk6u9U1eSO0eCdriUg3vZyYFcSlNuCkEMViUHOYRhefpplk4FoHq8wDePkwUIDXMTu4RMyBxUIYhZUVxXeIl+C296r4uUG6jnLRSHqE+JNrB22wfMVtFakz2JdkFx5Qq3tIQJZd24dADwtY86qP6X+0CR9LhrvL9H5J34Rdbl+IBLfelHRgUw8KhgV4Lom2eHAJZb6ShkNBhGoGk1CKEqft5oIe5MmGjzA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fea062a-8ebe-430e-071d-08db3c272790
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 13:58:26.8027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QOsRZXkPSfhsv4JCqvaBRQjYkml0ktwpoZTHfgCIn349xBzEvN5/MQrL4FFdzG2Q1tT5KIqBjnk3dmfkuiv2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_09,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130125
X-Proofpoint-GUID: dyF0HLjU2Af77YLmc31GpcNetLgwcTWf
X-Proofpoint-ORIG-GUID: dyF0HLjU2Af77YLmc31GpcNetLgwcTWf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 13, 2023, at 9:51 AM, David Howells <dhowells@redhat.com> wrote:
>=20
>=20
> The usage_data[] array in rfc6803_encrypt_case() is uninitialised, so cle=
ar
> it as it may cause the tests to fail otherwise.
>=20
> Fixes: b958cff6b27b ("SUNRPC: Add encryption KUnit tests for the RFC 6803=
 encryption types")
> Link: https://lore.kernel.org/r/380323.1681314997@warthog.procyon.org.uk/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Chuck Lever <chuck.lever@oracle.com>
> cc: Scott Mayhew <smayhew@redhat.com>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: linux-nfs@vger.kernel.org
> cc: linux-crypto@vger.kernel.org
> ---
> net/sunrpc/auth_gss/gss_krb5_test.c |    1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gs=
s_krb5_test.c
> index ce0541e32fc9..aa6ec4e858aa 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_test.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_test.c
> @@ -1327,6 +1327,7 @@ static void rfc6803_encrypt_case(struct kunit *test=
)
> if (!gk5e)
> kunit_skip(test, "Encryption type is not available");
>=20
> + memset(usage_data, 0, sizeof(usage_data));
> usage.data[3] =3D param->constant;
>=20
> Ke.len =3D gk5e->Ke_length;
>=20

Many thanks! I will apply this to nfsd-fixes.


--
Chuck Lever


