Return-Path: <linux-nfs+bounces-7917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6930B9C65FF
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 01:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5352DB28229
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637B9A50;
	Wed, 13 Nov 2024 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bvtG1ARr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tOUZFN+r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bvtG1ARr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tOUZFN+r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03AEEC4;
	Wed, 13 Nov 2024 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456488; cv=none; b=evHnYeZi3Tr6qDPl21y2iL4xYjVAC19k5vzteSqvQ49qTZLu6EnI0oQ4RPQJ0hH+N249OE/WpR756ZrXSaRQaMIvIY8fazvJWIUTmJ98CJ4OGXtD0FxEpXYxNH3RCnoknXXyvDtGWCot3MQJcSEb5iAgKRPxv/1Bgr2jQgbwsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456488; c=relaxed/simple;
	bh=BP63WwkAq744E+f3FsCRS3c7Mxd6uhE93x5UpBecwXI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Nc9NWEOkiLcseKpGSlSwE1jKU6p2HP/CAvPzwQWPWzNydig+Xv9Xyil3SDBbjhJy0y11i9Hz5q1Y0L8vEFmvMyzfF/VqClbvMrhdbBwvGlw+ypLsJD+G41e5Mh4BFX7zkBIGYsYYIs/ogbliJbMrEnlb1QdBmyWE1xrwkN12N0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bvtG1ARr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tOUZFN+r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bvtG1ARr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tOUZFN+r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2942B21223;
	Wed, 13 Nov 2024 00:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731456484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAJV6E58xdLYEcrSTKs3jbVQZe6BiifmVMXDfnTLudc=;
	b=bvtG1ARre1EYE2ewHYY0PLd9kLmtcEl0b/Lva1jhnaeuWnChjkBVv8pW5eXMN7MzhAStpe
	xHRh6O/y1CpQkyMjeW9ng39xlmSUZDBmLK4A7QgBHYUdI+Ux47N17X/za1k3H2v+ss5OYo
	mJXsVUudpU2NrtRd2HqYQlqIq5TzBNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731456484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAJV6E58xdLYEcrSTKs3jbVQZe6BiifmVMXDfnTLudc=;
	b=tOUZFN+rYN4ZoihLPYAjryMW4DGhvCExSfrtvdZ6y5/y1n31vEp7e/4cKzvMj6r2r8dhdI
	73J1o4V9i+95HWDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731456484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAJV6E58xdLYEcrSTKs3jbVQZe6BiifmVMXDfnTLudc=;
	b=bvtG1ARre1EYE2ewHYY0PLd9kLmtcEl0b/Lva1jhnaeuWnChjkBVv8pW5eXMN7MzhAStpe
	xHRh6O/y1CpQkyMjeW9ng39xlmSUZDBmLK4A7QgBHYUdI+Ux47N17X/za1k3H2v+ss5OYo
	mJXsVUudpU2NrtRd2HqYQlqIq5TzBNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731456484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAJV6E58xdLYEcrSTKs3jbVQZe6BiifmVMXDfnTLudc=;
	b=tOUZFN+rYN4ZoihLPYAjryMW4DGhvCExSfrtvdZ6y5/y1n31vEp7e/4cKzvMj6r2r8dhdI
	73J1o4V9i+95HWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8040313794;
	Wed, 13 Nov 2024 00:08:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d1x+DeHtM2cWIQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Nov 2024 00:08:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Olga Kornievskaia" <okorniev@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
