Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7044C7A4E
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiB1U0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiB1U0A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B249574BB
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646079920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1F83kWBlOPTXpOU5gFqTwfnERFl0ry8inv1xcq92Q54=;
        b=AbBsKN5tXqupOttLUsopM10PkdnpvN/SBdZXdJ4RTnoAQ2uoLO+0V7iVjvdUaSIdl12ifC
        Sgvm6zaLcNVNR4rfJ592/PiEdXUxoQS9fVz6ixAVk9EQ6veupvMiT6pStxkTNVZQUltnzd
        0TjYq9SgpXsRXb+8ZofKFuVmC6hvzes=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-Sq_V-TlhPhikr-TqJD9Z6w-1; Mon, 28 Feb 2022 15:25:19 -0500
X-MC-Unique: Sq_V-TlhPhikr-TqJD9Z6w-1
Received: by mail-qv1-f72.google.com with SMTP id p12-20020a0c9a0c000000b0043299cbbd36so12266059qvd.16
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=1F83kWBlOPTXpOU5gFqTwfnERFl0ry8inv1xcq92Q54=;
        b=0KYArn3ZoUQKebYLNbdNl6yujzpEewoMl8qLBUOhixhqDm6hA+aVDEPjtuIv93htpN
         hoPs64gZDVYA4IunKyDEaPjcJcyve5QULYwLvaoaDPbKoQc78MVLNMa7tWSD80IVnBE8
         3oTSSrxeQQlcCibOjNYhxA2ZuUL2O2S3FtS7wj6VlSRa1WiVJgGWrfzrZ9vNlg7kibms
         QN4//BLlyzAkWLWaVzy+/WqgOADbC9JQw97arc/NLUewm9Dt50QZ7g5l/xBGN6RGxS8k
         CaAqRNOmaPdyjBjOfsevdgvN2bRyyEeMO9yvdSYpQXRIDEJG4OjE5ZnNvPzTVPb5LMML
         3g6Q==
X-Gm-Message-State: AOAM5335g0gEgkkGd5o0XxncX2ZiER54aQxISbwAI5/jFtIFips8SUpV
        k/DJ9Xw6AGiAD0i/stV0hFbl+9dls0mscN/30ewSNlz6PyfF9UJoAUGVqSnRAH/lMfF503//Eao
        g5QmUQjGOfK+PB0c/KY+jx/Huz2edEkCa1QeSW/LUio8O5t3iTjIuMcagYJRanRLmRBuieQ==
X-Received: by 2002:a37:a148:0:b0:47e:b863:a656 with SMTP id k69-20020a37a148000000b0047eb863a656mr12159837qke.522.1646079918377;
        Mon, 28 Feb 2022 12:25:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcHZpBfJg49pjKGwii2jVRsjqoi1Dj4SOSBUaOYGGu87kW6po54C6efJTbCGnyyKBODq6P/A==
X-Received: by 2002:a37:a148:0:b0:47e:b863:a656 with SMTP id k69-20020a37a148000000b0047eb863a656mr12159824qke.522.1646079918016;
        Mon, 28 Feb 2022 12:25:18 -0800 (PST)
Received: from [172.31.1.6] ([71.161.196.139])
        by smtp.gmail.com with ESMTPSA id z196-20020a3765cd000000b0050848cdb596sm5454416qkb.101.2022.02.28.12.25.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:25:17 -0800 (PST)
Message-ID: <dc3daf5f-cd51-f03a-3042-e6659c3d3c90@redhat.com>
Date:   Mon, 28 Feb 2022 15:25:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] systemd: Fix format-overflow warning
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220223202120.126170-1-steved@redhat.com>
In-Reply-To: <20220223202120.126170-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/23/22 3:21 PM, Steve Dickson wrote:
> rpc-pipefs-generator.c:35:23: error: '%s' directive output between 0 and 2147483653 bytes may exceed minimum required size of 4095 [-Werror=format-overflow=]
>     35 |         sprintf(path, "%s/%s", dirname, pipefs_unit);
>        |                       ^
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-6-2-rc3)

steved.
> ---
>   systemd/rpc-pipefs-generator.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
> index c24db56..7b2bb4f 100644
> --- a/systemd/rpc-pipefs-generator.c
> +++ b/systemd/rpc-pipefs-generator.c
> @@ -28,11 +28,12 @@ static int generate_mount_unit(const char *pipefs_path, const char *pipefs_unit,
>   {
>   	char	*path;
>   	FILE	*f;
> +	size_t size = (strlen(dirname) + 1 + strlen(pipefs_unit));
>   
> -	path = malloc(strlen(dirname) + 1 + strlen(pipefs_unit));
> +	path = malloc(size);
>   	if (!path)
>   		return 1;
> -	sprintf(path, "%s/%s", dirname, pipefs_unit);
> +	snprintf(path, size, "%s/%s", dirname, pipefs_unit);
>   	f = fopen(path, "w");
>   	if (!f)
>   	{

