Return-Path: <linux-nfs+bounces-3796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C4907F1D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 00:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10921B239E0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 22:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D411411EE;
	Thu, 13 Jun 2024 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C7SzH5Mi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LpbHAbR7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C7SzH5Mi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LpbHAbR7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D514A4EB
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319380; cv=none; b=Vh3KzATSFiQ64WWqCE1w2vK/cxzZzP4aJIF4YYD0Fwzzw8MubcAKD6EkpDMr9TLfgHX23MZHng0OGKZ2JwaYwkQGDKr+SYOkRtW6jsl0AtYk22QvtCjtIsYIA1Ma7XTc+sx3FjJMQYJnu5KaPtE8TJSrmrN2lfE45cf4iD46TT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319380; c=relaxed/simple;
	bh=V/UESaRuqtQoHx7WqK2Nb5Ey+P61XMPC6vKB+p0Kodc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UgoFX+4Rd2l34mbuIFFVv2/EJJzobOosYagKcz4DlRewwKiYUfzcYwIXLW7xvqBFMXxMuFABxpX3U49QAswsgswM8nyPOdXRPEI9c88uAbFtRidtmlLueGhEmgoaaxU/TpcP1NOBYb/jMeTAxXmIFwlQVYE0qV8JfGZx++uKaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C7SzH5Mi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LpbHAbR7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C7SzH5Mi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LpbHAbR7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82B88221B5;
	Thu, 13 Jun 2024 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718319376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jQRwAEtQTxDmH+1cqtKF+znTJyrRf8LHkVOHYy7IiI=;
	b=C7SzH5MiPQ4C2TVtX00EGlU3VAgpbzCNAPLqf/4aTnf/wTxQlSxH9Z4G10T8gQHbmb17jF
	sojf0qD1HAD8QAs8FlkDJQK/YWu82MvDK5cRJV5TZOa0FCmFHkFtovMKtMz79Zne2kj3r8
	L2pVqCLdFnUgwnOhNxHhQLdFlmo/ZYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718319376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jQRwAEtQTxDmH+1cqtKF+znTJyrRf8LHkVOHYy7IiI=;
	b=LpbHAbR7tJiBwzPd0lVq6y3HsQAcuRdqypvKfqJX6DSVmQ7ZkvCB5eqTS7sj03JU/i9vRT
	1AvS04jQ07PxIjCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C7SzH5Mi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LpbHAbR7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718319376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jQRwAEtQTxDmH+1cqtKF+znTJyrRf8LHkVOHYy7IiI=;
	b=C7SzH5MiPQ4C2TVtX00EGlU3VAgpbzCNAPLqf/4aTnf/wTxQlSxH9Z4G10T8gQHbmb17jF
	sojf0qD1HAD8QAs8FlkDJQK/YWu82MvDK5cRJV5TZOa0FCmFHkFtovMKtMz79Zne2kj3r8
	L2pVqCLdFnUgwnOhNxHhQLdFlmo/ZYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718319376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jQRwAEtQTxDmH+1cqtKF+znTJyrRf8LHkVOHYy7IiI=;
	b=LpbHAbR7tJiBwzPd0lVq6y3HsQAcuRdqypvKfqJX6DSVmQ7ZkvCB5eqTS7sj03JU/i9vRT
	1AvS04jQ07PxIjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07B8C13A7F;
	Thu, 13 Jun 2024 22:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LOdOJw55a2Z0WAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 13 Jun 2024 22:56:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jan Kara" <jack@suse.cz>
Cc: "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 linux-nfs@vger.kernel.org, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH 3/3] nfs: Block on write congestion
In-reply-to: <20240613082821.849-3-jack@suse.cz>
References:
 <20240612153022.25454-1-jack@suse.cz>, <20240613082821.849-3-jack@suse.cz>
