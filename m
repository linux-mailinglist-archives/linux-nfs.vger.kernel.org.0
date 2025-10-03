Return-Path: <linux-nfs+bounces-14948-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A78BB6538
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 11:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE973A746E
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3202882D3;
	Fri,  3 Oct 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfPd0vh0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAC275AF2
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482684; cv=none; b=k4XqI51cHLLfnVA3MaVwXG4jxBYVxHywbooveKyFWCvbvEKcYeEEDPCH8PJ1vMR/I3avF2cHd4t8q0QO3FOQ1jAyEKPeU3q1xtthL9e1RIqOPCBl/SKzy2Gbm8VBqBsXU3xyWAM9oPoL2PzhmnuNs/4krgB2BETsbuHWKyxqZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482684; c=relaxed/simple;
	bh=VfiCAGN0AGfa646ltsvQvSU2Seqpx2og6lu9lSfJWYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugwjUSsAETfh8/BrWs3lB/shV6eJx85QMzZE4/Px7551bxPq0jcqGAkUEDm32Wn+KFdgEmexLa4dy8hbUuhdnoD9vaFfAeESMAz4VxRlhKF2az///MwWy53hqTisUtBPpxNQV++7GrpVj2nrjiu4xGa1q0MVm85/rxT5E7fEidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfPd0vh0; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36d77de259bso18078491fa.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 Oct 2025 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482679; x=1760087479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTLAmAkT0Bz6x7mi9MjbZErT4JQSvAEF74DuHT2XEq8=;
        b=IfPd0vh0R1NzQyZBXlGkHO2bi3GIRFXxH6oWp6YdU5q5/xfpOkeq1nzGh0kFMsPhbJ
         2MkVKP+kIBDeS2JS5MpfNxmeGG9uWNlqk3zNNs9joNUvxlErd46thPzRFeZcth5ERF4K
         qwpe2s6xo593oOiggD+Dx3VycsKJU+HxR9iCPVWTx+yEzxSPy1S0T6HrFU64bTyd0ARI
         rFmVmAnDt0pw2ZWfzj4jvVAtpHqdFqG7xl6QcIVaEAlGyJYxmUet/OkJjq6UUGRUmim8
         V2ZKEnGALhvvoYoBH/klepHXGlGHBuOX0GIlbkw/wZ29ml3NksSOKzy4AD1FNDq+XSfv
         TWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482679; x=1760087479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTLAmAkT0Bz6x7mi9MjbZErT4JQSvAEF74DuHT2XEq8=;
        b=IXsdsqokVoD0QWf7FTWdWJeo5CN7Ju+xQtZ4CFvZ7GG0CSKW2OLGUTS8KP4bLuniZT
         amNoUkSNX92R4eJYVjEsedL9Kqe1rerPqZpSbJXLUQJYEkvs8azkgw3t63tpvPWuiGW7
         rKyCVc4rIQDGtSonJQ6+n1caxIfQcagoIc9OMPtKIO9zY5v9c5TNgBEQxbYXqyXOQ/sT
         InLF96MUVgUZ6UrjvkduwZ4XwJY7uKvAVlkP+nSoSpwaz6OM1yU3GMfOsaQy9d48DeNJ
         8jmuj8zVywJnwFgOQsCeL7S9ar+fTrnIYcY+pf1104g8ppTq0mRIguIZiiv7WKDkh7UX
         RqEA==
X-Gm-Message-State: AOJu0YzqknRVMkKxsT2AlmjSwWyOyGJBbRdTt/WKOfLKgM7my7klwt95
	tL/oYqXgm+MSZ3k04whfbeeMU0Hb3YdexYWw4NebGyXFvaQokW/AKztp
