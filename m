Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF00D649E68
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 13:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiLLMEd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 07:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiLLME3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 07:04:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1511153
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 04:04:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 805CA60F3F
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 12:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F932C433D2;
        Mon, 12 Dec 2022 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670846665;
        bh=ICfYBzzq4Z2Ckmm38IkuzEvtL1/mQ7CGnSFLuCUxTdI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CdWScCLeqByi9DwJHBy9vQS9tmW1V2v8KAro5E/ipmfuOt/Zq4vtbU02bfBx+M3F8
         wSeZtXCpCLqQg0pPRnsrWMyrF9guvt8Xg0ZD3p84RlAAkVC8aWuyE1UlFd+QyN0JuR
         +4JAVHygiz8mV9kOOcPMCCLVyMtbr6Fsrlvub+YWeaRKjDLvyS8qOftkFfIKEEsEAw
         MppjSAlowmqzXJO5+NWBWqS/6Si2QahAgbrfGoQVVh7+62DGDTOWeZ4g1Lo7Hyylu4
         payHIv+nMTBJa5aGXfNsbhbEJwlcobT968PIDbFHU8UOaaQG49L1fK5XbSuMpRrqDs
         fySnqXFuC7SXA==
Message-ID: <3af79ee4cf8d8e9b129d28a9faa68252c2888554.camel@kernel.org>
Subject: Re: [PATCH] nfsd: under NFSv4.1, fix double svc_xprt_put on
 rpc_create failure
From:   Jeff Layton <jlayton@kernel.org>
To:     Dan Aloni <dan.aloni@vastdata.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "J . Bruce Fields" <bfields@redhat.com>
Date:   Mon, 12 Dec 2022 07:04:23 -0500
In-Reply-To: <20221212111106.131472-1-dan.aloni@vastdata.com>
References: <20221212111106.131472-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-12-12 at 13:11 +0200, Dan Aloni wrote:
> On error situation `clp->cl_cb_conn.cb_xprt` should not be given
> a reference to the xprt otherwise both client cleanup and the
> error handling path of the caller call to put it. Better to
> delay handing over the reference to a later branch.
>=20
> [   72.530665] refcount_t: underflow; use-after-free.
> [   72.531933] WARNING: CPU: 0 PID: 173 at lib/refcount.c:28 refcount_war=
n_saturate+0xcf/0x120
> [   72.533075] Modules linked in: nfsd(OE) nfsv4(OE) nfsv3(OE) nfs(OE) lo=
ckd(OE) compat_nfs_ssc(OE) nfs_acl(OE) rpcsec_gss_krb5(OE) auth_rpcgss(OE) =
rpcrdma(OE) dns_resolver fscache netfs grace rdma_cm iw_cm ib_cm sunrpc(OE)=
 mlx5_ib mlx5_core mlxfw pci_hyperv_intf ib_uverbs ib_core xt_MASQUERADE nf=
