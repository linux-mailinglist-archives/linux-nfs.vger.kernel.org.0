Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF9A4D8B4B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 19:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbiCNSGf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 14:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiCNSGe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 14:06:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9603A5D7;
        Mon, 14 Mar 2022 11:05:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EFTJr8009897;
        Mon, 14 Mar 2022 18:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QL0sHTpekNxxx3mOTbjKsvN6SIHToy8evelNg2oZW4o=;
 b=MUMXFEVUIhJjLXqPz5KxQx9jzWqo4MvL784X96B2LVWIUCgYX7dd+ncbfXwB9Uw1u6HW
 6FsMutRGDGcpVO4CJ9w1MEilhCOvLvjvkACDiB1AqyW/gg84B1jicXjB1slsqYvLHdKw
 /X22Ui0ugKsKt1lmOw4CmzmQ23Q5ZH6qPnHfDFSW4EL5Jnf09gDaK4Gvy1K+If1Htn8L
 anKtf87+wu3geJoeaO9wGKNunGC6tmTxnrncz1CMROCqAd1XBBAx5FM/0+6StgC/ss/q
 XHHWJ2YG2joQmKyjZMgNfmldCAKNMLDeK4Ud62SoqolaffPvoOQvz6N0s+eewy5psJ+4 eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwh05c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 18:05:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EI4pjG170668;
        Mon, 14 Mar 2022 18:05:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 3et65nxgwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 18:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlTb52amk9/EMry1Ifj6k1lzV7HK6Ex8seosNwfF3wV23EQSxyC3gycZq626+Zi8rnBufeR+2eyifdNP/cy6impH3XD4xpmR0i1ENfonQfOkB1lXNBTP2Gwi62BrdlmVj/9vQU9TE+oADb4QiP3nAebDX51QCnbqXEQfnILEt3NWjW4iPuCUWnfp6VH6+AMRNzn23fiPg8itXbQEdwkajqRT7xWyJI5G02+gHcch2MJwOPvWhM4gsh16btGkYf6hSoxVGjlJcemvd7+kDo1vvYOahaf4UY85puP1pRdgZisrBwr9R6R+mWGDaovMljZ/rvm8HbLqGah1fWW3h4gwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL0sHTpekNxxx3mOTbjKsvN6SIHToy8evelNg2oZW4o=;
 b=UEfP/HyZ83vDIwOcBEepaRBBPpwyvUzCzPH5xRt0Ar9Pwh+AHPx7v/YqeYsRD9dlOgSV4/UfK90vTvDsUcHkKFwO1c/4/HoWbqFbe625E2nnVmyiMt2ygeNzap0D5ZZWoO1+CadAxZ6i49WsxJt1rF6BlTLJYbBPzkMWmdCzhjgIIXNeBv3mSaFqOozyJ3HmmyEhD0PrwAwDTtgiMhm4DXrTezrQi1+IiVQ5Q/0Ztd+MmsujUpBmfMVQtJSpkh2fP39+hBQaDvS6Fl8tecuDPKze6QZFBjaqPR01AAqrcZSjW9bNn6L3u7F1XCDrz50GtUQlztVfNJY/mnXsWzl8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL0sHTpekNxxx3mOTbjKsvN6SIHToy8evelNg2oZW4o=;
 b=yf3laHlCtwRydh+nrONYZr5JngCwOOMEWXGRtfO4l61nYGiPuDgEoU3LJA55RqCUBFl34kA6RiQDH2sPuZuoOhv5VkJvQV/uUMIzaDgMUfjsSpozCLOLyQQmzjLoNbQbmqju6rRkt2mw06sHdeDgYbY6n7/59SxMFuHk6BwPAx0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4499.namprd10.prod.outlook.com (2603:10b6:303:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Mon, 14 Mar
 2022 18:05:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 18:05:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Thread-Topic: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Thread-Index: AQHYN603kl3z/l9gp0O8Q+O/wElPrKy+9RWAgAAmfQCAABEuAA==
Date:   Mon, 14 Mar 2022 18:05:15 +0000
Message-ID: <D5859D5C-229F-4377-98FE-314EE2C80721@oracle.com>
References: <20220314140958.GE30883@kili>
 <251A4166-DCCD-4C84-9819-F350D17A7298@oracle.com>
 <20220314170344.GT3315@kadam>
In-Reply-To: <20220314170344.GT3315@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6170fa61-c8a8-4a9e-2572-08da05e53105
x-ms-traffictypediagnostic: CO1PR10MB4499:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4499CED80351AFD70C49FA39930F9@CO1PR10MB4499.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBdBAnOl8+bVMmRm5ovaZ4E7coDWnuTVRod1xenIV7f9vaxvf/Bmgm/fgSzbSMykWz1PddOPRLcq+oHjKLXow6/I/0D5WNAVNt/+gzxLGG+GO+4c24Ldlxw7tLegMGYOaEZNswCb+2Us0i9mkSXfzDrSoRpeSjT2lzV1Ptk4w0XYcWr0cC7+GLNef3OG4LTpPxZ1SGgxFUNKOI2jLrcf+lueSR9LQ/zFRQ5v0c2gWAUBUskT3dcL/8+A4BEisC2C9vhqHbAqSPKjCaX9jT2rrfovH+/nhVsx74n2D0DdDSFn+yQBITf9jTTcyOkCsm2574a/GKVULxVaG/NuVM6cD1JQzs4JsC7r7MK76eirjUtxtpSCajBM0gGvfbL1V/x60gGewkCX4V7ZaNffOR3rxyisoUgKO6WXa3TQOvJv6aSOhTEoCH5cBWXuaotH0RXrNMy8h3/Wi2O2yIokypH8qhU0hGMxigTOUSxbVq49sH2YtcfHkRLNnM6XoM2+2eIhHzYeUkNsQD+LURxZhuy0wTjMe083ORIF56r25SwLTgUrwoTsk3QS4Pz0BwfQkqKf71khuYPgTykuTEyi7cDC7tu6yHoMKA5/wEOpbQbA8wny1WPpRl+aBPoONGq8fIvCnpEygy4Tt6C9nyul0SOFjcQAHbLgoU4i3PfT74l9zWqC8LirY3xrwsy4Wy+QyUhOiQlOJbf2/z49lOWNvTtGpsAmlKXYZTA5MnWdhDYml8oT7CSTQhlKxazYjxVRyYpO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(5660300002)(6512007)(107886003)(33656002)(2906002)(122000001)(36756003)(71200400001)(66446008)(38070700005)(66476007)(66556008)(4326008)(64756008)(26005)(76116006)(6862004)(186003)(8676002)(8936002)(38100700002)(66946007)(53546011)(6506007)(91956017)(86362001)(316002)(37006003)(54906003)(6486002)(6636002)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4/0ip5q/PBW3104NMkaDDlG+End6R+Fc15AEQGknYoMjTRW4DhIvyazLUMo1?=
 =?us-ascii?Q?cQTyVwkYWi/5Dy6m6e30x4JiUy71Ef6Ryfcca/f9yQGwE/AZgD6mX1nf2LQd?=
 =?us-ascii?Q?th5ivDiHFryrOD0o8dJbFLvu5NRjSINCYaA4GasUDYeAtG/V01GZa0WwMoll?=
 =?us-ascii?Q?Mw2IwvTkDxGWXi4vLEpGUSpNWgJ1KBkaBYUrLbzkIB43pqKLLD9i7c4/06eQ?=
 =?us-ascii?Q?YrIh/H+6dG8t4JD+fsRzSGua34odm5JwuUEndgJ5Dd5htCl/+zMgUG29HJxt?=
 =?us-ascii?Q?gax6+bCidlh2pSgvPTT5wU4UKcrJNhCaVMhJp+yZfiQi/6XoP6TTkLB/boST?=
 =?us-ascii?Q?dW3XrPQ3BKXLa+diTA55o0tg/55EMR3LCDFAQdjdZs7e+knLliYCIaCFokPd?=
 =?us-ascii?Q?JQXg87TD0c1CAqvCgCPm5B5nuj2m9oIShm0rJ/8RQxfwPCbh5aHh5e6m5jyu?=
 =?us-ascii?Q?fhbPMBYwaIvCRH4LQAM820QvLFKEKamwbERYpYcooyS3Tq252/0Rv+0lQqtN?=
 =?us-ascii?Q?s74d+hSbbO+IegtA7U5XBe0g413BU3KGKeroA36drXsEk+j4NO0qCLyDmfdW?=
 =?us-ascii?Q?71IXANXMo2KaS3uskGaO7L8zYPf3ZrsNWu7q5xxgD8gaXPWY838gbSThJw99?=
 =?us-ascii?Q?QbfRS7U8KvPSASYAfQ/kX9wAUrx88MdK88GwLdChs+DiPbcW10Zv+KgU2Csv?=
 =?us-ascii?Q?RTQflnDHrs2183JdT9lIYQPe5xLYsk6DtaJmDTNGreZNn/5yKiHVNofzjKtA?=
 =?us-ascii?Q?n5NLMn/YyDv4Rj9le7Ao0nDsW0CKMxyf53AZAcguDcWdZ2tpUUv46geBYUiQ?=
 =?us-ascii?Q?hl6+WXGuSdBYGQli2cf/NMVudYZd9THf6+JGZbLs5TKHOxTWTmqozMrbct1X?=
 =?us-ascii?Q?EqE0CYv9SxgonKtDAa1I2djh77P39Pj3DTXtgd6lV27brZOcNhuiMEWFiTKO?=
 =?us-ascii?Q?ZwoFGQ65eD132c2PmIFs/uyzLhCKtMUUff8RZUafdCcgqSiJisdlj5gejteu?=
 =?us-ascii?Q?FlB0kWoFaIfhTPV+V2r0i4SVMilPq1OThTo7aNTZsmUjKvILMFiWL1o2W2Jz?=
 =?us-ascii?Q?MkH9jzpoJh0Z6T8eYdHV72QasRxfIjbKjC6YGB2b8aTHHO7o48pmCqU+RDQ6?=
 =?us-ascii?Q?yVJ82Tw0/RWBgVnET9ein02rQ3sPzhTM8ITQKV6U/2ytvUTi1oO2LtN5gR+1?=
 =?us-ascii?Q?kN5XtWHiHqCgPRXgsQx73pn5vc6Ju4+ZM2Px4WIMB87ZJqqciFQPuNZlcUqF?=
 =?us-ascii?Q?AETD42Mh0sLdCzAgU8/xs4tD5GD5zYJK9m2b5X/1t8ixWx9oB0R0q22SoScs?=
 =?us-ascii?Q?SErZiCkKqgKRNXOjnSQbHbaP8UFsXa3cX97unLiZPl5zpQaU7QqqkfGLqk7q?=
 =?us-ascii?Q?aSnk5/JE5u73wshdaXdeAEjEHTpATwOET8niPS4uSgK2BidtUFhqYMSvf4BU?=
 =?us-ascii?Q?TRNwBqcsjJNFZqgzYtQHl4QalD0i/Mg28lN2FNBVlk9kw6K2GSjOew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C4CE45C867E39498E77DC19D67914F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6170fa61-c8a8-4a9e-2572-08da05e53105
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 18:05:15.3948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ind/0cCBWwTotm1+C4CfO5oOHuNQB91DqmxguJs/GhaSO8XLNX7TE5HbmYuTRQOLsLMKW/J76NiKcR747dkSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140109
X-Proofpoint-GUID: _FMemwDaN5u1vzJ0wMPzjdDrWz2tn0LP
X-Proofpoint-ORIG-GUID: _FMemwDaN5u1vzJ0wMPzjdDrWz2tn0LP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 14, 2022, at 1:03 PM, Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>=20
> On Mon, Mar 14, 2022 at 05:45:59PM +0300, Chuck Lever III wrote:
>> Hi Dan-
>>=20
>>> On Mar 14, 2022, at 10:09 AM, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>>>=20
>>> On a 32 bit system, the "len * sizeof(*p)" operation can have an
>>> integer overflow.
>>>=20
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>> It's hard to pick a Fixes tag for this...  The temptation is to say:
>>> Fixes: 37c88763def8 ("NFSv4; Clean up XDR encoding of type bitmap4")
>>> But there were integer overflows in the code before that as well.
>>>=20
>>> include/linux/sunrpc/xdr.h | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>=20
>>> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
>>> index b519609af1d0..61b92e6b9813 100644
>>> --- a/include/linux/sunrpc/xdr.h
>>> +++ b/include/linux/sunrpc/xdr.h
>>> @@ -731,6 +731,8 @@ xdr_stream_decode_uint32_array(struct xdr_stream *x=
dr,
>>>=20
>>> 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
>>> 		return -EBADMSG;
>>> +	if (len > ULONG_MAX / sizeof(*p))
>>> +		return -EBADMSG;
>>=20
>> IIUC xdr_inline_decode() returns NULL if the value of
>> "len * sizeof(p)" is larger than the remaining XDR buffer
>> size. I don't believe this extra check is necessary.
>>=20
>=20
> Yes, but because of the integer overflow then "len * sizeof(*p))" will
> be a very reasonable small number.

Got it.


> regards,
> dan carpenter
>=20
>>=20
>>> 	p =3D xdr_inline_decode(xdr, len * sizeof(*p));
>>> 	if (unlikely(!p))
>>> 		return -EBADMSG;
>>> --=20
>>> 2.20.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



