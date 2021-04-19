Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD736499D
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbhDSSGX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:06:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbhDSSGW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Apr 2021 14:06:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JHxVPj077684;
        Mon, 19 Apr 2021 18:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wqnqrGglgS7Dx+EnjNtR/MK2asXdSb1rzJmDG4TPQwk=;
 b=P67D7O1bTJvBtm9YoIN1Jg15Fg+CiLWdkBSOzpWQTsKUlRCmO5VgYQAvWnsIIeZzNAuz
 EqiifIn7rRDrQs0KtyT6dE7RCezIx8e5YooIeFprvFJ8/qOJY6XZ+CBORXY/sPJ7Fapp
 6UH6lPJ7fVQhD2MG+OsMH880p45OfmgK+iYo9uUWCJerjMUHA9/AjM8OBWZ6FfmFSxyF
 5m/Arpmm0SmhvlSgPjuDCu0Iqu18QMVocE0n9IuiZ06icBQ+xZet1Rxc9POy/HSj4JtG
 H00Q4ChTVYQ5mgMB6h04wNLnsH5bI2tww4CYzzUYZNkcuQaP9DteuRPaiACZdk+ZRx5Y Bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38022xv13t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 18:05:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JHxq5W167639;
        Mon, 19 Apr 2021 18:05:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3809ercwfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 18:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvUbSo2sdU9YMyJAQtbKSzoUT5m2LlY0dZRm4d2HAcVOeTIPwpJ1DpnWBBlsbNgGY2j5ZNRlBV1IFbwg1EsguRPOQ5iQcOmZIzOgfx6U40g9G82EeFulnJjqD3ipjB7TCHWPTCqPeo3Fcg73SjVNwLegSEe1IwUQozg4WCgYwE5kfszw0xEkPl9TVfpu7jgVKlpT7Kzdx6MXfA2d1aTHnzbbPqX5HNnGCAkxxcIxOPETlkjBuT7gS9T96/+d6rGsAdIBhVMwj8Np2fUNG5tziIDgW2sqeVhs5Cv8rGPI2GROP+FTFLn3fiUb5ep+TcS5N4jnr6zHw7SkAQVK9vxZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqnqrGglgS7Dx+EnjNtR/MK2asXdSb1rzJmDG4TPQwk=;
 b=njbNJgcazmP1OD10xRBgr9s0O6TipSu9SDhDzT4YAp8GlPBkXsbJ9i0I5aRazEOou85ANfXZH5J8L2T1ZJza+lIqgCKfnQgV+/4cxCgRMyTZY+zaOv2yswNBPnXakpAIBIFXvuflev6Jb0j5hmR5Tw2W4YVCOh15CPCBQeC8ZHK2Y8a0D4pefrbMkvHW5uTkg86R+v1ORKiX6mibXyULKUA2n8SEiZ9x41+dBS6MDZDNu+BFZFq0R0C4nelLQuFsBbH9kN+n1NN766or9zwf/4v793iNQ99F2RDv7+tmeNHvowJdLZPB9MaeAECEn0MyIHHOBUf1do8tpTR8nJRJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqnqrGglgS7Dx+EnjNtR/MK2asXdSb1rzJmDG4TPQwk=;
 b=IY1pQpzuOerDkuWyphTeo77hmgrtwp1ROUCj0PvxDdflDqk4DFzmsb4GOCONU2f1gJpWfRzzhf9n1/+rJhpHr23qYc3nP62LFWtrNZFaOw0w7IFT7KCpmuUFIufyaFgBAl58YcNIygPtYijX/K55Dhd3sXFCYLnZUYb2XQiRa2U=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3414.namprd10.prod.outlook.com (2603:10b6:a03:15d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 18:05:42 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 18:05:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 01/26] SUNRPC: Move fault injection call sites
Thread-Topic: [PATCH v3 01/26] SUNRPC: Move fault injection call sites
Thread-Index: AQHXNUYTRv+lxzAbMU2EsDrdsMoAz6q8IquA
Date:   Mon, 19 Apr 2021 18:05:42 +0000
Message-ID: <EDDCA320-686C-4A6F-A002-6722028B90FD@oracle.com>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
 <161885530484.38598.2278426440061934702.stgit@manet.1015granger.net>
