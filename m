Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74B754A91
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jul 2023 20:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGOSIf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jul 2023 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOSIe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jul 2023 14:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3EF2127
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689444466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iamKAJgwJgdTwW02X5OuZ3rqyMMNbIZBCLF/DQ4FzlY=;
        b=VhPi+E6kBTDxzcjpr2xKABb5iOv6TH6D+26gJVqn352FV1Gq3LZ0FhH6nhI/WkFptdW/Bc
        /NNwEIY95eyvgpead0Beg7M85xx81b62N7gkkCJNLufeSlKzT1pobzMDgg+5QFrp1dndSb
        QEhsxlN/VfwSp4vo+xJJ3oE/Ec2WlK8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-jEiRZawQPTOxJnmwwj1cNw-1; Sat, 15 Jul 2023 14:07:44 -0400
X-MC-Unique: jEiRZawQPTOxJnmwwj1cNw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635de6f75e0so7142016d6.1
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 11:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689444464; x=1692036464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iamKAJgwJgdTwW02X5OuZ3rqyMMNbIZBCLF/DQ4FzlY=;
        b=VcGpvkUEe8mJ93FgeyOIa/iz0oFj/uSiJD27ljaE+MuPBm3jYtlwZ4MpP2s3vWNv+J
         DMKnDvctbFWirw6YupRYGaspODVtiOkLQ5tF2jkytjYWLDkBvUxsI1xp6c9VQgRE+Eq2
         KS96k/iZQ77PnVEZFYSxTIGcQgNBUDZAcXQR72ZbQOXTg9CE3mjF4XeLv6xUpHUsMuen
         3+V/E0THnGBXS3e/QP/FmVbfLx9W5LagbPQjs2nBJbEm+sF6cAIEPm6ik5vEY9FkY+d2
         VYwql4rsyn7MNh5vqzZHGMrGkfTNZsdK2/NFSw8JcD7lCWLGcWYBne2Fp5QsHJzF6y2M
         OATg==
X-Gm-Message-State: ABy/qLavbzc0gyzgSlmQERQczK4oPFExFBdCEQozIGSGfsXpaQoUMeH3
        IAhhK85VZ7MBk91o3+VHng/BYR7sOc9jomN6q/98+u6OBOdWwYNl4uLHeLyZEL1ztsK5DSNtTTT
        4Lkj23Gd3L3eC0k/0t8tK
X-Received: by 2002:ad4:4eea:0:b0:634:cdae:9941 with SMTP id dv10-20020ad44eea000000b00634cdae9941mr1009539qvb.0.1689444463952;
        Sat, 15 Jul 2023 11:07:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpFiktFMhrHpBHw2rfuvkyjIDtNfi5r6thvCZQjcPC2IoRqJ9U6ucmHnqseKI8om42XgXByQ==
X-Received: by 2002:ad4:4eea:0:b0:634:cdae:9941 with SMTP id dv10-20020ad44eea000000b00634cdae9941mr1009526qvb.0.1689444463631;
        Sat, 15 Jul 2023 11:07:43 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.31])
        by smtp.gmail.com with ESMTPSA id e20-20020a0ce3d4000000b006375f9fd170sm5052947qvl.34.2023.07.15.11.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 11:07:43 -0700 (PDT)
Message-ID: <a6e861a1-1609-11fc-219c-88dd8d90b526@redhat.com>
Date:   Sat, 15 Jul 2023 14:07:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] nfs(5): Document the new "xprtsec=" mount option
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
References: <168935977873.1850.8214830433103692090.stgit@bazille.1015granger.net>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <168935977873.1850.8214830433103692090.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 7/14/23 2:36 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> More information about RPC-with-TLS and some brief set-up guidance
> are to be provided in a separate man page in Section 7.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Question: commit b5e4539f already add this RPC-with-TLS
update to the man page. So do you want me to revert b5e4539f
and replace it with this patch?

steved.

> ---
>   utils/mount/nfs.man |   38 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index d9f34df36b42..dfc31a5dad26 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -574,7 +574,43 @@ The
>   .B sloppy
>   option is an alternative to specifying
>   .BR mount.nfs " -s " option.
> -
> +.TP 1.5i
> +.BI xprtsec= policy
> +Specifies the use of transport layer security to protect NFS network
> +traffic on behalf of this mount point.
> +.I policy
> +can be one of
> +.BR none ,
> +.BR tls ,
> +or
> +.BR mtls .
> +.IP
> +If
> +.B none
> +is specified,
> +transport layer security is forced off, even if the NFS server supports
> +transport layer security.
> +If
> +.B tls
> +is specified, the client uses RPC-with-TLS to provide in-transit
> +confidentiality.
> +If
> +.B mtls
> +is specified, the client uses RPC-with-TLS to authenticate itself and
> +to provide in-transit confidentiality.
> +If either
> +.B tls
> +or
> +.B mtls
> +is specified and the server does not support RPC-with-TLS or peer
> +authentication fails, the mount attempt fails.
> +.IP
> +If the
> +.B xprtsec=
> +option is not specified,
> +the default behavior depends on the kernel version,
> +but is usually equivalent to
> +.BR "xprtsec=none" .
>   .SS "Options for NFS versions 2 and 3 only"
>   Use these options, along with the options in the above subsection,
>   for NFS versions 2 and 3 only.
> 
> 

