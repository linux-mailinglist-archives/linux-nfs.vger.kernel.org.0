Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20027573DF9
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 22:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbiGMUpx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 16:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiGMUpw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 16:45:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92CB3135B
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 13:45:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DJDcaK019282;
        Wed, 13 Jul 2022 20:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UYQjclXYyccqentor3jLpqJG3FPwkKVOQnaX8vyU9pM=;
 b=Fbwsp35MC2hSDyDWskp7rUKMMgNDlW4dEX7QWY7FgMRNV/ICIBAlT0V4POWGBt7dm6G4
 f+z7SgqL8koWBLOJiZWg/wFBQsFcgHDdKHsKvT1UfXYoe8+RxX5mZ/XgppLyQ7y1m8sN
 ZNVXaNgVwbgQ4DIB+2x2hv4FTBvJC+dkddEjW88fb1oO+Fm3HaxL4GF7+LnAo4ljlUs/
 rPIB7AuggV9Wdyqn9x3cABjnrPTzDyPMxPGewM0cUFrfFUqnZ4tzmapXIBYmgHLElLYo
 j4kXt5TzoszjRcMowAhyrBE3OcGdMGiJO562sQXI6lD9Sb6FruDBT3hOKQ9wsZpf9Zqy Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrkcnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 20:45:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DKaoPh007869;
        Wed, 13 Jul 2022 20:45:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70453rhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 20:45:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUSwfg+FUrq3fMKXHZ2OEpMUdeB8QgfOtumq81xK7MFfkBtU04ucvTDGcHQbSzjdqXJkqKLlsCLnyM9uQ0xCa3f51rJBiNKkOsxqxuWSuWsMxF4dCbgWdqsQ0zUrnNz9CG8dLsktoXAp/TDEVyQyG0Nwh9Lmk1sPNQqSWWnb2zRX8wjZt86Lh5dUid4qBz1vkP5POkDuXGzMr2cEp8jPMhyKAp5F8oIGHH7038Bezs37bMxZH9qnhFLqfqnIW3+rrGtdHZdIXZrcJdUI/y3KbZunciyEmDftOaqjW9F/wlXc35trLlPf7H1UImWz3OUSFcJU5I+ZQEo7plBZ2D5/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYQjclXYyccqentor3jLpqJG3FPwkKVOQnaX8vyU9pM=;
 b=BUbukbCZh0oMVXJBybzQVlkCuhy3jKCXe6v3u9eU0lwUb8I724+1eLZwaO5lZAKZ80HYQbSh/fpl675RFYSzndapwS7JwUekpxViOZctOCWKeIAfM1qG7Wuavj8p8kE9Ll5wdxlSb14jagEd7oCND1IC7pgFP3dFJXvs4NamilMVjnsoSU4soqYX3iutXTnmdizCxUldWwe6wCWlw+GF6Qfc+ZNBiHPfws0i4laXdS5VAPmOrnk7GH2C1aD07jxJJn5MeOOUQsRklJwVD1oJt6eAn1oZOruaLF3g279v28e2qT0GvQWkUqZxLbWTF8cG1PmJ3eU5uRsQ3HXsQb4nHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYQjclXYyccqentor3jLpqJG3FPwkKVOQnaX8vyU9pM=;
 b=UzAERP0DPCYmNFzrcrVJsgaNUeCZ4DiKwSosPdA7JHfnA9sZJiRznQ449VZPa+d9lXj+wKadbiXDA4BDkEf2jFFeWd8Jn43D3BxBYemOOJ4HoOrOwYE70PZCWfi7ngbRwVoDWCMok8gTe4Hx45ThbsUfPGG7egN1zFKy3KAxyrc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4676.namprd10.prod.outlook.com (2603:10b6:303:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 20:45:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 20:45:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v2 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYluv1sCUWFGf0akKyyNTzsrLeK618xS+A
Date:   Wed, 13 Jul 2022 20:45:42 +0000
Message-ID: <C16B8BE4-35C6-404F-9E94-3E01714DC436@oracle.com>
References: <20220713190825.615678-1-anna@kernel.org>
 <20220713190825.615678-7-anna@kernel.org>
In-Reply-To: <20220713190825.615678-7-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 684a916a-43e9-4153-ba9f-08da6510a701
x-ms-traffictypediagnostic: CO1PR10MB4676:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZpLxlmkulMvxu31TE1LJVW47j58q8QAMVaWjjes3UVEmyW9bc5O1884FtbI2OZ2cFG7D+Wgbi+RtbXviMvGGscHr72Y84uILw/V0EG1sAVGh6XItVK9qisYkmSDGbVC7q3ZH+oR/TmewAvWPwF3e34hafdtkiLM8HT7QDCWhCTUZ28ut0ERvTYpr6hhpfxetg5rAgGx/LAcE47jf2rI1iHZvIFMcCuiv8m70/5yc6BOwNtVqGbZNHA252KNNFEEd+Jfvl/NAGbNnlBlPTe7z8DVDKhdnUeUdDWYzXr10CHPqiRt0oCbHqnmbR+V5XhkHaGclZFsHjJYn+T/LUBqog2qCD4EdTpyUNdIJbwYjWnoOsEa2fiM627UOH+VJZEfhqKyH9n3ySU2PiSIfzyq4dZyyduskrFsao+Ju8/mVUQV5U/CNjZ9hbwethpEDKUAh49PcQeJOSK72R+w8COtgtbV3Ou3nhiiwSUMDa2BAPqhajakdES0MQL6zIUJ+es/qdD00V+KTkndN+7XgoqY5PP9mPXE100WeozoUGmaiiar91aFSIey19WvWjTg/K5xvx4sPOgn9qCpCdV6WokBeQu0Z6h8VrwMegB3OCXaG47n8E7dIYYaOUFaaI0omdQSGXwzcpvosr+Gtofigj7e9mZFoxzAXjGMCQrHKio3DG+XEptqWwp2WqyfnMfmDhagU9Mh++qtMyI9xzZXx7jdNqH+I4qseHWswFS3BcDFR2eV9APJzxeq7mPl/c4rrgdbNebylUy4pCKr4AOB8Bn1016ubBPzhBwSWYkHjcco0manPNLeUUM6uBD4D2V+aNBQwpNRzNVVBOcGEwFFx85Riru9MwXTmhoJMr1ul9CEiQFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(376002)(39860400002)(136003)(26005)(6512007)(38100700002)(8936002)(122000001)(6916009)(2906002)(33656002)(6506007)(5660300002)(83380400001)(30864003)(53546011)(4326008)(38070700005)(2616005)(41300700001)(66946007)(64756008)(8676002)(316002)(76116006)(66446008)(6486002)(91956017)(66476007)(86362001)(71200400001)(478600001)(66556008)(36756003)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6mDxUmOQK+h/ivbEmPQsfsZRy1C/jlgaYV2ECxLUWPCOEBZw4/grJtiM/buX?=
 =?us-ascii?Q?fVAnrWmHIwgV68Oqk6AUpjvRCCr/xtVooOaFLoaKhd2WOv79s0/slNBtCkCx?=
 =?us-ascii?Q?CLC2zAMvejjG1ja8QP1mFvM+9CmThm2w3+F5a/Ec7/tE2aoXs+kiKX5hWE2y?=
 =?us-ascii?Q?SZs3EqT1LNp4ZEN29TgygNYECctFWOJT/CY2vqmmZmDi9RNq9gv6xVA7l+CI?=
 =?us-ascii?Q?D4EDJOOxHR+n/dmeLIiFFzbHP/HPfNFPEXI4febMnwvmjJmH/zqz4TEHoAfs?=
 =?us-ascii?Q?ui4mn/xox0870OOd42bfhAmzN3bgqaEXGMdMrs+FzEtGUn20X+AgJXr+eEqt?=
 =?us-ascii?Q?VXT1xIfR4HC4YGCouktmVPl8JilY80U4kmmrdUrUQnICQn25ioWU8xlfyURN?=
 =?us-ascii?Q?g8SLB7mtiAA/KOcjkV92rK0rZScAmmU+xGOiQUvc1+Ob6kviuhUQHTxOJYVE?=
 =?us-ascii?Q?cTVBtblFermas3q8N+lOHJA+tshXXCHf5qGYYUghn00JZv97s+Ey3o/efO7+?=
 =?us-ascii?Q?85LvqwGadjMXgMc7spPzb1AP+RcOj5NHwVpPWSdmwFnZuamxL6fG9v98gcT7?=
 =?us-ascii?Q?oJV/rGh33sAHr4mSyzDEjfHZu+di+5ltceAEkn9BTW8tZOTp80ScwclX3bXE?=
 =?us-ascii?Q?2NvIRcGZTDDEpIDSaF6J+fv6R2FAYdfioc3356YSCjlSpnxWk9ygTNEwqu8J?=
 =?us-ascii?Q?ZP3r/Z3UmPwKfDz06OgzM6nAco3MVTN1MA/4WqKrQjJ9wftQYe+npIGVHJe2?=
 =?us-ascii?Q?2Rsq7jkzJyVlu9Hkvo4eIxpeiuFbe4129GcB4k2tm8b+cf8YBhe5+tUm+jsi?=
 =?us-ascii?Q?utnqwgciMXvM0AWMaH8wRgwk+KqTezp1iOZu3gwndyV9KP2s2YK24rXhAXSX?=
 =?us-ascii?Q?vmtDrOPrnPa1RI6bXy2CA2qCiz6bbiHmPXbQpWMvyP8wgDpep6y7x0m8ZUeV?=
 =?us-ascii?Q?DawV1WJhCnLpgm11tACk1RTQVQjDmfqSxBg8tVaDGGEoX1oYjgGzNBIRqfCF?=
 =?us-ascii?Q?5X0VRnTZhb+nYxe0e3G7SCPxZzjW72YZ3RXM8NHXmBn+/bSb4Qmr+IN4Q3Ai?=
 =?us-ascii?Q?mJBlPn1YXMPgBPQyvf6J4c9t8htyrzX4/vmxtI1mRDYNCxdlXEVFAnS8MPoi?=
 =?us-ascii?Q?TGtVoaZUOkiyn9Yu3iy1rk63PEY/hikrNiKX89A/F25NzMBSXsAZAKJbjrbB?=
 =?us-ascii?Q?Wpk1mWxqaZelFBrgIXB5ng8G+1bEQj1vICCA7zKVNi3wJPgy5mHv2OK4065W?=
 =?us-ascii?Q?ZF4g5xKo+INbsgDBvyg611XGJHNv3FSmBTgkELGzjNuJD4r2aHoBqdpFfgNr?=
 =?us-ascii?Q?o573JckACL9q5eRX9ne/MybiMHwekZowFD3wNzYdckUgZaa27wvanZzgJi8j?=
 =?us-ascii?Q?kc/6oFDwRTYcTpFtTuWzO7vql8XyzDYdoH43jJIxXpRvXQOxZH8GwRZdW7dl?=
 =?us-ascii?Q?ad2T20UAAZGRFrxFCEHKCj8d3LQcCHNmvuTkzZ9BegIJx/YqH2owrRjA64wD?=
 =?us-ascii?Q?CYX94VQDhE6KrL5l8Y2BIAu+nA9oRXp2lUrMl606rJuRVH+8ZWY/owV2VqXg?=
 =?us-ascii?Q?RnPHc2mNMU0cmu4pq+8+gqyj6BakMd09esbK1lgV4S03Ex7A1p6ey+SrJeXh?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B585942C8EB43540A9754EBCDC96C76E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684a916a-43e9-4153-ba9f-08da6510a701
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 20:45:42.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryvGTBOfot67PXQUqZ+/zGsCbHPsitvGBaJecVI5ssQ4/OiTfTdDM58jez9z4ZLC/LXKTW0aBx9R20TVDpk4uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_11:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130085
X-Proofpoint-GUID: NsIDAenM-Nlxb1NcVK0sCM4ayrw4BQW2
X-Proofpoint-ORIG-GUID: NsIDAenM-Nlxb1NcVK0sCM4ayrw4BQW2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 13, 2022, at 3:08 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Rather than relying on the underlying filesystem to tell us where hole
> and data segments are through vfs_llseek(), let's instead do the hole
> compression ourselves. This has a few advantages over the old
> implementation:
>=20
> 1) A single call to the underlying filesystem through nfsd_readv() means
>   the file can't change from underneath us in the middle of encoding.
> 2) A single call to the underlying filestem also means that the
>   underlying filesystem only needs to synchronize cached and on-disk
>   data one time instead of potentially many speeding up the reply.
> 3) Hole support for filesystems that don't support SEEK_HOLE and SEEK_DAT=
A

