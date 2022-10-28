Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757D6108AA
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 05:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiJ1DUv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 23:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiJ1DUt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 23:20:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A655E649
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 20:20:47 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mz75B2FpQzpVqQ;
        Fri, 28 Oct 2022 11:17:18 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 11:20:45 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 11:20:45 +0800
Message-ID: <db1d2e4f-36db-c271-121b-bc5af74f1dca@huawei.com>
Date:   Fri, 28 Oct 2022 11:20:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] nfs-blkmapd: PID file read by systemd failed
To:     Steve Dickson <steved@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
References: <f81e71f4-ea7b-c512-573f-ac1f6e4bcefd@huawei.com>
 <c6568a8b-7d55-6185-54f3-721c0a664de9@redhat.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <c6568a8b-7d55-6185-54f3-721c0a664de9@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100023.china.huawei.com (7.185.36.151) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2022/10/25 1:25, Steve Dickson wrote:
> Hello,
> 
> This still does not apply.. at all.. but
> did take a look.
> 
> On 10/17/22 11:05 PM, zhanchengbin wrote:
>> When started nfs-blkmap.service, the PID file can't be opened, The
>> cause is that the child process does not create the PID file before
>> the systemd reads the PID file.
>> Adding "ExecStartPost=/bin/sleep 0.1" to
>> /usr/lib/systemd/system/nfs-blkmap.service will probably solve this
>> problem, However, there is no guarantee that the above solutions are
>> effective under high cpu pressure.So replace the daemon function with
>> the fork function, and put the behavior of creating the PID file in
>> the parent process to solve the above problems.
>>
>> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
>> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>> V1->V2:
>>   2.27.0 -> 2.33.0
>>
>>   utils/blkmapd/device-discovery.c | 48 +++++++++++++++++++++-----------
>>   1 file changed, 32 insertions(+), 16 deletions(-)
>>
>> diff --git a/utils/blkmapd/device-discovery.c 
>> b/utils/blkmapd/device-discovery.c
>> index 49935c2e..dcced5c3 100644
>> --- a/utils/blkmapd/device-discovery.c
>> +++ b/utils/blkmapd/device-discovery.c
>> @@ -507,28 +507,44 @@ int main(int argc, char **argv)
>>       if (fg) {
>>           openlog("blkmapd", LOG_PERROR, 0);
>>       } else {
>> -        if (daemon(0, 0) != 0) {
>> -            fprintf(stderr, "Daemonize failed\n");
>> +        pid_t pid = fork();
>> +        if (pid < 0) {
>> +            fprintf(stderr, "fork error\n");
> use BL_LOG_ERR("fork error: %s\n", strerror(errno)) or
> something similar which tells why the fork failed.
I'm considering if openlog will have problems after fork, I'll try to
fix this and push the patch for the next version, thx.
> 
>>               exit(1);
>> +        } else if (pid != 0) {
>> +            pidfd = open(PID_FILE, O_WRONLY | O_CREAT, 0644);
>> +            if (pidfd < 0) {
>> +                fprintf(stderr, "Create pid file %s failed\n", 
>> PID_FILE);
> Same thing here... it is good you are showing the failed file
> but you are not showing my it failed.
> 
>> +                exit(1);
>> +            }
>> +
>> +            if (lockf(pidfd, F_TLOCK, 0) < 0) {
>> +                fprintf(stderr, "Already running; Exiting!");
>> +                close(pidfd);
>> +                exit(1);
>> +            }
>> +            if (ftruncate(pidfd, 0) < 0)
>> +                fprintf(stderr, "ftruncate on %s failed: m\n", 
>> PID_FILE);
>> +            sprintf(pidbuf, "%d\n", pid);
>> +            if (write(pidfd, pidbuf, strlen(pidbuf)) != 
>> (ssize_t)strlen(pidbuf))
>> +                fprintf(stderr, "write on %s failed: m\n", PID_FILE);
>> +            exit(0);
>>           }
>>
>> -        openlog("blkmapd", LOG_PID, 0);
>> -        pidfd = open(PID_FILE, O_WRONLY | O_CREAT, 0644);
>> -        if (pidfd < 0) {
>> -            BL_LOG_ERR("Create pid file %s failed\n", PID_FILE);
>> -            exit(1);
>> +        (void)setsid();
>> +        if (chdir("/")) {
>> +            fprintf(stderr, "chdir error\n");
>>           }
>> +        int fd = open("/dev/null", O_RDWR, 0);
>> +        if (fd >= 0) {
>> +            (void)dup2(fd, STDIN_FILENO);
>> +            (void)dup2(fd, STDOUT_FILENO);
>> +            (void)dup2(fd, STDERR_FILENO);
> not clear this is necessary but it is
> probably the safest since that's what
> daemon() does.I think it's necessary,because similar processing is in the daemon
function.

  -zhanchengbin
> 
> steved.
>>
>> -        if (lockf(pidfd, F_TLOCK, 0) < 0) {
>> -            BL_LOG_ERR("Already running; Exiting!");
>> -            close(pidfd);
>> -            exit(1);
>> +            (void)close(fd);
>>           }
>> -        if (ftruncate(pidfd, 0) < 0)
>> -            BL_LOG_WARNING("ftruncate on %s failed: m\n", PID_FILE);
>> -        sprintf(pidbuf, "%d\n", getpid());
>> -        if (write(pidfd, pidbuf, strlen(pidbuf)) != 
>> (ssize_t)strlen(pidbuf))
>> -            BL_LOG_WARNING("write on %s failed: m\n", PID_FILE);
>> +
>> +        openlog("blkmapd", LOG_PID, 0);
>>       }
>>
>>       signal(SIGINT, sig_die);
> 
> .
