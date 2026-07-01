Return-Path: <linux-nfs+bounces-22914-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oXbVCgF8RWq0AwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22914-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:43:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D86F18AB
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:43:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b="RF+DTrF/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22914-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22914-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98C6930087C5
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 20:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74873955C6;
	Wed,  1 Jul 2026 20:43:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEB28F949
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2026 20:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938621; cv=none; b=KNHg62tV3bYPFrfniinv+SB2GpH5HTLoBd5ZXyL/JSjjAiJ2b2U3RYCE9CEXOLhOcD27g32tcsk2vYQ6gYzQI6tQhwZL9LHIHHWZY/tPSlewAm3ar0lz6Od5O8uMSA1wBhPaSKnAdMDsYGW7NTCHfLgcgi8XxEyP0w8aVPfEemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938621; c=relaxed/simple;
	bh=sQywxGKKEFa1rBgQOqgqErkqWl68yV3X7h/U5i2mSVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ih9mnc2f9vH7Q2qoBA1gme8Zc41uxW1Jc52ckIvPwblEG+RwOAthg8yBi3uoL2lzNZrWuJRknJSFVYGxl4o0/4wDe2y1tmEBmorYfYoOdkcPZJ/5FM7aUcAvv26zOtiLeD8Slf+bk5Z5uR9i2ovEJFnR72/I3et5jrEi4tETW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=RF+DTrF/; arc=none smtp.client-ip=209.85.160.181
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-516d0db9372so8091291cf.2
        for <linux-nfs@vger.kernel.org>; Wed, 01 Jul 2026 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782938619; x=1783543419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+7KA1XWFlVyul4XCG4umxa1I8OgMxq3o1YAea4j00A=;
        b=RF+DTrF/C8qcpFTiqSSr8mIrF54U1g5p2worLhNiybQsk7TRI7smUCKCjj/VOpUnff
         FuswU3lsQjY8Ka/SVrOTZCidwPAOry7usN3QGJOOpzIR56gaLHrVJegyAAO9luY3Knbu
         ezyCkQUu3k2XmPxq/bCa9jomF9D2zMj0KEk57odhVioTiTsEBsD7UF1W9lyGvcwJy4Dz
         EV3cgPWLlDu3yRZ4/okUVT3A1WWnNGfEKy11c+qOXTkQeodoOXPx/vRlcOsNhLK2Wgja
         NR+iWVynsa2SW5OSQ+e/9hwLVJUBvH69zOzeOobxWIRFiHJdGfLIo3KiGJq388f+S7y1
         pgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938619; x=1783543419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+7KA1XWFlVyul4XCG4umxa1I8OgMxq3o1YAea4j00A=;
        b=Lin1F8zsL2TL1YsqqYUHgSR8loRE8zP3/wiiUf7p/S/MXCL2WpQveT6ch99axY39Ny
         IfRiAnCUKHAbvkueGZHh5F15qFFh7JcR7puQkbJo6zCL658Dxw8ZdjW3+S6yQxe5SsNW
         zlfOWomymLaN6+MhEniPZy3VyL7QUSrws+xQCLGlLKnsR916Xb+62NX4QD2H/+Ka1UXX
         EHyb3VAjZ9exfJpKkh4EfNu7jebXgvgZ78NdXBhVBMi0lx1RdORonb1Cm7vluxDUddsP
         FPs+yuxyBZFasjnX2qyFucNR/cLcca457i2gbNH0DQX6l8sonUIUCW88UrwhADYMH47w
         WQLw==
X-Forwarded-Encrypted: i=1; AFNElJ/EuRraufKh0XfEUJBXr95j+Q4CzS+RvKG2BukLUuUxYejxcZhgzRHlOGec57szAsrnkvEmelAschM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAXzF92Ka058vSoU3Xk1RRXBlo3ARE3Ki/9FQZNUUOpjBvi2y
	zGoUio6JUKw7hJ2rVFRiEQTtCGwfvhgdxwp3O/3UuceGJxWgraDPrGiWe7IEtpIWlCE=
X-Gm-Gg: AfdE7cnS6zQ+woe+ouM2BTDHhU1jdu/NUpseQrePEv5citIW/z26R1t7rGfzaaMhTcD
	rhz8mBW1G0VMmatsZmDiFZVh1QRUz+89gQ5joCqpbByd1xGxZejMkyU3ciJr6dzXFG0cMRuxZjp
	nXrTvbi3y5ruV3DgEReUH1ZFG4x12cP0Oab+DpuQlBUMF8NxJW2971ISKmX9CyGuLGNBm8HXRaW
	9Tvjc0VjHjFvHwwlF56jdhevLhx5Ye1TSP2H8YMEeoAhXU/nDgGsTYiGvnKNHrqMQ+GuGZd7G6b
	P3oTAvzpLKuhP7Qy5U+HK+lFSiwHFYUhQ1eEhzOxSsJI99DIG7ltx/vGwpqSb9sxeL/MK9YQB/a
	HowepVlu3+JSwE26c0Incd7pFoCtopeoFFBGOgu8Of/nB2VH5EamrsHrrCDbQGiXZLIWIiXJUaD
	DMG9mEag+3ooCDgzrPVL9LKe+NRhkPwG2qahXwMJ45mygsR2qS9VVpjBtO4F0XdhB0E00QOQc8e
	GX7KQ==
