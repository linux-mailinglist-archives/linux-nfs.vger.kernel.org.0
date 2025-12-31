Return-Path: <linux-nfs+bounces-17378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3A2CEB0B5
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2025D30094C2
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E922D7D27;
	Wed, 31 Dec 2025 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG+sDFAf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74E23C4F3
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147750; cv=none; b=Kn5mZlJjGNf4iEYcD52ZUwup4c2QX4ruPYAR4Buv27pNZNY5yh+BuFFsIxzQCULE2mV1h/GtKx1yk+mRqJ/DtkooPRIfO0d0HjHlwXjN+YbU1yNvh9tt8z9GC2WPdiO99SxEuGXXAa5e6lPvtNugn6fioJyb5KfRwQNUVhzoOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147750; c=relaxed/simple;
	bh=hFvW+GmtK4d1w2vlgVE7uobzZtVHug5nN8ia2HnXWHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELLN7j6GbBFdh7hXopYw8ehS7BjsC8UIJ4XAlGZ7ZfKaQK5pm7FRZwFmhEbLZy6HtPaRzwSbYIEC1UQYpcVv7Wxx768b1EUDfjTyASfNRFuIDU7Oev5L/nSfnGJba41kteOs0VZgHY49Q/5OJfaW7yhGDHDYNQ7QhZJxSdJUFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG+sDFAf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7f216280242so3201309b3a.1
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147748; x=1767752548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxNsV6Y2kDYR/rU9QuLklWwQeSTNoyNdTD0AYqr/pNk=;
        b=fG+sDFAfLUhQ1/mwQbfYMNgij1LwAF9BPeT6WeXE1t87jN/T6clKfzRXoMpFNSmTZN
         jwWtryq+Jo+Clgoq0SKa2/oXswH9qMMHISKRo/i3VBrToRPUaPeKjVTdu/kaU+LRg0bR
         CHoXCSwzktCHLtd8+zs8hg38kkdh6EEqZjPjLa4ku5BnAJBAA1VajVLl90S2klFdzIcr
         2FOOEd8XG3w+uywCUEaVL8GiqHHng078VKAUee1cvgsnnYS+1c5O0XX8m6W0Q2S/fB2p
         2mXZjUXSJyPPVIZkpGhRJhyaVhNzzoWTfG8gqTg9VZyGodfR3HzuYX+NmsmiLGHVjhjh
         N8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147748; x=1767752548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JxNsV6Y2kDYR/rU9QuLklWwQeSTNoyNdTD0AYqr/pNk=;
        b=dNz/KOEl3bMnOQtBq21byAM5KQ/3MkLwqxr5DCrGzt7MAn0uTz64SnkOrsEjleTW6A
         jOLG/tQ/GpsQgguOgy3Zd61y0LfHUZpTrX366wNokz25yKdYoHnYDk8ay7EdnqlyxgKj
         xBCJJ99nKVwW/namolHBSh0VsSZBe5UowMX1e9e+zMftdBmU6yXXR2wOMaZopk1qYGze
         vdFSHrRnaW7vGkFjDn8XBNM08A9ccO47MqNfyT1yCV47vbw/Dr5Y6IAzTopjfC5nwbLq
         UYP5tLiFm7lULg2M/LDB4G93KcjEUKVmzzchCT6wbaGn+Xk5VUlPun0tas7FSXDpvAuW
         EIyQ==
X-Gm-Message-State: AOJu0YxkPRU1GUH4/DUfIyWV16S47p+S+Btv73BG7gvb5dNIl6uawpLe
	SrCX6zII5yXBCqqrKC3qYcRwxK7GbMg9wJOcAUnqaoEAU/BN7+s9bcGeBzTp24Y=
X-Gm-Gg: AY/fxX6kNg7lCs48R95AXhsKegLCTWd9121FHL0EJaCPR1cKP2ILya3v3oyOHyOl0b6
	dcG2EBGbghOIWBHijd2xs6AsEvuGyoUqXfHPMHGeFemFyQWxRefrdYGIIaOyZLxhTnfNARqMinH
	vhevlOXfkiKCSg6nvRi/w/GkCW4z5+LrouxtExXevymcRpJeDOCjYqTFktkEeNNTU10ZW6MRaD7
	VzU8GVBNgGRuSO+7UKve7zJRdYurviRC4a6BQepZNCnFnE81+SaBsOdgiwX9gBBDxB5wO/HDv/f
	kV6I/d+3wAKkinU7QgCzcOB/Cto+zhshr3w42SsZGQ1/c9VwHfC3OdHcc3rUIVCArK0bUkLIkeL
	R1u9PCvihhyZqzj+yQAgTWbItfkx+B5JdvLZiRxmIiy25m2StCg8VIw+E+plTpMZO19Ndy68yy+
	QpZNgtAOCGAXl94TxBSeQCGK8RB+JEOXcqtewYLceZ20/j2WxifQ19CPsD
X-Google-Smtp-Source: AGHT+IHvgEkvEok2WmZoWewIHz5LL8IidZ25VO/DB7Zf4KsbsB4l8/duXJYFp8uSMMfEfGRntm/hmA==
X-Received: by 2002:a05:6a00:a90e:b0:7e8:3fcb:bc4a with SMTP id d2e1a72fcca58-7ff551da6b4mr28157200b3a.31.1767147747924;
        Tue, 30 Dec 2025 18:22:27 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:27 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 11/17] Make sort_pacl_range() global
Date: Tue, 30 Dec 2025 18:21:13 -0800
Message-ID: <20251231022119.1714-12-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251231022119.1714-1-rick.macklem@gmail.com>
References: <20251231022119.1714-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

nfsd4_decode_posix_acl() needs to call sort_pacl_range() to sort
the ACEs in a decoded POSIX draft ACL attribute.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/acl.h     | 1 +
 fs/nfsd/nfs4acl.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
index 213774cebeeb..7e061fee2eea 100644
--- a/fs/nfsd/acl.h
+++ b/fs/nfsd/acl.h
@@ -51,5 +51,6 @@ int nfsd4_get_posix_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 		struct posix_acl **pacl_ret, struct posix_acl **dpacl_ret);
 __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
 			 struct nfsd_attrs *attr);
+void sort_pacl_range(struct posix_acl *pacl, int start, int end);
 
 #endif /* LINUX_NFS4_ACL_H */
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 0a184b345f8c..84bef41848ca 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -402,7 +402,7 @@ pace_gt(struct posix_acl_entry *pace1, struct posix_acl_entry *pace2)
 	return false;
 }
 
-static void
+void
 sort_pacl_range(struct posix_acl *pacl, int start, int end) {
 	int sorted = 0, i;
 
-- 
2.49.0


