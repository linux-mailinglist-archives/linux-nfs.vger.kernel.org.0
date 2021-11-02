Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B73443401
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 17:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhKBQzP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 12:55:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18780 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235398AbhKBQxq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Nov 2021 12:53:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2FoqNH021981;
        Tue, 2 Nov 2021 16:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sJEZfj6/4HHk39tkMEADFSojAaSHHq3JvUgGKxhnFyU=;
 b=z9UVdDWuYBbAJLA9GeAhtIa9DaTuedWvlOdMfqfgjuHl9SlGGM8JnyyepmMRKe35b3Px
 GoS4IRBL2Nq51maS+uidae9IFQcuSQfPUpqrNOkGO2283jNwkPMP5LgZ65W/6MkSBZoJ
 9LjnRvKxGqw09jYmZwXJPzMOQjVlUdWlv9guD8zyVPckvUWUcsIc2zDdN2Ddxy/0Lo0U
 fHLnQo2cUhSqHD+T+DeV5OGzvFFm5oeAFQdM02eSJyZEC3eNM/xQxYnSV9qZW0k+uyBq
 lnI7jR6DTx2i1HiLSMDJgGxrq0WLVZnmKRg+MnJgAkrkK+xJnJF5ESLqDd4kv2wjZumF tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c278ngs9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 16:51:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2GftYK010107;
        Tue, 2 Nov 2021 16:51:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3020.oracle.com with ESMTP id 3c0wv4m667-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 16:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8Ji9u3yhza0tlePckM+W91nbUKMupEHT0uAX7KNeEB5rwtolZ0Qi/OAINiu+97PzMfM19GRO2n6uPQZ32sys8RUAo+CMXDLSwHDYVM2ZWjYyaqZF7Hq2HPb1QXh8viycOYa/Bsy24KV2bZjhXNTidzkAkmoy1T22+hM+Vhgja8gzR1SEPFfTBaPvlS//1Vrz9jkCjZY9JeFuMXqL5bMQ5S7G2XBHlEKG+pqI6i2omN3M2dHo3aaJoWjWgypg71DHCqIt71GY6jA6suFiMLqqvXetY0BEku1Sg9SfNQZ6Bei45TCl07s5MW+hrvsvBs0ThO0Ie1J5sNu7h2CYlsqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJEZfj6/4HHk39tkMEADFSojAaSHHq3JvUgGKxhnFyU=;
 b=VBD+1L/ScDw3pKnwg6KICtMCZf1IDQRdKgNMr7OwTS6Up98HtD7w3M8Shpww5uS2WXmZ964US6qYxA0/bjruTkDH2PIH0uVnTGh+9ufoUPNeGitapZ7T34fvF+DvDhGoOQbliUbww1NLfemyKaDMKf4lR3853LJru/2w8t0h8LESD4BIM/5pbD+CsqMhhoFLHbbm/k9p0u1Z1YN6tYQfaqm5yreXLyMlt5cXrPqIFMy0pSkqJRWzcp6/fZ5+S2gXk0A9KvYVBPekgzhRmjrL0TkdqDtNQWj5kkntC+OYMI2UUIxsiLO42UIbHUpFn2F5B572Qzf6lrNHdz17H9KYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJEZfj6/4HHk39tkMEADFSojAaSHHq3JvUgGKxhnFyU=;
 b=u64AAdQk5Pmcqnx+VIHQkjpn9cwQtSUwJ80fa2jxBvLF5gCEpN3i3C4crMkudm1RkEp86xNCO6/BgVN9DbSt/2Pinb5bvM6CYr8WZYRwbre1nAVJJjV3U0oxW/6l+3tvKdu/kyaD5zWKhyurEK1+/2fj80jU32MjsaGhmtmHU5o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2693.namprd10.prod.outlook.com (2603:10b6:a02:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 16:50:59 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%5]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 16:50:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH] xprtrdma: Fix a maybe-uninitialized compiler warning
Thread-Topic: [PATCH] xprtrdma: Fix a maybe-uninitialized compiler warning
Thread-Index: AQHXzlh5ESpT5Pt9IEKLG0l4cvaW6avtNIkAgANANACAAAIwAA==
Date:   Tue, 2 Nov 2021 16:50:59 +0000
Message-ID: <72A2B417-F76C-4896-AD91-77226C25BF74@oracle.com>
References: <2b32d41cf6a502918a685447cd749c4b1cb0d16d.1635685588.git.bcodding@redhat.com>
 <3EC776BC-8E37-477B-98BB-C9DE163EFA52@oracle.com>
 <d29f109c50126168ed83108ed4297c56771070ce.camel@hammerspace.com>
