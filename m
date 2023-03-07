Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52C6AFACD
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 00:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCGX4v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Mar 2023 18:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCGX4u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Mar 2023 18:56:50 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A82A54CE
        for <linux-nfs@vger.kernel.org>; Tue,  7 Mar 2023 15:56:48 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id x12so13125119ybt.7
        for <linux-nfs@vger.kernel.org>; Tue, 07 Mar 2023 15:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1678233407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfsBSwCHMjd2D1yfsbv/LxSXTus51yaMyRMEi0ePSs4=;
        b=SSdx+9t5qHYZ8OwZVOWk1/JBecjTsZigjWb/LpeJ+EwdW07bIt62rzIW6VhfKsgAfG
         5Vs76dww4R++N1QmpR1OhTTvYN8MJCoaP8m0Htc52ohNjRELuNVXF37JZWYNzPPAEqJh
         mMJs9mKS33k2J2E62+e4w25RdJDxuMRhdb1qI8JEWA426LhK+d31QIcXlAF5L4NSkXHc
         ZwRngxMMxuyRK63IIfuDhmkNesF3P4d0OyIyZsjwoobpcGCh8JadJV7hDe90JidoOdfF
         pK+1og6vYY9Yyxak9mp5nLxcGymqJL3EgAXyZTulQGNaaU6JCb76HjmysC0ruJQCGoz2
         2K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678233407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfsBSwCHMjd2D1yfsbv/LxSXTus51yaMyRMEi0ePSs4=;
        b=YwwlvBgoGcRXl8xzvIXwLQlVomspqo0wksB5LY3tDuNtckQ/RXOJliD6Xr6h57l63B
         fZ7MkZ+7i8L1dPyA1R4dU32gbBpGLMr00hyfsiqOHGmn8coSayqAfDJB4RTos0vuGp1z
         IaVOuFEvOTzTMtLi9Fuz+areiCicQ2XqMlXeB7CO/XpPYmtctq716VLS7nOU4TH8eN2M
         QKpdONYmG74m/lTPxAyKh21MDf3OTd+2j7jh8f5fE8gzasIHvg1A0HZUWQu+fvb3uTHs
         IHIuAqQc9oW3h27lX6wyndUSuvZG+mmDwhzu81FqehXX6KAoYFMD0ukc9H1tZg19MEJN
         WlcA==
X-Gm-Message-State: AO0yUKUImV0aIbh3ZtPbcTA/hD5mA9OKqP0HUlyJkXU4w0Ym1eLV8Tt6
        nXn0ih31A2xmqHngYY+3By9Y+sUTi8a8b1UlEGEfsQ==
X-Google-Smtp-Source: AK7set8NqGueL2UTzSZtZCmHa2STOP7CneLLiBBAx6oCLwtJhXt6q9h2NUbjKwrrCZ4k/LyPGVsntEzWFz+HbzFCU3o=
X-Received: by 2002:a5b:bc6:0:b0:a0d:8150:be04 with SMTP id
 c6-20020a5b0bc6000000b00a0d8150be04mr7922852ybr.13.1678233407457; Tue, 07 Mar
 2023 15:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20230307220525.54895-1-Jerry@skydio.com> <167822825917.8008.11050193827453206272@noble.neil.brown.name>
 <CAMKO5Cv1Uh1rSFQ0cR1kfA88iXXHP5RMO-euU15Xrn2i93J5rg@mail.gmail.com> <167823124256.8008.4738010782615192469@noble.neil.brown.name>
