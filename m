Return-Path: <linux-nfs+bounces-13536-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B74B1F6D1
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 23:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388A53AAA96
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D67238C16;
	Sat,  9 Aug 2025 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt9UPJ1Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A715665C
	for <linux-nfs@vger.kernel.org>; Sat,  9 Aug 2025 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754776651; cv=none; b=Faf6qW1R0M/Cg8Pi7p/qUHutg6lcMBtHKYCT7ZK6xrl/51fOGemgWxXiI34p1Zt89DJWQ/UDKvzl4m3cI6MPBeO/D2YWBPw6jNW5cSLkQl2ycNkScTo30OS3hDxNC4ORU3OmH+Tj1o6pkca4RaEU9ET3sh7GBCa4p0PGDWkAxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754776651; c=relaxed/simple;
	bh=ID4nrengyWb9b4ZQra99Ini4jk9y6rH+QzuC2A8JgcM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F1XVYHa+hQd2VVIV+1qLH92HD7anK6iG15hfMpky7sE33oLBV6vdITFnuGwVJ6fGI2+DRxb+rlzU90gFcLn35SRxd67XzUxtNucWxI34Z56+FC7Z498rFNGRT3NWZzSy03Xm4q+CsZ/MWxEVbOSn2tOqncn57V4E1ljNBQhhLTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt9UPJ1Z; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af925cbd73aso630689066b.1
        for <linux-nfs@vger.kernel.org>; Sat, 09 Aug 2025 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754776648; x=1755381448; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ID4nrengyWb9b4ZQra99Ini4jk9y6rH+QzuC2A8JgcM=;
        b=mt9UPJ1ZO23KqAS+c7/eK2zw5K57OE4hpEeBmASnbprOxx2UEtUynZ3wXvLvbwm/e6
         87jzLAOVjM/BnhREoCsTfGPCTiJZ3pd6Y6AoYU3Ay3BorNJl7bpe7npOAGndvuUTRCk5
         AQJATHlQ3dZVPomZuUJYlNsw8Npc3rQFhBSHwMCwO/AU++gp8xelblWUCiQbRm158cjm
         g7IQittqVkGWihLuVJso0jiNVcGBlXeVO+AXVi+bZG4NzYREUbzIo6BC+ZBTNP4uvYt4
         WidlddWkiqXVMBTOuJMhVLhxn73Y/vLqkcyC2VH8Rfx4ujLaqBAj9V0QYMCfCIugW1uo
         vyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754776648; x=1755381448;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ID4nrengyWb9b4ZQra99Ini4jk9y6rH+QzuC2A8JgcM=;
        b=vJBIW8KplA8qcaQnMELkFQ4cfERGryvzXd0vHnzAEFf+9AlllPoLFoGs/3v6OErXXF
         jJsoc7Z6MWwL6WnLkVsCn65zHSwwG0iOGzA5DKfWTSqzvqrWwUJVxPOYulAu2yPmWRBR
         pw8UoqJwI5LCRsDx33Oybc7ds1uEFAijccPRp2s7+8xzhsBFbVUq04BUTSURymEHnxgn
         sw0TiG2tzjtjb1eE407iOQC7yLLToYPOz1UXW9qPMk3B1+QLkSjag6k+hgHhFWjtLzWW
         lsQmDTkXaf+VEQWFB8rgBwqCyyEfsze5QePnaKvndNHpyYRL8eu19Dvx92aUDi5cYl5f
         aBlw==
X-Gm-Message-State: AOJu0Yw9KO+rln/TE98QXZ4ye/k8HeFMb8aNp29xia2Yn69bG0o17PNW
	dbkjtt9HCTt8vzqS9H7FKmW+0rkLzWEK9RfX6vYCdOIXiD9BdUFFgFLJmZ5dybjUEpz5DK0N3Df
	bo1H6KFzOcBqVuvq89/2RXJ5kme0lXMwX
X-Gm-Gg: ASbGncuVygRYgDXfxbdAbeJwUKwVtLgoyvHXJGR15zqY4fJM/GlBT34Q2Y0o9zc3CdQ
	GkRVygg3btq7X4EunAWHXHeCzlgpjr9ICl+rIleVSbYDCTGkwZHPqRbOlxJDOEABrefZts9j680
	CSAQ6BCxjq1VwWDOcIGESRGWfIDKVZcdpPe5pNj28hlL781stCRnYDYvOAyX1CnbuDiY5yjDc83
	o7urNUKB5rrMqyI0Pvji/6JMewAeGAKuH5uFPE=
X-Google-Smtp-Source: AGHT+IEZEp4WBTLY7UimcOa6AFVJE6iOwYSGOZLzJNDYR6FevY/Pw9y07xv0noTccRZ4hfggw6vj5m9KwHxF/mATz6c=
X-Received: by 2002:a17:907:96a9:b0:af9:a1e4:1bbd with SMTP id
 a640c23a62f3a-af9c65186d3mr591414066b.34.1754776648074; Sat, 09 Aug 2025
 14:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 9 Aug 2025 14:57:16 -0700
X-Gm-Features: Ac12FXyKCUFDtQhJPstgyfUWDco5ahwmIW8rkgxDObrxDWcI0j1HP8TZ62QCr4U
Message-ID: <CAM5tNy4iwPiOUuo8t8=m1zgcu1pHAVnYxaDy5DUFyxkRcqfSsA@mail.gmail.com>
Subject: RFC: clone_blksize being wrong for a file?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am looking at the Linux NFSv4.2 client code and the
only use I can see for the clone_blksize attribute is
to check alignment in remap_file_range.

It also appears that the Linux client assumes that the
value for clone_blksize is per-server.

My problem is that, for ZFS on FreeBSD, clone_blksize
is per-file. (512bytes for small files and 128Kbytes for
larger files for my test setup.)
RFC7862 doesn't seem to define whether clone_blksize
is per-file, per-fs or per-server (I've asked on nfsv4@ietf.org).

Which finally gets me to the question...
If the FreeBSD server replies 512 for clone_blksize for
all files, that will result in some CLONE operations
receiving NFS4ERR_INVAL, due to alignment problems.
Since remap_file_range does the same, I am hoping that
this will work out ok.

Anyone know what the implications of replying to CLONE
with NFS4ERR_INVAL is?

Thanks in advance for any comments, rick

