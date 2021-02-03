Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76830E25A
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 19:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhBCSSl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 13:18:41 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60320 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhBCSOf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 13:14:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113I9ZXu097701;
        Wed, 3 Feb 2021 18:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lT5uoxLyEJfzkKVUc5gIv811ElhjLLDgI+4pgxGIDk4=;
 b=mr4m6Jumaf7x+KorUwnXa55VLyhMEzkSEH+N5xf7+JwjtbsF83TcxIjdWUQp03wGpDfI
 xQ0oA+gVMcnnrkv6dEQ/IonK5D+m3Brx+m4YEL1DNA0JdMt8ihPy0fr+puzq+imkwAjm
 0E+DDtsT0/+rO/Jh9fbwh6468j9STxBMiY7Qjqvm28hmiXCFIjx7yC9/nRZ6Gm8Zs9fQ
 uQgqEal3B27xa4jnqvFN6x3r/VytJp4QK4hWUJNtFMGBP2MzG7BKarUnuAhM7iJJJ6Sp
 xSheXaTmKiBv7EYKEH5S5PnlJcYPmZJII/mduOBl/zQEMf1vzCwmM2iT5NmyJKP7a3jI ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36cvyb1ncr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 18:13:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113IBYmm004828;
        Wed, 3 Feb 2021 18:11:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 36dh1r96ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 18:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtTYJC/pFUBJ50M44syxDKlXAntSoOBqGWCDL+BcZPMoOWyY3CLbL8Jd/4wua2a5xJz8VVM3l8D9nGfbtMpa/ub023XS190wyrrVb8FmLBEJwFZ/m6+1d0JVGsszlRgVAVTufeE22LhJmffIwrBE3VEDthpsHdYZCPi6rYX+UOKLwWCpj9jCL9Jf77iBo6V3pK1EMGOCeh2lsi0VY6tKqzt48suM+7UxbZ4MZyOI5kv0YyZmUu/JyZguXbBOBq2e3BOBI7XEG9l2NTCyh5AmCHJ0/CUdz+LPGBFJIFMdteG/mh4bFpG2PlJunyaa3wZERN2XYps1+rp2FApiMG/UaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT5uoxLyEJfzkKVUc5gIv811ElhjLLDgI+4pgxGIDk4=;
 b=hFoimd+ZpkwcYXOi+WJC86V2StWXkbeJp/9Bbe9g8kKhkOoMqw0GnVJNt6WtIBZcgfuk8H2naktEmLfxxtNomF+O/g6pRa8K7NG6YFWNBU+SvZdlbuHxtk4xgJDVcenalwVgeUtZMlSGLGyjDmozGQiTrzIDiJzuAAXax6oZ2R5QX23FDk6INav4dTh5bqEcg9+kBdhXgmALyIUlTPDeRphzbMNqROKuTSHe2IrnKiMTAVmgm2dpS3O2MqtjYgDyDymulGWSTB7PDStCEIcZilXNNBSDzK8HyMBp6tlL3pcKiJfEFK1dMiMIR7wjWHvEnaohANPGKg/b+wFsI2Y1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT5uoxLyEJfzkKVUc5gIv811ElhjLLDgI+4pgxGIDk4=;
 b=l7QBKuiX+qAfu55MIw+o4tFhO+/lG+Y1lEoLHwAUxyePFbr6QWsRZpMDcpMend28ntktaQ3oFcuF0dXWYDytt5q5+zMAJFI3kF5Yo/AsUxOtGzXTpdAH4LlxvoFL1bcuJtYT/x+u9Tp/PFV8FD5iwF5GsPmQ7KtHfLj7/tKbyog=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 18:11:39 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 18:11:39 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] xprtrdma: Refactor invocations of offset_in_page()
Thread-Topic: [PATCH v2 3/6] xprtrdma: Refactor invocations of
 offset_in_page()
Thread-Index: AQHW+kkmqLH1KTPM0US61/D6LB+p56pGuv+AgAAAdgA=
Date:   Wed, 3 Feb 2021 18:11:39 +0000
Message-ID: <A8FD067A-DD97-4A5D-BCB1-83DF3FAB3842@oracle.com>
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
 <161236944700.1030487.6859398915626711523.stgit@manet.1015granger.net>
 <d0bbab3e-851c-3388-3d1c-cbc6249a6803@talpey.com>
