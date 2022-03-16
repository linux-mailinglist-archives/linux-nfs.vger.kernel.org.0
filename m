Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C104DB7AD
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 18:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbiCPR7Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiCPR7X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 13:59:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6721EC48
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 10:58:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GHEjRf012040;
        Wed, 16 Mar 2022 17:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=s/P94kcXhXVnDIQKm1KMDZ15AxEccrIiicnc06cuhWo=;
 b=tEUFlf/jq52AJoMvr1mUrUZy3AuOhgIxIvGU/TfuZQwk8THe5oItEb9Nex5QCdD1K2j7
 iBgnyObX9SFOvsNVXmBakvbzP+EOdetFT/vnS2PSWfybXnEQlGQnoc4EuNSMqPBxiAjp
 YqVduzhf0lU+pgqq3aTf6MSu7zBOJzkoZfqAR/JeMHNljc+zAD/pNBfXqlDfR0BkfQQ0
 tbQZzMOqOci2x6eSusgClCL7BBDyfslH1b0IeN43kDeNgXboDvFfVPbgAbIlOQWjQENb
 pgS54TZeR5xL0L5TvKl2UtBuORex7Z5YMtSWe2HN87C6nbnZTm6VJYO89kPpLRqPd7jN Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu76px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 17:57:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GHuujN144897;
        Wed, 16 Mar 2022 17:57:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 3et65q0dra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 17:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MshXMSl62ORc9UwM5dGwyaUCx/ahXnDVbNmmAbEIx4GYmpuWz0v7lputdL6ihnzvtHfz06qu5zr2pVgsU12cK3oa1+qv1j0ligkqSntOpqIX3By+Yk2Xp+0jLwyZcZvgaQaK58WwJFABzrHkFozkB4OwDszFGIo66Vs84qwgW5QY3KrBdB++DFlQAT65spIQB+Q6lHpxxRAk26HWW0rsQSDIx99hQQlGLmou6orer4ujpUjtOkQjmxuTMahYEAETKoVOAP2VTyj2a7FoSPJP7KrCppyRu4HpkMrnANnqBVtZ9SYolcDWmNWHIgA6BWPfECjhifluOHkNS+Dh75oGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/P94kcXhXVnDIQKm1KMDZ15AxEccrIiicnc06cuhWo=;
 b=JUhWoYvGL0IEV3776DNPQWacGno1j709t94MIDLL/rRpMBfQPdVxdfMlKYnkmL2/5DBrOit/2EMHnUz1+JYYkObNMoI289jxF3qQyP5x+tMRKcJO8Qoob3xPmnX432pcAD6al38tnljWa4xm2vxkSb163CY2kTbtMiZ4mKDkhmF1vEqCHg9+dmpeSUvE6pAkQmNeZku8tfN2eEF9HH/Q0fsVj8OkNhFWqPQXOMcndhtatq7EGRHSVrVGpuhUZnVbcVkanrchTU5wM50PouahmVfYVV9CozjLJSi6xOZEdLEQ6snzV6Rr78Iz8SSqcbi7gfnyIrQlxIfzMKiOB/yqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/P94kcXhXVnDIQKm1KMDZ15AxEccrIiicnc06cuhWo=;
 b=DQS3yttf6Q1PuVtLj97ChEC8qHSXSAkNCYnz/5sCglwZk2rLNkPtOX0lg/W8zYAjjwqaZpvMWWqI6SM0MNLhvcbKZFXFQKc/9YfUOJUU2A+6yPC08I6gRuW0999dcJFgVobzNuIMSdtU+mM46YKtpAwZMygB/COFY9pfkkcUDKI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2052.namprd10.prod.outlook.com (2603:10b6:405:2c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 17:57:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 17:57:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] SUNRPC: Fix socket waits for write buffer space
Thread-Topic: [PATCH 1/3] SUNRPC: Fix socket waits for write buffer space
Thread-Index: AQHYOIqROoDoMfMo0kabDTVmKfkU+KzCTZ+A
Date:   Wed, 16 Mar 2022 17:57:52 +0000
Message-ID: <D9030997-0BB7-435B-B7AD-4896BEF95B03@oracle.com>
References: <20220315162805.570850-1-trondmy@kernel.org>
In-Reply-To: <20220315162805.570850-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eab7252-103d-472f-e8cd-08da07767da8
x-ms-traffictypediagnostic: BN6PR1001MB2052:EE_
x-microsoft-antispam-prvs: <BN6PR1001MB20525DEB02D67622167E02B393119@BN6PR1001MB2052.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HF2chBeX8/H/1nGn3pBD97jCFpUeQ+1+GlDewzvtE9QQOHoyw9lUcetChhUYeY3Pn3baHh/XRGBCb3dGmbv5pwE0tBU7pa5pmvqB2wSdi9Y057vuSzPXCLWWJlCRQTp3lB9ft1KeeK4lM0fsb7q9U/1OtgTTT+c4qdBezUTtoGw+kT6BaE0QQA0Xiqat6MVVQMiSb7GRh5UqBQezGHsbpMNM1XZPv2yUUfJngkGblprG3qt0kIONHBNXbkyhg9UXMQDzzVjnAJC7o1McZpu12nzZd4RQhfgq/tVwZ6vkw9d4kMKwsz2XpC1aTORTZ3yJnuEr7MQMNzbKoBWu6PXs83DitsFK19TKzkFC5CWWDVNbJUo70snYp53wPx5S2iKzfY/cHYGuUszygf6pTN/VPYL1SV+YC710VVizUow3HQWKHWyiBfgoOHBcb4RHkqDVqhCjGoia7PCSGGBM+6U5lxpcYqQx33nV9+eqEwUW/sdNmYNBdmJqbkv4ShsYv0uX2+8p375I6ffTi8WpdijeoeZ/zC9ctB4z0LOgRjadGV+VSryC5Mu3maIomMamfDtr60ZE8mlM4B6A/lHdnfZQTCsSE8GWk3NLnoA/Byr6s8erRmZ7E73+M5mbPWWyVR7cPchoCu3f34Mn8h/bAmKKHccY0VpTTgZFqkD/qtkV9ipmHiOyQB+LQ98xdDYNrU7gl4rTRUSrYxjXAyh8CGGcy7yonzBelJbHeJdd5t0B/gBWO8UbMXfAGlVhm7J2vTr6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66476007)(64756008)(76116006)(86362001)(66446008)(4326008)(66556008)(8676002)(38100700002)(6916009)(122000001)(38070700005)(33656002)(316002)(8936002)(5660300002)(508600001)(6512007)(2616005)(83380400001)(6506007)(36756003)(6486002)(53546011)(71200400001)(2906002)(26005)(91956017)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?07BjyL5wb6RQmXNqPp6GEitOKqKhx+KcLdIoYryun9W3KoqMHC43JT9k5wfF?=
 =?us-ascii?Q?byWCmarbWgiDjk33Fe8Kklq5aMj6zEGZzz7NlvvHHTYenvoofq1EVssymWME?=
 =?us-ascii?Q?PEEERijCj/H3+tDb+C2kL8Jd8FBnvHU+hmBum/qDBJGdxJ8cqlTsxGAppAgT?=
 =?us-ascii?Q?FagjXedhf/SUQYXKl2hJ+NgtHV973pnkuKQhVubRtjAyilloGw5BPouNwycx?=
 =?us-ascii?Q?IN1LIM0XxpEmkWwpcoVVnCvY7HwyeqGZEbgQZvJ/nag6DtP+tzwZBj3do0gd?=
 =?us-ascii?Q?hZhtzXZRF2H9kRy2S/WAQzO9vXQPK0Fo11KoyEcsgiiFvq2FGdPVCImWDgDH?=
 =?us-ascii?Q?FQ+0e47IdBdYH61xoyuB7PMHwnRt0k9xn3ZPoCxhTaCR9n+XcNf2sd28Xkke?=
 =?us-ascii?Q?kgcfMldF6yHi6EeWzm+UsbiqJPvKN1INSAzS6IM1bBnLJqKWSgKbqccxl7fj?=
 =?us-ascii?Q?WmWaBY9kiis+4w+xpiRBKwSwkOxf8cuduhEWHU6UHlki0mJvKLTAQaSFWXlK?=
 =?us-ascii?Q?Irh4z7yv8l0tN1JoaKfR7kpsrogZgb1dye6yf9N5MpZ13jABhXSLAFUoj7f2?=
 =?us-ascii?Q?AZJmNNjTYiZB+s2kAZGvqh/s0kPex4p640bjP8JeMO1eK+Co3zXUDtKVre2B?=
 =?us-ascii?Q?jNNEWqG0gJm7PxqOdc/gi1fL/hDSV/m+zGfLcHRd7qc1ivppMAVciM+jL3Nc?=
 =?us-ascii?Q?D8ntHFLDaOBTAYSSO0nmPXNEVBy02F5dje8JGUzDots4z3jYH2UF7UBFhL3s?=
 =?us-ascii?Q?vo0d/C21iTl4AoIiGwUXaED0baoROvSOsa6Lhz9/gznHsSutkJmuupQRxtnt?=
 =?us-ascii?Q?9UUfm8zHgOrs1uBMKJ94ZczRwdCGHMceE2opxjhf3VABMElkqAV2xNfj86HB?=
 =?us-ascii?Q?lOsaWECpgTLECyZLH3mzOiyDb5ItPwmyRPJShNcJYV0yq55Nk/71PED8CHCf?=
 =?us-ascii?Q?JtILCQj+ShjZMHN5jeTuQ7M6Lww4a6BBYuiJT27/+KncnHFk/t6q/0hM9+mW?=
 =?us-ascii?Q?fcMBN2/gqFe4FyyJ/6H/pZ6DU6PWfMo+5dUAWGaZZNnUlAW15VnoD/OHk0vR?=
 =?us-ascii?Q?u5W84Wsw3LiIl+x9gN/NWREPndUECeLUGN/8ItQyFx9BstjZIeavEc566HE5?=
 =?us-ascii?Q?MYqGTM3z5LTx2ELqUBl2oj8uWyDTl9xJh76iVN9hL9N0yZQt1l8tLsBnh0jw?=
 =?us-ascii?Q?NnQJTAgKtwHZe9F4ekJAfW/ADFfd5O5Y69FaFBpK0/Ib5wGd5BNG3dXjcL2O?=
 =?us-ascii?Q?XnaEZmAWV6aWSaCbMdpnPLZ8YI2N5OOzF069boM9rzCBWT2mf5tI+u9maeH+?=
 =?us-ascii?Q?NUOLSS4vFOKHysxQaqE8C6OHOGrMe5MZIFdAsN+3nBkyTyTMPacNdVUCrHRR?=
 =?us-ascii?Q?XQzNwVda4syetbUlAzHZ4scjDjyk3eMnsLxnECSiPT68c4xSlJDjLCLEWqsh?=
 =?us-ascii?Q?H9Hn/rGO1fY6LqJAosnIwGdSinDYU1JpCCVdV9+8M/JXrcJrRlm3yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FBC0E243931464FA516AFF33A79F603@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eab7252-103d-472f-e8cd-08da07767da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 17:57:52.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlJnE8fsbGSM/IdDHPrzWJBjfzJr27R0xCRwcNZBUVCRULtBDrnqBk6N1vVxIN/5N8mx4hh90W1nrxUmrl+Pyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2052
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160106
X-Proofpoint-GUID: w93qH4lKZnFyKUg2ppjmfvJBwAYpKaPs
X-Proofpoint-ORIG-GUID: w93qH4lKZnFyKUg2ppjmfvJBwAYpKaPs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 15, 2022, at 12:28 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> The socket layer requires that we use the socket lock to protect changes
> to the sock->sk_write_pending field and others.
>=20
> Reported-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Applied the three patches in this series on top of my RPC-with-TLS
prototype. Works nicely!


