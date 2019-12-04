Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F0112401
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 08:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLDH7y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 02:59:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34506 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDH7x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 02:59:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB47sr8q117706;
        Wed, 4 Dec 2019 07:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=S+a60UhzqPZZ9k0O1/DfrG9ejLDvOQnagDFsObBPjag=;
 b=OvTU3F8FzIlNz7ikZCdfMRejlTqq0PzNhdTOghkO/Ts7ZyOkmxSkg7oUdbicu9k7x170
 v8Gk7fcv6qlunP/AyTumcIgroPGS4BSiPQAb4+wel2Il3g2joZ0iTdWQpptcQonhN3HF
 b3E5GrDIzRfc3LUafA6yV/RsKwvaOokdO4dWCe3pH0G782TbrX0monBZhalIwKgCp2PI
 jm8shve+cWq/AMzkU+G9vltoKDcUVP8EkUkUi650gPrOmKL3e8aBt2TyNuDqPrdcV2NM
 rB/Bc2wGUATNpkYB7Tc8+CAUuI1WbriDun+5W5hlwZAjY/oDilGQiZINMoGDAU3IqK84 qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wkh2rcj5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 07:59:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB47wawv106584;
        Wed, 4 Dec 2019 07:59:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wp209n134-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 07:59:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB47xhQ7006197;
        Wed, 4 Dec 2019 07:59:44 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 23:59:43 -0800
Date:   Wed, 4 Dec 2019 10:59:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] nfsd: unlock on error in manage_cpntf_state()
Message-ID: <20191204075935.sgdcxib4jahd5blr@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040058
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We are holding the "nn->s2s_cp_lock" so we can't return directly
without unlocking first.

Fixes: f3dee17721a0 ("NFSD check stateids against copy stateids")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/nfsd/nfs4state.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 296765e693d0..390ad454a229 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5695,13 +5695,16 @@ __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 	if (cps_t) {
 		state = container_of(cps_t, struct nfs4_cpntf_state,
 				     cp_stateid);
-		if (state->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID)
-			return nfserr_bad_stateid;
+		if (state->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID) {
+			state = NULL;
+			goto unlock;
+		}
 		if (!clp)
 			refcount_inc(&state->cp_stateid.sc_count);
 		else
 			_free_cpntf_state_locked(nn, state);
 	}
+unlock:
 	spin_unlock(&nn->s2s_cp_lock);
 	if (!state)
 		return nfserr_bad_stateid;
-- 
2.11.0

