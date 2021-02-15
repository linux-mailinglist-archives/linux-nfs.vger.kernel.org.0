Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39D31C173
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 19:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBOSXZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 13:23:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43882 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBOSXV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 13:23:21 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FIF0ax156711;
        Mon, 15 Feb 2021 18:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yVdF1zIFM213CMWYiqF1tFaSprreqLUHd6j0rou+bW4=;
 b=vCKrJi2aV++J0qs6QaDEIcmkUufnj4+U21ltE+C6TwOEI4CxvHdP0PgYIBGMiB1m6O81
 7fjCqqq16vVAIsZzIwGaiZ2ENT57zpB+b9n5Vb+cfZvHUir4KB5++uFF+l9so3T+Sx3T
 zADUXo9BjhDfwQId7RCvPzU2bt4s32Zr3ttdN9jwIBD8Hw0VWMOJYqa+afl3yVdIWxF9
 RdzJ8uIsoqUruZls67TpUVTxw1JN6HL1s/sDaTkxf7NVUBhg37fmnUCCoGZhyGDQfTQ8
 n7AS2iiiaYMioGYOuJbTZG/dRhbFPjqNRD1FwgUBcY8hLJkpnM72XB0AstxYkqpyHOLK Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36p49b4xkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 18:22:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FILSLk072513;
        Mon, 15 Feb 2021 18:22:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3020.oracle.com with ESMTP id 36prhqnfgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 18:22:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7UYGbCsedew3iFYKtqoazbjGu8JWMelfCX41xZn+HYeun2yMSRY4A4xHSHgInFfJx3V1S/M6n1SxnGvfixkLNrvQlCMryVeXp9AugOhLrKjnnC+mNQVm2yIYJgujoBVLNwgrkUMV68lyWqtaDqdy8Z4ZbSzgU/u/5l93wGOC8k5+y0+vk9WGwFkgA8MWdRqdSXHvA4zA9SaowT2JayV0L7Ayc8R80fhzkGCsZhdDKAmawzqA5YpsxWzUEHOBY9GhdhG9+pX40vo6z/LqToIIqicYtxsMjCALHP8sWk31j4JK0AdxD7YSMBSD5EfTTxodinpmWHatp9zzWfsJcWWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVdF1zIFM213CMWYiqF1tFaSprreqLUHd6j0rou+bW4=;
 b=lJT/GBJHp4rv5eIdXko7/9x2rxEtVrdLkc7f1/gTZ8ItsvRNHSfE/jgcpRc+AidtmS6ajX2jRH0CAI8i6tLKh4r+jImnBIE67p3aJEWeJxLQ6tTnMf7WYNK7h/6P46m9SXSYtN83EgHx7SkhwWkZZczj8QTHX16k0GJhGdB71fWx1z08d+uyOC3JCJg/XOM10bkD8z2HKS4SIsI4lAqp2HgksDAPM0HAM960XGpEuEox/VjzFDNwQQngO/9OfpxJzLXfp8y1f2ztT4wjez3NrQBOKS4j5nhPW6hPgc/6WbWKJD9MVejFOYhlsvBECs9WcyujVGGa9bqQCOQU5Kt/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVdF1zIFM213CMWYiqF1tFaSprreqLUHd6j0rou+bW4=;
 b=FN2h3xmBuYa+L7jm6cwP6Tkzl6jISgEiS/CE44Z5zoRFKFTRY13bKXyGG0zEimn1yWqa1Ft908dM9u2rXGO7C6USwrZF7YR70MoI9i3k7hZpIrJZYCaFLZWkOSWcH4PLTb6Gs5En8gxcxvrTOhzJvFFgBl56VTWIPsALz3Rwp4I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 15 Feb
 2021 18:22:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.041; Mon, 15 Feb 2021
 18:22:21 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Daire Byrne <daire@dneg.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpWoMoAgAAEs4CAABZCgMgY7/PBt+g1IgC0y9QTNss11YoA
Date:   Mon, 15 Feb 2021 18:22:21 +0000
Message-ID: <86F287AC-04CD-4160-889A-8B2B25A4546C@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
 <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
 <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
 <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
 <285652682.9476664.1613312016960.JavaMail.zimbra@dneg.com>
 <E39E6630-91A9-48DA-A6CF-6AE5BF6CEDD1@oracle.com>
 <608881118.10473767.1613398098205.JavaMail.zimbra@dneg.com>
