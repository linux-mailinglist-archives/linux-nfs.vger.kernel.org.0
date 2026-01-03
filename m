Return-Path: <linux-nfs+bounces-17430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82878CF0726
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 00:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8181E300A2A0
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27F720322;
	Sat,  3 Jan 2026 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCKl/XuR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886042BEFFF
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 23:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767483696; cv=none; b=Z+YXU+X+kr10hM7Y4aXuZz+KNhvPSDC/wzWE8YmDtmVuLyIxo3SZxHSCFfIWnZzJ6MTdbvgjqXLEY/pS1F3N2VKpPckHBxA3ifDVemf4tTGIpZCulPFPqZX3qmA/3S0lIOcQJbqO2QdxU/5yr49f/jRnrGFvgfMBtRPKnbIAs8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767483696; c=relaxed/simple;
	bh=moKIz5Ld8xajCABvcxgdytzAPIubMf8OhdTukxr5IzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COYe0tditQM82QvZI1MCt8w1lAfeEnNBA5i4xkoRk82a77RSqKlm5ES3aF7H5oNTEruGonAiBjN1lj5RyLU18S1+DePOxZnU2kt5DE5zroCjoU2zc+kuJtGKJ8zMCticYE0pOVNnhiS8JIL2q7hzrETRyKw4MAoLx6vVPIbwi2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCKl/XuR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7fc0c1d45a4so11509272b3a.0
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 15:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767483695; x=1768088495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUK1qxG3XNdlIN5wGsmxZ9ze2xZ7wFRokLFaNRKof7A=;
        b=aCKl/XuRrTB/W45JU/Cdbs7yFjbPe4x5aggzoIqnlXaChbfyjhhnQkN4tC+RkR6soP
         Ql16w9rHZD79l788B6giaYHGiE7WTr/3kd+lOwmaRzA4UPuYgmsYqmzRedPC3scVQGgp
         fJfXZvU9IXF8IqT9a7ClILNbfd+S4rE0t/0DjJhHiSaAHrBcybHoE9dTOqp6L6qUBhMV
         kNiAAtf1zdwa2uiEmWXzZ9ckwfpaYdzOGtin9+y7WOcrvAfrM5VMdSAl6YkSS4FEcwzI
         Gww5RCw/ElDT+NsVvW167tUQRW0UJaVDPIrQsi85QFMh+hewkhht9QVFs16OnhuFUE47
         pEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767483695; x=1768088495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUK1qxG3XNdlIN5wGsmxZ9ze2xZ7wFRokLFaNRKof7A=;
        b=siKV8rHKATZ8K3NCw0m2s/gmBUuEwYmY6dxHCG8vZpOQffagYRtqk/SJU+GbWDxJij
         7i8/saN2HWzFpwS0AUKVNyN8RWUb31NzK3vu4kIXu2BTulGpojYwInpFwBhyp4f7i5id
         yAUItlx56wHp/xiQWH5hLcTEXaZCP18zIsDxfv2DvVm6iVHYFSOFHxUFIyFxAdmQL+uf
         kunPQ4PdP145AFH2PxRzld3gWb60o+z8/svqO+b/hOvJcL7jawF2Y9lothuAnWpIBUPW
         Wu0mdGT9tuMuqcqKC2SFnD+6YDba19ZVWTvpyaGCE0lbYaUzCWRj55PqvnnQBhYYznI4
         ktiw==
X-Gm-Message-State: AOJu0Yy5KQ91E//kS90ntreufOk/1mYRM429ix4Mq0mV13d0HoLoG1To
	2kZ0Sd2FOtxMBf3jbr/ccK1znJnlbMYgt3JmoTsFMLMy9cLTceG4pGKSToXxrtc=
X-Gm-Gg: AY/fxX4DBEN3/yRff2PThKm7SAYFtBZ3CIr3d7+qj/Vvgq8JTqwLuWCoj0BpzDg2AOV
	PD7SCrU1DMsu3VyXSS39xBPdbn5bD1E1jeUWGkCRhpBqeKGDgSzwYmqkYJXTlMw8DAbqx877iX2
	BgpItkeFs4kRGxHoyU28sV6iRcMjX46Get+nWvnVeyu65YmGpzk3bK9dbSwD9gebC/owC1C/Q7K
	QntFdogig8quqy4Ps08v6tFQuW6JLrcT/2aZwTyQl0TYsGjEchaK0BOM+lof7VOph3D+lXI1rZ0
	2fjuoR9jwbxUsOp1D9BE3eDmRTG+Ihvj5hA0AOZH6sz8WRgQCJPdwJdZMH1f+svX3i2mll/vc/+
	u+LgcyVsfd0FxoxDnpieWJfrYUTko4JKi0UPZqoN4RlqVfmtuiX/VHflA59XU5VdLS3VcolzUn0
	fW0qfy1vrbxdi7i4azdqErXY3T4ErMrUPGuxt3eTLWerIsdN3F3PWQ03/k
X-Google-Smtp-Source: AGHT+IHe8RyJFsuzBLhmTY9J3ySNQg+ylartNjl5FBzLn/GuhNRG6zb1wg4Z71hRUcKmQZsuw81Cug==
X-Received: by 2002:a05:6a20:e210:b0:35d:8881:e6a4 with SMTP id adf61e73a8af0-376a85d3e59mr44853415637.25.1767483694537;
        Sat, 03 Jan 2026 15:41:34 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm38472577a12.28.2026.01.03.15.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:41:33 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 7/8] Set SB_POSIXACL if the server supports the extension
Date: Sat,  3 Jan 2026 15:40:31 -0800
Message-ID: <20260103234033.1256-8-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260103234033.1256-1-rick.macklem@gmail.com>
References: <20260103234033.1256-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Check to see if both the POSIX draft default ACL and
POSIX draft access ACL are supported by the server.
If so, set SB_POSIXACL.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 57d372db03b9..aa0f53c3d01d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1352,6 +1352,11 @@ int nfs_get_tree_common(struct fs_context *fc)
 		goto error_splat_super;
 	}
 
+	/* Set SB_POSIXACL if the server supports the NFSv4.2 extension. */
+	if ((server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) &&
+	    (server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL))
+		s->s_flags |= SB_POSIXACL;
+
 	s->s_flags |= SB_ACTIVE;
 	error = 0;
 
-- 
2.49.0


