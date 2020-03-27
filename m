Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532A1195B19
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 17:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgC0Qab (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 12:30:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36532 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgC0Qab (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 12:30:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RGMQJk152872;
        Fri, 27 Mar 2020 16:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 to : in-reply-to : message-id; s=corp-2020-01-29;
 bh=lKw580IEckaNt+6VSr6eXfoFbXsq14hbhkxA/PP/+Kw=;
 b=eZRSwA+/022ULPpOI29X+SYq9qiR0i02TST7BmCzaffW3fMDLOSUNKgHJHyWUwg8g85d
 Ep0FZgqqYeCoSd4CfLZsjm0uTOq9lAItM9NX3gG+WOnE8FTmGiRs6fEtgxjgNSnpIXG/
 EjShVFRla/D5ly13kZxi53iyrUWyTeGOYIGz/o+UAsZwkV/mivx9lvq7Sdr4hdlmuR72
 WEKS0O/vGCmVvIj8Rg6iMmvsWvznYYIP/erpVssQ6zceHTj3VXTEGBK7wds2QjXa3M8k
 pHBTPV0d+J/zmrnz71I0d39TofP97n1AwBIHAJVqZTI09wB9DFYq9JgsqUmwxR7QW3BR Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 301459c41s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 16:30:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RGJrQ2045975;
        Fri, 27 Mar 2020 16:28:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3003gp8n4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 16:28:29 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02RGSSVa010304;
        Fri, 27 Mar 2020 16:28:28 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Mar 2020 09:28:28 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] svcrdma: Fix leak of transport addresses
Date:   Fri, 27 Mar 2020 12:28:26 -0400
References: <20200326145920.29379.46066.stgit@klimt.1015granger.net>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
In-Reply-To: <20200326145920.29379.46066.stgit@klimt.1015granger.net>
Message-Id: <2994883C-F218-4054-A8DD-7F9DA515321A@oracle.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=2 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270144
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Mar 26, 2020, at 11:00 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Kernel memory leak detected:
>=20
> unreferenced object 0xffff888849cdf480 (size 8):
>  comm "kworker/u8:3", pid 2086, jiffies 4297898756 (age 4269.856s)
>  hex dump (first 8 bytes):
>    30 00 cd 49 88 88 ff ff                          0..I....
>  backtrace:
>    [<00000000acfc370b>] __kmalloc_track_caller+0x137/0x183
>    [<00000000a2724354>] kstrdup+0x2b/0x43
>    [<0000000082964f84>] xprt_rdma_format_addresses+0x114/0x17d =
[rpcrdma]
>    [<00000000dfa6ed00>] xprt_setup_rdma_bc+0xc0/0x10c [rpcrdma]
>    [<0000000073051a83>] xprt_create_transport+0x3f/0x1a0 [sunrpc]
>    [<0000000053531a8e>] rpc_create+0x118/0x1cd [sunrpc]
>    [<000000003a51b5f8>] setup_callback_client+0x1a5/0x27d [nfsd]
>    [<000000001bd410af>] nfsd4_process_cb_update.isra.7+0x16c/0x1ac =
[nfsd]
>    [<000000007f4bbd56>] nfsd4_run_cb_work+0x4c/0xbd [nfsd]
>    [<0000000055c5586b>] process_one_work+0x1b2/0x2fe
>    [<00000000b1e3e8ef>] worker_thread+0x1a6/0x25a
>    [<000000005205fb78>] kthread+0xf6/0xfb
>    [<000000006d2dc057>] ret_from_fork+0x3a/0x50
>=20
> Introduce a call to xprt_rdma_free_addresses() similar to the way
> that the TCP backchannel releases a transport's peer address
> strings.
>=20
> Fixes: 5d252f90a800 ("svcrdma: Add class for RDMA backwards direction =
transport")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

This fix seems straightforward and small, so I'll apply it to
nfsd-5.7 with the other fixes I received this morning rather
than postponing it to 5.7-rc.


> ---
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    1 +
> 1 file changed, 1 insertion(+)
>=20
> Here's a possible fix for v5.7-rc.
>=20
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c =
b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> index 46b59e91d34a..d510a3a15d4b 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> @@ -252,6 +252,7 @@ xprt_rdma_bc_put(struct rpc_xprt *xprt)
> {
> 	dprintk("svcrdma: %s: xprt %p\n", __func__, xprt);
>=20
> +	xprt_rdma_free_addresses(xprt);
> 	xprt_free(xprt);
> }
>=20
>=20

--
Chuck Lever



