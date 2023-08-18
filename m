Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF196781476
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 22:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHRUzP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjHRUy6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 16:54:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB984200
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:54:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fec1a30a1eso24675e9.0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692392094; x=1692996894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asY9UEQLpnW5dRfl5uWYd8TqKFlxagtVuYzGFXWsA5k=;
        b=Alvz4t3oc9qSrZltJGvc+De352k6T4H1wHAQdWbb8o+phuyd6jHX5Uuy3Uu/e/tOXc
         kEXQAGQ3K6iq0Q7yBM8LPjj9EXY5w1WEMDorksgu1MHcJp0vlFAXGZ4t8T5rv6n4GRwo
         qNCjhwqfjtxvOMAGcnnwxyY/AwXm+obJb0CkS+5TZTX7WKjEjWj82/OznYTuyqi+Fpdx
         hbzDvyITUoNBxp7GLdKEjKRna/tGydvPCnOkBO0PEUt5KF/F8Uae1BYhRHA1Z2TEDxRu
         s5WX/pbhtbBRdOEwuBIbNZy2oKs/hYptPuSxMzk8/D+JSGaOhS3AYBY1S7+HiwJ9i5Pe
         pNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692392094; x=1692996894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asY9UEQLpnW5dRfl5uWYd8TqKFlxagtVuYzGFXWsA5k=;
        b=WnZpx20tSThuVS9dEDrGiY9u4bACOtZp8sm32W4kwsnDpxBhXMscrwvTSlrpmWc0gz
         9MMk4OIOkb2GFAKck4kIblkORLzguCrGqka5F/LjdYWX8EdGS7cIzkyXpI5TCa1svAoR
         irvZThBj3u1k1D6+hli8i/2Gy0qbJ7+4aIFWLUR621MNdBsMVC+VqJJO2R7jKu6ba9sF
         bb62MFxGg/Au+IHN1PIRMYhho7Uch1geE3+F47F2g7/ruKFeEbgJKNZKBZGObevSGRh1
         FZbPQWEMclKjFv2EBzegcnRys2aLwXNRlJQ2YkSXLvZxT4IB3+gUoeOr4zFj9oYlTjT+
         HzOA==
X-Gm-Message-State: AOJu0YwurEB/ykJV4OtJlbTWOj8WTt6RDFntBdKsw33pgvzFHWI5Ng4u
        VQCpBoEiwzFWGxWeqKvHASDGrZh7NtfY92KAPGtu2w==
X-Google-Smtp-Source: AGHT+IHEAvGOn1QfwCah/cW2MjlDPrJrEjz3trPe6oWYwLtZ0+GtIb+KBWLYUO2lEapHfZpWumuMSSRsLPH0o4oDZF0=
X-Received: by 2002:a05:600c:3548:b0:3f1:73b8:b5fe with SMTP id
 i8-20020a05600c354800b003f173b8b5femr124268wmq.3.1692392094419; Fri, 18 Aug
 2023 13:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230818041740.gonna.513-kees@kernel.org> <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
 <202308181146.465B4F85@keescook> <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
In-Reply-To: <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Aug 2023 22:54:17 +0200
Message-ID: <CAG48ez2rQGxNF2ZSMxadAPTx7SQssBn0d2m_7gHETJjgBZH0Xg@mail.gmail.com>
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 18, 2023 at 9:31=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Fri, 18 Aug 2023 11:48:16 -0700 Kees Cook <keescook@chromium.org> wrot=
e:
>
> > On Fri, Aug 18, 2023 at 08:17:55PM +0200, Jann Horn wrote:
> > > Though really we don't *just* need refcount_t to catch bugs; on a
> > > system with enough RAM you can also overflow many 32-bit refcounts by
> > > simply creating 2^32 actual references to an object. Depending on the
> > > structure of objects that hold such refcounts, that can start
> > > happening at around 2^32 * 8 bytes =3D 32 GiB memory usage, and it
> > > becomes increasingly practical to do this with more objects if you
> > > have significantly more RAM. I suppose you could avoid such issues by
> > > putting a hard limit of 32 GiB on the amount of slab memory and
> > > requiring that kernel object references are stored as pointers in sla=
b
> > > memory, or by making all the refcounts 64-bit.
> >
> > These problems are a different issue, and yes, the path out of it would
> > be to crank the size of refcount_t, etc.
>
> Is it possible for such overflows to occur in the cred code?  If so,
> that's a bug.  Can we fix that cred bug without all this overhead?

Dunno, probably depends on how much RAM you have and how the system is
configured? Like, it should get pretty easy to hit if you have around
44 TB of RAM, since I think the kernel will let you create around 2^32
instances of "struct file" at that point, and each file holds a
reference to the creator's "struct cred". If RLIMIT_NOFILE and
/proc/sys/kernel/pid_max are high enough, you could probably store
2^32 files in file descriptor table entries, spread out over a few ten
thousand processes but all pointing to the same struct cred, and
trigger an overflow of a cred refcount that way. But I haven't tried
that and there might be some other limit that prevents this somewhere.

If you have less RAM, you'd have to try harder to find some data
structure where the kernel doesn't impose such strict limits on
allocation as for files. io_uring requests can carry references to
creds, and I think you can probably make them block infinitely through
dependencies; I don't know how many io_uring requests you could have
in flight at a time. Eyeballing the io_uring code, it looks like this
might work at somewhere around 1 TB of slab memory usage if there
isn't some limit somewhere?

My point is that it's really hard to figure out how many references
you can have to an object that can have references from all over the
kernel unless there is a hard cap on the amount of memory in which
such references are stored or you're able to just refuse incrementing
the refcount when it gets too high. And so in my opinion it makes
sense to use a refcount type that is able to warn and (depending on
configuration) continue execution safely (except for leaking a little
bit of memory) even if it reaches its limit.
