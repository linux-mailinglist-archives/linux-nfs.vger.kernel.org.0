Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CE560219D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 05:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJRDGR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 23:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJRDGP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 23:06:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D972ECB
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 20:06:12 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrzC66H5tz1P74m;
        Tue, 18 Oct 2022 11:01:06 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 11:05:48 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 11:05:48 +0800
Message-ID: <f81e71f4-ea7b-c512-573f-ac1f6e4bcefd@huawei.com>
Date:   Tue, 18 Oct 2022 11:05:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     <steved@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH v2] nfs-blkmapd: PID file read by systemd failed
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500022.china.huawei.com (7.185.36.66) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When started nfs-blkmap.service, the PID file can't be opened, The
cause is that the child process does not create the PID file before
the systemd reads the PID file.
Adding "ExecStartPost=/bin/sleep 0.1" to
/usr/lib/systemd/system/nfs-blkmap.service will probably solve this
problem, However, there is no guarantee that the above solutions are
effective under high cpu pressure.So replace the daemon function with
the fork function, and put the behavior of creating the PID file in
the parent process to solve the above problems.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
V1->V2:
  2.27.0 -> 2.33.0

  utils/blkmapd/device-discovery.c | 48 +++++++++++++++++++++-----------
  1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/utils/blkmapd/device-discovery.c 
b/utils/blkmapd/device-discovery.c
index 49935c2e..dcced5c3 100644
--- a/utils/blkmapd/device-discovery.c
+++ b/utils/blkmapd/device-discovery.c
@@ -507,28 +507,44 @@ int main(int argc, char **argv)
  	if (fg) {
  		openlog("blkmapd", LOG_PERROR, 0);
  	} else {
-		if (daemon(0, 0) != 0) {
-			fprintf(stderr, "Daemonize failed\n");
+		pid_t pid = fork();
+		if (pid < 0) {
+			fprintf(stderr, "fork error\n");
  			exit(1);
+		} else if (pid != 0) {
+			pidfd = open(PID_FILE, O_WRONLY | O_CREAT, 0644);
+			if (pidfd < 0) {
+				fprintf(stderr, "Create pid file %s failed\n", PID_FILE);
+				exit(1);
+			}
+
+			if (lockf(pidfd, F_TLOCK, 0) < 0) {
+				fprintf(stderr, "Already running; Exiting!");
+				close(pidfd);
+				exit(1);
+			}
+			if (ftruncate(pidfd, 0) < 0)
+				fprintf(stderr, "ftruncate on %s failed: m\n", PID_FILE);
+			sprintf(pidbuf, "%d\n", pid);
+			if (write(pidfd, pidbuf, strlen(pidbuf)) != (ssize_t)strlen(pidbuf))
+				fprintf(stderr, "write on %s failed: m\n", PID_FILE);
+			exit(0);
  		}

-		openlog("blkmapd", LOG_PID, 0);
-		pidfd = open(PID_FILE, O_WRONLY | O_CREAT, 0644);
-		if (pidfd < 0) {
-			BL_LOG_ERR("Create pid file %s failed\n", PID_FILE);
-			exit(1);
+		(void)setsid();
+		if (chdir("/")) {
+			fprintf(stderr, "chdir error\n");
  		}
+		int fd = open("/dev/null", O_RDWR, 0);
+		if (fd >= 0) {
+		    (void)dup2(fd, STDIN_FILENO);
+		    (void)dup2(fd, STDOUT_FILENO);
+		    (void)dup2(fd, STDERR_FILENO);

-		if (lockf(pidfd, F_TLOCK, 0) < 0) {
-			BL_LOG_ERR("Already running; Exiting!");
-			close(pidfd);
-			exit(1);
+		    (void)close(fd);
  		}
-		if (ftruncate(pidfd, 0) < 0)
-			BL_LOG_WARNING("ftruncate on %s failed: m\n", PID_FILE);
-		sprintf(pidbuf, "%d\n", getpid());
-		if (write(pidfd, pidbuf, strlen(pidbuf)) != (ssize_t)strlen(pidbuf))
-			BL_LOG_WARNING("write on %s failed: m\n", PID_FILE);
+
+		openlog("blkmapd", LOG_PID, 0);
  	}

  	signal(SIGINT, sig_die);
-- 
2.33.0

