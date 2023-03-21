Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585046C33B9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 15:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCUOJN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 10:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCUOJM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 10:09:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3683BD50F
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 07:09:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LE5Iww021684;
        Tue, 21 Mar 2023 14:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zuY4j7YaPsICGjI556LIHAzUeOH8/6xKDwraUYtclzE=;
 b=PQYSLLqZECcYdJLeuUQDgEDC5BzDTtyhCqJpkinyJ3rZ+HZx+lUeLIQrb4plbY/PAYul
 ySt6/giP6JHirr69aN3qwhEycZBN58dJuZ27Ikwe/qhtAqcdU2AmKUsYHESnWNZE0Dry
 ONnx1Y6z9TxA30vi+8dIROm5UXMXl5cLKIUOwjYTCZs/qAE9vSXbidglO5owogfql3gp
 aIX5yguHosP9FgmpwFwBY8mzCz5EO5jvwlVfaWtwLUs/Ugtehe1cQnpgxPgAdk1RP9ut
 SGNS3QXJv5EvCjpxYTLTYLRTFUkTXDS2ZtcIzVBC/uW2h+WN/QYyxcH6GnUn3tzfrRmq QA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56ax84c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:09:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LDXSAY038857;
        Tue, 21 Mar 2023 14:08:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3rd9b6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I47DCFORKaivMbIZDFM9pyytnYhWD/9I35sbWlscv4EkkrYi/28JqIgoWd5qVf4Nv51mq3Mfg0vjIEWNhOsVzxzJKeVQ+rmSUETWttsyZsS/hmsoBwbpAFSQLZTdVmDH70n/VXP3ggsk1wGPPcwMzn7SmGlSW7WoFtXxvThGClN0/q042cnBmZMX/355ZIKiNLEZVvMetSRE5bf2sZiDrjA7ED2ygEk/L6i9jML8Iuum+mBYCGBqDiwSBUyQnhTyXSViSSoFR0r22H0HEzqEvynbAllysC142u5ji5mNX9Ilmz6H97PAswdkkZObnJkUSX6s+KgUcnYYl0xIBa8YMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuY4j7YaPsICGjI556LIHAzUeOH8/6xKDwraUYtclzE=;
 b=krsKxXYsZ4tXttaKXJUhTNGwZnP19EKZf3CjvaIX/IFsarpDURK2UGT1LlE3FpSRnSVF/KMbleUoy52bdbvlEQgc/6f839rfzRrGIsJctW7SV6GRooVI/RdBfEVjUjuHIp8x/+/YtjNTmnbOYWsdEkCAHTZ2tcuqt8xUmwz3I+LjIDCuJbt9y/GPQ3wMCCkuXshPiZTLGqTOAUxcbD/nMKi8oBLoTr3lQ5reDchk5xhIl+s9VyUPiScJSLIJQ3F6MavHFkGWWQBZ7vpYbO+b5wogucGcoi6dhHF/fVT4wuc86ail1RFxsDVPlrLMjbW1jOuDnbWTJn5ibte9epdSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuY4j7YaPsICGjI556LIHAzUeOH8/6xKDwraUYtclzE=;
 b=utEWl6O3wrjOZaG7Fz3J5E/opfJpoqTUbm1NCX2TCTuy6OVijTksoFCkdqGwUlrolWLH9FGlwiM4AMO1sxCqek3UnFGruWDe7mvAsleIjH9YzF2CzAR6LyrTywL58uSAWE7hnS6y4NnkhIDigIfbQ41Ejw1xMmc/H8B/R4p1DKE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4276.namprd10.prod.outlook.com (2603:10b6:a03:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:08:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:08:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>, Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] exports.man: Add description of xprtsec= to
 exports(5)
Thread-Topic: [PATCH v1 4/4] exports.man: Add description of xprtsec= to
 exports(5)
Thread-Index: AQHZWzlKnU6bBsg80EiOcgBHLeoXOa8FJI0AgAAiVwA=
Date:   Tue, 21 Mar 2023 14:08:55 +0000
Message-ID: <00B8D419-0F7F-43FB-8DA1-5C6BD93DE1A7@oracle.com>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
 <167932295124.3437.894267501240103990.stgit@manet.1015granger.net>
 <fdfa374a7d5072c9b4606476b52f049a6a165ef9.camel@kernel.org>
