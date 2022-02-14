Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C14B55F5
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiBNQUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 11:20:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiBNQUb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 11:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69C4C4A3CA
        for <linux-nfs@vger.kernel.org>; Mon, 14 Feb 2022 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644855622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lGkfpnpBj21E7cKSgX2esb5JBVyU70o0K22jBg66E3w=;
        b=dQLCWRYSQf0RQSKC1T+JuzbdZa0nBaevqtR2tD2cdjbZlOuOHV+ObtPJKqCOeDfLGpBmhd
        2b6s7k90lnU/CYujU/y9aqu4PI8lEMlMs9K6eBAM+mGxFzqdMqCKml0XsV5EkT1nK+4QTS
        Jxj2LZDfb9HBofxkYcII6797Mj6cOYY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-BoXmvULoP6SQCIVbDIQpXQ-1; Mon, 14 Feb 2022 11:20:19 -0500
X-MC-Unique: BoXmvULoP6SQCIVbDIQpXQ-1
Received: by mail-qk1-f197.google.com with SMTP id bk12-20020a05620a1a0c00b00508b8a58a62so9414686qkb.20
        for <linux-nfs@vger.kernel.org>; Mon, 14 Feb 2022 08:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lGkfpnpBj21E7cKSgX2esb5JBVyU70o0K22jBg66E3w=;
        b=5UQIhdAe1ORZ8bM8JESQ/38RpWPK6hpF/4riYZJrOuj0lXXs1T5ecgre1Ji8GcqbCZ
         P5rapviule33O6Qq5mIvDea7JhlN/Rp2iQXrJJdDCHC1fmW9MGXg8mAj+6zG6AG28XgM
         S0foZuNfGzhsfPEMR3os11/Q8ithvkBm94PxSKdnhKlxQXn4qrdNKolSf32yB40R+bRZ
         6s02Brwd0xTVOtsWJvkErMggHYOtXk4+uIIQ7U/cW4B/ORL+zdULckr+GFA1LldBk4vS
         qsu+ptN2norIAr59P2WEpmhGqayg0U9tH5Lggm73HQcMGMVLXVHfnm5OktZHRhSIOkS8
         OrLA==
X-Gm-Message-State: AOAM531vCecsN48+eBE6OGdTe53Dpq3LeAs9mGdJfXwJzG029+0A2fRX
        bhNEtVrYgm3RYUTQVXcpZNzXVnu6hVLUAAKCUrVetUGQ7UZcpT+f0ZDIbo3y1OQLI5bWBwdpTJa
        D+FxPnWSW+RpyE+DKdi9C
X-Received: by 2002:ad4:5945:: with SMTP id eo5mr244810qvb.77.1644855618543;
        Mon, 14 Feb 2022 08:20:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzBfLS+ybzFHEosDdl2g37O/lEBgbLOeMvjdfWDL3+qK7JSe+DesX8KFdj5WVZETlJ+GuXhw==
X-Received: by 2002:ad4:5945:: with SMTP id eo5mr244795qvb.77.1644855618251;
        Mon, 14 Feb 2022 08:20:18 -0800 (PST)
Received: from [172.31.1.6] ([70.105.253.180])
        by smtp.gmail.com with ESMTPSA id h13sm7331568qkp.77.2022.02.14.08.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:20:17 -0800 (PST)
Message-ID: <69301a48-3afc-9082-bc76-cdb5d3aeaf0c@redhat.com>
Date:   Mon, 14 Feb 2022 11:20:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Fix error reporting for already mounted shares.
Content-Language: en-US
To:     Rohan Sable <rsable@redhat.com>, linux-nfs@vger.kernel.org
Cc:     rohanjsable@gmail.com
References: <YfvV6O+accmE0yVb@fedora.rsable.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <YfvV6O+accmE0yVb@fedora.rsable.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/3/22 8:17 AM, Rohan Sable wrote:
> When mount is triggered for an already mounted
> share (using auto negotiation), it displays
> "mount.nfs: Protocol not supported" or
> "mount.nfs: access denied by server while mounting"
> instead of EBUSY. This easily causes confusion if
> the mount was not tried verbose :
> 
> [root@rsable ~]# mount 127.0.0.1:/export /mnt
> mount.nfs: Protocol not supported
> 
> [root@rsable ~]# mount -v 127.0.0.1:/export /mnt
> mount.nfs: timeout set for Mon Apr  5 16:03:53 2021
> mount.nfs: trying text-based options 'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'
> mount.nfs: mount(2): Protocol not supported
> mount.nfs: trying text-based options 'vers=4,minorversion=1,addr=127.0.0.1,clientaddr=127.0.0.1'
> mount.nfs: mount(2): Protocol not supported
> mount.nfs: trying text-based options 'vers=4,addr=127.0.0.1,clientaddr=127.0.0.1'
> mount.nfs: mount(2): Protocol not supported
> mount.nfs: trying text-based options 'addr=127.0.0.1'
> mount.nfs: prog 100003, trying vers=3, prot=6
> mount.nfs: trying 127.0.0.1 prog 100003 vers 3 prot TCP port 2049
> mount.nfs: prog 100005, trying vers=3, prot=17
> mount.nfs: trying 127.0.0.1 prog 100005 vers 3 prot UDP port 20048
> mount.nfs: mount(2): Device or resource busy  << actual error
> mount.nfs: Protocol not supported
> 
> [root@rsable ~]# mount rsable76server:/testshare /mnt
> mount.nfs: access denied by server while mounting rsable76server:/testshare
> 
> [root@rsable ~]# mount rsable76server:/testshare /mnt -v
> mount.nfs: timeout set for Mon Jan 17 13:36:16 2022
> mount.nfs: trying text-based options 'vers=4.1,addr=192.168.122.58,clientaddr=192.168.122.82'
> mount.nfs: mount(2): Permission denied
> mount.nfs: trying text-based options 'vers=4.0,addr=192.168.122.58,clientaddr=192.168.122.82'
> mount.nfs: mount(2): Permission denied
> mount.nfs: trying text-based options 'addr=192.168.122.58'
> mount.nfs: prog 100003, trying vers=3, prot=6
> mount.nfs: trying 192.168.122.58 prog 100003 vers 3 prot TCP port 2049
> mount.nfs: prog 100005, trying vers=3, prot=17
> mount.nfs: trying 192.168.122.58 prog 100005 vers 3 prot UDP port 20048
> mount.nfs: mount(2): Device or resource busy	<< actual error
> mount.nfs: access denied by server while mounting rsable76server:/testshare
> 
> Signed-off-by: Rohan Sable <rsable@redhat.com>
> Signed-off-by: Yongcheng Yang <yoyang@redhat.com>
Committed...

steved.
> ---
>   utils/mount/stropts.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 3c4e218a..573df6ee 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -973,7 +973,9 @@ fall_back:
>   	if ((result = nfs_try_mount_v3v2(mi, FALSE)))
>   		return result;
>   
> -	errno = olderrno;
> +	if (errno != EBUSY || errno != EACCES)
> +		errno = olderrno;
> +
>   	return result;
>   }
>   

