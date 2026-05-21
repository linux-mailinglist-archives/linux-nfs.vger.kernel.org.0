Return-Path: <linux-nfs+bounces-21756-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJztCeIND2p7EgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21756-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 15:51:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED75A6543
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 15:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D38833A937E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257B211A28;
	Thu, 21 May 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A22HwZOd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPhgM14h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80BB226863
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369865; cv=none; b=NEBznzdq6NY2yyVxgCah4bOvQR/jvbGl9IpmMXZaWetw5xkJ1B0j1gUAPKQ335BYJG/DSfUrzX/y1/UYnzpGIcckV45MC+eA7U/L95cfCdghmgKSPjlS7q3XB5ohtiZClkvbCd9aizXh2qered/djDqEw6qeBO3E9yteybPOBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369865; c=relaxed/simple;
	bh=ri0dMmjilySZdzgLXn8EVxyZ7uYFISZpZ20dkjxhljM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cI7N+QYPMl1gkwNyHC9N7xXaNaYz8z+WF73t3I006lTlALNL/DnlvcNVtLvZ1wkw+aZNbWGLFk+55NqV3IvQR3glq12OE3Re/8aUxJBnHVO6fD/LvdEoPURrDCyDOXHVt5TO8xz4DUP9GG9ikI/FbODzTwEdL+2pWF9Q62Ng8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A22HwZOd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPhgM14h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779369862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/nBCWUEsDPqnfTulRRO4vNQXKTEAo1xPcXXUmwMZ2Tw=;
	b=A22HwZOd9KLCXGa7r9nty9a4ObndfkRM3Oo5Uy0CgMpME+QrV/zwE9H+6v5B9xPTzvZV0q
	CoUN3kGtVW6IWb9PvzHWmmX7Yb/q0rLSuuLEd62Wk+RbIr3zKKynXEvX8+Ai/sNXA5fR6G
	DcPWwYtjMWPRxAZsbQy3Bc8c6MteFV8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-mnWJiTYbNtirIaBL2hNUwA-1; Thu, 21 May 2026 09:24:16 -0400
X-MC-Unique: mnWJiTYbNtirIaBL2hNUwA-1
X-Mimecast-MFC-AGG-ID: mnWJiTYbNtirIaBL2hNUwA_1779369855
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd8162ed7so44571005e9.2
        for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779369855; x=1779974655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nBCWUEsDPqnfTulRRO4vNQXKTEAo1xPcXXUmwMZ2Tw=;
        b=RPhgM14h5+jRx2SYuLvE8q6+aWykBGuX3+iMhG6irMju9mrk4wQPJliQab/vGrNCJp
         /6bnD6CLjc7D2MNhVcnsbQYKeQBkgO4wm7zsxiBnTAtr8xCEuSZeFZUhNy2H6FJlbNlD
         MFXuSbiQhswNLmcIQME+nNqByv4dL+RhsNMJfhgSusoZFso6xQeL/6JKnqpM0D3HyUDq
         olTQ+gtlfSyvwumS29s4XwliG/J7kCFJASwdDWrP6hHDhlWnL6VQi0+9lBxSRfo1StzY
         ZcxU8UTf6Vo1uSA9ijMKVx9Upwf5BQ5a1kYsR3EuHvGWzkAa//t6vKAP4frbZttChdB6
         cB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369855; x=1779974655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nBCWUEsDPqnfTulRRO4vNQXKTEAo1xPcXXUmwMZ2Tw=;
        b=lPuKB8uIlPE9ZFM+urn/ASjAEbZ0Ve9B/KR+jb/l+fzh12yi48/aMO8OQFKEs/tHG8
         vuMcLaNWS6hxFpCozzQmWsd3/SMeLXmNi97wH2bTUF25hzf2DLwOnGiLjkgDzsZXI+rD
         122+Jxe0ftaTypHM5cx11nFABfoNxp7EeW3p8YB6Ao1OHBoSsMDXVAkPfSBy3Wsg4Vlc
         +hCjdUGL1REN8gDAEjkjZbEDqngHInYx2B0ARkj86wGwsfatHQQChAuFCKCYEjwSGt/9
         Re4L4cD+ecOpBV02tFKwoFLIBNJlSkymVRupG4MKuF9oqWy+P+S3xPjcQkGy8jjcf81b
         KsNg==
X-Gm-Message-State: AOJu0YyCCzgIjuIERu36o8RnXRd8/RcmgJ+oYjJBk4nXfSvGWOVXUR4e
	CDOBotZw56nRLBnzpwVKpo49T+c16GzRO6kgWZkHMx4Z/c+UrTo3B/BVcWCH+Vw+2LmcnOp7yb6
	Q+0ypAXXdScy/EGossy4k+qOJyNYzOR9wAXXy/2OCwz2lj2c/pk0jhctXyl0N1Q==
X-Gm-Gg: Acq92OEXMVIB2ms9UYPqJYTnVTVG+fmEqKcCV462Ir0mEkv0DswBFu8269PMAq2TJEG
	9Ipyo6AOccsXGDoVfGxWcRwgZIDsI/fUDPrzQRTEHgmslpMPHafhjHjE8LzfsARb+KtlDn2kvEt
	UEaYpLM1tXG9baeyXGQfcjpto7SXIsXhE+MquYBYoaFSJXyxpfsZlN4CkySRR7jq/sb34/yEkD7
	gRRWBczgvE4LUgUyHrQQIpFcyXuyuXe34EZYs4X6X2RrnX3OjGDCMCKX0Xzm6x4GqDr2z8vOEEM
	dQzYCML7EBqvCIch/36SzgPycXzRZPwCN9AcH5L1z05tYayd/YIueeGIFRNI95ctIYRzRznQVEc
	R6zY2QrkAihiUcCEUjIkn10+kGoledJHIbC4=
