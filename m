Return-Path: <linux-nfs+bounces-18662-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOiIFRYngmnPPgMAu9opvQ
	(envelope-from <linux-nfs+bounces-18662-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Feb 2026 17:49:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB257DC3DD
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Feb 2026 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C5D30737DE
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Feb 2026 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16323D331A;
	Tue,  3 Feb 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="JRxvx7iu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7A39E6ED
	for <linux-nfs@vger.kernel.org>; Tue,  3 Feb 2026 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137129; cv=pass; b=OkA7FXaHglQqZvORTSy2FH7ce+8pgPqqbCUGGBEyzbr0La09BWySK3fTuYjvhqiG6FZ1OW9oyLeyXNQy2mEO5h+eqaLXk9WPiCOr7CPAlqWG0kyI0xCbVTuBM/vm5vueMprVRTP6gT//4SjRWtNPVF17U2OLObtXQvx1zbGTYU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137129; c=relaxed/simple;
	bh=bO8dhNUjJ4X670TfqZgQ2YUgd1dsCj0kbvqJU6a2u1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hp0xuLkpOnQp8q9QGkIGyV0WUjBpuR2t3/BSC0WC9yJFN2gPUKQhuGDcSP1fwhsYtMreTWXYaXE+qJVpLs8zPlKeRSUEByG/PXj0R6WAg/w1VO5kMxsf5fBtP4BRMQoup4mSgBHHr49SMhohj7RIxxXNKVr5ZTzUctTLE7Vpjwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=JRxvx7iu; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso6232181e87.0
        for <linux-nfs@vger.kernel.org>; Tue, 03 Feb 2026 08:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770137126; cv=none;
        d=google.com; s=arc-20240605;
        b=ddCCkbPkLQM8Z5ekcdq2xAYYouWrq37OOaT1qtW1X2xlvtK3Y/D7bvWiH82mDu/QuW
         RCRXmseStgEsZyZNPCTA09LlCQULeKDt5MJalZZoOoxbafSb42qdDizM+R2sPh7prHNA
         do++9GHp1ChhWWsI8wfEYgP6tbl4KmHLA3XpiZIK7+G0C9guBqPFzFiQ870rojCrb2fb
         8zRB9fspZdtL66WuvO39Ewtfxp6PVATxI+OU0eMuismXn2goKLKhmQ4lLuSbE6phXb7r
         +2+n3KHkSEcEmkE8Itkq2tDyiTlD+YmFb4k8YB6EbstuvrPq2kU3r7CikqDv8cepBZJK
         NF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ygUUZtDkOgFMPRztTwX96v8DDz1QuLmF2t43V3sE79A=;
        fh=LDdwU1I/Ma2+bOFOIih5lWaPjbnVT/cfNu8vOILNirw=;
        b=hHA1sc29/mAn7R/OeWl0Sfn+2wUBRNoCAsv5BrvHNjcJh3akE7BCkIwP1RmWEf1Adc
         nEEOFRwlXmGioyf1sSFrqY22vt8/gEXx1O/BhZe9XWHGUV6UocoGdNygYdMMhKDCqIba
         3jw5a0CZf4xI6TLj/xqxpVZMD+HdH5lKeQq4f504+/2vTMxyGtzMvUesxObFIORKVoNh
         w7jQsA7VYTawDwfEVhbSF74hbfgFf/p631Bv8RS5qdou2bZ0b9/GIk059I3wqE6fx/rN
         2vrePeuGpfx5PspKZ9IY1qr+l9XKqHkXHalqQ8ostndKaJlsRFNdwuDbIF8SFSJBT9DP
         jA4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770137126; x=1770741926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ygUUZtDkOgFMPRztTwX96v8DDz1QuLmF2t43V3sE79A=;
        b=JRxvx7iudoAYOhNvTeURknB/2jI7vfKyrHcTGNjdEgRZor6HoBLtEe+lVvTKXla07V
         TodE4/SQSSizO0it8nsKjnpktroWxPQYCOfoth2WCZzR+EYrDO0WyFSwBB+TiD2VjENn
         vNNufCWcuZp+yiZJ/m8OGWr8vcJ6R40re6yRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770137126; x=1770741926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygUUZtDkOgFMPRztTwX96v8DDz1QuLmF2t43V3sE79A=;
        b=Hc2GL//NdRMsbbrcOcMrjsjOBF15aYhIKIEfrerqZE8KBTSZ9afSY0lcyxkp7UjxPi
         xVJnOBWeQOjld/FDBn1geDC/E7HDQIYJ05i4774EsWYul/eI4fFlQ/gPOVYE4r2XVcN3
         7o3NcCzGwNmjJYSkGN8K4viYdGCJl4t41vHPULNcloLW36BI+rhlkUtAYNubbpA2bKKS
         NOd6+NNPPBz7YWeEJcCbBXH2BkxU/vvlc9rDmcpaLcg3QO4XPRPf5yU9OVco9HwNywWp
         1rpMsWHpl9VkAwohlfXWnWPXfuzBuRAwL5pYLwE3o7tBzl3V/zH4aIhThEnBrT1rI4kC
         fc1g==
X-Forwarded-Encrypted: i=1; AJvYcCV287TA8VF80SPKRyXbaNTQCVHLLXiNCVf0OzB/svqaaDTnHO7VMUQMMP0/aBiPz0tje9XH1wOxi4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWN7Fm3gn3WiKVJBqvetH6nkxiw6sOgf50bKOxKu0JXesP6Yg
	0wSafhT1aPgEv/9MIRa1UFoDUl71m5vBnMQm0PDaVc0OHzZr7TdHxpgiulI55dT1qWdWMDvj3Cb
	AAB8FoAhrfFqnp1Mc/FfAvG1cAJv5OiPWHebvNE8HMw==
X-Gm-Gg: AZuq6aIXeOdWYFeN+cpYYgH/fHyhr0hic6Mnj/782RAX9jJFoiyde3Pa/Xlw8h1iciY
	xQhomKFjiW0gtaChxRTDRufGXajSvBAz1I/W4yYGP52D4IgSo4/AKxJHGsbFPCOyzMrWfu25ka7
	9B/brMBOniZiI4mlk7NISHRchNax1FS5JOEgrt9suo5vEfSC+/PQQ0jvp8KGjAfHY5CVfH5kSMP
	gaghyvS3ZleEJ8C/ThyGB2hG4PvT3BQrKmxHp82hi7+6tyQIZYo52AS8rnlKnqiZ30awg==
X-Received: by 2002:a05:6512:4012:b0:59e:2020:7e53 with SMTP id
 2adb3069b0e04-59e20207f54mr4877220e87.11.1770137125969; Tue, 03 Feb 2026
 08:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
 <CAJqdLrphO1GnAZ2=n8wQAP7B+ZwFnD0wSLY7sAjacZTpLZrqBg@mail.gmail.com>
 <6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org> <20260203-genehm-senden-f0375c2ca2b6@brauner>
In-Reply-To: <20260203-genehm-senden-f0375c2ca2b6@brauner>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 3 Feb 2026 17:45:13 +0100
X-Gm-Features: AZwV_QhbCo7XE4Hglp7OWCWOuSnYjjdtA-Lepc4tiiQWFh3d9Uj7O2E0mh_yXBU
Message-ID: <CAJqdLrp-LMVNng0F2xx1C0BtYvcidokZm6_tdssE+Z57v+tpqA@mail.gmail.com>
Subject: Re: [PATCH] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-18662-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mihalicyn.com:+]
X-Rspamd-Queue-Id: BB257DC3DD
X-Rspamd-Action: no action

