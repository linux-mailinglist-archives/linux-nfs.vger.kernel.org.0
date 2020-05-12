Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B81D00D4
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgELVYj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731334AbgELVYj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:24:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19854C061A0C;
        Tue, 12 May 2020 14:24:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id a136so6308189qkg.6;
        Tue, 12 May 2020 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=k4aFKZu7Ir4BTmsKFh4XOyBP0EdUtSdQg2tscndZkEA=;
        b=M+jVFcTcJSeCBnmcmEiK2kPUr7D/qnL8f2t9aTTtMIlMxdlSu7L9v4Pv61jB65Vzem
         dEHHAc8E9SDeuJ0MW6wI1xVIwMtuyF4SXdRPH1sTzQ1NjrkH36bbyxyT+uaivj5B1BBR
         xZJs3yug7nKmIPJ2p54fJQAU7zzBzuLDjoIuxQxhubxtAW0lgz5wRjaD9h5pHD+zI+Ba
         YnwtVWXi+D6JYU04Z7q+58bHYvdVvjanyly9Ej7iIF87p7js/5kC777TWFBZ/T2SqUwv
         ydaafYsM6d8u2ifOTFoX9ArOCGgloSgPj5FayY92rXvOlyiNUF/5NtXpMsTCv5TPbxLt
         t3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=k4aFKZu7Ir4BTmsKFh4XOyBP0EdUtSdQg2tscndZkEA=;
        b=dTDYNYh8azxqG0q/OOaeyWgVlchGVQayOj2KZBMFamezPrHhWJptGwZeHXMOtZbt6H
         VVHBE358KLP+fjgrzEgnQSB1H39B678UJ65VoKd3NMcjNWyGSbb0tI++8HIAKU3wGq4B
         205yd4LQ/cKUb8G+aN9PiGPkQlZk62gpUSUqyNrbhvDXbohrCcFH04rpQ/7zumnE2dO1
         jp6fZQ5Vru8o7d1HwpfTFWzrcZUf5eVXS2YRL9oTW5wZPE9y/tnp4M31UUdW/prT0qQV
         UG7EWRBFvwiY62kt6EeYL8O1RQmsmS0IjbVZKkgsaxDWYo5P2T/CiKpZDeY8NL/EWkuq
         o6IA==
X-Gm-Message-State: AGi0PuZLmKGKnbVQ6y6ZYydu51TxUF+13illxV6w4EphOQGlgiWPd6j6
        HKjBB/PzhKgeqyZ3VGI012pkj6nn
X-Google-Smtp-Source: APiQypI6Dv6llDwJwnfJOABbUlW+jI5qhq5LP/2DiJmSUuAsbm0PAEAruooW9loMHX/H9QfK/eVfjw==
X-Received: by 2002:a05:620a:484:: with SMTP id 4mr12021090qkr.1.1589318677925;
        Tue, 12 May 2020 14:24:37 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u56sm5261914qtb.91.2020.05.12.14.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:24:37 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLOarv009963;
        Tue, 12 May 2020 21:24:36 GMT
Subject: [PATCH v2 29/29] NFSD: Fix improperly-formatted Doxygen comments
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:24:36 -0400
Message-ID: <20200512212436.5826.37327.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

