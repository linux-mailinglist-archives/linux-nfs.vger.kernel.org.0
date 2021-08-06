Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F943E2FB3
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 21:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhHFTMn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 15:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhHFTMk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 15:12:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F2C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 12:12:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ec13so14539561edb.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJmO9mPWVAl/zYu7Hr1BxT3k9gx1WinKZ0udMWW3Bzw=;
        b=Jvq0xHp48AbI5ksrTdsLKE2CjI6t3LhaBXQ4yd8lDucqWWfOMJa3SWTv9zOIqyH3qg
         oBcCXA2LaDkU47vrX4pxf+w5LSp3HrkieqLqSQKXqw1NT3Ee9694Qt2GT3RdWkdaPsSx
         s4gFyqojXGROqgE0cjwnJhaRrQywmONPNBmx1msYiSSvZ6MqM1bYRjaiTL4g7VuCfi2F
         d5MdwUoMnQvaHmFnq6kaI35n4kdJ+vuAoGahSv4AStmm3hLQoxcKaXYx81pWMs/Cq/g3
         EpaBFp9B7lOjRPU49XvHOZBfPgfOdELrwMSsF+dosJ3DZgLJn7CRfTSWGZcttc0sbbso
         /fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJmO9mPWVAl/zYu7Hr1BxT3k9gx1WinKZ0udMWW3Bzw=;
        b=Wt6F2e7d4pGiqmP56zhd0WLlOj9PoDrWodORDmzKlZj0GDnJeK/4Mp/LcWkW+PTbTN
         H0AdTUz9mYZSRJGV0rqTTqw/ec3pRSCyjdIm1lgOhsoI9Ec+ROZgnFFv0NSAW5LPsll3
         1pBx0r4upNbkmewk+lhxrdMFGUW2QdQPqTKiAK3Sc/X2u04jpcIm86m/F8fnOORkKzSE
         YaGyr8QcLSqzjZsdM3DHdywpNMGO//ms8zQaRL6s8+orrOaJpI85VimGUr61SEDFR5RC
         vfCSJ7N56o9ASGKAHGoXrzunKqoNhJm/xHw76y+jMptvh1bKnsH6RaAqz047+6R8ZyXO
         09Gg==
X-Gm-Message-State: AOAM531E36d4CPqwzUoomqOPR3gw8xA0khQTuUPNLkA1qXtH0NTAR5bo
        EkKYhZtfyCaMb4jj/VCbhxg64qyoEjco2np+npU=
X-Google-Smtp-Source: ABdhPJz5j4BYCgk4Bw1Z81lR7Z4PEgbNSMag+2sjbqQOGaPDiGkT3PT72dLsKC/lIEFFaz69wQfYOwUIfSwZTptpCXw=
X-Received: by 2002:aa7:de98:: with SMTP id j24mr15295188edv.139.1628277143225;
 Fri, 06 Aug 2021 12:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com> <b8b806a99bd53ef9a1e8892f167ea919c52af730.camel@redhat.com>
In-Reply-To: <b8b806a99bd53ef9a1e8892f167ea919c52af730.camel@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 6 Aug 2021 15:12:12 -0400
Message-ID: <CAN-5tyEbTKQg7dNgNQGi0ysiWZnZmOKQgU5u2hy7ejfHoNZxuQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] nfs-utils: Fix mem leaks in gssd
To:     Alice Mitchell <ajmitchell@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 6, 2021 at 12:23 PM Alice Mitchell <ajmitchell@redhat.com> wrote:
>
> Also fix the modification of a returned config value which
> should be treated as const.
>
> Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
> ---
>  utils/gssd/gssd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index 4113cba..0815665 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -1016,7 +1016,7 @@ read_gss_conf(void)
>                 keytabfile = s;
>         s = conf_get_str("gssd", "cred-cache-directory");
>         if (s)
> -               ccachedir = s;
> +               ccachedir = strdup(s);
>         s = conf_get_str("gssd", "preferred-realm");
>         if (s)
>                 preferred_realm = s;
> @@ -1070,7 +1070,7 @@ main(int argc, char *argv[])
>                                 keytabfile = optarg;
>                                 break;
>                         case 'd':
> -                               ccachedir = optarg;
> +                               ccachedir = strdup(optarg);

Is it possible that there will be a value in both config file and
command line args. If we are strdup-ing in both we'll be over-writting
and leaking memory?

Why do we need to malloc it at all? Is it ever malloc-ed now (and
considered a leak)? I think in both cases it uses static memory and
doesnt require freeing.

>                                 break;
>                         case 't':
>                                 context_timeout = atoi(optarg);
> @@ -1133,7 +1133,6 @@ main(int argc, char *argv[])
>         }
>
>         if (ccachedir) {
> -               char *ccachedir_copy;
>                 char *ptr;
>
>                 for (ptr = ccachedir, i = 2; *ptr; ptr++)
> @@ -1141,8 +1140,7 @@ main(int argc, char *argv[])
>                                 i++;
>
>                 ccachesearch = malloc(i * sizeof(char *));
> -               ccachedir_copy = strdup(ccachedir);
> -               if (!ccachedir_copy || !ccachesearch) {
> +               if (!ccachesearch) {

ccachedir_copy is the only leak here.

>                         printerr(0, "malloc failure\n");
>                         exit(EXIT_FAILURE);
>                 }
> @@ -1274,6 +1272,8 @@ main(int argc, char *argv[])
>
>         free(preferred_realm);
>         free(ccachesearch);
> +       if (ccachedir)
> +               free(ccachedir);
>
>         return rc < 0 ? EXIT_FAILURE : EXIT_SUCCESS;
>  }
> --
> 2.27.0
>
>
