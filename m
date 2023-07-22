Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B8D75DDFE
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jul 2023 19:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjGVRvd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jul 2023 13:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGVRvc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jul 2023 13:51:32 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1173E2137
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jul 2023 10:51:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7659db6339eso143767885a.1
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jul 2023 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690048290; x=1690653090;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z65OWgPnaPn0L77+3lapz8oV8H3PahlcBzAh371BjA=;
        b=gyAx12HDeM4G9USPd3UfoDsy8bjQbqLQkeOr82JB9AOZ9VhKViNqVEjUbTwXN7hbfJ
         qok+vdTFFKQwz2yx5iDGUQQCPZwWfwvCMTw0iWXFxQsahFxoCQar/vXIPIc6SrgEgYM6
         q5r/EygQtJA9p2UtFEMJv9+0Kp9gNOTTHWIcwft1qw2MlYu44AOojJ7Gnk2IUPfgQ+wO
         CoYW462MxuWGZMjgCAqhN5HRmBMgKteM/2M4o3mu8v0kfSFxVBDaokLbl56eUDUuYVFO
         8obsb+lEC5YC3mXH3VLq06s+9VkLOLF6+PrXtTrHm7yFDT72rRkvQh/JDwL4ENFZmGhy
         gkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690048290; x=1690653090;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Z65OWgPnaPn0L77+3lapz8oV8H3PahlcBzAh371BjA=;
        b=i96g0I8G69/YK5mzZByScnszgQ4kbVZHy9hw7gloCyDQGWPMubBeQUFIGFT3SdTZwg
         +N6TQPqlzrCr2VKP/dLBP3w14d96IvxJQKjn1xazvB5WStTMI+qbZf9+lyXFr5UmWz4r
         er5BorAjRqzAKyW5Od4tasdgbefSv1i/VLrsGFrlh9DU0Al5Is2GPhRSU9ph5EDTjHmk
         9BX2LiLZeBzWR21j36AG1xqMh7qLidByAfm34Eo6jInvrCozcmV/G+jj5Daguknz3eVu
         CWVncM/+z4efWZ1WbTRdinCuccaA7Kwzcvd6dYrGuuIyjx+oWLvYoRCXwWHcd4D8bB+I
         kesQ==
X-Gm-Message-State: ABy/qLbaGUtogpBC/WG4bWKBYEeH0dBO9xRcGZQ5LlUTKlWZrgbIcmSB
        287CXVaJ7vkKdLnnuWZZCkKfVw/9gccN
X-Google-Smtp-Source: APBJJlGo4cU3Gn6GTNCu/j1320WLUE3b/CoT+d3KnmNnWP8Djm3in+zcVsMt9fOUIUnLmPedA1SYIQ==
X-Received: by 2002:a05:620a:424e:b0:765:4242:21e8 with SMTP id w14-20020a05620a424e00b00765424221e8mr4097280qko.4.1690048290011;
        Sat, 22 Jul 2023 10:51:30 -0700 (PDT)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id cx19-20020a05620a51d300b007655a4c5423sm1916500qkb.130.2023.07.22.10.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 10:51:29 -0700 (PDT)
Message-ID: <0466021aedfd6fc67d0ddc47487b3b9f13082bcb.camel@gmail.com>
Subject: Re: Best kernel function to probe for NFS write accounting?
From:   Trond Myklebust <trondmy@gmail.com>
To:     lars@pixar.com, linux-nfs@vger.kernel.org
Date:   Sat, 22 Jul 2023 13:51:28 -0400
In-Reply-To: <20230721224530.I6e45%lars@pixar.com>
References: <20230721224530.I6e45%lars@pixar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Lars,

On Fri, 2023-07-21 at 15:45 -0700, lars@pixar.com wrote:
> Hello,
>=20
> I'm using BPF to do NFS operation accounting for user-space
> processes. I'd like
> to include the number of bytes read and written to each file any
> processes open
> over NFS.
>=20
> For write operations, I'm currently using an fexit probe on the
> nfs_writeback_done function, and my program appears to be getting the
> information I'm hoping for. But I can see that under some
> circumstances the
> actual operations are being done by kworker threads, and so the PID
> reported by
> the BPF program is for that kworker instead of the user-space process
> that
> requested the write.
>=20
> Is there a more appropriate function to probe for this information if
> I only
> want it triggered in context of the user-space process that performed
> the
> write? If not, I'm wondering if there's enough information in a probe
> triggered
> in the kworker context to track down the user-space PID that
> initiated the
> writes.
>=20
> I didn't find anything related in the kernel's Documentation
> directory, and I'm
> not yet proficient enough with the vfs, nfs, and sunrpc code to find
> an
> appropriate function myself.
>=20
> If it matters, our infrastructure is all based on NFSv3.
>=20
> Thanks for any leads or documentation pointers!
> Lars

I tend to use the nfs:nfs_writeback_done and nfs:nfs_commit_done
tracepoints.

We make no attempt to track the PID that initiated the writes, because
it is often impossible to do so, for instance, if the file was mmapped,
or multiple processes owned by the same user are writing to the same
page.
If you want to track I/O at that level, I suggest rather tracing the
sys_write()/sys_writev()/... system calls since those will be called
from the user context.

Cheers
  Trond

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


