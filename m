Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F455B297B
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 00:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIHWk1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIHWkW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 18:40:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4410F13DD0
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 15:40:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288ME4qw014152
        for <linux-nfs@vger.kernel.org>; Thu, 8 Sep 2022 22:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2022-7-12;
 bh=UJ5ep4cgtMpPR5rY9PrS17lTK/Bu9Az4CDOXvTaLgl8=;
 b=Hl5ADAxeLNHPHqjtfW4Ra2IWTkMbfN2xXmMeBtlPQ0P3ilzoYy2AlKUqQ1jxkbeeF8v8
 agRb8YSxEvRm4aX6+IqyVvse2O/NHTkLsOmrzI6TwJ1O3bEOeWdcFCi8Pj/EWWoE67gs
 +uTBVuip4yDWjwuTordosgnQ/zkdkqZl1gvhzW5w3oUQVNG9bT3nyQDtecTC7FF1ci4h
 0RGvVU//AS0Mju+U2J8FAMgQCWienJ5ssPPQvMBtUDPk6o7uDdkNpkrVB+kqOi5fBUjj
 0q7uew1JZJ1CwTVIg/Qg/5AuhQrLs8fTIb7kAzA9jBLrjQeFDXYg+BGEXR6BdQdKBAJj Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftw9h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 08 Sep 2022 22:40:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288M0Eig028051
        for <linux-nfs@vger.kernel.org>; Thu, 8 Sep 2022 22:40:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcd5v6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 08 Sep 2022 22:40:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1JLH7WuLtPKFmtrZbGnS/vBbq1JItkkPJNYukb+Yp4kWmSfbNcPUceAnP4Ur0F0VwmCLRv9oi31Odu2NdA+oyAbvRL+CIbyNF6LID7XItz/20e2qd9ZHvJgAVhHq8zU1ZZeBYPBmcVH143JgbyTb5h4bdwBaUQrO4Wy23K8XTumkR1Ifuay5aWxnlYsghSLHCGZhnasiMw9qEACJ47ae+PwUhKzaiwo4Zi1snFzzvpM+rylgX+el+qF4aKI9nsrYHq11McKP+OQDrrsWznD2ah5HWOo/cixBZHivFbmFTggxD5brBjQ4R6Y5pC95hu2PB6HJ4g8ytc27RumW7rkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ5ep4cgtMpPR5rY9PrS17lTK/Bu9Az4CDOXvTaLgl8=;
 b=Y3r7QnrEJLX/XNrv5rnRzsJwrly4XsvJduQ/wYLGpbv9fZ4RyZnpi3t79qJU4T9axKOMg/mt+JOOssZVzoLsN1ZPq5SbTS+Frpfz7yhBp7toQV7XLxLuv7DJafdpypuLpdUf4xtR5ERPRPJASi9LMCTT+9fqvYU0UH/SMpUx1ycU02zn9bFJ0gD9J1AeGOppvYBLuQ2+rQdHUoIAjlPz39xW9UYLy0E5GA53JBT+JqFzq5sTwOHmgxxhIRfp876nnAnNzZpl14x64jVDRiAwxZHaXp5rtdjZDgQSLPmAIVSACQVa2PYyjG4rTinGJfAA7mKqajfclAvDaeya3hjVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ5ep4cgtMpPR5rY9PrS17lTK/Bu9Az4CDOXvTaLgl8=;
 b=d0YlW0cs2C6rUnvrucv41/OfpRu0A8RDs9y+oRsncTojurvet/NxicW6oQ6IMaf2hX2z/hw3Tyw/vy4rcJDz/lSMwMj0erOUkahLTkGOcI/+boL4wAExDTxtkFCtTMPFMXVjnwxtKbzzQUvn/OAepG0ZNVw9IXYzfdPzlO7+LCc=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 22:40:17 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::2c8f:543:17c0:f52b]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::2c8f:543:17c0:f52b%5]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 22:40:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: generic/444 failing on NFSv3