In-reply-to: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org>
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org>
Date: Wed, 13 Nov 2024 11:07:58 +1100
Message-id: <173145647827.1734440.229098670256873443@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 06 Nov 2024, Jeff Layton wrote:
> nfsd currently only uses a single slot in the callback channel, which is
> proving to be a bottleneck in some cases. Widen the callback channel to
> a max of 32 slots (subject to the client's target_maxreqs value).
>=20
> Change the cb_holds_slot boolean to an integer that tracks the current
> slot number (with -1 meaning "unassigned").  Move the callback slot
> tracking info into the session. Add a new u32 that acts as a bitmap to
> track which slots are in use, and a u32 to track the latest callback
> target_slotid that the client reports. To protect the new fields, add
> a new per-session spinlock (the se_lock). Fix nfsd41_cb_get_slot to always
> search for the lowest slotid (using ffs()).
>=20
> Finally, convert the session->se_cb_seq_nr field into an array of
> counters and add the necessary handling to ensure that the seqids get
> reset at the appropriate times.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> v3 has a bug that Olga hit in testing. This version should fix the wait
> when the slot table is full. Olga, if you're able to test this one, it
> would be much appreciated.
> ---
> Changes in v4:
> - Fix the wait for a slot in nfsd41_cb_get_slot()
> - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-0-c2df49a26c45@k=
ernel.org
>=20
> Changes in v3:
> - add patch to convert se_flags to single se_dead bool
> - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> - don't reject target highest slot value of 0
> - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6ef55d@k=
ernel.org
>=20
> Changes in v2:
> - take cl_lock when fetching fields from session to be encoded
> - use fls() instead of bespoke highest_unset_index()
> - rename variables in several functions with more descriptive names
> - clamp limit of for loop in update_cb_slot_table()
> - re-add missing rpc_wake_up_queued_task() call
> - fix slotid check in decode_cb_sequence4resok()
> - add new per-session spinlock
> ---
>  fs/nfsd/nfs4callback.c | 113 ++++++++++++++++++++++++++++++++++++---------=
----
>  fs/nfsd/nfs4state.c    |  11 +++--
>  fs/nfsd/state.h        |  15 ++++---
>  fs/nfsd/trace.h        |   2 +-
>  4 files changed, 101 insertions(+), 40 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a678333907eaa92db305dada5=
03704c34c15b2 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct =
nfs4_cb_compound_hdr *hdr,
>  	hdr->nops++;
>  }
> =20
> +static u32 highest_slotid(struct nfsd4_session *ses)
> +{
> +	u32 idx;
> +
> +	spin_lock(&ses->se_lock);
> +	idx =3D fls(~ses->se_cb_slot_avail);
> +	if (idx > 0)
> +		--idx;
> +	idx =3D max(idx, ses->se_cb_highest_slot);
> +	spin_unlock(&ses->se_lock);
> +	return idx;
> +}
> +
>  /*
>   * CB_SEQUENCE4args
>   *
> @@ -432,15 +445,35 @@ static void encode_cb_sequence4args(struct xdr_stream=
 *xdr,
>  	encode_sessionid4(xdr, session);
> =20
>  	p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> -	*p++ =3D cpu_to_be32(session->se_cb_seq_nr);	/* csa_sequenceid */
> -	*p++ =3D xdr_zero;			/* csa_slotid */
> -	*p++ =3D xdr_zero;			/* csa_highest_slotid */
> +	*p++ =3D cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);	/* csa_seq=
uenceid */
> +	*p++ =3D cpu_to_be32(cb->cb_held_slot);		/* csa_slotid */
> +	*p++ =3D cpu_to_be32(highest_slotid(session)); /* csa_highest_slotid */
>  	*p++ =3D xdr_zero;			/* csa_cachethis */
>  	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
> =20
>  	hdr->nops++;
>  }
> =20
> +static void update_cb_slot_table(struct nfsd4_session *ses, u32 target)
> +{
> +	/* No need to do anything if nothing changed */
> +	if (likely(target =3D=3D READ_ONCE(ses->se_cb_highest_slot)))
> +		return;
> +
> +	spin_lock(&ses->se_lock);
> +	if (target > ses->se_cb_highest_slot) {
> +		int i;
> +
> +		target =3D min(target, NFSD_BC_SLOT_TABLE_MAX);
> +
> +		/* Growing the slot table. Reset any new sequences to 1 */
> +		for (i =3D ses->se_cb_highest_slot + 1; i <=3D target; ++i)
> +			ses->se_cb_seq_nr[i] =3D 1;

Where is the justification in the RFC for resetting the sequence
numbers?

The csr_target_highest_slotid from the client - which is the value passed as
'target' is defined as:

   the highest slot ID the client would prefer the server use on a
   future CB_SEQUENCE operation.=20

This is not "the highest slot ID for which the client is remembering
sequence numbers".

If we can get rid of this, then I think the need for se_lock evaporates.
Allocating a new slow would be

do {
 idx =3D ffs(ses->se_cb_slot_avail) - 1;
} while (is_valid(idx) && test_and_set_bit(idx, &ses->se_sb_slot_avail));
=20
where is_valid(idX) is idx >=3D 0 && idx <=3D ses->se_sb_highest_slot


> +	}
> +	ses->se_cb_highest_slot =3D target;
> +	spin_unlock(&ses->se_lock);
> +}
> +
>  /*
>   * CB_SEQUENCE4resok
>   *
> @@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(struct xdr_stream *=
xdr,
>  	struct nfsd4_session *session =3D cb->cb_clp->cl_cb_session;
>  	int status =3D -ESERVERFAULT;
>  	__be32 *p;
> -	u32 dummy;
> +	u32 seqid, slotid, target;
> =20
>  	/*
>  	 * If the server returns different values for sessionID, slotID or
> @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(struct xdr_stream=
 *xdr,
>  	}
>  	p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> =20
> -	dummy =3D be32_to_cpup(p++);
> -	if (dummy !=3D session->se_cb_seq_nr) {
> +	seqid =3D be32_to_cpup(p++);
> +	if (seqid !=3D session->se_cb_seq_nr[cb->cb_held_slot]) {
>  		dprintk("NFS: %s Invalid sequence number\n", __func__);
>  		goto out;
>  	}
> =20
> -	dummy =3D be32_to_cpup(p++);
> -	if (dummy !=3D 0) {
> +	slotid =3D be32_to_cpup(p++);
> +	if (slotid !=3D cb->cb_held_slot) {
>  		dprintk("NFS: %s Invalid slotid\n", __func__);
>  		goto out;
>  	}
> =20
> -	/*
> -	 * FIXME: process highest slotid and target highest slotid
> -	 */
> +	p++; // ignore current highest slot value
> +
> +	target =3D be32_to_cpup(p++);
> +	update_cb_slot_table(session, target);
>  	status =3D 0;
>  out:
>  	cb->cb_seq_status =3D status;
> @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nfs4_client *clp, =
struct nfs4_cb_conn *conn)
>  	spin_unlock(&clp->cl_lock);
>  }
> =20
> +static int grab_slot(struct nfsd4_session *ses)
> +{
> +	int idx;
> +
> +	spin_lock(&ses->se_lock);
> +	idx =3D ffs(ses->se_cb_slot_avail) - 1;
> +	if (idx < 0 || idx > ses->se_cb_highest_slot) {
> +		spin_unlock(&ses->se_lock);
> +		return -1;
> +	}
> +	/* clear the bit for the slot */
> +	ses->se_cb_slot_avail &=3D ~BIT(idx);
> +	spin_unlock(&ses->se_lock);
> +	return idx;
> +}
> +
>  /*
>   * There's currently a single callback channel slot.
>   * If the slot is available, then mark it busy.  Otherwise, set the
> @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct nfs4_client *clp,=
 struct nfs4_cb_conn *conn)
>  static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task =
*task)
>  {
>  	struct nfs4_client *clp =3D cb->cb_clp;
> +	struct nfsd4_session *ses =3D clp->cl_cb_session;
> =20
> -	if (!cb->cb_holds_slot &&
> -	    test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
> +	if (cb->cb_held_slot >=3D 0)
> +		return true;
> +	cb->cb_held_slot =3D grab_slot(ses);
> +	if (cb->cb_held_slot < 0) {
>  		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
>  		/* Race breaker */
> -		if (test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
> -			dprintk("%s slot is busy\n", __func__);
> +		cb->cb_held_slot =3D grab_slot(ses);
> +		if (cb->cb_held_slot < 0)
>  			return false;
> -		}
>  		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
>  	}
> -	cb->cb_holds_slot =3D true;
>  	return true;
>  }
> =20
>  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
>  {
>  	struct nfs4_client *clp =3D cb->cb_clp;
> +	struct nfsd4_session *ses =3D clp->cl_cb_session;
> =20
> -	if (cb->cb_holds_slot) {
> -		cb->cb_holds_slot =3D false;
> -		clear_bit(0, &clp->cl_cb_slot_busy);
> +	if (cb->cb_held_slot >=3D 0) {
> +		spin_lock(&ses->se_lock);
> +		ses->se_cb_slot_avail |=3D BIT(cb->cb_held_slot);
> +		spin_unlock(&ses->se_lock);
> +		cb->cb_held_slot =3D -1;
>  		rpc_wake_up_next(&clp->cl_cb_waitq);
>  	}
>  }
> @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *=
cb)
>  }
> =20
>  /*
> - * TODO: cb_sequence should support referring call lists, cachethis, multi=
ple
> - * slots, and mark callback channel down on communication errors.
> + * TODO: cb_sequence should support referring call lists, cachethis,
> + * and mark callback channel down on communication errors.
>   */
>  static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
>  {
> @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *t=
ask, struct nfsd4_callback
>  		return true;
>  	}
> =20
> -	if (!cb->cb_holds_slot)
> +	if (cb->cb_held_slot < 0)
>  		goto need_restart;
> =20
>  	/* This is the operation status code for CB_SEQUENCE */
> @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task =
*task, struct nfsd4_callback
>  		 * If CB_SEQUENCE returns an error, then the state of the slot
>  		 * (sequence ID, cached reply) MUST NOT change.
>  		 */
> -		++session->se_cb_seq_nr;
> +		++session->se_cb_seq_nr[cb->cb_held_slot];
>  		break;
>  	case -ESERVERFAULT:
> -		++session->se_cb_seq_nr;
> +		++session->se_cb_seq_nr[cb->cb_held_slot];
>  		nfsd4_mark_cb_fault(cb->cb_clp);
>  		ret =3D false;
>  		break;
> @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task =
*task, struct nfsd4_callback
>  	case -NFS4ERR_BADSLOT:
>  		goto retry_nowait;
>  	case -NFS4ERR_SEQ_MISORDERED:
> -		if (session->se_cb_seq_nr !=3D 1) {
> -			session->se_cb_seq_nr =3D 1;
> +		if (session->se_cb_seq_nr[cb->cb_held_slot] !=3D 1) {
> +			session->se_cb_seq_nr[cb->cb_held_slot] =3D 1;

This is weird ...  why do we reset the seq_nr to 1 when we get
SEQ_MISORDERED??  Git logs don't shed any light :-(


>  			goto retry_nowait;
>  		}
>  		break;
>  	default:
>  		nfsd4_mark_cb_fault(cb->cb_clp);
>  	}
> -	nfsd41_cb_release_slot(cb);
> -
>  	trace_nfsd_cb_free_slot(task, cb);
> +	nfsd41_cb_release_slot(cb);
> =20
>  	if (RPC_SIGNALLED(task))
>  		goto need_restart;
> @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct =
nfs4_client *clp,
>  	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
>  	cb->cb_status =3D 0;
>  	cb->cb_need_restart =3D false;
> -	cb->cb_holds_slot =3D false;
> +	cb->cb_held_slot =3D -1;
>  }
> =20
>  /**
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc9265517f51952563be=
aa4cfe8adcc3f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_session(struct nfs=
d4_channel_attrs *fattrs,
>  	}
> =20
>  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> +	new->se_cb_slot_avail =3D ~0U;
> +	new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> +	spin_lock_init(&new->se_lock);
>  	return new;
>  out_free:
>  	while (i--)
> @@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *rqstp, st=
ruct nfsd4_session *new, stru
> =20
>  	INIT_LIST_HEAD(&new->se_conns);
> =20
> -	new->se_cb_seq_nr =3D 1;
> +	atomic_set(&new->se_ref, 0);
>  	new->se_dead =3D false;
>  	new->se_cb_prog =3D cses->callback_prog;
>  	new->se_cb_sec =3D cses->cb_sec;
> -	atomic_set(&new->se_ref, 0);
> +
> +	for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> +		new->se_cb_seq_nr[idx] =3D 1;

That should be "<=3D NFSD_BC_SLOT_TABLE_MAX"

I don't think *_MAX is a good choice of name.  It is the maximum number
of slots (no) or the maximum slot number (yes).
I think *_SIZE would be a better name - the size of the table that we
allocate. 32.
Looking at where the const is used in current nfsd-next:

		target =3D min(target, NFSD_BC_SLOT_TABLE_SIZE - 1

	new->se_cb_highest_slot =3D min(battrs->maxreqs,
				      NFSD_BC_SLOT_TABLE_SIZE) - 1;

	for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_SIZE; ++idx)

#define NFSD_BC_SLOT_TABLE_SIZE	(sizeof(u32) * 8)

	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];

which is a slight reduction in the number of "+/-1" adjustments.




> +
>  	idx =3D hash_sessionid(&new->se_sessionid);
>  	list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]);
>  	spin_lock(&clp->cl_lock);
> @@ -3159,7 +3165,6 @@ static struct nfs4_client *create_client(struct xdr_n=
etobj name,
>  	kref_init(&clp->cl_nfsdfs.cl_ref);
>  	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
>  	clp->cl_time =3D ktime_get_boottime_seconds();
> -	clear_bit(0, &clp->cl_cb_slot_busy);
>  	copy_verf(clp, verf);
>  	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
>  	clp->cl_cb_session =3D NULL;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb308f0b69916c4ee34b=
09075708f0de3 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -71,8 +71,8 @@ struct nfsd4_callback {
>  	struct work_struct cb_work;
>  	int cb_seq_status;
>  	int cb_status;
> +	int cb_held_slot;
>  	bool cb_need_restart;
> -	bool cb_holds_slot;
>  };
> =20
>  struct nfsd4_callback_ops {
> @@ -307,6 +307,9 @@ struct nfsd4_conn {
>  	unsigned char cn_flags;
>  };
> =20
> +/* Highest slot index that nfsd implements in NFSv4.1+ backchannel */
> +#define NFSD_BC_SLOT_TABLE_MAX	(sizeof(u32) * 8 - 1)
> +
>  /*
>   * Representation of a v4.1+ session. These are refcounted in a similar fa=
shion
>   * to the nfs4_client. References are only taken when the server is active=
ly
> @@ -314,6 +317,10 @@ struct nfsd4_conn {
>   */
>  struct nfsd4_session {
>  	atomic_t		se_ref;
> +	spinlock_t		se_lock;
> +	u32			se_cb_slot_avail; /* bitmap of available slots */
> +	u32			se_cb_highest_slot;	/* highest slot client wants */
> +	u32			se_cb_prog;
>  	bool			se_dead;
>  	struct list_head	se_hash;	/* hash by sessionid */
>  	struct list_head	se_perclnt;
> @@ -322,8 +329,7 @@ struct nfsd4_session {
>  	struct nfsd4_channel_attrs se_fchannel;
>  	struct nfsd4_cb_sec	se_cb_sec;
>  	struct list_head	se_conns;
> -	u32			se_cb_prog;
> -	u32			se_cb_seq_nr;
> +	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX + 1];
>  	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
>  };
> =20
> @@ -457,9 +463,6 @@ struct nfs4_client {
>  	 */
>  	struct dentry		*cl_nfsd_info_dentry;
> =20
> -	/* for nfs41 callbacks */
> -	/* We currently support a single back channel with a single slot */
> -	unsigned long		cl_cb_slot_busy;
>  	struct rpc_wait_queue	cl_cb_waitq;	/* backchannel callers may */
>  						/* wait here for slots */
>  	struct net		*net;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index f318898cfc31614b5a84a4867e18c2b3a07122c9..a9c17186b6892f1df8d7f7b90e2=
50c2913ab23fe 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1697,7 +1697,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
>  		__entry->cl_id =3D sid->clientid.cl_id;
>  		__entry->seqno =3D sid->sequence;
>  		__entry->reserved =3D sid->reserved;
> -		__entry->slot_seqno =3D session->se_cb_seq_nr;
> +		__entry->slot_seqno =3D session->se_cb_seq_nr[cb->cb_held_slot];
>  	),
>  	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
>  		" sessionid=3D%08x:%08x:%08x:%08x new slot seqno=3D%u",
>=20
> ---
> base-commit: 3c16aac09d20f9005fbb0e737b3ec520bbb5badd
> change-id: 20241025-bcwide-6bd7e4b63db2
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

NeilBrown

