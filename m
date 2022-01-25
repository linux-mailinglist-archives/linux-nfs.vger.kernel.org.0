Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348C49BA6B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 18:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiAYRdM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 12:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1588346AbiAYRbG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 12:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643131863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FOhtSnszfuYomKwI9GTes/EVQRwn8bawuKP9VnO4Rw8=;
        b=B8rNhMJA1+Fz2ZygSVInwSiY4mU/gJAL7HOSjqzcTSj0Fe01MDmeKe0BOnH/mhOkQyuc3X
        l8lLMYjmxuQWhBSJxYADnM4mctiGpAfuGNbdLDzg6dOHkWp+VhZDpXCyApcsHS+Ovr71+Y
        ubI0ktyq+bporjRJTp74qIhVHQaoESQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-9SAjqfipNvalBy331ui-gw-1; Tue, 25 Jan 2022 12:30:59 -0500
X-MC-Unique: 9SAjqfipNvalBy331ui-gw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58F8E1898290;
        Tue, 25 Jan 2022 17:30:58 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA49410A48B7;
        Tue, 25 Jan 2022 17:30:57 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id F1D4D1A001F; Tue, 25 Jan 2022 12:30:56 -0500 (EST)
Date:   Tue, 25 Jan 2022 12:30:56 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
Message-ID: <YfAz0EAim7Q9ifGI@aion.usersys.redhat.com>
References: <20220120214948.3637895-1-smayhew@redhat.com>
 <20220120214948.3637895-2-smayhew@redhat.com>
 <CAHC9VhT2RhnXtK3aQuDCFUr5qayH25G8HHjRTJzhWM3H41YNog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT2RhnXtK3aQuDCFUr5qayH25G8HHjRTJzhWM3H41YNog@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 24 Jan 2022, Paul Moore wrote:

> On Thu, Jan 20, 2022 at 4:50 PM Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> > shouldn't be performing any memory allocations.  Fix this by parsing the
> > sids at the same time we're chopping up the security mount options
> > string and then using the pre-parsed sids when doing the comparison.
> >
> > Fixes: cc274ae7763d ("selinux: fix sleeping function called from invalid context")
> > Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  security/selinux/hooks.c | 112 ++++++++++++++++++++++++++-------------
> >  1 file changed, 76 insertions(+), 36 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 5b6895e4fc29..f27ca9e870c0 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -342,6 +342,11 @@ static void inode_free_security(struct inode *inode)
> >
> >  struct selinux_mnt_opts {
> >         const char *fscontext, *context, *rootcontext, *defcontext;
> > +       u32 fscontext_sid;
> > +       u32 context_sid;
> > +       u32 rootcontext_sid;
> > +       u32 defcontext_sid;
> > +       unsigned short preparsed;
> >  };
> 
> Is the preparsed field strictly necessary?  Can't we just write the
> code to assume that if a given SID field is not SECSID_NULL then it is
> valid/preparsed?

The preparsed field isn't necessary.  I'll change it.

> 
> > @@ -598,12 +603,11 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
> >         return 0;
> >  }
> >
> > -static int parse_sid(struct super_block *sb, const char *s, u32 *sid,
> > -                    gfp_t gfp)
> > +static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
> >  {
> >         int rc = security_context_str_to_sid(&selinux_state, s,
> > -                                            sid, gfp);
> > -       if (rc)
> > +                                            sid, GFP_KERNEL);
> > +       if (rc && sb != NULL)
> >                 pr_warn("SELinux: security_context_str_to_sid"
> >                        "(%s) failed for (dev %s, type %s) errno=%d\n",
> >                        s, sb->s_id, sb->s_type->name, rc);
> 
> It seems like it would still be useful to see the warning even when sb
> is NULL, wouldn't you say?  How about something like this:
> 
>   if (rc)
>     pr_warn("SELinux: blah blah blah (dev %s, type %s) blah blah\n",
>             (sb ? sb->s_id : "?"),
>             (sb ? sb->s_type->name : "?"));

I agree, that would be useful.
> 
> > @@ -976,6 +976,9 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
> >  {
> >         struct selinux_mnt_opts *opts = *mnt_opts;
> >         bool is_alloc_opts = false;
> > +       bool preparse_sid = false;
> > +       u32 sid;
> > +       int rc;
> >
> >         if (token == Opt_seclabel)
> >                 /* eaten and completely ignored */
> > @@ -991,26 +994,57 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
> >                 is_alloc_opts = true;
> >         }
> >
> > +       if (selinux_initialized(&selinux_state))
> > +               preparse_sid = true;
> 
> Since there is no looping in selinux_add_opt, and you can only specify
> one token/option for a given call to this function, it seems like we
> can do away with preparse_sid and just do the selinux_initialized(...)
> check directly in the code below, yes?

Will do.
> 
> >         switch (token) {
> >         case Opt_context:
> >                 if (opts->context || opts->defcontext)
> >                         goto err;
> >                 opts->context = s;
> > +               if (preparse_sid) {
> > +                       rc = parse_sid(NULL, s, &sid);
> > +                       if (rc == 0) {
> > +                               opts->context_sid = sid;
> > +                               opts->preparsed |= CONTEXT_MNT;
> > +                       }
> > +               }
> 
> Is there a reason why we need a dedicated sid variable as opposed to
> passing opt->context_sid as the parameter?  For example:
> 
>   rc = parse_sid(NULL, s, &opts->context_sid);

We don't need a dedicated sid variable.  Should I make similar changes
in the second patch (get rid of the local sid variable in
selinux_sb_remount() and the *context_sid variables in
selinux_set_mnt_opts())?

Thanks,
Scott
> 
> -- 
> paul moore
> paul-moore.com
> 

