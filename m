Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCD521D64E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2020 14:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgGMMti (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jul 2020 08:49:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41632 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbgGMMth (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jul 2020 08:49:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DCko4B147096;
        Mon, 13 Jul 2020 12:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=3IQgW0/Xyva9CK3Q4C217A6BtnhwRDsOvg1ZCYWmd+g=;
 b=Z/MiFryX08TR44mJTnz2T/vA4IiMt3P4xF7tq6/299vdjONdTYxHvW/9Ms1VEbrrl/kh
 mwrUODTt3hbDzfBP9VCtLoDl84nShqg9bDxrSD23JXglKz4YdAvZ2rnjQ0WuRfI3YbYR
 sOCq53nWYA9BtMWWwpBMXTNR71C9IHBn+GbOmBQsSKsXVRxLd0TO+WtM4BWk/oo6UHR+
 j7+uj2/rpj6Ps6JsKlRsFwO9/A3jIKQzu1k1kIdJYJvK+lwjZp5u8GZo8ZOjD4lGvHfd
 rLnBQI38L58TOP/mAigImbmCIJxBjXK7meDP5ucdIt6U8AtMqZ7DhCTZJZWmlDZvGsan 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32762n6p96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 12:49:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DClWSd129401;
        Mon, 13 Jul 2020 12:49:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 327q0m9uu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 12:49:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06DCnRnO000487;
        Mon, 13 Jul 2020 12:49:27 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jul 2020 05:49:27 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] nfsd: avoid a NULL dereference in __cld_pipe_upcall()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200713122955.GY4452@aion.usersys.redhat.com>
Date:   Mon, 13 Jul 2020 08:49:26 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <646E9DB3-0E48-4C2D-A921-69615EAEC940@oracle.com>
References: <20200710203307.2545412-1-smayhew@redhat.com>
 <B6722AC5-A7DD-4EAF-B08A-45C12160D5DF@oracle.com>
 <20200713122955.GY4452@aion.usersys.redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130095
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 13, 2020, at 8:29 AM, Scott Mayhew <smayhew@redhat.com> wrote:
>=20
> On Sun, 12 Jul 2020, Chuck Lever wrote:
>=20
>> Hi Scott-
>>=20
>>> On Jul 10, 2020, at 4:33 PM, Scott Mayhew <smayhew@redhat.com> =
wrote:
>>>=20
>>> If the rpc_pipefs is unmounted, then the rpc_pipe->dentry becomes =
NULL
>>> and dereferencing the dentry->d_sb will trigger an oops.  The only
>>> reason we're doing that is to determine the nfsd_net, which could
>>> instead be passed in by the caller.  So do that instead.
>>>=20
>>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>>=20
>> Looks straightforward. Applied to the nfsd-5.9 testing tree.
>>=20
>> I'm wondering about automatic backports to stable. This fix does not
>> apply to kernels before v5.6, but IIUC addresses a crash introduced
>> in f3f8014862d8 ("nfsd: add the infrastructure to handle the cld =
upcall")
>> [2012] ?
>>=20
>> Is "Cc: <stable@kernel.org> # v5.6+" appropriate?
>>=20
> I think it would be 11a60d159259 ("nfsd: add a "GetVersion" upcall for
> nfsdcld"), so it would only need to go back to v5.4... and to get the
> patch to apply, in the hunk that modifies nfsd4_cld_grace_done_v0()
> you would need to add a cast of nn->boot_time to int64_t (which
> 9cc7680149b2 "nfsd: make 'boot_time' 64-bit wide" removed).

Thanks for the detailed background!

Then instead of "Cc: stable", can I add:

Fixes: 11a60d159259 ("nfsd: add a "GetVersion" upcall for nfsdcld") ?


>> Also, is there a bug report that documents the crash?
>=20
> Our QE hit the crash internally while running xfstests on a pNFS SCSI
> setup.  I don't think either of those is relevant aside from the fact
> that several nfsd threads where stuck on xfs while calling
> nfsd4_scsi_proc_layoutcommit().  I think what happened is that the job
> timed out and the system was in the process of being shut down when =
the
> oops occurred, and the rpc_pipefs was unmounted out from under nfsd:
>=20
> crash> bt
> PID: 39572  TASK: ffff8a78f67fddc0  CPU: 1   COMMAND: "kworker/u4:0"
> #0 [ffffa39a026b3ae0] machine_kexec at ffffffffae65b55e
> #1 [ffffa39a026b3b38] __crash_kexec at ffffffffae75ea5d
> #2 [ffffa39a026b3c00] crash_kexec at ffffffffae75f93d
> #3 [ffffa39a026b3c18] oops_end at ffffffffae622c4d
> #4 [ffffa39a026b3c38] no_context at ffffffffae66aa2e
> #5 [ffffa39a026b3c90] do_page_fault at ffffffffae66b552
> #6 [ffffa39a026b3cc0] async_page_fault at ffffffffaf00123e
>    [exception RIP: __cld_pipe_upcall+0x3d]
>    RIP: ffffffffc06b5ded  RSP: ffffa39a026b3d70  RFLAGS: 00010246
>    RAX: 0000000000000000  RBX: ffff8a78ceaf7000  RCX: 000000000000000b
>    RDX: ffff8a78ceaf7000  RSI: ffffa39a026b3d70  RDI: ffffa39a026b3d70
>    RBP: ffffa39a026b3dc0   R8: ffff8a78f37aac50   R9: ffff8a78c7c02800
>    R10: 8080808080808080  R11: 0000ec193f7575c0  R12: ffff8a78c8ef3038
>    R13: ffff8a78d3156220  R14: ffffa39a026b3e50  R15: ffff8a78d3156220
>    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> #7 [ffffa39a026b3dc8] nfsd4_cld_remove at ffffffffc06b7b70 [nfsd]
> #8 [ffffa39a026b3df8] expire_client at ffffffffc06aa4d6 [nfsd]
> #9 [ffffa39a026b3e08] laundromat_main at ffffffffc06aa799 [nfsd]
> #10 [ffffa39a026b3e98] process_one_work at ffffffffae6d1cf7
> #11 [ffffa39a026b3ed8] worker_thread at ffffffffae6d23c0
> #12 [ffffa39a026b3f10] kthread at ffffffffae6d7d02
> #13 [ffffa39a026b3f50] ret_from_fork at ffffffffaf000255
>=20
> crash> dis -lr __cld_pipe_upcall+0x3d
> ...
> =
/usr/src/debug/kernel-4.18.0-211.el8/linux-4.18.0-211.el8.x86_64/fs/nfsd/n=
fs4recover.c: 764
> 0xffffffffc06b5de0 <__cld_pipe_upcall+0x30>:    mov    =
0x108(%rdi),%rax
> 0xffffffffc06b5de7 <__cld_pipe_upcall+0x37>:    mov    %rsp,%rsi
> 0xffffffffc06b5dea <__cld_pipe_upcall+0x3a>:    mov    %rsi,%rdi
> 0xffffffffc06b5ded <__cld_pipe_upcall+0x3d>:    mov    0x68(%rax),%rax
>=20
> That puts us here:
>=20
> static int
> __cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
> {
>        int ret;
>        struct rpc_pipe_msg msg;
>        struct cld_upcall *cup =3D container_of(cmsg, struct =
cld_upcall, cu_u);
>        struct nfsd_net *nn =3D =
net_generic(pipe->dentry->d_sb->s_fs_info,
>                                          nfsd_net_id);
> ...
> crash> rpc_pipe.dentry -o
> struct rpc_pipe {
>  [0x108] struct dentry *dentry;
> }
> crash> dentry.d_sb -o
> struct dentry {
>  [0x68] struct super_block *d_sb;
> }
>=20
> If the rpc_pipe->dentry was NULL, that would explain the NULL pointer =
dereference at 0000000000000068.  Let's confirm.
>=20
> crash> dis -lr ffffffffc06b7b70
> ...
> =
/usr/src/debug/kernel-4.18.0-211.el8/linux-4.18.0-211.el8.x86_64/fs/nfsd/n=
fs4recover.c: 794
> 0xffffffffc06b7b65 <nfsd4_cld_remove+0x85>:     mov    %rbp,%rsi
> 0xffffffffc06b7b68 <nfsd4_cld_remove+0x88>:     mov    %rbx,%rdi =
<------------------------------rpc_pipe
> 0xffffffffc06b7b6b <nfsd4_cld_remove+0x8b>:     callq  =
0xffffffffc06b5db0 <__cld_pipe_upcall>
> =
/usr/src/debug/kernel-4.18.0-211.el8/linux-4.18.0-211.el8.x86_64/fs/nfsd/n=
fs4recover.c: 795
> 0xffffffffc06b7b70 <nfsd4_cld_remove+0x90>:     cmp    =
$0xfffffff5,%eax
>=20
> crash> rpc_pipe.dentry ffff8a78ceaf7000
>  dentry =3D 0x0
>=20
> We can also see that the rpc_pipefs isn't mounted:
>=20
> crash> mount|grep pipefs
> (nothing)
>=20
> And none of the daemons that require the rpc_pipefs are running:
>=20
> crash> ps|grep nfsdcld
> crash> ps|grep idmapd
> crash> ps|grep gssd
> crash> ps|grep blkmapd
> (nothing)
>=20
> I think part of the problem is that the nfsdcld.service unit file has
> "Requires=3Drpc_pipefs.target", but the nfs-server.service unit file =
only
> has "Wants=3Dnfsdcld.service".  It can't be "Requires" because using =
the
> nfsdcld daemon for client tracking is optional.
>=20
> -Scott
>=20
>>=20
>>=20
>>> ---
>>> fs/nfsd/nfs4recover.c | 24 +++++++++++-------------
>>> 1 file changed, 11 insertions(+), 13 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
>>> index 9e40dfecf1b1..186fa2c2c6ba 100644
>>> --- a/fs/nfsd/nfs4recover.c
>>> +++ b/fs/nfsd/nfs4recover.c
>>> @@ -747,13 +747,11 @@ struct cld_upcall {
>>> };
>>>=20
>>> static int
>>> -__cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
>>> +__cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg, struct =
nfsd_net *nn)
>>> {
>>> 	int ret;
>>> 	struct rpc_pipe_msg msg;
>>> 	struct cld_upcall *cup =3D container_of(cmsg, struct cld_upcall, =
cu_u);
>>> -	struct nfsd_net *nn =3D =
net_generic(pipe->dentry->d_sb->s_fs_info,
>>> -					  nfsd_net_id);
>>>=20
>>> 	memset(&msg, 0, sizeof(msg));
>>> 	msg.data =3D cmsg;
>>> @@ -773,7 +771,7 @@ __cld_pipe_upcall(struct rpc_pipe *pipe, void =
*cmsg)
>>> }
>>>=20
>>> static int
>>> -cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
>>> +cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg, struct nfsd_net =
*nn)
>>> {
>>> 	int ret;
>>>=20
>>> @@ -782,7 +780,7 @@ cld_pipe_upcall(struct rpc_pipe *pipe, void =
*cmsg)
>>> 	 *  upcalls queued.
>>> 	 */
>>> 	do {
>>> -		ret =3D __cld_pipe_upcall(pipe, cmsg);
>>> +		ret =3D __cld_pipe_upcall(pipe, cmsg, nn);
>>> 	} while (ret =3D=3D -EAGAIN);
>>>=20
>>> 	return ret;
>>> @@ -1115,7 +1113,7 @@ nfsd4_cld_create(struct nfs4_client *clp)
>>> 	memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
>>> 			clp->cl_name.len);
>>>=20
>>> -	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
>>> +	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
>>> 	if (!ret) {
>>> 		ret =3D cup->cu_u.cu_msg.cm_status;
>>> 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
>>> @@ -1180,7 +1178,7 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
>>> 	} else
>>> 		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len =3D 0;
>>>=20
>>> -	ret =3D cld_pipe_upcall(cn->cn_pipe, cmsg);
>>> +	ret =3D cld_pipe_upcall(cn->cn_pipe, cmsg, nn);
>>> 	if (!ret) {
>>> 		ret =3D cmsg->cm_status;
>>> 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
>>> @@ -1218,7 +1216,7 @@ nfsd4_cld_remove(struct nfs4_client *clp)
>>> 	memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
>>> 			clp->cl_name.len);
>>>=20
>>> -	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
>>> +	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
>>> 	if (!ret) {
>>> 		ret =3D cup->cu_u.cu_msg.cm_status;
>>> 		clear_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
>>> @@ -1261,7 +1259,7 @@ nfsd4_cld_check_v0(struct nfs4_client *clp)
>>> 	memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
>>> 			clp->cl_name.len);
>>>=20
>>> -	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
>>> +	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
>>> 	if (!ret) {
>>> 		ret =3D cup->cu_u.cu_msg.cm_status;
>>> 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
>>> @@ -1404,7 +1402,7 @@ nfsd4_cld_grace_start(struct nfsd_net *nn)
>>> 	}
>>>=20
>>> 	cup->cu_u.cu_msg.cm_cmd =3D Cld_GraceStart;
>>> -	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
>>> +	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
>>> 	if (!ret)
>>> 		ret =3D cup->cu_u.cu_msg.cm_status;
>>>=20
>>> @@ -1432,7 +1430,7 @@ nfsd4_cld_grace_done_v0(struct nfsd_net *nn)
>>>=20
>>> 	cup->cu_u.cu_msg.cm_cmd =3D Cld_GraceDone;
>>> 	cup->cu_u.cu_msg.cm_u.cm_gracetime =3D nn->boot_time;
>>> -	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
>>> +	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
>>> 	if (!ret)
>>> 		ret =3D cup->cu_u.cu_msg.cm_status;
>>>=20
>>> @@ -1460,7 +1458,7 @@ nfsd4_cld_grace_done(struct nfsd_net *nn)
>>> 	}
>>>=20
>>> 	cup->cu_u.cu_msg.cm_cmd =3D Cld_GraceDone;
>>> -	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
>>> +	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
>>> 	if (!ret)
>>> 		ret =3D cup->cu_u.cu_msg.cm_status;
>>>=20
>>> @@ -1524,7 +1522,7 @@ nfsd4_cld_get_version(struct nfsd_net *nn)
>>> 		goto out_err;
>>> 	}
>>> 	cup->cu_u.cu_msg.cm_cmd =3D Cld_GetVersion;
>>> -	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
>>> +	ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
>>> 	if (!ret) {
>>> 		ret =3D cup->cu_u.cu_msg.cm_status;
>>> 		if (ret)
>>> --=20
>>> 2.25.4
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



