Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB626AF9A2
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Mar 2023 23:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCGW52 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Mar 2023 17:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCGW5L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Mar 2023 17:57:11 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873FB5FC3
        for <linux-nfs@vger.kernel.org>; Tue,  7 Mar 2023 14:54:12 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536cb25982eso272574677b3.13
        for <linux-nfs@vger.kernel.org>; Tue, 07 Mar 2023 14:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1678229583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vemO8k1u3XZqdTI6RbhHJ2h2a6/5NFDCW7enHPRNpkY=;
        b=E/OucL9ZmQNqVGYqLtxV7vY2sBEWuX4VyLEfszQ2+G6kqzF1Hn/20/WJQgAeh+0e2Y
         FhE/Z7guBuB3+x/hrPMA7j4PirVxlzkdAv4aT1MfvaOQZJ2U8fLalZOZ0zFrp4jIr577
         VOc+Rq0z3Mwd8gbtVMCiXQJzdnaCIFvB2mN+vfUw9KiTHROx2+vxg7//K1Wb11g86Py3
         dExk54JG2Bko5NrNIOrglsYELMIUohMcjo4Tmn/InpNyh1ZtAyAQOvDlk85OIDDD4t93
         AFyXkd8/cgc1U+68z2+75f6X0EfgjqROr5GrJkqesuyBRQZE0G2PfhC+zoni8/QSa5rg
         ChDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678229583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vemO8k1u3XZqdTI6RbhHJ2h2a6/5NFDCW7enHPRNpkY=;
        b=Lmafes0Xtht+sUEvPJ6WCGlq94eiEb2UeKO+ckWx7ffDy6jBj14HzdMm7K94m0h6WH
         uzo5GQDS3XMeW4HJEdGJCxxgzigP09DhT/2JaFYTiXlDO3qGhgeBVJAROhBSnrc+xRdC
         w8BxJD880G+JhBIsrfTgZMigKrHRPGPj4NAVi3xgxzay43EAmg1wyHxHfaOoQvBJO0EI
         63y4WCkSXNN/BiYbpbLM0MHMLBys6YYIGmUFdLSroxbv2W43p+i1dxg9o3xN4PGdj8ul
         PTpsfb7eWQeMr3OK9FyjZbcfpL0RnGOow/bbKg8qbSmKYN+vL4OVW/OgycxHqQH5bqLV
         LZYg==
X-Gm-Message-State: AO0yUKXrwFPRkEZFRQtdUNr28C2jH/VU6PTxlMaepU52QjPng2b9rkCZ
        KAm6Q69jzKdxqldYPBM719b7IximYh+XfA5Zjf5EnQ==
X-Google-Smtp-Source: AK7set//d3d6ReCx/Lqh7Vi87eutnSWzCCuhRJrjuaJQTKDk3daZ5I3q+H2ah9vTH7AQGhcZjHOurb/SuVEOuucJCE8=
X-Received: by 2002:a81:ad46:0:b0:52e:cea7:f6e0 with SMTP id
 l6-20020a81ad46000000b0052ecea7f6e0mr9839474ywk.7.1678229582622; Tue, 07 Mar
 2023 14:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20230307220525.54895-1-Jerry@skydio.com> <167822825917.8008.11050193827453206272@noble.neil.brown.name>
In-Reply-To: <167822825917.8008.11050193827453206272@noble.neil.brown.name>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Tue, 7 Mar 2023 14:52:53 -0800
Message-ID: <CAMKO5Cv1Uh1rSFQ0cR1kfA88iXXHP5RMO-euU15Xrn2i93J5rg@mail.gmail.com>
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

On Tue, Mar 7, 2023 at 2:31=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 08 Mar 2023, Jerry Zhang wrote:
> > The expiry time field is mean to be expressed in seconds since boot.
>
> Correct.
>
> > The get_expiry() function parses a relative time value in seconds.
>
> Incorrect.  It parses and absoulte wall-clock time.
I'm not familiar with the source of truth for this info. Is there a
specification of some sort?

For reference, we were seeing writes to
/proc/net/rpc/nfsd.export/channel randomly fail with EINVAL despite
usually succeeding with the same invocation. Upon investigation this
was the string that exportfs was writing "-test-client- /path/to/mount
 3 0 65534 65534 0". "3" was the value for expiry in this message,
which led me to conclude that this is a relative field. If it isn't,
perhaps this is a bug in userspace nfs tools?

The failure in this was if nfs-server starts exactly 3s after bootup,
boot.tv_sec would be 3 and thus get_expiry() returns 0, causing a
failure to be returned.
>
> NeilBrown
>
> > In order to get the absolute time of seconds since boot that the given
> > message will expire, the right thing is to add seconds_since_boot()
> > to the given relative value.
> >
> > Previously this logic was subtracting boot.tv_sec from the relative
> > value, which was causing some confusing behavior. The return type of
> > time64_t could possibly underflow if time since boot is greater than
> > the passed in relative argument. Also several checks in nfs code compar=
e
> > the return value to 0 to indicate failure, and this could spuriously
> > be tripped if seconds since boot happened to match the argument.
> >
> > Fixes: c5b29f885afe ("sunrpc: use seconds since boot in expiry cache")
> > Signed-off-by: Jerry Zhang <Jerry@skydio.com>
> > ---
> >  include/linux/sunrpc/cache.h | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.=
h
> > index ec5a555df96f..b96b1319c93d 100644
> > --- a/include/linux/sunrpc/cache.h
> > +++ b/include/linux/sunrpc/cache.h
> > @@ -301,16 +301,14 @@ static inline int get_time(char **bpp, time64_t *=
time)
> >  }
> >
> >  static inline time64_t get_expiry(char **bpp)
> >  {
> >       time64_t rv;
> > -     struct timespec64 boot;
> >
> >       if (get_time(bpp, &rv))
> >               return 0;
> >       if (rv < 0)
> >               return 0;
> > -     getboottime64(&boot);
> > -     return rv - boot.tv_sec;
> > +     return rv + seconds_since_boot();
> >  }
> >
> >  #endif /*  _LINUX_SUNRPC_CACHE_H_ */
> > --
> > 2.37.3
> >
> >
>
