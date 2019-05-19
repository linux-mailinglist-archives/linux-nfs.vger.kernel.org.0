Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BE225B6
	for <lists+linux-nfs@lfdr.de>; Sun, 19 May 2019 04:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfESCQ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 May 2019 22:16:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33806 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfESCPr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 May 2019 22:15:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so11757626wma.1
        for <linux-nfs@vger.kernel.org>; Sat, 18 May 2019 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UqevtU0sfW5SZvxuU68PRglCl1tKazl+q8yvjPJdAO8=;
        b=YscOVE0MhTTrBkVv79nLTLThMG7uvnvWTX5ym3gUH2ztTpDdzMzagYNTR2dKwVcQYT
         gDUVUxFU0BWt82e0iK/ElPf77GXZDc6OTG8AtWqKPziG4jo39LMPis/c2fxUQnAy0qHu
         knLLCcEp7vN+WaqRURc6dg6VRd+PAJpgE/846ES8NcxliC9Y2QY4kBaHG5hlsgw1wYNf
         duxOrn34lWwibXWC4ZefEYicXSm/PjprLol+G7UkJXcTF4hU7Lpc3pe3sNyOr07tMbQ9
         AuFETBkvwKpGnrtiNqVnTc8vy3RN5F58Z+tpByJHk35sHilQelAGGdXYdxgNmZY46FsW
         4uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqevtU0sfW5SZvxuU68PRglCl1tKazl+q8yvjPJdAO8=;
        b=IgjjMFS+Ao1ijXPaM3JSsL5ymjT1JKKxuKlo3RJyXj+Ugxe0XpmR210SF/4NITrlkv
         55ogRl5vkHdAPvOX9p4/BODb9Atw3Bsy/GYWjcBEzTBUvlLM+RNbxxU0rbLL6MufJpyW
         viaXGxuPXQkmsHqPcjJheyXXxn9Js+tkGAn+AYJcLH0BQ6dZpzaTzefwPldkaTqtW+F6
         MvDuHdr6KTbVtxQWD08AwP9MHMt5P09cZ1JFvyN0XTJNTlgqXv8YXRcJ5S+giLYzbQ4Y
         fyR8wcMy+UBq0HcDiRbVdkkI5bNGNwLW/IB+WWZ4OCZB3cQnYfMVDjUQdFj6Cn0aOj9H
         aeIg==
X-Gm-Message-State: APjAAAVwTFCnHw5vM5rZHU3edLeyNoXLRO9M+LQh2eUClMxS1cUTAINf
        cw15tUo62WrG3N1omHMRT32fmRpL9+2q7Zp8B6T7Lg==
X-Google-Smtp-Source: APXvYqwcf3ZwZNw7Qq9VEUf5eXxCYI4YRTrSNWTd9l998bMcaHEK0UU305BkokTkml/RB6eq7ksX8LeTZ6X4SQkGxR4=
X-Received: by 2002:a1c:1b49:: with SMTP id b70mr7414718wmb.50.1558232144310;
 Sat, 18 May 2019 19:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPtwhKrJw54DmfVdP4ADd3w5QPv0cRP+kr1Atn58QOFL5xBGbA@mail.gmail.com>
 <3A924C3F-A161-4EE2-A74E-2EE1B6D2CA14@redhat.com>
In-Reply-To: <3A924C3F-A161-4EE2-A74E-2EE1B6D2CA14@redhat.com>
From:   Xuewei Zhang <xueweiz@google.com>
Date:   Sat, 18 May 2019 19:15:32 -0700
Message-ID: <CAPtwhKoF0XTuFa5msGB_eiiwRcJA0kK7eu6Rw6-b-5+8Qy0DDw@mail.gmail.com>
Subject: Re: [PATCH] lockd: Show pid of lockd for remote locks
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     bfields@fieldses.org, Grigor Avagyan <grigora@google.com>,
        Trevor Bourget <bourget@google.com>,
        Nauman Rafique <nauman@google.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jlayton@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, May 18, 2019 at 5:09 AM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 17 May 2019, at 17:45, Xuewei Zhang wrote:
> > Seems this patch introduced a bug in how lock protocol handles
> > GRANTED_MSG in nfs.
>
> Yes, you're right: it's broken, and broken badly because we find conflicting
> locks based on lockd's fl_pid and lockd's fl_owner, which is current->files.
> That means that clients are not differentiated, and that means that v3 locks
> are broken.

Thanks a lot for the quick response and confirming the problem!

>
> I'd really like to see the fl_pid value make sense on the server when we
> show it to userspace, so I think that we should stuff the svid in fl_owner.
>
> Clearly I need to be more careful making changes here, so I am going to take
> my time fixing this, and I won't get to it until Monday. A revert would get
> us back to safe behavior.

From my limited understanding, b8eee0e90f97 ("lockd: Show pid of lockd
for remote locks")
exists only for fixing lockd in 9d5b86ac13c5 ("fs/locks: Remove
fl_nspid and use fs-specific...").

But I don't see anything wrong in 9d5b86ac13c5 ("fs/locks: Remove
fl_nspid and use fs-specific..."). Could you let me know what's the
problem? Thanks a lot!

If 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific...")
is correct, we
probably don't need to add another fixing patch. Perhaps reverting b8eee0e90f97
("lockd: Show pid of lockd for remote locks") would be the best way then.

>
> Ben

Best regards,
Xuewei
