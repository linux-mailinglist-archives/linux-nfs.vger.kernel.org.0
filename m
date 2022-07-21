Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17657CE64
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiGUO7S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGUO7R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 10:59:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83255F7A
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 07:59:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LDjA1M028363;
        Thu, 21 Jul 2022 14:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FcWbjdKsnXekGxyKzVOoy9Iunuai0Y8VdlzYzF+ciFA=;
 b=Wm3vZZmvrlYx4HV7pfZvJ7FT7nCgv3BTV0X1NPoMoEm9wwiEgZ6dWH2RZ0fgbK8PxFyN
 DlsoOxvKT4qA9wBJyu85zICQc8GB9ZKb4BhfmTA70GjfV7IA9c+n9YFnWeuC0BkxZrMh
 HB9qHFnkOvdHX9sUbNuoKtzX0qTEQYHNYpNR+HTVk2YNsOtsbOfTojAlMzu9+/xDZYCM
 qvnMzgzOrDS6gvheMzJhPouKQMkidbyScUtbTdus2hgq4E8xf9pQIIU73Cgsd+t6ptI8
 s6FPOyQw5z9UhmKh33VR3WBCfneUnlVA6kpw1oBwJIiVpTyIb+3XkYvZ8HyfoNHQFy9n hQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42mt3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 14:59:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LC7uFn016547;
        Thu, 21 Jul 2022 14:59:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1epjdmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 14:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwlR2QLO1q9qXtDMh/WJufJ0gdHdEzLT42xz3MYOESoGN5ru++/KGjd6sTgkcsIx748kIFRx6Rcjqo85j1+hq1enixFQAnI5CF9jhsAKCddG7/GUhsw/6qHceTw71Vq5ElnihEGghnChknye4LANDvNpKOoaYOSi/pMbOBPVrAAiU2PsAddf1QVRBhomlxJp0l8FaULwjRJ+Jheyk2TnvL7Cy/9kcD7UhplusrmLFaAGVedMSz+SJNOMBV/lRiS0EiOS+i8Z/BPOO48SN4ixcAwBdKvO25FtolRFUOlCMKPcCtV6qdXvY9UPru1M7lScZKPxDOewlAdFKn/TqQ6/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcWbjdKsnXekGxyKzVOoy9Iunuai0Y8VdlzYzF+ciFA=;
 b=HQ5Nho1YDhovCzK4/YQyVdWeNddJUBDOWLXNDfv2A/D2YVJg3zVJlDr2Gj/HNbEFbo/sQyCVjjl7G00xtJXWiVEHPqDsqqxbl5tS3EK4pzlPak2s+TOUTAKh4VIggJy45M9oYPqrvrVIVyIivNdK9DRjgk2fh79ElHOjXqOoDR7nWDbE8KN7U7aP+Pu7kvfUUOmtk04VBeu9CKYKNo2Irl087YIRTLBP0tr2Uy5d6DiryJv+4GRbCEgQbcch7YP4dKWzh540YR48x9hTDY0bhyQxNi2lXVnRwgi7Xm6CW0N6+v/NjvTZAOaKDvb/W/J0G6PukQh+X14X7aRM08CQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcWbjdKsnXekGxyKzVOoy9Iunuai0Y8VdlzYzF+ciFA=;
 b=xImSK+TRoNAyhw1qUaAN2Got6jFAP5N7Pq+Kcc9OaWFfpT9s0cIvM9p37yy7q2BEduQMfui06JHNvpFUcBLtsfreu/APtn7+q8lTe8RqckVpkvZwnGXo+AjB/RVR9BZXEDGLFFIfGF6AzWfudFoOlsJKAILhkBEzR0MdTdSKeK8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2639.namprd10.prod.outlook.com (2603:10b6:805:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 14:59:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 14:59:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug Report] [PATCH v1] generic/476: requires 27GB scratch size
