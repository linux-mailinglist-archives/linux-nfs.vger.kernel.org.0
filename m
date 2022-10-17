Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695CD601717
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 21:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJQTM2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJQTM1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 15:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63682760E5
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666033940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GNIIdbmpQcPXamN/iBB80VJfnSUBFA/d7DmCy5IGpKA=;
        b=MneAttQlFvgXGJNl/O/xSAt2r21L1UXS/jQyX21cOZJFn8Zs5Esc6OxjWX1sAPU8NNoMEI
        JyBKK5O0YUogCTzxvpnbUkuEKqmycVR//t7T5DGLv6uB3x+qFT2bwIVa0gmajItEq68iUl
        HOrJbK13xSoz7PJVKx0o5giD5l2KYQs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-hU0mWYOKNHCaaEfF4i-UiA-1; Mon, 17 Oct 2022 15:12:19 -0400
X-MC-Unique: hU0mWYOKNHCaaEfF4i-UiA-1
Received: by mail-qv1-f71.google.com with SMTP id t19-20020a056214119300b004b03f58b1abso7360467qvv.17
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 12:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNIIdbmpQcPXamN/iBB80VJfnSUBFA/d7DmCy5IGpKA=;
        b=IWG/NVgP8qG+vtCkRJfalcEPoYX7FSwtMFf63PUGrdbazFtS+RCalGISiGzzZShffL
         QFuHunuVIbNa17sag9eLApWHsrXvk6PxuSNrnHCZIwkFJW1sDTUaWCd30OewcAdRIcyW
         zPdOiSFTR/rsJlLrE/oUCdmRWQLVycpPEOAaLCQeV2pQ8hUXMiCAOJnh+k4lkSV4Zl8B
         SsKai3wRh0mL1E9qLYcl626qSapTJf/v1ehbbgcvaJY5wk4+JTIBVmvZcAj9EX6aMRpm
         ZTSwb7gRDpF0oM1msqrbYX3Iso2KDdeRblu2/SV8w6gOqBLQcpwLhWhsDvuQfJMSHTQj
         slTw==
X-Gm-Message-State: ACrzQf3a9rZc/8TVG14Jp7YE1VZXTUGjddzF2L8EHgBl3IYXgBT5LMGf
        HCut/CXSCDikq/0inUJa83PeDdkn8SCgJqO8GdB4KZ3L1atYC0vmwPDNyJnBwfw9THUUjtmriws
        jUrDS3XrDC22xnD3nJDpf
X-Received: by 2002:a05:6214:e49:b0:4b3:f24e:91ac with SMTP id o9-20020a0562140e4900b004b3f24e91acmr9272716qvc.41.1666033939104;
        Mon, 17 Oct 2022 12:12:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5X/GqS4Dc4Ze0RklYmsQuAaxFy3N4bFAq+d/ZnEO9iL5We7xa3NJb0fQwQx66jSmm7JlPUeQ==
X-Received: by 2002:a05:6214:e49:b0:4b3:f24e:91ac with SMTP id o9-20020a0562140e4900b004b3f24e91acmr9272691qvc.41.1666033938822;
        Mon, 17 Oct 2022 12:12:18 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.253.248])
        by smtp.gmail.com with ESMTPSA id bs6-20020a05620a470600b006eee3a09ff3sm487972qkb.69.2022.10.17.12.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 12:12:18 -0700 (PDT)
Message-ID: <6aa694e0-9b22-48a2-0f86-d331aa72ff18@redhat.com>
Date:   Mon, 17 Oct 2022 15:12:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] nfs-blkmapd: PID file read by systemd failed
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-nfs@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong <linfeilong@huawei.com>
References: <68672de3-9fb5-e90b-814f-850185762029@huawei.com>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <68672de3-9fb5-e90b-814f-850185762029@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

Thanks for the ping!! Bakeathon sucked up a couples weeks!

On 10/11/22 5:33 AM, zhanchengbin wrote:
> When started nfs-blkmap.service, the PID file can't be opened, The
> cause is that the child process does not create the PID file before
> the systemd reads the PID file.
> Adding "ExecStartPost=/bin/sleep 0.1" to
> /usr/lib/systemd/system/nfs-blkmap.service will probably solve this
> problem, However, there is no guarantee that the above solutions are
> effective under high cpu pressure.So replace the daemon function with
> the fork function, and put the behavior of creating the PID file in
> the parent process to solve the above problems.
I understand what you are trying to do... but unfortunately
this patch does not apply to the latest release.... So
I'm a bit concern on the amount to testing was done.

Please repost a patch that applies cleanly.

steved.

> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>   utils/blkmapd/device-discovery.c | 48 +++++++++++++++++++++-----------
>   1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/utils/blkmapd/device-discovery.c 
> b/utils/blkmapd/device-discovery.c
> index 2736ac89..4d97ac72 100644
> --- a/utils/blkmapd/device-discovery.c
> +++ b/utils/blkmapd/device-discovery.c
> @@ -507,28 +507,44 @@ int main(int argc, char **argv)
>       if (fg) {
>           openlog("blkmapd", LOG_PERROR, 0);
>       } else {
> -        if (daemon(0, 0) != 0) {
> -            fprintf(stderr, "Daemonize failed\n");
> +        pid_t pid = fork();
> +        if (pid < 0) {
> +            fprintf(stderr, "fork error\n");
>               exit(1);
> +        } else if (pid != 0) {
> +            pidfd = open(PID_FILE, O_WRONLY | O_CREAT, 0644);
> +            if (pidfd < 0) {
> +                fprintf(stderr, "Create pid file %s failed\n", PID_FILE);
> +                exit(1);
> +            }
> +
> +            if (lockf(pidfd, F_TLOCK, 0) < 0) {
> +                fprintf(stderr, "Already running; Exiting!");
> +                close(pidfd);
> +                exit(1);
> +            }
> +            if (ftruncate(pidfd, 0) < 0)
> +                fprintf(stderr, "ftruncate on %s failed: m\n", PID_FILE);
> +            sprintf(pidbuf, "%d\n", pid);
> +            if (write(pidfd, pidbuf, strlen(pidbuf)) != 
> (ssize_t)strlen(pidbuf))
> +                fprintf(stderr, "write on %s failed: m\n", PID_FILE);
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
> +            fprintf(stderr, "chdir error\n");
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

