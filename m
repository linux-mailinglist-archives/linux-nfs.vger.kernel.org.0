Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3067F888
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Jan 2023 15:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjA1OPQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Jan 2023 09:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjA1OPP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 Jan 2023 09:15:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A77222E5
        for <linux-nfs@vger.kernel.org>; Sat, 28 Jan 2023 06:15:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30SC7s2k015181;
        Sat, 28 Jan 2023 14:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=a1ukfn1kVjhiI7zbnSGWl3DlCoxfMYxY6NOvbY/sgXo=;
 b=AGSgrEdVBI39U3S/dF05TK4ZDaUxucH7BSiqss+5uI1fUqZaRDAn68GosVK6ArQ42zwm
 c3a9op6Cfajq2w916cdFh7g8c6N4zUh+JSfO0GF8Q8U64p3nHtMJI3Ss5pflOCct11dG
 UQFrgGyYGVMnE2cWmbbtmB0FQf7oOTpf6YQOnlxWgLirqTyJQRqobdXCbbcE+LnhFGcX
 i2eyvcBsjS86ba4RHAb3MNJG6WLMFd6+R9DQISom6LboudrB45Sxagwr9gw2HI2nm5I4
 hOoZFIGcpLT8kFryyoZB7009klyAoqnK0110ynI5WlbbOmh1Qa08BWj6aVsWDFQWoiCR 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhgh6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 14:15:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30S9fSpB000861;
        Sat, 28 Jan 2023 14:15:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct52eae8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 14:15:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIsOTlZGEdLoXcAVSo0rF4exyo5tBCNph7pC1YigZy03M4OqBIUskyeZawCJSWS9keqaf95+e0wWXVG4xP5FV3E4sqWSoYJlDI8HGv7ViEdIWKfxF8LZbXhFodexaWQLq6XO0jcVnPQZLI3nJG85MK27oiwOoK1Yv6VxwHCmKtM2HCZmsjFnyyFERJ/kRz4GvlduEVimwrA925GxdkwhiLwjxzIZzXxM5LnUqQAv9JbiLyZYLk3tcYYUQh29EyXoNyXJlcVfQCHvrP9NLvk0eglpzCf7mKeUFpSRY+e4z9SoLZpZR75fXfr0VVtia80a7I6Y6AkP8YoBoxbZE1pGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1ukfn1kVjhiI7zbnSGWl3DlCoxfMYxY6NOvbY/sgXo=;
 b=Vxd9Rfr0NRNWr5a+1r7eKsu8AuBdPlDbwcpJCVey1uDxrqO5eyNl9PaTVp0dCbPvokvoPi7qbyww6mO42enLZCvavQN+ZEc8R4s5IWjqfcBPbno2wEjTKJ+jiH0VkKmyU+BL+QseTS/iFAjwTGErdMmitdyd43DamDoSmyrmSAT2V4pZGnVukcGtsbWPR3NVdgEePnY/sxarMPp7GWdTdwSMr+AFsjPM59WP9jX1PFg0djwrC8fkZ96GFUV5Lw+X1BP89+0y5vDX9D1zOazVT4kJ8AV3meJitfVQUPqK1EWiv5saPpNMn7uX3famJifouMfrW4UJwEima7AGNlyjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1ukfn1kVjhiI7zbnSGWl3DlCoxfMYxY6NOvbY/sgXo=;
 b=XS0wiqOdZDEK16aDmOWqsCRWl3w81w74fPHSjhlpBBzjFWXGCqYm+K2idnVjHmXQIbiGCYwQGHr2VImRmzkV5bU9M/f0heq9hhjq9A01fSqNiCDjYQs6RQnTQOfssgZa09luaBUQxJMhi5/W6+5B4wz3XeykqtvjiInBmKookzk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7398.namprd10.prod.outlook.com (2603:10b6:8:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Sat, 28 Jan
 2023 14:15:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6064.017; Sat, 28 Jan 2023
 14:15:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nfsd: fix race to check ls_layouts
Thread-Topic: [PATCH] nfsd: fix race to check ls_layouts
Thread-Index: AQHZMmsV5D34wjZzDESw+lpk/7zjnK6ydZmAgAACMwCAABbPAIABRlkAgAAEQoCAAAfHgA==
Date:   Sat, 28 Jan 2023 14:15:03 +0000
Message-ID: <34272738-0EB5-471C-A978-66F763664B7E@oracle.com>
References: <979eebe94ef380af6a5fdb831e78fd4c0946a59e.1674836262.git.bcodding@redhat.com>
 <C9FA580A-52A6-4208-AFA2-91E8BCB36B9F@oracle.com>
 <49815925-FB60-456F-8633-79B4C203B782@redhat.com>
 <0412daf06541dfa71866be1efedef5456e524ece.camel@kernel.org>
 <A1324B12-C0FE-4A60-8116-4DCD98C92A8D@redhat.com>
 <4305a18844f395657ef0fd3af313d8e15c330499.camel@kernel.org>
In-Reply-To: <4305a18844f395657ef0fd3af313d8e15c330499.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7398:EE_
x-ms-office365-filtering-correlation-id: d9fe1d2f-539f-4269-c5e0-08db013a0c9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rV9nLgAInUJpckMg2NLuFJ8NAfKsxXphqi0c6P+cwa1liNongMtp3MTWDQAurEIWa8/CoDu+8sULh5/cXvOepWuoDtIMezFdR5qAfPWbKq/Uc7Gf00DrCHA/4miuZpekH8hZoZH49l7h+4yMr+V3MLbXMzMFtE0UDbScvGQlfK0yS3CNlIVWHPhw8yiPrJGz11h1pw5vEbmIiHnQl0TojxbYx7ZrpB5t4AZodaYqT6WmbnoOb6/O2T8uBZWzq6O4uUsblhQsZxX1bHV7aXJVVNxbA4csJHldHq0m1No7B8DAT9AYbdxmMH+AacBfkJ2WVAnBlzIDY2OdLrUy+4qiptPF2SWarVS1DHw1yzkqoug/WbHbWyHKupoeh59AhvyYxVoWwizPgVyz1ii+yGR0idRfOf/4OIq2BSR/DK1uUzRA5vTYVo8/7wsYwNhq9eDT5L26B5vtMmfMPRYPLlL1Stt7+8dJw4HJCRZE1gPqS2DLSXGn7RQVwTHfVqOTzOC/EsFKTTxqhKfjFIzCNLzEkoFcf9Hafsg0Yd47Bw2DEcZIhJjHm/WOUPVoanTvE7zDeYkUWm6WEUS/Z2rLEHBYShmJEkcv8yvFzIIkI1y8T1yw9R7ciOcJdkSVkUkx9ARlF/RelZ4dcvlHP8CCXSKwjDgV2mU/IvTFBOlxrDR6JVUnixXp9nwSpziuTDGy8uWGrwv6jHYU9R/tJipo0nbYboDIKbzm2UsBYlV1VZJ6oGtTVkLFqYFk9qNCBfM6qb21jh96bTrKp7Tnczlk8nUeGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(8936002)(38070700005)(41300700001)(5660300002)(6916009)(4326008)(66946007)(76116006)(8676002)(64756008)(66446008)(66556008)(66476007)(91956017)(83380400001)(6506007)(53546011)(33656002)(316002)(122000001)(38100700002)(36756003)(71200400001)(86362001)(54906003)(966005)(6486002)(478600001)(6512007)(26005)(186003)(2906002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?brpElSbhrt0EN6uxh9jqUg9gRVnwBu5tYb71eJgk5TuRe8MlHlaFSvIChgof?=
 =?us-ascii?Q?fVOTshuOcAKUgOc+z7TMVbIYNVEOUZINMHrN8zNWWUYozPxu3wF6qOP+Lupz?=
 =?us-ascii?Q?min03oU8lDU37jDwSzM66bWFOiT2FWu31BEbWoG7n+JIj3B1RyzqaNTJ8bvp?=
 =?us-ascii?Q?PSXDGYvxoKihcikQ+LARYdsq/yxHHBP+bvdqD1iR3P4Osudh0mQZMIInWCK6?=
 =?us-ascii?Q?n2nZWWTyQV0ypj79JEMvjGezt632Yn0OjpyRvzh6AkLGFq0LhSWu1Qy1lVrq?=
 =?us-ascii?Q?AyiREwOmG+JsRJAYiDJMRsuyrsEoe3q9EuNHN8wEWi3c7ZakzhwLEvu2Ex6s?=
 =?us-ascii?Q?X3aoFdRWBA82/djmIOjS9pvi3VnCfUYnuyl4MavUIO3Bpddvsr7m+0rcIXjQ?=
 =?us-ascii?Q?6x8hCER1vFlTtVizigilpxzGu4kpOqhTLcmLv8xPmFicUHeKCblf13gLLivb?=
 =?us-ascii?Q?lRnEyeuS4isrKBv0JqyYLJQCAFKDbZ3ojTGTmeJLRzLpUmfvFtIxNc3ho1p1?=
 =?us-ascii?Q?3gc51wOaKx1rJESIlzNoiUm7sxEd1mbmvB9N+eoJD7YJ5PMEypAQ+KRGXaot?=
 =?us-ascii?Q?Qnu37EKghMi9XL2FhbPqqirLa7DzPUiO7jrBiH9iNz6DH8L/Hdtn+uqi+5SL?=
 =?us-ascii?Q?LgiWAyuCJimU0eym4oES6r/VMstRI+ZufYgV0B8CNFH/5vVsH7U9CoilxMyP?=
 =?us-ascii?Q?tYARUmtbtkRAg/ShLqL6Q+Y8/TCq8gBczBfHVF8onDs3sfFz/v3Z9KdWzPp/?=
 =?us-ascii?Q?21/m4Cn0CG/KU3L6lqA1CH9Y5WSlQdrpcPGcubDtHExAHnKdwHEvPTFdbmMn?=
 =?us-ascii?Q?HVN/8ZnQBkq9nwfZX2CcgdPHw8SOGPDs6n9U4EwPjMEqOSv9NnpA3LXM2T5t?=
 =?us-ascii?Q?9Yf1joe1//p9O1YzE0dSfsfUzdL/Q1ZJ2UqcqWomeOxEnG6Z0SkFwpMCLP5S?=
 =?us-ascii?Q?jyVXlF6tOLp1RmuQAYT7IDDfkABu5a1FnDvn2o/9g+P0gBtP331tIr3LkaWo?=
 =?us-ascii?Q?wNU4TWET0UphNSXTdp9ZRfZWpo0djdM81XaPVqx1Z0XtJBvj3j6VkDvTvs/f?=
 =?us-ascii?Q?k+nyTfWQDdI0vr8cZ61NlE2chgsASjXRLKsbaTUSx/zNAJEMntSb32JwIUpg?=
 =?us-ascii?Q?xr5jTwAxvx/SztncWyfi0jFy4Sg4qNMCRTJaNO321izriEHV9lECGaY5PNUo?=
 =?us-ascii?Q?H990ht/HcsDp1M5mYw28Bru/7wLuvq52aqTxN3GTv0m9NqOG3rfajIFPKvjD?=
 =?us-ascii?Q?6iQc9aGILKb/j2zZyoRLwRWQ8GV7CuJaS45VVe9wyPbG01TVwP7xPno9JjU4?=
 =?us-ascii?Q?HYhqlMn8fP9v8CpwLdFRx83LzbpRtxMBuxTMT9uezdaL0ziDNrew681/nCxG?=
 =?us-ascii?Q?Zv3gPLb+pxgpdBAgdsj20v5i/JYrglucPf1QhpcwJOEk6TKyr0M+3oOOzwBH?=
 =?us-ascii?Q?WtsJIHY9/vK9Yn3qXQloGN11wm8ZeuTWHbIY2xEc05nVrm7//Ob/kPOt0LBZ?=
 =?us-ascii?Q?BQrRM6DIq1KSNSqrgpEG9uV0pvXmFCP4pw2Ayq543xK9LwO+FJwYvDEBh9Pg?=
 =?us-ascii?Q?NOL5JLkWynDCPdj5FxFphP84nq3GtUUDrViwXofW9L67R9UcHwlMrkIFKCKH?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E3F67739EF1324D9787FCF6C9D9FFE0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kYwerrzyzYiBPTRf5DaTg+tDkGneP3q416pIXxAS0khavB2xcxICtxmTY3+AhEGGpnhn69irQbWxPCIobgSNj09G6i8hRiUA517P9o6AseBx5aHa0CM4Ni1RGsiL0fUVtAQuUXyQGT4/+kl2rEnXv9CtLyzAHKqvpVCXW2SMg11P+r6hoIY+vfhbKXUizohcuf8sl1K1k/ymvYiNcXPRtrfxBp89Ba0ocA/tO6EmP16M7oqpjcbhAb3JLSTZNc0q8zcrlboD5laTwkJStWk8Ew6ytoKlLQHN9Vr3WgC+8ohFu3juW8nX+uMQjIZoi1vVPdMaw+Jjgwgn77m/pieLDJqeVQEUc4Fod6WvPRi4oUhtO382fjjTM8+Pu80cpIWP013GR+P0hyWrGrsFq7hqJe1yPzkSzD/9ZOk+pPt9yI+8dpt1mEyJYSIjie/ZtioEo69G2A3C5ks09H1Ixn2yYgUn92fWJM8/3Zjm2pFjfjhVvx+yzAqz6v4NBXNtT3bgeLGUJ2jy5kRl6nULwDpOOqusgHK/RLenjMHNkJGniNimy4vnIGU6yq2AXeTWnSKeGfIqcRbh10B4as11xkSnMN+FVmsOn6BdNiJG0wjreHikjIRbyjcreW5tjcMlaY2cElG9CneRXg+MMZ0QCG1Mc9YplKLdXGtUK942WfbW5/m3sQFmgveXzbGfxJZpSmtmMtd7ANNwCLGavj0GEcvgTOeJhZzb0Nl0ozgwaIKe+nzVqfpAxc0nHQV3+0JRYIoGqTWNA4rJS2K8xw/KukQAOLSyHymH+zUfpvhVOvc0fqMsSNWGOWi14GOvDTXQNEniRJEvG5IP8r7B1oodGAUBTw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fe1d2f-539f-4269-c5e0-08db013a0c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 14:15:03.4273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtMYlJBnsnerotDbYxjM/rAh3yYXF2zQYT229vSb4wpSmDOTMQK4oxeCBymQxMDLCRmpp8Ykd5ZIs2czho0C1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-28_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301280139
X-Proofpoint-ORIG-GUID: pvMl7KoeebhAK6_l3xy7WGOO27O6LYJl
X-Proofpoint-GUID: pvMl7KoeebhAK6_l3xy7WGOO27O6LYJl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[ Cc'ing the original author of this code. ]

Proposed patch is here:

https://lore.kernel.org/linux-nfs/979eebe94ef380af6a5fdb831e78fd4c0946a59e.=
1674836262.git.bcodding@redhat.com/

> On Jan 28, 2023, at 8:47 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sat, 2023-01-28 at 08:31 -0500, Benjamin Coddington wrote:
>> On 27 Jan 2023, at 13:03, Jeff Layton wrote:
>>=20
>>> On Fri, 2023-01-27 at 11:42 -0500, Benjamin Coddington wrote:
>>>> On 27 Jan 2023, at 11:34, Chuck Lever III wrote:
>>>>=20
>>>>>> On Jan 27, 2023, at 11:18 AM, Benjamin Coddington <bcodding@redhat.c=
om> wrote:
>>>>>>=20
>>>>>> Its possible for __break_lease to find the layout's lease before we'=
ve
>>>>>> added the layout to the owner's ls_layouts list.  In that case, sett=
ing
>>>>>> ls_recalled =3D true without actually recalling the layout will caus=
e the
>>>>>> server to never send a recall callback.
>>>>>>=20
>>>>>> Move the check for ls_layouts before setting ls_recalled.
>>>>>>=20
>>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>>=20
>>>>> Did this start misbehaving recently, or has it always been broken?
>>>>> That is, does it need:
>>>>>=20
>>>>> Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls") ?
>>>>=20
>>>> I'm doing some new testing of racing LAYOUTGET and CB_LAYOUTRETURN aft=
er
>>>> running into a livelock, so I think it has always been broken and the =
Fixes
>>>> tag is probably appropriate.
>>>>=20
>>>> However, now I'm wondering if we'd run into trouble if ls_layouts coul=
d be
>>>> empty but the lease still exist..  but that seems like it would be a
>>>> different bug.
>>>>=20
>>>=20
>>> Yeah, is that even possible? Surely once the last layout is gone, we
>>> drop the stateid? In any case, this patch looks fine. You can add:
>>>=20
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>=20
>> Jeff pointed out that there's another problem here.  We can't just skip
>> sending the callback if ls_layouts is empty, because then the process tr=
ying
>> to break the lease will end up spinning in __break_lease.
>>=20
>> I think we can drop the list_empty() check altogether - it must be there=
 so
>> that we don't race in and send a callback for a layout that's already be=
en
>> returned, but I don't see any harm in that.  Clients should just return
>> NO_MATCHING_LAYOUT.
>>=20
>=20
> The bigger worry (AFAICS) is that there is a potential race between
> LAYOUTGET and CB_LAYOUTRECALL:
>=20
> The lease is set very early in the LAYOUTGET process, and it can be
> broken at any time beyond that point, even before LAYOUTGET is done and
> has populated the ls_layouts list. If __break_lease gets called before
> the list is populated, then the recall won't be sent (because ls_layouts
> is still empty), but the LAYOUTGET will still complete successfully.
>=20
> I think we need a check at the end of nfsd4_layoutget, after the
> nfsd4_insert_layout call to see whether the lease has been broken. If it
> has, then we should unwind everything and return NFS4ERR_RECALLCONFLICT.

Shall I drop this fix from nfsd-next, then?


--
Chuck Lever



