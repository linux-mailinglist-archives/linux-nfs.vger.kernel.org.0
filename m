Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9187F1E91B9
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgE3NbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3NbA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:31:00 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B984C03E969;
        Sat, 30 May 2020 06:31:00 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p20so2260039iop.11;
        Sat, 30 May 2020 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=k4aFKZu7Ir4BTmsKFh4XOyBP0EdUtSdQg2tscndZkEA=;
        b=G/6vgTk8KTzS/plhttXm3gQH6/37zgrgzqsLtL5svhoIz1WzegoIuY3frOIaO3PjLl
         3Q/Erst0uZdHXhP4/QXhS0SznRIXXNOjhTrmDZ+fgUnJXVJtf9RnKyjlRArXtGiVY+qG
         sXX0ZihcMVzjbCsW2TPIgpM1N8Ut8WnTVOgD5o7KI5jtTwoChU26AM2x3TwvPNFUxMzI
         EpYLZ8+MWVg6eyGplzYJ5SO0TyjVL9tT7M1sL/bHui4u0Xye2g67N0P3VPUkBorU0+T7
         VXxZRs/a8rkD3oZcZnOiOOYbFdWLKn+xWbnI7e0NOvIpUHp4znCJbNoKHAeyk7ukLpyV
         onkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=k4aFKZu7Ir4BTmsKFh4XOyBP0EdUtSdQg2tscndZkEA=;
        b=AHJzQg0wPmWS1/4OO/E/qL0uqE+JJJkejA7WwOFwh5+flgaUWuNQXlL8ocAwBD6MgD
         ihivT8oRZa4nRWpL6Em2Zy6Q8LRzBNVxPqafnZv85halyvCsNG61AoqgZxJyG43utF4e
         uUNFq7lJE7tPW8b/pp3CKCbZOeC939U6NV1U/dxSaN02eBel6EagFPLZ99oxeTvHu9pI
         5QjrjNjCUvqcwFkNTRdEnbYBfjsIVzU8222cdzoAR2bKpemZoVfjztLoXKBXYleb+abG
         XBi/3GMV3L2ItVNa9UQw0vZWjUAnJ6yA3B4OE70v7u3yvSrJlMA0iVNTwDcKmPJH9XfL
         W3HQ==
X-Gm-Message-State: AOAM531wJHNrrUbhlv5FnSub2MzYRHaO0u+7HAN3TT9vJfa0LpeaOQIO
        noMXylc9ClAKWFOwdFZMa1nMOT8U
X-Google-Smtp-Source: ABdhPJxrgC3PFb0BKZbh7iK5dgEChHKBQ+pM8+GAVIcMeXnCjzf6IYvRIdySwXj8rrjMzRIFiXaMFw==
X-Received: by 2002:a5d:88d3:: with SMTP id i19mr11314185iol.194.1590845459729;
        Sat, 30 May 2020 06:30:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a17sm6331799ild.31.2020.05.30.06.30.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:59 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDUwmr001492;
        Sat, 30 May 2020 13:30:58 GMT
Subject: [PATCH v4 33/33] NFSD: Fix improperly-formatted Doxygen comments
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:58 -0400
Message-ID: <20200530133058.10117.4971.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
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

