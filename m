Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F98F21A014
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2020 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgGIMcu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jul 2020 08:32:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38995 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgGIMct (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jul 2020 08:32:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id 18so1562742otv.6;
        Thu, 09 Jul 2020 05:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qf+FOomT9nO8ENiAbP5RjOUaSmYFh8SB5zg2jFw74po=;
        b=To60Y9J++O/XYO2JggxGYa5qUS/udyVhvcsANV6Fg0Y0+q6AasU3Hls6cxaJOl3Hbe
         JZwfsn1XGCN1OI84N7uzKn2d4If2CczmAy9e1fO2GdutmZYVoCb8jhbD0HH2k4aBWjWm
         5AjHfQeeyJNw4ZZBOECcf6kd0iCSnHcgYckDKa3SczK0mTts6EZX4G7R8dyltD+hlDsS
         x3QkdLhXunLEC2xcrKve7yBkIe1we3gGylFC/HScfvxb3ESxWzdf7SfnJYWkqo2Ipr3a
         SXRFt/qd7SVBab3XEv7Meed6de7IZNd+A1940z8FGUG6ad+5dd/56Hn9Zwj7wKjtdLWj
         2sKA==
X-Gm-Message-State: AOAM5329dySwpk8/HxU1wk1KkDx4SihJTI355qn2bOZQ+wSQP1NNvoVi
        xDn9BRH3+FHto6RFwzz9esNtU4HcODTNJOUN2/A=
X-Google-Smtp-Source: ABdhPJyyO/sow6b5DME3pCx+Xbfc2850NqvXukJ17yz4LloufPDrn0p4QCkTarJTa7CeTRe/o0Bjk2RlTbvm61GGVUo=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr31516692ots.118.1594297968822;
 Thu, 09 Jul 2020 05:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200706095224.2285480-1-zhe.he@windriver.com>
In-Reply-To: <20200706095224.2285480-1-zhe.he@windriver.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jul 2020 14:32:37 +0200
Message-ID: <CAJZ5v0hVkW2kSsLu016AjX_jWCxzTBKorXp95ojfEYQ44heLxw@mail.gmail.com>
Subject: Re: [PATCH] freezer: Add unsafe versions of freezable_schedule_timeout_interruptible
 for NFS
To:     zhe.he@windriver.com
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 6, 2020 at 11:57 AM <zhe.he@windriver.com> wrote:
>
> From: He Zhe <zhe.he@windriver.com>
>
> commit 0688e64bc600 ("NFS: Allow signal interruption of NFS4ERR_DELAYed operations")
> introduces nfs4_delay_interruptible which also needs an _unsafe version to
> avoid the following call trace for the same reason explained in
> commit 416ad3c9c006 ("freezer: add unsafe versions of freezable helpers for NFS")
>
> CPU: 4 PID: 3968 Comm: rm Tainted: G W 5.8.0-rc4 #1
> Hardware name: Marvell OcteonTX CN96XX board (DT)
> Call trace:
> dump_backtrace+0x0/0x1dc
> show_stack+0x20/0x30
> dump_stack+0xdc/0x150
> debug_check_no_locks_held+0x98/0xa0
> nfs4_delay_interruptible+0xd8/0x120
> nfs4_handle_exception+0x130/0x170
> nfs4_proc_rmdir+0x8c/0x220
> nfs_rmdir+0xa4/0x360
> vfs_rmdir.part.0+0x6c/0x1b0
> do_rmdir+0x18c/0x210
> __arm64_sys_unlinkat+0x64/0x7c
> el0_svc_common.constprop.0+0x7c/0x110
> do_el0_svc+0x24/0xa0
> el0_sync_handler+0x13c/0x1b8
> el0_sync+0x158/0x180
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>

Applied as 5.9 material with some edits in the subject, thanks!

> ---
>  fs/nfs/nfs4proc.c       |  2 +-
>  include/linux/freezer.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index e32717fd1169..15ecfa474e37 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -414,7 +414,7 @@ static int nfs4_delay_interruptible(long *timeout)
>  {
>         might_sleep();
>
> -       freezable_schedule_timeout_interruptible(nfs4_update_delay(timeout));
> +       freezable_schedule_timeout_interruptible_unsafe(nfs4_update_delay(timeout));
>         if (!signal_pending(current))
>                 return 0;
>         return __fatal_signal_pending(current) ? -EINTR :-ERESTARTSYS;
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index 21f5aa0b217f..27828145ca09 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -207,6 +207,17 @@ static inline long freezable_schedule_timeout_interruptible(long timeout)
>         return __retval;
>  }
>
> +/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
> +static inline long freezable_schedule_timeout_interruptible_unsafe(long timeout)
> +{
> +       long __retval;
> +
> +       freezer_do_not_count();
> +       __retval = schedule_timeout_interruptible(timeout);
> +       freezer_count_unsafe();
> +       return __retval;
> +}
> +
>  /* Like schedule_timeout_killable(), but should not block the freezer. */
>  static inline long freezable_schedule_timeout_killable(long timeout)
>  {
> @@ -285,6 +296,9 @@ static inline void set_freezable(void) {}
>  #define freezable_schedule_timeout_interruptible(timeout)              \
>         schedule_timeout_interruptible(timeout)
>
> +#define freezable_schedule_timeout_interruptible_unsafe(timeout)       \
> +       schedule_timeout_interruptible(timeout)
> +
>  #define freezable_schedule_timeout_killable(timeout)                   \
>         schedule_timeout_killable(timeout)
>
> --
> 2.17.1
>