_conntrack_netlink nft_counter xt_addrtype nft_compat br_netfilter bridge s=
tp llc nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_=
chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set overlay =
nf_tables nfnetlink crct10dif_pclmul crc32_pclmul ghash_clmulni_intel xfs s=
erio_raw virtio_net virtio_blk net_failover failover fuse [last unloaded: s=
unrpc]
> [   72.540389] CPU: 0 PID: 173 Comm: kworker/u16:5 Tainted: G           O=
E     5.15.82-dan #1
> [   72.541511] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.16.0-3.module+e=
l8.7.0+1084+97b81f61 04/01/2014
> [   72.542717] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
> [   72.543575] RIP: 0010:refcount_warn_saturate+0xcf/0x120
> [   72.544299] Code: 55 00 0f 0b 5d e9 01 50 98 00 80 3d 75 9e 39 08 00 0=
f 85 74 ff ff ff 48 c7 c7 e8 d1 60 8e c6 05 61 9e 39 08 01 e8 f6 51 55 00 <=
0f> 0b 5d e9 d9 4f 98 00 80 3d 4b 9e 39 08 00 0f 85 4c ff ff ff 48
> [   72.546666] RSP: 0018:ffffb3f841157cf0 EFLAGS: 00010286
> [   72.547393] RAX: 0000000000000026 RBX: ffff89ac6231d478 RCX: 000000000=
0000000
> [   72.548324] RDX: ffff89adb7c2c2c0 RSI: ffff89adb7c205c0 RDI: ffff89adb=
7c205c0
> [   72.549271] RBP: ffffb3f841157cf0 R08: 0000000000000000 R09: c0000000f=
fefffff
> [   72.550209] R10: 0000000000000001 R11: ffffb3f841157ad0 R12: ffff89ac6=
231d180
> [   72.551142] R13: ffff89ac6231d478 R14: ffff89ac40c06180 R15: ffff89ac6=
231d4b0
> [   72.552089] FS:  0000000000000000(0000) GS:ffff89adb7c00000(0000) knlG=
S:0000000000000000
> [   72.553175] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   72.553934] CR2: 0000563a310506a8 CR3: 0000000109a66000 CR4: 000000000=
0350ef0
> [   72.554874] Call Trace:
> [   72.555278]  <TASK>
> [   72.555614]  svc_xprt_put+0xaf/0xe0 [sunrpc]
> [   72.556276]  nfsd4_process_cb_update.isra.11+0xb7/0x410 [nfsd]
> [   72.557087]  ? update_load_avg+0x82/0x610
> [   72.557652]  ? cpuacct_charge+0x60/0x70
> [   72.558212]  ? dequeue_entity+0xdb/0x3e0
> [   72.558765]  ? queued_spin_unlock+0x9/0x20
> [   72.559358]  nfsd4_run_cb_work+0xfc/0x270 [nfsd]
> [   72.560031]  process_one_work+0x1df/0x390
> [   72.560600]  worker_thread+0x37/0x3b0
> [   72.561644]  ? process_one_work+0x390/0x390
> [   72.562247]  kthread+0x12f/0x150
> [   72.562710]  ? set_kthread_struct+0x50/0x50
> [   72.563309]  ret_from_fork+0x22/0x30
> [   72.563818]  </TASK>
> [   72.564189] ---[ end trace 031117b1c72ec616 ]---
> [   72.566019] list_add corruption. next->prev should be prev (ffff89ac49=
77e538), but was ffff89ac4763e018. (next=3Dffff89ac4763e018).
> [   72.567647] ------------[ cut here ]------------
>=20
> Fixes: a4abc6b12eb1 ('nfsd: Fix svc_xprt refcnt leak when setup callback =
client failed')
> Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Cc: J. Bruce Fields <bfields@redhat.com>
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> ---
>  fs/nfsd/nfs4callback.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index f0e69edf5f0f..6253cbe5f81b 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -916,7 +916,6 @@ static int setup_callback_client(struct nfs4_client *=
clp, struct nfs4_cb_conn *c
>  	} else {
>  		if (!conn->cb_xprt)
>  			return -EINVAL;
> -		clp->cl_cb_conn.cb_xprt =3D conn->cb_xprt;
>  		clp->cl_cb_session =3D ses;
>  		args.bc_xprt =3D conn->cb_xprt;
>  		args.prognumber =3D clp->cl_cb_session->se_cb_prog;
> @@ -936,6 +935,9 @@ static int setup_callback_client(struct nfs4_client *=
clp, struct nfs4_cb_conn *c
>  		rpc_shutdown_client(client);
>  		return -ENOMEM;
>  	}
> +
> +	if (clp->cl_minorversion !=3D 0)
> +		clp->cl_cb_conn.cb_xprt =3D conn->cb_xprt;
>  	clp->cl_cb_client =3D client;
>  	clp->cl_cb_cred =3D cred;
>  	rcu_read_lock();

Nice catch:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
