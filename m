Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63F644F57C
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Nov 2021 22:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbhKMVeu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Nov 2021 16:34:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36612 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234306AbhKMVes (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Nov 2021 16:34:48 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ADKoJea015270;
        Sat, 13 Nov 2021 21:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nq1WCMJfo0X4/NN21Jn1InUy4OiFg1+LifQX1ABLOno=;
 b=xSu+Tg1LOHYcdNlurqCT8/vmhjDZbe642hsXRNrOxp8smiDL3ISJ7IUXdGOegCsHsRCy
 011jm3F1z19nu/AnOYSA0Ps0/tnmG/3Vt5jdDdrqTdmxw1HT2t0VBFS/nbZPxN8dGD0S
 RNH3uM49DpENFhKQ4bAhlkIUbBK/a6kx/OXK40ItOhufSSV0S0LP9mWTjldhMe/9KaAf
 AYVD/Yoty7XC0YoMf5c/BMJ+GD5a07yiq8DnU5IfqYH/+2FJm4G6P4tXRHInAptLEoPK
 f0wQqvyeniFoMwwyzOd8pLcSRMxCgklORmikkDcBBFvqAE8CZSSNRQoRevW5PudNo084 aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ca452ss8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Nov 2021 21:31:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ADLGsl8126906;
        Sat, 13 Nov 2021 21:31:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3ca4pkcrw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Nov 2021 21:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvXmHwHyNXK1GwwH3npeQVFYZnH2DR5XuUFPqeAlRIKvUn5/gr74oTgTP2MDlVIH28MTdD9ORBZchUMGe9V5thZCCIpbWUPrfqq27qcqdjufqaE+n4RkEKPkI7K9G0jv3avcWGLpVuz7/2W8ThiJ0y1koKkDt/yB5ecFdFvfSid4gJrjql9x1UsFM3WQOqIAlPbTH2iMGu/D9emSktroiINHbqx5iP/wVjMdlE+h1iRZfG/xKvNqkUYBwJEEh7GAtwAhV5NAj3pQch0ZuTDwmFwh0eiIdFfZ0nqqPDcJhgEvRXnkVB42OG7IcPNPQH+2mU1828vzSaHh2u3Q9CeoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq1WCMJfo0X4/NN21Jn1InUy4OiFg1+LifQX1ABLOno=;
 b=Y0acgWsumTGjs9m74PJi/6ucxaptvXMe0tpOtq5TRVds8lVxJ46KAv6ZJUX7PxRN6kkNhCeHqwMim5wnExUPtjoU8ZyKh/H+4E26Bu2Am6idWRRNaYLU49hT2kbmUqHbcQndpBsoA0+94UtFXJruilxVx/3TlXW5HIjtJJi/uNu/IG3wv9vYLZLiP4N3kdebpv2bYJm//O18YfQnu7slZuhmErqAV/rb63eDO/5zdE076PVpg2Cyl9Gq59TbFSqaTgm2s/x+xnEkKiPngfzfc0WOTFn2wIl1p8IcXPhI24tS89tC+TTYYvjPxY3KD7loyHv9i+JW4UBtOvCijGIKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq1WCMJfo0X4/NN21Jn1InUy4OiFg1+LifQX1ABLOno=;
 b=WMHPqnynNzwJKZRbWhZNLciV4OY26cKP1+A7VMaU3PZCysIh2jLOBhAsfC5m2bh6R0rmbm8gmeZVrrIGf/WVHAlJXDk1SssJEKKoUUpmPCJgjo0L0WTNKQfDQcD/J3dGaaqUxlkXEdhPxy/S4TAZ3duHPVEvs8oW5gvdWTYKm+U=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4036.namprd10.prod.outlook.com (2603:10b6:a03:1b0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Sat, 13 Nov
 2021 21:31:41 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%6]) with mapi id 15.20.4690.019; Sat, 13 Nov 2021
 21:31:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     "rtm@csail.mit.edu" <rtm@csail.mit.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Topic: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Index: AQHX2NFEStLOh5EPHEGsmzKRU+63DKwB8uQAgAAFgQCAAAGpAA==
