Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56665A9F90
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 21:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiIATFz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 15:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiIATFy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 15:05:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C04A826
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 12:05:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281HJbBI006460;
        Thu, 1 Sep 2022 19:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tx4nFr/f3rJUoH1TyG+rAURxy8rQqh3JvJeq+Jx6+do=;
 b=W5VfGuE5JdjT0YMZwzWgn++rBkcNXTa9PgLK6FBFM+YoQUq3T5ixUUoi+bAhO2DxNTus
 ULPXpnTH1WCrnHja8pF5a9uMNKRW112OeQD6tO6mLvKJcOBtYUUecpxcx1e/kONe4UQp
 +LIP2oloPCM/6sjgylzDPxTURrMPoKquMdIghLQZKw0soQE976IhlbPUoRDNC6srVqwE
 j88SHXjY9We2nOMsRLqeTxhTbe32FpT5rQewXlVQLTMdCtmZkSzUtRGdipE7OCWQYnW5
 HHHTqdctGULqnMx2U23JaQwsUUQkAOXEFsR4To+7nB5fBKa08ys2AZ1QLu3bJsTXzJJF Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0w7ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 19:05:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281IpwS9019743;
        Thu, 1 Sep 2022 19:05:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q6srmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 19:05:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOjTtgCGryGGJPQoGa648mPO+JAnjIVfScpc4uxCSh7ACEJeutL5DTQ/kpbnO7uhMw+UtF1l28AHmG4935l9xmYkWF0OZXch2dexdUcC+oo9EARdJEKY13gOXAg90cp2BPJNBO2lcKpx/P6qr70EETmfebIq40/oDsguz9PmadKWKMdG1hFZY0JWxa904tz1SirKcEhq4wRsAXTJ+u4MElyQkJGepEGNiz8OWzHFZxK9s12d0s1Zh6lrSHT6hyBVCH/7e69Z/H0mvSJ6vTaOMZ3SFaaayPMkPgEfaPVVbnoNomSUyG2iG5eLpLUCFXN67eE1EyhCCj/OilzW5P396A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx4nFr/f3rJUoH1TyG+rAURxy8rQqh3JvJeq+Jx6+do=;
 b=gZBikIqGtPOFR7aZKJUCXMkiLnaHOdk8BuQ0TSrvWSNBYz00ye0N0LDPDGpjVVAOU8pStjaw3tJm+w8iPUd+tWZOKDo4BWCkRMTctgWlnZGgUpWvDum62omfHnRn/YPxOr7sYWq/ENwNjJDdX+8VqHS+Es0bNGFg+svlVv3EpvTgU6my3IKwA7sdg41VlbcqfYhIHGF5RAzN8D60JDHqfBfNQM8YYaMrRcuClT2ZeLIuVn61M27gDc8ocgX+PRpQXYPEn0uOIrYDKbk/aVCmBXMh8Ovvytx898vfKdJTfcZ+OoU75eTlJl5RZEuKI+IYPULbeJjeytqU5HBwusMXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx4nFr/f3rJUoH1TyG+rAURxy8rQqh3JvJeq+Jx6+do=;
 b=DBZO9lkbGsG05IugUQhCjfKWMKOn0oFkq8zHq5wLZqV1pwlOzk/F9KHShWiWdN42ZpKtyfTV4eT38CtVchy0u5kSWdGHy5Tkmj0BPr1loG0NphcwVBWjxQkyGh1YRwxkvV2Wnsn1lacD4z2hF6oRACGlEL4WE/HAGQIsNWG0Lwo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 1 Sep
 2022 19:05:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 19:05:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH 1/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYvjFg3/EVQxaYQEaaRJDN+HcN9q3K70kA
Date:   Thu, 1 Sep 2022 19:05:45 +0000
Message-ID: <D0E7F490-7459-48EF-8D74-99BEEF349444@oracle.com>
References: <20220901183341.1543827-1-anna@kernel.org>
 <20220901183341.1543827-2-anna@kernel.org>
