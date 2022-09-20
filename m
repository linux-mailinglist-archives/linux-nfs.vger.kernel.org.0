Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AAF5BED02
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiITSsx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Sep 2022 14:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiITSsw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Sep 2022 14:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E08C74B9E
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663699728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Dkz+vyaSR4q88otLbUdNAn6DLbGXNehFzsnUguPd7o=;
        b=Y0O4zJwqXLwsqsrRrm52ljWqKqxNXkAwxVSV0XlzyXTtP3uBa6E3TT2ZVTeCBq8M2dzjmD
        mc8qk3JwzcTuiEuIK2+wrCLYKFA+gwI1NIHFfXSfYJH8sCGtPO3sZIpeCcmaW9QRU/CSsY
        JYMrxlI4uyVZkAQdrKHwuoQhEk9u1VM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-352-fD_uUttBNqmr6OU5fCfI7Q-1; Tue, 20 Sep 2022 14:48:47 -0400
X-MC-Unique: fD_uUttBNqmr6OU5fCfI7Q-1
Received: by mail-qt1-f198.google.com with SMTP id w4-20020a05622a134400b0035cbc5ec9a2so2506435qtk.14
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 11:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+Dkz+vyaSR4q88otLbUdNAn6DLbGXNehFzsnUguPd7o=;
        b=jnJj8Mwnk7CK0RLcLTzB1T2Bklba2wIXehidEuu5g6O7PMCG6CaS0qrCyBkLJudkez
         ZjYqythQqFngRggnOtWVyvsKpqZtD0E1sf3ayTu/7KWLWmJ43W+CBxpDwzWHbABYHnd0
         lfI0iCrYe3OS0QH8eRJujlIXdW2DMSYvjB+mSsSzQG3l9wTkdl7k9XeFgIivyV4KoaLB
         eooIRqCbqWTlStvLUhVT/cf8ymHBJaYTS5ARz+2RYk0B3eT8i1Ha3zdJxAieMhqUz3kw
         iJyuAqDo5lRNYg4i8/1jyODjo7BFEYOc3Figz3whwcK0GxSdvkCXEiZI22gkKdP5Qwe4
         psUQ==
X-Gm-Message-State: ACrzQf2Pi6jM2arWTJC/y0cH2jome1Y4W7iFsyn+3rn31bq2QtSlHA5O
        Mrqa4+tT0eYuf5MS2WpJsYP3+I30eD6UhLwzYcEaHuQfoq6hoeOZ8Jt8a3MPVefWc9pLRA/FdbH
        ZYk9E4Ruzk7SeB8Gz1sMj
X-Received: by 2002:a05:6214:76b:b0:4ac:be62:d2e5 with SMTP id f11-20020a056214076b00b004acbe62d2e5mr20253959qvz.91.1663699726883;
        Tue, 20 Sep 2022 11:48:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51LCz2Bw1+tyz7dqKWt/5Yy2HIoIMZUcvLhdh517Oon41UArbXBSWdbopssUnAAL2CY3sB3Q==
X-Received: by 2002:a05:6214:76b:b0:4ac:be62:d2e5 with SMTP id f11-20020a056214076b00b004acbe62d2e5mr20253940qvz.91.1663699726571;
        Tue, 20 Sep 2022 11:48:46 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.93.20])
        by smtp.gmail.com with ESMTPSA id y17-20020a37f611000000b006b5cc25535fsm320513qkj.99.2022.09.20.11.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 11:48:46 -0700 (PDT)
Message-ID: <4db19e2a-40eb-dce9-0094-f6b1e479a95b@redhat.com>
Date:   Tue, 20 Sep 2022 14:48:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/2] nfs4_setfacl: add a specific option for indexes
Content-Language: en-US
To:     Pierguido Lambri <plambri@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220914173115.296058-1-plambri@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220914173115.296058-1-plambri@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/14/22 1:31 PM, Pierguido Lambri wrote:
> nfs4_setfacl had the possibility to use an optional index
> to add/remove an ACL entry.
> This was causing some confusion as numeric files could be interpreted
> as indexes.
> This change adds an extra command line option '-i' to specifically
> handle the indexes.
> The index can be used only with certain operations (add and remove).
> The new syntax, when using indexes, would be:
> 
> ~]# nfs4_setfacl -i 3 -a A::101:rxtncy file123
> 
> Signed-off-by: Pierguido Lambri <plambri@redhat.com>
Committed (tag: nfs4-acl-tools-0.4.1-rc3)

