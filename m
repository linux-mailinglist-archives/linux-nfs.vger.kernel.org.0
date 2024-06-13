Return-Path: <linux-nfs+bounces-3725-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22D90630B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59916B21D55
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A62A1C5;
	Thu, 13 Jun 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrSk1sI+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06613211A
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252276; cv=none; b=dmUYeEVamDVJBkeE0Ms65DxYSaVz+3T5SzeslsJ4MH0cCUcTP6777gETlbAeM9x/E/LmdQgAV/Q1ZC+y7MTsgohDonjp5QyIwvSUT0GPqpksAEbaWRV5HnMneV/DtsSpsyOfLFiZ9/w55iTQ+W5JIvdHrsuLK/5xE31j18vBurk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252276; c=relaxed/simple;
	bh=1FfBd74Ye+zPIx8Ibbq6He/677g4YFyWYMS1PSilE9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iboDSons8VbJnifTQJ5Pq7LlQQHgzx43d1trMlqG5zqu6ESmZdrJXIsRPXLOJpybycjR0ZF67BOfQFiayO1KkDN14QPqeDWosjy+eXktn6O5dmU/PjTgVIunNihNrXhHdSQDRkiTtXs7C37zotA5B0o1GpcOAuX2VxswO9crWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrSk1sI+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b064c4857dso2838636d6.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252273; x=1718857073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+tXPgV4kU1JZhivf9nh6YCdWg3Uo67z8Sq5MNbxaaA=;
        b=KrSk1sI+rnLqNny5+dH6QFvqeEL5WZHnoA+whGivKrrr5a3T5QeluoTs4w3U8lpNPV
         FM2S2kznl+1YveqvJlceVGSKtrAJowDVZqKpMVUzIr3uGN1UJc45jJSbCc/BJISIOJoT
         ia4v1wOhDh+npBxroLs1xDnkTUKl7HhEEH8YZL7h2eE0ubUM0oD1NE1i2zbNeCbxugwD
         jEuVJqvwZ1zmYNf4UBzelKWSN5QrFZnefEC6CdPjJZ7oMyXIVYxaAglx6dpqbOkJE9vC
         j1qfsso1Pv5ZROa5VI+O/dvQZ3EJWr1DGtuN5dQTaxdw6wmEQeFCUVqrrTNgNWGFH7+I
         vqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252273; x=1718857073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+tXPgV4kU1JZhivf9nh6YCdWg3Uo67z8Sq5MNbxaaA=;
        b=wuO+iWYbftfVzK6M0z1pvLo32kmXX5FW9PBJimxBsrHyvwm6JssmMtFN85qkEbohoR
         BxzlWKMZrZ3T2KPpYT7FJmLO6/+StXk+ll24Iw1y/HGnMYdDZpiQGPYwLQLtkli3PSOP
         /0MU02zmhJZ3w5MMRMN9ZTTU72cvnAVS0ogvWIBAvcjPH4h+Q1hN77UseYGPVKX3TGlw
         7XN2HEm/eYAI7QvoD/TxtuhUoGH4vCo46+wQo9HbD0KZ3J+Xc2SJd4SyoQBvzFySfSrx
         EadyLk6pTSmTvOyfyL6+IXIuDl6vOEXsciqs1J1RxANdJOQhp9LjRw3/rMPhgQv5tysd
         Ro/w==
X-Gm-Message-State: AOJu0YzrQ168wXZWhCay79CBkl+0lUK9lYdtL6K462xY4V8m/pspkJuN
	lsguHX+CityOdfjosJgfuY6kgIdFcfGsJAyOxf4LxhZzDgoIqfWae988
X-Google-Smtp-Source: AGHT+IHHUsBM8087uQ9pzw3xYvVfiemE5c232dCEzEn0txwlhQKtJW0SCZ17FuJbk5APNX7qIYyPtg==
X-Received: by 2002:a05:6214:5247:b0:6b0:4201:3840 with SMTP id 6a1803df08f44-6b1a696a190mr53462266d6.40.1718252273477;
        Wed, 12 Jun 2024 21:17:53 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:52 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 16/19] NFSv4: Add support for OPEN4_RESULT_NO_OPEN_STATEID
Date: Thu, 13 Jun 2024 00:11:33 -0400
Message-ID: <20240613041136.506908-17-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-16-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
 <20240613041136.506908-12-trond.myklebust@hammerspace.com>
 <20240613041136.506908-13-trond.myklebust@hammerspace.com>
 <20240613041136.506908-14-trond.myklebust@hammerspace.com>
 <20240613041136.506908-15-trond.myklebust@hammerspace.com>
 <20240613041136.506908-16-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

If the server returns a delegation stateid only, then don't try to set
an open stateid.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 87a197864277..23947fca78fe 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2035,8 +2035,11 @@ _nfs4_opendata_reclaim_to_nfs4_state(struct nfs4_opendata *data)
 				data->o_arg.claim,
 				&data->o_res.delegation);
 
-	if (!update_open_stateid(state, &data->o_res.stateid,
-				NULL, data->o_arg.fmode))
+	if (!(data->o_res.rflags & NFS4_OPEN_RESULT_NO_OPEN_STATEID)) {
+		if (!update_open_stateid(state, &data->o_res.stateid,
+					 NULL, data->o_arg.fmode))
+			return ERR_PTR(-EAGAIN);
+	} else if (!update_open_stateid(state, NULL, NULL, data->o_arg.fmode))
 		return ERR_PTR(-EAGAIN);
 	refcount_inc(&state->count);
 
@@ -2105,8 +2108,13 @@ _nfs4_opendata_to_nfs4_state(struct nfs4_opendata *data)
 				data->o_arg.claim,
 				&data->o_res.delegation);
 
-	if (!update_open_stateid(state, &data->o_res.stateid,
-				NULL, data->o_arg.fmode)) {
+	if (!(data->o_res.rflags & NFS4_OPEN_RESULT_NO_OPEN_STATEID)) {
+		if (!update_open_stateid(state, &data->o_res.stateid,
+					 NULL, data->o_arg.fmode)) {
+			nfs4_put_open_state(state);
+			state = ERR_PTR(-EAGAIN);
+		}
+	} else if (!update_open_stateid(state, NULL, NULL, data->o_arg.fmode)) {
 		nfs4_put_open_state(state);
 		state = ERR_PTR(-EAGAIN);
 	}
-- 
2.45.2


