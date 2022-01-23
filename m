Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF66949739D
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jan 2022 18:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbiAWRfk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 12:35:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29144 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229918AbiAWRfk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 12:35:40 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20N8Na2O006305;
        Sun, 23 Jan 2022 17:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vJIbaLTFxRwzDw9M2TQi5gNOL0UFHfr9QIr7UJNVNUY=;
 b=vptq5hmB8p6zbO/8mIPfqFPfIbn9t/66n0BF8iSNBvp+khq0YvpQUQhX+2weLWhRti8t
 wVZ2RPL/ZETp6jq+eYVWzKI7PGPSIxVDuNt9SZ66ykZcIYVAn0qeFArdBMOKv6V7qcsJ
 Qyv77MytK1XrlUSjA+cxXsVVUtGIJX4TP1oYmSakUFFth9lYmDO4pYUotu3gmEJzgfX2
 9C+Pepjg3bjPWyibwZ1XUImjiLXUIl2y527GeitEiWW+NNksf4HnAs93z6KiRNesCWKg
 UtdbDaLdDaZI2EeW7jn6TIAVV1lAvuWXB5eCWIy1IcfLvmiCNB72IuK4dGFMLsfR1JIt PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr9hsjf7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jan 2022 17:35:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20NHUKbh173695;
        Sun, 23 Jan 2022 17:35:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 3drbcj4n05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jan 2022 17:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7PRW2lvhL+4GW6G2uIkeiuc5rbdyeiFyI5sHsiAhldLZq6QSlB/tAw+/HJOeCLParcAQDENCY4aMEBq6lNKH8jQuYVlQgzl4SqpusRsLhrrm7Qk/GN8BeeYYwKm5NpNeHkg7d43M4z+FwNwB5o9DmJef0ZX7Ogm/UFpHvjiXlRhUZcacDoZL4b61abL22QIEl8UUcA/YhB3ce80mwEPqtJ1OLzekyqzbSZQZw9MuvTouiuRstieC7uywu3+Xv9u4PqCuLps8UiRm5VtCTjo7KpSuF9xHx4Vl4dt76iz8pWQ+DIcGOxSI5UOqqAOxaCdLgnVr60hMvhCHiDVYLZGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJIbaLTFxRwzDw9M2TQi5gNOL0UFHfr9QIr7UJNVNUY=;
 b=FjL61QBYTJI6VgJempbotO7AuHiwUeZ1L9jfE5JkJ9UfB4i0TIbHSe6Rk7TCB4AfVTEJUjB7N7TWoZWhQcCTMcCAXPw7ADczzLYXtEAsZqUg7f6D4HC2BO6PSqLvu2vcN18I0N0kyrcYUHm5R/vD2034T1qZKBYupm/fpk0qccs3dJJlMfuYXz8ElmW2Exr+istzpdEwFiDkDGm8mzwaohz7gw3+S8mMNwCxVW9zqmACIlkTXn/9BJtI1yjCPVAZr5DWzjNBSBFJhABHFZMRai9nPMWbiGjSwwVgUjFeUMglFeDcrxjtTmw4H6hyrJl7qKOw9Pc0j6vYkt1OFEls3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJIbaLTFxRwzDw9M2TQi5gNOL0UFHfr9QIr7UJNVNUY=;
 b=M60dpDXqZF+5l8O+jRR6G/mCQNPcxigG4sd20M+Hq75vmSwYvvJUDoA0IO14B8prfRP35uVTKYAvUTCXC1bH+6oUNj69DIHeo8JvnDVOTv6Xcb8pnpQHwZHLAUq4DaalpKZ01f/DiBE8rJuwA6vdnnkp69VySSpOGFJLXD9PKfE=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by PH0PR10MB5530.namprd10.prod.outlook.com (2603:10b6:510:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Sun, 23 Jan
 2022 17:35:17 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Sun, 23 Jan 2022
 17:35:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Topic: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Index: AQHYDvfTRZNTkkSWjkWDIwR2Vc39WaxuD5oAgADuzQCAAEhDAIAAFvMAgAAd+YCAAAROgIABYVcA
Date:   Sun, 23 Jan 2022 17:35:17 +0000
Message-ID: <3B062CE2-19CF-4D3A-AC93-2D120200EB78@oracle.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
 <20220121185023.260128-1-dan.aloni@vastdata.com>
 <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
 <20220122124710.4l5bzmfxhf2o2yee@gmail.com>
 <04E4C6DC-B78F-45DA-871A-296379B2D484@oracle.com>
 <b780f2adabad8beb13c0deca62561116b61e2402.camel@hammerspace.com>
 <D583D8ED-8E59-4CB2-B65C-AD1C0B332DAD@oracle.com>
 <93ef05db51a61c9d2d31788ec96f477502ea2a1a.camel@hammerspace.com>
In-Reply-To: <93ef05db51a61c9d2d31788ec96f477502ea2a1a.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aee7d817-a80f-476b-526a-08d9de96b8be
x-ms-traffictypediagnostic: PH0PR10MB5530:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5530F5B67A73B91FA710484D935D9@PH0PR10MB5530.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QUknRWvYDGQSCvVS70BLC5cytfyuX+V+JDH3uHlIvPBQtf+hstg0/4rMsHf5AfqITEj6jf7WRBjsqeT+0u5DkjdN5p/yRK813S5QkwMrgVOJHRv9i9hc6fV4oSi9527I+PUAPLBBGFLTZhypsz77zsOAO/w5elFFSHpMCQ8DiiuEPVellLqrAlFdO6OMJeMTnaUioUsqRvmgAXpDy3s9p+k53JBFXPow4mq4s1f3noKD7sR4Kc62AoCOHKKokZWuBed2p/O8bd8zxNDzRtV1lZrP8NQE75S8MUsHSrJFUBRXiW1D5nvUEoKiHGtyS/BzPIa2MciYzM+NxFQrzAVtSvGah68qV9mv2+kkag8n/Bj6M1jh9S9nXorORu8SUJutToYyI+IsIp0TbkKnrIpTNiLorZZlSLfGriFEJS7hnGSNInnqqeUnxYfBOVP4pHgE69ZJa2jTeT8ijZ6fcqSvRVJXo0OI2nwSXdv60VBu4Ul0FG2tW50YaJpPnUew2jfHcRaM8JpMMZVqEnR+gHiVaJbyPAFidxfNv+cbltadDe0pN9mLcRrTAol9YbNv4MpQGbf3Pqu9Kj47934Y4WF2ktQERgioGDp+sTjGq4iUoGn9Rd/3NN6TxCOKuYrT2D5sM7bPIQh4skJa0GoH0jwTYcdVONqBUR50V72kD9JQy1CZy00gxaWtfPkEgmOoxv8z4sJ73oTDQnMSIDEdOC7fg0hjB+wH3sNOhw8eaz8DXRook/n8dBCL9quGuSK5Oi0Piv3gCPZmLVcc9FAwBJdMTS967gXS4EwmDZasvEl7I5x4wqtBBn0dIgzlnSauwZd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(83380400001)(6506007)(86362001)(76116006)(2616005)(8676002)(53546011)(38070700005)(6512007)(54906003)(316002)(966005)(71200400001)(6916009)(36756003)(5660300002)(4326008)(8936002)(6486002)(66446008)(66476007)(38100700002)(33656002)(66556008)(186003)(64756008)(122000001)(26005)(2906002)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9AhcUWPRnpJeitRFH58xyW8jFBCvzItq1wAsCrOBPiQKMs51KO7ARfNbEyzd?=
 =?us-ascii?Q?vdfyNm2BTkEKuOsy1BO/2wh9qoiP0Z8ehkAagGZZmpBJXKwE9tsQ6YxspRyc?=
 =?us-ascii?Q?kM5SFSmyKa5oRsTipVS8Gj+e/HpzFGbgArwhSlxnaffv9evEljia7U5a0wgC?=
 =?us-ascii?Q?EnM4sGVuUD5fYEBYPuuX1PX5toROwdG17wqi03s+xFOztLMsM3Nz3B3vSlQp?=
 =?us-ascii?Q?9682YF9jDTAke4iFNj7JZXqoEp84ipsClS6x17IXHToIvihnSOMPjP3gi+b9?=
 =?us-ascii?Q?928gCgqKutDWvDMkE/7d61iXknNe457aKCyGYFiXGiSkM/+aY7O6wP6UCXVt?=
 =?us-ascii?Q?4g4VhyZ9E2JLEVC1PDG3uTZ22yULpQUkydSWzPEXn0SvHiM6CJXeg+aZSaMO?=
 =?us-ascii?Q?oY8x5WsQ2RHbqNgs4TfAxDEhDhuGIQEy2pkG74sSwYpHBf795qMoC3FQo5t7?=
 =?us-ascii?Q?utirKV6BHA5cyE/mkTT9Cpc13V8VxwQll8UsqbCuiBAhnWzpoYMdVQ5dckt8?=
 =?us-ascii?Q?yQNFmlDLCBwsRJJGX98/j8ODK2iv0mDfMQCcKJpxSLg2o5oFuI613Lxlf83x?=
 =?us-ascii?Q?VbsZ3TMGHcT1s/Zj0+FSVL55kKRP9E0H04hvW7HFDqm+1RYUN4VU0U4efl1Z?=
 =?us-ascii?Q?Hre0+1QrWj87HLprJthoLfcuXzIGe4ZObzZYRl9C/ur0cMeJugNaZJpNbQzE?=
 =?us-ascii?Q?XC2S0OUreeBCYVyPQ3anVP9nvkLiOTSEZvAr1TYFqtBvWXiUUwW17WHhu2m2?=
 =?us-ascii?Q?dTjwAlpolCYjlfZqo3ERu9O79h/Wl8FOcxwmVZ+s4ODRX5n5Uap0AYlaqM0g?=
 =?us-ascii?Q?O5NmbjwsLHFpfGN54Hssx6qZsknjXn4LvCKYi77NwaYnrUkPRxYinWBKE63d?=
 =?us-ascii?Q?THRXiAwVgwgzfCwjawZCvfqIyuufRtyxSrpqDD6jOlswRkg2IiN1D3jj+kPb?=
 =?us-ascii?Q?0J0fBsfGpiS/YM5Y69XK5V+Mzl5WZF6wrNKDVdScGsG0Chiaz1ZlocEMhgNA?=
 =?us-ascii?Q?QXcwlZADItALCDTj3RSkwrMtrzm4KyxjPdo/7O0SD2K+YCSQO/BilAot8Vap?=
 =?us-ascii?Q?alRBprfYfk3Cs81LT0TzJEHqclzPONxcFrSNTpqr0XrFxI4nVo33F7TzUUp8?=
 =?us-ascii?Q?jmlVoPNmQYrSkOFOhXqMOmaSEFKRX+0867iQw7mBQfEZO6i+IoGCS13c6TUy?=
 =?us-ascii?Q?IXghxy46VEERV3O8kVkOrlIsqyuA14XWoKmjN40QoLArN0qEH34Q4aobV1i2?=
 =?us-ascii?Q?4DKTSCc9P9PJfPr/Wx/1f2oHbZDHDuwcxqbDHs2TeMv4UC3Ey2WKZwOewj3e?=
 =?us-ascii?Q?/yPlvzAYQLkKgwjyf90lXw47LKoZzxzlTVYLw7IMNwFp/ZzG1UnIxvUge+gm?=
 =?us-ascii?Q?GoJqb07FW+ZBetMEKOZE0zrMHP4RXs6/pECg2oqcRIHDvRMV6AbQbBPYCdKs?=
 =?us-ascii?Q?/JxdkQRQMzgsf6do/GVtsSLVF49n++6w02wIABorBK6oSoOoIj+jKVluSFB9?=
 =?us-ascii?Q?TWFminJ4OYMc2XJnWv5rwpfaDWDhwgf/SE1QcZFh0sPehnEq6FvW9bpYlvPb?=
 =?us-ascii?Q?pxU4IaxxTHbBzCn2cKk8cE1bJcs0EAHw8GZAu2UhUG+m4c5YZwKQBQn9HOiJ?=
 =?us-ascii?Q?/ttvE1l3kLWmygcZwlKq+iY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4FA19837E2DDD438654B135CFAC2BC3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee7d817-a80f-476b-526a-08d9de96b8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2022 17:35:17.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8ehJ14zI0i6i8Tm8i3Aylb/PkULDrcajL5mFkwl6MJBPqp/iE/z5wZ7kJm4Tj6Pp2j2cUdORKPsUBcsiFY7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5530
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10236 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201230135
X-Proofpoint-GUID: TC7wJE4C1xtrwJsf-Fm6FH2I94gFO_h9
X-Proofpoint-ORIG-GUID: TC7wJE4C1xtrwJsf-Fm6FH2I94gFO_h9
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 22, 2022, at 3:30 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sat, 2022-01-22 at 20:15 +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 22, 2022, at 1:27 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Sat, 2022-01-22 at 17:05 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Jan 22, 2022, at 7:47 AM, Dan Aloni <dan.aloni@vastdata.com>
>>>>> wrote:
>>>>>=20
>>>>> On Fri, Jan 21, 2022 at 10:32:28PM +0000, Chuck Lever III
>>>>> wrote:
>>>>>>> On Jan 21, 2022, at 1:50 PM, Dan Aloni
>>>>>>> <dan.aloni@vastdata.com>
>>>>>>> wrote:
>>>>>>>=20
>>>>>>> Due to change 8cfb9015280d ("NFS: Always provide aligned
>>>>>>> buffers to the
>>>>>>> RPC read layers"), a read of 0xfff is aligned up to server
>>>>>>> rsize of
>>>>>>> 0x1000.
>>>>>>>=20
>>>>>>> As a result, in a test where the server has a file of size
>>>>>>> 0x7fffffffffffffff, and the client tries to read from the
>>>>>>> offset
>>>>>>> 0x7ffffffffffff000, the read causes loff_t overflow in the
>>>>>>> server and it
>>>>>>> returns an NFS code of EINVAL to the client. The client as
>>>>>>> a
>>>>>>> result
>>>>>>> indefinitely retries the request.
>>>>>>=20
>>>>>> An infinite loop in this case is a client bug.
>>>>>>=20
>>>>>> Section 3.3.6 of RFC 1813 permits the NFSv3 READ procedure
>>>>>> to return NFS3ERR_INVAL. The READ entry in Table 6 of RFC
>>>>>> 5661 permits the NFSv4 READ operation to return
>>>>>> NFS4ERR_INVAL.
>>>>>>=20
>>>>>> Was the client side fix for this issue rejected?
>>>>>=20
>>>>> Yeah, see Trond's response in
>>>>>=20
>>>>> =20
>>>>> https://lore.kernel.org/linux-nfs/fa9974724216c43f9bdb3fd39555d398fde=
11e59.camel@hammerspace.com/
>>>>>=20
>>>>> So it is both a client and server bugs?
>>>>=20
>>>> Splitting hairs, but yes there are issues on both sides
>>>> IMO. Bad behavior due to bugs on both sides is actually
>>>> not uncommon.
>>>>=20
>>>> Trond is correct that the server is not dealing totally
>>>> correctly with the range of values in a READ request.
>>>>=20
>>>> However, as I pointed out, the specification permits NFS
>>>> servers to return NFS[34]ERR_INVAL on READ. And in fact,
>>>> there is already code in the NFSv4 READ path that returns
>>>> INVAL, for example:
>>>>=20
>>>>  785         if (read->rd_offset >=3D OFFSET_MAX)
>>>>  786                 return nfserr_inval;
>>>>=20
>>>> I'm not sure the specifications describe precisely when
>>>> the server /must/ return INVAL, but the client needs to
>>>> be prepared to handle it reasonably. If INVAL results in
>>>> an infinite loop, then that's a client bug.
>>>>=20
>>>> IMO changing the alignment for that case is a band-aid.
>>>> The underlying looping behavior is what is the root
>>>> problem. (So... I agree with Trond's NACK, but for
>>>> different reasons).
>>>=20
>>> If I'm reading Dan's test case correctly, the client is trying to
>>> read
>>> a full page of 0x1000 bytes starting at offset 0x7fffffffffffff000.
>>> That means the end offset for that read is 0x7fffffffffffff000 +
>>> 0x1000
>>> - 1 =3D 0x7fffffffffffffff.
>>>=20
>>> IOW: as far as the server is concerned, there is no loff_t overflow
>>> on
>>> either the start or end offset and so there is no reason for it to
>>> return NFS4ERR_INVAL.
>>=20
>> Yep, I agree there's server misbehavior, and I think Dan's
>> server fix is on point.
>>=20
>> I would like to know why the client is looping, though. INVAL
>> is a valid response the Linux server already uses in other
>> cases and by itself should not trigger a READ retry.
>>=20
>> After checking the relevant XDR definitions, an NFS READ error
>> response doesn't include the EOF flag, so I'm a little mystified
>> why the client would need to retry after receiving INVAL.
>=20
> While we could certainly add that error to nfs_error_is_fatal(), the
> question is why the client should need to handle NFS4ERR_INVAL if it is
> sending valid arguments?

As I said:

I agree that Dan's test case is sending values in a range
that NFSD should handle without error. That does need to
be fixed.

However, there are other instances where NFSD returns INVAL
to a READ (and it has done so for a long while). Those cases
really mustn't trigger an unterminating loop, especially
since a ^C is not likely to unblock the application. That's
why I'm still concerned about behavior when a server returns
INVAL on a READ.


> 15.1.1.4.  NFS4ERR_INVAL (Error Code 22)
>=20
>   The arguments for this operation are not valid for some reason, even
>   though they do match those specified in the XDR definition for the
>   request.
>=20
>=20
> Sure... What does that mean, and what do I do?

Let me try to paraphrase:

A. RFC 1813 and 8881 permit servers to return INVAL on READ,
   but do not specify under which conditions to use it. This
   ambiguity might be reason for a server implementation to
   avoid that status code with READ. Have you considered
   filing an errata?

B. Though the RFCs permit servers to return INVAL on READ,
   the Linux NFS client does not support it. The client is
   not spec-compliant in this regard, but that's because of
   the ambiguity described in A.

C. Therefore the Linux NFS client treats INVAL on READ as
   unexpected input.

I claim that when confronted with unexpected input (of any
form) a "good quality" client implementation should avoid
pathological behavior like unterminating loops.... That
behavior is both an attack surface and potentially a
problem if the client has to be rebooted to fully recover.

The specific behavior of returning INVAL on READ is being
addressed in the Linux server, but not root-causing and
addressing the client's response to this behavior leaves a
large set of potential issues in this same class.


--
Chuck Lever



