Return-Path: <linux-nfs+bounces-21511-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cU4UIXcdA2r10gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21511-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 14:30:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF7520269
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 14:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ACA9300ACA0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52DA4C8FF5;
	Tue, 12 May 2026 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKcL2RGg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C634F24A
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589037; cv=none; b=WAgCtKDujQNW/4VXHy19NjoXV6VAgGBqGbREEATFlAD2nHok6C/kIoHRE8e/8zU2mQOtvHJZOshfrztyQviSk5B39YMkmHCJvK//6yTbL9ypM/DfKX+TcAP6XWvMzJWN8/wTzKGInTu9y6PflRXj0XAT1iFCqNoqHHK4yuoHP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589037; c=relaxed/simple;
	bh=02Nnu23Uu7eG96yKSKnQpac4o44Jx0WV9khru12eqhg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oe69QExg1ic5uXb3gq0U+hHaHB7EAXtVvqmRjJsu0C67dOlwILU3X9yO7O4WECAxFMMGdeet4S7aSd+fcZB+bTUmVXI37rJT8ufuztWt92Im+evRC4oovYX+3qTvHdEeO4xkay7Q0UUokPshbh0VG/EMFyWBRBZxrRfgwBl1pcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKcL2RGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFA3C2BCB0;
	Tue, 12 May 2026 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778589037;
	bh=02Nnu23Uu7eG96yKSKnQpac4o44Jx0WV9khru12eqhg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gKcL2RGgVkHC105A2GwPncEZfSBp+7RtWZRCFOEfA8WqTdb5MMYVpuJ+YFX3ZMgiB
	 0rP0U6xDgtldm41NvofNLI10gAwEQq26tcuBBnJQc2loYgtvQpI/uwqk6+AxLDYjRH
	 kzwEcckTOByQkrq5oWnrRdrKDUMkOLbPEOgnjqfuYcgQU4aNWLC9KhJeD/j3N/c3+s
	 1crBmmLMGg7B0k/TK5yu4tFeQlYCLM9W/YXrjqxs01jN165wnpCB3frO6qJaHupaHs
	 Jf2nVWZWocEGZiQ5brdq6sLP7IVlGmgtzE8VY0Co3nWBMuAmoa86/sUXo8nva23UwI
	 2jw2SffGGHclQ==
Message-ID: <da2da3a188b1823bad89e876001a5281351d8eb7.camel@kernel.org>
Subject: Re: [PATCH] Revert "NFSD: Defer sub-object cleanup in export put
 callbacks"
From: Jeff Layton <jlayton@kernel.org>
To: yangerkun <yangerkun@huaweicloud.com>, Yang Erkun
 <yangerkun@huawei.com>, 	chuck.lever@oracle.com, misanjum@linux.ibm.com,
 neil@brown.name, 	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 	lilingfeng3@huawei.com
