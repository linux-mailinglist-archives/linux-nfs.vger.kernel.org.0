Return-Path: <linux-nfs+bounces-3147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488AE8BAD3D
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3031281CD1
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C26215380B;
	Fri,  3 May 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/Oirgph"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A841BF24;
	Fri,  3 May 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741871; cv=none; b=oWmc6B+TEwpHIg6fYx8jHakSnV1vCaKxWE9SnZcAU5T5hto4xQca/LyXNnTzQis/4vzTp+FmwIRaRr/aHGohNB2waurjuw7rgQTvJhoQ4ufeOko69BpIYS4eCDl/bgvdDfN4h3/0Nf2nj1b25gDs94y+a0Njdc1AoHZ4DZKkybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741871; c=relaxed/simple;
	bh=fy3d2B/QhqrT7TtUJZHMmpRVS6MKTvHs89qp+kRDwlk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pi05cXSyH+YRoOeLgB4eLmqq4smqFGK5Oz5aCadIt269G1IfzZhKyOJXy8VYauKhOwGhCzdeOUuZU4zfHDuQmVjd1LTMoTOAdcIBncWetiAx+MROSwzUy7VzlLn020tgcYixHKmC+kIOl47mCNesvejNCG3WwKhQnSiO6m8cxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/Oirgph; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-790f91b834cso454317985a.0;
        Fri, 03 May 2024 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714741868; x=1715346668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPktYCeoSzQNmJIPtV72hrJJ3ni3uhRivPHWfBHCi5s=;
        b=E/Oirgph5m/fT63u0DKtuNAW7hkz7HFaxxuE0e7/wLxt29sS0n6+uiElNgdtj0r86J
         0q6G6Ks6JTuUHWHkF/1wfdPThD6pP02WPaF1+fnocGsQ7xp6zix8s7WVVdT4nG0jYNhf
         pGcktsHnzbO7/5Q2dBM/SHUKKOCwLGsIoURPyh2GKDlEykqbkH0C3sftTvGuYvs7Q8am
         Uh5mFZKMlLjk6cxtL/CKlpveu7Kovs0DWyJvFa5ED9mZWuiLiBazKuvnZHaIzIaC6eH+
         409sgtTBXKorPDJ4wlu7be6vLXC5hOddMUDvXEd2UUYPg12YLLE4pZoTcM7btD1o1JNx
         jxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714741868; x=1715346668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPktYCeoSzQNmJIPtV72hrJJ3ni3uhRivPHWfBHCi5s=;
        b=hCXowX2YKL/UUptez5zByrWl3ESz58w3uxJhuX9LP9JnDmpWEac7cdXF6ttFIWb+hD
         XIgEjAd8+VtIQaXerzx6EHTCDmn8vV2KTlIKJ+aCRtSzvGgS6tg/F66/Ep+9nkJJltEw
         QxZyGJX3jQ1XIKLNy8q31p4ntwqmId+5nhXI9tmkx1XYO5karrFj7AwMxV0C/P4L0/hK
         LB7AEKU55TxifS4xTkJY/jCkggD58Q4OUduANihF6KMdWBf7sgMmix/Z0QoyV51SzmiM
         pLbyGZqM3hcdjHI6jJZyHuSrx5dpPn3z9v6eaoVYgH+3Xp1/yhyUwxt171wWFm7BVrp6
         fAog==
X-Forwarded-Encrypted: i=1; AJvYcCXPyw5ZvH8PD5urcm8AsvToFM7Ldlas0pINTh7pD8eC0vwT7NtYPsTELutM8lVq9xXUdcPjq5SVj1riZCVV8O5xWYWLKXdKhzt5Tbw15UvF1qJMPa+8hC9SgOsHHtGo/K3ITPDG0K353NatEYxmO3Op
X-Gm-Message-State: AOJu0YxQWKpCoCoxiyUpp9x1pI7s+VbqbmgGF2XrCg+No4c75fDdGtqO
	QqBF1/SqKUi/gxKhFInJl5j5EEZlxRW/kOZEWs/j6tqatkDr6syUAs79iQ==
X-Google-Smtp-Source: AGHT+IHML979sIEIWV2ccwp+b1hIlYP8W5fwHS/aGlDmXGn3v4jCkAeXGveUp1qmOE/y38Eb2YrYkA==
X-Received: by 2002:a37:c446:0:b0:792:63fb:aacd with SMTP id h6-20020a37c446000000b0079263fbaacdmr2501801qkm.25.1714741868102;
        Fri, 03 May 2024 06:11:08 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id vz27-20020a05620a495b00b0078d68b23254sm1214809qkn.107.2024.05.03.06.11.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2024 06:11:07 -0700 (PDT)
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
Subject: [PATCH v3] nfsd: set security label during create operations
Date: Fri,  3 May 2024 09:09:06 -0400
Message-Id: <20240503130905.16823-1-stephen.smalley.work@gmail.com>
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
---
v3 removes the erroneous and unnecessary change to NFSv2 and updates the
description to note the possible origin of the bug. I did not add a 
Fixes tag however as I have not yet tried confirming that.

 fs/nfsd/vfs.c | 2 +-
 fs/nfsd/vfs.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

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


