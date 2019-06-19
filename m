Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C584C261
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 22:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFSU0L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 16:26:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFSU0K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 16:26:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JKJUnC119159;
        Wed, 19 Jun 2019 20:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=7HuPfR1DT4zYEKdIZnnRrDSeTf8hQPocZvrAWmpzHUg=;
 b=yB22p9ZzNxZWo07rFE7wIFK4Rw4WhBPQ15Cva5BXIKGClpJZT6bOSnjRhBEwAs2jCsx/
 xukBG3KelLHIGH3Ldv1J0UJ6d5gO2xiBnJJ+r8ZhIwNiD8X25GMCyWEYanv9hK8K94nY
 jE+PiDi+JkhbkSPh4qF+gFCmtPg3FZsVNPQdQADXK+RXMQgrqwqOsAOAeFcgiJD+EsXV
 mnSdDEtoT4DQB/WEXYVOnVUr0g567Fy7S5B8h2xfVIyPy3YSYlJt/QP8ISsZvk5gG+iU
 R3kbhbMihpywRqCORJZpVSxl2veXNOwaRRkoqXMtvui5YlCoSlr1pJU4k51R+15vGopB NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t7809dj8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 20:26:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JKPFJ4046360;
        Wed, 19 Jun 2019 20:26:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t7rdwudup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 20:26:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JKPw36017607;
        Wed, 19 Jun 2019 20:26:02 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 13:25:58 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] svcrdma: Ignore source port when computing DRC hash
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190611150116.4209.63309.stgit@klimt.1015granger.net>
Date:   Wed, 19 Jun 2019 16:25:57 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAF5EE39-8B5D-4F5C-9E9E-8FCA6EED8378@oracle.com>
References: <20190611150116.4209.63309.stgit@klimt.1015granger.net>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190167
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 11, 2019, at 11:01 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> The DRC appears to be effectively empty after an RPC/RDMA transport
> reconnect. The problem is that each connection uses a different
> source port, which defeats the DRC hash.
>=20
> Clients always have to disconnect before they send retransmissions
> to reset the connection's credit accounting, thus every retransmit
> on NFS/RDMA will miss the DRC.
>=20
> An NFS/RDMA client's IP source port is meaningless for RDMA
> transports. The transport layer typically sets the source port value
> on the connection to a random ephemeral port. The server already
> ignores it for the "secure port" check. See commit 16e4d93f6de7
> ("NFSD: Ignore client's source port on RDMA transports").
>=20
> The Linux NFS server's DRC resolves XID collisions from the same
> source IP address by using the checksum of the first 200 bytes of
> the RPC call header.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: stable@vger.kernel.org # v4.14+
> ---
> net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c =
b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 027a3b0..0004535 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id =
*new_cma_id,
> 	/* Save client advertised inbound read limit for use later in =
accept. */
> 	newxprt->sc_ord =3D param->initiator_depth;
>=20
> -	/* Set the local and remote addresses in the transport */
> 	sa =3D (struct sockaddr =
*)&newxprt->sc_cm_id->route.addr.dst_addr;
> 	svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
> +	/* The remote port is arbitrary and not under the control of the
> +	 * client ULP. Set it to a fixed value so that the DRC continues
> +	 * to be effective after a reconnect.
> +	 */
> +	rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, =
0);
> +
> 	sa =3D (struct sockaddr =
*)&newxprt->sc_cm_id->route.addr.src_addr;
> 	svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));

Hi Bruce, what's the disposition of this patch?


--
Chuck Lever



