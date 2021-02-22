Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11C3221BC
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 22:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhBVVsP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 16:48:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59286 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBVVsP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 16:48:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MLTVaY061883;
        Mon, 22 Feb 2021 21:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7Yyee3l+frQbRtE5uB03kfOY83PPdPvY3dmx96ih2PY=;
 b=wATF8FeoLOoYoXfN2fTdsh1qMobui+5dEDf5XVQ3KpVcgeddRX6gFnsxM8stDYY1Umjw
 WpDcr1dSNDYCEmOJiVnPs9DpCLaDSju7qs4H2m6O5NKgF+pl3Fr4hOoDdGMhh33gSXPg
 3gv9x81L29cEg04gLmUXgqA0D8LcgkRejO1Q1o0ow2/Y0Kan8J/KW/ttLOFZsxh3+xiN
 2jHUbyLuJebVhXcRvyWVqUwumzpbENmVW/x/nwfHNMTsBosJXvSm/oyFyB3gmj62vO+L
 0elfaGb3CS6xxrstr4E051+hSNilHaFXq7gfaU9DWNa0zjTbBX0GhfpP22ix0xVbZAHC lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36tsuqw9dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:47:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MLkWVx114421;
        Mon, 22 Feb 2021 21:47:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3020.oracle.com with ESMTP id 36ucaxk0xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRBMu3f/QYudcT/xKYKjH2m3G2qIbx0H3b215ob0PFH4mwd6CH5UR9TUrcwJa8w1vSCpzC+7M96msHuk2JYU2n8rkKtB4/zPJheJU7Ra/nX/sTlXBBZ7c5erGI1Kb1x+mjMY1QLzCHdMvVDcDws7T6Bu7JrhP/Dh9SsnAcYDYv7ZxJ8PRUK+RMHCmjejXUMnHLGXIR9/dazvRaZ3R4+5sFuMfMo5ez9oIUaMISTz1LBrYSBiHFfBEimVGTPTztFfiArF6PWbqaAiO0+GcTJD/DalIInyY05FZd/1GZMkxKSSO0K2VB3Yxiq/0oLjd7fJn2+Y9uHwlqkO86DzMvXvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Yyee3l+frQbRtE5uB03kfOY83PPdPvY3dmx96ih2PY=;
 b=H5z69mRbnVm2J7mAvxCmho9DaT69FUEqHTVO029OXCZfEd5JEyDROKqq/fdvmzZ8Pzc89rIynBw7/7uR6XCXSsc2JyR4KcO4+rXtw6TizfJZeQ1Nd3suGjzcPLMT3qRPizLKXDZT4LtREa/oIRFBtpwQqXkJNDyXQ/e7lskHocAJAxspGyFU2wUDlFS6ST4D4P4SIL1eNeZUNboicNJxopmfw6jvi99rQvouY9UlL2sm5Pn83LziAVWgMNktfKZLu/9FBC4wnldplDxPrsHZy4Fdixk4GfRMvjqFB3corCgXePq1gwuhGlvU3HxZwvBAmSFckmlQ8XvIFkDggJyC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Yyee3l+frQbRtE5uB03kfOY83PPdPvY3dmx96ih2PY=;
 b=eFbd9Ivrpw6/V4Mhvrr7yn+O01taJY/zq91bnouJe3+0YIeRheSe+m4yOXiVZMUjgHOL1ONPIJiMxwM462FWtnfXlWIw+Eohck+UtORSxaJE78Qn7hFQ0a13acF5U0dbN3TV2bQCTa/gYA30egW+aMRsx8xNE2EDLAv1PLK+/2k=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4146.namprd10.prod.outlook.com (2603:10b6:a03:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 22 Feb
 2021 21:47:16 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 21:47:16 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH] nfsd: set RPC_CLNT_CREATE_NO_IDLE_TIMEOUT on callback
 client
Thread-Topic: [PATCH] nfsd: set RPC_CLNT_CREATE_NO_IDLE_TIMEOUT on callback
 client
Thread-Index: AQHXCH83nfMXcY7VqUGg5DZ3Kqzkv6pi/gcAgAGtWICAAAwzgA==
Date:   Mon, 22 Feb 2021 21:47:16 +0000
Message-ID: <C99EA5DE-814A-418B-9685-D400F4E7B964@oracle.com>
References: <20210221182700.1494-1-timo@rothenpieler.org>
 <EF096827-F543-429E-AC9B-1E93C6A35B02@oracle.com>
 <3701466e-6c0a-93e1-1953-f2839b6fa37d@rothenpieler.org>
