Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E42949D3C6
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 21:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiAZUmG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 15:42:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbiAZUmF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 15:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643229725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cEHouQrloL2oxzXmnGVBA6JFcmEONjYk5C4lG+EUGRE=;
        b=J/oTMDYUlaHeXT6KjKugRuit3GutrvFZP/SZ+Pdn4Mr5f4lqx912a6cR3XhxdrWf7vQT9n
        4B/XBUYNq6s6Cmstk29nzWNNYJbBC6bvivO4jvAkgTox5ldPNayYe2Alg5rKmO+W/caBcK
        90P4XyP0NC6FnDcRWyAEwFlFpR5+dTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-lRMSPkIuMqau8EzdnDHtZA-1; Wed, 26 Jan 2022 15:42:01 -0500
X-MC-Unique: lRMSPkIuMqau8EzdnDHtZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB6F719251A0;
        Wed, 26 Jan 2022 20:41:59 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B629668D90;
        Wed, 26 Jan 2022 20:41:59 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id EE1F91A001F; Wed, 26 Jan 2022 15:41:58 -0500 (EST)
Date:   Wed, 26 Jan 2022 15:41:58 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
Message-ID: <YfGyFhA0ZQPagROG@aion.usersys.redhat.com>
References: <20220120214948.3637895-1-smayhew@redhat.com>
 <20220120214948.3637895-2-smayhew@redhat.com>
 <CAHC9VhT2RhnXtK3aQuDCFUr5qayH25G8HHjRTJzhWM3H41YNog@mail.gmail.com>
 <YfAz0EAim7Q9ifGI@aion.usersys.redhat.com>
 <CAHC9VhTwXUE9dYBHrkA3Xkr=AgXvcnfSzLLBJ4QqYd4R+kFbbA@mail.gmail.com>
 <YfBGx+M9jQZa80rZ@aion.usersys.redhat.com>
 <CAHC9VhRoWbnV-cs2HzmiTEd7_kP914stdVpN9Tm2-6uua2-ELA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRoWbnV-cs2HzmiTEd7_kP914stdVpN9Tm2-6uua2-ELA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022, Paul Moore wrote:

