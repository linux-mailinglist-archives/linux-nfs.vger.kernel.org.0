Return-Path: <linux-nfs+bounces-10673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F25A682C2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 02:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E0319C71A0
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 01:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281A24C062;
	Wed, 19 Mar 2025 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn0jDK23"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E524BC0F
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742347965; cv=none; b=sHtVJZDQbHpucDRzfbhCCnMkGKa/inVFqExM1EqdlKx107ld7EkHYBJVM4zHaQN2zq73RmJnClR7sEYSznDIwlYOZAAnBkkKlxoK8s0fblLAIoeroX4CT/K7Es3Yj11fI4vLS12G1GVsIMu8CbYSX7gDskfFPNoZOSmGSmpCMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742347965; c=relaxed/simple;
	bh=jy4cjt9stIbiUEW/N+T2rl2MLw1MzipEcBw+Bz20Ng4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6yMuoW2pWeI95/Asv4gcoQ9R/3gQL+I6DmQjwX4UTfgWnALoj6r6Z/juiOtWfgJF6uE0uMhecFfnG2NB1aCIo9dmzq6BcI6pRU+vPn7FsnmBtbUdO2fK7fztZYBKYbdKCaLUoqjdEE6G9Eqte4rwIRFNTg6IBVwl0524TeTNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn0jDK23; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso9098634a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 18:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742347962; x=1742952762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYr6quMRtpLf/VIFVTubWUQqa0uely0V0/fM8u51F3o=;
        b=Sn0jDK23rCsl8wREB54430OiEGUipk4JESedazWVZgHAzwEOJusPlcOsr8uSRBv3av
         e40ueEJurGyitznoDZzjanP9Om7EOxhhDiBUV1AcguIVtASylZ1y5cdR68UFuiSDX/DX
         VV2b3+/BUBsVTpctwb+c5taMauMCqBGMD1g7qakWgNU4Nbae9C8scHswXTu4x3N2emry
         urmpqasR35u/POd4MDQuLs0j0e6dDOAJ7ipEOdX+VcahuawqE8fndxwB54UsL4x64aMD
         tGK5IWoAPUSWiw390DINMracD2Wj64KvyOWygAClTVa2wspSlPFktuIX+JKT2CJgAxKG
         F//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742347962; x=1742952762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYr6quMRtpLf/VIFVTubWUQqa0uely0V0/fM8u51F3o=;
        b=EGgNpN2fCRTUxq3REMlVARuru2iOXOLy5IdrhLGjpVHCmcI5cAWTgWDsQZkzlnmTAi
         +gFYYi+yFrAobI0Ur8/F+GvSvFlXJOIlBlOLH6YZW46UQrdz2fe/H4mRvLPxaqJNvtdX
         NzL2Jcso1tMAGLdtL4hozFF6kNNVMx5iLJLj5EKHfBaMoLWiL1P7iCVuTpN7NwKrSVkq
         SgH8aA9ulj7MG1qifAMASb/b5ckIRUS64nCLkCeljHyauXmJTfK7TVZ1k7vHO9VepOir
         i9zocZerOv4Uyha8kNWiP19+lYKtl/U+9EDCsTMprJNeJan0zPVgKM46GMomfvpb9fh+
         mepw==
X-Forwarded-Encrypted: i=1; AJvYcCWjx/8yb39H8hAwFapuMWWgMZR7KaWXfmLInpbpkKiIldhTZ1/yD1zFm/JFwgtpPOenQAFAYt1v5Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6p1p84jXK2+sb8Ao7fQ8Lb7b/RbFlnAVYUjZnlZE7ZHtiEyeV
	Kga/i8Cq4SXW5feGlmeGBheFYa0ul3gF79n2kqonCljCa1i4jbMnQGfYNjO1eBS1rsJ0hfdNfnF
	g/vlB0n3biVreXSpFgS7TH7q1Vg==
X-Gm-Gg: ASbGncuMSpWAmRMVyi29bmGJ4whP19iTwke/DB0qNj68mKyOj/FeAr2iSouYEewEjFJ
	z8+RIx6TbWAVQfO/RZPVG4FKj5aiBtScCo3hpLzjrq9puy2dzXuaehNwn/HZJyJqyUMJgRZHTtL
	UoUkbM1PnCB71UJL83UCPB7E4pLlw1WRrJ34j7hl8IUy80afFzuJjG95RfkNE=
