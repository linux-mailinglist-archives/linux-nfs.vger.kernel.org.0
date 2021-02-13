Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2277C31AE39
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 22:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBMVyX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Feb 2021 16:54:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44360 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMVyW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Feb 2021 16:54:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DLouYW048324;
        Sat, 13 Feb 2021 21:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=h7qYdtoIiza4Cfz0vVOxWd2jNEuMyF7oScTdWp8m1bU=;
 b=JccmbMko2OVP4Gje6jJiO54Hq0X9NEEoVs7hyaneS/TgiJKyNDoNaxYdn1rcrznOKmKY
 D8K/slmSKbfNlHpXFf0DqI8N+/h/HGy4gXYl1vKeRvXRhLs1kyUskSq/94Jr7pTYAFap
 znPczncVYmzGR3HwaAtnopjSCAVZlKr/5Iv/ZdYbJlTslIQH5SFUl5SsOPL9brWY2DKK
 gXNbMEs8aSIxkHWPvWkY05HqC9ZTCh70/Ir1h+2QOQg/9zgKncUxroRGMGoNXC8o60El
 aiTU06nduPKAUlkT2MUeUcoKxQrNZTVrIvbU91KDMdQvQKIE7C3Sa42KzRo6zbG67ezg TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36pd9a0hy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 21:53:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DLjqVY152010;
        Sat, 13 Feb 2021 21:53:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 36p6d9cf46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 21:53:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROa9SxIA+DAXN2IkAN7SaIW+WYdmyeIDUyypokoztbNMALmzknKdr9/zoEv9v/PD3SwYlgO5lM+ngQ13XBKmn2cyxZrWyZGph9CYPyKWOVFCqtP9upsDm3hTGH+g9eL+uRmDIJw7Ap8K+wKdL1GOnS2nGFqthLZBPhte/CdH4gXe0oIFz+GCg16kzRYD4GFHohJVse/3Wm2F7QlBs6xoygq26z1kHwkpgB+Kwi2jfCqlcgKGoBP1PcAxiwF1w9VnphIdLIPVI0T7wi2QhLxTOYEYa5pzWwUWHh9AYp9p/GI/fGkWMczuTG/TIAc88erAMCrXorbM3C/IGUEH5XI8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7qYdtoIiza4Cfz0vVOxWd2jNEuMyF7oScTdWp8m1bU=;
 b=JmdZiwkfJLdsFt27QZptvJQ57mcj1IjHwfpDyH0Qi0dkuBvvqTuQOBlRi9JJ0tpGt8907MpzLDQr1trJbj62GBZJmWBOVqpd4ZbZQnh6ak2JD/Fiwr3P3KkNrHCCHGkynW0mgTDkQhpkKKCls4tz+sypgV9w60uVCTYQAZXjCAElyKbK5hXddTIn1pdkkpj87qlxI5OSjLMLk7o8bB/V5UMQh5+FTFTeC9uJCRL5gdi9yb+/IykoxfNZGRnsfYYwRLPLi8ZuZEr0zWP9ZPHZh0XnrWOhLtA7ZI6PHQ01TH/l991AaMdtcNfVonkgsWBqgH93/h1wdWedzZyU8NyobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7qYdtoIiza4Cfz0vVOxWd2jNEuMyF7oScTdWp8m1bU=;
 b=JK5xnjCBwwmwsgXyeTd7CH9A8en6gX2Z27K6S2V0sfyjwJq2avtcZCPCLzY/StHVpXApbyKxzkPh7Y0+rmTvqjJfJwjAgFZdarvGtFs2Kd/MSSp/YYs/WgCVqKBJcQf1ulH/j0o3BNb9IxlrWdoFTHK6e5xG8AoR4QbPSpS60nA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3953.namprd10.prod.outlook.com (2603:10b6:a03:1b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Sat, 13 Feb
 2021 21:53:33 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.038; Sat, 13 Feb 2021
 21:53:33 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpWoMoA
Date:   Sat, 13 Feb 2021 21:53:33 +0000
Message-ID: <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
In-Reply-To: <20210213202532.23146-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c48e027c-1214-4c9f-4948-08d8d069cedc
x-ms-traffictypediagnostic: BY5PR10MB3953:
x-microsoft-antispam-prvs: <BY5PR10MB395364BEB5A5BF356D312CEA938A9@BY5PR10MB3953.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zx2ENlQxKz+Rc8EA1T6sBNvKBeGzRCm3nWNSQD5i/IF3/DI4dNJn5IT4wC5B2j5lMfrJF0c5riDd0D/WuoK5Bnp64w7MW+468Fm8keX7xPQBCwFdme1yyL5d+ku6X8z1qv4SU/cNPAtVlVWr5Ry+CYABtnp3DQi/c6gEME6+dwok10QuxgyVku1x7pn2pHUuYYsX/Dkl6C3GRpKEYDZBJ4Zx1Q37A4ubC+BhyVU7QBktrV8Z5h213BVVfxeAWrRDTf3iS+Eppzl5BtEhuIoMt/9FuJvN/9WMotY8y+vBnEhneTUF9sVFXk7Wkwb4buZDBIRaQBo+U14V4PHaSg0rMB9NiRxCyNS4toBWpfLTct1O3hYD831kbU9JsZU23R6zJln9gK6ml6xAoL5emPM2gxW0ndrh4vw9tyXqK3yYEuR1mMFLGeYXRu9mHgE9LTeHLnlYQ333jD2wZU25qbKROWYC5qjxLkzfVN91szAURLy7f/ZQc/WcsomITqbnnzi7iv7BhDlH7gXn7H4qQ/4VvEpQUtX9BmqQ5LG9t101ZVN1xRkgGqM0NNSKn44twO94AbIDEUzCQIlqoiy9DTQ8HQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(376002)(396003)(136003)(66946007)(76116006)(66476007)(8676002)(36756003)(66556008)(6916009)(91956017)(5660300002)(44832011)(316002)(2616005)(6486002)(64756008)(66446008)(478600001)(86362001)(33656002)(4326008)(53546011)(2906002)(8936002)(83380400001)(54906003)(6512007)(26005)(6506007)(71200400001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?drkDYNHSkg5PlhQLTlg8guh8gKpjXTeEpldjVDal+RHjhgaSkNTO1Q3bW175?=
 =?us-ascii?Q?K0PqZTs0KLseVhmsj5R490ISgwRVgK1sHjaHUt2JezhMsI8QXoy4ibGt3vrC?=
 =?us-ascii?Q?tBzZbxyTdfRbEmAjlWjE7UrsE4wQLlLPTBRLggATapH+TSMEa6Mh64VMuRnH?=
 =?us-ascii?Q?oJrPBK8FddY9nkcbRxyuL4twXarjRBMV2+0h9uPIXUZe+3HPpMRA8cdnGKm1?=
 =?us-ascii?Q?xKDR60JEb3g1AH8nlZM+F39EfcFqUWjQnYdxKm/CknzYJycR5uq62nK4Dr/+?=
 =?us-ascii?Q?NbjKKhqv/GZ6bCL+NeIOoptbGDUsNSQj0oSQsHtu6gUbF9wBgkSGC2n9xEgz?=
 =?us-ascii?Q?qnFW5qqAl0BPCyPtx/yfH9vmyNDHsaLpOSq/PiYRVBWzGrSkfgL+TQnon90R?=
 =?us-ascii?Q?maYyff5e79K3+ajaozzlZGnbK+EaCtI1n6+6oQJoESxKV0Ane++fqKXsmVVg?=
 =?us-ascii?Q?WdjE6gIB5mL2zmmy9oi2W+ddQOKd2SejziVarQOg1fOLY84Ti4Gx1PST7Dt8?=
 =?us-ascii?Q?mqybVNNgIMkUSYaz0VMPMOT0Rfz0VucHGwk4Gv5sOqh/I+J3rvnAdUXqO0Dk?=
 =?us-ascii?Q?152Ru4GvsJB3jsVcHeRcJU5T+N24cETowk44gqcITsyfleLozJwrJzzvycXT?=
 =?us-ascii?Q?sFu/ho2tIwbh3j9gAGJsaO+tAK1+amJsiHByB63xhY4rWBY5LzxDhyBMD5vb?=
 =?us-ascii?Q?4wZrpkhiqGtrver6ZfXNtPdJPSlwP3Uqsej6IuDrf2g8fY237l8gIOR3S6nn?=
 =?us-ascii?Q?FJYWrHEWGkbjtYN6Sl2E4RBds2Q07gAtLtURdsRyt42ohZru/Ly9BKHQKfaj?=
 =?us-ascii?Q?54dnG2pknW2uDKEntnIHjWPkdQxHqKnwV4GeXLXlBrt1+rW4aeuqkRAr3/2Z?=
 =?us-ascii?Q?kNot0UXGF7ReOt4sTaaezO/6nU3rfg3IfpPEmhBVy20QirYfteSWODK0/vSi?=
 =?us-ascii?Q?Foze262ArTXpdfOU38uUN14BJGGUhsSYhAVanIo3PwEfWQSRxqchksyIUg24?=
 =?us-ascii?Q?MlEQ90dnGYgN6xtMMf3JkTFR4vkJk1WvgEZGBq1HLtRqRCDM8j91sSa2iSYj?=
 =?us-ascii?Q?TQ1wa0x+41AW/GhiJZxG37rfrsgMGxhj00AHmf6ADwMjmEuWj5+SdmLLdBWg?=
 =?us-ascii?Q?QbsMehcaQFUTyUHg0S9VGVz0fgOL+PRCDXrR3pRUFDiGZb/w4UYn4dbcq/nJ?=
 =?us-ascii?Q?HVj/BLtsJjXNPXBqWPaOirCYxYePUovhE++xVyRDEmZDTNXFPsD4SHBaxXys?=
 =?us-ascii?Q?9bc8E/L9jIbg9TDdp+UF68w689NBTv9UZy1VyVZEZUxilc9nPYAt66NV9Em+?=
 =?us-ascii?Q?xpOx/68h2BhJO2kr6h9hBgQ0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B1C2BE0B018084CBE1197C55E1D050E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48e027c-1214-4c9f-4948-08d8d069cedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2021 21:53:33.2317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXhEYBbpmMUVPN6a/VTVo0V9naOp0gbCDYiFwnTcIXd3EfvG+ozh0htAOsWM6sT63Jk3ay010p9oHxhNFLS2Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3953
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130200
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130200
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond-

> On Feb 13, 2021, at 3:25 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Use a counter to keep track of how many requests are queued behind the
> xprt->xpt_mutex, and keep TCP_CORK set until the queue is empty.

I'm intrigued, but IMO, the patch description needs to explain
why this change should be made. Why abandon Nagle?

If you expect a performance impact, the description should
provide metrics to show it.

(We should have Daire try this change with his multi-client
setup).


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> include/linux/sunrpc/svcsock.h | 2 ++
> net/sunrpc/svcsock.c           | 8 +++++++-
> 2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsoc=
k.h
> index b7ac7fe68306..bcc555c7ae9c 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -35,6 +35,8 @@ struct svc_sock {
> 	/* Total length of the data (not including fragment headers)
> 	 * received so far in the fragments making up this rpc: */
> 	u32			sk_datalen;
> +	/* Number of queued send requests */
> +	atomic_t		sk_sendqlen;

Can you take advantage of xpt_mutex: update this field
only in the critical section, and make it a simple
integer type?


> 	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
> };
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 5a809c64dc7b..231f510a4830 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1171,18 +1171,23 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
>=20
> 	svc_tcp_release_rqst(rqstp);
>=20
> +	atomic_inc(&svsk->sk_sendqlen);
> 	mutex_lock(&xprt->xpt_mutex);
> 	if (svc_xprt_is_dead(xprt))
> 		goto out_notconn;
> +	tcp_sock_set_cork(svsk->sk_sk, true);
> 	err =3D svc_tcp_sendmsg(svsk->sk_sock, &msg, xdr, marker, &sent);
> 	xdr_free_bvec(xdr);
> 	trace_svcsock_tcp_send(xprt, err < 0 ? err : sent);
> 	if (err < 0 || sent !=3D (xdr->len + sizeof(marker)))
> 		goto out_close;
> +	if (atomic_dec_and_test(&svsk->sk_sendqlen))
> +		tcp_sock_set_cork(svsk->sk_sk, false);
> 	mutex_unlock(&xprt->xpt_mutex);
> 	return sent;
>=20
> out_notconn:
> +	atomic_dec(&svsk->sk_sendqlen);
> 	mutex_unlock(&xprt->xpt_mutex);
> 	return -ENOTCONN;
> out_close:
> @@ -1192,6 +1197,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
> 		  (err < 0) ? err : sent, xdr->len);
> 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
> 	svc_xprt_enqueue(xprt);
> +	atomic_dec(&svsk->sk_sendqlen);
> 	mutex_unlock(&xprt->xpt_mutex);
> 	return -EAGAIN;
> }
> @@ -1261,7 +1267,7 @@ static void svc_tcp_init(struct svc_sock *svsk, str=
uct svc_serv *serv)
> 		svsk->sk_datalen =3D 0;
> 		memset(&svsk->sk_pages[0], 0, sizeof(svsk->sk_pages));
>=20
> -		tcp_sk(sk)->nonagle |=3D TCP_NAGLE_OFF;
> +		tcp_sock_set_nodelay(sk);
>=20
> 		set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
> 		switch (sk->sk_state) {
> --=20
> 2.29.2
>=20

--
Chuck Lever