In-Reply-To: <167823124256.8008.4738010782615192469@noble.neil.brown.name>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Tue, 7 Mar 2023 15:56:37 -0800
Message-ID: <CAMKO5CvuWxrzshJrUJGwiMApN_L6yL-qck0fvizvBUs2Z7PU-g@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: Fix incorrect parsing of expiry time
To:     NeilBrown <neilb@suse.de>
Cc:     embedded@skydio.com, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 7, 2023 at 3:20=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 08 Mar 2023, Jerry Zhang wrote:
> > On Tue, Mar 7, 2023 at 2:31=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> > >
> > > On Wed, 08 Mar 2023, Jerry Zhang wrote:
> > > > The expiry time field is mean to be expressed in seconds since boot=
.
> > >
> > > Correct.
> > >
> > > > The get_expiry() function parses a relative time value in seconds.
> > >
> > > Incorrect.  It parses and absoulte wall-clock time.
> > I'm not familiar with the source of truth for this info. Is there a
> > specification of some sort?
> >
> > For reference, we were seeing writes to
> > /proc/net/rpc/nfsd.export/channel randomly fail with EINVAL despite
> > usually succeeding with the same invocation. Upon investigation this
> > was the string that exportfs was writing "-test-client- /path/to/mount
> >  3 0 65534 65534 0". "3" was the value for expiry in this message,
> > which led me to conclude that this is a relative field. If it isn't,
> > perhaps this is a bug in userspace nfs tools?
>
> The above information is very useful.  This sort of detail should always
> be included with a bug report, or a patch proposing to fix a bug.
>
> The intent of that "3" is to be a time in the past.  We don't want the
> -test-client- entry to be added to the cache, but we want a failure
> message if the path cannot be exported.  So we set a time in the past as
> the expiry time.
> Using 0 is awkward as it often has special meaning, so I chose '3'.
>
> >
> > The failure in this was if nfs-server starts exactly 3s after bootup,
> > boot.tv_sec would be 3 and thus get_expiry() returns 0, causing a
> > failure to be returned.
>
> I don't understand this. getboottime64() doesn't report time since boot.
> It reports the time when the system booted.  It only changes when the
> system time is deliberately changed.
Ok I misinterpreted what this function does.
> At boot, it presumably reports 0.  As soon as some tool (e.g. systemd or
> ntpdate) determines what the current time it and calls settimeofday() or
> a similar function, the system time is changed, and the boot-time is
> changed by the same amount.  Typically this will make it well over 1
> billion (for anything booted this century).
> So for the boot time to report as '3', something would need to set the
> current time to a moment early in January 1970.  I'd be surprised if
> anything is doing that.
I see the discrepency now -- our system is actually an embedded
platform without an RTC. So it thinks that it is "1970" every time it
boots up, at least until it connects to the internet or similar, which
it may or may not ever do. We use NFS to share mountpoints between 2
linux systems on our board connected via usb-ethernet. The fact that
it allows simultaneous access gives it an advantage over other
protocols like mass storage.

Its likely that the code is working as intended then, it just didn't
take our particular usecase into account.

>
> How much tracing have you done?  Have you printed out the value of
> boot.tv_sec and confirmed that it is '3' or have you only deduced it
> from other evidence.
> Exactly what firm evidence do you have?
Sure I've added this simple debug print with the necessary info

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 15422c951fd1..5af49198b162 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -528,10 +528,12 @@ static int svc_export_parse(struct cache_detail
*cd, char *mesg, int mlen)
        int len;
        int err;
        struct auth_domain *dom =3D NULL;
        struct svc_export exp =3D {}, *expp;
        int an_int;
+       struct timespec64 boot;
+       char* orig_mesg =3D mesg;

        if (mesg[mlen-1] !=3D '\n')
                return -EINVAL;
        mesg[mlen-1] =3D 0;

@@ -564,10 +566,12 @@ static int svc_export_parse(struct cache_detail
*cd, char *mesg, int mlen)
        exp.ex_devid_map =3D NULL;

        /* expiry */
        err =3D -EINVAL;
        exp.h.expiry_time =3D get_expiry(&mesg);
+       getboottime64(&boot);
+       printk("mesg is '%s' expiry is %lld and boot_s is %lld\n",
orig_mesg, exp.h.expiry_time, boot.tv_sec);
        if (exp.h.expiry_time =3D=3D 0)
                goto out3;

        /* flags */
        err =3D get_int(&mesg, &an_int);

and the output is

[   14.093506] mesg is '-test-client- /path/to/mount  3 8192 65534
65534 0' expiry is 0 and boot_s is 3

which largely confirms the info above.

Do you think we'd be able to handle this case cleanly?
>
> Thanks,
> NeilBrown
>
