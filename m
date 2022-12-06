Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225A64449E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 14:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiLFNeJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 08:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLFNeJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 08:34:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69946E00C
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670333583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+0eCcuBosgAQRrprVj0TMmirBfpR6CQk2l6gsHHcnI=;
        b=anrMcVFOtiB1VJ1VxBKln7VNyCI3XhkZ1jD832wB/7QsipBC/WANp9X4dOpYKeicDLb8is
        ZiD7j7bhAD9YzLU5sn1SDJCvWp85uaxhB8DDEvNCyyojvfjrcg3anY2U+9fgyNC0koHC6m
        3DJVITGv0CUQ4Qspzk1NstVbBqGLGP4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-dJeHTdm7OtavH9obqZEboQ-1; Tue, 06 Dec 2022 08:33:02 -0500
X-MC-Unique: dJeHTdm7OtavH9obqZEboQ-1
Received: by mail-qv1-f71.google.com with SMTP id m4-20020ad44484000000b004c78122b496so2256816qvt.7
        for <linux-nfs@vger.kernel.org>; Tue, 06 Dec 2022 05:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+0eCcuBosgAQRrprVj0TMmirBfpR6CQk2l6gsHHcnI=;
        b=Ln2PMTb4SevHkH1RPJOkHHKq8PamcFJav5u6kbOGeLqpNGKJNXzQNWm3cqa/nOltWX
         CiAi3i3uiZ3+6Dt+7yDxFE8oO3dSNsz+kCMXh9qgcRMZEI5xb8EDS431ji/agLY0MbTY
         rIzaYc/NdFI0WnmZUEewpYajO7b5gUU0qwLpPadM+vbxYMnnBeASt2JBJTkDmihLkmk/
         Ihci3IeIK3E0Ao9apefpKOoesNZmXaVpC1NuWhA1ivk8kf7QiLjmLB5wwyLT+CGJ45T8
         Pt545GkRH8rGHtw4/R4SVnxl5d2baGH3hOHtCoS61ATjSxovVAhrkW0ZQ22JlOVZTnW9
         +RQA==
X-Gm-Message-State: ANoB5pmFhf9EBhWK6hk/cB14lAV3U05ZGGnAZelFWi2aUUMO96iJyE6h
        GLYe428fKI08hfOa2KNtgLIbKoNdg5Q3L2vNpeoyHMDKo+mJvPR03eEYzE8ZA3Iq/yJlnmXM6DF
        HRZscZGVs2ttG+8HtB2of
X-Received: by 2002:a0c:f0d1:0:b0:4c7:3114:b203 with SMTP id d17-20020a0cf0d1000000b004c73114b203mr367959qvl.10.1670333581062;
        Tue, 06 Dec 2022 05:33:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf60zW6qnebH5xJFw86Wc8rUdDvh60LfeBKO+Xp8mrAZHcsiUoDd40mIjdZtQdK3UwlWzmpY6A==
X-Received: by 2002:a0c:f0d1:0:b0:4c7:3114:b203 with SMTP id d17-20020a0cf0d1000000b004c73114b203mr367957qvl.10.1670333580726;
        Tue, 06 Dec 2022 05:33:00 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id u17-20020a05620a455100b006fa22f0494bsm14858917qkp.117.2022.12.06.05.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 05:33:00 -0800 (PST)
Message-ID: <6666bd23-210b-85a9-f3c4-f0c18f23fa12@redhat.com>
Date:   Tue, 6 Dec 2022 08:32:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Fix typos in the root folder
Content-Language: en-US
To:     yegorslists@googlemail.com, linux-nfs@vger.kernel.org
References: <20221129085305.11448-1-yegorslists@googlemail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221129085305.11448-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/29/22 3:53 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Also remove double spaces.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Committed... (tag: nfs-utils-2-6-3-rc5)