In-Reply-To: <3701466e-6c0a-93e1-1953-f2839b6fa37d@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b649142a-0432-4b25-8d86-08d8d77b6bb8
x-ms-traffictypediagnostic: BY5PR10MB4146:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB414680D4F0FDC5E9E429334F93819@BY5PR10MB4146.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y2hU4UygJCRQxfd5m/5tKaPpUxHyqomcL9WkgcgI4FJaC6ZwYvtWPBAPcaz33H8lB8gA01dv58o0oQWmFR9IDISvfP87QGGdeXNOHalXoN7Z3SGk7lRki8H2f6lrSIr+bdUjwEdiqLyaHOL8353LQKlXUjyKgCJs1d1lvyxMsqBIamDrZp63ZBVKBajqh8KLbbBdG2B2459NJLzEqTNMdq583Vl3/7OeuMZNqBQEwQFfMcncEkkfc7Pz9sJJG6ur5DHQnqdQhoUWd+4Cv5ZnFB5Y5gwWYbeAs706MiJgXX4xEU/+7rrtio5gM1tMM9o/nv9ITafEVGxEMm2auWKiTFupaq95uojaKF9BP1DUVOnQn6JndicThRfZpUQ9wNtN2A5v5sOpbNBhHUMsk+ioGtf4wrJ+lOSe3WcGWNWAmbdaESYJS/C70gH83o5ZjRwJgAMt/9jhgC4kT0oiALy9GS8lCj+Aq/PcWYD5FsoQU16lgPu9n9hqKhyKGoX5YiSScqDIKcOLnktlraGLavjxaqAmtml+3irQ82y4bOZpUc/TuIi2/PAVlCSfldEvfnX+49Vu7pwgt4wDUxD8U25p7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(136003)(346002)(4326008)(8676002)(2616005)(33656002)(478600001)(53546011)(6506007)(8936002)(71200400001)(66446008)(66946007)(66556008)(64756008)(66476007)(6916009)(107886003)(91956017)(2906002)(54906003)(316002)(6512007)(86362001)(186003)(76116006)(6486002)(44832011)(36756003)(26005)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?66MMbhOl/8h1M9ivF90dUuv6cA7cRCW/s69eQHudyoHO6vdRtyKwfdb5yiQq?=
 =?us-ascii?Q?ux3SDp/SS3RyqCLGiXP/f4M3k/L/Iwvg4BTLtA1Zu+rU+E7zdZ3XgGd0SpFw?=
 =?us-ascii?Q?o9C+bbnMHXEqZ9XUpuo44TESM8K140s3Cis8nI7Ap9P9PQWIy5x0SMpcmgD7?=
 =?us-ascii?Q?I2NwWy30RSLnSyXGkP0hnbYEFwlHrScrmbOK/TSd5FLwWufWc343XoYwKV5w?=
 =?us-ascii?Q?/AIm9wtVWmL2/EMV8PoHz1JTwlbgUBpyq2NPE1vpFC9Xh7fokZDqPCpCNP/V?=
 =?us-ascii?Q?gVSMioh8JSy+yEMywic872104FtCuApd+se0H+xLRFMu606OxZsbos+J4xy/?=
 =?us-ascii?Q?kZr2mBi6rj6m+CvdKrNUwrw7RQVVhHskr1x7UAt7vqLLLFBIF32iuNM4F5gz?=
 =?us-ascii?Q?9pEc5weOcxRzngWfVzyq2NrU4C+ngGvJhMumhOOIP9amPvS5MiiF9cQgPdtp?=
 =?us-ascii?Q?+lwiQmPaLNsoGjb7xv1+je2c7ZyYtPqk/wAx27zm5YNQW0x1DTxnyuwy2mBk?=
 =?us-ascii?Q?borcV3PVlV4nfbOvv+zm60WwZIg0jReFa6MRmixuJt6982sT2PPl0mcxQeqA?=
 =?us-ascii?Q?oROPJhShqgbpnNIZaRkRpBeevn+6Ye8yCzMJuH4Vjf4042hRFcN3aDzHSu8/?=
 =?us-ascii?Q?48fknADDaqDNC0Z2XPigTLpvLuVZNgZ/sHSmb8RoRzYI42otsnMgyfW8thG9?=
 =?us-ascii?Q?Hdf3I1HeDzytCqCZdOW6scTVT68LbgVy2A6fchcQoO5pSdwnpoNB0Q1T3HLT?=
 =?us-ascii?Q?9uLuVcy+Ay3Ry4ZFBK6JKFCM+oPZFYRxSFxDnMZW9k5Ov8gW3WvX5XnqBBsG?=
 =?us-ascii?Q?6HPsy1m4fcfwaRH7BGLZXQ/JH2kKxLrLZOPsfOlku+0jF5Ap14X/C1u2GewZ?=
 =?us-ascii?Q?abrMK71+BmNRTPCXNxGgg2qoGxUD8PVQQALWCWkiYhc7/aQp4jyWA/ofvPqV?=
 =?us-ascii?Q?w6bCL7bud3HSjN3BtgKCI/51vW9L2weJReHOlyhx/an37VfhNywGC8c+FYxu?=
 =?us-ascii?Q?yUKaWTB2wiuDI61suMUX5xGYCtTogmUjkID6OLF2fXrqlsdpMdWY/Mc1djoD?=
 =?us-ascii?Q?vCvs+vavdPBd+mRgzW5xsYphJOqnZB8kNFPhVBJgCSikdtKf6HrP11jtgxUm?=
 =?us-ascii?Q?kkF5GOElS7M18aHWyq5xYWp/apU9PjQhc6LEbAx46lp/l9uLqhcW8PdZNfPV?=
 =?us-ascii?Q?ovGtWbrX6X/hoF2CIa7QUtyqPTw4/582U3hUNkL8JRBxRRq/GYPuUmBl+e+H?=
 =?us-ascii?Q?VgAfPVPsA9iXFDySF8olpFsrQ1SJ4doAzypvUrak/WccWKRM3dtOK8j/6wl2?=
 =?us-ascii?Q?WwRFrygvXG5eqKM2ATRxDGReGXhGTBmN2JPEveFnA/3wvg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44F87F68A06E4C4F8B836CB147B9D856@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b649142a-0432-4b25-8d86-08d8d77b6bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 21:47:16.0374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiG/F7Wie4LEXGr4tqUuLibpEd2wv3vLpYW8SsaglN5/PmV4Y1mRorXeN/9Grv9ZatTh8mQlbGIoQlXjteAl3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4146
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220188
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220187
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Feb 22, 2021, at 4:03 PM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> On 21.02.2021 20:26, Chuck Lever wrote:
>> Thanks, Timo. A handful of nits below:
>>> On Feb 21, 2021, at 1:27 PM, Timo Rothenpieler <timo@rothenpieler.org> =
wrote:
>>>=20
>>> This tackles an issue where the callback client times out from
>>> inactivity, causing operations like server side copy to never return on
>>> the client side.
>>> I was observing that issue frequently on my RDMA connected clients, it
>>> does not seem to manifest on tcp connected clients.
>> Indeed, it is curious that the COPY issue does not occur on TCP
>> connections. You could try using the same tracing technique to
>> collect some data on TCP to see what is different.
>=20
> I did pretty much the same procedure, mount, copy, wait 10 minutes, copy =
again, just with it mounted via TCP instead of RDMA.
> (And I made sure to boot the server on an unpatched kernel).
> Worked perfectly fine.
> The pcap and trace are attached.
>=20
> To me it looks like it just never hits xprt_disconnect_auto, despite the =
no timeout flag not being set.
> Maybe it gets set implicitly somewhere for TCP? Or there is some keep ali=
ve going on for TCP, that never gives it a chance to time out.

