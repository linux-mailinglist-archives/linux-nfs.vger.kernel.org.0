Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4517D514AAD
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359840AbiD2Nlo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376347AbiD2NlV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 09:41:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90159CD31A
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 06:38:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TAIdXi003700;
        Fri, 29 Apr 2022 13:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=364fnJQKe1eiK/+rhKl/qkCgJ3eN89OZG74+OlU6omM=;
 b=K8iPCd7CH1pvQKQ4jVwgN4/MQiaoAS1hhXzGPjntf5+STPVE7Vs2LnNHXY35thj4bMb5
 rQCffbDGFBn10SKUiifuS5dcEONbJsq5Dng1UDruE7HhXLMgcud75PdRdWDWMRrRtinY
 k5oZtRS+M/aGal20fT8VZ2XRozGOEWaaCOSKY4/oe/d0prCHcNH6GZea/xaBrNyj79zT
 0RUKLRBzqyqIiW3W/+ECend3Pq8FKrihZ8tjw9b+vRJzmLIdoulpGqSIVoQU2uTFXq7m
 VrakjL2nUeKDJ3wR4plTuEv2eAsan3NaW/wN6ezN68BvIIrF7ND+sdv83LPq56KrAIHG zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4xand-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:37:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TDWRIr036479;
        Fri, 29 Apr 2022 13:37:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w81cc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK3WudWY935HPk1edSqOqcgA5pKMM9Z/qaEc93UBQS96ZoRQWON2ZYrUlwvF1QxFt2bRwUU9AItti19WlNb0asjCJe9a8Mo6WujqzL20DFAcasEQpGw6oN45wqHxiYZHREuM0J6RK6tO38bDC9IhVPxZWoK81eWmL7Ot2SI7C3XrwfZvNFrozUv07fBd83rTkKROUFJ0ZKnUTr/7z7xYaquC0Wedzz/dM8jNO/+zUNM3my4A/e1bQai0D30TkSGTAsK40SJttqnT7O5k06H0IuNJN8zJbvBMZipivgtH6b7L+l2taXjA1FbBy356D4ereOIzRNfxcIA7hFunaPjFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=364fnJQKe1eiK/+rhKl/qkCgJ3eN89OZG74+OlU6omM=;
 b=Jq8cOTjr+xhl8NvM5a3+cxYJkdvX32It6g+65b0tcm9kgkEvHGIpcYf1DdfWayZyKlOAUIuYo3l0O6uGBbKA+lkzekZ7+E/+2bq8lHaJuz61zk7pxKQAxtrIFqiL2m/tB+FfILVO1oJvk/1E3EADiS9fNdiwLuIcTZ957DHRghwTBkDFR6owOBaI88m5dIuWd9quZiPs2EaNFgKpibWgS94HGZbTc9RphW/Yr3fdhvkbTHbESdS7micSsLAN1Ibj4tnvkvjmeV3bAW53LhMGME1Xz1T75z7RzAI5VR8di6NgbAA8WTrFRhgPKSiwBZOA2zaqjiyJ1b5CeY29phNHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=364fnJQKe1eiK/+rhKl/qkCgJ3eN89OZG74+OlU6omM=;
 b=qmDnF7opoFZyfmUApZSMSRn1k3S3DMpivZZfbNL1cn9hbPhLmv882jABN+1GihTtD23WUNDvRTkS9eQNno+eoSB1sPi164S0TmxBk5uacZH/XbZ6LtmgNlkhGvTN6BoyOMIwb+o35/j3KxAXFcP26imSue2MwN5qTzlfqwAmgvI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1975.namprd10.prod.outlook.com (2603:10b6:903:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 13:37:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 13:37:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCixuCyjj49XkSuf+bm0GIRX60Faq4AgAAMfoCAAERPAIAAApwAgAEchwCAAAwEAA==
Date:   Fri, 29 Apr 2022 13:37:51 +0000
Message-ID: <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
In-Reply-To: <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25136ec6-5507-4fb1-7cf3-08da29e57543
x-ms-traffictypediagnostic: CY4PR10MB1975:EE_
x-microsoft-antispam-prvs: <CY4PR10MB197592A9CB1D54D5D2F2019893FC9@CY4PR10MB1975.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDKDg95sEKsg5zalGxtpYUTDloY1e0En/EFp4A9RQ4X4Fte80OQgGjK8sxH66tv/eA2UYLmd9pnAaiBdAJxR5jjbPVn0upT56ubt9WR5GP/ui+E0HMHJmTwOGgYMpPNNoXh13gQWmFl4MR6yLY5b7IdpV2QEpzTzpwJoPF1YV/C+WN1PPL1xd4zmjguxwP9OSYF+Mp5e0a1AB4kV+Mk6lxKj7z0ppPK07T7jrLNGOJu3TSaUt9TWyLC+BJuxCeC7z5iuS0CBUZOGLodFbH73vcRxusrLGtLgLbq1lc693MQ6LiBQMMDdLsywX28u86dAnTbE5TJg3RbZ1p2wGnUR0Y0+UkQXS4R9ghxnSVhDHh6wJOINBjRORzza+52bm+D81GXeHGGmMQti9mI5+rQEZmfSR/G0CDol2acg5h5MK+2uDP3kbXvQvey+Oweiuca++h4zASw8BY28RZ6h/MiA8Px1AIYmPydL0phxXa8E2jfubotqKaJkUQ7EfWDoVttyZMnUhvBZwhvyvyMrvr9Oa/tyVLD+2ztzVOd9ZYbCNJcWlvuZhf6TGGPDHWLp6XLVHi0BRfhEMtu2GC3E1aMldHA9/R4JSdC9p98dI2tSmAnkxZ3hWIMXuZYMT+shHuaVIzZvYqmDjdkyNzh+mJF+Wzl5xHNQi4eBoTRJEQabUF98JmsI/oZ+gNX/h+izsTJzBEFHNpvEenT/g0gYRJoyPW4Ca6dGjoZ+H6jApPx/LUh4xAFFjne7Q8zCvyBUdQAX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(71200400001)(6486002)(316002)(6916009)(54906003)(36756003)(38100700002)(5660300002)(38070700005)(8936002)(76116006)(86362001)(33656002)(4326008)(2906002)(122000001)(8676002)(91956017)(66446008)(66476007)(66556008)(66946007)(64756008)(83380400001)(2616005)(186003)(26005)(6512007)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vhvihnOCcg0zDYHb+Novb9tAyf+nUujz28gXRR4wBKsyBOybep59r1FUlrwx?=
 =?us-ascii?Q?qZb3mYP9uJx4WIb4V2zp9t/ai8OPjmX71+UjrffMEMpi4JIGQ7cgiV0VcEoG?=
 =?us-ascii?Q?4siIzAV1NnVhMo++Bbm9XFlgZguuRButQel/55wv7QbG+mCQEhU+HaA/flAt?=
 =?us-ascii?Q?c97HZTsU6fmOp8XLDvpBO3Egz6PQ0+dN5UUIiZoN5u2v3O7k9HAT5zeibXRb?=
 =?us-ascii?Q?En7EkfPVUFsuV5panYIvQym1CylfMOZ2qlvhogLkzHKetUDH6SpZMYWTm5WQ?=
 =?us-ascii?Q?XvOPPXTuz8sWnfhlC1P6HDwNmW+wra1Z92Wk8uhPVqIHT2tql4oCKL/Ygrgh?=
 =?us-ascii?Q?NUp/ZhvypNSDJQxJmL1b9zU5KisGA1uV0w+GjzjeW4hg5B9NNUxJmQrV0Ume?=
 =?us-ascii?Q?7t4v73RVBHj4z4mof1yAk9jw0N6Bw7/SnOCu03w18GKu0TJD6wtu+DMKuqbG?=
 =?us-ascii?Q?TT2hcyHNbWdtHJZB07U11v6ZhxoWttSUU+dyU4J69Qm9c6/KWB0OlJ/KbN2b?=
 =?us-ascii?Q?RHCGpLxz/6M9Rh2TiQyD3qGYyZk0Fl4FqX4tz0nF2j1+emn/1PbtuwHDbfL/?=
 =?us-ascii?Q?FEgBRrlGzZ9raZf6KxaDVgWI96MWX1mLNh9pA2yhU/38oQztGaWkNLNmnIE+?=
 =?us-ascii?Q?mRhuCOrDS6qEhsGui8PpM5A+UXgZDtCvvAHD3wdsdHnK0dm5Y6gzyHsQFLGW?=
 =?us-ascii?Q?XIOiDCjn9gv2gbgIsjpTXzYWyDtT5eUV1Fkcf5WzLyQUs1uU8XjmDvzsuo4R?=
 =?us-ascii?Q?hyN4SJyrhNDH62QWmqtx2/2st2y55r2GAUbVQt+OATzqbIKZubi5HAYB9J9d?=
 =?us-ascii?Q?ycVPzdfaffgFwzWtKCdhJue02pBisiwE1r085qLbgQ50+zOjNJhJKu1piaD6?=
 =?us-ascii?Q?xr13WJW4GTs3BKk4gOAIuioKyzmo4lMnBGCE2GzGatFFe82iRUgQvnDKxdnN?=
 =?us-ascii?Q?1ueCeTlM7AvExtbwcHaSDXeVF6cJkJRgtNQ1qHU2Vp3RiMUETndHbD5jo+2H?=
 =?us-ascii?Q?z5/8soJ9On/EoRTsQsoEZyoJRiR3flaDMCUsqGOtCll2lv6xUHTpDY2M5/kt?=
 =?us-ascii?Q?ksBIrpF/rxUj/rIdLV6lpEoC3VK4ZrTckHb0sqb05TH7C5R1+yfyQAnhnqEz?=
 =?us-ascii?Q?S0WMiMNcgv51uSABby1n/8KgzacmB8IcTXPH7fSVW1hJcQN03dw7KB42Md93?=
 =?us-ascii?Q?VA2VcQwL5Pt7XWs+HTxlDPI0gItUq4bHJ3ErsokZCh1BIki0kbcF0ctyQPwG?=
 =?us-ascii?Q?J6QxojVDxT6y7y+eIovBdWc1Ht5h/nnkGvkK0w/bVoxUr279XdNVoUyBJFse?=
 =?us-ascii?Q?EeQWcMeydIqtcRNYKwAzDNRrdPR+D1fS5AKPOV56c3gpXrftSH6s97Zh2wRx?=
 =?us-ascii?Q?W+3NUYAbD6tmxugyzzrx0ZS/DNCgj9/MXgdn9mOWM64rOklpIO7gxvY8Jx8W?=
 =?us-ascii?Q?jOge0q+arboTBPP5d4xojnF0AcLfYUEpCVCGlEr58M/EdgKAMAHG8zZqxlf6?=
 =?us-ascii?Q?5J4Nfs+D6WXPHUVUFaSU94ldiSJ8e4Cjsy6fmTLtXgaDny9zxppscMXTId+l?=
 =?us-ascii?Q?6L6wBusu09lclgcP7R/zBsww8d2e+/KkmJ6uOSctZUG8B7T0R3DV0rdzYmZS?=
 =?us-ascii?Q?qpqA6Oaw8H7k7WER6wSpgvQmBUegbgRZHQPQzusXPbwPkm5YsSsBYh2oMV/I?=
 =?us-ascii?Q?gq5KtI+WZIM02YJ2G+p+eGxU6/1VkyOUUjHG6losLXJ1+zevY3OOAbyiSLFw?=
 =?us-ascii?Q?BdnO+kHgny9+7UcsuKlcmdPYb1Cx0Vc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05652FFD3F225A4393CCF0CDF7498D9C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25136ec6-5507-4fb1-7cf3-08da29e57543
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 13:37:51.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvIfOVZogatPojL/KKZpYWBHgUk7p9oJzPQSeomjzVMMNo8xkbmGtmvq4G0uyq6Tx4M6tn/46b9KOaJrDNg1Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1975
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_04:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=684
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290078
X-Proofpoint-ORIG-GUID: 2bpJz43kP1sFFfzQOumwAUef0Wqw0eI_
X-Proofpoint-GUID: 2bpJz43kP1sFFfzQOumwAUef0Wqw0eI_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 29, 2022, at 8:54 AM, Dennis Dalessandro <dennis.dalessandro@corne=
lisnetworks.com> wrote:
>=20
> On 4/28/22 3:56 PM, Trond Myklebust wrote:
>> On Thu, 2022-04-28 at 15:47 -0400, Dennis Dalessandro wrote:
>>> On 4/28/22 11:42 AM, Dennis Dalessandro wrote:
>>>> On 4/28/22 10:57 AM, Chuck Lever III wrote:
>>>>>> On Apr 28, 2022, at 9:05 AM, Dennis Dalessandro
>>>>>> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>>>>=20
>>>>>> Hi NFS folks,
>>>>>>=20
>>>>>> I've noticed a pretty nasty regression in our NFS capability
>>>>>> between 5.17 and
>>>>>> 5.18-rc1. I've tried to bisect but not having any luck. The
>>>>>> problem I'm seeing
>>>>>> is it takes 3 minutes to copy a file from NFS to the local
>>>>>> disk. When it should
>>>>>> take less than half a second, which it did up through 5.17.
>>>>>>=20
>>>>>> It doesn't seem to be network related, but can't rule that out
>>>>>> completely.
>>>>>>=20
>>>>>> I tried to bisect but the problem can be intermittent. Some
>>>>>> runs I'll see a
>>>>>> problem in 3 out of 100 cycles, sometimes 0 out of 100.
>>>>>> Sometimes I'll see it
>>>>>> 100 out of 100.
>>>>>=20
>>>>> It's not clear from your problem report whether the problem
>>>>> appears
>>>>> when it's the server running v5.18-rc or the client.
>>>>=20
>>>> That's because I don't know which it is. I'll do a quick test and
>>>> find out. I
>>>> was testing the same kernel across both nodes.
>>>=20
>>> Looks like it is the client.
>>>=20
>>> server  client  result
>>> ------  ------  ------
>>> 5.17    5.17    Pass
>>> 5.17    5.18    Fail
>>> 5.18    5.18    Fail
>>> 5.18    5.17    Pass
>>>=20
>>> Is there a patch for the client issue you mentioned that I could try?
>>>=20
>>> -Denny
>>=20
>> Try this one
>=20
> Thanks for the patch. Unfortunately it doesn't seem to solve the issue, s=
till
> see intermittent hangs. I applied it on top of -rc4:
>=20
> copy /mnt/nfs_test/run_nfs_test.junk to /dev/shm/run_nfs_test.tmp...
>=20
> real    2m6.072s
> user    0m0.002s
> sys     0m0.263s
> Done
>=20
> While it was hung I checked the mem usage on the machine:
>=20
> # free -h
>              total        used        free      shared  buff/cache   avai=
lable
> Mem:           62Gi       871Mi        61Gi       342Mi       889Mi      =
  61Gi
> Swap:         4.0Gi          0B       4.0Gi
>=20
> Doesn't appear to be under memory pressure.

Hi, since you know now that it is the client, perhaps a bisect
would be more successful?


--
Chuck Lever