X-Gm-Gg: ASbGnctSxdX9UlC9XOFBv5jhFx7wI0aM4axebbkOtEIQ0CiQpkR3qi2noFHJ/8QP03U
	xbQ3bhsipYJqTQcRQLmXu2txvYB7g4LcN9XtDu2kmBeF3pnt5wha8PquwrSYiEpWHY0djbUtiQA
	aeK1cuxgzZLqkk/SVvSqAm43YTxzBmBF6kurjtnFX2aqzIFyst9p1FOZ4czGDjMace+bLJRoMP2
	KXVdapkJVB6+MCFqqJG2E68lnPQgDDDWeMNgTv+HeM/RIkBt7aB3C9e5M2xXkXNQp0863ZC5CRf
	BdzbAvJ06+jxT/Wzt6l8RmeZLXQFtNpMgMUUK8c/tnsEiZz2xjVCDa0N4SUt2dgxVydp8vtK1vx
	KmCdq9M+0qUt/O258KhGRN3nH7M2MyIhh+lkwR3qNJYr7mi6/xgaevG6/MEf2EEf0wR+dimLzuw
	xvVjmI1YOVzao=
X-Google-Smtp-Source: AGHT+IEE37WjpVP/WIvXAgeGS39Gce9Ezt51xjGTSJsmxeVSfCWvxIo+dLGFakcwws5UpIYrgxmgHA==
X-Received: by 2002:a05:651c:1992:b0:372:9992:1b0 with SMTP id 38308e7fff4ca-374c3823058mr6029241fa.31.1759482679187;
        Fri, 03 Oct 2025 02:11:19 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm13498971fa.30.2025.10.03.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:11:18 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v3 0/4] NFSD: Impl multiple extents in block/scsi layoutget
Date: Fri,  3 Oct 2025 12:11:02 +0300
Message-ID: <20251003091115.184075-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for multiple extents in the LAYOUTGET response
for two main reasons.

First, it avoids unnecessary RPC calls. For files consisting of many
extents, especially large ones, too many LAYOUTGET requests are observed
in Wireshark traces.

Second, due to the current limitation on returning a single extent,
the client can only reliably request layouts with minimum length set
to 4K. Otherwise, NFS4ERR_LAYOUTUNAVAILABLE may be returned if XFS
allocated a 4K extent within the requested range.

We are using the ability to request layouts with a minimum length
greater than 4K to fix/workaround a bug in the client. I will prepare
the client's patch for review too.

Below is an example of multiple extents in the LAYOUTGET response
captured using Wireshark.

Network File System, Ops(3): SEQUENCE, PUTFH, LAYOUTGET
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
        length: 0
        contents: <EMPTY>
    minorversion: 2
    Operations (count: 3): SEQUENCE, PUTFH, LAYOUTGET
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: LAYOUTGET (50)
            layout available?: No
            layout type: LAYOUT4_BLOCK_VOLUME (3)
            IO mode: IOMODE_RW (2)
            offset: 0
            length: 10485760
            min length: 16384
            StateID
            maxcount: 4096
    [Main Opcode: LAYOUTGET (50)]

Network File System, Ops(3): SEQUENCE PUTFH LAYOUTGET
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Status: NFS4_OK (0)
    Tag: <EMPTY>
        length: 0
        contents: <EMPTY>
    Operations (count: 3)
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: LAYOUTGET (50)
            Status: NFS4_OK (0)
            return on close?: Yes
            StateID
            Layout Segment (count: 1)
                offset: 0
                length: 385024
                IO mode: IOMODE_RW (2)
                layout type: LAYOUT4_BLOCK_VOLUME (3)
                layout: <DATA>
                    length: 4052
                    contents: <DATA>
    [Main Opcode: LAYOUTGET (50)]
pNFS Block Layout Extents
    bex_count: 92
    BEX[0]
    BEX[1]
    BEX[2]
    ...

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Changes in v3:
 - Added a Fixes tag
 - Removed an unnecessary sentence from the commit message

Sergey Bashirov (4):
  NFSD/blocklayout: Fix minlength check in proc_layoutget
  NFSD/blocklayout: Extract extent mapping from proc_layoutget
  NFSD/blocklayout: Introduce layout content structure
  NFSD/blocklayout: Support multiple extents per LAYOUTGET

 fs/nfsd/blocklayout.c    | 154 +++++++++++++++++++++++++++------------
 fs/nfsd/blocklayoutxdr.c |  36 ++++++---
 fs/nfsd/blocklayoutxdr.h |  14 ++++
 3 files changed, 147 insertions(+), 57 deletions(-)

-- 
2.43.0


