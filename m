Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8404C7B65
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 22:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiB1VMD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 16:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiB1VMA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 16:12:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962795642B
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 13:11:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SIJ7kv009544;
        Mon, 28 Feb 2022 21:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fmmJmUK+fnNSMiNDucOo6auaj2wpxeZDmef5Lb0Rsdo=;
 b=Amu0DJj3jMMDxxCSXG7i4egg5JrH9i3BDHa4MgD16yKAzU0MYT6l2GkE4DGdUrdWGqDV
 f4NPBKhR2wjLi3y5wDJdr3GbfZ4hWLgoJbyBpcnTQVSx6HyBzmBkb6kU1dxhpIbFaC/E
 fLBrhvgSdfXmsYRs1vIjxo/90gV1dRaZhEIwNRWy1sLqT0tRClr80+wOFFrPfwuoyC3O
 XxPr7ycl9TancdasGkDsYgqEkxPtQdisi194sekoJ64w11wFvLUk59zOT2kfBE8W7fFO
 w09MA8V4ZTHhb6d7WcWlIB+kfTQCT5SUC5Db8hP3GqzlLQYFzns2b2qoBzAYf7rU01Uz sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efamcdg0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 21:11:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SL1voo025980;
        Mon, 28 Feb 2022 21:11:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3030.oracle.com with ESMTP id 3ef9aw317f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 21:11:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7XIu8KPcUW86iP5Rf0lK/gXYaB2PW0WaCMalnKayfQb8SrWSjvfhJNU9uHFOpR3FMPro+zjDucjscLz7/wPLvf7MW3pELV0mjeVwWJILHr4CIvuVApsDkBx81zclVtmEjsMAZY4lVZMaXJAc8gQzs3onr9YwSKLk4BTbLCtXrLUuoG1w6gV47gWDZrKjDEhVLvzcnWZPoHu0P8kFtjf8qZSk1xsK3Q10QoJoCL3f2xgaMwVgtE+quQg50oZnwNBjIrvzC6Os/jmiwJcyNWuxTu+QtmBZLKIBwDtdtQuAlNFZZh4vZGEUHhmx/sm0Pc/YQizl/qGDAo9zvrigJLyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmmJmUK+fnNSMiNDucOo6auaj2wpxeZDmef5Lb0Rsdo=;
 b=mfjUH73Eqppdq8CpBaR7MQXKDwu1wTK6DX3SrhdDqmbedG82tU7VmTLIYIqkeg/YGGlLwJCFeSrsG1xRQEsQreqCyya+7H5ES2fT2tTFioFcc5GXcOA6A+6YWIWxEk1wQJk4jp6pXDFgcDTEUDNG/Vh+M0vF2lHbe8ILZ8zMCln7mU93G5MPAdL8D5/WU3kKo5a2Mn4xTho9+ZryJxAalEy4/Q3zcFYP9O2PGaqXmY/8OvSsxRwsrbnnzLgj65TxIDnA+es9PjPMkv3J7Oc4xzINhiOPJKy6Ys0HfQISadhlJNKsTJTAZMuGZExJbRsnX7LBA4ksi9A5Q4nO17N6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmmJmUK+fnNSMiNDucOo6auaj2wpxeZDmef5Lb0Rsdo=;
 b=cSOSKopWob589UQQ9HSlj3fs2rCGCyRTZy446Sz8mJEEDw69JfoE9ay1gjrBAGM+iLum6dCJgI39zitgI/YYxarRq8NsKgsgrCPQO9CLkeZ6wmwrAuTJqbuDeyw6F9aEq9TIvrYUUOb5jLKnOsW+gZpkw2OKROZoKGFsfDTTxR8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR1001MB2350.namprd10.prod.outlook.com (2603:10b6:301:2f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 21:11:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 21:11:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Topic: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Index: AQHYI1yJP7y4xU9Y+kaLua2/7R9GAqyXsraAgBGBCwCAABW4AIAAG9GAgAARbYCAAAJVAIAAB4kAgAAIHAA=
Date:   Mon, 28 Feb 2022 21:11:11 +0000
Message-ID: <511B6460-3899-44E4-942A-C6B7CE8E2014@oracle.com>
References: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
 <3EA14A5C-9FF9-4DDC-B530-768A86E2A4E8@redhat.com>
 <0F8CD466-6233-4386-94C5-FC8E5941F9D3@redhat.com>
 <73b61ba083df0a8954979fed11d6398d336ee1d1.camel@hammerspace.com>
 <F853D68C-C066-470E-BCFC-988C3D46ABA8@oracle.com>
 <01c6aeddf91d0e68d7c497456ea96f4f24145059.camel@hammerspace.com>
 <5DB9D3E8-2687-4945-9542-C0ECC58C509A@oracle.com>
 <fd290496bd66b6bf477c961ac716179ecdda13fd.camel@hammerspace.com>
In-Reply-To: <fd290496bd66b6bf477c961ac716179ecdda13fd.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce75a1d6-b75f-4615-893b-08d9fafed908
x-ms-traffictypediagnostic: MWHPR1001MB2350:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB2350E0E8A39C775281972C0093019@MWHPR1001MB2350.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O29gJY26JiIkl74EJFaR9HV1wKOP6PZC64/rK6hgsNwFjCTwDs40Ud7M7U8O0jT90+IIUUPZqMrxh6zv1L09aIv6znGdAC0anh+gnDrY8RcImEknZw/A8LkXdRaivrCbtxKgYMcQ4XD87dNykYNZccR3OfTvKCcyJHrijFclUc8bGWIjBaKVHc+cSZTFe3iiOYVWQgB0Vx6yXoK3x/J0hQ0BKBDiealW89ApPfGChnByIIXqYCsxc9HeSExrYnosSn7l/xBH44t8JHoZy8YQ4AKYvxFk0N/M09ucXiqmY69HByNAjgDIaxTzJfSjN3dhA6pB2lAjsnAc5ujU2wp1D6k/e5CvShZN6vYmat8Ta1hr1Y91iJX8CoT/5x9PucmrpH7C5mzU51kXY0zpoCnP05kcPGlx2mSkJZgtsQOdhaLcg3fMckxuYbVZNth2I3DHSDr9+AuO+5cLVf/t/JN5S9toOZ/Kkug7gfMWNxHfKCyBCgM9njM6dMae41PD3dBKEmF4f8+d5LvCLKMzZi5Ue8j7tCFy42R4WKBw0N+EN3VuVl6QgYur3ZH8xp57PF22MFoL//CKdAsNOuGwn+8zTNyqHq0yisnK5Zxs+JeasOhFOuTnE6KrwKoyeJQ9YaFmSCk8+asb4KAK5pJ1luM6Rj7+WoZieiglI7oho+WAm/EDL93PuYeZxdICq9TaaB4pNDyYJ6rLrhK29wDx5I6WNSufgZJGnP0xyuj56XKTiAepXYrrT/sRx0LCRz8rd3Oc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(5660300002)(8936002)(38070700005)(38100700002)(6512007)(186003)(26005)(2616005)(83380400001)(53546011)(71200400001)(6506007)(508600001)(6486002)(8676002)(66476007)(76116006)(66946007)(66556008)(66446008)(91956017)(6916009)(64756008)(54906003)(316002)(2906002)(86362001)(33656002)(36756003)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2rpn4Orkh5kt37qzIIGXTRQYYoLVwuJ8J0zFzpMxbu9PdWTQCLDT1wvkmjto?=
 =?us-ascii?Q?Ihpm1rFpBCs7IwfuTqYp4V4ZmCK44dICoFjsUYfEV9219VM3yUbHLhYzqHP7?=
 =?us-ascii?Q?9Ww3xm/FuMl0/JgB/r1xtSI2B9HXkQdaZJx+70BdPiI/a1In8EzxDwTnOfiN?=
 =?us-ascii?Q?erZSTOnE0sKFH+8NRRGjHiwLZoM51Qf+N/uAMBGgtsEt9T4Rqcq6f2Lqyvtb?=
 =?us-ascii?Q?D1EqMuVY6LJM4oweMNMt7UJERToIPTm22bQnHwXuWJ7rGP+LT1LtZy/qk+A3?=
 =?us-ascii?Q?jq0r3VYzE0qIOIlTi9qNje+5GtoihZPknS4Wkdr0GJp0z1S5a87yLv7VEfBu?=
 =?us-ascii?Q?8CHL2rVS8Y7AhFj6nxRyyF+jVmHj+CpJ4qUKVEZ1B/EALuBFawnuU8OYwayJ?=
 =?us-ascii?Q?iXY29z90AHGIc6BFSbf2+8WpPhPkPy9X2NVRY9G8Lzx0w5N4NgCMPOnH1Eqe?=
 =?us-ascii?Q?Jh6RbISWjHgsiRtYg7l7AWoPjgcaYOspXS91LofnABY6TeydV94L55NIiN+G?=
 =?us-ascii?Q?H22zkO20B06wyZsjOF35s0N8H0dbFa4oT07UVGUtlTNdf/xl8jbXNcBfO3rf?=
 =?us-ascii?Q?bHnDWhxrgPeUhk1n2ltWdkryEStWo/2qaresRA67K9/dFw1H/kqw/MRegk1H?=
 =?us-ascii?Q?7Qxn0frvesumbiOfW4yAmCeBwFajtEucejrRM4vk/Oijv7PEglE+oALHDC+M?=
 =?us-ascii?Q?yB8LfOJuoDC1w9aedhP5UB8DfepfUsvHvSmKkKGLcH0tFz/5iR6UlJuY/J9Q?=
 =?us-ascii?Q?HrS84sY9wY7DCAprHlfJZ2dQIR34jnyqDmktwuX4ZcoZ035jV+Er8AiQ8UFQ?=
 =?us-ascii?Q?SYt4wX6wdRRDbm1iS6jx3VkyGAkxx9yJFMPPdZtjunosg8wqnl4uD9b1uA4i?=
 =?us-ascii?Q?u9bbed7isNVsEoiX4U1VgHXOECX2n7Y1ZpnJMG3e/iJgfLBVap8iDhw4qXyb?=
 =?us-ascii?Q?jiE3kzZl27geN8AVNvz7diiOrb1maMXasFBj0BSE87eB9DAGRckZF0yQ86bV?=
 =?us-ascii?Q?bJ2thVZOt+h426LPET+HjOn4JFV24iA3XJjmaP+3Dfkzr/u7fYBUqJp5l7vo?=
 =?us-ascii?Q?bwxYhrjlmMSs2BZ+56SCcsvqiN4abfWzkqbPDp8QF2VOQcoqZwEW5sFyJ0SX?=
 =?us-ascii?Q?w7FnIIlTsKHuQMzr63DXqoCOY7cvbXjQ5uTv10gx+tusuGIO0jhCU1xEnC+T?=
 =?us-ascii?Q?OJIS9ZO6g4QqrkKBuQ6EqZjkTKxAC6iJkKNV1CE7kVU6S7AgmP1Fj9KpdCVL?=
 =?us-ascii?Q?RCE4zVxGO1BKaeKUKLN2F1qHRuZJlK3BlZClzRaFi7VLjpluMZ/MSp9JSzox?=
 =?us-ascii?Q?TFjn02cYCHzYdfJuyNO2qrcQpGEpVWGZud1OJqnGbGauukIU1+foSyGnk+ra?=
 =?us-ascii?Q?TGjb1uIhmFwKom0KOWA0AEmXgOhiQBCWsaIWpGoGtNFOQyrUBkzScLuiTmVl?=
 =?us-ascii?Q?BJW0hEif8Jb/gFf+BUoAVzYgWWDLwzhHkaModtEMcVk5NvXVjmoXAh3exKPB?=
 =?us-ascii?Q?/T9Gu19d0kCemsIFNdjNKpL7+n6HX/JODi4xNG7FOlNVjdpmoKmutHvOqerd?=
 =?us-ascii?Q?0Sgwgb6r1dsx0e6gQ1L9QgSLiE4oFIQeZ2gMsjiUEBJDWzXLORIr2VzFR8dW?=
 =?us-ascii?Q?w7F5plnm90XAeoKfV4Hcm64=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF9FB2CBD6532841B46874ABEB1BBF55@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce75a1d6-b75f-4615-893b-08d9fafed908
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 21:11:11.8752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFDaTms6lQJZyoi4Jr22+5pnFepCHfczRycJn21M8yX1Mpxyu91mVHnFlhIa897ppWBZqIUvcDegnLUVCwBzDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2350
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280105
X-Proofpoint-ORIG-GUID: R4NSejUcr356dfMkcWCR-pVzgBpA01kt
X-Proofpoint-GUID: R4NSejUcr356dfMkcWCR-pVzgBpA01kt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 28, 2022, at 3:42 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2022-02-28 at 20:15 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Feb 28, 2022, at 3:06 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Mon, 2022-02-28 at 19:04 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Feb 28, 2022, at 12:24 PM, Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>>> Attempts to work toward solutions in this area seem to be
>>>>>> ignored,
>>>>>> the
>>>>>> questions still stand.  Until we can sort out and agree on a
>>>>>> direction,
>>>>>> self-NACK to this patch.
>>>>>=20
>>>>> A new mount option doesn't solve any problems that we can't
>>>>> solve
>>>>> with
>>>>> the existing framework.
>>>>=20
>>>> I don't think a mount option was proposed. Rather, the mechanics
>>>> of the udev rule would be done by mount.nfs without any changes
>>>> to the administrative interface.
>>>>=20
>>>=20
>>> That's not how I read this proposal:
>>>=20
>>>> Do you still want us to keep this approach, or will you accept a
>>> mount
>>>> option as:
>>>> - first mount in a namespace sets the identifier
>>>> - subsequent mounts with conflicting identifiers return an error
>>>=20
>>>=20
>>> Which is why I responded as I did.
>>=20
>> Ah! Well, I read "mount option" as "mount alternative", I guess
>> I was filling in some context from previous dialog on the topic.
>>=20
>> I agree with you that an actual mount option -- that is, a new
>> administrative interface -- is not desirable or necessary.
>>=20
>> But I assert that having mount.nfs take care of initializing the
>> uniquifier for the net namespace is convenient, and can be done
>> automatically and reliably.
>>=20
>=20
> Again, if we do this, then I'd want the actual tool that initialises
> the uniquifier to be a separate one that gets called by mount if
> necessary.
> Otherwise we'll have to consider duplicating that code in busybox and
> all the other tools that have private implementations of 'mount'.

I don't have a problem with mount.nfs invoking a separate tool or
doing it as part of a systemd target that precedes remote-fs. The
tricky thing here seems to be guaranteeing that the uniquifier is
set before the first mount can be done.


--
Chuck Lever



