Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF824BA3C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Aug 2020 14:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgHTMDn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 08:03:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730735AbgHTMDY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Aug 2020 08:03:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FFE9C39410D8D12457E;
        Thu, 20 Aug 2020 20:03:10 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 20:02:55 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <kolga@netapp.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] nfs: Convert to use the preferred fallthrough macro
Date:   Thu, 20 Aug 2020 08:01:49 -0400
Message-ID: <20200820120149.12140-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro. Please see
commit 294f69e662d1 ("compiler_attributes.h: Add 'fallthrough' pseudo
keyword for switch/case use") for detail.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/nfs/blocklayout/blocklayout.c       |  2 +-
 fs/nfs/dir.c                           |  2 +-
 fs/nfs/filelayout/filelayout.c         |  2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c |  4 ++--
 fs/nfs/fs_context.c                    | 22 ++++++++++--------
 fs/nfs/nfs3acl.c                       |  4 ++--
 fs/nfs/nfs4file.c                      |  2 +-
 fs/nfs/nfs4idmap.c                     |  4 ++--
 fs/nfs/nfs4proc.c                      | 32 +++++++++++++-------------
 fs/nfs/nfs4state.c                     | 14 +++++------
 fs/nfs/pagelist.c                      |  2 +-
 fs/nfs/pnfs.c                          |  2 +-
 fs/nfs/super.c                         |  2 +-
 13 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index d1a0e2c8b1b4..08108b6d2fa1 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -753,7 +753,7 @@ bl_alloc_lseg(struct pnfs_layout_hdr *lo, struct nfs4_layoutget_res *lgr,
 	case -ENODEV:
 		/* Our extent block devices are unavailable */
 		set_bit(NFS_LSEG_UNAVAILABLE, &lseg->pls_flags);
-		/* Fall through */
+		fallthrough;
 	case 0:
 		return lseg;
 	default:
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a12f42e7d8c7..e732580fe47b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1181,7 +1181,7 @@ int nfs_lookup_verify_inode(struct inode *inode, unsigned int flags)
 			/* A NFSv4 OPEN will revalidate later */
 			if (server->caps & NFS_CAP_ATOMIC_OPEN)
 				goto out;
-			/* Fallthrough */
+			fallthrough;
 		case S_IFDIR:
 			if (server->flags & NFS_MOUNT_NOCTO)
 				break;
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index a13e69009f19..7f5aa0403e16 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -187,7 +187,7 @@ static int filelayout_async_handle_error(struct rpc_task *task,
 		pnfs_error_mark_layout_for_return(inode, lseg);
 		pnfs_set_lo_fail(lseg);
 		rpc_wake_up(&tbl->slot_tbl_waitq);
-		/* fall through */
+		fallthrough;
 	default:
 reset:
 		dprintk("%s Retry through MDS. Error %d\n", __func__,
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 965145592750..ff8965d1a4d4 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1133,7 +1133,7 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
 		rpc_wake_up(&tbl->slot_tbl_waitq);
-		/* fall through */
+		fallthrough;
 	default:
 		if (ff_layout_avoid_mds_available_ds(lseg))
 			return -NFS4ERR_RESET_TO_PNFS;
@@ -1260,7 +1260,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		 */
 		if (opnum == OP_READ)
 			break;
-		/* Fallthrough */
+		fallthrough;
 	default:
 		pnfs_error_mark_layout_for_return(lseg->pls_layout->plh_inode,
 						  lseg);
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 66949da0e827..524812984e2d 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -651,21 +651,21 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
 		case Opt_xprt_udp6:
 			protofamily = AF_INET6;
-			/* fall through */
+			fallthrough;
 		case Opt_xprt_udp:
 			ctx->flags &= ~NFS_MOUNT_TCP;
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 			break;
 		case Opt_xprt_tcp6:
 			protofamily = AF_INET6;
-			/* fall through */
+			fallthrough;
 		case Opt_xprt_tcp:
 			ctx->flags |= NFS_MOUNT_TCP;
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 			break;
 		case Opt_xprt_rdma6:
 			protofamily = AF_INET6;
-			/* fall through */
+			fallthrough;
 		case Opt_xprt_rdma:
 			/* vector side protocols to TCP */
 			ctx->flags |= NFS_MOUNT_TCP;
@@ -684,13 +684,13 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
 		case Opt_xprt_udp6:
 			mountfamily = AF_INET6;
-			/* fall through */
+			fallthrough;
 		case Opt_xprt_udp:
 			ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
 			break;
 		case Opt_xprt_tcp6:
 			mountfamily = AF_INET6;
-			/* fall through */
+			fallthrough;
 		case Opt_xprt_tcp:
 			ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
 			break;
@@ -899,9 +899,11 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 	ctx->version = NFS_DEFAULT_VERSION;
 	switch (data->version) {
 	case 1:
-		data->namlen = 0; /* fall through */
+		data->namlen = 0;
+		fallthrough;
 	case 2:
-		data->bsize = 0; /* fall through */
+		data->bsize = 0;
+		fallthrough;
 	case 3:
 		if (data->flags & NFS_MOUNT_VER3)
 			goto out_no_v3;
@@ -909,14 +911,14 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 		memcpy(data->root.data, data->old_root.data, NFS2_FHSIZE);
 		/* Turn off security negotiation */
 		extra_flags |= NFS_MOUNT_SECFLAVOUR;
-		/* fall through */
+		fallthrough;
 	case 4:
 		if (data->flags & NFS_MOUNT_SECFLAVOUR)
 			goto out_no_sec;
-		/* fall through */
+		fallthrough;
 	case 5:
 		memset(data->context, 0, sizeof(data->context));
-		/* fall through */
+		fallthrough;
 	case 6:
 		if (data->flags & NFS_MOUNT_VER3) {
 			if (data->root.size > NFS3_FHSIZE || data->root.size == 0)
diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index 26c94b32d6f4..c6c863382f37 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -108,7 +108,7 @@ struct posix_acl *nfs3_get_acl(struct inode *inode, int type)
 		case -EPROTONOSUPPORT:
 			dprintk("NFS_V3_ACL extension not supported; disabling\n");
 			server->caps &= ~NFS_CAP_ACLS;
-			/* fall through */
+			fallthrough;
 		case -ENOTSUPP:
 			status = -EOPNOTSUPP;
 		default:
@@ -228,7 +228,7 @@ static int __nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 			dprintk("NFS_V3_ACL SETACL RPC not supported"
 					"(will not retry)\n");
 			server->caps &= ~NFS_CAP_ACLS;
-			/* fall through */
+			fallthrough;
 		case -ENOTSUPP:
 			status = -EOPNOTSUPP;
 	}
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index a33970765467..fdfc77486ace 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -211,7 +211,7 @@ static loff_t nfs4_file_llseek(struct file *filep, loff_t offset, int whence)
 		ret = nfs42_proc_llseek(filep, offset, whence);
 		if (ret != -ENOTSUPP)
 			return ret;
-		/* Fall through */
+		fallthrough;
 	default:
 		return nfs_file_llseek(filep, offset, whence);
 	}
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 1e7296395d71..62e6eea5c516 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -520,7 +520,7 @@ static int nfs_idmap_prepare_message(char *desc, struct idmap *idmap,
 	switch (token) {
 	case Opt_find_uid:
 		im->im_type = IDMAP_TYPE_USER;
-		/* Fall through */
+		fallthrough;
 	case Opt_find_gid:
 		im->im_conv = IDMAP_CONV_NAMETOID;
 		ret = match_strlcpy(im->im_name, &substr, IDMAP_NAMESZ);
@@ -528,7 +528,7 @@ static int nfs_idmap_prepare_message(char *desc, struct idmap *idmap,
 
 	case Opt_find_user:
 		im->im_type = IDMAP_TYPE_USER;
-		/* Fall through */
+		fallthrough;
 	case Opt_find_group:
 		im->im_conv = IDMAP_CONV_IDTONAME;
 		ret = match_int(&substr, &im->im_id);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dbd01548335b..f8946b9468ef 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -483,7 +483,7 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 						stateid);
 				goto wait_on_recovery;
 			}
-			/* Fall through */
+			fallthrough;
 		case -NFS4ERR_OPENMODE:
 			if (inode) {
 				int err;
@@ -534,10 +534,10 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 				ret = -EBUSY;
 				break;
 			}
-			/* Fall through */
+			fallthrough;
 		case -NFS4ERR_DELAY:
 			nfs_inc_server_stats(server, NFSIOS_DELAY);
-			/* Fall through */
+			fallthrough;
 		case -NFS4ERR_GRACE:
 		case -NFS4ERR_LAYOUTTRYLATER:
 		case -NFS4ERR_RECALLCONFLICT:
@@ -1505,7 +1505,7 @@ static int can_open_delegated(struct nfs_delegation *delegation, fmode_t fmode,
 	case NFS4_OPEN_CLAIM_PREVIOUS:
 		if (!test_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags))
 			break;
-		/* Fall through */
+		fallthrough;
 	default:
 		return 0;
 	}
@@ -2439,7 +2439,7 @@ static void nfs4_open_prepare(struct rpc_task *task, void *calldata)
 	case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
 	case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
 		data->o_arg.open_bitmap = &nfs4_open_noattr_bitmap[0];
-		/* Fall through */
+		fallthrough;
 	case NFS4_OPEN_CLAIM_FH:
 		task->tk_msg.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_OPEN_NOATTR];
 	}
@@ -3545,11 +3545,11 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 			nfs4_free_revoked_stateid(server,
 					&calldata->arg.stateid,
 					task->tk_msg.rpc_cred);
-			/* Fallthrough */
+			fallthrough;
 		case -NFS4ERR_BAD_STATEID:
 			if (calldata->arg.fmode == 0)
 				break;
-			/* Fallthrough */
+			fallthrough;
 		default:
 			task->tk_status = nfs4_async_handle_exception(task,
 					server, task->tk_status, &exception);
@@ -6294,7 +6294,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 		nfs4_free_revoked_stateid(data->res.server,
 				data->args.stateid,
 				task->tk_msg.rpc_cred);
-		/* Fallthrough */
+		fallthrough;
 	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_STALE_STATEID:
 	case -ETIMEDOUT:
@@ -6314,7 +6314,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 			data->res.fattr = NULL;
 			goto out_restart;
 		}
-		/* Fallthrough */
+		fallthrough;
 	default:
 		task->tk_status = nfs4_async_handle_exception(task,
 				data->res.server, task->tk_status,
@@ -6622,13 +6622,13 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
 			if (nfs4_update_lock_stateid(calldata->lsp,
 					&calldata->res.stateid))
 				break;
-			/* Fall through */
+			fallthrough;
 		case -NFS4ERR_ADMIN_REVOKED:
 		case -NFS4ERR_EXPIRED:
 			nfs4_free_revoked_stateid(calldata->server,
 					&calldata->arg.stateid,
 					task->tk_msg.rpc_cred);
-			/* Fall through */
+			fallthrough;
 		case -NFS4ERR_BAD_STATEID:
 		case -NFS4ERR_STALE_STATEID:
 			if (nfs4_sync_lock_stateid(&calldata->arg.stateid,
@@ -8665,7 +8665,7 @@ static void nfs4_get_lease_time_done(struct rpc_task *task, void *calldata)
 		dprintk("%s Retry: tk_status %d\n", __func__, task->tk_status);
 		rpc_delay(task, NFS4_POLL_RETRY_MIN);
 		task->tk_status = 0;
-		/* fall through */
+		fallthrough;
 	case -NFS4ERR_RETRY_UNCACHED_REP:
 		rpc_restart_call_prepare(task);
 		return;
@@ -9113,13 +9113,13 @@ static int nfs41_reclaim_complete_handle_errors(struct rpc_task *task, struct nf
 	switch(task->tk_status) {
 	case 0:
 		wake_up_all(&clp->cl_lock_waitq);
-		/* Fallthrough */
+		fallthrough;
 	case -NFS4ERR_COMPLETE_ALREADY:
 	case -NFS4ERR_WRONG_CRED: /* What to do here? */
 		break;
 	case -NFS4ERR_DELAY:
 		rpc_delay(task, NFS4_POLL_RETRY_MAX);
-		/* fall through */
+		fallthrough;
 	case -NFS4ERR_RETRY_UNCACHED_REP:
 		return -EAGAIN;
 	case -NFS4ERR_BADSESSION:
@@ -9434,10 +9434,10 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 					&lrp->args.range,
 					lrp->args.inode))
 			goto out_restart;
-		/* Fallthrough */
+		fallthrough;
 	default:
 		task->tk_status = 0;
-		/* Fallthrough */
+		fallthrough;
 	case 0:
 		break;
 	case -NFS4ERR_DELAY:
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index b1dba24918f8..4bf10792cb5b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1530,7 +1530,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
 		default:
 			pr_err("NFS: %s: unhandled error %d\n",
 					__func__, status);
-			/* Fall through */
+			fallthrough;
 		case -ENOMEM:
 		case -NFS4ERR_DENIED:
 		case -NFS4ERR_RECLAIM_BAD:
@@ -1667,7 +1667,7 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 				break;
 			}
 			printk(KERN_ERR "NFS: %s: unhandled error %d\n", __func__, status);
-			/* Fall through */
+			fallthrough;
 		case -ENOENT:
 		case -ENOMEM:
 		case -EACCES:
@@ -1683,7 +1683,7 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 				set_bit(ops->state_flag_bit, &state->flags);
 				break;
 			}
-			/* Fall through */
+			fallthrough;
 		case -NFS4ERR_ADMIN_REVOKED:
 		case -NFS4ERR_STALE_STATEID:
 		case -NFS4ERR_OLD_STATEID:
@@ -1695,7 +1695,7 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 		case -NFS4ERR_EXPIRED:
 		case -NFS4ERR_NO_GRACE:
 			nfs4_state_mark_reclaim_nograce(sp->so_server->nfs_client, state);
-			/* Fall through */
+			fallthrough;
 		case -NFS4ERR_STALE_CLIENTID:
 		case -NFS4ERR_BADSESSION:
 		case -NFS4ERR_BADSLOT:
@@ -2273,11 +2273,11 @@ int nfs4_discover_server_trunking(struct nfs_client *clp,
 	case -ETIMEDOUT:
 		if (clnt->cl_softrtry)
 			break;
-		/* Fall through */
+		fallthrough;
 	case -NFS4ERR_DELAY:
 	case -EAGAIN:
 		ssleep(1);
-		/* Fall through */
+		fallthrough;
 	case -NFS4ERR_STALE_CLIENTID:
 		dprintk("NFS: %s after status %d, retrying\n",
 			__func__, status);
@@ -2289,7 +2289,7 @@ int nfs4_discover_server_trunking(struct nfs_client *clp,
 		}
 		if (clnt->cl_auth->au_flavor == RPC_AUTH_UNIX)
 			break;
-		/* Fall through */
+		fallthrough;
 	case -NFS4ERR_CLID_INUSE:
 	case -NFS4ERR_WRONGSEC:
 		/* No point in retrying if we already used RPC_AUTH_UNIX */
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6ea4cac41e46..6985cacf4700 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -711,7 +711,7 @@ static void nfs_pgio_rpcsetup(struct nfs_pgio_header *hdr,
 	case FLUSH_COND_STABLE:
 		if (nfs_reqs_to_commit(cinfo))
 			break;
-		/* fall through */
+		fallthrough;
 	default:
 		hdr->args.stable = NFS_FILE_SYNC;
 	}
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 40332c758d84..71f7741126b6 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1541,7 +1541,7 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 	case 0:
 		if (res->lrs_present)
 			res_stateid = &res->stateid;
-		/* Fallthrough */
+		fallthrough;
 	default:
 		arg_stateid = &args->stateid;
 	}
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7a70287f21a2..d20326ee0475 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -889,7 +889,7 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 		default:
 			if (rpcauth_get_gssinfo(flavor, &info) != 0)
 				continue;
-			/* Fallthrough */
+			fallthrough;
 		}
 		dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
 		ctx->selected_flavor = flavor;
-- 
2.19.1

