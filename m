Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09298515F54
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Apr 2022 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbiD3Qr5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Apr 2022 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383169AbiD3Qrz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 Apr 2022 12:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0080C58380
        for <linux-nfs@vger.kernel.org>; Sat, 30 Apr 2022 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651337071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ga9ROf5ix+tFT4oGIEf5QkQM90cv+Xc4ECD9D3wy18o=;
        b=Vyu1evG5GAcGRImbE5+AmOU/MusEZqH/Tn51N+FIMKCf9OA/ETvcTSxkFAEjRzx/DGJepk
        9k+8lxmhW/8SjR/vrhWBYqBkr/mKHFk9awwubTanihxtna9h9fucCojxk9OKF+qonvW9y9
        4nzeAyYsz3vBM586cJn2xbMth/bd9m4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-qZBDrv_XPOKbMST0cLRs8Q-1; Sat, 30 Apr 2022 12:44:30 -0400
X-MC-Unique: qZBDrv_XPOKbMST0cLRs8Q-1
Received: by mail-qv1-f72.google.com with SMTP id 13-20020a0562140d6d00b004563de53d74so8035791qvs.11
        for <linux-nfs@vger.kernel.org>; Sat, 30 Apr 2022 09:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ga9ROf5ix+tFT4oGIEf5QkQM90cv+Xc4ECD9D3wy18o=;
        b=sfT9bT2ay6ZhrLtU08vdkwyoLLD7DHofKgBPNF1BipOKwgLCEtrBXczqvIRWFAqOmI
         ndR1PmuAJlicFCB9zBRlq6dsZafJBbRuSWrzdrPKxwkWDg0EuwCEuE9/GXhxyqHb6k1L
         oKt8iWXgvhuXKIwqj/hcoHvrbaFocxBOtuw7nVnS36Ynf7nos/bIRjG0Z1apmSENxMfK
         wFCOpLbR6gQXvcNZfAiv4dfUplUxuzX+zBMRXbiSvi2BMSQHNOuCNf8Nhy5IoUAzRQXK
         HCbMxZEtg7ccweMYX5GiW2qxWRPVff3sm+fFWgx7qNtH7MK/fvUKELg4hYECKHz3Ps+g
         XuIg==
X-Gm-Message-State: AOAM533WcIdCJbRvIFnY8+gJ/cnVtjCjs0ps8R1BuDyXSuvNAXNeIaPP
        OSgrSYSrSzmYodb3z8YGFwckXhmt4/4J0NQQMskRMk9ztbJl3k/r19hqS2dQ+UZto0vbers7aua
        ylAsVuQYmMCIr5AX5KXic
X-Received: by 2002:ac8:5cd4:0:b0:2f3:9249:ff0b with SMTP id s20-20020ac85cd4000000b002f39249ff0bmr4105950qta.422.1651337069638;
        Sat, 30 Apr 2022 09:44:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGQoe5LVV/rma20hMVmzXPFYSz0rrcv+hxwYaXypP60mfrTxS2pP8v9gQyRjAmz0IwWwklVw==
X-Received: by 2002:ac8:5cd4:0:b0:2f3:9249:ff0b with SMTP id s20-20020ac85cd4000000b002f39249ff0bmr4105932qta.422.1651337069391;
        Sat, 30 Apr 2022 09:44:29 -0700 (PDT)
Received: from [172.31.1.6] ([71.168.80.171])
        by smtp.gmail.com with ESMTPSA id w24-20020a05620a095800b0069fc13ce23csm1359413qkw.109.2022.04.30.09.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 09:44:29 -0700 (PDT)
Message-ID: <6b3b7148-2b05-b0ed-d1ae-aa4eb72d68fe@redhat.com>
Date:   Sat, 30 Apr 2022 12:44:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nfsrahead: fix and improve logging.
Content-Language: en-US
To:     Thiago Becker <tbecker@redhat.com>, linux-nfs@vger.kernel.org
References: <20220429163604.1645422-1-tbecker@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220429163604.1645422-1-tbecker@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/29/22 12:36 PM, Thiago Becker wrote:
> Logging was not working properly wrt verbosity, it is changed by
> changing the facilities used. While at logging, add some extra logs when
> verbose that may be important.
> 
> Signed-off-by: Thiago Becker <tbecker@redhat.com>
Committed...

steved.
> ---
>   tools/nfsrahead/main.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> index 83a389f7..5fae941c 100644
> --- a/tools/nfsrahead/main.c
> +++ b/tools/nfsrahead/main.c
> @@ -85,8 +85,10 @@ static int get_mountinfo(const char *device_number, struct device_info *device_i
>   
>   	mnttbl = mnt_new_table();
>   
> -	if ((ret = mnt_table_parse_file(mnttbl, mountinfo_path)) < 0)
> +	if ((ret = mnt_table_parse_file(mnttbl, mountinfo_path)) < 0) {
> +		xlog(D_GENERAL, "Failed to parse %s\n", mountinfo_path);
>   		goto out_free_tbl;
> +	}
>   
>   	if ((fs = mnt_table_find_devno(mnttbl, device_info->dev, MNT_ITER_FORWARD)) == NULL) {
>   		ret = ENOENT;
> @@ -130,19 +132,20 @@ static int conf_get_readahead(const char *kind) {
>   	
>   	return readahead;
>   }
> -#define L_DEFAULT (L_WARNING | L_ERROR | L_FATAL)
>   
>   int main(int argc, char **argv)
>   {
>   	int ret = 0, retry;
>   	struct device_info device;
> -	unsigned int readahead = 128, verbose = 0, log_stderr = 0;
> +	unsigned int readahead = 128, log_level, log_stderr = 0;
>   	char opt;
>   
> +
> +	log_level = D_ALL & ~D_GENERAL;
>   	while((opt = getopt(argc, argv, "dF")) != -1) {
>   		switch (opt) {
>   		case 'd':
> -			verbose = 1;
> +			log_level = D_ALL;
>   			break;
>   		case 'F':
>   			log_stderr = 1;
> @@ -154,7 +157,7 @@ int main(int argc, char **argv)
>   
>   	xlog_stderr(log_stderr);
>   	xlog_syslog(~log_stderr);
> -	xlog_config(L_DEFAULT | (L_NOTICE & verbose), 1);
> +	xlog_config(log_level, 1);
>   	xlog_open(CONF_NAME);
>   
>   	// xlog_err causes the system to exit
> @@ -166,12 +169,12 @@ int main(int argc, char **argv)
>   			break;
>   
>   	if (ret != 0) {
> -		xlog(L_ERROR, "unable to find device %s\n", argv[optind]);
> +		xlog(D_GENERAL, "unable to find device %s\n", argv[optind]);
>   		goto out;
>   	}
>   
>   	if (strncmp("nfs", device.fstype, 3) != 0) {
> -		xlog(L_NOTICE,
> +		xlog(D_GENERAL,
>   			"not setting readahead for non supported fstype %s on device %s\n",
>   			device.fstype, argv[optind]);
>   		ret = -EINVAL;
> @@ -180,7 +183,7 @@ int main(int argc, char **argv)
>   
>   	readahead = conf_get_readahead(device.fstype);
>   
> -	xlog(L_WARNING, "setting %s readahead to %d\n", device.mountpoint, readahead);
> +	xlog(D_FAC7, "setting %s readahead to %d\n", device.mountpoint, readahead);
>   
>   	printf("%d\n", readahead);
>   

