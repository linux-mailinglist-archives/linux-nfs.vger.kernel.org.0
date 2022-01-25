Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAAA49BB88
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 19:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiAYSwD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 13:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232381AbiAYSwA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 13:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643136715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MFNBLU9fi1/P19BC1N9d+ep2tphTew1fPzk0R1jaXnE=;
        b=LTlkfhFw0VkYuzzXF2NSUJ5rfwydhuU6fhD2JiAOqaD0IEq78GZpdY3RMXa8lpqkX2H7SV
        dfMCXS92NWtU+aLwVETnlyLHDmgXAtiyTlpPsIdQKNciy6pGVxgy28IWA24w6vurl1VPkx
        EGu6ykyG/jmu4ahshfpJHTOWgVgDw2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-Aku6xU8LOGO17Wb6B0WNoA-1; Tue, 25 Jan 2022 13:51:53 -0500
X-MC-Unique: Aku6xU8LOGO17Wb6B0WNoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 961ED8519E3;
        Tue, 25 Jan 2022 18:51:52 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75B7572FA5;
        Tue, 25 Jan 2022 18:51:52 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 98B171A001F; Tue, 25 Jan 2022 13:51:51 -0500 (EST)
Date:   Tue, 25 Jan 2022 13:51:51 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
Message-ID: <YfBGx+M9jQZa80rZ@aion.usersys.redhat.com>
References: <20220120214948.3637895-1-smayhew@redhat.com>
 <20220120214948.3637895-2-smayhew@redhat.com>
 <CAHC9VhT2RhnXtK3aQuDCFUr5qayH25G8HHjRTJzhWM3H41YNog@mail.gmail.com>
 <YfAz0EAim7Q9ifGI@aion.usersys.redhat.com>
 <CAHC9VhTwXUE9dYBHrkA3Xkr=AgXvcnfSzLLBJ4QqYd4R+kFbbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTwXUE9dYBHrkA3Xkr=AgXvcnfSzLLBJ4QqYd4R+kFbbA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022, Paul Moore wrote:

> On Tue, Jan 25, 2022 at 12:31 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > On Mon, 24 Jan 2022, Paul Moore wrote:
> > > On Thu, Jan 20, 2022 at 4:50 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > >
> > > > selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> > > > shouldn't be performing any memory allocations.  Fix this by parsing the
> > > > sids at the same time we're chopping up the security mount options
> > > > string and then using the pre-parsed sids when doing the comparison.
> > > >
> > > > Fixes: cc274ae7763d ("selinux: fix sleeping function called from invalid context")
> > > > Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > ---
> > > >  security/selinux/hooks.c | 112 ++++++++++++++++++++++++++-------------
> > > >  1 file changed, 76 insertions(+), 36 deletions(-)
> 
> ...
> 
> > > >         switch (token) {
> > > >         case Opt_context:
> > > >                 if (opts->context || opts->defcontext)
> > > >                         goto err;
> > > >                 opts->context = s;
> > > > +               if (preparse_sid) {
> > > > +                       rc = parse_sid(NULL, s, &sid);
> > > > +                       if (rc == 0) {
> > > > +                               opts->context_sid = sid;
> > > > +                               opts->preparsed |= CONTEXT_MNT;
> > > > +                       }
> > > > +               }
> > >
> > > Is there a reason why we need a dedicated sid variable as opposed to
> > > passing opt->context_sid as the parameter?  For example:
> > >
> > >   rc = parse_sid(NULL, s, &opts->context_sid);
> >
> > We don't need a dedicated sid variable.  Should I make similar changes
> > in the second patch (get rid of the local sid variable in
> > selinux_sb_remount() and the *context_sid variables in
> > selinux_set_mnt_opts())?
> 
> Yes please, I should have explicitly mentioned that.

Actually, delayed_superblock_init() calls selinux_set_mnt_opts() with
mnt_opts == NULL, so there would have to be a lot of checks like

        if (opts && opts->fscontext_sid) {

in the later parts of that function, which is kind of clunky.  I can
still do it if you want though.

-Scott

> 
> Thanks.
> 
> -- 
> paul moore
> paul-moore.com
> 