X-Google-Smtp-Source: AGHT+IFo4fzyd99qsAJLgxhwN5x7d74fy+upRdm3KWfVwRErQUgjjbDbWoaNJgA//FgUBH0bm+Bvi2pZSML3Y2Zn7is=
X-Received: by 2002:a05:6402:510b:b0:5e0:58ca:6706 with SMTP id
 4fb4d7f45d1cf-5eb80fcdea1mr723336a12.30.1742347961700; Tue, 18 Mar 2025
 18:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com> <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
 <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
 <CAPJSo4WrOnWfLzmfoCcj1MuYQQBHo434vTK=9qx+rh_FCVck=w@mail.gmail.com>
 <e21645871fd6249d93f9bb33b154c3663eaf0a70.camel@hammerspace.com>
 <CAM5tNy5ZA5MKuCsFQHXE_uBkmMv3eBH7dgonaTrk9Rk-p2jA0g@mail.gmail.com> <09c573463b19a1d1f4b1e50484faa657d3c3aa28.camel@hammerspace.com>
In-Reply-To: <09c573463b19a1d1f4b1e50484faa657d3c3aa28.camel@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 18 Mar 2025 18:32:27 -0700
X-Gm-Features: AQ5f1JqDHJVlXKsrZ2mx8x4c6vGaqU0tmomIzhCTbA0ZlPeIUBLpV1CQ7y-N314
Message-ID: <CAM5tNy7pbpYk0-dwHtOSRj=S2S0CALK2v_Z-Sxe9pt3waLdiPA@mail.gmail.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "lionelcons1972@gmail.com" <lionelcons1972@gmail.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>, 
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:00=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Tue, 2025-03-18 at 16:52 -0700, Rick Macklem wrote:
> > On Tue, Mar 18, 2025 at 4:40=E2=80=AFPM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Tue, 2025-03-18 at 23:37 +0100, Lionel Cons wrote:
> > > > On Tue, 18 Mar 2025 at 22:17, Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Tue, 2025-03-18 at 14:03 -0700, Rick Macklem wrote:
> > > > > >
> > > > > > The problem I see is that WRITE_SAME isn't defined in a way
> > > > > > where
> > > > > > the
> > > > > > NFSv4 server can only implement zero'ng and fail the rest.
> > > > > > As such. I am thinking that a new operation for NFSv4.2 that
> > > > > > does
> > > > > > writing
> > > > > > of zeros might be preferable to trying to (mis)use
> > > > > > WROTE_SAME.
> > > > >
> > > > > Why wouldn't you just implement DEALLOCATE?
> > > > >
> > > >
> > > > Oh my god.
> > > >
> > > > NFSv4.2 DEALLOCATE creates a hole in a sparse file, and does NOT
> > > > write zeros.
> > > >
> > > > "holes" in sparse files (as created by NFSV4.2 DEALLOCATE)
> > > > represent
> > > > areas of "no data here". For backwards compatibility these holes
> > > > do
> > > > not produce read errors, they just read as 0x00 bytes. But they
> > > > represent ranges where just no data are stored.
> > > > Valid data (from allocated data ranges) can be 0x00, but there
> > > > are
> > > > NOT
> > > > holes, they represent VALID DATA.
> > > >
> > > > This is an important difference!
> > > > For example if we have files, one per week, 700TB file size
> > > > (100TB
> > > > per
> > > > day). Each of those files start as a completely unallocated space
> > > > (one
> > > > big hole). The data ranges are gradually allocated by writes, and
> > > > the
> > > > position of the writes in the files represent the time when they
> > > > were
> > > > collected. If no data were collected during that time that space
> > > > remains unallocated (hole), so we can see whether someone
> > > > collected
> > > > data in that timeframe.
> > > >
> > > > Do you understand the difference?
> > > >
> > >
> > > Yes. I do understand the difference, but in this case you're
> > > literally
> > > just talking about accounting. The sparse file created by
> > > DEALLOCATE
> > > does not need to allocate the blocks (except possibly at the
> > > edges). If
> > > you need to ensure that those empty blocks are allocated and
> > > accounted
> > > for, then a follow up call to ALLOCATE will do that for you.
> > Unfortunately ZFS knows how to deallocate, but not how to allocate.
>
> So there is no support for the posix fallocate function? Well in the
> worst case, your NFS server will just have to emulate it.
The NFS server cannot emulate it (writing a block of zeros with
write does not guarantee a future write of the same byte range won't
fail with ENOSPACE.
--> The FreeBSD NFSv4.2 server replies NFS4ERR_NOTSUPP.

The bothersome part is "there is a hint in the NFSv4.2 RFC that
support is "per server" and not "per file system".  As such, the server
replies NFS4ERR_NOTSUPP even if there is a mix of UFS and ZFS
file systems exported. (UFS can do allocate.)

Now, what happens when fallocate() is attempted on ZFS?
It should fail, but I am not sure. If it succeeds, I would consider
that a bug.

>
> > >
> > > $ touch foo
> > > $ stat foo
> > >   File: foo
> > >   Size: 0               Blocks: 0          IO Block: 4096   regular
> > > empty file
> > > Device: 8,17    Inode: 410924125   Links: 1
> > > Access: (0644/-rw-r--r--)  Uid: (0/ root)   Gid: (0/ root)
> > > Context: unconfined_u:object_r:user_home_t:s0
> > > Access: 2025-03-18 19:26:24.113181341 -0400
> > > Modify: 2025-03-18 19:26:24.113181341 -0400
> > > Change: 2025-03-18 19:26:24.113181341 -0400
> > >  Birth: 2025-03-18 19:25:12.988344235 -0400
> > > $ truncate -s 1GiB foo
> > > $ stat foo
> > >   File: foo
> > >   Size: 1073741824      Blocks: 0          IO Block: 4096   regular
> > > file
> > > Device: 8,17    Inode: 410924125   Links: 1
> > > Access: (0644/-rw-r--r--)  Uid: (0/ root)   Gid: (0/ root)
> > > Context: unconfined_u:object_r:user_home_t:s0
> > > Access: 2025-03-18 19:26:24.113181341 -0400
> > > Modify: 2025-03-18 19:27:35.161694301 -0400
> > > Change: 2025-03-18 19:27:35.161694301 -0400
> > >  Birth: 2025-03-18 19:25:12.988344235 -0400
> > > $ fallocate -z -l 1GiB foo
> > > $ stat foo
> > >   File: foo
> > >   Size: 1073741824      Blocks: 2097152    IO Block: 4096   regular
> > > file
> > > Device: 8,17    Inode: 410924125   Links: 1
> > > Access: (0644/-rw-r--r--)  Uid: (0/ root)   Gid: (0/ root)
> > > Context: unconfined_u:object_r:user_home_t:s0
> > > Access: 2025-03-18 19:26:24.113181341 -0400
> > > Modify: 2025-03-18 19:27:54.462817356 -0400
> > > Change: 2025-03-18 19:27:54.462817356 -0400
> > >  Birth: 2025-03-18 19:25:12.988344235 -0400
> > >
> > >
> > > Yes, I also realise that none of the above operations actually
> > > resulted
> > > in blocks being physically filled with data, but all modern flash
> > > based
> > > drives tend to have a log structured FTL. So while overwriting data
> > > in
> > > the HDD era meant that you would usually (unless you had a log
> > > based
> > > filesystem) overwrite the same physical space with data, today's
> > > drives
> > > are free to shift the rewritten block to any new physical location
> > > in
> > > order to ensure even wear levelling of the SSD.
> > Yea. The Wr_zero operation writes 0s to the logical block. Does that
> > guarantee there is no "old block for the logical block" that still
> > holds
> > the data? (It does say Wr_zero can be used for secure erasure, but??)
> >
> > Good question for which I don't have any idea what the answer is,
> > rick
>
> In both the above arguments, you are talking about specific filesystem
> implementation details that you'll also have to address with your new
> operation.
All the operation spec. needs to say is "writes zeros to the file byte rang=
e"
and make it clear that the 0s written is data and not a hole.
(As for whether or not there is hardware offload is a server implementation
detail.)

As for guarantees w.r.t. data being overwritten, I think that would be
beyond what would be required.
(Data erasure is an interesting but different topic for which I do not
have any expertise.)

rick


>
> >
> > >
> > > IOW: there is no real advantage to physically writing out the data
> > > unless you have a peculiar interest in wasting time.
> > >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

