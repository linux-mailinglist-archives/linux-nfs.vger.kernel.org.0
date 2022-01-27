Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2149DE81
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiA0Jyy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 04:54:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237979AbiA0Jyy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 04:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643277293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDdQPcDy/BXM/pP3P0TjV4ib8OmOcmrz0QfWKeXF3XU=;
        b=K0YroP/mRfDYFSt7rbYoHydoDTh/pSHL4OW5NOo1+hmYzeAWDtPOo+PSKK9TJT1LxBDLzR
        GoZeTd2IFLzOM331iZV1SGgIuKwvLjSPKo+nuuAIFQ7QxlHy93mF1GH141U2ih2mmstUya
        K6knec7dT57eKOxJHVSHnIPGOWW6mgw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-m3na3BaHOuuoIWsYEeq96w-1; Thu, 27 Jan 2022 04:54:52 -0500
X-MC-Unique: m3na3BaHOuuoIWsYEeq96w-1
Received: by mail-yb1-f199.google.com with SMTP id n198-20020a2540cf000000b00614c2ee23b7so5050773yba.9
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 01:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDdQPcDy/BXM/pP3P0TjV4ib8OmOcmrz0QfWKeXF3XU=;
        b=zJL6wlVjM+OX3hvIkuDxG+vnuxYczisfN11dR7HYTK1W3a6LZuM3zs0LfD/Gpj8oBK
         ae1fFU+nsm0twujGyaNca//GsbXiKsfcsv16ioEGXUu5mbfoNuaAlhmMFRdnW7weHtto
         M3Yv/ntv/SVV6oUC9R3hbI+oLB3C8W4uzsr3ApTwDsM6uzS5Ji5Tr675HQGkf7crd63A
         2p++Sf08n4Sxu7eJqagVcTaqPGa1CyLyB45qa7QOmB/3SWQ8l4NoNGLxI6QBSlRGs1ob
         SpMEwRdaR3vVwS8t+PYi0+zS22UaNz9KWybptu7wsf81qQNbLQktQdIliq3x6TRuNGMK
         MDHA==
X-Gm-Message-State: AOAM530yeWPs35zPqSBp2vwwWeJkrZQ7sh50YNiZI6wQsE8CQZ/Snu4s
        xSMYLzpjohPVFguJJSzyRdMXxa1j4ZZUgatNuB73JmupGEpHDBugiA5reJpcIZ920Ek9TPO0G7V
        xab6tagidGhqEoHjOKh58INeu1X3meAPvNY7K
X-Received: by 2002:a25:b003:: with SMTP id q3mr4101554ybf.767.1643277291804;
        Thu, 27 Jan 2022 01:54:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIUAhfn61houAngphIKxZWb+8qIDFd2Y+AxEj9EvOc+Kbl9jUki4ydOR8JkmOT4urcd1J7Cnw9TB1/ZvP+Wqg=
X-Received: by 2002:a25:b003:: with SMTP id q3mr4101543ybf.767.1643277291583;
 Thu, 27 Jan 2022 01:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
In-Reply-To: <20220120214948.3637895-2-smayhew@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Jan 2022 10:54:35 +0100
Message-ID: <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 20, 2022 at 10:50 PM Scott Mayhew <smayhew@redhat.com> wrote:
> selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> shouldn't be performing any memory allocations.  Fix this by parsing the
> sids at the same time we're chopping up the security mount options
> string and then using the pre-parsed sids when doing the comparison.
>
> Fixes: cc274ae7763d ("selinux: fix sleeping function called from invalid context")
> Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  security/selinux/hooks.c | 112 ++++++++++++++++++++++++++-------------
>  1 file changed, 76 insertions(+), 36 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5b6895e4fc29..f27ca9e870c0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -342,6 +342,11 @@ static void inode_free_security(struct inode *inode)
>
>  struct selinux_mnt_opts {
>         const char *fscontext, *context, *rootcontext, *defcontext;
> +       u32 fscontext_sid;
> +       u32 context_sid;
> +       u32 rootcontext_sid;
> +       u32 defcontext_sid;
> +       unsigned short preparsed;
>  };
>
>  static void selinux_free_mnt_opts(void *mnt_opts)
> @@ -598,12 +603,11 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
>         return 0;
>  }
>
> -static int parse_sid(struct super_block *sb, const char *s, u32 *sid,
> -                    gfp_t gfp)
> +static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
>  {
>         int rc = security_context_str_to_sid(&selinux_state, s,
> -                                            sid, gfp);
> -       if (rc)
> +                                            sid, GFP_KERNEL);
> +       if (rc && sb != NULL)
>                 pr_warn("SELinux: security_context_str_to_sid"
>                        "(%s) failed for (dev %s, type %s) errno=%d\n",
>                        s, sb->s_id, sb->s_type->name, rc);
> @@ -673,8 +677,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>          */
>         if (opts) {
>                 if (opts->fscontext) {
> -                       rc = parse_sid(sb, opts->fscontext, &fscontext_sid,
> -                                       GFP_KERNEL);
> +                       rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
>                         if (rc)
>                                 goto out;
>                         if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
> @@ -683,8 +686,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                         sbsec->flags |= FSCONTEXT_MNT;
>                 }
>                 if (opts->context) {
> -                       rc = parse_sid(sb, opts->context, &context_sid,
> -                                       GFP_KERNEL);
> +                       rc = parse_sid(sb, opts->context, &context_sid);
>                         if (rc)
>                                 goto out;
>                         if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
> @@ -693,8 +695,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                         sbsec->flags |= CONTEXT_MNT;
>                 }
>                 if (opts->rootcontext) {
> -                       rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid,
> -                                       GFP_KERNEL);
> +                       rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
>                         if (rc)
>                                 goto out;
>                         if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
> @@ -703,8 +704,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                         sbsec->flags |= ROOTCONTEXT_MNT;
>                 }
>                 if (opts->defcontext) {
> -                       rc = parse_sid(sb, opts->defcontext, &defcontext_sid,
> -                                       GFP_KERNEL);
> +                       rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
>                         if (rc)
>                                 goto out;
>                         if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
> @@ -976,6 +976,9 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>  {
>         struct selinux_mnt_opts *opts = *mnt_opts;
>         bool is_alloc_opts = false;
> +       bool preparse_sid = false;
> +       u32 sid;
> +       int rc;
>
>         if (token == Opt_seclabel)
>                 /* eaten and completely ignored */
> @@ -991,26 +994,57 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>                 is_alloc_opts = true;
>         }
>
> +       if (selinux_initialized(&selinux_state))
> +               preparse_sid = true;
> +

I wonder if we could make this all much simpler by *always* doing the
label parsing in selinux_add_opt() and just returning an error when
!selinux_initialized(&selinux_state). Before the new mount API, mount
options were always passed directly to the mount(2) syscall, so it
wasn't possible to pass any SELinux mount options before the SELinux
policy was loaded. I don't see why we need to jump through hoops here
just to support this pseudo-feature of stashing an unparsed label into
an fs_context before policy is loaded... Userspace should never need
to do that.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