In-Reply-To: <161885530484.38598.2278426440061934702.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d8a3dad-c144-4786-fbae-08d9035dbf2b
x-ms-traffictypediagnostic: BYAPR10MB3414:
x-microsoft-antispam-prvs: <BYAPR10MB34147DE60F604DED83DB3CAB93499@BYAPR10MB3414.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKlxJMIPICMkq/2h0MAALm1PJZYukXwU2QVlgd2Iybbv+bWWdfOG32dewpoqqLOqjRr7t9jqS7dQy3TDCYg50j5CrqtBGvQBl/f79EiVbNJlKEPuhWJ0zcGjYnBTHOwTT6YWhxwQJ56f+r3N0BhXuUp2l/MLv4YkwPVpBnmUyzUKLCKoZBo/kMVdBrXZ+9/tk7UurI26EpnPtLKRL80pcxFQBBo20ldnrTFL7SVoCnN14Edt3bwLpBoXDCyLLoaBymvxHR/91nsftJEJ7Fbc9gbjBincRYadmSRbvUntt1ZBhzjY7KgiarAi1IdE6VU0gO5PLHg8id1pXkbapa2cwggI0pPiw3t6xA7DtZp/1ekvy1z+HTdruQcWO7MiyYuBOAvS1eq3WRvj72bKIKy3X58wgAkHWOJZxH+BBLf5pwn+sKifgEgLCx9utYoSE1+7u4UBvoH9tP+xFpM+VuuJ3COiUI+Ix9mV8kC3h1mIefwim9GkuQR998NHNR5s9HzEFbYBwl9lm8TjOXw4lQFCZbfbZ0uLcXVlufMiGIip1vPx0sqhzdUqZgwWuGguVIdFEKseqtXedNQTd3VyDZyuusWcRubu3WWcrtJR1KFwA9WXrAuQKXLUyVENVM74lATcSVPQhmIH4Btpz6bGSdJOvSCApjTX1yaq41QaP9kCBFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(6916009)(66476007)(478600001)(66946007)(26005)(186003)(4326008)(71200400001)(64756008)(6486002)(316002)(38100700002)(54906003)(122000001)(8676002)(66446008)(36756003)(83380400001)(53546011)(2906002)(2616005)(86362001)(6506007)(6512007)(33656002)(91956017)(8936002)(5660300002)(76116006)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EmUkHVsIhiKpYFj+cvTM5AiHu5iJ8pxyRIp45p7m0LbUJzk/L4D4T4H78pWW?=
 =?us-ascii?Q?7Ad0DWVLXRjXfIto1BI25FiFJ6TXJwYDLOKNfCpR7QVEyjN/y5+x1veqIYYK?=
 =?us-ascii?Q?ZNwMH8ua46L0odZ/VXkzZ/I/JHBOGX/MexV3LH4DYSsSvOgVckHeYjimuvbV?=
 =?us-ascii?Q?dW6uYM79ZwqewTulx37vypMJ7zR/PKSYvbpY/hrKhdNpw75nrhcfjMqW+8N4?=
 =?us-ascii?Q?ITVXkxLOF9aa00uZ+YqkqCoKAir3h7awjVANI8Uxwx87zvDTsRks4QLTvwkq?=
 =?us-ascii?Q?Fuow2ocMfo8tZ0KMtJW/Ut3LTjNj7m20crJG+QJowdfytsV1HY8Bqltx91DU?=
 =?us-ascii?Q?jytttg25OFEejns0vY9LMF5SuaZKp4QPJy6+wnbHTWr8SPJuTlJ/oNXEBB9o?=
 =?us-ascii?Q?HpYsgX147e/Qk58HzMhfSt0tzGY/fQ/DyKzmDN0Kfgy6wygDp9IzDjY/DuRA?=
 =?us-ascii?Q?tBXnEDR+q08nX1E6iBXUa/wyxx44srYvVu5SAQf9+sz4PWOe+Ooh1+QoWOVo?=
 =?us-ascii?Q?jUrqJf+wPipRkTwbs6c67HKaTZzxRkFlKkO+QpECy1p50cbql0eqGSP+k3WM?=
 =?us-ascii?Q?I//wMGT6I6oLqYVHAHRBWDDfpcb/UHUAjoj6XsP8vN9v5PN+EBjA64BAIaqE?=
 =?us-ascii?Q?Ggy8yepoQVtKZdCzxjUbXaiudEFeaqTxlcMGnm3HFuj7aaAwh/KxHhXD47gQ?=
 =?us-ascii?Q?Y/va8Pd2a/S1M4gAqFj6EDxbefVKxK9WZaIU0NLlysIwCkLhjV1L53zam8GA?=
 =?us-ascii?Q?/SsGbH/ZGBPu0UGpKg9aAI4y2zFS8feOGk/ZKsndRJe7Tzju7WOwQ5sXA9Ke?=
 =?us-ascii?Q?cQjOOakKfIxZZ7v8U20lmYTMCffEpIRser9iG8JP+OU/KGMhM91g6Jqr3hbC?=
 =?us-ascii?Q?BnBxvFJ7Kl38GffU/7fo1JcfSNW+047jUBaWjmjbiDE4ZFnEh+wcEV6qlR+A?=
 =?us-ascii?Q?DjBGhSAKfk4ShWyqZV9kUTujaUBFaBC9OXR1S2KSLkf2Y3Du+KVJjkcUqT9Q?=
 =?us-ascii?Q?cryJ/QNfE2WhNrETFb5LRWPZVyPDC0Xu/sGGQX6RIMS+AcAOH1N7IKyJSz3G?=
 =?us-ascii?Q?XOBmEJuKKoYI9nHAZ3CheonqTsYjouYLrc+dQfabVfVR9gAwiscJft84EThK?=
 =?us-ascii?Q?EyDChn4NtuiiFFcnZtjQegbugU8ngeS5OjwgnMPWp69luRQJiM7f0G1Wx7ZK?=
 =?us-ascii?Q?k2ckSiOevtRgds+ADa1qvZIs6/FNaCj5Z2k4keXFN4qgt/L4AToGc7YJcJ8R?=
 =?us-ascii?Q?Z/JNYTz3vEHLBeGRdFtqQjtUsA8rEpE4ZavMlxiG4W4tYh2qIULymf6jDg8O?=
 =?us-ascii?Q?NvKKvKtJ37mL029tzmGIgzLJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25680FF63B8149449CF3191E6768173E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8a3dad-c144-4786-fbae-08d9035dbf2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 18:05:42.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGNEDKBTCaXD9sN32t+jdSy98sBxfjhXH3iT1tNBD1a599675dwDcgpnykkoVrxsW0szpju/E+5RymjMex0WBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3414
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190124
X-Proofpoint-ORIG-GUID: SF3b6ZxWe7Xy-2sy6OLjEkZkitOCEIyl
X-Proofpoint-GUID: SF3b6ZxWe7Xy-2sy6OLjEkZkitOCEIyl
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190124
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 19, 2021, at 2:01 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> I've hit some crashes that occur in the xprt_rdma_inject_disconnect
> path. It appears that, for some provides, rdma_disconnect() can