net/sunrpc/xprtsock.c:

2999         /* backchannel */
3000         xprt_set_bound(xprt);
3001         xprt->bind_timeout =3D 0;
3002         xprt->reestablish_timeout =3D 0;
3003         xprt->idle_timeout =3D 0;

But no similar setting for net/sunrpc/xprtrdma/svc_rdma_backchannel.c:

253         xprt_set_bound(xprt);
254         xprt_set_connected(xprt);
255         xprt->bind_timeout =3D RPCRDMA_BIND_TO;
256         xprt->reestablish_timeout =3D RPCRDMA_INIT_REEST_TO;
257         xprt->idle_timeout =3D RPCRDMA_IDLE_DISC_TO;

And perhaps these have been wrong since 5d252f90a800 ("svcrdma: Add
class for RDMA backwards direction transport").

Try replacing your previous patch with one that changes all these
backchannel settings to 0. It should have the same effect as using
NO_IDLE_TIMEOUT.


>>> However, it does not fix the actual issue of the callback channel
>>> not getting re-established and the client being stuck in the call
>>> forever. It just makes it a lot less likely to occur, as long as no
>>> other circumstances cause the callback channel to be disconnected.
>> Agreed. I'm hoping Olga or Dai will look further into why recovery
>> is failing in this case (and whether that missing recovery action
>> is also observed only on RDMA transports!).
>> Please add a Signed-off-by: tag. See the "Sign your work" section
>> in Documentation/process/submitting-patches.rst
>=20
> <trace.dat.xz><traffic.pcap.xz>

--
Chuck Lever



