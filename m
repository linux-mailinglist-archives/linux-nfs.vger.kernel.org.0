Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C789F496CFF
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 18:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiAVRGA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 12:06:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58634 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229773AbiAVRGA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 12:06:00 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20MGlGpo025472;
        Sat, 22 Jan 2022 17:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=j3NCX1hvSJFuRn2qYSWuJBQthGIi9dzLHzePQiAWNF8=;
 b=KqjbL627R43T38jNXkoI4iObnk4Yn4yk39vbie0t2n48fvy1oh13GF7lfDT6Pr+PbacD
 XJbBGZhgNOl5i4qBQLfGP26hXEH7nrmWYb3L0LDTaPm1ss8yf244SHKUO0O3vO94BHgx
 dTHPRtvwllhIObM9PtFDieaeKclXpVS0XOtVy5xgEFawfT0Ad55mPDNB2YzIdK29e7zS
 dGxW5r029dOVT/0yxfxm+GOZsKvC1tRVqsuoWGuixJI1zNJjOY2tGjIqnLGt622A8jha
 DkJk1Owj2k5VNticA9iei67K1d20Ejp+ELOGeT3x9N1VlU3pJBuUfVLvuNvLOPQLGIJw 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr8q394yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 17:05:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20MH0dAs007685;
        Sat, 22 Jan 2022 17:05:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3020.oracle.com with ESMTP id 3dr9r209rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 17:05:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Riq1ARxali2cnZHTCG2gEWckaEqGnnMdqXfolaNLZG87ywdox1duUuXO5g8LwVGu478RaiQrgspGheNDlod/SuluVEGD8/ROBChIiw7XuBwLjoZ8q7SZU+N94bcN9ZRiesZb0RqjPCwP/4QtZNoV79JL5afldC9PNK495DOMnEyZTvsgd4YcxB58MhwiBAUYuV7KOhC4gosWzqcjmaSgp+2g0aTkgYflj7BOAx13hbHi5yMijCV58B932BWuOrIJW6nmYfHB2x9C8h01+Vo0szJ87UgmAIhvgL5VCI1wkv5ERibt/zhyz6dR+aNtu7/uSHAKp6+ADX+9q9gXZNSaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3NCX1hvSJFuRn2qYSWuJBQthGIi9dzLHzePQiAWNF8=;
 b=KxK77kDkSj8stDh58PouT9AZlurhQXIvBn6Ia6gpRnQLBirbAzpQ2lJ1gjIPhG4ZAzUukFIJmfiWV6K9SZBzPi9Elm1yUAfjDnShFzURAPTLyUkA6awiP5l3HEpsc2U1x8+jou98/ygwsvjSuyTsDQOSEoZzRlU2uZ5+p/EICmND4mcwn7V2LKmsRCyKyGKPTR7aeW7pTYZUVW/nAxMkOyhCUP6+/Ze0gTg1BVc7376tIaWmVXlJsqMj6DB+EBvGjnqoWQlZbLY/QzMMStlw7ZZB/YNjI9C/cbYIUzebhQWTiNXMU8EnKssXYhSZtaF8PJwde0mShGTnS452yn/45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3NCX1hvSJFuRn2qYSWuJBQthGIi9dzLHzePQiAWNF8=;
 b=QORa2gUJU4gunhc56QrHmS9+kP72HJ2Wlyx7658saXf+97A8Zolz3Th4emlYElhRZf7NyCoNrYP5yyE4IvV9h8sLkMl5OU+iQDtUEHHTQQ+B4S1CYlxZEWvzpP8ofqXHkN5ZV9MD3s0EVWK5P30YnuI1XTryg4gUyDwtFY4CJ1I=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (13.101.46.241) by
 DM6PR10MB2939.namprd10.prod.outlook.com (20.177.219.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Sat, 22 Jan 2022 17:05:49 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.014; Sat, 22 Jan 2022
 17:05:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Aloni <dan.aloni@vastdata.com>
CC:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Topic: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Index: AQHYDvfTRZNTkkSWjkWDIwR2Vc39WaxuD5oAgADuzQCAAEhDAA==
Date:   Sat, 22 Jan 2022 17:05:49 +0000
Message-ID: <04E4C6DC-B78F-45DA-871A-296379B2D484@oracle.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
 <20220121185023.260128-1-dan.aloni@vastdata.com>
 <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
 <20220122124710.4l5bzmfxhf2o2yee@gmail.com>
In-Reply-To: <20220122124710.4l5bzmfxhf2o2yee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9512a26a-dfe5-49b1-8651-08d9ddc9706f
x-ms-traffictypediagnostic: DM6PR10MB2939:EE_
x-microsoft-antispam-prvs: <DM6PR10MB2939EE8352EA154A94A258CA935C9@DM6PR10MB2939.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5hHuohPPKIT8Iar9eHzG69F/nPNUpNXtX0XQxUwJ9nq75kuB7dq9PElw4bnELRjuQhW+6Bd7xzYR5CFRatYE8NFoOSsrMkQie4YQS0pFEyse1tqqRK02D8DZMwMMcK88vOZbCrKc/1jcbkrh29IGAHGAdT/m0lYQIoL8fJ6UWWd5ioaOhPWhNyZvpIVySYXD4LYc/A1yQ5t2l3zHMPk33YztOgdKBaaulaJGZcMVmkRC+CL/bzkGOZTfSB9BV/SxcSTtEH3zC6lP+S++HvHUIYzuz3f6RuBqsUgOYb8TogAETCQVNGNE39KGOCv3iehsV415swKYSu9mXpd3zaAA8ezY1yeQO1IRhqPHe6k6J5W8A7nqjv20io9cEcz74S2F8/g06V/bsDe8/cUpEfyCLhpIwp5NrY7mROeYFGAUmkW0VWpUTHyw9aHz2F+BH8TSkaPTqZVZn/soSrl/zKs8wsxWaoGUhaWYdvVUPk8s3mIDs+I7fcV+G7FNGwOrPgDuwZ+9HtJgOUW6dcmQeDSVSQSisEfxBDJpUOW518+njIKt4IL3FonhgDxCE9Ny45Y+rMT9iQMpmaKt6fJw4sNVyRphW5esmbMxotiStUzL2pyCWp/YQ2txtZCFjFhiLW2yFDh5hHzymFdhYMDi2j7rnCOb6PDQvXMI3iOW4xRvQr2MZgYpzHNJ7T2G7v+R1NiaSpmjdCliQE1HL4/tm1w0QnWjTWOBiu39IGEz9ytCr1hsDBYtKCjLzkJ5H6PId77D8L1bu5jyoFVY+/Ne2PE59JluFTgzSIsfijZKIA/7xjwcCX4ZcHeltDmkhCryRdfy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(8676002)(6506007)(86362001)(53546011)(6916009)(508600001)(66946007)(38100700002)(2616005)(316002)(6486002)(122000001)(38070700005)(6512007)(83380400001)(33656002)(5660300002)(26005)(66556008)(966005)(186003)(36756003)(2906002)(4326008)(8936002)(64756008)(71200400001)(76116006)(66446008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NjbWzx5cYIe8LxgrMTfN4gjR0ltLlanbgKpolu+Ka6GO8CoJkzfK68L+v/WO?=
 =?us-ascii?Q?10flV5JyIv7kCeSJNlU1wKSlXyGMOTGekhOAxqFlbmA2538BKRT+ltSb4XW1?=
 =?us-ascii?Q?Ip/xRaJ2N6sbVFriLPONcojPHKdvhN4ZSXFrzlarco/lW3hkBfyW/KS3R8K4?=
 =?us-ascii?Q?KgIY5KGmPi8AljGHsaFL91DYAcin3m9hWXlXt9HrFQbSlxl9AvCNLd5c8SB/?=
 =?us-ascii?Q?c5i13wlVJy0C2IXwvCFbwAUqZh35t9oMQf9Fj7/mhK7OowvvSZKRu+Axq3Bw?=
 =?us-ascii?Q?CydNKInUMObldwboxBYzCQyOwJxjDONv2tvBWNjgmlhM6g2hBsKZww3J1aWq?=
 =?us-ascii?Q?vS/KHiMTjqAM2/Oa/GSkSSmym1MKWBlpNfNDlBfrJ9FUjwbhTX3/ZHTOaKmE?=
 =?us-ascii?Q?DM9qExOCyoZKrIAPOAZJYX/6tMK/xApiWnVkRKvC3TdSNY+Mj66HJ82EvnEZ?=
 =?us-ascii?Q?gt1iRDVXammqweCNHV/iLdBUJSc8l3If5mlUo8ofC+afXQwsNKiofjpB7ajr?=
 =?us-ascii?Q?96BGBQta4f4tdIjWmMA02ymWr3lbGAyNc/niz1gz/+tGrUZLy5T1bzNjx5Qb?=
 =?us-ascii?Q?N2FevpUg+PidsGn3fd0Eyamjw+T+zlPrjyju0B05j7fs9R5c9/8caSZ86KXN?=
 =?us-ascii?Q?YVFZd/vtibYvWYGpUD3MhH2aNwagKZDGnDcLvFNVt9iTzCcBaPGd98A4f07a?=
 =?us-ascii?Q?1SlwIDECWDPjKBTQ32B9Ht1aYPJyuifKTgMv+5wPqZxlEa3aD22Itd74ngdu?=
 =?us-ascii?Q?fxD81bIuKRUZOobfdry/7Rn1p7+5DURQvO83sAv/5JVKG6EN8sgPikgB0Nie?=
 =?us-ascii?Q?aYtuC+lLaMxfXVSqc9VADx/Myx3QolunZ2AcDqeuPfnetCAJz68UYT5wN5Dz?=
 =?us-ascii?Q?FzFb0+6O9XaF/9/ACrPB9AEhfwvpmNWej+L0tVLRuV0erXHcKQ4XYZJTu+l6?=
 =?us-ascii?Q?13lRH4bOH1OgC8avxNQ8g0D5DBfzOYVmrNs1QAZWRkTTe2jXx26KM36tDrE4?=
 =?us-ascii?Q?2x/DLmhVTFEQNo760z0xSXe5hG7xha7S/82+PnNa8tUVi+fjvzjSZ8l0JjHa?=
 =?us-ascii?Q?oPqLodXNbf/xyfcTk2QJLx/XumDCvK27AOmSm7p2yY0f3CFx4C1slzUTCIyq?=
 =?us-ascii?Q?ridB9kXfRMlfpWbsXLMRSfQAK/+6CGMqa1phrWq5Mb4NsvBBhJPrhlO3Xwt/?=
 =?us-ascii?Q?GnduNkodH+KLZUAuBDE2qiYxqoFHaZPmjUrTiz+fxQUdLfGS9Ja3sILKIgx7?=
 =?us-ascii?Q?S1ZfJTZhF+s2wqMbRIs0KHngTORf8wMeHDa+S8ZkQNyw3P3rc8nXeNabysL/?=
 =?us-ascii?Q?BQJoXGund2u5Vwcmo7RtljYQKVo1a/ct9gnQv9+X07Y9LqDM2EqCES+CJRTO?=
 =?us-ascii?Q?txgeWK3oJXhXOaRdZk0DMrEfQZJ0YfdNhN7DDKbTxntLTeohY6ntUV8i2pqZ?=
 =?us-ascii?Q?l1cT7V40jMT/Hjz5FO/T3EK4xYPdfNDuKgzbRDJuGfR8TMjwWSsqFQaX6LTy?=
 =?us-ascii?Q?gzfszvxX3TrFD5uPybg7FLWJjP2RfmRkcVd/cZJSeN0Q1B7QRBacuSWUxail?=
 =?us-ascii?Q?mE4JmKBGYyTmyWZpZO4OU8ps4Cc5AsxQRZY5uchwICl2XzApqqUEW6GOAur0?=
 =?us-ascii?Q?T00+J/E9yqm+BgA67Ntw0Gc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A6EE41BDAAB72479864EBB5338FC6FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9512a26a-dfe5-49b1-8651-08d9ddc9706f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 17:05:49.3389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2XfLXTYLjx7Mzhn2tFXEqXI+G+Q8zzVU+s6zNZ47sj60KDeIBkLMPHTf3DNXsSf2O9tTP8pe8NkjqvhV5B2OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2939
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201220122
X-Proofpoint-ORIG-GUID: vbtAW8QQCiGWGBvyQgGroVWHBUa6RL_a
X-Proofpoint-GUID: vbtAW8QQCiGWGBvyQgGroVWHBUa6RL_a
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 22, 2022, at 7:47 AM, Dan Aloni <dan.aloni@vastdata.com> wrote:
>=20
> On Fri, Jan 21, 2022 at 10:32:28PM +0000, Chuck Lever III wrote:
>>> On Jan 21, 2022, at 1:50 PM, Dan Aloni <dan.aloni@vastdata.com> wrote:
>>>=20
>>> Due to change 8cfb9015280d ("NFS: Always provide aligned buffers to the
>>> RPC read layers"), a read of 0xfff is aligned up to server rsize of
>>> 0x1000.
>>>=20
>>> As a result, in a test where the server has a file of size
>>> 0x7fffffffffffffff, and the client tries to read from the offset
>>> 0x7ffffffffffff000, the read causes loff_t overflow in the server and i=
t
>>> returns an NFS code of EINVAL to the client. The client as a result
>>> indefinitely retries the request.
>>=20
>> An infinite loop in this case is a client bug.
>>=20
>> Section 3.3.6 of RFC 1813 permits the NFSv3 READ procedure
>> to return NFS3ERR_INVAL. The READ entry in Table 6 of RFC
>> 5661 permits the NFSv4 READ operation to return
>> NFS4ERR_INVAL.
>>=20
>> Was the client side fix for this issue rejected?
>=20
> Yeah, see Trond's response in
>=20
>   https://lore.kernel.org/linux-nfs/fa9974724216c43f9bdb3fd39555d398fde11=
e59.camel@hammerspace.com/
>=20
> So it is both a client and server bugs?

Splitting hairs, but yes there are issues on both sides
IMO. Bad behavior due to bugs on both sides is actually
not uncommon.

Trond is correct that the server is not dealing totally
correctly with the range of values in a READ request.

However, as I pointed out, the specification permits NFS
servers to return NFS[34]ERR_INVAL on READ. And in fact,
there is already code in the NFSv4 READ path that returns
INVAL, for example:

 785         if (read->rd_offset >=3D OFFSET_MAX)
 786                 return nfserr_inval;

I'm not sure the specifications describe precisely when
the server /must/ return INVAL, but the client needs to
be prepared to handle it reasonably. If INVAL results in
an infinite loop, then that's a client bug.

IMO changing the alignment for that case is a band-aid.
The underlying looping behavior is what is the root
problem. (So... I agree with Trond's NACK, but for
different reasons).


>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 738d564ca4ce..754f4e9ff4a2 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -1046,6 +1046,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>>> 	__be32 err;
>>>=20
>>> 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
>>> +
>>> +	if (unlikely(offset + *count > NFS_OFFSET_MAX))
>>> +		*count =3D NFS_OFFSET_MAX - offset;
>>=20
>> Can @offset ever be larger than NFS_OFFSET_MAX?
>=20
> We have this check in `nfsd4_read`, `(read->rd_offset >=3D OFFSET_MAX)`.
> (should it have been `>` rather?).

Don't think so, a zero-byte READ should be valid.

However it's rather interesting that it does not use
NFS_OFFSET_MAX here. Does anyone know why NFSv3 uses
NFS_OFFSET_MAX but NFSv4 and NLM use OFFSET_MAX?


--
Chuck Lever



