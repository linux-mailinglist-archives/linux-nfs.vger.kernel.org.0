Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A825E927
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Sep 2020 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgIEQzQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Sep 2020 12:55:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36812 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgIEQzP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Sep 2020 12:55:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085GsWQM030336;
        Sat, 5 Sep 2020 16:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=jnuxqMOv4q692rY336s7eKMn93zUhbMwKt2gi5yMTqg=;
 b=atpGs/G5Dc2AEzUq1m3G3jmGwEbJUNydj3f5oYndLnvwPK0O4rGHn1kAt9jnNgu1xr9J
 qiAnqQjUlK2kwacjH+5neBidvwRkoZtdMWHCGyMh4+ajvt3aE7YWAJb2Ito+EIyc3iqp
 65j6g6psftn3d9Yhf7C47tobBA2XxwFwnKrHRn/1TPED4VZMiTslr8T+mUfUOszjELp1
 NLwXdlStn0ljFekeAjab3HJ/A9lKRDft1cxOQf7e36OhyFIr6TqINUdEkZQDtTBPtrIt
 YhvnjfNc+ozFu62PP7aieNVgMihRxfAwWo9682Owjr0NeykD3qluwAhGANw+mJcNqQ7e Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mkhhfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 05 Sep 2020 16:55:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085Gsnou088519;
        Sat, 5 Sep 2020 16:55:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33c2g0tn2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Sep 2020 16:55:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 085Gt4HI027400;
        Sat, 5 Sep 2020 16:55:07 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 05 Sep 2020 09:55:04 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] SUNRPC: stop printk reading past end of string
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200905140326.GA26625@fieldses.org>
Date:   Sat, 5 Sep 2020 12:55:03 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3447F02-7A1F-4D6D-A8B7-C051BE732736@oracle.com>
References: <20200905140326.GA26625@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9735 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009050165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9735 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050165
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 5, 2020, at 10:03 AM, bfields@fieldses.org wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> Since p points at raw xdr data, there's no guarantee that it's NULL
> terminated, so we should give a length.  And probably escape any =
special
> characters too.
>=20
> Reported-by: Zhi Li <yieli@redhat.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

I sent a patch a couple months ago to remove this dprintk:

=
https://lore.kernel.org/linux-nfs/20200708201029.22129.31971.stgit@manet.1=
015granger.net/T/#u

However you might want to apply Bruce's patch first, so it can
be backported to stable.


> ---
> net/sunrpc/rpcb_clnt.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
> index c27123e6ba80..4a67685c83eb 100644
> --- a/net/sunrpc/rpcb_clnt.c
> +++ b/net/sunrpc/rpcb_clnt.c
> @@ -982,8 +982,8 @@ static int rpcb_dec_getaddr(struct rpc_rqst *req, =
struct xdr_stream *xdr,
> 	p =3D xdr_inline_decode(xdr, len);
> 	if (unlikely(p =3D=3D NULL))
> 		goto out_fail;
> -	dprintk("RPC: %5u RPCB_%s reply: %s\n", req->rq_task->tk_pid,
> -			req->rq_task->tk_msg.rpc_proc->p_name, (char =
*)p);
> +	dprintk("RPC: %5u RPCB_%s reply: %*pE\n", req->rq_task->tk_pid,
> +			req->rq_task->tk_msg.rpc_proc->p_name, len, =
(char *)p);
>=20
> 	if (rpc_uaddr2sockaddr(req->rq_xprt->xprt_net, (char *)p, len,
> 				sap, sizeof(address)) =3D=3D 0)
> --=20
> 2.26.2
>=20

--
Chuck Lever



