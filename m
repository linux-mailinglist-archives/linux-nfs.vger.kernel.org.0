Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155B65AB660
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiIBQRs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiIBQRV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 12:17:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D8524BDF
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 09:15:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282D7OA0030924;
        Fri, 2 Sep 2022 15:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5nQHym4yZyuQUDE6kOBu/SPo6kKBCR2OtrE2wJJDkSo=;
 b=yBogR/BERQ+QrHB2zG8n22ZPL0wBoARofUYNSTAzpdz7MA6FTXDYc41fTRRLGnnl15Z2
 INoAwwUZ2D9MDP+n2Txrdw/XFEp7jFz++lsoQC9p8Cq33pYbSPWYLMH/UziCx9CnOJgJ
 Ea3DC2FrGxnOv+EUEud54yTCCLIoAh/gjl5KfwFl+c2G9VtMjZ0SJxTD6fLEFY3RBhGz
 GBsirc2R7TOIYX7Y50iMvpWWhNo5UxcdNKcKOELFBO9QdewFA0B8UJG4SHLiNnOy7fKx
 s3Ok1nQUwirIO2JLs3nt66n+U79V8bS4Ja6P3WO0eCTy59qSHS8LbrKgNwt4oxgRqEpM Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0yhmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 15:58:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 282DCw1E002231;
        Fri, 2 Sep 2022 15:58:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q7sd5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 15:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K961KxrD6h//2W/nvBn8CgrZH5VjhQIklGqwj+cADbOyzvfg+gnkFXR26oCgQsCgs93Eb+aZ6HVX3c9HCgXGb7AdkeZoqz5H3zCRd8Atp06M/6nbYdV1wV7O8hnK7hG7nzyejFvAlEkNERTFMu9/tq8ERz6EecoI56kj8c9WXMWaQC/ZouDOKZiphMz9QjkP3pHtnyhrzX5Iu73A450mJIR2bmqeDfa75Of7s7Z4lyCrFogrurXSWwOlqoySvp6/zUXYJgMLJYxF0d0jhofa96nkhMU94uzx3WXK5EzdxV8PCqy/Eqy0Qy5GfhVRobOLPGd9tKMo+ILMPMf2a2pDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nQHym4yZyuQUDE6kOBu/SPo6kKBCR2OtrE2wJJDkSo=;
 b=Z9kq10AGn5zd5fz37zwFy9eYPmkW76oW4hgqVB0ihGAXIomBoPiIm6+rr9aN93EMSwZCHFXEutWIfU8LNcfXmliAQ8Se0mGztj6GklICewEjNAi+Q4ouSVnhvt7JL7bsRoO22JnnQUJ7593nktE0CmKe11ydllvh4fHQKwipxLhRwgVAg5G73Xl1OM/3hhaXiXGdXaiHzVhBNmCiLpFxKuYyCtl4xLgEdl/R6NOMC+gG86/vjWEeCY+BC1goMFiG7mNMuPqxXqpJrdkX5RN42P6itUHbbkCYY/EYniebIEHrhtXkPxlqHq/n0Cjsfiz0rv2a1ojLZ96SbKPKCGNXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nQHym4yZyuQUDE6kOBu/SPo6kKBCR2OtrE2wJJDkSo=;
 b=mxjScF7bCPUAinYlhu3LKqlBuYlw6Oth77xk0wKqceG7+7X7SfwotcAGSTbICkyh8+ePgXCJVtdMTxg86046t16XsGSpp2QrGhwtG6hZEHzdJv9ioj7KRTRbxoJ2ja/mrlJIEP9IQMwO1N+3MYU8Y77jHsdp9kfGphcHNUF1Glo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Fri, 2 Sep
 2022 15:58:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 15:58:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH 1/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYvjFg3/EVQxaYQEaaRJDN+HcN9q3MTS2A
Date:   Fri, 2 Sep 2022 15:58:04 +0000
Message-ID: <3EAF27E2-42DC-4D15-99CF-C75279729D58@oracle.com>
References: <20220901183341.1543827-1-anna@kernel.org>
 <20220901183341.1543827-2-anna@kernel.org>
