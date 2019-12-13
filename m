Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0552111E556
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfLMOLg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:36 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:36859 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfLMOLD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mi2BV-1i1js033dh-00e7iJ; Fri, 13 Dec 2019 15:10:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 11/12] nfsd: use ktime_get_real_seconds() in nfs4_verifier
Date:   Fri, 13 Dec 2019 15:10:45 +0100
Message-Id: <20191213141046.1770441-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pwg4ldcY+PirxuTk1NxKPR/wF0W7omnIpEhR4gWAXHpGQfencqU
 9EjmqFwbCPgYhBby6Q3tH+JCuKvm94AFXcEYbOtHvvBFf6t6QfakjHUFeX/9+wZ0WXOnnAf
 7Mj6sSgdq943phWuTRM8iA4/sHo+J04C+yauSKBDSHlxJ9ALUWqh/3hNXScfaod4Jm4H6EW
 TL/F8Z4OBfXWFGiYY0ojA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:taJeJc826rg=:gsJimcb309nz2tjW+nHMfT
 GfN+0U2212OBpxgW7egoFIGQ862g/bQvkrGmWwk6BlCUv2H3GGv3fwNrtYdaW/Q+PjOJZmAJk
 +dK25vCWRztDD50tdguuWnRXx875Hn+wEVYv/6TkFFDaMqRqmNefb4exZPSbWpniFe/lCeZW4
 7B/FJM5yqkx3yVZvol7G4KSTp/totkFhFKDnr58T4mvRXNnqzhQeai5WL5hcA6AeONLwFSK6d
 iIQVqN/4hswZCeNX34EDDwDAKjreQA8NFkfUCLMOO7UBArxETkwq4GJqgh7Fnc6B6zSsrabv3
 HrrvQf0GEA1aVb/YDSqqfNhszpmPDG2YhJkrtc813TrR9WJfXCz46oNiJ8vdZ0KSODbvy3Pvn
 4SAgh0DX41V96BZuFQOxt6lAlkcjWyFoooimY6kte2bluDN1Fi5RnBjrDDjgtumWA0Yho2LEN
 H8J2vSmFqLDUI5yGWhnR9qw9aMPe/swv/fuTTNLztVdcTwoFtsxQTGcDQkgHEeawX2UvCL5Zo
 PQJpcU1Tqdhw6S/gbwImUkqrbfOdpL9InZWTE6UBmtlHX1VpUx/hprHP0MtW+D7gMfZz6J0S4
 SCRv1BGJLJMOEl18unsekpH0O56m+qfl+h2S4MX5IxxiMXeuLtz5qYWMpoRqypa0PQfa5LTtd
 HQybvMPDK334iImyClesbRDePlvRHikkYSfP2RYsvuRgjX77uAP23PrPk568aer4mRcsDM7wB
 rIeR6WDUn9NFERKrHVuW3Ke+/Sdszf16X9oA6Sf/kN2xVZYxQLKs2PG5VUepNbX1Apchz0nYz
 3PSpZK+XI5D/ctMMzt8O3Z6Lrvy2GNRKiDresjBT5jiAADMswqQkrvYa0GQkmC4ec3a++HXgJ
 8HHnwgNFBKTuyN4ERjSQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

gen_confirm() generates a unique identifier based on the current
time. This overflows in year 2038, but that is harmless since it
generally does not lead to duplicates, as long as the time has
been initialized by a real-time clock or NTP.

Using ktime_get_boottime_seconds() or ktime_get_seconds() would
avoid the overflow, but it would be more likely to result in
non-unique numbers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6afdef63f6d7..efe3161f6cf7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2215,7 +2215,7 @@ static void gen_confirm(struct nfs4_client *clp, struct nfsd_net *nn)
 	 * This is opaque to client, so no need to byte-swap. Use
 	 * __force to keep sparse happy
 	 */
-	verf[0] = (__force __be32)get_seconds();
+	verf[0] = (__force __be32)(u32)ktime_get_real_seconds();
 	verf[1] = (__force __be32)nn->clverifier_counter++;
 	memcpy(clp->cl_confirm.data, verf, sizeof(clp->cl_confirm.data));
 }
-- 
2.20.0

