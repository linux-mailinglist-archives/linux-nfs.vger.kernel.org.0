Return-Path: <linux-nfs+bounces-11282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505CA9C7FE
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 13:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E2B1BC35D8
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 11:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE09247284;
	Fri, 25 Apr 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeIu7Tfx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1082459D4
	for <linux-nfs@vger.kernel.org>; Fri, 25 Apr 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581460; cv=none; b=ZixAnxLl1WV7idXnjpnY+FMVfCxcidzRDL53B/n/YLR9F4YHi+QrAJg3s2AOtFSfeXSp95ADRGlWc0Scxt6zJo4GnTIYrX4ZJrZXsHIq/q2d/+wVgkXm+3zs/z0TxqKRau/K13bM2jCTIcrY12J4KCObvX1GTIIJWapn7d7G3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581460; c=relaxed/simple;
	bh=IToxjMZYjvM9lNH3mw7yJTeT6jPRrkYp/rwx6SFhAEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwN0puqeJWJIy7Qjs3xoaai0+ZKArLpfis1lA1RKKw5SIZq2MPAUNticjgn+dzMjvN2YIaECdrZVjstjv4eFgHY6TJ6KNhRv293tC/Mq1QfZA8hJCQmmuP4I29HHSh41CdOOkygxGi6ASSd+bb3RZMY1N7Y3pKLJyeidGjKKGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeIu7Tfx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745581455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AdrKxOfuyOBnEuSmdyhh/BphGoP5d55HS+klRx6Y7IU=;
	b=EeIu7Tfx8WbZ8gm/av6Yukur4o3SXlndoIjRrSC7xTs3MEQq7oWP8cx7prfll5tL5l+xRu
	cDDE5oA1+Y9tsuBa5VR7KutKgQHkH65Kv0lO9RqacSuMO9EDXRR/fm1Q41ahQK7d3bCvxJ
	ChrdTJX12WFjX5tcLSlyZY0HcWS9JgQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-RYDpc744MSyuzDXJ2GDeAg-1; Fri, 25 Apr 2025 07:44:12 -0400
X-MC-Unique: RYDpc744MSyuzDXJ2GDeAg-1
X-Mimecast-MFC-AGG-ID: RYDpc744MSyuzDXJ2GDeAg_1745581451
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b16fc7aa649so770796a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Apr 2025 04:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745581451; x=1746186251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdrKxOfuyOBnEuSmdyhh/BphGoP5d55HS+klRx6Y7IU=;
        b=t17gx5mXCSA/3oA5KbFbRWVF8qHPuWOhPycCGkJ7T3aGYvqzpxIxfij6zQ/yTtvN0c
         81QFOoCeC1nf6M8xMzfYc14Nfx9uXIXfI8ITWhiT5P0EvnteVHwWNOeJqeQNhCXY3uk1
         LxoKekUvlpO1a+3Gs1npo+sfWt6OGRpGq+ZwyiAO3ppMdmUsFs3s0lSbcbojAr1XB14c
         LxvST3L+5eZ8KZO83pLC7EI/g20bubNKkHIh31B+q5kY67IxqcXLh39ZW670uXH5Cy7w
         I054qW07I3LXXa2ZUnhLyEF0vmefHWBShIt9YDbyA4G+VOfrulyLfkFFnUYmVLhk+fI/
         pzmA==
X-Forwarded-Encrypted: i=1; AJvYcCXM2In+F0aU8hRit80ZOqJaAT1YVm9bcy7Esy8mljD/Jc0fYI0mSXCyY0Z55Xegxy1+CjiC+1OHv8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfz2ncJJoGaAK0NHXKC8vruJa7MEtjEhyeM0Ji2fs5zh4ysa90
	UL5iPGbvfccx/FPunrppOOA/XzW1DB27/MIRlClXWz3n6s+dobqX1ZbBrek7822XoaK2zoG1mUg
	bgPSAKcn/ziwCbCwt13Xq41xGojvguwc7KfucOOk9qqoqXk1nkxoIGec1Ng==
