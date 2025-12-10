Return-Path: <linux-nfs+bounces-17024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5000FCB3D62
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 20:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0613431354D5
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466BC23C4FD;
	Wed, 10 Dec 2025 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="TSM1ljQK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8283148B1
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393848; cv=none; b=EdYwuuyMthZAPsMQuh7Gx8m98H0oknlp9OjLpNC0LLq42kzowegBXI5dLKt6XYeUnfhyHMITR2B6AXTMuIkubFPAhSZTMf1NwdOFmrA5lazJn0PmAGTY88xSIUPpbRywyqICr8Xa6xRs8tiVde2xwIXRH64gY6KDdJirNTaXWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393848; c=relaxed/simple;
	bh=zfJIrzQKKdjpscUWWN5gFpmaHIJTEwcoqyvcbOhNCQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXah3KmGb7rYHt7h8pqh9d4BZ0Hkz6mJJ0z3DHFaeTBOM6TT3eajMplBimuB78pysdaG1avb50ItFfFfxhaDyHgkGCrHSQR8DJHhWOF+2NABhXjB7Fk7vrq2k2kyOkLoiOnYfv1LhNYwmHYT+ODmUfaBkc3uBRKWqx8USacsACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=TSM1ljQK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b9d8122fdso725991fa.3
        for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1765393844; x=1765998644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCvPyrC2PjL2N29VoLcnmaUIUSJdxlUY9+Ue3271BXI=;
        b=TSM1ljQK/2Qifugf29qov8jwTUhhz7fvjpVYf9+gUZkEjiPEFBZ6O5nU9SOtfTF7Ij
         irkreWEz7l1o3SjEmWVQZRKkFthPRCKMiy8nZRxxzirpUUr8b9hW9XVjMghX48GYBTdZ
         4n9h0djKY/m9wqbKOCZpljcLXQ14OjOA/n7eljrTcf2IEFXwoQ8wFSvSXDGQDE8sR/5k
         h6zAtg63yYb2Y1rjvxLMCSJY8jfWXKluRBzNcl11jTIjkDnAPaU5mH9GKhJ/03rYIILP
         +PMqW4ZIo0F3CK08X5X59HkJqEvxvoU6XnTNK7+VRs8juhtglXdxA86Dl4Lo+oBrg/ji
         E4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765393844; x=1765998644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JCvPyrC2PjL2N29VoLcnmaUIUSJdxlUY9+Ue3271BXI=;
        b=qHms1YPK2V1zqii9FNBkJ/dzFSWK0xXmjV4RlDeLHbA7exUGCbz4jsijvVle1J/Zdy
         UoyUI8F8r/ib2hm0z96yKqsn5AAbu05v4QidDGc/5M71NArfpCHcv1cZV4Y9vheHOHmF
         VUQHEkT0KcXTzwilkY3PGe6KbrRogWHsxLRNq4JEWSfaog9LsdUfg4XpQvlBPOlJBoHg
         MMDLrm12HaeT2EhIM5EkIw6F4JtovILnpGjyoY8i21u0NJP8IvlGhFxoKxLxKEFWF2yT
         AXX0h6o8YGs7Bnm0DI+yXAOgctokwcM+2BHjwzTYVdKXGiHgSnNTpL5h+ieTtmRVYz7P
         Q7xw==
X-Forwarded-Encrypted: i=1; AJvYcCW6thbXSGsQFooyo4zzqHGHj61Wevxgkyamf9xs8nStIJht44HtiK5/9szUL2hsSmBt2VzJHU3AUvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6eEL93OnNioKw1tru7sZI01M3gzgD7nARoDD/4FHb5jLu66t
	1juItMxQ8chOOYCgIsKRfbCBmeW1m1ZGyH0i37gej080D5T+Nq64JHTFORdQcu8Q0LHd4ZwIlQr
	D96N9P5laGxXSZ7OGnyR94bo5vQ6LyoQ=
X-Gm-Gg: AY/fxX48Rbl64N2iMEo6QV10OgGokBO/TxjxTx8fs7ToPpHx7QmlspiBgvYJ0qN1lS9
	o15VDvEdYhk7yfklYX2O/RisrIpvHumUvWpO0vdGjuav79duZvWFEd9xl4oAxEHUTcXQH1PPFcO
	RU2zcxZrMCHOWitx/vXkdiv91ti06aNaRttOl2FTmfxQFHbpbjfbIZ2x8/04BV2FkTQvXFKrShf
	2w9SiSmtWikwV+DSGPe0p9zp0cStFGscfyPGyJoiXNvMvQA/yJmm/fd01IdU5CASU2tRWgoWdPs
	bRSWuyEv4peRtxyVPEJApH4V6+zY
