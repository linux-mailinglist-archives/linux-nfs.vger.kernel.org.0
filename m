Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38E2229027
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGVFyD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:54:03 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:41443 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728294AbgGVFyD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:54:03 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hX-0005j2-2i
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 00:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ryQleyECSGFEBjpkAxi8r41OI2B9iHbWTCGCiR4ywB4=; b=GrOyK4mW0AiHV09dieoqjDYuiR
        TjRNqPZOv1AWAv6tPWkgXF2fpuRWkbRO75filQ5Iaw0h37Ez3TkXUhEN3C2klpVgoaUkw4Jx1/NuQ
        OExQnjjsE6QbWjIy4I4QmbS0LrocOXebubINEmRcS710E0UjFhkvNIaVyWnLxybTCyIWHnw5eY3Aq
        WN2dJqZGV987BoAwxEw+UOdsgAjnwCfWN5co16M1XPm13w+UZXSlmepN4m3In95m8KB1UmSuH7CzX
        3f2G+vPy9sNM6srzAdObaFsneVVSmDQ1uvDrybK9x5Wo3v5+afRjkHIMhUB36wue1yq+QIPCqJILz
        E/4ZPQ/w==;
Received: from [174.119.114.224] (port=44746 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hW-00076P-Sh
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 01:53:58 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] exportfs: Fix a few valgrind warnings
Date:   Wed, 22 Jul 2020 01:53:51 -0400
Message-Id: <20200722055354.28132-2-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722055354.28132-1-nazard@nazar.ca>
References: <20200722055354.28132-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00795476787787)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVusVYsZeVq3kY
 iaOYGclMQETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJASvDB0CdODH1ouMZEJWABcBmI274c1l/AqPuXPnq7mnXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhtC+wDP16V4HdFP/bwDloqn9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVGLbUlq9gkfmitP94LxRBZa/QvoP8rt4/11000ZYKwS0ZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 support/nfs/exports.c     | 1 +
 utils/exportfs/exportfs.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 97eb3183..037febd0 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -838,6 +838,7 @@ struct export_features *get_export_features(void)
 	close(fd);
 	if (c == -1)
 		goto err;
+	buf[c] = 0;
 	c = sscanf(buf, "%x %x", &ef.flags, &ef.secinfo_flags);
 	if (c != 2)
 		goto err;
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index a04a7898..cde5e517 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -85,8 +85,11 @@ grab_lockfile()
 static void
 release_lockfile()
 {
-	if (_lockfd != -1)
+	if (_lockfd != -1) {
 		lockf(_lockfd, F_ULOCK, 0);
+		close(_lockfd);
+		_lockfd = -1;
+	}
 }
 
 int
@@ -184,6 +187,7 @@ main(int argc, char **argv)
 			xtab_export_read();
 			dump(f_verbose, f_export_format);
 			free_state_path_names(&etab);
+			export_freeall();
 			return 0;
 		}
 	}
@@ -225,6 +229,7 @@ main(int argc, char **argv)
 	xtab_export_write();
 	cache_flush(force_flush);
 	free_state_path_names(&etab);
+	export_freeall();
 
 	return export_errno;
 }
-- 
2.26.2

