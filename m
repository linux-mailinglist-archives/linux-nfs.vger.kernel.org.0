Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD947DBF03
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 18:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjJ3RdG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 13:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjJ3RdF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 13:33:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290AC4;
        Mon, 30 Oct 2023 10:33:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C874C433C8;
        Mon, 30 Oct 2023 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698687181;
        bh=NmBMUZ0aub9K48dR63VKdL58hnY2i/0sav/2YAAE35U=;
        h=From:Date:Subject:To:Cc:From;
        b=k8D7hDd/jRRDxRUikY75NK4PT5NJhZ/JiMopIn/+4CIsU1/N56OAa8sJnbV8ozULt
         l4IUAHFIiYMiCFgedv+jMf7KNxpdMyuoXrbbjlvYcNw8PtPACykq89SBaE116KHjP+
         ZJeBR2nXRHXLw3Y8tSR0N9yGINbTCSWeo6zoIM5IFNHu8luS0308YpF3Gtk4bGNF5P
         ZZYdIM0vlTuVH9XqDSg0lpZC6kDeih5Z108J1xlE/sJn+iKz4+J0WJSGTcGQcDprN8
         DfQw9Bhe3VhdFK1BRbIRWO7rac35BLD8sO0HFkduXt/BnyB/fz0thsGs5TqiS0THlM
         Dz/Gy0fSLEtnw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 30 Oct 2023 13:32:54 -0400
Subject: [PATCH RFC] nfsd: fix error handling in nfsd_svc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-kdevops-v1-1-bae6baf62c69@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMXoP2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA2MD3eyU1LL8gmJd0zRzYzMzC0vz1DQTJaDqgqLUtMwKsEnRSkFuzkq
 xtbUAjF+kFl4AAAA=
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2391; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NmBMUZ0aub9K48dR63VKdL58hnY2i/0sav/2YAAE35U=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlP+jMieljdWA7oHspQdewsswpVd+f8UwiG+n1y
 ZIOVFya9s+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZT/ozAAKCRAADmhBGVaC
 FdeTD/0cUpezDGAcWntDUPpmiPKDSMP0JDjOOjg1nZH/FLgYmNnXxGcmyPoLkd1bljXM1mIhCMo
 mUP/N41fq6xkawH6x4GI4FBxDcdESCgPXmbM8x8KecHWHzAzN/ILD5KJrD6OwUjRTd1ekE8F20p
 3slYBEjrDLH2BBeNQP2V8JxU31wyOC2y83SiGU9/kLzQTrTjbxRCVfzP5CjgGarYQEE7QxYlxJK
 zZkpV4C6bISQ+OaaXlKStvmzKuEV6ArwO2AB4YuRooh/hYxwzdwUU8z/3omEm/moGsE3Q4oN1rF
 TmE0LH7zTlypSFTjGstS4JaHAXeRZAUDL4MLI0rk8ncAo6SmIqFBM0oMoQ/tDLEtqO/hYmbqrqh
 AulROmOxJHXxF2/qLsSHgkq1T1dLXtbPvSQEkPwG8x+6hti7f0g1egisuDn5drEMVVUt1PiKRW4
 bRrjPCJC1t1GyO6DK6QE+nhqY8PYNeJ/2U3catucMquw7s5EYqHaM04VnvGvp5e9027vcjTIrms
 RALPlyQMkiX8+Vmt0oIiiz7uNvaHiiqbXpyxvDt2LgYTJwguVyPaKMF+asYd0vpdfBt00NqdrdO
 Nq8rra1LEJ7ua9hRtBAwFA1yYcPRRz6zPCUo3hMSqlc6mZ66T0sbRbvzYTfDUWb0uT23arDI20t
 9XDU0hItO9deQdw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Once we've set the nfsd_serv pointer in nfsd_svc, we still need to call
nfsd_last_thread if the server fails to be started. Remove the special
casing for nfsd_up_before case since shutting down the per-net stuff is
also handled by nfsd_last_thread.

Finally, add a new special case at the start and skip doing anything if
the service already exists, 0 threads were requested and
serv->sv_nrthreads is 0.

Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
Reported-by: Zhi Li <yieli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Here's what I was thinking for a targeted patch for stable. Testing it
now, but I won't have results until tomorrow.
---
 fs/nfsd/nfssvc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3deef000afa9..187b68769815 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -787,7 +787,6 @@ int
 nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 {
 	int	error;
-	bool	nfsd_up_before;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
@@ -797,8 +796,9 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	nrservs = max(nrservs, 0);
 	nrservs = min(nrservs, NFSD_MAXSERVS);
 	error = 0;
+	serv = nn->nfsd_serv;
 
-	if (nrservs == 0 && nn->nfsd_serv == NULL)
+	if (nrservs == 0 && (serv == NULL || serv->sv_nrthreads == 0))
 		goto out;
 
 	strscpy(nn->nfsd_name, utsname()->nodename,
@@ -808,22 +808,17 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	if (error)
 		goto out;
 
-	nfsd_up_before = nn->nfsd_net_up;
 	serv = nn->nfsd_serv;
 
 	error = nfsd_startup_net(net, cred);
 	if (error)
 		goto out_put;
 	error = svc_set_num_threads(serv, NULL, nrservs);
-	if (error)
-		goto out_shutdown;
-	error = serv->sv_nrthreads;
 	if (error == 0)
-		nfsd_last_thread(net);
-out_shutdown:
-	if (error < 0 && !nfsd_up_before)
-		nfsd_shutdown_net(net);
+		error = serv->sv_nrthreads;
 out_put:
+	if (serv->sv_nrthreads == 0)
+		nfsd_last_thread(net);
 	/* Threads now hold service active */
 	if (xchg(&nn->keep_active, 0))
 		svc_put(serv);

---
base-commit: 31b5a36c4b88b44c91cdd523997b1e86fb47339d
change-id: 20231030-kdevops-5f7366897ef4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

