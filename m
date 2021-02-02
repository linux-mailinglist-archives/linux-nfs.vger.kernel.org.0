Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6C730CE45
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 22:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhBBV4G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 16:56:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58144 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhBBV4B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 16:56:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112Lt2h0125716;
        Tue, 2 Feb 2021 21:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ASNP7AZ59GNHu8QyKvM7rJTR11dLNvezmcWf/wfF0UQ=;
 b=N8rCu+aapa66VSvuXLjXgFF+LcgYxm7FT5CeJDnfoCz36hsJx2zSSlPXBa9jN588Zo5I
 vzpHaLCGwn7q3SMn92+YBMKqGgrGCTo7ym+qno9cw7793qgmxh8t8I/Ym1pIGiVvnWfs
 6S54xTQoE9BUghfvpPAtTkvW1/lAFMz9ga2ZU89xSFgaiIyr2iI7rS3iIRJjd6WRpdIA
 sTl7YkzOivo/EaOx4B5F5Ia61SG2aUb0cyBBs+pGLeI0KGvVeLJa/L8CN0KbYSUhd+Kf
 rv8ZZU29diZ4cxTsEeqcTPiLx6rBt03VhT9gP4l40UwghpD/Q4/Bk/PURJ+/OZEVEReX DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36cydkw23b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 21:55:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112LUYDQ070617;
        Tue, 2 Feb 2021 21:55:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 36dhcxddsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 21:55:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWk6zn+3Pv3DQ4UMl4CO+1jH/4PSYBfbZUsj6Suig0+dCpOBN9Qx6fB/0xQjhLFYlVFzu/+g7z9ZRhW1xLfZSZN5b/awqmDWm4CmFd3nOo6FdB+Px8gZc144t2Q3Xyyi4ehDFL0OP/weWrzFbhwLnNorE+moau5YxiIyPE+OMbmHsJB9EZRMIlHzZKd8rtKvkCalX5rRVOynIoCrosGUHD7eiHNRl3boyvTvWZsrOB8TJ243WVNnQR9Eb4EMl+RbaVs7NcUISYChQvZCF/VTnQMqCJdRdvhNhijroM58ekTzAEopzsy+aeQf7CBffluT5I5gttoN4m2NxkUNpxbfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASNP7AZ59GNHu8QyKvM7rJTR11dLNvezmcWf/wfF0UQ=;
 b=f/gWYenXeycVe+fhcDkFei5fio5q1MPcyTSrEHpZPRQozxJm30ahNM+jx6j2NspusjbgU3dnptaoWC0ykBvfdQxIRIUr2PdLF7pPw+9vB1fUsdAP0VBPmlzQaYxEi7nY0Rpnc4q15CE/p7NH3WABiawv21sHIve1UFiObw/ElHvV7g2wuqDwkX96MzzV0lg7gVatxWIGhL5ClSAjJ5+7jhFxoeOIsvmljJlmrPUS920oQ3m5STcxlT2lgvUiq3Fve5Fcbk2Kgw4ScYkdNrFoowGTr3nJxPAy1jYQO+RIRv7NZF9S6F58THTZ0NB/5weqTNEtNNyTBBGeIlcE24kSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASNP7AZ59GNHu8QyKvM7rJTR11dLNvezmcWf/wfF0UQ=;
 b=miM/BgI6/5zdLZu3n3BlDffLU3rFP5N06vsaz3cpZhqkH9DmEwJXf1AceDHyns1izHc+ZU2ByLyPZTWaKRezFWf9rwwZUZt+0W08oKxaYj7fBsf7uhgBXD0jcJ1l1BnpW8Jizj89JmqK/MUUxugjJJPr2I9s0q0OG1Q2ObbIlbc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2486.namprd10.prod.outlook.com (2603:10b6:a02:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 21:55:07 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 21:55:07 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] xprtrdma: Simplify rpcrdma_convert_kvec() and
 frwr_map()
Thread-Topic: [PATCH v1] xprtrdma: Simplify rpcrdma_convert_kvec() and
 frwr_map()
