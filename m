Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0250F60B694
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 21:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJXTFL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiJXTEH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 15:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597D898C87
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666633346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xTScrm/C4P5LsOqv2gmaJGgYIy5W21InSwcYJLPGZw=;
        b=SaU5ynR3nJ61gHnOLFfZ72ZAEBnjmyyZj1CvBMUZkkRR9rJu5bQ4SIuIYUqpKP8eZ1HDOe
        h4Jfi9n5dSWXp6qyVdoWO2a/UUPrY7R8GNRL2faDRJnepPgPygvMd5vzx6zwXr7G7cyVJ3
        PLmnySeIwXKS94lAbkU0KEZDqTjETk4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-599-8crPYYAEOdGGM6x2wsN3Ng-1; Mon, 24 Oct 2022 13:42:24 -0400
X-MC-Unique: 8crPYYAEOdGGM6x2wsN3Ng-1
Received: by mail-qk1-f200.google.com with SMTP id h9-20020a05620a244900b006ee944ec451so9550012qkn.13
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xTScrm/C4P5LsOqv2gmaJGgYIy5W21InSwcYJLPGZw=;
        b=WHFW5gjVfYCP/nE8z+LtiYsFwpyBxPl9c72zdcWcaIoUp+DuMCKbraPPDdpRVWoa28
         dyFqZrfYMYu/NckUCYLZ9dzSErz0yVDTozHsvdOuOr/y1IlJ9DnXd99GEtoDEzDKSc9q
         aWeCU4cV61qyB4tS7OXPE2EqDwiWitHt9vVl8z4oyvtaR94S+HpgH9ago9azwmNM72lH
         yE6/VOyxDSfrK3yGgd4yH9Me1h9sREZBUMiPmUzT7eWzufxYxn1dzzYn9czfVnupqZ/3
         YJi5qhmXrpkjQRhXoWhdqrmxKDfMVrPnfSZtFUV9uGq3GDJNHrjDjeoqJSh5sT7PR7Eb
         Obfg==
X-Gm-Message-State: ACrzQf3yXMYk7Llq+SRBSGC1796/7z9ntHqPAW/zoA0LpfA/jDQi5vFl
        FGloeYzNmN9h5JuEggGk/ApC7T1sdBcjXC5Q/Sv4tbugJR7YgqrK3nLBINjd10Whr0wyUHXgS2K
        iQRC0Cnwqj1X7V6q/GO+h
X-Received: by 2002:a05:620a:46a7:b0:6ee:dea7:cc1c with SMTP id bq39-20020a05620a46a700b006eedea7cc1cmr24475122qkb.506.1666633343649;
        Mon, 24 Oct 2022 10:42:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5OhAKWEJHovasT+cvZtPaKhh7DjW0eEGQDFYDB2Vlzo57Finb7SgMfCWlfSGDIRSfICPaZkw==
X-Received: by 2002:a05:620a:46a7:b0:6ee:dea7:cc1c with SMTP id bq39-20020a05620a46a700b006eedea7cc1cmr24475102qkb.506.1666633343373;
        Mon, 24 Oct 2022 10:42:23 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id q29-20020a37f71d000000b006bb83c2be40sm332922qkj.59.2022.10.24.10.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:42:22 -0700 (PDT)
Message-ID: <4f3047ad-85f3-f1dd-e3e6-44624a49a017@redhat.com>
Date:   Mon, 24 Oct 2022 13:42:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/1] nfsiostat: Handle both readahead counts for
 statsver >= 1.2
Content-Language: en-US
To:     Dave Wysochanski <dwysocha@redhat.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1633782441-17839-1-git-send-email-dwysocha@redhat.com>
 <1633782441-17839-2-git-send-email-dwysocha@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <1633782441-17839-2-git-send-email-dwysocha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/9/21 8:27 AM, Dave Wysochanski wrote:
> Subject:
> [PATCH v2 1/1] nfsiostat: Handle both readahead counts for statsver >= 1.2
> From:
> Dave Wysochanski <dwysocha@redhat.com>
> Date:
> 10/9/21, 8:27 AM
> 
> To:
> chuck.lever@oracle.com, steved@redhat.com
> CC:
> linux-nfs@vger.kernel.org
> 
> 
> Later kernel versions convert NFS readpages to readahead so update
> the counts accordingly.
> 
> Signed-off-by: Dave Wysochanski<dwysocha@redhat.com>
Committed...

steved
> ---
>   tools/nfs-iostat/nfs-iostat.py | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
> index 1df74ba822b5..85294fb9448c 100755
> --- a/tools/nfs-iostat/nfs-iostat.py
> +++ b/tools/nfs-iostat/nfs-iostat.py
> @@ -43,7 +43,7 @@ NfsEventCounters = [
>       'vfspermission',
>       'vfsupdatepage',
>       'vfsreadpage',
> -    'vfsreadpages',
> +    'vfsreadpages', # or vfsreadahead in statvers=1.2 or above
>       'vfswritepage',
>       'vfswritepages',
>       'vfsreaddir',
> @@ -86,14 +86,14 @@ class DeviceData:
>               self.__nfs_data['export'] = words[1]
>               self.__nfs_data['mountpoint'] = words[4]
>               self.__nfs_data['fstype'] = words[7]
> -            if words[7] == 'nfs':
> -                self.__nfs_data['statvers'] = words[8]
> +            if words[7] == 'nfs' or words[7] == 'nfs4':
> +                self.__nfs_data['statvers'] = float(words[8].split('=',1)[1])
>           elif 'nfs' in words or 'nfs4' in words:
>               self.__nfs_data['export'] = words[0]
>               self.__nfs_data['mountpoint'] = words[3]
>               self.__nfs_data['fstype'] = words[6]
>               if words[6] == 'nfs':
> -                self.__nfs_data['statvers'] = words[7]
> +                self.__nfs_data['statvers'] = float(words[7].split('=',1)[1])
>           elif words[0] == 'age:':
>               self.__nfs_data['age'] = int(words[1])
>           elif words[0] == 'opts:':
> @@ -294,8 +294,11 @@ class DeviceData:
>           print()
>           print('%d nfs_readpage() calls read %d pages' % \
>               (vfsreadpage, vfsreadpage))
> -        print('%d nfs_readpages() calls read %d pages' % \
> -            (vfsreadpages, pages_read - vfsreadpage))
> +        multipageread = "readpages"
> +        if self.__nfs_data['statvers'] >= 1.2:
> +            multipageread = "readahead"
> +        print('%d nfs_%s() calls read %d pages' % \
> +            (vfsreadpages, multipageread, pages_read - vfsreadpage))
>           if vfsreadpages != 0:
>               print('(%.1f pages per call)' % \
>                   (float(pages_read - vfsreadpage) / vfsreadpages))
> -- 1.8.3.1
> 

