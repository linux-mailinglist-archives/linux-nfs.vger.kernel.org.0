Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15BD3A2D8A
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFJN6s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 09:58:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63078 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbhFJN6r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 09:58:47 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ADpK6b009141;
        Thu, 10 Jun 2021 13:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yXny2dDu2fzafELbaeIkLprd1D4dW0PSusl58JBf0AE=;
 b=t9qt/EYJNnB2BseBaAB+riJoXAR7IIS0cs/ccQOVVJ2KALlLQPwGAhF/JzvHgNXBWt6h
 P0GgLNK3o2BdRnJsBkLw118FI6CzF7Tcc6znF2vwrBtDBb4so57IavEcAQUc2n0c7sNu
 tRz4O2ChWzy5vYQCQe2H3wvQVf4P2ykI1vyGhd4RmNyRmpLHXy6uesWK5wps6Qiq8QeP
 EwYG5UvimHVtZArZbAvvCmPMHZq+nH7gTohyZlvXy1SxQ29Qoi1eiYK+mIthCXir0AB/
 7GGjnx26eSa6B9Coi9mlwJG0heCLtyr6+EZf87wBnFPyXNw38rbVU9Igetk2XmNxOC4H oA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 392ptc8m9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 13:56:44 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15ADuhAf104638;
        Thu, 10 Jun 2021 13:56:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3020.oracle.com with ESMTP id 3922wybj0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 13:56:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsVbg4jDmNXCLnNlMjSPJSR5a+SBU6Uaqo0Pe69FaWsnRPRuZG8B/B5DUJPzVGrvtytmphBWfD31C5C/YNX76QEaAOGDzvkk4dpGO6LQWCs3qyZiZewrx7KHShRNBRMlK56vpWZhMjJm9kNJZYZjWI1jTXTLlPsZjeV/euOfTD0kv2LB+c1By5g2rKc2oubA3wxoYtVlc9EHpO/BJqJJfpTSOebL9CdfaEL5bH2OXu9y4vHQAdHbRZgw+9huTLYjjVyPjJOO33UXVUtCJBAEnFI5RLO8RK2bh9MBs8O3ZsWdZ1+5mUFyJvSRFu1afUv4Q4wPk5UYjby6fpsDae1K9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXny2dDu2fzafELbaeIkLprd1D4dW0PSusl58JBf0AE=;
 b=gJ09iqkWze63ts7D+V0EsY5FpGdOkab69+6oxA1jghCGzwrXkkHR4O2q3Dsl73sBT1JCJljcuaQoE2fpuoaKiAU/Vg4eznX9Oak7XtwZArTpPIKzaOR8prTL9Z55QUNMwIunBSJ5KtG2Q/wVX1WFQ5NduuT5xeyMHMaMaD9Dk/cRztGInd5wX7RA+qeZAm/oCeoYiyfYGGLp6n0PqwSTw6nLvj5WZ5dSP5MH3eK8HP0C5K5syyhsJWX76gKw7mFuI7ATbKOmz5GT8i5fZI5cTCSvGD7sdUlDq8CQVS8sjMQnB+NmE4/8c7z2vD4rd5EGNnsOVWbebglqzANYzbpOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXny2dDu2fzafELbaeIkLprd1D4dW0PSusl58JBf0AE=;
 b=T2uTSxpox6KYVtjGrrKCMA0KVxGTEdwEKRK5Y0cJ+gFkRvDPdRPQTvq9NKk28vb3cO3gEhgRlmH490As+MXwLIdz4CUE6VutlE4T9LJXtfnYlDcFgfztdqN0o44BP9vhGIoxJUYzjd67loAXtZs7AcXlCJtwrA54hqtcK1tamd0=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by CO1PR10MB4580.namprd10.prod.outlook.com (2603:10b6:303:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 13:56:41 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1%7]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 13:56:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Topic: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Index: AQHXXXoN9xSEM+vT7E6aMlyo/90m26sNPoWAgAABLICAAAY6AA==
Date:   Thu, 10 Jun 2021 13:56:40 +0000
Message-ID: <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-3-olga.kornievskaia@gmail.com>
 <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
 <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
