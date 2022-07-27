Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A059D5835CB
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 01:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiG0Xst (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 19:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG0Xss (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 19:48:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1011B5A3DF
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 16:48:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF20220ECC;
        Wed, 27 Jul 2022 23:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658965726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loyJhTq/FNEHNkgsLNEljJhAEtjX8v/yKoD0dhpNWTc=;
        b=EqEuYCqE8D5PquRvuJYh5nOWbTIY366aWorC1FlBZ024fEjXl4kREwDEayf8hu0KL+2kTz
        T53SQVzWIgabv1wJvsFigH5/abeYf7mRxrCrVgDkomA5zzfhdfZgolIvBX16IRB0NzvAgV
        zAgrprTUaiU6Hgi7sfcRfsnU87fjA1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658965726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loyJhTq/FNEHNkgsLNEljJhAEtjX8v/yKoD0dhpNWTc=;
        b=v+UzBsD9S1jEFy740VZIi+WvqMerSWGQTNTG4Q3ZyHPxoWQrXRK4HdGrvRDFeM+8wkFlnz
        87ifrmKdniQznACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A243313A8E;
        Wed, 27 Jul 2022 23:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c/1OF93O4WKEHQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 27 Jul 2022 23:48:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/13] NFSD: clean up locking
In-reply-to: <9f3fa578841067378e7f5a1c26ecde90e66c90e9.camel@kernel.org>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>,
 <9f3fa578841067378e7f5a1c26ecde90e66c90e9.camel@kernel.org>
Date:   Thu, 28 Jul 2022 09:48:42 +1000
Message-id: <165896572203.4359.16866453628573745859@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 28 Jul 2022, Jeff Layton wrote:
> On Tue, 2022-07-26 at 16:45 +1000, NeilBrown wrote:
> > This is the latest version of my series to clean up locking -
> > particularly of directories - in preparation for proposed patches which
> > change how directory locking works across the VFS.
> >=20
> > I've included Jeff's patches to validate the dentry after getting a
> > delegation.  The second patch has been changed quite a bit to use
> > nfsd_lookup_dentry(). I've left Jeff's From: line in place - let me know
> > if you'd rather I change it.
> >=20
>=20
> That's fine.
>=20
> > Setting of ACLs and security labels has been moved from nfs4 code to
> > nfsd_setattr() which allows quite a lot of code cleanup.
> >=20
> > I think I've addressed all the concerns that have been raised, though
> > maybe not in the way that was suggested.
> >=20
> > I've tested this with cthon tests over v2, v3, v4.0, v4.1, and xfstests
> > on v3 and v4.1, and pynfs 4.0, 4.1.  No problems appeared.
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> > ---
> >=20
> > Jeff Layton (2):
> >       NFSD: drop fh argument from alloc_init_deleg
> >       NFSD: verify the opened dentry after setting a delegation
> >=20
> > NeilBrown (11):
> >       NFSD: introduce struct nfsd_attrs
> >       NFSD: set attributes when creating symlinks
> >       NFSD: add security label to struct nfsd_attrs
> >       NFSD: add posix ACLs to struct nfsd_attrs
> >       NFSD: change nfsd_create()/nfsd_symlink() to unlock directory befor=
e returning.
> >       NFSD: always drop directory lock in nfsd_unlink()
> >       NFSD: only call fh_unlock() once in nfsd_link()
> >       NFSD: reduce locking in nfsd_lookup()
> >       NFSD: use explicit lock/unlock for directory ops
> >       NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
> >       NFSD: discard fh_locked flag and fh_lock/fh_unlock
> >=20
>=20
> It looks like the last 5 patches are missing from the posting
> (everything after patch #8).
>=20

Sorry.  You should have them now.

NeilBrown