X-Received: by 2002:a05:600c:1909:b0:490:778:4fe7 with SMTP id 5b1f17b1804b1-4903607857dmr46555015e9.23.1779369853843;
        Thu, 21 May 2026 06:24:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1909:b0:490:778:4fe7 with SMTP id 5b1f17b1804b1-4903607857dmr46553785e9.23.1779369852982;
        Thu, 21 May 2026 06:24:12 -0700 (PDT)
Received: from fedora.redhat.com ([2a00:102b:4000:577b:6abd:c9d7:e4e9:b43a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa92f622sm3202739f8f.24.2026.05.21.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:24:12 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: fix nfs_access_calc_mask() corner cases
Date: Thu, 21 May 2026 15:24:10 +0200
Message-ID: <20260521132410.1072478-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21756-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[omosnace@redhat.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DAED75A6543
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The special case for special files (neither regular file nor directory)
is inconsistent with the perms requested in nfs_do_access() and the
MAY_WRITE condition seems incorrect (checks just `access_result &
NFS_MAY_WRITE` instead of `(access_result & NFS_MAY_WRITE) ==
NFS_MAY_WRITE` as is the pattern for the other cases).

Since nfs_access_calc_mask() requests the same access bits for regular
and special files, we end up with nfs_access_calc_mask() that treats
both the same as well.

Notably, this fixes a corner case inconsistency between NFS and classic
filesystems when calling access("...", X_OK) on special files (i.e.
fifo, block device, and character device; symlink is special here). On
classic filesystems the result of that call depends on the UNIX
permissions of the file, while on NFS it would always fail. See a test
script below that demonstrates this difference:

    tmpdir="$(mktemp -d)"
    trap 'rm -rf "$tmpdir"' EXIT

    systemctl start nfs-server
    exportfs -o rw,no_root_squash,fsid=0 "localhost:$tmpdir"
    mount -t nfs localhost:/ /mnt

    mkfifo "$tmpdir/fifo"
    mknod "$tmpdir/chrdev" c 1 3
    mknod "$tmpdir/blkdev" b 7 0

    for f in fifo chrdev blkdev; do
        python3 -c "import os; print(os.access('$tmpdir/$f', os.X_OK))"
    done

    for f in fifo chrdev blkdev; do
        python3 -c "import os; print(os.access('/mnt/$f', os.X_OK))"
    done

    umount /mnt
    chmod u+x "$tmpdir/"*
    mount -t nfs localhost:/ /mnt

    for f in fifo chrdev blkdev; do
        python3 -c "import os; print(os.access('$tmpdir/$f', os.X_OK))"
    done

    for f in fifo chrdev blkdev; do
        python3 -c "import os; print(os.access('/mnt/$f', os.X_OK))"
    done

    umount /mnt
    exportfs -u "localhost:$tmpdir"

Note that on some Fedora/RHEL systems you may need to also do
`setenforce 0` before running the script, because the SELinux policy
could block the execute permission for the special files on the server
side - this bug will be fixed independently in the policy.

Fixes: ecbb903c5674 ("NFS: Be more careful about mapping file permissions")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/nfs/dir.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e9ce1883288c5..82048c567dbbb 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -3250,12 +3250,11 @@ void nfs_access_add_cache(struct inode *inode, struct nfs_access_entry *set,
 EXPORT_SYMBOL_GPL(nfs_access_add_cache);
 
 #define NFS_MAY_READ (NFS_ACCESS_READ)
-#define NFS_MAY_WRITE (NFS_ACCESS_MODIFY | \
-		NFS_ACCESS_EXTEND | \
-		NFS_ACCESS_DELETE)
 #define NFS_FILE_MAY_WRITE (NFS_ACCESS_MODIFY | \
 		NFS_ACCESS_EXTEND)
-#define NFS_DIR_MAY_WRITE NFS_MAY_WRITE
+#define NFS_DIR_MAY_WRITE (NFS_ACCESS_MODIFY | \
+		NFS_ACCESS_EXTEND | \
+		NFS_ACCESS_DELETE)
 #define NFS_MAY_LOOKUP (NFS_ACCESS_LOOKUP)
 #define NFS_MAY_EXECUTE (NFS_ACCESS_EXECUTE)
 static int
@@ -3270,13 +3269,12 @@ nfs_access_calc_mask(u32 access_result, umode_t umode)
 			mask |= MAY_WRITE;
 		if ((access_result & NFS_MAY_LOOKUP) == NFS_MAY_LOOKUP)
 			mask |= MAY_EXEC;
-	} else if (S_ISREG(umode)) {
+	} else {
 		if ((access_result & NFS_FILE_MAY_WRITE) == NFS_FILE_MAY_WRITE)
 			mask |= MAY_WRITE;
 		if ((access_result & NFS_MAY_EXECUTE) == NFS_MAY_EXECUTE)
 			mask |= MAY_EXEC;
-	} else if (access_result & NFS_MAY_WRITE)
-			mask |= MAY_WRITE;
+	}
 	return mask;
 }
 
-- 
2.54.0


