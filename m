Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4525111E552
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfLMOL2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:28 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:57525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfLMOLD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFbeI-1iVKSE1XmY-00H7do; Fri, 13 Dec 2019 15:10:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 05/12] nfsd: make 'boot_time' 64-bit wide
Date:   Fri, 13 Dec 2019 15:10:39 +0100
Message-Id: <20191213141046.1770441-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ulRRllI5JAoz0buK11S43JXVc/eMQFrIawurypLyW+N7TiEk0dp
 sYPiQy6yvK8EGQIpnFN2TTwvGPPXkdo/AQIl7S/SrZCuD2WGshTS2C4G8EUX49W4DwNDUtD
 L88/4+GwzL6UsguMBy6RERpwuy6IQumqGgXy6L+iDb2UHPXPwa2X8rChSWR1KTjzHVNkC34
 OvnVT8pX39Yg9x925DqbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NcumhT8wISM=:JBOSCdGfsCAdWOIW+bnrHA
 QA4UJlzwE2vocoKnX7UialKPo/que+qGW7+EHoXxQ3MzakMVSf3MRYQW+Zlmh0kCKxlHkkV7d
 Hsewp+K2GVG9yoCqQEdlG0WETcBZNX16d1xB/y/0Y8/2AJc03sSMK7pkikjEkHmIbHitedOJQ
 EKABeWyDYp2cY+0uZLzplYYk/1tD3AnlejEyRaRqXOxLorSlGseUIXdMv+IHto94Zrv5mE3/h
 KDxq/7bWkpGoaZbQZa3yv2htZBQ9sAPIQYJBuOAY/FpDtQaWxVKCb9nF2PiCzc4lm2jbQjYKs
 jimwDA6j11Wa7kHmY8okBNaxsHNH+0wJZr9+BulTs2I1cHCGCL+Rzi/l6nYfTqAmbQEcKDZMf
 809SjF50j+Xt9lsK3xhP4QfmwJDThcv2i+zhkmzoxxOyqiZV9/AdU5CVF3C6MeUa6EfZtt68d
 fBPyd9O/BOWiIX8br0c0LGWNStaj5Azfprth2wX+7ikjC9Ws8cOWYQMHxFUUzVCtPcwIFb6A/
 83a/4ae5n/RVimEcQW+iGZKvzSaxRxjNYXPUtj45wNuhIpP/YTozGnuDVpGrvIV1Wsd0NAfL4
 3n2xbxp4Vnqjq73aC7aoVn94SFKdcZtjg/JblwQQn4BHE4bj17s/xFYeuiQ4h/lMouLFm5BMo
 kYOM3Ckbfj9wjCq9yzLCUDtFuzj1GGcqVeM4i3JLAzR71Ox5HzLU/xK3jCD/3J8hDmjyw+hvS
 ysxVWEPsEW+RnFBu5Yvw9ANGOES60kgcfd+lh89NUBlF+fDtKB3bg97+5ElTjpdPze2sN9LaK
 Bni5z1+PV0BVYjZ4U2olawi3BAss6zIQudiitpcdSo/23lXCtKNY2xjswb6JP+J40Jn41eufB
 i1sS34VdQdTMvRMNDSgg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The local boot time variable gets truncated to time_t at the moment,
which can lead to slightly odd behavior on 32-bit architectures.

Use ktime_get_real_seconds() instead of get_seconds() to always
get a 64-bit result, and keep it that way wherever possible.

It still gets truncated in a few places:

- When assigning to cl_clientid.cl_boot, this is already documented
  and is only used as a unique identifier.

- In clients_still_reclaiming(), the truncation is to 'unsigned long'
  in order to use the 'time_before() helper.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/netns.h       |  2 +-
 fs/nfsd/nfs4recover.c |  8 ++++----
 fs/nfsd/nfs4state.c   | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9a4ef815fb8c..29bbe28eda53 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -40,7 +40,7 @@ struct nfsd_net {
 
 	struct lock_manager nfsd4_manager;
 	bool grace_ended;
-	time_t boot_time;
+	time64_t boot_time;
 
 	/* internal mount of the "nfsd" pseudofilesystem: */
 	struct vfsmount *nfsd_mnt;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2481e7662128..a8fb18609146 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1445,7 +1445,7 @@ nfsd4_cld_grace_done_v0(struct nfsd_net *nn)
 	}
 
 	cup->cu_u.cu_msg.cm_cmd = Cld_GraceDone;
