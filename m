Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB12324038
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhBXOmo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 09:42:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236469AbhBXOTN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 09:19:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OEEc17116097;
        Wed, 24 Feb 2021 14:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=etFkRci+GprCNvL2ql+4yWxJXFkzzTMuyHQlnCr6Od8=;
 b=j3fqb3HctMp/kPvHYPe04SUbMqsqQsF19vY5MC/X9r7g/Tja+gBGDmCS6RW4R0rHCSPu
 UxmMNqJqsTOYBby0cIFMe+AZGryi8gut2uifGLn6hx0UESpk84NUMCjH5Mt0osV8+k8X
 94StIPxBOQ/f5aGeBwku8qejAXk5foOhm8m59vZZI2OYEvhRVVvBu3bvWACKvxb5hsOC
 54H09Jr4r3sjN5oVG8mQD1gq0wSoHvz/fVOLKvpAKv/yef2OrrlUUb4Okh2bHpvswJO7
 zOaX/6f8Q348To3b3sY0+pO7J3YynEb7CUHmlWvSEXiM0fo7XhkW51nNfIeRfqE4tB8i 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36ugq3hx15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 14:18:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OEGWLa023519;
        Wed, 24 Feb 2021 14:18:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 36v9m60ntq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 14:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx4GhKZxjmbmaEBXDfUjDVfuIbJ+GEBdjzwiC9xMFaPmGNkhdyTLRKYZu7JovYrS2X5rVodjdxSbtG0AS1SmSODNpbEGM8H1RSPI+ThtrnTCgXUJBJrWw3EdstdDTAHf7EIoQj9UW/yDd4bEzVsW4SrgT+3FXbcHK7CHAEdBR8QGoFJoVPWzq74x1P9ehK7djJxJMhtebohuhTAHWnz7aq/8iIRQNeaKiBQ9aBHg5DMGpuDwzRlXFtvtxcP8jhpotZxlruzoTujVKSNnCM5NwKcv1/yDUvmDUlUwzAbbljyaJYxZDGlYk0g9Vak3iSJFL1+jL2Gd4yduNMDY6yo+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etFkRci+GprCNvL2ql+4yWxJXFkzzTMuyHQlnCr6Od8=;
 b=LZkVpr0qgqh+wO9Nsv7tfET/B2ZqbFoxG+QRh55UnrgBpbY1YDWHong4vNlnBTeCEpzIaCRmqZMbYX1h9VtaFUBITaU7s1deRfjs5zeh67RYFhQgkEv7TWX0OgWPo++Rhzm4XhcWWXgBlfZNzzp8jZAjKmbL1DeIun6zHsedbVSKc0gKhZGHOCWNQfMZ1bugwwOCEKTx4ILk+eDQMHvWXvnO5ju0vPoFtML7bMZDDNmyEjV8+ly7PWrHenvjkJdJsXnTRnarw79dohk7ciFH/sjxhdYPV6AkwYKWWx7FBAjUzz3h8A+02E+n17WzKBK1x2JYqLUWaTD9dyQMA8/Z6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etFkRci+GprCNvL2ql+4yWxJXFkzzTMuyHQlnCr6Od8=;
 b=0H6Cmghy5Q4bwiCr4IXv+nje5fzT/JG/HKxguZsTDMP7BMyLFRqJVBw1sL58Y7zJQTXN19m8DH6mQ92yX1AORPatRSX2F5veUq1aMExnNI6ibUBtk9tIxeBB8498cmX2bnMkmld2liFcnr6IPlL8hAJrWQ/RuY9MtYeNDRheGK0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4813.namprd10.prod.outlook.com (2603:10b6:a03:2d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 14:18:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 14:18:19 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH] svcrdma: disable timeouts on rdma backchannel
Thread-Topic: [PATCH] svcrdma: disable timeouts on rdma backchannel
Thread-Index: AQHXCXOTv6ms0S5nPkS/+o1NfiK5PqpnXOQA
Date:   Wed, 24 Feb 2021 14:18:18 +0000
Message-ID: <E650E8DD-9F65-4029-8F3B-AA854AF575A1@oracle.com>
References: <C99EA5DE-814A-418B-9685-D400F4E7B964@oracle.com>
 <20210222233619.21568-1-timo@rothenpieler.org>
