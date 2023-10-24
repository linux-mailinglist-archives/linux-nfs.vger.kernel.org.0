Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58A7D4E79
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 13:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjJXLBW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 07:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjJXLBS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 07:01:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBEF123;
        Tue, 24 Oct 2023 04:01:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d9effe314so2999377f8f.3;
        Tue, 24 Oct 2023 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698145274; x=1698750074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/Hy9mjKVZEp592T+CI4HCA7TuFfPuvSuvsA6aj3cwg=;
        b=jQaHMRlf+a2eRckLdvetdSv1C/2tA+o/brpu6mLUnwCNjKRaCjaOj2YXOfiwR/f2uG
         soJK5q5DXU9+gUgRHgr53CFVLJEX9ZN/ZQ0a1rtAMD6ldULG1ymdz4RKADQVj5Pzwcy5
         b9VPDx18EjEpZXRbntbtho6iv5QWa4XLl4ELDY4j7jPumxmzXhUP83WJ84SwJ4RQUIRi
         OiSYMcyKbtjM3tfD2Z+UfNY0sjOdJ74eYT5KKSMKQ4aGwH3R9l47o40lYzLmpg5o3vNN
         DSkg0MCFvNVLTBQ17cFwJA7P72vfezyVkmSfkqrhUw/iSsuJ6AVRAd/Up0sUIIqL/62X
         E/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698145274; x=1698750074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/Hy9mjKVZEp592T+CI4HCA7TuFfPuvSuvsA6aj3cwg=;
        b=lA2QRHKtrZIUO7iuJZNnD7ZNw6wM1V+eDVs1FfPz16Jp1nnpPoBYFysFibIAMKAOSs
         ckaRI6Xo5fgnKyxclPWtDWsoeJY2wHZgfuhTNqt8l6eFczdXR8axr595Gqvldl+vnFZL
         GFU7vO1vmYoC3NguWo2AMtgpDGiWMzIZmYKiQgz+Ae6ZlA9kT8Ks6WeHlU3Sx0k2u28m
         rT779GWhxqH3yLNYJWdlSddXhM/Va6fvYPJOsC5FBwT+h7MTVo6KmcIHK1K2kRcrV6rh
         5FypbBd2MU/5+U6F73om49KPfc47RNRRlp0Usbv09AJgEe7RhOodAXWDg4/d7Qq56IZk
         t34g==
X-Gm-Message-State: AOJu0YzmKRBOcbmvcYo9PvfwxaNO74qW82XxWbeYNQ1eYd5ntPW9Qctf
        N8PP3Uvm2MUNT0gXDA/PYyM=
X-Google-Smtp-Source: AGHT+IEU1jutgb9sVKgdnyuesST+oIr997jElQQEBnEoqERofOMlH9lBASsXRPh6FHq5zA9+MkhWyg==
X-Received: by 2002:a05:6000:b41:b0:32d:8f4c:a70b with SMTP id dk1-20020a0560000b4100b0032d8f4ca70bmr9844603wrb.9.1698145274217;
        Tue, 24 Oct 2023 04:01:14 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b0040775501256sm11707312wmq.16.2023.10.24.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:01:13 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: derive f_fsid from server's fsid
Date:   Tue, 24 Oct 2023 14:01:09 +0300
Message-Id: <20231024110109.3007794-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fold the server's 128bit fsid to report f_fsid in statfs(2).
This is similar to how uuid is folded for f_fsid of ext2/ext4/zonefs.

This allows nfs client to be monitored by fanotify filesystem watch
for local client access if nfs supports re-export.

For example, with inotify-tools 4.23.8.0, the following command can be
used to watch local client access over entire nfs filesystem:

  fsnotifywatch --filesystem /mnt/nfs

Note that fanotify filesystem watch does not report remote changes on
server.  It provides the same notifications as inotify, but it watches
over the entire filesystem and reports file handle of objects and fsid
with events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Anna, Trond,

I realize that the value of watching local changes without getting
notifications on remote changes is questionable, but still, we want
fanotify to be on-par with inotify in that regard.

Remote notification via fanotify has been requested in the past for fuse
and for smb3. If we ever implement those, they will most likely require
a new opt-in flag to fanotify.

I think that exporting a digest of the server's fsid via statfs(2) on the
client mounts is useful regardless of fanotify, so please consider this
change to NFS client.

Thanks,
Amir.

 fs/nfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0d6473cb00cb..d0f41f53b795 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -295,6 +295,7 @@ int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_ffree = res.afiles;
 
 	buf->f_namelen = server->namelen;
+	buf->f_fsid = u64_to_fsid(server->fsid.major ^ server->fsid.minor);
 
 	return 0;
 
-- 
2.34.1

