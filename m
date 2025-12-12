Return-Path: <linux-nfs+bounces-17056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E3ACB9624
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 17:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76C07300261F
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14552DC784;
	Fri, 12 Dec 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="KIo0Ahs5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D04247280
	for <linux-nfs@vger.kernel.org>; Fri, 12 Dec 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558523; cv=none; b=YmNJzgPIZfNO+4VKlGpEv74Kpn3PZiSMPNZ2IIPJ/tzxAXVcn6bMhEhBl/WiU59YzUeD2JR+K2mGWkrXE95+HVyfO04lsMnFx6hv62hM+DZtCjHAL5RWKSsfH53Wl2BwZbc8EiEy+zRzG+Oo1vMDPzI+F6QsqOIgCrjDphrB0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558523; c=relaxed/simple;
	bh=9YP7a5PAGzENUkR+vT8zRJ31bLvm0UOf6CpdVitUQmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6Tg2F2fekJAViiSwlNJtPlmAHjYZTXN7MU8E0EvTRPMeoI/QOJn13Tw/SaXEpZx5J5nisgF3WM5MlVxiDTzAkR2nC3X4Xf2YWlNieiDfZeVA5GpNVSkr1Wlpx5Q3zDtyBhAxA3x3sLiCDa9gpa2wMmaGdTcW9YuPiIM9cbjnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=KIo0Ahs5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a34702a20so10877341fa.3
        for <linux-nfs@vger.kernel.org>; Fri, 12 Dec 2025 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1765558520; x=1766163320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjClQgNTKOM09T1xfh/unYKbpQOEfZnPkK236h91Mek=;
        b=KIo0Ahs5dsBGQTYaFbha+qI79Ft71LRrtOn7j9cgOckyrMOurI7D5xlfqzsW32g/MA
         AFZcTPWbdIpHKan/SY3CZ2jyV5WlugHhHCio0PeW2HwET4/QC0XMuLclFcKV8nRPXcHa
         V+Q0QqKqNPV/MdjntVUHopzzJXM6UBHH9HuBKTuspfMGpQxanLtVJNsOmnrluePVK7sE
         Q47/eLPxDUuOsdPd0Td0hKZLP+kFxuCKoiYooyMg86Crba82/URpG3gkq2Wic61QEMJX
         5ohVwoCHjDMHA/ahYT1tEyft0fZ0qKnIkoFwm+LjlRJYaI76X1FQeZQRoRbOHIzUQD1Z
         HmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765558520; x=1766163320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjClQgNTKOM09T1xfh/unYKbpQOEfZnPkK236h91Mek=;
        b=G1Y44RxLjRK4qE+EWLQsflGYk/nQyj+Q5ayKB6T3/WHVuzvpmUdwBvKmB7wfDpa4Zl
         Y2OY7XQX5JcL2UR9LXbuBs8x0OZ/bBs8mL/JW2zi9PIN91WmG2aTUp1oZ4w1dNgx4IWA
         r0oCIC2tj14IT24IbGgwKHg4P2f5gOUYNzuZdl5a8CyDtOKZvX9YA0ZT1GfGEriSxbTs
         78cL1V5Ed4q4Z7qW+GefIswtiNi5fmUgjl0kjsFs6OLkSjRkAiOFl3cm6uwuOaM/895i
         2AnALKY7YkF6n2aDLOSfVckErWVttImOfBOnCuQ+g7qoZcoRNvbwQC24S9jz2PaAQTxc
         Xw5w==
X-Forwarded-Encrypted: i=1; AJvYcCVkIAvQZ2B6R+S7nyjsyBvmFLJ00OR9A1lUwX1Xt3J9ek78VCdmSH98HqGF5aVZigSnH+P+O3jJgwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpu/hhcX4tlMVB7YdWqIVLVVaUGCIIxrcVIiSvFghyVEI/Noio
	6A4pc9vVixevqirlYk/tRvutqzf3xt7XuzKXwWJDfj57dzImXoXPhDrImzyzMntF8zqiW9p3hwe
	KhwSd1j16x9bZ22K/irdobtmTDYxktfY=
X-Gm-Gg: AY/fxX496Fi+JbypTBRwzmNESa/2042RiC0/qy/WQcAc8lJZhGpt50Jb3Rtn6mYJbey
	8VW4kGBu5ztukvyt2VVOa9KgpHBvM7/KDLOO9C76vhwObtxUnu3yTIXOeAG7BHfRi8lktMvryi5
	Ds0zwxwQyuEkRxo5FuydGQmkJrkmW41brkQjq0E0KRgjSUoibpfY9PA90QRsOiv3IYg8l2eO3yE
	G4lTgYZpMwXnqE3nIHyreSydQ4CphH/CNKIos2yb1apK3zQ2cbsKma3CNrcRIf++oH5BfwMjGIF
	SFHgUlzijEhzjD8BT8QhQ7cbJAbPSvrvresvtaqY
