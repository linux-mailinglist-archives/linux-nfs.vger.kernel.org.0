Return-Path: <linux-nfs+bounces-13628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4858B244E3
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA481B64A89
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87032EBB99;
	Wed, 13 Aug 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jUQ7XsZs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jUQ7XsZs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969202C324C
	for <linux-nfs@vger.kernel.org>; Wed, 13 Aug 2025 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075674; cv=none; b=Z6D3Rf6fOg+4fymRYxKkRJxCmoV3ZvNNnD0bPEo/q+xUzu8My7lQ70Abkl+zUWwer+TQRXzFVtbZamua4/dFn3FW+cBTERwBbOso2xGWAANiDaAw0iPU1PcY7edjMT6F1Tfj50FY4r58bJgds/8v2w1Z5pX4lZre02R6jn1n2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075674; c=relaxed/simple;
	bh=98gS8jlGUMJgrr2hZDj8VV/wEeve8P7XCKMM65HGuzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQDuRmZMGWQkl6UCI7pwfEdb5NVL6+4udg09b2z9cW/hzEiZTX+2Z38E162BlyNzNA5UWiyKKevfUDs34Iz+EH1fzbOsYYfvOTEavPX43m6ETWqfK39gdQ1f/6U4t01c/flo+Gi8ryo7zaq1B+uPWz1izA3/yFoHOghiLdpb5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jUQ7XsZs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jUQ7XsZs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id BE5441F78F;
	Wed, 13 Aug 2025 09:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755075663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8RANueWYXHx6+a+xemM6bD0hc1Q4kvkaTM/lTKjXNA=;
	b=jUQ7XsZs45MLjQk011y5sMitNQZXecmsL07ICMZgJmNZN7amWL5k9rslWm0FpyMSirC5ba
	ernfSV2+mR0nn7lflVBsLBR4s/0Wzr0vLHhs3x/YSPmaCKZJzWfLMoBJHLx1ZjXHq1g/M+
	sve0dWs4k+cdwU6pz5yKkN4SjBSBIMw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755075663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8RANueWYXHx6+a+xemM6bD0hc1Q4kvkaTM/lTKjXNA=;
	b=jUQ7XsZs45MLjQk011y5sMitNQZXecmsL07ICMZgJmNZN7amWL5k9rslWm0FpyMSirC5ba
	ernfSV2+mR0nn7lflVBsLBR4s/0Wzr0vLHhs3x/YSPmaCKZJzWfLMoBJHLx1ZjXHq1g/M+
	sve0dWs4k+cdwU6pz5yKkN4SjBSBIMw=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: "J . Bruce Fields" <bfields@fieldses.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4.1: fix mount hang after CREATE_SESSION failure
Date: Wed, 13 Aug 2025 11:00:47 +0200
Message-ID: <20250813090047.92365-3-ailiop@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813090047.92365-1-ailiop@suse.com>
References: <20250813090047.92365-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
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
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

When client initialization goes through server trunking discovery, it
schedules the state manager and then sleeps waiting for nfs_client
initialization completion.

The state manager can fail during state recovery, and specifically in
lease establishment as nfs41_init_clientid() will bail out in case of
errors returned from nfs4_proc_create_session(), without ever marking
the client ready. The session creation can fail for a variety of reasons
e.g. during backchannel parameter negotiation, with status -EINVAL.

The error status will propagate all the way to the nfs4_state_manager
but the client status will not be marked, and thus the mount process
will remain blocked waiting.

Fix it by adding -EINVAL error handling to nfs4_state_manager().

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/nfs/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 7612e977e80b..01179f7de322 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2744,6 +2744,9 @@ static void nfs4_state_manager(struct nfs_client *clp)
 	case -ENETUNREACH:
 		nfs_mark_client_ready(clp, -EIO);
 		break;
+	case -EINVAL:
+		nfs_mark_client_ready(clp, status);
+		break;
 	default:
 		ssleep(1);
 		break;
-- 
2.50.1


