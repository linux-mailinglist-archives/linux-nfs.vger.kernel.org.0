Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEAB320D24
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Feb 2021 20:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhBUT1s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Feb 2021 14:27:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51544 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhBUT1r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Feb 2021 14:27:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11LJPDAi019458;
        Sun, 21 Feb 2021 19:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iShlJejsVm5kpdVv1l0WrkUAD1eRPb4w76zyUXZ+t9Q=;
 b=em1vLfWXjzisJNLaeDEsFDzgDss5+uw9e8/X7JD95utfPyoBXhhDRh6oDsLTk4s4e44/
 UYMD5fejmn6YbPQGd5UDOAOU/4luvq4BL0IkuttRwVSqYBnIj8ztU1AXKZDm+JU0AntV
 Cb9/tyCeUQtbn2bR5SBmhTxDK6+ZQSObeC8bSkTwhFFEK50USzSVw6e+A2Zjsc1daLmm
 g+e9wQ+1BJ6UUNSdSMvHq0XPpij+fjPzKtkpSowmTqijU93NsVyY3H5VzL6vLSBtBl8K
 ocPIJynrmMQYlvrbXI1E3o3hMzv4z0bfqOy7/a5y11DgvtSbWtrfbz6SDf/q1rGR0Vu9 PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36tsuqsw3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Feb 2021 19:26:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11LJPwMr118851;
        Sun, 21 Feb 2021 19:26:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 36uc6pjyt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Feb 2021 19:26:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX+1+Z5uyQm7Ci5XmKtSGWQjso0i5cIVauFfRqa8lSO/qu5giT8yl21vJwPLuGR5fILJjX3cHrwNqx6tW9sN30ytQMfKC59NIAnpJpdq66VwmvS6AaPSKBUZPnHVcYNrAKFI1ZP4X3LXUNe8eqZ7QsRh6uYamMCyIIiFDU1oUa7JSP/OsL8gnRyJmqPbMEy7iRV6CAheKSdQ8tsmdEo7bgkbbT8L4F+rO5yNrSN7WftbA83Vo0bqtU0+UXOaizdtVF+ItaVX3NC5T+7EoZq/18nynDYyPKTQYKZfU6N4qjK8Egq8gd2HBk0yOYTuOzlHSNxMVw+09CEmc+aIn7vUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iShlJejsVm5kpdVv1l0WrkUAD1eRPb4w76zyUXZ+t9Q=;
 b=JrqFfnlYziMxYtRHhDmSh3r+PKLz9UyMMCBckp9TBCvZzx7KsYVzEjlXZlvISODwDVyOIYdeVg0k118EeHON7AI8flzmMJVE2I+kOWKSqoyTsnbdLX6HCcunWGUTFF1MMa7I8FduAYFenKdQPA50laxWfmVtU36sFMi77QKEJaepPPyc5+GOQeOZ1D49gVdiQXBH1e9SmmehGN8oDNa9tf+PVG45vhMizovK8Y/Y1D0oFNN8W4nGd2+Wjx+huGk3SMQHwAqEN2Xxohb/79uKmlMQU3t2vkzWBY5V5Lmi4GsEeArDN4ZCxpYW8O/qDaGBVC0wcBNbfVYUBbRerKS09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iShlJejsVm5kpdVv1l0WrkUAD1eRPb4w76zyUXZ+t9Q=;
 b=eKI+93pS6ri0YYrbiqhVJwA+h0Vg6SYzM3cAy2Y+bKZv1RA2pcrq8A/ZiDHVnAuYdVpGouBf8FNHLLkj08FUzCUPAm1Oy4bRjR7IV6Ds6VIVn67RaJ8p2P0ZvWTMeDBo4Lk/jqcGbVtY9ceSvPDUz9JfdsN/DPAPc5w1VG6JzFE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2758.namprd10.prod.outlook.com (2603:10b6:a02:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Sun, 21 Feb
 2021 19:26:56 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3868.031; Sun, 21 Feb 2021
 19:26:55 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH] nfsd: set RPC_CLNT_CREATE_NO_IDLE_TIMEOUT on callback
 client
Thread-Topic: [PATCH] nfsd: set RPC_CLNT_CREATE_NO_IDLE_TIMEOUT on callback
 client