In-Reply-To: <d0bbab3e-851c-3388-3d1c-cbc6249a6803@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a08b921f-b565-47dd-6d92-08d8c86f26de
x-ms-traffictypediagnostic: SJ0PR10MB4656:
x-microsoft-antispam-prvs: <SJ0PR10MB4656EC865C0853A49E674A9B93B49@SJ0PR10MB4656.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/Y0isHE+jQ/FfvduX2RDnx1ZFV1PEyKB9E2M/C2YAU695rHPcNeILzpx7ewq80zeXPZpEK+vsPT8f4ICcZtjoC+wlD+RsQm8Pic7C6PlIhrx/2DRkWtDpKLboDRqdz93ZFExLcpk2le+B5kvv/oIrM1jqx88oBfoZJIVh41r/m0nxpPYDV0YM2pmTimEfiyP2M+gJzUhJI3iivbnbOcgCbd4a29/P/qelgIoXQKcjspe8gBXzWJubvmXzqPIacj7UQ7mLyATglLnU9Sh7j+O7ea0AvhSiO8t5ExTRnKaO+vWzunrgyh4TXxi+vWKdjK7q0m3D3UIf9yWYnssah5O/x+34YPBragcVHkSjSzv5j4Rx53LyQacQUeofPQ8Rx7ykNnfP32F6dSoLY5glHv2ZyALb70Gbk8w/VGbt6WvH4XYgO/jcfvWRcM4GzQvgaaife8JGds4Sr/+9D6vTsvD//Tw+JPNKio+RlbVPRTUklh8elEe7CLHliCgQxVaLe3S2rlIKriBnrQFMDy8ng10cUKr+E6DfxaArpUCofJ0z5isOIAU3Ji0xbQ9wKIu73NrR/JZrp2EttbdhsB+NVItQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(376002)(136003)(396003)(2906002)(53546011)(4326008)(2616005)(83380400001)(66556008)(36756003)(6916009)(44832011)(6486002)(5660300002)(66446008)(76116006)(91956017)(316002)(64756008)(26005)(8936002)(186003)(33656002)(66476007)(71200400001)(6512007)(478600001)(66946007)(86362001)(8676002)(54906003)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fBDnlp+mqbJPnTXiGrlX7ziJsLUymo3WukgbPO/6TmtYbbenWqXrSHdNpIwp?=
 =?us-ascii?Q?lIft8y4WtvdnttbX1TLRpreeMpDWBKL2wBQ+b/dW0GQvgAsly5RVmG1T+xdn?=
 =?us-ascii?Q?9MDmouL0wvklAiY00prui/z1Fq5sc4tZRs9QvkYWGijMtulah+DWArxtrO4n?=
 =?us-ascii?Q?qDwcgWqm/TF1IN7Cn7AvySBhculrFYWcvY0qeS8OXmTWqCOBA1i7loGeOkpF?=
 =?us-ascii?Q?MC51yAJ9tURu7oIuSI3fyJ0JjlO1f3NfrvWuvXiyBLQ+GS/N/sw616HTmnPG?=
 =?us-ascii?Q?xPtl/NMGda0+PW4hUbJpbgos4VFDtGDhLAdl9RRtW9M9uL8lT7M00GK2AqaW?=
 =?us-ascii?Q?bY9xC3eiYTWemYenmGsbSnYA3fWuEfWClWAFUE0wuAd2VvcbKMS/gT/ONGZs?=
 =?us-ascii?Q?jNgp0Hss0s5axJO9URal/M8vzTGr1XgO+H6yPLrzqo3OejNWRoSFI1gpshHd?=
 =?us-ascii?Q?+XxgfGoi3NugakQJhTk2M4UDTPKD2cuJYYpRILxUzhwmn+jHVhY3SUADUnS9?=
 =?us-ascii?Q?C7jCUeMYno1nW1s4z40YykcbiQ6CAz6peyWqVPqmDpLlB5PRhBVrZtoVFoWh?=
 =?us-ascii?Q?cjAOnBL74wpNyrQx3XqB6FW5pgJVKTpZle8EQR0t0bPATJ4ew04DLJ40WNYs?=
 =?us-ascii?Q?0XL24spbiOGf+iw7gkC39fFWjg4KYJAxu6w1HAmHCSfNNZeEknVIZEy3Uu61?=
 =?us-ascii?Q?7AMMS8hyDvcKgtgJLMXupEM5tsN9PSiH/55/ljSTfsWBK0/BdUZKvFtv+DD5?=
 =?us-ascii?Q?6s+RTkemTERjCNXlOGRXnvUEfxQxSzeQemsAD/O9lYulA5hZMIw7TZ7aBw65?=
 =?us-ascii?Q?o8GDx9LTrn7+0/SPBy34pG50/ZT4URUVky4Y8BaKcvpKIgh9OHe7yIUunFS8?=
 =?us-ascii?Q?19aM8HYGEWuaqTueg5NmqQC/oGYkAacqw2FmNJTR52EnjdmsH0BVDgC1GJjn?=
 =?us-ascii?Q?FvFedcX5B2Ox0RbFRACmImr7eS5F/phvao+EQxSd0sNPkJJmQX6ksdjpJTCS?=
 =?us-ascii?Q?hxos3LuGvF+WVSBO6xbOGwCKm7Q7wtywQ0g/9GWHEwxHwT7mFwqE7hk4h2dM?=
 =?us-ascii?Q?hSqEKYy9G1OvPX1+QnzWlrfehOSDSw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E378D25AA203624C819894E9C3CB1ADD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08b921f-b565-47dd-6d92-08d8c86f26de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 18:11:39.0766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikGgRRaK2ks3CazVOGRz4fjllrcw8x8NZP1izDs5Yer7cTyaCfBc9ntk65dEOpFsXyIkcEQ0TSFn0ZegqDqa+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030107
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 3, 2021, at 1:09 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> This looks good, but the earlier 1/6 patch depends on the offset_in_page
> conversion in rpcrdma_convert_kvec.