X-Google-Smtp-Source: AGHT+IHFueV0UwRFn8dbnH+gv08OwbtyK7FN1LhVZX+HCPQ8A071mTXrIxIQydEAc4SoWDgHIr20HQfRNsw54wWyLmA=
X-Received: by 2002:a05:651c:325b:b0:37f:af92:1c10 with SMTP id
 38308e7fff4ca-37fd0712974mr8643931fa.9.1765558519481; Fri, 12 Dec 2025
 08:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205184156.10983-1-okorniev@redhat.com> <176508180496.16766.14577514890223630313@noble.neil.brown.name>
 <CAN-5tyFNgMk0j37ZnhiRqKK8LoLChb25_oCjvo5LWsjapGJL9w@mail.gmail.com>
 <176522947804.16766.1562289482158759372@noble.neil.brown.name>
 <CAN-5tyE6DEoH9r2SH=3BwxM8vaQoYF83Zk9+s_iq3Vk6MKSV1w@mail.gmail.com> <176549518259.16766.11594053603722440783@noble.neil.brown.name>
In-Reply-To: <176549518259.16766.11594053603722440783@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 12 Dec 2025 11:55:07 -0500
X-Gm-Features: AQt7F2pB5WEgwhPoqXPjBJXS1xVJ6iEUYLnZnVLIhhTrPHDIx3Fdlev9JToCVE8
Message-ID: <CAN-5tyHJKKOvHnxJ0rUu6efJTKbJSjrCk0TuvvXOP1PU+OG73w@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: check that server is running in unlock_filesystem
To: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 6:19=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Thu, 11 Dec 2025, Olga Kornievskaia wrote:
> > On Mon, Dec 8, 2025 at 4:31=E2=80=AFPM NeilBrown <neilb@ownmail.net> wr=
ote:
> > >
> > > On Tue, 09 Dec 2025, Olga Kornievskaia wrote:
> > > > On Sat, Dec 6, 2025 at 11:30=E2=80=AFPM NeilBrown <neilb@ownmail.ne=
t> wrote:
> > > > >
> > > > > On Sat, 06 Dec 2025, Olga Kornievskaia wrote:
> > > > > > If we are trying to unlock the filesystem via an administrative
> > > > > > interface and nfsd isn't running, it crashes the server.
> > > > > >
> > > > > > [   59.445578] Modules linked in: nfsd nfs_acl lockd grace nfs_=
localio ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qr=
tr rfkill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobu=
f2_memops uvc videobuf2_v4l2 videobuf2_common snd_hda_intel snd_intel_dspcf=
g snd_hda_codec videodev snd_hda_core snd_hwdep mc snd_seq snd_seq_device s=
nd_pcm snd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock=
_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs ghash_=
ce nvme e1000e nvme_core nvme_keyring nvme_auth hkdf sr_mod cdrom vmwgfx dr=
m_ttm_helper ttm 8021q garp stp llc mrp sunrpc dm_mirror dm_region_hash dm_=
log iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath =
dm_mod nfnetlink
> > > > > > [   59.451979] CPU: 4 UID: 0 PID: 5193 Comm: bash Kdump: loaded=
 Tainted: G    B               6.18.0-rc4+ #74 PREEMPT(voluntary)
