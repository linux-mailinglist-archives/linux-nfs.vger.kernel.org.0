Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8427DA326
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Oct 2023 00:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjJ0WKa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 18:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0WK3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 18:10:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A601A6
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 15:10:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B462E1FEF4;
        Fri, 27 Oct 2023 22:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698444625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jWqXm+OxPjjbhJeneEYuEaI6iD3ynOI5FZeXNxX+0A=;
        b=J36jFsTQyuBFILNNN66ILwtO2DE4TG/QgmRTbyQN21hYuYJs4815236R+WZGMTaHxAtXyK
        CY8IybhZuPf841O8LaWZOlfj+0mRmP3Ywvr62zKiZvMuWmMi0t2nwFA0KcaRU2yvgZWgME
        69oUZXIEzxczj4NYsQhZVu+giRaghxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698444625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jWqXm+OxPjjbhJeneEYuEaI6iD3ynOI5FZeXNxX+0A=;
        b=MD4AJYiHhTa7tYqA9GNs/4I+toKbDpNr2yKjCxLszYqWi/eax7smN4fnFl9HiIAHk1uFc3
        QC8THXcatrmiMwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8520F1358C;
        Fri, 27 Oct 2023 22:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lFooDk81PGUbOAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Oct 2023 22:10:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 0/6] support admin-revocation of v4 state
In-reply-to: <ZTvaxWodP4rKFkrm@tissot.1015granger.net>
References: <20231027015613.26247-1-neilb@suse.de>,
 <ZTvaxWodP4rKFkrm@tissot.1015granger.net>
Date:   Sat, 28 Oct 2023 09:10:19 +1100
Message-id: <169844461904.20306.4942454840443131694@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 28 Oct 2023, Chuck Lever wrote:
> On Fri, Oct 27, 2023 at 12:45:28PM +1100, NeilBrown wrote:
> > This is a revised version of a patch set I sent over a year ago.
> > It now supports v4.0 and has had more testing.
> >=20
> > There are cirsumstances where an admin might need to unmount a
> > filesystem that is NFS-exported and in active use, but does not want to
> > stop the NFS server completely.  These are certainly unusual
> > circumstance and doing this might negatively impact any clients acting
> > on the filesystem, but the admin should be able to do this.
> >=20
> > Currently this is quite possible for for NFSv3.  Unexporting the
> > filesystem will ensure no new opens happen, and writing the path name to
> > /proc/fs/nfsd/unlock_filesystem will ensure anly NLM locks held in the
> > filesystem are released so that NFSD no longer prevents the filesystem
> > from being unlocked.
> >=20
> > It is not currently possible for NFSv4.  Writing to unlock_filesystem
> > does not affect NFSv4, which is arguably a bug.  This series fixes the bu=
g.
>=20
> I agree that this is a good thing to do.
>=20
> However, I'd like to migrate the "unlock_filesystem" functionality
> to the nfsd netlink protocol first rather than adding this support
> to /proc/fs/nfsd/. I don't believe that would be a difficult pre-
> requisite to get through.
>=20
> Does that seem sensible?

Not to me.

This is not new functionality - it is a fix for existing functionality
which incorrectly ignores NFSv4.

When you say "migrate" I hope you mean to add the "unlock_filesystem"
functionality to netlink, but not remove it from /proc/fs/nfsd for
several years at least.  I certainly wouldn't want to wait several
(more) years for this to land.

However it lands, the interface that it used for NFSv3 should be the
same as the interface that is used for NFSv4 and I think
/proc/fs/nfsd/unlock_filesystem should be one such interface until (if
ever) we discard the /proc/fs/nfsd filesystem.

Thanks,
NeilBrown


>=20
>=20
> > For NFSv4.1 and later code is straight forward.  We add new state types
> > for admin-revoked state (open, lock, deleg) and change the type of any
> > state on a filesystem - inavlidating any access and closing files as we
> > go.  While there are any revoked states we report this to the client in
> > the response to SEQUENCE requests, and it will check and free any states
> > that need to be freed.
> >=20
> > For NFSv4.0 it isn't quite so easy as there is no mechanism for the
> > client to explicitly acknowledged admin-revoked states.  The approach
> > this patchset takes is to discard NFSv4.0 admin-revoked states one
> > lease-time after they were revoked, or immediately for a state that the
> > client tryies to use and gets an "ADMIN_REVOKED" error for.  If the
> > filestystem has been unmounted (as expected), the client will see STATE
> > errors before it has a chance to see ADMIN_REVOKED errors, so most often
> > the timeout will be how states are discarded.
> >=20
> > NeilBrown
> >=20
> >  [PATCH 1/6] nfsd: prepare for supporting admin-revocation of state
> >  [PATCH 2/6] nfsd: allow admin-revoked state to appear in
> >  [PATCH 3/6] nfsd: allow admin-revoked NFSv4.0 state to be freed.
> >  [PATCH 4/6] nfsd: allow lock state ids to be revoked and then freed
> >  [PATCH 5/6] nfsd: allow open state ids to be revoked and then freed
> >  [PATCH 6/6] nfsd: allow delegation state ids to be revoked and then
> >=20
>=20
> --=20
> Chuck Lever
>=20

