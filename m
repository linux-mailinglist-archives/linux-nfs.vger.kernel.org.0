Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5F747B0CF
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 17:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhLTQCI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 11:02:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20058 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238041AbhLTQCH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 11:02:07 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BKED75H013036;
        Mon, 20 Dec 2021 16:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mepFl0zv40v5qmX+PU7Zbx7YnD9de9t+DbqpG6m4Oo8=;
 b=DPQ3jvnXjYPTFrTTGt5tfhrA4ttVIjctX95Qn3Mxxz1faTOVOiy/GYOj7U4jyl6MtBY7
 cqMWAkOto8JOYHiTp0p7I9I4El+8AvLTYlsbi2nPe3uM5jodbEoPQTH1sKrrTFQSqT06
 YRwpfmxoT8Ct3mpmUuUxhtmStQAeMbm6SqyvmNaYpiWkjqRf7dqGPS58khIIsAJ6D5Dd
 Hj4LaSgSyqW/SJpuKAVLsW1P1A+AvUbRPTI42XV7Pom+lIzWbHE46se0uq28N6jYOkKT
 IfUsIkvgRZxIp3rZcn1T4oDVxYMmVDPG52U6MCP+5M33kVmOm/L8EVcs3UQqcMOjVo8Z Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2udc8ajd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 16:02:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BKG0o40053216;
        Mon, 20 Dec 2021 16:02:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3d17f2s3de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 16:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjMo0+T4KLtJ8HAWTdKdpzQc/cBZUXNB80iMsa726ZozCrRxPGfQjGiO6fWbLeSATkgq6+n3ImNwXRVOVU3PeYuiz0EM3QWMMYxiIE0o+u9ke46E/1KFOYKRJUdcPr2Cqqj/fo/6+oDTTYPDz0UBkPkClm+8J2aJ5MaKHdVlkPPK4Q+IaMinn5aWS+2B894gedMhEeDRVhttxDzjN1bUZL9SHptTQ0iaFn7HKkrTORCQw8RtFLpn8A4SNrXgf+on8iz7xVWZXKzTksqqaGwgdz0Kp9z2dz5GJiAroUJ+8Qk61o/rVHSARUjx0kCQCzf3qLF3dKxTJwQycw0FHNpp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mepFl0zv40v5qmX+PU7Zbx7YnD9de9t+DbqpG6m4Oo8=;
 b=QpF0sqryX0SckwMSGyRWlRt7J0Ypv5RA1u+XcMO5kk9X0vBnayDJYsANBLfSFNejai4gF9YzzgBb9Rloj5672RDJUSeJ3ZFkg0/diRWZ8BYEMWnPtjMyIdE18kk3huhnDdd//5HiP9R5gXJAU6DuXdrMMWGQFSS+fFNAQNaaI5BA8jEnieePsqbvICxPZzp6/TNCs0kj7tZeDPewK7Vrh2308x4feUvBn5un/FEPK/1C3kyfpoXLMFTSt+LiujbeRHjNtWhVu/L05Sxj2v9GjZ8tqlCxZlSRapKihwXuF2WUFLc75Z/Mv8hsTy39Pm+lzXCter7NB5zDrqvO2Ti4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mepFl0zv40v5qmX+PU7Zbx7YnD9de9t+DbqpG6m4Oo8=;
 b=g+EOmHzxOtqgawszp8TmeFVerOaW0IAOKWi9qivU2RvkQXxn+zMmLufeE27UVz0Ph/aFyzX+QmeeAQP8w6zoqkafwgaz/YWa7lIeR77lUHUWa/0L2cVEgx2BSvY+qLkZJ6WWazRh/l4L4vZf9hS+kjyZ9QJBbysxGaiLhaKrIqs=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5305.namprd10.prod.outlook.com (2603:10b6:610:d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 16:02:01 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 16:02:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH v2 04/10] nfsd: Distinguish between required and optional
 NFSv3 post-op attributes
Thread-Topic: [PATCH v2 04/10] nfsd: Distinguish between required and optional
 NFSv3 post-op attributes
Thread-Index: AQHX9HoHis+nI73XsEy3XV75+2rrG6w6QAKAgAAQW4CAATyGAA==
Date:   Mon, 20 Dec 2021 16:02:00 +0000
Message-ID: <D5FE6A62-DFE6-4C03-A9A0-E9E8A598C294@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <B6B9027D-D7EB-4324-9C26-9FDADCCCEFCC@oracle.com>
 <6adbcc44f48cdb0a6a96ed488d5a1959c09e13cd.camel@hammerspace.com>
