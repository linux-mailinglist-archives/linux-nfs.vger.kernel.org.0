Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F1496D20
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 18:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiAVRhX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 12:37:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230289AbiAVRhW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 12:37:22 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20MGdmE1004880;
        Sat, 22 Jan 2022 17:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4eJ5i4Hk7TSJsoQ8+N0ql7Q7TWTYWqv3kycDOgBNEtM=;
 b=Y4n/OZ0eBpg6Phm8TxGYVSDM/qKgYqw7eN3ZIBwsTf7HbHWxZdsct/OTPvXB3UD+GeE4
 hefTzT6v9FT/MGCHFgKAKhiTakJMEco5C//j5KUyec+QShIuHuj1BsRAZW6M2WKCuqpo
 H9zqiRdy1LE3Ae8caWdUgUpwscS3TIIxDlEuSc+pYodQSrhWW2E3kce88cHduyoVgQzb
 G+JKrXQaOtQQ8Ms4Vlntm7wb0nljCjK6IsrL7xorOpIkpwMesJZmtv5eh9Wy0le8mATr
 6YcuVsNsFhYlrxF502IFb+14HnfCrYWF/4SQRdNEK+V96Bjq9yql4F9yhEF2ptDnag6G QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr9hsh4gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 17:37:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20MHaFga098329;
        Sat, 22 Jan 2022 17:37:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 3drbcgtt0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 17:37:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIvjuOD83k1o1mgZK7Rsv5v7o1i6ewWWHI++sj+tqnEWbeFhOi36NrnQPNGl+kVlccxCQZfDQ7rHU9r82yc+S6Ll9Ww8oQshUwkXK1ygcNlcF+NjKMzO9A0wubarrqiMQ1mhJ5dPwhDnXda2LxWo3bnuHfDq/1hXG5eO71cyp02KJS7doIzyvDdDOAa1THGo/zdOyYduYi0STdGKb1qiOKqNtPSlZkLmFrNaXLOkxciC0nfL7vcafilXbVEK5PZKVq6sIxFbCeY7bNymmtYOVsnGttJWcrhQOcOJ4Z/67CLJgqTAo2a4pNb1fyxmhckdCVXrnuD5GmXuhT6Rauzrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eJ5i4Hk7TSJsoQ8+N0ql7Q7TWTYWqv3kycDOgBNEtM=;
 b=SZ8DJ2CeMtjT6l5xOcx7eIib7XliNBjhzvQ6+wuWno77eCGuoQpuRP5rdikWvMuNrYtWuQIOwMFVjPTU6F4fUA4iQp9SM6yw3fH547VdD9r0Ryos7cQOL9/559fRAzNjnTgT2fTpOFjy3GtuuJlL+eDnNcCTiToeZaHJtSBeD2ByCY1vBKyWG6lL+7OFTcgmkOOTkUVVKs8V4sqM3J7C0QwF9XiQjIOJLTdhKsiNOsYgrzkMGL5NLekMxfLSC5Z+bmirbtGkeR98CJ23eqq1sAENoCKZKkGdD5lvo1NwWICCHyzutvJvvRxgXiATMD99w8TegFKaJyrxUgqU4wcLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eJ5i4Hk7TSJsoQ8+N0ql7Q7TWTYWqv3kycDOgBNEtM=;
 b=O+QTkhpFfmIoPfOLrFPiy8g3nTJk2kzbFDsFxm7rN/9QnAyx6LL1rLKYV5B0VsJn020vvxcSS0s7u9zBKQwrpD3eA3IOkb0mA656z4px8o3yO1rUT/z0b89TnJgmRXlefhS4R6zPQ03V+3j1we4gchLYC/9WvSAJ6QHAfYp4vzE=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM6PR10MB3388.namprd10.prod.outlook.com (2603:10b6:5:1b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Sat, 22 Jan
 2022 17:37:16 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.014; Sat, 22 Jan 2022
 17:37:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Aloni <dan.aloni@vastdata.com>
CC:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: trim reads past NFS_OFFSET_MAX and fix NFSv3
 check
Thread-Topic: [PATCH v2] NFSD: trim reads past NFS_OFFSET_MAX and fix NFSv3
 check
Thread-Index: AQHYD46SBFtdFYx+RkmeBfOdi1yO+KxvTkaA
Date:   Sat, 22 Jan 2022 17:37:16 +0000
Message-ID: <ADEC85C2-8D72-4E25-A49B-2039C1FF82F2@oracle.com>
References: <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
 <20220122124953.1606281-1-dan.aloni@vastdata.com>
In-Reply-To: <20220122124953.1606281-1-dan.aloni@vastdata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c73fa0cb-68d9-4d20-580c-08d9ddcdd522
x-ms-traffictypediagnostic: DM6PR10MB3388:EE_
x-microsoft-antispam-prvs: <DM6PR10MB33886287FE1222BB28DF3AE0935C9@DM6PR10MB3388.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQE0HlKIv2fJXJAnY7HUfWH/ViR9ZW6BJlI25CpVy8GHzZMo6x1PvFWpMEx7y/aiy5RsbGZRyISJeBtnCzhcQJkVZ0qGhple1idyo6I9e47aUTCxbxZeg1BTkEcg/6EgY6Z11N36sEOLFJBMymmb5VizdncV4g+0AAwFxO654+/1vPf0LavMxbNktOQfcyu51m37Wm56dg8vtUh36w2Si3kb2KUrHZusSibwEmxlr8FtGotQ4mNCRGdeVOjBe2tCyKpaS2o+fm/r0YwAv8oTnFqWXQl4zYGwHekGYF0/odLTBq4td3Rn7jWS3ib33A8zNSHvOstb2CTrx1Nh8QiCfaSgnH0/VyHPVF3cz89b3b473jnOL268Zbq/pthbS03HsIeTuMTxQDdfz2Ol7u9fAUBCySqf5eoDiiy4262472Jb9NSnvX5CptCPgigPqdDY0+rU5so2QA9yP1SgXX8ZsCqFk/iQ7uOV6qO4ZHX2YYl43/uqWSxejI2rXCE2WQDckY8uoCKCM4/sK3hp1b7rAmVq/xZhKm/dajOF8o+KgalBmVAokakBlC2Xqp+lf9fKBuY46GucpM2QY2VLUj17ltUg2uRg/jBHb/ffIUNNwO8jW4U01A9Fwiyg3P9KbNrdpFh52ukiljjY3B3najp91+KeA+hUg67v8CiqiWzE2WscwtJXrR7iYM5sWPg6M8xTfouxrmxmgCNnUa8m0xMylVToHjenusjENwul6XutyDg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(4326008)(66556008)(6916009)(5660300002)(316002)(86362001)(8936002)(71200400001)(64756008)(66946007)(66476007)(2616005)(66446008)(2906002)(38070700005)(186003)(6486002)(508600001)(36756003)(53546011)(26005)(8676002)(38100700002)(83380400001)(54906003)(122000001)(6512007)(6506007)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NJFvib6/rzMQ53VlKGlUmToNORxi8sdsQt9dBYH9PlvNuueArm65UpHefNuv?=
 =?us-ascii?Q?29P0m088zs7VJ2mURSoYTnGBaPFt479wTg5KXzvpwNv1R7FYwBCwW0anWyR0?=
 =?us-ascii?Q?k3pfVYYsagDtUYbE+UZrTmdPP8LWBlz8JhmKO/3VFLRkCa4C7Qpg8YiQGjkW?=
 =?us-ascii?Q?/7TOPyH2ghjI7Lohc88jeYNc9ZEyNXe1NBZlVNYF74d3CFNTyZ3YCfOAvIgi?=
 =?us-ascii?Q?pZBEZsHOj0qMtKpdK9GRxE0xqPsI/PTwexmOsAk74+xDIkZW62AMUH3rzRiC?=
 =?us-ascii?Q?YwDRF5T+4Hdq3cN9BziUEqaleWvkuW/g0U2Z+8EvsDB3ouBK0EVYLuJAZ5xi?=
 =?us-ascii?Q?ZRwH17xZ/1650NQJV+NtXelRmkhUsBs0dq71RnJY9Gk1kzw7N5lVCZRcmfNt?=
 =?us-ascii?Q?fwAmVVLbR90v6Btm/6pwvPstI4tonhckMnUAElL4bbkclVfzJeKmdXWNQOaR?=
 =?us-ascii?Q?HZP+8MrhhH1g6YDJbriydtm+PXQ0NwnEwGbY4luVA0btN4Ln36fmvN5M4JMU?=
 =?us-ascii?Q?TRMVVwTRdqpods3dYXm0PaEBSLthjRM6m4In4jZrxrmsAD9s8wZDkJwtGESq?=
 =?us-ascii?Q?WDR6zsYG+qAr1mRp4R3kt9kGQV02SzwgmLkM/+C0Nx1DtCVE/WDagQYCimdt?=
 =?us-ascii?Q?Xu1Hfmmij1UpO7KSqveuj53VsZtMbrw3QTFT2TSIMRdEFKyqtdG6wlWdJMjg?=
 =?us-ascii?Q?1FvSoMRVuOFijQoox4aNfdFKvDnA9QxywegsTxKpXwH3OTPvcyRa0YhQ0Z2Y?=
 =?us-ascii?Q?/ys/gF658Fo3D3rCZu0MawaSR0eguY/r0bfr7dynocGYPhPJcEn7+O26D98r?=
 =?us-ascii?Q?aYuWvUJxRTx4FWpHoUq+p5W9PdWb+aiDcboPWwV32Jd7H+j4zWMXwzVglUfr?=
 =?us-ascii?Q?SFj+F03T8oL9QXc4lvNAZY8GrRpIUpyPE7GEQ5Sx67ddey0WQnn5PegsSAdW?=
 =?us-ascii?Q?+sFG0XlGfo0RWotI91iAoGlv86LKvEHz0tU5TFKVLr6cfkKwvM/tBnGHrmNH?=
 =?us-ascii?Q?1UkaQIqZnlHQCBIR8FqvLzxqkkO+nbCVd221pRNFWKOMBHdoqGfoVjWtlmIW?=
 =?us-ascii?Q?ch3c8Jjr8oNdF7t/chDTGdzNswv+JaYpwi6X7kvz5KE9u6S3/GQRmOb91jxQ?=
 =?us-ascii?Q?PTazBc4OkyIE4v+ImeieQaJ/TGCVSYZ/Xq9sJnTtF+lqVVlQVRMTtY4a2yaM?=
 =?us-ascii?Q?qrOTwZnnkCq/OENTkbV2vxJ7eAkWAonhXmI88u2EU09CF6L90ZaEaBHfz+PL?=
 =?us-ascii?Q?IcbzxAPGt73DPCBfYa7wu+kyt+9uMQ2VbLuaAHaWU/JV0gGFOMrqa6iakUD8?=
 =?us-ascii?Q?Qc4p1c7HD9Y5vjxUtXkTHFNa+UeuVVo8I3+Xr2+0tBd6+ldpmMQHzjLumsJ6?=
 =?us-ascii?Q?JfJy+kqxYjwEB5+Efj+EbysfEKFzZXHW5klNawFkI7TsjT4qxJMN3lpS7/cG?=
 =?us-ascii?Q?AHexApPetcefKd/SqtcFXt6F73R10uhUL3v4cmEP1QaB/pzLHjD3XFazu5vJ?=
 =?us-ascii?Q?hnruftH412LRcwh2S2kVmDi7oF9BcdyyKtoZXugschWHxPtKEW9X+itAXez1?=
 =?us-ascii?Q?I6WVvxuZM+ltaOEgTt/g6OvpCG18QEn4vaymPlK9Gu8XOe1Ksb6RTpZAMYrT?=
 =?us-ascii?Q?aJ+SrxSNR+ec1qNi+R2AbB0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B07DD6F543EE2E46B63EECBC3F74E970@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73fa0cb-68d9-4d20-580c-08d9ddcdd522
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 17:37:16.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVKzri32SdvErcPlKzjqmIAlY+x+O8V/rC/553naXSGh5VNYaq9xV6pksaLm2IRVvuLNbZ3CAcBrcpiMVDK8cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3388
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201220125
X-Proofpoint-GUID: hyMtDi-xVH-evGAXj4uqyIF8dY8wm6TM
X-Proofpoint-ORIG-GUID: hyMtDi-xVH-evGAXj4uqyIF8dY8wm6TM
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Some additional comments on v2 below. We need to sort the
NFS_OFFSET_MAX v. OFFSET_MAX issue before you send a v3.


> On Jan 22, 2022, at 7:49 AM, Dan Aloni <dan.aloni@vastdata.com> wrote:
>=20
> Due to change in client 8cfb9015280d ("NFS: Always provide aligned
> buffers to the RPC read layers"), a read of 0xfff is aligned up to
> server rsize of 0x0fff.

scripts/checkpatch.pl will complain about the way you name the
commit here. It will want:

Due to commit 8cfb9015280d ("NFS: Always provide aligned buffers
to the RPC read layers") on the client,=20


> As a result, in a test where the server has a file of size
> 0x7fffffffffffffff, and the client tries to read from the offset
> 0x7ffffffffffff000, the read causes loff_t overflow in the server and it
> returns an NFS code of EINVAL to the client. The client as a result
> indefinitely retries the request.
>=20
> This fixes the issue at server side by trimming reads past
> NFS_OFFSET_MAX. It also adds a missing check for out of bound offset
> in NFSv3.

RFC 1813 section 3.3.6 does say this:

>>       It is possible for the server to return fewer than count
>>       bytes of data. If the server returns less than the count
>>       requested and eof set to FALSE, the client should issue
>>       another READ to get the remaining data. A server may
>>       return less data than requested under several
>>       circumstances. The file may have been truncated by another
>>       client or perhaps on the server itself, changing the file
>>       size from what the requesting client believes to be the
>>       case. This would reduce the actual amount of data
>>       available to the client. It is possible that the server
>>       may back off the transfer size and reduce the read request
>>       return. Server resource exhaustion may also occur
>>       necessitating a smaller read return.

Similar language in RFC 8881 section 18.22.4:

>>    If the server returns a "short read" (i.e., fewer data than requested
>>    and eof is set to FALSE), the client should send another READ to get
>>    the remaining data.  A server may return less data than requested
>>    under several circumstances.  The file may have been truncated by
>>    another client or perhaps on the server itself, changing the file
>>    size from what the requesting client believes to be the case.  This
>>    would reduce the actual amount of data available to the client.  It
>>    is possible that the server reduce the transfer size and so return a
>>    short read result.  Server resource exhaustion may also occur in a
>>    short read.

So the server could be returning INVAL and leaving EOF set
to false. That might be triggering the client to retry the
READ. Does the server need to set the EOF flag if the READ
arguments cross the limit of the range that the server can
return? Does the client need to check for this case and
stop retrying? The specs aren't particularly clear on this
matter.


> Fixes: 8cfb9015280d ("NFS: Always provide aligned buffers to the RPC read=
 layers")

It's arguable that you are fixing 8cfb9015280d. I don't
think that commit is actually broken.

Also, the server behavior is wrong even before that commit,
and that commit is a client change... Mentioning this commit
at the top of the patch description is fine, since that is
how you discovered the problem, but I'd prefer if you drop
this line.

The patch does warrant a Cc: stable, though.


> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> ---
> fs/nfsd/nfs4proc.c |  3 +++
> fs/nfsd/vfs.c      | 11 +++++++++++
> 2 files changed, 14 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 486c5dba4b65..3b1e395a93b6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -788,6 +788,9 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> 	trace_nfsd_read_start(rqstp, &cstate->current_fh,
> 			      read->rd_offset, read->rd_length);
>=20
> +	if (unlikely(read->rd_offset + read->rd_length > NFS_OFFSET_MAX))
> +		read->rd_length =3D NFS_OFFSET_MAX - read->rd_offset;
> +

rd_offset is range-checked before the trace point, so I think
this check needs to go before the trace point as well. That
way the adjusted argument values are recorded.

And we need to verify whether NFS_OFFSET_MAX is the correct
constant for this check.


> 	/*
> 	 * If we do a zero copy read, then a client will see read data
> 	 * that reflects the state of the file *after* performing the
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 738d564ca4ce..4a209f807466 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1046,6 +1046,16 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 	__be32 err;
>=20
> 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
> +
> +	if (unlikely(offset > NFS_OFFSET_MAX)) {
> +		/* We can return this according to Section 3.3.6 */

RFC 1813 section 3.3.6 says that READ is permitted to return
NFS3ERR_INVAL, but does not mandate that status code in this
particular case (it's provided for general issues similar to
this). So returning INVAL here is an implementation choice.

Thus mentioning the spec here is IMO perhaps misleading, so
I'd like you to drop this comment.


> +		err =3D nfserr_inval;
> +		goto error;
> +	}
> +
> +	if (unlikely(offset + *count > NFS_OFFSET_MAX))
> +		*count =3D NFS_OFFSET_MAX - offset;
> +

Same as above: these range-checks need to go before the trace
point, IMO.


> 	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> 	if (err)
> 		return err;
> @@ -1058,6 +1068,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>=20
> 	nfsd_file_put(nf);
>=20
> +error:
> 	trace_nfsd_read_done(rqstp, fhp, offset, *count);
>=20
> 	return err;
> --=20
> 2.23.0


--
Chuck Lever



