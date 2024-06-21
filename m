Return-Path: <linux-nfs+bounces-4212-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D35A911BDC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 08:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04581C209BB
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A3513C802;
	Fri, 21 Jun 2024 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mVF8LU91";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hql3Uf0Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mVF8LU91";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hql3Uf0Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A539FD0
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951723; cv=none; b=iXASZ88W8tKQUUXUDdkZ+SltdtTAbfNBz25gy0whrXtiSgJwgUCpJ/5K3xGAEd+LyK+yaTp+Ki1J2P8s+0HpVExDwgbYmEuFKACMw6vAJ/vVML+Pvn5pzpQsiTDuvR7wwXUhFjoXE6taqlxhI2HMVlYknGO2bY/vtkXNKMYreB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951723; c=relaxed/simple;
	bh=Fk+MyjyP2xyi/ozVD93CPA+87xJUPKMsM3JRxizwu1Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=k9h0qJ8YT3zamZ/mwmzwo958pb3Lp4oTE8vfOTLYizsFFbzo0nUtpd1UcCguXQtVvse34uT/3ywChZ0QTJyXW+MB+9mT10tdxc3oZ9Ki+8NRstzSTQy87EXdPQRmwAF34AQ6zTAi09oxl8EAkLYYRqpsQYNYtV1yzKk7A70WFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mVF8LU91; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hql3Uf0Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mVF8LU91; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hql3Uf0Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1AB71FB4F;
	Fri, 21 Jun 2024 06:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718951719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gky7i+Wvwjgn8GNQOboB30L9EhqRR1eV3HvFG4/ohjE=;
	b=mVF8LU91pUMrYYBA7JGmLIsv6IEDRS5sYFLGIgjOudDFYhsLaPtl+4jmplGGHbocZgMnRs
	YmSmUPsqljStzwlfbmcGb3e3kKzT00yHNI4x0T6s2OQNURWqBN6EFFlr5AvCE5faFkm/NL
	4J39F0SDXubVTJ9rZkU+IZ71sEXXZUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718951719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gky7i+Wvwjgn8GNQOboB30L9EhqRR1eV3HvFG4/ohjE=;
	b=hql3Uf0QvyQhIRRoug+cpLKDrmfeNQgxahA7DWPoF2ieWP8l0JJSS8wQPZe0kjrFGWvocR
	7nDACJK55SD44fDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mVF8LU91;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hql3Uf0Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718951719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gky7i+Wvwjgn8GNQOboB30L9EhqRR1eV3HvFG4/ohjE=;
	b=mVF8LU91pUMrYYBA7JGmLIsv6IEDRS5sYFLGIgjOudDFYhsLaPtl+4jmplGGHbocZgMnRs
	YmSmUPsqljStzwlfbmcGb3e3kKzT00yHNI4x0T6s2OQNURWqBN6EFFlr5AvCE5faFkm/NL
	4J39F0SDXubVTJ9rZkU+IZ71sEXXZUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718951719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gky7i+Wvwjgn8GNQOboB30L9EhqRR1eV3HvFG4/ohjE=;
	b=hql3Uf0QvyQhIRRoug+cpLKDrmfeNQgxahA7DWPoF2ieWP8l0JJSS8wQPZe0kjrFGWvocR
	7nDACJK55SD44fDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22AD913ABD;
	Fri, 21 Jun 2024 06:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7onwLSQfdWY7BAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 21 Jun 2024 06:35:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 15/18] nfsd: use SRCU to dereference nn->nfsd_serv
In-reply-to: <20240619204032.93740-16-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>,
 <20240619204032.93740-16-snitzer@kernel.org>
Date: Fri, 21 Jun 2024 16:35:13 +1000
Message-id: <171895171341.14261.1146008422146566199@noble.neil.brown.name>
X-Rspamd-Queue-Id: C1AB71FB4F
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 20 Jun 2024, Mike Snitzer wrote:
> Introduce nfsd_serv_get, nfsd_serv_put and nfsd_serv_sync and update
> the nfsd code to prevent nfsd_destroy_serv from destroying
> nn->nfsd_serv until all nfsd code is done with it (particularly the
> localio code that doesn't run in the context of nfsd's svc threads,
> nor does it take the nfsd_mutex).
>=20
> Commit 83d5e5b0af90 ("dm: optimize use SRCU and RCU") provided a
> familiar well-worn pattern for how implement.
>=20
> Suggested-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/filecache.c | 13 ++++++++---
>  fs/nfsd/netns.h     | 14 ++++++++++--
>  fs/nfsd/nfs4state.c | 25 ++++++++++++++-------
>  fs/nfsd/nfsctl.c    |  7 ++++--
>  fs/nfsd/nfssvc.c    | 54 ++++++++++++++++++++++++++++++++++++---------
>  5 files changed, 88 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 99631fa56662..474b3a3af3fb 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -413,12 +413,15 @@ nfsd_file_dispose_list_delayed(struct list_head *disp=
ose)
>  		struct nfsd_file *nf =3D list_first_entry(dispose,
>  						struct nfsd_file, nf_lru);
>  		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> +		int srcu_idx;
> +		struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
>  		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> =20
>  		spin_lock(&l->lock);
>  		list_move_tail(&nf->nf_lru, &l->freeme);
>  		spin_unlock(&l->lock);
> -		svc_wake_up(nn->nfsd_serv);
> +		svc_wake_up(serv);
> +		nfsd_serv_put(nn, srcu_idx);
>  	}
>  }
> =20
> @@ -443,11 +446,15 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
>  		for (i =3D 0; i < 8 && !list_empty(&l->freeme); i++)
>  			list_move(l->freeme.next, &dispose);
>  		spin_unlock(&l->lock);
> -		if (!list_empty(&l->freeme))
> +		if (!list_empty(&l->freeme)) {
> +			int srcu_idx;
> +			struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
>  			/* Wake up another thread to share the work
>  			 * *before* doing any actual disposing.
>  			 */
> -			svc_wake_up(nn->nfsd_serv);
> +			svc_wake_up(serv);
> +			nfsd_serv_put(nn, srcu_idx);
> +		}
>  		nfsd_file_dispose_list(&dispose);
>  	}
>  }
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 0c5a1d97e4ac..92d0d0883f17 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -139,8 +139,14 @@ struct nfsd_net {
>  	u32 clverifier_counter;
> =20
>  	struct svc_info nfsd_info;
> -#define nfsd_serv nfsd_info.serv
> -
> +	/*
> +	 * The current 'nfsd_serv' at nfsd_info.serv.  Using 'void' rather than
> +	 * 'struct svc_serv' to guard against new code dereferencing nfsd_serv
> +	 * without using proper synchronization.
> +	 * Use nfsd_serv_get() or take nfsd_mutex to dereference.
> +	 */
> +	void __rcu *nfsd_serv;
> +	struct srcu_struct nfsd_serv_srcu;
> =20

srcu_struct is not tiny.  I think it would make sense to use a global
struct for all net namespaces.

Most users do seem to be embed them in some other structure - but not
all....  kfd_processes_srcu stm_source_srcu

Thanks,
NeilBrown

