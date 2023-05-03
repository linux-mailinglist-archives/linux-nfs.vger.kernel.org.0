Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD806F597F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 May 2023 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjECOF5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 May 2023 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjECOF4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 May 2023 10:05:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD7C3C3C
        for <linux-nfs@vger.kernel.org>; Wed,  3 May 2023 07:05:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3436u2tH031814;
        Wed, 3 May 2023 14:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GyqfTMU6l+eH2fcpaEfVStyc26bC/u9uS3t2epJfxhc=;
 b=mLf/ycLTyNvDoPEmlTzO1frS+u4r3M5KA9uoY/oD8AHRcKvOME6V+L2A5qttoxw8qkrF
 QAzc4S4jc3iMtfQZnKknBg0OaoBZgR//ZOQZWo19b2hzTmeLYGSPiP68VwNplO2cStbQ
 4mvljNeX5lS9oMuErDZxAS6Vaz9KLwW6L8CZWHA2BS3YF2S2aoUIVrDGeIu3MZ9zViPp
 fXaIjHrQuDNxH/LynQX/pPHBsbjKIruZZqJ3xRZ9I/tGnsjldQdR8Ur74RNUwG3iHJh1
 BeKuEKL8kARBkUBmHIriSZasyX8TX6ZeBNlqfaWBD84ETbOPNPtTP0cMKcSsOl0HqoqM Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4aqbfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 14:05:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343E5kds024982;
        Wed, 3 May 2023 14:05:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7dapq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 14:05:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbtLKCvdNeoFr+DJQIIjG0WvWn+zlq2pl8NdcHkV0ZhEvapNqFtEDG59Ifm5CvXHtMem2v/ZE2VXeEu8Hrs/2auwYhPOHtywvfXSmXNLuOKZaVTneghRLqwL7nMe4+ch86l0588PHdOHiBjbDWr4gvHHAm2bJ7VQZgSIzE23OQ2/leMNdzmWQLD70teL3shzzk13xwy42RgGpqeatPpILOzH7Q2cdfCmwqYgwUbC4Jay5hFC0T/QhRRIWYWroOOJO6HgFq3pFO/PIBeTOUTS+2YQNh450fKvTrPy5blUiKRXdDBTf9kwdtGHkWZ8sscopObs+VdQmSxWui9xeFlD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyqfTMU6l+eH2fcpaEfVStyc26bC/u9uS3t2epJfxhc=;
 b=ULGbjEldvoXDGROdN8TNFSqdfnHpcT71rra4QF8PHeSZXvZu3F/e1xYzn3Xesb+kCzRixzJv7bxx725BoYTmz9SY7rWJQchsZAZtn5WiPZ4DzPcqn9igrHJxr10zzNCm562LOcW9dVjts8hzUZLf/be6YqEi6j/wjphFFdlQFHO6cVyWqtaFLRcz0X0eORXkgsWmsMmGNKnZ/wqMxpejz3HvdbxDkYgXFB6+Ht5QrzmpzGBe8RznAFO5ayY1SO4hyboDoN9RjGV9oWR6El2Tk3TZYr+hooUxXMRj6n9Wfw+6OYYCAkxGpY9mIVawCiOQQf5HzhyJOG6oymW0pRpNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyqfTMU6l+eH2fcpaEfVStyc26bC/u9uS3t2epJfxhc=;
 b=fw+1OKByteR78xHpxGCGXSARpoCnh0hOju7myzhGQ0UkmjuHDFZzokNvAiqXeD3K7BZwDSCQtLVyRDNkz0M6ttXmQmTTwvW1eqML3omjN/Uy5GF7LR/GqN4FMSFdjQqJP9xy46FFonbREstEe+46ZrUXRiu1y+PjHjf30x5QU1M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6661.namprd10.prod.outlook.com (2603:10b6:806:2b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 14:05:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 14:05:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Christian Brauner <brauner@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Sherry Yang <sherry.yang@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] nfsd: use vfs setgid helper
Thread-Topic: [PATCH] nfsd: use vfs setgid helper
Thread-Index: AQHZfPsU0hWi9leffEW/mcTC+uI3U69G/7aAgAAykoCAABoxAIAA02kAgABBLwCAADWlAA==
Date:   Wed, 3 May 2023 14:05:48 +0000
Message-ID: <A5A8DAD5-7FFD-4CE6-ADC9-FF9F5E509869@oracle.com>
References: <20230502-agenda-regeln-04d2573bd0fd@brauner>
 <77C7061E-2316-4C73-89E5-7C8CA0AEB6FD@oracle.com>
 <51805A56-F815-405F-8CDF-4CD04A17436C@oracle.com>
 <741D94D5-4058-452E-830B-49D3BEBD5D8E@oracle.com>
 <20230503-mehrverbrauch-spargel-258668d27f53@brauner>
 <ac5c9882-8cc7-8d64-5784-fd71b04dde3a@oracle.com>
