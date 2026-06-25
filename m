Return-Path: <linux-nfs+bounces-22831-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sUoUMd8ZPWoRxAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22831-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 14:06:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2A6C5616
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 14:06:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=EbcKWEiw;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22831-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22831-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 094073028820
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E043DEACB;
	Thu, 25 Jun 2026 12:05:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A23DDDAB
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 12:05:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389155; cv=none; b=TeGfFDkBdWfJD74SUBnGuxXE6keDtnsNEDuB7kuub9qcUamZ4NFOLG3HeBQ+YI5NeZ+8mTSaPEr+7GbYN2NhAxhMqS9WJhTVbaPctbrg5i7jq2U62BIzSwxHQ1Q4bdtaVw+FmWI8d3tpUwaIBlV2MtmfnvzRxoVM6827LRqBUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389155; c=relaxed/simple;
	bh=/tcYaToIiw49OPcSM+NusBXpqlKfF5M19XnrJ1xXCDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1NGbqowfLMjw+XyWyaIsvtbzJGtvbTyet0NBBSeDE6fo5sEkx1V7VpoyTwEicVtool4eGAwD6kvGbkNiuxkGCwUAvEQR/CN165/EKSwyKE/mLYDqNHm7p6LzEOsbvnQy0IJgI3RWi2xrSzS+QHuhCRY46xCGRUm+yvoLBWdduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EbcKWEiw; arc=none smtp.client-ip=209.85.161.54
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69de16f5e80so1222579eaf.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782389153; x=1782993953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sq0U65qOces9m37tRNMb9FgHujeXBhW2ohMx18tyGn0=;
        b=EbcKWEiwYaTJ3+FGFWX1LboJwfj6rT7cZARBKUp/yktUljB3ritDGyOyEVDTsTsUt/
         +S7dgNDaz2SPKRIq4CcWnLaaVkoRb2xtrRJL0xCFMjCyIqdRmYTvNNLfQcmEdn8DPZMl
         O5QdRenXd2L0xpE+petaWeD+WGtIdbcdTstT1+mjjUKkVLM+11pL1Z0zh5MK5WV9fUHX
         fEt3vQtfx7FkKo2Z1TANNpwmNNDnlBlrIFWczG86beh/v4wdRafOXbUcZLjls4HkPRpv
         VOxNAFz6M1zGgXtsot0WjlOhEzvi89xCxAoyTAQhGJQ1LW33k3SXqaNOHcUfOyixpWlj
         eUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389153; x=1782993953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq0U65qOces9m37tRNMb9FgHujeXBhW2ohMx18tyGn0=;
        b=QpYgmGtCqvOoSNXmADW5LHofxVBelvIg1hxf9uoRGphxWsOCNg3qSLua0VDtQlCECr
         ArIl0y+eMyBwTranIaWQS6h1R2m9Cn5kbytMltWEkx9BKPs0tK6mD87c7GPpqMTe+EWD
         g5kbq6cswsnClJuMuzw9dOYM/N50CNMIlS9rFJOHOY7IPUOW1yDEPvIWLZFQ05OihtOk
         tmHilghm14r6ukEcyEV/PVggUHdWzuhr4UqVcaAIL0ZeB9KXRcIgKCsdo2ySyjDjaUpd
         5523XAXQY1+qZjAGYMUSctvgRIyXNgbg+JD5O4k6QQ9/ggqKS/bzWQvl5toGUzvBZBJm
         c7WQ==
X-Gm-Message-State: AOJu0YxqOsgT4FyMBwzkaj1JF8brxYbuk0WvsumgNN2uSxByJwBy2UvG
	mMj5q0wgUdw01Klo999w7MlSmsyc3KavXI9RfpcBVLYNIND/8m2cMuOImECKAG8gzRk=
X-Gm-Gg: AfdE7cmRSCkAqtT6uRIPpoQmsfVD/FtnJQ/9lgjnCg3XKx1DBXLzvL0iUz/wb8HKIVx
	C5u1d5KNfBPYWvhSDbm/0hWGeLJgxksQ1GG6cvs7FwIZP1Va1HCVnd82PC4whIHnHozgLOK4f4u
	MJVXoJkBFRNrGkTovb2Tqb2tUbZJjhasV76/CWeyGhl2A9zbb4ltD4i/kcrQaUzhw1caHkbi500
	zNGPoxXUqYRN0IYLKTuX/80Y3PECBqCiO+VhNf1AqlxEFYx9c6gUNdymCqTAcbOQwLCRUMJFpMc
	lpCAo2XbR+rbsIAchv+8UggjFcCYkPR5ASFoeP14Dp2AZ5M+TR6JRALlxBFHPWE4CKO9zic5uMQ
	4Yyq0UlA/0VrDWHnnqP+zq965g6F5i+oJcr1kPDBplgdDx2Qy3OgfyJ6nE7NnrurYc8DkO5PqW3
	p0TtFfZSeigPewK2w7sdnv1lBAiPGv0ZJNaD7Tmtv6T3CjNUXd
X-Received: by 2002:a05:6820:4dc4:b0:69e:14a:f30f with SMTP id 006d021491bc7-6a1352267afmr1905983eaf.41.1782389152646;
        Thu, 25 Jun 2026 05:05:52 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472e79af8fsm11123405fac.0.2026.06.25.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:05:52 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/3] pNFS/flexfiles: honor clora_changed and report cancelled I/O
Date: Thu, 25 Jun 2026 08:05:47 -0400
Message-ID: <cover.1782388900.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22831-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:dkim,hammerspace.com:mid,hammerspace.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BA2A6C5616

RFC 8881 section 20.3.3 lets CB_LAYOUTRECALL carry clora_changed: when it
is FALSE the client may flush modified data to the data servers before
returning the layout; only when it is TRUE should it stop writing to the
DS and redirect through the MDS.  The client decodes cbl_layoutchanged but
has ignored it since commit b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if
the layout is recalled or revoked"), cancelling in-flight DS I/O
unconditionally -- which can leave a write incomplete at the DS with no
write layout held.

This series teaches the client to honor clora_changed: on an unchanged
recall it drains its in-flight DS writes before LAYOUTRETURN instead of
cancelling them; when it does cancel (changed recall, or revoke) the
cancelled I/O is reported to the server as NFS4ERR_NXIO so it can
reconcile the affected mirror instance.  Patch 1 adds clora_changed to the
recall tracepoint.

Changes on v2:
	Anna: fix missing kerneldoc comment, remove FILE_INODE

Based on Anna's nfs-for-7.2-1.

Benjamin Coddington (3):
  pNFS: report clora_changed in the cb_layoutrecall_file tracepoint
  pNFS: honor clora_changed when recalling a layout
  NFSv4/flexfiles: report cancelled I/O as a layout error

 fs/nfs/callback_proc.c                 |  5 ++-
 fs/nfs/flexfilelayout/flexfilelayout.c | 23 ++++++++++-
 fs/nfs/nfs4trace.h                     | 55 +++++++++++++++++++++++++-
 fs/nfs/pnfs.c                          | 22 ++++++-----
 fs/nfs/pnfs.h                          |  2 +-
 5 files changed, 93 insertions(+), 14 deletions(-)

-- 
2.53.0


