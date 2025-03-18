Return-Path: <linux-nfs+bounces-10664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69EAA67FDE
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 23:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FEF19C200B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FFB2066CF;
	Tue, 18 Mar 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDULokIv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE01DDC21
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337465; cv=none; b=V2OwS8rNaWrFdBMREF6Q1KHiXjM/sU6M4te6FElCKDKvTTWdMH37uUZqtqhVds9vK+5bRzU0qcgDIbexeNiBepcZ0zLo0LMk7rHaaulkvsE4v8JkmGzCHH81KbY+3/uaUU5bhjlNn6xj2jB0RpsjmON5KP7ywa4Nt4MK53JTYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337465; c=relaxed/simple;
	bh=3VeCnZvpbRj2PntNv88a59MhyTZ7BzrLRcV7mwHokmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2u/nSHkcWoNuWompv7s79cxdtXYVASgaSTQsQakt7VYaqTkMvapzQBd0ur6kDvioa3JO9V7U3BmWSmm4ffhQJJzxdDyW1eUNGfVfpHofTAKRXQqu8AUbc+2bkSkB8E47Fj0Xma1iHkj3jtzWLg+oDUFlwwS7HA81GmNjEePnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDULokIv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso9049530a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742337462; x=1742942262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3VeCnZvpbRj2PntNv88a59MhyTZ7BzrLRcV7mwHokmA=;
        b=EDULokIv8/y4qp7fOXecH1DwyPMMHFEsEB9rlJobVvDr5gqfdw+S6pJ6kUT0jqdwGB
         w57Vur7XZ8IHuN3ClV8+4CNXdfnN8dIzLix+nk1gATYu82nU249L2/d6PusxX+CFeiLc
         UmvmRkBAutt2oEYGix/97slcJYbBklYdA1o8BdzKnfHhqzKlLE7LLbRftPBkgxxwn3PV
         TymcvZEpzHoczGFWPA1KZf7wkB6TEnCm22CXZ4BUBIGFwxTArtT3u0xvrJYE/BS7ZVTL
         0yX0bRBnjambNIlX3FDuArndyiNVP22+QDDKVlvrT7RVHMSBiPm9GNV/cFmdol2h7tLG
         4APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742337462; x=1742942262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VeCnZvpbRj2PntNv88a59MhyTZ7BzrLRcV7mwHokmA=;
        b=q7m0qodtt01tWveHQsjZO8+zLO6LD17Pw9ppd11yztY7kUqP+9dp3db23YZQfncAmd
         Ufv3lmSFaAgiSvzAplMcd7xBFYNxNBO/Lhp532CxPfFY0PtYqSChAVpEtL3frMeYgciq
         vKAFA7Fr7EMvQd7HNZFH8uqIdaPLzTMG1rRiZIz+YicyoI8E0A4q0UbmkkMEk0J773pd
         BT3uyCbn4NPmExJodCHIq37yzpTSpJG539SLsoHdbPNd4il2z9gt4zJbDwPZjQFr5XaY
         yItduHMtuzm29kFx7eCNuocGJIUSEVCttVGlbVVViT/cHHJpE2cDb0IX4PBMgnQEVQc0
         /4uA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+YmEQ5GvPCCxTddWKO4o9FNibe8AafSIXjrTvKn5SSLb2ITep6vj2ofoSt5mDQKRk6P0NZ+eXmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLNdb3cu45KeNC56krl4NDk6P/zbNQAPjUb+J4gq+lMg7pD8HI
	wgtdjRUJbtrvUnP5FTZmqVcU3zFs+Otq/GRt4Ko9t6NYCCRQ6ikkRrVzrJb081GLhnEGqAGGvhN
	va9CVJ4XfckU8GVVkrkxRYNzIv44jPw==
X-Gm-Gg: ASbGnct/sxXEjAJOLP+NpC4x4MOEVLHwjGEDFQIon5bgc2Bxp2CjFcxXo8zfqPkWpKC
	IUM7VDQH14HZGQOU4TNRuVKhwv8ZOMGIUQwZcpoevavAmiIuXbQFimDXg/U+9YOgd7kk+L9BBsv
	yJq0gS/k9L40g604eXKlpNChPAAfs=
X-Google-Smtp-Source: AGHT+IHaYNeGQRlk5O0i53KI4yUXqNQhwjItYQjhKUylpOcmEffD7zenAwZgZfyJUkaktE91fwf3cEowN3R9aw6TkGs=
X-Received: by 2002:a05:6402:254d:b0:5e4:a88a:657 with SMTP id
 4fb4d7f45d1cf-5eb80fcaeb0mr511051a12.28.1742337461973; Tue, 18 Mar 2025
 15:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com> <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com> <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
In-Reply-To: <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 18 Mar 2025 23:37:05 +0100
X-Gm-Features: AQ5f1JrGTGhEcmf7K853Viz2TiQeSX0jup9RrAmRlGPQdYKU1ZXqjbItDQZaJRg
Message-ID: <CAPJSo4WrOnWfLzmfoCcj1MuYQQBHo434vTK=9qx+rh_FCVck=w@mail.gmail.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "rick.macklem@gmail.com" <rick.macklem@gmail.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>, 
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 22:17, Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2025-03-18 at 14:03 -0700, Rick Macklem wrote:
> >
> > The problem I see is that WRITE_SAME isn't defined in a way where the
> > NFSv4 server can only implement zero'ng and fail the rest.
> > As such. I am thinking that a new operation for NFSv4.2 that does
> > writing
> > of zeros might be preferable to trying to (mis)use WROTE_SAME.
>
> Why wouldn't you just implement DEALLOCATE?
>

Oh my god.

NFSv4.2 DEALLOCATE creates a hole in a sparse file, and does NOT write zeros.

"holes" in sparse files (as created by NFSV4.2 DEALLOCATE) represent
areas of "no data here". For backwards compatibility these holes do
not produce read errors, they just read as 0x00 bytes. But they
represent ranges where just no data are stored.
Valid data (from allocated data ranges) can be 0x00, but there are NOT
holes, they represent VALID DATA.

This is an important difference!
For example if we have files, one per week, 700TB file size (100TB per
day). Each of those files start as a completely unallocated space (one
big hole). The data ranges are gradually allocated by writes, and the
position of the writes in the files represent the time when they were
collected. If no data were collected during that time that space
remains unallocated (hole), so we can see whether someone collected
data in that timeframe.

Do you understand the difference?

Lionel