In-Reply-To: <20220901183341.1543827-2-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 652d64c1-0d24-4514-998b-08da8cfbeb7d
x-ms-traffictypediagnostic: SN7PR10MB6382:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5QryuFTQ8v7YbKLtMz9S614L2Per8+oR69gRxTFfXUQSi+9zX3KTphwptBHBsDRGdkDvFK2b6Cd9gy4b9DKNN3T20YlvQBY72EhE/4sCj5UdynygaklHjzqn56qeh6UtNdXG76Y9rhVqe5FRH8TdiYd+TQxdXD4XtmZD+vFtvn+LVFbu3wYnUR8z2BHqTnG/AtjrbEldAsjixDWQTSlBX9EaSTCa4CJPwaT1XDNYhRTdxx4C9IvczbNNOFw7edIMPn+SA3c+pNwTn5VhUa+Y71AOGuwOWA9+4kClALn0REyCm/n/ZBG2yaueJ5SjnWgopjg9F881gXeaZEwA/53pw8O8WBt5vDkX36fDOWUoNUiy9tVpHYL4B7RcFE4IQG4ZkjxyC2PniRITnKYO89MQ0w1PksU9QLL+zkxAEFhN2aDE+OwlC0vjFrga3y1sPRk4uHEI+pRSULil9lqLMHfHuTdi8HOTkKJ3+FQ44XLHguqADioWyYvUCkXzZiKu4cnGaqQeqqDdVB+ACc4jsqW5LpA5icDQccRoYl6Oj+bgsRbOWi2xxpSr8grEStRlutZUvx5LJgWHPLEaO8nUJEpGun3XJ5I8ILTZq5Y8hltN/qEaT8au+5uK0FydFjTz+iMwRlgvBtilkhB7XHy6ZjR4IUVpwIIBvyXez29D91qN1cLUX21fpPhjglGbznWEwJM5H8UwstaGVIm6UqYn3Ps30uoZEK3aMsUn6fr8AY24gmEN54LRloHmNbgCuhhgnhYY+WCkad1fCDr5Pmmd3xh9Ixn2LfvspxPn8yChCyWZqUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(396003)(136003)(39860400002)(53546011)(38100700002)(122000001)(41300700001)(6512007)(6506007)(26005)(71200400001)(38070700005)(83380400001)(6486002)(478600001)(186003)(2616005)(76116006)(66946007)(66476007)(66556008)(91956017)(66446008)(64756008)(8676002)(4326008)(86362001)(2906002)(36756003)(8936002)(5660300002)(316002)(33656002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dFusnI24zmq+W+WY4vxBtOlD3KqMBIo55hg0s4UnqayceIrTHA9ASm/tsFtR?=
 =?us-ascii?Q?WiCAOUi+ctYj5fNrUiLEYlk7fdVPp5cVYSMxHR2f6aHWgmrI7mg/3ZWS0dm4?=
 =?us-ascii?Q?MdKXmJvJqyEbcaEoS2PFYGB9BB/Pq6xKXeLict3hWeGk16Wl7+E1MafDcuZo?=
 =?us-ascii?Q?mX5ZqrKGLfAZspEKj486SveY/2spRO5hi9bZ2hOt7BmqaiSMcdJ822zAJ0/C?=
 =?us-ascii?Q?zzELP5fQMgi0QPH+oyfjnmM6AQhl3dRtTIdmB+rDfRK/KdvGQDqbVZFDLIqD?=
 =?us-ascii?Q?4E6BLLHRjPBjpz3lg7OeBELBEVhkt+7korwxtrU3E7kreqmRwjZNpZAsqaJw?=
 =?us-ascii?Q?zKxTRKz0RFXzgVjqJBhYnYmAyD31YkZDSXzzA21uoNPdGqiJbhJItZKbMzBm?=
 =?us-ascii?Q?zouUFg0w2Jz+rX4PR9fu706T0/HiFqnlMJkeX6Digglrpafqft8XYofLS96s?=
 =?us-ascii?Q?/Ht8ROELhBhSkLwzUdYWw2N8t7l1+GImA7mzDeWB5wP7ALxQjtrhEgLd2K69?=
 =?us-ascii?Q?arTFiptc7OIbVIqsbjcjUReBhbpWmBICQWfxYf3gekvPMN0WELef3KOVrBBZ?=
 =?us-ascii?Q?pTYuDgj/b2duAE4psHgMNeP4OEu8AFSIE2ed/sPCQCO8/8dtHp7Y+6Sgq9wk?=
 =?us-ascii?Q?H+kcU6ip1gwr72Aeb9bic5C7GILcNaUiGPKPVVn4zaD+45ipr3a/pk2e5L3V?=
 =?us-ascii?Q?ZadamSXDeW8Ep7OIvcVFxcjf738whzLVIfb+muaQJcDNbSSuT1fqyEMbUNTH?=
 =?us-ascii?Q?JEydqFUVMeA7yANuxtWOQj4B5ZLsRi/SFa5ks8cYhzEsI9Y1TqQkGzxWLD5/?=
 =?us-ascii?Q?NVIgbfNE/Jxu5tA704WZpoZy/bqnsi50JNCO4u8puLgqsyUon88TnZ64c3Mc?=
 =?us-ascii?Q?uKf9iQ+XvJgR0iQzkMcdiZzztSGdX24z82SoYMhSrAG3Q3aB32EEncCXk+TN?=
 =?us-ascii?Q?ckzF7PyKZcWEHn5gGhABHybX86rtIztYjezV7eoc3VA+PPAF7u+QrLnk1jUA?=
 =?us-ascii?Q?8RD+KndJ9p/tXHn6gRDJgVBQAUuRMg2No7XUAFxbkHvyJ9l9/l2x+jUrAI6w?=
 =?us-ascii?Q?imatC5uX+zies3KRQCvzhIKa53KxZIhjiEebG5HqkgxK/dCluJpDawpdNAcg?=
 =?us-ascii?Q?ml3R6IT9mVYjXvLlo5ENxULrhVTo8D6PcoMM/Kt51xaiaaZZpHs+7roYECxj?=
 =?us-ascii?Q?Vhw7aujMOb9r3tCSyNQ+PvhCf+AqDte7+RvogdCNhJ0e0+iZcxzCbHyvECbK?=
 =?us-ascii?Q?QDJQsnEBAJx2mal+S/ojgf/B6aMeWPLL6VGZkvDOqfVaMKp6U7JCBDlvBomh?=
 =?us-ascii?Q?v5pNKfEz5WAlglbA67SrqPh7yZgeINMwneZPUVTXVAFRbfpX8T20H5JLTzS/?=
 =?us-ascii?Q?84ZngbQuFl2Ipa4jH26WT0GHBEg5nw8p7BKH+s9LFXmlg3oVfNuRxWDjt7TQ?=
 =?us-ascii?Q?InNobtZFL4ZJG+kbNVvuxvWo33qkLv+zoSpjlXlktnTt3TdtszIlD+h2t+uy?=
 =?us-ascii?Q?zLHoefRB6TJdp6quMCcmqWCe+5xTkkmYrb7Z2IfK/f4mr4pXsP+edIwmBR9T?=
 =?us-ascii?Q?wDGUwLFBx4jCykE6u0fapnr4EKlO12LkJ6dseXNazGEs5g6RB8YskRFASCQb?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <313DE5AB5F832D438DC7ECD8136CD99E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652d64c1-0d24-4514-998b-08da8cfbeb7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 15:58:04.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLu0ZOYG4kUQ1+LgflwfI4bqLKwcFoWtlCF2bh6p/3GsZBMiQuBxx3EQ7ZlUT6xQzHAXX32P/eI8DRJRyWAlpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020077
X-Proofpoint-GUID: B7L6ml026BdkQfIEqgztLbezmULXAKG7
X-Proofpoint-ORIG-GUID: B7L6ml026BdkQfIEqgztLbezmULXAKG7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 1, 2022, at 2:33 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Change the implementation to return a single DATA segment covering the
> requested read range.
>=20
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

Now eventually (but not right at the moment) I don't think we
can use the rd_length and rd_offset fields in @read directly
in this function ... won't those arguments be different for
each data segment? Not a problem yet, just thinking out loud.

I think using @read directly here makes it easy to re-use
nfsd4_encode_readv(), so I'm OK with this strategy for the
moment.


> {
> +	unsigned long maxcount;

Nit: reverse christmas tree, please. The declaration of
maxcount goes on the line after "struct file *file ...".


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

The only problem I see with this so far is that nfsd4_encode_readv()
can return nfserr_resource, which isn't allowed after NFSv4.0, and
is not listed in RFC 7862's table of allowed errors for READ_PLUS.

I see that READ_PLUS code remaining after this patch might make the
same mistake. I think this patch needs to correct that at least for
the code that isn't shared with READ. Consult RFC 7862 to figure out
the correct status codes to return. (I'll file a bug to audit the
other encoders and come up with a plan to ensure NFSD returns an
appropriate error code for the minorversion in use).


To help answer the "merge readiness" question and to know if we need
splice read support or not, can you run some performance comparison
tests with NFSv4.2 READ (with and without a splice-enabled filesystem)
and this READ_PLUS implementation? Nothing elaborate, let's just check
our assumptions.

I've also applied the 0/1 splice change here to do some testing to
see if I can work out what's giving xfstests heartburn.


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

Nit: Reverse christmas tree style means this one goes at the top.


> 	int starting_len =3D xdr->buf->len;
> -	int last_segment =3D xdr->buf->len;
> 	int segments =3D 0;

I would also say that @segments should be u32, but that's not
relevant to this changeset. Optional if you want to add that
change.


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



