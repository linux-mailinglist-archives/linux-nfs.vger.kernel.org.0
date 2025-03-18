Return-Path: <linux-nfs+bounces-10668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37B9A680EB
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 00:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5083ACC27
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 23:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449DF1DD0D5;
	Tue, 18 Mar 2025 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlQE02S9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94C1C5F2C
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341958; cv=none; b=gfCWFI11zWGOWAaouovHgvnGy7RaNyaaa+PCP582TU35QS1IiKaOqaZQL2/kGy5QqRe8tFJQMhujdZr117wzrlID8bEaYayC0C39ySxeWfuz1AErkxykjtnOt+vVUmcxNJFZSNchx8tIdxdycYhZu3KgVCkKTFxkxJidBWRgZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341958; c=relaxed/simple;
	bh=OlmqDL2RrETjYsGCjU830/2LcV2MsEtWx8EZhrEqz2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2zUvSR8NtMVzu9L/Dzq5oevmG6O7mu7SA0s3xp1vcO9EI9PHjNq+v6mf9Kdo7luvo7EW1l1Zlf/ZyOLTcVpBIV6WdjeLeZXToODTD9OZaRvzrE1ggg68x1F+qyu/vrCaCxgPuMqtkTsyiEH8bIUENsy9W1W1t1ihPO6/kJ+WF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlQE02S9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso10622671a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742341955; x=1742946755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1HSu5qbfE3Sj/n4ap0qeyNwQ8qcPjHSrkmp0tceajk=;
        b=jlQE02S9LZldO6dmm6BJDpAO0iQ70Qr0FZGxx7IPSXyKKfM02zHKR216gOMF5qxjBk
         LehvACb+tvcMDpfvGJ2d1rMlk3pT/tahxSH6UQkMpONKkcLslNlQbkvjgzaYhHl1QrSJ
         4xKOwMHniKXiu9XNS51/6f20YjhKGcXCK4NTaM/UMYwXO0BOkIm3ajo8tLe4fI7OOAnS
         k1lDlSs7FvY4/v8RCWLI1KBcrKBsekPGu1NoibKtdXCe5oMLjWmqsOXiUrU3MzDuc/xn
         B94jhyc1WOP3hgAZsKh35MEWXSIJTjNY/fkpIhHco12h7du6spky+kD8162eLe6t2r08
         50HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742341955; x=1742946755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1HSu5qbfE3Sj/n4ap0qeyNwQ8qcPjHSrkmp0tceajk=;
        b=SEIwUMZ6KoxwY/jYIJdo4/UBcvL10d/KDSBjJR2zRnkA3mKDwF5XU5Ll1YVApy6FcU
         uaTyG80ldW58Ug9EVfi/crzBRKhOI2SGedVhHLl906klCtTErahyzVbcfv26NkvcqW0f
         a3w12aduNvspFvysus2BWKc13tJLau9I0JA5x5jW94mAStxkZYkZDV2hMo53DefQCPsS
         jBa4kysePCgtusjeuRPt1gSMW6sQQ0dG8PZcqTN0UbXm7qSwTfs8ckYbhINSC08T/nXG
         xBBdLLTlFZtuvFcxyzrfwDLVhbIiphCR29DhgxqJCi2Xs/yIx+hA+xKIDQlLRaCuBBDW
         E/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg1TDCYWcpuXANN6LF1q/PsoqFnIy7VHMjFo3u9YG10xkFkKVr2c8VqKEaauutTrfsqs/wNnjMKmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMUD22yjuORSN5lEWGU+XPlB8V2dxmntq1idF1YueamR2A3v+
	iaw73/Eh0KHYkJEhy9q7lVtrXw8qytBeBuvFQ0qO1CPH2wDmNKLbRrUh4L0OqGm3D18eW8Yz+te
	8wI91xCm5lsil5XkusSZd8g4cHQ==
X-Gm-Gg: ASbGncsB99NhctoFbhnJDV3ZkbsJbG78vVWaHOiG4TFiXQdy0OLcAvly3+IyqiwAvc8
	XSHt8Z/sZoBuKwVgP00XTZrlzjdya01szwN/+XAqcVy0iaiDyWn+wj+rgiGNXHbEhinWOJRdKhU
	ODTT6xCrmDl8T1ARXu6ae6FAwFLxX95yBDfJuUqHDj+9Xq0XpW/Q3eomSXTys=
X-Google-Smtp-Source: AGHT+IHWucOZKrAm1XYlwQ5MqOYrC961Bma+Fm1fw7pGyC4e8zpDBKaisNTuckzTASt3DL+23H2u7g+dmcyRUwMDiFE=
X-Received: by 2002:a05:6402:42c7:b0:5e0:60ed:f355 with SMTP id
 4fb4d7f45d1cf-5eb80d4908fmr599142a12.18.1742341954377; Tue, 18 Mar 2025
 16:52:34 -0700 (PDT)
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
 <CAPJSo4WrOnWfLzmfoCcj1MuYQQBHo434vTK=9qx+rh_FCVck=w@mail.gmail.com> <e21645871fd6249d93f9bb33b154c3663eaf0a70.camel@hammerspace.com>
