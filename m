Return-Path: <linux-nfs+bounces-13071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7008BB05641
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB05E16D299
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556512D5C74;
	Tue, 15 Jul 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="W9TVkvuG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2B2D4B6C
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571489; cv=none; b=ASvAS9SSeR0bvb46ApG3Gw2n2A9sI+0ar+R3/QORFCiVZd0BKaxHjeVisodLSVVRW9WRZR0fXf7DFDyzxHT4twNt1rlsLX28upN3SLzCRQ4/p7T0IqRz5t3pFl2KB57a+eTIzhpkK13IpDKdsxhs+7aeiatdi09C15dg/S2evlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571489; c=relaxed/simple;
	bh=AcJQr+zA3rTMRaiSbiOE1SA04hozVmZxLirNLn7OWnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpTD8iWPgjik6wHG1JdApOGkhA2iH5afneHkFHNmvz6wHJqPopbCY2FXWnDOA5910noslfOGlhmpUlMWv3oQ0ywdQ7tJesDenCFMPzfG+WzYi4sz41TAtQYaGI/drvwxvQWi5zduqSrKIuMAo79XGC/yPTP9DqkKQgES6YcrFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=W9TVkvuG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1058786166b.1
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1752571485; x=1753176285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O2eCNiRDQ5DX4mHY4pcMsOTfjERkzn7FQIm7kYAQVSc=;
        b=W9TVkvuGOfjqr70dOMTHojFaYaVBvaB+l0RzL91laY/vq87kdBgwmb4MvV/dSm55JV
         Kye4PS9UnDUC4xGaRRnast/Znjq72QZXy9uw89S4bsTHxg/kOodSIb58ZZbvazVPFCiV
         fIb4bzQJeS02oYzV5WjEg47g4DfSBontSJ7v+wshEqsCAOh3rwi5TJg9Fa5hdjeCDQZt
         zOSaRVC+9ccISOq+iDkSILcM0dfIEQoRk/bO9EcJX+QM3JhyuWPE2rXoGA6GQWxyV/SO
         YM6ZIXpU7moK95zWQIqaBrecVOJAq/0Tyq/8Fd46P1kUpZMPM+udDhVyRCaB6pplRUiF
         CX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571485; x=1753176285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2eCNiRDQ5DX4mHY4pcMsOTfjERkzn7FQIm7kYAQVSc=;
        b=W659Nx+3sXrj1OvI2knaWduY4kT0R4K+UPAHMX43YjfS2uQJAkQW26BG0Wwk0OMY0R
         yUxgO7bMuYzDsMmeAWLBInVL3pE59+X2HM0Ov6Rj7RTggagLULXY2KfEhKqsl3YZpdxx
         X27JhsOD1Fs7ojQppnfzWwWlHG2Lo92Cb6kdPhHQ9PRx0YJOKcKmU8uMgkt+nVqr9Pw5
         F6WZBO/iQjqbvoEWv7w8iL+SYdCabBrc2pE54rmBUtQ5xP1zF9F05s8oWKFl3BLeH9tL
         dlAwjVoWzZNtzRYliWANx8iV3lnGMam/PnTxez23oRH6luRum+K9VtVBv6Il+ZUbUzpI
         aMUg==
X-Forwarded-Encrypted: i=1; AJvYcCX9uC92L5dFNqf5iZHWz/lYjlq26Ih3Y5KKNEEd6i8Cx2/h/NB7iQZhenPfYoteHqKUWn8m8OV2RnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLvgSypCz9vLxuLzYamQ5xSn7mhPzYS+OOKmhIG5ynjLvkSy7
	wdJw2HG/SBLGD9gxTfKmNun2aXKELJZTzF8UrHSzDYZgRGR17nx+cZOo/PT3j86dgy2Q9ls9sTF
	Om4EbHFDmTFsA5r4wDdkKU+sNG4foHu3clKjtUz8Z+A==
X-Gm-Gg: ASbGncv/L8r4pVdW81L2LP3WOdWsvHjtaCVzHEQxe6F7fIHoYk54uSQpd9nuS9uZ8Kd
	H4M3gzT1fLJtyok0tV+hE+IsXB1R2iYalJrAPnyWZMehFj5j6sW/Hyv8nePIP1Wa7cXEPQGdz5j
	utZClVeXx732cNdQES/KbDSPVBAVvpUus58+3JjyjoOqj9dDJ7oshASSwIgsv6bBwIzXXmqQ/yu
	iZFjQ==
