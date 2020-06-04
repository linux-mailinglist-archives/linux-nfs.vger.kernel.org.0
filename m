Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE81EED3F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2020 23:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgFDVVf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jun 2020 17:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgFDVVf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Jun 2020 17:21:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08799C08C5C0
        for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2020 14:21:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a25so7662608ejg.5
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jun 2020 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wpQqBbkRBLkuCh6lS8Nlf9fgu74z+lAzmxbYR1j2PlM=;
        b=e0aXTwBc5GJnLQqt53QaLMvrYl0tXaUMkfxmxa2aIvglM8SsX074G5R6Aim2KGsqz4
         mLmKorZsnq/h70qCunvxPWPeyxCJM6A124qA+30RzcF/4hUWtn7ZM5yHGwsv6+VxOYjP
         CHN4HfLa8p7gkoLjrXvPY4BENYEp5ztChj9w0El6GxjhejfvcacJTwRWldOgrCM5kbPz
         6k1jZdyzxk4schkLcFatOZjxkgvdiOYitIbuHtFPx2PAhP+wJcJ1oSv3AInYbGi69oAP
         KOsf/HjxXIWPlTmWr3LG2QO1IoUL01VFVtuhk6sMbHAy+gkl1GaPMJlFuGA5EI2htWvs
         ujWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wpQqBbkRBLkuCh6lS8Nlf9fgu74z+lAzmxbYR1j2PlM=;
        b=cnc9S3Gib+WbI63fdRIkE70UYTESUW7GF9GwLvRX6X7v6jrozTWGoJIL4wcqU7cbIb
         8i02NuDPifTdfM+Zurb2gR8CnhpYOzlBqGKBD+bMCavCj1Vj+ZWNorWKpRNWDtSrooj9
         xIyaSAgm3gGtGRpjuFDA+7iEKSgWmasqOHrcyvMX91XJBoDF0tBnquEBHytYXgrTaDJ9
         nUuWbeTpqOaG02m/ZIM/fS45qRX6d1ErUbTZn5/d0SHJH8kqB/wDs6skFgpCIaRbEbxc
         FLtnv9hmrqxVpbI1kiDyTvUlybwY3evFC6jqFiVDIRBQr8ib10H/g4Owr0mV+rrMB19q
         Sb0w==
X-Gm-Message-State: AOAM533kUOsxKkMGn+umT0umO3N+9hYhG4WCYA3RoPYoex/Q0l+zZ4hr
        Q7FdtXqcaJcrAh7i0mNgcQmkfRZ2bTuR/VhG1IqhWHX/
X-Google-Smtp-Source: ABdhPJyON2iMfjD9z00jdKKxoguETDLHtSvRAHjQVj0YQpE9pMM0WvnCv1yyZsDRa1Jx468m6FZs2M3s53eAUUZjmGE=
X-Received: by 2002:a17:907:9486:: with SMTP id dm6mr5834850ejc.248.1591305693558;
 Thu, 04 Jun 2020 14:21:33 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 4 Jun 2020 17:21:22 -0400
Message-ID: <CAN-5tyFCotATeYVR0J1B_UaxhXYBDhp21LbFEzZtLYmgN_i+hg@mail.gmail.com>
Subject: once again problems with interrupted slots
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

There is a problem with interrupted slots (yet again).

We send an operation to the server and it gets interrupted by the a signal.

We used to send a sole SEQUENCE to remove the problem of having real
operation get an out of the cache reply and failing. Now we are not
doing it again (since 3453d5708 NFSv4.1: Avoid false retries when RPC
calls are interrupted"). So the problem is

We bump the sequence on the next use of the slot, and get SEQ_MISORDERED.

We decrement the number back to the interrupted operation. This gets
us a reply out of the cache. We again fail with REMOTE EIO error.

Going back to the commit's message. I don't see the logic that the
server can't tell if this is a new call or the old one. We used to
send a lone SEQUENCE as a way to protect reuse of slot by a normal
operation. An interrupted slot couldn't have been another SEQUENCE. So
I don't see how the server can't tell a difference between SEQUENCE
and any other operations.
