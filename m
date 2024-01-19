Return-Path: <linux-nfs+bounces-1202-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EF8322BE
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jan 2024 01:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86C0B2424C
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jan 2024 00:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4D3EC2;
	Fri, 19 Jan 2024 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gu4Dy2h5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kbW531uS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gu4Dy2h5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kbW531uS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCFB184E
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jan 2024 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625207; cv=none; b=NfJap8k0hZsdGTS9QDvy5tE9/SIGE1b0UBBZ0tAME4AYEOiKZNuLXKIUPHveKFJGTrVXL6HgZWJgxr9eLhUkX1uDs+YW7CqU66urYeM8fpxpcdVc5KXD3u+Uax2WoqxtA3VMQdN6L4bZnSBKXUKWsTHQSN9edjl0SmlbSrJCKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625207; c=relaxed/simple;
	bh=bi9AlNMS4AII5iBqb/mxm5j9cW+yI6yItrsuqCsngjQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bcmWqFQeM8DsrX/qtDalCekNrDPsHhauncxjXkNlLO05WcpEEOfg7+DJrWk3iity772cbU6gWznjdc4pamoKPZxJuYF/4mpHayAUgjNuklR7XfqqJZoKxMLLelAOjuPGw9GZoLtTjwsvanvpmO2I2Yo66y4f0/C9H2hkU0sxgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gu4Dy2h5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kbW531uS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gu4Dy2h5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kbW531uS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44D2B1FCF7;
	Fri, 19 Jan 2024 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705625203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of8N6RslNJkb+A1BDYa8leaFZ+8SW23gjAJImJd4r4g=;
	b=Gu4Dy2h51pwFSkinRcz4clcFqgO+wED2nFW4SVXXRxabVsg18WY5QKuaW03dUgK2NozRWI
	OptlRtcyfPp5xf+ogujWQpxPE4u7+uEPX2mPy7rXPckQtWB7Qqmdnd/K2cDJS1XUbPAGw0
	qJcx+kaGHOUmy8HsCaaOQlRZXovaEys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705625203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of8N6RslNJkb+A1BDYa8leaFZ+8SW23gjAJImJd4r4g=;
	b=kbW531uSTVVpSdGZ/MnoeE6OXYvNtYaa0aetQpy0GYpfg3Hn5hDRzNFqBKyN6EsPz7N+cS
	l56F9cHOzM9MjoBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705625203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of8N6RslNJkb+A1BDYa8leaFZ+8SW23gjAJImJd4r4g=;
	b=Gu4Dy2h51pwFSkinRcz4clcFqgO+wED2nFW4SVXXRxabVsg18WY5QKuaW03dUgK2NozRWI
	OptlRtcyfPp5xf+ogujWQpxPE4u7+uEPX2mPy7rXPckQtWB7Qqmdnd/K2cDJS1XUbPAGw0
	qJcx+kaGHOUmy8HsCaaOQlRZXovaEys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705625203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of8N6RslNJkb+A1BDYa8leaFZ+8SW23gjAJImJd4r4g=;
	b=kbW531uSTVVpSdGZ/MnoeE6OXYvNtYaa0aetQpy0GYpfg3Hn5hDRzNFqBKyN6EsPz7N+cS
	l56F9cHOzM9MjoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 170F7136F5;
	Fri, 19 Jan 2024 00:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vLrMLnDGqWWETQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 19 Jan 2024 00:46:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 05/11] nfsd: prepare for supporting admin-revocation of state
In-reply-to: <ZWOCFjELHrc7sTil@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>,
 <20231124002925.1816-6-neilb@suse.de>,
 <ZWOCFjELHrc7sTil@tissot.1015granger.net>
