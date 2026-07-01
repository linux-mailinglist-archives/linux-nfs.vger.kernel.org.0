Return-Path: <linux-nfs+bounces-22919-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UistNhl8RWrAAwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22919-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:44:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5446F18D2
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:44:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=kzLBPE0S;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22919-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22919-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 779623013B41
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8D349CC2;
	Wed,  1 Jul 2026 20:43:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351928F949
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2026 20:43:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938627; cv=none; b=efYNV6W0ZnYlfyH4rCSzwVkDZ9d5A0MQwXiCfF5DYv12HGGYlhpm0u9fV98pjQ3sQIkocksS5OoRcfzIYUR2gmdsE0Ezgf3ExB34IpkSRL6iPLRv33LJCSgvt3oxeOQoH2DQDBM1uuwJCBaWvyj2oUhDwNipO2FiBYTZyXuvgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938627; c=relaxed/simple;
	bh=Aif3FjdRXkOavZYMCT5na3LpTkebVIYGhIYaOcQAk6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reskYFHf0tbqxSf3BKzJHyussjdr85VEph9QXr/sqwVLyaD6jnmgefPWSiQGj+AmGi4EIAmvnXQ7MF+o5LM+8wESjRTbkZ7S+qK+okXPkS+5t8FukvwC74xuctKtN4qEUl+SsR7d/nvqaoI5eZc5NSnQ+GWAG3Xhs5eWiZNtu00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=kzLBPE0S; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9159951f05aso81143785a.0
        for <linux-nfs@vger.kernel.org>; Wed, 01 Jul 2026 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782938625; x=1783543425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFKINBFnjt6Bs7q4H2q3X66UxkrWW1rAfONRKUjrUaQ=;
        b=kzLBPE0Stp+rO4Gv9qL4HYTI2c8M5gUOJvVukzdyI0Q2SrYGy5Foiuhh3RH5bTeeJi
         jUSE7X8V6fcULAHdtbb+UkrOvRzut5Cd0LZ7KXw/ivYIDpo5WKEP8+rGMvgdR8fsIJFV
         Lp53a7Lu+8gZ/gs57IYEf2jpEkAfmJ5D3h5JUgz7f3gkIsVdsz8TU0hALsToEGN9oZze
         Ou8R+UlAfUraa4wJ7lU00515W21LshrOOBkPjnYniR31/X5PEizl/1IqbkdRPkS2Qfci
         R8xIGfwXvRCxw0C4QSrsi9xqeO6cvxyudX9c482OSUskyvjwFwR22KpdAwPiLMQ8jB15
         ZW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938625; x=1783543425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKINBFnjt6Bs7q4H2q3X66UxkrWW1rAfONRKUjrUaQ=;
        b=XMo5nKG7uL9wzovEJzkhy+Ng8KNfqXmzQ0Bx00gCOH4oWauvGjLwTeERClWbmniUrL
         R1DvYYHFrl+sYFRyhvUejqznrDfxTo8NdKP5jf5UveS1FqprQdUzgDy8gbwfFqjIlGjV
         OVzSfj4vl9mL1n/WtWSY2wvZRLVC730us9wy5T3dpZfYUCgEiORaYQVchTGEBZmWViGN
         av9LVZleuKtFfy6iCNX7qpmGzKxKxDxyaTuS/OLBBlvTCPu0iDK5dVB7iUvUYifx0SR8
         e1dyrlzWMhiurXwfxRKq/DKran9BZzxIzderf23R2uZFRrfByWr0RWxTXA2zHtZdeh7g
         Ol9g==
X-Forwarded-Encrypted: i=1; AFNElJ8hMbsebYZadYpr5OrclHzHfU1lReVRcBVIgekHmhmH4DO1RvQaL4Iuel6cPDqEg2HpF1SlT0Ld/cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmyxBPjCwlTHfWqUk1jaAfFCOSXWDFeLUyiylQ4g323JAy0h6a
	mNPmXVrsaS5EetKjcgaA4p8iMb/j2zflb79nr8Vtd/K+VeD8xvVuOz6xcGRM1RY0ZdQ=
