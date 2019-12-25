Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A684412A5D5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2019 04:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLYDfN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Dec 2019 22:35:13 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43774 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLYDfN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Dec 2019 22:35:13 -0500
Received: by mail-yw1-f65.google.com with SMTP id v126so8985915ywc.10;
        Tue, 24 Dec 2019 19:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=f7OdTVI7jtXrQm/7QUzasuPuN5M09Cg0stJpVqfXKeQ=;
        b=WHmWnkkWxsjSjUbUY0wzaOSTQSCHe0qF+Sh1LbvNUMl67+SUB4MXdKP8HpymHwrYv3
         6k7K9Ij/OX3hmUZzWk03CJqB8zGkIoADgSTsBqK3mXOFUPbE9VR7LfCmDmtEHZ/Ybmd1
         YBc+bqkedII6MSPlFfw+NAdonA0w4xqVYIGNMgoEoW2U/imA5qYTWnCR0BJHUKdD4cDG
         CwB5u6hPsFg2eEpjLKEyTF5C491Xb8PZ+EjpmgrB0Mhim2ab1fq7fsRp6CO9Fqy1+P8B
         2jHPW72Lqz2SlTqsNTGlo1gtUL8mhTB8WP0GA4FE1j+JXYfIfKvnRFITWYu5t6/akpSK
         K4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=f7OdTVI7jtXrQm/7QUzasuPuN5M09Cg0stJpVqfXKeQ=;
        b=tE5rQc7PTbygJ2snoA1fSqDMHW59h2QFh69HrKs7sXR+tCPYZD/WZk31y3zZM5az2H
         We5PCNTcdHhbz9LXv2NbokoBMtZOLTNQNxU0HTN+ftSjRB3mYgQgjbfCOmVeEWD01JSK
         r+bz6XG8UV6Ha0YH5GxS04PTxLMdkLzuvqYpqG0ZhN+i/urArKDRHyYH2QyjLPrankLE
         OOGplp5XH7l0rSs7MdHBug2nNPiCh+25CGsmoz7tfyGrS2GY3YQNot6QprtHAkVUIYWU
         YEi8IiKylKxjYkMzI3UIZu4iSkd2lrm1CEkRsFgaTW6JG3Zc+eZhhdBZC7/u0LT0inPU
         swPg==
X-Gm-Message-State: APjAAAXPVpWgEfYkn/5sruUM/fNyE4yHqFqIHo7rqwJKs/TBV9rtMVJp
        Prl36gS2gZewrcYgRPHCrJLlkmdgDBw=
X-Google-Smtp-Source: APXvYqwUMy6rvG29I7N4EOQQjmmU5tQ/oGTvBJf3VdxU9GrfnE7jctaOMygTr25SbzA4eXKXx+YaRQ==
X-Received: by 2002:a0d:d4cb:: with SMTP id w194mr28057103ywd.263.1577244911769;
        Tue, 24 Dec 2019 19:35:11 -0800 (PST)
Received: from [0.0.0.0] ([107.175.31.166])
        by smtp.gmail.com with ESMTPSA id 144sm10437319ywy.20.2019.12.24.19.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 19:35:11 -0800 (PST)
From:   Su Yanjun <suyanjun218@gmail.com>
Subject: [PATCH] NFSv3: FIx bug when using chacl and chmod to change acl
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <0f14d9f5-c937-783b-d88f-047e78502f71@gmail.com>
Date:   Wed, 25 Dec 2019 11:37:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We find a bug when running test under nfsv3  as below.
1)
chacl u::r--,g::rwx,o:rw- file1
2)
chmod u+w file1
3)
chacl -l file1

We expect u::rw-, but it shows u::r--, more likely it returns the
cached acl in inode.

We dig the code find that the code path is different.

chacl->..->__nfs3_proc_setacls->nfs_zap_acl_cache
Then nfs_zap_acl_cache clears the NFS_INO_INVALID_ACL in
NFS_I(inode)->cache_validity.

chmod->..->nfs3_proc_setattr
Because NFS_INO_INVALID_ACL has been cleared by chacl path,
nfs_zap_acl_cache wont be called.

nfs_setattr_update_inode will set NFS_INO_INVALID_ACL so let it
before nfs_zap_acl_cache call.

Signed-off-by: Su Yanjun <suyanjun218@gmail.com>
---
 fs/nfs/nfs3proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 9eb2f1a503ab..6d736f0ac811 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -140,9 +140,9 @@ nfs3_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
     nfs_fattr_init(fattr);
     status = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
     if (status == 0) {
+        nfs_setattr_update_inode(inode, sattr, fattr);
         if (NFS_I(inode)->cache_validity & NFS_INO_INVALID_ACL)
             nfs_zap_acl_cache(inode);
-        nfs_setattr_update_inode(inode, sattr, fattr);
     }
     dprintk("NFS reply setattr: %d\n", status);
     return status;

-- 
2.17.1

