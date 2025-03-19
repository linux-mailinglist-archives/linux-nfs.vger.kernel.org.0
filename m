Return-Path: <linux-nfs+bounces-10675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C6A682D5
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 02:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9CA17529C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAE124EA95;
	Wed, 19 Mar 2025 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exDLXIGf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE924DFE3
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348601; cv=none; b=WKACwj/BLlo348pRarCHH+O9ar5SVpjPKAMnpNizJGcw93YdMc5PDugFGEFlJ78zusWZHqNZI1YnUVvWWCuLA5UurZWeiKI85lhaCu6mzXoDyAXexvDPvnf3wRlde9RKrmZF5mfy1Ug/En6YEekQOJmo5S+VJkGKCNBygiBLp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348601; c=relaxed/simple;
	bh=u/xXKqv8I6bHEBECO/gTwsnRWBpJETKVGwthz//InPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTxXCT5gU+KWfyxeEed+KDx+0f1mqz9zRNdk8WCCXpNC+LtSRkZ7k3XJyIs2aUQlPOPfb7ygONjDP5fuzNQaGnmFtkL0MBR3+oL+VxxcXi9cXAOuS15Syo20LEhqYWDvh7N/Lj4dSvwMm9mV/wyuYlnHbWTLeiEuA4bS1eoVyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exDLXIGf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so11826677a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742348597; x=1742953397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcwlh/GUCQWc0XlVc3FymBxNECPzO13sSA8GoPVW5lE=;
        b=exDLXIGfAEa9SfVOuZQMhZSD6y+eNhJvBDcT4OhvfGrbWVC7DyXcha/WwTr0xq0XsH
         D32XnFCJ1X1k3dqamOZpBfc30wik8QA11KXDJJzZ/K4ZDrAoYuf8kwoAvPkHuIJ4Ujic
         RdeU0ksOOIjiEpCt40GHXqMOyLWpYrdiU7q581iTF9eqqgXpiF8VuXO84tWmntB8PDXt
         aRRTz9JYvgxDhNuvvBig2MXJTE713pk3Z0dKr/UhyTdZ5sasVEJDuFkVLvm/5LVgLINQ
         BEfYQ9H7s8x5JuQS//kqo4exzix97Zvk6ebn/Zv8WWe76smclzypJccpMZgGwyqY1FIc
         gexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348597; x=1742953397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcwlh/GUCQWc0XlVc3FymBxNECPzO13sSA8GoPVW5lE=;
        b=KhVBcqO3Uhy8UvNCYHxaJH9B4f4IwDZns6xM2B+TY2FH46Y3x4u1G8WFn3D8MVIsA6
         Wz2vhoWfRLe8RkRyEu/b03MSrHOH+qQj2qFaMOIPgI6L+p5Up+22UvEYTQf8NqavPaZW
         hOsWp3eTUe18salMWsdCfkZbXYLYnUXyeZ46eN+LWN4RT6ABBKuyGXvhVuyYVhMcxE5g
         DBa7bf3xu0jfm/r+NhAYWLknMRKAUZsgJt38jv/eOnKO47fwyCR94Mf/gUKfp7Y1X8bz
         Mvlt9tx9CwkkXxQQpIROzkMrKvOxk1BfiBjt4xkOnu7wIT2jq2pP6ltAZMB7D2iTCXtB
         PRRg==
X-Forwarded-Encrypted: i=1; AJvYcCVkGppCa2lGu9sLtrCGrjqvoZLHGKfZRLHnj6jA5fX50wmGTOmF+xJGNqGccASbIyrgsR+kUJ6xVOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/GaUOqqyuCa0gejpts+D1s7Sl255OcHyLzlNSULE3RXd7eboF
	M5GsTqIM7wU7hADz78K1beTmmKm1bYnq+FnIqoLOSdPUVCOgUKYxzsznQ/yGegwKr/xOTtHFOgW
	onR1gVMgM5k7g+b+UB9I/dqmJug==
X-Gm-Gg: ASbGncuDlS5Fus4NHN2FO249oRYqNIhC4JcdMf/F/Uj09jurCbsvKOsXfU2gIp2W3gc
	/jmUD8xsR4IaDhDPH0G8/C4swTIRbdhlPTYuw6LoHmwAFgXBHpNozkHvPwGeaJDGdS/RdnLqjR1
	xVAB/6Xx0bt3OilZz/f8ip8BtfmY2n6tgreRuX0rF/y63h9bAsqoLBWMg4CkM=
