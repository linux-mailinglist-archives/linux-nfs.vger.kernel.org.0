Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4076AFB11
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 01:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCHA2I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Mar 2023 19:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCHA2A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Mar 2023 19:28:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0BCAD08;
        Tue,  7 Mar 2023 16:27:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29B6F21A06;
        Wed,  8 Mar 2023 00:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678235275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYg0zd14OnH6G6prYVh+6t1LC9BkRsu+xveMuEjHgAI=;
        b=g+L0DX3jibkMrqYHRpN50jGt2DsViX8qWrUYPkSWsZqAcjxrvnn6GlapTy4/Mwy76xGEQ/
        3yRkbPBoXY+STHjyuNq/9bAHL6zpDA35R0hrFH5Kb0xpUoVaNjGGi0i1QswO5yEudLwgIG
        otRiwsBbHjnmUbtWK7chyz2eVuLswik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678235275;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYg0zd14OnH6G6prYVh+6t1LC9BkRsu+xveMuEjHgAI=;
        b=t9+RpxQeMzux8Kym8FcyznVmsj1Z5Ds9ZWvw/Ik1+ueiCvuJmStzatj7HDcoHGXWlaMjwi
        XIAC19Guf4JTAnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECA6F1348D;
        Wed,  8 Mar 2023 00:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nx9XJ4XWB2S6NwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 08 Mar 2023 00:27:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jerry Zhang" <jerry@skydio.com>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: Fix incorrect parsing of expiry time
In-reply-to: <CAMKO5CvuWxrzshJrUJGwiMApN_L6yL-qck0fvizvBUs2Z7PU-g@mail.gmail.com>
References: <20230307220525.54895-1-Jerry@skydio.com>,
 <167822825917.8008.11050193827453206272@noble.neil.brown.name>,
 <CAMKO5Cv1Uh1rSFQ0cR1kfA88iXXHP5RMO-euU15Xrn2i93J5rg@mail.gmail.com>,
 <167823124256.8008.4738010782615192469@noble.neil.brown.name>,
 <CAMKO5CvuWxrzshJrUJGwiMApN_L6yL-qck0fvizvBUs2Z7PU-g@mail.gmail.com>
Date:   Wed, 08 Mar 2023 11:27:46 +1100
Message-id: <167823526640.8008.3772702242442581073@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


(I've removed some bouncing email addresses, and also removed
 Trond and Anna who are responsible for the NFS client and so
 not directly interested in the server.  They will likely find
 this on the list if they are interested).

