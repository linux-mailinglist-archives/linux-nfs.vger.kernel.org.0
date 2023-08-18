Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90254781426
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 22:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379908AbjHRULJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 16:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379915AbjHRUKz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 16:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02463C06;
        Fri, 18 Aug 2023 13:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5465E61781;
        Fri, 18 Aug 2023 20:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD83C433C8;
        Fri, 18 Aug 2023 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692389452;
        bh=/gCWMaOLpMSzTJlQL5d99rxf8VIx/wS5FmvUt0qjRkQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vy39Rf0AhvuZ60WucazFdo9cWw2t00Cp0cnjk//4DJyW6bdds2pRL7mGClkNIOx5r
         p2gDGvxQOZJJLAwq1BYkK3WcF2kP7ZDzzZQ67/ixZW8gfk65370elKfpgNIQ8nPwFb
         fdSErbDgC5GfPuhdgFPqCyKuxutYlfNRhk+vh6/vELClbMKkSvF4mvHT2+QnlPynXh
         EWk9O76rGrwsrSqKmtjeVMcDJ9CyNgtroxelxtG2mwRUbl+aSzXds8hDP40SDOkvZw
         ksRBrXlNRCjPLIffaHvfTGxkREdaNkTAlEV4UBi5iSZzLRcmqaumRkrNk5YYO0kCXW
         YxZshpFjGURWA==
Message-ID: <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
From:   Jeff Layton <jlayton@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
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
Date:   Fri, 18 Aug 2023 16:10:49 -0400
In-Reply-To: <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
References: <20230818041740.gonna.513-kees@kernel.org>
         <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
         <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
         <202308181146.465B4F85@keescook>
         <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-08-18 at 12:31 -0700, Andrew Morton wrote:
> On Fri, 18 Aug 2023 11:48:16 -0700 Kees Cook <keescook@chromium.org> wrot=
e:
>=20
> > On Fri, Aug 18, 2023 at 08:17:55PM +0200, Jann Horn wrote:
> > > On Fri, Aug 18, 2023 at 7:56=E2=80=AFPM Andrew Morton <akpm@linux-fou=
ndation.org> wrote:
> > > > On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org=
> wrote:
> > > >=20
> > > > > From: Elena Reshetova <elena.reshetova@intel.com>
> > > > >=20
> > > > > atomic_t variables are currently used to implement reference coun=
ters
> > > > > with the following properties:
> > > > >  - counter is initialized to 1 using atomic_set()
> > > > >  - a resource is freed upon counter reaching zero
> > > > >  - once counter reaches zero, its further
> > > > >    increments aren't allowed
> > > > >  - counter schema uses basic atomic operations
> > > > >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > > > >=20
> > > > > Such atomic variables should be converted to a newly provided
> > > > > refcount_t type and API that prevents accidental counter overflow=
s and
> > > > > underflows. This is important since overflows and underflows can =
lead
> > > > > to use-after-free situation and be exploitable.
> > > >=20
> > > > ie, if we have bugs which we have no reason to believe presently ex=
ist,
> > > > let's bloat and slow down the kernel just in case we add some in th=
e
> > > > future?
> > >=20
> > > Yeah. Or in case we currently have some that we missed.
> >=20
> > Right, or to protect us against the _introduction_ of flaws.
>=20
> We could cheerfully add vast amounts of code to the kernel to check for
> the future addition of bugs.  But we don't do that, because it would be
> insane.
>=20
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
> >=20
> > These problems are a different issue, and yes, the path out of it would
> > be to crank the size of refcount_t, etc.
>=20
> Is it possible for such overflows to occur in the cred code?  If so,
> that's a bug.  Can we fix that cred bug without all this overhead?=20
> With a cc:stable backport.  If not then, again, what is the non
> handwavy, non cargoculty justification for adding this overhead to
> the kernel?

It's not so much that the cred code itself is buggy, but the users of it
often have to deal with refcounting directly. Cred refcounting bugs can
be quite hard to even notice in the first place and are often hard to
track down.

That said...

With something like lockdep, you can turn it off at compile time and the
extra checks (supposedly) compile down to nothing. It should be possible
to build alternate refcount_t handling functions that are just wrappers
around atomic_t with no extra checks, for folks who want to really run
"fast and loose".
--=20
Jeff Layton <jlayton@kernel.org>
