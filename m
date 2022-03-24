Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45FE4E6A5D
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 22:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbiCXVoO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 17:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiCXVoN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 17:44:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB968B6D11
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 14:42:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OJMtNM007614;
        Thu, 24 Mar 2022 21:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1LHmoIL+7KgbOvBREWOC2Ixh+uZ6vmrVoFHpb+zJJ4k=;
 b=JInLwaRWHqO/UymMqnRWfCW9L/moI1cPjVkVY+O/CWe9rTJG2wGsuc3u6vvueHPiuLPr
 QIV2Z+TZuGljnDo7zrDtYUM4TraEcwULW2Db0HJ9dkybeipKS3Qa9j0Sx2Lt12dMjU6x
 crQgUs434YzljrKKCzINTiAzwaLKmdrGJGDrtM29zH3v9qy+9UYcJfJnb7rymghNwxmy
 ZTUT00PtE/UZIUyPCe7BeKnW2hwkZ+BcHIUtaDsB3apSE8lD1TtbXTXtfG2V5BrlD5Hb
 wG7nH3nl+yqZT97S6XY6wGvq/8HdvavAjcuH1j+VUtj/WRNLSXxUuNgQauxk6nbtLbuv dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcwggs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 21:42:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OLarT9158146;
        Thu, 24 Mar 2022 21:42:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3ew701sq3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 21:42:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDSQTzfIuF3R4uH8/oJ+lGa3CotNmK2g40WuqHLjMiC7+J1Wuc0gOqtqDF8OL30Dm2c/kolsGJUOuvLe499FjZj4M/38nOCXy6gP9M8KhJUtj9giG75S+/v0rq2woJRfH0NmrG3yClKVh+VbeH9s/bgMnJYGKGNLhGZf6dRLYUknkSwws6KYnib1PIclDPn5E5nmCAz/Nv1tNkqadcvlbEx5EvaZSrEfq3QDYm46ipNZE2im0AX6PTzRq5UzTcHHzpaA7vkR6guq5pmy5qKLmN4D3eMnHnbGdku0ccB5WKIP5UMX3KTn/A89t7pRqvW+KgrGvmCbKuEVwtZvzICffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LHmoIL+7KgbOvBREWOC2Ixh+uZ6vmrVoFHpb+zJJ4k=;
 b=GRqpOBQr9M0Y2hdLXfoeuB6ITalNUPjAFzfY5bc0+MSbEpujh9fVRj56qLhmqa9Q2r5RVmH93FwYGaNFVEbXBLFleMOSqw2ISzIHZHYZiGTD+892r+171ZLmhcdYfaxpdLGcgNR89jSGJxgOCT5JtYDAFIF4n0UQK/H1kS/JlsH9L6v2RJQ7e8zi4hSUufak4z3Geck82b95+denitC9MhC0r6EaVvZjyClqtGIIgKQ0SKTzsxlNUYFwx88+Qr1rqvJnrkw1hGk60hF5p1HH4/K2JHHHgQS8SKVdIAVhTmfCNZ8pHdsoI0R6ITbcSNa39b3v2qN7+1zG5TxgsCkByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LHmoIL+7KgbOvBREWOC2Ixh+uZ6vmrVoFHpb+zJJ4k=;
 b=Zzw6BKHgzpV/fBL2Si+qtQTYS0AcfclDeuXL2k0tJ5YLge8P1Iz+ccIB2KasuA2ZBwzxfhSyi8AgXawPBnKzKzNlK3sBHKB4476wW2kV5/Bx1fCyb+Aet6OZ6MCadZkdk08yMxMrOD+k2hS286M7J3uzRF/Jv/Ub8bp8tRI2Avo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR1001MB2096.namprd10.prod.outlook.com (2603:10b6:301:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 21:42:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.017; Thu, 24 Mar 2022
 21:42:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] SUNRPC: Do not dereference non-socket transports in
 sysfs
Thread-Topic: [PATCH 1/2] SUNRPC: Do not dereference non-socket transports in
 sysfs
