Return-Path: <linux-nfs+bounces-2110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A25986B7C3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 19:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7058B23680
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978DC79B79;
	Wed, 28 Feb 2024 18:57:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FA79B74
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146626; cv=none; b=gKbAEAuJm4fSKCcj6ta2IwqCQdi+BWnGNuLFrgMQygOfh6aj5pefGAJ+EwgL03qT2B2YPK59FogFGi90l7pGs71LgZrPclTRhmZQi2EglNWgsBGfbZAEqy5klp9LJtcOJcJD0qQH/d4HD0WCZgGdu1Zvb3gye4xxG9C/5iWk99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146626; c=relaxed/simple;
	bh=/UbWTVtLHxMER6hH80Vrcbt28xh6/F/aoZwnhzCthX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M5TYZvVdP8EsQlvI2fAV3R6BVv+gnwLaUZW1TK7JLRxoAHDTJ6MvsZgLw9Om+sbhyPJaZPPibzXiD7z2KyM0+eZ05q+nFqXw4r/Kv/KwKKHBcQ3IfVCEoOH4XoqP+uA1TEggyddItHHTnuF7kJ8uO6SnnIbZ42bZXCL14WMCSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rfP6w-0006V5-CP; Wed, 28 Feb 2024 19:56:58 +0100
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rfP6v-003Rir-TM; Wed, 28 Feb 2024 19:56:57 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rfP6v-00BVbA-0z;
	Wed, 28 Feb 2024 19:56:57 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
To: NeilBrown <neilb@suse.de>,
	Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	kernel@pengutronix.de,
	Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH nfs-utils] start-statd: use flock -x instead of -e for busybox compatibility
Date: Wed, 28 Feb 2024 19:56:44 +0100
Message-Id: <20240228185644.2743036-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nfs@vger.kernel.org

busybox flock(1) only supports -x and not -e. util-linux flock(1)
treats both -e and -x the same, documents them both in its man page,
but lists only -x in its help output.

Referring to util-linux git, it seems both options were added between
util-linux-2.13-pre1 and util-linux-2.13-pre2 back in 2006, so there
should be no harm in switching over to flock -x to avoid confusing
error output when attempting to mount a NFS on a busybox system:

  $ mount -t nfs 192.168.2.13:/home/afa/nfsroot/imx8mn-evk /mnt
  flock: invalid option -- 'e'
  BusyBox v1.36.0 () multi-call binary.

  Usage: flock [-sxun] FD | { FILE [-c] PROG ARGS }

  [Un]lock file descriptor, or lock FILE, run PROG

          -s      Shared lock
          -x      Exclusive lock (default)
          -u      Unlock FD
          -n      Fail rather than wait

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 utils/statd/start-statd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/statd/start-statd b/utils/statd/start-statd
index b11a7d91a7f6..67a2f4ad8e0e 100755
--- a/utils/statd/start-statd
+++ b/utils/statd/start-statd
@@ -8,7 +8,7 @@ PATH="/sbin:/usr/sbin:/bin:/usr/bin"
 
 # Use flock to serialize the running of this script
 exec 9> /run/rpc.statd.lock
-flock -e 9
+flock -x 9
 
 if [ -s /run/rpc.statd.pid ] &&
        [ "1$(cat /run/rpc.statd.pid)" -gt 1 ] &&
-- 
2.39.2


