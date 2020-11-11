Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6252AE4FE
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 01:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgKKAma (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 19:42:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731746AbgKKAma (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 19:42:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB0ZGhN016801;
        Wed, 11 Nov 2020 00:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=ac7TAgGN8Y2elDHJ6ZkEOyv0KYgVeytcsxvp5mX73CU=;
 b=CryRd6etV5ofkuWdgCl+d08qolkJphiN4IyB6TKMh5H14yvVufrWhjwsG+fzC+4D3t8l
 R+WReFwgOukqA+KvUIjTdDFr+KjihCfDHaeUOEkOVlmTPIYg7Vn1kpp0s7kmPxU40i0z
 AnFew8JcHp8x/Zc+VDkDSf1uqHeAX508Usnu8UDXsgBV0tFA13TW9dVrVoXrUMOQCAYm
 ExQGk2mSRzRS5A5DDNqn52dVpBfJB2N1tFyLllg+y02lNEoc3DjZEFW9Es4lU47iTsHt
 4B7WT9YRoGhYuIWBt+AK+5IlTJar+YgwU0+CpnKKjd3CeiUQ4RLTuhdBgcPI8537At4q 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72emv2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 00:42:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB0UCnA098134;
        Wed, 11 Nov 2020 00:40:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 34p5gxq4n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 00:40:25 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AB0ePuO131668;
        Wed, 11 Nov 2020 00:40:25 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 34p5gxq4mw-1;
        Wed, 11 Nov 2020 00:40:25 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Fix 5 seconds delay when doing inter server copy
Date:   Tue, 10 Nov 2020 19:40:03 -0500
Message-Id: <20201111004003.40823-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=3 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110001
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit b4868b44c5628, every inter server copy operation suffers
5 seconds delay regardless of the size of the copy. The delay is from
nfs_set_open_stateid_locked when the check by nfs_stateid_is_sequential
fails because the seqid in both nfs4_state and nfs4_stateid are 0. 

The nfs_stateid_is_sequential is the new replacement for the old
nfs_need_update_open_stateid check.

Fix by modifying the source server to return the stateid for COPY_NOTIFY
request with seqid 1 instead of 0. This is also to conform with section
4.8 of RFC 7682. And on the destination server, delaying the setting of
NFS_OPEN_STATE in nfs4_state to indicate this is the 1st open to pass
the check by nfs_stateid_is_sequential.

Here is the relevant paragraph from section 4.8 of RFC 7682:

   A copy offload stateid's seqid MUST NOT be zero.  In the context of a
   copy offload operation, it is inappropriate to indicate "the most
   recent copy offload operation" using a stateid with a seqid of zero
   (see Section 8.2.2 of [RFC5661]).  It is inappropriate because the
   stateid refers to internal state in the server and there may be
   several asynchronous COPY operations being performed in parallel on
   the same file by the server.  Therefore, a copy offload stateid with
   a seqid of zero MUST be considered invalid.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

---
 fs/nfs/nfs4file.c   | 2 +-
 fs/nfsd/nfs4state.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 9d354de613da..57b3821d975a 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -377,10 +377,10 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		goto out_stateowner;
 
 	set_bit(NFS_SRV_SSC_COPY_STATE, &ctx->state->flags);
-	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
 	memcpy(&ctx->state->open_stateid.other, &stateid->other,
 	       NFS4_STATEID_OTHER_SIZE);
 	update_open_stateid(ctx->state, stateid, NULL, filep->f_mode);
+	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
 
 	nfs_file_set_open_context(filep, ctx);
 	put_nfs_open_context(ctx);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d7f27ed6b794..33ee1a6961e3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -793,6 +793,7 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 	refcount_set(&cps->cp_stateid.sc_count, 1);
 	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
 		goto out_free;
+	cps->cp_stateid.stid.si_generation = 1;
 	spin_lock(&nn->s2s_cp_lock);
 	list_add(&cps->cp_list, &p_stid->sc_cp_list);
 	spin_unlock(&nn->s2s_cp_lock);
-- 
2.9.5

