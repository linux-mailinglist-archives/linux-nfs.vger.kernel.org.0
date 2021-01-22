Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD31300CC2
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 20:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbhAVThq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 14:37:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33228 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbhAVS4M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 13:56:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MIsvhf049600;
        Fri, 22 Jan 2021 18:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=TW2jfSLTf27aifCmZtVPJfwDayNPe50EhkYaE+2fJ/M=;
 b=B8VzcdbdQ4g2nqYES4lxvL+h+fW/syicg6Pf+vBOi3wxEqprJNONNfwbFgBEV33nvDDD
 cInbGZG9aFj9dNqo5gL6IUdT+xAh1HkcTgSuN/r+89nyRf3yR9ltqFAS/Uma0aEweY64
 ztPDJV+p15xxzy/azdBPs4d0Pmtd6/dDr7/XMwP2CuByhWGMpBhIvCpQwOmUArCpAk1X
 LRVt4TZpG3Tdf/No4z/yWrUBw0RI6bcjdCZxfJvxgCVym3tZoyScFRHh8yYGUrhdFH/7
 zJTNojzRSXDxnlyznnpvEtyIjTP4jVO0wl1uiQYMO/Klsr4wa4gfZK2YFSyAGlXqryLd NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3668qrnm6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 18:55:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MIjriM041664;
        Fri, 22 Jan 2021 18:55:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3668rhb90e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 18:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3KwGLMDaLhb+6WemPf+EiUL64Zdv84pbajtG1Hm+KhjDSse2Yr+iqSYeNHEKW+Be8oCVOPbyumOkS9xrGRe+K+c0a4/s5RDdZElQsOHvLwzyn1CitmvkAxnnrU1GuJYB0bUwzWSiteC4FjUDgIGBoJH9++va/CBvwvgIi36dbRSniXvlO3TqlPF84HGFc7h6c9ghwKNVympDRBloUYzep+QxqaUPAv/c2rcfUbC4uwTBQ/G5lScrgQybMTflFpgbUQL1u5D4Aw+q9+8PstOtwCt+CUw0SJRWnPVJ48Wdek3VQl/1rZLQdXTczfDYj5IJ5/1Qi/ZvmBioffuNPW3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW2jfSLTf27aifCmZtVPJfwDayNPe50EhkYaE+2fJ/M=;
 b=nKYQLeNdyglX5Lr5F/I0cldQLP7PI2U0Hac6BzUQpiCMmQO0HwYx6cqbLgd4V8eWxzdPR7MowCG6EtSQWbkKJJ3vjzrD64j+oOYlMnnXcYmRQs7dHFNm6DKw0D0wpfIjgDh2UpY7vcgy6sfVReUrZwCOxj5CgU1uJQYotHcBqbqJYwjdfPs6roaVPBdYOoaWB1mPKQz19M+p3ozLkzwKvC2+uy3Sxq9m13QsCakRVTF6y7fo1+/pHbCS44XqL8YUnvqDCBbiDRpI1X7NCcm8DsDjy9LhzgmJFKZHnfG13QEJrSFu2g8Zl4rOC4aDIoyncc4LQRjjPSeqblRjK8appA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW2jfSLTf27aifCmZtVPJfwDayNPe50EhkYaE+2fJ/M=;
 b=WGXRHK4zIbhcrcCRb99psw1xpWJrS5x4HMdDYLEFIcd7sDUk3wYpn+/oH4UGBV38JLqqCiwpHqsa03IVt8IZeheUjjdY3Y0HJrWkYAIChHP2eBYfjTST/V890nJaPJLIYVFYa1ESUExoJNqicO3yphUgpHrxIzWrDbR7j7Cx2b8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4260.namprd10.prod.outlook.com (2603:10b6:a03:202::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 18:55:23 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 18:55:23 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 07/42] NFSD: Update WRITE3arg decoder to use struct
 xdr_stream
Thread-Topic: [PATCH v1 07/42] NFSD: Update WRITE3arg decoder to use struct
 xdr_stream
Thread-Index: AQHW8O8XiOIeY47PXUyIyG1mP1wKvaoz/mcA
Date:   Fri, 22 Jan 2021 18:55:23 +0000
Message-ID: <C7B44F6C-0EE8-4920-AB1C-C2EF6A807861@oracle.com>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
 <160986061812.5532.3122782251888690881.stgit@klimt.1015granger.net>
 <20210122184754.GC18583@fieldses.org>