> On Tue, Jan 25, 2022 at 1:51 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > On Tue, 25 Jan 2022, Paul Moore wrote:
> > > On Tue, Jan 25, 2022 at 12:31 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > > On Mon, 24 Jan 2022, Paul Moore wrote:
> > > > > On Thu, Jan 20, 2022 at 4:50 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > > > >
> > > > > > selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> > > > > > shouldn't be performing any memory allocations.  Fix this by parsing the
> > > > > > sids at the same time we're chopping up the security mount options
> > > > > > string and then using the pre-parsed sids when doing the comparison.
> > > > > >
> > > > > > Fixes: cc274ae7763d ("selinux: fix sleeping function called from invalid context")
> > > > > > Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> > > > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > > > ---
> > > > > >  security/selinux/hooks.c | 112 ++++++++++++++++++++++++++-------------
> > > > > >  1 file changed, 76 insertions(+), 36 deletions(-)
> > >
> > > ...
> > >
> > > > > >         switch (token) {
> > > > > >         case Opt_context:
> > > > > >                 if (opts->context || opts->defcontext)
> > > > > >                         goto err;
> > > > > >                 opts->context = s;
> > > > > > +               if (preparse_sid) {
> > > > > > +                       rc = parse_sid(NULL, s, &sid);
> > > > > > +                       if (rc == 0) {
> > > > > > +                               opts->context_sid = sid;
> > > > > > +                               opts->preparsed |= CONTEXT_MNT;
> > > > > > +                       }
> > > > > > +               }
> > > > >
> > > > > Is there a reason why we need a dedicated sid variable as opposed to
> > > > > passing opt->context_sid as the parameter?  For example:
> > > > >
> > > > >   rc = parse_sid(NULL, s, &opts->context_sid);
> > > >
> > > > We don't need a dedicated sid variable.  Should I make similar changes
> > > > in the second patch (get rid of the local sid variable in
> > > > selinux_sb_remount() and the *context_sid variables in
> > > > selinux_set_mnt_opts())?
> > >
> > > Yes please, I should have explicitly mentioned that.
> >
> > Actually, delayed_superblock_init() calls selinux_set_mnt_opts() with
> > mnt_opts == NULL, so there would have to be a lot of checks like
> >
> >         if (opts && opts->fscontext_sid) {
> >
> > in the later parts of that function, which is kind of clunky.  I can
> > still do it if you want though.
> 
> I might be misunderstanding your concern, but in
> selinux_set_mnt_opts() all of the "opts->XXX" if-conditionals are
> protected by being inside an if-statement that checks to ensure "opts"
> is not NULL.  Am I missing something?

Sorry for being unclear.  The parts where the sids are (potentially)
being parsed are inside an "if (opts) { ... }" block... but later in the
function those sids are used in various tests/assignments.  So if we
wanted to eliminate the four local context_sid variables (using the
variables in opts instead), then there would need to be additional
checks to avoid dereferencing opts when it's NULL.

In other words, if the local context_sid variables are kept, then the
change to selinux_set_mnt_opts() would look like this (option A):

---8<---
@@ -676,36 +676,48 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 */
 	if (opts) {
 		if (opts->fscontext) {
-			rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
-			if (rc)
-				goto out;
+			if (opts->fscontext_sid == SECSID_NULL ) {
+				rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
+				if (rc)
+					goto out;
+			} else
+				fscontext_sid = opts->fscontext_sid;
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
 					fscontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= FSCONTEXT_MNT;
 		}
 		if (opts->context) {
-			rc = parse_sid(sb, opts->context, &context_sid);
-			if (rc)
-				goto out;
+			if (opts->context_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->context, &context_sid);
+				if (rc)
+					goto out;
+			} else
+				context_sid = opts->context_sid;
 			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
 					context_sid))
 				goto out_double_mount;
 			sbsec->flags |= CONTEXT_MNT;
 		}
 		if (opts->rootcontext) {
-			rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
-			if (rc)
-				goto out;
+			if (opts->rootcontext_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
+				if (rc)
+					goto out;
+			} else
+				rootcontext_sid = opts->rootcontext_sid;
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
 					rootcontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= ROOTCONTEXT_MNT;
 		}
 		if (opts->defcontext) {
-			rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
-			if (rc)
-				goto out;
+			if (opts->defcontext_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
+				if (rc)
+					goto out;
+			} else
+				defcontext_sid = opts->defcontext_sid;
 			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
 					defcontext_sid))
 				goto out_double_mount;
---8<---

and if the local context_sid variables are removed, the change to selinux_set_mnt_opts()
would look like this (option B):

---8<---
@@ -627,8 +627,6 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	struct dentry *root = sb->s_root;
 	struct selinux_mnt_opts *opts = mnt_opts;
 	struct inode_security_struct *root_isec;
-	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
-	u32 defcontext_sid = 0;
 	int rc = 0;
 
 	mutex_lock(&sbsec->lock);
@@ -676,38 +674,50 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 */
 	if (opts) {
 		if (opts->fscontext) {
-			rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
-			if (rc)
-				goto out;
+			if (opts->fscontext_sid == SECSID_NULL ) {
+				rc = parse_sid(sb, opts->fscontext,
+						&opts->fscontext_sid);
+				if (rc)
+					goto out;
+			}
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
-					fscontext_sid))
+					opts->fscontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= FSCONTEXT_MNT;
 		}
 		if (opts->context) {
-			rc = parse_sid(sb, opts->context, &context_sid);
-			if (rc)
-				goto out;
+			if (opts->context_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->context,
+						&opts->context_sid);
+				if (rc)
+					goto out;
+			}
 			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
-					context_sid))
+					opts->context_sid))
 				goto out_double_mount;
 			sbsec->flags |= CONTEXT_MNT;
 		}
 		if (opts->rootcontext) {
-			rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
-			if (rc)
-				goto out;
+			if (opts->rootcontext_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->rootcontext,
+						&opts->rootcontext_sid);
+				if (rc)
+					goto out;
+			}
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
-					rootcontext_sid))
+					opts->rootcontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= ROOTCONTEXT_MNT;
 		}
 		if (opts->defcontext) {
-			rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
-			if (rc)
-				goto out;
+			if (opts->defcontext_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->defcontext,
+						&opts->defcontext_sid);
+				if (rc)
+					goto out;
+			}
 			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