I don't think it does... sg_set_buf() handles the offset_in_page() calculat=
ion
in that case.


> Won't that complicate any bisection?
>=20
> Reviewed-By: Tom Talpey <tom@talpey.com>
>=20
> On 2/3/2021 11:24 AM, Chuck Lever wrote:
>> Clean up so that offset_in_page() is invoked less often in the
>> most common case, which is mapping xdr->pages.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/frwr_ops.c  |    8 +++-----
>>  net/sunrpc/xprtrdma/rpc_rdma.c  |    4 ++--
>>  net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
>>  3 files changed, 6 insertions(+), 8 deletions(-)
>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_o=
ps.c
>> index 13a50f77dddb..766a1048a48a 100644
>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>> @@ -306,16 +306,14 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xpr=
t *r_xprt,
>>  	if (nsegs > ep->re_max_fr_depth)
>>  		nsegs =3D ep->re_max_fr_depth;
>>  	for (i =3D 0; i < nsegs;) {
>> -		sg_set_page(&mr->mr_sg[i],
>> -			    seg->mr_page,
>> -			    seg->mr_len,
>> -			    offset_in_page(seg->mr_offset));
>> +		sg_set_page(&mr->mr_sg[i], seg->mr_page,
>> +			    seg->mr_len, seg->mr_offset);
>>    		++seg;
>>  		++i;
>>  		if (ep->re_mrtype =3D=3D IB_MR_TYPE_SG_GAPS)
>>  			continue;
>> -		if ((i < nsegs && offset_in_page(seg->mr_offset)) ||
>> +		if ((i < nsegs && seg->mr_offset) ||
>>  		    offset_in_page((seg-1)->mr_offset + (seg-1)->mr_len))
>>  			break;
>>  	}
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rd=
ma.c
>> index 529adb6ad4db..b3e66b8f65ab 100644
>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>> @@ -215,7 +215,7 @@ rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdm=
a_mr_seg *seg,
>>  {
>>  	if (vec->iov_len) {
>>  		seg->mr_page =3D virt_to_page(vec->iov_base);
>> -		seg->mr_offset =3D vec->iov_base;
>> +		seg->mr_offset =3D offset_in_page(vec->iov_base);
>>  		seg->mr_len =3D vec->iov_len;
>>  		++seg;
>>  		++(*n);
>> @@ -248,7 +248,7 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, st=
ruct xdr_buf *xdrbuf,
>>  	page_base =3D offset_in_page(xdrbuf->page_base);
>>  	while (len) {
>>  		seg->mr_page =3D *ppages;
>> -		seg->mr_offset =3D (char *)page_base;
>> +		seg->mr_offset =3D page_base;
>>  		seg->mr_len =3D min_t(u32, PAGE_SIZE - page_base, len);
>>  		len -=3D seg->mr_len;
>>  		++ppages;
>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_=
rdma.h
>> index 02971e183989..ed1c5444fb9d 100644
>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>> @@ -287,7 +287,7 @@ enum {
>>  struct rpcrdma_mr_seg {
>>  	u32		mr_len;		/* length of segment */
>>  	struct page	*mr_page;	/* underlying struct page */
>> -	char		*mr_offset;	/* IN: page offset, OUT: iova */
>> +	u64		mr_offset;	/* IN: page offset, OUT: iova */
>>  };
>>    /* The Send SGE array is provisioned to send a maximum size

--
Chuck Lever



