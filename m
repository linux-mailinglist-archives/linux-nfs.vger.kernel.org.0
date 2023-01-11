Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28207665FD0
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjAKP4d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 10:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbjAKP4X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 10:56:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E962AC75E
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673452536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANgPKw4peN0kZhf8V1uZre3LMYSqsFwRKv7XdY+ayPA=;
        b=faxeyvsnxTFuZq5BjFNgmprzuHnFToMwt1rTAAWRKjTepQGogv+D6xDc0xEw/t5gtPi68c
        wUyY48jIlW9reQ/YdKZT17O/hN+GySBMFZ0r9WL9B0fltys91OQ1i70glJ4lpkZmnTRE9G
        KKheolTExQWfE32HEDO0TpateUTy3Ac=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-Afs2Nnu0NKeCbLPbcTSBfQ-1; Wed, 11 Jan 2023 10:55:35 -0500
X-MC-Unique: Afs2Nnu0NKeCbLPbcTSBfQ-1
Received: by mail-qv1-f70.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso8568575qvr.0
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANgPKw4peN0kZhf8V1uZre3LMYSqsFwRKv7XdY+ayPA=;
        b=GYQupDJd8I9zWDe7Daf9d00HE6hpXbjP5tKjScvOikssQOlMqe3jT43qeufh2z/G6r
         MkM/R1BeUHfkA+/rYIvO/zoAL7QcG0NTnDp7G74l8YgpXDEe7Yg4M+LVTMslwcY0s2He
         yc2+2pwZJH5z4ShLmvddEmIORXj76l5sNAuJISH8vrM3U/+r9yc3ndZG9JSQmLdZ/jBO
         XQ8FO50DCXgkrcFKsgeKg541RQa4vaH2Z/SR2+RfVUVdAzlcleoxvi8YyxXx3zCbb0Jt
         +ZC5GYuK4IKTVYn7eryIRIsSR03D69oY4fceGPYD37i+UG58ZXCPplMF0d+PLO2tEQb8
         cq2A==
X-Gm-Message-State: AFqh2kqi1kyowTQOqrQVsSx7ZQoPQZ/bbsDeK8opnssmY2633p/B7fvs
        wa5k4vvFZiWDlM/XDCHEx9bk+at/xTqpf6NSQ0w/D9rroLDvqkenPP2bUcJ3cVcHbdeEdN/nlRQ
        BJvQjf9GLlU441hPUi96z
X-Received: by 2002:a05:622a:229f:b0:3a9:861d:a6a6 with SMTP id ay31-20020a05622a229f00b003a9861da6a6mr101380517qtb.36.1673452533430;
        Wed, 11 Jan 2023 07:55:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXss1T7i4ZwcO1h5A8kzkw8Ud1oAWO/gkiOol3YqhJAV0234cjApAa/lct6OKhjACPPTALrjrA==
X-Received: by 2002:a05:622a:229f:b0:3a9:861d:a6a6 with SMTP id ay31-20020a05622a229f00b003a9861da6a6mr101380497qtb.36.1673452533127;
        Wed, 11 Jan 2023 07:55:33 -0800 (PST)
Received: from [172.31.1.6] ([70.109.130.165])
        by smtp.gmail.com with ESMTPSA id bx6-20020a05622a090600b003a81029654csm7791997qtb.31.2023.01.11.07.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:55:32 -0800 (PST)
Message-ID: <29a84188-21cc-fcf2-a9ce-5cc6e6c26c56@redhat.com>
Date:   Wed, 11 Jan 2023 10:55:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [nfs-utils PATCH] Don't allow junction tests to trigger
 automounts
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        JianHong Yin <jiyin@redhat.com>
References: <20221213160104.198237-1-jlayton@kernel.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221213160104.198237-1-jlayton@kernel.org>
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



On 12/13/22 11:01 AM, Jeff Layton wrote:
> JianHong reported some strange behavior with automounts on an nfs server
> without an explicit pseudoroot. When clients issued a readdir in the
> pseudoroot, automounted directories that were not yet mounted would show
> up even if they weren't exported, though the clients wouldn't be able to
> do anything with them.
> 
> The issue was that triggering the automount on a directory would cause
> the mountd upcall to time out, which would cause nfsd to include the
> automounted dentry in the readdir response. Eventually, the automount
> would work and report that it wasn't exported and subsequent attempts to
> access the dentry would (properly) fail.
> 
> We never want mountd to trigger an automount. The kernel should do that
> if it wants to use it. Change the junction checks to do an O_PATH open
> and use fstatat with AT_NO_AUTOMOUNT.
> 
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2148353
> Reported-by: JianHong Yin <jiyin@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Committed... (tag: nfs-utils-2-6-3-rc6)

steved
> ---
>   support/junction/junction.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/support/junction/junction.c b/support/junction/junction.c
> index 41cce261cb52..0628bb0ffffb 100644
> --- a/support/junction/junction.c
> +++ b/support/junction/junction.c
> @@ -63,7 +63,7 @@ junction_open_path(const char *pathname, int *fd)
>   	if (pathname == NULL || fd == NULL)
>   		return FEDFS_ERR_INVAL;
>   
> -	tmp = open(pathname, O_DIRECTORY);
> +	tmp = open(pathname, O_PATH|O_DIRECTORY);
>   	if (tmp == -1) {
>   		switch (errno) {
>   		case EPERM:
> @@ -93,7 +93,7 @@ junction_is_directory(int fd, const char *path)
>   {
>   	struct stat stb;
>   
> -	if (fstat(fd, &stb) == -1) {
> +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) == -1) {
>   		xlog(D_GENERAL, "%s: failed to stat %s: %m",
>   				__func__, path);
>   		return FEDFS_ERR_ACCESS;
> @@ -121,7 +121,7 @@ junction_is_sticky_bit_set(int fd, const char *path)
>   {
>   	struct stat stb;
>   
> -	if (fstat(fd, &stb) == -1) {
> +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) == -1) {
>   		xlog(D_GENERAL, "%s: failed to stat %s: %m",
>   				__func__, path);
>   		return FEDFS_ERR_ACCESS;
> @@ -155,7 +155,7 @@ junction_set_sticky_bit(int fd, const char *path)
>   {
>   	struct stat stb;
>   
> -	if (fstat(fd, &stb) == -1) {
> +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) == -1) {
>   		xlog(D_GENERAL, "%s: failed to stat %s: %m",
>   			__func__, path);
>   		return FEDFS_ERR_ACCESS;
> @@ -393,7 +393,7 @@ junction_get_mode(const char *pathname, mode_t *mode)
>   	if (retval != FEDFS_OK)
>   		return retval;
>   
> -	if (fstat(fd, &stb) == -1) {
> +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) == -1) {
>   		xlog(D_GENERAL, "%s: failed to stat %s: %m",
>   			__func__, pathname);
>   		(void)close(fd);