Thread-Topic: [Bug Report] [PATCH v1] generic/476: requires 27GB scratch size
Thread-Index: AQHYnRJspQF+Nm/xKUaneWT4ZqBZng==
Date:   Thu, 21 Jul 2022 14:59:06 +0000
Message-ID: <77BA43E5-5F41-46BA-9AEE-913591ABCE90@oracle.com>
References: <Ytlnn6myHtOphb52@mit.edu>
In-Reply-To: <Ytlnn6myHtOphb52@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e262047b-0b26-45f8-4853-08da6b298f54
x-ms-traffictypediagnostic: SN6PR10MB2639:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QlrHMRytnN4KWNtE+ooiXTW6hQsKq2WnXuXvkYrYbM2e7VdgsJ6Sn8VPkVPXV6Hj5ULXYnBBBnr8diqcoUu+vnzmX0qe3R0JnToEI9gpUKZxUwBUW7XF6hmtGkMdGgWccCMyEYQiEVDTEH72qQifcLaDYXaPm4PjioB0VUuVnKOCZBibmnfRp+3WQY+7mhQvtsv1ugVbi0e1ct69XYQfoQMnniCZqaJ9l/jaTWNhua3YYcFW0zjvbbRrhRedXgbw3zsF4jETQPm/ywzN8gLC7gswxnlXJpVJkB2rwBzqcr9dnWcZRyfoHMPyoO4vlq76NyTepgYMMH/DIoFH8C4Ndrf9mRjlGImdl/Bqnbx8thIGZFLBHyIlkVRQcGFp5qpADP26f7TwjzONnnreHX7kWMU8oWy7Bny7iikoceLXbPwnZ70rDsZwO0aJd62TVZhUMRn1XCw2DQCdNf3gSIOXQLjgNBp6pg6dTKAm0dU2FPcTjv/Z/B6zp2WMjuPlC0p5U5IMksghMkZolz+OelAlIIAY11fCjaTx23xKEP0enFo/Xpm+srT90sjNlhKlySPibYqVYY+t3mDz5kPMdEY/n5r+zhUDKjbpnNv+gsDAySsb21O1bmeQbWmReQMGRpla21TgEsKsl8+0b5Yb+rHfVtyyJG1nE/T34W0YapyTA9PU4DydyMmfqL07xBO4n0CmBxxw7txpyYqnWCIwut7xbrfqFpReBXF2cOZnjqb/v1WsYY9IzsBR1q6BhFG2fjDnrU2yvVyOpaSETFqBeYeqqnuijrX+McVaaN//FF+fZAfHAncSh7EwtBuv38ALJApVbCSblZgvFA2mS38xIlv0G3IGjqhN6cTuiPBTiN50VZTBSnOkM3VB+t5I9sF18gHNxumR3edKNaJmCge/yC2hwLomI9sZRZok+dyGljtBBdqgVZ0XJQqlrgY1AxQ5s2xl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39860400002)(136003)(346002)(478600001)(53546011)(26005)(86362001)(41300700001)(6512007)(316002)(6486002)(966005)(71200400001)(6916009)(38070700005)(6506007)(122000001)(186003)(83380400001)(64756008)(8676002)(76116006)(66946007)(66476007)(91956017)(66446008)(33656002)(2616005)(66556008)(36756003)(2906002)(4326008)(5660300002)(8936002)(38100700002)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WN2LLCiRdAhqug6MFTGO5n42t/9oPb2VtQhZ4b3JaKxNqhfYptyU/6pS2uqO?=
 =?us-ascii?Q?5K/HLOLUOomdSXsO802CRhh+vUzmr571q7078gyQH58XyuYCok49YctG2/CU?=
 =?us-ascii?Q?OXlTLPL3aqH9IuNGOU5hjRzaSvNpjPd3Ae6fuXKM4Uzdt8ET2UYLnYW/Nldg?=
 =?us-ascii?Q?PpAFAhtoTI+pSDcsAP+iOKNKR72j3FAjJPORIFvN8lWLuU7xcGIzIO5LyrqU?=
 =?us-ascii?Q?6LSNVVBW/p6EvpzXC9gHa6VyWypToWlZLscTREwovjSYSlVN72lzaCD4MSwC?=
 =?us-ascii?Q?FJO+pUMV+AjPAlgi/DHwU9GaAnJNkxykGvE3MdY+56tXwKJtK7iuNdxLyaIb?=
 =?us-ascii?Q?ujr1w8Rb27YGeuoqCEQggQFj7LFJd9v3BDjDhZCY7RH1L8jl44YlJXHSgezx?=
 =?us-ascii?Q?r573XiepAGQOBzt1s7P8vE62bIwoPbjqK72toSElQFw4beBG/KeJ0jb2aQrg?=
 =?us-ascii?Q?uoE4j66JSHuCrT6nHIT3vBLVwzBaybxWP/4Rl7szZgB/pN8mVnJoDFHvLCUw?=
 =?us-ascii?Q?hOB9wlYFm/Az30V2E80RgMWwJm7UW7b0e5YM+L8v2JsiuQXQAzBpHqIH+7ha?=
 =?us-ascii?Q?L3FDMw6tubjOUmlOJq9FGPMOKjvmkWySjCBOH1PhkiRxTQT5yZItSxDcwGMi?=
 =?us-ascii?Q?kzaZtgo/LbJ21ccwtpijHTGBlgvBmfPSa1qry6hvtKy2FYDVjmm23SaZOb+v?=
 =?us-ascii?Q?I37h+f6YBhLPXo3McXRGr0IuJlAIHyuhe0eAcTVydfxi97rhqTBkCQGdsNHH?=
 =?us-ascii?Q?46ZNTkDYzDfWO6OiR1qRTA1x2nLUJKjouLyVucXDIwtLxJLxYV1aBziu5Nxo?=
 =?us-ascii?Q?NM66pBnfjwazUleElUMPYRUoGBCAdRstJhlnIL6sbdyNnSD0uTezEi4vANra?=
 =?us-ascii?Q?0PTRqT5dlT4Dg9hvMc4GfCN6QS1XcCzG08aeRkdambtruLoW8sXYro3gNIlW?=
 =?us-ascii?Q?Xn0TADdGRws9oQrA5t+eB/bY8BeJFfsNTvgqP/ZVHP6QeER0Y7wh6x03T000?=
 =?us-ascii?Q?27MvpYQKM+3fdpNUlf7jd00ZTZ3igIdXn4+y39AIV7bqxFMs5PqYLYEiltkU?=
 =?us-ascii?Q?ZPwE7/gwmx7y8BfeZTOmE3i/k7lgetdkuUoEp8tduTZ8SQR+RyvpK6I9d75f?=
 =?us-ascii?Q?ZLt+Y7rn4vd1ol0Ec3mj2JU8J4NknbPr/1puacVIMDFYNksyuTNyVD4ivdAu?=
 =?us-ascii?Q?DpAtz2U6y/xFH+EdDMOb4uygdmDEuTtgVlySJteQgD5JNpD+OogDM5k/LyXm?=
 =?us-ascii?Q?pnjgwj8zCIwHFQMBsGLL2IaWK/tjPhS3XSuhZq6O8AMSBk8LxUNrZG71Y/D6?=
 =?us-ascii?Q?ow5LIUDocJZ+dpgLgaoxYbZAmKV0Y0Go139ERyvOW6Ai7KTHKg23OMkWsvM9?=
 =?us-ascii?Q?nfhGBdtQtE54qo2PUioF2xudE5SgSz3I9csF1Cb/sUjs02DccOo0xeFxvYST?=
 =?us-ascii?Q?tY3Z+XIvnj3Zla0OmJbgpSUg35muxLcVX+pVNT+n81tShZBD4q2bOp2q1SpA?=
 =?us-ascii?Q?optcIy/6z6qUsnfL0NqFLhgYTNJZvt3rfANzV98guw5O+edyKyOKsEpDmNLO?=
 =?us-ascii?Q?JvSJW2RX/OlIDkGS4Sya+vRCnAtMVE1sYe57nqiJZqCREKZjZagpkVxm5FDi?=
 =?us-ascii?Q?lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB0C183F6824594390D5B7C98630DF3D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e262047b-0b26-45f8-4853-08da6b298f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 14:59:06.8686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmToWgv7eN137ojpXfRDf1Mz8+wlklcxvcCJIQmxtJF07dS0MamEkidZg4t+5p2rHs8HVqyWKQn32ec1tcVqtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210060
