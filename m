Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5314611E542
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfLMOLC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:02 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:51747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfLMOLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Macaw-1i84Sj1p7K-00cCpo; Fri, 13 Dec 2019 15:10:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 01/12] nfsd: use ktime_get_seconds() for timestamps
Date:   Fri, 13 Dec 2019 15:10:35 +0100
Message-Id: <20191213141046.1770441-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UIf61Zh2SX1jsmuKNONn62q4e8CIE4uEXBXf6f109VVpmdYXULw
 3DDB1afIxbPSigzPGj4zKy84ctp9G2LWRCnmiNkIqoV6z5Zbzp4ZaEjYXMvt/KdlcGScd85
 CvkPLmDDRNSKusXQV1jFQnVyNcrmpdXyPhhO1iLZNoX7r3RHZmLXwh42dFUClt6jlfW3gB+
 5LDOGbPnVIvJ/6UhqWWXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hp6SY27GsDo=:roxwhEgFNjaSqv9qD56rYs
 aKJi8HwFgh2nqNbgz5XSZIExntsuKjtyQV+V3MTihNeQCpjp7o6Q3uLQlU4QxgXUoQlzEH6Hl
 xdCdnZbd6z/CSE+NEA1fax+01ClDVcAVCX2KK/ITYYl9A22DQsZTooCPJ5uURpq6nVgYjoT5T
 oWamxoH9qYQKdMoX0Gb8/LL/HbEot/xISWlkhaK2D5AmUTmpdrHL1MPp9bnFgL/P2JgNzzGRN
 R+6Fy7d5axn77UC/DPyufnXcDXljXR+GSe28AmWxFbvZZwmNY3WP23O0FmEP4M2+kj4hx5jhn
 O0e38IzmBWN492S5t5jfyRSWQk7Uaj9lbYh2tOPK+q1i5aFHAY2clTtEFY+798kvSkuCvzOy0
 DayV7c8o2tLzxKV7Sko6HAZ6EHE9kIJJwnT6tnPPLA7Mtza873EHnIFrHBDJ4UD49vTpNUCNS
 rFbLRdo9u4N+xk3PImvMw/5WzjFV1ejMQ3OqSboFF6SLl+9v0fIu9yH433WDyxX61flR5hsr2
 iz4TIaLPctcgTKC7nSiENvssIXEGbbRsC6StTNtwNC7Q39A2WZJwm6Nt2kn+HpkFbvBZnWGEN
 F0apOSYVE6Aib+6kx+2vTl8k7Go7hmQYhvDs3KZLsCV60i3BmykzAMGPUDzN65IM9jYu9djxb
 h+m0PpeJTeQqIo8i5m1U0f8hsuiIyrMjU3JLsDz40z81LL1dt8Ena7vorRoWKTbTU4Li9Eu7o
 aKqSlY6f5QnHdMiFro7PsgvqmvyzgSRz2q9EVhC0AJbZ+acBeieEWf0XIkp7eiayxYPK89mbr
 L9LP0NJAi0/Spg0XZCgRYgCCk8KjPO1ovkUILkg41wtdDR47/EuSvphRALTvCMQgPUDbINiHZ
 v8K4a5MueHJWbKn6X0kg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The delegation logic in nfsd uses the somewhat inefficient
seconds_since_boot() function to record time intervals.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 369e574c5092..bfdb3366239c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -806,7 +806,7 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
 static DEFINE_SPINLOCK(blocked_delegations_lock);
 static struct bloom_pair {
 	int	entries, old_entries;
-	time_t	swap_time;
+	time64_t swap_time;
 	int	new; /* index into 'set' */
 	DECLARE_BITMAP(set[2], 256);
 } blocked_delegations;
@@ -818,15 +818,15 @@ static int delegation_blocked(struct knfsd_fh *fh)
 
 	if (bd->entries == 0)
 		return 0;
-	if (seconds_since_boot() - bd->swap_time > 30) {
+	if (ktime_get_seconds() - bd->swap_time > 30) {
 		spin_lock(&blocked_delegations_lock);
-		if (seconds_since_boot() - bd->swap_time > 30) {
+		if (ktime_get_seconds() - bd->swap_time > 30) {
 			bd->entries -= bd->old_entries;
 			bd->old_entries = bd->entries;
 			memset(bd->set[bd->new], 0,
 			       sizeof(bd->set[0]));
 			bd->new = 1-bd->new;
-			bd->swap_time = seconds_since_boot();
+			bd->swap_time = ktime_get_seconds();
 		}
 		spin_unlock(&blocked_delegations_lock);
 	}
@@ -856,7 +856,7 @@ static void block_delegations(struct knfsd_fh *fh)
 	__set_bit((hash>>8)&255, bd->set[bd->new]);
 	__set_bit((hash>>16)&255, bd->set[bd->new]);
 	if (bd->entries == 0)
-		bd->swap_time = seconds_since_boot();
+		bd->swap_time = ktime_get_seconds();
 	bd->entries += 1;
 	spin_unlock(&blocked_delegations_lock);
 }
-- 
2.20.0

