Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDC8344F7B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 20:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhCVTAa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 15:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhCVTAV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 15:00:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22672C061756
        for <linux-nfs@vger.kernel.org>; Mon, 22 Mar 2021 12:00:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u5so23062959ejn.8
        for <linux-nfs@vger.kernel.org>; Mon, 22 Mar 2021 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DY+ADK98r/lYBrg2oozDga4hZ5La4ibn89mMMa32APM=;
        b=BXYAJLxcuRH5oRxtxWbWiwktazlO44A9TZdXp1vfkDadW39IR7NVnIrDUnd6T0Qaji
         EtwUiSq2UG16VbRUQ0XTNgDUAacWsdIEnqm+XH5AFtEHAoOVuEi2tT21lsrvlfCFxZR/
         qesIrifile3JvJuxIPu0B6x18zI/590KMOT2p2/gbXI2gJose0KUowKt1m7SLHtldSid
         n8j43mDxdjsaun5LdVJ3BhKptlOb+vxL+2CtFCMp4G0kIUK/6KoIMlP72x+d+qs3I/p9
         p2GGj2MC0Id3zKXhkLqe7fa6zORB6MuoYV7Oe5odCKdP6AR0H1BAOn7OaI7cpFzzrOPy
         QFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DY+ADK98r/lYBrg2oozDga4hZ5La4ibn89mMMa32APM=;
        b=DnV8vf9MffCwe1v/QR3eX6qL7B3t5n2CQWFsBXi/SkDUzNBZSAtrvwfQ/L0yt8wZrm
         kWwzpiiMz3+2l4W5N5MfA2HyeploKtd9kQXyU+RD0L5BDB88Sh0nYPcWF/FVxofeVu3W
         VX8THrcznOYo8ybVdvr1O44oguZgr/lxEyjQZkaunJr4g4OhqdAG8joXUloOq4LzXpV/
         7HCEq7fuhdy8bl56INTuMGnLmZVxGFe4dFzWNUcslERZN8lGBNWdb/aG2l+4kS7BXfts
         w7jPdGInjm8uRAa26OZSD6y5MvLjfc51nJzLxf/ORK5CLAchSyDoiiUBfwOCpe8xyV77
         TIVQ==
X-Gm-Message-State: AOAM532w/mwI0QeVoxLHw8+vFCFij8q3YQ7xk4hicMKTYe5AHhIvWeCa
        JAOoNrADARb5u4rXzb4qjmCXzzkYfe1IZKGAbdok+1T7Yag5
X-Google-Smtp-Source: ABdhPJxBI9nbqYYbiPbcQlRK4x4a8SAUrhThaao+Dq6D5/vgzjJrsU2iVFjFs3ELvrxMxHUuvdn/YbbxerWQ9SLaIYI=
X-Received: by 2002:a17:906:b846:: with SMTP id ga6mr1221686ejb.542.1616439619771;
 Mon, 22 Mar 2021 12:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com> <20210219222233.20748-2-olga.kornievskaia@gmail.com>
In-Reply-To: <20210219222233.20748-2-olga.kornievskaia@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Mar 2021 15:00:09 -0400
Message-ID: <CAHC9VhRFSZyKcT8XxW00QwFvbeC8iB7PpaDifrenuZk2wdAqfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] [NFS] cleanup: remove unneeded null check in nfs_fill_super()
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 19, 2021 at 5:24 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> In nfs_fill_super() passed in nfs_fs_context can never be NULL.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
