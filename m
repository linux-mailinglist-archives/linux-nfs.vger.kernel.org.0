Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BABD4F67EE
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Apr 2022 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiDFRt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiDFRtq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 13:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9511A181B0F
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649260678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZkosHO3/qohnzYjmrzPUmovzbkO3kB+s/3SZou3ANY=;
        b=JC8r/SARnpmmW+qje8YpTvRRnivlTx4RFqdcI54/8SiNynwXQYIsw48D0C60UMZrtTbwEE
        V7AofXJtWzQKjpaRlTAyVTDRIsAtLKlv4rpJQcm5Qw+B1icYGNytvo/F27fIBNxyaa0wrw
        YVmvs/xABxcRJO3jKvOEvvWJid/tMmw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-N7ee4_m-NGu59oW5RoTQug-1; Wed, 06 Apr 2022 11:57:57 -0400
X-MC-Unique: N7ee4_m-NGu59oW5RoTQug-1
Received: by mail-qt1-f199.google.com with SMTP id p6-20020a05622a00c600b002e1cb9508e8so3248438qtw.20
        for <linux-nfs@vger.kernel.org>; Wed, 06 Apr 2022 08:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tZkosHO3/qohnzYjmrzPUmovzbkO3kB+s/3SZou3ANY=;
        b=uvDxtjeMV3sSOWdM8v+bk+CnRk6lG32rhQbEM3iRAgbFAf0LcAIfhHoU/ruLAFWubF
         pBGXGaB7BCUCkp1tVuh1YU4IoXGs6nISXQAhTErf5yWTRVxwEqDtS+jU9Pua6Lu+p9tM
         ygCVg4m79mr4ab1ZeGfnbXxElLAIfcqzlLH9oXcLFCEiqRJ3xTmkqba/PZBi2fKVMoVd
         JsSXSSWrqulkalCjuxUUGaUXekgiEz0Lzi0KK+SD0E6g29AfkcNSW74fZkoyJIIYDLSV
         RNP9mSJQoecOJOkOyATQMF34QY8uarP74CUvkgbeWCaftY3zOwmI74BGXwFzPMgske5f
         ooiQ==
X-Gm-Message-State: AOAM5301tqphz+CPvcnod93zwEMMFd4gapynrZSo9A8zWmJgZ9nKZKdR
        J2kevAUyvsfG2eEfLWxzNRZE32uN4NnWYq/jsLBz+zuL23EIFGWHqilMjvvvtA/bb6xXKY2Wwfd
        2peRENoVVc/F6UlBSe4ft
X-Received: by 2002:ac8:5fcf:0:b0:2e1:ebd9:3e38 with SMTP id k15-20020ac85fcf000000b002e1ebd93e38mr8112633qta.149.1649260676692;
        Wed, 06 Apr 2022 08:57:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBFrXaaSvJ1VVoUmT6Jbzb0CgOJjxQYypYQpv2O520k3GpmyxzXgAIJq7tmV9bkY5J4AZ9Uw==
X-Received: by 2002:ac8:5fcf:0:b0:2e1:ebd9:3e38 with SMTP id k15-20020ac85fcf000000b002e1ebd93e38mr8112617qta.149.1649260676422;
        Wed, 06 Apr 2022 08:57:56 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.124.94])
        by smtp.gmail.com with ESMTPSA id 3-20020a370503000000b0067b03f03589sm9893337qkf.53.2022.04.06.08.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 08:57:56 -0700 (PDT)
Message-ID: <852313a3-005e-2771-8be1-888891370533@redhat.com>
Date:   Wed, 6 Apr 2022 11:57:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH/RFC] mount.nfs: handle EADDRINUSE from mount(2)
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <164816808982.6096.11435363819568479436@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <164816808982.6096.11435363819568479436@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

My apologies for taking so long to get to this....

On 3/24/22 8:28 PM, NeilBrown wrote:
> 
> [[This is the followup to the kernel patch I recently posted.
>    It changes the behaviour of incorrectly configured containers to
>    get unique client identities - so lease stealing doesn't happen
>    so data corruption is avoided - but does not provide stable
>    identities, so reboot recovery is not ideal.
Which patch are you referring to and did it make it in?

>    What is best to do when configuration is wrong?  Provide best service
>    possible despite it not being perfect, or provide no service so the
>    config will not get fixed.  I could be swayed either way.
> ]]
Maybe a little both? :-) Flag the broken config and continue on
if possible... but flagging the broken config is more critical... IMHO.

