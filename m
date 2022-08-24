Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735295A0280
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbiHXUKu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiHXUKt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 16:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB55AE43
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661371845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tE5/lGsAjKVDLsWLWWKqhF16tk3/hN/HIY281w2ACVQ=;
        b=NG39OdSEA8LJ96EVVrTkpsl7ox8+yMQ42EroEZthTv+I1JSS2Ybh3qzrq2ylPJv0dNrwKi
        9Vbj1fmtYSLtKw2LOLNkpjpKdRYXEEv+HXw2JdVHri7OSC9ntLIAW4AOwkuI3Hw+0BqG96
        grKDxnhOmycATOxmP5a+TAsDK6CPGSo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102--gBCVDUsMa2kte6yofKjlw-1; Wed, 24 Aug 2022 16:10:42 -0400
X-MC-Unique: -gBCVDUsMa2kte6yofKjlw-1
Received: by mail-qk1-f198.google.com with SMTP id h20-20020a05620a245400b006bb0c6074baso15483870qkn.6
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 13:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tE5/lGsAjKVDLsWLWWKqhF16tk3/hN/HIY281w2ACVQ=;
        b=qjHyDdSiT8fNDEYNf24h0F/N2Jp/EpZNZsIDwkGnHB3ezwL09ScYjewroGMBoxQTbi
         ULPvWtNjKhRwUlN/dOPxNYkNMKqc0yQJFEWNRuLKpVIfvpQwJCXc7hA1Gm6p1ybLp4PP
         3krkl9MN20ncaRWh45BFCp0+QcXMx+g6tiLCZvmmmnBBfz13gKwM3J+5jeQOZ3qTGoer
         cmkqS6U9y9d+UrxJ7JBBtbrg+B5YkDjMyfjZjEips68GDUNa8WYHYP4uKg2UXQN/0AeR
         SGEfTfOaYZ4NkX3j3uWNa9RH6n7M55SlYksyxHBBKx0JAvjXGyCiY2ZbDcv0/MsXd9gv
         PBjQ==
X-Gm-Message-State: ACgBeo0Kzo2uLB2SRYyF7tAL7ezcOTNEoF/6Z8Ho6q9ZBugNy28buAld
        P/8h14IsDKBNeQX/wtUWVgGbkFzwROCECYGytyeIRVdynpY/Z7+kfI+iHae31A2P+bo/s9Z+sWt
        RtXVZ4yzjljlc5sy57cvI
X-Received: by 2002:a05:620a:2545:b0:6b6:6773:f278 with SMTP id s5-20020a05620a254500b006b66773f278mr777545qko.390.1661371841732;
        Wed, 24 Aug 2022 13:10:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5RGdJswZa6jnkQY3HVZ+68Ga84vr4bqjdMER/aVoIm6QgMsJ5abtm8tcPM8eEF78Ybnp/KrA==
X-Received: by 2002:a05:620a:2545:b0:6b6:6773:f278 with SMTP id s5-20020a05620a254500b006b66773f278mr777524qko.390.1661371841434;
        Wed, 24 Aug 2022 13:10:41 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.94.45])
        by smtp.gmail.com with ESMTPSA id y206-20020a3764d7000000b006b9ab3364ffsm15298769qkb.11.2022.08.24.13.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 13:10:41 -0700 (PDT)
Message-ID: <dff91106-4869-c20b-502b-4d3e0e9ac536@redhat.com>
Date:   Wed, 24 Aug 2022 16:10:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] nfs4_setfacl: add a specific option for indexes
Content-Language: en-US
To:     Pierguido Lambri <plambri@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220815083908.65720-1-plambri@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220815083908.65720-1-plambri@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I'll go ahead and que this patch.. but there needs to be
an manpage update for me to commit to it...

steved.
On 8/15/22 4:39 AM, Pierguido Lambri wrote:
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
> ---
>   nfs4_setfacl/nfs4_setfacl.c | 37 +++++++++++++++++--------------------
>   1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/nfs4_setfacl/nfs4_setfacl.c b/nfs4_setfacl/nfs4_setfacl.c
> index d0485ad..c3bdf56 100644
> --- a/nfs4_setfacl/nfs4_setfacl.c
> +++ b/nfs4_setfacl/nfs4_setfacl.c
> @@ -148,7 +148,7 @@ int main(int argc, char **argv)
>   		return err;
>   	}
>   
> -	while ((opt = getopt_long(argc, argv, "-:a:A:s:S:x:X:m:ethvHRPL", long_options, NULL)) != -1) {
> +	while ((opt = getopt_long(argc, argv, "-:a:A:i:s:S:x:X:m:ethvHRPL", long_options, NULL)) != -1) {
>   		switch (opt) {
>   			case 'a':
>   				mod_string = optarg;
> @@ -158,21 +158,14 @@ int main(int argc, char **argv)
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
> @@ -184,9 +177,6 @@ int main(int argc, char **argv)
>   				break;
>   
>   			case 'x':
> -				ace_index = strtoul_reals(optarg, 10);
> -				if(ace_index == ULONG_MAX)
> -					mod_string = optarg;
>   				goto remove;
>   			case 'X':
>   				spec_file = optarg;
> @@ -248,6 +238,9 @@ int main(int argc, char **argv)
>   					case 'A':
>   						fprintf(stderr, "Sorry, -a requires an 'acl_spec', whilst -A requires a 'spec_file'.\n");
>   						goto out;
> +					case 'i':
> +						fprintf(stderr, "Sorry, -i requires an index (numerical)\n");
> +						goto out;
>   					case 's':
>   						fprintf(stderr, "Sorry, -s requires an 'acl_spec'.\n");
>   						goto out;
> @@ -283,6 +276,9 @@ int main(int argc, char **argv)
>   	if (action == NO_ACTION) {
>   		fprintf(stderr, "No action specified.\n");
>   		goto out;
> +	} else if (action != INSERT_ACTION && action != REMOVE_ACTION && ace_index >= 0) {
> +		fprintf(stderr, "Index can be used only with add or remove.\n");
> +		goto out;
>   	} else if (numpaths < 1) {
>   		fprintf(stderr, "No path(s) specified.\n");
>   		goto out;
> @@ -548,9 +544,10 @@ static void __usage(const char *name, int is_ef)
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

