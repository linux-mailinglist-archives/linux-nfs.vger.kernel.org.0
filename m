Return-Path: <linux-nfs+bounces-12431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09729AD884B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 11:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7B51897E0D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 09:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14F2C159D;
	Fri, 13 Jun 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qFKdDGdY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qFKdDGdY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362702C3262
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807920; cv=none; b=YBAlRPT+Rx7YwzwpGlefjzsYxqaFe3TohJrO1TbPaXH13Zg0P0xjDJTFrQ7xIQNn9So3LNLxbIFAy2LTwlTwNcFwxvZMDKgxJBBaIVAf8DEbd+KINVcy51U/fmjqOwwaNdeHpInVAhfhdkEcnLbDTHC5eQMgyD2LWf9cKptlf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807920; c=relaxed/simple;
	bh=mMpBbEvbeNXlC5X9MC3OgHZtGFuzFGEpvWSd0B3IbfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLk+P+0nF9HlbtoCAB0sPAiT2sN5QGmp5rQAqcWJf5G6Ez5R8JeE9hbTkLBKQCRmZXnfg9+142rimHOZyZcCffsPEXSG3jsfnUpIZ0e+5WIlyDrkKdTEhckXp/P+NGbc7IYDUNaX2tqgA0sdRRT4azfPoWRFhhnSY7SFMHrPJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qFKdDGdY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qFKdDGdY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 6CCC221903;
	Fri, 13 Jun 2025 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749807914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T93nWSOKpYiphFrBz44VoY1CDwFHzHVBbfxOK7WrGD8=;
	b=qFKdDGdYX5B28I+0jtLc5HCsvM+qSeyGlElKlhBWhyLJH0EpUOpF21cfLB2orS2PwUB5lh
	hThOfsAwbaeJcWH3XHqiQfLtJsZ3CtyF7GujLIO/yQzDEvXjTTnq3uVDvWBvaCIivuLYC/
	YQ2ZqKFDqbVv5IZnY+6VIRIaegZ1Nls=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749807914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T93nWSOKpYiphFrBz44VoY1CDwFHzHVBbfxOK7WrGD8=;
	b=qFKdDGdYX5B28I+0jtLc5HCsvM+qSeyGlElKlhBWhyLJH0EpUOpF21cfLB2orS2PwUB5lh
	hThOfsAwbaeJcWH3XHqiQfLtJsZ3CtyF7GujLIO/yQzDEvXjTTnq3uVDvWBvaCIivuLYC/
	YQ2ZqKFDqbVv5IZnY+6VIRIaegZ1Nls=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] NFS: struct nfs_server minor cleanups
Date: Fri, 13 Jun 2025 11:44:36 +0200
Message-ID: <20250613094439.82338-1-ailiop@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Level: 

Minor cleanups of unused fields in struct nfs_server and associated code.

Anthony Iliopoulos (3):
  NFS: remove unused wpages field from struct nfs_server
  NFS: remove unused time_delta field from struct nfs_server
  NFS: remove unused pnfs_ld_data field from struct nfs_server

 fs/nfs/client.c           | 2 --
 include/linux/nfs_fs_sb.h | 3 ---
 2 files changed, 5 deletions(-)

-- 
2.49.0


