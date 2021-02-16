Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05AA31CE02
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhBPQ2C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 11:28:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54724 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhBPQ2A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Feb 2021 11:28:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GGPaXc026766;
        Tue, 16 Feb 2021 16:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZgwxYMnxth+kAdJozjv0SLq+K54ytKGsgN+dT6pgu0U=;
 b=VTYxJX2yg7x4kmj0N0fMH6BiwPz/3mIpOiH38YvgL1g0N+LsMtB9sDBsvX+tLFyjT62/
 DpgygXw/qJBtgVqrZbq6NdOA1aF5ANUcEplpf79L+B2Yri1MrE7CGTiyL+rATQ1ZXbM3
 QSmRH79QImcB9yyqpUhuylF4J4/MULb/VAAbtzRqC/C0PbfOm9ZkQjYck/D4M3vQl7Om
 3vqrrUIkzxAGvJSSv9H6czUNUo5XyrjfxeeywNNK1x7lGLasAxVKJTpSDjFdC8KG+KXh
 rvuxQjQGYxG4HAbR/VueQ5S8kCuH4fkXy0vFWRauPPWe9DlJ1ZwdCwBSUbPHtuugfSEW 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36pd9a6w7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 16:27:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GGPWXF159326;
        Tue, 16 Feb 2021 16:27:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 36prhrqs9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 16:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd80qIt99de5gxaEusDJM006UWXktKXR1tPYSHgKigFbXf0p+PRMGTC9P+kqmMr+JGqc86NALWdarM/17eaIIPI+Zzau8uJZdiq2pRz2rlNkvtDN3WHDtmh/8MX7ovp6Ooopxl3PCR1OH0Vgu6x0OH1VqPqUFVSiqkoZveUDfEJlTGH36flvt5KJ5xfKsgFt4+BXkCldxKI8B1Pj4/6m1r3FQQGQwvvhbt0u5uQHsvDReY41cD6V+KE/qTtzxweOTxxI8etp/oS2vherP/3PK76gZ9xQDWqFF8BMSXDL4/1CtOrHWdR30/2+ZlRJ9QDvSgKu66HlVbIUHHj8KCBvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgwxYMnxth+kAdJozjv0SLq+K54ytKGsgN+dT6pgu0U=;
 b=I7K2h47uF8dI1Q0MNN0HGi3dpp98EST3CSehu3Rs+PDSUu6VpJ0hq6rShQUG3+hzmQYbPz9u9xxyoAhoTO0hDTw1O0onndjI1pRl0y8dPsn+34tW0A0CYeMG1z4wU9Qei1cJ4ZQ7ZPO25Ism0EW0Eoqv2BShX5BeP/I9lZ7mxJpFTCeWBXamg809iV1dz28uAM45JGh43ZMdTZDEms671HJN0eGGFKZU3yhNqwvurqf7I46rCeXFiXiBTmA886f0mW3DkzSaR/GDH7t0j16smyXa5KYfk24r0av+qw5JkQYqN/MMfrQh6Cad4HIM+CezwuuBT78XryULRoXOOZ5j3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgwxYMnxth+kAdJozjv0SLq+K54ytKGsgN+dT6pgu0U=;
 b=D0yZtVUxlisOYncGypz0vJy1r6MU6JuD9v11cGb7L2F/cmSRZ4eBcvYpir+wTyoAbO1MqyQRdyEgxcuDSGxc7DpBYUaW6b3R0cXF0dCa8aNbwneNzKsSXn8Ath163OtFDQLeSW0DfswgMi3/8hGITOxCe62hO6rUs4psUJaYYOc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3333.namprd10.prod.outlook.com (2603:10b6:a03:14e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Tue, 16 Feb
 2021 16:27:10 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 16:27:10 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpa/JkA
Date:   Tue, 16 Feb 2021 16:27:10 +0000
Message-ID: <635D6DE6-3E7B-43EB-93A4-075DE91897BB@oracle.com>
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
x-ms-office365-filtering-correlation-id: 91b065f1-cd84-45d5-b896-08d8d297b5f8
x-ms-traffictypediagnostic: BYAPR10MB3333:
x-microsoft-antispam-prvs: <BYAPR10MB3333B1EB32B1A0E77C930A6A93879@BYAPR10MB3333.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39UMxgKaG4o9udIIERt+H/ptH3RDxftHdSvje62d5k9SoKOl2j9ibn4GL1PV2404EnP6u6dQJaleI/mV+F51VxCrQI3f6+R4fwKPLk7Glvia8VOH9kh3gosEC44ox7tSwg6JSHlVEkeTeCEtn2pjmsc2Y6GeG5ELDSEL7cu2uH6VcbgcqKx5heb4+VmHqcStzj8fT7bIgXAEVFbFqqJafwPAFvHA8K9Zr8l+ejVsXUAJcNwJYIbs9bEZkTDmC33LrqzGjtzAozA9kEMhs/CfxwglQ90JtBLmOlZRZ4hh81T3DVNCMZbWreShlfog9pGH+rzUkDARgJMcHaTpg3dRfuV4vKLeE4K//nrlL0FDxVw4FYVZuBKJW7koYmR4qTkrtqLIADKr8h4yzsoE77KEfHu5fuGLln+Frc/1rNgfN+ocfnbmswZK72ndJIhN9naq3OyNFnZSVxWPUh39ACESjzLpn16qyuMYD8xTeSVLToID+V0nIjO+M1V3/f6vzn0yREpBZ9GjSrB2t1OxlmruUgRCIhuBdiN71wXr+UPwxxnwcI7IdUtJnJj0Mejw7sDBRiye3QPcfruakz6wmaRkWfsqTRrZijezKz/aGpfSKsF119FsJsOu+iWZufaIYDlDKqx1LD/C+eDQKkSzW8HbsCh7MgI87d2Fmn8qq7hh6GQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(396003)(366004)(8936002)(36756003)(6486002)(186003)(66946007)(86362001)(6506007)(66446008)(2616005)(44832011)(2906002)(8676002)(71200400001)(316002)(53546011)(478600001)(26005)(5660300002)(91956017)(4326008)(66556008)(6512007)(966005)(64756008)(76116006)(54906003)(33656002)(6916009)(83380400001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DOjcGmKlLB8hOmXwIPFw5FixcrzrF2IwFuotByUKupbw4IRFsUL5XwHK5ENd?=
 =?us-ascii?Q?LH7NDqUB81wI4jr5H9vd51OOIHh8KDXrOB2s4e7vWD9777lKHVQwHQkvi/j/?=
 =?us-ascii?Q?9Th8n4ZvmKYZDaBOLuVubi5JGHMsri60Jw/V7LLr/WFZVfm0zvouE9l8MITl?=
 =?us-ascii?Q?5iC8Gqxq3ns2MfG8hfzXCWX6jLXZk4OQxhkkgbltFl3hacSv+v/2WpRuWlgr?=
 =?us-ascii?Q?iWqdm/Fw9N7wPvqzdPiMIPDmVop7d5OI227n54uOngIKuHH09RYmWGdkVn0d?=
 =?us-ascii?Q?MsyHdKnOPNicbELxhSBiHKr7BGx/ASisUzK3ORUxb2qwx8Ziron4SVXjz/4d?=
 =?us-ascii?Q?xa4T7vo2mvMkhDMQLywycrGH/sb8VE8upXRtaBebZL17KEn7KMz3bn7sP2VI?=
 =?us-ascii?Q?QMT99I2/0RboSh4IlcfFi+xNMUBEqXZMRtSlqtG1WsRP5LUr8cO6LogqLOSe?=
 =?us-ascii?Q?goOiPSxzbN3dvbVnLXLaUdvMQqVM8GGSGmKF2sJzb9HldT0DcCZRyZh3JfdL?=
 =?us-ascii?Q?n8y93SqwpH3vGJjTegHN/Vy73zq+GZUKwxZhbdCR1eZJnCVG/iv2FbFXD9+O?=
 =?us-ascii?Q?9nvVh7R0Vi2fMc59Zi2etzbhWIA5hT+FY4F9xL86r+aRpjsdEbfi0wSjk+RQ?=
 =?us-ascii?Q?MxqYZU/Y55tLozjj+Y8IweW9BK7DMGzmnbKJf+X+dRWT20sT+TaLTsxNSPNx?=
 =?us-ascii?Q?TJSa1NoI2vRNr6UzGPkQeztFSD3wUrdS5T1TtmjD4S4J9Yoj59vLW6o1N650?=
 =?us-ascii?Q?IHtEhvXjjaUB9jcgErGcKVNmhWJ9jbtrNhWvDz561etHslo8TTFp1UWMONJH?=
 =?us-ascii?Q?x9wMElKuRlXligtbxQidpPSiMnAkHdTP8C88u14+wsP2J8FkEHbJpb08qY4L?=
 =?us-ascii?Q?Jze9JFf/Xl9Od2HVZ89rGA9vS9/gqY6oiWUtW4L4jrmk6iqM4D+xRcNcQPBb?=
 =?us-ascii?Q?/mJBLT9vhYSmzCKSw6aOMyi5knp4RfSZUMA7grup2BOSxHbZ7s8SmE6Dxqh/?=
 =?us-ascii?Q?gHM5LO2P+5D9euONDBhGnyHW13vbWlL2mpQVjvqkNArCcgRwCZQZYCHl4/WG?=
 =?us-ascii?Q?ajhDrt7FqVcXJTZViW3NzpRfrKMAjpCjaOugmbeyXRPB17UDAud+hD6XCiEr?=
 =?us-ascii?Q?Jj7JLia1DsGQ/WAtxILRhY23ggHud/JyP9B862brO5yv99FJuUW3RZ7gAFpa?=
 =?us-ascii?Q?Hqn6zVdkEXPnKIX6VCd47mI+nOgFYciTlps5lchfh4LEucarbOqDfk9haF07?=
 =?us-ascii?Q?/JCmqlZOhtd2LdKn+R84x3glLj6gZiOoz22eZ3r7OkltnwTqTc5pfbuF04u/?=
 =?us-ascii?Q?cyW8tX4diw8ixCU+cvBaeF7NF4pZocTrSDwQVDXByKvPMg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60EEA2B93682F6439EFB9B1764995042@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b065f1-cd84-45d5-b896-08d8d297b5f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 16:27:10.7228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3z6bbZ28PHU7iwWGeDVjprK7Ort/b9U5yOpP0EErXxbiFoF8qDeDmy3oqFajG6P2tRJ61+pRxA+8v64YnBjISA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3333
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160145
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160145
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Trond-

> On Feb 13, 2021, at 3:25 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Use a counter to keep track of how many requests are queued behind the
> xprt->xpt_mutex, and keep TCP_CORK set until the queue is empty.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Let's move this forward a little bit.

I'd like to see the previously discussed MSG_MORE simplification
integrated into this patch.

In addition to Daire's testing, I've done some testing:
- No behavior regressions noted
- No changes in large I/O throughput
- Slightly shorter RTTs on software build

And the current version of the patch is now in the for-rc branch
of https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/
to get broader testing exposure.

This work is a candidate for a second NFSD PR during the 5.12
merge window, along with the other patches currently in the
for-rc branch.


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
>=20
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