In-Reply-To: <fdfa374a7d5072c9b4606476b52f049a6a165ef9.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4276:EE_
x-ms-office365-filtering-correlation-id: cda9b6ea-108c-4dcb-6f88-08db2a15cee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1NhO+fVssKNg9h62Z+BkTkwurOdiRNxRJ/GVqnoUH8mn/SMzEGe5hhowsmxjuKTCUnEwKkeTnaZTEQh+Cu2wQgOm2RdtpzgRFi0Gx3EDT/bzxZvffDhYjYbS98RdlmUE8h6jXxJubemZG6C5s5XAdh0MHzfabCzAFHoBHIMncejCoXoY2WPyLasq8odJd9v10CusSlUEVB1Se4F8EVF6jEocmRG0B4PUf3IAGLoyJnRu+Xh3CyELvn7Raz5sZ40itWTZ9W8SwM6gvfpQZuZx/LQoMBQAs7MXol7OXLGSG3L8rGV48K/G3pqiZy8a67lglMCNFiX3FPsTnFJo07Sk3Jst0TN9g1vLK1zBRVovm2TwZ+zbI/gy0LAcvh5S9QEHyZhVm3vtEr+NiIW7D0sfWiv6TEzGrUQIIYAJYl3rvD7vH9iqqsmoZSa+eqaDLR2gNr5gXpA6qXDnV5b7rXgDSU3m8g+dVHEOJx8JZ702V3Q4QmEWyVm8yG4QxSGqg3CY/S0A4kcOC1qxgCQSIuyJ4jEmpStTD9OhsPp2NIEsP4AqMim0q9pMYEYGjRipfiuoqSU9AZNgHNPDldLnjBp8EEGWwpaAQiXpPprHSqLAozpP15Aw82nwY4ycP+VYXtsShlAO4YXcQynkDhVx6IAQK46Gjl1e87ZJoMcNGkFoYH59RNLLswzNaP7oa/GCCk6Kb+eOsAih3Ri3d05IjxbmByNq6fVFxHlpIILEh6idguY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199018)(8936002)(5660300002)(41300700001)(86362001)(38070700005)(33656002)(36756003)(38100700002)(2906002)(122000001)(4326008)(6486002)(478600001)(83380400001)(71200400001)(2616005)(186003)(53546011)(6506007)(6512007)(26005)(66899018)(54906003)(66476007)(91956017)(316002)(66946007)(8676002)(6916009)(64756008)(66556008)(76116006)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h1LjIn20s+F9IU2Lp/os1R/7WkyDH1YZzKu1VQmvw2LoaQv5GAWmAWaizR6Z?=
 =?us-ascii?Q?Ls9WeZxmBqzBGSjXciATEtIYCIu/XXwXV6A95WQZ1Xy+5GCvLtwLMnuPJeZa?=
 =?us-ascii?Q?TMYo9LyPh6p9FJQbXU93OkKirxIvZszA6+ZP+nbZ8vSC1BbxF/qyPQeFuOHR?=
 =?us-ascii?Q?bvztiI6dtnIZm8XUZD6M8cu2sroZTedwKwXGG7YUH9xJ7nI5kSI8UF+N9r8R?=
 =?us-ascii?Q?O9vJqnPKl2BR62t9860bHJ5aRk+SWqu3BJ0Fs67hnGMxSlm4iUJGbGu923tg?=
 =?us-ascii?Q?3OSnb7NuHNZbdwO3eWb4QR5np/yK0PP7zG0lZCu2FH/7v0C/OV7X90+dl/tM?=
 =?us-ascii?Q?r/hmrB1Sp96TUeWJsB5EzkmxPyILESaEIS00J0jcnq3Ibhyr2/gUQmeloP+M?=
 =?us-ascii?Q?OUrY2lcnZMj5pHjAy0383WCoverNTkc6De7+Ot+sAOgkJ7MDn6an0G9uo1jh?=
 =?us-ascii?Q?JdNl6k/YNdFTT9jOGKEbgKSVUUCGEOnnImlbC8nO0s1MZJTY7aTJ3YuVf4MY?=
 =?us-ascii?Q?aPDUPFOYfuRjn9ah1OqJAiMLEwlenu45JPWPJsVdBRNToYDVRLVpTa4QhMad?=
 =?us-ascii?Q?rO4w9Sgy+bZ1vZwxFW64qFNLZae4YvPcDbz4Ceu58lSF4oUkaAYlZ26VgZog?=
 =?us-ascii?Q?IV/Wb4tmgIsKV7G2cnRx2cqwpcEPNEO+PGoOeJqebkgb/z5I4fkIs0aNbffR?=
 =?us-ascii?Q?G5N/SHA9kc+BlQejooJmKDhaOX8EZnzouwXU8ME9rD/qegQJnVc0ijyv4XlI?=
 =?us-ascii?Q?rO9gtUyNmKg2Edw23PAXUsNl99kD3lAHOVHt/GRRj17qdnUpXApZgetKR01Q?=
 =?us-ascii?Q?CIiOv4scG+hdOzYH4dY0eYfeqkazuKYG11PRawPHJJ7xKVESOkrxm9ia6R0y?=
 =?us-ascii?Q?L6vr9kNVrf5+tjHNyffh9OOHbBnkAETQeD9RBT9/5kGoMn6umyBjwLJ4tVY0?=
 =?us-ascii?Q?OemNgfEmCIQw2EIY8BKoV6xBXVoiFiP+o8up73qbV9D0JithlteuWZf72Hfo?=
 =?us-ascii?Q?L+kB35npANIefRdy9w1gzd5s5M/ZLdg1wLtQTchtEZbyQSWvCEyu2k+xarf1?=
 =?us-ascii?Q?PU87mojYET0K0BEZXgf5y744FiBPTphHgfYUAMIw5NP3MO3R9EGSIqLsJPB+?=
 =?us-ascii?Q?1pIyoZYx/d1c2Bh3le+mrbnhP0IdlDOwGyzHF55Dk4eoNQqawyGfFhND97e/?=
 =?us-ascii?Q?mfHC0KVDu2PQVyn3VCL7B5MS5XtODAQQUEe1hFJoZwhQSPZLjHh0WHk1v5KX?=
 =?us-ascii?Q?VABvgjFW9PUnbuJSPTI/ynpaNH7StYB/BAGzhEkySW6QwfD0PbW4T5O+aCE8?=
 =?us-ascii?Q?YxqTpuJSFvGaubqSvaU0axy041oSWDct+7rz0pHB8JPpeBm3d/ePuf/u+G6K?=
 =?us-ascii?Q?upND2k5V+mBOCz1j71cOkguBlOtCpYrEmyKLTWAW4unZkIx1FSfEKX/E/kTu?=
 =?us-ascii?Q?tdkRECUGws/uWsmVKTElpFYCML25cdpmJdBCiTGd21AX74EHP0VyhKoSx/ug?=
 =?us-ascii?Q?DMWZtNzjx7BlqyN1hpmxwseviD/UikVsgLeeUGm6PCmH84vll6ZoM3BVR4t3?=
 =?us-ascii?Q?8ca+SwOCzQamdBDfSNykE/Sp2zCPpT8lv+cLCX/WlrFcCp5CjvCu7uo5wPKK?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5957B29C454D524482D649D3E7281620@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 41arhpbdVLz6hCYmELvatRP79bT5UUAjLhW6oLf9yH/3VUPABuy7kin1uX5Di3K8UVdMP1FFm5se1j+R04IM6xGFunCfZNEXu2y8oIZ7GBjDDT5D+za33M4DT2o/PDGnlah33jlEPV9H31vbVswTu64m4CRRDdcEv75e4Y9NcWuyoWGWgl0p58A6j77mRsjlqaIfc0KXAS0E8pgAylrk5wWvE3kOOT8cOuB9RYMtsBf38msRNc7T8FRgXbjiX2UKSxJZeTr6CcXUYyL2gq/AT0U7LmqDdvCVs2BOqDVdTR3gOddv6rBJbYHbBgwfTSWqA42qUkdS7deWYwQDKgwCpgfxTWyNoCM7mPtbTAGkeynrqholaJEAKEfsvRYgbaQFRXc0waP3qogtRA1IQVVB+wOWNuoSTrnu1Maxrt1bcTiXx9+g/i6t2JcqwPkF7yeHRprwceKdTGlPCGN4IFT5TU+2/XHeljtMsk4YRdkYgCQ1usEOgX/sRe/e4OkXDnwicLZhRm9TEO/JDfFR52Pq/D4ObE8s3edVuso0o3tjFMTEK+9qOYQQNR8MYb2Vrec8q9QJNM0Pmrk6LYd6swYVA9kBkjQhb8tE3EbgI4cQb2icjOE5rvNEQvHYs/Sjbb1RyRAhraVYLchYtXo2ZjRPc2h9dlbmrepI9hr+D4q4Cmd3m7BlX5n3Fdv5BZF9EdOjkbioWb/76qZjHW/itlkirQqONBGrTiRW0/8TBBxdfLjwdFGUjVncZv7/MQS5l9oqpitZr5U+eSRoQZVDC9cCamU6AodEVXbY1eg5ZrCQWZRz6qJ87g59NKl3MW2mrqr1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda9b6ea-108c-4dcb-6f88-08db2a15cee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 14:08:55.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dh54cyPWC3sf+xtnquwU+QPKnXLI8AxD72FJP287HLFeQuaXwr3RQJgJ5WM1ILDtwQfDFSJ5eSJjxp0B1mVnNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210111
