Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93049BB38
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiAYSXv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 13:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiAYSXU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 13:23:20 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D6C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 10:23:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id o12so32457141eju.13
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 10:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSr348A+2Kq1F6LYwvOgYGx2MvGbrDd9QVuy/+BfOlM=;
        b=VGxDVl96rrqz1imI+5akjhZpbRGO0Y2OnJVjjKVKR7vWIcoDBBFIfN/PxeJ7gHgu5W
         T6j1Pd4tjy+1YscSUZqZNJ1ZX2wLN1WjYeuu5zrjCLGIWqrHkiaAsJFpEYr8HlELMlww
         NyVuLUh22klqmH/cYcmdRYk6mp1LjI8ExQE50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSr348A+2Kq1F6LYwvOgYGx2MvGbrDd9QVuy/+BfOlM=;
        b=GjrA+9oj8laTHt8he5ahiV2VzxUoBtYcsC2SZ4MH0CbFfRNTEfuYhClORvsYP2Fo81
         cZqrGLZVeG2mp7mmiWkRkIIoIPFHwWmXUoBpwYKUHYeJVU2gRDhjmOZKDmFOa30Gi2l0
         5FTzFaEUH+MMgQ9Acydys2/Gt/6TENcPsDr1uM71KK7u052gqTFVsA1Ey7obkL4rcxZz
         g7p68edqF0mASLFOpZrstnFYeLGxbduLa9saCll/lpJGjAQ7aabrIuYbfVK5ywgZRjwB
         VL82+yHSbl3dWyKHdsNddTM9uECKdq61+nOK8dUHSiXHsKq1DzwlwhBDtcMT4v/QGG+b
         YDdQ==
X-Gm-Message-State: AOAM531GSVGNGTXIz/1RSrwGu18tqjBq2Co56mjZImxsa7QxajJddLuP
        JfnD80Y66Riincn7r+wo9DWBgyFGMYvb3pkU5G2IPBtva4iNzxP1
X-Google-Smtp-Source: ABdhPJwlC+3K9GQOFJMNTdRAAXG2O8z32/+KFe9Ahe4sge83XyoX22Di1do3r2UMxxS0o3cVXKN9kniASmuzCSLdISg=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr15817105ejc.610.1643134996931;
 Tue, 25 Jan 2022 10:23:16 -0800 (PST)
MIME-Version: 1.0
References: <CAFX2Jf=8s+rrwgGxm1FsaPUvEHygLFaUCNeFh989v4MXmLJFSg@mail.gmail.com>
 <CAFX2JfmEBhRF63o8ZwuUjwJ7aOUJLb+h8oidrq8kVUsnsq5vcA@mail.gmail.com> <CAFX2Jfm=theSU4ey9hqBhAX5VEJe7p7QG1M7+946G96BqyOZng@mail.gmail.com>
In-Reply-To: <CAFX2Jfm=theSU4ey9hqBhAX5VEJe7p7QG1M7+946G96BqyOZng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jan 2022 20:23:06 +0200
Message-ID: <CAADWXX-B6q-MA2FHuQvxrnEkbxsmQ+5miWtEr+yZhsyjuiF9ig@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS Client Updates for 5.17
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 25, 2022 at 8:01 PM Anna Schumaker
<anna.schumaker@netapp.com> wrote:
>
> I'm still not seeing this in your tree. Was there something wrong with
> the pull request? What can I do to fix it?

Hmm. It looks like these were all caught in the gmail spam filter, and
while I go look at my spam folder regularly, I don't exactly go
through it with a fine comb. If nothing stands out to me, it all goes
into the great big bit-bucket in the sky.

And the reason gmail considers it spam seems to be that your email is
misconfigured. You have a "from:" field using netapp.com, but you
don't seem to use the proper netapp smtp server, so you don't get the
netapp DKIM signature, resulting in

       dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE)
header.from=netapp.com

and that's quite the spam-trigger.

In fact, from the headers it looks like you're using gmail to deliver
the email using your schumakeranna@gmail.com gmail account, but then
you have that "From:"  having that "netapp.com" from address. Naughty,
naughty.

Even if gmail receives it, gmail will then notice that the from
address has been faked, and will not deliver it to me.

That whole "send email using another delivery thing than the one you
claim it is from" is how most spam is sent, and it used to work. It
doesn't work any more in a world where people actually check DKIM
information, and netapp.com does have DKIM enabled.

So you have to use the real netapp SMPT server if you send emails that
claim to come from netapp.

You could just use your actual normal gmail.com address - that works
fine, and I'll see the signed tag, and the kernel.org address, and
I'll trust it that way.

             Linus