In-Reply-To: <6adbcc44f48cdb0a6a96ed488d5a1959c09e13cd.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 973ed3ed-a36c-47c1-5c47-08d9c3d20ee6
x-ms-traffictypediagnostic: CH0PR10MB5305:EE_
x-microsoft-antispam-prvs: <CH0PR10MB53053F31CBF536D63E1BC952937B9@CH0PR10MB5305.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2nhR4ZVsjZBO5WaMMl8e++LeaySgW6Qmo3vQ+xoUMNKsuSZZ/su0esiLhusbWBoyzKwyKJhMKU57XtczS0MOIR/m/8fAnfvAM8T1abW3ls4puf0rlcZyd/2Sca52c4h6UaZnKfa6vGAVZ0DqsndsXsnpLWqT9fUYYWQdsLx/6uazt3iLRbKzwcELGkIv8Ute0f/Jo6AiSxHhMM++Fs5f1+TsmGNwUxew6hkgY521L9k8jut5BM20owpT+mJpdPag75p2rDZSSAYp+AW8UvjXrShYaji8VoYAcG1oO7VbmH4zP7szFSnON7U/wlW53s4Nqc+S0OTlhu1sIXVXP1GoVp160kRhaLRbdPUC0/YxwF8dd4jK3kKVt3U3XyscWUUXRdkWVc5CbW5jm79RYfvBi77+futN6KNxucvsvmtkOpkUaD4rdEphgbwE1zI0GujAui9/5BhK4r8rOLKnlctXaSUY+UeTiVL9tUZCCE9DboouBZ4S0eWbGW8w5sCLsie1JfAwe2aFT44omFX06Qjs9uiNcND1TIcfZthX3LwX1Km58kgwCbma+ERolxzSMnWchCMgAgOOxXW071RGVXv0DQ5Jx/LAX4VDNW6mCO+cbEVkkWwEFq534xqZPIdR0CS0EhoBySs8JMcUcYPZR8QLc5WF//E2MvbtCcNu2VgPj7uj7uRH46pV5Jez5+TTLdcB8SjpenhoQmHNlNw5SdkXfacbIMJvTEHpdX3zW23pLaRxG44//VoLQ4Qa2kOZoiI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(2906002)(122000001)(38100700002)(6916009)(36756003)(4001150100001)(2616005)(38070700005)(86362001)(83380400001)(5660300002)(54906003)(6486002)(4326008)(71200400001)(186003)(8676002)(8936002)(26005)(316002)(66556008)(66476007)(53546011)(6506007)(66446008)(6512007)(66946007)(76116006)(508600001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T5VSjTHTLNqkNwwci03QpMDC1il9qbLN97+VayLt+HcE1t+Z3xPuZtauzDVo?=
 =?us-ascii?Q?NrkxiRkJhROtHH0dEwlg53Vjn3zKelLvpBEUTDYt4lqJfaMtnGRk893c7PE+?=
 =?us-ascii?Q?+iP9jId6ESE/Ht4yhHvCnnesarf3WHHu6sfwsclgtVZsnTmoszpMhiiTOT8h?=
 =?us-ascii?Q?xns7W8MeKUKAxTCIXxwZFz5SaRNRtAfrj8qbV3jhe3Rz88MSsrAHm3PPJjvQ?=
 =?us-ascii?Q?hpj5MUzBSBb3ZXokYZsC1ODN7EmOKmsmYlRt6b4AkWe51g5K9mxjZCn391YG?=
 =?us-ascii?Q?jASeog9HF3Gs1Mf9RnUX+i7ZU59N/epy5hTdJfFaPPExsxmgYlyDuDTgliw1?=
 =?us-ascii?Q?BC7AB0cZwBo7i5e7bf28nBKWHYmNL7BZdoluNu4tsPybi+G4cUqVNsPi6iWM?=
 =?us-ascii?Q?/bSCd18XiP4NsB/xIojG2h+zvxSPnfaTaUmsHRk006P8lvMjTpgHU5y+rH7C?=
 =?us-ascii?Q?BZOarr91IBuEBu6WvraL2QCxNAonF82woMBMKcxiJHME118ln7BWbfoscbUT?=
 =?us-ascii?Q?eVON/U5sgbeiTwz0ufKyXB/RPsr/PnYGAdQjYwAWoBbfQ45uCPWnDHznn+Mu?=
 =?us-ascii?Q?p8+GU45+crxLRLUMzlSHfXGmeBqBqMgpU73ZsxTwl32cWXKaNJG4+Z86w2Wx?=
 =?us-ascii?Q?NomSokYvVAcKtTrosYeBhKkswiP1u9mB29xgK1p8evdWkzsQ4frbyDbtb9/r?=
 =?us-ascii?Q?uqIbJnojFrKWavw/rN4C0hmFINbkWgZT42Ck9pp0t5DV2sG05q98aQbJcAJh?=
 =?us-ascii?Q?1g5lul44Yo6lKLi5khpMpVYsBGOs7TF2aypO95jKoKOHhH9Ee+1z5KEsQsO6?=
 =?us-ascii?Q?CNQwpFHZRbtBrs7hIOQF9G0IzKYdUsQhBvFQhEE9J16ovvNaLu8n8P0DFyBK?=
 =?us-ascii?Q?GmLD2hCLChLQYcjGRk0lwv6tMokYskvYesUEqtVHiJsTa2XauZXTNwpuSqwI?=
 =?us-ascii?Q?19baiuCbiII0xKRjw+QsswykhQBNwfX5FBfsMo5xydpxoTg6tXcJyfCzP6Y4?=
 =?us-ascii?Q?U1TqPMO4Rj1lLOqVUZoPjmTmIVgUsntQeJFJjm1FHv0jnx+0yofNhGUn+LVY?=
 =?us-ascii?Q?5oxAn2lNzHxu+djDGy6xwLtxgSHb+szv868+XBC+YXVhLppl5cdAhIPcoupX?=
 =?us-ascii?Q?7L4FrICXAOUTJRcqTtuk8H55XpEGm2TKKkOzyE0c61G4HwZIOzpQC2YCPHBR?=
 =?us-ascii?Q?e4a1t2dMmPGceBYQFfcqwVsW8Wzms8XEl/17rpLFfFgVzKrPyp6a0pA0/PeL?=
 =?us-ascii?Q?QE9rV8WAoCjVnIpIAC0EbPqDXX07cdWZ25zoVrGfrzZ0HA5krMBXVhwKm4TB?=
 =?us-ascii?Q?4BWQUI8SxJ5nCqVdoXiuHEo0TtqGIO8lA1BOCR5otU9VXCt9sgAjJ35MCqZy?=
 =?us-ascii?Q?+b5piaMle2TkYO7UleUpyla8g8HsMynrggKKlfZjGGZ9ckZiinZFV3ChBxum?=
 =?us-ascii?Q?XOXeD0DH05gV0v5nySlB94sX9fet6tBu5CIFv4G5N45xot5UiNoz1WuRLKOC?=
 =?us-ascii?Q?fxKkYDiHMJb3cM/FYNOFTkvnvJ3fzDI01nzGkWCvXU3Sbm9DPJbWC6ONuQ/j?=
 =?us-ascii?Q?05gS9BKcIl0og90GYrLcDPEDlYLRm7JSShfVe0LzMPAangl88DdOdNM5z041?=
 =?us-ascii?Q?Etx6co4sLpNEC/QVCr+JgYo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7FBDAA6CA9AC240BCAB1F00F50450B1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973ed3ed-a36c-47c1-5c47-08d9c3d20ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 16:02:00.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qKE64597yiOn5htvp09ejNH8Z+TzFkSw2yH8MezG58aAZkUVnWGBAlOlTP1B3ubo+5RjQT8mnZx8cdjTW5O4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5305
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10203 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200092
X-Proofpoint-ORIG-GUID: OWEytF51854ExHsdWtedeBoyRDXjSlce
X-Proofpoint-GUID: OWEytF51854ExHsdWtedeBoyRDXjSlce
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 19, 2021, at 4:09 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sun, 2021-12-19 at 20:10 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Dec 18, 2021, at 8:37 PM, trondmy@kernel.org wrote:
>>>=20
>>> From: Trond Myklebust <trond.myklebust@primarydata.com>
>>>=20
>>> The fhp->fh_no_wcc flag is automatically set in
>>> nfsd_set_fh_dentry()
>>> when the EXPORT_OP_NOWCC flag is set. In
>>> svcxdr_encode_post_op_attr(),
>>> this then causes nfsd to skip returning the post-op attributes.
>>>=20
>>> The problem is that some of these post-op attributes are not really
>>> optional. In particular, we do want LOOKUP to always return post-op
>>> attributes for the file that is being looked up.
>>>=20
>>> The solution is therefore to explicitly label the attributes that
>>> we can
>>> safely opt out from, and only apply the 'fhp->fh_no_wcc' test in
>>> that
>>> case.
>>>=20
>>> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
>>> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> fs/nfsd/nfs3xdr.c | 77 +++++++++++++++++++++++++++++++-------------
>>> ---
>>> 1 file changed, 51 insertions(+), 26 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
>>> index c3ac1b6aa3aa..6adfc40722fa 100644
>>> --- a/fs/nfsd/nfs3xdr.c
>>> +++ b/fs/nfsd/nfs3xdr.c
>>> @@ -415,19 +415,9 @@ svcxdr_encode_pre_op_attr(struct xdr_stream
>>> *xdr, const struct svc_fh *fhp)
>>>         return svcxdr_encode_wcc_attr(xdr, fhp);
>>> }
>>>=20
>>> -/**
>>> - * svcxdr_encode_post_op_attr - Encode NFSv3 post-op attributes
>>> - * @rqstp: Context of a completed RPC transaction
>>> - * @xdr: XDR stream
>>> - * @fhp: File handle to encode
>>> - *
>>> - * Return values:
>>> - *   %false: Send buffer space was exhausted
>>> - *   %true: Success
>>> - */
>>> -bool
>>> -svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct
>>> xdr_stream *xdr,
>>> -                          const struct svc_fh *fhp)
>>> +static bool
>>> +__svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct
>>> xdr_stream *xdr,
>>> +                            const struct svc_fh *fhp, bool force)
>>> {
>>>         struct dentry *dentry =3D fhp->fh_dentry;
>>>         struct kstat stat;
>>> @@ -437,7 +427,7 @@ svcxdr_encode_post_op_attr(struct svc_rqst
>>> *rqstp, struct xdr_stream *xdr,
>>>          * stale file handle. In this case, no attributes are
>>>          * returned.
>>>          */
>>> -       if (fhp->fh_no_wcc || !dentry ||
>>> !d_really_is_positive(dentry))
>>> +       if (!force || !dentry || !d_really_is_positive(dentry))
>>>                 goto no_post_op_attrs;
>>>         if (fh_getattr(fhp, &stat) !=3D nfs_ok)
>>>                 goto no_post_op_attrs;
>>> @@ -454,6 +444,31 @@ svcxdr_encode_post_op_attr(struct svc_rqst
>>> *rqstp, struct xdr_stream *xdr,
>>>         return xdr_stream_encode_item_absent(xdr) > 0;
>>> }
>>>=20
>>> +/**
>>> + * svcxdr_encode_post_op_attr - Encode NFSv3 post-op attributes
>>> + * @rqstp: Context of a completed RPC transaction
>>> + * @xdr: XDR stream
>>> + * @fhp: File handle to encode
>>> + *
>>> + * Return values:
>>> + *   %false: Send buffer space was exhausted
>>> + *   %true: Success
>>> + */
>>> +bool
>>> +svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct
>>> xdr_stream *xdr,
>>> +                          const struct svc_fh *fhp)
>>> +{
>>> +       return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, true);
>>> +}
>>> +
>>> +static bool
>>> +svcxdr_encode_post_op_attr_opportunistic(struct svc_rqst *rqstp,
>>> +                                        struct xdr_stream *xdr,
>>> +                                        const struct svc_fh *fhp)
>>> +{
>>> +       return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, !fhp-
>>>> fh_no_wcc);
>>> +}
>>> +
>>=20
>> Thanks for splitting this out: the "why" is much clearer.
>>=20
>> Wouldn't it be simpler to explicitly set fh_no_wcc to false
>> in each of the cases where you want to ensure the server
>> emits WCC? And perhaps that should be done in nfs3proc.c
>> instead of in nfs3xdr.c.
>>=20
>=20
> It can't be done in nfs3proc.c, and toggling the value of fh_no_wcc is
> a lot more cumbersome than this approach.
>=20
> The current code is broken for NFSv3 exports because it is unable to
> distinguish between what is and isn't mandatory to return for in the
> same NFS operation. That's the problem this patch fixes.

