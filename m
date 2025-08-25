Return-Path: <linux-nfs+bounces-13889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C01B34E03
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 23:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB7D486CF2
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 21:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B7277C8D;
	Mon, 25 Aug 2025 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BiNFgqTg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAB1991D2
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157260; cv=none; b=bkH2NStoVZkqyvhTbDWkUMO1xs8sOZxuTtj1fyvLf42l/ilvR+65wsno9eVxn+iYH8z/0NKKYsJEmLOeFtJEz7DvHHAsuAVunRg5safY0YbP2vWW7dSBQpPop4SLgOv3WNOVMA7Y48lksqgVEvPQQx9uLwQOAcccNmssEKocy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157260; c=relaxed/simple;
	bh=1xeGAreEi2x2Aquc/6dLVE/3TMfMr/uLa0az8bFjmD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sUglTlDkTI2+p5BcHWk7AsI/dxVVAS61K9qj+5HXwmJfMSJvP9g1KcmUEHnLvp0r/lCgLC0ApNCvkCHM465eT5mFzQBj7F+RVccDj6HVEScAt3pgQcai2UbwByG0E2nCdj9AAVtQGEKxsBvm31DYbCfAyN6Utx82H7jthf8PCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BiNFgqTg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so674311566b.3
        for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756157254; x=1756762054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=BiNFgqTgOpzd4tIc20HDd3WjuWDkRTe876U//vpz6S5LdpiqkW+fjRkXZ+e5omLbnu
         zuGHx0xB2Q67vv6vWgbVvPKtHVaNhOTzSwSsAxVkJDobALiTdxVHvLkVgskq1mnwBQSh
         66KECyT0R9Uj2F2GuYafSQiXelTYoAkE2StmKHdFOG0aojeHT02cHIZ9z7xiJoykozlM
         CEROrvPiOwMVwozqxxplz03kEnOqh0Zk01XTyoQIycLKF1Y1CehxcR0deZtmT3gW3BMM
         N/HXq2cHXCHx6XZLabBA/YtATtOuTzTf2TmiTd4kCc3+YyQ2xzM1cRk2Jk7qhD2+s8NB
         c6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157254; x=1756762054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=t/ubg35Mx9n1QVj3ZNu8+PZYNeeZCsfXGfYdRy3FUcKVrrq9HHrDPXERSS3VQhondB
         pIUgtlupDcUBhuChECT6LId2FmtG31pHea89WQmQP7yTkvvQKdtlW29d+6iLERpQ7Gj6
         A6fbd0qEJZ7t0gOPH8YQgvgl8y7ryaaBK+guwYMvy1NvSfp1FybcsHvRKKB05BXINOrm
         7MuRujWziSu64Uo9GjI8B7V/S5FSx+EUQKu8Sf0xDFsC81sa0Qpi7XTge1Anq2fOmgAo
         2C+R3PyDdPhsUO1kxGekf/tLAAx3hfj4Ge9BeZDrG90hIDKSwTfIYXNIXqjeTRyI/KE1
         ++3Q==
X-Forwarded-Encrypted: i=1; AJvYcCURrYDOT4IjU9dlhiR8/cstNPMr2aN8K1bmSu+0tpbpHPoCDmeuf459Jc6NiuShh7NAkKjbI9P3k1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrW+LYNSD6eCxNwfkkkNrfYQPcvc4YtsE5jhtQHcuyE04uEOyB
	wEhPPj/+McurRQDHvWP4tV/STT2oyAOwg/K7cWTQvIiStL3jHsy1oq9dGOrFSN94WkY=
X-Gm-Gg: ASbGncvl/NauAhpNsVMu4SNdCmc3Jx0z3k/c+Q27CHE/SEa8u1xa/1/rZnTKH/NHSRU
	REL8ZyEQy612mGncR34BC5/zwdgQ1XTv807ClTXsVmTanMhUzr2FIZMc1Rb3Ygy66b1SQxaiSbC
	02UZEfJj1/Cx/qBm1gOPACYMlbVoBjdrc/ZLydQZTUATd1L0XaA8ML30PPHyY3V8d/Qi1DPXYXz
	suPUK4oGN7jtskHmaR6n9ZgLWIn4UUISaNgoRJ/k0ZP4A4j1IOYt4DH2LWXY6o8EO4R5uvz8Dct
	YwXU/nOC7woI0jRlP5MfqFNSnzRrmNE/MDJmdtGbl6i9J/xx08OxgmcAUVhzGNS4il/rusDL5Z7
	g8YkkZe6DsRB2MgNdFYd7zcw=
X-Google-Smtp-Source: AGHT+IFxHO0Q93IzEhfxGk7illEZfSQE74ktfAzsEduUmTD+lgDdjoFDpFJGVu4miBHsTGT2VRg1Ew==
X-Received: by 2002:a17:907:985:b0:afe:6648:a24c with SMTP id a640c23a62f3a-afe6648c0damr594863766b.52.1756157254377;
        Mon, 25 Aug 2025 14:27:34 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afe9f7a1b2fsm41066166b.38.2025.08.25.14.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:27:34 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v1 1/9] NFSv4/flexfiles: Remove cred local variable dependency
Date: Mon, 25 Aug 2025 21:27:21 +0000
Message-Id: <20250825212729.4833-2-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825212729.4833-1-jcurley@purestorage.com>
References: <20250825212729.4833-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No-op preparation change to remove dependency on cred local
variable. Subsequent striping diff has a cred per stripe so this local
variable can't be trusted to be the same.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 4bea008dbebd..a437d20ebcdf 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -532,10 +532,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (mirror != fls->mirror_array[i]) {
 			/* swap cred ptrs so free_mirror will clean up old */
 			if (lgr->range.iomode == IOMODE_READ) {
-				cred = xchg(&mirror->ro_cred, cred);
+				cred = xchg(&mirror->ro_cred, fls->mirror_array[i]->ro_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
 			} else {
-				cred = xchg(&mirror->rw_cred, cred);
+				cred = xchg(&mirror->rw_cred, fls->mirror_array[i]->rw_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
 			}
 			ff_layout_free_mirror(fls->mirror_array[i]);
-- 
2.34.1