In-Reply-To: <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e572f1f8-ae70-4ad8-0262-08d92c1792de
x-ms-traffictypediagnostic: CO1PR10MB4580:
x-microsoft-antispam-prvs: <CO1PR10MB4580E9FFB06A042FDD46F4E793359@CO1PR10MB4580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJryfwLk1OTm/udoX9Mds8f8745CcNvIy4mQzGBXILcgqU9UZpsnufjP0dpvgaekcMKXFtOD1jyXak0+53DWE2JWywydElLivzOGY2a2o/om1s4Ju2m8q97t7V4DsSlOSHg9+68hWEL9GLzQ3yLeVJCFRKAhRMx/IzElEQVmwLuUaL0MHsgAsW/xqH4j1bRI3wwKv2/Oz9YsY0hx0yXvqdQPK5FKH5ZWr+l9plgx7GBdQOmeNFopXAXW6DQJlOZdrARnBqEw12O3RYVWbacY47PjNKtoD8hPS2DQO1GN9ZNoM2MesOySTNrRauQSgCWlcT9HOzowy71hf5fs4+qbgfc7waMcO+xzXMBft4KKikweZCmY6QzLwPwOK5a0a1i1UgfICBYPB6vxfinM6nQtFyWY552Q+VGUw7weMeg3GyvbGmeJve/HacACI5TFO2TjvDIMZIIyBpv1jqstjs1kBgow486yxlc1fWDl0pPLG2/ukIjeOerTK+3A5bNBSkLJj5mkf8kKwXalHkJEWrzUIMoWmKanOZgtLKlbE8zxcnrdj414ea9ombwdDpV9rvku9y/evSszPjThk+5O013aD3b/VXkhKyEwzMkX2I7lbhpgImh/9I5i9mYOaKrB/OP6qdLfNJA7gmpWo1PvGhrs1/O+mqQ2N43x3GICar9IsSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(376002)(136003)(39850400004)(66446008)(6506007)(91956017)(76116006)(66946007)(2616005)(86362001)(66476007)(66556008)(4326008)(54906003)(53546011)(64756008)(33656002)(8676002)(6916009)(38100700002)(71200400001)(316002)(5660300002)(122000001)(6512007)(83380400001)(26005)(478600001)(2906002)(6486002)(186003)(8936002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c0SH+QzYKQhwjJUXjzf45BiQcuU6VP9Iftpgd4m9PBEdb5hT+iI0FETuhdFG?=
 =?us-ascii?Q?GNaVGOG27+PkQJMS83gy+WLl9WfdBG/TmhxqVmajRyuGjS9GoTz+rKfXUt70?=
 =?us-ascii?Q?pFBRShCKvh/LpWhwGu3f8i/6G8pH2fkZvK1AJhJLWdGvfspWprGlWtiBQJxB?=
 =?us-ascii?Q?kriGdf+AEteaafLAr6FiZAIsqZIu0wbROo6ZuFnPrEvUMF2Yi33Doal1XYRg?=
 =?us-ascii?Q?V7CiabexTQ4b7el/KNhoybbdML+IRoKb6+5ASB1qL+srmSrpryYpZMGYciqq?=
 =?us-ascii?Q?X2IXKEZh/shficaEaq9fJHEFrCYvExYxvDk3djdELbyb8Hn6HhmpzWsfwe8u?=
 =?us-ascii?Q?fmRSmcez0jFqDUIZfM8lcVkBHZ8EY/SVw2ilG1RkwKyhSEPt1lnk8YVhHXUn?=
 =?us-ascii?Q?X8DovprXIWvxH2VIGBOgSnxkGTbDeTK7H8OPdhC/g8rmZh0fZ5u1JAS5iduz?=
 =?us-ascii?Q?8d9QUZ305bmzV1zHvxmkPiOwZUbbJhp64KKcb6RWv0+HaZwaoTzk5a6byOkI?=
 =?us-ascii?Q?3uJ8uR9vWN2Fb657sLdrb6nepzNSjuFe83IgbRSJuXiwXWGmWTSw0cmSosbh?=
 =?us-ascii?Q?3NSlY/qy4wx1v0lhK5XkJxo+9jexYhwIGrcSKyE7XA+4b/MsbnsKXe9dq1a6?=
 =?us-ascii?Q?z9DdFZDINnRUsGPRntF1fTrbUfV86Tm6W9D+zAt2RaAFoM6OxekW4JWk9NjC?=
 =?us-ascii?Q?5zeVHr2lhXb4WH5TNMrUPNBi8vFfU9aAkJaShXmsOu2FoaTV1DQFzEwbVLNl?=
 =?us-ascii?Q?gE0cHy8iBYpFDETf89BqOkt1WGdelVSMjaQVNa6UrOeLyW2Cxy8aAhhzEzcg?=
 =?us-ascii?Q?oWyRB3N4NFxpHrrNt6FUVvWAbrBtH9UDrv79R7Uv30B0vWZXjgEHZzTZqvQ/?=
 =?us-ascii?Q?O35RMAsNIVs85DLDbwrulYh6Cc8nCYLT7A34SfQPy5WbiElkmNEe1j77Z8ak?=
 =?us-ascii?Q?fBqyfT1rNbOfwyXfFpiO+GItacuAQizgNzReqDsOxCYPaeVQ3oQqYlYQz7Z/?=
 =?us-ascii?Q?mtrXjNasQKsm5pKQ+GmLPZQnPqM50qcie0Kbu9O5v9p+Pv0lYh5D/1aQPMB4?=
 =?us-ascii?Q?gYwK4pP/DNgkH4L3MRyYfsdzSFlUF61BrpM0RaBKfEQQJAuGVP9IX8CVTkx8?=
 =?us-ascii?Q?YbzSuckbr7QmU2bObCn9aAKVTorHOlC4cAJC+ke3vCovaGqlmAfzldlw506Y?=
 =?us-ascii?Q?MODmyNvgXnrRD+/XX3JlyldpQu8vmS5/7g3Eyt+G0JspHncaRbQYL/zvgc7F?=
 =?us-ascii?Q?kY1KpBdiyNJHgb0tLtK3/XrC4ej+vRo0hOpreegFUs9x68jfcTL93mXb6vpP?=
 =?us-ascii?Q?9U6siH6JreWrmtJmhQ3f8gxt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A5733F14D20E44AAC0B59CC9CBE41D4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e572f1f8-ae70-4ad8-0262-08d92c1792de
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 13:56:40.8145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V+yjuQ0k0bMSMe4kw+054VY0+p5rokn5z0JLvGrUXpiw/njJHN1jEZSIlB8FNovKqr+5+Q4gd0zz5SfFznF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100090
X-Proofpoint-ORIG-GUID: fkQW0MwTA9UoUC6rhsGF-jYq6_jPSwzw
X-Proofpoint-GUID: fkQW0MwTA9UoUC6rhsGF-jYq6_jPSwzw
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 10, 2021, at 9:34 AM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Thu, 2021-06-10 at 13:30 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <=20
>>> olga.kornievskaia@gmail.com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> This option will control up to how many xprts can the client
>>> establish to the server. This patch parses the value and sets
>>> up structures that keep track of max_connect.
>>>=20
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>> fs/nfs/client.c           |  1 +
>>> fs/nfs/fs_context.c       |  8 ++++++++
>>> fs/nfs/internal.h         |  2 ++
>>> fs/nfs/nfs4client.c       | 12 ++++++++++--
>>> fs/nfs/super.c            |  2 ++
>>> include/linux/nfs_fs_sb.h |  1 +
>>> 6 files changed, 24 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
>>> index 330f65727c45..486dec59972b 100644
>>> --- a/fs/nfs/client.c
>>> +++ b/fs/nfs/client.c
>>> @@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const
>>> struct nfs_client_initdata *cl_init)
>>>=20
>>>         clp->cl_proto =3D cl_init->proto;
>>>         clp->cl_nconnect =3D cl_init->nconnect;
>>> +       clp->cl_max_connect =3D cl_init->max_connect ? cl_init-
>>>> max_connect : 1;
>>=20
>> So, 1 is the default setting, meaning the "add another transport"
>> facility is disabled by default. Would it be less surprising for
>> an admin to allow some extra connections by default?
>>=20
>>=20
>>>         clp->cl_net =3D get_net(cl_init->net);
>>>=20
>>>         clp->cl_principal =3D "*";
>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>>> index d95c9a39bc70..cfbff7098f8e 100644
>>> --- a/fs/nfs/fs_context.c
>>> +++ b/fs/nfs/fs_context.c
>>> @@ -29,6 +29,7 @@
>>> #endif
>>>=20
>>> #define NFS_MAX_CONNECTIONS 16
>>> +#define NFS_MAX_TRANSPORTS 128
>>=20
>> This maximum seems excessive... again, there are diminishing
>> returns to adding more connections to the same server. what's
>> wrong with re-using NFS_MAX_CONNECTIONS for the maximum?
>>=20
>> As always, I'm a little queasy about adding yet another mount
>> option. Are there real use cases where a whole-client setting
>> (like a sysfs attribute) would be inadequate? Is there a way
>> the client could figure out a reasonable maximum without a
>> human intervention, say, by counting the number of NICs on
>> the system?
>=20
> Oh, hell no! We're not tying anything to the number of NICs...

That's a bit of an over-reaction. :-) A little more explanation
would be welcome. I mean, don't you expect someone to ask "How
do I pick a good value?" and someone might reasonably answer
"Well, start with the number of NICs on your client times 3" or
something like that.

IMO we're about to add another admin setting without understanding
how it will be used, how to select a good maximum value, or even
whether this maximum needs to be adjustable. In a previous e-mail
Olga has already demonstrated that it will be difficult to explain
how to use this setting with nconnect=3D.

Thus I would favor a (moderate) soldered-in maximum to start with,
and then as real world use cases arise, consider adding a tuning
mechanism based on actual requirements.


--
Chuck Lever



