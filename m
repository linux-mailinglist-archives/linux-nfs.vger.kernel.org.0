Return-Path: <linux-nfs+bounces-22907-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MqbZLsMgRWr67QoAu9opvQ
	(envelope-from <linux-nfs+bounces-22907-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 16:14:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 734786EE952
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 16:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DFYLwAOt;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22907-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22907-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C44F3010D21
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3593FC5A5;
	Wed,  1 Jul 2026 13:41:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE148A2CE
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2026 13:41:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913271; cv=none; b=UQL4+47MEcvZTIs6FzUDfOp32tm5dJR2g9nmleCTWDgwKiZycePm/YzDpz2pp30gtNesrFPyobXMhtF5ghSwWwnSiWZ1UacmQ4ZvzBQm+5jlPNVEhZRO7eoB/QVewloZnv4MlZVCLGZA9H9j81EnQDT6YtRozleh0hlfQiR1MYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913271; c=relaxed/simple;
	bh=Skr40u/Dng8njXJYjrXvDUcoJrvmebMDtASicFrhoY0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mCEF/O7iCk9CECUmRHck7hIIK42M5lc4hkgqTl9e2NZvXP8UtAHq8GAOk55URHbtRV5GTie28l13hblJtwbmJBPGrscVMCUkS8+MWW0FbG4wLitMNBE9w6p7GYpPDVl6WbfbepfDkMzLS7jgDxn7goSGyzDPlaiiJTWXeiA5BGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFYLwAOt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59951F000E9
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2026 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913267;
	bh=cyvQfxD8O0i2DnL4i42HboqaIPkieuTSz5nXz1LPYas=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DFYLwAOtx0FrBLgvnEujRX863wBEOB7QMXygYZUlOPqrfTOjdARFpBbSWJ0geE+b/
	 IAhxvzFCJ6tppNudNe23SXaaZCBQu4R6qd70AXtjcu6c1qNbqukTsp2dxVxDQ/8Ctl
	 vci1HQB2v7WSsPuPgY0JQavNhX/hgp+Ab00lZuuh2if5pv319ehtxtNouO/t06tjcA
	 bh3w/sItQTsvuCKOpbMWm21D1zfxyxKDTPoaPsaslD7jX0bkoVnLYzz1atUlaL5Qbd
	 LQwhd6XpejgLySHTaOSJWUClW2l9VJUunNV5bZETVF9cu1ZyKgeLMp+OhkQMnBDOiT
	 CBdMx1WYi6AZQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E550FF4006C;
	Wed,  1 Jul 2026 09:41:06 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 01 Jul 2026 09:41:06 -0400
X-ME-Sender: <xms:8hhFanWF6ngYUL2Icswh6RU5sZYYWdqx8JHJKH5nRvYvoFQLwnpJcg>
    <xme:8hhFaqbELIkEbSjmM6sGkknowAR5WfQEkMj10wRMD-O9No6yq8Z65yklzFHo5eC_l
    7DZrpURz6IB0Nz9UjWsCTZ-GW39AK8R10v8GAKX6wzF6ZQx22JZNw>
X-ME-Proxy-Cause: dmFkZTE0z8hogJsYsdjbIqgYA2BYi8gtw7XlZ/5li0BnCFyjpUJLrNBo6KFGk6MHZS+2fs
    jKRdQY0JeRuWWXkGfitcrLMoToxsVrgOGjSCT5l7VOHZlSGt2NhmERBN9BZRb0cHSUMg3E
    TJBqnmOl5PMKqeaw/YVMs9ewr8Unn5lm0G3u8NJ13BWCUMHPJDcUojZ1v8naoFWPeB0w+4
    e1yjU3Jjj4BOiv1Jgd4yztlyRa/z/G/e8r7TnPd5Q8xwY/ZYXOLIcqCzIgQA7to1HKNg3Q
    2qhh28HrshtcZUzNBI4Mqu7wT/DWD3MteThmWmPA65NEqizq8U/XrBGFAFx8c3QZSh27eo
    5eYSvmGScEfTX59NhLsKkt/5ueMtlsRPqPyQvWnshcpkrGjIqksm7w6fI/UdtGkP+5/h+f
    9a1d/eeFh6LEmd9NgKvkyoWzvreyVCRXqWHp0DBUY4nWqKl2yLDD6KyqZMigk65wQUNB2Y
    pd/azY8N4+hsDjWav+L8/Eqv2uauu3jizHXY0QOEpFIvgnuV5XYQ2+oTNez7a/GalNCLmD
    HcJ8LtRDKwOMRlWHBUjGudPF2+J/dEtfuaHN0AskzA0Jx4Y5MMP52GjGDBi763jJxhnX3L
    6A7hHDyGEYkkMIbc1HShDlhIa0CEGTOqwtDPMqy/M0FJTAAX3EJNGKCT3v4g
X-ME-Proxy: <xmx:8hhFamScHLfC8cJ9TytqFKh_OjIKAJyO7Fm6wat2tszH_l193YPjEw>
    <xmx:8hhFajjyqniNgkWQyODFrYIZBljFEijXhTvBCL4vMHU1QqjWdYbDTw>
    <xmx:8hhFam7taDz31UeNXLX5ZWQuTqJEoCeIY2aBIIDDqVurBMNApsc4ig>
    <xmx:8hhFagBt903PUsHIwmHDZjk5lpNqy6dipS3cNo3Jf7QhOlzGDyg9ew>
    <xmx:8hhFatZyGmgsVvMfxjgdTG9RXiVGZIsMEbks8s_jstWlRw1hQMlODDEJ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1CF3780AB5; Wed,  1 Jul 2026 09:41:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXywqv_4gqb-
Date: Wed, 01 Jul 2026 09:40:46 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Oscar Ou" <oscarou@synology.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Message-Id: <bdce0570-b584-444b-b78e-a5a2cc5b85ad@app.fastmail.com>
In-Reply-To: <20260701052645.2213483-1-oscarou@synology.com>
References: <20260630093820.2162344-1-oscarou@synology.com>
 <20260701052645.2213483-1-oscarou@synology.com>
Subject: Re: [PATCH v2] lockd: refcount NLM_SHARE access/deny modes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22907-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:oscarou@synology.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,synology.com:email,vger.kernel.org:from_smtp,app.fastmail.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 734786EE952



On Wed, Jul 1, 2026, at 1:26 AM, Oscar Ou wrote:
> When an NFSv3/NLM client issues multiple NLM_SHARE calls from a single
> host for the same (file, owner) tuple, the current implementation
> overwrites the recorded access and deny modes with the latest pair.
> A subsequent NLM_UNSHARE then drops the entire entry, even if other
> grants were implicitly subsumed by the most recent SHARE.  This is
> particularly visible to Windows-style clients that map each open of
> a file to a distinct NLM_SHARE, all carrying the same NLM owner
> handle.  For example:
>
>     1. SHARE(access=3DRW, deny=3DW)   -> entry [RW, deny W]
>     2. SHARE(access=3DR,  deny=3DN)   -> entry [R, deny N]   (RW/W ove=
rwritten)
>     3. UNSHARE(access=3DR, deny=3DN)  -> entry freed
>     4. UNSHARE(access=3DRW, deny=3DW) -> nothing to release
>
> Track each of the four valid fsh_access and fsh_mode values with a
> small per-value refcount.  On SHARE the appropriate buckets are
> incremented; on UNSHARE they are decremented.  s_access / s_mode
> are recomputed in both paths as the union of all positive buckets
> with a non-NONE / non-DN value (indices 1..3), and the entry is
> freed once s_access and s_mode are both zero.
>
> NLM_UNSHARE gains the access and deny modes as arguments so the
> correct buckets can be decremented.  The two callers in svcproc.c
> and svc4proc.c are updated to forward the decoded values.
>
> Signed-off-by: Oscar Ou <oscarou@synology.com>
> ---
> Applies on top of "lockd: Regenerate NLMv4 XDR code" by Chuck Lever.
>
> No Fixes: tag.  The fix depends mechanically on the xdrgen
> regeneration, so a Fixes: tag would mislead -stable backporters.
> Happy to add one plus an informal Depends-on: line if preferred.
>
> Changes since v1:
> - Reworded the "buckets" sentence in the commit message: the entry is
>   freed once s_access and s_mode are both zero, not when every bucket
>   has reached zero.  Index 0 (fsa_NONE / fsm_DN) contributes no bits
>   to the union and does not gate freeing.
> - Dropped the incorrect claim that per-file f_mutex serialises the
>   new arrays, from both the commit message and the comment on
>   nlm_recompute_share().  f_mutex is released by nlm_lookup_file()
>   before the share helpers run.
>
>  fs/lockd/share.h    |  6 +++++-
>  fs/lockd/svc4proc.c |  4 +++-
>  fs/lockd/svcproc.c  |  4 +++-
>  fs/lockd/svcshare.c | 40 +++++++++++++++++++++++++++++++++++-----
>  4 files changed, 46 insertions(+), 8 deletions(-)

Hi Oscar -

First, a "process" note, then notes on your patch
follow below that.

Thanks for the "Applies on" and the change log. You've
addressed the concerns from my review of v1.

I want to highlight a couple of subtleties when sending
updated patch versions.

1. New thread per revision =E2=80=94 no In-Reply-To: back to the
   old version.

Post v2 as its own top-level thread; don't reply-to the v1
cover or any v1 patch. Per the doc (lines 845=E2=80=93850): "for a
multi-patch series, it is generally best to avoid using
In-Reply-To: to link to older versions of the series =E2=80=A6
so multiple versions don't become an unmanageable forest
of references."

This matters for our tooling: b4 and patchwork group a
thread by its reference chain. If v2 is threaded under v1,
b4 sees one giant thread and can pick up stale patches when
someone runs b4 am; maintainers who "apply the latest" can
grab the wrong blobs. A clean top-level thread per version
keeps b4 am/patchwork resolving to exactly the vN the
contributor intended.

2. Version the subject tag, not RESEND. [PATCH v2],
   [PATCH v2 01/27] (lines 716=E2=80=93719, 726=E2=80=93731). RESEND is
   only for re-sending an /unchanged/ series that got no
   response (lines 379=E2=80=93380) =E2=80=94 a modified series is never
   RESEND.


> diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
> index 5ac0ec25d62d..b7372094d397 100644
> --- a/fs/lockd/svcshare.c
> +++ b/fs/lockd/svcshare.c
> @@ -64,12 +82,15 @@ nlmsvc_share_file(struct nlm_host *host, struct=20
> nlm_file *file,
>  	share->s_host       =3D host;
>  	share->s_owner.data =3D ohdata;
>  	share->s_owner.len  =3D oh->len;
> +	memset(share->s_access_counts, 0, sizeof(share->s_access_counts));
> +	memset(share->s_mode_counts, 0, sizeof(share->s_mode_counts));
>  	share->s_next       =3D file->f_shares;
>  	file->f_shares      =3D share;
>=20
>  update:
> -	share->s_access =3D access;
> -	share->s_mode =3D mode;
> +	share->s_access_counts[access]++;
> +	share->s_mode_counts[mode]++;
> +	nlm_recompute_share(share);
>  	return nlm_granted;
>  }
>=20

NLM has no duplicate reply cache, so it depends on its request handlers
being idempotent: nlmsvc_dispatch() runs the procedure directly for
every request that arrives, with nothing to absorb a retransmit.

  fs/lockd/svc.c:nlmsvc_dispatch() {
  	...
  	*statp =3D procp->pc_func(rqstp);
  	...
  }

The rest of the NLM procedures are built around that invariant.  LOCK
reuses an existing block and lets vfs_lock_file(F_SETLK) re-apply a held
lock as a no-op, UNLOCK and CANCEL act on state that a replay simply
finds already gone, and FREE_ALL / SM_NOTIFY discard everything for a
host, so a replayed request lands on the same state.  Before this change
SHARE fit the same pattern: a repeated SHARE for an already-recorded
(host, owner) just reassigned s_access and s_mode.

With the per-value refcount a replayed SHARE instead increments the
bucket a second time.  Over UDP a lost reply followed by a client
retransmit reaches nlmsvc_share_file() twice for one open, and if the
client then sends one matching UNSHARE:

	SHARE(access=3DRW, deny=3DW)              -> s_access_counts[3] =3D 1
	SHARE(access=3DRW, deny=3DW) (retransmit) -> s_access_counts[3] =3D 2
	UNSHARE(access=3DRW, deny=3DW)            -> s_access_counts[3] =3D 1

nlm_recompute_share() still sees s_access_counts[3] > 0, so s_access
stays non-zero and the entry is never freed.  Can this leave a stale
share reservation that denies later conflicting opens until the host is
torn down?


> @@ -93,8 +116,15 @@ nlmsvc_unshare_file(struct nlm_host *host, struct=20
> nlm_file *file,
>  	for (shpp =3D &file->f_shares; (share =3D *shpp) !=3D NULL;
>  					shpp =3D &share->s_next) {
>  		if (share->s_host =3D=3D host && nlm_cmp_owner(share, oh)) {
> -			*shpp =3D share->s_next;
> -			kfree(share);
> +			if (share->s_access_counts[access])
> +				share->s_access_counts[access]--;
> +			if (share->s_mode_counts[mode])
> +				share->s_mode_counts[mode]--;
> +			nlm_recompute_share(share);
> +			if (!share->s_access && !share->s_mode) {
> +				*shpp =3D share->s_next;
> +				kfree(share);
> +			}
>  			return nlm_granted;
>  		}
>  	}

The decrement side has the mirror problem.  The old UNSHARE dropped the
whole entry on the first matching call, so a replay found nothing and
returned granted, idempotent.  The refcount version decrements a bucket
that may still be positive, so a replayed UNSHARE keeps going:

	open #1: SHARE(RW, deny=3DW)     -> s_access_counts[3] =3D 1
	open #2: SHARE(RW, deny=3DW)     -> s_access_counts[3] =3D 2
	close #1: UNSHARE(RW, deny=3DW)  -> s_access_counts[3] =3D 1
	retransmit of that UNSHARE     -> s_access_counts[3] =3D 0  (entry free=
d)

Here the client still holds open #2, but its reservation is gone, so a
conflicting open from another owner would now be granted.  Can a
retransmitted UNSHARE release a grant the client still holds?

Taken together, is there a way to keep SHARE and UNSHARE idempotent
under retransmission, some per-open identity to match on rather than a
bare count, so a duplicated request lands on the same state the way the
other NLM procedures do?

One direction would be to track the set of held (access, deny)
combinations rather than a count of each.  There are only sixteen
possible pairs, so a single u16 held-mask with one bit per
(access << 2 | deny) covers it:

	SHARE(a, d):   held_mask |=3D  BIT((a << 2) | d);
	UNSHARE(a, d): held_mask &=3D ~BIT((a << 2) | d);

s_access and s_mode are then the union of (i >> 2) and (i & 3) over the
set bits, and the entry is freed once held_mask is zero.  Setting or
clearing a bit is idempotent, so a replayed SHARE or UNSHARE lands on
the same mask, while distinct (access, deny) opens from one owner are
still tracked separately.

The tradeoff is that two opens with the identical (access, deny) pair
collapse to one bit, so a count of duplicate identical opens is lost.
RFC 1813 defines SHARE and UNSHARE but does not require that repeated
identical SHAREs from one owner survive an equal number of UNSHAREs,
and its duplicate-request discussion (section 4.5) treats a
non-idempotent request as something a reply cache has to guard, which
lockd does not run for NLM.  Tracking each distinct (access, deny)
combination therefore stays within the protocol while keeping both
operations idempotent.  Does that match your reading?

The bottom line is that after more consideration, IMO the reference
count approach is not going to work, in particular because NLM still
operates on unreliable network transports like UDP. Consider the
above direction not as a mandate but as a possible approach that
might address the issue you've reported while avoiding introducing
non-idempotency.


--=20
Chuck Lever