Date:   Sat, 13 Nov 2021 21:31:40 +0000
Message-ID: <9A3E5D78-AE3C-4F45-8CB1-10F2EDA1D911@oracle.com>
References: <97860.1636837122@crash.local>
 <11B4530A-C0A0-4779-A9BA-F0E19B62C5A6@oracle.com>
 <20211113212544.GA27601@fieldses.org>
In-Reply-To: <20211113212544.GA27601@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0986a9e-6dcb-48c7-3947-08d9a6ecfb6e
x-ms-traffictypediagnostic: BY5PR10MB4036:
x-microsoft-antispam-prvs: <BY5PR10MB4036D4F20A9FAF5F50240E7C93969@BY5PR10MB4036.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXObozz+AuLX5ef7aCuIimuD8fOwp1hABMe/dOrqfpRfk08iS1P5smXbwOCPkaHHX4jassa/zGopQK6d+Ha6f57qkFyvkDTpoJXUtOZ+Dev0rO3xZCUvbxbGDJ5s7XYeJ4B9dVPgoWpyXkm9rNboIiC4ThYDzcrGz24hXsy1OV6pBeLDq8T4k+xDhjn+HB7GkJs0vqZyM/N873em0+pp6IcFBx1DgiDqadmraADEgqjms1elDaJHG04I1BKZpUYPOEHL/irQnuprPjZLvBI+5zyKPR6GeXeLShayKFEQSFcRfjyBF5tG+wVzeF4K477bxJnbducxnA3MSRSGpS3M5rZMvTfqCAtii8+7gWNZWAQsDFKtqeigKodXsb855+H/AZ5ae5nCsZt2nZ9re6RM6VE2KlxV6M0jqI0e95UE1vDPWJ5EYHNunczSEAporoZrlvI8bJCCeI38Bntiutke8n1eCOMOgTd+cwje9DD/iUkD3FKTcsN04jPIo+hkQmK+JxhzLyp7p0rd8HcWHzqCoz6jqmSBDYiSS83dvE3G+vq4u+WDzf1P5bqxT8kno/m8PPw7IT0+Nuzj4kh66v0v4rZgjt41K4OBkJjQaqP9fjSmpHH9nlJHth05SNKS/eJWgySVVwC6KM46k2bwqlHrfWmX6X8BCLAhDT6TB/GYqXbz/xWi0ziijAkOJNkjmzhwtNfcx/5xhkGg+3Rl9YH+uibMek3yWfPyr7/qEMWKcr5ZhAi13IQZRNjFyTYv5PmM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(122000001)(38100700002)(86362001)(508600001)(316002)(66556008)(66476007)(64756008)(38070700005)(5660300002)(33656002)(4326008)(66446008)(2906002)(6486002)(6916009)(71200400001)(186003)(26005)(8936002)(2616005)(8676002)(36756003)(6506007)(53546011)(54906003)(66946007)(76116006)(83380400001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M9mj6vfzOWJmeU5bAEYj26TVn0stRMd6/TdBOKtLAJV8sNFiiiy3Uzh+bqeP?=
 =?us-ascii?Q?PloCp7h6txBXP0COGDvJBJIG2resJWmaVQyFkAQyVZFukndZ29PGe5OZMLjX?=
 =?us-ascii?Q?ZDQB4DwObv1RRRaBm0RskEVKqHCvqIBNguWiXh8hjnI5xhV1nJ6lCwfb25iF?=
 =?us-ascii?Q?oOhbGTMje2lWq/kgJsElY+K+X6PGzelI1NxGukms0lJcCINNSXa92y2HPZld?=
 =?us-ascii?Q?opffdrVOeEgidJYHZFtVOmIHPCUtiBpTfA+cBIbWqAXiwvbjNrGqnhKK8L9N?=
 =?us-ascii?Q?ZGpXUGALyqA/ltdTZiBvUTZR5exbEXFryeBk/7oe1DdeBe0G4L+oBplRHPwx?=
 =?us-ascii?Q?GE4JyU6D7yeRazvQv0NPSuWCvvMLj5aYyN54uyUUWMqY406VvW9gPc0rM7M3?=
 =?us-ascii?Q?1RY9sdLRkjrHbMZHWp5MJjDp/5vcn+ZhEaUPfCkxVd105gAv/Ns5ZRbSYmNS?=
 =?us-ascii?Q?aERWf7nXT++TjNVUDwgdQlXs6+k0uoIgskuAGUjzJbW7FxHE41NHjp/XpfLB?=
 =?us-ascii?Q?J0FAJeVOlcJFD+yJV21C5+JegCuz+R2kX1DSuVlgCVgkyTnFmjnR7kwo8Lre?=
 =?us-ascii?Q?m6gesROSBgb9Fx0EPRSDIl7sQkz6ste3Me0n9aCbHDCmdyaXT5v0s9DoYKux?=
 =?us-ascii?Q?WqSg3G5nZQmtxhteNQDjYIGGc7PhhXPZAFB+zRGPFh4MrCvzPb2J6qPsJysZ?=
 =?us-ascii?Q?SCAQor5NtqMiMC5NqhZfTzPRiRyHq9oiFDRVnSEuQhJflgG7jl7KeYrMSHIP?=
 =?us-ascii?Q?YxTEByI1c5qvFlCqeeEFs1XNw+sJRmJ/aUn9VGyqzZSzXzPhScJQATNOV1gF?=
 =?us-ascii?Q?q07CAg9JWjKUVQcM4U9ZpsVeSlLqmcPSS8j/1fb13RhKhW9QjVdsWuvgV6Wv?=
 =?us-ascii?Q?QwU7pS+t0QN/4dAZx2DEX9s+zYn8onqv1+5nd47sAzuKGRm5rSIVqVMMYYmk?=
 =?us-ascii?Q?ZLsvDnzdttygI+D0MUFisaMPS6X7my1wqFeJ3IYExlPHuPGfHKSb5D1k71Fn?=
 =?us-ascii?Q?48avY3r06Cy3I4BVrr8PptszXwVwhNw8hSJsnGloroGLX0lj8OuXoU+1jEwF?=
 =?us-ascii?Q?NHyHFk4G8yx47WMyELbsICvO0vLNKYB2KDs4fBG0uO4P7l1xVi980sHprA5O?=
 =?us-ascii?Q?xeZ3Sr+V2sti1qMGMEk1pXCprFztegMLlJkqOkvMk96zGaURg/bxOwSXOuNg?=
 =?us-ascii?Q?3VqWD5dabS1vVPWtVTvpD9kxwwbmEiwg7r5a+p68BrSnvfYGCcE1qYR1Ll9T?=
 =?us-ascii?Q?LVCuLk4k5RXjV41HrumnqhfR56USoN3EekiBg88Qbky72auvDIIWs2E43/U9?=
 =?us-ascii?Q?CWVjCTruxGqOYvx5f1oFmuX9uJBHo3SjY7K4IJkHfqK5jETECLjAldjYaG7w?=
 =?us-ascii?Q?SeYmvDBNMH3JwjSuANzbsTOqCD3E9VOzGjIIfF2/Vyb9GQ8U8MPme3F3+EUj?=
 =?us-ascii?Q?K7+H1wSLdHKgPbmYQZeK+NFoPSyEtUGE1TvckuTcc0lGlNwdMUgkIcqaujF+?=
 =?us-ascii?Q?QxHlrhvEn2fqIcA1uat+ASxY71DZB/PZ38J1/Z7uPVtiYl9HKol4GagUoZAW?=
 =?us-ascii?Q?Mr+FWup3W1889CI1OHOrxWlvqmlvXiMcVycBhqI/b+VFbIsbo/0gu/HgMPZ+?=
 =?us-ascii?Q?i/Dupi/TgjLvJiQkw36MqVs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E4530E78470B648A45BA600F19833A1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0986a9e-6dcb-48c7-3947-08d9a6ecfb6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2021 21:31:40.9447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPemRyrnN58fCkaRbDONnw+bXnzYlLY8khkBpCF6EsXDDqMbEKpiOQFupxwcmTU8e2GdzToNl1zU2ql4ZCprdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4036
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111130130
X-Proofpoint-GUID: cpdBjeGwkly3NQYqXIKgpagKwKChFij6
X-Proofpoint-ORIG-GUID: cpdBjeGwkly3NQYqXIKgpagKwKChFij6
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 13, 2021, at 4:25 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Sat, Nov 13, 2021 at 09:06:03PM +0000, Chuck Lever III wrote:
>>=20
>>> On Nov 13, 2021, at 3:58 PM, rtm@csail.mit.edu wrote:
>>>=20
>>> nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
>>> directs it to do so. This can cause nfsd4_decode_state_protect4_a() to
>>> write client-supplied data beyond the end of
>>> nfsd4_exchange_id.spo_must_allow[] when called by
>>> nfsd4_decode_exchange_id().
>>=20
>> Thanks, I'll look into addressing this for v5.16-rc.
>>=20
>> By the way, can you tell if this exposure was in the code
>> before 2548aa784d76 ("NFSD: Add a separate decoder to handle
>> state_protect_ops") ? (ie, do we need a separate fix for
>> this for pre-5.11 NFSD -- I'm guessing no).
>=20
> It may not have been an EXCHANGE_ID problem, but:
>=20
>> Is the current implementation of nfsd4_decode_bitmap() a
>> problem for its other consumers?
>=20
> Yeah, I don't see that there's anything a caller could do that would
> prevent it, so the problem starts with the introduction of
> nfsd4_decode_bitmap4.
>=20
> Not actually tested, but I suppose we want the following.
>=20
> --b.
>=20
> commit 8211c4817cc0
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Sat Nov 13 16:11:58 2021 -0500
>=20
>    nfsd: fix overrun in nfsd4_decode_bitmap4
>=20
>    rtm says: "nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if
>    the RPC directs it to do so. This can cause
>    nfsd4_decode_state_protect4_a() to write client-supplied data beyond t=
he
>    end of nfsd4_exchange_id.spo_must_allow[] when called by
>    nfsd4_decode_exchange_id()."
>=20
>    Reported-by: <rtm@csail.mit.edu>
>    Cc: stable@vger.kernel.org
>    Fixes: d1c263a031e8 "NFSD: Replace READ* macros in nfsd4_decode_fattr(=
)"
>    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 9b609aac47e1..7aa97c09b5a9 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -282,8 +282,7 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp,=
 u32 *bmval, u32 bmlen)
