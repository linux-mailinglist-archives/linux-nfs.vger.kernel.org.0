Return-Path: <linux-nfs+bounces-2611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3964D896545
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 09:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C31C217A7
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CDB17C64;
	Wed,  3 Apr 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IyC0Fh1O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151C17BC2
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127766; cv=none; b=qdm00RMyLRYHMI3gxt5uv3EsWdsH/ni1QY7MTr89ae6UqrWhJFMRpN35/3wUTx9psuKekPYxs2ekM9sCqLZ4fKV4KyhC2kFgvgvOjrkzOM8gsTPUx5ABl3/mCyh8bcO+0xrlv4irwAhRmw4eLf9sN8TvVJcyuoy0R7LMdk66cX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127766; c=relaxed/simple;
	bh=zgi82/H/VSFgxmc1D62JP1I5qxrmSvtHWkHiKV6R1Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DKZ5J2w/8KOVb9SmfGAGemRlmJ9Pqz3KhGiajkKeRRCmnhs1jScELtOkyZgHF80tNmoiHyYrh+zO3S/wevBOMzh8qKDlmtZnU8cYCS5VMQYJn2IOxr5xq1IGwJPoW5cfWM6HXqHt/7fOZnaht4sAlCjOIGXTa9Hu348EYdIp4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IyC0Fh1O; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712127763; x=1743663763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zgi82/H/VSFgxmc1D62JP1I5qxrmSvtHWkHiKV6R1Uc=;
  b=IyC0Fh1Otgpee6mzmYzySC1HLzepijlp6zxg46V8TrTE13vnHh6qH9CG
   QBsy+A/2kIh3Q5gAB9gWbEQAECPmNXJu4Mz8eKAoaLrj7jw0gqcxVXAbT
   4HJHw2qjf+WI1vn3ySu8eFlzN7c6xy+/yS+gGxE/1ZfOu2gHvfgPg8LJV
   ww5RTDpV69+MMy4FPL0LW4LSPKgCP+GXgGWKCYH4renX+h4/PcrlIPZ6G
   mIUKuAotXoum7WU6Hl4rarOkqGc36ZPalxTKgdlmBIcM9Y9ab8GGsQbUQ
   Fudcspdoo88EJTVZ9Fq0RwOeoI81MK942pa68DffkQRTRYGk811PcE6v0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="133776779"
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="133776779"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 16:02:40 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4EECAD4803
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 16:02:37 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8496A1531F0
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 16:02:36 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0718B20097CC9
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 16:02:36 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7CF161A0002;
	Wed,  3 Apr 2024 15:02:35 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] mount: warning "namlen=" option for a NFSv4 mount
Date: Wed,  3 Apr 2024 15:02:28 +0800
Message-Id: <20240403070228.308-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28294.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28294.005
X-TMASE-Result: 10--1.690300-10.000000
X-TMASE-MatchedRID: QAAr3LZ6Q9JOBjuTIREKLfCCu8kVj0TRrzD8YrC59vx/iZ1aNsYG7p7V
	Ny7+UW/9wVeG+L4n/T9fsF9Eqkj/t+BRuAss+FbmEXjPIvKd74BMkOX0UoduuejzDg3u173a8U7
	h2c3MXxMbkKUBXyytFS0EwpjgUMbJGAdnzrnkM48URSScn+QSXmVV1G+Ck2l7+gtHj7OwNO2I3a
	djBtsMrLE0IBlgQeOWq0O9dENK1NgZ/WZut2uqBpCy9Wne07YYEcOiXfAUc89j8tNQdwIkLQIHK
	h+iCzVM71MnwUfYp4eyKuJKir56uYaT7FRqp0wPAcQrAfBh69vBRLFeH6OJSCTDD+DBjuEw
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

namlen is not a valid option for NFSv4.
Currently, we could pass a namlen=xxx in a NFSv4 mount,
the mount command succeed and namlen is ignored silently

# mount -o vers=4,namlen=100 192.168.122.19:/nfsroot /mnt/ -vvv
mount.nfs: timeout set for Fri Mar 22 14:22:18 2024
mount.nfs: trying text-based options 'namlen=100,vers=4.2,
	   addr=192.168.122.19,clientaddr=192.168.122.15'

This patch will remove "namlen=" option in a NFSv4 mount,
and give a warning message in verbose mode.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 utils/mount/stropts.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index dbdd11e7..a92c4200 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -780,6 +780,14 @@ static int nfs_do_mount_v4(struct nfsmount_info *mi,
 		goto out_fail;
 	}
 
+	if (po_contains(options, "namlen")) {
+		po_remove_all(options, "namlen");
+		if (verbose) {
+			printf(_("%s: Ignore unsupported nfs4 mount option 'namlen' in '%s'\n"),
+				progname, *mi->extra_opts);
+		}
+	}
+
 	if (mi->version.v_mode != V_SPECIFIC) {
 		char *fmt;
 		switch (mi->version.minor) {
-- 
2.39.1


