Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C907065AAF5
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Jan 2023 19:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjAASTS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Jan 2023 13:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAASTQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Jan 2023 13:19:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA1F2BC3
        for <linux-nfs@vger.kernel.org>; Sun,  1 Jan 2023 10:19:15 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 301Ht5D3013742;
        Sun, 1 Jan 2023 18:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=g8DxgiWs2z8c/m6WEovpfxqnVwL1uzgKdM+Klgt3l10=;
 b=rEJotyAMn2w2R+/ZfY4E+TWzcpbtIU1n5PPgSsy0wQ0BcoItpfd+fQhsHg8YGIPFJlJx
 d3n+SmOKd+aqHtJKaj60I+ZckxsJGP2HZMpdew4CdCW6pKwOSZnSgQJBumT1DmnFJwaD
 fnWTj/TgWM1OhUKQ2KPPWNk9eDuL+d7Q3RMvY8giT17spODLN5JJIXvJyzRgQ41kASvX
 6vwdPJisXTOP4BiwyfHujqQJ+QsIxdCsG65w4VDsuH7f8NONQreeOK2QmL/tctL2ku6P
 84PGvlPcWcoAVCYXFHbKHAvh7Gm80wftfaSO3/3Me8lORTRMyaG4po8avHaOajM0n4CD DQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv2sehd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Jan 2023 18:18:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 301FK8pn005998;
        Sun, 1 Jan 2023 18:18:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbra79qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Jan 2023 18:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJAQ6/lR8+4yXWxLoAS0VU5nISjdAiAtUbgWPSKiWEVLyZLIOMDMPjHHk1XlfXr7SyVWjMKzyyhkCsMin40YCkiJqGI0s38Zt2RKUQPlIByVkjZhFnFEcwEhws0QCn3NmteJQUjL+Si7ZiPY0rTfNA286pwzuPTcjyIyc3M2qPwILELyeUhFqOp+MRH7LBL5BswilvK9BBuSif+HrSN3iP/m28+DKf/ixRhl9qdgK1KOVByki+eRMGx5auZ+ASYTpivf7t9JE9iqPhuWQLq6GLA1+t6D2P5ZUT6QCSXBBQF/KzGItyKJVX3Vtfiq8K8d464MxJKIbUNLdXIUdtZE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8DxgiWs2z8c/m6WEovpfxqnVwL1uzgKdM+Klgt3l10=;
 b=f48zSWvaA1YRMISycINHGt1gghoNaxkHBZljaJIHRIRcQdK0tukuZMjBrQ6xwTpnmOYQJwEaLNiu3P+iimJXpMXzVaD4XUR1hRCIfmIIfeMv0uppWABSAYGJ13/YbYt3DA19g/X32I7LRbNm/smIvW4Y3MkskPyBMzHBveZtrqSTwJUiu15j55+WV31A20Uh2HzR8J6RYTJhUyLebajt1xnuHUNs0VRzLpU7zVC0pHLLpAJgzBgh17wNy7X1koRtlnr0tNw72fARWpG4S2XW2J5jkT1n6RSaEjn+oGYPJ2RFV9MaKTLzYQze4a37ySxv3HT0yLqyGcTOhhY7M5YDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8DxgiWs2z8c/m6WEovpfxqnVwL1uzgKdM+Klgt3l10=;
 b=fM9bja/Wwg+VrSQCUngUs71LaES/XgVfy/OKCQwDh3sbKNk1uCDCz7ZuyEq2OICXRhD6VC702kFqnxzgP5jzb9P4AcytqHt3BkDoRo32O3avdL88gfVy5At9c66+qSSolbMk3/2RRp8K3mbmhI4MRTM3fwzsBWFPjolYRHB3vIk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5393.namprd10.prod.outlook.com (2603:10b6:5:35e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sun, 1 Jan
 2023 18:18:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Sun, 1 Jan 2023
 18:18:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ian Kent <raven@themaw.net>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall
 timeout
Thread-Topic: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall
 timeout
Thread-Index: AQHZDx3smN/KyreXA0qcwVX6hchw565sLBKAgAARQwCAADW/AIAAF7yAgABTIACAHRwugIAAApgA
Date:   Sun, 1 Jan 2023 18:18:41 +0000
Message-ID: <5248B584-8A4A-47D2-A7D0-8EFDC2B97F63@oracle.com>
References: <20221213180826.216690-1-jlayton@kernel.org>
 <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
 <988799bd54c391259cfeff002660a4002adb96d2.camel@kernel.org>
 <81f891ef-b498-24b0-12e3-4ddda8062dc0@themaw.net>
 <0d6deecbe0dff95ebbe061914ddb00ca04d1f3c1.camel@kernel.org>
 <b2593a91-0957-5203-b556-f93bdd2dc0dd@themaw.net>
 <940934D4-7896-4C0D-93F1-26170C49CBE4@oracle.com>
In-Reply-To: <940934D4-7896-4C0D-93F1-26170C49CBE4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5393:EE_
x-ms-office365-filtering-correlation-id: 3c714b45-c0a7-47cd-8876-08daec249c83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?VioYsZrmKchM4xTP1f9oojBQBY9op0EJMfJr1uQ+gjfrGMVZfo296+FEV3bV?=
 =?us-ascii?Q?6weE5jr6HYbxUw3bctoyWypxIKZH3N7TyfceZ3n5jC7acprTqNwr0qiOOPgh?=
 =?us-ascii?Q?C+ut0z34rshRaui7uKeh4x260+W/DNa6v5yTH0GC7pgF4ubixEQ3jMIERi3K?=
 =?us-ascii?Q?RK4WwNh0za1fCvLbR6niU68+4aezyaBIG+2u2c9DcL7gteH9E5QQwiP21qPe?=
 =?us-ascii?Q?M8mJvzOVXEzFaGtJFYZRYyQ0dNjIEy+jkuZmn9LLO07hGRE6qdLrvVGQRBRB?=
 =?us-ascii?Q?mJqzNh2y071a5ctrO8vU26FxVWqv8vqXAlrXPo0Aamr0Ad2zLZQA08gHhtP/?=
 =?us-ascii?Q?cTeDNWjG6BxcXtqg5G6xGUpi3Fuod/qizOWq1sDNXsgKywi3Yyjz4jn2Ij6Y?=
 =?us-ascii?Q?P+dzdtRCRWv4v9+JwY1foSGIA/b8lNFVI3k5uz62lWqELsXVzeNIuvTph1Jr?=
 =?us-ascii?Q?GRM7WLFlT+pWZQz3sBnHULwrjYWzSMDeYXvCRyjmujHFWASzKxpOfdxUAUTC?=
 =?us-ascii?Q?qq6uR9Fhen2+kAKx1xxLObVt2lcJ641ohUOdWVoY5LQgu6M4qz6r+cqW/rle?=
 =?us-ascii?Q?sUg03yYGvQpECtQ4dEisVXfSeZtlPeUqdmHDENoFMVty0eOlQQ0zUPzWuNhB?=
 =?us-ascii?Q?aHxySWYNk22M492Nzz/b4d5HKBUJSO3pfDdLS9JJ8kJNbwonn9HAVLrD54dR?=
 =?us-ascii?Q?yf90JaNpNc5PZYMFmbRqrtJkYswUTkHkovpJCcbPZR6EyIVK+RDcXWE6K2XM?=
 =?us-ascii?Q?wu1fvMOfbVdqLwEHKIzd44wog1V4eHXPxc/39VDgrfYDsrM04Ll5sodPsN7g?=
 =?us-ascii?Q?t91B1jV54izXrhelqLtXHZXITxEKQukCOplz7/O1oUIjmjLtNyHFmNNjAiNT?=
 =?us-ascii?Q?yDMNoTf7m8pjshLSPrbSWhddAjueNT5IENEzsrnIjw9Xf0ev1FDesqPSIBi2?=
 =?us-ascii?Q?dbXc8q2wgdyuiFxCAFtpBzNfqCqyTWyZzo4tUZ+PCjxMupg/3ya6xgYAbnzC?=
 =?us-ascii?Q?xGGhC1q3nKaZepxOLu7qxpNbUHXSHcmOz9iYizop2BiRdEUyunxIX9ruFYNO?=
 =?us-ascii?Q?PcSKH19dYiP9X5F5XT2KxqdeVNBw3nvn+boCU7YctiGUEVe4RDW9f7s+PoVX?=
 =?us-ascii?Q?6bwl9JfNGTLt?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230022)(376002)(136003)(396003)(346002)(39850400004)(366004)(451199015)(91956017)(41300700001)(4326008)(8676002)(76116006)(8936002)(64756008)(66556008)(66446008)(66476007)(66946007)(110136005)(54906003)(4001150100001)(2906002)(5660300002)(316002)(71200400001)(6506007)(6486002)(478600001)(6512007)(26005)(186003)(53546011)(86362001)(2616005)(83380400001)(38100700002)(38070700005)(36756003)(122000001)(33656002)(22166003)(42413004);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jNPjp70xiCcKZICUXbQKagKek/z6DxLwbwRQbgL0v0UzNaMCHpe8aE2lw6Ph?=
 =?us-ascii?Q?CHauTAeW6TaOoojbqaia/ySxEbPnTEVz7SditnWqV4gSRTWRI5Ba/2/YnuqG?=
 =?us-ascii?Q?HX2BHx/YWnoPec0VrWdpJzNGSP014qD/FkbNAzpvDJLXmz36zGPyxRJKobBb?=
 =?us-ascii?Q?DuC3wFbJkYPnERHH22d93KmoFkrwUqlyuP2Y1zHPa9fiU7WLSP3XOX4vq9Dm?=
 =?us-ascii?Q?pMrvRcVa4vp7Lly+2IEjnLcM7AanEma/FhYrc45CTmsozL3MUqhmT5gRiRTO?=
 =?us-ascii?Q?ZrC4fdW9BNPG4Sox36Q//J/qkYfzhWndWgqqMcxpKtnqXBx1LNoFvxhVkWtD?=
 =?us-ascii?Q?bog5ye3b/S+bCj8YZDruBcav/qSoIhVZGzk9gRWETkGpEmDoW+fDMIE8qQYc?=
 =?us-ascii?Q?o5WJzIMoklvHWannfOLh8MxujyQHse+gAB/gNGuTJFT/xVoYWoRcQdqx1HNS?=
 =?us-ascii?Q?hgj6U6eBKDKJLsAWTrOsARfLuOb32jBO6hRHZ18kYICRPIoivFVP2/qiovhj?=
 =?us-ascii?Q?IvAEZiNWGTEtEtVqoDgLc32uiw8+bl2DJk3x6dpMPB+MDjI13DgNFyE7dt2b?=
 =?us-ascii?Q?tHkVK6PYd7a9bkOIBLM4Yoi2TSxVWCYYbNqU/6AILmHk9A00JlT3k7LyvEBN?=
 =?us-ascii?Q?kbTN04RToq+T12loDRqQilS1Pcc9TD6C1O1gLArE2QXX/HwcE7oraf2y5kk1?=
 =?us-ascii?Q?dW9bPCBCja22CBLjSM4IQ2zB8j1aSkt8RnrnKRLcB1fLQDNK2g+c/qePCpvm?=
 =?us-ascii?Q?36jUwN2+jAWIRbpHOPZR/ht/58EcRRcVO2SprtzKL1hHkfoO8mNRgTwt/SQi?=
 =?us-ascii?Q?Kyii+dnlOgJ4LTX5C4Mj1hto4H9IDLzq5CFPqCZd5EKkkkcUzF/USw5NoTzN?=
 =?us-ascii?Q?QrEP/XNk9XW7Bai5lg2+LHF6uAppWj7HpxigZnhsc/hx1YBl0x/m2uBn3Xn8?=
 =?us-ascii?Q?Y54wSqEwJSwn4blBmmyZT1IYDvFaWFIjOWRuX3j8vTAIeJ3kVbxgl5n9eqDG?=
 =?us-ascii?Q?IPf+GXY10zxvRGhhCikYuomBsbWiiINZpVUHIFRJGsn1UAC7LEJzz6aeXLHy?=
 =?us-ascii?Q?rqwYI1+Fe/af6Ae81rS0e3Cqi76N6NBqLr98bgUNQ5EgUaGdARTx0/+wmfon?=
 =?us-ascii?Q?9owznlKSCkeIGGNz0Dofva6rR7yYP+EHIDtJ7KCNmXSsS7VoiTQD7ES23h6W?=
 =?us-ascii?Q?KX5L8zire7ldTd3wDsHBAJOAPLH8nyFCoeCEtWe6NNeW7XsNkgxJAiEiK0ee?=
 =?us-ascii?Q?erQ4ipSh003gEytX3jQNr1ZHlzgmjqq4i4Vh46ejhMNzczqLDrDYmtV7xUHX?=
 =?us-ascii?Q?J9dxzqTFRN/uCqVKUkDDHcznGo5p0TTpodGxtMfJLCdOms2S1ApU0vETB5il?=
 =?us-ascii?Q?obgiYi0GqWngmvOYcVHBupkcQAN8zxngssJGD72Atmc1u6Y0O7035sHKHzUi?=
 =?us-ascii?Q?1aNQpA4pVTyUpfRatJV00qNhGrToVFRdIXnxNvKQRhEeHnYFuCpc2fLOPwF2?=
 =?us-ascii?Q?aUNzkWFXFksLuJlKDqLb1fVTiIXipZmpMAAGXnDqkZrPNiR8Czod35uJaAua?=
 =?us-ascii?Q?y7RnxkhYtedd9nBjwLtvkfPGVdMH6g9NvxINqorwUifB1QBmxlLArWOd9Jt+?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F29676C0979A340905F49A53A67BEEA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c714b45-c0a7-47cd-8876-08daec249c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2023 18:18:41.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fKxbLXLm0CT5YMnwuRv+5Wj9Io0WGNc8HEs7OBQNhZ+1G+7giiHiIn2apsfz8CV/v/mNws+ozwIaBwBbpmgYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-01_08,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301010169