On Wed, 08 Mar 2023, Jerry Zhang wrote:
> On Tue, Mar 7, 2023 at 3:20=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Wed, 08 Mar 2023, Jerry Zhang wrote:
> > > On Tue, Mar 7, 2023 at 2:31=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> > > >
> > > > On Wed, 08 Mar 2023, Jerry Zhang wrote:
> > > > > The expiry time field is mean to be expressed in seconds since boot.
> > > >
> > > > Correct.
> > > >
> > > > > The get_expiry() function parses a relative time value in seconds.
> > > >
> > > > Incorrect.  It parses and absoulte wall-clock time.
> > > I'm not familiar with the source of truth for this info. Is there a
> > > specification of some sort?
> > >
> > > For reference, we were seeing writes to
> > > /proc/net/rpc/nfsd.export/channel randomly fail with EINVAL despite
> > > usually succeeding with the same invocation. Upon investigation this
> > > was the string that exportfs was writing "-test-client- /path/to/mount
> > >  3 0 65534 65534 0". "3" was the value for expiry in this message,
> > > which led me to conclude that this is a relative field. If it isn't,
> > > perhaps this is a bug in userspace nfs tools?
> >
> > The above information is very useful.  This sort of detail should always
> > be included with a bug report, or a patch proposing to fix a bug.
> >
> > The intent of that "3" is to be a time in the past.  We don't want the
> > -test-client- entry to be added to the cache, but we want a failure
> > message if the path cannot be exported.  So we set a time in the past as
> > the expiry time.
> > Using 0 is awkward as it often has special meaning, so I chose '3'.
> >
> > >
> > > The failure in this was if nfs-server starts exactly 3s after bootup,
> > > boot.tv_sec would be 3 and thus get_expiry() returns 0, causing a
> > > failure to be returned.
> >
> > I don't understand this. getboottime64() doesn't report time since boot.
> > It reports the time when the system booted.  It only changes when the
> > system time is deliberately changed.
> Ok I misinterpreted what this function does.
> > At boot, it presumably reports 0.  As soon as some tool (e.g. systemd or
> > ntpdate) determines what the current time it and calls settimeofday() or
> > a similar function, the system time is changed, and the boot-time is
> > changed by the same amount.  Typically this will make it well over 1
> > billion (for anything booted this century).
> > So for the boot time to report as '3', something would need to set the
> > current time to a moment early in January 1970.  I'd be surprised if
> > anything is doing that.
> I see the discrepency now -- our system is actually an embedded
> platform without an RTC. So it thinks that it is "1970" every time it
> boots up, at least until it connects to the internet or similar, which
> it may or may not ever do. We use NFS to share mountpoints between 2
> linux systems on our board connected via usb-ethernet. The fact that
> it allows simultaneous access gives it an advantage over other
> protocols like mass storage.
>=20
> Its likely that the code is working as intended then, it just didn't
> take our particular usecase into account.
>=20
> >
> > How much tracing have you done?  Have you printed out the value of
> > boot.tv_sec and confirmed that it is '3' or have you only deduced it
> > from other evidence.
> > Exactly what firm evidence do you have?
> Sure I've added this simple debug print with the necessary info
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 15422c951fd1..5af49198b162 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -528,10 +528,12 @@ static int svc_export_parse(struct cache_detail
> *cd, char *mesg, int mlen)
>         int len;
>         int err;
>         struct auth_domain *dom =3D NULL;
>         struct svc_export exp =3D {}, *expp;
>         int an_int;
> +       struct timespec64 boot;
> +       char* orig_mesg =3D mesg;
>=20
>         if (mesg[mlen-1] !=3D '\n')
>                 return -EINVAL;
>         mesg[mlen-1] =3D 0;
>=20
> @@ -564,10 +566,12 @@ static int svc_export_parse(struct cache_detail
> *cd, char *mesg, int mlen)
>         exp.ex_devid_map =3D NULL;
>=20
>         /* expiry */
>         err =3D -EINVAL;
>         exp.h.expiry_time =3D get_expiry(&mesg);
> +       getboottime64(&boot);
> +       printk("mesg is '%s' expiry is %lld and boot_s is %lld\n",
> orig_mesg, exp.h.expiry_time, boot.tv_sec);
>         if (exp.h.expiry_time =3D=3D 0)
>                 goto out3;
>=20
>         /* flags */
>         err =3D get_int(&mesg, &an_int);
>=20
> and the output is
>=20
> [   14.093506] mesg is '-test-client- /path/to/mount  3 8192 65534
> 65534 0' expiry is 0 and boot_s is 3
>=20
> which largely confirms the info above.
>=20
> Do you think we'd be able to handle this case cleanly?

Thanks for all the details.  Yes I think we can and should handle this
case cleanly.  I think the core problem is that get_expiry() mixes the
error code into the expiry time.  If we separate those out the problem
should disappear.

Please try this patch.

From: NeilBrown <neilb@suse.de>
Date: Wed, 8 Mar 2023 11:19:01 +1100
Subject: [PATCH] SUNRPC: return proper error from get_expiry()

The get_expiry() function currently returns a timestamp, and uses the
special return value of 0 to indicate an error.

Unfortunately this causes a problem when 0 is the correct return value.

On a system with no RTC it is possible that the boot time will be seen
to be "3".  When exportfs probes to see if a particular filesystem
supports NFS export it tries to cache information with an expiry time of
"3".  The intention is for this to be "long in the past".  Even with not
RTC it will not be far in the future (at most a second or two) so this
is harmless.
But if the boot time happens to have been calculated to be "3", then
get_expiry will fail incorrectly as it converts the number to "seconds
since bootime".

To avoid this problem we change get_expiry() to report the error quite
separately from the expiry time.  The error is now the return value.
The expiry time is reported through a by-reference parameter.

Reported-by: Jerry Zhang <jerry@skydio.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/export.c                  | 13 ++++++-------
 fs/nfsd/nfs4idmap.c               |  8 ++++----
 include/linux/sunrpc/cache.h      | 15 ++++++++-------
 net/sunrpc/auth_gss/svcauth_gss.c | 12 ++++++------
 net/sunrpc/svcauth_unix.c         | 12 ++++++------
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 668c7527b17e..6da74aebe1fb 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -123,11 +123,11 @@ static int expkey_parse(struct cache_detail *cd, char *=
mesg, int mlen)
=20
 	/* OK, we seem to have a valid key */
 	key.h.flags =3D 0;
-	key.h.expiry_time =3D get_expiry(&mesg);
-	if (key.h.expiry_time =3D=3D 0)
+	err =3D get_expiry(&mesg, &key.h.expiry_time);
+	if (err)
 		goto out;
=20
-	key.ek_client =3D dom;=09
+	key.ek_client =3D dom;
 	key.ek_fsidtype =3D fsidtype;
 	memcpy(key.ek_fsid, buf, len);
=20
@@ -610,9 +610,8 @@ static int svc_export_parse(struct cache_detail *cd, char=
 *mesg, int mlen)
 	exp.ex_devid_map =3D NULL;
