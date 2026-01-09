Return-Path: <linux-nfs+bounces-17691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01727D0AAD6
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 831C430533C2
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACAE35E53F;
	Fri,  9 Jan 2026 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAX7CjjA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E43612C9;
	Fri,  9 Jan 2026 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969591; cv=none; b=NWuYS06dj8ymzcCepxrMzqEYTrqaKK098WeoJ8UE9kNC7vGDmHIHcXVP9L47P0Rou12k81+lyDnUHwuXc6WhDOswsOsl+QtfoDwQza/FjrslRAigAuXm/PR4fGBXEkV9cmsDbo7DS3slOId1QicStFkGB3dU4iwidV/IrGwbeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969591; c=relaxed/simple;
	bh=AZEKedAFNo5RTf60sXjdfVmiFYuZh4+qmIvmbAWHGyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDZMhwxWM9W82q4x+XyL0Rz49dWW2yl91q9ZiZFIdfdA6kgF7RFh28WW1QbcPijG+5FZOqHdejWQiFgfHcSKlVYlGPgESv20NO6mYTgpttFOvpSpVH3hjn7Qtbkq9FBRrR1d1Uy5CuXwekWIvTMP8M2qjPLAThAjJ81Jt/WJtc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAX7CjjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7464BC4CEF1;
	Fri,  9 Jan 2026 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969591;
	bh=AZEKedAFNo5RTf60sXjdfVmiFYuZh4+qmIvmbAWHGyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAX7CjjATW5+i804ao78z9li/gFtCbaETkK61TOvW7Bc7Zi9yWwByQ9r95kKRdiTs
	 ljbdA02uXHfkfLyjQMOSMEwxvVqrx7kHVXvNUGzM0/P7vQnkPsXyKsQBjfI3NipXq/
	 Zxjac+RNhYobkMEoKcdV6PrTKLAZ/wL1F3xBH67K/Xu6QFFCVG0tKcJyrGTgF6KGbR
	 e+LFo02ByS9qQJ2IqAthNTy17ASyCT6NzNC0Obekx1GrBIcvK3Vk9irNBFQJElhxva
	 n7K4/iQ0kuUuHZxmzl8Mi7ut1wKmRs2NBfmQjhNmIUWXq5Jy825G7/JWzdUTVD4/Yu
	 9aGuiD8sw5lIw==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH 6.6.y v3 3/4] nfsd: set security label during create operations
Date: Fri,  9 Jan 2026 09:39:45 -0500
Message-ID: <20260109143946.4173043-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025122941-civic-revered-b250@gregkh>
References: <2025122941-civic-revered-b250@gregkh>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stephen Smalley <stephen.smalley.work@gmail.com>

[ Upstream commit 442d27ff09a218b61020ab56387dbc508ad6bfa6 ]

When security labeling is enabled, the client can pass a file security
label as part of a create operation for the new file, similar to mode
and other attributes. At present, the security label is received by nfsd
and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
called and therefore the label is never set on the new file. This bug
may have been introduced on or around commit d6a97d3f589a ("NFSD:
add security label to struct nfsd_attrs"). Looking at nfsd_setattr()
I am uncertain as to whether the same issue presents for
file ACLs and therefore requires a similar fix for those.

An alternative approach would be to introduce a new LSM hook to set the
"create SID" of the current task prior to the actual file creation, which
would atomically label the new inode at creation time. This would be better
for SELinux and a similar approach has been used previously
(see security_dentry_create_files_as) but perhaps not usable by other LSMs.

Reproducer:
1. Install a Linux distro with SELinux - Fedora is easiest
2. git clone https://github.com/SELinuxProject/selinux-testsuite
3. Install the requisite dependencies per selinux-testsuite/README.md
4. Run something like the following script:
MOUNT=$HOME/selinux-testsuite
sudo systemctl start nfs-server
sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
sudo mkdir -p /mnt/selinux-testsuite
sudo mount -t nfs -o vers=4.2 localhost:$MOUNT /mnt/selinux-testsuite
pushd /mnt/selinux-testsuite/
sudo make -C policy load
pushd tests/filesystem
sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
        -e test_filesystem_filetranscon_t -v
sudo rm -f trans_test_file
popd
sudo make -C policy unload
popd
sudo umount /mnt/selinux-testsuite
sudo exportfs -u localhost:$MOUNT
sudo rmdir /mnt/selinux-testsuite
sudo systemctl stop nfs-server

Expected output:
<eliding noise from commands run prior to or after the test itself>
Process context:
        unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
Created file: trans_test_file
File context: unconfined_u:object_r:test_filesystem_filetranscon_t:s0
File context is correct

Actual output:
<eliding noise from commands run prior to or after the test itself>
Process context:
        unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
Created file: trans_test_file
File context: system_u:object_r:test_file_t:s0
File context error, expected:
        test_filesystem_filetranscon_t
got:
        test_file_t

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Stable-dep-of: 913f7cf77bf1 ("NFSD: NFSv4 file creation neglects setting ACL")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 2 +-
 fs/nfsd/vfs.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 51c2ad3847c4..d2ca0739ae81 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1379,7 +1379,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * Callers expect new file metadata to be committed even
 	 * if the attributes have not changed.
 	 */
-	if (iap->ia_valid)
+	if (nfsd_attrs_valid(attrs))
 		status = nfsd_setattr(rqstp, resfhp, attrs, NULL);
 	else
 		status = nfserrno(commit_metadata(resfhp));
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index b476028e020b..df9baaee052e 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -60,6 +60,14 @@ static inline void nfsd_attrs_free(struct nfsd_attrs *attrs)
 	posix_acl_release(attrs->na_dpacl);
 }
 
+static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
+{
+	struct iattr *iap = attrs->na_iattr;
+
+	return (iap->ia_valid || (attrs->na_seclabel &&
+		attrs->na_seclabel->len));
+}
+
 __be32		nfserrno (int errno);
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
-- 
2.52.0


