Return-Path: <linux-nfs+bounces-17382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92538CEB0BB
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CB813009B3A
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E69E23C4F3;
	Wed, 31 Dec 2025 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeaHuQ7o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC042D7DCE
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147758; cv=none; b=UyW2ciEKUc//M5MkrxTlSZtulOI4r9pwkGFqOuL0mu8/7s1ZrD+dRJGYRH2QdnwNcxHQtqvLKIrnKfwPf7e49UNhcnh/xPLQNV5bHBqvdzB9w0T/csUOm7AXWiyqw+IHC4sV5rnGEHt+v62+ZE/FiOwJHS20ji/pcW3Z7lnE8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147758; c=relaxed/simple;
	bh=1F6bpuDUQP1SF/+KdlsTkbo/YlJ7HroSGUX1WtZWoG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIUeMPmyq/D7b5Ulhz3GOXaHpnwfb3x4giaEYNWUMUzxxITOW6YgPwWKXadL0yseePOLk2MIZWtxifSLOXPMXPwK8S4RJSsrawAi6iW3U/gMq1ljn8xVkOaNSxHfd/ClwzW++zo+Jk7Ea5E9B4zf3/Rr1Kc64iBR7UH0XX13f+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeaHuQ7o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so11871529b3a.1
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147756; x=1767752556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/iZJcN5PZUntInp9NbZG2rn3lJG7T4RPYYPP91W9O8=;
        b=HeaHuQ7onTj5Yi9h5ljwS5MWcZPemdjgXrSKpniUhxfqWFTi64KVSmbPa6Cs1Ru4q1
         39q9ZefRoZV35TBgs6bi99t8JMsx6TO0S+5IkrzbHqqgDOB4G7KbIvkvGXnlEDYYoEuj
         D6GYu5h/Lt8npDCw0iExO5xKbmUs/wQu71zOeH6w0to18YQwuCgwZMMMJwbciSaxgjIr
         GJSYdc2jRDnKxSrKN2YU1ruQlGcKnnxxSJ7eBycz59wXRRlOsDLqzJ81Cw2se4W+tIoR
         6ndBEq3HVL0nmIvbfBx+1MiCpE2ikJi2zwT5fO1wmQMeN48E239R+tVPpw6mbXBhEwpO
         4msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147756; x=1767752556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/iZJcN5PZUntInp9NbZG2rn3lJG7T4RPYYPP91W9O8=;
        b=L46WS3QyH5jOqNDNgu0zkZvC3MlarsbhAv6qBaNkMF5MGrSXn3GOr1zLX4fvILJ7XA
         ub01wiApppAjLIrRcj8mIjIbXAQ6yg7eEUHwCCuR6bz/nTsPFtP4hcRmsSuAF5MTGPBs
         VjZcOdDXjw7kHwvptHCVHyoCxEIhMTSOB/FWy9gZQ2fgMtJkTBybXHSf7/Xzk4qAnwiG
         lmVu0vKlq9Sjs13/DCE0HxvbzoJcjILbc25hNBgTVZ2xEo8bPlfFBy66bQHG7/KxXou+
         ELfUySiWn95dFVR+xe71oueNmEFeQEaxfdc5Th5vG9JTwGP8bWT5OYyMM/WOBB8Xs83B
         7atA==
X-Gm-Message-State: AOJu0Yw9iPDa0Rc/Npguyuv0aDxlSbHCDCyX/2gh8o8WraXfHALZsPGU
	p425R5WF3yeNrLzWrUxESE3XDzCOz/coBFHTDS80lXafQDwmDRcK+oJgSIwEFPI=
X-Gm-Gg: AY/fxX7m5xanCajDqIV7IVxxp3uo8z4dxbHuQuX84GCojqi+U0CFXcjNzz1UoYsZULs
	PNoP8lDXK42WK83zWt5owm6edCKY8sekZw441rXm/PgtSl9GaBZQY+lFJI64iNdrzU3Riy/zgTf
	Nf2ChcbTu9JNctPFMeVUHu00aHHJxxEEP+woVqq4nIhhxGUnbaIDhsE3jPSEky8HXhQVbgFwMRn
	XCyZPOx2BPGpbO/A89oCV/Ns7b6kq1ItqY59sC29LUJnvddDqZVaZQVvuWaxTgBXf9096eOdute
	QqdnJ+0A93XAa+bMSS43LYsEnTNZfnpTYTPAcjcOj9NxFFs1p3NaJegsrIowSj5+lTCsiPHfLfx
	3+sRr3J6WJ1nz5u4K1mLC4pzCV/VdpkTsOyapnEtseiXZhu4cswRrg2MZMiXVq++YZjVHASjwHZ
	4/wGEZF5AIiAdmcvUA6HpqA7SsDYsfzHp8fzSMWxbTCMmAPT+0kziIN2Jb
X-Google-Smtp-Source: AGHT+IGl1z7FINAzkmyRMdl2wQnPSKHmYXkBhUWdS85lX1fbCoEd4YQkua7m/OVpbVa/uxLokaRq5g==
X-Received: by 2002:a05:6a00:4484:b0:7e8:450c:61cc with SMTP id d2e1a72fcca58-7ff66c6b01emr29124396b3a.60.1767147756313;
        Tue, 30 Dec 2025 18:22:36 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:35 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 15/17] Do not allow (N)VERIFY to check POSIX ACL attributes
Date: Tue, 30 Dec 2025 18:21:17 -0800
Message-ID: <20251231022119.1714-16-rick.macklem@gmail.com>
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

Comparison of POSIX draft ACLs via (N)VERIFY is not
permitted by the IETF working group draft.
It is also not practical for the (N)VERIFY code in the
knfsd, since ordering of ACEs is not required.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 1dab7d3aa11e..ae5c1f5b714d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2373,6 +2373,11 @@ _nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (verify->ve_attrlen & 3)
 		return nfserr_inval;
 
+	/* The POSIX draft ACLs cannot be tested via (N)VERIFY. */
+	if (verify->ve_bmval[2] & (FATTR4_WORD2_POSIX_DEFAULT_ACL |
+					FATTR4_WORD2_POSIX_ACCESS_ACL))
+		return nfserr_inval;
+
 	/* count in words:
 	 *   bitmap_len(1) + bitmap(2) + attr_len(1) = 4
 	 */
-- 
2.49.0


