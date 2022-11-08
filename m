Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53367621D59
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 21:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKHUAN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 15:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKHUAM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 15:00:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6D3C6CC
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667937560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfdEiD874JpCBJ9Acw7avW0od+mrZKQyUgHgRNQuFg4=;
        b=feShBMOdPuTvHmD7IwpQAzVIj39bebKIMqGkicXkIwUoIXHkaHsrSY518T08bbVmnLF/l8
        OyATsmVlNp7sw6eCODLsjzFcJEe+zXDZiLGxqJxKcuWDCYzDS1F8JIw/f/loEn8Ve3qOeh
        FX8sEKuI5ACHzAw/j9M58LOOCLpuw/E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-qKjwg1-nOam8cY4R851AYg-1; Tue, 08 Nov 2022 14:59:19 -0500
X-MC-Unique: qKjwg1-nOam8cY4R851AYg-1
Received: by mail-qk1-f198.google.com with SMTP id w13-20020a05620a424d00b006e833c4fb0dso13686644qko.2
        for <linux-nfs@vger.kernel.org>; Tue, 08 Nov 2022 11:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfdEiD874JpCBJ9Acw7avW0od+mrZKQyUgHgRNQuFg4=;
        b=wH5M77qNwweg5spSUGDS0yyfBcqRukexP0SzPtdPdl9xcFVu2Px0ufY/Q+UPgCw7OF
         LAMn+b6hRyaKUR0p+ongGy3oO/6KBshLLIy0SEPdFlqk8cO45G17hZ09jCkOuNh2K3DP
         43K+ZC00tusw3HNwHxDsDL40SG9oSMX68XUSZu5OiglT78sNLUWJqQs+GGPdWSut8SEM
         LIvQp7A1f2mb4oRDFpnLH9os+2AXVgZEi2kCzps5HHDI9s9/rbb2r0/06Vx49dzfJHqn
         lYOpgbzwkHPE21SzLgj26QjWziFm52wGgMahvT0xL4h5qASUwg4j0Oq1JrlnjsSDseAJ
         YVRg==
X-Gm-Message-State: ACrzQf3yjkHU4I/+rn0KoOQZGhv77pPUxtCungKB6jnXuL2qLPJloPm3
        G6KwMXIB2wJ74Rcv48/Az3Dj1Ef+RIZbiUeeS/MbzlWdnoAsYXC+JGMZZPb/pgtUXYmFapfSFTz
        i5j+JjBoiDrc1aVmQNJy6
X-Received: by 2002:a05:622a:156:b0:3a5:6bca:8654 with SMTP id v22-20020a05622a015600b003a56bca8654mr17714401qtw.14.1667937558507;
        Tue, 08 Nov 2022 11:59:18 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5A8vZYT9Az3f+qsCT7hdkXTnvfErZ29+e8GTTlFdDPgc4b1UhKmOZrBT4NnLo+0ZvOf3uyQQ==
X-Received: by 2002:a05:622a:156:b0:3a5:6bca:8654 with SMTP id v22-20020a05622a015600b003a56bca8654mr17714383qtw.14.1667937558165;
        Tue, 08 Nov 2022 11:59:18 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a440e00b006fab416015csm9024415qkp.25.2022.11.08.11.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 11:59:17 -0800 (PST)
Message-ID: <8b3c6919-b4a5-9136-933c-45c352908212@redhat.com>
Date:   Tue, 8 Nov 2022 14:59:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3] nfs-blkmapd: PID file read by systemd failed
Content-Language: en-US
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-nfs@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        liuzhiqiang26@huawei.com
References: <c0bd54a6-ff27-ccf7-39b4-a823996bd5af@huawei.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <c0bd54a6-ff27-ccf7-39b4-a823996bd5af@huawei.com>
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

Hey!

Again thank you make those changes but once again
nothing applies cleanly... I think your email client
is reformatting the patch. Please try this:

$ git clone git://linux-nfs.org/~steved/nfs-utils
$ cd nfs-utils
$ edit utils/blkmapd/device-discovery.c
$ git commit -s -a
$ git format-patch -o /tmp/ -1
$ git send-email $DRYRUN  --suppress-cc=all --suppress-from \
    --no-chain-reply-to \
    --from "zhanchengbin <zhanchengbin1@huawei.com>" \
    --to "Linux NFS Mailing list <linux-nfs@vger.kernel.org>"

If DRYRUN=--dry-run will test the mailing but not send it.

steved.

On 11/7/22 10:41 PM, zhanchengbin wrote:
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
> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
> V2->V3:
>   Replace "fprintf(stderr" with BL_LOG_ERR.
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

