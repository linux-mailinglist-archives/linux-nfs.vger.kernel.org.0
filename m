Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77EC7F0975
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 23:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjKSWg4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 17:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjKSWg4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 17:36:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827FA137
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 14:36:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20449218EA;
        Sun, 19 Nov 2023 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700433411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoLhogCbUPbV3QR7cDgeU6EMhEutQ6Q1A7Q6TV3FlQY=;
        b=BZtg6ap+5BPIpgTX/27LkKyB/kjGE76bx+bgdOh9VaDgHfVd1kLigGUDrE51xD2oXiZgR4
        ZBfV8Gm78cIwWvqoXzBZXpMAlkGioVzgI1EDozqplCtkGEkqC9X3rVkiogDf9BzirWdNw+
        tIUYMOTN1+rFOW0HHtPFimEyj6PzvcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700433411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoLhogCbUPbV3QR7cDgeU6EMhEutQ6Q1A7Q6TV3FlQY=;
        b=0I1B3czfwyQAfY9sjKOVJQhcWEYMFfaRURKpRgAyNxfOSWc+MEyrcYJuvGwxkR+tbOPNd3
        z5kP5nXwj2qolDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBFC7139B7;
        Sun, 19 Nov 2023 22:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T/tGIwCOWmXWXwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Nov 2023 22:36:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 5/9] nfsd: allow admin-revoked state to appear in
 /proc/fs/nfsd/clients/*/states
In-reply-to: <ced58cba1234c662ddf7cfeaef5ce4b1a702dcfa.camel@kernel.org>
References: <20231117022121.23310-1-neilb@suse.de>,
 <20231117022121.23310-6-neilb@suse.de>,
 <ced58cba1234c662ddf7cfeaef5ce4b1a702dcfa.camel@kernel.org>
Date:   Mon, 20 Nov 2023 09:36:45 +1100
Message-id: <170043340577.19300.13599388686680253695@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 3.40
X-Spamd-Result: default: False [3.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[0.999];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 17 Nov 2023, Jeff Layton wrote:
> On Fri, 2023-11-17 at 13:18 +1100, NeilBrown wrote:
> > Change the "show" functions to show some content even if a file cannot
> > be found.
> > This is primarily useful for debugging - to ensure states are being
> > removed eventually.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 81 +++++++++++++++++++++++----------------------
> >  1 file changed, 41 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index a2b3320a6ba8..8debd148840f 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2680,17 +2680,10 @@ static int nfs4_show_open(struct seq_file *s, str=
uct nfs4_stid *st)
> >  	struct nfs4_stateowner *oo;
> >  	unsigned int access, deny;
> > =20
> > -	if (st->sc_type !=3D NFS4_OPEN_STID && st->sc_type !=3D NFS4_LOCK_STID)
> > -		return 0; /* XXX: or SEQ_SKIP? */
> >  	ols =3D openlockstateid(st);
> >  	oo =3D ols->st_stateowner;
> >  	nf =3D st->sc_file;
> > =20
> > -	spin_lock(&nf->fi_lock);
> > -	file =3D find_any_file_locked(nf);
> > -	if (!file)
> > -		goto out;
> > -
> >  	seq_printf(s, "- ");
> >  	nfs4_show_stateid(s, &st->sc_stateid);
> >  	seq_printf(s, ": { type: open, ");
> > @@ -2705,14 +2698,19 @@ static int nfs4_show_open(struct seq_file *s, str=
uct nfs4_stid *st)
> >  		deny & NFS4_SHARE_ACCESS_READ ? "r" : "-",
> >  		deny & NFS4_SHARE_ACCESS_WRITE ? "w" : "-");
> > =20
> > -	nfs4_show_superblock(s, file);
> > -	seq_printf(s, ", ");
> > -	nfs4_show_fname(s, file);
> > -	seq_printf(s, ", ");
> > +	spin_lock(&nf->fi_lock);
> > +	file =3D find_any_file_locked(nf);
> > +	if (file) {
> > +		nfs4_show_superblock(s, file);
> > +		seq_puts(s, ", ");
> > +		nfs4_show_fname(s, file);
> > +		seq_puts(s, ", ");
> > +	}
> > +	spin_unlock(&nf->fi_lock);
> >  	nfs4_show_owner(s, oo);
> > +	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
> > +		seq_puts(s, ", admin-revoked");
> >  	seq_printf(s, " }\n");
> > -out:
> > -	spin_unlock(&nf->fi_lock);
> >  	return 0;
> >  }
> > =20
> > @@ -2726,30 +2724,31 @@ static int nfs4_show_lock(struct seq_file *s, str=
uct nfs4_stid *st)
> >  	ols =3D openlockstateid(st);
> >  	oo =3D ols->st_stateowner;
> >  	nf =3D st->sc_file;
> > -	spin_lock(&nf->fi_lock);
> > -	file =3D find_any_file_locked(nf);
> > -	if (!file)
> > -		goto out;
> > =20
> >  	seq_printf(s, "- ");
> >  	nfs4_show_stateid(s, &st->sc_stateid);
> >  	seq_printf(s, ": { type: lock, ");
> > =20
> > -	/*
> > -	 * Note: a lock stateid isn't really the same thing as a lock,
> > -	 * it's the locking state held by one owner on a file, and there
> > -	 * may be multiple (or no) lock ranges associated with it.
> > -	 * (Same for the matter is true of open stateids.)
> > -	 */
> > +	spin_lock(&nf->fi_lock);
> > +	file =3D find_any_file_locked(nf);
> > +	if (file) {
> > +		/*
> > +		 * Note: a lock stateid isn't really the same thing as a lock,
> > +		 * it's the locking state held by one owner on a file, and there
> > +		 * may be multiple (or no) lock ranges associated with it.
> > +		 * (Same for the matter is true of open stateids.)
> > +		 */
> > =20
> > -	nfs4_show_superblock(s, file);
> > -	/* XXX: open stateid? */
> > -	seq_printf(s, ", ");
> > -	nfs4_show_fname(s, file);
> > -	seq_printf(s, ", ");
> > +		nfs4_show_superblock(s, file);
> > +		/* XXX: open stateid? */
> > +		seq_puts(s, ", ");
> > +		nfs4_show_fname(s, file);
> > +		seq_puts(s, ", ");
> > +	}
> >  	nfs4_show_owner(s, oo);
> > +	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
> > +		seq_puts(s, ", admin-revoked");
> >  	seq_printf(s, " }\n");
> > -out:
> >  	spin_unlock(&nf->fi_lock);
> >  	return 0;
> >  }
> > @@ -2762,27 +2761,29 @@ static int nfs4_show_deleg(struct seq_file *s, st=
ruct nfs4_stid *st)
> > =20
> >  	ds =3D delegstateid(st);
> >  	nf =3D st->sc_file;
> > -	spin_lock(&nf->fi_lock);
> > -	file =3D nf->fi_deleg_file;
> > -	if (!file)
> > -		goto out;
> > =20
> >  	seq_printf(s, "- ");
> >  	nfs4_show_stateid(s, &st->sc_stateid);
> >  	seq_printf(s, ": { type: deleg, ");
> > =20
> >  	/* Kinda dead code as long as we only support read delegs: */
>=20
> nit: You can probably remove the above comment since we now support
> write delegations.

Done.  Thanks for the suggestion.

NeilBrown


>=20
> > -	seq_printf(s, "access: %s, ",
> > -		ds->dl_type =3D=3D NFS4_OPEN_DELEGATE_READ ? "r" : "w");
> > +	seq_printf(s, "access: %s",
> > +		   ds->dl_type =3D=3D NFS4_OPEN_DELEGATE_READ ? "r" : "w");
> > =20
> >  	/* XXX: lease time, whether it's being recalled. */
> > =20
> > -	nfs4_show_superblock(s, file);
> > -	seq_printf(s, ", ");
> > -	nfs4_show_fname(s, file);
> > -	seq_printf(s, " }\n");
> > -out:
> > +	spin_lock(&nf->fi_lock);
> > +	file =3D nf->fi_deleg_file;
> > +	if (file) {
> > +		seq_puts(s, ", ");
> > +		nfs4_show_superblock(s, file);
> > +		seq_puts(s, ", ");
> > +		nfs4_show_fname(s, file);
> > +	}
> >  	spin_unlock(&nf->fi_lock);
> > +	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
> > +		seq_puts(s, ", admin-revoked");
> > +	seq_puts(s, " }\n");
> >  	return 0;
> >  }
> > =20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