X-Proofpoint-ORIG-GUID: Uj9qDiy6nK1F71NrTF05tb5BPrHBdHnD
X-Proofpoint-GUID: Uj9qDiy6nK1F71NrTF05tb5BPrHBdHnD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 21, 2023, at 8:06 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> utils/exportfs/exports.man |   45 ++++++++++++++++++++++++++++++++++++++=
+++++-
>> 1 file changed, 44 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
>> index 54b3f8776ea6..cca9bb7b4aeb 100644
>> --- a/utils/exportfs/exports.man
>> +++ b/utils/exportfs/exports.man
>> @@ -125,7 +125,49 @@ In that case you may include multiple sec=3D option=
s, and following options
>> will be enforced only for access using flavors listed in the immediately
>> preceding sec=3D option.  The only options that are permitted to vary in
>> this way are ro, rw, no_root_squash, root_squash, and all_squash.
>> +.SS Transport layer security
>> +The Linux NFS server supports the use of transport layer security to
>> +protect RPC traffic between itself and its clients.
>> +This can be in the form of a VPN, an ssh tunnel, or via RPC-with-TLS,
>> +which uses TLSv1.3.
>=20
> This is a little awkward, as the NFS server really isn't involved at all
> at that level in the case of a VPN or ssh tunnel. How about:
>=20
> The Linux NFS server supports transport layer security (TLS) to protect
> RPC traffic between itself and its clients via RPC-with-TLS which uses
> TLSv1.3. Alternately, RPC traffic can be secured via a VPN, ssh tunnel
> or similar mechanism that encrypts traffic in a way that is transparent
> to the server.

