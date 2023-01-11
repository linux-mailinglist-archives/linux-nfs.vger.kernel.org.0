Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82255665FD3
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 16:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjAKP6L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 10:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjAKP5w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 10:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8ABF42
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673452633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2Cq23rDT1H8ZaN0ny+x9sY5OPs6EZbKc/HB7v4IBg8=;
        b=eE3Cfk5+5BJE6JxrdjtoLxyslyLJ+eHfLMT3vh/HnD9I2c8gquNHjNUZ9FiaptW3l7jx3T
        DP7C4qKW4YX1ZP3An3MOnFv+3affxfBJ0fy21bm/oKsrWeWQISHqYbBzRoG8A7LA0lqSqV
        ras+M03URDi7nL69fjfwA3SX8mLFtuw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-0-duIei-MOiQMvShfxOJ7A-1; Wed, 11 Jan 2023 10:57:12 -0500
X-MC-Unique: 0-duIei-MOiQMvShfxOJ7A-1
Received: by mail-qt1-f200.google.com with SMTP id k7-20020ac84747000000b003a87ca26200so7335840qtp.6
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2Cq23rDT1H8ZaN0ny+x9sY5OPs6EZbKc/HB7v4IBg8=;
        b=cljH0dmTqgDXS6gwhMUeO1qbtkM7f8Ej7x51hgYtSu0RSK3RQVLNtmfXZTL4n+fulu
         f2zUQ/fRkAAXjPndUwDTGonErpZZodY9ENnyk1jtEwKC1+8OVP6+2+PscTh4Wh19RL6I
         NsDGiKeXGEppIi3quArD5S+/saAD+fBlaUyhHdHnYPeW5ceVIml1Iib3ZuHi87yTtVlt
         Eughh6YK/4Y1D+FNPeV0M5YGsH0iS9V2C9Eyhtr8z/jdsRNLfF1/S8hBhBBf0XvP4Vjm
         /npC8sXCF6g4GcCnSdHIiDDmiTNLwglykN89ZY5Tr0SqTu9fKuZfVbB16KOUBn4yi27h
         kR8A==
X-Gm-Message-State: AFqh2komRGMudJzZXQ741xLOgBhN2CXUHvVg6MvPA+NpnAvi5HPgIJNT
        30AUlM9k4jKtLH6pl7xoEzEP5aUHFR1wQHcLyu1/7UMxKjYhLkpEh6RVOwE2NZD3ewYVd+t5mOZ
        iF71XkpgVoOs/cLyPoJkUkvAm9ZbuWT+Hjb2JT9+QbIxy8HD01eJV9BZRuzBP6ZUJEFYINg==
X-Received: by 2002:ac8:674e:0:b0:3a9:7c51:1944 with SMTP id n14-20020ac8674e000000b003a97c511944mr99419776qtp.42.1673452631770;
        Wed, 11 Jan 2023 07:57:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuo2EM/zAqzpPbZ1t2wWoCuPP1UaxVi1hdGxvF2oFfbdtvzgy5Zoq1F4l5cRWl0ZXk/xIHpTQ==
X-Received: by 2002:ac8:674e:0:b0:3a9:7c51:1944 with SMTP id n14-20020ac8674e000000b003a97c511944mr99419729qtp.42.1673452631293;
        Wed, 11 Jan 2023 07:57:11 -0800 (PST)
Received: from [172.31.1.6] ([70.109.130.165])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a284a00b006feea093006sm9222330qkp.124.2023.01.11.07.57.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:57:10 -0800 (PST)
Message-ID: <c137cbd6-2073-c217-927c-d95e0e891e7d@redhat.com>
Date:   Wed, 11 Jan 2023 10:57:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] Covscan Scan: Fixed a couple CLANG_WARNINGs
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20230104170855.19822-1-steved@redhat.com>
 <20230104170855.19822-2-steved@redhat.com>
In-Reply-To: <20230104170855.19822-2-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/4/23 12:08 PM, Steve Dickson wrote:
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2151971
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-6-3-rc6)

steved.
> ---
>   tools/nfsrahead/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> index c83c6f7..8a11cf1 100644
> --- a/tools/nfsrahead/main.c
> +++ b/tools/nfsrahead/main.c
> @@ -167,7 +167,7 @@ int main(int argc, char **argv)
>   		if ((ret = get_device_info(argv[optind], &device)) == 0)
>   			break;
>   
> -	if (ret != 0) {
> +	if (ret != 0 || device.fstype == NULL) {
>   		xlog(D_GENERAL, "unable to find device %s\n", argv[optind]);
>   		goto out;
>   	}