X-Google-Smtp-Source: AGHT+IE/RNa8sUR3AtmjkAoXRBO94hxl6ytjfqev/NuEiQrV0/RWxHP8M2TyQcOx94mMQ0vlbrxq55ay47xp8oV6GC8=
X-Received: by 2002:a2e:a595:0:b0:363:fea4:dcfa with SMTP id
 38308e7fff4ca-37fb200590dmr10517431fa.10.1765393843599; Wed, 10 Dec 2025
 11:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205184156.10983-1-okorniev@redhat.com> <176508180496.16766.14577514890223630313@noble.neil.brown.name>
 <CAN-5tyFNgMk0j37ZnhiRqKK8LoLChb25_oCjvo5LWsjapGJL9w@mail.gmail.com> <176522947804.16766.1562289482158759372@noble.neil.brown.name>
In-Reply-To: <176522947804.16766.1562289482158759372@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 10 Dec 2025 14:10:32 -0500
X-Gm-Features: AQt7F2rtwn4mHIYHn7aFruT24hl__lUezmzP8vAL-U1zXEy3E7RCcH2sC4eK7Co
Message-ID: <CAN-5tyE6DEoH9r2SH=3BwxM8vaQoYF83Zk9+s_iq3Vk6MKSV1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: check that server is running in unlock_filesystem
To: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 4:31=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
>
> On Tue, 09 Dec 2025, Olga Kornievskaia wrote:
> > On Sat, Dec 6, 2025 at 11:30=E2=80=AFPM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > On Sat, 06 Dec 2025, Olga Kornievskaia wrote:
> > > > If we are trying to unlock the filesystem via an administrative
> > > > interface and nfsd isn't running, it crashes the server.
> > > >
> > > > [   59.445578] Modules linked in: nfsd nfs_acl lockd grace nfs_loca=
lio ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr r=
fkill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_m=
emops uvc videobuf2_v4l2 videobuf2_common snd_hda_intel snd_intel_dspcfg sn=
d_hda_codec videodev snd_hda_core snd_hwdep mc snd_seq snd_seq_device snd_p=
cm snd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_vir=
tio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs ghash_ce n=
vme e1000e nvme_core nvme_keyring nvme_auth hkdf sr_mod cdrom vmwgfx drm_tt=
m_helper ttm 8021q garp stp llc mrp sunrpc dm_mirror dm_region_hash dm_log =
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_m=
od nfnetlink
> > > > [   59.451979] CPU: 4 UID: 0 PID: 5193 Comm: bash Kdump: loaded Tai=
nted: G    B               6.18.0-rc4+ #74 PREEMPT(voluntary)
> > > > [   59.453311] Tainted: [B]=3DBAD_PAGE
> > > > [   59.453913] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VM=
W201.00V.24006586.BA64.2406042154 06/04/2024
> > > > [   59.454869] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSB=
S BTYPE=3D--)
> > > > [   59.455463] pc : nfsd4_revoke_states+0x1b4/0x898 [nfsd]
> > >
> > > But *why* does it crash?
> >
> > > Can you please
> > >    ./scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4=
/0x898
> > >
> > > and report what line of code it is crashing on?
> >
> > okorniev@linux-10:/source/linux$ ./scripts/faddr2line
> > fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4/0x898
> > nfsd4_revoke_states+0x1b4/0x898:
> > find_one_sb_stid at /source/linux/fs/nfsd/nfs4state.c:1748
> > (inlined by) nfsd4_revoke_states at /source/linux/fs/nfsd/nfs4state.c:1=
786
>
> Thanks.  As you suggest it is likely accessing memory that we freed by
> nfsd_shutdown_net().  By the time it gets into find_one_sb_stid() it
> would have already accessed some freed memory so it was lucky to get
> that far.
>
> Code that wants to access conf_id_hash and related parts of nn should
> use:
>
>   nfsd_net_try_get(net)
>
> to check if it is safe and to keep it safe, and then nfsd_net_put(net)
> when it has finished.  That is more robust than simply checking nfsd_serv=
.

I'm confused by the guidance given.

I understood that other uses of nn->nfsd_server did so by grabbing the
nfsd_mutex lock. Thus, I ask, if it would be acceptable to do. Again,
I vote for this as it's the same as what the other proc uses (note,
unsure what the appropriate error code here should be).
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2b79129703d5..fcd026db553c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -259,6 +259,7 @@ static ssize_t write_unlock_fs(struct file *file,
char *buf, size_t size)
        struct path path;
        char *fo_path;
        int error;
+       struct nfsd_net *nn;

        /* sanity check */
        if (size =3D=3D 0)