That suggests that a Fixes: tag is appropriate. Can you recommend one?


> LOOKUP has to return the attributes for the object being looked up in
> order to be useful. If the attributes are not up to date then we should
> ask the NFS client that is being re-exported to go to the server to
> revalidate its attributes.
> The same is not true of the directory post-op attributes. LOOKUP does
> not even change the contents of the directory, and so while it is
> beneficial to have the NFS client return those attributes if they are
> up to date, forcing it to go to the server to retrieve them is less
> than optimal for system performance.

I get all that, but I don't see how this is cumbersome at all:

 82 static __be32
 83 nfsd3_proc_lookup(struct svc_rqst *rqstp)
 84 {
...
 96         resp->status =3D nfsd_lookup(rqstp, &resp->dirfh,
 97                                    argp->name, argp->len,
 98                                    &resp->fh);
    +       resp->fh.fh_no_wcc =3D false;
 99         return rpc_success;
100 }

Then in 5/10, pass !fhp->fh_no_wcc to nfsd_getattr().


>>> /*
>>>  * Encode weak cache consistency data
>>>  */
>>> @@ -481,7 +496,7 @@ svcxdr_encode_wcc_data(struct svc_rqst *rqstp,
>>> struct xdr_stream *xdr,
>>> neither:
>>>         if (xdr_stream_encode_item_absent(xdr) < 0)
>>>                 return false;
>>> -       if (!svcxdr_encode_post_op_attr(rqstp, xdr, fhp))
>>> +       if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> fhp))
>>>                 return false;
>>>=20
>>>         return true;
>>> @@ -854,11 +869,13 @@ nfs3svc_encode_lookupres(struct svc_rqst
>>> *rqstp, struct xdr_stream *xdr)
>>>                         return false;
>>>                 if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> fh))
>>>                         return false;
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> dirfh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->dirfh))
>>>                         return false;
>>>                 break;
>>>         default:
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> dirfh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->dirfh))
>>>                         return false;
>>>         }
>>>=20
>>> @@ -875,13 +892,15 @@ nfs3svc_encode_accessres(struct svc_rqst
>>> *rqstp, struct xdr_stream *xdr)
>>>                 return false;
>>>         switch (resp->status) {
>>>         case nfs_ok:
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> fh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->fh))
>>>                         return false;
>>>                 if (xdr_stream_encode_u32(xdr, resp->access) < 0)
>>>                         return false;
>>>                 break;
>>>         default:
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> fh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->fh))
>>>                         return false;
>>>         }
>>>=20
>>> @@ -899,7 +918,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst
>>> *rqstp, struct xdr_stream *xdr)
>>>                 return false;
>>>         switch (resp->status) {
>>>         case nfs_ok:
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> fh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->fh))
>>>                         return false;
>>>                 if (xdr_stream_encode_u32(xdr, resp->len) < 0)
>>>                         return false;
>>> @@ -908,7 +928,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst
>>> *rqstp, struct xdr_stream *xdr)
>>>                         return false;
>>>                 break;
>>>         default:
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> fh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->fh))
>>>                         return false;
>>>         }
>>>=20
>>> @@ -926,7 +947,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp,
>>> struct xdr_stream *xdr)
>>>                 return false;
>>>         switch (resp->status) {
>>>         case nfs_ok:
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> fh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->fh))
>>>                         return false;
>>>                 if (xdr_stream_encode_u32(xdr, resp->count) < 0)
>>>                         return false;
>>> @@ -940,7 +962,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp,
>>> struct xdr_stream *xdr)
>>>                         return false;
>>>                 break;
>>>         default:
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> fh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->fh))
>>>                         return false;
>>>         }
>>>=20
>>> @@ -1032,7 +1055,8 @@ nfs3svc_encode_readdirres(struct svc_rqst
>>> *rqstp, struct xdr_stream *xdr)
>>>                 return false;
>>>         switch (resp->status) {
>>>         case nfs_ok:
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> fh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->fh))
>>>                         return false;
>>>                 if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
>>>                         return false;
>>> @@ -1044,7 +1068,8 @@ nfs3svc_encode_readdirres(struct svc_rqst
>>> *rqstp, struct xdr_stream *xdr)
>>>                         return false;
>>>                 break;
>>>         default:
>>> -               if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp-
>>>> fh))
>>> +               if
>>> (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
>>> +                                                           =20
>>> &resp->fh))
>>>                         return false;
>>>         }
>>>=20
>>> @@ -1188,7 +1213,7 @@ svcxdr_encode_entry3_plus(struct
>>> nfsd3_readdirres *resp, const char *name,
>>>         if (compose_entry_fh(resp, fhp, name, namlen, ino) !=3D
>>> nfs_ok)
>>>                 goto out_noattrs;
>>>=20
>>> -       if (!svcxdr_encode_post_op_attr(resp->rqstp, xdr, fhp))
>>> +       if (!svcxdr_encode_post_op_attr_opportunistic(resp->rqstp,
>>> xdr, fhp))
>>>                 goto out;
>>>         if (!svcxdr_encode_post_op_fh3(xdr, fhp))
>>>                 goto out;
>>> --=20
>>> 2.33.1
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

--
Chuck Lever



