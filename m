Return-Path: <linux-nfs+bounces-13626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC2B244E2
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 11:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4096A1B62F62
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236EE61FFE;
	Wed, 13 Aug 2025 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GjprlOyL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GjprlOyL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4461FAC34
	for <linux-nfs@vger.kernel.org>; Wed, 13 Aug 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075660; cv=none; b=uk+kpSVPjeUzYoiJ2Hu7TsFCo0aQbAmn6NPdhWx+fBSMnCiIgHn82eGdos6NSWrV7Lu3lrpWXmr7DniTs5WUA1+N/buHAiBzSSawvCcPJnZSd8ymZP/zzxsK2Git9N3bLVXn6YmzPGpRJg9tr5UNVGX09hEYzU6wpOzL4wKl8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075660; c=relaxed/simple;
	bh=zGNM9q/RWj/4h4w7Z4WT1YjSbVutjlbGgiMmDlqZECw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twElWzOZ0BvdPw0APfkr6z6CN3dSUSHc90CH63rsLtsst1BDuCjO9mpc5E5/VtriqfpqWOSqJQ7XVsEVISDArMPsfMKh4EzGRok6aqB+wK7nDhRvC26aeFsfyc5TgZulrNj9DgoQh2H5s0E/PE70npyXiJSDNCp7e6U3XbPDYew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GjprlOyL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GjprlOyL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id 4C2A21F455;
	Wed, 13 Aug 2025 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755075656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oHUAVau6ODGU75nNV2EzA/QFjAlgW0s2lUCpX++ZvD8=;
	b=GjprlOyLI5tLNC3Myp8OSZ4WtvsY8O7750q00gX+lfxzSn9ib66XJNfbpU5KiunvHzoBo0
	Q9e7XxGy1uYD8+sWKXhVii5tQNJe0jcZ7IF1ReUg5r9qx+ZxpnSSA2tUwKqylQ1uBv8VG7
	9nShxTBDVM7VL5SMGhWGB6hiP0/GxCY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755075656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oHUAVau6ODGU75nNV2EzA/QFjAlgW0s2lUCpX++ZvD8=;
	b=GjprlOyLI5tLNC3Myp8OSZ4WtvsY8O7750q00gX+lfxzSn9ib66XJNfbpU5KiunvHzoBo0
	Q9e7XxGy1uYD8+sWKXhVii5tQNJe0jcZ7IF1ReUg5r9qx+ZxpnSSA2tUwKqylQ1uBv8VG7
	9nShxTBDVM7VL5SMGhWGB6hiP0/GxCY=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: "J . Bruce Fields" <bfields@fieldses.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] NFSv4.1 client initialization related fixes
Date: Wed, 13 Aug 2025 11:00:45 +0200
Message-ID: <20250813090047.92365-1-ailiop@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.980];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

This short series addresses two separate issues related with NFSv4.1 client
initialization.

The first is an issue with backchannel parameter verification when
negotiating with a non-linux nfs server that does not accept larger
max_resp_sz values.

The second issue is a side-effect of the first (although it could be caused
by number of other failures during CREATE_SESSION), which makes mount hang
due to lack of -EINVAL error handling in the nfs4_state_manager.

Anthony Iliopoulos (2):
  NFSv4.1: fix backchannel max_resp_sz verification check
  NFSv4.1: fix mount hang after CREATE_SESSION failure

 fs/nfs/nfs4proc.c  | 2 +-
 fs/nfs/nfs4state.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.50.1


