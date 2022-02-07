Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37984AC9FC
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiBGT6d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 14:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiBGT6R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 14:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B22EBC0401DA
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644263895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfPounJOfhIoKCCpVX3r+qKgIQauZa+Vdhf/mLCt2b0=;
        b=M7q8QlamXl7qluoYkPQHU8NmGrGVFCuD/iGvTbYB1QZzv5Sezy6dn7CQzqFiCsYce8w8eI
        s517enIOrYnIAdKyr+9pH2mN6hwBryX2PWmpkjJJdQsI23XSgfPvwMi3ngMvF/wyxqTxDQ
        OPS8F2Jd6g9ZChFdVZ4x3pJr+dsEE0A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-FPk7_SnHMDCzT2cqgDhysg-1; Mon, 07 Feb 2022 14:58:14 -0500
X-MC-Unique: FPk7_SnHMDCzT2cqgDhysg-1
Received: by mail-qv1-f71.google.com with SMTP id g2-20020a0562141cc200b004123b0abe18so9459493qvd.2
        for <linux-nfs@vger.kernel.org>; Mon, 07 Feb 2022 11:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VfPounJOfhIoKCCpVX3r+qKgIQauZa+Vdhf/mLCt2b0=;
        b=M/wk9LOa2NWAAvqxE2FPgkaoQ1gDIYOxWV+6dNtVbYhjyAAL0VmyODHgOhPOmZyrrb
         2cAgFpt2Hw+KXgr5vDdqvPQXx/6nRTGKVrYAnzKetKdaOLT7X8IRDkjY/exqetOpypzY
         OxShgznmFFR4dUKBE6qwl4wYYc/wUQJER2pBxSmMafNeGtN8oHggUjfcvjzvK4GG+A65
         Q5uwSFtOP/JDHc2J+3p9MGa9hSJ6WO2pcklVw38f38U9EzlCXYmFTwkyHuMWySbeif3G
         XNEs6vd9POykdxK422ah5pTEJQqNcK0rlnWirsH10RiBfnZj3kcQx0FWPdB1uuWynU+w
         k7kg==
X-Gm-Message-State: AOAM533rIT1+fAejXcjY/6EWuwhInUzz9BwJEgZB+C9D4GBQzPZUuv6z
        eNiNUmnLUGYyg7K8+Z9wgqHmHISc1o714uGlZi79ZIk2Pu01uxLWG+LsKZ+73shX1Jod7nh3pCg
        eAY0GN3N3qvw2xsNbwBmf
X-Received: by 2002:a05:620a:4623:: with SMTP id br35mr859415qkb.586.1644263894192;
        Mon, 07 Feb 2022 11:58:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqSJ6Dsp/TQde9xEg5R+FhqjzBodqZv0Axxn6UpuB8qg07JkJ8JZyp2ax9Wjh12APHO0eEQg==
X-Received: by 2002:a05:620a:4623:: with SMTP id br35mr859404qkb.586.1644263893937;
        Mon, 07 Feb 2022 11:58:13 -0800 (PST)
Received: from [172.31.1.6] ([70.105.253.180])
        by smtp.gmail.com with ESMTPSA id h7sm6343220qtb.27.2022.02.07.11.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 11:58:13 -0800 (PST)
Message-ID: <c416e70b-35c6-6b8c-df04-ed496e9a978d@redhat.com>
Date:   Mon, 7 Feb 2022 14:58:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 8/9] rpcctl: Add a man page
Content-Language: en-US
To:     schumaker.anna@gmail.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
 <20220127194952.63033-9-Anna.Schumaker@Netapp.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220127194952.63033-9-Anna.Schumaker@Netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Anna!

On 1/27/22 2:49 PM, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>   tools/rpcctl/rpcctl.man | 88 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 88 insertions(+)
>   create mode 100644 tools/rpcctl/rpcctl.man
> 
> diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
> new file mode 100644
> index 000000000000..e4dd53ac8531
> --- /dev/null
> +++ b/tools/rpcctl/rpcctl.man
> @@ -0,0 +1,88 @@
> +.\"
> +.\" rpcctl(8)
> +.\"
> +.TH rpcctl 8 "25 Jan 2022"
> +.SH NAME
> +rpcctl \- Displays SunRPC connection information
> +.SH SYNOPSIS
> +.B rpcctl
> +.RB [ \-h | \-\-help ]
> +.P
> +.B rpcctl client
> +.RB [ \-h | \-\-help ]
> +.RB [ \--id
> +.IR ID ]
> +.P
> +.B rpcctl switch
> +.RB [ \-h | \-\-help ]
> +.RB [ \--id
> +.IR ID ]
> +.P
> +.B rpcctl switch set
> +.RB [ \-h | \-\-help ]
> +.RB [ \--id
> +.IR ID ]
> +.RB [ \--dstaddr
> +.IR dstaddr]
> +.P
> +.B rpcctl xprt
> +.RB [ \-h | \-\-help ]
> +.RB [ \--id
> +.IR ID ]
> +.P
> +.B rpcctl xprt set
> +.RB [ \-h | \-\-help ]
> +.RB [ \--id
> +.IR ID ]
> +.RB [ \--dstaddr
> +.IR dstaddr]
> +.RB [ --offline ]
> +.RB [ --online ]
> +.RB [ --remove ]
> +.P
> +.SH DESCRIPTION
> +.RB "The " rpcctl " command displays information collected in the SunRPC sysfs files about the system's SunRPC objects.
> +.P
> +.SS Objects
> +Valid
> +.BR rpcctl (8)
> +objects are:
> +.IP "\fBclient\fP"
> +Display information about this system's RPC clients.
> +.IP "\fBswitch\fP"
> +Display information about groups of transports.
> +.IP "\fBxprt\fP"
> +Display detailed information about each transport that exists on the system.
> +.SH OPTIONS
> +.SS Options valid for all objects
> +.TP
> +.B \-h, \-\-help
> +Show the help message and exit
> +.TP
> +.B \-\-id \fIID
> +Set or display properties for the object with the given
> +.IR ID.
> +This option is mandatory for setting properties.
> +.SS Options specific to the `switch set` sub-command
> +.TP
> +.B \-\-dstaddr \fIdstaddr
> +Change the destination address of all transports in the switch to
> +.IR dstaddr
> +.SS Options specific to the `xprt set` sub-command
> +.TP
> +.B \-\-dstaddr \fIdstaddr
> +Change the destination address of this specific transport to
> +.TP
> +.B \-\-offline
> +Change the transport state from online to offline
> +.TP
> +.B \-\-online
> +Change the transport state from offline to online
> +.TP
> +.B \-\-remove
> +Removes the transport from the switch. Note that "main" transports cannot be removed.
I got some feed back on this manpage....

They said would be useful to have examples on how to use
the objects... esp the switch set and xprt set ones.
I kinda agree...

steved.
> +.SH DIRECTORY
> +.TP
> +.B /sys/kernel/sunrpc/
> +.SH AUTHOR
> +Anna Schumaker <Anna.Schumaker@Netapp.com>