I'm not sure I understand why this last one is a good idea.
Wouldn't that cause holes to appear in the file cached on
the client where there are no holes in the stored file on
the server?

Is there any encryption-related impact such as the issues
that David brought up during LSF/MM ?


> I also included an optimization where we can cut down on the amount of
> memory being shifed around by doing the compression as (hole, data)
> pairs.
>=20
> This patch not only fixes xfstests generic/091 and generic/263
> for me but the "-g quick" group tests also finish about a minute faster.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfsd/nfs4xdr.c | 202 +++++++++++++++++++++++-----------------------
> 1 file changed, 102 insertions(+), 100 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 61b2aae81abb..0e1e7a37d4e0 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4731,81 +4731,121 @@ nfsd4_encode_offload_status(struct nfsd4_compoun=
dres *resp, __be32 nfserr,
> 	return nfserr;
> }
>=20
> +struct read_plus_segment {
> +	enum data_content4 type;
> +	unsigned long offset;
> +	unsigned long length;
> +	unsigned int page_pos;
> +};

"unsigned long" is not always 64 bits wide, and note that
rd_offset is declared as a u64. Thus ::offset and ::length
need to have explicit bit-width types. How about u64 for both?

The same type needs to be used wherever you do an

	unsigned long offset =3D read->rd_offset;

