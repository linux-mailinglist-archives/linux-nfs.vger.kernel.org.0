Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF4E4C1E66
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 23:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbiBWWW7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 17:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbiBWWWz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 17:22:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626C63D1DE
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 14:22:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NKYOkN011466;
        Wed, 23 Feb 2022 22:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=i+v9nVmoJeWQXdxcC94yNnIDHxGdppItOyCyZAkOfwY=;
 b=ie1wWPSn5+4e3bYE19KKqbvxFXTaf48678uo/wzwnMur7Y+acb+Iepo/gv5xGuA/Z2e+
 mz3vuTXui7/geS7BQYe0UBxDMiV+QVqDzGxdqOVwEjVrbdofXEPmrwsgvfTyBU3BG0nl
 UAswClEGZj/2oTtkSv0megfL+MUKJydoPTg/AgpKZnuxIQ7e195DZAV6CrCXiZaq2cqF
 Odeq6O4KVg55aQ0J74wQxTIqYOEcEbQut8FIcJjtDOpVAjElu/q+xWcQGi0RskLwTtM8
 YxooHZNjodOKFdty255CIjEhXRmU3XVizGFHEl0/x7P0mwNBwgz2Ua4pi4Hm7NAPt2o1 Vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx5rjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 22:22:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NMGVQU141217;
        Wed, 23 Feb 2022 22:22:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by aserp3020.oracle.com with ESMTP id 3eb482ypms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 22:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6Ge1XFitl79EzAKGoYZGkxX8HlowFd6MrCz4mnu5gkQUv1S2P6VhUibIrezbhnW1bEYIskvSRPoqJ5t374by16FfH9mfKpkBhNojwokXUD01FDUSM/f8Y4XkZ9D9awAtEHP+rHlTfaiE1wBl1A+sBPPVKaiO8sb7AqXLnFT6F3rYPe1Gp+RxgeBfaFzmLb3jFH9AEYfD3p5AeH2OCXYmi8ARswAMywEXDE1wbuajZ0L9oSJtEBD5a4DiAbCAs4c3atCx+sIOV+ByR96gEijXrVD9IPIVW+azyxCB4T/7lrtrhk3KdWtN97iw/jdFonwqGsZ5omb/00+RJ5glriEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+v9nVmoJeWQXdxcC94yNnIDHxGdppItOyCyZAkOfwY=;
 b=oOPY0C7AXbT/KBgIF83NdCthWTKUjBx+hFJop3cj9XZF7lgJcf7FHuH4sxVZcag0QKdjbMU3OnrW+xw+i6Gr7bM80jsiFLEr2QyUF2+/XW07Wmvsus7vYnwjqBD0r7+IOxRMxOyCc0UwRf5IeP23gWBPX0ZNS1/a7kTniT1OGBUZMvL6ktMAnNRfbOvRgWS9rdu8tZT4JkUA0wuEr/bcBICijZAEV/CDcS7YfRMTaZybRw8AZRY3EC4N1Q9zWZesJzPnASbWE6wI4w3rNz7Faw7+mVQOuP0/ze+0S7l4JRcfRmdWj2TkvP+Vqlx/AoHCjcfmFi127mC2NsAJcnOrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+v9nVmoJeWQXdxcC94yNnIDHxGdppItOyCyZAkOfwY=;
 b=GDYIx/wP1KV6n3gDA21bYIUmX2Dukh+DD5w91LQF4YRMGoPEdhdeEnVk4eFsqftefBfw0UqR/NcCvi2kDJy5J53xb9Iu0EuaTwTyOQlhm1pBtfuAwkpxkXOlEh6SLWFnrWBok4V0fbCluB0zpTLWwQEsGwczhG1bXVA4P0lKJoM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4022.namprd10.prod.outlook.com (2603:10b6:610:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Wed, 23 Feb
 2022 22:22:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 22:22:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "kurt@garloff.de" <kurt@garloff.de>,
        "Olga.Kornievskaia@netapp.com" <Olga.Kornievskaia@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Thread-Topic: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Thread-Index: AQHYJqo39+LyDrnueE2TsZR4Xaed/KydEsUAgAAiEoCAAImBgIAAFXKAgAOfFICAAEE+AIAABjCA
Date:   Wed, 23 Feb 2022 22:22:18 +0000
Message-ID: <E5300203-2C9B-4873-84EA-CDBEAA1CCDFA@oracle.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
 <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
 <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
 <FFD47AE3-D6B0-417F-B0CF-D89E6FDB38C5@oracle.com>
 <29c0db53ab6dee067c1b91ba3eeca98310506453.camel@hammerspace.com>
In-Reply-To: <29c0db53ab6dee067c1b91ba3eeca98310506453.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 535c9f36-283e-4fc3-0789-08d9f71af3d0
x-ms-traffictypediagnostic: CH2PR10MB4022:EE_
x-microsoft-antispam-prvs: <CH2PR10MB40223369AE3920DEF99FC255933C9@CH2PR10MB4022.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +PUdpZCGecAySAZctbD9Ne09YFEB29+OiKuJGBh2kxmYo1Vu9zDuBXMiKm1EbRwY6HufIJT9tKs6GtV4tzMf7yxd/S92KtbilNVudQ90x0+e4ete4C9SaiwbiPhfn+qqnEk2W71xMkXK50labl20cxzySRDaXqOQL43Bf0/a/joDI03rEbNewCTvQTeKeQEj45TzMjcdyiZEKvn1qJsP6pSkmRlPxXEH3CJinuUNkVPTq7OQ77XPPRD79Q2k5rvX5eerT1yGzMi1s5/hbU33rLMtBpKUYCmANdjFnYGtxb3LGSPAA281CaLs/LyQxlo7M+oMt9dFct5ecccD/AIX2dW3RuaJNLjo0s81gUqBCQr/ehawpwEb8TlQ/EH0nutAH1BinusA+1raC8kglb6CTj+2/uNnK6N+A5w1mqA9/0hov2V8ho1f189T5B7ejS7y4ja42bJSPoX//LM+P7sMIlwOIPUiWG2PqHTLAuOYOvzlmyGNPOln7wUtn8iqCVsChunFyEUcb8AKqqHeLdLzNn2o3X5vi40bGZ1ocC08Xd1eQ7bPG2BjoS96ZVpLt1ypwZ73wNjDpqH4u/4KcWJM6Rt0suKqsg7LxBmJtCbxK7AwHcVbD9emewqib39K5NM0LKOhurhKCuinPjoeHq5qXC12+fRBVygHD99eYMGeqqXOqAPflErDnIYxA1HZzQVk8pMbYw6vPf5I8pJ8whQQ2F29q+nUC+478EhSUul9N2WM7XIdIP0aYkjri0zBCA9IK9m4VrVFvAhVDhCB89BQWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(5660300002)(508600001)(36756003)(8936002)(86362001)(38070700005)(83380400001)(2906002)(6506007)(71200400001)(33656002)(54906003)(6916009)(186003)(26005)(316002)(91956017)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(76116006)(66946007)(53546011)(6512007)(122000001)(38100700002)(2616005)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D1SPutnLuonInkYQnVLcU3X9hv85F/VIPS3Qc8sZpxbFL71RygehVCdIWGIV?=
 =?us-ascii?Q?aukF5Zfd+/7FYnmEjrTu/9vWFet/oktj4YsPcj3yRy1+0fv0/bjV7B08Gq2L?=
 =?us-ascii?Q?y3JsCFkE2QlCWsa1gTNhbVDT5NH2neUEsNZn41MbI36k8dp8yF+030RjRLQ6?=
 =?us-ascii?Q?uk96uXgrLrx6fx7OK82oXGj1o/ChiDvq16w6z4X0ma24eQLIiNXlOef5MTId?=
 =?us-ascii?Q?PrGCzf5mqt8RTHsxLnBnwfoEExottNYf31BDVGzSsOe4b0bupGQ5BDwsA28o?=
 =?us-ascii?Q?KIGS8oFveWVogQswy/p3JVoSxbdwzUVbUJ6ruot5Y5hVkN5lAR3X7y1/4KAs?=
 =?us-ascii?Q?sMDDZiMTdl3VvgOwY5kVi8lM0QIQa0k/AADsEjDR3NRIMbY+OltvrTyhVqQN?=
 =?us-ascii?Q?FfQqd8LQhUO1rJXwNjXfAJcG1fTCpCRwRHe5g7SPe+UiV/FvHkInPN8yZswE?=
 =?us-ascii?Q?Q4/Z3UaWdAFZkhBO/wT8XqMFr5bRYEXXIWmLka/7GKAkwr48vrAeOwgADDEf?=
 =?us-ascii?Q?eaBt+oW6VrTyJhZrnGwEv4dcxFM6ZF+OEoowL6zyiDYPyZAJitu5pPNP+RfK?=
 =?us-ascii?Q?TmYFJZVCmYLyVNZvBbjlaRd5yN8iIB9hjQsMUW0WokWIzLicNOs1TSbqT0fh?=
 =?us-ascii?Q?izrf1HfyXEJxf/4UmqPu1xZTQDpBaTeK1CssD302wXlBsrd6PsHeR7iVFYFZ?=
 =?us-ascii?Q?Np0Y32Gs+UJeBDWpEx9G5AY8Gz9CVvXW05YVt3ZbdXhRHxZ9/eCNXsLQaalC?=
 =?us-ascii?Q?ZABb2UG3Opy643tyZUPzUg7D34P3oKzhTzlCQpfeRclnBuzl6grojQEbYZVT?=
 =?us-ascii?Q?qWc9XKZDoh1WpNsTHJUDV1LuD5Dyxl6mSZxASTtS4Xt4wkmTm24qT1s3IPn8?=
 =?us-ascii?Q?3BDO/VVZG3OgJiHhBvG1jjdpImD7aRwM9LHIbKQon8cahGwRYzDHIc8JsrBO?=
 =?us-ascii?Q?1GLWZ40Df7GNDe39HbnvpoTnz3zO6imLBA3Sv/J46L6lFrDqinjUJCkuCcPZ?=
 =?us-ascii?Q?iREstFIL+LaUOa5rLsFgVFNVbbHAtJEl2uBEOdymYs9z8VSw5UDKdjMQLrhs?=
 =?us-ascii?Q?3JVT4HblSXK8P89FQ9VFhZ2qzBlr671icOVG6/S/M3vQFsPKij2aniU0H0nT?=
 =?us-ascii?Q?bgQ6NB6HccK8qX2lnQTtjGZ39sXoUb90z1nK/aIpy8G5q7XeoeCJF/vGjiKQ?=
 =?us-ascii?Q?/4gbXXkjQlZ+ApN5tQSugh9+4YiCX/oy7Ai/eyF8PRMgYJTAYVorxNkhIWcU?=
 =?us-ascii?Q?cisZ1I6NnMzBStwVWH9Z1ulD2ARWj/278prOWykiyFzTFQKBP/VRaVwQKB8K?=
 =?us-ascii?Q?sI1QpDYD+G8xcYdjuG03bOZeQ4A8mzN4l2yZEOoZJbKRACv3WSvigjU1myA9?=
 =?us-ascii?Q?5mv7VqdtrJRhw16qGDLFa/DUB6wai451Oam6+IQJVjhBTZwXG091dHXbTdez?=
 =?us-ascii?Q?EBwXBMaKO+vjEeYc3sNMafKjrBiUmt5S+JSlyEpJo+JtEoi6UdS3SdVasAkb?=
 =?us-ascii?Q?ymrjcTuhRWDJOlbz1AIBDubF93yO79hg/kKwmQxm/4NlIXW81hOKZXlhGi1F?=
 =?us-ascii?Q?fEsBWCFu4uP/XAGflPSYBwab+vP6U/JuG8RZdz/Hm6sP3gUjoR3jNryaLsHf?=
 =?us-ascii?Q?eOiE3MCZof+5VDjEhsalfiI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14C6E3DD2F4E3E4C8DC7C723BEF37024@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535c9f36-283e-4fc3-0789-08d9f71af3d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 22:22:18.0874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2A0wwTe7gelUeMaV+598oGjoLf9+UrGTQ+Xwy4TBnfuKAAIIQLnO0lJZpefFz1wXwsB5/lHnA/4OOT4RxW2FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4022
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230125
X-Proofpoint-ORIG-GUID: WMP0mzKWSUAP-aZmq9xDKZFjxEtnY9-A
X-Proofpoint-GUID: WMP0mzKWSUAP-aZmq9xDKZFjxEtnY9-A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 23, 2022, at 5:00 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Wed, 2022-02-23 at 18:06 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Feb 21, 2022, at 5:48 AM, Kurt Garloff <kurt@garloff.de> wrote:
>>>=20
>>> Hi,
>>>=20
>>> On 21.02.22 10:31, Kurt Garloff wrote:
>>>> Hi Olga,
>>>>=20
>>>> On 21.02.22 02:19, Kornievskaia, Olga wrote:
>>>>> [...]
>>>>> Is it possible for you to provide a network trace?
>>>>=20
>>>> Yes.
>>>>=20
>>>> Is tcpdump what you'd like to see? wireshark's dumpcap?
>>>> Any NFS specific tracing tools I should be using?
>>>>=20
>>>> One trace with a working kernel and one with the broken one?
>>>=20
>>> Comparing the good and the bad trace ...
>>>=20
>>> mount -t nfs 192.168.155.74:/Public /mnt/Public
>>> against Qnap 4.3.4.xxx NFS v4.1 server.
>>>=20
>>> Both do:
>>>=20
>>> Establish conn
>>> NFS NULL (ack)
>>> NFS EXCHANGE_ID (4.2 -> NFS4ERR_MINOR_VERS_MISMATCH)
>>> Teardown and reestablish
>>> NFS NULL (ack)
>>> NFS EXCAHNGE_ID (4.1 -> ack)
>>> NFS EXCAHNGE_ID (4.1 -> ack)
>>> NFS CREATE_SESSION (ack)
>>> NFS RECLAIM_COMPLETE (CB_NULL, ack)
>>> NFS_SECINFO_NO_NAME (ack)
>>> NFS PUTROOTFH|GETATTR (ack)
>>> NFS GETATTR FH:0x62d40c52 (ack), 8 times
>>> NFS ACCESS FH_ -x62d40c52 (denied md xt dl, alllowed rd lu)
>>> NFS LOOKUP DH:0x62d40c52/Public (ack)
>>> NFS LOOKUP DH:0x62d40c52/Public (ack)
>>> NFS GETATTR FH:0x8ee88cee (ack), 3 times
>>>=20
>>>=20
>>> Now the differences start:
>>>=20
>>> The fixed NFS client repeatedly gets ack back, the broken NFS
>>> client gets
>>>=20
>>> NFS GETATTR FH:0x8ee88cee (NFS4ERR_DELAY), repeating forever (exp.
>>> backoff)
>>=20
>> Any idea why the server is not able to respond properly to
>> the GETATTR request? That seems like the root of the problem.
>>=20
>=20
> The GETATTR is a request for fs_locations in order to probe for
> alternative IP addresses.
>=20
> IIRC, some earlier implementations of knfsd had this response when the
> mountd daemon wasn't configured to expect a referral upcall for that
> location.

knfsd, or mountd? Is there known to be a server-side fix available?


--
Chuck Lever