steved.
> ---
>   nfs4_setfacl/nfs4_setfacl.c | 60 +++++++++++++++++++++++--------------
>   1 file changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/nfs4_setfacl/nfs4_setfacl.c b/nfs4_setfacl/nfs4_setfacl.c
> index e581608..d10e073 100644
> --- a/nfs4_setfacl/nfs4_setfacl.c
> +++ b/nfs4_setfacl/nfs4_setfacl.c
> @@ -143,7 +143,7 @@ int main(int argc, char **argv)
>   	int opt, err = 1;
>   	int numpaths = 0, curpath = 0;
>   	char *tmp, **paths = NULL, *path = NULL, *spec_file = NULL;
> -	FILE *s_fp = NULL;
> +	FILE *s_fp, *fd = NULL;
>   
>   	if (!strcmp(basename(argv[0]), "nfs4_editfacl")) {
>   		action = EDIT_ACTION;
> @@ -155,7 +155,7 @@ int main(int argc, char **argv)
>   		return err;
>   	}
>   
> -	while ((opt = getopt_long(argc, argv, "-:a:A:s:S:x:X:m:ethvHRPL", long_options, NULL)) != -1) {
> +	while ((opt = getopt_long(argc, argv, "-:a:A:i:s:S:x::X:m:ethvHRPL", long_options, NULL)) != -1) {
>   		switch (opt) {
>   			case 'a':
>   				mod_string = optarg;
> @@ -165,21 +165,14 @@ int main(int argc, char **argv)
>   			add:
>   				assert_wu_wei(action);
>   				action = INSERT_ACTION;
> -
> -				/* run along if no more args (defaults to ace_index 1 == prepend) */
> -				if (optind == argc)
> -					break;
> -				ace_index = strtoul_reals(argv[optind++], 10);
> -				if (ace_index == ULONG_MAX) {
> -					/* oops it wasn't an ace_index; reset */
> -					optind--;
> -					ace_index = -1;
> -				} else if (ace_index == 0) {
> -					fprintf(stderr, "Sorry, valid indices start at '1'.\n");
> -					goto out;
> +				break;
> +			case 'i':
> +				ace_index = strtoul_reals(optarg, 10);
> +				if (ace_index == 0) {
> +                                    fprintf(stderr, "Sorry, valid indices start at '1'.\n");
> +                                    goto out;
>   				}
>   				break;
> -
>   			case 's':
>   				mod_string = optarg;
>   				goto set;
> @@ -191,9 +184,14 @@ int main(int argc, char **argv)
>   				break;
>   
>   			case 'x':
> -				ace_index = strtoul_reals(optarg, 10);
> -				if(ace_index == ULONG_MAX)
> -					mod_string = optarg;
> +				/* make sure we handle the argument even if
> +				 * it doesn't immediately follow the option
> +				 */
> +				if (optarg == NULL && optind < argc && argv[optind][0] != '-')
> +				{
> +					optarg = argv[optind++];
> +				}
> +				mod_string = optarg;
>   				goto remove;
>   			case 'X':
>   				spec_file = optarg;
> @@ -255,6 +253,9 @@ int main(int argc, char **argv)
>   					case 'A':
>   						fprintf(stderr, "Sorry, -a requires an 'acl_spec', whilst -A requires a 'spec_file'.\n");
>   						goto out;
> +					case 'i':
> +						fprintf(stderr, "Sorry, -i requires an index (numerical)\n");
> +						goto out;
>   					case 's':
>   						fprintf(stderr, "Sorry, -s requires an 'acl_spec'.\n");
>   						goto out;
> @@ -297,7 +298,21 @@ int main(int argc, char **argv)
>   	if (action == NO_ACTION) {
>   		fprintf(stderr, "No action specified.\n");
>   		goto out;
> -	} else if (numpaths < 1) {
> +	} else if (action != INSERT_ACTION && action != REMOVE_ACTION && ace_index >= 0) {
> +		fprintf(stderr, "Index can be used only with add or remove.\n");
> +		goto out;
> +	} else if (numpaths <= 0 && ace_index >= 0 && mod_string)
> +	{
> +		/* Make sure the argument is a file */
> +		if (!(fd = fopen(mod_string, "r"))) {
> +			fprintf(stderr, "No path(s) specified.\n");
> +			goto out;
> +		} else
> +			fclose(fd);
> +		paths = malloc(sizeof(char *) * (argc - optind + 1));
> +		paths[numpaths++] = mod_string;
> +	} else if (numpaths < 1)
> +	{
>   		fprintf(stderr, "No path(s) specified.\n");
>   		goto out;
>   	}
> @@ -609,9 +624,10 @@ static void __usage(const char *name, int is_ef)
>   	"%s %s -- manipulate NFSv4 file/directory access control lists\n"
>   	"Usage: %s [OPTIONS] COMMAND file ...\n"
>   	" .. where COMMAND is one of:\n"
> -	"   -a acl_spec [index]	 add ACL entries in acl_spec at index (DEFAULT: 1)\n"
> -	"   -A file [index]	 read ACL entries to add from file\n"
> -	"   -x acl_spec | index	 remove ACL entries or entry-at-index from ACL\n"
> +	"   -a acl_spec		 add ACL entries in acl_spec at defaul index (DEFAULT: 1)\n"
> +	"   -A file 		 read ACL entries to add from file\n"
> +	"   -i index 		 use the entry-at-index from ACL (only for add and remove)\n"
> +	"   -x acl_speci 	 remove ACL entries\n"
>   	"   -X file  		 read ACL entries to remove from file\n"
>   	"   -s acl_spec		 set ACL to acl_spec (replaces existing ACL)\n"
>   	"   -S file		 read ACL entries to set from file\n"