In-Reply-To: <20220901183341.1543827-2-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b73c964a-bd8a-48a5-5f33-08da8c4cf950
x-ms-traffictypediagnostic: MW4PR10MB5701:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OfLlxwgP/suz6YjIb6GSePwhrItEpS2j4V7Ba11On1o0oNnxwOOOcgAb/wOyiVAtBUX2gbFCABtbqXSp+ACIPHrDozqXYeyp/n2sIk/8o108AWws+2izWdL56C35vKV6ziQ6LOf62vS+YGGRXcXNRuALvVxMh0rBMIdJU3ikz4jzGh3mj19Epm77x8LvubqkJOw742hf5ygynOByvR76ufI37EDtK7UepX22VgVnUz/tGL4TVG4QbYIaZzBnY4N2t/rwipdAVFG96kBpi4J1yYGx5t1i/wZ8DCBNgeR7pnN20dzt2gz4PmTeHjIBCajkUfAZaSs2JFSx8CGd+LS5ZrGZSiLnwDfDvLkKhqzlk0lIrFhtHYlh70Uo285/VksoP+x67O8Um2Q4h2gecwYUx7XZ5HrP2e4c5k7WmjTAjIZtuvt8rf2ACXwlcs9ZPKdy00//ppezhjGlhocqbDngomWM5bj2++7XA8rmDOcKTkTVqG/uv3C4TjB2adOlVfrbOkurFElmzErJZnSMhgF7F7Kwtwo/75Mjcj/HYQ94SE3p9i55xeN/QlU2PYhU++ExPTuTqYJmu4r6srSOIgW9rXiJgJBf0HaeyWSqnYN3t9+CBLyqwpmLWyJ6Lzbqoyn9OPOQ8zwYtujjBIVG3GrChoSkb7fy2BxpAUjHdcAAhfS7B59/AgdZsjOmSNHhL0F3brNMFWJ5+0IreWnuFvr+VmwjRi1viWtGKVJvT7r1mXZxROp/rPz7CHhxSyO2KRtIqw1OR3uo74hl/+MWFyDcw0tZNiMSruUr1jKFIYKX2DM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(366004)(346002)(83380400001)(316002)(38070700005)(8936002)(5660300002)(122000001)(38100700002)(6916009)(91956017)(76116006)(8676002)(66556008)(66446008)(64756008)(53546011)(36756003)(66476007)(4326008)(66946007)(6506007)(26005)(6486002)(6512007)(33656002)(478600001)(41300700001)(71200400001)(186003)(2906002)(86362001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L7zlV9OA03jNETYqXdvV9QMIoWREMDBfMA5Z9QMnETHoExntB4A4u/LcBk7c?=
 =?us-ascii?Q?AfgMGC4TMdE7tUKPPda5oEAE33ob9jg9rhfgw9WW0X2rjvrms6rdBFDJxNEP?=
 =?us-ascii?Q?WIOto+2o6jBKTgdikD9rfWH+OZOM4s+M7QnqX1swiU4oU2axV7QkjgEqbS9e?=
 =?us-ascii?Q?skoD97s0cLZqExVmnVh2UrfP50i/tDmep0vCkB3ZTJcUQim0MlZwS1bY5knz?=
 =?us-ascii?Q?k1e6dr0KhbWQ2eFC7OnIyD+CKDAKFdBCzQL5d+cbDvn7pc17TLsbqjGNtMIR?=
 =?us-ascii?Q?UM17cTG67u0GqFjLvcqQm/3Q1KB23K2TbVnBZ1bio9+15I/xtUK8DEZ7UBZU?=
 =?us-ascii?Q?1UdOuQy6ItdT+I19YWotSza6SP06IYk0u3hMCmSkK24Cn5Ohvqsk+udn7Vl4?=
 =?us-ascii?Q?oerXl3IOCZ9xhOoaXLyl+lowy96fDQGdn3WsWbq2DyW+6iqZPrpjKV26eZ3n?=
 =?us-ascii?Q?mbcLhDhbajQyXJIS7v/A2v3DYlIBk07bUnlT3Xcb+MxhJdWNrJceK+7b9slV?=
 =?us-ascii?Q?pH2yj18SmJ8Vcl/kXjVYxz9TkoMvI2AHXNJdyKClVrVQvyQG7scfq6eqggkU?=
 =?us-ascii?Q?WjZv1Y1KnetxTIQ3AkB1PaXuhwx2uafFqB+oBMhFKk14Sm3bSAS6hYbaDUml?=
 =?us-ascii?Q?0H6hVIopMGdBq0ictRlSIj2tGbd30d7fCNL1VCUFRXYkRRaOeQJc8gIg+yyf?=
 =?us-ascii?Q?e4BSwxGclgywrLxG384XVZidV1zHrj4j2JOvnc6963yl6Yf07F2oeHntkfpz?=
 =?us-ascii?Q?zzCMMP0nL/AtuH3Z4/UQkJZgureh6yU4MYW540IU2wTs8ckOdn+I9PrTs3Nb?=
 =?us-ascii?Q?+6jQaOac4UB1cwdEj37vKwK/mNH+3trHANzUk69IpZ+FFP8qrlIEbRGRBJdF?=
 =?us-ascii?Q?qD0VL/xzVHYr61RTWXVq9fCUWxL/ilbFhULawmJrldqsDfB9pPCkOUND5DDF?=
 =?us-ascii?Q?ZCbAgTEiWdcDCo+80IGSBft2K+C2xF4I8tpZH4OCPTevUekIvAsPzuZ/cz76?=
 =?us-ascii?Q?7/9Y1+MjvDO63UxEXrOSO4HrthtxiSl7F55YDy48O+A2w5sTOmq6vdvwVGow?=
 =?us-ascii?Q?i72mpa1Gu4/kjYY+M/o9KsZlCltYgZlY8rUGpmzdnQ6juJP8/mF82JSBy7ez?=
 =?us-ascii?Q?wzXPZO0AkkyB8dRXl70yeyxVSQkdOckUcC9jMS4Nu9oOQWPkwzNKvzJ5vUWQ?=
 =?us-ascii?Q?6DkWvsZ7Txcjk3iOoumYcQBURvgPek4RJtfi+YI+FtfatyViiquBN57jxQtu?=
 =?us-ascii?Q?rdHLeqW1eMd6hnEV9Ya+QzJpTLnxYoz8sGMek8KQ3f35GQBVA/r8lQPOEZph?=
 =?us-ascii?Q?w9x3c+vCK/htS/i9/97L6AMhmqPzuF9j/JlHf6PEIBEwMRHbw62lnwO6SBJ/?=
 =?us-ascii?Q?fpQAhEqESA71gvvkAD/bP+5SYhNsrUSTxY4lq/7qUZKhYTk92PZA3D5DqBIL?=
 =?us-ascii?Q?vh2qPMsQxNpEDUvZDnkovQP4AI48ozDK9vkjnpZhYuJj3ZFp4P/4ATGiNCfN?=
 =?us-ascii?Q?OlBWMcukgUj7okGHFIPoeKKziN6FEx5u1OPpuByW1yn/AxcEPFzYvfYHsHiR?=
 =?us-ascii?Q?KqoXWvPOMozT9ZnbAiqEgfin4EDyrbq2wDkVF9ksXTJBvAcyt5YF18CSAUvn?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEEE6D3E36146747929690E3F3186626@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73c964a-bd8a-48a5-5f33-08da8c4cf950
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 19:05:45.4231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iRj2KWW4kwdsGlRJsohPHfkK0Go2sV/kqc/LP16r6X/fspmREoSWs3A4fauLtye6BnvPoxM/UAhQdMxyb2Oaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010082
X-Proofpoint-GUID: J5qKhfiNvSw_ivsFGQueTWZ_mSjnY9Fc
X-Proofpoint-ORIG-GUID: J5qKhfiNvSw_ivsFGQueTWZ_mSjnY9Fc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good to see this! I'll study it over the next few days.


