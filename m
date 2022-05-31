Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF45392FB
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 16:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbiEaOMN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 10:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345183AbiEaOMK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 10:12:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED23D12611
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 07:12:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VBFdOB000810;
        Tue, 31 May 2022 14:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GZ8PfkVrnK4hPM8LSj0LqRhSyHivrEWQMtzrqfzMl10=;
 b=WIz7zlTl+QRtNh09pkUVtU7E19wE1OdH4+Ym0b/LzEOSpVZ5/T9/XwmpNaIivVWuTe0j
 sLJQtrdwh9Sy7p+OCdO76+nIARKLdf8Nry4Y10XFtlM3srlriWWEeP3CA0U5AbS5lAea
 g5estjHbbwUMxzC/3HtbyrzrCHg0W/iJBKy8/Va0fS3M6Z9s9QNoGAzYDqushhU6XGz+
 ybuz6KZS0EkfHW/6Bq8aioU2cwhffg5gWZDhHDTeMqZi1peNqqA08JKnR8yOZuqh3X2k
 KnbdnT1yGAgwAkpr5sbqPKvJv5vyyqZgOChR+JEVX2U6KDKk5ONdX+zRlBgcbL7ozqSm +g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahn8r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 14:12:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VE66PH019982;
        Tue, 31 May 2022 14:12:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p1pdcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 14:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn5upUNSAm6BzPSY6cXpW7icR2vWmatGMwx2h6Z95kH6D+78TeaeZOwXwvdT0O/04gDETqb2VBl2SYVA1NBRaV/57u+IH3knLWmlYD2FQiQMZhEb3fgd9ZiyJOPifLeu4Ksv9WnW2yb+hq+Q52gKVYX3Q8Ukv5pOJWygTcwWTB2uGGOPGg6iMZwzYJXrs2Ts0BNJ76htiL2BLDpoZUgavC1F6powbSl+qgZHG5hFeF7s1axTEqrRsQdGBgv/IaU/8271j7L/RjokCiGBxPNBSedLjxK3sXBOudvG8caXA/Urv/h0v75D9XN2bEV3Otjst/jWQ5nhzRAKCahLB3NE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ8PfkVrnK4hPM8LSj0LqRhSyHivrEWQMtzrqfzMl10=;
 b=B+ZZMymf7YZWqyrnVC198eSP8PUOnJjtcgaA7TmnJr/Oq6GRwev9/uQrjIatc7LgVTqv0bzw64IYyr8DNmTZVheeerCw4kYl+tQNiIg+EuytRk6YEo/oEi/c+fnybglXbbDW3SI3R0hR06H6xwBtiZ9k7F0HlXboEwzvlPwEhutAuiXjvU9m/n9IuxHbFk+4HH+h/hLs7uJcclzbQI4OVYHtWVrluPmXPuGrMogXIHNMqvwGSv/dKLzXUHto+mchBm5IaQg0Yz8t2d53jGsTgp9tEUxtc5Qmr1r94f7hlX+FUQga/VAeIiEZHzisGeBVEQYYbuxs1VDVafJ8x4tINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ8PfkVrnK4hPM8LSj0LqRhSyHivrEWQMtzrqfzMl10=;
 b=tS7naFbshHiJrvmLloEtQ7qfUR/PkRLmd8q4AjihSr3fbXuTcYWygtNOUDpasy1xWonULrOQi7C0EvX7/Q94MaUxHK5gQF2V5O0D2kufGb1za/7wY86DhQCoo3jzbrLStYQpJso5pWf/MgDDmla8rK/aPLu9VfB3lg4VZl5Kq80=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5969.namprd10.prod.outlook.com (2603:10b6:208:3ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 14:12:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 14:12:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: serialize filecache garbage collector
Thread-Topic: [PATCH v2] nfsd: serialize filecache garbage collector
Thread-Index: AQHYdNvpgilm5hKNx0yhsp1S8r+H8605BxOA
Date:   Tue, 31 May 2022 14:12:03 +0000
Message-ID: <A12757CE-17B8-4F21-9EC9-3CA0496A8B99@oracle.com>
References: <20220531103427.47769-1-wangyugui@e16-tech.com>
In-Reply-To: <20220531103427.47769-1-wangyugui@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3bc2830-c804-4efe-6fed-08da430f8925
x-ms-traffictypediagnostic: IA1PR10MB5969:EE_
x-microsoft-antispam-prvs: <IA1PR10MB5969BB359D8CD0163065B28593DC9@IA1PR10MB5969.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TePc7e5IAlxOkqeyjNbzJWKAjGwseO4CYCK8e7gjfKbgMO3dgD2BYHip3MJF/doE4Ux+NfLC91y/yHG5vkVcV1L8s46GkWQIQmVE0W/FAxIdLPleokJZicPOuvFCwWXszoz+PBho8cn5OQVaxdIGIOkgXD/M3hN4N0DjbeHLqwhzua1LsmhraDirFS4r3A2wXFOVxyGAV7KMU5ABmOea5BYqGddFMGlsfqasOH8sIKO1FshrihUG5NECB4lso/tHfxoTOMMy2wx/Mf0Ap9V6cW498EftbeZrlEC6qqy4wVjNaohFcXu+z1xdch470QQC2IzJfYXqRHUr+WGwzDHT7gUOt3IGWamEX7DvgZ2c2aau4xQEyEPIjyyLrJEl4PtWjbyn0Nq6oDX1I5SkaIAppj/ZiaFxbg5Kg76sESMEn1YnzflCeYPIY1oH8jViMSlaeM4vEUVqxjIxaITaAzOebSKavKu5onY9cBQgrDulU6K/ldobG1KbRFxjHUAP22SmMUAkXi1DehA2w+HPVfF8nA2zYTp9o0iFgFs0Oow8wUU0qTaDYJLvietbxb5BvN0O47If6u1Y15J4dU9bNx9Jx6rBmsTwAUXglqzT8vOTUJnL848A2DJz4A4b10NCUdiR+yDzielXeCdLJ8slJXKhWKxY1GXTB2yl7wJOHFw4AdsFM4ahNB9sn5W5YXR658w/b8StxGH1snz2HqPVsGXu8lM3Vtfhd6nrNXqfZr/g5sUtPnJdIS2vjlqGwHSxsqfl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6486002)(33656002)(5660300002)(8936002)(508600001)(6506007)(86362001)(6512007)(26005)(2906002)(122000001)(66556008)(66946007)(2616005)(38100700002)(186003)(64756008)(83380400001)(38070700005)(316002)(36756003)(4326008)(6916009)(8676002)(66446008)(76116006)(71200400001)(91956017)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nYD27oJQf7SHjAJ/qjbB/WyQxHfGWfTjt6zpneAEuxpzbEXOEVjCmsqr5gEl?=
 =?us-ascii?Q?kA4dYX4nvDBsiEbRASJoV2h80mbj1n6cc/otwGbcyaBPKiTVl+XHuyCcL0QK?=
 =?us-ascii?Q?h2xt05QZr2j91Wlcc4LV8AcAd+yNfgD1HuBqMUYwdf9U0QU2zZRdVi9L19cE?=
 =?us-ascii?Q?8/vkwsFxgiMgegA2cTH8Ke3UDxQisfi8WFg/rO5Ob4PBULFL3i+QlAIpPzwa?=
 =?us-ascii?Q?IGctal/t0oaydMnXm3NaJvqbPUe0X43YqHicLREK/0xQxysL/jRQ2Mq/InJy?=
 =?us-ascii?Q?IhRU8fnY0AkZeDmCPfnO+2edPIvFJUUDBeE8llbJ9h3hzn8+AggMl767B7D1?=
 =?us-ascii?Q?mW0oJGw2wTQAY2IBX/mWhup5SqPtG9EpvOZanS/QoKn+ZAdlsQp0kLXjOY/z?=
 =?us-ascii?Q?7rOLhxDQ4k/OtPBk5JjF8mCdwetgdN807r3QNz3kOzAxvg25t2/ISAxiWQPE?=
 =?us-ascii?Q?8MpbNUed5rDPNqhXpfALhlTUTNb2gPoyi1uapH2UyRAbUfIfiDoes5l4IGc8?=
 =?us-ascii?Q?KG/0mJDtZN4bCmh89CI78/RgNTXyLmM6JaX0HnuDBrRN00ZUs+YriYJxsCS+?=
 =?us-ascii?Q?9mIJG1QBOoxeI/qEnnRyZWWTdR07Rxkl7ZANSF2HZJREEENEcuuVWOUg0sGv?=
 =?us-ascii?Q?dv8KvGUowVKtyguTi1DbrMM/6arWfwDcQLzyGSVjumCmM0u62VoFNFW4H+eT?=
 =?us-ascii?Q?PyIn/XW+jeL05iSB+GWgls8dSRD2QpmOzRHyC8bD7Vdp6czA2gHynkcEnDwm?=
 =?us-ascii?Q?p53DvqMoJtAYaJXdlDvuV+ZjpBtjejY3Zi4tlAl6ty7YOCC3/MKLfGMadhkF?=
 =?us-ascii?Q?48UUUNt5LL3H446BAJlmUHHynYp6jWjrfvk66SS59P49iKs3Kh6x5wZXSkBH?=
 =?us-ascii?Q?cDENGyVr2VbKkS9Pqdu7uuqnBfIOmQCcv3/LrCo95TcvRVLM11ZiXElmvH2P?=
 =?us-ascii?Q?S8XvOg3ksgDNfRIJUlUvQ8pG+rCF6csGBeafJkASKXt6mimtxGynAtj2ttv6?=
 =?us-ascii?Q?iltcdwDOMRlNlM3F5l8VB0ZBaS03zUdNa4mn3KbRLxAYwzZWJkofj83jRR5C?=
 =?us-ascii?Q?9ZhQ+0jsaDMDQaoZkAjxV2E4GjDqsNPdVFHisAwSuE8tfoBr6olKe0roaBJy?=
 =?us-ascii?Q?CzPjtacpo/6SxElHhW0jwdM0AS33TC+/xKU1jDdiVPc0pqghXUrDeeEZ/GFO?=
 =?us-ascii?Q?PTadHET7ixdOTOQmTS/X0VxsN16xJ+mMd9SiiN6psuiSuTvLjGbqCar3rCzJ?=
 =?us-ascii?Q?J2sTIPaPUogMHk06ZVvpp90ckc49i2LjPaEi6lG80wAa+sml07ZUGkQwHZwx?=
 =?us-ascii?Q?Ge3v+RUc2/Q3VCUcPLklTzGwiGliqvW7/0YBiswLEv8mBjbAIiZjOwKW20wg?=
 =?us-ascii?Q?KskYc8fRVLZlh5XUb/37hooiHn93w1FPqCWLL91AKItwkkCy3lDWLZ6rNYur?=
 =?us-ascii?Q?7f6No2F54Nm+armiWa4WEc+XwaVanI0ss/N8QtaNxwVh0TKMCMV2zxUcgDHC?=
 =?us-ascii?Q?j9nclFaD5r3LR6R6H1lkhwJYcrZMwz8ERQBFmxmeeGzMPwrwepqFRtuBdHzd?=
 =?us-ascii?Q?olZ3tyFPUQ6PGTCW6BXpmn/Gl22TBProxQ8RwYGzsE+ay9ZtnYK4LmxAC+HE?=
 =?us-ascii?Q?IXw87+1BzmlIo5aJoyZ1sxLVQYowaynY+SdB0JoQhOFY1136ozlfMXTIF+rV?=
 =?us-ascii?Q?oPz0Jy8FtdmQ7H0+4kQLmlmsX+BdE8lVDybTa0uiWf5TgXKt8fe40FJuCM9D?=
 =?us-ascii?Q?mrhyHj69r943wP9P2gK3q7n43dOKzGI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4144C02DA9C5644885870B4C0624FBFD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bc2830-c804-4efe-6fed-08da430f8925
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 14:12:03.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqQfG5FQDcPoTJD2T5m3ADYC5+OanOaXmEEEjaoUnuQ/jxuXUwU6//cdqdE0fMsadkIlxpHQa+2VIly4zrQXhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5969
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_06:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310073
X-Proofpoint-ORIG-GUID: -0I6sFJJrLN8PF_8KymL_l4TZ_efCMiA
X-Proofpoint-GUID: -0I6sFJJrLN8PF_8KymL_l4TZ_efCMiA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 31, 2022, at 6:34 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>=20
> When many(>NFSD_FILE_LRU_THRESHOLD) files are kept as OPEN, such as
> xfstests generic/531, nfsd proceses are in CPU high-load state,
> and nfsd_file_gc(nfsd filecache garbage collector) waste many CPU times.