X-Gm-Gg: AfdE7ckp5QYUA3SD6roJaClqQxWuvQyLARMa2zWVhgwRmos7V0FjTBq1mMD1UR1bzGX
	5BM0WaNz6O7Y6ghZZFQWR/NCxApWhg5hc/RDa8UP/bB6KbXQ8PHqGC9hAlGIs2pSeWEnFfxkJEh
	KuFRnonmhuJBtXDg4O7rYxSzPDYS7a+HkN3HxI5uPfZkaSs8XFVJ7+hEUeYuH4QjuWBqlDAqD2t
	1RKuaHwFNmlINHRtLljfnMwRJbiNoLi1ZtSzboOPuqjTCONU7Q4pGNScmjaSQaT8uPkeIc57hWf
	zHpvTe8VV67FNN8SWBJq5vgFB/pELKybnMZulY81oGiwQzGpR+8zxgmBJfr689fWxuVMBO+dkQ0
	iELT68TlGUfhTrHrrJskImBc/0hGe6DTTS/rD/N/I0nJA13j78QXn/AJ68ZdfhatQ9bRiHtmPVd
	1rULlf8IqXgTimn0wnziyqHCBmQLprTEa3vGHaOs7TBxre3dJrJJLO09Z0YCDiWKpNSqbaYJtZe
	yUkBA==
X-Received: by 2002:a05:620a:298a:b0:92e:683f:48e2 with SMTP id af79cd13be357-92e78257ad5mr452595285a.32.1782938625094;
        Wed, 01 Jul 2026 13:43:45 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801948a8sm39241785a.35.2026.07.01.13.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:43:44 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 5/6] nfs4.2: request UNCACHEABLE_DIRENT_METADATA only for directories
Date: Wed,  1 Jul 2026 16:43:36 -0400
Message-ID: <20260701204337.54314-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260701204337.54314-1-snitzer@kernel.org>
References: <20260701204337.54314-1-snitzer@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-22919-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F5446F18D2

The UNCACHEABLE_DIRENT_METADATA attribute (attr 88) applies only to
directory objects (NF4DIR); per draft-ietf-nfsv4-uncacheable-directories
a server must reject a query of it on any other object type with
NFS4ERR_INVAL.  Gate the request by object type at the single choke point
nfs4_bitmap_copy_adjust(), stripping FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA
unless the target is known to be a directory (callers with an unknown
object type, e.g. LOOKUP/LOOKUPP/CREATE, pass a NULL inode and are already
routed through this helper).  This mirrors the NF4REG gating of the
companion UNCACHEABLE_FILE_DATA attribute: a regular file requests
file_data and never dirent_metadata, a directory requests dirent_metadata
and never file_data, and an unknown/other object requests neither.

The bit stays in server->attr_bitmask, so OPEN (which requests the
regular-file open bitmap) is unaffected.  This type gate runs before the
helper's read/write (file) delegation handling and is the only adjustment
the directory attribute needs: a directory cannot hold a file delegation,
so the delegation-based suppression below it never applies.

See: https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-directories/

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 fs/nfs/nfs4proc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4c8436ac5cfc..273fc9fc5fd7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -312,13 +312,16 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	memcpy(dst, src, NFS4_BITMASK_SZ*sizeof(*dst));
 	/*
 	 * The uncacheable_file_data attribute applies only to regular files
-	 * (NF4REG); a server must reject a query of it on any other object
-	 * type with NFS4ERR_INVAL.  Never request it unless the target is
-	 * known to be a regular file (callers with an unknown object type,
-	 * e.g. LOOKUP, pass a NULL inode).
+	 * (NF4REG) and the uncacheable_dirent_metadata attribute only to
+	 * directories (NF4DIR); a server must reject a query of either on any
+	 * other object type with NFS4ERR_INVAL.  Never request either unless
+	 * the target is known to be of the matching type (callers with an
+	 * unknown object type, e.g. LOOKUP, pass a NULL inode).
 	 */
 	if (!inode || !S_ISREG(inode->i_mode))
 		dst[2] &= ~FATTR4_WORD2_UNCACHEABLE_FILE_DATA;
+	if (!inode || !S_ISDIR(inode->i_mode))
+		dst[2] &= ~FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA;
 	if (!inode || !nfs_have_read_or_write_delegation(inode))
 		return;
 
-- 
2.47.3