Nit: can this struct declaration use tab-formatting with the
usual naming convention for the fields, like "rp_type" and
"rp_offset"? That makes it easier to grep for places these
fields are used, since the current names are pretty generic.


> +
> static __be32
> -nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof,
> -			    loff_t *pos)
> +nfsd4_read_plus_readv(struct nfsd4_compoundres *resp, struct nfsd4_read =
*read,
> +		      unsigned long *maxcount, u32 *eof)
> {
> 	struct xdr_stream *xdr =3D resp->xdr;
> -	struct file *file =3D read->rd_nf->nf_file;
> -	int starting_len =3D xdr->buf->len;
> -	loff_t hole_pos;
> -	__be32 nfserr;
> -	__be32 *p, tmp;
> -	__be64 tmp64;
> -
> -	hole_pos =3D pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> -	if (hole_pos > read->rd_offset)
> -		*maxcount =3D min_t(unsigned long, *maxcount, hole_pos - read->rd_offs=
et);
> -	*maxcount =3D min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->=
buf->len));
> -
> -	/* Content type, offset, byte count */
> -	p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
> -	if (!p)
> -		return nfserr_resource;
> +	unsigned int starting_len =3D xdr->buf->len;
> +	__be32 nfserr, zero =3D xdr_zero;
> +	int pad;