Date: Fri, 14 Jun 2024 08:56:10 +1000
Message-id: <171831937031.14261.6690155619843129747@noble.neil.brown.name>
X-Rspamd-Queue-Id: 82B88221B5
X-Spam-Score: -6.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 13 Jun 2024, Jan Kara wrote:
> Commit 6df25e58532b ("nfs: remove reliance on bdi congestion")
> introduced NFS-private solution for limiting number of writes
> outstanding against a particular server. Unlike previous bdi congestion
> this algorithm actually works and limits number of outstanding writeback
> pages to nfs_congestion_kb which scales with amount of client's memory
> and is capped at 256 MB. As a result some workloads such as random
> buffered writes over NFS got slower (from ~170 MB/s to ~126 MB/s). The
> fio command to reproduce is:
>=20
> fio --direct=3D0 --ioengine=3Dsync --thread --invalidate=3D1 --group_report=
ing=3D1
>   --runtime=3D300 --fallocate=3Dposix --ramp_time=3D10 --new_group --rw=3Dr=
andwrite
>   --size=3D64256m --numjobs=3D4 --bs=3D4k --fsync_on_close=3D1 --end_fsync=
=3D1
>=20
> This happens because the client sends ~256 MB worth of dirty pages to
> the server and any further background writeback request is ignored until
> the number of writeback pages gets below the threshold of 192 MB. By the
> time this happens and clients decides to trigger another round of
> writeback, the server often has no pages to write and the disk is idle.
>=20
> To fix this problem and make the client react faster to eased congestion
> of the server by blocking waiting for congestion to resolve instead of
> aborting writeback. This improves the random 4k buffered write
> throughput to 184 MB/s.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/nfs/client.c           |  1 +
>  fs/nfs/write.c            | 12 ++++++++----
>  include/linux/nfs_fs_sb.h |  1 +
>  3 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 3b252dceebf5..8286edd6062d 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -994,6 +994,7 @@ struct nfs_server *nfs_alloc_server(void)
> =20
>  	server->change_attr_type =3D NFS4_CHANGE_TYPE_IS_UNDEFINED;
> =20
> +	init_waitqueue_head(&server->write_congestion_wait);
>  	atomic_long_set(&server->writeback, 0);
> =20
>  	ida_init(&server->openowner_id);
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index c6255d7edd3c..21a5f1e90859 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -423,8 +423,10 @@ static void nfs_folio_end_writeback(struct folio *foli=
o)
> =20
>  	folio_end_writeback(folio);
>  	if (atomic_long_dec_return(&nfss->writeback) <
> -	    NFS_CONGESTION_OFF_THRESH)
> +	    NFS_CONGESTION_OFF_THRESH) {
>  		nfss->write_congested =3D 0;
> +		wake_up_all(&nfss->write_congestion_wait);
> +	}
>  }
> =20
>  static void nfs_page_end_writeback(struct nfs_page *req)
> @@ -698,12 +700,14 @@ int nfs_writepages(struct address_space *mapping, str=
uct writeback_control *wbc)
>  	struct nfs_pageio_descriptor pgio;
>  	struct nfs_io_completion *ioc =3D NULL;
>  	unsigned int mntflags =3D NFS_SERVER(inode)->flags;
> +	struct nfs_server *nfss =3D NFS_SERVER(inode);
>  	int priority =3D 0;
>  	int err;
> =20
> -	if (wbc->sync_mode =3D=3D WB_SYNC_NONE &&
> -	    NFS_SERVER(inode)->write_congested)
> -		return 0;
> +	/* Wait with writeback until write congestion eases */
> +	if (wbc->sync_mode =3D=3D WB_SYNC_NONE && nfss->write_congested)
> +		wait_event(nfss->write_congestion_wait,
> +			   nfss->write_congested =3D=3D 0);

If there is a network problem or the server reboot, this could wait
indefinitely.  Maybe wait_event_idle() ??

Is this only called from the writeback thread that is dedicated to this
fs?  If so that should be fine.  If it can be reached from a user
processes, then wait_event_killable() might be needed.

Thanks,
NeilBrown


> =20
>  	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
> =20
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 92de074e63b9..38a128796a76 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -140,6 +140,7 @@ struct nfs_server {
>  	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
>  	struct nlm_host		*nlm_host;	/* NLM client handle */
>  	struct nfs_iostats __percpu *io_stats;	/* I/O statistics */
> +	wait_queue_head_t	write_congestion_wait;	/* wait until write congestion e=
ases */
>  	atomic_long_t		writeback;	/* number of writeback pages */
>  	unsigned int		write_congested;/* flag set when writeback gets too high */
>  	unsigned int		flags;		/* various flags */
> --=20
> 2.35.3
>=20
>=20


