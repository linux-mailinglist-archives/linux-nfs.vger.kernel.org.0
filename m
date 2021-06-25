Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24583B4944
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jun 2021 21:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFYTko (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Jun 2021 15:40:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4884 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhFYTkn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Jun 2021 15:40:43 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PJa5mI022107;
        Fri, 25 Jun 2021 19:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0IY22JrEOFZlobuhTEkVhwRFvtFheY++fOUOZQEfohk=;
 b=SY9qR4vA6kddlfFvGImhVlhMtlnUbT5iXv9OXuYTH3DmCHiJSSvwOrp9F4+J+6Vfzz6g
 w57MNFD0jq7pPGKLBmV/rZURFESo9Nhtzc+fOnND60iOuza5l3fx/sarW9ftUB2zGHkO
 0bvEnDesquEmvnElt1XjQ4rtt0pAyeduJDBhh9aoyO4FB1MMPTe3mgGh75Zs/n6ISOr0
 HHbAZU+sojJ8CvIBchIMThUKw3Q+pJknv7oPtiYxfIw1na+aNILcAUGGP1f0eheUzKtG
 i3spQeeqI5TAjYzr7//Z2TcGEEhQddMSrhoxyBd8mTWrKAEE4qXdyn5EZWvcXvfGVHGR MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2kxt2g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 19:38:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PJZQbr067237;
        Fri, 25 Jun 2021 19:38:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 39dbb1wffv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 19:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgACUZoFX7WWgXGMnnrZcMLvZikVUK2Eveb1XvhMmfCaBbdHwsjCrwkv+5gJn8qS3hiCuxp5BIwvAAxX1ZaFDIXxTXQU6koXVXPqg2hYKWRcWO2gtz7TulpvuHSoA9unwvv6usRrlrlcYxBo41bEdx6bWFscJZyBE9eixSV/3cbQmETkzdooTFcWFmGfcN2GQLkfWj1AvVXhXREpmmyQnkIR8+oFug42pRr9AwksVRo3TPDbniPbXP5+tM0rNnA5Fv4hUvBB+cXomDvEm3f1aMblOoGxTx7ezfqK0um1Tehbt1l16FtIXyswB1wYVxpxCRxZFqlxvIN+SIQeQq7xfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IY22JrEOFZlobuhTEkVhwRFvtFheY++fOUOZQEfohk=;
 b=WirhfmKDj3dp5bWWD9Cys+pRyiITCpbJVnpWhMR4zNOdCQ4rzsVA6AlgvOmTnYFrj42xMWYZEEdpMp0lPE9elZguDqsceuwSwT/7Y0/PeKZzou6pDsv7UzaJ8fz4pNEdBX6bf6yDibjDpJd4+i/U5HSQGYuH/fdECHyObLiAO5VurHTlhxaCTnjpKjzaPAlTEDm2zEwLRdRZADO60txWom+1Mqm5RHVGaGSGC19wb6Wjh7rOLBQRifUatT8P1NsEaJmWKeCBffL2kqqjO9y1qZcg+OsgMznDC+MtwqsZZ7RL2gB4mqD60sYZP4xZNJgRI+UXQOQZ7Z1iUBAijD0yrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IY22JrEOFZlobuhTEkVhwRFvtFheY++fOUOZQEfohk=;
 b=IWwx3jDzphL3RGIDl9YTvebR9qg8G/lf0uRIvWu1TA/PnOZdsecJxkVqskCpHRphQN3PKg5Wi8Ju+dmTrr1ZYSVmAO+1CtrwxDJXyER1kNyDSCAKe0F5DPARZNul8AT15yjIgbgZTARY6+yzlt6AiN7E1zQPhR/QzwPSIHyH/eU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2487.namprd10.prod.outlook.com (2603:10b6:a02:b0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Fri, 25 Jun
 2021 19:38:15 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 19:38:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Prevent a possible oops in the nfs_dirent()
 tracepoint
Thread-Topic: [PATCH] NFSD: Prevent a possible oops in the nfs_dirent()
 tracepoint
Thread-Index: AQHXadSUyWoIP0jByEW2b8M2eLEYFKsk6oUAgAAbGYCAAA6SAIAAC20A
Date:   Fri, 25 Jun 2021 19:38:15 +0000
Message-ID: <17A20C3E-4711-44C9-BB50-E4B3B0866D4A@oracle.com>
References: <162463396907.1820.8112792283525036426.stgit@klimt.1015granger.net>
 <b71c76c0fb21ebb35e1f91864bbb411a4c895370.camel@hammerspace.com>
 <FB070B1F-FF5C-43B5-AFC2-0DC6B9348AC6@oracle.com>
 <951807a3b7f8870951bd2bc4ef5a1f4f0e50fc25.camel@hammerspace.com>
In-Reply-To: <951807a3b7f8870951bd2bc4ef5a1f4f0e50fc25.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab0dd04-cf70-4812-8018-08d93810c6ec
x-ms-traffictypediagnostic: BYAPR10MB2487:
x-microsoft-antispam-prvs: <BYAPR10MB24873CADF707EBCC991E3EFD93069@BYAPR10MB2487.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7HddGk5vKAYHFnuT5REzHcd6h5OHjvZP3RanwPz7oUEU3Ya3LsXX7SEu8K3DbuyyrjrA+jZhWXQs89dc0ZtEgL3dFzND/0ii9rvpCxuns1bIWhmQyyfBWvkm2gAKYaLXBOsykjT3xgFl+Z9Oy4Gclw2JxVMzzy/JL6F2+FjOWtCObuGG/Cc1SIvIAIfedsaLG0YX8mA9DNMx+z7Jr0hyygL/OrZeJYjYBCY7IJFDku7WzrqBsqgUORfPpSvHB29wSolK/Ev3wx07uL5CC5XX8SQByZDeowvWP6626M/fPMSnFHNnlns8Sk+tt7S9II5Dk7SsXAjwl5GEU08n2qxZRYxZ0olLlr/hym5sKhJMlzb7FSkc+arGVJuPi7ragC2Kcd0r+rG0oocCY4ueaUR5jsF5K9pjbMG0vfpayFgfo4UnfeZWwnBH7dUBUIq1fBcjNDNoay+8sfTXd7AWcYFuWJ7K26jakRZUy5sHvJBtzOTnN+3KiC88NOkolIDd5Idb3VpRuwJw0EM7g17KvsG+JA3g159h9id0OnwCUWpycB75mzHKkPdihXbeCIdxzLtFjHDCRSCZIcB/LHGtczZ/orAmyJFsFAbFNVZdvDz0tIVAFVZQVm1aKcjXM0tGjhIbHy9aCZ5+NxWm7sqTI3Npnn8ObbJw6rvj9kAfTC94qEIgg8TkmMCeX823ac2mn79mouYXj0CyOUhBavPnE/isg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6916009)(71200400001)(4326008)(66476007)(2616005)(316002)(33656002)(64756008)(36756003)(83380400001)(66556008)(54906003)(8936002)(66946007)(66446008)(76116006)(26005)(8676002)(186003)(38100700002)(122000001)(5660300002)(6506007)(6512007)(2906002)(478600001)(86362001)(53546011)(6486002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?enFqp49YxP6LxxO1NsYeG+wGCXdCGMlA3Szpz+x5sO2ReqvYyPisvmSTAQpR?=
 =?us-ascii?Q?CQZH4IZQLjUdYIH1HGhfaYveu4JmbUpGU0YaTg5sXIV/HfPBn9oLlfYtDevL?=
 =?us-ascii?Q?eoAQx1msRlRHLgqBn7h3KLYmalmhrGf7gPM4Q9N8c8Okw+qqF4IjteFfmk+o?=
 =?us-ascii?Q?7+XAdlMf+qqEWrblksvTYLwV+uky5Ct0ldnk/iH2A5w3S1EcdHwHcTcykKk3?=
 =?us-ascii?Q?z4zVJf/JwXpgbzxAxwCs28MPzdWZ9qWEBVC9my3TcJMRvK0hdWdkFM3YhlFH?=
 =?us-ascii?Q?jY9Q1NiQmRUyO4vFSqWgInam07yhZXpbB7wnYM2xqbrWRfEjo39LXJ55RVEy?=
 =?us-ascii?Q?Zo2ZZ4u0Ss/tJ7E04QHY3WlEv30wI74FfShWZkyVj6vAN2EYNgfTcFxKOqAr?=
 =?us-ascii?Q?53bx1gOqOWf5EWpMAGMzqmkoZv91FhXrV2l6IjjPIcj1WEMiOwFYOpuzaayS?=
 =?us-ascii?Q?dhhtZiMWgq/823GIVssBbGoyZsUbnfkwBEWXiNsEhHRf0blecvLmo1dVWCsC?=
 =?us-ascii?Q?Y8y0ELY3+migSD2ZKbZzgw0E5YJO5buxw+rWN67pyu9ZW32MokGO/WhslmzB?=
 =?us-ascii?Q?PEAgDP96Wta3LPgTs793GI23s/G7LZ7P4Eaa+ys5v/38PAKe1gsi8gmfpAbZ?=
 =?us-ascii?Q?LtKOFt59khKUdz28ek0G+b/yjHwXoJI4u9zwp05DDB9SarJUPLQkRCXbDJHY?=
 =?us-ascii?Q?HsfY23HwrwZB/aq0JDboDzJs0bmYGy9KWea5pSJybRNrz8UCXPuXmxm4kZTL?=
 =?us-ascii?Q?ydg7ymNdFucprx34sBI8gWoKSIQqVYeba2QdPyTH4ScFNUFcEKAyiBcrSqFT?=
 =?us-ascii?Q?uPEQ77Y0JljT81zLTTRQRNNsa3ka6jVJ3a0EySmlmW12uGzSjHb6JHO6osrY?=
 =?us-ascii?Q?f0hNuY6Hz3mnf/mW/AIzrrDRZHvSuW5gxHZ5JSKNb9EdAnLdErDkgc3g/2/d?=
 =?us-ascii?Q?csIVWqbNJb8c2f7wNQZaxQpbXtL4lqsSBxhtI/slVWmp263NXySB5RDDJ0bN?=
 =?us-ascii?Q?OuJhpetMbv5S7cT6AM/T210kS+VesgYm+FgAOVhnuXOrIwSSz/h3Qlcz93ir?=
 =?us-ascii?Q?aNTjX6lzfNpL1LDbGcWdXz7Ep+AQxSRPSkbVMNktZ0A8nd2holGlHjOtupOF?=
 =?us-ascii?Q?Xb+ZbNjZKD5UNMlQ1UOWGEBj6kdUY0MiEfblRYcLjgoBDeIs9TOhH1tgwLR6?=
 =?us-ascii?Q?/iA2d/RTBdpvIeeUX1vAt6SDtSumhTMXnqmLgLlslB2Ti56My3tSIuAaGEwr?=
 =?us-ascii?Q?96eMAWX2Bdw6BndlG91AxvZ0hSd+LiqF/H3QxdbGgGpO5ib6sWJblzYKn8s0?=
 =?us-ascii?Q?wK0GaYpaGYJwQxi+LkZ/QK/m?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C6FBB0C466A1D84FB874B18DF908F497@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab0dd04-cf70-4812-8018-08d93810c6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 19:38:15.6421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49r6F/AHcJjQLLmMnEi2j+M4ICNEvOkWxtoOxWB19LLGYnatWQLH+R+pf9mwS5gMylJGlFeRZnfm1JKpDQKtDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2487
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10026 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250119
X-Proofpoint-GUID: jLvjsNBXbsYpZk11OHBhm6Iabe9di_XE
X-Proofpoint-ORIG-GUID: jLvjsNBXbsYpZk11OHBhm6Iabe9di_XE
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 25, 2021, at 2:57 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2021-06-25 at 18:05 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jun 25, 2021, at 12:28 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Fri, 2021-06-25 at 11:12 -0400, Chuck Lever wrote:
>>>> The double copy of the string is a mistake, plus __assign_str()
>>>> uses strlen(), which is wrong to do on a string that isn't
>>>> guaranteed to be NUL-terminated.
>>>>=20
>>>> Fixes: 6019ce0742ca ("NFSD: Add a tracepoint to record directory
>>>> entry encoding")
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  fs/nfsd/trace.h |    1 -
>>>>  1 file changed, 1 deletion(-)
>>>>=20
>>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>>> index 27a93ebd1d80..89dccced526a 100644
>>>> --- a/fs/nfsd/trace.h
>>>> +++ b/fs/nfsd/trace.h
>>>> @@ -408,7 +408,6 @@ TRACE_EVENT(nfsd_dirent,
>>>>                 __entry->ino =3D ino;
>>>>                 __entry->len =3D namlen;
>>>>                 memcpy(__get_str(name), name, namlen);
>>>> -               __assign_str(name, name);
>>>>         ),
>>>>         TP_printk("fh_hash=3D0x%08x ino=3D%llu name=3D%.*s",
>>>>                 __entry->fh_hash, __entry->ino,
>>>>=20
>>>>=20
>>>=20
>>> Why not just store it as a NUL terminated string and save a few bytes
>>> by getting rid of the integer-sized storage of the length?
>>=20
>> Stephen is adding some helpers to do that in the next merge
>> window. For now, I need to fix this oops, and this is the
>> fastest way to do that.
>=20
>=20
> Won't this suffice?

Yes of course it will. As I said, Stephen has some trace
macros lines up for the next merge window that I would
prefer to use. I will be posting patches that use those
as soon as 5.14-rc1 appears.

For now, a single line fix is needed to prevent an oops
in 5.13.


> 8<---------------------------------------
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 27a93ebd1d80..799168774ccf 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -400,19 +400,17 @@ TRACE_EVENT(nfsd_dirent,
> 	TP_STRUCT__entry(
> 		__field(u32, fh_hash)
> 		__field(u64, ino)
> -		__field(int, len)
> -		__dynamic_array(unsigned char, name, namlen)
> +		__dynamic_array(unsigned char, name, namlen + 1)
> 	),
> 	TP_fast_assign(
> 		__entry->fh_hash =3D fhp ? knfsd_fh_hash(&fhp->fh_handle) : 0;
> 		__entry->ino =3D ino;
> -		__entry->len =3D namlen;
> 		memcpy(__get_str(name), name, namlen);
> -		__assign_str(name, name);
> +		__get_str(name)[namlen] =3D 0;
> 	),
> -	TP_printk("fh_hash=3D0x%08x ino=3D%llu name=3D%.*s",
> +	TP_printk("fh_hash=3D0x%08x ino=3D%llu name=3D%s",
> 		__entry->fh_hash, __entry->ino,
> -		__entry->len, __get_str(name))
> +		__get_str(name))
> )
>=20
> #include "state.h"
>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