Sure, that expresses what I was after.


>> .PP
>> +Administrators may choose to require the use of
>> +RPC-with-TLS to protect access to individual exports.
>> +This is particularly useful when using non-cryptographic security
>> +flavors such as
>> +.IR sec=3Dsys .
>> +The
>> +.I xprtsec=3D
>> +option, followed by a colon-delimited list of security policies,
>> +can restrict access to the export to only clients that have negotiated
>> +transport-layer security.
>> +Currently supported transport layer security policies include:
>> +.TP
>> +.IR none
>> +The server permits clients to access the export
>> +without the use of transport layer security.
>> +.TP
>> +.IR tls
>> +The server permits clients that have negotiated an RPC-with-TLS session
>> +without peer authentication (confidentiality only) to access the export=
.
>> +Clients are not required to offer an x.509 certificate
>> +when establishing a transport layer security session.
>> +.TP
>> +.IR mtls
>> +The server permits clients that have negotiated an RPC-with-TLS session
>> +with peer authentication to access the export.
>> +The server requires clients to offer an x.509 certificate
>> +when establishing a transport layer security session.
>> +.PP
>> +The default setting is
>> +.IR xprtsec=3Dnone:tls:mtls .
>=20
> Shouldn't that list order be reversed? IOW, shouldn't we default to mtls
> first since it's more secure?
>=20
> It might also be good to spell out what the kernel does with an ordered
> list here. In what order are these methods attempted and at what point
> does the server give up?

There's no order to this list. It's simply a list of
transport layer security settings that the server will
permit clients to use on this transport.

The "ordered list" concept is from the MNT protocol.
For xprtsec, there's no communication or negotiation
of preferences with clients.


>> +This is also known as "opportunistic mode".
>> +The server permits clients to use any transport layer security mechanis=
m
>> +to access the export.
>> +.PP
>> +The server administrator must install and configure
>> +.BR tlshd
>> +to handle transport layer security handshake requests from the local ke=
rnel.
>=20
> In the event that tlshd isn't running, what happens? I assume we give up
> on TLS at that point, but how long does it take for the kernel to
> realize that it's not there?

If tlshd is not running, the handshake request fails immediately.
There's no timeout needed thanks to netlink multi-cast.


>> .SS General Options
>> .BR exportfs
>> understands the following export options:
>> @@ -581,7 +623,8 @@ a character class wildcard match.
>> .BR netgroup (5),
>> .BR mountd (8),
>> .BR nfsd (8),
>> -.BR showmount (8).
>> +.BR showmount (8),
>> +.BR tlshd (8).
>> .\".SH DIAGNOSTICS
>> .\"An error parsing the file is reported using syslogd(8) as level NOTIC=
E from
>> .\"a DAEMON whenever
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


