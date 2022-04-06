Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A934F69E0
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Apr 2022 21:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiDFTba (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 15:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiDFTam (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 15:30:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B912C25E
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 10:18:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236H4739024505;
        Wed, 6 Apr 2022 17:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QnvG4lwqePFEwOiPP2mLrfZZEX+3Eipl2JLJ7CQs0Ok=;
 b=oNZHYkomdXNvmbSro/v6LX8PVBMsGZbPykGadPznPi3MklkWkVTXQ0BpeSPRGfEYJ/8e
 ixGl93z3EX73dFi8D6tENRMR5VsEwz9jLCoc6jqclC04OxgzizM5EWgtOjfBLpuzh4x1
 gVaw3xsfbfJcl5oOeSrNmnsSiAime8C5Ax+IVPKLVvpemx4K7X5aSOd/myDBtfScvnNB
 X/fmSUTEOS86jP+5rkMak+9eu4qNZyGlGHcMvlbRZMqXaaLcqYia/KoPQMl2bS44DEAA
 aRBcbMXAsXCSrBtSOC5kVg3LcaqJqamGBpFrO0Ho6mTqsX6QgSG62I0R7t4MAUjaLHiG 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t9rcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:18:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236HGbHk040714;
        Wed, 6 Apr 2022 17:18:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y6juha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:18:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDZjev6i873gN1nLmDtnImdK6kxh6I/enIt9Kz13X1Fm2AL2uXgwjZDQEYCIdbE2WaYpLEzKs2OSTSSUUskE5FlX2vUzE9Tz7+sBbnzoc3/bzQwi+TgxcHzhxJQNjbe73lq2km6RkYTu84owAP6f4lMbPqGFt6/O1yoKi5DTBXFKwG3V1s2oBJECs0DvSLm7Ie+wpf7XvUIdNmb7V9vGj7y1lKf+CeEpBPLMj40ou/MXw8dOgb5AwBA2za3ZE9fsCqS+3lIBRCPqPZXn0a3xnKFY0RWWqjnydIQMzr61fkOBeO4GerQalZ7VTAtoPab+PzGCb2+alYouZ8B3+qtDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnvG4lwqePFEwOiPP2mLrfZZEX+3Eipl2JLJ7CQs0Ok=;
 b=IQ7daUCaQZnmYlMnbs5BGZc9lqwYcGQza3b0owfpX5tLDKzCjLbdHkYxkQABqcmFmYF/+vvcjzJsb//Pl7+5IohJjf+z2yZGVXNqBDSxJUkkSKrFWLa1ihPZGTm3gWh/HzVUeMCzuouUbrFbeBHIKQKx9Mw+QHHnAoqJnFpAl13laB9VlGKNXFzIJl43BDLdIaE163z8McQ5jfD9TOqIxUwvbAspvXeupJZqIaRzEOgGegUcY1DkfCfn9z6/cx3tw8WTJFkODHD4g3DNzRLShL5SeCq24oRLL+Ykg+dXTGZXGk8QrYBMii0XFOYkb/iphTxBeO8TfdC/LVpDZAAcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnvG4lwqePFEwOiPP2mLrfZZEX+3Eipl2JLJ7CQs0Ok=;
 b=ECeWAEKzRLc5q2zwIiE1YGriyaLHTlcdwZS8e8mPMZaYbQqyM3g95/OWIqViJlsDNqOv/BwEY2aBZMEUx3giemnWvR0kmKIPEIsWOXSqC9B9Uf3DlwmgqVm8J2ahrgCQPA3CBF3S8IvFDx+mcf8pEZhHjDKrDun/HMcWD9ETGs8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 17:18:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 17:18:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Regression in xfstests on tmpfs-backed NFS exports
Thread-Topic: Regression in xfstests on tmpfs-backed NFS exports
Thread-Index: AQHYSdpN1SFcUB4GDEa/4f/k4JlVpQ==
Date:   Wed, 6 Apr 2022 17:18:15 +0000
Message-ID: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbfe1546-3a2e-4b79-8525-08da17f16fd2
x-ms-traffictypediagnostic: CO1PR10MB4644:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4644068BB093EEBDA5FBEFD693E79@CO1PR10MB4644.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: id53Jhh4KYZBEoFEecwbDcedfytzluPDD1fxiDw0t+oEJ+TSq8fNU2ezJphtel09bq3r4d3CP0nnplPydcL3c8Pnm60Q6qfjg/VQWO3TLrFcx0/ThvQy3v+CfgdDt9UBvL1d6VR6i9N/AkjEzwc4ivu2UltOEwiFA+Vyd0Hzjte9CUKGwUDYcBORFBNHl6zeyeehP6ZPPDorcdVFhF/De7RLkKbKW7WVky6imUrmWoaCQGNrE/kL0AagYyDHkWhvrymBdaAeHxPEXdi5dx+Dw/RFer03d2qFaFhIR6qu/Esb7PSlBw5KDhYDg5PyFuK/0Rs4vp0/L6JqgbqL8B6eBRfWg8VPlUcSwXnh/A+eF4HsaNkKZHcExf5l+Esf+JvLU8sGpq9wN6MD18+X7wm0vjm/TsyFog1p5dp0Sjd0EAJ744BxFjiobfGLKQE1Llycp568BZKM44KIPMryBnmlgwvVL+hL0+8lCgfVOsqLsN5Uq70FPi1wz4vXohc4NGxHcYd2XPyL4OCdBk/GVJnFUKYicHmILctpzoBcoOPuRltyXKUGvoyAWVY5R+E3w4+Kn4CfuEJWjND83u4VojTrKyZyN6WIM+O+e0OZ/ZQJkVy5PLcbQT1oFXFJ3YvORmx4g3VaLtsLrvgecspjsO6PXOayba8S4oIKYrSaUkvUiKLq3aGuefe/o/JCzO53+kFqtasZQPsMylaH2afUO5Hy3J02RajVZIJcCI2zlSxwwfQfzVcZ5VvxIvyRLLHQsov9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(6506007)(83380400001)(26005)(2616005)(186003)(2906002)(5660300002)(8936002)(6916009)(54906003)(316002)(71200400001)(66946007)(91956017)(6486002)(64756008)(66446008)(66476007)(8676002)(76116006)(4326008)(66556008)(36756003)(122000001)(38100700002)(86362001)(38070700005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BgMGfwEygOpDL4N7nuBq8KmStKKhTsMV+srXWY/vUb0rAMvNoaQ9pOlPQ6ec?=
 =?us-ascii?Q?RxIlLDpopl0D1WvXIebtiVaTvVBjWq3OTcC7GQt0h8GJOu7739LxohrSnsBz?=
 =?us-ascii?Q?31xXxCkVU9cpcQwfaP8uDz5e+Md1ZQI2ofL44zGPblSMALH3XC5xgxh0OtbE?=
 =?us-ascii?Q?bxEWiG+wqc2DiqwfzV6qv/mkiiWtoPNbLhesDgoAMhl8wWoOPsnx4H6Tp8Ut?=
 =?us-ascii?Q?60QwD1A+vF4uSAEbr/Eia53Ey2iAIENRCwJYeU/VVJnm6i80Y52qryJaZg+2?=
 =?us-ascii?Q?VlJXZTn+38uHPO65AbkAWJ8AcuRwece+RXoJidN3QT9SCKq2hdssh0/9HCsf?=
 =?us-ascii?Q?vsNGcQ5RoILDdmqnu1A0bCgob97OwLVcF5Oy5reFn7jYTLoLrBKO8kkXyQuN?=
 =?us-ascii?Q?716MTP/9r6QDzzbgQS91X6JjxRqraY46LtRoqmW/3g1F8oE/BJpwX08yG0XL?=
 =?us-ascii?Q?1nU9tiV238wbPTH9SbtjAoKiLcRhcKYJUyWUuGDPMBt80sqj7TlnCzFQ5YFT?=
 =?us-ascii?Q?IwgRh7xZPQ8Dnjetx4YrSmNCsr+qT3KxUtzrgrOpZNUKZlBa8Vb1oi+pGYOV?=
 =?us-ascii?Q?C+XRC+kKO5Qbb7uWBAPfyQ4cuxeBW3YUNXseL/pBNJBESZm4Q1JgyHEvbZPq?=
 =?us-ascii?Q?N1SrIwMeXSudHYFtrtuRtsciOg+v0DWuKAWiuzEiug2Vgsaxj130JEh5wsKb?=
 =?us-ascii?Q?bFN1aNMOj4AuqUZTlCPjpDQ/4QGCzHVaoiLYyd3CDfCNzW2PNLXmHFebSb3e?=
 =?us-ascii?Q?sChA2/E7s5kq7Mi2vLGxewga+2HfzqU/F62m75EyJRHqYPeQcgaRPlvH/sCL?=
 =?us-ascii?Q?bapqVu1adObJ4OhmIUBpLKPrCbzIX8Y02dKXJsRLZg868usA5/dMdHk+dzWG?=
 =?us-ascii?Q?ceK3rtDfcyyp9ftos2fFk35mx4zQg7ERjq78TiukyGGl8Ss1CBpR3k9AlmH/?=
 =?us-ascii?Q?2j3KGDUlRoYR/y5v3XimRCazFGXs8MTDogaLD7f4++gtZzl1R3EgZK6e/gHd?=
 =?us-ascii?Q?67Cf/fXNy4wmmcHloZyUW6XRXUAFiT/G9BS1Pa70/3wOdyRJCkyQ5/CL5Qcg?=
 =?us-ascii?Q?N2BE5SDFDjrsjJPhoXvpzXJPY+oqPmEdmhKhcpcO1Do5n2GRhKGOClr4xtYT?=
 =?us-ascii?Q?igv6d5GomtmuplFvDmv/7Qu7S/brC2eoavY5qNUFaWd8RrvxL4hm0lq8urL8?=
 =?us-ascii?Q?G3XvEVsE2+vo0fdnPYtMTW5CK+fQb7PA6Dp1x5ZlPXuXAWwB+XmpROyAhhRf?=
 =?us-ascii?Q?i0ma8eMsZXVYzWmcaTvoHoZNKLkU16j5uT6iAWBUWY4a5/nqSeoE9YBRurWV?=
 =?us-ascii?Q?46SHoHFrxzff1CCf6Sf5qp3HDkV91bG+Ko5/Cnjsai1zs2v3DbzZeqPI3hVt?=
 =?us-ascii?Q?04WKiNGL1dMAw/EE95uUqMYzrztsYYLho8sAjqaZ/xtNyRuytLYKZQsjO7zI?=
 =?us-ascii?Q?2QhQ34TTd7RZ8NSetEvlxZ78XrvDaLF31tV0vRHsETwH1paODm+lF8XTaM2N?=
 =?us-ascii?Q?ZperN0MGSElX2mZDC2bJ8ufBqQOBHDrH9ymaPCjRM1IbDyMcF1KkE7GQK3Nm?=
 =?us-ascii?Q?FB0iMzvFPMAIAehi9yTk53TtbDropKQQL9NVUq9CrvYl8v6OWh7TPihELhOV?=
 =?us-ascii?Q?d4VpymETmtDRBJRe+2isgWFHUX5fJ8KkQWhBUM1pA07OHBKFuaQqJjZV0k2t?=
 =?us-ascii?Q?tyQ+/2P1O41v2a8+GXqfzRyMbx/LvS/kjmQW7kLxLQCDGFlXRJutpgUlcGDT?=
 =?us-ascii?Q?q5W6Y4eJtp660bmZxEwtxBwS9YHzp/E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <080628C0D300A5438CC0A39C79967D5F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfe1546-3a2e-4b79-8525-08da17f16fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 17:18:15.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAP/DQ11HuhG3u0GJ9sAaSygRTwm4OJAhQcmK/FuS8RHpqeJi1DELHmzHqzajB0vcCg0D4Mkozn46SuBCEBr/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_09:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=786 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060086
X-Proofpoint-ORIG-GUID: Lg4wm-Arm3P-xNRHnc-flzOxIo7i-ibv
X-Proofpoint-GUID: Lg4wm-Arm3P-xNRHnc-flzOxIo7i-ibv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good day, Hugh-

I noticed that several fsx-related tests in the xfstests suite are
failing after updating my NFS server to v5.18-rc1. I normally test
against xfs, ext4, btrfs, and tmpfs exports. tmpfs is the only export
that sees these new failures:

generic/075 2s ... [failed, exit status 1]- output mismatch (see /home/cel/=
src/xfstests/results//generic/075.out.bad)
    --- tests/generic/075.out	2014-02-13 15:40:45.000000000 -0500
    +++ /home/cel/src/xfstests/results//generic/075.out.bad	2022-04-05 16:3=
9:59.145991520 -0400
    @@ -4,15 +4,5 @@
     -----------------------------------------------
     fsx.0 : -d -N numops -S 0
     -----------------------------------------------
    -
    ------------------------------------------------
    -fsx.1 : -d -N numops -S 0 -x
    ------------------------------------------------
    ...
    (Run 'diff -u /home/cel/src/xfstests/tests/generic/075.out /home/cel/sr=
c/xfstests/results//generic/075.out.bad'  to see the entire diff)

generic/091 9s ... [failed, exit status 1]- output mismatch (see /home/cel/=
src/xfstests/results//generic/091.out.bad)
    --- tests/generic/091.out	2014-02-13 15:40:45.000000000 -0500
    +++ /home/cel/src/xfstests/results//generic/091.out.bad	2022-04-05 16:4=
1:24.329063277 -0400
    @@ -1,7 +1,75 @@
     QA output created by 091
     fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
    ...
    (Run 'diff -u /home/cel/src/xfstests/tests/generic/091.out /home/cel/sr=
c/xfstests/results//generic/091.out.bad'  to see the entire diff)

generic/112 2s ... [failed, exit status 1]- output mismatch (see /home/cel/=
src/xfstests/results//generic/112.out.bad)
    --- tests/generic/112.out	2014-02-13 15:40:45.000000000 -0500
    +++ /home/cel/src/xfstests/results//generic/112.out.bad	2022-04-05 16:4=
1:38.511075170 -0400
    @@ -4,15 +4,4 @@
     -----------------------------------------------
     fsx.0 : -A -d -N numops -S 0
     -----------------------------------------------
    -
    ------------------------------------------------
    -fsx.1 : -A -d -N numops -S 0 -x
    ------------------------------------------------
    ...
    (Run 'diff -u /home/cel/src/xfstests/tests/generic/112.out /home/cel/sr=
c/xfstests/results//generic/112.out.bad'  to see the entire diff)

generic/127 49s ... - output mismatch (see /home/cel/src/xfstests/results//=
generic/127.out.bad)
    --- tests/generic/127.out	2016-08-28 12:16:20.000000000 -0400
    +++ /home/cel/src/xfstests/results//generic/127.out.bad	2022-04-05 16:4=
2:07.655099652 -0400
    @@ -4,10 +4,198 @@
     =3D=3D=3D FSX Light Mode, Memory Mapping =3D=3D=3D
     All 100000 operations completed A-OK!
     =3D=3D=3D FSX Standard Mode, No Memory Mapping =3D=3D=3D
    -All 100000 operations completed A-OK!
    +ltp/fsx -q -l 262144 -o 65536 -S 191110531 -N 100000 -R -W fsx_std_nom=
map
    +READ BAD DATA: offset =3D 0x9cb7, size =3D 0xfae3, fname =3D /tmp/mnt/=
manet.ib-2323703/fsx_std_nommap
    +OFFSET	GOOD	BAD	RANGE
    ...
    (Run 'diff -u /home/cel/src/xfstests/tests/generic/127.out /home/cel/sr=
c/xfstests/results//generic/127.out.bad'  to see the entire diff)

I bisected the problem to:

  56a8c8eb1eaf ("tmpfs: do not allocate pages on read")

generic/075 fails almost immediately without any NFS-level errors.
Likely this is data corruption rather than an overt I/O error.


--
Chuck Lever



