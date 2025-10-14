Return-Path: <linux-nfs+bounces-15251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62050BDAED0
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 20:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE0624EADED
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507191C5D57;
	Tue, 14 Oct 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="cA7/SS/Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB724DCEF
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466031; cv=none; b=sdmmzQZ8oh/68YEmxEZX7QFsxrx9VSExx47BsVEJvHcyeOYiVNyYEDLKVj84Thx4o3E+ZlfpHyZi2Fe68gep/Cl/1kCuDiAJA0TklhjnqZeQmU/iEyL8QpHTQWsKCiDHGlMRPUn+D2ay/0BvfSe8aKsef6Lkkl7tFr/AbAXAjA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466031; c=relaxed/simple;
	bh=7rJ420caESCVKPmWKA2s24zTwvo59HlMyaRVRA47C3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAFwQmZGfv7/m3Q+7NQfD+NRUqXAdQsoKxqieWpkvDhIyvhPFWWBa5YR5APT9NPLmoFgwwhy/uaV+thcMJCKYQcGVdL7dkHYj+2E5a0frkkbBM8hNfRvyW9aNrCfgLnqeUvMu+QvVGEZmn2tzfYoKCDA4RwOasC+ERymRB2EWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=cA7/SS/Q; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57e36125e8aso1994610e87.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1760466027; x=1761070827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyxwePsqTyfAeXX6sgCwgNv652bBiH7VtqmJJnqLwgo=;
        b=cA7/SS/QfwTCT0eIDyHOmV/rp6Os5CEVOXMB2c27YDN4aD8NNUuoyiiJZYuSGIMyHb
         CWz3AtD+ShTtgAbvJDsN04AMjHn+o13etY8+nJFyzRonVZb22E8A1k4IHFN4Sirs1DgO
         Nel2GBl9mDejJsnCnQl2fOrvL1E4rUHyZtXCHBL2oAo7r92j0MURbVuroRLI8cKGx8It
         1AIPeiLolyoc6LgvCyTbz1DC+AFwQ/B4D+C77dc5+QxAHgySc0u3UYz5tuulQrR+BC1X
         4WQwOC9KtcCfDRbP2/T1ESEo+wPO1/+oyTbeWFf52OiZF7yR5ODOqhY/1jwQ5SHY+ID3
         nmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466027; x=1761070827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyxwePsqTyfAeXX6sgCwgNv652bBiH7VtqmJJnqLwgo=;
        b=BWm+dQd0EtqrdjwJcBLzG/k3n4wt6b8gEQiQCgk01H/CBNGL1yww2if0DCFjMJ3fXw
         e1P/3BTXiTVeCQSzf16ULSar9Mb6/mpKIGD07CMFKTFv52nFD/nRqbCLDbZujT4wiS/b
         Z40zyogdU1iRIVp64T95UyXtuxM+0g0pbjpQhooL5h7z6dFgjfugPPi1cXO0b98en3II
         Qfb/DmaWsK9UulMM2ZZfo+mBvBvGrG336rP8QDO/tTqscxghDt1XJ7lO9QrhGVIWjT1Z
         IvbokGtVAzn3Y07NM4OJFFX/QaAlrbpJhcsCaWNbYZJXMxqhRMm0AHwRLeittYRxmEeH
         1iDA==
X-Forwarded-Encrypted: i=1; AJvYcCUaY+PFixNz7ftGu2d6rEBvNg+WTMhv+6TfDj7CeRi9GWh93By4VWVCtqgCvsgtFD86scQmkQFRpjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdII5byDzrMuprunDLYFXUMKBKx7VjW5bDQIJ+wfkM6YDUquJy
	JrP9I5ugZuDHMQvPg7SmE2XRFNmrTFL/KBSF2m5elebZpL6lNPUDV6Sm3R5caXfN+3nkL+FCe5C
	I7jfZLE3sHOVUaqBwBrUJ5zJPVOwhaxo=
