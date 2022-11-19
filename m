Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4F2631088
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Nov 2022 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiKSTvG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Nov 2022 14:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiKSTvF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Nov 2022 14:51:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F481C9
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668887402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7pCNaEexYTRvVzB4YFGFYf75PsfsP7DmwpLfpxcS/E=;
        b=M1BJQ05ecY+fojGLwigo/xSwefG0ZzdjL/OxgeuPmerl9b5iLlH8RTW5NULIWGf0uc48Bg
        PfrOkKNEaQ8AJ10k8805IsmaiUGFgGoCJDWzEmQh+aq4hFA9vvlgaCFA7C6oJcwF5//knc
        fOXOipbCr4wVnkOd8llBmuW7MUDHsK8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-dkMWQ0KZMwKSD86hTIXqRg-1; Sat, 19 Nov 2022 14:50:01 -0500
X-MC-Unique: dkMWQ0KZMwKSD86hTIXqRg-1
Received: by mail-qt1-f197.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so8412726qtb.0
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7pCNaEexYTRvVzB4YFGFYf75PsfsP7DmwpLfpxcS/E=;
        b=Zy8ethIoQQmlg5LNzZhg1JsavLcCcNOHVvGaGg6IKqhH9Jhm7C+Dk8g6PhQLYKzZc4
         Jaj6am2IPZewEWcP3rse/R0eR//wuI7m5LrnuovL0PdApPF3S8jqOdRmrboIpRslASrp
         BYAs/yiALogVPoEJx2jrt936DR/wVPvx/5VO1zsjINAz8mBU7RpF+U0f7yNbStJwt09g
         UZUVclg/2ToMxNuWJzDC7ytWUOGE3ry2MTlXQYTsm7RfEPWPBXQ/JRG+QNg+np1Tz7lb
         lo3kF77wtrOO4Zh7ZueDJ3/kBTsNjoYxTPOlsJjla7u/fJJopdSsFIojwH7elrN1UeRd
         QiRw==
X-Gm-Message-State: ANoB5pkcCGtmhLC1ZttCuOyTvf1xdZhEA7QIihDBMcfOmXSWk4tMHJnR
        seeWDPtVj+raOolZXmTuT3H+5m+BowJzuVfmddeqFjrX1psKG+WkqsidCFTlByadCVR5sGH7T3L
        hEU7vqK8QKrBaDnge0Fyf
X-Received: by 2002:ac8:72d0:0:b0:3a5:9e38:9f4 with SMTP id o16-20020ac872d0000000b003a59e3809f4mr11700805qtp.532.1668887400624;
        Sat, 19 Nov 2022 11:50:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5EptKHiqeEeByb4j+tj01P8T1Oyc+jf3lAcUJ5+5HLpH7T/BIQTAVO3/qi/FhUTVU5kBmYaw==
X-Received: by 2002:ac8:72d0:0:b0:3a5:9e38:9f4 with SMTP id o16-20020ac872d0000000b003a59e3809f4mr11700793qtp.532.1668887400381;
        Sat, 19 Nov 2022 11:50:00 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006b929a56a2bsm5055747qkb.3.2022.11.19.11.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 11:49:59 -0800 (PST)
Message-ID: <91bc13b0-8ed7-1f67-f39a-1ce34e16e59b@redhat.com>
Date:   Sat, 19 Nov 2022 14:49:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4] nfs-blkmapd: PID file read by systemd failed
Content-Language: en-US
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-nfs@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        liuzhiqiang26@huawei.com
References: <3e9dfa44-7448-bf0a-8359-7c8229c45246@huawei.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <3e9dfa44-7448-bf0a-8359-7c8229c45246@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/8/22 10:48 PM, zhanchengbin wrote:
> When started nfs-blkmap.service, the PID file can't be opened, The
> cause is that the child process does not create the PID file before
> the systemd reads the PID file.
> Adding "ExecStartPost=/bin/sleep 0.1" to
> /usr/lib/systemd/system/nfs-blkmap.service will probably solve this
> problem, However, there is no guarantee that the above solutions are
> effective under high cpu pressure.So replace the daemon function with
> the fork function, and put the behavior of creating the PID file in
> the parent process to solve the above problems.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Committed...

steved.
> ---
> V3->V4:
>   The previous version cannot be applied.
> 
>   utils/blkmapd/device-discovery.c | 48 +++++++++++++++++++++-----------
>   1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/utils/blkmapd/device-discovery.c 
> b/utils/blkmapd/device-discovery.c
> index bd890598..a565fdbd 100644
> --- a/utils/blkmapd/device-discovery.c
> +++ b/utils/blkmapd/device-discovery.c
> @@ -498,28 +498,44 @@ int main(int argc, char **argv)
>       if (fg) {
>           openlog("blkmapd", LOG_PERROR, 0);
>       } else {
> -        if (daemon(0, 0) != 0) {
> -            fprintf(stderr, "Daemonize failed\n");
> +        pid_t pid = fork();
> +        if (pid < 0) {
> +            BL_LOG_ERR("fork error\n");
>               exit(1);
> +        } else if (pid != 0) {
> +            pidfd = open(PID_FILE, O_WRONLY | O_CREAT, 0644);
> +            if (pidfd < 0) {
> +                BL_LOG_ERR("Create pid file %s failed\n", PID_FILE);
> +                exit(1);
> +            }
> +
> +            if (lockf(pidfd, F_TLOCK, 0) < 0) {
> +                BL_LOG_ERR("Already running; Exiting!");
> +                close(pidfd);
> +                exit(1);
> +            }
> +            if (ftruncate(pidfd, 0) < 0)
> +                BL_LOG_ERR("ftruncate on %s failed: m\n", PID_FILE);
> +            sprintf(pidbuf, "%d\n", pid);
> +            if (write(pidfd, pidbuf, strlen(pidbuf)) != 
> (ssize_t)strlen(pidbuf))
> +                BL_LOG_ERR("write on %s failed: m\n", PID_FILE);
> +            exit(0);
>           }
> 
> -        openlog("blkmapd", LOG_PID, 0);
> -        pidfd = open(PID_FILE, O_WRONLY | O_CREAT, 0644);
> -        if (pidfd < 0) {
> -            BL_LOG_ERR("Create pid file %s failed\n", PID_FILE);
> -            exit(1);
> +        (void)setsid();
> +        if (chdir("/")) {
> +            BL_LOG_ERR("chdir error\n");
>           }
> +        int fd = open("/dev/null", O_RDWR, 0);
> +        if (fd >= 0) {
> +            (void)dup2(fd, STDIN_FILENO);
> +            (void)dup2(fd, STDOUT_FILENO);
> +            (void)dup2(fd, STDERR_FILENO);
> 
> -        if (lockf(pidfd, F_TLOCK, 0) < 0) {
> -            BL_LOG_ERR("Already running; Exiting!");
> -            close(pidfd);
> -            exit(1);
> +            (void)close(fd);
>           }
> -        if (ftruncate(pidfd, 0) < 0)
> -            BL_LOG_WARNING("ftruncate on %s failed: m\n", PID_FILE);
> -        sprintf(pidbuf, "%d\n", getpid());
> -        if (write(pidfd, pidbuf, strlen(pidbuf)) != 
> (ssize_t)strlen(pidbuf))
> -            BL_LOG_WARNING("write on %s failed: m\n", PID_FILE);
> +
> +        openlog("blkmapd", LOG_PID, 0);
>       }
> 
>       signal(SIGINT, sig_die);

