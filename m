Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AAE5AC467
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Sep 2022 15:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiIDNQK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiIDNQJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 09:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4071031EC7
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662297363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJ5kx5GSVqmDyMggaz6MuQ7w9VCEp5UcT1diD2YpI2E=;
        b=NalPMXOow8S3RjGZJsUPflZpJv08UA/H7R/C2qUm6PjH9pk6O4z++6jYMXR8ZsZExly0R9
        74YrebSHOJXuURfBy0N/JRFUu3BgavobAgY0PwKQ3c8963OXYS9MXwvkrV+vK9b0AjKQ+q
        xpWqB8oBq+6mIy/36S8uNBCgUYvlnWE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-LZNsdw0wNsazmS1dIXiuEw-1; Sun, 04 Sep 2022 09:16:00 -0400
X-MC-Unique: LZNsdw0wNsazmS1dIXiuEw-1
Received: by mail-qt1-f198.google.com with SMTP id b10-20020a05622a020a00b003437e336ca7so5155361qtx.16
        for <linux-nfs@vger.kernel.org>; Sun, 04 Sep 2022 06:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yJ5kx5GSVqmDyMggaz6MuQ7w9VCEp5UcT1diD2YpI2E=;
        b=o5vIoYld2R1lkRobFphqY8JSWGACS5v+TxHO+D1YRQtIjJf7CpHc6YGHM9TGx12HS5
         87GAPKAkDMv56VEKBidHkoKH+pDfVX4o4NDFfOxxJQNPjoFxdIVniO34Ei9CKvlh1kwe
         einhKcnVl9lfVxbVDOFzyzgh+9y7sGUWgvqFtBTIhCm3nqof3gsx7AW6FpZ5/+iCIyOF
         rvpnj//COfUFPE1G6W824+MEfsY+SUJf6CL7qK5iYpqPxBsvug0bAxQ8/E6FTtErATgG
         mIcK08gQ3+V39AJgHAiw9WrWberOdnlo3cqxfvUUvua7/fe05CA+NnybXYRiU/QFbSYx
         7mlw==
X-Gm-Message-State: ACgBeo39qgPU4U/8lzVZImIF3yAtmS0ciWoePaiLFJp5/jBwvSbdXDbr
        f6KL/LOxOg+vAiuCQMAlFRsTBnpJKXoIl6F1FIa3jTua2QqCy71qOo2zSwCAsVmGloooJRB2LvY
        74WSPFeH8R6mjjshWZBEA
X-Received: by 2002:a05:622a:95:b0:343:66b1:d32a with SMTP id o21-20020a05622a009500b0034366b1d32amr35221187qtw.32.1662297359301;
        Sun, 04 Sep 2022 06:15:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR73D/KejJPoRZVOG1bs+e3JWf8wwl21iYdMBPVw1L5/bD73hUocaF4XSUQctjWKIEzxEUeHDA==
X-Received: by 2002:a05:622a:95:b0:343:66b1:d32a with SMTP id o21-20020a05622a009500b0034366b1d32amr35221169qtw.32.1662297359104;
        Sun, 04 Sep 2022 06:15:59 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l2-20020ac87242000000b0034455ff76ddsm4941002qtp.34.2022.09.04.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 06:15:58 -0700 (PDT)
Date:   Sun, 4 Sep 2022 21:15:53 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        djwong@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: generic/650 makes v6.0-rc client unusable
Message-ID: <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Sep 03, 2022 at 06:43:29PM +0000, Chuck Lever III wrote:
> While investigating some of the other issues that have been
> reported lately, I've found that my v6.0-rc3 NFS/TCP client
> goes off the rails often (but not always) during generic/650.
> 
> This is the test that runs a workload while offlining and
> onlining CPUs. My test client has 12 physical cores.
> 
> The test appears to start normally, but then after a bit
> the NFS server workload drops to zero and the NFS mount
> disappears. I can't run programs (sudo, for example) on
> the client. Can't log in, even on the console. The console
> has a constant stream of "can't rotate log: Input/Output
> error" type messages.
> 
> I haven't looked further into this yet. Actually I'm not
> quite sure where to start looking.
> 
> I recently switched this client from a local /home to an
> NFS-mounted one, and that's where the xfstests are built
> and run from, fwiw.

If most of users complain generic/650, I'd like to exclude g/650 from the
"auto" default run group. Any more points?

Thanks,
Zorro

> 
> 
> --
> Chuck Lever
> 
> 
> 