X-Google-Smtp-Source: AGHT+IGHQhz52G2S25R5pEL80SqoPIF1/kx7mhVX8MQPk31S0QxpapeeHATLoZYGAMP5QIVa1AWj+LSpLj+PaoTPhME=
X-Received: by 2002:a05:6402:d0d:b0:5e6:60da:dc45 with SMTP id
 4fb4d7f45d1cf-5eb80f98067mr578210a12.31.1742348597300; Tue, 18 Mar 2025
 18:43:17 -0700 (PDT)
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
 <CAM5tNy5ZA5MKuCsFQHXE_uBkmMv3eBH7dgonaTrk9Rk-p2jA0g@mail.gmail.com>
 <09c573463b19a1d1f4b1e50484faa657d3c3aa28.camel@hammerspace.com> <CAM5tNy7pbpYk0-dwHtOSRj=S2S0CALK2v_Z-Sxe9pt3waLdiPA@mail.gmail.com>
In-Reply-To: <CAM5tNy7pbpYk0-dwHtOSRj=S2S0CALK2v_Z-Sxe9pt3waLdiPA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 18 Mar 2025 18:43:02 -0700
X-Gm-Features: AQ5f1JqKDAM8g1nioeH_dKNZygNnOgbpbrQi7WcOaFeslyfjMyEG9M_M6KIPFfY
Message-ID: <CAM5tNy4Nq1cNb+DPhpa3KMCBNFWQHP-b0tg9hJiwayOnvDpsYg@mail.gmail.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "lionelcons1972@gmail.com" <lionelcons1972@gmail.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>, 
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:32=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Tue, Mar 18, 2025 at 5:00=E2=80=AFPM Trond Myklebust <trondmy@hammersp=
ace.com> wrote:
> >
> > On Tue, 2025-03-18 at 16:52 -0700, Rick Macklem wrote:
> > > On Tue, Mar 18, 2025 at 4:40=E2=80=AFPM Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > >
> > > > On Tue, 2025-03-18 at 23:37 +0100, Lionel Cons wrote:
> > > > > On Tue, 18 Mar 2025 at 22:17, Trond Myklebust
> > > > > <trondmy@hammerspace.com> wrote:
> > > > > >
> > > > > > On Tue, 2025-03-18 at 14:03 -0700, Rick Macklem wrote:
> > > > > > >
> > > > > > > The problem I see is that WRITE_SAME isn't defined in a way
> > > > > > > where
> > > > > > > the
> > > > > > > NFSv4 server can only implement zero'ng and fail the rest.
> > > > > > > As such. I am thinking that a new operation for NFSv4.2 that
> > > > > > > does
> > > > > > > writing
> > > > > > > of zeros might be preferable to trying to (mis)use
> > > > > > > WROTE_SAME.
> > > > > >
> > > > > > Why wouldn't you just implement DEALLOCATE?
> > > > > >
> > > > >
> > > > > Oh my god.
> > > > >
> > > > > NFSv4.2 DEALLOCATE creates a hole in a sparse file, and does NOT
> > > > > write zeros.
> > > > >
> > > > > "holes" in sparse files (as created by NFSV4.2 DEALLOCATE)
> > > > > represent
> > > > > areas of "no data here". For backwards compatibility these holes
> > > > > do
> > > > > not produce read errors, they just read as 0x00 bytes. But they
> > > > > represent ranges where just no data are stored.
> > > > > Valid data (from allocated data ranges) can be 0x00, but there
> > > > > are
> > > > > NOT
> > > > > holes, they represent VALID DATA.
> > > > >
> > > > > This is an important difference!
> > > > > For example if we have files, one per week, 700TB file size
> > > > > (100TB
> > > > > per
> > > > > day). Each of those files start as a completely unallocated space
> > > > > (one
> > > > > big hole). The data ranges are gradually allocated by writes, and
> > > > > the
> > > > > position of the writes in the files represent the time when they
> > > > > were
> > > > > collected. If no data were collected during that time that space
> > > > > remains unallocated (hole), so we can see whether someone
> > > > > collected
> > > > > data in that timeframe.
> > > > >
> > > > > Do you understand the difference?
> > > > >
> > > >
> > > > Yes. I do understand the difference, but in this case you're
> > > > literally
> > > > just talking about accounting. The sparse file created by
> > > > DEALLOCATE
> > > > does not need to allocate the blocks (except possibly at the
> > > > edges). If
> > > > you need to ensure that those empty blocks are allocated and
> > > > accounted
> > > > for, then a follow up call to ALLOCATE will do that for you.
> > > Unfortunately ZFS knows how to deallocate, but not how to allocate.
> >
> > So there is no support for the posix fallocate function? Well in the
> > worst case, your NFS server will just have to emulate it.
> The NFS server cannot emulate it (writing a block of zeros with
> write does not guarantee a future write of the same byte range won't
> fail with ENOSPACE.
> --> The FreeBSD NFSv4.2 server replies NFS4ERR_NOTSUPP.
>
> The bothersome part is "there is a hint in the NFSv4.2 RFC that
> support is "per server" and not "per file system".  As such, the server
> replies NFS4ERR_NOTSUPP even if there is a mix of UFS and ZFS
> file systems exported. (UFS can do allocate.)
>
> Now, what happens when fallocate() is attempted on ZFS?
> It should fail, but I am not sure. If it succeeds, I would consider
> that a bug.
>
> >
> > > >
> > > > $ touch foo
> > > > $ stat foo
> > > >   File: foo
> > > >   Size: 0               Blocks: 0          IO Block: 4096   regular
> > > > empty file
> > > > Device: 8,17    Inode: 410924125   Links: 1
> > > > Access: (0644/-rw-r--r--)  Uid: (0/ root)   Gid: (0/ root)
> > > > Context: unconfined_u:object_r:user_home_t:s0
> > > > Access: 2025-03-18 19:26:24.113181341 -0400
> > > > Modify: 2025-03-18 19:26:24.113181341 -0400
> > > > Change: 2025-03-18 19:26:24.113181341 -0400
> > > >  Birth: 2025-03-18 19:25:12.988344235 -0400
> > > > $ truncate -s 1GiB foo
> > > > $ stat foo
> > > >   File: foo
> > > >   Size: 1073741824      Blocks: 0          IO Block: 4096   regular
> > > > file
> > > > Device: 8,17    Inode: 410924125   Links: 1
> > > > Access: (0644/-rw-r--r--)  Uid: (0/ root)   Gid: (0/ root)
> > > > Context: unconfined_u:object_r:user_home_t:s0
> > > > Access: 2025-03-18 19:26:24.113181341 -0400
> > > > Modify: 2025-03-18 19:27:35.161694301 -0400
> > > > Change: 2025-03-18 19:27:35.161694301 -0400
> > > >  Birth: 2025-03-18 19:25:12.988344235 -0400
> > > > $ fallocate -z -l 1GiB foo
> > > > $ stat foo
> > > >   File: foo
> > > >   Size: 1073741824      Blocks: 2097152    IO Block: 4096   regular
> > > > file
> > > > Device: 8,17    Inode: 410924125   Links: 1
> > > > Access: (0644/-rw-r--r--)  Uid: (0/ root)   Gid: (0/ root)
> > > > Context: unconfined_u:object_r:user_home_t:s0
> > > > Access: 2025-03-18 19:26:24.113181341 -0400
> > > > Modify: 2025-03-18 19:27:54.462817356 -0400
> > > > Change: 2025-03-18 19:27:54.462817356 -0400
> > > >  Birth: 2025-03-18 19:25:12.988344235 -0400
> > > >
> > > >
> > > > Yes, I also realise that none of the above operations actually
> > > > resulted
> > > > in blocks being physically filled with data, but all modern flash
> > > > based
> > > > drives tend to have a log structured FTL. So while overwriting data
> > > > in
> > > > the HDD era meant that you would usually (unless you had a log
> > > > based
> > > > filesystem) overwrite the same physical space with data, today's
> > > > drives
> > > > are free to shift the rewritten block to any new physical location
> > > > in
> > > > order to ensure even wear levelling of the SSD.
> > > Yea. The Wr_zero operation writes 0s to the logical block. Does that
> > > guarantee there is no "old block for the logical block" that still
> > > holds
> > > the data? (It does say Wr_zero can be used for secure erasure, but??)
> > >
> > > Good question for which I don't have any idea what the answer is,
> > > rick
> >
> > In both the above arguments, you are talking about specific filesystem
> > implementation details that you'll also have to address with your new
> > operation.
> All the operation spec. needs to say is "writes zeros to the file byte ra=
nge"
> and make it clear that the 0s written is data and not a hole.
> (As for whether or not there is hardware offload is a server implementati=
on
> detail.)
Oh, and it would also need to deal with the case of "partial success".
(In the NFSV4.2 tradition, it could return the # of bytes of zeros written.=
)

rick

>
> As for guarantees w.r.t. data being overwritten, I think that would be
> beyond what would be required.
> (Data erasure is an interesting but different topic for which I do not
> have any expertise.)
>
> rick
>
>
> >
> > >
> > > >
> > > > IOW: there is no real advantage to physically writing out the data
> > > > unless you have a peculiar interest in wasting time.
> > > >
> > > > --
> > > > Trond Myklebust
> > > > Linux NFS client maintainer, Hammerspace
> > > > trond.myklebust@hammerspace.com
> > > >
> > > >
> > >
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >

