Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9FC44F63E
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Nov 2021 03:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhKNCre (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Nov 2021 21:47:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40070 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233306AbhKNCrd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Nov 2021 21:47:33 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ADKvwHK025140;
        Sun, 14 Nov 2021 02:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=s2JDW8FVjx0cAfjCen66SHxKsSZfQrF+vN2e7LY85IM=;
 b=FlIPFHR3xvnChmjDffzBfL1+W1o/Q9edCOy4jrLOdN/SNd3y0jZ1+L954NqKgzJp4M1m
 sDkB3DWSo2/Oh4Demc+fTDxLDtox811LTRbRNg2ex0W/7voa6fFgm5Qrjn97YfhO+JP2
 QN551dbjYXGFG+NGM86TReYwZvh3Dq6sDetXdm79WgIOtU8Oo18puZ0fSIeaoKQD6lr3
 WNVmqFKRfsMgk0f4YCKB4W7vr0wnB/ybQk0M+s6hp5R9RJ5QP5nTvBsXdKj4j430emR4
 NpHxUJdz2p/F/CXy825qmibRVbPV5zXD339sPIUVKqHGisy2vZv8y6Sm3DBEa2/7NKgr aA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ca5wu1xdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Nov 2021 02:44:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AE2GGk2190304;
        Sun, 14 Nov 2021 02:44:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 3ca3dd1g34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Nov 2021 02:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIMdmXim2FKg/VmOJehRhdX/bCR4Jno8opjTlF4iu4eyfXq9roCAai3fHDQVZZsOIV407EXakXUrahNPeM5x7xev6+hpZVV72CQsaRfoNfwW22BqN2TfcvgQaaAjFxPqbql7vY60TExmTglPnVLjdBTdAaLzYkmi2+iXtOEMQcS8qcOfyuv9NfBIoXj8VE8uULVw6C3RhYNi9Snjxh9d3USHPhiyasXb2v4IkdT2PTBkLLqaSiCTb2tcGor3xSV9GVe2GMZ2zuqYcYYf0tppbrtFNvM4SMj7fB/fdoLv3xOsB2BK7czK9jiFVDbQyNJeYzCdlmbd+5WtWfr5SsjjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2JDW8FVjx0cAfjCen66SHxKsSZfQrF+vN2e7LY85IM=;
 b=B+2v6KGJNcdSrMWgCXoX4wANhpi/0GTEHlJawkDY5CzGjx3knjYb+H/xMsURoT/7bbvPnhjfFvepKW5//SSJQBBo3srdRw/BhGwFC1lcELyWWGEbDmgxUDGDWlbqxPAEZvJhAwp67M5othDInmrBF6ulweQICFMIQ9dtSh8X916k4gzxH0LvZtOzqUGxFG9QXLOQ3t1P0j9VYvSB5lSq7Hq6Ze38mycNplvxZu3AsnWPbx3Lf1rg3p9GdTcoGt9Qs/noCOPwbBRL3nUYmdwCubBplU2FyEA4aEdyMLtKV273XN42V+7Ljw+B7mtxeuVhEzwiHyI9046hT17CyjSpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2JDW8FVjx0cAfjCen66SHxKsSZfQrF+vN2e7LY85IM=;
 b=iN+7CGlbeaqy7QN5mPJTF00gP725pXcQDY9uL64WPVNyIpSrUxDFu0Ux/8b5UpVAbbPYL59Bs0KdGric5qwfXqPg9kYDZaalSTfpWgpcvvXEMjQeKGGTl3Yo59WsSrWZGp/QXU2lPlOnzqDHYDV31w+6cj5KuSPtDHZj2UqNhHs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Sun, 14 Nov
 2021 02:44:23 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%6]) with mapi id 15.20.4690.019; Sun, 14 Nov 2021
 02:44:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     "rtm@csail.mit.edu" <rtm@csail.mit.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Topic: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Index: AQHX2NFEStLOh5EPHEGsmzKRU+63DKwB8uQAgAAFgQCAAAGpAIAABxyAgABQQgA=
Date:   Sun, 14 Nov 2021 02:44:22 +0000
Message-ID: <421C8671-59D0-48B2-A03F-157BC65D653A@oracle.com>
References: <97860.1636837122@crash.local>
 <11B4530A-C0A0-4779-A9BA-F0E19B62C5A6@oracle.com>
 <20211113212544.GA27601@fieldses.org>
 <9A3E5D78-AE3C-4F45-8CB1-10F2EDA1D911@oracle.com>
 <20211113215707.GE27601@fieldses.org>
In-Reply-To: <20211113215707.GE27601@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0aced06-d074-4fe2-bb52-08d9a718aa68
x-ms-traffictypediagnostic: BY5PR10MB4164:
x-microsoft-antispam-prvs: <BY5PR10MB4164CFEB0A4831E67A05B81893979@BY5PR10MB4164.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNco9YlOCaMn7ub6N3yNL+lrXRoeamAGZczMAzh6hU21AvrftlFCnZD8qh+JuGSyJpA713Dcgfda6yvs5HLKC46Ofycv44rtqP9yCQHRNe+IgqATbHGpBe1UeBN6CdU+cqEFSmar9iOByV16YYC6suvhh3wdgRG9UJ6zzfSDL2cD2NWtDGhAQK9XQlI6hZ0MIGTCP3LRL4INBvaikS3P0WO5AT5KQ9SqzAdyUlYcgCS5qEW3ajF43BR7bDCKg/3y+DEg1Vqh0g1Py/IeH2or+65ef0MzyQvBOSHsnBYHw1gN/wUz6y7gR/hQIF5/bFLj7vZGBLDK5mx/+mtBT6oj74hSkhazL6NsL+ZP4AFKimv1AKNG61Z6gC4CedYIvldBWX25rEaokiJK65D66s8B3n8dQw3VzvZDO1gPoYqzdBXqvPlzCiuATGgqRHYdLtFprCldMuFqJB0Eg51IJZYWFWQV16tob6tEMd0Qi4ZZkGDYL9Ql3IWlYPz75bB/LYavs4f14riNCN7p1C3LFcAU14+0hbn2vUKUVAHBtuY7Y4FFcC0OqWAy77IcRpK1HeAJeqHDkW9Nw7OCCjrHeEqjGIkIuSd+oXRql9PfilpLz81gfH1F2qX5ewJpMS2L6Ltc9IMGmNf95BDcE6k6ZvWqz3aDOfdr/rKXV5+NdDSgMdVTVCt6CInbfKhki6jptAn0R4Uq97+AG0I7uVbeuWzzr79J2IkoqUZoePOEHyU4FAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(186003)(76116006)(33656002)(4326008)(38070700005)(54906003)(38100700002)(2906002)(36756003)(66946007)(8676002)(6512007)(64756008)(66556008)(26005)(66476007)(66446008)(2616005)(5660300002)(122000001)(53546011)(508600001)(6916009)(316002)(71200400001)(6506007)(8936002)(6486002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fQ3ShP88KWXRDqvFGOW/J+TIUt9d39J8Mdj8S6XNO6vrhi9PB8G/hMURZu+K?=
 =?us-ascii?Q?wfKsli+Areyk6c37Nvz1rBIJHMLJ0O6nkgvyxMPn2kIeSH4kV8+8PTVXVCGJ?=
 =?us-ascii?Q?2oPSwleh3AgLifEvfnOnhGHJ3TKAak4zIoCqM034bXvQDn7Zb2SHADxRTHXN?=
 =?us-ascii?Q?6ra4UAtnVQZTQBzmHIS5I33gpvorLV+cAWb+liH/y3C1I1ow+HNP5+JNbipv?=
 =?us-ascii?Q?Pr7TSL9uTDc7PoRuKw+YbScZC3EzFYokJvNdkkHH26WXKIgvPLOf16w6+pZt?=
 =?us-ascii?Q?Dgpnnouc8D/YfhkaUDr4p+xdJbnVzMEAUDQEaSi58wM7COLJukeHusgZgPn9?=
 =?us-ascii?Q?A7KmZSLK0cKbb07lnfn9m1VLPVpXs1jqP4GINf2lRKxpGdnnFHLImK+D+NsD?=
 =?us-ascii?Q?iyy+sOLwAAgzfZSQ1XMgNjoto+mT1MpM5TdeFRpxCjCGjHDE9+WBYTxoEKaR?=
 =?us-ascii?Q?Bl7diYYtU4M21RuZeCAdc9PK9uUQ1bBkTZPC1aSwZ7vdWCkARX7QKrYfHF6l?=
 =?us-ascii?Q?+o8dbfN657FgxEUMUjOxjHRCw4K54V/tzumi+wtvSO1iGCmwawpkzo2mtVCi?=
 =?us-ascii?Q?ip7yeqLn8OTp2fWeIG8sFa3/KhqlcyONOtn6U6dGOrMgKF8qSYD6zhs8Zv9q?=
 =?us-ascii?Q?xYpLagE6gB/JOPHNwYM4V8zFfqTJ3sC2LB+bDDDRBE1n4FJz/euVDr+dJEmB?=
 =?us-ascii?Q?wposzxahv7606FHLGn9LWzbOwLV2DM7ENjqFYz6A/jSSZb1HnhGwZJVwVxJM?=
 =?us-ascii?Q?PYtozo3BqCeCmyfLbohOcYU0bMh4TqJ8/uzgt/PRQ4RjjsifIC3KNL3T3f4L?=
 =?us-ascii?Q?cLdoimsWmvyg+JLAOfDILQADiVIDCdD23j8CCwRsMXA0mOAkX+98+1X4xeDh?=
 =?us-ascii?Q?iVds2CaNqKEZuRzEaSQNQlZtybOPHiIG73HWQigIUUEPsyDkXJrC0MI8+Tmm?=
 =?us-ascii?Q?WaH4BBVGHzO7GVWOPhz3u1uC6XqZZhZxGbu6dqqb4fvXksfLaviOGXsDFs1b?=
 =?us-ascii?Q?Txv+bmeR1xPneEcc9llwO/FGvasFk9QFDrZXT87skX/DMD44n0FsoEBv3yTD?=
 =?us-ascii?Q?4VgxQTkLFF4EK2lkEuJcsJ2rYh/JWcFgPlSTFZ63Lm7caozoTOzRwObqUr0b?=
 =?us-ascii?Q?nYDKeFCzLpa5Gma2/SoaRuxOQ7i7d8D5o8KGuVSITqtf/V/OC8wTS53H2b27?=
 =?us-ascii?Q?Nn0Q9LOHOZ6YQ2lwRG/dU0omEpeTo+/Ipyl7w6C7JzyMJb/O8n1DjdkizV8U?=
 =?us-ascii?Q?EhliOmaPArl5InCLZnvzD21cKcjo5Z4J8JgZXuoUtKyJ9BMXANjohevw6p6M?=
 =?us-ascii?Q?ROEnYcpX7o8J/WunOLzlAvBg7k7w+n04Ye7eXg0Hm25NqCZUsoXvD1BmIMbW?=
 =?us-ascii?Q?p8gIg+AZIP425vLz4klPJWEYlkZMkhqhiJFXZpIkF7nV/pXTXqsPkO5ltddM?=
 =?us-ascii?Q?6k5q5q9GRy+amtg2CPdbFvEaKHWkBJgqetAuUF44GQMeJxfaK9zVR1udDAVo?=
 =?us-ascii?Q?3XYD78q6crqwiu3spEtr+mqNYKpJarEqyZ7ZKXTX9CjiOxtl3SV+Yg2i0Fxu?=
 =?us-ascii?Q?kq3YbQ/38TPeLNbsF1roDLGQ6g37CujPd5ngX2gLwXMfe/j2uanLOjPgxMlN?=
 =?us-ascii?Q?ONrEV++7TpRYbAbEOCMrDZM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7785310B71A9242A6968197C7861806@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0aced06-d074-4fe2-bb52-08d9a718aa68
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2021 02:44:22.8883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6p1Qu6ud5MwYf3n3BtjJRKf84boet4OQ7qSkS6TrtHRFqQYoWdhm5yEAAicaHxLQdyZ1r8i9KVrE1vCSmzUksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111140012
X-Proofpoint-GUID: HPAFD58TwqVbG9EVPz5Yt-mq3Gr5e0KQ
X-Proofpoint-ORIG-GUID: HPAFD58TwqVbG9EVPz5Yt-mq3Gr5e0KQ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 13, 2021, at 4:57 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Sat, Nov 13, 2021 at 09:31:40PM +0000, Chuck Lever III wrote:
>> This allows the client to send bitmaps larger than bmval[],
>> as the old decoder did,
>=20
> Oh, thanks, right, I guess rejecting too-large bitmaps outright might
> cause compatibility problems with future implementations.
>=20
> (Hm, ideally, shouldn't we be checking whether bits are set beyond where
> we expect so that e.g. we can return NFS4ERR_ATTRNOTSUPP on operations
> that set attributes?  Perhaps that's more than is necessary; it's a
> separate issue, anyway.)

The spec might call for those bits to be ignored. The server would
simply not set those in the response. I believe that's how unsupported
bits are handled anyway, rather than returning an error response.

Also note that the "count > 1000" sanity check might be unneeded. If
the count is unrealistically large, it will cause the subsequent
xdr_inline_decode() to fail. I could send a separate patch to remove
that check if you agree.


>> and ensures that decode_bitmap()
>> cannot write farther than @bmlen into the bmval array.
>>=20
>>=20
>>> 		return nfserr_bad_xdr;
>>> 	p =3D xdr_inline_decode(argp->xdr, count << 2);
>>> 	if (!p)
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



