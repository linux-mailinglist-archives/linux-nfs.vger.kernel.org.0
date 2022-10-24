Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC41960B6E0
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiJXTNK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 15:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiJXTMc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 15:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40E5B2748
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666633776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QFzMPOVhlSWF5NJr8yaXnz5DygEX2t8aC7JOeR+QXE=;
        b=KNlqNiq/qFm4FGiqzcvgAXXPBvdN43grndjdMnYg84cR0oyHmjtQqbJR+xqrVlHLrUY85r
        l/lmtBJGLUcb9nnb8gqRmmA4YRvDGjMzWmKoA1B2Lqhc8K8D2cWUUmCEJSOeA0S0X/0qje
        cNhaFaj26dlDyrXB7TM3vBccDi9dr04=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-ScpMgtj2Mz26m26_p-ePFA-1; Mon, 24 Oct 2022 13:25:03 -0400
X-MC-Unique: ScpMgtj2Mz26m26_p-ePFA-1
Received: by mail-qk1-f199.google.com with SMTP id o13-20020a05620a2a0d00b006cf9085682dso9396355qkp.7
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QFzMPOVhlSWF5NJr8yaXnz5DygEX2t8aC7JOeR+QXE=;
        b=Ast5O0wLTRTwukbLTanzbfjIBdFB0Kdlpr5k6qK1EeYUNfEu9XXy8d3XmVaX6lQaTz
         UKEKYk7Y34dg+wqZZftzKqvv3G8Wqa+spQx8bbBu4dGazRy1QiMcROv2rzKCNsr8H+Zb
         9CFBGZLzPEq+OWshYNVCn/1puOIg3SfBn/PoEwwWKq54HWtfuWJnkBHF4GuGEJ8GwUep
         Mwqm+lSKS3vSb6Leu/P6F+iKkP4u4PwtaXYu026ZNTNozn0rO2dyP7JLTA2HSLobY8R6
         OLmRb7vOL/QPSMdlzqveUR91vuiRTTElalBk8d3cFMOmRILN4bADeaoB41NDwVEjb8f6
         1Lig==
X-Gm-Message-State: ACrzQf3DiBf3TWSoHWo1vjw+hPo81gaV+GFVhHNyNl5qyWdDne064kaE
        R44CuALOo3ehfyMoNKqkI63/6lQ8VTx4MDTsQ/ffv9sOLgc6vJRTjB1ClDF6A4ktDdjBW5wXwNs
        my4d1SvPT0Uc1VVDmd4ET
X-Received: by 2002:a05:620a:46a0:b0:6ee:afc7:d9dc with SMTP id bq32-20020a05620a46a000b006eeafc7d9dcmr22828199qkb.189.1666632302303;
        Mon, 24 Oct 2022 10:25:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7pW2yjruP5el4yeBOcfYfF1qlMHB2k0cZdMQqO5yLugc6j5UI5xWynds2pRQc5lxZKX9xI3Q==
X-Received: by 2002:a05:620a:46a0:b0:6ee:afc7:d9dc with SMTP id bq32-20020a05620a46a000b006eeafc7d9dcmr22828172qkb.189.1666632301966;
        Mon, 24 Oct 2022 10:25:01 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id he19-20020a05622a601300b0039cc7ebf46bsm216508qtb.93.2022.10.24.10.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:25:01 -0700 (PDT)
Message-ID: <c6568a8b-7d55-6185-54f3-721c0a664de9@redhat.com>
Date:   Mon, 24 Oct 2022 13:25:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] nfs-blkmapd: PID file read by systemd failed
Content-Language: en-US
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-nfs@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong <linfeilong@huawei.com>
References: <f81e71f4-ea7b-c512-573f-ac1f6e4bcefd@huawei.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <f81e71f4-ea7b-c512-573f-ac1f6e4bcefd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

This still does not apply.. at all.. but
did take a look.

On 10/17/22 11:05 PM, zhanchengbin wrote:
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
> V1->V2:
>   2.27.0 -> 2.33.0
> 
>   utils/blkmapd/device-discovery.c | 48 +++++++++++++++++++++-----------
>   1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/utils/blkmapd/device-discovery.c 
> b/utils/blkmapd/device-discovery.c
> index 49935c2e..dcced5c3 100644
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
use BL_LOG_ERR("fork error: %s\n", strerror(errno)) or
something similar which tells why the fork failed.

>               exit(1);
> +        } else if (pid != 0) {
> +            pidfd = open(PID_FILE, O_WRONLY | O_CREAT, 0644);
> +            if (pidfd < 0) {
> +                fprintf(stderr, "Create pid file %s failed\n", PID_FILE);
Same thing here... it is good you are showing the failed file
but you are not showing my it failed.

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
not clear this is necessary but it is
probably the safest since that's what
daemon() does.

steved.
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

