Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C416496DEA
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 21:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiAVUPd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 15:15:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46348 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbiAVUPc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 15:15:32 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20MGj8rI018591;
        Sat, 22 Jan 2022 20:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cKHygQNL0p+pjqJwYKJIS/kyu/mnAER9t4QtwqgxJYs=;
 b=ZIrlcaR3pUb6KAp8MnrKiWnqJmqw/b8PBntyBhgAbWA/cHt2tAU3kR6tlzzuW0Yfk8fq
 IaLXuMf8c3/NKILaTMIKDL+GP5w4MnRqT6xWx8m/zKJ9wpAWoJ99FLFJ+0nEdSGbhvZJ
 aDzJBoHGCzLuRvKTA8REQQyJCz+6msY+HQDkn+iFEfKXli+V5wmY4pUuHBagHMlapcV1
 OqO97socVNaaU5KFSZzmegTCATbravU9kG9g0NohMqTg96hbyivW2a6yGGyyl1AC94vW
 ejAjTZnzm1JbfhB3s8B23buq0szwDhZHJDvPv7u/hGKgC1N96p8i3C0FhCER5XOfLr/L cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3drafu9a7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 20:15:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20MKAJ31181804;
        Sat, 22 Jan 2022 20:15:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 3drbcgyrc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 20:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbzl0Hdvr4aiGtahR/F/UatsGqlUS+Jb+iI3+Orn8w06C2bYrZ4svdRcZy6XdCGVfkg+wTJeFFxyNoJ4TNnl0sCKHMu0NccbuJCzVmpga2jvoU+cfFYPuTS2nIKPZ5m+9/3Lg5xuwmznCq5aQnmEJhaLR6FplOA1CW1NiobNmSTkr6OJ76Zbw7mgZgKoupNsyt2syfGimalErlHEEbGrc9QoPeOr7K9zjZ2N+lIievuFgXMDoupdJjeF3WEpVOH++Bo+q8MBQcJ7JY8PWenlnuGza+406ye62Pn5KViI8YGgHA+bNAPGbsCp5UB97r/fyoUhQOziiUkzrUp1lUhfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKHygQNL0p+pjqJwYKJIS/kyu/mnAER9t4QtwqgxJYs=;
 b=GFn2Hx2kUSjTg7VXVnkG/KjBGiW1RopAotzNzq1dyCi8/eyHAmZqZw60ISa4pb4Ix+VCgavpmdZCfxEnYJMskKDat3Gld4ZAp0+zhrEuPuYqZQVyKVHUljXp08Ljl87AokMY1aMOBj0HvfKBGuGD0q+0pYUjLhhHRAj7vA0wh9hSyAza7PCKYJ0ZH8T0H17mqFQiNDglhXFRHdvZJBbJZfZOmHkpkN9MwCU1Hpk8btb2TRqDjfBkhTlZMkJz7h3cEeYhqv1WGRvH6E5jET/FSbC0v49SdpNx+AdWamZhp33WpCklkyyJ9VDfBEuLzMt1YBpq9xSTZCy5Bm37RuhIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKHygQNL0p+pjqJwYKJIS/kyu/mnAER9t4QtwqgxJYs=;
 b=BfK/ANWsySM+eAzSYj3eH9dHzPBWk4J4tYGpCN+s1a1bnEOd2U4jFdnQ0lE23pwDiUJ83tq9Z0BXtNmE9LQY7l8b72vTxZ1cfqUvbkNyyN/vZ9NQKxGXNgPeLxLY8K97IiojfTKilAvZL1niUyuQCmiR1qB5uZt89lv+9NjdWHU=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4825.namprd10.prod.outlook.com (2603:10b6:610:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 20:15:14 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.014; Sat, 22 Jan 2022
 20:15:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Topic: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Index: AQHYDvfTRZNTkkSWjkWDIwR2Vc39WaxuD5oAgADuzQCAAEhDAIAAFvMAgAAd+YA=
Date:   Sat, 22 Jan 2022 20:15:14 +0000
Message-ID: <D583D8ED-8E59-4CB2-B65C-AD1C0B332DAD@oracle.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
 <20220121185023.260128-1-dan.aloni@vastdata.com>
 <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
 <20220122124710.4l5bzmfxhf2o2yee@gmail.com>
 <04E4C6DC-B78F-45DA-871A-296379B2D484@oracle.com>
 <b780f2adabad8beb13c0deca62561116b61e2402.camel@hammerspace.com>
In-Reply-To: <b780f2adabad8beb13c0deca62561116b61e2402.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94ed39e2-a3b0-4005-eb1b-08d9dde3e675
x-ms-traffictypediagnostic: CH0PR10MB4825:EE_
x-microsoft-antispam-prvs: <CH0PR10MB48258D02C95CDBD11FB4B7AE935C9@CH0PR10MB4825.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2L0RwGpjWXM+09Ape/YUroJIfKP4BSkaOdrqHIAGVPIelpsas1bcghLV3fp89i1prGRzntz7QsQaCY8ECl0ZLMAK6MOgHhVLSs00KSkzXVDXJMd4BE605XAXTx7cPw2iZTXQN2o8oGL/0/TvKsN++n2tUbDZ/F1jL57n/o8FuS8vr652KESwkn7KgnHHFDNY/hNbkuw7b2lqbKzvgT4eJ12/jlp4RD17MOCSJ1lsXSmpa1I2cBKKkabwVbDhvbOFem/BpEGt78lpBsf422YDK6NecGMEjpwPelBwYhD8/U5sGftxFb28ClV57mYYK8eUJxQnrhwq4y/XcsmekGfqzPTTWeYfwcxI19QDA14ajjAcm+1kLAmlYISov/kiGqyzxxicgUNTecGGShGD9Zoq30V22PDqv4FZD84xMoe8lUGLCg9z5454bxE+f4ZyqrcrqpTt2keCd0+8rIgMXIQhFVKhk0tiGXaEw7V103zrdhAyalqbPzqC3nSZZVwhQwBO7XK8eu3wfAJMU9mZB6ZZGsZOtCOO4DZF/QPBbb1gxbM68ziyW88CSSZVf14uubJ5C9zfIb9/e058W/BhSEqTuPVnIYIFZChXht1E+lqZnNeFW6ZkLxdj7axYVVxYpGmZylSDMiwyrbjyBwnlPUJIkpxL4iVJ4p2lU0EMg0eLnoBI6Yhg7OGQVWPK1VIAOhEKBnawRjxlxz61CXI14su2YCsjCYS+WcODVwmgldEXCiiFFKaLO3xHlnragUNVp2S85lpgQjKDaQrtokFkr97ohcMxxa6fvwiW5Z5BTffXkLyj4VHi8Tci0+gQCaa98cqr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(38100700002)(54906003)(508600001)(38070700005)(2906002)(5660300002)(83380400001)(6512007)(33656002)(26005)(122000001)(36756003)(76116006)(6916009)(2616005)(966005)(186003)(64756008)(66446008)(86362001)(66476007)(8676002)(66556008)(53546011)(316002)(4326008)(8936002)(6486002)(66946007)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UllyI1oq9/LJDCvcz36O1sgEbwZQbrOzkzi4huEaWylnY6lPVAkG6fO54gFQ?=
 =?us-ascii?Q?KwVdW3nAogFbsVmOpb3nCU8EnEvR/K4v4MIBcf0kU3VEJJ3TwDg6Kin9z7Bz?=
 =?us-ascii?Q?V50UpwRjsMVSeW1ANO9sHOm8bS5DjhLv/mOeoLnmCrMN5BTnuDLWg0wqE5vd?=
 =?us-ascii?Q?LkskfUwk7KcvHgW21I33rsamFDohib0ApHHMjLmipEGy3sDQUZFgymxBGa5Q?=
 =?us-ascii?Q?legUufFpiRzqIJJkyM3RxYBRdWtQLK46PhCYCPREdDATD70gQCEFcEfqZNrV?=
 =?us-ascii?Q?vsb7dX7vs2PYerbC8CEuWMQn+cNy7rS4kmPOba81l2gmnDJlc1Xckgzor8cU?=
 =?us-ascii?Q?Y0WHmS20si0kQIBdsM9CCTwD9LxCI8EqGvIt08PXVw2OxkzELO7LsFo4lrAS?=
 =?us-ascii?Q?JPQz4vEN9AJg6BBjkboJjURhFNs77OfsogxOkZwakltqFErIxoK99q27LTa6?=
 =?us-ascii?Q?Z0irBLdAWB/L/cqpOsrObyJu/m8Y4jvVnPgA99IjYVtXj4LSnNdaZ2Y2/PI8?=
 =?us-ascii?Q?BVtAEvdRm3YH7/gHYFtBnDb+AQfWZig4c+eSz92U8eFgBeodk0YaqFy8Ohq/?=
 =?us-ascii?Q?zEzfmcGVif+T/41w6JZsRHeaQ4LmCrmvevzWHkPr/fZcd2olPRxXv76fgMHq?=
 =?us-ascii?Q?QYTonJ4COk72b7SJeyEidUIHhIYpb4e6jubk3+xHXq45FU32++ojC/kRdcbL?=
 =?us-ascii?Q?T1YLLGjh2Ds7JKELD45HGrL1kAuna4u9nDEQbpG0PWOb3+NP1bG12hUlYP4/?=
 =?us-ascii?Q?gsjiiYqFZrRkFs3shxspRKqEXRA5dAPjdGTRHx2JmS/uf9RNsuR1e0/G/61k?=
 =?us-ascii?Q?GAwTdnvItJJiMBGe3QTUm2q38Rok69OtCEiShNqtfL3yHFlVbOE16zvXoZoI?=
 =?us-ascii?Q?tkala3wMkHfbnqXaF0zcqoFX/VfweqSu0OGp3x8UQQGs+sdtzhqSJ6IkfVAf?=
 =?us-ascii?Q?FwbfFHSpJW7fDZLb17C4dqUgGE14olASSTMF8jzVQSvIgYVvdYzvnVbmsozt?=
 =?us-ascii?Q?nzP83eqZr0cJm73YOdmsVNuJUU7Vok+b4t61K3cFQS0smX87mO+3IhIzTTQz?=
 =?us-ascii?Q?jmuXCGPkU4zy/AEi36Qny74bwrT8PEoOc7PBxSoVTW9n8hssHEMJA1ov3tCt?=
 =?us-ascii?Q?IV7htWHU2DElD0f98FQEXCAr8Gu/akKayH+RdmSEbouTSlwLCpUD9t6QKJxw?=
 =?us-ascii?Q?fEhi4RwC8xkLk53HtZkcxpczmELjiiHOKM2qrYEDz76kLkus9x8+OzGIsQxY?=
 =?us-ascii?Q?0+QpI9uSfRim35L0jj1ygJ6mapvlshZDr9jek/5RlxE/+4aaBhiI/QEU68dy?=
 =?us-ascii?Q?z8I5RcGHVAThtzd5T5JgXz2Rgo4w1zAUMpCkiSipO0NbH+TDD4nQ6gF7BfIc?=
 =?us-ascii?Q?TKwudMIUfTXDVnz+sJlxo7I4X659wTabPAVHpMnlwMr55rbvfRs8GW5Ab5NW?=
 =?us-ascii?Q?0G4ng7shXPitxMvrzMrf5LIdqMjs6CoAtcvWPDQUZdR4XLcAvpDoNwha0JRl?=
 =?us-ascii?Q?UEFIOmPx0dGae5AGSouGhkA6OiONXPD81OKTG2sPwUMAQVF9MTj9XVZBhT6Y?=
 =?us-ascii?Q?W3fx+r80yZQ1GKC7Bbt6STYRubxGJxnTxW7+0qwDLgszvZUjx60SXABucteG?=
 =?us-ascii?Q?mCgr8dAhjEFmcwsIveLK288=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8980BE22905CB744B0C59FCE33E76441@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ed39e2-a3b0-4005-eb1b-08d9dde3e675
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 20:15:14.2801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fIpT+cRD1X0rponk9VIoMlnN+8jzGiHHsz+3n/++82koX7jg5pJakVD3Ff4ZsA+30iZJ+x1ik6lq3kIjVnhow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4825
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10235 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201220144
X-Proofpoint-ORIG-GUID: vJCN9K9sLtO2bB20lw-5X28soLfJrB_3
X-Proofpoint-GUID: vJCN9K9sLtO2bB20lw-5X28soLfJrB_3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 22, 2022, at 1:27 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sat, 2022-01-22 at 17:05 +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 22, 2022, at 7:47 AM, Dan Aloni <dan.aloni@vastdata.com>
>>> wrote:
>>>=20
>>> On Fri, Jan 21, 2022 at 10:32:28PM +0000, Chuck Lever III wrote:
>>>>> On Jan 21, 2022, at 1:50 PM, Dan Aloni <dan.aloni@vastdata.com>
>>>>> wrote:
>>>>>=20
>>>>> Due to change 8cfb9015280d ("NFS: Always provide aligned
>>>>> buffers to the
>>>>> RPC read layers"), a read of 0xfff is aligned up to server
>>>>> rsize of
>>>>> 0x1000.
>>>>>=20
>>>>> As a result, in a test where the server has a file of size
>>>>> 0x7fffffffffffffff, and the client tries to read from the
>>>>> offset
>>>>> 0x7ffffffffffff000, the read causes loff_t overflow in the
>>>>> server and it
>>>>> returns an NFS code of EINVAL to the client. The client as a
>>>>> result
>>>>> indefinitely retries the request.
>>>>=20
>>>> An infinite loop in this case is a client bug.
>>>>=20
>>>> Section 3.3.6 of RFC 1813 permits the NFSv3 READ procedure
>>>> to return NFS3ERR_INVAL. The READ entry in Table 6 of RFC
>>>> 5661 permits the NFSv4 READ operation to return
>>>> NFS4ERR_INVAL.
>>>>=20
>>>> Was the client side fix for this issue rejected?
>>>=20
>>> Yeah, see Trond's response in
>>>=20
>>> =20
>>> https://lore.kernel.org/linux-nfs/fa9974724216c43f9bdb3fd39555d398fde11=
e59.camel@hammerspace.com/
>>>=20
>>> So it is both a client and server bugs?
>>=20
>> Splitting hairs, but yes there are issues on both sides
>> IMO. Bad behavior due to bugs on both sides is actually
>> not uncommon.
>>=20
>> Trond is correct that the server is not dealing totally
>> correctly with the range of values in a READ request.
>>=20
>> However, as I pointed out, the specification permits NFS
>> servers to return NFS[34]ERR_INVAL on READ. And in fact,
>> there is already code in the NFSv4 READ path that returns
>> INVAL, for example:
>>=20
>>  785         if (read->rd_offset >=3D OFFSET_MAX)
>>  786                 return nfserr_inval;
>>=20
>> I'm not sure the specifications describe precisely when
>> the server /must/ return INVAL, but the client needs to
>> be prepared to handle it reasonably. If INVAL results in
>> an infinite loop, then that's a client bug.
>>=20
>> IMO changing the alignment for that case is a band-aid.
>> The underlying looping behavior is what is the root
>> problem. (So... I agree with Trond's NACK, but for
>> different reasons).
>=20
> If I'm reading Dan's test case correctly, the client is trying to read
> a full page of 0x1000 bytes starting at offset 0x7fffffffffffff000.
> That means the end offset for that read is 0x7fffffffffffff000 + 0x1000
> - 1 =3D 0x7fffffffffffffff.
>=20
> IOW: as far as the server is concerned, there is no loff_t overflow on
> either the start or end offset and so there is no reason for it to
> return NFS4ERR_INVAL.

Yep, I agree there's server misbehavior, and I think Dan's
server fix is on point.

I would like to know why the client is looping, though. INVAL
is a valid response the Linux server already uses in other
cases and by itself should not trigger a READ retry.

After checking the relevant XDR definitions, an NFS READ error
response doesn't include the EOF flag, so I'm a little mystified
why the client would need to retry after receiving INVAL.


--
Chuck Lever



