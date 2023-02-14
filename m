Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17B6956E1
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 03:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjBNC5J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 13 Feb 2023 21:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjBNC5I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 21:57:08 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE961C583
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 18:57:05 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id l7so4724536qvw.7
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 18:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKMAho6lzqBGt22epJYMH78Wr1sGLTQXRDE8H1k81+s=;
        b=w5LChPk6AWmErUHG3NzKImQcDw5tru/lxLXsfGYuogkOdfN8tutHZt+RpLeSYfaVb5
         SfH/XNO/qqj9M/MJiiN/IRAP+8GSXBRGrml6/f3NAf+e2zZLNnFf8x+RspgUxWscsfh0
         V1XAt2l8KaR/JJKcroFfRJ5xCXyexqEykQJkpWCt+LftKscnI7VFyN0x23kVfo+tQZiM
         NLliv97DRazhw2lg5ppxgQ9VDl7VVXz/JZ/AX8rG9FGAllZekHEOY9OwXMl+6VmfaxvZ
         0IqdyBBiyD6IliGtsCd/o6ss8cvQ0j5Oaut4HJs/yX4pQVlZn0guB1k001Zn6jIKlk7F
         pExQ==
X-Gm-Message-State: AO0yUKUh4V1fp+Xbgp5IvoD4iRIKk0PpaWve9wDjN1S+1A0qkMqmHuc1
        ckuGondyxW/h9mhjNHu/PA==
X-Google-Smtp-Source: AK7set8qN5K2Toy611f8Dt0XOjlvZSnUseN1dc7Wr0AqCRdr6KXB5fkyxeGkqEJ0mfSsCSjrNOoWeA==
X-Received: by 2002:a05:6214:2608:b0:56e:c04e:c48c with SMTP id gu8-20020a056214260800b0056ec04ec48cmr2536795qvb.25.1676343424065;
        Mon, 13 Feb 2023 18:57:04 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id 145-20020a370697000000b007195af894e7sm10934050qkg.76.2023.02.13.18.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 18:57:03 -0800 (PST)
Message-ID: <2172b7be16ff5b93da967a412ab47834b7444b21.camel@kernel.org>
Subject: Re: [PATCH] NFS: avoid infinite NFS4ERR_OLD_STATEID loops
From:   Trond Myklebust <trondmy@kernel.org>
To:     NeilBrown <neilb@suse.de>, Anna Schumaker <anna@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 13 Feb 2023 21:57:01 -0500
In-Reply-To: <167632902904.1896.16364452992981515041@noble.neil.brown.name>
References: <167632902904.1896.16364452992981515041@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-02-14 at 09:57 +1100, NeilBrown wrote:
> 
> Linux-NFS responds to NFS4ERR_OLD_STATEID by simply retrying the
> request, hoping to make use of an updated stateid that might have
> arrived from the server.  This is usually successful.
> 
> However if the client and server get out-of-sync for some reason and
> if
> there is no new stateid to try, this can result in an indefinite loop
> which looks a bit like a DoS attack.
> 
> This can particularly happen when a server replies with success to an
> OPEN request, but fails a subsequent GETATTR.  This has been observed
> with Netapp and Hitachi servers when a concurrent unlink from a
> different client removes the file between the OPEN and the GETATTR. 
> The
> GETATTR returns NFS4ERR_STALE.

Then they are both badly broken servers, and people should complain to
NetApp and Hitachi. We're still not fixing their server bugs in the
Linux client.

NACK...
-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