Over the past few days, I've been able to reproduce a lot of bad
behavior with generic/531. My test client has 12 physical CPU
cores, and my lab network is 56Gb InfiniBand.

Unfortunately this patch doesn't really begin to address it. For
example, with this patch applied, CPU idle is in single digits
on the NFS server that exports the test's scratch device, and
that server can still get into a soft lock-up. IMO that is
because this change works around the underlying problem but
makes no attempt to root-cause or address that issue.

I agree that the NFS server's behavior needs attention, but I'm
not inclined to apply this particular patch as it is.


> concurrency nfsd_file_gc() is almost meaningless, so serialize it.
>=20
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
> Changes since v1:
> - add static to 'atomic_t nfsd_file_gc_running'.
>  thanks for kernel test robot <lkp@intel.com>
>=20
> fs/nfsd/filecache.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index f172412447f5..28a8f8d6d235 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -471,10 +471,15 @@ nfsd_file_lru_walk_list(struct shrink_control *sc)
> 	return ret;
> }
>=20
> +/* concurrency nfsd_file_gc() is almost meaningless, so serialize it. */
> +static atomic_t nfsd_file_gc_running =3D ATOMIC_INIT(0);
> static void
> nfsd_file_gc(void)
> {
> -	nfsd_file_lru_walk_list(NULL);
> +	if(atomic_cmpxchg(&nfsd_file_gc_running, 0, 1) =3D=3D 0) {
> +		nfsd_file_lru_walk_list(NULL);
> +		atomic_set(&nfsd_file_gc_running, 0);
> +	}
> }
>=20
> static void
> --=20
> 2.36.1
>=20

--
Chuck Lever



