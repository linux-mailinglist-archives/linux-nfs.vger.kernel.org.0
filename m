Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE2242769
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Aug 2020 11:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgHLJYi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Aug 2020 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgHLJYi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Aug 2020 05:24:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E1C06174A
        for <linux-nfs@vger.kernel.org>; Wed, 12 Aug 2020 02:24:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so834057plt.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Aug 2020 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=W8D3R2UOmBNEYTpoH2iEymnU67QkiwGdh/p16Dc6cY4=;
        b=jCWo/9D/IbwGmLBT0IS3VQHTacJz6Zla3gv+FGWY4PK4i16VPJzwgNXmJcOtapflNr
         S9zZxLpg57T8Ph8e3elEFHp0CXSsrljOY0Ba7nhy3qWpWW/jD5tq5jiKmn2kfQ2QqYpH
         IJoAFpf657EckMcht1gZPUXwQEBX1uEbYc4CxJsW/D8OjxmfW8OhpKAs2xUzdxbL7noI
         zYLcKonslxsmnxJiUaqQAdoqrDu+a0HYg7Hq3gf8DDJrVPlcBWJsrSbIeMfi3QLlFVIH
         wAv74AsoQsMOx27SPL8DpcxqIFk5Z4Mqw3vdJSXYjmhiSRsET/BYDAlDzh3NlxXWfps6
         5jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=W8D3R2UOmBNEYTpoH2iEymnU67QkiwGdh/p16Dc6cY4=;
        b=OUgU+gXqEbFOesgzn5K4iYsYjMBnb3IkpKrVr+Jc+Kd1nNBm3v1D3iqBS0ZKUkTsOE
         3k7DqQkgyODELWk4UymK91UsPfevC7s9q6MXfz0I0BS3EXHvrMHk17ag+yY34gdGbQye
         I9QLdEmTRCqXxP8McjfdvZtqgUqUJy7Z4v77w865QZvgjioSnBZP5DXzvHoVUKShJVyI
         hPQtqHZGlm1FH3blDwOR4KG06ik/XvwFnM7rSSzf4pM1PTMj7yfnNUquQd8bjuU19vDt
         e6gfX6bof2uRVN3LdImGan5d+0ZHA3BqrqPAdkKQ690UJdH8RtwRGVUa0sforSLn5IcR
         +D3g==
X-Gm-Message-State: AOAM530pZ3bAPIegGiwKBtRvp6C1PWxP7UJV3Xx2TaV5wAyn9AdBlNw0
        hwYqEe/nUeTSFN02pwH+d/RR7PCUQyAvU1L/j4clnFWT/lQ=
X-Google-Smtp-Source: ABdhPJzA9pIZOfQN8hqCfZDQ8v7TWvDxzn+QrRWqkSGEDTiA2DN6NOKUIG5wvtb7JH6PyUPA+ELT3glVggFxx2jsSnk=
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr4385685plk.183.1597224277663;
 Wed, 12 Aug 2020 02:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAL9i7GFmOOCWoOnGuDORCCHonFE7siUxSvAvP4TpWX5+CR601g@mail.gmail.com>
In-Reply-To: <CAL9i7GFmOOCWoOnGuDORCCHonFE7siUxSvAvP4TpWX5+CR601g@mail.gmail.com>
From:   sea you <seayou@gmail.com>
Date:   Wed, 12 Aug 2020 11:24:26 +0200
Message-ID: <CAL9i7GHMbU9_5i6r-c=kmv+q0LPTKAX8WX0bNxpwzeXT=UjN-g@mail.gmail.com>
Subject: Re: Kernel panic in laundromat_main on 5.3.0-46-generic (Ubuntu HWE)
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After upgrading the kernel to 5.4.0-39-generic, the very same happened again.
You could find more information here on LaunchPad
https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1885265

Anyone else experienced this? This definitely looks like a bug to me
at this point.

On Thu, May 14, 2020 at 12:26 PM sea you <seayou@gmail.com> wrote:
>
> Hi all,
>
> Today we've seen a kernel panic that looks like related to delegations
> and laundromat
>
> ...
> [1388051.959652] Call Trace:
> [1388051.959984]  unhash_delegation_locked+0x39/0xa0 [nfsd]
> [1388051.960631]  laundromat_main+0x235/0x5a0 [nfsd]
> [1388051.961234]  process_one_work+0x1fd/0x3f0
> [1388051.961803]  worker_thread+0x34/0x410
> [1388051.962281]  kthread+0x121/0x140
> [1388051.962698]  ? process_one_work+0x3f0/0x3f0
> [1388051.963210]  ? kthread_park+0xb0/0xb0
> [1388051.963690]  ret_from_fork+0x22/0x40
> ....
>
> In the link below you'll find what has been captured from the console.
>
> https://pastebin.com/raw/CdpMfUAK
>
> I couldn't really find any reference to this in the mailing list
> history so I assume we might have hit a bug that is unknown so far.
>
> Best regards,
> Doma
