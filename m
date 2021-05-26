Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A7391E30
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhEZRfd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 13:35:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51362 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhEZRfc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 May 2021 13:35:32 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 13:35:32 EDT
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BA2581FD2E;
        Wed, 26 May 2021 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622049910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZKTNMDPJ8ZAu1UUGg6nPw9zt9jqD0YoOEaw+BLyLqOs=;
        b=kFw0wgDW82EsBoLtanBShIu9Zw51d4VQtd7quQzXSH4lANfpQGOKbpNLRtB/12mlThps5h
        c9tG40kDMWidCI8IUejZaL/qvtv/3FqY57IX1r2J344hWkBuGJku0pERoJw1TONBlR+vVK
        e185bUddX+NZTMZrmALIwUsMV9spJjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622049910;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZKTNMDPJ8ZAu1UUGg6nPw9zt9jqD0YoOEaw+BLyLqOs=;
        b=2cq8c3J7WVY00SVs6rBI86IG8XLQik+yBxsfl4l96oELvQPT8wDibh9i/Vr7osJylqxuCw
        gEeVkQiPR63GGoBA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 9920C11A98;
        Wed, 26 May 2021 17:25:10 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        linux-nfs@vger.kernel.org
Subject: [LTP PATCH v2 2/3] nfs_lib.sh: Require nfsd kernel module
Date:   Wed, 26 May 2021 19:25:02 +0200
Message-Id: <20210526172503.18621-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526172503.18621-1-pvorel@suse.cz>
References: <20210526172503.18621-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
new in v2

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index b80ee0e18..26b670c35 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -30,6 +30,7 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
 TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
+TST_NEEDS_DRIVERS="nfsd"
 
 # When set and test is using netns ($TST_USE_NETNS set) NFS traffic will go
 # through lo interface instead of ltp_ns_veth* netns interfaces (useful for
-- 
2.31.1

