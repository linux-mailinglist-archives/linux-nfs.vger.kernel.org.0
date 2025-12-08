Return-Path: <linux-nfs+bounces-16988-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8EACADAEC
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 17:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C84AA3015383
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0782225417;
	Mon,  8 Dec 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="eaHCeuKF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C641DF963
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209753; cv=none; b=QFtqxwzTUoAZshVqusDy1CSrie+EbZEuEEdoDjS517hb/DkLHW97P/7e2mu8t0nc2qk6ltWTADp89RbtGUeHI4+92hJ+A2+8AWi0bCUUTKUOSsjXIXMC9t1wz1YlZZgaM6G42o8f2ATqNi2spIOHPG63hcDehcOU+QmQBvSlP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209753; c=relaxed/simple;
	bh=aVco2UWzsnetz711xsXpxDHZhjLSN4RtAB4zqX6sGeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWCnQXsfmN0uhV7OwlUWHvFmjMH6w9dLDbNiBW3fgLbsFiHRC8QQQuKUqaY8cgz4rtFrOt/hPwIj+WzNGOTUk627e6ZnKAqB/x12eKYH5zNQ8iCXlu4xAJhUaMjzm9qoRdM1IihhhiIUjUsDRTq0Oomyk57JyTBlSfCuAFxd00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=eaHCeuKF; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37bac34346dso28386651fa.2
        for <linux-nfs@vger.kernel.org>; Mon, 08 Dec 2025 08:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1765209750; x=1765814550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DALFK6uNpPE/XFkN1g6mGC/xJd60UlwJCdmoqRAGu6M=;
        b=eaHCeuKFATWGwX2H6r00ssAmZwWD8yDlWaxajtA5HXisV0mpntM7ZM94Kab0yyOwSG
         F6UXul8fEvROkdTG/ox3Ytoz8gcwXw61H652MFb9TpVpaXoeO4br7ZUcGYGuM9mOVBCK
         myURRK1jyhepJYn9QyElS1vEtADrEPctywsu5kld/HDn0S+gfhJrYKphCeQ4ym8YfKQE
         Jv/3jAJ3dbCwuCU+r7v4vAnWQxcS9Sz8a63sYgxysJxLdql/wtLyddWqRUK59beKHz/E
         nmXgTHX4IjPrBv8az+zuwP5SJb0lEJOJSHqBeP6m0pV6P/TYJ9NJTlp0rWMR8iMxCtjn
         aPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765209750; x=1765814550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DALFK6uNpPE/XFkN1g6mGC/xJd60UlwJCdmoqRAGu6M=;
        b=Jp0J6im1t/SmqL+kbLq92yZUIWAsY259/mY/afe9qe6Du/EvRSehBoZ612/IjlSRuf
         s1uRtJtyyAjCcfSdjC/Eauro2yib6wZUJR9A3849cbNonEuakELz+pkh32Wp06n11ndG
         5Y94+yPMEAV560KF+pOoofs1zG8lM1sNL/2YcCRVAKdH3uGo9kJt+E1fithIqX616zd8
         zmdRUdKN2TNNvS7p58JPG/gZwtxkx/EkDxVQM81Ikn5vA0LuzuUCwZEevASkT70r9ZaD
         KCyC2jp+sBrPVWcuHkO0LG29jOXUN9KGQCLH85flx/I8Be6IVqUcJSH8NjgqAIH5TrNR
         V0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXqdhg2yNdwVhDEl2IrdG/LmwdqDJ5stwZ8ULeljWHcIi8I3dMs3boLfCwVrzhGP3WwIJZY/Sgbh4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YysSi7QHmfruezETJgTq4M9fzEx2DLC+XtMJngJN+wz2SJt1geB
	vFsGReCC6u9+Igj68sBiDpfuxhvtwAd6WuPO2y57679VpGA0Mo37erZOpO2Ll84ai/Aa3/TTBk2
	qmS8IKSePamOSxTZqu03CisdgGee1/oPYpyXaP6aVIQ==
X-Gm-Gg: ASbGnctMF3JCA2AujVvCBYOJRVzOu1EcDuN5DyBRhy5U6UjlXsBtt+rnEgz0pnQgifb
	1dlLHTueqn3/OydsYkDMgMiwUvSqu12xylXrlU+jbix/mypItFFPD3GZj/RARUTtO5c9eBeDpbF
	fq5tZMvZUoFQHN9JIKVGUzfgJko3JargvBtQr60ru2xwGmCQb5ouOA92tDQQZ5w0VJv52YpejHh
	iEkwtq9EYyf0OyBWBlc6mG3BgM8j3M1Zqv9yko9VCi7gFqXOqHM2Op8BCNcwxMzWSZ1T1fHYFs9
	GT46cwUmiGSDLdii5xo/NAcX1aT5LDclneiztIoz
