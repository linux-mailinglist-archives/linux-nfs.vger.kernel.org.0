Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E4EAB40
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 09:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfJaICX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 04:02:23 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:53599 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbfJaICX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 04:02:23 -0400
X-Greylist: delayed 3484 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 04:02:22 EDT
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <nazard@nazar.ca>)
        id 1iQ4V9-0003Ya-Sh
        for linux-nfs@vger.kernel.org; Thu, 31 Oct 2019 02:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DzKCjTs3AqXRoBdBrtuiHiJ/DPSjCDGcxG5cX2A5xVk=; b=bNlxx9/pD1tqciMWdyP4qAwG9m
        sBJ8Modds/9c5zjLB7X+aVAVQrt2qI5rl5SmqqTisUedYq+w0Glp/yJc5oSZZuluTZE6aGkAKRw52
        NMh/8l6Zdv+7NccU8Ig76Tcf5rWXtcj8laKyaGQk8lIyjUL5LlR+n/h0gr1zPa49F6tchUFmbjGWG
        sKIacUir49YbwfbUXWzvOu07ijNrDKm9GnklRKaRhBpPND8q7weP3h+eRb2cExUiir2qSwSYeU20I
        0n6BumTIreVg30W2fkaRPjMEgPIrsz/0yo2bvCrSDNXOOtvnclTszY2u3rnNr5iDJajjhqdDV40d0
        ofAN355w==;
Received: from [24.114.52.237] (port=61047 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpa (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1iQ4V9-000ZhR-F4; Thu, 31 Oct 2019 03:04:11 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Cc:     Doug Nazar <nazard@nazar.ca>
Subject: [PATCH] Ensure consistent struct stat definition
Date:   Thu, 31 Oct 2019 03:03:55 -0400
Message-Id: <20191031070355.26471-1-nazard@nazar.ca>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: relay
Authentication-Results: arandomserver.com; auth=pass (login) smtp.auth=relay@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00170630964)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0eT2jivapI8P7M2alpZfRhCpSDasLI4SayDByyq9LIhVqvXsHlLLlUbg
 P4WYAVlPUkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dLc4obpjbf08by+M7b0EHXgdMWAh8MxKGaVAWoKvmEDzHXpGCeulZALlD2V
 AvpAcEdf744xu+RC3veeu00j80mer/yY+JhjcMS53cIXFxfh3ByeP3kMF/HM2qi7bXBmBn8wFR42
 J7UfXpcz2r2kQsBELXlmC60tmJRRpwzLoIbf5RR8Pn/4ZVaMtKTxj4/k25+btB7+FSxlHuYIERvd
 RN/RhHQOLtWk4clq0P6Ltvr/5c9SxONrrqc2Pjmtxs4wgHNkxEkh0C3Vr5FCbGnhiDumCpDOcqQN
 ioEzqLzLiIk4HEcFBAvuf345Nnfstl8j+xb+3g9gkPulv+51ClEQ+Hg4LsZ1+FYshGMbuvlV1VNM
 rtad27bIXajXXo8vXH+RaTt8AmPL5r/iajlSWpgR3zhlcI5+17rf5V2oLKHXeaqjg0xYsHKVOH8s
 ++Y8aVPfETxoh9VoIekQHpwUfpYnEThmrzfrc8FOzGDXsFXzw54wLIOiMVCaTGAMqRQNlVmHntGN
 ShV7TzzzSgfE7+D5c8ChczdAyif+8H+l3s7d4CANOXBA8PwUUc0q++amiXvpOwmBk4QknL1NHAiI
 h0kG5nFSDN/LH4qDO8KBspSp72b1SUdDb6CHBgQ05Px8y2iqfRDMzvY5KZtyjtrp1aagF1iG1yyr
 aE/TU54ocoY1ib6Dvlz1pRXWhjh9fdbl44I0Df0ZmqWO+Zg42l5xNDnh7swLZ51IRj/s4EA8i8vj
 l0Dm/z4TqmCVei/7GM2834L7x/UfPFg46jzk0wb+4gNa+rlVr38cN0L29hpYqOQomv/Sn2sbq4Hr
 MJoTppXpWKUnjd4vnqDy5y5BzhkOB+SLoPMOCxSUmvUwEaOV47zQAz/Qm8cv4ibvfd0VeYmt2Kro
 k4eWp33KKvSLEepfzmW/VTBD
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Although 2fbc62e2a13fc ("Fix include order between config.h and stat.h")
reorganized those files that were already including config.h, not all
files were including config.h.

Fixes at least stack smashing crashes in mountd on 32-bit systems.

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 support/junction/junction.c | 4 ++++
 support/misc/file.c         | 4 ++++
 support/misc/mountpoint.c   | 4 ++++
 support/nfs/cacheio.c       | 4 ++++
 utils/mount/fstab.c         | 4 ++++
 utils/nfsdcld/legacy.c      | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/support/junction/junction.c b/support/junction/junction.c
index ab6caa61..41cce261 100644
--- a/support/junction/junction.c
+++ b/support/junction/junction.c
@@ -23,6 +23,10 @@
  *	http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <sys/types.h>
 #include <sys/stat.h>
 
diff --git a/support/misc/file.c b/support/misc/file.c
index e7c38190..06f6bb2b 100644
--- a/support/misc/file.c
+++ b/support/misc/file.c
@@ -18,6 +18,10 @@
  * along with nfs-utils.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <sys/stat.h>
 
 #include <string.h>
diff --git a/support/misc/mountpoint.c b/support/misc/mountpoint.c
index c6217f24..14d6731d 100644
--- a/support/misc/mountpoint.c
+++ b/support/misc/mountpoint.c
@@ -3,6 +3,10 @@
  * check if a given path is a mountpoint 
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <string.h>
 #include "xcommon.h"
 #include <sys/stat.h>
diff --git a/support/nfs/cacheio.c b/support/nfs/cacheio.c
index 9dc4cf1c..7c4cf373 100644
--- a/support/nfs/cacheio.c
+++ b/support/nfs/cacheio.c
@@ -15,6 +15,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <nfslib.h>
 #include <stdio.h>
 #include <stdio_ext.h>
diff --git a/utils/mount/fstab.c b/utils/mount/fstab.c
index eedbddab..8b0aaf1a 100644
--- a/utils/mount/fstab.c
+++ b/utils/mount/fstab.c
@@ -7,6 +7,10 @@
  * - Moved code to nfs-utils/support/nfs from util-linux/mount.
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
diff --git a/utils/nfsdcld/legacy.c b/utils/nfsdcld/legacy.c
index 07f477ab..3c6bea6c 100644
--- a/utils/nfsdcld/legacy.c
+++ b/utils/nfsdcld/legacy.c
@@ -15,6 +15,10 @@
  * Boston, MA 02110-1301, USA.
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <stdio.h>
 #include <dirent.h>
 #include <string.h>
-- 
2.23.0

