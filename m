Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1862953
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391668AbfGHTYv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:51 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:37910 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391667AbfGHTYv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:51 -0400
Received: by mail-io1-f54.google.com with SMTP id j6so37879073ioa.5
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J5715FQO+sJDvJbVkL450ZeVhGjy4w0w+RjJo9pkRRA=;
        b=W7yQ4hx3UCbZujqZdg46GHV4tnhJR42jphOAH/Sc2qO8BPeA0ZCTlerIW0cIgNIsF6
         PmVVwfF/r44nRuDJgDV85hdahSdF4+LEARYugowbweB6G4oAyz25Q+GJJgF3QLqNmwaj
         elUjy5p0xOz+eJ6oOyF/FsAUXpehMDnVZ988uBefEhbh1QkYoK4YzhgvdvuZXC1ExYVC
         JQIdWptNurIO/I0HReyZyz97Dv/XCmPfX4GXQOzxtFBWBSj4nDmwNImf+BDiQn4bMkAV
         o05BeOPSILtFgGZhvSdaqWDLfvtGx0ePhoGGJh6eqqWyRLkamEnh/yqxPUWg64DJoB+X
         +swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J5715FQO+sJDvJbVkL450ZeVhGjy4w0w+RjJo9pkRRA=;
        b=Ojn0hBGXK8iVmVJvBMamILy0ieRBTOBLBi8SOUplFQE+e1sngQzApTPPHg1bAKojIw
         eAO/hPtWZ3+yaMv5KTkw9PupbMMICKpzPAgiySyt0CgQdNKxp0UZT4WN/R98mkHYTx8G
         +BR16sw5OBFU9sXwuhWR951cqF4ENmMPjLmdj+MF/L20cQx4c2o+RUd43n8WYUves9m1
         R2pSVrR8X3s185XceKVv7HDHLO1uaUwWOMrtnuS1XNOIQoSNJq5jN5ycxEgalnUMjN8p
         8GBHJjlvtUpCwwVoIXshIdv1ZavEEMgU9PMWRKoePuWZh2uM+UaYTZxtq97VdWKlwvNP
         fJ4Q==
X-Gm-Message-State: APjAAAWuncAn7Lhta107gRPNcT1BksxkVjCugzZWmOTIUzX/XhmIJovN
        ZtM0R6yBkHhZnfmWkw/sdZ0M10JIKtw=
X-Google-Smtp-Source: APXvYqzcZMd9OQ9s60s9LfKcYizO+oNYvJWtT6d4iUcke/N0EIuC3KbsjBenLM6dXDbbCJKON9pCdg==
X-Received: by 2002:a6b:6310:: with SMTP id p16mr20928439iog.118.1562613890763;
        Mon, 08 Jul 2019 12:24:50 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:50 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 09/12] NFS handle NFS4ERR_PARTNER_NO_AUTH error
Date:   Mon,  8 Jul 2019 15:24:41 -0400
Message-Id: <20190708192444.12664-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When a destination server sends a READ to the source server it can
get a NFS4ERR_PARTNER_NO_AUTH, which means a copy needs to be
restarted.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c898ce1bccc6..e31e1b683d62 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -458,6 +458,7 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 		case -NFS4ERR_ADMIN_REVOKED:
 		case -NFS4ERR_EXPIRED:
 		case -NFS4ERR_BAD_STATEID:
+		case -NFS4ERR_PARTNER_NO_AUTH:
 			if (inode != NULL && stateid != NULL) {
 				nfs_inode_find_state_and_recover(inode,
 						stateid);
-- 
2.18.1

