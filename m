Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C0731B18C
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 18:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBNR2j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 12:28:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBNR2h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Feb 2021 12:28:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11EHOf1C094539;
        Sun, 14 Feb 2021 17:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=59/F35ttkBKy0fsNK03kLOs4nY6zMSy9Pg+/LRlGM7E=;
 b=z1fLtsRMsNA4QmdsSuBQjGosXf3h/wUpYiVrUHKDcvF6Mo2Pwadfn/5FsxMFo+jEgd07
 vdUtxBpPuxiA6MCQ0Adw1Dj6I79EG9WLg2Ef8cKOw79fgDsXD7eEJhoMxdkkNSMZH8Tt
 JS0n5zeBqw0eMuNgXBoT26JZBGq1K4m79kR5YLAebNPH8EzdHTUvzaFb061AcSE5WT+U
 z/dRJSZ/Aoizt51pXak8nTs7XfHEmKbHhzgMpygVfvzjG9NuEjx3KuRm3NQgzTjP6QMV
 LKFtGudBU6NSFPT4uN6Qqj0u91YlS26T+Mq0tyy9vgEtdX9cZuSB+XK5C8tZjikFYuBg qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36p49b2dup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 17:27:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11EHPMGJ100145;
        Sun, 14 Feb 2021 17:27:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3020.oracle.com with ESMTP id 36prhphvjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 17:27:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tik5VIFQXr9jdDXFWVfbO8+1kdF79wIE3jCx4sPXEB6KWFB4xr5YVtHnxbewBoVv+XDBywmoECdVecuZOdhehUdw5ldNfOselqwYm01c48DR1G3gdLorzn0gxQK6LXeKj9s2+G0rT+aGpElHDO+IOfXAR34r+KOSllcijuBiWDUlybZGIAa3V81P/4xDj1chgPNcIvaOWiO1dnFdPkMkHjlkv3LMPo1fpeHhiRWD2a6zHmoyjMbc8LtPTxF9vGC3G3qcwIpr0FH+d8HwHCMYclUNryKYYTgWj6cL5llX/w/ttMSi0ylOvpRDVuUst9is303OlVAJQJ0E5p0UkCap7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59/F35ttkBKy0fsNK03kLOs4nY6zMSy9Pg+/LRlGM7E=;
 b=YHizm2JWEMY14K/l1OskG+m5t8eYxH+Mp+UAsFh2rVJ5YOBYXFb94jDEsTghsHrBOFpJQTQVHqoWy9uyHFnqsEs/9xzIXdf6KAS3Ambuax611b992S9VT8iFI5pWdtpJDT5rHR5S8Hj9dqR1w0uV59uddWIui+STfJ6moZoFgxElYSZK+5l9ltNpxdXhNAscOM5/xWqbuW821F7vANC4gYqZlFYG1S8mHbRJTR05Kxe++TOy7oFJdPoTqpOUQiWZqDBQNEd44ginbjtBhuqzP1RnCQ/bF1QgIsUbBEg9hFFfrKEzKD8yXWdk0eRz7jX0hRYyybDJ0lO8xHHbgUtsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59/F35ttkBKy0fsNK03kLOs4nY6zMSy9Pg+/LRlGM7E=;
 b=raiMUik723qlAPdkktVIc964hyBfAs9NO8W3nvNrG27BarrPvRQJFFHI9VF2CL+HEqcsJkrgmT+xz9q7k+qMKu93R8dt7dQHAEfJX8Sv4DR6DZ9zqmkARMd0uc5G8x4gJUlSi0KrvF7nDyQig2ebBvxBURh6MWPdkiKp/cqO75I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2790.namprd10.prod.outlook.com (2603:10b6:a03:89::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Sun, 14 Feb
 2021 17:27:45 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.038; Sun, 14 Feb 2021
 17:27:45 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpWoMoAgAAEs4CAABZCgIABGpyAgAASgAA=
Date:   Sun, 14 Feb 2021 17:27:45 +0000
Message-ID: <C3A48B63-63AF-4308-A499-15665AB2FF9C@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
 <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
 <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
 <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
 <8ce015080f2f4eb57a81e10041947ad7e6f31499.camel@hammerspace.com>
In-Reply-To: <8ce015080f2f4eb57a81e10041947ad7e6f31499.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40bd20a4-d47a-498c-e534-08d8d10dd7a2
x-ms-traffictypediagnostic: BYAPR10MB2790:
x-microsoft-antispam-prvs: <BYAPR10MB279086D3BFF99E4F501947C093899@BYAPR10MB2790.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: esALL6V8LHl1I+2gR9KNgK34FT9ga71CCkodNDrZUjJNltjlCCcSoEc1iVIUwIw+P2w5Y79dZMfS9oPxDX84GOTzEL0OgZsoYnNFPIUEBlmgce1caqqZY2rKfmVnzd/UbwFI/2GKA0ye5sRIw+MDzGLCFhLhV5TIzTDOchUY2xU0e0BASH4NObYG0niB8QBDY7T5XsdsqLP1USuJEUMjb5Q9Zj4DoINa3tjjnNbraCrEsKY/f/lxqV0A+/nBLYn1rN/TfNqFprqEzRgwuU9ewcPcD6oo2qGksKp9m/qdpzZn0fZSNIrQqkyqkk7T6egR9C034jktJWRkT3zsEGSsG8ZTWutF2e4omIdBpIsYGU/G3skomJWTjsZCNbbZHRJ/cJ+tEvLekYLobujRzbMQ96ocCveFZTRueYKZvl4KOctEp9cBuVhmDr6SINnqZrsjgupjEZ8CI5RSjio4ppq7tKfTCbpCbwU5J4rFHRWTXS/h/Ts/JSN5Zw6uvljqsZvcrUenH7+gUTyJR87cLqSf+RAYTsMhG2li+vLTb4jsl05TjXL04qSrJNDm14GcMp71Jq8qB93cmD4r8wZZFdWWpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(316002)(4326008)(66446008)(86362001)(33656002)(54906003)(66476007)(66946007)(76116006)(91956017)(5660300002)(66556008)(6506007)(53546011)(26005)(186003)(6916009)(44832011)(64756008)(2616005)(6486002)(6512007)(8676002)(83380400001)(478600001)(8936002)(71200400001)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zGLCXrX5rui3WShwkRHrZcRmGaF2fsNjID4Kyss2LeY68GnU8Zi3jHn8jACG?=
 =?us-ascii?Q?NHfWoTxoDYQq5/7CXoO3reUIq3YJYSFdAeelwryGOc8yYHOd+FoNYNeBEpSG?=
 =?us-ascii?Q?4wAfjoSeTTHlDk/dLJWzTqQ7jJ6DNpyB7ybGG76gec8VPb6Sgg0HOL+x//9A?=
 =?us-ascii?Q?53HFhet83XDlslJ6y5On0VRIyIpzvD+F3Slv/gYje7B3ZS4mdKyHcvOm5kBe?=
 =?us-ascii?Q?1QfaT4WaLEmuhmdHkC7Giu9QQvUrA7rvgQlC53yvv05AxPrlr1meCmszKkUD?=
 =?us-ascii?Q?IlmdId9dVaftK6uk14WFayzNga03qB4K2l7WESTVa35uoSLM/GJ9n0XaXJpT?=
 =?us-ascii?Q?+BAOpSs3xh4mcsRx1j3VYXLnopnGUpBGlnK0K73xnRD2ydDG6JAEHlvVAloM?=
 =?us-ascii?Q?H+XhpN/E5JmmSpfuXcEfthoRcTVTMPFYUKSYKL0cYxwj75W9V367op7t9gs2?=
 =?us-ascii?Q?c/3NORx0xp5dt8H5KFpFWdxryrZIrQ83A7F6HMeLWKzznGxgLZR6Xjw8ri1h?=
 =?us-ascii?Q?s84wQ1scK8K8H0BC0CrHZ9nAzN7ZoS5dseTlVjc7SZmy+lxNRcyT1KfCyPan?=
 =?us-ascii?Q?182firNgCqFRk8N++SZsE0qX0xfBFMUmrMc4t7mWFXrnSMWO4gbkzs0/8MYy?=
 =?us-ascii?Q?tfo0v1BZiU8kCgqIAyWGRtb5wjnXBorzXTQTvcoJ8I/i2ADwQevKtTaeFs7N?=
 =?us-ascii?Q?7TUz2nCtviBNu9W2EisI3gVji1jiAKurZmoqJdZOrwnwWf3K9StZ4ZgEhlyQ?=
 =?us-ascii?Q?TwtcqvyMiIBDtUkvGOzSstmPvyMKEExDvkYiQafsbpAhXWaJRBsOhNuRbaf7?=
 =?us-ascii?Q?KeZ+Ls7v8XOnHG1c2eKyHNkziWL5rZKlSVfmJGWPESyVEB8o2ocLx0vNtpDs?=
 =?us-ascii?Q?dSZtM/EyRrPy1vaDToIYruI9hdvnVfJ7WAAiz86GiM4KDrMs4yy5Q8IZjVDZ?=
 =?us-ascii?Q?E1NAfVlBpGh3XtFtBp0mBjqjEZ+wrQbwwie0RWmJFG0I83l2nxPpFpRTKUh3?=
 =?us-ascii?Q?UBoro22bFJMwwAtGbZGqbXfn2vuxk1eoUtTbdjSMofnz7UIysXG80n3bX/LC?=
 =?us-ascii?Q?LFg4oW/zOPfvdL8FOkPM80YqarX3IfAxqXBrNjqq4yu5nxUFOKLQVPJGiR8G?=
 =?us-ascii?Q?KQjtxzV1+lRrwqs7RRNewNV8R2th4afirGC5TxpgUItiKKZHuqgG0G+yYRkI?=
 =?us-ascii?Q?R+ud1E7K6zPAJwVuSdJk2uQNRGhJHsTUH0Xxwbce4PVK31lY/jnnUgktW4dT?=
 =?us-ascii?Q?KMVGikLO2/AQ1W9csPqtUaoNdk8CsK5NR8Xv3hOu7kOmP6QenZDCbD+CNCNl?=
 =?us-ascii?Q?R8BPrLYTdwofjFtN/UcimNq3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0903A9B32990AB428C7E2D6652823ADB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bd20a4-d47a-498c-e534-08d8d10dd7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2021 17:27:45.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg04hfDUeLkBKQW7/HxTUizsOg6ZNY+AB56L8+O0jFh6jLwlyZzmSBvO3ulBrUE/9uu2uSoaX6dDOF4VRiaFpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2790
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102140150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140150
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2021, at 11:21 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Sat, 2021-02-13 at 23:30 +0000, Chuck Lever wrote:
>>=20
>>=20
>>> On Feb 13, 2021, at 5:10 PM, Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>=20
>>> On Sat, 2021-02-13 at 21:53 +0000, Chuck Lever wrote:
>>>> Hi Trond-
>>>>=20
>>>>> On Feb 13, 2021, at 3:25 PM, trondmy@kernel.org wrote:
>>>>>=20
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>=20
>>>>> Use a counter to keep track of how many requests are queued
>>>>> behind
>>>>> the
>>>>> xprt->xpt_mutex, and keep TCP_CORK set until the queue is
>>>>> empty.
>>>>=20
>>>> I'm intrigued, but IMO, the patch description needs to explain
>>>> why this change should be made. Why abandon Nagle?
>>>>=20
>>>=20
>>> This doesn't change the Nagle/TCP_NODELAY settings. It just
>>> switches to
>>> using the new documented kernel interface.
>>>=20
>>> The only change is to use TCP_CORK so that we don't send out
>>> partially
>>> filled TCP frames, when we can see that there are other RPC replies
>>> that are queued up for transmission.
>>>=20
>>> Note the combination TCP_CORK+TCP_NODELAY is common, and the main
>>> effect of the latter is that when we turn off the TCP_CORK, then
>>> there
>>> is an immediate forced push of the TCP queue.
>>=20
>> The description above suggests the patch is just a
>> clean-up, but a forced push has potential to change
>> the server's behavior.
>=20
> Well, yes. That's very much the point.
>=20
> Right now, the TCP_NODELAY/Nagle setting means that we're doing that
> forced push at the end of _every_ RPC reply, whether or not there is
> more stuff that can be queued up in the socket. The MSG_MORE is the
> only thing that keeps us from doing the forced push on every sendpage()
> call.
> So the TCP_CORK is there to _further delay_ that forced push until we
> think the queue is empty.

My concern is that waiting for the queue to empty before pushing could
improve throughput at the cost of increased average round-trip latency.
That concern is based on experience I've had attempting to batch sends
in the RDMA transport.


> IOW: it attempts to optimise the scheduling of that push until we're
> actually done pushing more stuff into the socket.

Yep, clear, thanks. It would help a lot if the above were included in
the patch description.

And, I presume that the TCP layer will push anyway if it needs to
reclaim resources to handle more queued sends.

Let's also consider starvation; ie, that the server will continue
queuing replies such that it never uncorks. The logic in the patch
appears to depend on the client stopping at some point to wait for the
server to catch up. There probably should be a trap door that uncorks
after a few requests (say, 8) or certain number of bytes are pending
without a break.


--
Chuck Lever