In-Reply-To: <20210222233619.21568-1-timo@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05cfb8ee-ad81-471e-8fa8-08d8d8cf08d0
x-ms-traffictypediagnostic: SJ0PR10MB4813:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB481392411B11492F13F2B695939F9@SJ0PR10MB4813.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70FF7s1yt6aFvc2qd5Zi1GmbN8LgrWkX6Ky0K5q06Fj463tUYT4WX5tjzdElRnqFfFs2xNPU01M8XWjhVhom/Uyn07UTjwT0KEoST5YbSbWb8LGOIxQBiQy2KK35CdF8Ouqstg94aq/Ugxmjsm/HiWnC9S63WAXgPn21NTeF98GqykLlLRiKsDoDP6gK7frMdFZVwX7QHqAWsNzk3HxZjERsAmxYQazh7Fgn1ZEuptJDljsccjGN0lSZ+zP/WCokaI9336BaMz+hSahkCvU0Hkx0MF0mhyHotPW9XUB4qeLGST0knkOwGaEcCy7T0JB4MccNKaw8+jacDFJaFfkJjTsETegsCoCFMRBdoBizUzqI5jzx21MYV3gYIxVMoRwdPzkaPdQLeJts/QmVgis4AAF27UC6ZfUu7tGs1JudrrlwZ224Z33SNK0GMt051vLEaIjPvpLXl/7nOcrIRT2PtTfY6VPT8xqH4RsahXlo9AhMQpGefffDg2sx6FDl7cLF0AmExFgrZLbJmYM/TaU/vWvRPt06x4tDenXSPBhbjo36CzDwMhrq5c270tnqjscxfEydJjy1hXssO5U/U+0Z4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(91956017)(86362001)(478600001)(186003)(316002)(54906003)(26005)(36756003)(6486002)(4326008)(6916009)(8936002)(8676002)(53546011)(107886003)(2906002)(71200400001)(83380400001)(2616005)(33656002)(6506007)(76116006)(6512007)(5660300002)(66446008)(64756008)(66946007)(66476007)(66556008)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JqZQE1MXLXadauSlzeAVQHV+zRIVq+cvVQjmQ5mhhhVRvQoS2BhPJTiDy2Po?=
 =?us-ascii?Q?n9n7E29mQ/fGk0TgbUa2Sd5+4OX3ISqfZ88JSQAx26BtDLUTxS5Z1avK7oao?=
 =?us-ascii?Q?K6BeX96idDzpaLhto/9B/ZENwUlvXPYSuHge7kJRnYsnRIYrB8Llmcs1Es4f?=
 =?us-ascii?Q?4WFuYz/rZuUurhiOfe6pEvkjwwgoOa2Y121zZ2ioRRjqussvjAG0g+fY/clE?=
 =?us-ascii?Q?XfONxnF7RZPkQZuhKiG3Xo4qghwNO1ta6h+o6jPIg2bWQQSAo18HS6Bb/b2F?=
 =?us-ascii?Q?41uKihLSsWVDleSkeuK14s0vVWslRt4XYyjav+mJICj5nAcBKebKSQ7G77R/?=
 =?us-ascii?Q?BR/E7aqElf3nUH6xuU9kSdsZgwGMF8eNiJVSQmEPeJqMx/8SCRSkmTqzGmWO?=
 =?us-ascii?Q?XgMQcIyxnFQ+3d/evlku8vbsW5erXSQRJEUpaaViBaWqnRl0SlmoVoQzXiPH?=
 =?us-ascii?Q?a6qvUxF3ufeb20qlGRXIbiLQtcSLfUrYUNmKU+aIJK8V6O10lLLbQpkXu8ro?=
 =?us-ascii?Q?AK6YGPMe/6LKS57zkzrKTMvbpL1UdrhGYAoGGUAUd+EGZT9fd/mvcb1+zImu?=
 =?us-ascii?Q?i2bJ3yeeYyPykNYeBHXZjUkpfZFe3YZQNC8J2eksxorNcnm0G8DZhOqmL6hP?=
 =?us-ascii?Q?YAFOoZZLrxs/eH7etljxWpvWp1lItSuQlvP9PnD60i04gHwXVx47r38SENu+?=
 =?us-ascii?Q?pEW8Ukj1x0T45UOva9SzSqZ/ppnC6aH+h4WrK6MlO9V+ifPY7YnnnyKwTVRp?=
 =?us-ascii?Q?dxLoKeelnzZjfaUgV96355K1fawLzwuzgMdCKYqqDBqreTFyClnQdahxL8aP?=
 =?us-ascii?Q?O7FvYT/NyfwTbSD6gQY8kZVzdTiG8e6VTPP9wqWvJX/cU/myXMRa3tAI1JOF?=
 =?us-ascii?Q?KbksR+uVzrglDzHbeICumnsTChdFkffeJCA6GHO3NlNJUzUSqIPnNOemI4Q8?=
 =?us-ascii?Q?lwXREuFpmrdGxfv8e576t4tCyAoCy3d3deFNlYFBISH3Nr3n5awX/XZNAwTj?=
 =?us-ascii?Q?8yA0UNZTrXpieU0oTqBhYL+fo2Tj9sv7aiUMoZhjWdQz/RtnbcxRCXTnrHRi?=
 =?us-ascii?Q?MCYZASXYF/2RBPGFpE6UpPpief6vso04ecliWygg+3dbWyDWxBdT0PvA/bfW?=
 =?us-ascii?Q?oZcX6NYOV1JZW+daSJCdLMcgbHnKurSGGSCmgmaTnXiiO9jcAhF5V58aqNrj?=
 =?us-ascii?Q?AJpzUtuR95KoUbwbskGdzns1tCUEnTcIuGZtgtDPboHcAt2mhPUQS0Tj0A+h?=
 =?us-ascii?Q?QZ4PO3Jtgc4CTeYcieOBHvPO2yqffZJlH2pnZcSKzzDHcR4LAHvFNy/aZVte?=
 =?us-ascii?Q?JJAfsJeM0NBmv2tICbNtPn9miPxys2rYilO4DGn68dVdBg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F00444E5597B6A4B9C8F676C822D0AFD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cfb8ee-ad81-471e-8fa8-08d8d8cf08d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 14:18:18.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAMK9sfRIt9Z8METCjrgnaU0nF49MQPzi5VJx4Oq0su1J1lH4aIi4FouhVVqCNJyuiICMjYaxIejSAodQ0eEtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4813
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240111
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240111
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 22, 2021, at 6:36 PM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> This brings it in line with the regular tcp backchannel, which also has
> all those timeouts disabled.
>=20
> Prevents the backchannel from timing out, getting some async operations
> like server side copying getting stuck indefinitely on the client side.
>=20
> Signed-off-by: Timo Rothenpieler <timo@rothenpieler.org>