Date: Tue, 12 May 2026 08:30:33 -0400
In-Reply-To: <5701706a-6a54-4bcb-a2ce-83eac3d4b715@huaweicloud.com>
References: <20260512023322.2828939-1-yangerkun@huawei.com>
	 <a6c66164d75e6cfa530892b9f5f25ab9d677a9fa.camel@kernel.org>
	 <5701706a-6a54-4bcb-a2ce-83eac3d4b715@huaweicloud.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5ECF7520269
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21511-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 20:19 +0800, yangerkun wrote:
> Hi Jeff,
>=20
> =E5=9C=A8 2026/5/12 19:25, Jeff Layton =E5=86=99=E9=81=93:
> > On Tue, 2026-05-12 at 10:33 +0800, Yang Erkun wrote:
> > > This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
> > >=20
> > > Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
> > > callbacks") describes an issue where calling svc_export_put, path_put=
,
> > > and auth_domain_put directly can cause use-after-free (UAF) errors wh=
en
> > > accessing ex_path or ex_client->name. However, after discussion in [1=
],
> > > it is clear that commit e7fcf179b82d ("NFSD: Hold net reference for t=
he
> > > lifetime of /proc/fs/nfs/exports fd") actually resolves this problem.
> > >=20
> > > Additionally, commit 48db892356d6 ("NFSD: Defer sub-object cleanup in
> > > export put callbacks") introduces a regression that was already fixed=
 by
> > > commit 69d803c40ede ("nfsd: Revert "nfsd: release svc_expkey/svc_expo=
rt
> > > with rcu_work""). Therefore, reverting commit 48db892356d6 ("NFSD: De=
fer
> > > sub-object cleanup in export put callbacks") is necessary to fix this
> > > regression.
> > >=20
> > > Link: https://lore.kernel.org/all/10019b42-4589-4f9f-8d5b-d8197db1ce3=
c@huawei.com/ [1]
> > > Fixes: 48db892356d6 ("NFSD: Defer sub-object cleanup in export put ca=
llbacks")
> > > Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> > > ---
> > >   fs/nfsd/export.c | 63 +++++++--------------------------------------=
---
> > >   fs/nfsd/export.h |  7 ++----
> > >   fs/nfsd/nfsctl.c |  8 +-----
> > >   3 files changed, 12 insertions(+), 66 deletions(-)
> > >=20
> >=20
> > The LLMs don't seem to agree that this is safe:
> >=20
> > commit (not yet applied)
> > Author: Yang Erkun <yangerkun@huawei.com>
> >=20
> > Revert "NFSD: Defer sub-object cleanup in export put callbacks"
> >=20
> > This reverts commit 48db892356d6. The commit message states that
> > e7fcf179b82d resolves the underlying UAF and that the reverted
> > commit re-introduces an umount regression fixed by 69d803c40ede.
> >=20
> > Link: https://lore.kernel.org/all/10019b42-4589-4f9f-8d5b-d8197db1ce3c@=
huawei.com/
> >=20
> > > This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
> > >=20
> > > Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
> > > callbacks") describes an issue where calling svc_export_put, path_put=
,
> > > and auth_domain_put directly can cause use-after-free (UAF) errors wh=
en
> > > accessing ex_path or ex_client->name. However, after discussion in [1=
],
> > > it is clear that commit e7fcf179b82d ("NFSD: Hold net reference for t=
he
> > > lifetime of /proc/fs/nfs/exports fd") actually resolves this problem.
> >=20
> > Is this accurate?  Commit e7fcf179b82d holds a net reference for the
> > lifetime of the /proc/fs/nfs/exports file descriptor.  This prevents
> > nfsd_net_exit() from calling nfsd_export_shutdown() while the exports
> > fd is open, keeping the cache_detail alive.
>=20
> Yes.
>=20
> >=20
> > But the UAF described in 48db892356d6 is a different problem.
> > cache_clean() periodically removes expired entries from the hash table
> > via sunrpc_begin_cache_remove_entry() and drops their reference via
> > cache_put().  If that was the last reference, svc_export_put() runs
> > and frees sub-objects.
>=20
> Yes.
>=20
> >=20
> > Meanwhile, c_show() and e_show() iterate cache entries under
> > rcu_read_lock() without holding a reference.  Specifically, c_show()
> > unconditionally calls cd->cache_show():
> >=20
> > net/sunrpc/cache.c:c_show():
> > 	if (cache_check_rcu(cd, cp, NULL))
> > 		seq_puts(m, "# ");
> > 	else if (cache_is_expired(cd, cp))
> > 		seq_puts(m, "# ");
> > 	return cd->cache_show(m, cd, cp);
> >=20
> > svc_export_show() then accesses both exp->ex_path via seq_path()
> > and exp->ex_client->name via seq_escape().  expkey_show() similarly
> > accesses ek->ek_client->name and ek->ek_path.
>=20
> Yes.
>=20
> >=20
> > Commit e7fcf179b82d does not prevent cache_clean() from removing
> > individual entries concurrently with these RCU readers.  It seems
>=20
> Yes.
>=20
> > like the claim in this commit message may be conflating two different
> > problems.
>=20
> True, the msg describe here seems confused. That should change to:
>=20
> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
> callbacks") describes an issue where calling svc_export_put, path_put,
> and auth_domain_put directly can cause use-after-free (UAF) errors when
> accessing ex_path or ex_client->name. But after discussion in [1], it=20
> seems cannot happen and either will introduce a gression that was
> already fixed by commit 69d803c40ede ("nfsd: Revert "nfsd: release
> svc_expkey/svc_export with rcu_work""). Therefore, reverting commit
> 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
> is necessary to fix this regression.
>=20
>=20
> >=20
> > > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > > index 665153f1720e..0baa58d1dbfc 100644
> > > --- a/fs/nfsd/export.c
> > > +++ b/fs/nfsd/export.c
> >=20
> > [ ... ]
> >=20
> > > -static void expkey_release(struct work_struct *work)
> > > +static void expkey_put(struct kref *ref)
> > >   {
> > > -	struct svc_expkey *key =3D container_of(to_rcu_work(work),
> > > -					      struct svc_expkey, ek_rwork);
> > > +	struct svc_expkey *key =3D container_of(ref, struct svc_expkey, h.r=
ef);
> > >   	if (test_bit(CACHE_VALID, &key->h.flags) &&
> > >   	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
> > >   		path_put(&key->ek_path);
> > >   	auth_domain_put(key->ek_client);
> > > -	kfree(key);
> > > -}
> > > -
> > > -static void expkey_put(struct kref *ref)
> > > -{
> > > -	struct svc_expkey *key =3D container_of(ref, struct svc_expkey, h.r=
ef);
> > > -
> > > -	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
> > > -	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
> > > +	kfree_rcu(key, ek_rcu);
> > >   }
> >=20
> > With this change, path_put() and auth_domain_put() run immediately
> > when the last reference is dropped, before the RCU grace period.
> > kfree_rcu() only defers the kfree of the svc_expkey struct itself.
> >=20
> > If cache_clean() drops the last reference concurrently with an RCU
> > reader in c_show() -> expkey_show(), the reader can access
> > ek->ek_client->name after auth_domain_put() has freed the
> > auth_domain, and can call seq_path(&ek->ek_path) after path_put()
> > has freed the underlying dentry/mnt.  The rcu_read_lock() held by the
> > reader prevents kfree_rcu() from freeing the struct, but does not
> > prevent the direct path_put()/auth_domain_put() calls.
>=20
> Yes. It won't prevent the direct path_put/auth_domain_put calls.
>=20
> >=20
> > Does this re-introduce the UAF that 48db892356d6 was fixing?
>=20
> No, something like release of dentry/mnt ek->ek_client->name all=20
> protected will call_rcu(call_rcu(&dentry->d_rcu, __d_free) in=20
> dentry_free, call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt) in=20
> cleanup_mnt, call_rcu(&dom->rcu_head, svcauth_gss_domain_release_rcu) in=
=20
> svcauth_gss_domain_release, call_rcu(&dom->rcu_head,=20
> svcauth_unix_domain_release_rcu) in svcauth_unix_domain_release), so=20
> rcu_read_lock/rcu_read_unlock for c_show/e_show can protect this trigger=
=20
> UAF.
>=20

Got it. Thanks for the explanation. In that case, I'm fine with
reverting this patch.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