X-Google-Smtp-Source: AGHT+IGyumuBX8AA+7lPxI4IxDBuuagmG/dmNN4lxHvmKyBIMIaj1RrIst0/1zMCCzsor0MB4v8B+S53G4HD2TAQfMw=
X-Received: by 2002:a17:907:3e23:b0:ae0:cf01:a9ad with SMTP id
 a640c23a62f3a-ae6fcc21096mr1820822066b.40.1752571485146; Tue, 15 Jul 2025
 02:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714224216.14329-1-snitzer@kernel.org>
In-Reply-To: <20250714224216.14329-1-snitzer@kernel.org>
From: Daire Byrne <daire@dneg.com>
Date: Tue, 15 Jul 2025 10:24:08 +0100
X-Gm-Features: Ac12FXwpooG3SpJuiK5gq7swbkYG8EIm5qsmuUOLTVTjX1EvD1506UxstXAU8LQ
Message-ID: <CAPt2mGOwiXi3U5X3Pq1f425VmsKRJOSn6zA1S6CdoDx_twsv2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO modes
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Just a quick note to say that we are one of the examples (batch render
farm) where we rely on the NFSD pagecache a lot.

We have read heavy workloads where many clients share much of the same
input data (e.g. rendering sequential frames).

In fact, our 2 x 100gbit servers have 3TB of RAM and serve 70% of all
reads from nfsd pagecache. It is not uncommon to max out the 200gbit
network in this way even with spinning rust storage.

Anyway, as you were.

Daire

On Mon, 14 Jul 2025 at 23:42, Mike Snitzer <snitzer@kernel.org> wrote:
>
> Hi,
>
> Summary (by Jeff Layton [0]):
> "The basic problem is that the pagecache is pretty useless for
> satisfying READs from nfsd. Most NFS workloads don't involve I/O to
> the same files from multiple clients. The client ends up having most
> of the data in its cache already and only very rarely do we need to
> revisit the data on the server.
>
> At the same time, it's really easy to overwhelm the storage with
> pagecache writeback with modern memory sizes. Having nfsd bypass the
> pagecache altogether is potentially a huge performance win, if it can
> be made to work safely."
>
> The performance win associated with using NFSD DIRECT was previously
> summarized here:
> https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> This picture offers a nice summary of performance gains:
> https://original.art/NFSD_direct_vs_buffered_IO.jpg
>
> This v3 series was developed ontop of Chuck's nfsd_testing which has 2
> patches that saw fh_getattr() moved, etc (v2 of this series included
> those patches but since they got review during v2 and Chuck already
> has them staged in nfsd-testing I didn't think it made sense to keep
> them included in this v3).
>
> Changes since v2 include:
> - explored suggestion to use string based interface (e.g. "direct"
>   instead of 3) but debugfs seems to only supports numeric values.
> - shifted numeric values for debugfs interface from 0-2 to 1-3 and
>   made 0 UNSPECIFIED (which is the default)
> - if user specifies io_cache_read or io_cache_write mode other than 1,
>   2 or 3 (via debugfs) they will get an error message
> - pass a data structure to nfsd_analyze_read_dio rather than so many
>   in/out params
> - improved comments as requested (e.g. "Must remove first
>   start_extra_page from rqstp->rq_bvec" was reworked)
> - use memmove instead of opencoded shift in
>   nfsd_complete_misaligned_read_dio
> - dropped the still very important "lib/iov_iter: remove piecewise
>   bvec length checking in iov_iter_aligned_bvec" patch because it
>   needs to be handled separately.
> - various other changes to improve code
>
> Thanks,
> Mike
>
> [0]: https://lore.kernel.org/linux-nfs/b1accdad470f19614f9d3865bb3a4c69958e5800.camel@kernel.org/
>
> Mike Snitzer (5):
>   NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>   NFSD: pass nfsd_file to nfsd_iter_read()
>   NFSD: add io_cache_read controls to debugfs interface
>   NFSD: add io_cache_write controls to debugfs interface
>   NFSD: issue READs using O_DIRECT even if IO is misaligned
>
>  fs/nfsd/debugfs.c          | 102 +++++++++++++++++++
>  fs/nfsd/filecache.c        |  32 ++++++
>  fs/nfsd/filecache.h        |   4 +
>  fs/nfsd/nfs4xdr.c          |   8 +-
>  fs/nfsd/nfsd.h             |  10 ++
>  fs/nfsd/nfsfh.c            |   4 +
>  fs/nfsd/trace.h            |  37 +++++++
>  fs/nfsd/vfs.c              | 197 ++++++++++++++++++++++++++++++++++---
>  fs/nfsd/vfs.h              |   2 +-
>  include/linux/sunrpc/svc.h |   5 +-
>  10 files changed, 383 insertions(+), 18 deletions(-)
>
> --
> 2.44.0
>
>

