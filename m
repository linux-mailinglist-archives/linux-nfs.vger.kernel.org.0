Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96D235B622
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Apr 2021 18:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhDKQnn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Apr 2021 12:43:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45832 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbhDKQnn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Apr 2021 12:43:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13BGdvTx030923;
        Sun, 11 Apr 2021 16:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xz2UgIrrYDpisz19vG+RoWKQJH1RxcXyZjNvJ2Ju+ew=;
 b=e3gLs8puA8ttRamXzd94W9+0G52Jo6DpnlyGLwfAUE+acZfBXNmYPwgwUbJQO900GaVJ
 Wd4QhXsF/n1UapyrdvxFX516SrxIH/5a6tb4ssF5FAHBS2hR3jOcuY/8pbf9Ibr4ktFt
 a3st+rywwojUsuqGJmbYTipr/uL9t1RaX69MkeZBSEfsqlxF6VPYrmmyrqvuRVo3ScMU
 sA/JGFH7fjLIqvrBVeiiFiXzmNGSGFzcH9cTLNJjHHJHV7rodZXnWkkpM4OLvUoXbzUx
 7PU2JWBG5bkt8Pdq62Vq9Q0bK+IaJI8QrBKJ5nQjtC5x2epo+RecG4D9fpyOn55CoLZF BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37u1hb9w7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Apr 2021 16:43:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13BGeLNW145281;
        Sun, 11 Apr 2021 16:43:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 37unkm8hnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Apr 2021 16:43:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVtwv40YF3y4dmcVHgbAzq3zlORWukB7240A/McGGME1u+RNk8scN2MnI/3KFwBoarHcfGo7u+8nW05m0DC2m3u6VagF9yTE5ltCi9Lr5MJ5PGRe01+N2oUSgkZOemH6ZhLoMDWOH7NydpnsV++AfXwN8pgt0E/29M/+xCBLquY3Zxwn/CPpf5SGguyTBgp/g9Cppp6IwSAQlaLK4AofPyxkupFRg1zjqTCcM36aXRYWKZtB0WayBNvAkRTawM0AIreOn7StoFP8tein8quH+jPBJwnUWBing4XOxiLC+Nt28nIPwW3MrCvcVEVac3ft2O1Ov2KUIGsfup3PeKCrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz2UgIrrYDpisz19vG+RoWKQJH1RxcXyZjNvJ2Ju+ew=;
 b=dj26aRaB4hmVWQOSIVju1Efss91DnPh7A3dZSOfESaZ5lX8lMBOnl4lN5c0iAUXAgM5JOJ6PgXtSmehQSLrIckWEPb+567WjuGUitgR/JX3IN9hMInz+ECcujo3l05oesT4IsnJXOTgXyo1JU5rRgDT8iTHv8kUreGcqsrwxhAGagmy8nu2E2AUu8wuS+yX8II4hg+byCEXFt86GpX1ocXkYd0CYwAxRw7EcPQLbfjRhPNfIxnpsmkUm5Ps5/QR08kpOv9YsNXXWrDGFY42bfsOW0wG2x7L2NJWbKmPTvU7QelBKe1QKXyQV49Dt4OHCOyju0OpgOba/d9y+NWPOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz2UgIrrYDpisz19vG+RoWKQJH1RxcXyZjNvJ2Ju+ew=;
 b=N/eMWjZuZCAsp90wRJiXRw9jR+Nqo1zVKqGQWVZ1dY0zJFpRw0HBFZ5px5TBv999YY5e+UM/sKd/ES8TyXMmqYBM+U1i1Wsic7SIk0BfHhj789wXXn2s6En7NDJgsBXUloJQgExRh1BZ2PHhPgSqsHFUig0APteIUZ3ZuiONDQE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3511.namprd10.prod.outlook.com (2603:10b6:a03:129::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Sun, 11 Apr
 2021 16:43:22 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 16:43:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within the
 last hole
Thread-Topic: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within
 the last hole
Thread-Index: AQHXJmQFTcgUtIhOdkWOHgA/x/kHY6qe5g2AgADC0QCAAaRLgIALRWIAgAMEPYA=
Date:   Sun, 11 Apr 2021 16:43:22 +0000
Message-ID: <2ACF7423-7162-4880-B8B7-4580208925E5@oracle.com>
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
 <YGUm7/HE3HqVJik2@pick.fieldses.org>
 <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
 <YGcq7T2wZHJvONHu@pick.fieldses.org>
 <CAN-5tyHBr-H3UjAMHqAQTUPSe_w-wwd4Pqb=WuvkCFfvxnOo_Q@mail.gmail.com>
In-Reply-To: <CAN-5tyHBr-H3UjAMHqAQTUPSe_w-wwd4Pqb=WuvkCFfvxnOo_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7cca4bf-2f0b-4164-d5d6-08d8fd08eb47
x-ms-traffictypediagnostic: BYAPR10MB3511:
x-microsoft-antispam-prvs: <BYAPR10MB351185E7CFAB00D4C4296AD993719@BYAPR10MB3511.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XO7Zswu0qaBSCiwnQ+gbsCbolmsPwMmFK/MCpxpKLay4srCibR+G4M7YhF3TPmdqdjgTRBppbsP7UuvLqNrMTJTiQfDreU6j6nggcxxXLxgwmnB8oxqnGo99K0iTswxl9Fch3Z7xNpC6l5fUYGXIiCuh8CVrOASXHS1z6IbNvV0myUUMcFPkTRpo0HdIb43orM9DUbT/vC2tBcIbs7EhdMd/ybrl7kJm+a+KW/eHOduGIXdw6zAS51q1h3Ktyef+Bpxty4SF9Vw6BHge/SqlCakA0HoGEsHk0CO4WfFnIIQbHPAo1QOFVXv/9JY0JC9rhRmPDtYKy/1n+vEXFGUGf9Xov0+2adXw778TF3M8B85RYInsw2lERgtnaAPX4cBXj1oo7+QFqMovfIidW5u3ybLkHDUPFZmIEieFtQ3UXv20bPflQjYZYLAqjKiq+1o+JFrQrxBRcF87KMChxOAWmYLrfA3F/sJ+Kp9V9lUhkUGHc3BXcQxboBF2cDdcU+HxlrPxjXeX3pnOC8HO5heOuZ8PhKUM7zySiSYdQdczqtTOkPCKZa+i48n0baoRsA1BTUz6reto0CdufiN830yrnVL7FakeLkKDrkmL+/8Q/Oyxy+iZgeguUMBRLDC3mkJc0GKqofoOOrvXBtzXehib5MF8mwUewfZqTMWOYSxgcDY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(376002)(136003)(5660300002)(66446008)(53546011)(110136005)(6512007)(6486002)(316002)(6506007)(64756008)(66556008)(38100700002)(86362001)(66946007)(76116006)(91956017)(186003)(66476007)(26005)(36756003)(83380400001)(2616005)(8676002)(478600001)(33656002)(2906002)(4326008)(71200400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sXOHKaBnY7mgZ3NArjmbV2+40bw1UAdNkAqEpKiywsb1BkYIZ7J4TkxutrjJ?=
 =?us-ascii?Q?nx1N1sFyQpSHDvqxJACUVL+kkqB2qLtOpfVdRShD2WjL6mFprP4XwgDHo7LH?=
 =?us-ascii?Q?Eei2V/NysULTHN9YQfh4Iqp5u7Ogo7uyLc1xr0HncJ26wPF3FkWdooWk7OyT?=
 =?us-ascii?Q?PbMO2JIMMseakU/AjQZtijH1D7QIPfqt6bIT8HhvyyJJgVz7XjN1v040bpYQ?=
 =?us-ascii?Q?cNek83kGWH1n3c5/UbXpvUO50LPkitGzK7hXVxJ+SsYHHjKjthXX9p0F8swc?=
 =?us-ascii?Q?dc4v1BLrMn21/jJJhkNhiGtmusCru9E/+MVVr8Ug6Wq1+8oBm26PxCd3E4Eg?=
 =?us-ascii?Q?kZkcV9K2WoZF881RLfz/fZUWxIsZJshpVF4Ka8rhUb5tIJuiC8LrQbMUnjw1?=
 =?us-ascii?Q?Wt+SVPH+1uJkWAOi24J7AWv+J7/ePep0xU/tyre8HQ04mnv0OwtWCbdamAYN?=
 =?us-ascii?Q?ey8GJQejESKEvOQ5BVf5+T13tt5BAGdM73G3+1KM1MoGuiwvvhM6OOq+yHtq?=
 =?us-ascii?Q?xS49V4P5RGChgof1EEafyrspq7XCUhuURCZ+DZ97BmUnxftGXJz4TbrVm6pm?=
 =?us-ascii?Q?JDu1eaCc6G/UhEFStaSku1To9DH7ZY8V7cuoRbLyDDMWNm1BNiM6D0Ben0JQ?=
 =?us-ascii?Q?mI/SxRTMWYExmaebbHblfc6tsQ1e99kCZu6mV/2GDRgH8l3A6ibQ1tXXkUFz?=
 =?us-ascii?Q?jtDMQ+ax46mJ2dPFe7g1C8tL6etZDOW6pQXijYdFeOS6K5q07+2APtbh/GT2?=
 =?us-ascii?Q?Rg0HPkmjD0kgByHKH1UTdRb/KDsmT5S4ara29ELivkrs9Dw5qzDZx3+Oq1su?=
 =?us-ascii?Q?VjoJ27jvPGp9nlOiVcZFmBPzUod/ztn7WXmFseGzqaBvV8ieiuu8aoH7nPQr?=
 =?us-ascii?Q?t9xeduZ2RJktd/uWcbrKzQ27Rz29tKxCM3kpAU27376oJ8jaC7mExxoNZHMm?=
 =?us-ascii?Q?kszCPSoQHMnErq8hnmF5nKqFKtLNlA5+jtJMB00u2tL48wLuJZudfNDDPhBl?=
 =?us-ascii?Q?PI6wonwuL+d7hHxAwh7tO2v1HbZmduR2z3Ijplwd8g0DzcdVhlJjYjKIknrp?=
 =?us-ascii?Q?vH7iTpcYJIKHJ1OXYmrPbSl4NTnlDoa9+dvLtEZIrNSik/6lODQRGON7mAK+?=
 =?us-ascii?Q?m/MwSSgCHTdpFMBOLrvJ7adqJA5qE3hoB4pAtd5oyGATxTQO3C0IZI8zWPKR?=
 =?us-ascii?Q?HLPqpbnrkWvvF1b2UY2xAmxdw+27VMFrHLmyKPpCntMh9aiHr2/ZlUWmgPaM?=
 =?us-ascii?Q?PQuFaW6LWDQGYi6kh51UY+yW7UKC4K2wlhg0RlprAjxQwNfi9Q/K5tb0IgVL?=
 =?us-ascii?Q?pp6iKCs/aJ/WKbCc3vPSlx1J?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39382824BEEA7046A170B25B97882533@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cca4bf-2f0b-4164-d5d6-08d8fd08eb47
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 16:43:22.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIrr6742mUjG4z0nKXNuSlVj+f8qRarkEgpRIw1Lz+TGnTBLkkGKkeG5vRA3F+Dl4aqPkQUI0e0PHeJzM+GRQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3511
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9951 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110130
X-Proofpoint-GUID: KRPFYnQopLF0VUPmCTuUKK43tYY6qFJ2
X-Proofpoint-ORIG-GUID: KRPFYnQopLF0VUPmCTuUKK43tYY6qFJ2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9951 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104110130
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 9, 2021, at 2:39 PM, Olga Kornievskaia <olga.kornievskaia@gmail.co=
m> wrote:
>=20
> On Fri, Apr 2, 2021 at 10:32 AM J. Bruce Fields <bfields@redhat.com> wrot=
e:
>>=20
>> On Thu, Apr 01, 2021 at 09:27:56AM -0400, Olga Kornievskaia wrote:
>>> On Wed, Mar 31, 2021 at 9:50 PM J. Bruce Fields <bfields@redhat.com> wr=
ote:
>>>>=20
>>>> On Wed, Mar 31, 2021 at 03:28:19PM -0400, Olga Kornievskaia wrote:
>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>=20
>>>>> According to the RFC 7862, "if the server cannot find a
>>>>> corresponding sa_what, then the status will still be NFS4_OK,
>>>>> but sr_eof would be TRUE". If there is a file that ends with
>>>>> a hole and a SEEK request made for sa_what=3DSEEK_DATA with
>>>>> an offset in the middle of the last hole, then the server
>>>>> has to return OK and set the eof. Currently the linux server
>>>>> returns ERR_NXIO.
>>>>=20
>>>> Makes sense, but I think you can use the return value from vfs_llseek
>>>> instead of checking the file size again.  E.g.:
>>>>=20
>>>>        seek->seek_pos =3D vfs_llseek(nfs->nf_file, seek->seek_offset, =
whence);
>>>>        if (seek->seek_pos =3D=3D -ENXIO)
>>>>                seek->seek_eof =3D true;
>>>=20
>>> I don't believe this is correct. (1) ENXIO doesn't imply eof. If the
>>> specified seek_offset was beyond the end of the file the server must
>>> return ERR_NXIO and not OK.
>>=20
>> OK, never mind.
>>=20
>>> and (2) for the same reason I need to
>>> check if the requested type was looking for data but didn't find it
>>> because the offset is in the middle of the hole but still within the
>>> file size (thus the need to check if the seek_offset is within the
>>> file size). But I'm happy to check specifically if the seek_pos was
>>> ENXIO (and not the generic negative error) and then also check if
>>> request was for data and request was within file size.
>>>=20
>>> Also while I'm fixing this and have your attention, Can you tell if
>>> the "else if" condition in the original code makes sense to you. I
>>> didn't touch it but I don't think it's correct. "else if
>>> (seek->seek_pos >=3D i_size_read(file_inode(nf->nf_file)))" I don't
>>> believe this can ever happen. How can vfs_llseek() ever return a
>>> position that is greater than the size of the file (or actually even
>>> equal to it)?
>>=20
>> I agree, I don't get it either.
>=20
> Any more thoughts about the forward progress of this patch? Are you
> interested in taking it?

Bruce and I discussed this privately a few days back. He asked
that I not merge it until the client compatibility issue is
resolved. Bruce, please chime in if I misunderstood you.


>> --b.
>>=20
>>>=20
>>>>        else if (seek->seek_pos < 0)
>>>>                status =3D nfserrno(seek->seek_pos);
>>>>=20
>>>> --b.
>>>>=20
>>>>>=20
>>>>> Fixes: 24bab491220fa ("NFSD: Implement SEEK")
>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>> ---
>>>>> fs/nfsd/nfs4proc.c | 10 +++++++---
>>>>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>> index e13c4c81fb89..2e7ceb9f1d5d 100644
>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>> @@ -1737,9 +1737,13 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>>>>>       *        should ever file->f_pos.
>>>>>       */
>>>>>      seek->seek_pos =3D vfs_llseek(nf->nf_file, seek->seek_offset, wh=
ence);
>>>>> -     if (seek->seek_pos < 0)
>>>>> -             status =3D nfserrno(seek->seek_pos);
>>>>> -     else if (seek->seek_pos >=3D i_size_read(file_inode(nf->nf_file=
)))
>>>>> +     if (seek->seek_pos < 0) {
>>>>> +             if (whence =3D=3D SEEK_DATA &&
>>>>> +                 seek->seek_offset < i_size_read(file_inode(nf->nf_f=
ile)))
>>>>> +                     seek->seek_eof =3D true;
>>>>> +             else
>>>>> +                     status =3D nfserrno(seek->seek_pos);
>>>>> +     } else if (seek->seek_pos >=3D i_size_read(file_inode(nf->nf_fi=
le)))
>>>>>              seek->seek_eof =3D true;
>>>>>=20
>>>>> out:
>>>>> --
>>>>> 2.18.2

--
Chuck Lever