Thread-Index: AQHW+XI3YU9+0Px6s0a/A4oYM4MFE6pFPVyAgAAAmgCAACoMAIAAATsA
Date:   Tue, 2 Feb 2021 21:55:07 +0000
Message-ID: <4A44C2FF-BFD6-423A-9FE5-F08CD2D75AA4@oracle.com>
References: <161227696787.3689758.305854118266206775.stgit@manet.1015granger.net>
 <e53cc3c2-2209-5f35-c487-9e59b9b9e526@talpey.com>
 <B0EED542-086B-4E76-9348-FAB8EBA612AB@oracle.com>
 <23f6893c-de31-0382-78a4-c09b1ceb2787@talpey.com>
In-Reply-To: <23f6893c-de31-0382-78a4-c09b1ceb2787@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 599a7318-7e9a-4839-ba23-08d8c7c53486
x-ms-traffictypediagnostic: BYAPR10MB2486:
x-microsoft-antispam-prvs: <BYAPR10MB2486E652F7FB6E1BE344C61193B59@BYAPR10MB2486.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:146;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7tt4zpyqCo6n0R7rx2yL8TvT7x7bjmuRG3QNMR/GF0WC1/varQnaoDvzkJPnzMAec2nPrR22X61XoVLFmudIXY0arC7linbQNpxYWqF7Ov0LWIUjCQDKqwfDm7/BXebQxN2ODMBa2Sq6VDHKPhM23V2Pq5V1T4+EDjKvrYmddbXwpiWRQ1ICVkiNOAb+iS7ODMx3RsH62G7TTIKVvBfeU7oliRvd4OJQZl7YgFwFSE6PMG1TLiMPNKyulb6PYsWYDXkVDmjZRRb+gR1AvZZLHy47tgLvROPGuYMKwDNE7xYXL99bmu3Wa9YmYt4eR9noBQktYXZR+HLvzs/UpmCCk1aIVK6burgoECqDqO47v3ZTOsEfI/82DtW42FlaUQTBhZmzCrU0AHrg+XVB+m5N7MmnHLkVEvZ6zJKXj4T6mlq7piQYlpoIKVfa/Aj2rmB4JlEF1ZGdBMskl3JImp3CBQfHnPhoesoTnp8QlmeSDFGGRX68MnrPR9tkZOijc9Y5U6J+qwf5e5F7aH5re9j/DolIGHeYiTc5Zceq05ZZ3aoD1mEZ8no8zjOj6EbmUnLEwQNgZI7+CTtpAD51AwudBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(346002)(366004)(136003)(2906002)(66476007)(6512007)(66446008)(66556008)(64756008)(66946007)(8936002)(86362001)(76116006)(5660300002)(26005)(6506007)(91956017)(83380400001)(186003)(36756003)(44832011)(33656002)(8676002)(6486002)(54906003)(4326008)(53546011)(71200400001)(478600001)(6916009)(2616005)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zuBXJ0yCmXfduaiSx9y8DMsAaBJnzAUTWWeZVn9dsBE+6YcqdyHpdG0diLl7?=
 =?us-ascii?Q?dkelAhNuDtcL16pQWiyt7YreAwxqwoshxuOJCk4K9u0kxzcLQ+7fFDdDbw9v?=
 =?us-ascii?Q?oVGiML7uAKqVuxITkuOwKVh89OzKD+QQjYANoXjWiHY1aDkJTu3rlKJIL445?=
 =?us-ascii?Q?KXoUnmq5qcej0lFu9IcbWER8aqYvaby4H0+dVhJLLxAE2BD5ZeZMlO2qjbr9?=
 =?us-ascii?Q?C5e+TlI/lV3SHGeEhftwGdaI/4cMBn8muT2NqiJl2YmhQfayt7lC8gXUzVii?=
 =?us-ascii?Q?JondxLYQpU0ZYcRlV6sGIeKrbTLy+v0Ul7G8NX6TUHVYnVnPfyL71bYbdb0+?=
 =?us-ascii?Q?M5sbb6JRRebJGB8GxGIKx821VAR1y1qcdQ0PUKbvqSWuAfsfyAlBSCgFwuTR?=
 =?us-ascii?Q?M5dqn5mfOrFWzOvjFp39aQThlqJfBAjkVMTvmJ6C0J99woTHIxAxs9dDSaRn?=
 =?us-ascii?Q?JJMKniqS7DQMkyElk8IPvFJiAiK2Gq1p80c+YpaYDSS9KjOKjk8tkV6/p9eo?=
 =?us-ascii?Q?2m9MlLKnoUnz2F+3VKrvQuMQgF0EpIuOrzjMUfq7xwzVkKPrbzTcrpXCYaY4?=
 =?us-ascii?Q?2e6nkj68lMvV00TXrMQ2s0u7LsOYzyouAV0uR/QaKqGQyYIq3qM6GySvVOB8?=
 =?us-ascii?Q?tvJPBxtBFt3zy2GLZiVMZ2+R+bKhfV9msVy+rkZKLVSv7qoeFQCuKLYf3X4m?=
 =?us-ascii?Q?bmnQJq9vD/6EMROfl+RBDDcpZGIhx5dd3pAd6+fT7eokcw9hbvv2V7jjS1/U?=
 =?us-ascii?Q?xxWgJdMkIAvQYzMuai+xxsUAl4xeOvnApKHkmWE8aZ026Usrbp8Jm0rveTcO?=
 =?us-ascii?Q?gjQicwGFe9+oqV/k/Nnq9Rgg+MVvN7bzgimKzXGI8fY5So9iFXw3uuQnQvYL?=
 =?us-ascii?Q?b7hJOPtHYrxDS0CbH0sA3HE/BsNswcrxtQbW3BgBgZ3zhkENRGem4LcaKGiV?=
 =?us-ascii?Q?F95dngc4wi70gtj7hmskfOcnLJAC/lmfozDGLTQMEm/W9KGynurTtrdlmn/I?=
 =?us-ascii?Q?ZB4LI6P901XPdba9lJ/sYk/FT0TG8xtu28q05u+QAh3g9eg0Aw/bn2yseTAD?=
 =?us-ascii?Q?JMcVOQyPpPp6AMFUnSOi4tODE9Firg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8564F7F56080734F859F917009593CB6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599a7318-7e9a-4839-ba23-08d8c7c53486
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 21:55:07.5529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ks6rAGRFcrk3cW+RulnDyq4ksXj74YS5SMquUOhSx8hIEYHMOYRhOjvsXdUGqi2OC18RtIcFLstTYJRJ3v9WJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2486
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020138
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020139
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 2, 2021, at 4:50 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 2/2/2021 2:20 PM, Chuck Lever wrote:
>>> On Feb 2, 2021, at 2:18 PM, Tom Talpey <tom@talpey.com> wrote:
>>>=20
>>> What's not to like about a log that uses the words "with aplomb"? :)
>>>=20
>>> Minor related comment/question below.
>>>=20
>>> On 2/2/2021 9:42 AM, Chuck Lever wrote:
>>>> Clean up.
>>>> Support for FMR was removed by commit ba69cd122ece ("xprtrdma:
>>>> Remove support for FMR memory registration") [Dec 2018]. That means
>>>> the buffer-splitting behavior of rpcrdma_convert_kvec(), added by
>>>> commit 821c791a0bde ("xprtrdma: Segment head and tail XDR buffers
>>>> on page boundaries") [Mar 2016], is no longer necessary. FRWR
>>>> memory registration handles this case with aplomb.
>>>> A related simplification removes an extra conditional branch from
>>>> the SGL set-up loop in frwr_map(): Instead of using either
>>>> sg_set_page() or sg_set_buf(), initialize the mr_page field properly
>>>> when rpcrdma_convert_kvec() converts the kvec to an SGL entry.
>>>> frwr_map() can then invoke sg_set_page() unconditionally.
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  net/sunrpc/xprtrdma/frwr_ops.c  |   10 ++--------
>>>>  net/sunrpc/xprtrdma/rpc_rdma.c  |   21 +++++----------------
>>>>  net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
>>>>  3 files changed, 8 insertions(+), 25 deletions(-)
>>>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr=
_ops.c
>>>> index baca49fe83af..5eb044a5f0be 100644
>>>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>>>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>>>> @@ -306,14 +306,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xp=
rt *r_xprt,
>>>>  	if (nsegs > ep->re_max_fr_depth)
>>>>  		nsegs =3D ep->re_max_fr_depth;
>>>>  	for (i =3D 0; i < nsegs;) {
>>>> -		if (seg->mr_page)
>>>> -			sg_set_page(&mr->mr_sg[i],
>>>> -				    seg->mr_page,
>>>> -				    seg->mr_len,
>>>> -				    offset_in_page(seg->mr_offset));
>>>> -		else
>>>> -			sg_set_buf(&mr->mr_sg[i], seg->mr_offset,
>>>> -				   seg->mr_len);
>>>> +		sg_set_page(&mr->mr_sg[i], seg->mr_page,
>>>> +			    seg->mr_len, offset_in_page(seg->mr_offset));
>>>>    		++seg;
>>>>  		++i;
>>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_=
rdma.c
>>>> index 8f5d0cb68360..529adb6ad4db 100644
>>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>>>> @@ -204,9 +204,7 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
>>>>  	return 0;
>>>>  }
>>>>  -/* Split @vec on page boundaries into SGEs. FMR registers pages, not
>>>> - * a byte range. Other modes coalesce these SGEs into a single MR
>>>> - * when they can.
>>>> +/* Convert @vec to a single SGL element.
>>>>   *
>>>>   * Returns pointer to next available SGE, and bumps the total number
>>>>   * of SGEs consumed.
>>>> @@ -215,21 +213,12 @@ static struct rpcrdma_mr_seg *
>>>>  rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
>>>>  		     unsigned int *n)
>>>>  {
>>>> -	u32 remaining, page_offset;
>>>> -	char *base;
>>>> -
>>>> -	base =3D vec->iov_base;
>>>> -	page_offset =3D offset_in_page(base);
>>>> -	remaining =3D vec->iov_len;
>>>> -	while (remaining) {
>>>> -		seg->mr_page =3D NULL;
>>>> -		seg->mr_offset =3D base;
>>>> -		seg->mr_len =3D min_t(u32, PAGE_SIZE - page_offset, remaining);
>>>> -		remaining -=3D seg->mr_len;
>>>> -		base +=3D seg->mr_len;
>>>> +	if (vec->iov_len) {
>>>> +		seg->mr_page =3D virt_to_page(vec->iov_base);
>>>> +		seg->mr_offset =3D vec->iov_base;
>>>> +		seg->mr_len =3D vec->iov_len;
>>>>  		++seg;
>>>>  		++(*n);
>>>> -		page_offset =3D 0;
>>>>  	}
>>>>  	return seg;
>>>>  }
>>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xpr=
t_rdma.h
>>>> index 94b28657aeeb..4a9fe6592795 100644
>>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>> @@ -285,7 +285,7 @@ enum {
>>>>    struct rpcrdma_mr_seg {		/* chunk descriptors */
>>>>  	u32		mr_len;		/* length of chunk or segment */
>>>> -	struct page	*mr_page;	/* owning page, if any */
>>>> +	struct page	*mr_page;	/* underlying struct page */
>>>>  	char		*mr_offset;	/* kva if no page, else offset */
>>>=20
>>> Is this comment ("kva if no page") actually correct? The hunk just
>>> above is an example of a case where mr_page is set, yet mr_offset
>>> is an iov_base. Is iov_base not a kva?
>> Ah, well the "if no page" part is now obsolete.
>> I suppose it should be set to "offset_in_page(vec->iov_base)" ?
>=20
> Seems like it, yes. Assuming that only the first element in the sgl
> has a possibly non-zero offset ("FBO"). All others must be zero for
> the FRMR.
>=20
> Is it guaranteed that each kvec is at most one physical page? If not,
> then the length may span into a random physical page, that was not
> necessarily contiguous in the original KVA-addressed buffer.

IIUC kmalloc'd buffers are backed by physically contiguous pages.


--
Chuck Lever