> 
> When NFS filesystems are mounted in different network namespaces, each
> network namespace must provide a different hostname (via accompanying
> UTS namespace) or different identifier (via sysfs).
> 
> If the kernel finds that the identity that it constructs is already in
> use in a different namespace it will fail the mount with EADDRINUSE.
> 
> This patch catches that error and, if the sysfs identifier is unset,
> writes a random string and retries.  This allows the mount to complete
> safely even when misconfigured.  The random string has 128 bits of
> entropy and so is extremely likely to be globally unique.
> 
> A lock is taken on the identifier file, and it is only updated if no
> identifier is set.  Thus two concurrent mount attempts will not generate
> different identities.  The mount is retried in any case as a race may
> have updated the identifier while waiting for the lock.
> 
> This is not an ideal solution as an unclean restart of the host cannot
> be detected by the server except by a lease timeout.  If the identifier
> is configured correctly and is stable across restarts, the server can
> detect the restart immediately.  Consequently a warning message is
> generated to encourage correct configuration.
Just curious... How did you test this patch? I would like
to build an env to generate this type of error.

steved.

> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   utils/mount/stropts.c | 54 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index dbdd11e76b41..84266830b84a 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -32,6 +32,7 @@
>   
>   #include <sys/socket.h>
>   #include <sys/mount.h>
> +#include <sys/file.h>
>   #include <netinet/in.h>
>   #include <arpa/inet.h>
>   
> @@ -749,6 +750,50 @@ out:
>   	return ret;
>   }
>   
> +#define ENTROPY_BITS 128
> +static void set_random_identifier(void)
> +{
> +	int fd = open("/sys/fs/nfs/net/nfs_client/identifier", O_RDWR);
> +	int rfd = -1;
> +	unsigned char rbuf[ENTROPY_BITS / 8];
> +	char buf[sizeof(rbuf)*2 + 2];
> +	int n, rn;
> +	int cnt = 1000;
> +
> +	if (fd < 0)
> +		goto out;
> +	/* wait at most one second */
> +	while (flock(fd, LOCK_EX | LOCK_NB) != 0) {
> +		cnt -= 20;
> +		if (cnt < 0)
> +			goto out;
> +		usleep(20 * 1000);
> +	}
> +	n = read(fd, buf, sizeof(buf)-1);
> +	if (n <= 0)
> +		goto out;
> +	buf[n] = 0;
> +	if (n != 7 || strcmp(buf, "(null)\n") != 0)
> +		/* already set */
> +		goto out;
> +	rfd = open("/dev/urandom", O_RDONLY);
> +	if (rfd < 0)
> +		goto out;
> +	rn = read(rfd, rbuf, sizeof(rbuf));
> +	if (rn < (int)sizeof(rbuf))
> +		goto out;
> +	for (n = 0; n < rn; n++)
> +		snprintf(&buf[n*2], 3, "%02x", rbuf[n]);
> +	strcpy(&buf[n*2], "\n");
> +	lseek(fd, SEEK_SET, 0);
> +	write(fd, buf, strlen(buf));
> +out:
> +	if (rfd >= 0)
> +		close(rfd);
> +	if (fd >= 0)
> +		close(fd);
> +}
> +
>   static int nfs_do_mount_v4(struct nfsmount_info *mi,
>   		struct sockaddr *sap, socklen_t salen)
>   {
> @@ -844,7 +889,14 @@ static int nfs_do_mount_v4(struct nfsmount_info *mi,
>   			progname, extra_opts);
>   
>   	result = nfs_sys_mount(mi, options);
> -
> +	if (!result && errno == EADDRINUSE) {
> +		/* client id is not unique, try to create unique id
> +		 * and try again
> +		 */
> +		set_random_identifier();
> +		xlog_warn("Retry mount with randomized identifier. Please configure a stable identifier.");
> +		result = nfs_sys_mount(mi, options);
> +	}
>   	/*
>   	 * If success, update option string to be recorded in /etc/mtab.
>   	 */