X-Gm-Gg: ASbGncsZbJ/4o1DSojUFSSMfWvkxR8AoRZv15JTMgqiqIMuoUXDnXFyvYxJzYdEcCuu
	japzRxpiSrwI1mmMuZLSIJDNEaf5bRW5awi9T1v4h0xgxjiLkl3srp8TOx6KdwyUFdTJ/TVhnkg
	N4CvvGZVZtZSuX1mMy4OWgqY0WwRB8to59o+8THU6f6xZtbgCQVIpxK2GNYtosj3tzmwEycFtQl
	PQlhaWXuOl2qDlbN4Vz/LV9aqlSVRFQTp06knzb993LKVI6vLZWUpz9Hm7XG/kAHPrPYupUKeYw
	7dm+d3GKeHJ0nEkMbLJxSwfsDdYhA8Y6pFOgT8luoV0bEZTimPsR
X-Received: by 2002:a17:90a:d603:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-309ee37cae3mr9834700a91.8.1745581451307;
        Fri, 25 Apr 2025 04:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEyQ03516MLicuEbsvFpC6tMOzPwTVFh2zMJJAA3nJDMBcj7+bnYTxQVxGkWGF1gSpnnClFQ==
X-Received: by 2002:a17:90a:d603:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-309ee37cae3mr9834679a91.8.1745581450840;
        Fri, 25 Apr 2025 04:44:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76db1sm30033755ad.13.2025.04.25.04.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 04:44:10 -0700 (PDT)
Date: Fri, 25 Apr 2025 19:44:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/033: Check that the 'fzero' operations supports
 KEEP_SIZE
Message-ID: <20250425114406.nybdc6witc33kiae@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250424195730.342846-1-anna@kernel.org>
 <20250424213607.GF25667@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424213607.GF25667@frogsfrogsfrogs>

On Thu, Apr 24, 2025 at 02:36:07PM -0700, Darrick J. Wong wrote:
> On Thu, Apr 24, 2025 at 03:57:30PM -0400, Anna Schumaker wrote:
> > From: Anna Schumaker <anna.schumaker@oracle.com>
> > 
> > Otherwise this test will fail on filesystems that implement
> > FALLOC_FL_ZERO_RANGE but not the optional FALLOC_FL_KEEP_SIZE flag.
> > 
> > Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> > ---
> >  tests/generic/033 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/033 b/tests/generic/033
> > index a9a9ff5a3431..a33f6add67bf 100755
> > --- a/tests/generic/033
> > +++ b/tests/generic/033
> > @@ -20,7 +20,7 @@ _begin_fstest auto quick rw zero
> >  
> >  # Modify as appropriate.
> >  _require_scratch
> > -_require_xfs_io_command "fzero"
> > +_require_xfs_io_command "fzero" "-k"
> 
> I wonder, does this test even need KEEP_SIZE?  It writes 64MB to the
> file, then it fzeros every other 4k up to (64M-4k), then fzeroes
> everything else.  AFAICT the fzero commands never exceed the file
> size...though I could be wrong.

Hmm... I think you're right, the code logic is:

  bytes=$((64 * 1024))
  $XFS_IO_PROG -f -c "pwrite 0 $bytes" $file
  endoff=$((bytes - 4096))
  for i in $(seq 0 8192 $endoff); do
          $XFS_IO_PROG -c "fzero -k $i 4k" $file
  done
  for i in $(seq 4096 8192 $endoff); do
          $XFS_IO_PROG -c "fzero -k $i 4k" $file
  done

So looks like the offset+len isn't greater than the file size. So we
might can remove the "-k" directly. What do you think ?

Thanks,
Zorro

> 
> --D
> 
> >  
> >  _scratch_mkfs >/dev/null 2>&1
> >  _scratch_mount
> > -- 
> > 2.49.0
> > 
> > 
> 


