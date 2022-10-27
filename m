Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B760F878
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiJ0NHd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiJ0NH1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 09:07:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34D1799B8
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 06:07:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so1398841pjd.4
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bA5UIXoeSiPSdpk42SIcKNh5Hs0RGjWIBYmqNZvV8z0=;
        b=WMK5ErddZ+UAaVGwb6JZd/hV/xL45PeKozs9Y8Ts6Dl5wl6x54N23+uGqZ1KF/inKX
         lOIqkJkEFXdPaCgyh2+I9CKKgAPy3C6QQKf0OrAYKwXF1akmSsXU/T7s+DaDMjIXac0f
         P1VQieyooXdBGZPT78rPl5bE5TaCNoldXNwXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bA5UIXoeSiPSdpk42SIcKNh5Hs0RGjWIBYmqNZvV8z0=;
        b=l0z22gUDkZc7r6zHzwIzSts1wv9AuqJ8Kfy+5zJdRDQySoRu6Ll1YZ5inmaUWYld97
         YDE8U+QYzSEZ62mAfC24JsadIrEgM+z/gs6CHm+Eb77joDG3xFXV23ZqJP5XhgU0RhXX
         v12I6uzC3UEJgEK6rWmR7VebDNotnQ2rvCA+LSUH/ANvp2Ba9oKmEmP+K7/yGtM7uJA8
         sgnSx9wXeqdWaFXiiQs8FbUtQd2OE1dmJdQw+Eq7cDtFX11R5hcYoNZTrYDWfzEUI0rc
         cGKwBzAiMwNBOJH1TuBFX9Je1t8MirjLhp/77lYoxxEtAVLmmk6DA43uYMlMoKXF1gF+
         ugyg==
X-Gm-Message-State: ACrzQf31U9XEKFLbaCaRoBFGrOuBSQC443egbaYmZf5JFVjTMTh8BvrY
        4HJRBKDRF7e0pfbHkqWUx5q2fw==
X-Google-Smtp-Source: AMsMyM6XvKHWZb4CUg/of1JGw7Fw/JFlLofrdFN0ZHBinRybiUgEUdo0acHehvuEcDop9LoIA26AjA==
X-Received: by 2002:a17:903:2306:b0:185:43a2:3d1c with SMTP id d6-20020a170903230600b0018543a23d1cmr19357662plh.154.1666876044670;
        Thu, 27 Oct 2022 06:07:24 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:a253:6b21:b32f:c252])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7956e000000b0056265011136sm1138963pfq.112.2022.10.27.06.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 06:07:24 -0700 (PDT)
Date:   Thu, 27 Oct 2022 22:07:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cred: Do not default to init_cred in
 prepare_kernel_cred()
Message-ID: <Y1qCg+g9je72TneY@google.com>
References: <20221026232943.never.775-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026232943.never.775-kees@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On (22/10/26 16:31), Kees Cook wrote:
> A common exploit pattern for ROP attacks is to abuse prepare_kernel_cred()
> in order to construct escalated privileges[1]. Instead of providing a
> short-hand argument (NULL) to the "daemon" argument to indicate using
> init_cred as the base cred, require that "daemon" is always set to
> an actual task. Replace all existing callers that were passing NULL
> with &init_task.
> 
> Future attacks will need to have sufficiently powerful read/write
> primitives to have found an appropriately privileged task and written it
> to the ROP stack as an argument to succeed, which is similarly difficult
> to the prior effort needed to escalate privileges before struct cred
> existed: locate the current cred and overwrite the uid member.
> 
> This has the added benefit of meaning that prepare_kernel_cred() can no
> longer exceed the privileges of the init task, which may have changed from
> the original init_cred (e.g. dropping capabilities from the bounding set).

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
