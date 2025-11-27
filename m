Return-Path: <linux-nfs+bounces-16765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91BC8FD4C
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 18:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99553ADE87
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A32F746C;
	Thu, 27 Nov 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oU/kSU9v";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BZ5xfX08"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839272F658F
	for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266321; cv=none; b=O8uNC6126REdxh3/4EWSphbnGX8he+aSHCRPHuYeFreNNk5c6t9HYBZ33O2P2k6MzOtqaMx5T0a1ql9Bek+PMGLH5vUxMjUYfnqp7nG6nate8UErjHhOt3N7dC978ELDnwG38gqvH1tifPfST1XRI3pncA+tRbD3/lRCA2J8LBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266321; c=relaxed/simple;
	bh=L224FyFbaCPH5WBK4gBVM3bCrAWcaSySHzLSK2IWIxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCh8jJ8Plt3qR6AG4q8xykqKMnpPc81mfP+a0HgYFm3HZYQzIce6wGQAmXhMrfYGLj15I/jaLf0PeuV0vMgx6lCUavjX6bW/E7frmqZRpgP0Dj4ddGk3K0NNqkl+O/M2RfVm3Btayg9Y+btxjPg82pGg6b9C9GpG77oYRjleiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oU/kSU9v; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BZ5xfX08; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id C4B2A5BCC1;
	Thu, 27 Nov 2025 17:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764266318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Dd2A0nsSkB6XO45f1iMc6Qf2cfJhwgW6BffDXha7zlk=;
	b=oU/kSU9vusG9EU1cIwoyz4PSJgjNaficIeUCIAeV9qhSWwYIAXq/5rTyOjzIlp7kR8iFFP
	Vb739n3Ww0C5kXqf+TPzd8EJ3+MuXfCl4A/EIfmfv46njVhyzjrpaNFT0fg3EjMwz3M512
	CRh/AJSpNR2KJkeqvh8ml5LtuCm6hsA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764266317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Dd2A0nsSkB6XO45f1iMc6Qf2cfJhwgW6BffDXha7zlk=;
	b=BZ5xfX08lgItG75F6yDR5c8USR8edb7k3C3CJEDkah/wGEx6Ag7VnfyVEmW98xUjFfosiO
	+r6v5JeqZIPja/yqgFTCsJo5nVyWrQ/aDXBoNynS1HSVSoVoOt79si6/dqeWCoDO9Ox4gn
	Up8tbWsirWBdeeqDxdwYuzQgGMR01T8=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/2] nfsd: fix handling of timed out idmap lookups
Date: Thu, 27 Nov 2025 18:57:51 +0100
Message-ID: <20251127175753.134132-1-ailiop@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.arch.suse.cz:helo,suse.com:mid]

This series addresses an issue occurring during v4 compound decoding, when
idmap lookup upcall responses are delayed in userspace. This causes the
related request to be marked for deferral and to be dropped, preventing
nfs4svc_encode_compoundres from being executed and thus never clearing the
session slot flag NFSD4_SLOT_INUSE. Subsequent requests will fail with
NFSERR_JUKEBOX, given that the slot will be marked as in use.

The first patch fixes this by making sure that no deferrals can happen
during decoding.

The second patch fixes the return code of delayed idmap lookups, so that
clients will retry the operation instead of aborting with an error.

Anthony Iliopoulos (2):
  nfsd: never defer requests during idmap lookup
  nfsd: fix return error code for nfsd_map_name_to_[ug]id

 fs/nfsd/nfs4idmap.c | 4 ++++
 fs/nfsd/nfs4xdr.c   | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.52.0


