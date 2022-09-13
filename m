Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598205B7A55
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 20:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiIMS4d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiIMS4C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 14:56:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3846317056
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 11:45:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIfPvv027072;
        Tue, 13 Sep 2022 18:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=l4Py3zT5sk1uk/SBTJoiV0ey0a6kROV0lTJ4YlwEHUg=;
 b=nJaviPXwdnMfMrInjbrlKkxioeDIKfqxhFU5ULO7iTW2CJsq9Nm7YOrjao1jFsMrF2Nt
 pAzx9ReD3XORsUOYW6i1trWrs9c83Mrt/4Eh8sk3mDe1V7hsuQvckmW6reDEanpu69SR
 KrpiWLVa42T9i85J5pqDsK331Oy2IUpqLB+/HuaHw3klwf7OujM61r1GOj+7dUwjJOb0
 GHRWr3OYiOxUy5BG4jJiPvgc08TqL3XaYif3De3/3CDFhcqjXlk3Es9/UBkwpmBVeA5f
 gUZeVopCsHYCfvcs20t6Zan7qOs7S9kZdngHv0RvjS1ZwWsrWNl0SUoDXRi1y93KcGS4 rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyc82pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 18:45:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIRABO007359;
        Tue, 13 Sep 2022 18:45:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy5d8e02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 18:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWeEZbf6jVeDKfVgI7wfDrE8j70K+EtV4soKYoDdl0i8ZLeV2U6E3QIQbzkptAeCMwfuJEx0GKR1X30z8Nk8xPTMFQdRXDwStLhiHbNX3jcaU8IYZRNHW489YPH93KxV3tajSaeq9uNgk/L/xHrLg8zYR7Edld/WhgNDrCbSwXTYhUGMsjr4TLBdk2KCU4qgZCST0BCj7yRLmKGiCxD3jl7yNi5FPh/BV+mNZWmeRks/Hs0ajWD6CtC1kAsjonK+HArBaT4ljJI4mveVAdZB716GLV/jOJgQsrjkSaUV8+PRXGgInW4Sh58WiKJnomVBAnyjILvt5t4hovRnzPBdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4Py3zT5sk1uk/SBTJoiV0ey0a6kROV0lTJ4YlwEHUg=;
 b=nVKNPC2ABIfn3wcYAMKd0pfTJQX0Dm6pobWp0/4EBxd8Cogb+y32oBmDLbisBU2Js02p4rnZka1+rRNoqOqUAh/xbE+PMVmbpIGJidisxG1LMB82GGDG+hUZHdc6zZkE5x01i78FYHNyfvuSlZ/2UscSwqvKpnUMUvGffZVL3Y7mcbxB1fVdmV9Twt4poGq5PyXrKjLifbykkFM6yT4jZUWyZSLDc1KsMohoHpd4+DJqktz8f9qjsoAqT1itw2uU93Pplc8V2+SSq7xX0sGa8sCdFAUPV3fCt28F3SuZWRWTIJJtSMKlCew3dvufFsFw+pHHg5mNfmIX7jCi7XSSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4Py3zT5sk1uk/SBTJoiV0ey0a6kROV0lTJ4YlwEHUg=;
 b=mTStsXwDKWA9v+IiWaUg0pH1+cVSahfv9y/j4vEWFoJ14uIHTX85vkMoXFu1TPOZOeHbXRG7PFGq8Ob5YDrrCtrEtAMfavhmnvQlbffGezP6MvkH5slNOj6Jap5gCBOwZkO/BCVt/dGj4SYKC9VFqEIKUgFDF2GjGEFBKNb+Uc0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 18:45:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 18:45:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH v4 0/2] NFSD: Simplify READ_PLUS
