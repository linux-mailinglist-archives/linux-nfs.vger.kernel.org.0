Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7F7D29DB
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfJJMqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:46:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39987 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbfJJMqf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:46:35 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so13282390iof.7
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WGW8kqXq+lrOvaIN+hIGYmZGzJjyvdoT0qOGs5S/oPk=;
        b=hCyciXC+5OaCF5ZTkUj2oHxlRKjaA+kZGaSHBmFMJHHHj+rhQ6KCoCpo6CXcT6seij
         wrfHeUVzjTW1juuJ3ZVZfkAaMvRFQCXx9xcQTxB4qvt9dsIY1zqN9ZjXJ744m9pKW2V5
         ZrLFA5Kyw89Lh0uO9GWt4/L/H4sC8ozPHNSdc7ivwf7UzQTU6mljKLWFWEctsv+Zg1Y9
         hu6OXibRo+VXUFEfYVRHsyXENTsz15mHGjzEwA+85N08R4v0uMc0CUv0A1sR6or+Stk4
         5IzQwVrSCd67V6GO97XXhk3pEV0ifiSftxtKvmrgBOXYJdPp/7R+jlpeTgVyUhxS3LI4
         EFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WGW8kqXq+lrOvaIN+hIGYmZGzJjyvdoT0qOGs5S/oPk=;
        b=JE6nN0I9XH8NDvC9ppnn18vKPw/5mL8U3ZKpXn7DX24hhBfak0AfP1XvdrK8zzGsEa
         ZvjXECMEZNGsC6mnWXrwv5Ea1km0tXhgKlzcjp+SkjVIadsX0c94CUoK6SveUuXOvrgj
         3p+qjuxVVfdmKl/IRvSTB5F0TQGyPsnUzAQsjurPzyOsXeF7UNyZEKLj7feRDcclO2rm
         SI5bHSXyuRaZ8xSR5qh5M1IZac5Lze8PgKLC3CISWhiNMPAUSCy3U7OcFes6RkbrThzG
         CcN7RB/48gt8hq6iviu/iBYmMX9qVkAGRkH+AI7q3jk8PoAPXviq2kjMDZzkmZWArvS6
         CXlg==
X-Gm-Message-State: APjAAAUTSYgzLtIjSDEn0ujfp8AZf8ugHuYdX05MC3GzUaShtMNFB3Am
        k0QqjvPw2mk3Zc6+P8a83ko=
X-Google-Smtp-Source: APXvYqzsIbUN1CvM/1ch7f3hlEstI5jY05pp6SHm2rg7Whm1viItcoDpt7vLAxzUNkXk1p1quDiD5A==
X-Received: by 2002:a02:c646:: with SMTP id k6mr10452307jan.141.1570711594435;
        Thu, 10 Oct 2019 05:46:34 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:33 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 08/20] NFS: also send OFFLOAD_CANCEL to source server
Date:   Thu, 10 Oct 2019 08:46:10 -0400
Message-Id: <20191010124622.27812-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In case of copy is cancelled, also send OFFLOAD_CANCEL to the source
server.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 50538b9..5d833f5 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -206,12 +206,14 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
 	status = -copy->error;
 
+out_free:
 	kfree(copy);
 	return status;
 out_cancel:
 	nfs42_do_offload_cancel_async(dst, &copy->stateid);
-	kfree(copy);
-	return status;
+	if (!nfs42_files_from_same_server(src, dst))
+		nfs42_do_offload_cancel_async(src, src_stateid);
+	goto out_free;
 }
 
 static int process_copy_commit(struct file *dst, loff_t pos_dst,
@@ -381,7 +383,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 
 		if (err >= 0)
 			break;
-		if (err == -ENOTSUPP) {
+		if (err == -ENOTSUPP &&
+				nfs42_files_from_same_server(src, dst)) {
 			err = -EOPNOTSUPP;
 			break;
 		} else if (err == -EAGAIN) {
@@ -392,7 +395,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			dst_exception.retry = 1;
 			continue;
 		} else if ((err == -ESTALE ||
-				err == -NFS4ERR_OFFLOAD_DENIED) &&
+				err == -NFS4ERR_OFFLOAD_DENIED ||
+				err == -ENOTSUPP) &&
 				!nfs42_files_from_same_server(src, dst)) {
 			nfs42_do_offload_cancel_async(src, &args.src_stateid);
 			err = -EOPNOTSUPP;
-- 
1.8.3.1

