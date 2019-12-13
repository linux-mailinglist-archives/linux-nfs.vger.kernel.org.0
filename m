Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBF511E54F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfLMOLT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:19 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:47387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfLMOLD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MqatE-1htFXk3NMO-00mcAo; Fri, 13 Dec 2019 15:10:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 07/12] nfsd: use time64_t in nfsd_proc_setattr() check
Date:   Fri, 13 Dec 2019 15:10:41 +0100
Message-Id: <20191213141046.1770441-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sX4dzulNvI3GFKBUZrcox6lRFdAV/6K1BJ9TvA9ivOBNVK9j/Fq
 HRkqj1+KlXNIMOzBQU1Xwc0Zt8X512GFwS7+50tQv4ye+TTIUFaV+tPsdzIAz6k9IoK5zQv
 wLf5aSCwQeZZzhx0SN2yos9NOwz3b2R466i8u7lDzFbCYfMYmEXJmjelP1g3OleNKYHT+hX
 7UqX81fHsFigibDLRpRHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4hTU0Zhy3NQ=:bv7zUqTP1evs5iKvCSg0Lm
 PWh+T4mOdKNjNJstivcGtjiydc7IZ3gSqHcbbPsCuoTVP+xMTWkYehmIyu1DcBjRL+ecLJ0+X
 ZJD6hl3vEk7hFKMqESnHpTYmz3MumF2cGk7ddeNT2/utJtc4hBxS04XIUs/SV5xPYH2ZDvrAV
 V4Zk8YSoj+98aKd3X/MklOsAEb4JJFI726yWsSywMOsHuJXvoP/1cwHgYIxP5nbnQOSdqK1df
 MOOvxp02OsMTr4p7iiPxAQ5EOviTs30gNQO/csbivnWmSH4xhXWREApWXjdAN//PvilsYetGe
 OE1Yi1pwNhLl2uNkSCsuPrsvXIr26+yNj7ZFvS9hJ5TpiVqZdk6ckdGbYRUlW3p/zPxgk8m3N
 NbPovt9gt9IOGOgIKjIESqCbrHCMyqQ0yJl973vWPUzMkIV6mchAOSb5HYXU/RfRjtTP2JOAk
 2D2zNcQuJYp9YKWJg3YOcwqcdXKbCRZb0YIM4Zq53XJiL5YJOCojmcW3nA3ZHiOgCkfX4QhVz
 BL7U0W/rjW6fdpVJDl3gVbiqiCDqV7SqOjYA9Yi15VTgUFwp9Mrd+ZtANRvyRlyiw+FPNqiWj
 +06/ZeRJE4dBtPz6MXkLEmoFBtCvvqqskQJXNqxuB3mHi8MXtVaiZoCwVYDvzaoN1j7xdJT8n
 qqheUol17GKV+sNz5q9/7lHGfQm3PAVf4WXIx1RcnTAUzQ9jc2MslG+dNEuRc7I0PZmp9h9Pu
 Q/0gMb+f+gZnJi+lrT+OXQKtOIYJV+5cvTPpmgrXSJvgWQ6TCSwgt8R9IColqV1Nz4otLJ3wv
 LERsNwtkT11JsIdZEaP6cb3hVo17GSdMJzzc89I2xRPmFDhBATDB/jplloCjXF3+bnBbhGk0I
 RypZQYndZrym8+J9LvqA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Change to time64_t and ktime_get_real_seconds() to make the
logic work correctly on 32-bit architectures beyond 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfsproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index aa013b736073..b25c90be29fb 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -94,7 +94,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		 * Solaris, at least, doesn't seem to care what the time
 		 * request is.  We require it be within 30 minutes of now.
 		 */
-		time_t delta = iap->ia_atime.tv_sec - get_seconds();
+		time64_t delta = iap->ia_atime.tv_sec - ktime_get_real_seconds();
 
 		nfserr = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
 		if (nfserr)
-- 
2.20.0

