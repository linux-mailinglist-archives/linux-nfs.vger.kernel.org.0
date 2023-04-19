Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A881F6E7D6D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjDSOt3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 10:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjDSOt2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 10:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776DE3C0D
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681915725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXE/3zfQM8IiQvVF2aa941PWlKDN6ov0KA7sidO6c9w=;
        b=Y/f24Ro81zHiIroUQn5hPcolxJY1S9RkXorq9bV90XS2aoa8ap4xfLKPBDe2gusqLnV+9J
        YORnkI3qguEqzpz2MCxXQfzdDt4pem4iYpiq4KZcSUNVsRtGAt9RCEzV0zNXqbnL6oYOGC
        BisP7OI9nWDL0jFj77t9y/HUESY6RmI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-WO0SzH5iNxqSsPenSkThgw-1; Wed, 19 Apr 2023 10:48:44 -0400
X-MC-Unique: WO0SzH5iNxqSsPenSkThgw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74cf009f476so1362685a.0
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 07:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915723; x=1684507723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXE/3zfQM8IiQvVF2aa941PWlKDN6ov0KA7sidO6c9w=;
        b=KQBY2vB9J7WxzZdAJ8bwUuVcq9tlJLj5EQmFSTBwy+IlRl9oZzbRQBtAn8wyrcfnfW
         v1sHwwqz7Dcboz351eaCIm13NN8HlyGORBoUeY3Lr0VpEHoNtVZ/I+0HBjZQly9DWptj
         NUYM+DP2Cujqhjg2k5vFrISrG+mNOVoQJtxzUgRqjvVClNwh2lFqawY2qwqqiasCgqnj
         aetOXN9V0njRmBBFppFz+f67dj1Tvk+hVdHTdb9DMU2+dbfAAPt/K5jBRPgsb9h3YdPy
         rNAY8MLGx1LQMwt/tMzxFM+48gPuzvQZrLvrv16Fq2CxPe4P60TT1aAGPfJ2uKhJRG4B
         QJOg==
X-Gm-Message-State: AAQBX9dG19qDrJhuoALMhgFffOB48/DsCOVC0bYGjSWuOenp+pdOc2Wz
        TqkTaa+HP7b8quAmH1YMUbVAfuZFjVthqX8+xigsDptUU24xfpCLK4P+brBUgHjlGyt1aNU1cve
        P8ZySESF+jiHbnMdoNq66unsHmqrV
X-Received: by 2002:ac8:5e0b:0:b0:3ee:5637:29be with SMTP id h11-20020ac85e0b000000b003ee563729bemr21075041qtx.5.1681915723074;
        Wed, 19 Apr 2023 07:48:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z7ixlLYiw61mWoyuHmCemdzhMUwyW4tWLKQmOxJK/jL+axR/Z4q5lHqsyHQ+JNrPp7aQVGvg==
X-Received: by 2002:ac8:5e0b:0:b0:3ee:5637:29be with SMTP id h11-20020ac85e0b000000b003ee563729bemr21075012qtx.5.1681915722776;
        Wed, 19 Apr 2023 07:48:42 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.248.80])
        by smtp.gmail.com with ESMTPSA id t15-20020a37aa0f000000b0074d1d3b2143sm3094087qke.118.2023.04.19.07.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 07:48:42 -0700 (PDT)
Message-ID: <6859c49e-ae96-378c-2b49-1767daa95c8c@redhat.com>
Date:   Wed, 19 Apr 2023 10:48:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [nfs-utils PATCH v2] mountd: don't advertise krb5 for v4root when
 not configured.
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-nfs <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
References: <168186226971.24821.9774040849376889413@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <168186226971.24821.9774040849376889413@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/18/23 7:57 PM, NeilBrown wrote:
> 
> If /etc/krb5.keytab does not exist, then krb5 cannot work, so
> advertising it as an option for v4root is pointless.
> Since linux commit 676e4ebd5f2c ("NFSD: SECINFO doesn't handle
> unsupported pseudoflavors correctly") this can result in an unhelpful
> warning if the krb5 code is not built, or built as a module which is not
> installed.
> 
> [  161.668635] NFS: SECINFO: security flavor 390003 is not supported
> [  161.668655] NFS: SECINFO: security flavor 390004 is not supported
> [  161.668670] NFS: SECINFO: security flavor 390005 is not supported
> 
> So avoid advertising krb5 security options when krb5.keytab cannot be
> found.
> 
> Note that testing for /etc/krb5.keytab is what we already do in a couple
> of systemd unit file to determine if krb5 is enabled.
> 
> Link: https://lore.kernel.org/linux-nfs/20170104190327.v3wbpcbqtfa5jy7d@codemonkey.org.uk/
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-6-3-rc9)

steved.
> ---
>   support/export/v4root.c         |  2 ++
>   support/include/pseudoflavors.h |  1 +
>   support/nfs/exports.c           | 14 +++++++-------
>   3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/support/export/v4root.c b/support/export/v4root.c
> index fbb0ad5f5b81..03805dcb4e6d 100644
> --- a/support/export/v4root.c
> +++ b/support/export/v4root.c
> @@ -66,6 +66,8 @@ set_pseudofs_security(struct exportent *pseudo)
>   
>   		if (!flav->fnum)
>   			continue;
> +		if (flav->need_krb5 && access("/etc/krb5.keytab", F_OK) != 0)
> +			continue;
>   
>   		i = secinfo_addflavor(flav, pseudo);
>   		new = &pseudo->e_secinfo[i];
> diff --git a/support/include/pseudoflavors.h b/support/include/pseudoflavors.h
> index deb052b130e6..1f16f3f796f3 100644
> --- a/support/include/pseudoflavors.h
> +++ b/support/include/pseudoflavors.h
> @@ -8,6 +8,7 @@
>   struct flav_info {
>   	char    *flavour;
>   	int     fnum;
> +	int	need_krb5;
>   };
>   
>   extern struct flav_info flav_map[];
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 2c8f0752ad9d..010dfe423d6f 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -36,13 +36,13 @@
>     (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
>   
>   struct flav_info flav_map[] = {
> -	{ "krb5",	RPC_AUTH_GSS_KRB5	},
> -	{ "krb5i",	RPC_AUTH_GSS_KRB5I	},
> -	{ "krb5p",	RPC_AUTH_GSS_KRB5P	},
> -	{ "unix",	AUTH_UNIX		},
> -	{ "sys",	AUTH_SYS		},
> -	{ "null",	AUTH_NULL		},
> -	{ "none",	AUTH_NONE		},
> +	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
> +	{ "krb5i",	RPC_AUTH_GSS_KRB5I,	1},
> +	{ "krb5p",	RPC_AUTH_GSS_KRB5P,	1},
> +	{ "unix",	AUTH_UNIX,		0},
> +	{ "sys",	AUTH_SYS,		0},
> +	{ "null",	AUTH_NULL,		0},
> +	{ "none",	AUTH_NONE,		0},
>   };
>   
>   const int flav_map_size = sizeof(flav_map)/sizeof(flav_map[0]);