-	cup->cu_u.cu_msg.cm_u.cm_gracetime = (int64_t)nn->boot_time;
+	cup->cu_u.cu_msg.cm_u.cm_gracetime = nn->boot_time;
 	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
 	if (!ret)
 		ret = cup->cu_u.cu_msg.cm_status;
@@ -1782,7 +1782,7 @@ nfsd4_cltrack_client_has_session(struct nfs4_client *clp)
 }
 
 static char *
-nfsd4_cltrack_grace_start(time_t grace_start)
+nfsd4_cltrack_grace_start(time64_t grace_start)
 {
 	int copied;
 	size_t len;
@@ -1795,7 +1795,7 @@ nfsd4_cltrack_grace_start(time_t grace_start)
 	if (!result)
 		return result;
 
-	copied = snprintf(result, len, GRACE_START_ENV_PREFIX "%ld",
+	copied = snprintf(result, len, GRACE_START_ENV_PREFIX "%lld",
 				grace_start);
 	if (copied >= len) {
 		/* just return nothing if output was truncated */
@@ -2004,7 +2004,7 @@ nfsd4_umh_cltrack_grace_done(struct nfsd_net *nn)
 	char *legacy;
 	char timestr[22]; /* FIXME: better way to determine max size? */
 
-	sprintf(timestr, "%ld", nn->boot_time);
+	sprintf(timestr, "%lld", nn->boot_time);
 	legacy = nfsd4_cltrack_legacy_topdir();
 	nfsd4_umh_cltrack_upcall("gracedone", timestr, legacy, NULL);
 	kfree(legacy);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 27a629cc5a46..1ac431aa29c4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -753,7 +753,7 @@ int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
 	if (new_id < 0)
 		return 0;
 	copy->cp_stateid.si_opaque.so_id = new_id;
-	copy->cp_stateid.si_opaque.so_clid.cl_boot = nn->boot_time;
+	copy->cp_stateid.si_opaque.so_clid.cl_boot = (u32)nn->boot_time;
 	copy->cp_stateid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
 	return 1;
 }
@@ -1862,7 +1862,7 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
 	 */
 	if (clid->cl_boot == (u32)nn->boot_time)
 		return 0;
-	dprintk("NFSD stale clientid (%08x/%08x) boot_time %08lx\n",
+	dprintk("NFSD stale clientid (%08x/%08x) boot_time %08llx\n",
 		clid->cl_boot, clid->cl_id, nn->boot_time);
 	return 1;
 }
@@ -2222,7 +2222,7 @@ static void gen_confirm(struct nfs4_client *clp, struct nfsd_net *nn)
 
 static void gen_clid(struct nfs4_client *clp, struct nfsd_net *nn)
 {
-	clp->cl_clientid.cl_boot = nn->boot_time;
+	clp->cl_clientid.cl_boot = (u32)nn->boot_time;
 	clp->cl_clientid.cl_id = nn->clientid_counter++;
 	gen_confirm(clp, nn);
 }
@@ -5183,9 +5183,9 @@ nfsd4_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	unsigned long now = get_seconds();
-	unsigned long double_grace_period_end = nn->boot_time +
-						2 * nn->nfsd4_lease;
+	unsigned long now = (unsigned long) ktime_get_real_seconds();
+	unsigned long double_grace_period_end = (unsigned long)nn->boot_time +
+					   2 * (unsigned long)nn->nfsd4_lease;
 
 	if (nn->track_reclaim_completes &&
 			atomic_read(&nn->nr_reclaim_complete) ==
@@ -7640,7 +7640,7 @@ static int nfs4_state_create_net(struct net *net)
 		INIT_LIST_HEAD(&nn->sessionid_hashtbl[i]);
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
-	nn->boot_time = get_seconds();
+	nn->boot_time = ktime_get_real_seconds();
 	nn->grace_ended = false;
 	nn->nfsd4_manager.block_opens = true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
-- 
2.20.0

