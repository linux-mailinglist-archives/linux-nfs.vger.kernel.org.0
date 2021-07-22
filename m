Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98AE3D26AB
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jul 2021 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhGVOun (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jul 2021 10:50:43 -0400
Received: from smtpcmd11117.aruba.it ([62.149.156.117]:34155 "EHLO
        smtpcmd11117.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhGVOun (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jul 2021 10:50:43 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jul 2021 10:50:42 EDT
Received: from ubuntu.localdomain ([146.241.181.181])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 6aYZmVjCCp6qU6aYZmmc4g; Thu, 22 Jul 2021 17:24:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1626967456; bh=cQgR0Ue7X6OMHPrRjtapiqpbyrhrI3c3NFZfPXBW1fI=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=fkO5proAiPQhapm+AhuGk0cj52wHg9Zw6NdJ8+eDrTgDnPb/UIYhr3tlIbpgLwNuE
         mx00HwkVU72MF9lbD5/fTmHYzyCYD8jPMVlhJwWm6DiyGEgcoJeHgOWfuQouKeRJd9
         5A7NwQO17PIIPxd74tm5Fxc55P6Pew/vEk/Hbn5ZLb+zXuwDcb2Ua3F8zW+SgbLw3m
         MtDcKsdU12Vx4qUNuFhjLxoe8NFtt++GqKgbLC/lHQjm0kPTWHMVGK2sVoISZw4GJ9
         ZHjO6y71KHyUXRv8kV4KVoHHWVf2DNyOYTM15X57jeWZ8uF+Ra+2Zti2sQIWSADusB
         6QNawBmyLQbEA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] nfs-utils: fix time_t build error on 64-bits platforms
Date:   Thu, 22 Jul 2021 17:24:11 +0200
Message-Id: <20210722152411.1156295-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGhSrCaSr7q+f4ozdIK53XllQFjACL2sOS2EC/h1XtB/BWiPLXncZiFoMwSGRv+hkiWhSv1WcsKOt2xo5F+1HcktR3zDlFXZleG6XpauzfjvXz+zcNov
 Ot/I2DdDemELjqqXaNnTPjFFTbICw1pYDyYOuKvpC1AaQ8Pjky7Rtxy3FIylTlAx5LTedGNuvdKEBpnEl0EPbEBrMcfeTtOEPyvxu2F0+XbwIkWh6YIjHBGk
 UxWehoLXwMT4q/uAwwW0kzjhisH+J7Y4ZKO2KrLS8Kk=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When passing time_t type to "%ld" on 64-bits platforms where time_t is a
'long long' we encouter this build failure:
error: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]

So let's change "%ld" markers to "%lld" assuming it to be a 64-bits and
cast variables to '(long long)' if the type is a time_t.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 utils/nfsdcltrack/nfsdcltrack.c | 2 +-
 utils/nfsdcltrack/sqlite.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltrack.c
index e926f1c0..437477bb 100644
--- a/utils/nfsdcltrack/nfsdcltrack.c
+++ b/utils/nfsdcltrack/nfsdcltrack.c
@@ -525,7 +525,7 @@ cltrack_gracedone(const char *timestr)
 	if (*tail)
 		return -EINVAL;
 
-	xlog(D_GENERAL, "%s: grace done. gracetime=%ld", __func__, gracetime);
+	xlog(D_GENERAL, "%s: grace done. gracetime=%lld", __func__, (long long)gracetime);
 
 	ret = sqlite_remove_unreclaimed(gracetime);
 
diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
index f79aebb3..6e603087 100644
--- a/utils/nfsdcltrack/sqlite.c
+++ b/utils/nfsdcltrack/sqlite.c
@@ -544,8 +544,8 @@ sqlite_remove_unreclaimed(time_t grace_start)
 	int ret;
 	char *err = NULL;
 
-	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %ld",
-			grace_start);
+	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %lld",
+			(long long)grace_start);
 	if (ret < 0) {
 		return ret;
 	} else if ((size_t)ret >= sizeof(buf)) {
-- 
2.25.1

