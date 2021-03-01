Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C4D328B2F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 19:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbhCASaS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 13:30:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34388 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhCAS0z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 13:26:55 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121IF0Ys079912;
        Mon, 1 Mar 2021 18:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7jNlGF/n9d4vhsYUIpiaHJieRziKlkyZ11P/XdG2Xt0=;
 b=QP/ZLhTzjbUH2EERinH1hGpQj8Xmfcmn6N7+0+SDkJneVPdGrIS4QPBZ9R2HqdNk12Re
 vhkh5N1CevIn4lnaHcwCv5dUp4ozZrcV2y7mE7OvlfkUPp6Dol+4xjS+coDOrbkuC+Xq
 x3vhD+WMJNnV3UGkHJ54Qi4J0/vLuPmQWOSRxqoBHhMnQwsitIDthtKgdAQw5C9bi4hH
 J71sHC2tfS5gy5rarKOo2+Y+fSKcU4a39cJx0/f0v/w5A1rQbjjObDqJr1b9uoMzBgaD
 EUXPgtWYjirQCHjv+B/VGToaWzKNtykKyUMwN1q5h5TD7sVIcGuz0cMvckmuFmztEUZk 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36ybkb50wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 18:25:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121IEuWR013465;
        Mon, 1 Mar 2021 18:25:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 36yynn3ju7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 18:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLVW4CNDsPrWE8JFUAkbWW9R7E2s11pyFQVfizjAr0MzPLHyd7Cu1s3BDZ8KgMiQLBrY1pdhqEcHb0NIrA7HwqojkO/xWp6Xj53yo7iTFO8IS9RUXQl0YrviEP3g+YuoQY8UOClcNHJt4eg8KZTti3pD5B79XEfF2AYsaKgBrpkS+b4viuzQ2U0rBlRQaDzW423jgMjqfVh5cQejTnQ8GrrBxG4bp0ysJPs8No6htD8wqepVRwU60MAB2TkbOy8kypzzgiXaZRdj5b5R91E4mhX79yw0EpKSGQe8CV00U6/lbMzaoaqCiM4jwa4gPFs81J0ADGzmjWvKvmo4eNf+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jNlGF/n9d4vhsYUIpiaHJieRziKlkyZ11P/XdG2Xt0=;
 b=QLTMERXD2IcQ7sq04Ez8iR5vskKinbesCkqpN5bG8CkzAIOkIHWzaawnRo3tIYO4V2nvf9VgO/tQ6dAYy+aOUNrVgTQajvyVO9rwNdaIH4119m2DGgHuy9BW5j1dyOlNMJpFmVh3oNQRHbKkq9o0Q67yAKGOUsSx1QGZ/Hvjwt+xZaZ8wwQmDcVUb2YBxtmPdwx+CioF1xGUjdfX9XCTtHhzJ/U36anixhKb9/1MuJenSjTbghB/MC9qeLlMwII3zn+51WHuzm9Y0ogKFIhI5FjO0EQpO1C5rXgUNlMu7owweKfVKo85HwQEtsL0jI96ae2Ylx8XM7ip8WrM5Z6NsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jNlGF/n9d4vhsYUIpiaHJieRziKlkyZ11P/XdG2Xt0=;
 b=Ip9nqaepBuHd6zzx7hSMODgtwrzqYuhNbkRF43RilTwcWhvbWNV85Lvo9rPthWrT/of2sQcwa9wFiUAmq1+acJ0LkzAx/UBSiiHlCratc+qBZIsYXYC9o2FO3NGOy8SmDhagaF3gLpucSkWkeodfcHcsQmeBmlAIukoki4CgvoQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 18:25:55 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 18:25:55 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Romain Perier <romain.perier@gmail.com>
CC:     Kees Cook <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/20] SUNRPC: Manual replacement of the deprecated
 strlcpy() with return values
Thread-Topic: [PATCH 07/20] SUNRPC: Manual replacement of the deprecated
 strlcpy() with return values
Thread-Index: AQHXCS01IFrfld7+ZU6LqewR1/d2LqpvfkYA
Date:   Mon, 1 Mar 2021 18:25:55 +0000
Message-ID: <34ECB5D0-6E9F-4FF0-A41D-C4DD4505EB5C@oracle.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
 <20210222151231.22572-8-romain.perier@gmail.com>