unsigned int pad;


>=20
> +	/* xdr_reserve_space_vec() switches us to the xdr->pages */

IIUC this is reserving a maximum estimated size piece of the xdr_stream
to be used for encoding the READ_PLUS, and then the mechanics of
encoding the result can trim the message length down a bit. The missing
xdr_reserve_space calls are a little confusing, as are the operations on
the stream's xdr_buf rather than using xdr_stream operations, so it would
help to explain what's going on, perhaps as part of this comment.

Or, move all of this blathering to a kerneldoc comment in front of
nfsd4_encode_read_plus_segments()


> 	read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxco=
unt);
> 	if (read->rd_vlen < 0)
> 		return nfserr_resource;
>=20
> -	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> -			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> +	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, read->rd_nf->nf_file,
> +			    read->rd_offset, resp->rqstp->rq_vec, read->rd_vlen,
> +			    maxcount, eof);
> 	if (nfserr)
> 		return nfserr;
> -	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount))=
;
> +	xdr_truncate_encode(xdr, starting_len + xdr_align_size(*maxcount));
>=20
> -	tmp =3D htonl(NFS4_CONTENT_DATA);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> -	tmp64 =3D cpu_to_be64(read->rd_offset);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> -	tmp =3D htonl(*maxcount);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> -
> -	tmp =3D xdr_zero;
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
> -			       xdr_pad_size(*maxcount));
> +	pad =3D (*maxcount&3) ? 4 - (*maxcount&3) : 0;