> > > > > > [   59.453311] Tainted: [B]=3DBAD_PAGE
> > > > > > [   59.453913] Hardware name: VMware, Inc. VMware20,1/VBSA, BIO=
S VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > [   59.454869] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT =
-SSBS BTYPE=3D--)
> > > > > > [   59.455463] pc : nfsd4_revoke_states+0x1b4/0x898 [nfsd]
> > > > >
> > > > > But *why* does it crash?
> > > >
> > > > > Can you please
> > > > >    ./scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_revoke_states+0=
x1b4/0x898
> > > > >
> > > > > and report what line of code it is crashing on?
> > > >
> > > > okorniev@linux-10:/source/linux$ ./scripts/faddr2line
> > > > fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4/0x898
> > > > nfsd4_revoke_states+0x1b4/0x898:
> > > > find_one_sb_stid at /source/linux/fs/nfsd/nfs4state.c:1748
> > > > (inlined by) nfsd4_revoke_states at /source/linux/fs/nfsd/nfs4state=
.c:1786
> > >
> > > Thanks.  As you suggest it is likely accessing memory that we freed b=
y
> > > nfsd_shutdown_net().  By the time it gets into find_one_sb_stid() it
> > > would have already accessed some freed memory so it was lucky to get
> > > that far.
> > >
> > > Code that wants to access conf_id_hash and related parts of nn should
> > > use:
> > >
> > >   nfsd_net_try_get(net)
> > >
> > > to check if it is safe and to keep it safe, and then nfsd_net_put(net=
)
> > > when it has finished.  That is more robust than simply checking nfsd_=
serv.
> >
> > I'm confused by the guidance given.
>
> Probably the guidance was confused.
>
> >
> > I understood that other uses of nn->nfsd_server did so by grabbing the
> > nfsd_mutex lock. Thus, I ask, if it would be acceptable to do. Again,
> > I vote for this as it's the same as what the other proc uses (note,
> > unsure what the appropriate error code here should be).
>
> Yes it would be acceptable to use nfsd_mutex.
> I don't like nfsd_mutex and would like to get rid of it.  In most
> cases there is no desire to wait, only to ensure other code waits before
> destroying anything, and that fits the refcount pattern better.
>
> But we have nfsd_mutex now so it isn't wrong to use it.
>
>
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 2b79129703d5..fcd026db553c 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -259,6 +259,7 @@ static ssize_t write_unlock_fs(struct file *file,
> > char *buf, size_t size)
> >         struct path path;
> >         char *fo_path;
> >         int error;
> > +       struct nfsd_net *nn;
> >
> >         /* sanity check */
> >         if (size =3D=3D 0)
> > @@ -285,6 +286,11 @@ static ssize_t write_unlock_fs(struct file *file,
> > char *buf, size_t size)
> >          * 3.  Is that directory the root of an exported file system?
> >          */
> >         error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> > +       mutex_lock(&nfsd_mutex);
> > +       nn =3D net_generic(netns(file), nfsd_net_id);
> > +       if (!nn->nfsd_serv)
> > +               return -EINVAL;
> > +       mutex_unlock(&nfsd_mutex);
> >         nfsd4_revoke_states(netns(file), path.dentry->d_sb);
>
> If you move the mutex_unlock to *after* the nfsd4_revoke_states() call,
> this should be correct.
>
> It might be nicer to change nfsd4_revoke_states() to take an nfsd_net
> rather than a net, then you could just pass 'nn', but it isn't a big deal=
.
>
> >
> >         path_put(&path);
> >
> > However, your preference was to make use of nfsd_net_try_get()
> > function and here's my attempt:
> >
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 2b79129703d5..3ab22bab1d51 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -285,8 +285,10 @@ static ssize_t write_unlock_fs(struct file *file,
> > char *buf, size_t size)
> >          * 3.  Is that directory the root of an exported file system?
> >          */
> >         error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> > +       if (!nfsd_net_try_get(netns(file)))
> > +               return -EINVAL;
> >         nfsd4_revoke_states(netns(file), path.dentry->d_sb);
> > -
> > +       nfsd_net_put(netns(file));
>
> This looks correct - except that it might need rcu protection as you
> note below.
>
> >         path_put(&path);
> >         return error;
> >  }
> >
> > But I'm confused that nfsd_net_try_get() has "__must_hold(rcu)" yet
> > when I look at usage of that function there is only one place that
> > calls under rcu_read_lock(). Thus I'm confused about the said
> > requirement. Also say if rca_read_lock was gotten before
> > nfsd_net_try_get() call can it be released directly after it or is it
> > supposed to be held over the call to nfssd4_revoke_states().
>
> That __must_hold(rcu) is wrong - sort of.
> It should be in the .h file as well to be at all useful.
> The important thing is that a stable ref should be held to 'net', and
> rcu is one have a stable reference is via rcu.
>
> I think rcu is needed inside nfsd_net_try_get() to ensure that if 'nn'
> is not NULL, then percpu_ref_tryget_live() cannot access freed memory.
> I think it is currently safe because when netd_net_try_get() is called
> without rcu_read_lock, there is already a ref held and the code is just
> trying to get an extra one.
>
> In general, if rcu is used to stablise 'net', then nfsd_net_try_get()
> will stablise it more permanently and also stablise the nfsd-specific
> parts of 'net'.  So after nfsd_net_try_get() succeeds, rcu_read_lock()
> is no longer needed.
>
> >
> > Neil/Chuck/Jeff please which of those 2 patches should I resend (and
> > if the 2nd one needs modifications as I said I'm too unsure about the
> > suggested approach).
>
> Given the uncertainties around rcu, it is probably best use the
> nfsd_mutex approach, as long as the we don't unlock until after the work
> is done.

Thank you Neil. V2 is sent.
>
> Thanks,
> NeilBrown

