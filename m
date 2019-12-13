Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE211E545
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfLMOLD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:03 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:45803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfLMOLD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MO9qz-1iLjfE1Is5-00OVdn; Fri, 13 Dec 2019 15:10:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 09/12] nfsd: fix jiffies/time_t mixup in LRU list
Date:   Fri, 13 Dec 2019 15:10:43 +0100
Message-Id: <20191213141046.1770441-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RFuOm2jAOCBiUoXlcDVvCUpmtQ/EOsE27v8hWd2SPEDQBW1MVji
 F20sBMDqnoDPPoQR3UwHCy/qExcLtPGSC0zhgPPoacYANfEO0BM+cFNtUO39R+nniEFCvBZ
 0vLjHqwoptxwnSOyc8O+ofFbLlZuGdwVfar9RmTj5Jqr9NXtOr7H0ORBwlnxhkqpm+i5vBc
 V2a+eqY0MgrkZ3mjf4+Zg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/UJVsafxFSg=:Y4ga6FSx7qvpwzE042pdFW
 nHzm568/bjSOtNM3soyeFV02GfMcErPlxHw0/MfcTiKPwvjl2kkgspCHFVFXg+7/Je1S/H4mM
 rPYIKoouGVczC+4S56Et4qsP8WXxfzlipZ4SJkiELqDl6eb6+El8v1Uko5qek/npGIRsdSnt6
 IrHYw1AinWZMoGf/rDw6Ngnu5CYJTeApgfuwA5wEiLDDzuZuptGI3ILthuJpWbxaTfqKtl9kC
 LTh45DFhs/FM0dtsQhevr8V9rGrplekeI1/Qc33aRGHbd8s3ecyUaHjEMNtR6aed9ob9GQunC
 y1w9XFb3DBEDfcEFqgLdy8AVRMxStRgS2I3fzDILpo5BeDEyhXDZo+XFu1dfcbATh66+DTC4t
 k3I8XEAeiibrm7GHdwxMYrGAKjb6wjkLX2WswG+US/bJWrq+WdBZgWcMXbu9mHUjaHCa5+mf9
 bPYQiSYIEr3VQr4G9qSXjWY1el9D8qTAti3zaV2Io3t44t0RbLFGL36NWieKADpKha6fv7aia
 l94qnerKOBVrbZRX8dfHxTIhMcmLwTitNJnt/0bqniD/dPddUefOzvhwPrKKBzOy73G/6Gf8W
 xK5+NwoNua0R4f0uh5LAVA7EgUeAFgej6hdX8xuwqSQ6lxH6Amy5BpS8vNjJbsFYByG0Noii2
 VniQCnoU/q+bnfa6qV4t0mOJ4neo1rxcaJgpheb51U2Gml0pmw+2w3e2YdMQvxP9F8zj6IquR
 CKZFWDn2aUFJPcDu9GfN0yZn2sXyVqFyuGgCBILMFwyOJhltZ18h+ANJxR34iIplBFk96ZV1z
 lsvol/QnE9t88BLt/vNZmiBEXFG9BSTw0kfgL5TNdRSza69lkUOqjZTql50g4+qCjpm2o5TH3
 1YrHNuuBy5tUvhDoJYuA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfsd4_blocked_lock->nbl_time timestamp is recorded in jiffies,
but then compared to a CLOCK_REALTIME timestamp later on, which makes
no sense.

For consistency with the other timestamps, change this to use a time_t.

This is a change in behavior, which may cause regressions, but the
current code is not sensible. On a system with CONFIG_HZ=1000,
the 'time_after((unsigned long)nbl->nbl_time, (unsigned long)cutoff))'
check is false for roughly the first 18 days of uptime and then true
for the next 49 days.

Fixes: 7919d0a27f1e ("nfsd: add a LRU list for blocked locks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4state.c | 2 +-
 fs/nfsd/state.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5cb0f774218a..9a063c4b4460 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6549,7 +6549,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	if (fl_flags & FL_SLEEP) {
-		nbl->nbl_time = jiffies;
+		nbl->nbl_time = get_seconds();
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
 		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 2b4165cd1d3e..03fc7b4380f9 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -606,7 +606,7 @@ static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
 struct nfsd4_blocked_lock {
 	struct list_head	nbl_list;
 	struct list_head	nbl_lru;
-	unsigned long		nbl_time;
+	time_t			nbl_time;
 	struct file_lock	nbl_lock;
 	struct knfsd_fh		nbl_fh;
 	struct nfsd4_callback	nbl_cb;
-- 
2.20.0