Date: Fri, 19 Jan 2024 11:46:37 +1100
Message-id: <170562519798.23031.12759107372096732722@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Mon, 27 Nov 2023, Chuck Lever wrote:
> On Fri, Nov 24, 2023 at 11:28:40AM +1100, NeilBrown wrote:
> > The NFSv4 protocol allows state to be revoked by the admin and has error
> > codes which allow this to be communicated to the client.
> >=20
> > This patch
> >  - introduces a new state-id status NFS4_STID_ADMIN_REVOKE
> >    which can be set on open, lock, or delegation state.
> >  - reports NFS4ERR_ADMIN_REVOKED when these are accessed
> >  - introduces a per-client counter of these states and returns
> >    SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
> >    Decrements this when freeing any admin-revoked state.
> >  - introduces stub code to find all interesting states for a given
> >    superblock so they can be revoked via the 'unlock_filesystem'
> >    file in /proc/fs/nfsd/
> >    No actual states are handled yet.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-
> >  fs/nfsd/nfsctl.c    |  1 +
> >  fs/nfsd/nfsd.h      |  1 +
> >  fs/nfsd/state.h     | 10 +++++++
> >  fs/nfsd/trace.h     |  3 +-
> >  5 files changed, 84 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index b9239f2ebc79..477a9e9aebbd 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1215,6 +1215,8 @@ nfs4_put_stid(struct nfs4_stid *s)
> >  		return;
> >  	}
> >  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > +	if (s->sc_status & NFS4_STID_ADMIN_REVOKED)
> > +		atomic_dec(&s->sc_client->cl_admin_revoked);
> >  	nfs4_free_cpntf_statelist(clp->net, s);
> >  	spin_unlock(&clp->cl_lock);
> >  	s->sc_free(s);
> > @@ -1534,6 +1536,8 @@ static void put_ol_stateid_locked(struct nfs4_ol_st=
ateid *stp,
> >  	}
> > =20
> >  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > +	if (s->sc_status & NFS4_STID_ADMIN_REVOKED)
> > +		atomic_dec(&s->sc_client->cl_admin_revoked);
> >  	list_add(&stp->st_locks, reaplist);
> >  }
> > =20
> > @@ -1679,6 +1683,54 @@ static void release_openowner(struct nfs4_openowne=
r *oo)
> >  	nfs4_put_stateowner(&oo->oo_owner);
> >  }
> > =20
> > +static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
> > +					  struct super_block *sb,
> > +					  unsigned int sc_types)
> > +{
> > +	unsigned long id, tmp;
> > +	struct nfs4_stid *stid;
> > +
> > +	spin_lock(&clp->cl_lock);
> > +	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> > +		if ((stid->sc_type & sc_types) &&
> > +		    stid->sc_status =3D=3D 0 &&
> > +		    stid->sc_file->fi_inode->i_sb =3D=3D sb) {
> > +			refcount_inc(&stid->sc_count);
> > +			break;
> > +		}
> > +	spin_unlock(&clp->cl_lock);
> > +	return stid;
> > +}
> > +
>=20
> nfsd4_revoke_states() needs a kdoc comment.

Done.

