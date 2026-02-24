Return-Path: <linux-nfs+bounces-19181-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEH6D8rYnWk0SQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19181-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 17:58:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DEA18A30D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 17:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E1D3308E437
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCDB3A9DBA;
	Tue, 24 Feb 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwYJIlxL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B63A9DA8
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952106; cv=none; b=W/h+5NieMIflTY/OKbYxZvgWrjYtHqFt8iG5I3Ke2RXa2SShMXd9sDu/4Ly7I0toExc00u9FX+ng4lNORCfTZf1C43O8rc/dFycKgeCicwbXWnHW3FQE8EptA4Dvvr8+rYNm8u3S5Hx3b+D8jdk8ZlL77Pf/JYz17x80UALxhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952106; c=relaxed/simple;
	bh=YQW0EfAeLICvyMNg/tfBC2TK594tWmLxtymR/cKwzGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNRa96KOMlxdwRsUajW84V5YKKJszrSnfB84m1ypD0Z9yIdZxg7WK7SdmW2UYjGcozB/QXAdot9aYBWLshg9jlR92CpstY4QypLhMaF4SNKen/ENq5S+X/fBCURnV+bbKjot4Ee3yYHL/WMzfYRTSlSbIHHkDexhQtFnR50MmKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwYJIlxL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso3035559b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771952104; x=1772556904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qm9aAVKRhdXbmvZ9eNzRctppVAHInh8i2MIXKl/+Wg=;
        b=mwYJIlxLKjYKko/wvpn5zNTqn2jXpvmo24X3KL/Sly2GOmvJgmanjwa6FRfv8AmIxA
         GobsqqCl1Uca57eQb2CS74RpHbkc51PYcdApnoLaSgo/nJnFEmn19oWv9o4ndS6b1FuZ
         BDQqQ5wBiRfNnFSAHnJ5/dqNJWRWR76YUdn7nXRdcz3035bktqpMAcd3kdsDNqX18O2Z
         7npt+V0pXaHV5Aa5Tbyqwxs37WYK8zUeKj9jSbTyKD6hYdmc92WjEDNGe9E9tgok0H0z
         HZEjlyQetw0rlq+L/aEsKdLeBVnrfamPuPhGVkB2MjDPA6gbPWORuWkhyYFyhkmL/Ynp
         mgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952104; x=1772556904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+qm9aAVKRhdXbmvZ9eNzRctppVAHInh8i2MIXKl/+Wg=;
        b=QsoS0axwtbrDNAyNn+2NAXWLalt3QTyEQPtRvc2Cf6rU0NrRLoWfM6qddKuAh44OUk
         FLSE0SFRPp28xqnKm2rg/9pdmbqQ9aoMzpbs5Wu0XrwONhDv78S0HRAvT4IobUYLW0v+
         DDe9zS1bhRMdbpGNsC3nynDlNif7SYKnWUG6dyFbYeZLA2F1nylYCWnCZCZYYAjxGxxv
         u7H/axKsS270r4Equ7z5xkYZwL9JphXXB7wdlR1/UZWIpQIGywUPEGzKqQDvzFlJYPpw
         EZSp9JjFvPoiA+ZzA7vFAuh1NEXBngr3CgT8py8V6ncsMQn541C7i4Rhw6rMCTrkTCEh
         y2Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW/QlM0VfNy2xbixCdTxhD3GCFQ8swJhX4jiwq/2h6sDQZtIXqYDCb31qwbgUFSur5rTsNBanzMbVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZGEwWQUYVMgWyNCyzDBqWSwsu2D8GofaiLr4kzRLUoKWejHE
	S+xuQrXo9woEsNrNWXSpFZcY4SvKbITTk1PzXqQzUns4rNlnoQPyT5VE
X-Gm-Gg: AZuq6aKraFzM+j4KxnbSs8igkvcH95al1BZPR0y4WkAU6v7eSEi7Twn161WSglXAtQE
	Hy1HjcRzrSHon6eyXgK4MghXY26A0d/xsaANLGjozKQ3GGWXie3+4voHfw5P5DwhRUpNaH42t/f
	qT6tjNBPVIpnZK0T0wlQi/pc8Il4/NT0HzDApWQ130DHBUxtMZbS9WWG7TIjZFZI+wXOaovJLQV
	jdtVVPGB9K1lM7WWYOGGPnpooew2vcJQ45s3IEHFcvgHVKoEi5QNRzv1M8/wXWruLWCBjn8hEwW
	y2dJKW/PUvMPZl8rJRYN4yqTxdTWNxaJ9V98vV5Sr/38GXYPI+HlMsp2ZpOzCpCPxcyZj78nDCd
	fHbRSNMrFLzl3jAkdYlufTlJOPfScW2hrNs5GvqZMy/BVx3aGnenEVV32jt56QX3Uu1mj0duD3D
	6q45geIJ8CTvn+vSh40fhHpuoGDNh9BA9dftvqr6NFzED1b5Z5IKKui5o7h8WWSj71MZTeciAwn
	A==
X-Received: by 2002:a05:6a21:6d9a:b0:35f:b96d:af11 with SMTP id adf61e73a8af0-39545e3c7a7mr11945453637.5.1771952103875;
        Tue, 24 Feb 2026 08:55:03 -0800 (PST)
Received: from sean-All-Series.. (59-115-199-112.dynamic-ip.hinet.net. [59.115.199.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7256f32sm12364083a12.27.2026.02.24.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:55:03 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v3 1/2] nfs: fix unused variable warning when CONFIG_SUNRPC_DEBUG is disabled
Date: Wed, 25 Feb 2026 00:54:34 +0800
Message-Id: <20260224165435.17648-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224165435.17648-1-seanwascoding@gmail.com>
References: <20260224165435.17648-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19181-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17DEA18A30D
X-Rspamd-Action: no action

When CONFIG_SUNRPC_DEBUG is disabled, the dprintk() macro expands to
an empty do-while loop. This causes variables used solely within
dprintk() calls to appear unused to the compiler, triggering
-Wunused-variable warnings.

Fix this by adding __maybe_unused to the affected variables. This
ensures the code builds cleanly across different configurations,
including RISC-V, ARM, and ARM64 allmodconfig, as verified in the
mailing list discussion.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    | 2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 3 ++-
 fs/nfs/nfs4proc.c                         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 9056f05a67dc..de9e8bad6af2 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1502,7 +1502,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	u32 status = *op_status;
-	int err;
+	int err __maybe_unused;
 
 	if (status == 0) {
 		switch (error) {
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c2d8a13a9dbd..3fb8dba0abf5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -53,7 +53,8 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	u32 mp_count;
 	u32 version_count;
 	__be32 *p;
-	int i, ret = -ENOMEM;
+	int i;
+	int ret __maybe_unused = -ENOMEM;
 
 	/* set up xdr stream */
 	scratch = folio_alloc(gfp_flags, 0);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 180229320731..f76c23cdc888 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9241,7 +9241,7 @@ static int _nfs4_proc_create_session(struct nfs_client *clp,
 int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 {
 	int status;
-	unsigned *ptr;
+	unsigned *ptr __maybe_unused;
 	struct nfs4_session *session = clp->cl_session;
 	struct nfs4_add_xprt_data xprtdata = {
 		.clp = clp,
-- 
2.34.1