In-Reply-To: <20210122184754.GC18583@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b02671d-ef91-4d85-c875-08d8bf074608
x-ms-traffictypediagnostic: BY5PR10MB4260:
x-microsoft-antispam-prvs: <BY5PR10MB4260A6DA32B7E3D8C069367493A09@BY5PR10MB4260.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pelrQtrJbFnMwDm4h7zOm6mmktx9D2lKr5zwjqiKUdW9KYbM//Vz7ntSYrA9q7kiNviHXFgI61nGm42XBjLYmZk+wMGxGciE4zPmur4cjDw+HQ37ugTuw8A/XQOH0Y6KJJYQr7O6/1fT9I6iem9j7ZrZVWa/oy7Z5pC6wisvvstEk6xmcmHlO3KiJyi2dZkgd1Zy4k55vu0ai++NrPrfbLNNZDbexqhSwUh10oxzhR8JLpnP+l8nTQjHHHfqCMnXkHcOiId3Sq+I0vKM2tdqvcsjbaPtpmytq6wF5ZMDBsVx9RP/6XrUcUxaaMt1AH0gf5YSdeLUuzKDmfZGKdyQs3QY0SM2o32A9vQwqs8VxKtcd4aVn/xYNj/9EXtk08/zeZqAC5vqSK63nv2mMnijozln7r6lq5JmGxJysuRNrJZ6qaDujpnWnV9Tgr5xhIhNswPFOldK3hOqR6Wzpzlh13+fSrK59PM8VDp8CieG2RI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(39860400002)(366004)(376002)(186003)(83380400001)(2616005)(44832011)(5660300002)(6506007)(33656002)(26005)(53546011)(15650500001)(478600001)(36756003)(66556008)(66476007)(66946007)(76116006)(91956017)(86362001)(8936002)(316002)(64756008)(8676002)(66446008)(4326008)(6486002)(2906002)(71200400001)(6512007)(6916009)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7swwIUxlUdZ1bB+kQJoXYgFaPTlGDfBKnyS5LtHr1Co50tOnK2VqbvxjRNxK?=
 =?us-ascii?Q?YVlVZBpBzUIBGoiB7gKXSLSEkXdtcmkP7sbOY9zB5AIety1rorsx82EuiKT1?=
 =?us-ascii?Q?WUWirPO86pRXjFlJH2T1wkv+gA6Kxrdtgj/nPX7xA5qMK7pt+Q1dpNNs8U+B?=
 =?us-ascii?Q?oWGxbdc/DjhjJyeLrdaq2tYVG5/S01s1v6ZSTLvVjvJAk+Ki/5zNhWTHlXjJ?=
 =?us-ascii?Q?5/iHwIqRo73fgv2ApkWy+nmRwdMfnMJEiyPs1qLpxgf0PFCL5A1BtxaKzJGZ?=
 =?us-ascii?Q?7MZ8fLlfiBEzHcJenRerNPNKfWnZLF/0SiOwngEIwoao5rPUzf33PN7ZqpkG?=
 =?us-ascii?Q?3Z6E8OH4rKAyPdKWNoiXshK3Yz+h6U55ynk2N5LzZ6bd/EeRYdFutHqY08aJ?=
 =?us-ascii?Q?WIF+SMKMv2I9ATiJELd9hKA68Tb72JKOHGGriNAkTWBu4CuEOLsGNDJyhN/7?=
 =?us-ascii?Q?zIS/fZ/p+hGofJqvFuZ1G37BRFQlazLiDfuQ7Z+FhQXqaM0/YUg/lfOx0UcO?=
 =?us-ascii?Q?IQqbvp9MqX5IMZNWJFbBG0PhsPH8XbYF41uG/lL9/hN3X2ZLIQlh+lgyIJ19?=
 =?us-ascii?Q?KKD+IKj7Z9ulBAoMU1tuocqjkSMhTblz6Gp5x1dHmUlKDN0sJ1iXdmoA/oUb?=
 =?us-ascii?Q?/PmXyjdzZBeobF4GgY1fUwrC59ensl8cbxt5m1LmYVLVHh4DYlr66AWIGqSn?=
 =?us-ascii?Q?RLmmC3dmauk3bKjOn6xN4DBkhMXu608d2vdrNjzhGH6cr/MIXnIUEfkPQULD?=
 =?us-ascii?Q?9XMUQk/WJZPlovria3J/6ezFQqcGXgFvnh3gjpuQIJrlaLV/arGBGpUe5JhW?=
 =?us-ascii?Q?N3YtkJQg8fViUEWifL+nHO1Rgf6G6ruGjyCkpdydHADx5BTPEXSZN4bNB1KH?=
 =?us-ascii?Q?WbdJDLVlfHnZ2EOdCmAgi5xD5tlYWN+krXZsXVFZV10T8bmONxa0lAQwutQx?=
 =?us-ascii?Q?30TLBtz7Zltn8q9bWGvJHs3lDH6z6hazgLPqyrl7G51pLxuLutVLkB0gcoOu?=
 =?us-ascii?Q?yp1/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <472DBBE70DE4C74D8C4743A04152C809@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b02671d-ef91-4d85-c875-08d8bf074608
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 18:55:23.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pgnt051jTLNz35RIZUdA50dnk5v5ytSJwZb67gyrkPv9vhdDQTT9wW6jsngIxf8pfqiaVbqQwwDquB/Op34FLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4260
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220097
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 22, 2021, at 1:47 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Tue, Jan 05, 2021 at 10:30:18AM -0500, Chuck Lever wrote:
>> As part of the update, open code that sanity-checks the size of the
>> data payload against the length of the RPC Call message has to be
>> re-implemented to use xdr_stream infrastructure.
>=20
> I'm having a little trouble parsing that.  Did you mean "write code"?

