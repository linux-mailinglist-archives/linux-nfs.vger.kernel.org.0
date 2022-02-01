Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04164A673D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Feb 2022 22:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiBAVos (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Feb 2022 16:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiBAVor (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Feb 2022 16:44:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F60C061714
        for <linux-nfs@vger.kernel.org>; Tue,  1 Feb 2022 13:44:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ka4so58276916ejc.11
        for <linux-nfs@vger.kernel.org>; Tue, 01 Feb 2022 13:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yesm+gpXef/eaQ4MHLV9cZEc+Dgod1yjSaH4OtP/5ko=;
        b=l/Uet5oa6hms67OUa3Vukk9Sc1DR7G166JQ0KwWLwALgXOkCcTTMUacYBhcEDNwQF6
         rNHqf6efJyMXc3PO2lcBNFyCDWTyfKx11CHkHYKm1AsZLqZpBbRuNIVfi5YXCQl5mWXs
         rHMv6VTXVJ77myLzMQ8ARRHb+kzI0S7oRyVhXj8kbAHoK8cIet7Xr2YdxPZ1qMpZNpNK
         Egw4Na7rvIH159ck9kMDh0aQHEmW1hZ03Cbpy/BmQsS6nkAvj/phYFNa4JK2xDjee0sY
         vuGEwSiAvp8vEp95hBu7QWje4ESnS11ShUPqHytYShLSMXqwIlsUpl6c56cH2KbxbiPw
         OvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yesm+gpXef/eaQ4MHLV9cZEc+Dgod1yjSaH4OtP/5ko=;
        b=i1vxiTkW+6z13fHE2ccBhpjtJL4biSaA9FqO0/Kb92nasoL5keiR+TLPDA4NDXZ04w
         UMv18UVKQX1T5sX30P90FpwWnRvYw82h9MnGWEpXZ4FpHXQ84HXODx1v1k6ITL+V25FH
         2pl8zFYhimQYSX2AhliuAExMIxgvhmp+KVLSvlEzCp+A4iaMBFlG2Yz5rB83l/pJUk9+
         h/LhRxOoYLEWR9XcBeLyZhvBRcZTF/0TMzYWvKiGSWOXrCKucpIY3FNt0OheiRCvSXzZ
         mxrLSX3PhuVRUcAvb+Sjn9R+HyV+k/VC1z32zivZu0faBsixFOzdoQwE7Fq/QN0HY6gM
         WpiQ==
X-Gm-Message-State: AOAM5335TQfDXAEF4thOd2O4xyvp2Dk/y5PZHZ+PcwdHTwlexmjypQcZ
        Ag1xCyBIH3yCoGs23A1uys/4VjJBSCWTuCxr7tTS
X-Google-Smtp-Source: ABdhPJwv1wOD13WlIKKXXU/u3rrX7ixmf3pNogGirJHF+p9a8Zbzkrps+SYfblp6TN/B//b3vqn1MlBpgsuseTXnRJA=
X-Received: by 2002:a17:907:3e1d:: with SMTP id hp29mr22354191ejc.701.1643751885760;
 Tue, 01 Feb 2022 13:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20220131185737.1640824-1-smayhew@redhat.com>
In-Reply-To: <20220131185737.1640824-1-smayhew@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 16:44:34 -0500
Message-ID: <CAHC9VhSZy-tN8Rx0K7K0uj1R__W_a_Fkp8s_Etvk8hJbC-T6CA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] selinux: parse sids earlier to avoid doing memory
 allocations under spinlock
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 31, 2022 at 1:57 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> shouldn't be performing any memory allocations.
>
> The first patch fixes this by parsing the sids at the same time the
> context mount options are being parsed from the mount options string
> and storing the parsed sids in the selinux_mnt_opts struct.
>
> The second patch adds logic to selinux_set_mnt_opts() and
> selinux_sb_remount() that checks to see if a sid has already been
> parsed before calling parse_sid(), and adds the parsed sids to the
> data being copied in selinux_fs_context_dup().
>
> Scott Mayhew (2):
>   selinux: Fix selinux_sb_mnt_opts_compat()
>   selinux: try to use preparsed sid before calling parse_sid()
>
>  security/selinux/hooks.c | 147 ++++++++++++++++++++++++---------------
>  1 file changed, 92 insertions(+), 55 deletions(-)

Merged both into selinux/next, thanks Scott.

-- 
paul-moore.com
