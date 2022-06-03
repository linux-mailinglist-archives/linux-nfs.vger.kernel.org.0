Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A8753CB3F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jun 2022 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbiFCOC5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jun 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbiFCOC4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jun 2022 10:02:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C0224583;
        Fri,  3 Jun 2022 07:02:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253A1NQJ008021;
        Fri, 3 Jun 2022 14:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Y7Bb4+kk2N3neqa6dHJJ/nCGK7tB+Eb2l/X6Xm1a2q0=;
 b=HuAPwkCzrFjtfq6ef4w6WcyP2YHfgGt+iRDhoqaStg7H16F8NeOQTyZ4l4ON2q2SuxXa
 Yhg8ztUu6zQJVmIkREcPSh3x3BduhO+p8FTOSUqUoTRdNVhEtQU05jv3MCa+I69dDqK+
 4LfUBDQIEtGh7wR4fGp/fDvAHPKe49TerQKFIVXsPD1NCkYcFheS+w5Yzut0Sm+U4r4R
 YC72uJcBgMbxGm1cIGhcs+Q0imuflcfm9kKL6WKy/phVr2c8/wvHtE9AU7Y2dRozGenG
 /6EHj7Z4gkvnj0CjOKpxv6jMXdcntWNGzHkMC1GhkcEe/BzxYqYOmnxtqibgWSRiVql7 0Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gf08e2587-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jun 2022 14:02:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 253E0GOI013856;
        Fri, 3 Jun 2022 14:02:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p5ygsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jun 2022 14:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxKQpSpXwMz3c9AzfR5Gpf6n6FS+S5IjdNAUcRVXWIwcs7b15PCEiCS3vXfRkOsDHZR8EUpNtP8+LyafikMC/ZS1ractT1a6hOIuqZicP1+UvXs0MyX33Fma1/fjJxhBIzIkHeBFNQy2Jr5ZwDFzIJTYMR028KbHPbjPgOuvNZmPv6XKgcDLSEP7/s998vlLOnEJdS6/kS75AHICnjrxwg0451t3OKf/fZkyNsqmBT/Ar8uekhwj4+4tjVb6phoOs5d399AyydHEKDMuKaMlFIAGT8j3znuh1SlXQc1HGVoRHilbGXt/LUhoIJID/C8mR/NcDRyYtSaV2M3XyMxSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7Bb4+kk2N3neqa6dHJJ/nCGK7tB+Eb2l/X6Xm1a2q0=;
 b=RaKoCFV012MJxToUKg1+ss4a6IO4duLmUES7YjbTE45J26assL1vtM1zHiUAxOZ4rG9UPNNUPUjTTULphoAvrV3MXgtXOLx0EF1JgsTteR1swZsOsYU2sWYHHsYaPag9i1zHrombZNqPNQsoPnHvcsT08vfMtYku0/T9xSFDR2jXawvPSOlZguh66E/JAMKpL3Z5sI7eSvTClvMvZinBjdO9DVPuHxEVpUA+EilCYnz/TbH+8TRukWE0VahzlWqX9W8y+oWT1qapO0fQ7MCzjzRq82wZQkSz2YxQZUXBiXWfYeXQE3osMvJQrgm0iX9EQEcw2xDVdcLO+gTmmdetWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7Bb4+kk2N3neqa6dHJJ/nCGK7tB+Eb2l/X6Xm1a2q0=;
 b=V+uppHlHZiDql6nYhQyu729X+ceYLG7htCTWDG4ZcMLCq5/fn2FJhT0lPgcLugUXc59FrGtNGy1rurZ3c0lBKRcXi/+Er/K5AgbCk55OIVnLLNbKVOt6A8WeyPiVbUYGZxq99o1uJxB5/2p/bCi/19nWEjOb+W/xjFRF6pLDmjM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4840.namprd10.prod.outlook.com (2603:10b6:408:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 14:02:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 14:02:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
CC:     Dongliang Mu <dzm91@hust.edu.cn>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: make destory function more elegant
Thread-Topic: [PATCH] nfsd: make destory function more elegant
Thread-Index: AQHYdo09Led0teFie0eOL9JGzaRrQ609tLwAgAADVgA=
Date:   Fri, 3 Jun 2022 14:02:41 +0000
Message-ID: <5D082BBB-B440-437C-9C3A-AAC29FFA3910@oracle.com>
References: <20220602055633.849545-1-dzm91@hust.edu.cn>
 <53417E03-4D3C-44DC-AA8A-5F9FE340483A@oracle.com>
 <CAD-N9QUAvTZMFz6A+=NxvyHaO102mrc7+5gL4K9xV5j3AEuvjQ@mail.gmail.com>
In-Reply-To: <CAD-N9QUAvTZMFz6A+=NxvyHaO102mrc7+5gL4K9xV5j3AEuvjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24abf912-0f35-4494-2155-08da4569b9b2
x-ms-traffictypediagnostic: BN0PR10MB4840:EE_
x-microsoft-antispam-prvs: <BN0PR10MB4840379CB854F77C7D89864193A19@BN0PR10MB4840.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7frCSdDSl29YdsTkHKzC6UCEM8+ir26PTLxYsFJQmQ9Vy7dxH4KLcf/wln3uHQG37bxeQGptuAjMMMXvBUI4YRhop0MuvsXgOpGSZuV78IG2tikvRqnRMbuxSpmRAf52jPvDnaKoErziumnGJXFj9xB5V7yioCDwVm1zScaP8QIjDJ6kwS0Qp4Eiafu6PYri0qIDSmhAvfFH1Q2O7B4AJ3tZ88LlV7X3GXXayhFaKaEBAoNkLi94jJGc6SSZGDYzow140eCn2bLK/s1y34bj2aLvPg3NWIB9xAPpZwl7t1+tIdzV9mijwuYvubHRaYaAaZydCxalycp14UWwlO3FY4tbbxFKZw6tjTc8CUBUu0GwkJYt8uCEEnvMK+Zg3N/3ZUYH6TqMKEvpTfNC2sUOuOKUkY4t+kszIwEAy/TaEA/nyg2Xii3ZN7ysOy5QZ8hryZizDJMMjIqc3qYGoTWgYRRU+7nd0eMUj5907GZsE7H7pUGJcsDn/TwzHXo7S0amNKCUTnrfams6Dp1d6WZBKsSiHvlyIS6G9CI+N+o0ucj5gGRTL8BO7mYlSA3wV/vtiyybF3ophnjwjEwE+xACVW73YRpNPtruu4JsSo2BXcNEicRz1lVOQP34y3XevkSawZyw7CZH23jv1PcAIJNd4+j/Psnz8EnX41NUmRU3r2vFWKlQcBTCnVw5CqCUgaAy92XgjRuzCQOxiGecijGjjB3Kikfb5GT+QP7811Bjh6hRC48NGzChoWcF9NdCGCGs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(71200400001)(316002)(6512007)(5660300002)(83380400001)(508600001)(38100700002)(6486002)(8936002)(186003)(33656002)(6916009)(2616005)(54906003)(36756003)(86362001)(8676002)(53546011)(38070700005)(91956017)(4326008)(66556008)(66946007)(66476007)(76116006)(66446008)(64756008)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hOM40ysrjbyg4AvQjkxPnD8UGHN2dSC6Af/c3q+T4SVhLvQ0YN/5YmP0nrT1?=
 =?us-ascii?Q?f8klmrroLGWRHuWazyiNmI2Ctu8yfVFuLKuZ8/lPjAxwN073dIO42rA+Wvi3?=
 =?us-ascii?Q?Lt125/qryQRBkBjTIXKbAuG8l4naQw0LG/OT+orktke0NS4YE3E4sGRn9YQP?=
 =?us-ascii?Q?1yLPbzzm3NVj1Ta6a2RlN8IyD5n/9gpyrF0joKeAvvTaHDXJQTr4+LvWKMKE?=
 =?us-ascii?Q?IZ/HDcPHYSKjgirKo+f9I+vuaV7G4zwBF5Nak8yeyXUUHvGhlLHt+40Vtf1M?=
 =?us-ascii?Q?TIuJqCaCRkDxmVUSlhCrq5WPMCtgM5VvDTC6KXUZKbiQg6+aMABpTr3haVPq?=
 =?us-ascii?Q?cPNmPyJwAptmgsxGm0t9gSobVHsCeGXwr1xe01XAu5bc5zBS18mqaPMJMIMb?=
 =?us-ascii?Q?2VwvrIsPY0IXcehhXdm9M/HPghr8vqvteYTr3L1twn3+EUnrZlkGuMMiEqBd?=
 =?us-ascii?Q?ad9aGDOX7tg0J1umfsy4NHVELtWit84EtHA+Ycez2CeoH11+m5lvTl3Foso6?=
 =?us-ascii?Q?vHPWVz+0OXH9Aoqlk7dyniz+KRc3AsSEmXdFgNXz6xgSB/QK79XJ20Avm5+d?=
 =?us-ascii?Q?OV71nXqTOjHdgRa78yrzhEgwlaZsI3JOY30Om78jFkKKvHarqyigjqgAuGGh?=
 =?us-ascii?Q?wuFnxzSxPpennSYBEZguEfAgYGpPA5FinXMLmEbtbej3QmNShjApsCDQhTJ0?=
 =?us-ascii?Q?XjOrhQh4aQiuLQdSv4VkUY8T/a2eeX96jyaSJlrhk6k9bA5sMZiectj6nYVs?=
 =?us-ascii?Q?HYyt795EpM7md9jxlq/ww+Zyj+PslX8xveOD5DmhIJogOXYaAWTyq7AvE1KT?=
 =?us-ascii?Q?1nfOSf8PXmRu3MV5U5II77sXhR/vUt/bAI1Ki30o+6FQesJs9wAEt0bXy1YK?=
 =?us-ascii?Q?fwYhb/9mccT3Mf22OOiOemmIjFEPkGwKG3gUZhN2Jg9reGskfQukwL+SgjZ0?=
 =?us-ascii?Q?jqbRBivXqcLww0+EEar237AEYR3KRKHVWBzyH1AvJnJ/VCJSipTSJq9dI7GD?=
 =?us-ascii?Q?czPkPx8JTYVOi7IUeKwj7O2GDyfqvEHWEKnjzdSCuhwZULMM9Qa87+2rdE/l?=
 =?us-ascii?Q?zVxLKcso59W9wVReACobLacYnleTIvwQi3wquj/giElSi8t8hzGVcwvCGvZH?=
 =?us-ascii?Q?+1Bp+fJYbH50yOWlB/ZXp28CAUr4LHaUvWOGpFAYG0QFaFfWWlS0x5kCIeYB?=
 =?us-ascii?Q?c+yUcsstKIxtqpuEEnHWTjdb5IooZvFeMGmIARrT25kpcZcPtCTLjp3NRX92?=
 =?us-ascii?Q?pIkHseISmx/eK1YjNbFhn/JmydAbWpbkkCgZ8jk/TZA1kcHA4xg8F6hvNSti?=
 =?us-ascii?Q?W3LJiYRYRyIEwTdObONFusqq7qfuPicmHQZvsAFowVuexWOpxHqr5n2cn1ST?=
 =?us-ascii?Q?O9nAHA9forDA87Ucp2XwUR321gAJzbejcgvIwsogTfp/F5JvBEUh6sIUfxGS?=
 =?us-ascii?Q?EG7ZRXMl/wO+po0cFQp3b0mK3Id6NxlqwiDg/hsueGvT0h50uu5WkcDu6BRL?=
 =?us-ascii?Q?SuqIjymcBxtfv4WmpmceKHDeTMyDL4b5tXR1Sp2QqxYfSNhaa+xB0/H3Ya/O?=
 =?us-ascii?Q?1T1QW/SZ1ul9KZjGXn2EQIb3plID/zia9qQiU/cVr+xh4FVGjzPMWHWD9a/G?=
 =?us-ascii?Q?e+M5tzn6D/b3dgEADq6fN/b4GIJCaErL5RMDDzwYHfnwoyJKHup1796KqYRt?=
 =?us-ascii?Q?UN7SgIDV53EDIA6mBQel/q8lGQXB+JXOeYyMnvvCqX/x4QHYZsQ7LLZ67qjE?=
 =?us-ascii?Q?uz+m7tKpp9l4GBWxX3gFxTCkh1Id2/8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D22FF4515BEB8E4491AD5E58DDA87265@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24abf912-0f35-4494-2155-08da4569b9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 14:02:41.5063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpbUdbgO1bFbza/BNVL7LOExCUOW6lltqoV6JZeVWJMPAPvhq6r80HdFWrCjveY286VbJc1ZEc8Gbivg6h1XPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4840
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-03_04:2022-06-02,2022-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030062
X-Proofpoint-GUID: MJeNy7lGM4KAyM_bEgixm4bJFIcrtHn0
X-Proofpoint-ORIG-GUID: MJeNy7lGM4KAyM_bEgixm4bJFIcrtHn0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 3, 2022, at 9:50 AM, Dongliang Mu <mudongliangabcd@gmail.com> wrot=
e:
>=20
> On Thu, Jun 2, 2022 at 10:30 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jun 2, 2022, at 1:56 AM, Dongliang Mu <dzm91@hust.edu.cn> wrote:
>>>=20
>>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>>=20
>>> In init_nfsd, the undo operation of create_proc_exports_entry is:
>>>=20
>>>       remove_proc_entry("fs/nfs/exports", NULL);
>>>       remove_proc_entry("fs/nfs", NULL);
>>>=20
>>> This may lead to maintaince issue. Declare the undo function
>>=20
>> "maintenance"
>=20
> Sorry for the typo.
>=20
>>=20
>>=20
>>> destroy_proc_exports_entry based on CONFIG_PROC_FS
>>=20
>> IIUC, the issue is that if CONFIG_PROC_FS is not set,
>> fs/nfsd/nfsctl.c fails to compile?
>=20
> The answer is no. There is no bug in the code.
>=20
> At first, I thought this might cause the miscompilation or bug. But
> actually the code is fine.
>=20
> Because remove_proc_entry is defined as an empty function if
> CONFIG_PROC_FS is not set,

Code inspection does suggest there could be a problem,
but I'm glad there isn't one. I can drop this one.


>>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>>> ---
>>> fs/nfsd/nfsctl.c | 16 ++++++++++++----
>>> 1 file changed, 12 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index 0621c2faf242..83b34ccbef5a 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1450,11 +1450,21 @@ static int create_proc_exports_entry(void)
>>>      }
>>>      return 0;
>>> }
>>> +
>>> +static void destroy_proc_exports_entry(void)
>>> +{
>>> +     remove_proc_entry("fs/nfs/exports", NULL);
>>> +     remove_proc_entry("fs/nfs", NULL);
>>> +}
>>> #else /* CONFIG_PROC_FS */
>>> static int create_proc_exports_entry(void)
>>> {
>>>      return 0;
>>> }
>>> +
>>> +static void destroy_proc_exports_entry(void)
>>> +{
>>> +}
>>> #endif
>>>=20
>>> unsigned int nfsd_net_id;
>>> @@ -1555,8 +1565,7 @@ static int __init init_nfsd(void)
>>> out_free_subsys:
>>>      unregister_pernet_subsys(&nfsd_net_ops);
>>> out_free_exports:
>>> -     remove_proc_entry("fs/nfs/exports", NULL);
>>> -     remove_proc_entry("fs/nfs", NULL);
>>> +     destroy_proc_exports_entry();
>>> out_free_lockd:
>>>      nfsd_lockd_shutdown();
>>>      nfsd_drc_slab_free();
>>> @@ -1576,8 +1585,7 @@ static void __exit exit_nfsd(void)
>>>      unregister_cld_notifier();
>>>      unregister_pernet_subsys(&nfsd_net_ops);
>>>      nfsd_drc_slab_free();
>>> -     remove_proc_entry("fs/nfs/exports", NULL);
>>> -     remove_proc_entry("fs/nfs", NULL);
>>> +     destroy_proc_exports_entry();
>>>      nfsd_stat_shutdown();
>>>      nfsd_lockd_shutdown();
>>>      nfsd4_free_slabs();
>>> --
>>> 2.25.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



