Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C613811E54A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfLMOLK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:10 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:50571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfLMOLE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:04 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MK3eI-1iQyrf475S-00LVMW; Fri, 13 Dec 2019 15:10:58 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 12/12] nfsd: remove nfs4_reset_lease() declarations
Date:   Fri, 13 Dec 2019 15:10:46 +0100
Message-Id: <20191213141046.1770441-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZKDoE9QgssUEaF4ESIVfDgM6JJvUm/C6dyGIwg+yexjRBcXrUwm
 hst4t6IX7xAaZVaj/pOiP9MP7i6dIkJDNDt0a+FHxmxT1X1k0C+p7+Ws/qj5gef0dozZQ2B
 qLHaEEbKkSXSec+anp6BztnEkbxv1Wa6tunbyUd/NoOGcetuTEK04Q4jFRbxBLBGjRvm0ZS
 GLiZZqTHprSm8m6ItitfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IbM7yEiXipE=:6X7jwtgzmmb9MKvUnt9E0Y
 dXCOBP06ZrqB3cgtvswg5L3oHYNBYrspPiM5rwALF0quasoWzYagSSjZvX3QErsP9Vx8sgm65
 tJaji1xG9BMEWCKqmG70OGUBdqpeQ/qpwZxrDUaQA+R1vsFZMAH7IsmVYGkbWUjhgysRlfAhQ
 G+xxqSEMW3S4xlbBmU4RXsk2BImOt5aXmPQzIiS7ej8VDcXcUqds5+WAw2dyQuZvVWnQCGP7f
 BPO94IBvxRPFgAMVtN83yhn4tZQ4L6TWg9u7aGwwRh0vvrxuK/sX7T0SEJK9ELGCzJ9uzhKug
 ZY98E1SQWDUs0WWHh+EwsXYqqda/S1BMTuoX7elPUQnsf6DQKnK9T5KyiiOq5YhhEUJ25Mgd+
 +FSswh/Y7xq4hIYXtvBn51twcQLK/QZCzRGBj/q378QlvI1gcgz/Rd2eBJT9lLvtG3wnveyJJ
 53TSww8LgvMndlhYIo/CNyXRByQva8XaP8+ICFcLaFCNvZ94+Ew0ljzaPIW8uXZRTOVxcTgRB
 tb4QHALggAbZSCmo173owo3uK8H9pDr3EXMVlwfqwrpgfAbggI4CQ57nNAVrrUMu1plgiP7+i
 +LdKRuwTf8/8NbROdhVM21An1ZI4nRsUpeFTnh3f/dT5yNyWvN0iFXXhsxLwz2qbnNMBwo1I7
 Zj8LnQ18TZRjDYUZCgeR45eMpVjv8ci6V4T+m0qKZtzlJgF9ddI5zYdtp7+RJfuhKP2YPwgYM
 WCcWPJtuqJwqdI8UQf3cHDhRbtrhzi3UcYaWURXNINhjeId5TP7GqLjCowkYa3dBFuMa3v+at
 o5/9enAVhBgXv+5ElFYeBya0gx4RRb7cydfpDC3mgU77gMWJ7g9gtiQXxzB9Czm1HRU42NvK/
 Vp3PRn1kosvqocOoocrg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The function was removed a long time ago, but the declaration
and a dummy implementation are still there, referencing the
deprecated time_t type.

Remove both.

Fixes: f958a1320ff7 ("nfsd4: remove unnecessary lease-setting function")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfsd.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 57b93d95fa5c..31f152bbbb2f 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -142,7 +142,6 @@ int nfs4_state_start(void);
 int nfs4_state_start_net(struct net *net);
 void nfs4_state_shutdown(void);
 void nfs4_state_shutdown_net(struct net *net);
-void nfs4_reset_lease(time_t leasetime);
 int nfs4_reset_recoverydir(char *recdir);
 char * nfs4_recoverydir(void);
 bool nfsd4_spo_must_allow(struct svc_rqst *rqstp);
@@ -153,7 +152,6 @@ static inline int nfs4_state_start(void) { return 0; }
 static inline int nfs4_state_start_net(struct net *net) { return 0; }
 static inline void nfs4_state_shutdown(void) { }
 static inline void nfs4_state_shutdown_net(struct net *net) { }
-static inline void nfs4_reset_lease(time_t leasetime) { }
 static inline int nfs4_reset_recoverydir(char *recdir) { return 0; }
 static inline char * nfs4_recoverydir(void) {return NULL; }
 static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
-- 
2.20.0