>=20
> 	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
> 		return nfserr_bad_xdr;
> -	/* request sanity */
> -	if (count > 1000)
> +	if (count > bmlen)

Sure, but that's more restrictive than what the old decoder
did. I have this instead (also yet to be tested):

    NFSD: Fix exposure in nfsd4_decode_bitmap()
   =20
    rtm@csail.mit.edu reports:
    > nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
    > directs it to do so. This can cause nfsd4_decode_state_protect4_a()
    > to write client-supplied data beyond the end of
    > nfsd4_exchange_id.spo_must_allow[] when called by
    > nfsd4_decode_exchange_id().
   =20
    Rewrite the loops so nfsd4_decode_bitmap() cannot iterate beyond
    @bmlen.
   =20
    Reported by: <rtm@csail.mit.edu>
    Fixes: d1c263a031e8 ("NFSD: Replace READ* macros in nfsd4_decode_fattr(=
)")
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 10883e6d80ac..c2f753233fcf 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -288,12 +288,8 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, =
u32 *bmval, u32 bmlen)
        p =3D xdr_inline_decode(argp->xdr, count << 2);
        if (!p)
                return nfserr_bad_xdr;
-       i =3D 0;
-       while (i < count)
-               bmval[i++] =3D be32_to_cpup(p++);
-       while (i < bmlen)
-               bmval[i++] =3D 0;
-
+       for (i =3D 0; i < bmlen; i++)
+               bmval[i] =3D (i < count) ? be32_to_cpup(p++) : 0;
        return nfs_ok;
 }

This allows the client to send bitmaps larger than bmval[],
as the old decoder did, and ensures that decode_bitmap()
cannot write farther than @bmlen into the bmval array.


> 		return nfserr_bad_xdr;
> 	p =3D xdr_inline_decode(argp->xdr, count << 2);
> 	if (!p)

--
Chuck Lever



