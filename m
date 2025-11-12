Return-Path: <linux-nfs+bounces-16308-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31719C53DC3
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 19:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7973B07B6
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 18:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4627D344025;
	Wed, 12 Nov 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W6aP10wP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E87082A
	for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970572; cv=none; b=jBR4ri1pRXoWOscDQViMgUnDM7wvW43iTwZRdpQpFriGEHX4SOQatIG/+ATLmp0p4udh/X8HF168JiLIrMqI6w5O3ZEzi42zfkfHDq1AkaUGIAX/8YQ56ENVxfS6enB6TEXwywd/gb36YmPKE4DW8QiV1j5n+txagOkcsqQIOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970572; c=relaxed/simple;
	bh=D08gs2PneUbQipTCu4MQqdAp1pkAbokPXsane91gNcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9nq0jUW0H66uPGWyEM8IrwKnu/MxrdLGCfz5+DbxMTUayXMCIdhNEwbB7p1uYhi1FKKtBPEIAxE/jex30zvqyGSRhCQ7Z0e0OdzzZygLQAfRnqCFmoeKMsBo9z5XD0boCVsEpVAbdE5ivPO9EQ5PkNIJe84do6eT1HZdn7xqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W6aP10wP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1850502a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762970569; x=1763575369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PD/YXHxrjDe7iQ2y+/SZbIeCZqRT7gfKEAc5Jjv2SY=;
        b=W6aP10wPhevE0oslOobpQkk58GBdSV/oiDEecrkXfq7onfMQxs7uYN+QK8a4H8IS8r
         SRYWXggRe9xIMzXuRQydJ/y9TOzfVvz9Q3cpxu5SgDsEMakf2VGQG738wO4eF1UrJEUY
         URV9TJ7FD2AMB7sQpD7NhxP/mX0jk5dvRNZ2GKalsJ72MVytQExreNiP3SpU73Tb5VQK
         u8cn/V2UWWyNaNqiwXQCYnh6UnzizUIzb/M3f6I1OUic3KU51wlGHg1PsbqdLEFLkdPq
         zSFxmHpRbFtjqHpX413UPO0arKp4P9LPuxDUUfEJk+UqMJjsNtaUk49i736SwG/dlQ7Y
         k7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970569; x=1763575369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6PD/YXHxrjDe7iQ2y+/SZbIeCZqRT7gfKEAc5Jjv2SY=;
        b=YhMDcrEjgL+U0fF0+xLR69/hEZycfn9TXc9Dlrtebo4Y7hbFGmIWFzUquzeEiDlyqj
         hZJl/Q65Vpmwq+AOqHxQp5yZUixLkQHwy67E16LQiGhccinpxwXBJCbtr/MqqklvAeI3
         qcNh3OHvRdlXWY0aGh6PNhBosBUkYiiSSGsaLxFt++r5ixG7cebtZHG/BKnRebfNUscm
         wgUCAK5XYBlrIwUOzWNRUa4/lpBfIQfddyfbMTRcTdoVl+JK+jYi5rY0NF/TWcwjoLA7
         FrDtQaFJ2OsnJ7p6xwxLLCcIKOcx0TfmLxbpqkd/hdq+iYM1B2xs6+kDS9OUIjIc3MPd
         WT5g==
X-Forwarded-Encrypted: i=1; AJvYcCXB3hJeImMuLQtLBt3l1O+6KoXXPtSznXlC6KDimvwxug6LW6Lj8NrlUSitxNz2UvAdU8pBieZgIMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dRFaifgUi3eThm1mdKaAQINDGujqcntrYj0ABVIy+A7iXBj5
	3/Q4+D8EeFWCmslt5IOtYtLkwyJ+9sGiFkocwlXDyqW5G8bvHzWOOnC4Dd0MaoPwvHo=
X-Gm-Gg: ASbGnctgY2LTSP51tBakS9Khq9Nlwez5cYWBENUs92Xf6GyXaJV91Dsu1Avg/ACL5wa
	HYm6D7tmxQl5SrnujNiTkys4WZzjZ+leHpDEFOumM7I7++sUq0OOdvLqYupLJOnNo4IGbGQtC0J
	zJo09k3wCbyCw9l7dukiyJ1+tvgBAhkuUUH8W0UOMCxjYywdNUh3vMyPlDbn83OisQotbdO53LY
	nBNa5U4JEuGajCBd1zSdKkPtarzuGIrTqvxCpstVYDEHjiOvBJs2nKSvDsWH4Dq+lOyvON5f4tA
	nWWkYuo/mKHOPJA1QUHzrcv3uEY921h9p4qudgscLVQw6h8xGlZTXJwwdoqm1RwavkgIInlKk0r
	p5cbG/jI5d1YXrd9VwYlfciarL1xlX2TWi+vU6Wf4mKeiICzmAFn5VubidLcXbHeAQ5xbXmamDT
	clU06iby4h6f4=
X-Google-Smtp-Source: AGHT+IHAicBfZEqXyRcHjmwIQ1euH5/JW7kxWorWof9NafLXeiE2aTBzGxknrmbQRVwkhmtLPZwrrg==
X-Received: by 2002:a05:6402:5111:b0:640:b07c:5704 with SMTP id 4fb4d7f45d1cf-64334ce31e9mr268736a12.15.1762970568936;
        Wed, 12 Nov 2025 10:02:48 -0800 (PST)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6411f862cd7sm16296046a12.30.2025.11.12.10.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:02:48 -0800 (PST)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Haihua Yang <yanghh@gmail.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_layout_stateid_invalid
Date: Wed, 12 Nov 2025 18:02:42 +0000
Message-Id: <20251112180242.345608-2-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112180242.345608-1-jcurley@purestorage.com>
References: <20251112180242.345608-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a crash when layout is null during this call stack:

write_inode
    -> nfs4_write_inode
        -> pnfs_layoutcommit_inode

pnfs_set_layoutcommit relies on the lseg refcount to keep the layout
around. Need to clear NFS_INO_LAYOUTCOMMIT otherwise we might attempt
to reference a null layout.

Fixes: fe1cf9469d7bc ("pNFS: Clear all layout segment state in pnfs_mark_layout_stateid_invalid")
Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/pnfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 5f582713bf05..358b04ec5867 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -466,6 +466,7 @@ pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 	struct pnfs_layout_segment *lseg, *next;
 
 	set_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags);
+	clear_bit(NFS_INO_LAYOUTCOMMIT, &NFS_I(lo->plh_inode)->flags);
 	list_for_each_entry_safe(lseg, next, &lo->plh_segs, pls_list)
 		pnfs_clear_lseg_state(lseg, lseg_list);
 	pnfs_clear_layoutreturn_info(lo);
-- 
2.34.1