fs/nfsd/nfsctl.c:256: warning: Function parameter or member 'file' not described in 'write_unlock_ip'
fs/nfsd/nfsctl.c:256: warning: Function parameter or member 'buf' not described in 'write_unlock_ip'
fs/nfsd/nfsctl.c:256: warning: Function parameter or member 'size' not described in 'write_unlock_ip'
fs/nfsd/nfsctl.c:295: warning: Function parameter or member 'file' not described in 'write_unlock_fs'
fs/nfsd/nfsctl.c:295: warning: Function parameter or member 'buf' not described in 'write_unlock_fs'
fs/nfsd/nfsctl.c:295: warning: Function parameter or member 'size' not described in 'write_unlock_fs'
fs/nfsd/nfsctl.c:352: warning: Function parameter or member 'file' not described in 'write_filehandle'
fs/nfsd/nfsctl.c:352: warning: Function parameter or member 'buf' not described in 'write_filehandle'
fs/nfsd/nfsctl.c:352: warning: Function parameter or member 'size' not described in 'write_filehandle'
fs/nfsd/nfsctl.c:434: warning: Function parameter or member 'file' not described in 'write_threads'
fs/nfsd/nfsctl.c:434: warning: Function parameter or member 'buf' not described in 'write_threads'
fs/nfsd/nfsctl.c:434: warning: Function parameter or member 'size' not described in 'write_threads'
fs/nfsd/nfsctl.c:478: warning: Function parameter or member 'file' not described in 'write_pool_threads'
fs/nfsd/nfsctl.c:478: warning: Function parameter or member 'buf' not described in 'write_pool_threads'
fs/nfsd/nfsctl.c:478: warning: Function parameter or member 'size' not described in 'write_pool_threads'
fs/nfsd/nfsctl.c:697: warning: Function parameter or member 'file' not described in 'write_versions'
fs/nfsd/nfsctl.c:697: warning: Function parameter or member 'buf' not described in 'write_versions'
fs/nfsd/nfsctl.c:697: warning: Function parameter or member 'size' not described in 'write_versions'
fs/nfsd/nfsctl.c:858: warning: Function parameter or member 'file' not described in 'write_ports'
fs/nfsd/nfsctl.c:858: warning: Function parameter or member 'buf' not described in 'write_ports'
fs/nfsd/nfsctl.c:858: warning: Function parameter or member 'size' not described in 'write_ports'
fs/nfsd/nfsctl.c:892: warning: Function parameter or member 'file' not described in 'write_maxblksize'
fs/nfsd/nfsctl.c:892: warning: Function parameter or member 'buf' not described in 'write_maxblksize'
fs/nfsd/nfsctl.c:892: warning: Function parameter or member 'size' not described in 'write_maxblksize'
fs/nfsd/nfsctl.c:941: warning: Function parameter or member 'file' not described in 'write_maxconn'
fs/nfsd/nfsctl.c:941: warning: Function parameter or member 'buf' not described in 'write_maxconn'
fs/nfsd/nfsctl.c:941: warning: Function parameter or member 'size' not described in 'write_maxconn'
fs/nfsd/nfsctl.c:1023: warning: Function parameter or member 'file' not described in 'write_leasetime'
fs/nfsd/nfsctl.c:1023: warning: Function parameter or member 'buf' not described in 'write_leasetime'
fs/nfsd/nfsctl.c:1023: warning: Function parameter or member 'size' not described in 'write_leasetime'
fs/nfsd/nfsctl.c:1039: warning: Function parameter or member 'file' not described in 'write_gracetime'
fs/nfsd/nfsctl.c:1039: warning: Function parameter or member 'buf' not described in 'write_gracetime'
fs/nfsd/nfsctl.c:1039: warning: Function parameter or member 'size' not described in 'write_gracetime'
fs/nfsd/nfsctl.c:1094: warning: Function parameter or member 'file' not described in 'write_recoverydir'
fs/nfsd/nfsctl.c:1094: warning: Function parameter or member 'buf' not described in 'write_recoverydir'
fs/nfsd/nfsctl.c:1094: warning: Function parameter or member 'size' not described in 'write_recoverydir'
fs/nfsd/nfsctl.c:1125: warning: Function parameter or member 'file' not described in 'write_v4_end_grace'
fs/nfsd/nfsctl.c:1125: warning: Function parameter or member 'buf' not described in 'write_v4_end_grace'
fs/nfsd/nfsctl.c:1125: warning: Function parameter or member 'size' not described in 'write_v4_end_grace'

fs/nfsd/nfs4proc.c:1164: warning: Function parameter or member 'nss' not described in 'nfsd4_interssc_connect'
fs/nfsd/nfs4proc.c:1164: warning: Function parameter or member 'rqstp' not described in 'nfsd4_interssc_connect'
fs/nfsd/nfs4proc.c:1164: warning: Function parameter or member 'mount' not described in 'nfsd4_interssc_connect'
fs/nfsd/nfs4proc.c:1262: warning: Function parameter or member 'rqstp' not described in 'nfsd4_setup_inter_ssc'
fs/nfsd/nfs4proc.c:1262: warning: Function parameter or member 'cstate' not described in 'nfsd4_setup_inter_ssc'
fs/nfsd/nfs4proc.c:1262: warning: Function parameter or member 'copy' not described in 'nfsd4_setup_inter_ssc'
fs/nfsd/nfs4proc.c:1262: warning: Function parameter or member 'mount' not described in 'nfsd4_setup_inter_ssc'

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    7 +++----
 fs/nfsd/nfsctl.c   |   26 +++++++++++++-------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0e75f7fb5fec..ec1b28d08c1c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1155,7 +1155,7 @@ extern void nfs_sb_deactive(struct super_block *sb);
 
 #define NFSD42_INTERSSC_MOUNTOPS "vers=4.2,addr=%s,sec=sys"
 