> ---
> net/sunrpc/xprtsock.c | 54 +++++++++++++++++++++++++++++++------------
> 1 file changed, 39 insertions(+), 15 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 7e39f87cde2d..786df8c0cda3 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -763,12 +763,12 @@ xs_stream_start_connect(struct sock_xprt *transport=
)
> /**
>  * xs_nospace - handle transmit was incomplete
>  * @req: pointer to RPC request
> + * @transport: pointer to struct sock_xprt
>  *
>  */
> -static int xs_nospace(struct rpc_rqst *req)
> +static int xs_nospace(struct rpc_rqst *req, struct sock_xprt *transport)
> {
> -	struct rpc_xprt *xprt =3D req->rq_xprt;
> -	struct sock_xprt *transport =3D container_of(xprt, struct sock_xprt, xp=
rt);
> +	struct rpc_xprt *xprt =3D &transport->xprt;
> 	struct sock *sk =3D transport->inet;
> 	int ret =3D -EAGAIN;
>=20
> @@ -779,25 +779,49 @@ static int xs_nospace(struct rpc_rqst *req)
>=20
> 	/* Don't race with disconnect */
> 	if (xprt_connected(xprt)) {
> +		struct socket_wq *wq;
> +
> +		rcu_read_lock();
> +		wq =3D rcu_dereference(sk->sk_wq);
> +		set_bit(SOCKWQ_ASYNC_NOSPACE, &wq->flags);
> +		rcu_read_unlock();
> +
> 		/* wait for more buffer space */
> +		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> 		sk->sk_write_pending++;
> 		xprt_wait_for_buffer_space(xprt);
> 	} else
> 		ret =3D -ENOTCONN;
>=20
> 	spin_unlock(&xprt->transport_lock);
> +	return ret;
> +}
>=20
> -	/* Race breaker in case memory is freed before above code is called */
> -	if (ret =3D=3D -EAGAIN) {
> -		struct socket_wq *wq;
> +static int xs_sock_nospace(struct rpc_rqst *req)
> +{
> +	struct sock_xprt *transport =3D
> +		container_of(req->rq_xprt, struct sock_xprt, xprt);
> +	struct sock *sk =3D transport->inet;
> +	int ret =3D -EAGAIN;
>=20
> -		rcu_read_lock();
> -		wq =3D rcu_dereference(sk->sk_wq);
> -		set_bit(SOCKWQ_ASYNC_NOSPACE, &wq->flags);
> -		rcu_read_unlock();
> +	lock_sock(sk);
> +	if (!sock_writeable(sk))
> +		ret =3D xs_nospace(req, transport);
> +	release_sock(sk);
> +	return ret;
> +}
>=20
> -		sk->sk_write_space(sk);
> -	}
> +static int xs_stream_nospace(struct rpc_rqst *req)
> +{
> +	struct sock_xprt *transport =3D
> +		container_of(req->rq_xprt, struct sock_xprt, xprt);
> +	struct sock *sk =3D transport->inet;
> +	int ret =3D -EAGAIN;
> +
> +	lock_sock(sk);
> +	if (!sk_stream_memory_free(sk))
> +		ret =3D xs_nospace(req, transport);
> +	release_sock(sk);
> 	return ret;
> }
>=20
> @@ -887,7 +911,7 @@ static int xs_local_send_request(struct rpc_rqst *req=
)
> 	case -ENOBUFS:
> 		break;
> 	case -EAGAIN:
> -		status =3D xs_nospace(req);
> +		status =3D xs_stream_nospace(req);
> 		break;
> 	default:
> 		dprintk("RPC:       sendmsg returned unrecognized error %d\n",
> @@ -963,7 +987,7 @@ static int xs_udp_send_request(struct rpc_rqst *req)
> 		/* Should we call xs_close() here? */
> 		break;
> 	case -EAGAIN:
> -		status =3D xs_nospace(req);
> +		status =3D xs_sock_nospace(req);
> 		break;
> 	case -ENETUNREACH:
> 	case -ENOBUFS:
> @@ -1083,7 +1107,7 @@ static int xs_tcp_send_request(struct rpc_rqst *req=
)
> 		/* Should we call xs_close() here? */
> 		break;
> 	case -EAGAIN:
> -		status =3D xs_nospace(req);
> +		status =3D xs_stream_nospace(req);
> 		break;
> 	case -ECONNRESET:
> 	case -ECONNREFUSED:
> --=20
> 2.35.1
>=20

--
Chuck Lever