steved.
> ---
>   NEWS         | 22 +++++++++++-----------
>   configure.ac |  6 +++---
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/NEWS b/NEWS
> index e70ae8ab..77872c5a 100644
> --- a/NEWS
> +++ b/NEWS
> @@ -1,32 +1,32 @@
>   Significant changes for nfs-utils 1.1.0 - March/April 2007
>   
> - - rpc.lockd is gone.  One 3 old kernel releases need it.
> - - rpc.rquotad is gone.  Use the one from the 'quota' package.
> -   Everone else does.
> + - rpc.lockd is gone. One 3 old kernel releases need it.
> + - rpc.rquotad is gone. Use the one from the 'quota' package.
> +   Everyone else does.
>    - /sbin/{u,}mount.nfs{,4} are now installed so 'mount' will
>      use these to mount nfs filesystems instead of internal code.
>     + mount.nfs will check for 'statd' to be running when mounting
> -    a filesystem which requires it.  If it is not running it will
> +    a filesystem which requires it. If it is not running it will
>       run "/usr/sbin/start-statd" to try to start it.
>       If statd is not running and cannot be started, mount.nfs will
>       refuse to mount the filesystem and will suggest the 'nolock'
>       option.
>    - Substantial changes to statd
>     + The 'notify' process that must happen at boot has been split
> -    into a separate program "sm-notify".  It ensures that it
> -    only runs once even if you restart statd.  This is correct
> +    into a separate program "sm-notify". It ensures that it
> +    only runs once even if you restart statd. This is correct
>       behaviour.
>     + statd stores state in the files in /var/lib/nfs/sm/ so that
>       if you kill and restart it, it will restore that state and
>       continue working correctly.
>     + statd makes more use of DNS lookup and should handle
> -    multi-homed peers better.  In particular, files in
> +    multi-homed peers better. In particular, files in
>       /var/lib/nfs/sm/ are named with the Full Qualified Domain Name
>       if available.
>    - If you export a directory as 'crossmnt', all filesystems
>      mounted beneath are automatically exported with the same
>      options (unless explicitly exported with different options).
> - - subtree_check is no-longer the default.  The default is now
> + - subtree_check is no-longer the default. The default is now
>      no_subtree_check.
>    - By default the system 'rpcgen' is used while building
>      nfs-utils rather than the internal one.
> @@ -43,14 +43,14 @@ Significant changes for nfs-utils 1.1.0 - March/April 2007
>   
>    - A new option, -n, was added to rpc.gssd which specifies that
>      accesses by root should not use 'machine credentials' when
> -   accessing NFS file systems mounted with Kerberos.  Using this
> +   accessing NFS file systems mounted with Kerberos. Using this
>      option allows the root user to access the NFS space using any
>      Kerberos principal, rather than always using the machine
> -   credentials.  However, its use also requires that root manually
> +   credentials. However, its use also requires that root manually
>      authenticate before attempting a mount with Kerberos.
>   
>      When rpc.gssd uses machine credentials, the selection algorithm has
> -   been changed.  Instead of simply using the first "nfs/*" key in the
> +   been changed. Instead of simply using the first "nfs/*" key in the
>      keytab, the keytab is now searched for keys in the following
>      defined order:
>   
> diff --git a/configure.ac b/configure.ac
> index 5d9cbf31..0a108171 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -688,12 +688,12 @@ AC_SUBST([AM_CFLAGS], ["$my_am_cflags $flg1 $flg2 $flg3 $flg4 $flg5"])
>   # Make sure that $ACLOCAL_FLAGS are used during a rebuild
>   AC_SUBST([ACLOCAL_AMFLAGS], ["-I $ac_macro_dir \$(ACLOCAL_FLAGS)"])
>   
> -# make _sysconfdir available for substituion in config files
> +# make _sysconfdir available for substitution in config files
>   # 2 "evals" needed late to expand variable names.
>   AC_SUBST([_sysconfdir])
>   AC_CONFIG_COMMANDS_PRE([eval eval _sysconfdir=$sysconfdir])
>   
> -# make _statedir available for substituion in config files
> +# make _statedir available for substitution in config files
>   # 2 "evals" needed late to expand variable names.
>   AC_SUBST([_statedir])
>   AC_CONFIG_COMMANDS_PRE([eval eval _statedir=$statedir])
> @@ -705,7 +705,7 @@ else
>   fi
>   AC_SUBST(rpc_pipefsmount)
>   
> -# make _rpc_pipefsmount available for substituion in config files
> +# make _rpc_pipefsmount available for substitution in config files
>   # 2 "evals" needed late to expand variable names.
>   AC_SUBST([_rpc_pipefsmount])
>   AC_CONFIG_COMMANDS_PRE([eval eval _rpc_pipefsmount=$rpc_pipefsmount])