Thread-Topic: generic/444 failing on NFSv3
Thread-Index: AQHYw9P3CYcLQcAaZUa4o/0tY4PY3g==
Date:   Thu, 8 Sep 2022 22:40:16 +0000
Message-ID: <2AC1BDDF-E422-404D-8BBD-2E97CF4FC0F8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|IA0PR10MB6746:EE_
x-ms-office365-filtering-correlation-id: c60528a7-2356-4155-15c1-08da91eb1a2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YXJgwUeEPu5oveGXSu/ErsRx9TVHvVTjlNkm7wTOTPcMbMVofh4tiaTWtGApr/0L2hs13hsXuhtNcIP+ppzvlzw2cIoJUgMJG8uncrOS84IM6sjsUuI8s2L/UNKLgxFR0UMcOBpBrSmDU+AfMwujBzWLC2J0NKPK5FghKYH9x++CXk84MIFt86pfhsoXb+3ibHn8550Xba7wRcXw5oHvV+/gsFj6MY6niYfbPeRkZ0cenZG1in6WsjGyjlKKGg5X/xQwZ4bRLt2//PYe7HPIMqrq+iRX9UzeM+Kf3Lz+xhUEB1s7pmxVo6E8jLc1hOnzTCppSt3eFa4du9RkQ52/VqpDX8qMHAAy9wtC0fz4/qhdApkRaFbanYbRSEHJ76yvVvncYQwh/xy8GXxqth4lg5ZqdkXhTkcWkKQs285sWL86uCHNe7LNzqOnijQTDQ3C6BbLtbn9a+zIvu2fQLBTMfhuHNjhyjEj7hK+yLJ6Ddlvq3Lbhs/12BefrS30xMjyiM7nzUYApGQ+pEXjVEDDDl+xbBs8+k9r73Q4OvHg0e65OEgEcfJKfrGaIRYzthqZoyudPn8P/fddW8huAoeUgEHD1Y54Kuj96PSOTbVRKaLI6fFxyeEoDONdHUahQx+n9FQOviJIMOKqXT5ceVIz+765h0xT1GH2HuoqAmtvwbVdQiXxU6prYn1QPnr1vxa+VmiYHfWuLN1INrKB/t0L+RlRxLI0SHT1BSS3EyozjOxpEPxamwXg+uM0hvhayWI/s+/07/F842FmFykL8YktNK5+0NKeRXOtFYM+qedTtEi5aLSpMfe32KBSip7swr1mXSLTLlOPl5hkD3PmSU3lXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(396003)(39860400002)(38070700005)(71200400001)(36756003)(186003)(83380400001)(122000001)(2616005)(8676002)(76116006)(6486002)(6916009)(66946007)(66446008)(66476007)(66556008)(316002)(64756008)(91956017)(478600001)(6512007)(26005)(6506007)(41300700001)(33656002)(5660300002)(38100700002)(8936002)(4744005)(86362001)(2906002)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WYBGLnlQonlrDkKdCU9V/CKJTuY61Qj29iOEsvAfXNcs5BOEqIfjAM/aSU97?=
 =?us-ascii?Q?2yxqaqwU0KrnLInQzxZsVJ7rbAmucCYWYYLkEeh1oJXaG9k5kawHMqR+HJMZ?=
 =?us-ascii?Q?E+jESQ1k2nIlt+q7gMcM6s3OiytwZlR017h027FBrqe4VtKZftpeOTVXUyZ3?=
 =?us-ascii?Q?Sx/lN0LDzFyM+Bg63/INqxtqnrqfuNxNbqWh+kyodrzPhFc9FVSRI0R2nNlJ?=
 =?us-ascii?Q?rm+nikaM1aTC2ecMoR+EXe8+09aHBTvhY9NmqOuvsowAmkKgxTulI5lP6NaG?=
 =?us-ascii?Q?MMGCylDeOnoo+7WV6/I0i5noY4qL457qnE8eRWTfLT44X408PtZB9Bc4DUXz?=
 =?us-ascii?Q?Y3ICSvBV16RgdlQ2HyzB8fwXBzDy3gLqJDDrRPsQ4SG5WHGDtuwVnLZwU/dy?=
 =?us-ascii?Q?QpEsWYXZDGSDLelWE3QrrLgP5jHBRKthHrvgKVyM35Uuv6gLmMj2aanstPOd?=
 =?us-ascii?Q?ft25nl7aZkh8uZwOyvESk/+ez8gBBRlXKFwRQxphWtM4x9Zl+8m1YPZNS1D6?=
 =?us-ascii?Q?glvfW9IjizYynBC2ndT5l+jub/pWAc0Qu4PwNgy+6QI7MIW0Yx4z1piSUX+o?=
 =?us-ascii?Q?aGINbA6Cz04ElhnwLDpWLE9QshO1DPHRCwE2Lu8QyTreqgxgC1gKs1BzeVBv?=
 =?us-ascii?Q?M6VhNUJaNT1uB0RTinE9j5VqvnA3GH8NSgHu/HAaU+n54BnAaW/GDFfFoqy3?=
 =?us-ascii?Q?vltgTZPAVZzfq5PU2B/DSFJ2JprezKjZ2FFocI5KLc0RWDvQov4HMnSTqk9r?=
 =?us-ascii?Q?WdN4B6ND9W1wo+F7Trg5LbHLcBuhUOS+Kcm+51Si0eZqLbIIeJuwA5GAVXYJ?=
 =?us-ascii?Q?nCgMxLffv8TVqPQby8eIatq37yAjCl9NstNlbVeBKnfi9cvTJ6eE4YEAllGr?=
 =?us-ascii?Q?hVhKdTq2YiC2yR6esVFi8S3JhhOg9v0+pdD7XdXYHq5yIVHfZi750oWtknzL?=
 =?us-ascii?Q?bKEqdMoj0S9Dx44ZNldJ2c10CWRyWSTK4L+VzXnuO8gmgKhqN2FxrZaySfmh?=
 =?us-ascii?Q?YBgAIyJrLqoBtYYVDd58gu4Y7XNnftaPb2hxptOdvh6KgoOnkQ01MMW5A9ay?=
 =?us-ascii?Q?MkhAsEws0YVM+5LAiIFVgIqjXkHbzrhP2z4mZ7Dof/mW8OS+99vo7o42sMM9?=
 =?us-ascii?Q?tvBol+8PmirCyz64v8sNX9utHoCtUQhHs/yLBd1ZnnkHEZ8XxEZDQMCG6rXO?=
 =?us-ascii?Q?h/N6Cf09j1imbXPX40Z3cu3bc+0bW67KEGpu2dGR2Yb2TIACHn9oIZBGJPjc?=
 =?us-ascii?Q?3+BINFQwib04Ax2lujzKmLc5RlYT07AZ3kjZgvDrSal65QzEji9dgLSInxpV?=
 =?us-ascii?Q?d7hs5ToaQ7IE+RXurNWu2PrOqVepjz0/my548lIe3063rBdR/CKSr9cQ07uL?=
 =?us-ascii?Q?K4IYApx8u2L22Gpk+hcc8W+J3G106qmGe9YGO2QdpAy6EzLDqugz9gh1nq5V?=
 =?us-ascii?Q?R8EJywPY0AIdvgyO5XLufwfhSdFZohvLIdCmnxYDzTmlWdWufVuRADTjhFim?=
 =?us-ascii?Q?eJ+T3jVhXTBsUdqckYY9W5X4sxXoTn8jnV9r5K2XfqeWQiSsEBUZNbycbr2I?=
 =?us-ascii?Q?FX1lbtjvqKpOeeTmbFaNREqS9+m1ZCy5LWnY+BTfoCojCrGQNjW+X6VuB8dL?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <671253854E9FEB4CBC0D65E5CB2FB870@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60528a7-2356-4155-15c1-08da91eb1a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 22:40:16.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6jJVDs1/9xyuqJ5y7n2Th6L0XtCyrO4eWc8ZpD1YJvFyZcfKWoidSYJLDVa52fdC7JWDdtkJZpW/pn89eZLSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080081
X-Proofpoint-ORIG-GUID: n0N6zJ3XTew2RErhr7njJDZlKLxguof2
X-Proofpoint-GUID: n0N6zJ3XTew2RErhr7njJDZlKLxguof2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I noticed this failure while testing Neil's fix for nfs/001
not passing.

This is a POSIX ACL-related test that does not run on NFSv4
mount points. It fails when the server or client is 5.19 or
6.0-rc, so maybe not a recent failure?

generic/444       - output mismatch (see /home/cel/src/xfstests/results//ge=
neric/444.out.bad)
    --- tests/generic/444.out	2017-08-15 16:01:52.907008068 -0400
    +++ /home/cel/src/xfstests/results//generic/444.out.bad	2022-09-08 17:5=
9:51.165199218 -0400
    @@ -1,3 +1,3 @@
     QA output created by 444
     drwxrwsr-x
    -drwxrwsr-x
    +drwxrwxr-x
    ...
    (Run 'diff -u /home/cel/src/xfstests/tests/generic/444.out /home/cel/sr=
c/xfstests/results//generic/444.out.bad'  to see the entire diff)

--
Chuck Lever