>=20
>=20
> > +void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	unsigned int idhashval;
> > +	unsigned int sc_types;
> > +
> > +	sc_types =3D 0;
> > +
> > +	spin_lock(&nn->client_lock);
> > +	for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> > +		struct list_head *head =3D &nn->conf_id_hashtbl[idhashval];
> > +		struct nfs4_client *clp;
> > +	retry:
> > +		list_for_each_entry(clp, head, cl_idhash) {
> > +			struct nfs4_stid *stid =3D find_one_sb_stid(clp, sb,
> > +								  sc_types);
> > +			if (stid) {
> > +				spin_unlock(&nn->client_lock);
> > +				switch (stid->sc_type) {
>=20
> This is "dead" code, for now. Does this stub really need to be
> introduced in this patch?

"need" is a strong word..
The entire patch is "dead" code.  I want to allow handling for the
different state types to be added one at a time.  I could delay much of
this patch until handling the first state, but I think that would hurt
reviewability of the series...

>=20
>=20
> > +				}
> > +				nfs4_put_stid(stid);
> > +				spin_lock(&nn->client_lock);
> > +				goto retry;
> > +			}
> > +		}
> > +	}
> > +	spin_unlock(&nn->client_lock);
> > +}
> > +
> >  static inline int
> >  hash_sessionid(struct nfs4_sessionid *sessionid)
> >  {
> > @@ -2550,6 +2602,8 @@ static int client_info_show(struct seq_file *m, voi=
d *v)
> >  	}
> >  	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
> >  	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
> > +	seq_printf(m, "admin-revoked states: %d\n",
> > +		   atomic_read(&clp->cl_admin_revoked));
> >  	drop_client(clp);
> > =20
> >  	return 0;
> > @@ -4109,6 +4163,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> >  	}
> >  	if (!list_empty(&clp->cl_revoked))
> >  		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> > +	if (atomic_read(&clp->cl_admin_revoked))
> > +		seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
> >  out_no_session:
> >  	if (conn)
> >  		free_conn(conn);
> > @@ -4597,7 +4653,9 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
> >  {
> >  	__be32 ret =3D nfs_ok;
> > =20
> > -	if (s->sc_status & NFS4_STID_REVOKED)
> > +	if (s->sc_status & NFS4_STID_ADMIN_REVOKED)
> > +		ret =3D nfserr_admin_revoked;
> > +	else if (s->sc_status & NFS4_STID_REVOKED)
> >  		ret =3D nfserr_deleg_revoked;
> >  	else if (s->sc_status & NFS4_STID_CLOSED)
> >  		ret =3D nfserr_bad_stateid;
> > @@ -5188,6 +5246,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nf=
sd4_open *open,
> >  	deleg =3D find_deleg_stateid(cl, &open->op_delegate_stateid);
> >  	if (deleg =3D=3D NULL)
> >  		goto out;
> > +	if (deleg->dl_stid.sc_status & NFS4_STID_ADMIN_REVOKED) {
> > +		nfs4_put_stid(&deleg->dl_stid);
> > +		status =3D nfserr_admin_revoked;
> > +		goto out;
> > +	}
> >  	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
> >  		nfs4_put_stid(&deleg->dl_stid);
> >  		status =3D nfserr_deleg_revoked;
> > @@ -6508,6 +6571,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *c=
state,
> >  		 */
> >  		statusmask |=3D NFS4_STID_REVOKED;
> > =20
> > +	statusmask |=3D NFS4_STID_ADMIN_REVOKED;
> > +
> >  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> >  		CLOSE_STATEID(stateid))
> >  		return nfserr_bad_stateid;
> > @@ -6526,6 +6591,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *=
cstate,
> >  		nfs4_put_stid(stid);
> >  		return nfserr_deleg_revoked;
> >  	}
> > +	if (stid->sc_type & NFS4_STID_ADMIN_REVOKED) {
> > +		nfs4_put_stid(stid);
> > +		return nfserr_admin_revoked;
> > +	}
> >  	*s =3D stid;
> >  	return nfs_ok;
> >  }
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index d6eeee149370..a622d773f428 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -285,6 +285,7 @@ static ssize_t write_unlock_fs(struct file *file, cha=
r *buf, size_t size)
> >  	 * 3.  Is that directory the root of an exported file system?
> >  	 */
> >  	error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> > +	nfsd4_revoke_states(netns(file), path.dentry->d_sb);
> > =20
> >  	path_put(&path);
> >  	return error;
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index f5ff42f41ee7..d46203eac3c8 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -280,6 +280,7 @@ void		nfsd_lockd_shutdown(void);
> >  #define	nfserr_no_grace		cpu_to_be32(NFSERR_NO_GRACE)
> >  #define	nfserr_reclaim_bad	cpu_to_be32(NFSERR_RECLAIM_BAD)
> >  #define	nfserr_badname		cpu_to_be32(NFSERR_BADNAME)
> > +#define	nfserr_admin_revoked	cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
> >  #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
> >  #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
> >  #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index bb00dcd4c1ba..584378c43e0a 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -112,6 +112,7 @@ struct nfs4_stid {
> >  #define NFS4_STID_CLOSED	BIT(0)
> >  /* For a deleg stateid kept around only to process free_stateid's: */
> >  #define NFS4_STID_REVOKED	BIT(1)
> > +#define NFS4_STID_ADMIN_REVOKED	BIT(2)
>=20
> The names of these mask bits are now getting to be visually
> indistinguishable from the stateid type names. The subtlety of
> where the _STID_ falls in the name makes me blink a few times when
> reading this code.
>=20
> It would be a little more friendly to add _STATUS_ or some other
> infix that makes it easy to tell these are not stateid types. I
> know that makes the names longer and more unwieldy.

In an ideal world we could have just the words that 'trace' reports:

 OPEN LOCK DELEG LAYOUT   and CLOSED REVOKED ADMIN_REVOKED

and the language would tell us if the flag was not compatible with the
field it was stored in.  But C does not provide that world so we need
something help the reader assess consistency.

Do we really need NFS4 here?  These flags are local to nfsd/nfs4* (and
state.h and trace.h)

The values are stored in "sc_type" or "sc_status" (and occasionally
typemask or similar).  So

 TYPE_OPEN TYPE_DELETE TYPE_LAYOUT and STATUS_CLOSED STATUS_REVOKED STATUS_AD=
MIN_REVOKED

would be sufficiently informative for the reader.  Putting "NFS4_STID_"
in front of each of those makes them unwieldy as you say, and doesn't add
any value that I can see.  Possibly putting "SC_" in front to match the
field name could be justified.

Thoughts?

Thanks,
NeilBrown

