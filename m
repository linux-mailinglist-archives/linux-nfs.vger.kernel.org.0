Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B805F41DE
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 13:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJDLUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 07:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJDLT4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 07:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8E0B848
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 04:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49DB76135E
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 11:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D46C433D6;
        Tue,  4 Oct 2022 11:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664882391;
        bh=SJ5LTFVwSmLI22VmtgvQOKRzc4Wlxe8BqDVOSvf0a1o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eAQLCHkz+L2jW+vwESXUvib2yzZ4bqUqlq7MK0D7acFKFClaUXBjWtqUEEY3cljBJ
         xMmZgGiunSg4i0N2Y8gMzRGOSFQKRjQpENBYnAPBuKnCruE6swyXv3LXJtOzYgmijo
         bs4GXMZhkaJvho/98dMdIIkKmiKO1nt4hsvOzxx8CySCJBWZHu1EuQLDuNm6Ft+76Y
         lgWZi4VtOGLt1h0qYcXPlwf+S/MO8myLNHCRsRZmERsY2fRKBttkoI1Jyi9mW0Bo2l
         IzEXJjwHeRLpyVZQOhUO1PXLu7MNboQQ152QB7lGkN1iL4l5RenFwmR98uAh6QmVKj
         FcFefzQuwIIdw==
Message-ID: <fb9c520e8bd9a034eeb10285c03dcf5cd6a660c9.camel@kernel.org>
Subject: Re: nfsd: another possible delegation race
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 04 Oct 2022 07:19:49 -0400
In-Reply-To: <166486048770.14457.133971372966856907@noble.neil.brown.name>
References: <166486048770.14457.133971372966856907@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-10-04 at 16:14 +1100, NeilBrown wrote:
> Hi,
>  I have a customer who experienced a crash in nfsd which appears to be
>  related to delegation return.  I cannot completely rule-out
>   Commit 548ec0805c39 ("nfsd: fix use-after-free due to delegation race")
>  as the kernel being used didn't have that commit, but the symptoms are
>  quite different, and while exploring I found, I think, a different
>  race.  This new race doesn't obviously address all the symptoms, but
>  maybe it does...
>=20
>  The symptoms were:
>   1/   WARN_ON(!unhash_delegation_locked(dp));
>     in nfs4_laundromat complained (delegation wasn't hashed!)
>   2/   refcount_t: saturated; leaking memory
>     This came from the refcount_inc in revoke_delegation() called from
>     nfs4_laundromat(), a few lines below the above warning

Well, that is odd! Chuck has caught this a couple of times:

    https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394

...but that's an underflow.

>   3/ BUG: kernel NULL pointer dereference, address: 0000000000000028
>      This is from the destroy_unhashed_deleg() call at the end of
>      that same revoke_delegation() call, which calls
>      nfs4_unlock_deleg_lease() and passes fp->fi_deleg_file, which is
>      NULL (!!!), to vfs_setlease().
>   These three happened in a 200usec window.
>=20
>  What I imagine might be happening is that the nfsd_break_deleg_cb()
>  callback is called after destroy_delegation() has unhashed the deleg,
>  but before destroy_unhashed_delegation() gets called.
>=20

Ok, so a DELEGRETURN is racing with a lease break?

>  If nfsd_break_deleg_cb() is called before the unhash - and particularly
>  if nfsd_break_one_deleg()->nfsd4_run_cb() is called before, then the
>  unhash will disconnect the delegation from the recall list, and no
>  harm can be done.
>  Once vfs_setlease(F_UNLCK) is called, the callback can no longer be
>  called, so again no harm is possible.
>=20
>  Between these two is a race window.  The delegation can be put on the
>  recall list, but the deleg will be unhashed and put_deleg_file() will
>  have set fi_deleg_file to NULL - resulting in first WARNING and the
>  BUG.
>=20
>  I cannot see how the refcount_t warning can be generated ...  so maybe
>  I've missed something.
>=20
>  My proposed solution is to test delegation_hashed() while holding
>  fp->fi_lock in nfsd_break_deleg_cb().  If the delegation is locked, we
>  can safely schedule the recall.  If it isn't, then the lease is about
>  to be unlocked and there is no need to schedule anything.
>=20

I think you mean "If the delegation is hashed, we can safely schedule
the recall."

That sounds like it might be the right approach. Once we've unhashed the
stateid, I think we can safely assume that it's on its way out the door
and that we don't need to issue a recall.

>  I don't know this code at all well, so I thought it safest to ask for
>  comments before posting a proper patch.
>  I'm particularly curious to know if anyone has ideas about the refcount
>  overflow.  Corruption is unlikely as the deleg looked mostly OK and the
>  memory has been freed, but not reallocated (though it is possible it
>  was freed, reallocated, and freed again).
>  This wasn't a refcount_inc on a zero refcount - that gives a different
>  error.  I don't know what the refcount value was, it has already been
>  changed to the 'saturated' value - 0xc0000000.
>=20
>=20

That would be this, I think:

        else if (unlikely(old < 0 || old + i < 0))
                refcount_warn_saturate(r, REFCOUNT_ADD_OVF);

So the old or new value was < 0?

No idea how you get there though. I would think if we were leaking
delegations to that degree that we'd see leaked memory warnings when
shutting down nfsd.

>=20
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c5d199d7e6b4..e02d638df6be 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4822,8 +4822,10 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>  	fl->fl_break_time =3D 0;
> =20
>  	spin_lock(&fp->fi_lock);
> -	fp->fi_had_conflict =3D true;
> -	nfsd_break_one_deleg(dp);
> +	if (delegation_hashed(dp)) {
> +		fp->fi_had_conflict =3D true;
> +		nfsd_break_one_deleg(dp);
> +	}
>  	spin_unlock(&fp->fi_lock);
>  	return ret;
>  }
>=20
>=20

This looks reasonable to me.
--=20
Jeff Layton <jlayton@kernel.org>