Thread-Index: AQHXCH83nfMXcY7VqUGg5DZ3Kqzkv6pi/gcA
Date:   Sun, 21 Feb 2021 19:26:55 +0000
Message-ID: <EF096827-F543-429E-AC9B-1E93C6A35B02@oracle.com>
References: <20210221182700.1494-1-timo@rothenpieler.org>
In-Reply-To: <20210221182700.1494-1-timo@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c80d4f1-0400-4542-c4a4-08d8d69ea67e
x-ms-traffictypediagnostic: BYAPR10MB2758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB2758160E0A7341E584EC731B93829@BYAPR10MB2758.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gdUMAG4RR0FJ0trUvVMPHRoy5H9ch22fN5+R5z3A7gHR4/qJq0O+yo8nht5exw+4lBHKkwVav0nta27qXPyHZX5k5EtIOVtCxn1xk559zoLWjfURGAM1btxI2KR5MKEv1SKFTSTpxl3QJu7MImOkjyLe3AXBb1SiCsmf33sJsVVfZ0wW7qxBYouiZMMi4xYmTHZwNfbWH5/LLRoYZbhMNheqIuQJV2QoTiqbEkfHdYK/qsoxbarBlG3w24/aYhq+J+Zqw8KqfwO/dOEwrtjtNDJwwC/i+U8C9w+S0CS5m+1i+YdmCzjl/Iqq0+HGrl3uQlzIRzyLnsyllBxYY2DpsOF8/xNur9NzkLbysQWLlvRecLRmqtlNRY7tDRjaN0UHP//euDXeV1ic3/9DsU2EGmqfsGAtLSC1grKdsro8/xYrBMyAbQ6WqWZAmbslKxaVjqKXf6++D2QHE6uDgIZRNuuZCaFRJ8RCJ68Ffa58oTPOCiuQGAhIJLCmNLt44zq21gF9IIBLJRZA9KSZXhHDXcoeusUKRQ6tXUg/hb5HloO5PIS69x3zV2EY2wkDk4L22oJ7cFCZ8+fMuo1ONW8I0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(316002)(107886003)(2616005)(44832011)(478600001)(8936002)(54906003)(86362001)(6512007)(71200400001)(2906002)(66556008)(33656002)(6486002)(5660300002)(4326008)(8676002)(66476007)(64756008)(6506007)(66446008)(36756003)(91956017)(6916009)(26005)(186003)(76116006)(66946007)(83380400001)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ve9NwT0clCF2ithm6A9nQEf/G+PCgzgNjU9NjaWxwVj6XFwx7/hYsBptv6xl?=
 =?us-ascii?Q?YvBbEOwughnsPqleQ1HmQMI4yXdLC7XiilOKDhHpHImmckLOkFxEj35oChhY?=
 =?us-ascii?Q?8ViMvQp8wHCisP4EQQaSbGArQvwefYq4/1CfS2elyvFRhpxIKYpUnF/LuSMR?=
 =?us-ascii?Q?DbGMY8EbBKN24gKIFMI7dENSvwvLDeOiSioypG3iNT6bEN590q4+9cPlOinA?=
 =?us-ascii?Q?FmWvAWo+qtHe/sHieg9qJaRWkMREPHKgpIkgd1b3eLDmLQwiEd0ek5skqP0I?=
 =?us-ascii?Q?aI7IFeSLk4hDl9mvyqM1tPD5WkRwLnvZyVYYR8971lzoGIGd2UjiUk+ppeps?=
 =?us-ascii?Q?Iv45zyBrgsmpfunnG4lnTrB5cnwgsJFyh5rLJAKhiUcgOASczZdCC4ilkPlc?=
 =?us-ascii?Q?cv4TEYTkiRJZVPGnup8ZVTNBHeImOW8f8NvtBkzx6F8SdrNQFWUai3BOVgap?=
 =?us-ascii?Q?Pm5f1V/+HZjOzNZHBrqkgXUD7BpelFVj6gXv9R/QVCjkB4axddti8862VJ/2?=
 =?us-ascii?Q?LZN6dEaSEdxMN91O9id9lQJRRO3WUkupCUFfuK8EGvxUicmtP25wPH0R3p9P?=
 =?us-ascii?Q?RLANOjoLg7RGVp4+S5wi1lC92089gLH2VfLNMY9MtKyCpsUUu2KNmV14giyy?=
 =?us-ascii?Q?tGah3dj9/aSpewmh0UFQh3cPbHLjPolOAfguQbrA6zQ9d7nNJB66MRo3MWUW?=
 =?us-ascii?Q?1uJ89CbTI2I/81AgIIqBfx1xAO/Ci9NAY/kDTNtRxtC06rJaC1xJfcJy+Wr/?=
 =?us-ascii?Q?qLHSrg14yeCJbtNZj8Nn3/bnJjZzOOX6jNOSAeBqupcezh4J7Z7LN/VFQk5P?=
 =?us-ascii?Q?iPw5uRgC2nbu3JrU4bVy3iJNLjSzjNFu1eM7AozZO6VhQq8fhWUZpIUN7zhr?=
 =?us-ascii?Q?zziKDPCJwEMylfBrHLoHq9Ze2LLnjZUVHlq+LZozzHD0VmL5e7MnrFDLBDVE?=
 =?us-ascii?Q?UJG0yuUjuukvoaH7AUZIqRm8w6r/phb19s2fYiWeDyGh2rDGwic++04B0JhP?=
 =?us-ascii?Q?EelpCbHt7103h67038jGRqRPkkVzy6pJvVXm0dVZ+U96Sbkfvj2JqOFG9jJU?=
 =?us-ascii?Q?ZNmOU2f9/OR+ovCLBO3KGPB+au0R3p+imceOP8jCSCi9jemK9WP5VGNtu9YJ?=
 =?us-ascii?Q?N+g//+HCHqGJjdNxwyvq2iYL0GuClAIKbr7/Lqrjt86WVuzWjYelPRBj7LzM?=
 =?us-ascii?Q?Y/RPtyP2Khcex62HFxKQrTqEVC8NGwQ3o8YGaukVKub5w/oXUz1f9QGIgnfV?=
 =?us-ascii?Q?memSor4AAjsgXpXgeF8SwpxSaAPYnzWzLwQhvLaOGtKJGx/IkhsYKuOH7kON?=
 =?us-ascii?Q?Ey78QBTS0nnBgArFeSHVBO7E?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BE152C803471149958A9A4F43F5F506@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c80d4f1-0400-4542-c4a4-08d8d69ea67e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2021 19:26:55.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /u3Ub0TSRT5i2RhJa+NvFqBz6j7GcKoPBxOkYV/MoMbNbjNYmEcsmsf9GD9mfw1fIstgFVQUmlrxeImsV58EyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2758
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102210199
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102210198
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, Timo. A handful of nits below:

> On Feb 21, 2021, at 1:27 PM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> This tackles an issue where the callback client times out from
> inactivity, causing operations like server side copy to never return on
> the client side.
> I was observing that issue frequently on my RDMA connected clients, it
> does not seem to manifest on tcp connected clients.

Indeed, it is curious that the COPY issue does not occur on TCP
connections. You could try using the same tracing technique to
collect some data on TCP to see what is different.


> However, it does not fix the actual issue of the callback channel
> not getting re-established and the client being stuck in the call
> forever. It just makes it a lot less likely to occur, as long as no
> other circumstances cause the callback channel to be disconnected.

Agreed. I'm hoping Olga or Dai will look further into why recovery
is failing in this case (and whether that missing recovery action
is also observed only on RDMA transports!).

Please add a Signed-off-by: tag. See the "Sign your work" section
in Documentation/process/submitting-patches.rst


> ---
> fs/nfsd/nfs4callback.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 052be5bf9ef5..75dacb7878b8 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -897,7 +897,7 @@ static int setup_callback_client(struct nfs4_client *=
clp, struct nfs4_cb_conn *c
> 		.timeout	=3D &timeparms,
> 		.program	=3D &cb_program,
> 		.version	=3D 1,
> -		.flags		=3D (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET),
> +		.flags		=3D (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET | RPC_CLNT=
_CREATE_NO_IDLE_TIMEOUT),

Kernel coding style keeps lines at 80 characters or fewer. Please
find a way to keep the replacement line under 80 characters.


> 		.cred		=3D current_cred(),
> 	};
> 	struct rpc_clnt *client;
> --=20
> 2.25.1
>=20

Once you have received other review comments, you might wish to
submit this patch again. Be sure to update the Subject: line to
say "[PATCH v2]".

--
Chuck Lever



