Return-Path: <linux-nfs+bounces-6722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223298AA40
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 18:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0731C2103D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB660194147;
	Mon, 30 Sep 2024 16:46:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF896194A5A
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714805; cv=none; b=WVmcyDKV6IdUE3Ay05dHJUO+oJtIBsAVZ7h7pSv1kcQkBiL28JnhXkQVMA6GO+SC/QM3b6Rn0ALVuxyvYLc8P5K+YVk6KAv7N9zN4dpa19enuqYp0G7ZKUoId7RbPkZKjsNAkjzojAYzgE4HpMGVMder4wSMKuMgezmxu41IdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714805; c=relaxed/simple;
	bh=LH/9XcmSR3NkV6nlSKilhsUp6En/XXDQY9YjjgQLYr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8zQyWZZezWi22YN9CddL5xmOXac6CUK/Z3XwKwqfAU3AlMUoFnL5RPctx64Wi4ehf+29ey/+ojfzzsi3Sp1xj76go9aLrnXZTEjL/s43Z+9w1U+rdIqojFvsSbnQ6xgwGoRLvEYBSUOsggrz7qLPjhCSdPbuJf5z3+lv+r3on8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84e962c9a99so1313466241.2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 09:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714801; x=1728319601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7mWYU8SpdaNosLi30zt/7SRNoNMYVqo9lHMgAOchDs=;
        b=h0Vj9CmqSHZt7ehcn8ROAehtEp+BPAEm/H6DwAclRFSr7b7Unq1GZgc1yTrRgzf7Ad
         YpVq4+zYMpvvbulySpvuvFQc1yvGTpfqcPsp1yJpmmrZtobpCR8PLwx3G8NKVvXx/3iX
         2IQUa66h3T+vyPCvDlvd2KPN+4y5S4ulgAnD0EDZTfTED9qfWWDGfjtpPV4H3I5Ka6hp
         FDtk8wukdzBmkPaP5kWIrkF7MQJy6vO8bwmaF3o080w2fuQebgmMtzChLm80FvqhDujq
         xKbFyGTjmEGTYACQ3iT94SV4a6WxCeBnlljHuGlK38HsbZyjMJjNcuLWLGS8rtq8nLFH
         FA3w==
X-Gm-Message-State: AOJu0YyJigUzy82anP+oWccN8oZoOaUfkUHhLmPzw8iFwwT2ifVD1CKn
	88XlNGdo4oYeJzDtsG/+b9EmkpuSdTIy2dhpYboOwpMPhaWiPuXYMEtkIwzLf3eye+4BkNxJfa0
	Cl2rl94lhVe8Gr1ZRwbZa7BCumY6WwFWwsQdV3DJSYJFEQj7uCT6UC8ZH636/YExD81v6Yx2T0P
	OzIMkxXCsTS3i1N/2ZvcRHCus4vNYo/8obbQqxCt8=
X-Google-Smtp-Source: AGHT+IHpFzZvc1M+5zHttY/bbaprE+d54TAO4RYiO6+ObH4K0uHskLoeXwdG1j+Wos5YE8msCx2JKQ==
X-Received: by 2002:a05:6122:da6:b0:502:bd0d:abe2 with SMTP id 71dfb90a1353d-507816decd4mr9681473e0c.6.1727714801226;
        Mon, 30 Sep 2024 09:46:41 -0700 (PDT)
Received: from localhost (pool-68-160-145-92.bstnma.fios.verizon.net. [68.160.145.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b69421csm40590306d6.142.2024.09.30.09.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:46:38 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: [6.12-rc2 PATCH 0/5] NFS LOCALIO: fix and various cleanups
Date: Mon, 30 Sep 2024 12:46:32 -0400
Message-ID: <20240930164637.8300-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here is a LOCALIO fix and various cleanups I've accumulated.

The first patch should certainly go upstream for 6.12-rc2.

The other 4 patches are cleanups that are more subjective (relative to
them being sent for 6.12-rcX), I'd prefer they go upstream now but I
can carry them until 6.13 if that is how others would like to proceed.

Please note that there are 3 other patches that should be merged into
6.12-rcX:
filemap: Fix bounds checking in filemap_read()
filemap: filemap_read() should check that the offset is positive or zero
sunrpc: fix prog selection loop in svc_process_common

Hopefully Willy or Andrew will pick up the filemap fixes soon:
https://marc.info/?l=linux-nfs&m=172736276211019&w=2

Thanks,
Mike

Mike Snitzer (5):
  nfs_common: fix race in NFS calls to nfsd_file_put_local() and
    nfsd_serv_put()
  nfs/localio: remove redundant suid/sgid handling
  nfs/localio: eliminate unnecessary kref in nfs_local_fsync_ctx
  nfs/localio: remove extra indirect nfs_to call to check
    {read,write}_iter
  nfs/localio: eliminate need for nfs_local_fsync_work forward
    declaration

 fs/nfs/localio.c           | 96 ++++++++++++++++----------------------
 fs/nfs_common/nfslocalio.c |  5 +-
 fs/nfsd/filecache.c        |  2 +-
 fs/nfsd/localio.c          |  2 +-
 fs/nfsd/nfssvc.c           |  4 +-
 include/linux/nfslocalio.h | 15 ++++++
 6 files changed, 64 insertions(+), 60 deletions(-)

-- 
2.44.0