X-Gm-Gg: ASbGncuYsoAREd3szrQpuajZ8uEI1NMquoss/bG7m4OAa0aLGcg1qCl0485AUfnJdre
	EVpma35a+GH0x4Ql4tfUbPwTLoHbxeaANjZ5Wbwz1MjVDshzIP00KXwKAi1EXHwc13iNuzBScuh
	1qmWjDkwUR6cJ/g5dXmEYQzON1LyhkVn79vvk27O2aYKn2i75bLxEsWcebGSIO+JqiHrYtsC1Vg
	UT56c/ZYiKslgL/YAEYU6eUaaTjpJvbXwELPrBNpRzTMAkwVjVHqA3DqaMU
X-Google-Smtp-Source: AGHT+IF/6PwOIPuoNXmMeJzXodxizrRYPpU6T/CNEnb2eYmxuRB+Prp0AaQH9sqrKhbcS44iitlUF3tk9EpUljFvXjE=
X-Received: by 2002:a05:651c:199f:b0:373:a5ad:639 with SMTP id
 38308e7fff4ca-37609ce62c7mr68562181fa.8.1760466026970; Tue, 14 Oct 2025
 11:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014175959.90513-1-okorniev@redhat.com> <53d794cc-daa8-489a-8fcc-173e5cb8ef75@oracle.com>
In-Reply-To: <53d794cc-daa8-489a-8fcc-173e5cb8ef75@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 14 Oct 2025 14:20:14 -0400
X-Gm-Features: AS18NWD-C3lDLL8GLseG6Lnn3uAoggcR9qZLalEFY9XqJ7YmMN_Hrb_7BhPg9mI
Message-ID: <CAN-5tyEPpeQt8eRXkP2MgnnPBmjKY6cZSe6k8wVL53GDr2445g@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: free copynotify stateid in nfs4_free_ol_stateid()
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 2:05=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 10/14/25 1:59 PM, Olga Kornievskaia wrote:
> > Typically copynotify stateid is freed either when parent's stateid
> > is being close/freed or in nfsd4_laundromat if the stateid hasn't
> > been used in a lease period.
> >
> > However, in case when the server got an OPEN (which created
> > a parent stateid), followed by a COPY_NOTIFY using that stateid,
> > followed by a client reboot. New client instance while doing
> > CREATE_SESSION would force expire previous state of this client.
> > It leads to the open state being freed thru release_openowner->
> > nfs4_free_ol_stateid() and it finds that it still has copynotify
> > stateid associated with it. We currently print a warning and is
> > triggerred
> >
> > WARNING: CPU: 1 PID: 8858 at fs/nfsd/nfs4state.c:1550 nfs4_free_ol_stat=
eid+0xb0/0x100 [nfsd]
> >
> > This patch, instead, frees the associated copynotify stateid here.
> >
> > If the parent stateid is freed (without freeing the copynotify
> > stateids associated with it), it leads to the list corruption
> > when laundromat ends up freeing the copynotify state later.
> >
> > [ 1626.839430] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> > [ 1626.842828] Modules linked in: nfnetlink_queue nfnetlink_log bluetoo=
th cfg80211 rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs_acl lockd grace nf=
s_localio ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer =
qrtr rfkill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc video=
buf2_memops snd_hda_intel uvc snd_intel_dspcfg videobuf2_v4l2 videobuf2_com=
mon snd_hda_codec snd_hda_core videodev snd_hwdep snd_seq mc snd_seq_device=
 snd_pcm snd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vso=
ck_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021=
q garp stp llc mrp nvme ghash_ce e1000e nvme_core sr_mod nvme_keyring nvme_=
auth cdrom vmwgfx drm_ttm_helper ttm sunrpc dm_mirror dm_region_hash dm_log=
 iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_=
mod nfnetlink
> > [ 1626.855594] CPU: 2 UID: 0 PID: 199 Comm: kworker/u24:33 Kdump: loade=
d Tainted: G    B   W           6.17.0-rc7+ #22 PREEMPT(voluntary)
> > [ 1626.857075] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> > [ 1626.857573] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201=
.00V.24006586.BA64.2406042154 06/04/2024
> > [ 1626.858724] Workqueue: nfsd4 laundromat_main [nfsd]
> > [ 1626.859304] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BT=
YPE=3D--)
> > [ 1626.860010] pc : __list_del_entry_valid_or_report+0x148/0x200
> > [ 1626.860601] lr : __list_del_entry_valid_or_report+0x148/0x200
> > [ 1626.861182] sp : ffff8000881d7a40
> > [ 1626.861521] x29: ffff8000881d7a40 x28: 0000000000000018 x27: ffff000=
0c2a98200
> > [ 1626.862260] x26: 0000000000000600 x25: 0000000000000000 x24: ffff800=
0881d7b20
> > [ 1626.862986] x23: ffff0000c2a981e8 x22: 1fffe00012410e7d x21: ffff000=
0920873e8
> > [ 1626.863701] x20: ffff0000920873e8 x19: ffff000086f22998 x18: 0000000=
000000000
> > [ 1626.864421] x17: 20747562202c3839 x16: 3932326636383030 x15: 3030666=
666662065
> > [ 1626.865092] x14: 6220646c756f6873 x13: 0000000000000001 x12: ffff600=
04fd9e4a3
> > [ 1626.865713] x11: 1fffe0004fd9e4a2 x10: ffff60004fd9e4a2 x9 : dfff800=
000000000
> > [ 1626.866320] x8 : 00009fffb0261b5e x7 : ffff00027ecf2513 x6 : 0000000=
000000001
> > [ 1626.866938] x5 : ffff00027ecf2510 x4 : ffff60004fd9e4a3 x3 : 0000000=
000000000
> > [ 1626.867553] x2 : 0000000000000000 x1 : ffff000096069640 x0 : 0000000=
00000006d
> > [ 1626.868167] Call trace:
> > [ 1626.868382]  __list_del_entry_valid_or_report+0x148/0x200 (P)
> > [ 1626.868876]  _free_cpntf_state_locked+0xd0/0x268 [nfsd]
> > [ 1626.869368]  nfs4_laundromat+0x6f8/0x1058 [nfsd]
> > [ 1626.869813]  laundromat_main+0x24/0x60 [nfsd]
> > [ 1626.870231]  process_one_work+0x584/0x1050
> > [ 1626.870595]  worker_thread+0x4c4/0xc60
> > [ 1626.870893]  kthread+0x2f8/0x398
> > [ 1626.871146]  ret_from_fork+0x10/0x20
> > [ 1626.871422] Code: aa1303e1 aa1403e3 910e8000 97bc55d7 (d4210000)
> > [ 1626.871892] SMP: stopping secondary CPUs
> >
>
> Reported-by: <rtm@csail.mit.edu>
> Closes:
> https://lore.kernel.org/linux-nfs/d8f064c1-a26f-4eed-b4f0-1f7f608f415f@or=
acle.com/T/#t
> Cc: stable@vger.kernel.org
>

To clarify, you want v2 with these lines added?
(do you want me to add "cc: stable" too)?

>
> > Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfs4state.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 1c01836e8507..c197438765db 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1542,7 +1542,8 @@ static void nfs4_free_ol_stateid(struct nfs4_stid=
 *stid)
> >       release_all_access(stp);
> >       if (stp->st_stateowner)
> >               nfs4_put_stateowner(stp->st_stateowner);
> > -     WARN_ON(!list_empty(&stid->sc_cp_list));
> > +     if (!list_empty(&stid->sc_cp_list))
> > +             nfs4_free_cpntf_statelist(stid->sc_client->net, stid);
> >       kmem_cache_free(stateid_slab, stid);
> >  }
> >
>
>
> --
> Chuck Lever
>

