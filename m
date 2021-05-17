Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC86382DAC
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbhEQNn0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 09:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237441AbhEQNn0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 09:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621258929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H6x6dlAzQJeEEcgnxw7b14Lv0Ybic0pb80Lf+1COmZk=;
        b=QCDDgQgXCKpCaooMjgjI5F/tQnybWbCvyAW/ogl+f5wVeys7pE6MCIK5ijxRrT9RSUjhn+
        NpcD2nPOeOVnv0Uzxfi/wj7JS1ZAvJKxnyXzG45GAzFqDXQBsSReApnLkQqfQ4J5st1p9q
        Aiio+0IZdSZx299RoVi1f6prr/ypc0k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-a5Ehg8aeMpqxFiKUD_FQuA-1; Mon, 17 May 2021 09:42:06 -0400
X-MC-Unique: a5Ehg8aeMpqxFiKUD_FQuA-1
Received: by mail-ej1-f72.google.com with SMTP id h4-20020a1709067184b02903cbbd4c3d8fso1057240ejk.6
        for <linux-nfs@vger.kernel.org>; Mon, 17 May 2021 06:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6x6dlAzQJeEEcgnxw7b14Lv0Ybic0pb80Lf+1COmZk=;
        b=eGUlSTpZpEfDLfxXvXzdUXI5iJsgyt1iwWYl5H5LL6TBgh8N5XAdAdJNTuRvlCBUkP
         jLUj7u5LTZFUrlbwsJ5AarL8PgMcBXkIlSb6+Wcud1fK2fNQHLvpIcCQO4OuGszpBDaS
         TLNwcYSQIK/qC89HLemZwzMCB/di52sB//H1nKVliAPs1doF0HgAWCRRlyh7wDDoRBN2
         zRcJzXX2ZuDwQF1ZtDcQI61XTYEUjBETJp5yu7IhfL2ZzSCXnZrf1+Kr5ML6smhAfuQv
         G6i8roCYAamyzM+BzPfxtTREfSTNouWOS5nOuIZc5U0fg9VBiakVsJtZKA33Z/xZajn1
         BALQ==
X-Gm-Message-State: AOAM531E9cQy5nxrnRBjZuvKpDgtPRJ+ywPJZT/+ZtxhGBjPYwhyBMjG
        D0uooJkKCF4p6vcV80DdUpT2HvTCApJHWLsv1D9jX2k1jBkAfM4aLGMFhITzxmGRuFn+vPNH6xO
        wf+Ppa467RIu0IJZZu5cg
X-Received: by 2002:a17:907:1007:: with SMTP id ox7mr4484ejb.82.1621258925019;
        Mon, 17 May 2021 06:42:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOnrwdmJm9wKgv4E3uyq02kBsINeKG2K+kyigE4PMhwjioTBtobRTknqqvWz3J64hwJZiBMw==
X-Received: by 2002:a17:907:1007:: with SMTP id ox7mr4465ejb.82.1621258924851;
        Mon, 17 May 2021 06:42:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id f7sm11302466edd.5.2021.05.17.06.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:42:04 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH v2 0/2] vfs/security/NFS/btrfs: clean up and fix LSM option handling
Date:   Mon, 17 May 2021 15:41:59 +0200
Message-Id: <20210517134201.29271-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series fixes two bugs:
1. A bug with BTRFS where LSM options are ignored when BTRFS is mounted
   via the new fsconfig(2) API. (fixed by patch 1)
2. A bug with NFS + SELinux where an attempt to do the same mount twice
   might incidentally turn off LSM labeling, making any fresh inode
   show up as unlabeled. (fixed by patch 2, with patch 1 as a prereq)

For bug (1.) I previously posted a different patch [1], which is no
longer needed if these patches are applied.

While these patches do add a new fs_type flag (which seems to be frowned
upon), they also reduce the semantics of FS_BINARY_MOUNT_DATA flag to
*only* the mount data being binary, while before it was also (ab)used
to skip mount option processing in SELinux for NFS and BTRFS. The result
is perhaps still not perfect, but it seems to be the only non-invasive
solution for these bugs in the short term. Once BTRFS is finally
converted to the new mount API, a lot of the ugliness can likely be
refactored to something nicer (and these patches do not really make that
any harder to do, IMHO).

I tested the patches by running the NFS part of the SELinux testsuite
[2] (which is now fully passing). I also ran the proposed BTRFS SELinux
test coverage for selinux-testsuite [3], which is now passing.

Changes since v1:
- in BTRFS, move the FS_HANDLES_LSM_OPTS flag to btrfs_root_fs_type, and
  remove FS_BINARY_MOUNTDATA from both fs_types now

v1: https://lore.kernel.org/selinux/20210409111254.271800-1-omosnace@redhat.com/T/

[1] https://lore.kernel.org/selinux/20210401065403.GA1363493@infradead.org/T/
[2] https://github.com/SELinuxProject/selinux-testsuite/
[3] https://lore.kernel.org/selinux/20201103110121.53919-2-richard_c_haines@btinternet.com/
    ^^ the original patch no longer applies - a rebased version is here:
    https://github.com/WOnder93/selinux-testsuite/commit/212e76b5bd0775c7507c1996bd172de3bcbff139.patch

Ondrej Mosnacek (2):
  vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
  selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount

 fs/btrfs/super.c         | 34 +++++-----------------------------
 fs/nfs/fs_context.c      |  6 ++++--
 fs/super.c               | 10 ++++++----
 include/linux/fs.h       |  3 ++-
 security/selinux/hooks.c | 32 +++++++++++++++++---------------
 5 files changed, 34 insertions(+), 51 deletions(-)

-- 
2.31.1