In-Reply-To: <d29f109c50126168ed83108ed4297c56771070ce.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d69faf3-7c99-4cbb-f3f6-08d99e20f27c
x-ms-traffictypediagnostic: BYAPR10MB2693:
x-microsoft-antispam-prvs: <BYAPR10MB2693F7E821F530CCA9BBA212938B9@BYAPR10MB2693.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvC4Z2ewuTGp/Uor2gg6vjl6y4pPoKK7jlmI8eSVRCtN+GzxSxIS6SbJ0JdA2MtVYOj1PY8vxPrHC4y5mygYhdX2T5ISYduSUsyrmkKhytH22IPvlQu+3s9xnfXnlhziO5RZcO/1yyyKl/E4j5k2/aI8goMCj0T1KrRtmdW3BV0fYtVhrwIn6rO7N3UV0X+h/apG9zygVAPT6o1kZW4rgpFy+cbfF4qj3Ta3rvQpFccov6Z/DTuXHzojoaYp2Ca2JfQ+rYJu7EPpfaEcmow/Zj1UEoDHa4TZZjTu1ML6b8rXdV4jhAhIG8oJ6CSv5IQjUm2ub6XRPTUJ4PYJY3x5vqUWT4vr02MprvYYc/T5EgHy8hInIK7QRgDsTSAiChZOxJCk4XBIG24sDZwLqELL46hPBkKDXZzgYXiZQImoonzkvP58zEg71GSbX6XZGWAwVIZqw2PNTEnOSsttwUYEOLaKgOer1WN6otvzxLCY/n5oMVQ/WVBGhc+8ZyJ2Merxv9AVzvo/qRVIIjJLYv88O3l7EPSPY2Kzoj0nHzxSEI7C7qn8MNbP97gn9marI9aVdFxtUXNABjN+67aTM7/Fcz+tou6w6f5+zu62r0S/6mgKi29jWdz+VK9EtzzXGtz8vFMrH1dbXRyO895cdKdTkC7QqiMOFqeaSaNM0zHffCGdvhgMW/Txr57yxr8LOyLsEQbb2jXkMOP9mWalmCl1mMNQNrGOwEn6znZ8MZJoFP0kQY4+LJYCFFSM9ZYB5P+F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(86362001)(8676002)(4001150100001)(71200400001)(33656002)(186003)(38100700002)(54906003)(122000001)(8936002)(66476007)(66556008)(66446008)(6916009)(5660300002)(38070700005)(83380400001)(26005)(6506007)(53546011)(2906002)(76116006)(508600001)(2616005)(91956017)(4326008)(6512007)(66946007)(36756003)(6486002)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?znMJdIf8WszGsBeFvUBl7xIlAGV6oDCz7zq+SACWwtAAE5MlUzuRQ3u3urzi?=
 =?us-ascii?Q?WJQ8txqqgScudBYbKHZKQJr5hUh3wREel3bOYHIXZ7e/+3olKEDJJwQAV9G6?=
 =?us-ascii?Q?ySm4D34BLA3vd21z7ZZF/ftFYa5+IfutbuXk3QVSDPZDB5Hkindp4oDh9EbQ?=
 =?us-ascii?Q?yMVvb29Ap3HIEscgRMyuVCwIeATfQJVxIYv5oN0dVxXOWoOiJr18u1XmBb58?=
 =?us-ascii?Q?yKx0shb71ti4tgR9AIwD3I3oOwm8qLVti+6PO7GPvol5V+yJ+EHpEGdH2Qsy?=
 =?us-ascii?Q?iRVkF1FbvqRrTuG1sNjncdvqsgefJyInKn64tSqNORTBffjFxvclP4+WnqmH?=
 =?us-ascii?Q?BXBig6AQcmBhDXnVNpbjIzvWVFxd5sR2FUPL0Bf96UHfwCOMl2XHrrrPLawE?=
 =?us-ascii?Q?lcnFDdpHFecmGVthHa+lNiS9gFIkPvmogx6Hk229EO69j++hrqRhlZZ8Iyep?=
 =?us-ascii?Q?s8173jPcbt7aU49ufLt2I89bZLwuFpdD4Si2pvXrQNkvhUjQWQ6fHITmMpMI?=
 =?us-ascii?Q?dGLb8nAoHGtkYJmJNbqc6LdAadrizS8FIkUDr2zoZmienWEgHOMQqSOZSFHF?=
 =?us-ascii?Q?t+uXgjMnGO5njTTXIH1hecz272WTE2YrlAjydOQSw/uyWSSPiRUnvrFf1Xhb?=
 =?us-ascii?Q?3ReNuIjKdByl9oRjfYJbmrdo6UukhefymG6bPXLFDlrxas5Ag4eN9Syz2pfK?=
 =?us-ascii?Q?6gEYlkKQk6gKHaS2h1Nc/ZELz93h87scl3RIQpMNZzDUm8rDBz2luhmGxCXZ?=
 =?us-ascii?Q?yTWaERnrc+XfH3S1x1sbu5b5DloWHMHWui8byYuV/82BIhHOdnQtLTi9VyAX?=
 =?us-ascii?Q?PtcAq4H/ir7CgtDM+LnIJMjLuLbg4WSl9oabCjFqL3jcKGtrTLZRhNwhQHbv?=
 =?us-ascii?Q?iv9XIKTz0+x266i1/+Unn9iBc9GXTo81qCI/GdjKPKE/P75xSP0xlrbJ8byg?=
 =?us-ascii?Q?sWpRX7DWIxyTqPs1Ap7H8O6nyebKgvYUmwTQ7Zw1C9DEhDO+hGYMdJyYXnmO?=
 =?us-ascii?Q?inBsSR1AJcXD2xY+unHOogXo2Ji94pcGP8heqgCiMefNcbhP2yekxZjkRLb0?=
 =?us-ascii?Q?VZO11JCx+Qd0u8OwHQPdQ8nDaxOB+hVWlf59h3DmVcBl/1wDwjyjwbCC9AWF?=
 =?us-ascii?Q?6BsF59aOukgyqLTEVEHTUpCn+N53nx7CxCxnnTjhdWineO5Rd01odDDXq5iV?=
 =?us-ascii?Q?OA9nmF07I7vmhTOVYCdwfoagXqkseQFTkrf7BAAJxbcoljG8M6PaGD11Z2st?=
 =?us-ascii?Q?Rf7Gj+92jOfrzp31AJIG2mMZWPLSw6HRxViPR0KKso27Mww0nv6bJ77b6eyt?=
 =?us-ascii?Q?rQfCg+7vGDfUo99KhhvM1Z5dp5VWDvVKxgn7OWFxAvs+X6FsvGvMaXKModdF?=
 =?us-ascii?Q?V9ZpJMxu8Lu8uKXNzEOGT073/9eR9ek+5RUiVF3J2yR6mFchoArTIX6Ugfl+?=
 =?us-ascii?Q?hlcF4bxyEjHus6vzzPW4ccCnrVgtl/E8586002dkdekmrBkCG0I7gYnaVZS8?=
 =?us-ascii?Q?kL/reN5bCMNR4A7KOoq5wPEqSe/2JVKCWA1gh5JYJ0vP6nvzDvR0WzFGsKht?=
 =?us-ascii?Q?r8oliiU0/tRTrUwWqF++XrjBinvMKjZB9mX1s4yRSvnkY2vShY2CggX6cR21?=
 =?us-ascii?Q?Ksnx5SEVGBHWa8LODdsOe5s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CEF98AE9ACDDD44960C2E3E5880133B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d69faf3-7c99-4cbb-f3f6-08d99e20f27c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 16:50:59.3067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zsUrsPh6rK2AloB3t9XMIqGMovzSQ/wHusm5G51tmoU6wnnTlPLffnpGbAguQWWw2TsDwE47UILp2bW3HKNYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2693
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020096
X-Proofpoint-GUID: NIieLkrGd7n8lS0-iSoxOhsYUJhYTUBO
X-Proofpoint-ORIG-GUID: NIieLkrGd7n8lS0-iSoxOhsYUJhYTUBO
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 2, 2021, at 12:43 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sun, 2021-10-31 at 15:04 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Oct 31, 2021, at 9:08 AM, Benjamin Coddington
>>> <bcodding@redhat.com> wrote:
>>>=20
>>> This minor fix-up keeps GCC from complaining that "last' may be used
>>> uninitialized", which breaks some build workflows that have been
>>> running
>>> with all warnings treated as errors.
>>>=20
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>=20
>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>>=20
>>=20
>>> ---
>>> net/sunrpc/xprtrdma/frwr_ops.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c
>>> b/net/sunrpc/xprtrdma/frwr_ops.c
>>> index f700b34a5bfd..de813fa07daa 100644
>>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>>> @@ -503,7 +503,7 @@ static void frwr_wc_localinv_wake(struct ib_cq
>>> *cq, struct ib_wc *wc)
>>>  */
>>> void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req
>>> *req)
>>> {
>>> -       struct ib_send_wr *first, **prev, *last;
>>> +       struct ib_send_wr *first, **prev, *last =3D NULL;
>>>         struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
>>>         const struct ib_send_wr *bad_wr;
>>>         struct rpcrdma_mr *mr;
>=20
> Err... Definitely not sufficient.
>=20
> gcc is absolutely correct to complain here, because if req-
>> rl_registered is empty, then the whole rest of the function after that
> while() loop is invalid.

The callers ensure rl_registered is not empty.

This used to be preferred: don't add code to check conditions
that are known to be true. If that policy is different now,
then yes, this code will have to be restructured.


>>> @@ -608,7 +608,7 @@ static void frwr_wc_localinv_done(struct ib_cq
>>> *cq, struct ib_wc *wc)
>>>  */
>>> void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct
>>> rpcrdma_req *req)
>>> {
>>> -       struct ib_send_wr *first, *last, **prev;
>>> +       struct ib_send_wr *first, *last =3D NULL, **prev;
>>>         struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
>>>         struct rpcrdma_mr *mr;
>>>         int rc;
>>> --=20
>>> 2.31.1
>>>=20
>=20
> Ditto.
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



