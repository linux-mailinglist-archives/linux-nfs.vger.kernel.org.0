Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288F86D83B7
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDEQbY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDEQbY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 12:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E0E40CC
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680712237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTqXxRhdY+JvHS3UGlRLeVtjHUzW22PSd9gtCa10I7s=;
        b=LEUYmYZP8JoNIwa+JYazs3GNF0xGofT3QagY4JxkU8hAkKdwMR63LGREmXPSzNhWmAmOjV
        n8wTGp/oTDc4sJqFr5BnYrYzeXAqVVXA6XjA+VEC0u0nZ7KxEZL+wSc06uEOKtfVdENGQ+
        LNCDxBuUutCWJuDU6zgRY1w0Kzjd+Sc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-LlriofMCOl-QJIFx0V2kTA-1; Wed, 05 Apr 2023 12:30:35 -0400
X-MC-Unique: LlriofMCOl-QJIFx0V2kTA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74678af9349so119490785a.0
        for <linux-nfs@vger.kernel.org>; Wed, 05 Apr 2023 09:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTqXxRhdY+JvHS3UGlRLeVtjHUzW22PSd9gtCa10I7s=;
        b=dk6tOMNryMpBOreXPDe5ZRMKmUOrk2i44Y5p7ltw4y/W6pEDtycjIGt8JEi9AMqiNP
         g0+alyhSffwTcBb1wObKCR7nei6J1AuGf4d5uUt/o5J+5Dt7IopOxA5m+i1/vYSX8Rz4
         T/xU2L80iYTOCD7YMiagNvMatL+rZ3zIN15PMFevC5iLIoHL5BFPi1RPXRbNeFAO/Hcq
         URcX+K+hm8gAnclSrw2DCaVUCCmSyWJWzEkiBFLpgjGjudVopPMfv7q+OWKEhf2sLzu2
         sUesgYpWNpjRhwloXpL+5rYlR6VpQvqJf//l2Nxvdltt8ef9tsiLewyghAlDX6J8FQpy
         gWKg==
X-Gm-Message-State: AAQBX9fFbTsMf8xU42Gk4D5ddNoOa/pIZY43vg5Up83DH8YI1uYI2MQO
        e9KCnJw5XR9a+rwcD517GaZFJw72MvKYT+G9ULvBo7+erDtti2nyi0M3tgykuvF2t6lcCby2QE1
        XAoAe6o+MAG9L3bx8PAGv82an0Rzq
X-Received: by 2002:a05:622a:1a24:b0:3e6:707e:d3c2 with SMTP id f36-20020a05622a1a2400b003e6707ed3c2mr6825324qtb.0.1680712234398;
        Wed, 05 Apr 2023 09:30:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350bQ2wGRMPg3OM35i1KHUh2mUzuHGUbQ9xJNIDKPwPzVaLoflb8YKdCjGsTqfHtTnZ4+lTGcJQ==
X-Received: by 2002:a05:622a:1a24:b0:3e6:707e:d3c2 with SMTP id f36-20020a05622a1a2400b003e6707ed3c2mr6825262qtb.0.1680712233930;
        Wed, 05 Apr 2023 09:30:33 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.174.217])
        by smtp.gmail.com with ESMTPSA id e1-20020a05620a014100b0074a1d2a17c8sm4380214qkn.29.2023.04.05.09.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:30:33 -0700 (PDT)
Message-ID: <13fd348e-cf5a-8507-4ee6-5600de2d034d@redhat.com>
Date:   Wed, 5 Apr 2023 12:30:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH nfs-utils] mount.nfs: always include mountpoint or spec if
 error messages.
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <167997198028.8106.1574926503489095936@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <167997198028.8106.1574926503489095936@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/27/23 10:53 PM, NeilBrown wrote:
> 
> If you try to mount from a server that is inaccessible you might get an
> error like:
>      mount.nfs: No route to host
> 
> This is OK when running "mount" interactively, but hardly useful when
> found in system logs.
> 
> This patch changes mount_error() to always included at least one of
> mount_point and spec in any error message.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-6-3-rc7)

steved.
> ---
>   utils/mount/error.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/utils/mount/error.c b/utils/mount/error.c
> index 73295bf0567c..9ddbcc096f72 100644
> --- a/utils/mount/error.c
> +++ b/utils/mount/error.c
> @@ -207,16 +207,17 @@ void mount_error(const char *spec, const char *mount_point, int error)
>   				progname, spec);
>   		break;
>   	case EINVAL:
> -		nfs_error(_("%s: an incorrect mount option was specified"), progname);
> +		nfs_error(_("%s: an incorrect mount option was specified for %s"),
> +				progname, mount_point);
>   		break;
>   	case EOPNOTSUPP:
> -		nfs_error(_("%s: requested NFS version or transport protocol is not supported"),
> -				progname);
> +		nfs_error(_("%s: requested NFS version or transport protocol is not supported for %s"),
> +				progname, mount_point);
>   		break;
>   	case ENOTDIR:
>   		if (spec)
> -			nfs_error(_("%s: mount spec %s or point %s is not a "
> -				  "directory"),	progname, spec, mount_point);
> +			nfs_error(_("%s: mount spec %s or point %s is not a directory"),
> +				  progname, spec, mount_point);
>   		else
>   			nfs_error(_("%s: mount point %s is not a directory"),
>   				  progname, mount_point);
> @@ -227,31 +228,31 @@ void mount_error(const char *spec, const char *mount_point, int error)
>   		break;
>   	case ENOENT:
>   		if (spec)
> -			nfs_error(_("%s: mounting %s failed, "
> -				"reason given by server: %s"),
> -				progname, spec, strerror(error));
> +			nfs_error(_("%s: mounting %s failed, reason given by server: %s"),
> +				  progname, spec, strerror(error));
>   		else
>   			nfs_error(_("%s: mount point %s does not exist"),
> -				progname, mount_point);
> +				  progname, mount_point);
>   		break;
>   	case ESPIPE:
>   		rpc_mount_errors((char *)spec, 0, 0);
>   		break;
>   	case EIO:
> -		nfs_error(_("%s: mount system call failed"), progname);
> +		nfs_error(_("%s: mount system call failed for %s"),
> +			  progname, mount_point);
>   		break;
>   	case EFAULT:
> -		nfs_error(_("%s: encountered unexpected error condition."),
> -				progname);
> +		nfs_error(_("%s: encountered unexpected error condition for %s."),
> +			  progname, mount_point);
>   		nfs_error(_("%s: please report the error to" PACKAGE_BUGREPORT),
> -				progname);
> +			  progname);
>   		break;
>   	case EALREADY:
>   		/* Error message has already been provided */
>   		break;
>   	default:
> -		nfs_error(_("%s: %s"),
> -			progname, strerror(error));
> +		nfs_error(_("%s: %s for %s on %s"),
> +			  progname, strerror(error), spec, mount_point);
>   	}
>   }
>   