In-Reply-To: <20210222151231.22572-8-romain.perier@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba8c06b1-d354-4afc-448e-08d8dcdf7403
x-ms-traffictypediagnostic: SJ0PR10MB4765:
x-ms-exchange-minimumurldomainage: kernel.org#8760
x-microsoft-antispam-prvs: <SJ0PR10MB476527065E1D778DE2CCA6F8939A9@SJ0PR10MB4765.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TIUPZW1dYUOmFGNrOBEa+dO3ciRwuwQldmB+dMbwvRMIwX0U4r7LErQKvZF+lZz06bH4+16Ak/l+L+M28Maf6cuviT8u1/VIuUmm4BngRFrW0X4rVvHvZxFYcEDXmgDAdl5OMToNxxcW/43gGwopSwNdaNbhN92ZZZ6AbMB5gJimFDPwBLbmzmVpWkDE9iEQaaeqCjujuvWLHm7Im2za1wkcYYqEr8NUEidmAQIJkxyasYUsrJJ7uOPKe8FO6VEPejphbvVjkj8HzoUEoZXnBR8SC95vjWksCUW6DW1NUhoSpe80OwvbsPiD8A+i/8Dkn7VS7/H3mWCCgVNe2Tq5urbkYFqncL7HQJVzKUk9IjjKyw0qSuDl4CyvwOLf0SByvfFVFU/BDtqxDe90Bjfk4Kb+5+5kt/tSZGqZQazTmrhULcrYsQDyg1gcXFbG+qX43PMC0FvBSWa9jUqvjtlTDgdjxxEZW5oILECKqUCCw3VK8fNqdTp8ckeIradJaN1fo8A0OyQktaWzUK56RCtvHoCJZ0ma0U7raYH1HqHyOLhCuRUVDJm8AMyoiNrVpGHfT7bMFEzDV97qxxbsr/AOl5o6l51HYQLurnx3ydZHSAcDOpf7y4WrW00ZJSFG8PZ4SRw8C3KXA5lp3c3HiTiIk5kg/QnIC1x/K+3viWp+96c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(86362001)(36756003)(33656002)(4326008)(83380400001)(6916009)(5660300002)(91956017)(6512007)(66446008)(2616005)(66556008)(2906002)(71200400001)(53546011)(6506007)(8936002)(6486002)(44832011)(26005)(316002)(54906003)(186003)(478600001)(76116006)(966005)(66476007)(8676002)(64756008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XMjWviHVWvNeTtiG/UIGax98+LmkMoBxtDxYkODGlEXfxgPD2+crlzHUYVki?=
 =?us-ascii?Q?0UozrrDdpM8Mn1lJalG3QwBpduJCQlFTP5Ko/k+w2fYP0Y87/a5NFK98U+q8?=
 =?us-ascii?Q?in3fWPZvhHfNLLxgZoyip46CA8rg/47T3dlhJVpbn04p9MmyOClmW/Lyshe9?=
 =?us-ascii?Q?kE1PPC/RFZE2+kK8/jD/8z85GHK2sVdWCBjFKquzxeZq6qJQHUiBI0QZxMRP?=
 =?us-ascii?Q?7Q4gIRUM2ebofhkM9IY9wPLhyXbFHrWlZ+Q1wmZj8wMg3txQLFQ/WodjFcOd?=
 =?us-ascii?Q?b1Lxzb+7Oa/q96qx5K90zDi8uVfOi6OJPA2Bnfkz3xm1R6n+b8SRRsA5NgqW?=
 =?us-ascii?Q?GY9iaU5MehY6lMTFr8NMnoH0c+OCpMMFt/mjJceJIyQnRhuiEmaIlf6iL6gf?=
 =?us-ascii?Q?jfjreKMprUleplsgrDYpiRbYw1zfyWO51uu80itH++jOKLBsD5ucl85sGo73?=
 =?us-ascii?Q?nngbHiy4uZhbwtG70POcY76ZEl18VGWb1qMTsD1nQh64y8K6Lc+f7jK1ApoV?=
 =?us-ascii?Q?Yn+Qkq6/MpV2syvYpJNGQ7M3D4C4fRtVtKc7p7yKmoxXIrKLQ1g1CvAgYn0M?=
 =?us-ascii?Q?xeyKgQHR1FblvtLP1UT20RHTDWznubXkLF8sZxIEMyeotA8xe2q0Rbikf3ZR?=
 =?us-ascii?Q?AA+TOGczBqwDIv74wJuhw+2VpVhMvtlya3q4ih7fQ+xxF4Tgrzu/sLU2/TEg?=
 =?us-ascii?Q?T8KMcZLbsHya/XzJs4UxtT22rwbQIR+1yUr8tMzdjlW/+ucqbYW7IfTsxWwK?=
 =?us-ascii?Q?RcRn25fc2WmQyZEdhwBW+NUF9Ji6u5+aMOdy4VeFuDxmQryNTH9S1xdvt85z?=
 =?us-ascii?Q?ylLyzn0RCl03TpLxotPxO1DAaK9c7eJrNFGrxvtFzv6LnSaC51471EJXKQ1e?=
 =?us-ascii?Q?WMmbxDMgKCi9QF8XHzicv1BQIccNkYTbp8JeiMxat4YnueNvQQ8TZ2eW69cg?=
 =?us-ascii?Q?3wKs2APep42xwhCxLjMnoTT6Wd2QZxm/T5x6Pyc+SNqG3DcDgCBkUsAgB6oN?=
 =?us-ascii?Q?nZ3ylLdPZAImq/KiCyJKoRxo18T4As5rbVvmMi8NVHwDd0Tdef1LA6aDzIbo?=
 =?us-ascii?Q?Hiz+Vgtzn8pbx/yCG53xEOyrNOch9p/ck6E97wQBwG7LHOyTJKr+znnGz2o1?=
 =?us-ascii?Q?yHY9+UMHWUrEzg8QO31/ay72JICdJwDBHX8lWf9nFGLkVZ3mhXUIRiKQrb1Y?=
 =?us-ascii?Q?3u+YB3eREpnFJ/+BcDRLfZNjrbRqwpQli7AEVVlEf5afRKAb9YNM44lhLPkh?=
 =?us-ascii?Q?T6osqzC/x3YFl8OFI1RdmUDgSYV58rOSqt+xADu0YvqYL76I6XzedJurvg0q?=
 =?us-ascii?Q?YjtfnkjqLblofbKdAt81QMIA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2690463AA5D9744398354A57918A1D26@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8c06b1-d354-4afc-448e-08d8dcdf7403
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 18:25:55.4088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dL2L1oeu3n+xzhaRZe9i5YckeCxDaOuDXzXbFhj6feo9Cg1WaEOV6LotRue02P8RokjoURS3ajKPRBPdYw+cqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010147
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010147
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 22, 2021, at 10:12 AM, Romain Perier <romain.perier@gmail.com> wro=
te:
>=20
> The strlcpy() reads the entire source buffer first, it is dangerous if
> the source buffer lenght is unbounded or possibility non NULL-terminated.
> It can lead to linear read overflows, crashes, etc...
>=20
> As recommended in the deprecated interfaces [1], it should be replaced
> by strscpy.
>=20
> This commit replaces all calls to strlcpy that handle the return values
> by the corresponding strscpy calls with new handling of the return
> values (as it is quite different between the two functions).
>=20
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
>=20
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

Hi Romain-

I assume you are waiting for a maintainer's Ack? IMHO Trond or Anna
should provide it for changes to this particular source file.


> ---
> net/sunrpc/clnt.c |    6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 612f0a641f4c..3c5c4ad8a808 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -282,7 +282,7 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct=
 rpc_clnt *clnt,
>=20
> static void rpc_clnt_set_nodename(struct rpc_clnt *clnt, const char *node=
name)
> {
> -	clnt->cl_nodelen =3D strlcpy(clnt->cl_nodename,
> +	clnt->cl_nodelen =3D strscpy(clnt->cl_nodename,
> 			nodename, sizeof(clnt->cl_nodename));
> }
>=20
> @@ -422,6 +422,10 @@ static struct rpc_clnt * rpc_new_client(const struct=
 rpc_create_args *args,
> 		nodename =3D utsname()->nodename;
> 	/* save the nodename */
> 	rpc_clnt_set_nodename(clnt, nodename);
> +	if (clnt->cl_nodelen =3D=3D -E2BIG) {
> +		err =3D -ENOMEM;
> +		goto out_no_path;
> +	}
>=20
> 	err =3D rpc_client_register(clnt, args->authflavor, args->client_name);
> 	if (err)
>=20

--
Chuck Lever