Would xdr_pad_size() be appropriate here?


> +	write_bytes_to_xdr_buf(xdr->buf, starting_len + *maxcount, &zero, pad);
> 	return nfs_ok;
> }
>=20
> +static void
> +nfsd4_encode_read_plus_segment(struct xdr_stream *xdr,
> +			       struct read_plus_segment *segment,
> +			       unsigned int *bufpos, unsigned int *segments)
> +{
> +	struct xdr_buf *buf =3D xdr->buf;
> +
> +	xdr_encode_word(buf, *bufpos, segment->type);
> +	xdr_encode_double(buf, *bufpos + 4, segment->offset);
> +
> +	if (segment->type =3D=3D NFS4_CONTENT_HOLE) {
> +		xdr_encode_double(buf, *bufpos + 12, segment->length);
> +		*bufpos +=3D 4 + 8 + 8;

Throughout, can you use multiples of XDR_UNIT instead of naked integers?


> +	} else {
> +		size_t align =3D xdr_align_size(segment->length);
> +		xdr_encode_word(buf, *bufpos + 12, segment->length);
> +		if (*segments =3D=3D 0)
> +			xdr_buf_trim_head(buf, 4);
> +
> +		xdr_stream_move_subsegment(xdr,
> +				buf->head[0].iov_len + segment->page_pos,
> +				*bufpos + 16, align);
> +		*bufpos +=3D 4 + 8 + 4 + align;
> +	}
> +
> +	*segments +=3D 1;
> +}
> +
> static __be32
> -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof)
> +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
> +				struct nfsd4_read *read,
> +				unsigned int *segments, u32 *eof)
> {
> -	struct file *file =3D read->rd_nf->nf_file;
> -	loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
> -	loff_t f_size =3D i_size_read(file_inode(file));
> -	unsigned long count;
> -	__be32 *p;
> +	enum data_content4 pagetype;
> +	struct read_plus_segment segment;
> +	struct xdr_stream *xdr =3D resp->xdr;
> +	unsigned long offset =3D read->rd_offset;
> +	unsigned int bufpos =3D xdr->buf->len;
> +	unsigned long maxcount;
> +	unsigned int pagelen, i =3D 0;
> +	char *vpage, *p;
> +	__be32 nfserr;

Nit: try to use reverse christmas tree style where possible.


> -	if (data_pos =3D=3D -ENXIO)
> -		data_pos =3D f_size;
> -	else if (data_pos <=3D read->rd_offset || (data_pos < f_size && data_po=
s % PAGE_SIZE))
> -		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size)=
;
> -	count =3D data_pos - read->rd_offset;
> -
> -	/* Content type, offset, byte count */
> -	p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> -	if (!p)
> +	/* enough space for a HOLE segment before we switch to the pages */
> +	if (!xdr_reserve_space(xdr, 4 + 8 + 8))
> 		return nfserr_resource;
> +	xdr_commit_encode(xdr);
>=20
> -	*p++ =3D htonl(NFS4_CONTENT_HOLE);
> -	p =3D xdr_encode_hyper(p, read->rd_offset);
> -	p =3D xdr_encode_hyper(p, count);
> +	maxcount =3D min_t(unsigned long, read->rd_length,
> +			 (xdr->buf->buflen - xdr->buf->len));
>=20
> -	*eof =3D (read->rd_offset + count) >=3D f_size;
> -	*maxcount =3D min_t(unsigned long, count, *maxcount);
> +	nfserr =3D nfsd4_read_plus_readv(resp, read, &maxcount, eof);
> +	if (nfserr)
> +		return nfserr;
> +
> +	while (maxcount > 0) {
> +		vpage =3D xdr_buf_nth_page_address(xdr->buf, i, &pagelen);
> +		pagelen =3D min_t(unsigned int, pagelen, maxcount);
> +		if (!vpage || pagelen =3D=3D 0)
> +			break;
> +		p =3D memchr_inv(vpage, 0, pagelen);

So you have to walk every page in the payload, byte-by-byte, to
sort out how to encode the READ_PLUS result? That's... unfortunate.
The whole idea of making the READ payload "opaque" is that XDR
doesn't have to touch those bytes; and then the payload is passed
to the network layer as pointers to pages for the same reason.

It might be helpful to get this reviewed by fsdevel and linux-mm
in case there's a better approach. Hugh was attempting to point
all zero pages at ZERO_PAGE at one point, for example, and that
would make it very quick to detect a range of zero bytes.

Another thought is to use a POSIX byte-range lock to prevent
changes to the range of the file you're encoding, while leaving
the rest of the file available for other operations. That way
you could continue to use llseek when that's supported.


> +		pagetype =3D (p =3D=3D NULL) ? NFS4_CONTENT_HOLE : NFS4_CONTENT_DATA;
> +
> +		if (pagetype !=3D segment.type || i =3D=3D 0) {
> +			if (likely(i > 0)) {
> +				nfsd4_encode_read_plus_segment(xdr, &segment,
> +							      &bufpos, segments);
> +				offset +=3D segment.length;
> +			}
> +			segment.type =3D pagetype;
> +			segment.offset =3D offset;
> +			segment.length =3D pagelen;
> +			segment.page_pos =3D i * PAGE_SIZE;
> +		} else
> +			segment.length +=3D pagelen;
> +
> +		maxcount -=3D pagelen;
> +		i++;
> +	}
> +
> +	nfsd4_encode_read_plus_segment(xdr, &segment, &bufpos, segments);
> +	xdr_truncate_encode(xdr, bufpos);
> 	return nfs_ok;
> }
>=20
> @@ -4813,69 +4853,31 @@ static __be32
> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> 		       struct nfsd4_read *read)
> {
> -	unsigned long maxcount, count;
> 	struct xdr_stream *xdr =3D resp->xdr;
> -	struct file *file;
> 	int starting_len =3D xdr->buf->len;
> -	int last_segment =3D xdr->buf->len;
> -	int segments =3D 0;
> -	__be32 *p, tmp;
> -	bool is_data;
> -	loff_t pos;
> +	unsigned int segments =3D 0;
> 	u32 eof;
>=20
> 	if (nfserr)
> 		return nfserr;
> -	file =3D read->rd_nf->nf_file;
>=20
> 	/* eof flag, segment count */
> -	p =3D xdr_reserve_space(xdr, 4 + 4);
> -	if (!p)
> +	if (!xdr_reserve_space(xdr, 4 + 4))
> 		return nfserr_resource;
> 	xdr_commit_encode(xdr);
>=20
> -	maxcount =3D min_t(unsigned long, read->rd_length,
> -			 (xdr->buf->buflen - xdr->buf->len));
> -	count    =3D maxcount;
> -
> -	eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
> +	eof =3D read->rd_offset >=3D i_size_read(file_inode(read->rd_nf->nf_fil=
e));
> 	if (eof)
> 		goto out;
>=20
> -	pos =3D vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> -	is_data =3D pos > read->rd_offset;
> -
> -	while (count > 0 && !eof) {
> -		maxcount =3D count;
> -		if (is_data)
> -			nfserr =3D nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
> -						segments =3D=3D 0 ? &pos : NULL);
> -		else
> -			nfserr =3D nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
> -		if (nfserr)
> -			goto out;
> -		count -=3D maxcount;
> -		read->rd_offset +=3D maxcount;
> -		is_data =3D !is_data;
> -		last_segment =3D xdr->buf->len;
> -		segments++;
> -	}
> -
> +	nfserr =3D nfsd4_encode_read_plus_segments(resp, read, &segments, &eof)=
;
> out:
> -	if (nfserr && segments =3D=3D 0)
> +	if (nfserr)
> 		xdr_truncate_encode(xdr, starting_len);
> 	else {
> -		if (nfserr) {
> -			xdr_truncate_encode(xdr, last_segment);
> -			nfserr =3D nfs_ok;
> -			eof =3D 0;
> -		}
> -		tmp =3D htonl(eof);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> -		tmp =3D htonl(segments);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> +		xdr_encode_word(xdr->buf, starting_len,     eof);
> +		xdr_encode_word(xdr->buf, starting_len + 4, segments);
> 	}
> -
> 	return nfserr;
> }

The clean-ups in nfsd4_encode_read_plus() LGTM.


--
Chuck Lever