-/**
+/*
  * Support one copy source server for now.
  */
 static __be32
@@ -1245,10 +1245,9 @@ nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
 	mntput(ss_mnt);
 }
 
-/**
- * nfsd4_setup_inter_ssc
- *
+/*
  * Verify COPY destination stateid.
+ *
  * Connect to the source server with NFSv4.1.
  * Create the source struct file for nfsd_copy_range.
  * Called with COPY cstate:
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3bb2db947d29..b48eac3bb72b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -238,7 +238,7 @@ static inline struct net *netns(struct file *file)
 	return file_inode(file)->i_sb->s_fs_info;
 }
 
-/**
+/*
  * write_unlock_ip - Release all locks used by a client
  *
  * Experimental.
@@ -277,7 +277,7 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 	return nlmsvc_unlock_all_by_ip(sap);
 }
 
-/**
+/*
  * write_unlock_fs - Release all locks on a local file system
  *
  * Experimental.
@@ -327,7 +327,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	return error;
 }
 
-/**
+/*
  * write_filehandle - Get a variable-length NFS file handle by path
  *
  * On input, the buffer contains a '\n'-terminated C string comprised of
@@ -402,7 +402,7 @@ static ssize_t write_filehandle(struct file *file, char *buf, size_t size)
 	return mesg - buf;	
 }
 
-/**
+/*
  * write_threads - Start NFSD, or report the current number of running threads
  *
  * Input:
@@ -452,7 +452,7 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%d\n", rv);
 }
 
-/**
+/*
  * write_pool_threads - Set or report the current number of threads per pool
  *
  * Input:
@@ -661,7 +661,7 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
 	return tlen + len;
 }
 
-/**
+/*
  * write_versions - Set or report the available NFS protocol versions
  *
  * Input:
@@ -811,7 +811,7 @@ static ssize_t __write_ports(struct file *file, char *buf, size_t size,
 	return -EINVAL;
 }
 
-/**
+/*
  * write_ports - Pass a socket file descriptor or transport name to listen on
  *
  * Input:
@@ -867,7 +867,7 @@ static ssize_t write_ports(struct file *file, char *buf, size_t size)
 
 int nfsd_max_blksize;
 
-/**
+/*
  * write_maxblksize - Set or report the current NFS blksize
  *
  * Input:
@@ -917,7 +917,7 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
 							nfsd_max_blksize);
 }
 
-/**
+/*
  * write_maxconn - Set or report the current max number of connections
  *
  * Input:
@@ -998,7 +998,7 @@ static ssize_t nfsd4_write_time(struct file *file, char *buf, size_t size,
 	return rv;
 }
 
-/**
+/*
  * write_leasetime - Set or report the current NFSv4 lease time
  *
  * Input:
@@ -1025,7 +1025,7 @@ static ssize_t write_leasetime(struct file *file, char *buf, size_t size)
 	return nfsd4_write_time(file, buf, size, &nn->nfsd4_lease, nn);
 }
 
-/**
+/*
  * write_gracetime - Set or report current NFSv4 grace period time
  *
  * As above, but sets the time of the NFSv4 grace period.
@@ -1069,7 +1069,7 @@ static ssize_t __write_recoverydir(struct file *file, char *buf, size_t size,
 							nfs4_recoverydir());
 }
 
-/**
+/*
  * write_recoverydir - Set or report the pathname of the recovery directory
  *
  * Input:
@@ -1101,7 +1101,7 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
 	return rv;
 }
 
-/**
+/*
  * write_v4_end_grace - release grace period for nfsd's v4.x lock manager
  *
  * Input:

