Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389526A9E32
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 19:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjCCSLw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 13:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjCCSLu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 13:11:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D65D892
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 10:11:47 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323HaeSB027818;
        Fri, 3 Mar 2023 18:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eddtUnaDpH+k6K0OBlw9Vrym5ZYZASwbY3bDVLkBQKk=;
 b=bWt1fDK4wlPdTVKzauir6LGWUXXiRONJFO6KNRNHpzZyhjgBAlOwVLukDpg1sKy2ZZkO
 jHE85BuwZN+P0BbgKU3Wxl554yhfLJbuCLz/cDJ3AB1f0SshqGYzgPeay6+82wrMt5VQ
 IbqTFs0b71avg9FU8sR4JMj97IwOPXiZOgTgTqdXArs2CIXpFeo2SvZpZ28psbk3WT9x
 tqn0UjVj7PGMw0jqqC2WzfSULk2KiERC8kOyvZt7nBe3ZBH2VWdPcNfxz7SwGd2ZIu7Z
 oi7vKxZA/eEZLzICukj+PaSe7sfU2Q+6Y6tmDBXwD8ggNCRXXIpWqqUF2OF3BpESnPSH zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2q1mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 18:11:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 323GSCpI004979;
        Fri, 3 Mar 2023 18:11:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sc4kd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 18:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfR9EoO216EQUttd4PLYsu7V5AP8oqnjh7m8cHJcYsPDUJtE85TpFV9ZOS+bVn1XARkYS3iI3jY2dpGEE7Kw0JVs4RSH7oPgH6vUudD+gnvdu/C/WJEUHt9rUyuwKByTPedJB01IfGVkjlzGl2pLQzl+4Ry+9ApAeYFMvb6inuXncIEw/95074beykSjO2sfzqRZxKKXN8/rLDdefTrZevNsIqGXpV068KjM2VvTks5Mpi2eDaMGQxu276MZTIvP6b8+E4zOQ6d5TzveOUxYlCaQ5IQXDX+G+qLLUWc3G4S67HCAbYjXRV/+1PGB6ofylMsJbwrc4zt3bWZkAfrBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eddtUnaDpH+k6K0OBlw9Vrym5ZYZASwbY3bDVLkBQKk=;
 b=oU9OPPMDuJ4CIA/9+kJi+S+xOBSSd+17i4dqgAw1YShkGP1bYg3FFSM8zLQEzxCyPanfFEIUapDnqyofjC++JdGwJiGLCMATX+mTVwea3VAY9q1fB0udDRAZArYmVXBN5WnhshNdQbdD+DONof+T9cUnPPRY5dx5fVTe4M4MATl9eOzFqFBtUl9YzIVe5PAWZug1CdwZ3nmGvPYeOC8KH4N8mwVLsKa1Dyi1YLD4Cz7sfAy1mguwAAtrQpOytUoYu0TzNVRhe83+W/MpRx3hEWOhcSeckgd14rZhPwxknUcm3uvEZSkYbU6w+70oRPqH6OTSqX1ckWYz/5bZELI3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eddtUnaDpH+k6K0OBlw9Vrym5ZYZASwbY3bDVLkBQKk=;
 b=IKjiNmzEiKJJFA3t1AnSvTiEI9ziugQpngDoVFLoZP1VaNBb3y5AqwpG0hooDdkArEu4UAa1AZ90BUrJkW6nLecGnU/wSJRy6HLrVEb8hTS5L+CpIUeAdQEam++fx7H7D2l0n51I66GoNPWBwAcWEJdRNfKc7KEDZ7PmY5xAsLE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4379.namprd10.prod.outlook.com (2603:10b6:5:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 18:11:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 18:11:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yoyang@redhat.com" <yoyang@redhat.com>
Subject: Re: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
Thread-Topic: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
Thread-Index: AQHZTcnxbdBJ4h9EiE6itgxSR0amOa7pIQIAgAA6k4A=
Date:   Fri, 3 Mar 2023 18:11:31 +0000
Message-ID: <0B9EDC13-4ADA-4BDD-9799-29CEF7C556AC@oracle.com>
References: <20230303121603.132103-1-jlayton@kernel.org>
 <0FC66364-4F59-4590-9211-EB54E918C97D@oracle.com>
In-Reply-To: <0FC66364-4F59-4590-9211-EB54E918C97D@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4379:EE_
x-ms-office365-filtering-correlation-id: 48856155-e9fd-4a9a-7b8a-08db1c12b75e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ACUtBe01FMkYfgr/E3o+q6rEReQtG3eiAvuFhMiG2pRdI3Za6nstw/abvgUgFxY0koTOD9XDBF2Q0Y7UyDmFik1r9uLqvNC8EZcFRwKLt40ZcNXkQVFD/+nLNZnQuWYN2+DAGlrFKjsKiYqA+uLFDp9xFKzxg5cB+1+Cbqv7Z64ncvlX6l3lDoy0M3EUb2Nu8NiKx+3PfN4go/EQkPF0gXBTCOVxtbH4LuByxE240RveEajaZtsMAVe9cWbg7Ki8BarQ9T5yul2MJvHdCLoJ4PS6f0q4N3r8ZL5xLvsvn0maDS4AWaszCV07s4J7+s/7exihLvVjWmo2HSf1Iiza6bu3dbU4x3SJFkcK/5io1msDtAmsiLCLuFNl6e7lSiZlgpc3dgRj6eMp/6j9gIYzlTWdhSkrRyCZ+EthgaqS4l0y4lPJT7Rf778hPlmECzUGawB8fT+aHI2vK57BfaE9CLw/4MZLF5itLC12MggAslmQjlLN+XAp++hL7+3e8IO38EwRZnpzffzHdc/jbSSC8OKDg6t9HgdcvmFnTkdcIYMimpk+XknW+WDrXcNfQDuIKbRaIhs+1k5P3Z/2cRnx6QITCgNexc2J+TL6FN57AEkLL0lfzQUynnoVyflrFhldShAJqf8iAH1lIMbJ4Cr2hHJXXVI7sex2ZlhHD1Cz6/eWEJxxPabmYU0q6rYiuPaZHKnLWYut7+/dO8RjWjiG1sITJ1a7Mqk1fORPr1KfBc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199018)(83380400001)(36756003)(478600001)(38100700002)(122000001)(33656002)(71200400001)(5660300002)(8936002)(86362001)(38070700005)(186003)(6506007)(26005)(2616005)(66446008)(6512007)(6486002)(53546011)(66476007)(2906002)(64756008)(76116006)(8676002)(4326008)(66556008)(66946007)(91956017)(6916009)(54906003)(41300700001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DIfJO6GvcyHopGTnqtv6u2u/UC0GL1Cfe5fRTeVsUb0mFuCC8MAzM9hOaBDA?=
 =?us-ascii?Q?DyqmrXKyZH4v8MGYsuztbSalzljyD087x1njgytTqylzf0FmhqYWk9sfx5MG?=
 =?us-ascii?Q?v/E7eRWU70iiZn2i8EFhsLDkmCrHYtgM4wycM1XADfprlLqH9WnkTZAVQpVL?=
 =?us-ascii?Q?8jIosYIG8HTPJP52CWI7AwBIKxXRwZb1sNMz0Wq7A18Oe3YAQPHohqq71Oud?=
 =?us-ascii?Q?ws0rDhgdJs/xNTaEpU/da9hcqwBF+X9qVosAcz9mnGwaa9tShtpGuRjIN1FN?=
 =?us-ascii?Q?YG5ltPMVAzW8H2n1S1XSzMvKCk+J3NeDf2y3lGNdfk2/GmpRBsrt3I1pI9M0?=
 =?us-ascii?Q?gLFZN8GgjVKoo7RQAzkCuV7DUVBqTdiGqc9MavrVoNG/EOn6vwcNtCEVI5Ib?=
 =?us-ascii?Q?FvDa5OnNJ20vZYvN2X0nh0ZidOBhJn9OlTSKIlPLVomiWJ9OjFN3ZC4DUbNR?=
 =?us-ascii?Q?QGQhvs7LoNUWfokSUV22XKDwnWrWBkSCnqM0bCKxwTTVJ6Bj1K2Pq4Wi3JXI?=
 =?us-ascii?Q?/AgjUuwr8LP45zXFiWdWVBimsoZuVdbea/3RIlMlW+8Ve0O7fUDxtbPTtlZe?=
 =?us-ascii?Q?DISAg7PqdmMIhDRhxDVHb+YJhvpI6dmmB2uWwj1vWGODZdjVj+q+3/Fo/t6r?=
 =?us-ascii?Q?71F5b5FbekyRRPJTkHs/5BwUeImjWfX1Fm1hXZxo78qUr6nznG0/t5lR4mqX?=
 =?us-ascii?Q?PZ9yT2JiLfKbIaivv+a9m4h/9Gz3bHXtXdhKqaJCcJ2eN57VC8nCSQPZlrIz?=
 =?us-ascii?Q?IiRJ6PV0yQykmwcQWni0K8EX2ZvOMiSuk3S3/NmD6lSYoV7Hicv1v9+QdfFh?=
 =?us-ascii?Q?7jJ1oVfJgQxs4JD/DfInZ9A2dT+FeoBex/Q/DKEGBzJm5SV2wLizAKsp2FyU?=
 =?us-ascii?Q?pzqvjJcclqODxvDOio+LvK5un05CYvwiay77JUGtgA2OnDy42vzuxsy8i+nG?=
 =?us-ascii?Q?iNBZFFpIeEodwOYdcR76c8CUC91uhk6Wm8XOwR6+HkmkjPWN8aLbihrbSee+?=
 =?us-ascii?Q?GjJtrIUqhRPnXtMAm47TQgkQljFQPzSPjrAo2y5df62/zADr0Qy+PRUXf7eh?=
 =?us-ascii?Q?GQsViMG6coVi11HroUYXDk42+XwH3TEQzIklI/kASTeeVAAEq0ygpyGI8Xt+?=
 =?us-ascii?Q?3iT82cs61mQQXvptur528ySsY2bKxBTDRc4i4jJlqsVeh2DiBrYlRW6XRFXq?=
 =?us-ascii?Q?KHa1i/acOFRn+X4YqCCDlvJBYa9LwBI0jSkY1pLy9ShP5ATp9SocL3Mx/Shm?=
 =?us-ascii?Q?nMOdO+kp+kRaVa2bpTB5jLAwI2yUNndLpV7Mr25/+Iym8ihCozwYJuyX2HQF?=
 =?us-ascii?Q?Lrpl2+Z+ZrMow24F9VG5WP1CnsB2f/SYWDKCxreHFFMy5tZ0JL034KRl31D4?=
 =?us-ascii?Q?2btL8llHQOMmesbwM12osmWrqZ2kMkalqjFkRdEbhoPsnEl5ytLIFVNiUFWn?=
 =?us-ascii?Q?kOcOVa5dllp3wQ0ZY1UBWboxRFe82uG8JOVUN2IDOyBlmDPZgzw+HQqD7P6a?=
 =?us-ascii?Q?gAQhmsPuwRQI8pw3V5S33qbrLHiXhXk251UM41lehTchqVg6FFCFyTvsIhCD?=
 =?us-ascii?Q?qOY74BVDxo6EPG8DCnKx+obZRHD4sWErnOveTh/ocr2dHf40H33GhlKb/CuP?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87A29FCD77F237429C388751051DB604@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cqcLpXK+sKFAMGSvLkBT2WAaZZyGfsgebYhEvNhhYi8lgf0RU8l30sStyZYvEPfUyaEbTFvXUH1gwxh/urNQKw3xCDWSXPvE3oqlhMOMax0ooVai0XedBoUMbuqm/TB1u5XCqVx9P9rUE1HRwyonyMRN6eeAncU4/toKtfVxVXwiHO8wlgBiXuvSs74MUDPXH5AiA4lZ5UuV1qV3AeHgUih266zhlvi/r9TqEjBdz0+w5AGOSJRzyrCHf/5Q+nFEGOwwk0GeIxLWjA+qXMgSUxCX1R54GyCtZ8/BbIJmFo8QT6YOa81RHjsWXggwmsryyY9Ne85Vkp6JHO4noVorR5bvtQHCkDWarVwBlVbGR9a8X5MtA1yNbYUMSrKOazCutYkuGz4snXishultSHHjhE8wewza69DI1Bm9SJsjtXEG2FX0MMb5Bn0lQju4s/y9iDj/KPRON184pb4o1zGF5i6VATbYJLAMpvXccQPTcY9PR5mm2Y0ouDq99h+n8frqNLMqDPMFLxwmPOQE/EZeNi8KC/ONOawn54Qt3Y4aWI5X6QPOyCyZzPoI4kV7WxqiPI4GppxcQVDvOp80AgKjR+MYG4PVp539lW2+lD+cDXsveNHCVyWek8v5tJAG78gKn3rOA8yJJhXOhnFbm1RCEaMpl2vEWAktSBruOcsueLbbQSePmTfw1IFRe+24wghTQBQfqVnbesVG4/lhJyYLPikLZLBi62pthTeIFcrfebs3G1S86bYCXv0P62eZLE9hlo934Qs/dJ4bUjEduEn7sA1EdVoktcp9VBGPMHvqug+4qQEbn28jw4r4JIDF7t14pf8CjJ1hiIkbCTTNbZC8M2Upa1XeNmBxbzt4ZetIHxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48856155-e9fd-4a9a-7b8a-08db1c12b75e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 18:11:31.4312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /uOYh2+tXGiU5QXLtQ8RlcNbHQYhLsHHjdKki+Fd9xgJxWUdtsefmHO5lBnV5/H8AJZ2Ka70op5laLgZgoNsmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030157
X-Proofpoint-GUID: PM3vQ9Rs921olYSlH9rHq3uP0-6L0jAc
X-Proofpoint-ORIG-GUID: PM3vQ9Rs921olYSlH9rHq3uP0-6L0jAc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 3, 2023, at 9:41 AM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>=20
>=20
>> On Mar 3, 2023, at 7:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> I sent the first patch in this series the other day, but didn't get any
>> responses.
>=20
> We'll have to work out who will take which patches in this set.
> Once fully reviewed, I can take the set if the client maintainers
> send Acks for 2-4 and 6-7.
>=20
> nfsd-next for v6.4 is not yet open. I can work on setting that up
> today.
>=20
>=20
>> Since then I've had time to follow up on the client-side part
>> of this problem, which eventually also pointed out yet another bug on
>> the server side. There are also a couple of cleanup patches in here too,
>> and a patch to add some tracepoints that I found useful while diagnosing
>> this.
>>=20
>> With this set on both client and server, I'm now able to run Yongcheng's
>> test for an hour straight with no stuck locks.
>>=20
>> Jeff Layton (7):
>> lockd: purge resources held on behalf of nlm clients when shutting
>>   down
>> lockd: remove 2 unused helper functions
>> lockd: move struct nlm_wait to lockd.h
>> lockd: fix races in client GRANTED_MSG wait logic
>> lockd: server should unlock lock if client rejects the grant
>> nfs: move nfs_fhandle_hash to common include file
>> lockd: add some client-side tracepoints
>>=20
>> fs/lockd/Makefile           |  6 ++-
>> fs/lockd/clntlock.c         | 58 +++++++++++---------------
>> fs/lockd/clntproc.c         | 42 ++++++++++++++-----
>> fs/lockd/host.c             |  1 +
>> fs/lockd/svclock.c          | 21 ++++++++--
>> fs/lockd/trace.c            |  3 ++
>> fs/lockd/trace.h            | 83 +++++++++++++++++++++++++++++++++++++
>> fs/nfs/internal.h           | 15 -------
>> include/linux/lockd/lockd.h | 29 ++++++-------
>> include/linux/nfs.h         | 20 +++++++++
>> 10 files changed, 200 insertions(+), 78 deletions(-)
>> create mode 100644 fs/lockd/trace.c
>> create mode 100644 fs/lockd/trace.h
>>=20
>> --=20
>> 2.39.2

I've opened nfsd-next for v6.4 and applied these. I can drop any
that the client maintainers wish to take through their tree or
would prefer to reject.

Noted that several of these had checkpatch.pl warnings or errors.
I fixed up the issues before applying them.


--
Chuck Lever


