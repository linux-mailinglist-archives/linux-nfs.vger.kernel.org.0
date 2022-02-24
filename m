Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D32C4C33D6
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 18:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiBXRi5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 12:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiBXRi4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 12:38:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705418FAEE
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 09:38:24 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OFIOvN000938;
        Thu, 24 Feb 2022 16:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CsYm0QWs1JmVbDQtk6EbcHEvfhmzPwXsK9Qp16I0MTk=;
 b=yrLvcLcQc2G6b+p0lcZWqEviPDqziKKoasIiL27jwUjVBUkJMXijdFk2Ks0uykx052d8
 CbqF80meHtDK2Kvhrxg/2GGJhdFDeyYrfj15E3uS0aXtAHBqsolDbD47ojUXoeIV01GC
 6MiTShLC7Lx2QNrp/klIz1iB8R+EiRP8IGnSiAklFRRZDexe/+eT503nwbaZruiKg2/i
 mazEP9zWaaSoXDBknJpa4lXuVTYBnHPanpUihv3fJAWEdVslKhaat9+Zd8ylA7kjz+Px
 4hcllpu++ual+I4+DM9S+MuW4qklwaCLKWVtPjb3La7b5HQfe+zy/yARBnakrtaCKk/l 3Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7aqujj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:10:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OG6Xe4111100;
        Thu, 24 Feb 2022 16:10:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3eb483su2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilZ5Xdxm1FXD4GlQ1hGm8zygqtyEoHNx4LF7KSWh7X3lO7b5eC9tdI2nxyugop0rP2rzJ7pcaPqXu62bVbaCwYhc9uJ0icip0Qx/RqHySkx8L3aEMT+bK1rn6SJ9w2eR2XvJFeExm2aE61kqTGVwRpIZkKhiSvXp3zs3LU70vv5RgJqIb6C0UqESbXWFTdafopGgTbuO52eWTIv2l726Go4u1iCnPdJvpJsJ9CJDXIX8WNVIrElNXW3W9Uf3FW627dHLFqNALtkjmEMg4ZIyAyOr5/GSpPlL6j4pnzAs56TZtoQZpf0MMSP1XGOqPh1d6REwlwHSrHHS/ArCBccEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsYm0QWs1JmVbDQtk6EbcHEvfhmzPwXsK9Qp16I0MTk=;
 b=k2KpwGTIkpgwMuG/43YBe+a4D8XzOKWN6pzdcKy7xhLZY+oH0kC1dB6odYUY5eAr2gXs+iZE36jE+1/BiKS8lYxZUAN4uMmTXGaDsdr2mqHy4xoqJdpVYYn90Z0Q9vu3maBOw36tEuTB7L7hJLe9F18GCcGh7rsYs8207of+3f+rJoPmRciJr1XH/xvewElgXSaboiepZuevfo4yI2gUoqNM+SkNQ5b3/6H/sHbJiwnk51nBt0rt0GQOdTeKuUvT00vbgVTibSn2NKgUFBSGJR+XTy/z+p09ZBxRWwAaEdKIlnk/s1/huhVpkqxCWFoTmNftvyIOsT0AoysLnNi7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsYm0QWs1JmVbDQtk6EbcHEvfhmzPwXsK9Qp16I0MTk=;
 b=bBjHW1pu8+skcZenuo3lkQs1mmTsJNK4IRqIgekjRGxF9D0BkXs1BKVed/sGL019cnV/mKWgP/JC4cLxxoD0k1daQnjvZ7Y9BPC+YrDIxeyGn7NWxzvTkc/v2fQligg6WH8xO8tp9Hp2Rgzc0OJfAPZ06QLAuht/ffJaoANjjsU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 16:10:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 16:10:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
