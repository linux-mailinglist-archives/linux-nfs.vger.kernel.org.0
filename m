Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B92121C9DD
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2020 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgGLOrH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Jul 2020 10:47:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41256 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgGLOrG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Jul 2020 10:47:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06CEhH5G014035;
        Sun, 12 Jul 2020 14:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=zDeK5RziViwzXmbwfqq5aLI663VszJzfDtqfjAjEd7s=;
 b=E7xijBbTQRxz0vblsaVIjW9uarQ4SnALb3kl2PRDWcfzNwtyewe/FD46/OCF11PbYcrF
 hM266XApPaD6irNngCtDiCplfwclvwYR+5k+CcjPbb+l+T0o/bGlqZqPXMhVlO8Ft5oe
 4s/28SR8iV2cfcxY0JGxXzObhL6MI7gynxvnvWN8TtplBC0w3lLMEU8TFeANUZY58OuD
 olADty1Sa69fftfKk4JC8EfKJLKv3K/oiFnFTDyO0KTWm7/7At+hMBfd3UF4GK2v5dgr
 9BSwlHtGes5YPRMRxXZWRGQgeZjJuKddM0P34aW8sc9t+DWDCRSTkwHqtO2hrXMsTEvV Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3274uqum17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 12 Jul 2020 14:46:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06CEhQph035071;
        Sun, 12 Jul 2020 14:46:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 327qax071p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jul 2020 14:46:59 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06CEkrAf022939;
        Sun, 12 Jul 2020 14:46:53 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Jul 2020 07:46:53 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] nfsd: avoid a NULL dereference in __cld_pipe_upcall()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200710203307.2545412-1-smayhew@redhat.com>
Date:   Sun, 12 Jul 2020 10:46:52 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <B6722AC5-A7DD-4EAF-B08A-45C12160D5DF@oracle.com>
References: <20200710203307.2545412-1-smayhew@redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007120116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007120116
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Scott-

> On Jul 10, 2020, at 4:33 PM, Scott Mayhew <smayhew@redhat.com> wrote:
> 
> If the rpc_pipefs is unmounted, then the rpc_pipe->dentry becomes NULL
> and dereferencing the dentry->d_sb will trigger an oops.  The only
> reason we're doing that is to determine the nfsd_net, which could
> instead be passed in by the caller.  So do that instead.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>

Looks straightforward. Applied to the nfsd-5.9 testing tree.

I'm wondering about automatic backports to stable. This fix does not
apply to kernels before v5.6, but IIUC addresses a crash introduced
in f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
[2012] ?

Is "Cc: <stable@kernel.org> # v5.6+" appropriate?

Also, is there a bug report that documents the crash?


> ---
> fs/nfsd/nfs4recover.c | 24 +++++++++++-------------
> 1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 9e40dfecf1b1..186fa2c2c6ba 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -747,13 +747,11 @@ struct cld_upcall {
> };
> 
> static int
> -__cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
> +__cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg, struct nfsd_net *nn)
> {
> 	int ret;
> 	struct rpc_pipe_msg msg;
> 	struct cld_upcall *cup = container_of(cmsg, struct cld_upcall, cu_u);
> -	struct nfsd_net *nn = net_generic(pipe->dentry->d_sb->s_fs_info,
> -					  nfsd_net_id);
> 
> 	memset(&msg, 0, sizeof(msg));
> 	msg.data = cmsg;
> @@ -773,7 +771,7 @@ __cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
> }
> 
> static int
> -cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
> +cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg, struct nfsd_net *nn)
> {
> 	int ret;
> 
> @@ -782,7 +780,7 @@ cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
> 	 *  upcalls queued.
> 	 */
> 	do {
> -		ret = __cld_pipe_upcall(pipe, cmsg);
> +		ret = __cld_pipe_upcall(pipe, cmsg, nn);
> 	} while (ret == -EAGAIN);
> 
> 	return ret;
> @@ -1115,7 +1113,7 @@ nfsd4_cld_create(struct nfs4_client *clp)
> 	memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
> 			clp->cl_name.len);
> 
> -	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> +	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> 	if (!ret) {
> 		ret = cup->cu_u.cu_msg.cm_status;
> 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> @@ -1180,7 +1178,7 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
> 	} else
> 		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = 0;
> 
> -	ret = cld_pipe_upcall(cn->cn_pipe, cmsg);
> +	ret = cld_pipe_upcall(cn->cn_pipe, cmsg, nn);
> 	if (!ret) {
> 		ret = cmsg->cm_status;
> 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> @@ -1218,7 +1216,7 @@ nfsd4_cld_remove(struct nfs4_client *clp)
> 	memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
> 			clp->cl_name.len);
> 
> -	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> +	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> 	if (!ret) {
> 		ret = cup->cu_u.cu_msg.cm_status;
> 		clear_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> @@ -1261,7 +1259,7 @@ nfsd4_cld_check_v0(struct nfs4_client *clp)
> 	memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
> 			clp->cl_name.len);
> 
> -	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> +	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> 	if (!ret) {
> 		ret = cup->cu_u.cu_msg.cm_status;
> 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> @@ -1404,7 +1402,7 @@ nfsd4_cld_grace_start(struct nfsd_net *nn)
> 	}
> 
> 	cup->cu_u.cu_msg.cm_cmd = Cld_GraceStart;
> -	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> +	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> 	if (!ret)
> 		ret = cup->cu_u.cu_msg.cm_status;
> 
> @@ -1432,7 +1430,7 @@ nfsd4_cld_grace_done_v0(struct nfsd_net *nn)
> 
> 	cup->cu_u.cu_msg.cm_cmd = Cld_GraceDone;
> 	cup->cu_u.cu_msg.cm_u.cm_gracetime = nn->boot_time;
> -	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> +	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> 	if (!ret)
> 		ret = cup->cu_u.cu_msg.cm_status;
> 
> @@ -1460,7 +1458,7 @@ nfsd4_cld_grace_done(struct nfsd_net *nn)
> 	}
> 
> 	cup->cu_u.cu_msg.cm_cmd = Cld_GraceDone;
> -	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> +	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> 	if (!ret)
> 		ret = cup->cu_u.cu_msg.cm_status;
> 
> @@ -1524,7 +1522,7 @@ nfsd4_cld_get_version(struct nfsd_net *nn)
> 		goto out_err;
> 	}
> 	cup->cu_u.cu_msg.cm_cmd = Cld_GetVersion;
> -	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> +	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> 	if (!ret) {
> 		ret = cup->cu_u.cu_msg.cm_status;
> 		if (ret)
> -- 
> 2.25.4
> 

--
Chuck Lever