X-Google-Smtp-Source: AGHT+IEZWhnzKrOUc+GTeHTZ3nyNpcy8T62nxf0qUjBAHzjkutRzjSFbu2ZwA9NQdoTUO0LJs8oFpFDTTM8bVDMiUQo=
X-Received: by 2002:a05:651c:41ca:b0:37a:4085:c83d with SMTP id
 38308e7fff4ca-37ed83a09a2mr25743421fa.29.1765209749434; Mon, 08 Dec 2025
 08:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205184156.10983-1-okorniev@redhat.com> <176508180496.16766.14577514890223630313@noble.neil.brown.name>
In-Reply-To: <176508180496.16766.14577514890223630313@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 8 Dec 2025 11:02:17 -0500
X-Gm-Features: AQt7F2rylqNT58GKIsbCqBaghXSX3mn36DQkYXbJAGmqaDNP8_rMGklC9pduYXg
Message-ID: <CAN-5tyFNgMk0j37ZnhiRqKK8LoLChb25_oCjvo5LWsjapGJL9w@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: check that server is running in unlock_filesystem
To: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 11:30=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Sat, 06 Dec 2025, Olga Kornievskaia wrote:
> > If we are trying to unlock the filesystem via an administrative
> > interface and nfsd isn't running, it crashes the server.
> >
> > [   59.445578] Modules linked in: nfsd nfs_acl lockd grace nfs_localio =
ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkil=
l vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memop=
s uvc videobuf2_v4l2 videobuf2_common snd_hda_intel snd_intel_dspcfg snd_hd=
a_codec videodev snd_hda_core snd_hwdep mc snd_seq snd_seq_device snd_pcm s=
nd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_=
transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs ghash_ce nvme =
e1000e nvme_core nvme_keyring nvme_auth hkdf sr_mod cdrom vmwgfx drm_ttm_he=
lper ttm 8021q garp stp llc mrp sunrpc dm_mirror dm_region_hash dm_log iscs=
i_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod n=
fnetlink
> > [   59.451979] CPU: 4 UID: 0 PID: 5193 Comm: bash Kdump: loaded Tainted=
: G    B               6.18.0-rc4+ #74 PREEMPT(voluntary)
> > [   59.453311] Tainted: [B]=3DBAD_PAGE
> > [   59.453913] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201=
.00V.24006586.BA64.2406042154 06/04/2024
> > [   59.454869] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BT=
YPE=3D--)
> > [   59.455463] pc : nfsd4_revoke_states+0x1b4/0x898 [nfsd]
>
> But *why* does it crash?

> Can you please
>    ./scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4/0x8=
98
>
> and report what line of code it is crashing on?

okorniev@linux-10:/source/linux$ ./scripts/faddr2line
fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4/0x898
nfsd4_revoke_states+0x1b4/0x898:
find_one_sb_stid at /source/linux/fs/nfsd/nfs4state.c:1748
(inlined by) nfsd4_revoke_states at /source/linux/fs/nfsd/nfs4state.c:1786

> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 35004568d43e..faa874eff1e9 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1775,6 +1775,9 @@ void nfsd4_revoke_states(struct net *net, struct =
super_block *sb)
> >       unsigned int idhashval;
> >       unsigned int sc_types;
> >
> > +     if (!nn->nfsd_serv)
> > +             return;
> > +
>
> Seeing that nfsd4_revoke_states() doesn't make any reference to
> nfsd_serv, I think this change is - at best - confusing.

This solution was in line with how the rest of proc functionality did
it (ie it checks whether or not the server is running).

> As there is no lock held here, nfsd_serv could spontaneously become NULL
> at any time, so this is unlikely to be a complete fix.

I disagree that it's not a fix. As the main logic I think should be
that the unlock operation shouldn't be attempted if there isn't a
running server.

However, what I think you are saying is that the server shutdown
cleanup should have cleaned things such that this error shouldn't
occur even if there isn't a check for the running server. While I see
the logic there, I find it more confusing to ignore the fact that we
are not checking for the running state of the server before trying to
perform an operation that assumes the server is running.

> I would expect each conf_id_hashtbl[] list to be empty

Not only is it empty, it's been freed by nfsd4_state_destroy_net() function=
.

"systemctl start nfs-server" --- creates the conf_id_hashtbl
"systemctl stop nfs-server" --- ends up freeing it
echo path > unlock_filesystem --- has no conf_id_hashtbl.

I still stand that the solution here is to check for the running
server. If you think the check nn->nfsd_net_up is better than checking
for null, I can do that.

>  when no server is
> running so the function should do nothing.  Clearly my expectation is
> wrong, but I would like to know *why* it is wrong, and to fix the root
> cause.
>
>
> We also need this
>
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1778,7 +1778,7 @@ void nfsd4_revoke_states(struct net *net, struct su=
per_block *sb)
>         sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYP=
E_LAYOUT;
>
>         spin_lock(&nn->client_lock);
> -       for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) =
{
> +       for (idhashval =3D 0; idhashval < CLIENT_HASH_SIZE; idhashval++) =
{
>                 struct list_head *head =3D &nn->conf_id_hashtbl[idhashval=
];
>                 struct nfs4_client *clp;
>         retry:
>
> Maybe it should be part of the same patch - maybe not.

I gather this is a needed change but insufficient to fix the issue and
should be a separate patch (as a fix for something but not this
problem).

>
> Thanks,
> NeilBrown
>