The WRITE payload size sanity-checking code has to be re-implemented.


> --b.
>=20
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs3xdr.c |   51 ++++++++++++++++++++---------------------------=
----
>> 1 file changed, 20 insertions(+), 31 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
>> index ff98eae5db81..0aafb096de91 100644
>> --- a/fs/nfsd/nfs3xdr.c
>> +++ b/fs/nfsd/nfs3xdr.c
>> @@ -405,52 +405,41 @@ nfs3svc_decode_readargs(struct svc_rqst *rqstp, __=
be32 *p)
>> int
>> nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
>> {
>> +	struct xdr_stream *xdr =3D &rqstp->rq_arg_stream;
>> 	struct nfsd3_writeargs *args =3D rqstp->rq_argp;
>> -	unsigned int len, hdr, dlen;
>> 	u32 max_blocksize =3D svc_max_payload(rqstp);
>> 	struct kvec *head =3D rqstp->rq_arg.head;
>> 	struct kvec *tail =3D rqstp->rq_arg.tail;
>> +	size_t remaining;
>>=20
>> -	p =3D decode_fh(p, &args->fh);
>> -	if (!p)
>> +	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
>> 		return 0;
>> -	p =3D xdr_decode_hyper(p, &args->offset);
>> -
>> -	args->count =3D ntohl(*p++);
>> -	args->stable =3D ntohl(*p++);
>> -	len =3D args->len =3D ntohl(*p++);
>> -	if ((void *)p > head->iov_base + head->iov_len)
>> +	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
>> 		return 0;
>> -	/*
>> -	 * The count must equal the amount of data passed.
>> -	 */
>> -	if (args->count !=3D args->len)
>> +	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
>> +		return 0;
>> +	if (xdr_stream_decode_u32(xdr, &args->stable) < 0)
>> 		return 0;
>>=20
>> -	/*
>> -	 * Check to make sure that we got the right number of
>> -	 * bytes.
>> -	 */
>> -	hdr =3D (void*)p - head->iov_base;
>> -	dlen =3D head->iov_len + rqstp->rq_arg.page_len + tail->iov_len - hdr;
>> -	/*
>> -	 * Round the length of the data which was specified up to
>> -	 * the next multiple of XDR units and then compare that
>> -	 * against the length which was actually received.
>> -	 * Note that when RPCSEC/GSS (for example) is used, the
>> -	 * data buffer can be padded so dlen might be larger
>> -	 * than required.  It must never be smaller.
>> -	 */
>> -	if (dlen < XDR_QUADLEN(len)*4)
>> +	/* opaque data */
>> +	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
>> 		return 0;
>>=20
>> +	/* request sanity */
>> +	if (args->count !=3D args->len)
>> +		return 0;
>> +	remaining =3D head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
>> +	remaining -=3D xdr_stream_pos(xdr);
>> +	if (remaining < xdr_align_size(args->len))
>> +		return 0;
>> 	if (args->count > max_blocksize) {
>> 		args->count =3D max_blocksize;
>> -		len =3D args->len =3D max_blocksize;
>> +		args->len =3D max_blocksize;
>> 	}
>>=20
>> -	args->first.iov_base =3D (void *)p;
>> -	args->first.iov_len =3D head->iov_len - hdr;
>> +	args->first.iov_base =3D xdr->p;
>> +	args->first.iov_len =3D head->iov_len - xdr_stream_pos(xdr);
>> +
>> 	return 1;
>> }
>>=20
>>=20

--
Chuck Lever



