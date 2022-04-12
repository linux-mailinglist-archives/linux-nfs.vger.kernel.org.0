Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FEA4FE465
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349796AbiDLPQJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiDLPQI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 11:16:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B185DA01
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 08:13:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CEdUKi032238;
        Tue, 12 Apr 2022 15:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uhZN3L8t3QuI7tqlYkC8wDGav2q9ujLaSM9i3j82lAo=;
 b=ibu/Fyqj0R5kYR13RPVa/QcyPZgM/ULknCa5L0btkJQCe4uFS/dI7PDMgGHW7bJXJpLn
 vPJJPVUAjDcr/rbm6euVvu8oeCy1Zq5b0LmgX0DH/enjL+RTKb8HadeB6eNcAeVOJePv
 RZr4+1MqNaWLa9td+Rwye43ESs47aVITulveFCKJBJNJjNxVUbMIq+TcKjltdBbL4EYI
 B6juOAG/5Og7etxp6QdZaRDABS8SyqDplssKkcR/Mv9iuBAgtET4aSwmE0GZ8ox9wXg5
 9WnJ1VwoumO1xsp+DcatW1vuXQKFtkZ0/Fras1l0lt/gl3vSCOY+b79KIBqGH4AOYcEr PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd6y39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 15:13:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23CEvFW0031772;
        Tue, 12 Apr 2022 15:13:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k2p525-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 15:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enBlHOvPpucTqKUxxmrra5SM59PT/mM64hpCNg2iNGVYFdNk2p6bWVCRzNL2XSHMDsbSD2Kj7x62CvkZ8dtSdySG8mSOYjjx7Kc9GBr6POdxJMqSDU6Oxi+/uQbq7tIA9ZJpLXQSlMeGrk6c7OLaMKZ07+IX0iq8PeNftNI+9kYT1/9o778FyBde5NfGVrjLUvhl9mW0tGPapusfpGoJ0pDRblG5adNIm9Ka6ub591XnKsVSo6EXXmXRHH0SQdfD6A3KFSySVIFu74ezpFLxOTYKeUYozFt9vwrRoStnk7ef97EiPizu2N+Xc1JFIyEmPgDNGKqRjseb9MOm+z2P2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhZN3L8t3QuI7tqlYkC8wDGav2q9ujLaSM9i3j82lAo=;
 b=TW5Am+AsH3khSDJDJu0zJXwVv3LhuecFI+isRM5SAHHSDOw4+Uuo3vL4X6WgP1+3fHtv3cErlSWVaXfazNr/3OMVEApIjlrD3a7dEanCxw9gD77RA1g5R0nzW5u6CFT/sRNDsPUscNJ+OP2tW96Xo9IeI+4hQUg2flMod+f5g9j38Xxnpc2vlMaTfvAdOolxN/Hq5jvcJ/bWgB3ZxUxl57HtqToioN0MPIoj1FA7MzwspwHqKJ0m8rgiAauPv9fTAEDjw4Ljkj+kJ9K2aHB3faNX51nYA4IdmT7vqYb+t/Geng/HOR1O5dgnx3oCCLOzXMpg2R7WrGTZvPAylanzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhZN3L8t3QuI7tqlYkC8wDGav2q9ujLaSM9i3j82lAo=;
 b=izeTXXUupC60qsZ9ieKB8yuaEjltUTAju/gO+5ZOT3Gn0V2/4qvCY8bMVtu7rlNMxxb12A/4tcT+SkzEUDLTEAzzt3SvsvrXtcQAqlh8Y0Lc+PimHNPOXmznR0t/TSIOcweJIqz7ESyxDQQUTxfU1Parsn6qSNoyTri5wSBeUOk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 15:13:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 15:13:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Add an explanation of NFSv4 client
 identifiers
Thread-Topic: [PATCH] Documentation: Add an explanation of NFSv4 client
 identifiers
Thread-Index: AQHYTeNKNj3im2ccyUWrdlE9NE+XpKzr2+yAgACIEgA=
Date:   Tue, 12 Apr 2022 15:13:39 +0000
Message-ID: <4918188E-9271-47F2-8F5A-D6D5BEB85F36@oracle.com>
References: <164970912423.2037.12497015321508491456.stgit@bazille.1015granger.net>
 <164974719723.11576.583440068909686735@noble.neil.brown.name>