In-Reply-To: <608881118.10473767.1613398098205.JavaMail.zimbra@dneg.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dneg.com; dkim=none (message not signed)
 header.d=none;dneg.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b71fd4f7-cf8e-4169-6785-08d8d1dea2ba
x-ms-traffictypediagnostic: SJ0PR10MB4527:
x-microsoft-antispam-prvs: <SJ0PR10MB452712DF205DB7DCC825638693889@SJ0PR10MB4527.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rx2NVZVg4d+oe9TbUBKhHScwJa2c5bhimsiMgvE58rCLzP0bTX8Ce6SRgUA2UBNcaSTJO6HbNB/jXCiIj/jS0nJu50n8y4ZeDs5/Sb/KtNchAQeRsGZ7ZXSSnUzdD68YHcW8q8PlIuGgn+67iUVoP0PQxnsfhactoPsojj5ropbOGH2oCWh9iGiriawExJOuQdjjvm2sutNu0dWS1VAnA7Bg3xYk/P0tDK0PYDH6mYLEd2xiyce69h+ywuITxqGMCnrJoOrbxg/RY6A+H2lwyReobLHH6wRwRZC+iYZ/HbzmrXwonuofnvRJ7++QG70MLPzcH4P4R4bb393SS+hZaJ5krZf1S85b6j4kpt57vmpwzHgiFzOGC4S+bi3RjrQtCxS4VxUJJFC+fPGBjS6PwfO8Rocf971nyQo2AsSnnuIY6/oCht4+OMUmJjFSRfcYzTe+BZUhMVy1imBRIyVsQm/cTNpQHCjrd7EIFXE77i/MqFfTStDaHRLA6sHiCDlWuKlRvZ4ctZ2RH1DCyD8rEHgIosOYJ6C5MRCTf1IHx9e/BdgxINo2qYRmbGLcyBK4X/vy8LdFOXKp+69LrLHg6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(396003)(366004)(33656002)(44832011)(2906002)(83380400001)(86362001)(4326008)(316002)(54906003)(6506007)(186003)(8936002)(8676002)(6916009)(26005)(6486002)(5660300002)(36756003)(53546011)(2616005)(478600001)(71200400001)(6512007)(66476007)(76116006)(64756008)(66556008)(66446008)(66946007)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1LotRy1gVuA1HIRxrVrtyAdcHVxkr4I513/y0QIDm84xaiwgA8Mo4tOrBQKR?=
 =?us-ascii?Q?2tuk0RW15EyXeVoVaO7YsR2yQpN4xSFQI+GPQkXK/Y1r+FqI/VREuRnA/9a+?=
 =?us-ascii?Q?Z9e0/eXRtutgiuX76rcy/0DVPSdN71BiJAAPmNu5c+pAtHZ2aLBHKMJgaILJ?=
 =?us-ascii?Q?QIlyNB4uHcANquyhFFN5IhOEHBzPCKcrjx9Sht8dBK/nm+kYvEnRjofTEgat?=
 =?us-ascii?Q?NR4wNqpfOk8/xO9E5Cc07Rubmtb+U/mLycMxfB2G63Bnv/47Kfrzbrie67x2?=
 =?us-ascii?Q?Za3axDY4edaSjRMHPKeyJ4j/EmvjSAOfj6671MQ0/ha0hMtuXMPzkwIdOWYx?=
 =?us-ascii?Q?2vxKfOPuHjrRE1yTVUNMHY+Z52fyv0uLBoBz9LMKYtbof2AoHZS9Zz+3zSJA?=
 =?us-ascii?Q?15m9lBOrO0+ekjMtY10hdMpc1fsn79D0Uy5bT5F5iabAnDO8KM90Xdvq0cpK?=
 =?us-ascii?Q?lEAgXN4w2D0iGncrugpMAgxfKQqESiunWCzvPI+ShhId/G609UG51aZkE4Dt?=
 =?us-ascii?Q?jMe9T50m92Z8732gZkVCExWgpWMa3K46jaLX9XcPHUE7Ypx/fShH4dTggTG2?=
 =?us-ascii?Q?CzQ6Pi71FYr2DViVbQMn2pnjYtk80/4h57mE554TfEjl7D4B4ILbg4/UlsdK?=
 =?us-ascii?Q?y/h+mYqbo1nVBZYTZUmunJpSSVB0P8id+vyxowhr6z2dnR6XzWUsc3y3SqC9?=
 =?us-ascii?Q?IbejqtLE6t0AXeWdNnE4yibQEUpzVdIu37TMcca3rxXuXcIHhcbxq9HKOI9I?=
 =?us-ascii?Q?L/id90hVjiECkNJgthG03qY+lm1XiObhntWAXhqVpF89pzPQ8hEaMfZ9xTUG?=
 =?us-ascii?Q?r+die2UcqTHm7YJr9PoH5/cz8A0pON6UCm7FPLhcF99Ctuj1N/Sb91c4Uzmf?=
 =?us-ascii?Q?jv1Bo7NjhPfiAQ1Hgn2nI7AGijkKPRtxbVEyriR6/JI7u2TgjADcbQxMMHWw?=
 =?us-ascii?Q?0KWxSaDE2Fb6HoPB3mVgj94u18z/LHJ8/NMajg1OLwfolR1/7VzAgYBSNbVk?=
 =?us-ascii?Q?kY1iifd7JklIPicax1ix8ZwGDnH3rxpWXooeq8Vj+RQACZ81tW49lCT5Yx/t?=
 =?us-ascii?Q?QgXLncTXL/sFSD2Hf7C5af8Pct9uDNpgDtcVwN4jTkmcpGAoOinUu5OMCcAq?=
 =?us-ascii?Q?BTS2h9GBh3pSgSN0DwafAu4RQV+5SyPSx+ylhsus9e4W8y8+OhMvaXwzCq8I?=
 =?us-ascii?Q?bcwWC4yPhcZSCQLnZ6KTC51LoZA8h9QDGQWkbCaYUX4DnPI2BBIPr9b7ZlMU?=
 =?us-ascii?Q?4q+4daZeh2+g+REtJTaiRA8PMRLfgSln6k6s/CS9E5EEEAg9VXstCJM7wmJY?=
 =?us-ascii?Q?Bu0/7WFH/kQg+mjBc3x9kzei?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D785FD83AA16641AD5474A9E293915E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71fd4f7-cf8e-4169-6785-08d8d1dea2ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 18:22:21.4471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eI2+S9meWqPnqWo/yBZZEYiMuwH8ldBcGqXOPiuQsUrojxfs7N3slIDfVf0NDTF+HJNtAgzPwbldMzjSG8nHJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150143
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150142
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 15, 2021, at 9:08 AM, Daire Byrne <daire@dneg.com> wrote:
>=20
>=20
> ----- On 14 Feb, 2021, at 16:59, Chuck Lever chuck.lever@oracle.com wrote=
:
>=20
>>>>> I don't have a performance system to measure the improvement
>>>>> accurately.
>>>>=20
>>>> Then let's have Daire try it out, if possible.
>>>=20
>>> I'm happy to test it out on one of our 2 x 40G NFS servers with 100 x 1=
G clients
>>> (but it's trickier to patch the clients too atm).
>>=20
>> Yes, that's exactly what we need. Thank you!
>>=20
>>> Just so I'm clear, this is in addition to Chuck's "Handle TCP socket se=
nds with
>>> kernel_sendpage() again" patch from bz #209439 (which I think is now in=
 5.11
>>> rc)? Or you want to see what this patch looks like on it's own without =
that
>>> (e.g. v5.10)?
>>=20
>> Please include the "Handle TCP socket sends with kernel_sendpage() again=
" fix.
>> Or, you can pull a recent stable kernel, I think that fix is already in =
there.
>=20
> I took v5.10.16 and used a ~100Gbit capable server with ~150 x 1 gbit cli=
ents all reading the same file from the server's pagecache as the test. Bot=
h with and without the patch, I consistently see around 90gbit worth of sen=
ds from the server for sustained periods. Any differences between them are =
well within margins of error for repeat runs of the benchmark.
>=20
> The only noticeable difference is in the output of perf top where svc_xpr=
t_do_enqueue goes from ~0.9% without the patch to ~3% with the patch. It no=
w takes up second place (up from 17th place) behind native_queued_spin_lock=
_slowpath:
>=20
>   3.57%  [kernel]                     [k] native_queued_spin_lock_slowpat=
h
>   3.07%  [kernel]                     [k] svc_xprt_do_enqueue
>=20
> I also don't really see much difference in the softirq cpu usage.
>=20
> So there doesn't seem to be any negative impacts of the patch but because=
 I'm already pushing the server to it's network hardware limit (without the=
 patch), it's also not clear if it is improving performance for this benchm=
ark either.
>=20
> I also tried with 50 clients and sustained the expected 50gbit sends from=
 the server in both with and without the patch.

Thank you Daire. That is a comforting result. The increase in do_enqueue
is curious, though.

--
Chuck Lever