Thread-Index: AQHYx5rrmfCuFExeO0iyVxj5F6vj1q3dsroA
Date:   Tue, 13 Sep 2022 18:45:18 +0000
Message-ID: <E45EC764-E698-45E9-8489-FF63A2A0FC5C@oracle.com>
References: <20220913180151.1928363-1-anna@kernel.org>
In-Reply-To: <20220913180151.1928363-1-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4915:EE_
x-ms-office365-filtering-correlation-id: 1085fb0c-ce0a-4bcf-fd5f-08da95b81b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rkDnPEawREg51KLihhfprN1LDU1GNfXy1SUGFPHb7frkxrNowA5A2dhRVfgODFpJ0X6imvDtlzPAIw2Rt24/voiqkT/4uiF404d/iNM02kJJBZR4Jz1uYhoHvPg9B3F+xbafTcMkgvBvEsjUhN0EFmpvIFobDouHcMhylZb0IZmgvdah1XooF2bsOXFyZkHDi1MJZppk5DLmLmewTiKdAiKvkuSJTydrhlKcpzSXxSBUPMzeCvsxJSvd4sjxz19PVdZBIhQWcg6ZZVfCQa2+FiWKd6rYBa//X4ZtpXu9veQ17xsxx99XogdsAbVurGVMSJQsQqy2s9Zpbc4Ta1Lrk4Pzvp4kCEUb4y8AbND9ISXVJDTmghuK0WL6us5j9guYgMy1uNXv0K9QA3cdWsJMmkTkbM+D1biryihNHCS8Gq6I9JL2BO9ITfYrbn19EP7vu9QdjP9tFvBV+acXcZIn+8115hydyep8tW17QOXvUUk1Ngs9ruzv6J05AHD2kIfxQrT6uqpURlMxF4GATszLEYoJF3trxJM97E2E+R5e6FwWdGWYnwIEkFQT9uHiPFKGuzHEf76OlJJXP2jGQ8nLD2nTuBeg8sBIcPCvX0bB5VoDJ35y1BJZwOWi+Y5C7abmmLGMobwd7Kv4se4RAUNnfQWCqzJIxVEs08qE+OxloOBEpqhBr6k1zzdTxrVWtJ3zZZgHtv93vXfzXZKOZOr9gGkn0LEYlP5gc61ERlDtSzbqeIyJ1gwOSk0YsrwtvZNi1EIiPXUBnwPLtGoD0V++6GZRuJFVvwYssWo2+DKozHs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(26005)(33656002)(83380400001)(316002)(6486002)(64756008)(6916009)(66476007)(66446008)(66556008)(36756003)(38100700002)(186003)(6506007)(4326008)(6512007)(8676002)(86362001)(5660300002)(8936002)(71200400001)(38070700005)(478600001)(76116006)(41300700001)(2906002)(66946007)(91956017)(2616005)(53546011)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BcchQ+7R+KwtnAP8iN4KOkx/Az2OUZ7fdb2rMC2C3opLByP78hEiXjP8EhQr?=
 =?us-ascii?Q?ieJQtJgqfFlrIJosnbtqgEan4j7jGoJlvkDHW2r5zJfRBG7wocw74nB5Zfev?=
 =?us-ascii?Q?bqOyL3ptGUDFjjWFDzmtiMl0TGPB1ZZ+ssbfYaeLIsxxqYCgYWnOp4BFM//3?=
 =?us-ascii?Q?nPYv+iMrsjMtjlyBoTb6Cf3MUYS3CweqGXl66/RJswnmZ1smLnnHh8zcHUdr?=
 =?us-ascii?Q?lH1x6+t6fDAaMZNJYuSzTBVrVD06WoGY1t7VmCosIW10Vrxv4DeUcMh+uhCX?=
 =?us-ascii?Q?7TYZtA9HWmPvt721ePFYVxikXa7MrJa3jcngyWhAS5FAfgljL0o2gst68ili?=
 =?us-ascii?Q?WedK3V5UKS/XuSavoJVn5zoVTjD3q0oIanEj7IKKWm+IZcDcewlNrqM1pZL4?=
 =?us-ascii?Q?A0kYNB4UFqrlwPW+W+05s0OFiD4q3FTsyGT7AOBMnXtOuD7M4HtOh80+UnQT?=
 =?us-ascii?Q?Q+xbakNMGWvcJ1a2VwT6PvaRc5+ZU2rdU0xhVgR4BfuqU4iCQmliwsHZ7/pW?=
 =?us-ascii?Q?2/SMJLs3oRz0c2sx9gfb8vmpkuR7vxVViDIHzqAmEihJ/0Ilz03GIKkJe5ZT?=
 =?us-ascii?Q?WYq2fwgV3GYJD5QxRnVb/25/IC9dPyOCM30GdJDYJPncWUJDukS8yHccQWVC?=
 =?us-ascii?Q?ACKFqPl8qC4i0leD3bHchT0dckPMAFEcJ7eFd/dAccUJzxY62R3HCO+NxoUj?=
 =?us-ascii?Q?/wBUYEtClDZfIVEYm7gU7lrG/txxByuYo0J8Axl0o83f3MOODY3g/tT/nhMw?=
 =?us-ascii?Q?YM7bG7ALre7K7oXThkn2hgt3AV87A/6UxhFGXOvlVjY1p7mxO1NW46UeN3Xe?=
 =?us-ascii?Q?w8cIGr8A+q77wiR4vDtmT0O34j8S8rVHQznbv6EXhVMuN7ZIi8VRhX42xLSw?=
 =?us-ascii?Q?d1KhxM4IQh1q3Z2eazQzyr419kaz9cCCFoFoaWMPXGeIy9Dbpu/Z2Bc3NBcO?=
 =?us-ascii?Q?hylBtInsKPgD/qRP3qB3hrz3NKZg34tXYGmtSbFZ2pQcEAH5K8ReM69jtpRT?=
 =?us-ascii?Q?IeMjFbKgQTtq+whT5B6yC0gJQKYZ/7SjdoWFZUDvnHOTs80rzpQfIOcDq/8w?=
 =?us-ascii?Q?BNombEfq+dHd8TFBKkdLbU2k1DF9TUhjOPR9bmyeb4t7+cUB0Lm2l3gHM4jq?=
 =?us-ascii?Q?hAMCHlI09vzV8yyX+qzoVT9CAhcikAhUjKgWHGaaKoYMdYZMRqt2Q4LucUpD?=
 =?us-ascii?Q?FYfBK0sZZ28U+6XAXXtOTD6SweUhTp2UiJXUyZOdcR7i0tOeWdQ/JSHBynI+?=
 =?us-ascii?Q?u/2lh3Ovc86jOSrZiQqQr2l1RAFrAHNQjE6yli5Qw3672djDtRFsXQ9XeBbR?=
 =?us-ascii?Q?KPDyyIOMt6/VmXJ6RgyBTO2VRdxAE35DeJedsCjMPlpfa/sCQj0pYoyn5YnJ?=
 =?us-ascii?Q?wd7ApFZivieMBDtoDoBrdVcPw7OH0J6xKnR6oAfv67eOHi+i9I2f9p4LePTN?=
 =?us-ascii?Q?kKS+VxX8wxZ16t8cU4RA4UzuhcUJ/AdX67/+Wll9+RGnGH6FfhGjbIpREN/B?=
 =?us-ascii?Q?oEITAvqIM2Dn6EeJnUcIKoLxpheqzc6HyNJ8/BWBmvlT8Q9AjRyLgReRzQm3?=
 =?us-ascii?Q?CBPzFffEvZkhIUDUXpkk/1nbShhPBT4XPtq93Jd7UsisbXfM1w/UJ+psiOrm?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4940ECA9EA05064DA7E0D9178C345690@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1085fb0c-ce0a-4bcf-fd5f-08da95b81b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 18:45:18.7923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FCNVchV+LoBdrbJGLg3zUib7b/AQvVk/k+oeP88nVsHr7YxCyxzn74Z/aPGvNeEBb50VKDtRkmCOMbLQqKj/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130086