Thread-Index: AQHYP8e+sYOw+awWsEWGB/AApwPOn6zPEJGA
Date:   Thu, 24 Mar 2022 21:42:32 +0000
Message-ID: <80AE76C3-4D6D-4495-AD45-34EC73B12CEE@oracle.com>
References: <20220324213345.5833-1-trondmy@kernel.org>
In-Reply-To: <20220324213345.5833-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 358acd66-6b90-4e84-44f5-08da0ddf3398
x-ms-traffictypediagnostic: MWHPR1001MB2096:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB20962EB7F3032F9612E7712193199@MWHPR1001MB2096.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3f7xDIi6UQdAZSEOSNrkp97aKZwLeA864NKp/i4GaMYHk5qpamxPw3BWNzuORYBPip+QsM4M8OH5LNLaf3hooEq4v5uR8djuZLhNAaNQIvt0aaxnz+79/QAF2Du24g28cOFguxEHMpmYGDPE2dUJYazDpbbmcw73G8A7pKs6nT/v2+e8H1y/8JaZ2JTshdvR+kor8SX2ZQ7AXybx5jeVnof/VSL1PghRNKRG3xwEFUjPfI1ed5Hm98Kt+NerH+brIPMfaDx+WOCs/toWBdmo4LCoEv85/TEIMb5WqRsAKlUjy902b5u0ADmTWjTZKfNEFVrhfezDH501LX1ha2IYKRJQlYBdNh+rnF7DMIIGxzLQa+dhk9ujP7sWxpFAux6ktDiiiDV9ffBpd8pZ0CkvC0QYgMVslMj5JiQzPkoW+tffgVYMQKYTR9GpvpIBA3Bz60RatMCsUy958NBV4VF15DoU3C0GseqEBAjAnh+rzOLZPlC3jLr9m5PB0/na8nh1dujPWowvvYhg14eswOWvRCa9Gx0iySUG4tIqZ2uzo0z7BoZQ50tX7F4soGBryK+Wpnagl50PdAHo+/6jbEGR+gmM2F5sy3Yeogv7+XOL5+YvzlMPEATYEiEkn7Er5LM8Ckob/tdnJTGvbW0LI8ZkIlupsQmwtnGqymAs4VrzjgwQM/k/nbE4kDFEozhRFdNI4sJjQ6vcrOdT7Hd4SGrEx8ZILYnwgoca6HCPSt36Xc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(86362001)(186003)(71200400001)(36756003)(508600001)(26005)(6486002)(6506007)(53546011)(38100700002)(83380400001)(66946007)(64756008)(2906002)(122000001)(8676002)(66556008)(66446008)(66476007)(4326008)(8936002)(5660300002)(6512007)(6916009)(316002)(91956017)(33656002)(76116006)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bNAk3zMqiusZulC/1lsO2ujV6s3bS0eUANmkjWaUyaAQT426bXlbx3sW+qsl?=
 =?us-ascii?Q?gKpWbzE7Enp3aKgaTP31qH0ZSmE8RsE1h6NL2tKxqlFNfycroeF7XKTG3xKS?=
 =?us-ascii?Q?McXHaoJVQd/jKUQwy1ANZSK0QByRHEJSLft72mLj4v0CYpxbOBqyePeFWThK?=
 =?us-ascii?Q?7XiHVX6rdiFz9SN/E/u/q9Xnypu1o0DawKryLkDiLsdJjGgFGS4YSa37wq2f?=
 =?us-ascii?Q?4IVzNZ8xo5cLavLRQwuk4e1MlYvkq9u0ta7V8ur+uJqh4mNLTdJ7uw6VfTBa?=
 =?us-ascii?Q?X79blTKsLiUfERH1PM+zkyIidZJKfH7bObBxtUpFEKWuiIKuon2mAOE2Bhno?=
 =?us-ascii?Q?Ta7B7dNh26in8EMbNLdeiWChNAdvyRlidl65+duPpLOashcfZekhAHKatcfs?=
 =?us-ascii?Q?qffvfXd9ihjJVREabAE9FuS+xoS8u21C9+tCHKARyPDbmxBIUHnuoNB/TCJ+?=
 =?us-ascii?Q?Qy93dVV6k/3FOQGceOLon5uF+gsaV72ulAY4xc7L+OAQsj1RSQPvq4FbT0aN?=
 =?us-ascii?Q?mb7dqbvAtpB145axmW4Bxs9z893CmHaGP2hc6Mckgo4ny4JQH6MDXNW2PTob?=
 =?us-ascii?Q?N3sxDKdDsVG9AREr7LLcozz8OUF2fkionJoIsSIaVX2NTd26LpU/kmcN1Cfo?=
 =?us-ascii?Q?eJuzGxxMIzeS4E9yI6nMgmlPMQRcQICHskrD3JQeMsoNei5xl0g889uGKKVs?=
 =?us-ascii?Q?jbmIlokvZ/FP9XnMrt7JF6JT6ditCOtE9WxCBbe++soYxMTWmJErLoCJG+PL?=
 =?us-ascii?Q?p8OifrmrbqfzOKeTwdx0fEsJO09YnAZowaxH+NYFVLS9w3nQVQthFMEJpik/?=
 =?us-ascii?Q?0I9czIFOOxEnzvg6XcErm9FrhjeuLNbEVkTt+m9RPjmbq7vBw6fZUsJ0tAym?=
 =?us-ascii?Q?K5QFLrb8EcFcOMuTlcpZaIgZfa/RZPxITQN3qweTDvJeCR0JpGyxiR2Dvdcf?=
 =?us-ascii?Q?Khpf6jVn6Zhbw/TwqarAgRqPIcGR7LyLRvS5hF2C87BD6QZoO5azkF4mDzHc?=
 =?us-ascii?Q?7RZAktRsJsCJ+bM7Np7uyLRPwfeHq1OqQGRwWmN9MtHkLjaebONwDZoHsGn5?=
 =?us-ascii?Q?rrkY6FTLC15IB0MGmIFXBKf6dVKaHP/YqpAarjI1RIQaTA3llXdCUjIfGrhy?=
 =?us-ascii?Q?ld47vbeYE9UpuS5dZ6yI8KYRd1BUF03xKYxqiLv+y9ffnfAWkpesWO00tK3D?=
 =?us-ascii?Q?MA5+HCGm2wyxnUB3yHQFtzvLoQMgNsyBB72vW26YS8nZITn8EqAO1TnJ1Ui6?=
 =?us-ascii?Q?IKUTacOyMaoafltP3u9zAu4aynRyrCK4cCjjbaj1shzD4Aw6RaUOxTx3kPAJ?=
 =?us-ascii?Q?ty/gBXZJpxGF+VjTqr/y5Nu4MPOee0s5BqjGJXhfAbkYdYc98mjdZxj/hTRV?=
 =?us-ascii?Q?tiFPUNfIpYN/DEoKYhjvU+pnoRQxVeVQRmyY8n9k6Soo/4293MYrlXL+jDC7?=
 =?us-ascii?Q?u34++/eEiFj8XQgHoUy0Zb+3ROqdMitR5gJkgA851p/nDiIJgqiC4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9CBE828DC8284E47B87A2E071A100AB9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358acd66-6b90-4e84-44f5-08da0ddf3398
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 21:42:32.0206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuvG0pVJxFCPKXtpDZRlCq7eXmeCiKBdV6BO8WMEeVjv1KK+2p8BnLV2PygcLpqXDvp9H20eiBHYTtGkN9uBxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2096
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240113
X-Proofpoint-GUID: XRX5Jv-OakkBV-Pc6PuyCpbs-7bUcy9q
X-Proofpoint-ORIG-GUID: XRX5Jv-OakkBV-Pc6PuyCpbs-7bUcy9q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 24, 2022, at 5:33 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Do not cast the struct xprt to a sock_xprt unless we know it is a UDP or
> TCP transport. Otherwise the call to lock the mutex will scribble over
> whatever structure is actually there. This has been seen to cause hard
> system lockups when the underlying transport was RDMA.
>=20
> Fixes: e44773daf851 ("SUNRPC: Add srcaddr as a file in sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> net/sunrpc/sysfs.c | 32 ++++++++++++++++++++++----------
> 1 file changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index 05c758da6a92..8ce053f84421 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -107,22 +107,34 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct k=
object *kobj,
> 	struct rpc_xprt *xprt =3D rpc_sysfs_xprt_kobj_get_xprt(kobj);
> 	struct sockaddr_storage saddr;
> 	struct sock_xprt *sock;
> +	const char *fmt =3D "<closed>\n";
> 	ssize_t ret =3D -1;
>=20
> -	if (!xprt || !xprt_connected(xprt)) {
> -		xprt_put(xprt);
> -		return -ENOTCONN;
> -	}
> +	if (!xprt || !xprt_connected(xprt))
> +		goto out;
>=20
> -	sock =3D container_of(xprt, struct sock_xprt, xprt);
> -	mutex_lock(&sock->recv_mutex);
> -	if (sock->sock =3D=3D NULL ||
> -	    kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)

This would be a little nicer if it went through the transport
switch instead. But isn't the socket address available in the
rpc_xprt?


> +	switch (xprt->xprt_class->ident) {
> +	case XPRT_TRANSPORT_UDP:
> +	case XPRT_TRANSPORT_TCP:
> +		break;
> +	default:
> +		fmt =3D "<not a socket>\n";
> 		goto out;
> +	};
>=20
> -	ret =3D sprintf(buf, "%pISc\n", &saddr);
> -out:
> +	sock =3D container_of(xprt, struct sock_xprt, xprt);
> +	mutex_lock(&sock->recv_mutex);
> +	if (sock->sock !=3D NULL) {
> +		ret =3D kernel_getsockname(sock->sock, (struct sockaddr *)&saddr);
> +		if (ret >=3D 0) {
> +			ret =3D sprintf(buf, "%pISc\n", &saddr);
> +			fmt =3D NULL;
> +		}
> +	}
> 	mutex_unlock(&sock->recv_mutex);
> +out:
> +	if (fmt)
> +		ret =3D sprintf(buf, fmt);
> 	xprt_put(xprt);
> 	return ret + 1;
> }
> --=20
> 2.35.1
>=20

--
Chuck Lever



