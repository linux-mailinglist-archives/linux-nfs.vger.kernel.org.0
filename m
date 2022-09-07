Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F49C5B0E2B
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Sep 2022 22:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIGU3z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Sep 2022 16:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIGU3x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Sep 2022 16:29:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B913C248F4
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 13:29:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287KRdAg025737;
        Wed, 7 Sep 2022 20:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WJaSZ9cxrJsKbP36NpacX3tdBQ1GeYORxsxyYJRxG3k=;
 b=jD94CKuLz/fSxbWJfEeMICgqDllSdw/cm3Tk/R2o9Xknnrb2/D4COGnPPI1fN3BsWyIY
 WyWUYrs7E18v4IKsCEQNrDG+sAgODxRmP97PHddljEsrMi38K853C6Aeaxk8ibFxxsVK
 WQVoKd+tJgZBubyINRZf+lcIOj3gPn4/orV3IhaYl7nvdwdW4uriL55gUQviTyKFWMWL
 3ExQ4dxUyx44P8APjtqvrqp4yIQpL3x89IgQeuiXwnQ7QgH9fJ134m2QcdWQrM5z//cp
 noM/WNoEWkOK5//D/s3lncnQ5a9H0tk/j5Xdbs5HbBrQ//mUjO4v94WxGDCOvAynmika 2Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc9u04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 20:29:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 287IRiMb033488;
        Wed, 7 Sep 2022 20:29:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcavxrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 20:29:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkxArc+VYmECbFOMAWqtfWsSNDkd5YSjhFXo5AF/aoHdjMW04R7bY74MzCojNeAx5agu0iAKsSoRNS9JTA+meZ7ZaYiS9+bsSHOvZKI0sDhz3NAGdhOChNc8o0opTJPzXVgV+JFNf3/gJTlTa8JLa4gSOEnNczSPWi0IGinMaDVWxVu0PexlAtg0zhcuC62JV1QdPrCeZSNz8aGvM/MiDySGSknnVjUPgHSHSXSBw7K2zaVpUISSstBH45g/Gnp02LiBWD3FTzXyo0NR5OT5ntBlQLIvxdANvIkYrLY/53dJWENf65klpe+wiiTEld/BKd/IsILbbWMI6MlLUN1tcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJaSZ9cxrJsKbP36NpacX3tdBQ1GeYORxsxyYJRxG3k=;
 b=B1bbFnRah521f/MBuggbtwQuRmF6QgSwLbdrKi0yHE2MIZqThKQ5KgP5+snWarD0daBeK3y93qnSijVBGi2ElQKiP2ZriGR5XEmbLO/+h8YPp4087r9z38h6HGJP3i2EyDXdX85u8p4Q467l464dljJfq3y4JGMOer4mJl/a1D891JUDf9+VFoH3Ucl5X7drEJaBVB08mnEwXVOx3DkKiXGT7yBm72peu+8jQmfy6nE4X9NFz/qOOE3hAS/TjvrJ9LnYn58s07Ptac7yuqusszZJ96c3GVw4ik6edvxT7h9t+ucHaHBPRvBnv6TpxsXDbB0H8qGBduvdpDze+WgseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJaSZ9cxrJsKbP36NpacX3tdBQ1GeYORxsxyYJRxG3k=;
 b=Brxy/JSE/nXMOzyDspK+ocVSSFxi7xHsf6zF3cYFdQGznacIQHkZ9GbPj7lwBlGOFWBg6apQAPIplsG/JZ1zljPeH6hUKLDl39AQMukhfHf6WFU3Yq/mVpMESYtfPqDFQekaZJFwsR50XNHsPB7EbyyFvzTSqMX0xXXBfkTEzeg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4983.namprd10.prod.outlook.com (2603:10b6:408:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 20:29:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 20:29:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYwvN0H50fO0bVeUq5hyL/2HYwe63UazcA
Date:   Wed, 7 Sep 2022 20:29:43 +0000
Message-ID: <06EA863F-8C11-4342-8D88-954E99A07598@oracle.com>
References: <20220907195259.926736-1-anna@kernel.org>
 <20220907195259.926736-2-anna@kernel.org>
In-Reply-To: <20220907195259.926736-2-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4983:EE_
x-ms-office365-filtering-correlation-id: faf6020e-7d2f-4eb3-2d22-08da910fb298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9C1zeRWx/FGW9tbn69rim7654exWtuJpbPbEazu0SUrT+KTwLpDb61SMH8CTuYhQn4OfQPobIP3cS0r1gx72m47SEnNAFNscCaLNxfWJyxuqTLmIbkJyPLYgpg72vUP7z2cFzqbvTXYzeIEP/XG1sKzjg47nMi4BkaYFQi5Y2EXUFv9sRypZqYWHVvt4dKGMyvTXvrfSB/GDRDYSg6mkfGz7rABx6XILIWG/Mt0Dvbx6dLX7YXCo4CcHvN/Dm9oO7dir5lzFsVrHTEa+ys7ULwGh3bc3PYepDWqmrhNnXrr7MllUVHHmIbbYy9OC5ZHuKkwHd1ZQMH3fAIZIyBVbyv4N0mxqgWWxq2VlcxMgIndweIZhKieZjRvi7E8hB+m1x0MDazSgrQyHLPMaU4ODzsNH627T0TGmOKkDnUVC7Sai0hPqcN6JisNAVnhIvBuqCTRQko3GFoD5dzIMBHUqA+VRXbyFX5v/zEb6BUzO51dJu2haMSqcd+kYpXmVxZc4Eg9u4C2vKVy7QUxZQOHCiE+BuCaeaenqAhWuAmBFkkfMNgj2kvbnyTOTuYZrmyCKSsS1haRcBvP+5LkK1EFHmPyCAeZvKfWnuynoYPvkKBk4HKDleSAmVgTWriwhkfZ/biTEwHVYsqyYY20SVfPAUBTSi7dWY81XU+quu21hiteT2kSHwh+KWya5Ea9KPfk5Qpya07TTreQ/tx5u1I/R9BXoBrpmv2wAxS+ZwhV1gXkZsjPM/ycghAs5c96vSxplU8ldGIHoZ7G5LcaokU57ECu6obWtDgYi0kKxXXLu0BI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(39860400002)(136003)(2616005)(186003)(5660300002)(2906002)(66946007)(4326008)(8676002)(66446008)(66476007)(66556008)(91956017)(64756008)(8936002)(76116006)(53546011)(6506007)(33656002)(36756003)(26005)(86362001)(6512007)(41300700001)(478600001)(6486002)(83380400001)(38070700005)(316002)(6916009)(71200400001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w/8YfhaD1UvqUMEoBxTvNRwVJ8NmgKMlRPE2oiIAormihq8Yn6B2cocCIq90?=
 =?us-ascii?Q?bfilJZfIs9BfOB3/7AMP6x7uz1ueyBJiSTPenRxY7YQ0i5CJ1wtoqyKTWPBq?=
 =?us-ascii?Q?Cjzx15ftEdBuXjdWndjq+Z5VnSxx448Ep8JzadjLX3V4H9Ydx2ZC8HCHLM9j?=
 =?us-ascii?Q?TjFFhWoEgC0ZoyvwGVD9N+C2jnZmC2zZ8kuod7QjfEgJCuMv2lXaAyUl+U0k?=
 =?us-ascii?Q?C4pEg0ZxZO7zzvXsLy2q9PDpNHIsqCPTrQLpaD7aQC8h4EM02h1TUaaRdEHd?=
 =?us-ascii?Q?SbMA71ECqpduyk1pKUXPvlyO6TnarJhbCDEHMe/Gw17+xFEnCqa1171ITDLi?=
 =?us-ascii?Q?XH+r/O3KX6poYiJe0HYVUIEMeK7FZVwWxZJAG1jYtIPjcSgB19E6+LEvRZk9?=
 =?us-ascii?Q?SpkQGNHyObyEfEiGXj5CRwFl4DH1zIa+OMGAYR+F9YM2RzgQBclNY3L74I+2?=
 =?us-ascii?Q?Xc5x8b91EFHxbEWDGQ5NGBRdteBFnkMdDoaCzUNiZgapnO4HkVbtkcS8YJcZ?=
 =?us-ascii?Q?xxIAN19Pqtv2l6fbt9kk043k1i6oh03rXVLxHngKeTIzX802EIddgi7meSAh?=
 =?us-ascii?Q?jqkD1mjC6W1OYeGQxpnB0dy6ARU8491EFgYgvIDUaNnHeueFn0tEpzsltgIm?=
 =?us-ascii?Q?Kr2X2idnYHEH+nz7W+eu9LAMMJL3Wy1mjf1T9B7a4S/Y7mtjhLzBrP5f8xDR?=
 =?us-ascii?Q?tmOjCvzIiKsm57sR891R58Q41ubt0VvjS5+TRAmVKRdLCY0GHPYr9uome+Qc?=
 =?us-ascii?Q?glA/GB3DtEfKwMz6MErMHlQG5X9qCeksd3SWM0g4E/T41Befi/Hiby8NljM6?=
 =?us-ascii?Q?k1piBZ49tMJm7V28Ov7Oo2zZSjmVsIbLsAvqZIXUAhRtXuSIpgqLKW4EWL4k?=
 =?us-ascii?Q?BNo67gUwM8BIbPWEG/WDiotzFPlNrMIg0UjzWqavbHGdw+Zvvkm6tBvkwfDI?=
 =?us-ascii?Q?4UQvoSR81/TEDzsXA2kz0gYXyGi8zhmAMlJvMy0gHput6s/BSQCI3IeKvYCU?=
 =?us-ascii?Q?oBi60gEHQLl3rravsmytZ6MckfEyUrWb6Opvh6TAeSIKTVx5ZtT+sXGHyGjg?=
 =?us-ascii?Q?Mo0YRjJLy4xLX+Oed8pqF0/zUdq5MKU08GVQvHHsBG7XP2g/JDLPs+vaHBFm?=
 =?us-ascii?Q?n3hzrmv+iYUXK2srKi9keBL7tDZT+jOZrIWIheEUlcf/X8XP2dFuaPbqY24m?=
 =?us-ascii?Q?Lkavof1c5xS3V7+kSb71ImVTvS1NBEefWFSIVnPNMp67zTV4zP569XZjbnt+?=
 =?us-ascii?Q?NbG3qgdREnHMhAbOE2OvWnoNrsuQUTklRWai6/90aayd98d8xP8/y3lUVXrE?=
 =?us-ascii?Q?bet/yfUYoXOwHTwSMu3/vn/3bK46Bgcj/FBkr5p9d4vSlPbZ4MgSA7Y5rQnI?=
 =?us-ascii?Q?LtW0Fs68ravR8cEhDDW9pj9QZT7PHWSyKfhx0EG6QvUJr7GDbk+RUxDG6GB+?=
 =?us-ascii?Q?4PDYXOPCIRW0x8PvCLZDnt6iTgT5bMO2FPi7drcO0FlvjwqqgZMZC7eqEcqo?=
 =?us-ascii?Q?ykiPHloYFrvGMuUu4ei90DhPTX/w20UvbjEwr4JoHi/fNLQnm7+nEKUZ+vnv?=
 =?us-ascii?Q?aZ3SF0KaTWWNt8sx6aKBk3ruBcMGivTRRncvN+dE4arWSngG0CyP/ulI8iAi?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <114E4DB9B931944899AF85FD0DB57CDC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf6020e-7d2f-4eb3-2d22-08da910fb298
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 20:29:43.3044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hH7Lrl/ikAxOMvN8SGz3UirTFIruK2+uWYjIthgceNdcUTd3/mecGMFG3fUpgNk2+0u93OZVNi2l51/h3SMrTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070076
X-Proofpoint-ORIG-GUID: blTUJ9GvGgAFsdJGqlz9Q7V5YFPsoQWu
X-Proofpoint-GUID: blTUJ9GvGgAFsdJGqlz9Q7V5YFPsoQWu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Be sure to Cc: Jeff on these. Thanks!


> On Sep 7, 2022, at 3:52 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Chuck had suggested reverting READ_PLUS so it returns a single DATA
> segment covering the requested read range. This prepares the server for
> a future "sparse read" function so support can easily be added without
> needing to rip out the old READ_PLUS code at the same time.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfsd/nfs4xdr.c | 139 +++++++++++-----------------------------------
> 1 file changed, 32 insertions(+), 107 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e9690a061ec..bcc8c385faf2 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4731,79 +4731,37 @@ nfsd4_encode_offload_status(struct nfsd4_compound=
res *resp, __be32 nfserr,
>=20
> static __be32
> nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof,
> -			    loff_t *pos)
> +			    struct nfsd4_read *read)
> {
> -	struct xdr_stream *xdr =3D resp->xdr;
> +	bool splice_ok =3D test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
> 	struct file *file =3D read->rd_nf->nf_file;
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
> +	struct xdr_stream *xdr =3D resp->xdr;
> +	unsigned long maxcount;
> +	__be32 nfserr, *p;
>=20
> 	/* Content type, offset, byte count */
> 	p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
> 	if (!p)
> -		return nfserr_resource;
> +		return nfserr_io;

Wouldn't nfserr_rep_too_big be a more appropriate status for running
off the end of the send buffer? I'm not 100% sure, but I would expect
that exhausting send buffer space would imply the reply has grown too
large.


> +	if (resp->xdr->buf->page_len && splice_ok) {
> +		WARN_ON_ONCE(splice_ok);
> +		return nfserr_io;
> +	}

I wish I understood why this test was needed. It seems to have been
copied and pasted from historic code into nfsd4_encode_read(), and
there have been recent mechanical changes to it, but there's no
comment explaining it there...

In any event, this seems to be checking for a server software bug,
so maybe this should return nfserr_serverfault. Oddly that status
code isn't defined yet.


Do you have some performance results for v2?


> -	read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxc=
ount);
> -	if (read->rd_vlen < 0)
> -		return nfserr_resource;
> +	maxcount =3D min_t(unsigned long, read->rd_length,
> +			 (xdr->buf->buflen - xdr->buf->len));
>=20
> -	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> -			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> +	if (file->f_op->splice_read && splice_ok)
> +		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
> +	else
> +		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
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
> @@ -4811,69 +4769,36 @@ static __be32
> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> 		       struct nfsd4_read *read)
> {
> -	unsigned long maxcount, count;
> +	struct file *file =3D read->rd_nf->nf_file;
> 	struct xdr_stream *xdr =3D resp->xdr;
> -	struct file *file;
> 	int starting_len =3D xdr->buf->len;
> -	int last_segment =3D xdr->buf->len;
> -	int segments =3D 0;
> -	__be32 *p, tmp;
> -	bool is_data;
> -	loff_t pos;
> -	u32 eof;
> +	u32 segments =3D 0;
> +	__be32 *p;
>=20
> 	if (nfserr)
> 		return nfserr;
> -	file =3D read->rd_nf->nf_file;
>=20
> 	/* eof flag, segment count */
> 	p =3D xdr_reserve_space(xdr, 4 + 4);
> 	if (!p)
> -		return nfserr_resource;
> +		return nfserr_io;
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



