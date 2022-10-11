Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184E35FAF63
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 11:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJKJd3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 05:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJKJd2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 05:33:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A6B8A7DE
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 02:33:25 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mmr7t2Pn1zVhrt;
        Tue, 11 Oct 2022 17:28:58 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 17:33:23 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 17:33:23 +0800
Message-ID: <68672de3-9fb5-e90b-814f-850185762029@huawei.com>
Date:   Tue, 11 Oct 2022 17:33:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <steved@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: [PATCH] nfs-blkmapd: PID file read by systemd failed
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100010.china.huawei.com (7.185.36.14) To
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
  utils/blkmapd/device-discovery.c | 48 +++++++++++++++++++++-----------
  1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/utils/blkmapd/device-discovery.c 
b/utils/blkmapd/device-discovery.c
index 2736ac89..4d97ac72 100644
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
2.27.0