X-Proofpoint-ORIG-GUID: U39Q7Qhvkrymbmj81IZRrWWapZx8yQIt
X-Proofpoint-GUID: U39Q7Qhvkrymbmj81IZRrWWapZx8yQIt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 13, 2022, at 11:01 AM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> When we left off with READ_PLUS, Chuck had suggested reverting the
> server to reply with a single NFS4_CONTENT_DATA segment essentially
> mimicing how the READ operation behaves. Then, a future sparse read
> function can be added and the server modified to support it without
> needing to rip out the old READ_PLUS code at the same time.
>=20
> This patch takes that first step. I was even able to re-use the
> nfsd4_encode_readv() and nfsd4_encode_splice_read() functions to
> remove some duuplicate code.
>=20
> Below is some performance data comparing the READ and READ_PLUS
> operations with v4.2. I tested reading 2G files with various hole
> lengths including 100% data, 100% hole, and a handful of mixed hole and
> data files. For the mixed files, a notation like "1d" means
> every-other-page is data, and the first page is data. "4h" would mean
> alternating 4 pages data and 4 pages hole, beginning with hole.
>=20
> I also used the 'vmtouch' utility to make sure the file is either
> evicted from the server's pagecache ("Uncached on server") or present in
> the server's page cache ("Cached on server").
>=20
>   2048M-data
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.555 s, 712 =
MB/s, 0.74 s kern, 24% cpu
>   :    :........................... Cached on server .....  1.346 s, 1.6 =
GB/s, 0.69 s kern, 52% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.596 s, 690 =
MB/s, 0.72 s kern, 23% cpu
>        :........................... Cached on server .....  1.394 s, 1.6 =
GB/s, 0.67 s kern, 48% cpu
>   2048M-hole
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.934 s, 762 =
MB/s, 1.86 s kern, 29% cpu
>   :    :........................... Cached on server .....  1.328 s, 1.6 =
GB/s, 0.72 s kern, 54% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.823 s, 739 =
MB/s, 1.88 s kern, 28% cpu
>        :........................... Cached on server .....  1.399 s, 1.5 =
GB/s, 0.70 s kern, 50% cpu
>   2048M-mixed-1d
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.480 s, 598 =
MB/s, 0.76 s kern, 21% cpu
>   :    :........................... Cached on server .....  1.445 s, 1.5 =
GB/s, 0.71 s kern, 50% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.774 s, 559 =
MB/s, 0.75 s kern, 19% cpu
>        :........................... Cached on server .....  1.514 s, 1.4 =
GB/s, 0.67 s kern, 44% cpu
>   2048M-mixed-1h
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.568 s, 633 =
MB/s, 0.78 s kern, 23% cpu
>   :    :........................... Cached on server .....  1.357 s, 1.6 =
GB/s, 0.71 s kern, 53% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.580 s, 641 =
MB/s, 0.74 s kern, 22% cpu
>        :........................... Cached on server .....  1.396 s, 1.5 =
GB/s, 0.67 s kern, 48% cpu
>   2048M-mixed-2d
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.159 s, 708 =
MB/s, 0.78 s kern, 26% cpu
>   :    :........................... Cached on server .....  1.410 s, 1.5 =
GB/s, 0.70 s kern, 50% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.093 s, 712 =
MB/s, 0.74 s kern, 25% cpu
>        :........................... Cached on server .....  1.474 s, 1.4 =
GB/s, 0.67 s kern, 46% cpu
>   2048M-mixed-2h
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.043 s, 722 =
MB/s, 0.78 s kern, 26% cpu
>   :    :........................... Cached on server .....  1.374 s, 1.6 =
GB/s, 0.72 s kern, 53% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.913 s, 756 =
MB/s, 0.74 s kern, 26% cpu
>        :........................... Cached on server .....  1.349 s, 1.6 =
GB/s, 0.67 s kern, 50% cpu
>   2048M-mixed-4d
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.275 s, 680 =
MB/s, 0.75 s kern, 24% cpu
>   :    :........................... Cached on server .....  1.391 s, 1.5 =
GB/s, 0.71 s kern, 52% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.470 s, 626 =
MB/s, 0.72 s kern, 21% cpu
>        :........................... Cached on server .....  1.456 s, 1.5 =
GB/s, 0.67 s kern, 46% cpu
>   2048M-mixed-4h
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.035 s, 743 =
MB/s, 0.74 s kern, 26% cpu
>   :    :........................... Cached on server .....  1.345 s, 1.6 =
GB/s, 0.71 s kern, 53% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.848 s, 779 =
MB/s, 0.73 s kern, 26% cpu
>        :........................... Cached on server .....  1.421 s, 1.5 =
GB/s, 0.68 s kern, 48% cpu
>   2048M-mixed-8d
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.262 s, 687 =
MB/s, 0.74 s kern, 24% cpu
>   :    :........................... Cached on server .....  1.366 s, 1.6 =
GB/s, 0.69 s kern, 51% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.195 s, 709 =
MB/s, 0.72 s kern, 24% cpu
>        :........................... Cached on server .....  1.414 s, 1.5 =
GB/s, 0.67 s kern, 48% cpu
>   2048M-mixed-8h
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.899 s, 789 =
MB/s, 0.73 s kern, 27% cpu
>   :    :........................... Cached on server .....  1.338 s, 1.6 =
GB/s, 0.69 s kern, 52% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.910 s, 772 =
MB/s, 0.72 s kern, 26% cpu
>        :........................... Cached on server .....  1.438 s, 1.5 =
GB/s, 0.67 s kern, 47% cpu
>   2048M-mixed-16d
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.416 s, 661 =
MB/s, 0.73 s kern, 23% cpu
>   :    :........................... Cached on server .....  1.345 s, 1.6 =
GB/s, 0.70 s kern, 53% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.177 s, 713 =
MB/s, 0.70 s kern, 23% cpu
>        :........................... Cached on server .....  1.447 s, 1.5 =
GB/s, 0.68 s kern, 47% cpu
>   2048M-mixed-16h
>   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.919 s, 780 =
MB/s, 0.73 s kern, 26% cpu
>   :    :........................... Cached on server .....  1.363 s, 1.6 =
GB/s, 0.70 s kern, 51% cpu
>   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.934 s, 773 =
MB/s, 0.70 s kern, 25% cpu
>        :........................... Cached on server .....  1.435 s, 1.5 =
GB/s, 0.67 s kern, 47% cpu