In-Reply-To: <e21645871fd6249d93f9bb33b154c3663eaf0a70.camel@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 18 Mar 2025 16:52:20 -0700
X-Gm-Features: AQ5f1Joz-cIbKGcQRREkDWsre3Pj1NOJZPdLxVs1FWWgcYcl_s_Y8JgV6uuPkcI
Message-ID: <CAM5tNy5ZA5MKuCsFQHXE_uBkmMv3eBH7dgonaTrk9Rk-p2jA0g@mail.gmail.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "lionelcons1972@gmail.com" <lionelcons1972@gmail.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>, 
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:40=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Tue, 2025-03-18 at 23:37 +0100, Lionel Cons wrote:
> > On Tue, 18 Mar 2025 at 22:17, Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Tue, 2025-03-18 at 14:03 -0700, Rick Macklem wrote:
> > > >
> > > > The problem I see is that WRITE_SAME isn't defined in a way where
> > > > the
> > > > NFSv4 server can only implement zero'ng and fail the rest.
> > > > As such. I am thinking that a new operation for NFSv4.2 that does
> > > > writing
> > > > of zeros might be preferable to trying to (mis)use WROTE_SAME.
> > >
> > > Why wouldn't you just implement DEALLOCATE?
> > >
> >
> > Oh my god.
> >
> > NFSv4.2 DEALLOCATE creates a hole in a sparse file, and does NOT
> > write zeros.
> >
> > "holes" in sparse files (as created by NFSV4.2 DEALLOCATE) represent
> > areas of "no data here". For backwards compatibility these holes do
> > not produce read errors, they just read as 0x00 bytes. But they
> > represent ranges where just no data are stored.
> > Valid data (from allocated data ranges) can be 0x00, but there are
> > NOT
> > holes, they represent VALID DATA.
> >
> > This is an important difference!
> > For example if we have files, one per week, 700TB file size (100TB
> > per
> > day). Each of those files start as a completely unallocated space
> > (one
> > big hole). The data ranges are gradually allocated by writes, and the
> > position of the writes in the files represent the time when they were
> > collected. If no data were collected during that time that space
> > remains unallocated (hole), so we can see whether someone collected
> > data in that timeframe.
> >
> > Do you understand the difference?
> >
>
> Yes. I do understand the difference, but in this case you're literally
> just talking about accounting. The sparse file created by DEALLOCATE
> does not need to allocate the blocks (except possibly at the edges). If
> you need to ensure that those empty blocks are allocated and accounted
> for, then a follow up call to ALLOCATE will do that for you.
Unfortunately ZFS knows how to deallocate, but not how to allocate.

>
> $ touch foo
> $ stat foo
>   File: foo
>   Size: 0               Blocks: 0          IO Block: 4096   regular empty=
 file
> Device: 8,17    Inode: 410924125   Links: 1
> Access: (0644/-rw-r--r--)  Uid: (0/ root)   Gid: (0/ root)
> Context: unconfined_u:object_r:user_home_t:s0
> Access: 2025-03-18 19:26:24.113181341 -0400
> Modify: 2025-03-18 19:26:24.113181341 -0400
> Change: 2025-03-18 19:26:24.113181341 -0400
>  Birth: 2025-03-18 19:25:12.988344235 -0400
> $ truncate -s 1GiB foo
> $ stat foo
>   File: foo
>   Size: 1073741824      Blocks: 0          IO Block: 4096   regular file
> Device: 8,17    Inode: 410924125   Links: 1
> Access: (0644/-rw-r--r--)  Uid: (0/ root)   Gid: (0/ root)
> Context: unconfined_u:object_r:user_home_t:s0
> Access: 2025-03-18 19:26:24.113181341 -0400
> Modify: 2025-03-18 19:27:35.161694301 -0400
> Change: 2025-03-18 19:27:35.161694301 -0400
>  Birth: 2025-03-18 19:25:12.988344235 -0400
> $ fallocate -z -l 1GiB foo
> $ stat foo
>   File: foo
>   Size: 1073741824      Blocks: 2097152    IO Block: 4096   regular file
> Device: 8,17    Inode: 410924125   Links: 1
> Access: (0644/-rw-r--r--)  Uid: (0/ root)   Gid: (0/ root)
> Context: unconfined_u:object_r:user_home_t:s0
> Access: 2025-03-18 19:26:24.113181341 -0400
> Modify: 2025-03-18 19:27:54.462817356 -0400
> Change: 2025-03-18 19:27:54.462817356 -0400
>  Birth: 2025-03-18 19:25:12.988344235 -0400
>
>
> Yes, I also realise that none of the above operations actually resulted
> in blocks being physically filled with data, but all modern flash based
> drives tend to have a log structured FTL. So while overwriting data in
> the HDD era meant that you would usually (unless you had a log based
> filesystem) overwrite the same physical space with data, today's drives
> are free to shift the rewritten block to any new physical location in
> order to ensure even wear levelling of the SSD.
Yea. The Wr_zero operation writes 0s to the logical block. Does that
guarantee there is no "old block for the logical block" that still holds
the data? (It does say Wr_zero can be used for secure erasure, but??)

Good question for which I don't have any idea what the answer is, rick

>
> IOW: there is no real advantage to physically writing out the data
> unless you have a peculiar interest in wasting time.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

