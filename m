Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0050E4CCB17
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Mar 2022 02:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiCDBBy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Mar 2022 20:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiCDBBx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Mar 2022 20:01:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAB1795C6
        for <linux-nfs@vger.kernel.org>; Thu,  3 Mar 2022 17:01:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7316F1F382;
        Fri,  4 Mar 2022 01:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646355663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvugK65kAsWi/8Pn8zMrULRchO2qCeWp6UAzwFR2hQ0=;
        b=rk2da8BJKiWHOOCTyl8I0/9ybqPyu3QRqPpy1wS2OqltWiChl3uTCA0aEzEYaBK3CAdmkX
        1HZ/VloBjxO42THRIlv7JaZjb8TzEoPL6hnoUrGoZcMdD2zUIg/vwSULOk16lGWuyUB1UO
        02ywzJfRXo/v/hiOlkBf9Il8hoPeODo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646355663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvugK65kAsWi/8Pn8zMrULRchO2qCeWp6UAzwFR2hQ0=;
        b=xV1H041mea4YtLn/d+r+YtgUTj/iuorOlHPGrzG/H2qZL9bQVLhymgqYi+6vik/HTPxXqQ
        L4BpeIwcAIWxL1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4E5313AF7;
        Fri,  4 Mar 2022 01:01:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xDjqGM5kIWInZQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 04 Mar 2022 01:01:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS access problems when group membership changes on server
In-reply-to: <c834d47c685d2c6a227846f31ba259b893fcbf73.camel@hammerspace.com>
References: <164628537738.17899.2312723585718867242@noble.neil.brown.name>,
 <c834d47c685d2c6a227846f31ba259b893fcbf73.camel@hammerspace.com>
Date:   Fri, 04 Mar 2022 12:00:59 +1100
Message-id: <164635565950.13165.2115862112727302421@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 04 Mar 2022, Trond Myklebust wrote:
> On Thu, 2022-03-03 at 16:29 +1100, NeilBrown wrote:
> >=20
> > Since
> > =C2=A0Commit 57b691819ee2 ("NFS: Cache access checks more aggressively")
> > we do not recheck "ACCESS" tests unless the inode changes (or falls
> > out
> > of cache).=C2=A0 I recently discovered that this can be problematic.
> >=20
> > The ACCESS test checks if a given user has access to a given file.
> > That is most likely to change if the file changes, but it can change
> > if
> > the users capabilities change=C2=A0 - e.g. their group memberships change.
> > With AUTH_SYS the group membership as seen on the client is used
> > (though
> > with the Linux NFS server, adding the -g option to mountd can change
> > this).
> > With AUTH_GSS, the mapping from user to groups must happen on the
> > server.=C2=A0 IF this mapping changes it might be invisible to the client
> > for an arbitrary long time.
> >=20
> > I don't think this affects files with NFSv4 as there will be a OPEN
> > request to the server, but it does affect directories.
> >=20
> > If a user does "ls -l some-directory", this fails, and they go ask
> > the
> > server admin "please add me to the group to access the directory",
> > then
> > they go back and try again, it may well still not work.
> >=20
> > With a local filesystem, logging off and back on again might be
> > required to refresh the groups list, but even this isn't sufficient
> > for
> > NFS.=20
> >=20
> > What to do?=20
> >=20
> > We could simply revert that patch and refresh the access cache
> > similar
> > to refreshing of other attributes.=C2=A0 We could possibly do it with a
> > longer timeout or only with a mount option, but I don't really like
> > those options.
> >=20
> > Maybe we could add a 'struct pid *' to the access entry which
> > references
> > the PIDTYPE_SID of the calling process.=C2=A0 This would be different for
> > different login sessions, but common throughout one login.
> > If we did this, then logging out and back in again would resolve the
> > access problem, which matches that is needed for local access.
> > I'm not sure if I like this idea or not, but I thought it worth
> > mentioning.
> >=20
>=20
> Actually, most of the newer common identity mapping schemes, including
> Active Directory and FreeIPA will store the group membership in a PAC,
> which is attached to the ticket on the client. So the mapping still
> happens on the server, but it uses information from the GSS session
> instead of doing another round trip to the identity server.
>=20
> That means the group membership as understood by the server is tied to
> your AUTH_GSS session and the ticket that created it. To change it, you
> may need to invalidate the AUTH_GSS session, and change your kerberos
> ticket through a new "kinit".

Interesting ....  so it might be possible that logging of and back on
again could already work for the customer.  I'll check.
Though I don't even know if they are using GSS.  All I know is they did
"something" on the NetApp server and didn't get the access they expected.

>=20
> >=20
>=20
> > Any other ideas?
> >=20
>=20
> As I see it, the cache needs to be tied to the GSS ticket so that any
> given entry can be invalidated when the ticket is. That's a scheme that
> also works just fine for AUTH_SYS, and would exactly preserve the POSIX
> semantics whereby we update the group membership on login.
>=20
> One suggestion for doing so might be to allow the cache entries to
> subscribe to the RPC cred that was used to create them in a way that
> doesn't prevent the  cred from being kicked out of the cache (i.e. we
> don't take a reference). If the cred is no longer in the cred cache
> when we check the access cache, then consider the access entry to need
> refreshing/revalidation.

Holding a cred without taking a reference would mean it could get freed,
unless we added some new "weak reference" to creds.  I wonder if we can
really justify that.

But maybe we could require the group_info pointer to match.  They are
refcounted and shared with the cred, but you get a new one when you log
in.
You get a group info even if the list of groups is empty.
So that would track closely to the login credential.
What would you think of something like this (once it had been tested etc
of course).

Thanks,
NeilBrown


diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 75cb1cbe4cde..5852c67a3bd4 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2737,22 +2737,9 @@ static int access_cmp(const struct cred *a, const stru=
ct nfs_access_entry *b)
 	gb =3D b->group_info;
 	if (ga =3D=3D gb)
 		return 0;
-	if (ga =3D=3D NULL)
+	if (ga < gb)
 		return -1;
-	if (gb =3D=3D NULL)
-		return 1;
-	if (ga->ngroups < gb->ngroups)
-		return -1;
-	if (ga->ngroups > gb->ngroups)
-		return 1;
-
-	for (g =3D 0; g < ga->ngroups; g++) {
-		if (gid_lt(ga->gid[g], gb->gid[g]))
-			return -1;
-		if (gid_gt(ga->gid[g], gb->gid[g]))
-			return 1;
-	}
-	return 0;
+	return 1;
 }
=20
 static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode=
, const struct cred *cred)