For this particular change, I'm interested only in cases where the
whole file is cached on the server. We're focusing on the efficiency
and performance of the protocol and transport here, not the underlying
filesystem (which is... xfs?).

Also, 2GB files can be read with just 20 1MB READ requests. That
means we don't have a large sample size of READ operations for any
single test, assuming the client is using 1MB rsize.

Also, are these averages, or single runs? I think running each test
5-10 times (at least) and including some variance data in the results
would help build more confidence that the small differences in the
timing are not noise.

All that said, however, I see with some consistency that READ_PLUS
takes longer to pull data over the wire, but uses slightly less CPU.
Assuming the CPU utilizations are client-side, that matches my
expectations of lower CPU utilization results if the throughput is
lower.

Looking at the 100% data results, READ_PLUS takes 3.5% longer than
READ. That to me is a small but significant drop -- I think it will
be noticeable for large workloads. Can you explain the difference?

For subsequent test runs, can you find a server with more memory,
test with larger files, and test with a variety of rsize settings?
You can reduce your test matrix by leaving out the tests with holey
files for the moment.


> - v4:
>  - Change READ and READ_PLUS to return nfserr_serverfault if the splice
>    splice check fails.

At this point, the code looks fine, but I'd like to understand why
the performance is not the same.


> Thanks,
> Anna
>=20
>=20
> Anna Schumaker (2):
>  NFSD: Return nfserr_serverfault if splice_ok but buf->pages have data
>  NFSD: Simplify READ_PLUS
>=20
> fs/nfsd/nfs4xdr.c | 141 +++++++++++-----------------------------------
> 1 file changed, 33 insertions(+), 108 deletions(-)
>=20
> --=20
> 2.37.3
>=20

--
Chuck Lever



