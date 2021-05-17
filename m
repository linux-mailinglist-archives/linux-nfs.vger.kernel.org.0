Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7714382DB3
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbhEQNn3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 09:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237441AbhEQNn1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 09:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621258930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/7ogBL+LNdJ2jZ956/DJsdJPCwqblJZYhGffkhc86o=;
        b=Afi6nisDS0MjQrzVGJPcSxXIbgO7vdqgcVdAplH5P9KIm+xZ3YX7RpHyVxJgg5MeNJiOCt
        ysFfpc40pA3jC8xChT3osQ91mDtyX5KKF8Ad+T0oEACDm2EZJaBuvOmWPRtZVZPRAFfJRX
        /PrflJxcpymprNFz9E686f+MyKM+gr0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-BY2dI7zoMf6mVYeQ8eS3hQ-1; Mon, 17 May 2021 09:42:08 -0400
X-MC-Unique: BY2dI7zoMf6mVYeQ8eS3hQ-1
Received: by mail-ed1-f71.google.com with SMTP id q18-20020a50cc920000b029038cf491864cso3924942edi.14
        for <linux-nfs@vger.kernel.org>; Mon, 17 May 2021 06:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/7ogBL+LNdJ2jZ956/DJsdJPCwqblJZYhGffkhc86o=;
        b=NwD9rm2mYjs1Ro+QZPYL6Tm3gJvtOw64/v1OeV/XtG1YyrtFebs5nMEzjroiGTd0Tg
         GA/2+Bm3G0m9UoSIRKOURRW0bKC34iDYSNHRXq+RX9xaCUMMs5ilkhWK9sfef4AlkY7Z
         eSocPFTGMUQX1dSSNxPSCjVys9JlQy8wdh6nfwrYI4GpM34PgWTrkQ8KzbL7Zer9zbGS
         OYYq102TVGsYdh2M5QUP01YAJ90z4sC7xzIDP3+0V7u4wrMHL0D1IDkVnNvj5JEC0YeB
         hlEt7SdyLcyu2RUzOpbpDg/mxbIyijGv+86A+8V6HYAveEI2kmY1Z91YcnkXYTS/Jxx1
         qQeg==
X-Gm-Message-State: AOAM530GaGErLnU5xasqiiwVBKSGeB6jq0wA9RCdAtTw09ODD8QHrBwT
        y5xvI6aSrAbQWOmFGYy3Jmyp/W/xUa7dOgsEI5CmJfF6tMg7k8jlB2Gvd3fAWeankXmVOwJLOhN
        n8pFJuuQSMUjmnLmuK3OS
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr63552956ejb.183.1621258927778;
        Mon, 17 May 2021 06:42:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwmY87sB+RI/eYOHiE4Q0GrYf2Jge+7AHgcZqApEDJVyA57Z96Ks3gQhOvtduuLmn2qVC3iQ==
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr63552938ejb.183.1621258927634;
        Mon, 17 May 2021 06:42:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id f7sm11302466edd.5.2021.05.17.06.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:42:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH v2 2/2] selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount
Date:   Mon, 17 May 2021 15:42:01 +0200
Message-Id: <20210517134201.29271-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517134201.29271-1-omosnace@redhat.com>
References: <20210517134201.29271-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When mounting an NFS export that is a mountpoint on the host, doing the
same mount a second time leads to a security_sb_set_mnt_opts() call on
an already intialized superblock, which leaves the
SECURITY_LSM_NATIVE_LABELS flag unset even if it's provided by the FS.
NFS then obediently clears NFS_CAP_SECURITY_LABEL from its server
capability set, leading to any newly created inodes for this superblock
to end up without labels.

To fix this, make sure to return the SECURITY_LSM_NATIVE_LABELS flag
when security_sb_set_mnt_opts() is called on an already initialized
superblock with matching security options.

While there, also do a sanity check to ensure that
SECURITY_LSM_NATIVE_LABELS is set in kflags if and only if
sbsec->behavior == SECURITY_FS_USE_NATIVE.

Minimal reproducer:
    # systemctl start nfs-server
    # exportfs -o rw,no_root_squash,security_label localhost:/
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # ls -lZ /mnt
    [all labels are system_u:object_r:unlabeled_t:s0]

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 041529cbf214..367e7739cb18 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -734,7 +734,24 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		/* previously mounted with options, but not on this attempt? */
 		if ((sbsec->flags & SE_MNTMASK) && !opts)
 			goto out_double_mount;
+
+		/*
+		 * If we are checking an already initialized mount and the
+		 * options match, make sure to return back the
+		 * SECURITY_LSM_NATIVE_LABELS flag if applicable. If the
+		 * superblock has the NATIVE behavior set and the FS is not
+		 * signaling its support (or vice versa), then it is a
+		 * programmer error, so emit a WARNING and return -EINVAL.
+		 */
 		rc = 0;
+		if (sbsec->behavior == SECURITY_FS_USE_NATIVE) {
+			if (WARN_ON(!(kern_flags & SECURITY_LSM_NATIVE_LABELS)))
+				rc = -EINVAL;
+			else
+				*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
+		} else if (WARN_ON(kern_flags & SECURITY_LSM_NATIVE_LABELS)) {
+			rc = -EINVAL;
+		}
 		goto out;
 	}
 
-- 
2.31.1