Thanks for your patch! I've included it in the for-rc branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> Did the same testing with this applied than before, and could not
> observe it getting stuck, same as with the previous patch, which I
> removed before testing this one.
>=20
> This obviously still does not fix the issue of it being seemingly unable
> to reestablish the disconnected backchannel.
> An event that disconnects the backchannel but leaves the main connection
> intact seems a pretty rare occurance though, outside of this issue.
>=20
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprt=
rdma/svc_rdma_backchannel.c
> index 63f8be974df2..8186ab6f99f1 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> @@ -252,9 +252,9 @@ xprt_setup_rdma_bc(struct xprt_create *args)
> 	xprt->timeout =3D &xprt_rdma_bc_timeout;
> 	xprt_set_bound(xprt);
> 	xprt_set_connected(xprt);
> -	xprt->bind_timeout =3D RPCRDMA_BIND_TO;
> -	xprt->reestablish_timeout =3D RPCRDMA_INIT_REEST_TO;
> -	xprt->idle_timeout =3D RPCRDMA_IDLE_DISC_TO;
> +	xprt->bind_timeout =3D 0;
> +	xprt->reestablish_timeout =3D 0;
> +	xprt->idle_timeout =3D 0;
>=20
> 	xprt->prot =3D XPRT_TRANSPORT_BC_RDMA;
> 	xprt->ops =3D &xprt_rdma_bc_procs;
> --=20
> 2.25.1
>=20

--
Chuck Lever