Thread-Topic: [PATCH] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
Thread-Index: AQHYKZf75HSgyspnYEGJwm0BUEIItKyi3vWA
Date:   Thu, 24 Feb 2022 16:10:44 +0000
Message-ID: <0303CA45-1553-4C95-BB41-2BA97D8A4648@oracle.com>
References: <20220224160119.1034749-1-amir73il@gmail.com>
In-Reply-To: <20220224160119.1034749-1-amir73il@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33ef5276-6bf4-4e28-0a08-08d9f7b03603
x-ms-traffictypediagnostic: BN0PR10MB4901:EE_
x-microsoft-antispam-prvs: <BN0PR10MB4901A61E4F61F3014E0BC0D5933D9@BN0PR10MB4901.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhzA6Mjwyf6MUX+KYnQRUm2wMX9D0rml924wnqUbr2FDC/2mGWDLoBR4LjQmT62Bq3c7YRINIgmDs3SJi68vlCFOOWqs7xNu3blrUmNc72fhMxRsJOmwf26BuQdqF8vt+kJc7vg22pMb6SJ8ho+btmwu6etXo3NO/u2PhJKMQf0/KhD8wpwKFHbHeZGREZn7phs8jGKbDXGwXvssp+yVPmx1ZPgoPD2VqDz089icSV/K6xITEGgUS1F1b5XaNO5aid5hsMoicjTouVE1H0ki5AZP/+LXGZ0AynAXlFni1yCEKTw1TcVqRxXeV8FZvmW/jinN8BkCKYvSl5fDgbvDfFfAMsZaQy5hH3GQe0bFdDAsjP5yQBQIFluQ79LijriquPjqoEy/6EVFOu+g06o4qFMxscM1tai2MAdYo+YsDrUEmyiNJE6yiwgnVvy7VE6n/0iP1vA4orjRXdLJhCML96ri4+dMrxjEahb/4w55CCoes0ETYFq2NgPr9EGyy/aRWZminu4nbnF6HAPR01bxzkKvaxxXj1hvgx7WTDbASY+i1oo5KrnPj16Rem1eCi3GKvAzFW6ofMTu2s3FFi/SUO7NM+yF7334tT7lVl8YjurepPcGuFpmGyQmQwvnZjRgdxark65wcXB4lSzq/GHoeRtxmi80csv9JI7aUdSPpSU/rAedzZ4oY/ToFMuyI00mM2aJnKrpcDKbYN1NvtdgR9B6UQJsCWJyju2dWTnZcxWWK6yY8HZtSQx0XS6WvKMdE84nUI/giKAJ0DcDhjO52JSMQWjAJ5Px+ut3D1iOi9Kt9nBguRIOKzlEsXxena6t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66476007)(66446008)(66556008)(91956017)(33656002)(64756008)(4326008)(66946007)(316002)(508600001)(83380400001)(8676002)(76116006)(6486002)(966005)(38070700005)(5660300002)(36756003)(2906002)(38100700002)(186003)(6512007)(6506007)(122000001)(53546011)(110136005)(86362001)(26005)(71200400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?feilE9tmX3I1e/wyLkmPZHp9B7F6PYBi+Y5Nshe4FVI8HZgkTfnvAIMztsnK?=
 =?us-ascii?Q?uSPB5R1A93g/wBD7RXwnGOEOT00b8AsoYipyzlkEHk8O5bVYosre64eUUqwX?=
 =?us-ascii?Q?SZE++aUJ5E3IAyZzb/o8qdSqj62teGVFxbpwIzDjOCSxRJs4cd0AXAU79Oy5?=
 =?us-ascii?Q?Nby72m9LnHaCv5hStK0LjVL3AR1BYaJC0P2AZKvQ/pQ+EOLWXGtQOL81BPI/?=
 =?us-ascii?Q?DbI2dhzjV9oFXJrxRH2B11SUANECUMaZnj2ZXYZc46zISdRlzH0EJK38uPP6?=
 =?us-ascii?Q?QAC2cRVJNTe9ImgX0CY4YlmZpqvTlu5cXbxtxsbwT3DV4OeCtmPlAGHQx5ht?=
 =?us-ascii?Q?P2pp9XdH8aEH0xUVuFzVC+PlOIDHU9rGKh5AEueadCS0NEqF8+HTpPEaF6EO?=
 =?us-ascii?Q?UncZlToQu1xcyHkWyEV1vn0xW99ZWzpozcHwLCi3Xm+neImLrA/0OBzP/2Nd?=
 =?us-ascii?Q?1xFPNZmeBgvxp850klrXPPIqe7ra7uuyXcefX2Y89WpKvBtHadveFB788Mvk?=
 =?us-ascii?Q?b7XdL3ZDmN/dNhTbjVEx1/cNoOBJBTbrPPn3alcI4rXd3B5pwl3d47ldgY1M?=
 =?us-ascii?Q?0yCvK7eJDJe34bqlUDn7kwHFBJwSdBZL/pyrvF2aX3ni5t1hjiuqcfXdxvAQ?=
 =?us-ascii?Q?mdMJp4Cs/1Sv2tTavjtokk6wQF8rc+e13/+pPHDZUK+ZmJn6Ign0VFTeLBCc?=
 =?us-ascii?Q?K1jlc7ZyUdB7sit+3TcgKbm0Fl2EPRKFaAEskBBF/KZNuaYNTwKPj1ixa+uq?=
 =?us-ascii?Q?eWyQFBngm7e67eTucO6WYfqdWwX62a0IbySA89tb2jzdJsP04byAhzHVn+pc?=
 =?us-ascii?Q?ryIGzQpODNX+9mkkea2Ja+ORvGILHUibHVg5R1mlF5pAZn60TjocMbSkilZj?=
 =?us-ascii?Q?X1Uhw+5lmocPt/ioaesTMwhGTU67hUHT7ftrHPq3RJ53+aPX9CBeLrCQ/ruw?=
 =?us-ascii?Q?BbXYMkLOi9OiADch2JtHLXPKbBaLhhMNM9nUulmqxo8fTKbGWIybjiTKfalC?=
 =?us-ascii?Q?RCHWProFmDDUCtv1tYgkzol3uqHLbAf5qM5TqPGFNLZR4BPQvqqyIMflyfCR?=
 =?us-ascii?Q?ryscAQpVuSJZMEuDf+OXgz38xcsu5J62tIEnpaFs/7aGv8s9J9DT21G9Gxpm?=
 =?us-ascii?Q?JcFWeD2Owcd991YAdQ4O5bTIjjdjLx7llqEFxJcCxNM2v4ZPr3xDKHbIcOXp?=
 =?us-ascii?Q?2b9IN/7pqEoWCn/aoV0ACV6WXs1HATZAW7/IMqwQiT9YmoQyZpj/xJrFhhlw?=
 =?us-ascii?Q?sbfuxPZBrStQwRVbYy5FIgbVT1IYtm3zH2tsyE0e+57XFuk5Y0bziEHpLDqf?=
 =?us-ascii?Q?58UzdynxeAkE+HI4ocDYTA2ts0UIBZBaY7D6Qrq9Yzdyx7G1UJ+FP4yY84Yh?=
 =?us-ascii?Q?7/0v1oWEQVBYat2VCnW23NGzmIUJY2n79ECfq4uwOrQS4ztb0wqX6E88Qmzs?=
 =?us-ascii?Q?EqMHpLY1KX4mQIa25geqrEIwWUblYsEfYclDg5o7/PTZL3ba1SWdIzqe81AH?=
 =?us-ascii?Q?sj0+9X688ggWP3K8hqK8IEgJOxi6SkwqRuR/F2gb/x9KuJhb2xLwqrvvdWq0?=
 =?us-ascii?Q?0HvWZslyHCDC+eovb45eycATmyNhxCSyzCGj+gGVA+Vm9r04Ge6SoBScq/Dm?=
 =?us-ascii?Q?/3JF5Z7NcxeX/02An+sNQac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67279AEBD78A1E4A9A676952E4095437@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ef5276-6bf4-4e28-0a08-08d9f7b03603
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 16:10:44.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgZu1Xh6iL69TeWTOl1o5KY1mo7mhSC2qyEX78M3wWplCsym/VSLQsvd6gDfXVmor2VAB0ZDX0+3cFtm5EeAFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240095
X-Proofpoint-GUID: PUwfa5BACZ8XpAyx_WCvjRhCL0CiYW0C
X-Proofpoint-ORIG-GUID: PUwfa5BACZ8XpAyx_WCvjRhCL0CiYW0C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff, Amir -

> On Feb 24, 2022, at 11:01 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>=20
> The nfsd file cache table can be pretty large and its allocation
> may require as many as 80 contigious pages.
>=20
> Employ the same fix that was employed for similar issue that was
> reported for the reply cache hash table allocation several years ago
> by commit 8f97514b423a ("nfsd: more robust allocation failure handling
> in nfsd_reply_cache_init").
>=20
> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfs=
d")
> Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327c03=
81c1778.camel@kernel.org/
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

IMO, this approach is a band-aid, as was 8f97514b423a. I note
that not as a rejection, but rather to point out that more
work is needed in this area. Big hash tables are inflexible.

I'll go with this one because you provided a patch description ;-)
But, as you noted, you need to fix up the kfree() paths too.


> ---
> fs/nfsd/filecache.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8bc807c5fea4..b75cd6d1e331 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -60,6 +60,9 @@ static struct fsnotify_group		*nfsd_file_fsnotify_group=
;
> static atomic_long_t			nfsd_filecache_count;
> static struct delayed_work		nfsd_filecache_laundrette;
>=20
> +#define NFSD_FILE_HASHTBL_SIZE \
> +	array_size(NFSD_FILE_HASH_SIZE, sizeof(*nfsd_file_hashtbl))
> +
> static void nfsd_file_gc(void);
>=20
> static void
> @@ -632,8 +635,7 @@ nfsd_file_cache_init(void)
> 	if (!nfsd_filecache_wq)
> 		goto out;
>=20
> -	nfsd_file_hashtbl =3D kcalloc(NFSD_FILE_HASH_SIZE,
> -				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
> +	nfsd_file_hashtbl =3D kvzalloc(NFSD_FILE_HASHTBL_SIZE, GFP_KERNEL);
> 	if (!nfsd_file_hashtbl) {
> 		pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
> 		goto out_err;
> --=20
> 2.25.1
>=20

--
Chuck Lever