> On Sep 1, 2022, at 2:33 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Change the implementation to return a single DATA segment covering the
> requested read range.

The discussion in your cover letter should go in this patch
description. A good patch description explains "why"; the diff
below already explains "what".

I harp on that because the patch description is important
information that I often consult when conducting archaeology
during troubleshooting. "Why the f... did we do that?"


> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfsd/nfs4xdr.c | 122 ++++++++--------------------------------------
> 1 file changed, 20 insertions(+), 102 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e9690a061ec..adbff7737c14 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4731,79 +4731,30 @@ nfsd4_encode_offload_status(struct nfsd4_compound=
res *resp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof,
> -			    loff_t *pos)
> +			    struct nfsd4_read *read)
> {
> +	unsigned long maxcount;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	struct file *file =3D read->rd_nf->nf_file;
> -	int starting_len =3D xdr->buf->len;
> -	loff_t hole_pos;
> 	__be32 nfserr;
> -	__be32 *p, tmp;
> -	__be64 tmp64;
> -
> -	hole_pos =3D pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> -	if (hole_pos > read->rd_offset)
> -		*maxcount =3D min_t(unsigned long, *maxcount, hole_pos - read->rd_offs=
et);
> -	*maxcount =3D min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->=
buf->len));
> +	__be32 *p;
>=20
> 	/* Content type, offset, byte count */
> 	p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
> 	if (!p)
> 		return nfserr_resource;
>=20
> -	read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxc=
ount);
> -	if (read->rd_vlen < 0)
> -		return nfserr_resource;
> +	maxcount =3D min_t(unsigned long, read->rd_length,
> +			 (xdr->buf->buflen - xdr->buf->len));
>=20
> -	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> -			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> +	nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> 	if (nfserr)
> 		return nfserr;
> -	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount))=
;
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
> -	return nfs_ok;
> -}
> -
> -static __be32
> -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof)
> -{
> -	struct file *file =3D read->rd_nf->nf_file;
> -	loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
> -	loff_t f_size =3D i_size_read(file_inode(file));
> -	unsigned long count;
> -	__be32 *p;
> -
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
> -		return nfserr_resource;
> -
> -	*p++ =3D htonl(NFS4_CONTENT_HOLE);
> +	*p++ =3D cpu_to_be32(NFS4_CONTENT_DATA);
> 	p =3D xdr_encode_hyper(p, read->rd_offset);
> -	p =3D xdr_encode_hyper(p, count);
> +	*p =3D cpu_to_be32(read->rd_length);
>=20
> -	*eof =3D (read->rd_offset + count) >=3D f_size;
> -	*maxcount =3D min_t(unsigned long, count, *maxcount);
> 	return nfs_ok;
> }
>=20
> @@ -4811,20 +4762,14 @@ static __be32
> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> 		       struct nfsd4_read *read)
> {
> -	unsigned long maxcount, count;
> 	struct xdr_stream *xdr =3D resp->xdr;
> -	struct file *file;
> +	struct file *file =3D read->rd_nf->nf_file;
> 	int starting_len =3D xdr->buf->len;
> -	int last_segment =3D xdr->buf->len;
> 	int segments =3D 0;
> -	__be32 *p, tmp;
> -	bool is_data;
> -	loff_t pos;
> -	u32 eof;
> +	__be32 *p;
>=20
> 	if (nfserr)
> 		return nfserr;
> -	file =3D read->rd_nf->nf_file;
>=20
> 	/* eof flag, segment count */
> 	p =3D xdr_reserve_space(xdr, 4 + 4);
> @@ -4832,48 +4777,21 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *=
resp, __be32 nfserr,
> 		return nfserr_resource;
> 	xdr_commit_encode(xdr);
>=20
> -	maxcount =3D min_t(unsigned long, read->rd_length,
> -			 (xdr->buf->buflen - xdr->buf->len));
> -	count    =3D maxcount;
> -
> -	eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
> -	if (eof)
> +	read->rd_eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
> +	if (read->rd_eof)
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
> -out:
> -	if (nfserr && segments =3D=3D 0)
> +	nfserr =3D nfsd4_encode_read_plus_data(resp, read);
> +	if (nfserr) {
> 		xdr_truncate_encode(xdr, starting_len);
> -	else {
> -		if (nfserr) {
> -			xdr_truncate_encode(xdr, last_segment);
> -			nfserr =3D nfs_ok;
> -			eof =3D 0;
> -		}
> -		tmp =3D htonl(eof);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> -		tmp =3D htonl(segments);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> +		return nfserr;
> 	}
>=20
> +	segments++;
> +
> +out:
> +	p =3D xdr_encode_bool(p, read->rd_eof);
> +	*p =3D cpu_to_be32(segments);
> 	return nfserr;
> }
>=20
> --=20
> 2.37.2
>=20

--
Chuck Lever