X-Received: by 2002:a05:622a:2615:b0:51b:eb55:2919 with SMTP id d75a77b69052e-51c2aeedbdfmr32044741cf.51.1782938619008;
        Wed, 01 Jul 2026 13:43:39 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30b4511dsm565091cf.10.2026.07.01.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:43:38 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/6] nfs: NFSv4.2 client support for UNCACHEABLE_FILE_DATA and UNCACHEABLE_DIRENT_METADATA
Date: Wed,  1 Jul 2026 16:43:31 -0400
Message-ID: <20260701204337.54314-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22914-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E9D86F18AB

This series adds Linux NFSv4.2 client support for two companion,
per-object "uncacheable" attributes that let a server advise the client
to stop caching state that changes faster than client caches can track:

  - UNCACHEABLE_FILE_DATA (FATTR4 87, draft-ietf-nfsv4-uncacheable-files
    [1]) -- a per-regular-file boolean: suppress caching of the file's
    data, both write-behind and read caching.

  - UNCACHEABLE_DIRENT_METADATA (FATTR4 88,
    draft-ietf-nfsv4-uncacheable-directories [2]) -- a per-directory
    boolean: retrieve directory-entry metadata (names and per-entry size
    and timestamps) from the server on each READDIR rather than serving it
    from the client's readdir cache.

Both are OPTIONAL, read-write booleans; the two are independent and apply
to disjoint object types (a regular file may carry 87, a directory 88).
This client honors a server-set attribute; it does not set either (that
is left to server/administrator policy).  The motivating deployments
expose a single namespace concurrently through NFSv4.2, NFSv3, and SMB,
plus server-side policy engines, so file data and directory contents can
change faster than a typical client cache lifetime -- producing stale
reads and read-modify-write "write holes" for file data, and stale
size/timestamp listings for directories.

For UNCACHEABLE_FILE_DATA, a marked regular file is opened O_DIRECT, which
suppresses read and write-behind caching and satisfies the spec's
durability invariant via the existing direct-I/O path.

For UNCACHEABLE_DIRENT_METADATA, readdir on a marked directory bypasses
the readdir cache and refetches from the server, forcing READDIRPLUS so
the per-entry attributes the attribute governs (size and timestamps) are
refreshed rather than served stale from the inode attribute caches.

Each attribute is requested only for the object type it applies to, since
a server must reject a query on any other type with NFS4ERR_INVAL.

The series is organized as:

  1/6  decode UNCACHEABLE_FILE_DATA, track per-exported-filesystem
       support, and record it on the inode.
  2/6  request UNCACHEABLE_FILE_DATA only for regular files.
  3/6  open uncacheable regular files O_DIRECT.
  4/6  decode UNCACHEABLE_DIRENT_METADATA, track per-exported-filesystem
       support, and record it on the inode.
  5/6  request UNCACHEABLE_DIRENT_METADATA only for directories.
  6/6  honor UNCACHEABLE_DIRENT_METADATA: refetch readdir (forcing
       READDIRPLUS) on a marked directory.

[1] https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-files/
[2] https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-directories/

Changes since v2:
 - Patch 1 (nfs4_fattr_bitmap): place FATTR4_WORD2_UNCACHEABLE_FILE_DATA
   as the first, unconditional word2 entry and OR in
   FATTR4_WORD2_SECURITY_LABEL under CONFIG_NFS_V4_SECURITY_LABEL, so the
   word2 initializer no longer begins with a stray '|' (which fails to
   build) when CONFIG_NFS_V4_SECURITY_LABEL is disabled.

Changes since v1:
 - Drop the v1 1/4 xdrgen patch that added Documentation/sunrpc/xdr/
   nfs4_2.x and a generated <linux/sunrpc/xdrgen/nfs4_2.h>.  Instead
   open-code FATTR4_UNCACHEABLE_FILE_DATA in <linux/nfs4.h> alongside the
   other hand-defined FATTR4 protocol-extension constants, and drop the
   generated NFS4_fattr4_uncacheable_file_data_sz macro (its single XDR
   word is folded into nfs4_fattr_value_maxsz).
 - Store the per-inode flag as a bool bitfield (bool
   uncacheable_file_data : 1) and simplify the sites that record it.
 - Remove stray blank lines introduced in nfs4_atomic_open() and the
   nfs4trace.h attribute-flags list.
 - Add client support for the companion UNCACHEABLE_DIRENT_METADATA
   attribute, attr 88 (patches 4-6).

Mike Snitzer (5):
  nfs4.2: request UNCACHEABLE_FILE_DATA only for regular files
  nfs4.2: open UNCACHEABLE_FILE_DATA files with O_DIRECT
  nfs4.2: add UNCACHEABLE_DIRENT_METADATA attribute support
  nfs4.2: request UNCACHEABLE_DIRENT_METADATA only for directories
  nfs4.2: honor UNCACHEABLE_DIRENT_METADATA by refetching readdir

Tom Haynes (1):
  nfs4.2: add UNCACHEABLE_FILE_DATA attribute support

 fs/nfs/dir.c            | 22 +++++++++++--
 fs/nfs/inode.c          | 32 +++++++++++++++++--
 fs/nfs/nfs4file.c       |  2 ++
 fs/nfs/nfs4proc.c       | 69 +++++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs4trace.h      |  4 ++-
 fs/nfs/nfs4xdr.c        | 64 +++++++++++++++++++++++++++++++++++++-
 fs/nfs/nfstrace.h       |  4 ++-
 include/linux/nfs4.h    | 18 +++++++++++
 include/linux/nfs_fs.h  |  5 +++
 include/linux/nfs_xdr.h | 11 ++++++-
 10 files changed, 216 insertions(+), 15 deletions(-)

-- 
2.47.3


