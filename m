Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE05754C0E
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jul 2023 22:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGOUx4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jul 2023 16:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOUxz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jul 2023 16:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484CB198
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689454386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpkPSceFuY9FMC6Pe6nu4cZ/mdvGwOzewmFbBTQQp20=;
        b=AxUFuOHabHYM1tD/P6BnmdAOC5Ma6hllUFEGcRrZJQW7xymn8GPwuNw9oSd8v2ltZVnG+m
        BcNHJqHjE1Nx328FuP8zBnUc7abaGEtRG9VEtp6rRCkTTkrFZZpOBk+ppR+W6hvJhAANyp
        UOejMD59cMj3vSjWZNBn249jVnGC4Vk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-la7rNxyXNyWkw_rhVrC5Sg-1; Sat, 15 Jul 2023 16:53:05 -0400
X-MC-Unique: la7rNxyXNyWkw_rhVrC5Sg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-767d30ab094so70421685a.1
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 13:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689454384; x=1692046384;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpkPSceFuY9FMC6Pe6nu4cZ/mdvGwOzewmFbBTQQp20=;
        b=YBvs+uTc6qKDGRQHKeI7wKuPsmeZnP3sOpdk0ZhJ4XIZ5n3BXSY31KUlp58MqmPMCE
         VGErqm60m/JlS20jy0Z6yp28YhCFGy5NUlGmpg308WzNDv/IGptxNKSRUJJTKdtT4mW6
         twn3wktMYmZEzPuigU4w3S36yY+JbPSQAcx146xIqiQaNXjPRwlbIYcss/uYuIsFbe+7
         9ldV6+ajgByqfFAKMcyOdihewf3RmqHnzoi1AESqpUNMwveAs0X4PMDp3f3qaI2kc/j7
         nyzusfbWL/pdCIEf0lIB6Ir9gFWcJFjjWCv5t8+NwAlINIM5nUe25Frx60xk5t8XZiKJ
         RgqA==
X-Gm-Message-State: ABy/qLaY7x4HwSBiNJwn+ikpokSLkXxNnkmIdQiIolCp2QaENyrHnEDT
        AS6S3oZ6lW30hcBOsMwsjXtkYNABlIhSs/fRow1GqzzkShwSfICOQI77156Yj9SuwFRlmIRknOs
        D0AfnmF/jVLKe0ZYWjanS1RIMszHP
X-Received: by 2002:a05:620a:408e:b0:765:58ac:9458 with SMTP id f14-20020a05620a408e00b0076558ac9458mr3767296qko.7.1689454384233;
        Sat, 15 Jul 2023 13:53:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHWze3aLXsumpOHnUekhuZlh05sj2n+FZ0AlDpdRlgmluPQMplAyrZ6NP/UpXfXjHVP657eTQ==
X-Received: by 2002:a05:620a:408e:b0:765:58ac:9458 with SMTP id f14-20020a05620a408e00b0076558ac9458mr3767289qko.7.1689454383923;
        Sat, 15 Jul 2023 13:53:03 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.31])
        by smtp.gmail.com with ESMTPSA id g7-20020a05620a108700b00767d05117fesm4859280qkk.36.2023.07.15.13.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 13:53:03 -0700 (PDT)
Message-ID: <5230337e-b028-0e86-9693-c29f7d1165b2@redhat.com>
Date:   Sat, 15 Jul 2023 16:53:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] systemd: Ensure that statdpath exists using
 systemd-tmpfiles
Content-Language: en-US
To:     Alberto Garcia <berto@igalia.com>, linux-nfs@vger.kernel.org
References: <20230713102531.131072-1-berto@igalia.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230713102531.131072-1-berto@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 7/13/23 6:25 AM, Alberto Garcia wrote:
> The NFS utils store their state under /var/lib/nfs and they can
> generally handle the case where that directory is missing by creating
> the appropriate files and directories automatically.
> 
> This is not the case of rpc-statd: if sm and sm.bak (under $statdpath,
> which also defaults to /var/lib/nfs) are missing the daemon will
> refuse to start and will exit with an error.
Why are they would be missing? They are created on the
nfs-utils installation.

> 
> If nfs-utils is configured with systemd support it can take advantage
> of systemd-tmpfiles to ensure that the state directories are always
> present and have the appropriate ownership.
> 
> This would normally be handled with the StateDirectory directive in
> rpc-statd.service, however that method would not be able to change the
> ownership of the directories to $statduser because this daemon needs
> to be run as root, and only later changes its uid and gid.
Just curious... how did you test this patch? When I apply it
I get this error

Failed to insert: creating /var/lib/nfs/statd/sm/<client>: Permission denied
STAT_FAIL to <server> for SM_MON of <server_ip>

Maybe this is packing issue but I'm thinking it is more
of systemd issue... the permissions on the sm directory
are
283 drwx------. 2 nobody rpcuser 6 Apr 18 20:00 /var/lib/nfs/statd/sm
instead of
283 drwx------. 2 rpcuser rpcuser 6 Apr 18 20:00 /var/lib/nfs/statd/sm

Even when I change the owner to rpcuser, I still get the
permission error...

steved.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   configure.ac              | 1 +
>   systemd/Makefile.am       | 5 +++++
>   systemd/nfs-utils.conf.in | 4 ++++
>   3 files changed, 10 insertions(+)
>   create mode 100644 systemd/nfs-utils.conf.in
> 
> diff --git a/configure.ac b/configure.ac
> index 6fbcb974..fe958ab3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -695,6 +695,7 @@ AC_CONFIG_COMMANDS_PRE([eval eval _rpc_pipefsmount=$rpc_pipefsmount])
>   
>   AC_CONFIG_FILES([
>   	Makefile
> +	systemd/nfs-utils.conf
>   	systemd/rpc-gssd.service
>   	systemd/rpc_pipefs.target
>   	systemd/var-lib-nfs-rpc_pipefs.mount
> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> index b4483222..6127986e 100644
> --- a/systemd/Makefile.am
> +++ b/systemd/Makefile.am
> @@ -5,6 +5,9 @@ MAINTAINERCLEANFILES = Makefile.in
>   udev_rulesdir = /usr/lib/udev/rules.d/
>   udev_files = 60-nfs.rules
>   
> +sdtmpfilesdir = /usr/lib/tmpfiles.d/
> +sdtmpfiles_files = nfs-utils.conf
> +
>   unit_files =  \
>       nfs-client.target \
>       rpc_pipefs.target \
> @@ -85,4 +88,6 @@ install-data-hook: $(unit_files) $(udev_files)
>   	cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
>   	mkdir -p $(DESTDIR)/$(udev_rulesdir)
>   	cp $(udev_files) $(DESTDIR)/$(udev_rulesdir)
> +	mkdir -p $(DESTDIR)/$(sdtmpfilesdir)
> +	cp $(sdtmpfiles_files) $(DESTDIR)/$(sdtmpfilesdir)
>   endif
> diff --git a/systemd/nfs-utils.conf.in b/systemd/nfs-utils.conf.in
> new file mode 100644
> index 00000000..a44c337e
> --- /dev/null
> +++ b/systemd/nfs-utils.conf.in
> @@ -0,0 +1,4 @@
> +# This is a systemd-tmpfiles configuration file
> +# type path			mode	uid	gid	age	argument
> +d      @statdpath@/sm		0700	@statduser@	:root	-       -
> +d      @statdpath@/sm.bak	0700	@statduser@	:root	-	-