In-Reply-To: <164974719723.11576.583440068909686735@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7e29530-c880-453e-1c12-08da1c97061d
x-ms-traffictypediagnostic: SA2PR10MB4745:EE_
x-microsoft-antispam-prvs: <SA2PR10MB47451BE4D1B84D4DC9D054E393ED9@SA2PR10MB4745.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWuAE+5szx+8xFNrvGkeXaM6R0KiLGa0p3ekLY+4EaaNMjC5MftZhTTmynCpmuMKJGt63mYtbv5L+DMkt2G7diAjUX3SJkxeUd9MewQNDkLMWfZV3hNSyFGPAuJq1NLMLA9ViRBuyji3eBfXqtgkJWVHpK3fleFTmnBlsJgH4v2QHn2W6wQoAfpQZvgAcYTsRM8jtGTx+F+yK5b3OKt4Qk1VglCjllgUdycYLUt7FVsve1wpe8M0L7s/z8849gxrkLWyKPErpLR/8HKVPC0GGRGH+iHQ5J3vDIvtp9eYaHG6/ZT2ORqWY33d0PiC0i/HDlgEHW/boMMHxTKQUQ0nN0GsLBgRme9pNCq3lrm1TBSw3E1s4Mdj37tPUg7WdRDtkoNbQCa7j/dCrrFIlZWCJWj3ADtWA4Wfbx2J35pkvuGrH5NOM2ybI+9c2ZzFRjJ8vmNsPXXmpnoZitWqlhcDaoblnMR5yvobpdW6/XinyjMybAa72AB/dOIQJSw+9BZaZjh4/tSSt00jGVPuVGLMAVfOlSPOpVnQEgkSY3yt54t7DThLgvdbbCNDVtJjMCkhePvxbtJ1Nk4qF2/tP4tIckgnopBf9P6dWdzgBB/JZLRF3I8eR2YAPTIlNAvHyDFw69jzuWpzBUXK16Kj7+hWU8lLlh5YOhsK7UyafvWYtLxqclCUFbJdKN+VBtbX2rJL5mXjDgcRfuh7miBTG767ln0q6xHnzzaHRmCOlfkE0n2Jkingo3gfqg5PGP64QxWw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(38100700002)(8676002)(64756008)(122000001)(66446008)(66556008)(66476007)(4326008)(76116006)(66946007)(2906002)(8936002)(91956017)(6506007)(26005)(186003)(83380400001)(2616005)(36756003)(316002)(6916009)(6512007)(33656002)(53546011)(6486002)(30864003)(38070700005)(508600001)(86362001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w9MMtNpgDobVb3ni1Hi6qUU2lpAMWPpojeLn+3hde6EdrgZFIBK/SzXd7Tnm?=
 =?us-ascii?Q?v1HQwUjl8XzlyZdltiyw7wIErGJ5czzz5FKsHlrB0nVK+zBmhQsPNiMzAI3O?=
 =?us-ascii?Q?6ZHZNpJXHdO2nYTlHLhu5EYNqzKhgCaf9+09EOQEDljrUjbyTK/c4/HPLzEF?=
 =?us-ascii?Q?XMnVOrjVNnnBd6g3yLxoi/YcMl0N4aVQ8JD99Soub7gCFCXbQpQ321OCHS8+?=
 =?us-ascii?Q?pdb/sYFf3T7rlScDRW5fmFuJx33QsmezhWVej6VnRXiQ+Rdgj1ro6qRwEtoL?=
 =?us-ascii?Q?DMkbR6uo99xkTuSapoLhPxvvQnNRISh7jViKmeE/aO6P55G4aVDDANYCOoq7?=
 =?us-ascii?Q?4Elt3uBFlB5HDrMey9riz7sAVuUFUaXHZ95znkr8g29lPeRJgqEwrc3QjCeo?=
 =?us-ascii?Q?EhLJZvfRxvVzTqPufb0dYyjVKQyqI2YfZ1I6rOSnYr2TJudMT2dS4VW9QXcG?=
 =?us-ascii?Q?tnmNWUHgO7ILABOptag7P63X/41+MSslkLXlaWguLexs1POl9O4kXAx2yKCf?=
 =?us-ascii?Q?maQviOxWMbQgVY4iNeAGZk7PJqjnvH5IaDkcYMNL94XDUfL62tElE41KEhEG?=
 =?us-ascii?Q?h6DgXHKYTI7U9hKNz0NIs4ttOaeDt1YDiZRv2XKiZUkJc+gGLPGhiwuMaka2?=
 =?us-ascii?Q?WFDnFgETYHh/2ZHnZiszqKfgRQztkULkt42LLNM2KTWIUgEMN6tI9vd0dLdC?=
 =?us-ascii?Q?7n+k6gQsGrcSiJKNYvvAOHMizxVuhk+8cWyurT+3/YXPKzgGYwUULuqlHUh0?=
 =?us-ascii?Q?iV8XQ72T9coy2QQR6vAE2YeXBCjHNYFLDTBAr5IWgslyjzbDwksL+9V86nKG?=
 =?us-ascii?Q?x9Xpv5miD5XMkQGPkv87jiNhihL1CIS58kdYn7wjOJaB4TR75HQsylSRU5Fk?=
 =?us-ascii?Q?z7W+To/ZCR7LlfKaApj7P3xBJkf/aNEx+Lbz9rPAQnT4/XFYmoWH03XQbfxm?=
 =?us-ascii?Q?Z8DhRvYk1yJ+7qYnLDsBsBx/SQqtm67XzsqziyCvAWBA61aMndnWYaloYOoC?=
 =?us-ascii?Q?1yzEw8h0jp3eTwFD9+fMwKrfPK+iuuDgHzU8aM6+ihXCPgDPmRkQ/7tHy87m?=
 =?us-ascii?Q?AmJfc0oGHWOtLYbAFIS9a9y7Cw6YGQgrB4MJEB+zabP+8UXE+zX4milMBLmT?=
 =?us-ascii?Q?Gk+RQcc3nJWL3pvfSjOVJfL2QgFNQWXe4ABRKKsdxQiI4MMllTYRcgAti4mv?=
 =?us-ascii?Q?JlWlj/rNyzgTxSFaQrX24zJoNoLaREybdTXXe+C0ISxclcgzsrCeRL0NKlJf?=
 =?us-ascii?Q?sQkdq+zzEET2Y8tN1BPBuLYqHQehfCf1Hez6VzibL/9vVL3srEDvctNdzmow?=
 =?us-ascii?Q?wLaYOno4gAuMjxlfi9NrTVHz5I7ce9RPqAbwxRtVFj38O/rENsVLLsiB2EHS?=
 =?us-ascii?Q?ly6/kOv90JKUr6Ryyy6XCBicLJei2EZHcqCLzBle9+bJWSSpcjILbG+aZDaK?=
 =?us-ascii?Q?t8AM7VUXZnhnkQlCuitEjtfdKuuoNoqRgtJqcEJe0q2bVdufvpcv4B6u236g?=
 =?us-ascii?Q?56C1WHQ1C9fWcvMPG98QhgLxsfgGo6HgVwPSMT11QsBvXVrYf6lHax3aNiRo?=
 =?us-ascii?Q?isfji6HxMo7xWDCZWBjediXfhbrbtCuKl0WGW1SiyCQB9JHS4FZGA94hj4LI?=
 =?us-ascii?Q?eW95aTD1I8l/hZMEhIp7gp6m1VT6hO+4WdnbQneHpS9xp9xRgVGXAZ0UWXYD?=
 =?us-ascii?Q?Vja4A8vJz+koOBeX0ibmL7X1PH0YPdFyVRlek4BrRkJ5oI53hVvQ5Y5jwWUO?=
 =?us-ascii?Q?aiLiXzB1TL4CvyZFbB1kBwurSvRjSo8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B76D4148D97F174A98AFE236ED37185D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e29530-c880-453e-1c12-08da1c97061d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 15:13:39.3932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaAZRpGBNLcQNVh6DYV2S6bwBtZwf2WUFc+UYbfP22xypSw0pbEGX+CTnVgaQY2d1+xNCJzdzUiaA/+myULf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_05:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120073
X-Proofpoint-ORIG-GUID: UFy8PXlAKJ_dVW6R9NGPCPWpwxTxljUA
X-Proofpoint-GUID: UFy8PXlAKJ_dVW6R9NGPCPWpwxTxljUA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 12, 2022, at 3:06 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 12 Apr 2022, Chuck Lever wrote:
>> To enable NFSv4 to work correctly, NFSv4 client identifiers have
>> to be globally unique and persistent over client reboots. We
>> believe that in many cases, a good default identifier can be
>> chosen and set when a client system is imaged.
>>=20
>> Because there are many different ways a system can be imaged,
>> provide an explanation of how NFSv4 client identifiers and
>> principals can be set by install scripts and imaging tools.
>>=20
>> Additional cases, such as NFSv4 clients running in containers, also
>> need unique and persistent identifiers. The Linux NFS community
>> sets forth this explanation to aid those who create and manage
>> container environments.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> .../filesystems/nfs/client-identifier.rst          |  212 ++++++++++++++=
++++++
>> Documentation/filesystems/nfs/index.rst            |    2=20
>> 2 files changed, 214 insertions(+)
>> create mode 100644 Documentation/filesystems/nfs/client-identifier.rst
>>=20
>> diff --git a/Documentation/filesystems/nfs/client-identifier.rst b/Docum=
entation/filesystems/nfs/client-identifier.rst
>> new file mode 100644
>> index 000000000000..5d056145833f
>> --- /dev/null
>> +++ b/Documentation/filesystems/nfs/client-identifier.rst
>> @@ -0,0 +1,212 @@
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +NFSv4 client identifier
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +This document explains how the NFSv4 protocol identifies client
>> +instances in order to maintain file open and lock state during
>> +system restarts. A special identifier and principal are maintained
>> +on each client. These can be set by administrators, scripts
>> +provided by site administrators, or tools provided by Linux
>> +distributors.
>> +
>> +There are risks if a client's NFSv4 identifier and its principal
>> +are not chosen carefully.
>> +
>> +
>> +Introduction
>> +------------
>> +
>> +The NFSv4 protocol uses "lease-based file locking". Leases help
>> +NFSv4 servers provide file lock guarantees and manage their
>> +resources.
>> +
>> +Simply put, an NFSv4 server creates a lease for each NFSv4 client.
>> +The server collects each client's file open and lock state under
>> +the lease for that client.
>> +
>> +The client is responsible for periodically renewing its leases.
>> +While a lease remains valid, the server holding that lease
>> +guarantees the file locks the client has created remain in place.
>> +
>> +If a client stops renewing its lease (for example, if it crashes),
>> +the NFSv4 protocol allows the server to remove the client's open
>> +and lock state after a certain period of time. When a client
>> +restarts, it indicates to servers that open and lock state
>> +associated with its previous leases is no longer valid.
>=20
> Add "and can be removed immediately" This makes is clear how the two
> sentences in the para relate.
>=20
>> +
>> +In addition, each NFSv4 server manages a persistent list of client
>> +leases. When the server restarts, it uses this list to distinguish
>> +between requests from clients that held state before the server
>> +restarted and from clients that did not. This enables file locks to
>> +persist safely across server restarts.
>=20
> I still think this is a bit misleading.  It distinguished between
> clients, not between requests.  I would prefer:
>=20
>  When the server restarts client will attempt to recover their state.
>  The server uses this list to distinguish between clients with state
>  that can still be recovered and clients which don't - possibly because
>  their state expired before the server restart.
>=20
>=20
>> +
>> +NFSv4 client identifiers
>> +------------------------
>> +
>> +Each NFSv4 client presents an identifier to NFSv4 servers so that
>> +they can associate the client with its lease. Each client's
>> +identifier consists of two elements:
>> +
>> +  - co_ownerid: An arbitrary but fixed string.
>> +
>> +  - boot verifier: A 64-bit incarnation verifier that enables a
>> +    server to distinguish successive boot epochs of the same client.
>> +
>> +The NFSv4.0 specification refers to these two items as an
>> +"nfs_client_id4". The NFSv4.1 specification refers to these two
>> +items as a "client_owner4".
>> +
>> +NFSv4 servers tie this identifier to the principal and security
>> +flavor that the client used when presenting it. Servers use this
>> +principal to authorize subsequent lease modification operations
>> +sent by the client. Effectively this principal is a third element of
>> +the identifier.
>> +
>> +As part of the identity presented to servers, a good
>> +"co_ownerid" string has several important properties:
>> +
>> +  - The "co_ownerid" string identifies the client during reboot
>> +    recovery, therefore the string is persistent across client
>> +    reboots.
>> +  - The "co_ownerid" string helps servers distinguish the client
>> +    from others, therefore the string is globally unique. Note
>> +    that there is no central authority that assigns "co_ownerid"
>> +    strings.
>> +  - Because it often appears on the network in the clear, the
>> +    "co_ownerid" string does not reveal private information about
>> +    the client itself.
>> +  - The content of the "co_ownerid" string is set and unchanging
>> +    before the client attempts NFSv4 mounts after a restart.
>> +  - The NFSv4 protocol does not place a limit on the size of the
>> +    "co_ownerid" string, but most NFSv4 implementations do not
>> +    tolerate excessively long "co_ownerid" strings.
>=20
> RFC5661 declares:
>   struct client_owner4 {
>           verifier4       co_verifier;
>           opaque          co_ownerid<NFS4_OPAQUE_LIMIT>;
>   };
> and
>   const NFS4_OPAQUE_LIMIT         =3D 1024;
>=20
> so I think there is a clear limit that must be honoured by both sides.
>=20
>> +
>> +Protecting NFSv4 lease state
>> +----------------------------
>> +
>> +NFSv4 servers utilize the "client_owner4" as described above to
>> +assign a unique lease to each client. Under this scheme, there are
>> +circumstances where clients can interfere with each other. This is
>> +referred to as "lease stealing".
>> +
>> +If distinct clients present the same "co_ownerid" string and use
>> +the same principal (for example, AUTH_SYS and UID 0), a server is
>> +unable to tell that the clients are not the same. Each distinct
>> +client presents a different boot verifier, so it appears to the
>> +server as if there is one client that is rebooting frequently.
>> +Neither client can maintain open or lock state in this scenario.
>> +
>> +If distinct clients present the same "co_ownerid" string and use
>> +distinct principals, the server is likely to allow the first client
>> +to operate normally but reject subsequent clients with the same
>> +"co_ownerid" string.
>> +
>> +If a client's "co_ownerid" string or principal are not stable,
>> +state recovery after a server or client reboot is not guaranteed.
>> +If a client unexpectedly restarts but presents a different
>> +"co_ownerid" string or principal to the server, the server orphans
>> +the client's previous open and lock state. This blocks access to
>> +locked files until the server removes the orphaned state.
>> +
>> +If the server restarts and a client presents a changed "co_ownerid"
>> +string or principal to the server, the server will not allow the
>> +client to reclaim its open and lock state, and may give those locks
>> +to other clients in the mean time. This is referred to as "lock
>> +stealing".
>=20
> This is not a possible scenario with Linux NFS client.  The client
> assembles the string once from various sources, then uses it
> consistently at least until unmount or reboot.  Is it worth mentioning?

Neil, thanks for the eyes-on. I've integrated the other suggestions
in your reply. However there are some corner cases here that I'd
like to consider before proceeding.

Generally, preserving the cl_owner_id string is good defense against
lock stealing. Looks like the Linux NFS client didn't do that before
ceb3a16c070c ("NFSv4: Cache the NFSv4/v4.1 client owner_id in the
struct nfs_client").

If a server filesystem is migrated to a server that the client hasn't
contacted before, and the client's uniquifier or hostname has changed
since the client established its lease with the first server, there
is the possibility of lock stealing during transparent state migration.

I'm also not certain how the Linux NFS client preserves the principal
that was used when a lease is first established. It's going to use
Kerberos if possible, but what if the kernel's cred cache expires and
the keytab has been altered in the meantime? I haven't walked through
that code carefully enough to understand whether there is still a
vulnerability.


>> +
>> +Lease stealing and lock stealing increase the potential for denial
>> +of service and in rare cases even data corruption.
>> +
>> +Selecting an appropriate client identifier
>> +------------------------------------------
>> +
>> +By default, the Linux NFSv4 client implementation constructs its
>> +"co_ownerid" string starting with the words "Linux NFS" followed by
>> +the client's UTS node name (the same node name, incidentally, that
>> +is used as the "machine name" in an AUTH_SYS credential). In small
>> +deployments, this construction is usually adequate. Often, however,
>> +the node name by itself is not adequately unique, and can change
>> +unexpectedly. Problematic situations include:
>> +
>> +  - NFS-root (diskless) clients, where the local DCHP server (or
>> +    equivalent) does not provide a unique host name.
>> +
>> +  - "Containers" within a single Linux host.  If each container has
>> +    a separate network namespace, but does not use the UTS namespace
>> +    to provide a unique host name, then there can be multiple NFS
>> +    client instances with the same host name.
>> +
>> +  - Clients across multiple administrative domains that access a
>> +    common NFS server. If hostnames are not assigned centrally
>> +    then uniqueness cannot be guaranteed unless a domain name is
>> +    included in the hostname.
>> +
>> +Linux provides two mechanisms to add uniqueness to its "co_ownerid"
>> +string:
>> +
>> +    nfs.nfs4_unique_id
>> +      This module parameter can set an arbitrary uniquifier string
>> +      via the kernel command line, or when the "nfs" module is
>> +      loaded.
>> +
>> +    /sys/fs/nfs/client/net/identifier
>> +      This virtual file, available since Linux 5.3, is local to the
>> +      network namespace in which it is accessed and so can provide
>> +      distinction between network namespaces (containers) when the
>> +      hostname remains uniform.
>> +
>> +Note that this file is empty on name-space creation. If the
>> +container system has access to some sort of per-container identity
>> +then that uniquifier can be used. For example, a uniquifier might
>> +be formed at boot using the container's internal identifier:
>> +
>> +    sha256sum /etc/machine-id | awk '{print $1}' \\
>> +        > /sys/fs/nfs/client/net/identifier
>> +
>> +Security considerations
>> +-----------------------
>> +
>> +The use of cryptographic security for lease management operations
>> +is strongly encouraged.
>> +
>> +If NFS with Kerberos is not configured, a Linux NFSv4 client uses
>> +AUTH_SYS and UID 0 as the principal part of its client identity.
>> +This configuration is not only insecure, it increases the risk of
>> +lease and lock stealing. However, it might be the only choice for
>> +client configurations that have no local persistent storage.
>> +"co_ownerid" string uniqueness and persistence is critical in this
>> +case.
>> +
>> +When a Kerberos keytab is present on a Linux NFS client, the client
>> +attempts to use one of the principals in that keytab when
>> +identifying itself to servers. Alternately, a single-user client
>> +with a Kerberos principal can use that principal in place of the
>> +client's host principal.
>=20
> I think this happens even when "-o sec=3Dkrb?" isn't requested.  Is that
> correct?  Is it worth stating that here?  I guess the next paragraph
> suggests it, but making more explicit could help.
>=20
>> +
>> +Using Kerberos for this purpose enables the client and server to
>> +use the same lease for operations covered by all "sec=3D" settings.
>> +Additionally, the Linux NFS client uses the RPCSEC_GSS security
>> +flavor with Kerberos and the integrity QOS to prevent in-transit
>> +modification of lease modification requests.
>> +
>> +Additional notes
>> +----------------
>> +The Linux NFSv4 client establishes a single lease on each NFSv4
>> +server it accesses. NFSv4 mounts from a Linux NFSv4 client of a
>> +particular server then share that lease.
>> +
>> +Once a client establishes open and lock state, the NFSv4 protocol
>> +enables lease state to transition to other servers, following data
>> +that has been migrated. This hides data migration completely from
>> +running applications. The Linux NFSv4 client facilitates state
>> +migration by presenting the same "client_owner4" to all servers it
>> +encounters.
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D
>> +See Also
>> +=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +  - nfs(5)
>> +  - kerberos(7)
>> +  - RFC 7530 for the NFSv4.0 specification
>> +  - RFC 8881 for the NFSv4.1 specification.
>> diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/fil=
esystems/nfs/index.rst
>> index 288d8ddb2bc6..8536134f31fd 100644
>> --- a/Documentation/filesystems/nfs/index.rst
>> +++ b/Documentation/filesystems/nfs/index.rst
>> @@ -6,6 +6,8 @@ NFS
>> .. toctree::
>>    :maxdepth: 1
>>=20
>> +   client-identifier
>> +   exporting
>>    pnfs
>>    rpc-cache
>>    rpc-server-gss
>>=20
>>=20
>>=20
>=20
>=20
> Generally good - just a few suggestions to consider.
>=20
> Thanks,
> NeilBrown

--
Chuck Lever