Am Di., 3. Feb. 2026 um 17:41 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> On Tue, Feb 03, 2026 at 11:21:25AM -0500, Jeff Layton wrote:
> > On Tue, 2026-02-03 at 17:11 +0100, Alexander Mikhalitsyn wrote:
> > > Am Do., 29. Jan. 2026 um 22:48 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
> > > >
> > > > Commit e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems
> > > > without FS_USERNS_MOUNT") prevents the mount of any filesystem inside a
> > > > container that doesn't have FS_USERNS_MOUNT set.
> > > >
> > >
> > > Hi Jeff,
> > >
> > > > This broke NFS mounts in our containerized environment. We have a daemon
> > > > somewhat like systemd-mountfsd running in the init_ns. A process does a
> > > > fsopen() inside the container and passes it to the daemon via unix
> > > > socket.
> > > >
> > > > The daemon then vets that the request is for an allowed NFS server and
> > > > performs the mount. This now fails because the fc->user_ns is set to the
> > > > value in the container and NFS doesn't set FS_USERNS_MOUNT.  We don't
> > > > want to add FS_USERNS_MOUNT to NFS since that would allow the container
> > > > to mount any NFS server (even malicious ones).
> > > >
> > > > Add a new FS_USERNS_DELEGATABLE flag, and enable it on NFS.
> > >
> > > Great idea, very similar to what we have with BPFFS/BPF Tokens.
> > >
> > > Taking into account this patch, shouldn't we drop FS_USERNS_MOUNT and
> > > replace it with
> > > FS_USERNS_DELEGATABLE for bpffs too?
> > >
> > > I mean something like:
> > >
> > > ======================
> > > $ git diff
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 9f866a010dad..d8dfdc846bd0 100644
> > > --- a/kernel/bpf/inode.c
> > > +++ b/kernel/bpf/inode.c
> > > @@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block
> > > *sb, struct fs_context *fc)
> > >         struct inode *inode;
> > >         int ret;
> > >
> > > -       /* Mounting an instance of BPF FS requires privileges */
> > > -       if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> > > -               return -EPERM;
> > > -
> > >         ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
> > >         if (ret)
> > >                 return ret;
> > > @@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
> > >         .init_fs_context = bpf_init_fs_context,
> > >         .parameters     = bpf_fs_parameters,
> > >         .kill_sb        = bpf_kill_super,
> > > -       .fs_flags       = FS_USERNS_MOUNT,
> > > +       .fs_flags       = FS_USERNS_DELEGATABLE,
> > >  };
> > >
> > >  static int __init bpf_init(void)
> > > ======================
> > >
> > > Because it feels like we were basically implementing this FS_USERNS_DELEGATABLE
> > > flag implicitly for BPFFS before. I can submit a patch for BPFFS later
> > > after testing.
>
> Can you send that to the list, please?

Sure, I'll do that a bit later! I'm still in Brussels ;-)

> Thanks!

