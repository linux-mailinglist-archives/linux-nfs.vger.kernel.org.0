Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B45708EB
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiGKRdN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiGKRdK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 13:33:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C7765593
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 10:33:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BG2iKw019405
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 17:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=n7F4jsKXMYaxbBMWS2cwM9kNKhFkOT/ODoyoHHM0b/c=;
 b=hy2VQQoipvZRW+KHtySGdUGor6FWIcZd4BQxhDngcxBmT9j9X1miYB5E4bXmpNHpSx7g
 D3QJ89cpdIjRVGtUVB/wAwCegfLCGJUXY3bTDKfbp4376s24/FQqk1uhgT3NrNe3wasS
 ozW416hVQtlBLqaCfFouvzP3z1xXYrjeDhNehH2Ni96xAkUxRXhSlzAeGmdc2/DdjYMH
 IpJtwtWk9D1emwiefNl41qvkt3likCzKpiHkBngMRGsWPX5QS9K41VRwUgPMtC0YG9ZF
 q4/kx0Qze8ehi4/tBnYCmw6FNepof3l5V+v/WTPMyIs/uZNRL7+Uoehn4iioJic7IVkI MA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrc78j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 17:33:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BHFG7o023000
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 17:33:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7042tbv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 17:33:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQTLd1uBucL1dIao56wrnU/VgWn1mKrNeOulQ3CO745OQpOXXyoWk5CuJv9hxQG7f0CKi/ug7/R0egRa9MFqg3x2MlsGelf2OqSJTjM6m6W9tE32zpNJKC573Tq5a4ABaiRgd/gZcrwfHclzmTCpsm+nsU9vJVE9+TykJqFsSlIec3OnBXLdGzNcjpaohSKDequwuDmlqSyjnua4Gc6vHV0WhiU50pUeRjv0p4H5A9VI0xFMnmBPV2TdqWKaseA7BmwfG1kVkmweGrSs6y7yHF/KnjMIUOWpxs/TW7VC3BTe0w72jUIMR68w0CB2lpiosvv195XD+Eolfi9mc4oj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7F4jsKXMYaxbBMWS2cwM9kNKhFkOT/ODoyoHHM0b/c=;
 b=QEecjsLpyvWd6Iu2VbUJDF6fn/XMmmvqTtoyaVm+6j8wDlFJdQsJjIZWQMs2M+TxuXHFYLv7g9K1SawVxfYmg5g7n+BL+S1LyW+/xqDL3fODnDgyqr5PXf4fS0ii/E63j1HxGkC6raVuMykAQhu51l7hwzBxmfCXypF/6yUMdEe4Dalt/luietkZI30EBt/3cXtZz4gDYreelms9uN7Cybq7LrSXFUoq1houMFiRYqMEhukzfgBND2ufE3d4WKJscw9TmySuAW+zaCIdyVnr6aX5nHtc7Rz6MSVs4/QWf5+vyk2X02c/0ycDHARKzT9SVy0W/6cJglTnLfgRCKbKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7F4jsKXMYaxbBMWS2cwM9kNKhFkOT/ODoyoHHM0b/c=;
 b=dlJhF1EmZ2QW8kIuOFRnjy+Cr+OwBbuDpfuXtT9ojkSCADUFiSr/CoeyvD6B8/9CZvdQqznt3E3SXPH/S2jqAWTuNv3lWCwyJIeoj8UEg/ZhQBpgQX3jTE13TPG/wri2qZbFl5dFYT0TA+tfdQT32XwTsLavjjinlzxfMq5uFwk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1361.namprd10.prod.outlook.com (2603:10b6:404:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 17:33:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 17:33:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Rick Macklem <rmacklem@uoguelph.ca>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Topic: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Index: AQHYlKIG8hnDNDQzXUuZ/p7iJwgH2615RPsAgAAqTQA=
Date:   Mon, 11 Jul 2022 17:33:04 +0000
Message-ID: <89044942-DAFE-4E9B-BC70-A8D2C847A422@oracle.com>
References: <YQBPR0101MB97421B80206B30FC32170C25DD849@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
 <DCE64EDD-FCE4-4C21-8B00-7833D5EB4EB2@oracle.com>
In-Reply-To: <DCE64EDD-FCE4-4C21-8B00-7833D5EB4EB2@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10df4975-50f5-4bc6-24f2-08da63636973
x-ms-traffictypediagnostic: BN6PR10MB1361:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VchTuida2QhDU01TcWRQzn39BtgseetQz+ZbszZid7qWSsmlA5c9S821mLEeFRUyGxr17iaU/zjaFPXyjuA37Fg2OS0EbyRQfh8981HYiSp19+2mfpFDXojqanOcAEvD6XqBaZA7Ee/dml1wdLwPY7a6ZLNHvCE4eFsoYuiMDH3NXBrz2IUWmZ1agkUHLM+0vBiVkj5dk1hMSvZsgOgC7MQ4myMpz5/1BoAaJUf0D7OT1vx7SzWdl+IsWYvGva+aujXgbmRV65Rx9v0gUsp0C56n1twD290pm7Un1rGGy/kxvG7RbgFVKqudsicJvFXZBoqE1JTo8Gs0xZ7xg8efV0FEy9WTLWdhl2x5ja8LIuWHFbjNupNCJHMezTsjz3tFB7EVSrDENgAx8lFmok+KEUvWm1sAi0ElIqQzTgdI/8CGkJn904zxcCBYFRo9urp/fBlSwwk0qLlPgMUvBFSFAMBd0V0zJnOuQd8BpFJ+1SKX7p0kH/Kg8xQczqdZhqaksO5POqwHatuonR2ElvTSe1xqQ3rUUloUYLHa3sBPYtUv2phnMWV6Y3WSCajR5PsMjjd3E2KEl5BTbhw3ev4fHJ27Cmvs2P21VsckKGkoopeLY+tlvSIlnKnDwDrO3kJRJY+DJXIoVb7EAz4Pklq8bpeH04fPDSJWMcxFfngNDn5QOFqcCDFOC8rinJkHEMACrS/LsDQJDDrIGTKPfivZmQLZJaQHpZssIasl76hMJu+wLv+WAS6wllF2be+3l+tocly/mqcQpwZ++M5fN/0Vc+rhvxUtV+BrSXKfoIrp8/RHaCCavUnwW3LZAw5PDtuRgX4bRlDKO3hQKJfMnn+ZXbHrwtHVyz9D3QWrpvMwVo+S9+QSohMR0FQgDqBmR4XU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39860400002)(366004)(136003)(26005)(2616005)(53546011)(41300700001)(6512007)(76116006)(66946007)(6506007)(186003)(8676002)(38070700005)(83380400001)(478600001)(38100700002)(66446008)(6862004)(122000001)(33656002)(5660300002)(36756003)(2906002)(8936002)(86362001)(71200400001)(316002)(6486002)(66476007)(66556008)(966005)(4326008)(64756008)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cTBQm5VVf7AvslhhQqcNyfFrXdqkhUs1OGd/BBlcIsATWz7dGmDLGlGdnjls?=
 =?us-ascii?Q?38GanufuRBRol1huhuOz0JKFyxmRcfgIQzzFP6QWJxFSfVITcXcdW7FyAsWn?=
 =?us-ascii?Q?B/jyvYDe0jWD42KHlZSOUyUzzDGVYCesSo6SIrOvn2o3kDSHx27eGVSHqY3/?=
 =?us-ascii?Q?q5rqk1w26WROilNjqY7cdJhpI/GB4dUK5pUPY4l3NLuC9vdDaFfFn04pHCa9?=
 =?us-ascii?Q?cupoKVNAJ4ZPdfFTUP5AL+44evEI7/tvQ4Gz2zybZkeMVS92hHq4a3HM+h6s?=
 =?us-ascii?Q?HCZiU2t6Ah3nW1TL4a8rkNmjykVlipXsDXGYB3Sj5UUmS0DcrvxC9bAxzPN4?=
 =?us-ascii?Q?16Mx3lgDLbGhWPBOvLdIOMLDa+7LEd5mc/VDE2ne/PXUesN9PZSoeIK7wwf8?=
 =?us-ascii?Q?NQ7kDp2c9/o/RjQamQqCILd1YpkneEzrJoxY8Qy17+GFYDyRg4EkCkBDKUEd?=
 =?us-ascii?Q?nQSs3fsliIX2Sb2WHXMlZO5Xq2aFROG6F+xPfxmvtcuUzgqW/tyw6g9m5mNp?=
 =?us-ascii?Q?wAIkQBEuM/Y8iHSlhlgvm5fcxs5o+KNgqIykP6FWZOSKQFb6rf0I3B4lsZ6g?=
 =?us-ascii?Q?C+do24BJ3Dh2A4xXbuw3noqCs4jqO/hv6LuUI1H7UsENHeTMFA5+7rrVjMmX?=
 =?us-ascii?Q?m92uZY/xhiu4wexplsPMbXMLPSOSbqQtC0ibYc2ukCaz9G8MsBmch+tttUT+?=
 =?us-ascii?Q?rRmNMmLQUS1mRcJyzMDPQEdNRPwzsj1lF1AiBjXs+d+/r48Ibibz8Mrvkzr0?=
 =?us-ascii?Q?Ui5zGRSPmAomswB7h8P1ZPEqVeeY5D6OyU5Z0u4nlhPNUrxWAY51+fY3hhh3?=
 =?us-ascii?Q?h6qe02/a/boAsyJyGFXgA3JmRt5/SyZnhW7X663Vp8Bkxl9kvk7uJOhm7w5s?=
 =?us-ascii?Q?sl711qEhRKZhCOzxlyVOvkLhvQXsjCNx0i9/SXx4u4Ag06vp6N35gFqtDta4?=
 =?us-ascii?Q?g37VQnz6GD/F7LM7DQd6ptlRvSGozlBO/3N07CkjWp8E79YpJJpFA5jN2InR?=
 =?us-ascii?Q?HsZeXzYCM55v43wnGSejKyBL2iLBpsaZQ8XVXbzbtlckWDYVqcxwRrnHSRAQ?=
 =?us-ascii?Q?hUaASRBFiP37UYQ1I7YjJudgJcFG1pGRgpKQEeZxDBpDFFlciLxfqmb+7dRb?=
 =?us-ascii?Q?RUONW3sBEIiu6FbA755GF9wrlmHdD8t/kHJB3yB6zhDT1pMId90goqKJ0wQR?=
 =?us-ascii?Q?L0kK5CG3TujmGKDaCqIyNIbAsJM5Pgy0ySRbftZggyN3odsOpfJYF6fGeFfS?=
 =?us-ascii?Q?i06I0WlEC3xC+/O5glVG3PwrbU9peiNiLFTQOO31RI2W75+3RJvqXXiKAWkd?=
 =?us-ascii?Q?w/oTLeHZoVnMeLb7NaRaHevEPKHKw7v/h5dE7rmA/LT/qPK6T2r2+mCyPI5n?=
 =?us-ascii?Q?zjFly2pr+gbZuJbegZMfCHMy7Y4dlD7oD3s2xnVOYA6MTLQYOnCa16MD9/zz?=
 =?us-ascii?Q?o/QXgavg+MmrA6q9p3C9ObKdOnOkFEwDBOMZh1QmdB/Gcrx1BaspDRdvyb7k?=
 =?us-ascii?Q?CN4BK6LMteuVOZJoUgk27wgucp3cBroMRAolrzOj4vJR1rbq35cf2xu6JUyl?=
 =?us-ascii?Q?crxiodt8l1yYiy+cpipeEZbrm8EUqmYTUtg2XPYX1T57a2lftom+WoPWmPd+?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1098497E6CC84B48A73A17A9AD12BC9D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10df4975-50f5-4bc6-24f2-08da63636973
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 17:33:04.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GQyivgnRADGZs4GxIDb0Jiteo9dbT+r9oaJ+UmLXqhD5DnPJRZ0RRQYSLLOaJ2n/P2ulEzAgz2E6TnCpQs7Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1361
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_21:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110074
X-Proofpoint-GUID: rJo29vaENGGPpNuY8VcyEowuHfMQ62y-
X-Proofpoint-ORIG-GUID: rJo29vaENGGPpNuY8VcyEowuHfMQ62y-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2022, at 11:01 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>=20
>=20
>> On Jul 10, 2022, at 6:10 PM, Rick Macklem <rmacklem@uoguelph.ca> wrote:
>>=20
>> Hi,
>>=20
>> I have been trying to improve the behaviour of the FreeBSD
>> NFSv4.1/4.2 client when using the "intr" mount option.
>>=20
>> I have come up with the following scheme:
>> - When RPCs are interrupted, mark the session slot as potentially bad.
>> - When all session slots are marked potentially bad, do a
>> DestroySession (only op in RPC) to destroy the session.
>> - When the server replies NFS4ERR_BAD_SESSION,
>> do a CreateSession (only op in RPC) to acquire a new session and
>> continue on.
>>=20
>> When testing against a Linux 5.15 server, the CreateSession
>> succeeds, but returns the same sessionid as the old session.
>> Then all subsequent RPCs get the NFS4ERR_BAD_SESSION reply.
>> (The client repeatedly does CreateSession RPCs that reply NFS_OK,
>> but always with the same sessionid as the destroyed one.)
>>=20
>> Here's what I see in the packet trace:
>> (everything works normally until all session slots are marked
>> potentially bad at packet# 14216)
>> packet# RPC
>> 14216 DestroySession request for sessionid 2725cb62002ed418040...0
>> 14302 DestroySession reply NFS_OK
>> 14304 Getattr request (using above sessionid)
>> 14305 Getattr reply NFS4ERR_BAD_SESSION
>> 14306 CreateSession request
>> *** Now here is where I see a problem...
>> 14307 CreateSession reply NFS_OK with sessionid=20
>> 2725cb62002ed418040...0 (same as above)
>> 14308 Getattr request (using above sessionid)
>> 14309 Getattr reply NFS4ERR_BAD_SESSION
>> - and then this just repeats...
>> The whole packet trace can be found here, in case you are interested:
>> https://people.freebsd.org/~rmacklem/linux.pcap
>>=20
>> It seems to me that a successful CreateSession should always return
>> a new unique sessionid?
>=20
> Hi Rick, thanks for the bug report.
>=20
> CREATE_SESSION has a built-in reply cache to thwart replay attacks.
> It can legitimately return the same sessionid as a previous request.
> Granted, DESTROY_SESSION is supposed to wipe that reply cache...
>=20
> I'd like to see if there's a test in pynfs that replicates or is close
> to the series of operations in your trace so that I can reproduce on
> my lab systems and watch it fail up close.

I constructed a pynfs test that does something similar to your
reproducer:

diff --git a/nfs4.1/server41tests/st_destroy_session.py b/nfs4.1/server41te=
sts/st_destroy_session.py
index b8be62582366..014330e7d623 100644
--- a/nfs4.1/server41tests/st_destroy_session.py
+++ b/nfs4.1/server41tests/st_destroy_session.py
@@ -1,12 +1,33 @@
 from .st_create_session import create_session
 from xdrdef.nfs4_const import *
-from .environment import check, fail, create_file, open_file
+from .environment import check, fail, create_file, open_file, close_file
 from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_clai=
m4
 import nfs_ops
 op =3D nfs_ops.NFS4ops()
 import threading
 import rpc.rpc as rpc
=20
+def testDestroyBasic(t, env):
+    """Ensure operations outside a session fail with BADSESSION
+
+    FLAGS: destroy_session all
+    CODE: DSESS1
+    """
+    c =3D env.c1.new_client(env.testname(t))
+    sess1 =3D c.create_session()
+    sess1.compound([op.reclaim_complete(FALSE)])
+    res =3D c.c.compound([op.destroy_session(sess1.sessionid)])
+    res =3D create_file(sess1, env.testname(t),
+                      access=3DOPEN4_SHARE_ACCESS_READ)
+    check(res, NFS4ERR_BADSESSION)
+    sess2 =3D c.create_session()
+    res =3D create_file(sess2, env.testname(t),
+                      access=3DOPEN4_SHARE_ACCESS_READ)
+    check(res)
+    fh =3D res.resarray[-1].object
+    open_stateid =3D res.resarray[-2].stateid
+    close_file(sess2, fh, stateid=3Dopen_stateid)
+
 def testDestroy(t, env):
     """
    - create a session

I'm not able to reproduce the problem on 5.19-rc5, but that
probably means there's something going on that we haven't
discovered yet.


--
Chuck Lever



