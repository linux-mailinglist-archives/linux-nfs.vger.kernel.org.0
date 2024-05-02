Return-Path: <linux-nfs+bounces-3137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3EA8BA139
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 22:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F371C2147E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BFF17F37D;
	Thu,  2 May 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrXlz3OL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4128717BB21;
	Thu,  2 May 2024 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680064; cv=none; b=nnaSTLZnoLf7v2wkGXNlWh+d6n3jRqIu8yho/dExRsZ8rhVz35wUAtP/1gx010kCLuUjlTtXp307bke0a3UB0b/u1FvhCztG8zF6mvKc5CS/YNVfmI/r1BkFS4w0HtnER4wnBBUPjn75QZ5Fz45niJqr7MocDJwbWhYIvW1stBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680064; c=relaxed/simple;
	bh=rn4Yfmm7yt286UsRRKZd4puA9l7n31/HavEaBnKPs04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q1z0subnkM00N1NNlRiOv+SRcERGcwKo5vPoub/5ykXQyon3KopmB30kAXa6CdlQoZ4tNgp07pIUxQ0utapOoLT/aqST8Y9WumKmbYu2EsU6qU516xoQb1F2lw2kqXHc6ngQoslp5sGlQeOQB4F/QOwpmXVKIUmzePVKt1LvZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrXlz3OL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4371955d27fso51428591cf.0;
        Thu, 02 May 2024 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680062; x=1715284862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrvslWZpt0+ROBn+i7xX3LaQIiYYUEBB4cf3XHd6iwU=;
        b=TrXlz3OLYfstivBbOZ/XSVXP8ZvmeUsTBlPVk0yBZ3Orzz8y+yVjH7WyhauGQdgVuO
         +PB5vlRnc5c9RGRUIV7KdrUiimWHwtr+Wp9gvLtkVsdepcOz7rc2G8lPAUglsN+cNbki
         KHYSfgJMX7b3wibUUVTi/6fOMWIAFJlnUOBkB2YMH9ugTYs1htH1vVof81mjOlYjSfXK
         jQ8m/q8BDgOPu9GjIpBStCU415SG6Pfi8DQTK2gKE6SYHp/jDN6Jy6+2cfUSLv6h+t5f
         adI7RsjBSLyD9wA1zd4COOpMlfDithFB0G7whPz3aJ8vNqM3iggv2b4w+UaKPK0Zuky/
         9bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680062; x=1715284862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrvslWZpt0+ROBn+i7xX3LaQIiYYUEBB4cf3XHd6iwU=;
        b=R9geDBNZnAzsYFPrVa+d+8Of0sdoeUh2pBKcsl/MhkO+sqMeDAEv2dHjGp7z1JhVcI
         CHqvSygZvRBf9htE5J344cU3mGKt98KsdyTImQXQ8s3EI5KZPGOGpjk2PxnV4dZ6CfCO
         f5N7KvfrLGScWhdOgQYiRi1Ia+PMrzxIpWDScN/MkmydJPoTfoEpL4HwdCmG/JdN1sPQ
         dNCododpykzDvVi/2/O4L9Fxe8wDXjr/IIL1NxZj2/XOlgULRApFTQeuoXc7cWS7NYeI
         zAFb7rAs9dIqeY0qvZNRSt0mu666faiD06Mte6pJMkj+LtHiSJzt8F6b3BwUnpRu7Nlf
         hegA==
X-Forwarded-Encrypted: i=1; AJvYcCXzBAIqHPFQhMuzJtMr8Q0uwYRcD/rPgJYmcmYRtu5osX4RCG+y/QWP3GSi29Xy/Gn3jLBNseImdjWMbfstr1hChhqw8XYrdtxErEcDCXPlC4PoaP54lPm+oinmQzwBl6aIiuD83MqjKlutXZdt+TAF
X-Gm-Message-State: AOJu0YyU1yOZSEv9q9OAfBaCYD7+JyA11FdwMtZ9P2j6ImX/iHbqSHYJ
	PVkzVfg6JSnKoqa6Cf5inWxkD+LGPot3LfEHsxV+BLwvqDrpZlGPW/S36g==
X-Google-Smtp-Source: AGHT+IHQNvWvV9+/WH8p4brLmimptfMON317VG6pccXNgkFqH0QhQgTkBrlbB0nZXjw+WtCvSMsWww==
X-Received: by 2002:ac8:5d0b:0:b0:439:e95e:5bc0 with SMTP id f11-20020ac85d0b000000b00439e95e5bc0mr664626qtx.40.1714680061688;
        Thu, 02 May 2024 13:01:01 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05622a4e9100b0043ae234c0f2sm775847qtb.36.2024.05.02.13.01.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2024 13:01:01 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	linux-security-module@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] nfsd: set security label during create operations
Date: Thu,  2 May 2024 15:58:01 -0400
Message-Id: <20240502195800.3252-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When security labeling is enabled, the client can pass a file security
label as part of a create operation for the new file, similar to mode
and other attributes. At present, the security label is received by nfsd
and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
called and therefore the label is never set on the new file. I couldn't
tell if this has always been broken or broke at some point in time. Looking
at nfsd_setattr() I am uncertain as to whether the same issue presents for
file ACLs and therefore requires a similar fix for those. I am not overly
confident that this is the right solution.

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
---
v2 introduces a nfsd_attrs_valid() helper and uses it as suggested by
Jeffrey Layton <jlayton@kernel.org>.

 fs/nfsd/nfsproc.c | 2 +-
 fs/nfsd/vfs.c     | 2 +-
 fs/nfsd/vfs.h     | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 36370b957b63..3e438159f561 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -389,7 +389,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 * open(..., O_CREAT|O_TRUNC|O_WRONLY).
 		 */
 		attr->ia_valid &= ATTR_SIZE;
-		if (attr->ia_valid)
+		if (nfsd_attrs_valid(attr))
 			resp->status = nfsd_setattr(rqstp, newfhp, &attrs,
 						    NULL);
 	}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2e41eb4c3cec..29b1f3613800 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1422,7 +1422,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * Callers expect new file metadata to be committed even
 	 * if the attributes have not changed.
 	 */
-	if (iap->ia_valid)
+	if (nfsd_attrs_valid(attrs))
 		status = nfsd_setattr(rqstp, resfhp, attrs, NULL);
 	else
 		status = nfserrno(commit_metadata(resfhp));
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index c60fdb6200fd..57cd70062048 100644
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
2.40.1