-					defcontext_sid))
+					opts->defcontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= DEFCONTEXT_MNT;
 		}
@@ -760,8 +770,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    strcmp(sb->s_type->name, "ramfs") &&
 	    strcmp(sb->s_type->name, "devpts") &&
 	    strcmp(sb->s_type->name, "overlay")) {
-		if (context_sid || fscontext_sid || rootcontext_sid ||
-		    defcontext_sid) {
+		if (opts && (opts->context_sid || opts->fscontext_sid ||
+		    opts->rootcontext_sid || opts->defcontext_sid)) {
 			rc = -EACCES;
 			goto out;
 		}
@@ -779,12 +789,13 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	}
 
 	/* sets the context of the superblock for the fs being mounted. */
-	if (fscontext_sid) {
-		rc = may_context_mount_sb_relabel(fscontext_sid, sbsec, cred);
+	if (opts && opts->fscontext_sid) {
+		rc = may_context_mount_sb_relabel(opts->fscontext_sid,
+						  sbsec, cred);
 		if (rc)
 			goto out;
 
-		sbsec->sid = fscontext_sid;
+		sbsec->sid = opts->fscontext_sid;
 	}
 
 	/*
@@ -792,42 +803,43 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * sets the label used on all file below the mountpoint, and will set
 	 * the superblock context if not already set.
 	 */
-	if (kern_flags & SECURITY_LSM_NATIVE_LABELS && !context_sid) {
+	if (kern_flags & SECURITY_LSM_NATIVE_LABELS &&
+			!(opts && opts->context_sid)) {
 		sbsec->behavior = SECURITY_FS_USE_NATIVE;
 		*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 	}
 
-	if (context_sid) {
-		if (!fscontext_sid) {
-			rc = may_context_mount_sb_relabel(context_sid, sbsec,
-							  cred);
+	if (opts && opts->context_sid) {
+		if (!opts->fscontext_sid) {
+			rc = may_context_mount_sb_relabel(opts->context_sid,
+							  sbsec, cred);
 			if (rc)
 				goto out;
-			sbsec->sid = context_sid;
+			sbsec->sid = opts->context_sid;
 		} else {
-			rc = may_context_mount_inode_relabel(context_sid, sbsec,
-							     cred);
+			rc = may_context_mount_inode_relabel(opts->context_sid,
+							     sbsec, cred);
 			if (rc)
 				goto out;
 		}
-		if (!rootcontext_sid)
-			rootcontext_sid = context_sid;
+		if (!opts->rootcontext_sid)
+			opts->rootcontext_sid = opts->context_sid;
 
-		sbsec->mntpoint_sid = context_sid;
+		sbsec->mntpoint_sid = opts->context_sid;
 		sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
 	}
 
-	if (rootcontext_sid) {
-		rc = may_context_mount_inode_relabel(rootcontext_sid, sbsec,
-						     cred);
+	if (opts && opts->rootcontext_sid) {
+		rc = may_context_mount_inode_relabel(opts->rootcontext_sid,
+						     sbsec, cred);
 		if (rc)
 			goto out;
 
-		root_isec->sid = rootcontext_sid;
+		root_isec->sid = opts->rootcontext_sid;
 		root_isec->initialized = LABEL_INITIALIZED;
 	}
 
-	if (defcontext_sid) {
+	if (opts && opts->defcontext_sid) {
 		if (sbsec->behavior != SECURITY_FS_USE_XATTR &&
 			sbsec->behavior != SECURITY_FS_USE_NATIVE) {
 			rc = -EINVAL;
@@ -836,14 +848,14 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			goto out;
 		}
 
-		if (defcontext_sid != sbsec->def_sid) {
-			rc = may_context_mount_inode_relabel(defcontext_sid,
+		if (opts->defcontext_sid != sbsec->def_sid) {
+			rc = may_context_mount_inode_relabel(opts->defcontext_sid,
 							     sbsec, cred);
 			if (rc)
 				goto out;
 		}
 
-		sbsec->def_sid = defcontext_sid;
+		sbsec->def_sid = opts->defcontext_sid;
 	}
 
 out_set_opts:
---8<---

-Scott
> 
> -- 
> paul-moore.com
> 

