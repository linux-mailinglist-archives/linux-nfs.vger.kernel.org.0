Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74655C94F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiF0Oey (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jun 2022 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiF0Oew (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jun 2022 10:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53708B7EF
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656340490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhZoRjal+jmR6sN4ej1+vD8J7/ZqAqC0JRzNAe8DPFw=;
        b=eNYVV5NbrRuFYqMYKv0jQ77wyu3IiNWAl0kQ3r83VH3rMjMcEgluUsEfHkXQrNVZCYef7q
        Zm4c8cj4YtpZA2G6Z4SN5H8aGqghTdVTOl8joPOj6P76AwHrA7J6+kkaSFbY9E8xoSSj6M
        lJReuO3s0M5AOafSR0po/p2KY7RXUfE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-7xaI4teyMImE6GpZk8zMKA-1; Mon, 27 Jun 2022 10:34:49 -0400
X-MC-Unique: 7xaI4teyMImE6GpZk8zMKA-1
Received: by mail-qv1-f70.google.com with SMTP id x18-20020a0ce252000000b004703cbb92ebso9529242qvl.21
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 07:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IhZoRjal+jmR6sN4ej1+vD8J7/ZqAqC0JRzNAe8DPFw=;
        b=z7mH3BbiSQ9z9UDylnDn+7ezdfFJJ1qtsUzwQdiUxMLeQKDflnrR9m3k2CGZtkfVRT
         DpPuXgTVjPrbC3h4UQQDczOtkqHQB0FvjG3Nmtr6IarqZHZw3BOdv4Y5tE5Rm9TjAEg9
         y6ES/zkT5zl8/H39I8cDTSAXh81HXDrWusbtGWhYCHjzWhCAmiengpYdTJebxU7RPuEE
         LcpzhurrDXiVUEUspYdvjIcEYN74XoeQGGFtMfncCRXPaxfK3A4P+j4wR7mbntA/zM/n
         zgB3KSw82CC/iw2hSPayoTLmLxpHiCl/t3UFtI9y5FDEMcPbm81T8lbwnXZwbaVXA5Eh
         6Kpg==
X-Gm-Message-State: AJIora8E0mNw5+2FsGE7Tfq6rLJB+yCsAGuN0U48bqu3QibwX7Q1claa
        LZ5X2A1GnnJ2AQR2vVJWNy0c4ygC5Q1YPXOBlTZQ474nshq51blA0UYfALFsVfQ6cNoUIT4kGdr
        cQKCCDbE/vt0gNUjt5SfO
X-Received: by 2002:ac8:5a44:0:b0:304:f19e:779c with SMTP id o4-20020ac85a44000000b00304f19e779cmr9458819qta.480.1656340488144;
        Mon, 27 Jun 2022 07:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tp+KkKVhdNGSthnxEDRu0TNFb03z1bbR7oGJbS8J1oNDAQFhcYtbdLa5vLDIQGNDqmzg01Gw==
X-Received: by 2002:ac8:5a44:0:b0:304:f19e:779c with SMTP id o4-20020ac85a44000000b00304f19e779cmr9458787qta.480.1656340487805;
        Mon, 27 Jun 2022 07:34:47 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.186.229])
        by smtp.gmail.com with ESMTPSA id r18-20020ac87ef2000000b00304e33f21f7sm6933140qtc.68.2022.06.27.07.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:34:47 -0700 (PDT)
Message-ID: <0e186d74-b59e-afdb-5ecc-a3fcd1d92cd1@redhat.com>
Date:   Mon, 27 Jun 2022 10:34:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH nfs-utils] modprobe: protect against sysctl errors
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <165594885936.4786.14207888490098319610@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <165594885936.4786.14207888490098319610@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/22/22 9:47 PM, NeilBrown wrote:
> 
> If there is an error running sysctl, a modprobe of these modules will
> fail.  We probably don't want that - missing a sysctl is unlikely to be
> fatal.
> 
> A real possibility is that /sbin/sysctl might not exist at all,
> such as in a initramfs.  In that case we definitely don't want modprobe
> to fail.
> 
> So make the scriptlets safe.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-6-2-rc8)

steved.
> ---
>   systemd/50-nfs.conf | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/systemd/50-nfs.conf b/systemd/50-nfs.conf
> index b56b2d765969..19e8ee734c8e 100644
> --- a/systemd/50-nfs.conf
> +++ b/systemd/50-nfs.conf
> @@ -1,16 +1,16 @@
>   # Ensure all NFS systctl settings get applied when modules load
>   
>   # sunrpc module supports "sunrpc.*" sysctls
> -install sunrpc /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && /sbin/sysctl -q --pattern sunrpc --system
> +install sunrpc /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && { /sbin/sysctl -q --pattern sunrpc --system; exit 0; }
>   
>   # rpcrdma module supports sunrpc.svc_rdma.*
> -install rpcrdma /sbin/modprobe --ignore-install rpcrdma $CMDLINE_OPTS && /sbin/sysctl -q --pattern sunrpc.svc_rdma --system
> +install rpcrdma /sbin/modprobe --ignore-install rpcrdma $CMDLINE_OPTS && { /sbin/sysctl -q --pattern sunrpc.svc_rdma --system; exit 0; }
>   
>   # lockd module supports "fs.nfs.nlm*" and "fs.nfs.nsm*" sysctls
> -install lockd /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && /sbin/sysctl -q --pattern fs.nfs.n[sl]m --system
> +install lockd /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && { /sbin/sysctl -q --pattern fs.nfs.n[sl]m --system; exit 0; }
>   
>   # nfsv4 module supports "fs.nfs.*" sysctls (nfs_callback_tcpport and idmap_cache_timeout)
> -install nfsv4 /sbin/modprobe --ignore-install nfsv4 $CMDLINE_OPTS && /sbin/sysctl -q --pattern 'fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout)' --system
> +install nfsv4 /sbin/modprobe --ignore-install nfsv4 $CMDLINE_OPTS && { /sbin/sysctl -q --pattern 'fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout)' --system; exit 0; }
>   
>   # nfs module supports "fs.nfs.*" sysctls
> -install nfs /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && /sbin/sysctl -q --pattern fs.nfs --system
> +install nfs /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && { /sbin/sysctl -q --pattern fs.nfs --system; exit 0; }