In-Reply-To: <ac5c9882-8cc7-8d64-5784-fd71b04dde3a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6661:EE_
x-ms-office365-filtering-correlation-id: d1400cab-fd2c-4c59-adc8-08db4bdf7f23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TPoKmrmi5dZFmwxANBfzX45k1QGv3C22opdTzsOmIa8d7tPT5BT6rcqr0kU0cxp5CE+zUXJOFZ1dS4cdl6vCVEU0DsmbY/2maCDUsOj4tt29czsxQ95hUafr7lfOAVRuzGaq2nJigqEPeBYLnZZFCUx5eBQgQbYzYt5wf0OqtrW5TQ3an4q9IBrScQ+n0zdgR2s2PiJvqW+amOGVBTTwVwWqNlVP1YKNkkdiO/eghc2RzE87aDelYG3BuvxUnrlWZ5ucTC+Me4hyph689XuK8Be0S3WCFHMj78fvinQxwXlpZ+OhuJ0NRXH/UiqMVfF6SJyvTN9i6ToAq/XBoNCSpIz72gQhEdLBT9vq24k6a+ZWjzIXvAeWOHZ3tYaIn4DIlJgIMhiRkczJ6MmDek2j4E34624ggA3cqD91soY8mKjYy73lke/td+jvjyWYzM/anypSB0S14JSRUyqdY0nEvpp9PUJClVzk3zLKAfwUXa5r1rODLNfD70A5g2tfIdl/KRtSVkEGHunkYnt+/H8wodBpMh8C7yHNONEM5+3ZniWSCegrJF27B4bf04i3MJcBu62JioQsNGTtkEFlrB1ESo1X0u3aDx/0XK3k0ec22qAXrPdcj6onHA/rYWTvAlb1c91mNg0tUgAADQUhmDc45g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(966005)(6486002)(71200400001)(83380400001)(36756003)(2616005)(186003)(122000001)(38100700002)(86362001)(38070700005)(33656002)(107886003)(53546011)(26005)(6512007)(6506007)(54906003)(110136005)(64756008)(66446008)(66476007)(66556008)(4326008)(2906002)(66946007)(76116006)(91956017)(316002)(8676002)(8936002)(478600001)(5660300002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nkuBQpEPfk2I2EcSPx4+uSEIC/kcc5qw3EiwRE7W3zQbH9SaPK77fZ9Gye5/?=
 =?us-ascii?Q?RlHB677VTgFapZZzg0XZwKlJltVl8138OOOT574I0UEZ6k0fY5WA+2Z8t6zh?=
 =?us-ascii?Q?5aEl3CMqbkopXY4lF9/O1pUPOJVZ8WFngY1tsCJwY54xsmdejaiwe86uTOg7?=
 =?us-ascii?Q?pgaojZ0n4d+axiQqS0Rv4uMNcKSxEv2wCovyGhm8utaMWIknCAh6Uj8PM1kN?=
 =?us-ascii?Q?ABtimjlKLmX+xhLvq92OA7tXPT0jxPapAXzRPOV1ETsMF90BXv3bG5S7pkMA?=
 =?us-ascii?Q?7WsnD4gi6msSJhdMuWciQsjh1XwXex6FELg+xD9piyD9En4L7JmnHDSxn61r?=
 =?us-ascii?Q?279BMgr1peOX2Uq+mMr2+ZmsEMIK3z+mO8W+9vRxPgCVCTDFMBrKwpdBWSOq?=
 =?us-ascii?Q?Zdt6pzfzZUoJtGo0FeqEzTjR2jXmtS1eHuu0+QgByLRn1R8wj+1zkkONMGU9?=
 =?us-ascii?Q?6b77C59VW7w6/KoLYFxDgTWCyhYFK3SvZ1ABWchIlsLXksE/RTrNToTjFYsi?=
 =?us-ascii?Q?yZrQ0ACggdp7faLxyZILthkrWr6mgSriQNDrpRI6pPUY2+XmA7eKY1KcgACT?=
 =?us-ascii?Q?i2Anp1F6FRDDfds0IDI7PoVpZ7Xp2Hxzach7L4QIfb9yyaKtnysnRX22P8Yq?=
 =?us-ascii?Q?dlP5K3rWiy9lGSwiecFIhZQWMZ75sBXXkklQo48LMTRLmrsGH2mAL8jjTqlT?=
 =?us-ascii?Q?xv2Aj7EbncDLqOzlJn50fpFNTlQwIoSAqcJnHwkaZjTaA9u4fL1ft1shet/D?=
 =?us-ascii?Q?Tfck4gLG0RFIby6qbJsUhRloVQBQrPWoYHFuasEpr3yZio8Bu3ZVlRBLXF+y?=
 =?us-ascii?Q?hLLV9gmPnsqCpmrKBFW9pbGpaaSfFEW73O5fjwuqlnrTsYjMqn/ugDIZ81vN?=
 =?us-ascii?Q?Uv1doR+ScyBK5PhNNKyYjlEZ05quJ8yiff6hXouaFYNYYJafbwsP29pD+kKL?=
 =?us-ascii?Q?vUDsjJsyx4QTDfvJFhgf39WzZKJivsm7fUCs0i5yiVLPYSS0XdBtQXwPZ2Km?=
 =?us-ascii?Q?z7oGj2GUhM2DmoGxs24AzJq/r5LEGyIiamgDI0KNTbjOqQSIsMXbzF+oM3lk?=
 =?us-ascii?Q?M+kLJSOe08q9+B/UsNJOB9JUQeJMECZ9QhUvo0T4McexF/E4VhyUB/pb+NAr?=
 =?us-ascii?Q?NaTgRRYp3POXsw8+yYR/WR2jX3OJv0cL8gpjfxe2iGkEWNCqTYi3ycKE8c27?=
 =?us-ascii?Q?AtP073O1BiGQsWAYeMK0KPcOmSn4p7Qyr1gfIbjhxwpLzzBpJOTK2fIwCcRV?=
 =?us-ascii?Q?cLyoGmLlJe38sTQVCTT7P/jzfy3lfEYnUGPN3+AffMdVxYOKvveMD9N23xwv?=
 =?us-ascii?Q?0znDQaiOMfWfS7h7oW3DMrSNElxds4w43BzW9596JxTMB/v+vEC9mIEyKns0?=
 =?us-ascii?Q?ZDgIv2/wH4zSjBo98HW/hsnXn8UNh81JMOv0PqTr+1NuMePcyhP9tIBlORjf?=
 =?us-ascii?Q?sdgibY5dKN02ZFwfR1/ZZBhTRmhcChhOi3cT64FLwqq671Dmuzjf7CjVfQzU?=
 =?us-ascii?Q?ySOTm7zcdPjQSxO0ohX0s9Be3eBCeM3x/PAJ2FimKpxI8iyZ3yL6HFxcB5SQ?=
 =?us-ascii?Q?xsavt1rcCY++0wEPXStNZX9LUc7YFmR5jAzrvO+dMVZjJY9UuSRHwPZtdS6q?=
 =?us-ascii?Q?JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C62500715920C1408D6A7672B92E967B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jcGdkLwcB0G9gmovkeDfw6dwhP7s/Vx5E8jFDoHFw58qU0Nn+DnJ2sOKjcFMNhwkL95T+nyfEraUHYuw2eNCBAJ00N57Tt0qQbiQ9b6YGuIlJA8mct44qvdXXiI+lQV3svJpZErF10RF79e4h/4rkDUEuC4am2MEjvLE7zYm+WY62DAubzF6XIh5JEvNJryCfKNM70yvSSVPoMUdiP7izb/RQ9V54A8iHCVi5RziwgMdHGOS9OOjbMf5Ic6xZ3hkHJMrI83IFitTVqmzTi/2kZHE23FP2wBPsUqCIM/why5BpQVgipfK3wqvjaVhX++Ureq/KlOm2gREEc984nSUBROfuud0ybshCmVuhQXi4WjsRtvy21p2QMI/Zvg9TyVDRCdpsBt8lozdMfSciZ+pDfMNYBiQEFNfqBqjED52cwgbSa25lvVU+Ec5ojAlshS60yRJZvWsMbm0p/vbja/r7WNOXn60n91RYYnBW5kopTkEtEo9O6YuhjLJpVTGjpXyjkNjkaXdbmjNvPLznX3rGksV9ilEZN8xD+pP4hLCzHg7ismIOthzGnyL6gYYjMc60IQl0MiQiDc6UyDh/NA9skzaj4kNMtXDS2sVjjk0UGkDEvo5Oyup1i5fmIhWMnE+wqGbyPTrhgYFrQ1HQPE8C0W5J33M1x+zjiunX8yEsVLXcXpMWHfz3Han7O8lS1f0RibKmqrVvyzYZyipzFni1xqcVXik8hyrG6Wz1xOMIrZS+xr1I7nQZz1dO2u6p4VxYBK96/cKSejqcwogjgiUDHifXSicFUHkjac+R71XWu0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1400cab-fd2c-4c59-adc8-08db4bdf7f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 14:05:48.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YoLcACMOH03YMiRw1+cJRTqd4IoVWMuuixIGeK0kuAZdkxnaqRG5cVHoQXM/0vWMtQCs8quZZy6Y+Q0aWNo0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_09,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030119
X-Proofpoint-GUID: ySA_ebg4G-KxKTzNCCgnkSUTbW5IhZsr
X-Proofpoint-ORIG-GUID: ySA_ebg4G-KxKTzNCCgnkSUTbW5IhZsr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 3, 2023, at 6:53 AM, Harshit Mogalapalli <harshit.m.mogalapalli@or=
acle.com> wrote:
>=20
> Hi Christian,
>=20
> On 03/05/23 12:30 pm, Christian Brauner wrote:
>> On Tue, May 02, 2023 at 06:23:51PM +0000, Chuck Lever III wrote:
>>>=20
>>>=20
>>>> On May 2, 2023, at 12:50 PM, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On May 2, 2023, at 9:49 AM, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>>>>=20
>>>>>>=20
>>>>>> On May 2, 2023, at 9:36 AM, Christian Brauner <brauner@kernel.org> w=
rote:
>>>>>>=20
>>>>>> We've aligned setgid behavior over multiple kernel releases. The det=
ails
>>>>>> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2'=
 of
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
>>>>>> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
>>>>>> Consistent setgid stripping behavior is now encapsulated in the
>>>>>> setattr_should_drop_sgid() helper which is used by all filesystems t=
hat
>>>>>> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
>>>>>> raised in e.g., chown_common() and is subject to the
>>>>>> setattr_should_drop_sgid() check to determine whether the setgid bit=
 can
>>>>>> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
>>>>>> will cause notify_change() to strip it even if the caller had the
>>>>>> necessary privileges to retain it. Ensure that nfsd only raises
>>>>>> ATR_KILL_SGID if the caller lacks the necessary privileges to retain=
 the
>>>>>> setgid bit.
>>>>>>=20
>>>>>> Without this patch the setgid stripping tests in LTP will fail:
>>>>>>=20
>>>>>>> As you can see, the problem is S_ISGID (0002000) was dropped on a
>>>>>>> non-group-executable file while chown was invoked by super-user, wh=
ile
>>>>>>=20
>>>>>> [...]
>>>>>>=20
>>>>>>> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, ex=
pected 0102700
>>>>>>=20
>>>>>> [...]
>>>>>>=20
>>>>>>> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, exp=
ected 0102700
>>>>>>=20
>>>>>> With this patch all tests pass.
>>>>>>=20
>>>>>> Reported-by: Sherry Yang <sherry.yang@oracle.com>
>>>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>>>>=20
>=20
> We had a very similar report from kernel-test-robot.
>=20
> https://lore.kernel.org/all/202210091600.dbe52cbf-yujie.liu@intel.com/
>=20
> Which points to commit: ed5a7047d201 ("attr: use consistent sgid strippin=
g checks")
>=20
> And the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6.=
1.y
>=20
> So would it be better to tag it to stable by adding "Cc: <stable@vger.ker=
nel.org>" ?
>=20
> Thanks,
> Harshit
>=20
>>>>> There are some similar fstests failures this fix might address.
>>>>>=20
>>>>> I've applied this patch to the nfsd-fixes tree for broader
>>>>> testing.
>>>>=20
>>>> ERROR: modpost: "setattr_should_drop_sgid" [fs/nfsd/nfsd.ko] undefined=
!
>>>>=20
>>>> Did I apply this patch to the wrong kernel?
>>>=20
>>> setattr_should_drop_sgid() is not available to callers built as
>>> modules. It needs an EXPORT_SYMBOL or _GPL.
>> Hey Chuck,
>> Thanks for taking a look!
>> The required export is part of
>> commit 4f704d9a835 ("nfs: use vfs setgid helper")
>> which is in current mainline as of Monday this week which was part of my
>> v6.4/vfs.misc PR that was merged.
>> So this should all work fine on mainline. Seems I didn't use --base
>> which is why that info was missing.
>> Thanks!
>> Christian

I'll apply this to nfsd-next (6.5) and add Jeff's Reviewed-by
and a Cc: stable.


--
Chuck Lever