@@ -285,6 +286,11 @@ static ssize_t write_unlock_fs(struct file *file,
char *buf, size_t size)
         * 3.  Is that directory the root of an exported file system?
         */
        error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
+       mutex_lock(&nfsd_mutex);
+       nn =3D net_generic(netns(file), nfsd_net_id);
+       if (!nn->nfsd_serv)
+               return -EINVAL;
+       mutex_unlock(&nfsd_mutex);
        nfsd4_revoke_states(netns(file), path.dentry->d_sb);

        path_put(&path);

However, your preference was to make use of nfsd_net_try_get()
function and here's my attempt:

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2b79129703d5..3ab22bab1d51 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -285,8 +285,10 @@ static ssize_t write_unlock_fs(struct file *file,
char *buf, size_t size)
         * 3.  Is that directory the root of an exported file system?
         */
        error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
+       if (!nfsd_net_try_get(netns(file)))
+               return -EINVAL;
        nfsd4_revoke_states(netns(file), path.dentry->d_sb);
-
+       nfsd_net_put(netns(file));
        path_put(&path);
        return error;
 }

But I'm confused that nfsd_net_try_get() has "__must_hold(rcu)" yet
when I look at usage of that function there is only one place that
calls under rcu_read_lock(). Thus I'm confused about the said
requirement. Also say if rca_read_lock was gotten before
nfsd_net_try_get() call can it be released directly after it or is it
supposed to be held over the call to nfssd4_revoke_states().

Neil/Chuck/Jeff please which of those 2 patches should I resend (and
if the 2nd one needs modifications as I said I'm too unsure about the
suggested approach).

Thank you.
>
> >
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 35004568d43e..faa874eff1e9 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -1775,6 +1775,9 @@ void nfsd4_revoke_states(struct net *net, str=
uct super_block *sb)
> > > >       unsigned int idhashval;
> > > >       unsigned int sc_types;
> > > >
> > > > +     if (!nn->nfsd_serv)
> > > > +             return;
> > > > +
> > >
> > > Seeing that nfsd4_revoke_states() doesn't make any reference to
> > > nfsd_serv, I think this change is - at best - confusing.
> >
> > This solution was in line with how the rest of proc functionality did
> > it (ie it checks whether or not the server is running).
>
> That code checks nfsd_serv while holding nfsd_mutex.  write_unlock_fs()
> does not take nfsd_mutex, so testing nfsd_serv in nfsd4_revoke_state()
> is racy.
>
> >
> > > As there is no lock held here, nfsd_serv could spontaneously become N=
ULL
> > > at any time, so this is unlikely to be a complete fix.
> >
> > I disagree that it's not a fix. As the main logic I think should be
> > that the unlock operation shouldn't be attempted if there isn't a
> > running server.
> >
> > However, what I think you are saying is that the server shutdown
> > cleanup should have cleaned things such that this error shouldn't
> > occur even if there isn't a check for the running server. While I see
> > the logic there, I find it more confusing to ignore the fact that we
> > are not checking for the running state of the server before trying to
> > perform an operation that assumes the server is running.
> >
> > > I would expect each conf_id_hashtbl[] list to be empty
> >
> > Not only is it empty, it's been freed by nfsd4_state_destroy_net() func=
tion.
> >
> > "systemctl start nfs-server" --- creates the conf_id_hashtbl
> > "systemctl stop nfs-server" --- ends up freeing it
> > echo path > unlock_filesystem --- has no conf_id_hashtbl.
> >
> > I still stand that the solution here is to check for the running
> > server. If you think the check nn->nfsd_net_up is better than checking
> > for null, I can do that.
> >
> > >  when no server is
> > > running so the function should do nothing.  Clearly my expectation is
> > > wrong, but I would like to know *why* it is wrong, and to fix the roo=
t
> > > cause.
> > >
> > >
> > > We also need this
> > >
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1778,7 +1778,7 @@ void nfsd4_revoke_states(struct net *net, struc=
t super_block *sb)
> > >         sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC=
_TYPE_LAYOUT;
> > >
> > >         spin_lock(&nn->client_lock);
> > > -       for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval=
++) {
> > > +       for (idhashval =3D 0; idhashval < CLIENT_HASH_SIZE; idhashval=
++) {
> > >                 struct list_head *head =3D &nn->conf_id_hashtbl[idhas=
hval];
> > >                 struct nfs4_client *clp;
> > >         retry:
> > >
> > > Maybe it should be part of the same patch - maybe not.
> >
> > I gather this is a needed change but insufficient to fix the issue and
> > should be a separate patch (as a fix for something but not this
> > problem).
>
> It is just a tangentially related bug that I noticed while reading the
> code.  Not really related to the bug you found, so it deserves to be a
> separate patch.  I'll send something.
>
> Thanks,
> NeilBrown