=20
 	/* expiry */
-	err =3D -EINVAL;
-	exp.h.expiry_time =3D get_expiry(&mesg);
-	if (exp.h.expiry_time =3D=3D 0)
+	err =3D get_expiry(&mesg, &exp.h.expiry_time);
+	if (err)
 		goto out3;
=20
 	/* flags */
@@ -624,7 +623,7 @@ static int svc_export_parse(struct cache_detail *cd, char=
 *mesg, int mlen)
 		if (err || an_int < 0)
 			goto out3;
 		exp.ex_flags=3D an_int;
-=09
+
 		/* anon uid */
 		err =3D get_int(&mesg, &an_int);
 		if (err)
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 5e9809aff37e..7a806ac13e31 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -240,8 +240,8 @@ idtoname_parse(struct cache_detail *cd, char *buf, int bu=
flen)
 		goto out;
=20
 	/* expiry */
-	ent.h.expiry_time =3D get_expiry(&buf);
-	if (ent.h.expiry_time =3D=3D 0)
+	error =3D get_expiry(&buf, &ent.h.expiry_time);
+	if (error)
 		goto out;
=20
 	error =3D -ENOMEM;
@@ -408,8 +408,8 @@ nametoid_parse(struct cache_detail *cd, char *buf, int bu=
flen)
 	memcpy(ent.name, buf1, sizeof(ent.name));
=20
 	/* expiry */
-	ent.h.expiry_time =3D get_expiry(&buf);
-	if (ent.h.expiry_time =3D=3D 0)
+	error =3D get_expiry(&buf, &ent.h.expiry_time);
+	if (error)
 		goto out;
=20
 	/* ID */
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index ec5a555df96f..518bd28f5ab8 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -300,17 +300,18 @@ static inline int get_time(char **bpp, time64_t *time)
 	return 0;
 }
=20
-static inline time64_t get_expiry(char **bpp)
+static inline int get_expiry(char **bpp, time64_t *rvp)
 {
-	time64_t rv;
+	int error;
 	struct timespec64 boot;
=20
-	if (get_time(bpp, &rv))
-		return 0;
-	if (rv < 0)
-		return 0;
+	error =3D get_time(bpp, rvp);
+	if (error)
+		return error;
+
 	getboottime64(&boot);
-	return rv - boot.tv_sec;
+	(*rvp) -=3D boot.tv_sec;
+	return 0;
 }
=20
 #endif /*  _LINUX_SUNRPC_CACHE_H_ */
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_=
gss.c
index acb822b23af1..bfaf584d296a 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -258,11 +258,11 @@ static int rsi_parse(struct cache_detail *cd,
=20
 	rsii.h.flags =3D 0;
 	/* expiry */
-	expiry =3D get_expiry(&mesg);
-	status =3D -EINVAL;
-	if (expiry =3D=3D 0)
+	status =3D get_expiry(&mesg, &expiry);
+	if (status)
 		goto out;
=20
+	status =3D -EINVAL;
 	/* major/minor */
 	len =3D qword_get(&mesg, buf, mlen);
 	if (len <=3D 0)
@@ -484,11 +484,11 @@ static int rsc_parse(struct cache_detail *cd,
=20
 	rsci.h.flags =3D 0;
 	/* expiry */
-	expiry =3D get_expiry(&mesg);
-	status =3D -EINVAL;
-	if (expiry =3D=3D 0)
+	status =3D get_expiry(&mesg, &expiry);
+	if (status)
 		goto out;
=20
+	status =3D -EINVAL;
 	rscp =3D rsc_lookup(cd, &rsci);
 	if (!rscp)
 		goto out;
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index b1efc34db6ed..9e7798a69051 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -225,9 +225,9 @@ static int ip_map_parse(struct cache_detail *cd,
 		return -EINVAL;
 	}
=20
-	expiry =3D get_expiry(&mesg);
-	if (expiry =3D=3D0)
-		return -EINVAL;
+	err =3D get_expiry(&mesg, &expiry);
+	if (err)
+		return err;
=20
 	/* domainname, or empty for NEGATIVE */
 	len =3D qword_get(&mesg, buf, mlen);
@@ -497,9 +497,9 @@ static int unix_gid_parse(struct cache_detail *cd,
 	uid =3D make_kuid(current_user_ns(), id);
 	ug.uid =3D uid;
=20
-	expiry =3D get_expiry(&mesg);
-	if (expiry =3D=3D 0)
-		return -EINVAL;
+	err =3D get_expiry(&mesg, &expiry);
+	if (err)
+		return err;
=20
 	rv =3D get_int(&mesg, &gids);
 	if (rv || gids < 0 || gids > 8192)
--=20
2.39.2

