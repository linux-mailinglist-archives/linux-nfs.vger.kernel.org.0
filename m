Return-Path: <linux-nfs+bounces-3133-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B58B9FF2
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CAC1F2411D
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849031553BB;
	Thu,  2 May 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuvvuHNH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A8171080;
	Thu,  2 May 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672829; cv=none; b=tMVHETJuPw0RFtX2gXNOZSMnMZw5NNmPkA5l2Tkd5t3oJB5op1SogYcM64XDjYtzPEURFv4m9ichF2Nryx//RFTNx48XU4MNioA6J3Rvu1VrmbyazmCa34YZ31nc5RVSb+PE5FsUTDNSjEBBaKxISrWP+zsgyjN620cAP8yva9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672829; c=relaxed/simple;
	bh=QDXTnY5oZWprMy/6g95ltVBXAjwW3gizThBMdvsLY7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BOJL4DN9DfBBxXULeSdJsNXLWR+8Px/Asju7Pf6lR0uxTJU0kV1ds3RyR98ZIHPK/yk8xNzoW41lC5mf3VjA2EPNU6G14dEw76a9eUa2YOTPxi3OOujKQwn//3ZlsccqHXv/Q5yeCbdWxdBy3jlBjXrRmuBl0ez+WMGSyU4jsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuvvuHNH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f05e56cb3so514234385a.1;
        Thu, 02 May 2024 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714672826; x=1715277626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jflkGh1PW9nu6fE5YGWWi/1uR1xUydBgrE4IGl9JWJM=;
        b=TuvvuHNHuk84AtWzP63snD1I9ozXeWvc4mBOlW8E15nnWlx2BWgi7Ig0ImhM+b7pVs
         36C7GALR0neCL0oHykCZaj+Aq1tN63mfQYyjJTCMTVNSyg6Rf/Ac6rwA/PxmlUy48IwI
         YWKnnd5W96Y8q9tMcD6vRjTGPKo5fudpGO7rJaf9h4Ny7uMHYiddO69APWzEWZi/wP1a
         WJy1S0OUwie59a3v0eOwkcEm6WQl3auZpLXkGBEH6fH0WlIZ232ZLw+7KApAcZZ41FH5
         oygOtMXVt+kBNUP97SdWSLaVifevFcWkIcZXoBy1D77tsOE6R9b4BbsPPGuMN4FQVREL
         dHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714672826; x=1715277626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jflkGh1PW9nu6fE5YGWWi/1uR1xUydBgrE4IGl9JWJM=;
        b=TDbIT2gAFeSJokOy8HdJ7lcn7nNFjY+T5fP7nGVx1puPY6NcXiQqSnqTGCjOxRZhUN
         GuaiTYMepcrwDqJDIlwuzCMQxQ5h8whLRPTecnZ8HoF4W2CHn/dM2PbLNmDCp47XRPxP
         UiYugC6FmeAF6NHjSWxbEBMdlkuXYDTMm2td21XloBBwa46O21LSrc/J4JejlJab9/yn
         7kgSlAZBL8w3SNu6Ds4uvNStE1vN+qwYmuWP1N6n3gdxeiitz04D6ILf71WV+MJpFwGY
         nliacu6f6LJ+9p2LC2hEGVUu/0ZFNzbfytzi9xvGrHmzivQ8iFTvLKVk0DpFH1RVxhPR
         xeIw==
X-Forwarded-Encrypted: i=1; AJvYcCW+AW64H92OjC0zXdifdKA63RFyKtglgd7tSvtDp2bFi2AT1WFy9EXkg+8qaNSK0Fop0mXV+DwqohxEtLyTLwQpzsTiKAZRHtn3lFYtmCQRY3N+2LOZhouL8FKqj+TP6s6jGwypxpXix695WKB4HVH7
X-Gm-Message-State: AOJu0YybmgvzF+BUICelOjlXUS4GO1pgifSWWzUyjUuL6VCdv4hDbhk8
	emsS0IWMVzfvZlIMPRKs/Lfnm+R0oVs4Gu/3C+XUcgHsnJQyqI49V3UaWg==
X-Google-Smtp-Source: AGHT+IH0uUBvTsO5EBUgye00Z5uyZfFBMYEPiOD1EKtzl4/7UMaN2rqHawVPjv7wbPFZoFdEFR3DKQ==
X-Received: by 2002:ac8:5a83:0:b0:43a:ffa5:3f24 with SMTP id c3-20020ac85a83000000b0043affa53f24mr246459qtc.58.1714672826045;
        Thu, 02 May 2024 11:00:26 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id fx7-20020a05622a4ac700b004366d3eef03sm670826qtb.68.2024.05.02.11.00.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2024 11:00:25 -0700 (PDT)
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
Subject: [RFC][PATCH] nfsd: set security label during create operations
Date: Thu,  2 May 2024 13:58:19 -0400
Message-Id: <20240502175818.21890-1-stephen.smalley.work@gmail.com>
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
 fs/nfsd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2e41eb4c3cec..9b777ea7ef26 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1422,7 +1422,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * Callers expect new file metadata to be committed even
 	 * if the attributes have not changed.
 	 */
-	if (iap->ia_valid)
+	if (iap->ia_valid || (attrs->na_seclabel && attrs->na_seclabel->len))
 		status = nfsd_setattr(rqstp, resfhp, attrs, NULL);
 	else
 		status = nfserrno(commit_metadata(resfhp));
-- 
2.40.1