^provides^providers

> take so long that the transport can disconnect and release its
> hardware resources while rdma_disconnect() is still running,
> resulting in a UAF in the provider.
>=20
> The transport's fault injection method may depend on the stability
> of transport data structures. That means it needs to be invoked
> only from contexts that hold the transport write lock.
>=20
> Fixes: 4a0682583988 ("SUNRPC: Transport fault injection")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/clnt.c               |    1 -
> net/sunrpc/xprt.c               |    6 ++++--
> net/sunrpc/xprtrdma/transport.c |    6 ++++--
> 3 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 612f0a641f4c..c2a01125be1a 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1799,7 +1799,6 @@ call_allocate(struct rpc_task *task)
>=20
> 	status =3D xprt->ops->buf_alloc(task);
> 	trace_rpc_buf_alloc(task, status);
> -	xprt_inject_disconnect(xprt);
> 	if (status =3D=3D 0)
> 		return;
> 	if (status !=3D -ENOMEM) {
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 691ccf8049a4..d616b93751d8 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -1483,7 +1483,10 @@ bool xprt_prepare_transmit(struct rpc_task *task)
>=20
> void xprt_end_transmit(struct rpc_task *task)
> {
> -	xprt_release_write(task->tk_rqstp->rq_xprt, task);
> +	struct rpc_xprt	*xprt =3D task->tk_rqstp->rq_xprt;
> +
> +	xprt_inject_disconnect(xprt);
> +	xprt_release_write(xprt, task);
> }
>=20
> /**
> @@ -1885,7 +1888,6 @@ void xprt_release(struct rpc_task *task)
> 	spin_unlock(&xprt->transport_lock);
> 	if (req->rq_buffer)
> 		xprt->ops->buf_free(task);
> -	xprt_inject_disconnect(xprt);
> 	xdr_free_bvec(&req->rq_rcv_buf);
> 	xdr_free_bvec(&req->rq_snd_buf);
> 	if (req->rq_cred !=3D NULL)
> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transp=
ort.c
> index 78d29d1bcc20..09953597d055 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -262,8 +262,10 @@ xprt_rdma_connect_worker(struct work_struct *work)
>  * xprt_rdma_inject_disconnect - inject a connection fault
>  * @xprt: transport context
>  *
> - * If @xprt is connected, disconnect it to simulate spurious connection
> - * loss.
> + * If @xprt is connected, disconnect it to simulate spurious
> + * connection loss. Caller must hold @xprt's send lock to
> + * ensure that data structures and hardware resources are
> + * stable during the rdma_disconnect() call.
>  */
> static void
> xprt_rdma_inject_disconnect(struct rpc_xprt *xprt)
>=20
>=20

--
Chuck Lever



