Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34268619FD3
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 19:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiKDS0t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 14:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiKDS0s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 14:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299EE57
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667586350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFUa1oFqgpZIlGKGUlzPXnx8RQrTULWjpowCBC10GgQ=;
        b=iHV8g0G4A8hYEy5rQKhc/v7iGMj4bdwkjTbOmlK5D9YXWTXB8iFQmehU2Fjfw/RA0aO1B/
        3h969dPUN12G/uSTRWot4mvsJQFaAw0djPUt3j/+ooGT6LXFeJH7tkZImetznU/BhvpR4d
        BJp7DyK8O068bnerq7D9FEqJehN8Dr4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-YJcl8wNHNz6iiiJZZjk4Sg-1; Fri, 04 Nov 2022 14:25:48 -0400
X-MC-Unique: YJcl8wNHNz6iiiJZZjk4Sg-1
Received: by mail-qt1-f198.google.com with SMTP id y19-20020a05622a121300b003a526e0ff9bso4283663qtx.15
        for <linux-nfs@vger.kernel.org>; Fri, 04 Nov 2022 11:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFUa1oFqgpZIlGKGUlzPXnx8RQrTULWjpowCBC10GgQ=;
        b=xKx1UVIyrHXYzliFTi+JVtiH813GLkMsMO9V0O9aet/vQ6TUnPhc8PYlOQFzd8kAeM
         fjCAiK//QKIdqtsSVywNRmLr9c+mAcsEbjdQkbLF4jH06iIzagEz1xxyVfyzlP+q4ki6
         hGdDCKYYYhizMLFMXlH9U3jmrNdvER5IOxhDJkdYzaQZKDBpmewYGLg4JGS5vVyIAOSY
         Nq0rIz/UZ+dRCKq4AEIy6ydd31LYM2ZTQcF0H4yZ9tMTJ3eDYN5YxNPFDtC5CVs/dd+0
         m4IuIFPax1HPMGh7r6B1IPT6ldbIhpKuFMMtY7HLulX/qDaW6ypF4TlK8aGDIEuTlQTg
         txzQ==
X-Gm-Message-State: ACrzQf20IwcEbT0Nq7JThb/I2kCQxjwem8HJEBH2Epf+85vS4WwEorq8
        f+JPug8jqqZ+5CWl4DgjOqkLQOxJOSMx5EK0+LwXSJ+ctyEtGWt0lkIuNepJm1NaUykUCqMy9d4
        UsxqXzd0bcM7/K9XEuBqP4rWaACQpVZAdR6c6Fx3P709KkXh+dtfMKQ1PY3hajbpYD1921A==
X-Received: by 2002:a05:620a:51d3:b0:6fa:7934:8132 with SMTP id cx19-20020a05620a51d300b006fa79348132mr6818909qkb.581.1667586348031;
        Fri, 04 Nov 2022 11:25:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM59ixHPOsUoKl0zwAeiqCZTC0aFUniDhHBeHbSBONLXNOdQUUufXbQsT0h79fqpBZV3Gzp/DA==
X-Received: by 2002:a05:620a:51d3:b0:6fa:7934:8132 with SMTP id cx19-20020a05620a51d300b006fa79348132mr6818894qkb.581.1667586347686;
        Fri, 04 Nov 2022 11:25:47 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05620a318600b006bb366779a4sm3374753qkb.6.2022.11.04.11.25.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:25:47 -0700 (PDT)
Message-ID: <bf5ac4a8-364f-c14a-567a-4e9d0f96daf6@redhat.com>
Date:   Fri, 4 Nov 2022 14:25:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] nfsd.man: Explain that setting nfsv4=n turns off all v4
 versions
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20221028150547.19646-1-steved@redhat.com>
In-Reply-To: <20221028150547.19646-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/28/22 11:05 AM, Steve Dickson wrote:
> Update the man page to explicitly say setting
> nfsv4=n turns off all v4 versions
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-6-3-rc3)

steved.
> ---
>   utils/nfsd/nfsd.man | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
> index 634b8a6..bb99fe2 100644
> --- a/utils/nfsd/nfsd.man
> +++ b/utils/nfsd/nfsd.man
> @@ -159,7 +159,9 @@ Enable or disable TCP support.
>   .B vers3
>   .TP
>   .B vers4
> -Enable or disable a major NFS version.  3 and 4 are normally enabled
> +Enable or disable
> +.B all
> +NFSv4 versions.  All versions are normally enabled
>   by default.
>   .TP
>   .B vers4.1