X-Proofpoint-ORIG-GUID: 5yd9b7klEYfla3z1fSJTrOT2Rd7a3K2M
X-Proofpoint-GUID: 5yd9b7klEYfla3z1fSJTrOT2Rd7a3K2M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ted-

It's not clear from your report whether the kernel range applies
to the client's kernel or the server's kernel (in the non-loopback
case).

Since a scratch device is involved, I suspect the livelock might
be due to a problem with the NFSD filecache code introduced on or
about v5.10. There are patches pending in the NFSD for-next branch
that should address this issue. Is there a way that your tester
can try these out to confirm?


> On Jul 21, 2022, at 10:50 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> FYI, modern kernels (anything newer than 5.10 LTS, up to and excluding
> bleeding-edge mainline kernels) are looping forever in a livelock or
> deadlock when running generic/476 on NFS, both in a loopback and
> external export configuration.  This *may* be an ENOSPC related issue.
>=20
> See the referenced discussion on fstests@vger.kernel.org for more
> details.
>=20
> 	 			     	      - Ted
>=20
>=20
> From: "Theodore Ts'o" <tytso@mit.edu>
> Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
> Date: July 21, 2022 at 10:03:45 AM EDT
> To: Boyang Xue <bxue@redhat.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
>=20
>=20
> Following up, using NFS loopback with a 5GB scratch device on a Google
> Compute Engine VM, generic/476 passes using a 4.14 LTS, 4.19 LTS, and
> 5.4 LTS kernel.  So this looks like it's a regression which is in 5.10
> LTS and newer kernels, and so instead of patching it out of the test,
> I think the right thing to do is to add it to a kernel
> version-specific exclude file and then filing a bug with the NFS
> folks.
>=20
> KERNEL:    kernel 4.14.284-xfstests #8 SMP Tue Jul 5 08:21:37 EDT 2022 x8=
6_64
> CMDLINE:   -c nfs/default generic/476
> CPUS:      2
> MEM:       7680
>=20
> nfs/loopback: 1 tests, 597 seconds
>  generic/476  Pass     595s
> Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 595s
>=20
> ---
> KERNEL:    kernel 4.19.248-xfstests #4 SMP Sat Jun 25 10:43:45 EDT 2022 x=
86_64
> CMDLINE:   -c nfs/default generic/476
> CPUS:      2
> MEM:       7680
>=20
> nfs/loopback: 1 tests, 407 seconds
>  generic/476  Pass     407s
> Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 407s
>=20
> ----
> KERNEL:    kernel 5.4.199-xfstests #21 SMP Sun Jul 3 12:15:15 EDT 2022 x8=
6_64
> CMDLINE:   -c nfs/default generic/476
> CPUS:      2
> MEM:       7680
>=20
> nfs/loopback: 1 tests, 404 seconds
>  generic/476  Pass     404s
> Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 404s
>=20
>=20
> See below for what I'm checking into xfstests-bld for
> {kvm,gce}-xfstests.  I don't believe we should be changing xfstests's
> generic/476, since it *does* pass with a smaller scratch device on
> older kernels, and presumably, RHEL customers would be cranky if this
> issue resulted in their production systems to lock up, and so it
> should be considered a kernel bug as opposed to a test bug.
>=20
> 						- Ted
>=20
>=20
> commit 4a33b6721d5db9c07f295a10a8ad65d2a0021406
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Thu Jul 21 09:54:50 2022 -0400
>=20
>    test-appliance: add an nfs test exclusions for kernels newer than 5.4
>=20
>    This is apparently an NFS bug which is visible in 5.10 LTS and newer
>    kernels, and likely appeared sometime after 5.4.  Since it causes the
>    test VM to spin forever (or at least for days), let's exclude it for
>    now.
>=20
>    Link: https://lore.kernel.org/all/CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz=
7tdM1ZLnpeQW4UQ@mail.gmail.com/
>    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>=20
> diff --git a/test-appliance/files/root/fs/nfs/exclude b/test-appliance/fi=
les/root/fs/nfs/exclude
> index 184750fb..ef4b19bc 100644
> --- a/test-appliance/files/root/fs/nfs/exclude
> +++ b/test-appliance/files/root/fs/nfs/exclude
> @@ -10,3 +10,14 @@ generic/477
> // failing in the expected output of the linux-nfs Wiki page.  So we'll
> // suppress this failure for now.
> generic/294
> +
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(5,4,0)
> +// There appears to be a regression that shows up sometime after 5.4.
> +// LTS kernels for 4.14, 4.19, and 5.4 will terminate successfully,
> +// but newer kernels will spin forever in some kind of deadlock or livel=
ock
> +// This apparently does not happen if the scratch device is > 27GB, so i=
t
> +// may be some kind of ENOSPC-related bug.
> +// For more information see the e-mail thread starting at:
> +// https://lore.kernel.org/r/CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZL=
npeQW4UQ@mail.gmail.com/
> +generic/476
> +#endif
>=20
>=20

--
Chuck Lever