X-Proofpoint-GUID: 9uqDlUHUfDenmbZ_txsYnaCn74MVum4p
X-Proofpoint-ORIG-GUID: 9uqDlUHUfDenmbZ_txsYnaCn74MVum4p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 1, 2023, at 1:09 PM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>=20
>=20
>> On Dec 14, 2022, at 12:37 AM, Ian Kent <raven@themaw.net> wrote:
>>=20
>> On 14/12/22 08:39, Jeff Layton wrote:
>>> On Wed, 2022-12-14 at 07:14 +0800, Ian Kent wrote:
>>>> On 14/12/22 04:02, Jeff Layton wrote:
>>>>> On Tue, 2022-12-13 at 19:00 +0000, Chuck Lever III wrote:
>>>>>>> On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
>>>>>>>=20
>>>>>>> If v4 READDIR operation hits a mountpoint and gets back an error,
>>>>>>> then it will include that entry in the reply and set RDATTR_ERROR f=
or it
>>>>>>> to the error.
>>>>>>>=20
>>>>>>> That's fine for "normal" exported filesystems, but on the v4root, w=
e
>>>>>>> need to be more careful to only expose the existence of dentries th=
at
>>>>>>> lead to exports.
>>>>>>>=20
>>>>>>> If the mountd upcall times out while checking to see whether a
>>>>>>> mountpoint on the v4root is exported, then we have no recourse othe=
r
>>>>>>> than to fail the whole operation.
>>>>>> Thank you for chasing this down!
>>>>>>=20
>>>>>> Failing the whole READDIR when mountd times out might be a bad idea.
>>>>>> If the mountd upcall times out every time, the client can't make
>>>>>> any progress and will continue to emit the failing READDIR request.
>>>>>>=20
>>>>>> Would it be better to skip the unresolvable entry instead and let
>>>>>> the READDIR succeed without that entry?
>>>>>>=20
>>>>> Mounting doesn't usually require working READDIR. In that situation, =
a
>>>>> readdir() might hang (until the client kills), but a lookup of other
>>>>> dentries that aren't perpetually stalled should be ok in this situati=
on.
>>>>>=20
>>>>> If mountd is that hosed then I think it's unlikely that any progress
>>>>> will be possible anyway.
>>>> The READDIR shouldn't trigger a mount yes, but if it's a valid automou=
nt
>>>>=20
>>>> point (basically a valid dentry in this case I think) it should be lis=
ted.
>>>>=20
>>>> It certainly shouldn't hold up the READDIR, passing into it is when a
>>>>=20
>>>> mount should occur.
>>>>=20
>>>>=20
>>>> That's usually the behavior we want for automounts, we don't want moun=
t
>>>>=20
>>>> storms on directories full of automount points.
>>>>=20
>>>=20
>>> We only want to display it if it's a valid _exported_ mountpoint.
>>>=20
>>> The idea here is to only reveal the parts of the namespace that are
>>> exported in the nfsv4 pseudoroot. The "normal" contents are not shown -=
-
>>> only exported mountpoints and ancestor directories of those mountpoints=
.
>>>=20
>>> We don't want mountd triggering automounts, in general. If the
>>> underlying filesystem was exported, then it should also already be
>>> mounted, since nfsd doesn't currently trigger automounts in
>>> follow_down().
>>=20
>> Umm ... must they already be mounted?
>>=20
>>=20
>> Can't it be a valid mount point either not yet mounted or timed out
>>=20
>> and umounted. In that case shouldn't it be listed, I know that's
>>=20
>> not the that good an outcome because its stat info will change when
>>=20
>> it gets walked into but it's usually the only sane choice.
>>=20
>>=20
>>>=20
>>> There is also a separate patchset by Richard Weinberger to allow nfsd t=
o
>>> trigger automounts if the parent filesystem is exported with -o
>>> crossmnt. That should be ok with this patch, since the automount will b=
e
>>> triggered before the upcall to mountd. That should ensure that it's
>>> already mounted by the time we get to upcalling for its export.
>>=20
>> Yep, saw that, ;)
>=20
> I'm not sure if there is consensus on this patch.
>=20
> It's been pushed to nfsd's for-rc branch for wider testing, but if
> there's a strong objection I can pull it out before the next -rc PR.

Also, do we agree that it should get a "Cc: stable" tag?


--
Chuck Lever



