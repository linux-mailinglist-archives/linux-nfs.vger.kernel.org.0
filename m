Return-Path: <linux-nfs+bounces-16860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60350C9D790
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 02:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 523D34E207E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB70922D7B5;
	Wed,  3 Dec 2025 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egy5BGhR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDDF221DB3
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724171; cv=none; b=FD9dxCwiKzPUu7UbG7xW8ZeOe0rfcluDolO1jt+pqmi2lmaSUrfuJZeXM7NSCx2Uxd/5z8FmkoNsEB2b9sWVPeJa5yCrp+3WJiqOBNPuZzYlQ21E5olUg3nDUYrgRPr1d9rY618FvdFSbDutJmxw9WOkM168nm4dQKYPAdt31bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724171; c=relaxed/simple;
	bh=Z0aBSNRh8FsZikWs+4hiqB4YrcaG4UI4KRU2o9/GRvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KewksMugdQVB0WIwf3eQ/GqpWf+Z7WwVSQTTykkDMWiX5GVI6/sprU2Yq8CBixA9QbBD8ntJK2fEmBcKrcpRVc0lxofPzL7dGtcqad1Z9Va4pOv0QLpcd6meFLeKfpbKduFohlEL1gXYYf6qpQ5LAcEl7BpTnuGhZvtqbZw8xOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egy5BGhR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2953ad5517dso60724565ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Dec 2025 17:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764724169; x=1765328969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiYHA42xwedYipACSgzqjaQJIVD/rAg52mdw9jn4jBA=;
        b=egy5BGhRX9+P1weZgOTkBGIefvozlOVoH0qVBRbFX4KvcfLNqS4cD94yZ8jvj8FJgr
         KvPxO6ElS9w7FveUFrVzFb1707XG72BwB0xkCvhql9Y6zSh3Lh4tTndO8nTXEPrQ2JUk
         N5dMPRntqx31jDkwDqAsgPw8dpla/S7R8F7q+RJJUxgABVv9EemzAzRZry7vqs+PiDGt
         2jieLX966SXcuk81zM6dwzXfpBz2LqH+FO0k+/rzCHlzyQeckmkARwhw/1xfDWyjmVEb
         qtT6/ZawFDLOfC0TKW4klS0DWMWNmGlCnzu/xzTmyqtNmGHktnksHevRZs7AUqWmXUr9
         Fh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724169; x=1765328969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LiYHA42xwedYipACSgzqjaQJIVD/rAg52mdw9jn4jBA=;
        b=ee36DXtv7nUyzZvpr7d2rsx3+MrKnuXfDsltyJZ99khN6P0GfNz86JeeLYHC//DV0F
         DYD/QyHBNWoRPOAXDoOyrENpekWLtpriGeD0FCK/yGag+Obo5L851mviYmYN3ZzKbTqF
         o4VlhWOjZ67SXPYFhOPRPlIXR+QrYIzG90sXyAmwl2UAGP2/EbuED1O1j7CPAZloGZz6
         AJMYBaIw1PZXG6G69VtDdX+esNB5AUtmSg9tpHAt+zdmW4jSogFzZs15m5uHa6+vSV13
         waIy72HRJmC+8HNT+ytYGH685VbwHTB6ZOCIOIzT/oaftuZ5oWi5IwUnE9HDqOGrFV7Z
         2aDA==
X-Forwarded-Encrypted: i=1; AJvYcCU1v6+7ejTpiB0boRyliJrNZ+HjdkLoeci6sWU8nWZ/CIH0l9jo682ujZrtBNps2aBsPJXMTTPvClM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2O5w0IuNO0lKIyAOL9tIU7f9Yam60PSe3iUkDwzPcKcIYQXB
	NnLTFYZFjLHijVauLkQGe84Lh7go7y0NPzbjtXfscREV4TamYE+ED7LE
X-Gm-Gg: ASbGnctW0YacEpmZDrj8M2/dn+Wu9vJ2oa8t9FM6JpmciJmgp5cP51ra2GnIsyMnBNx
	nahLSOZUVYmVx0qeAkp7xRVo2KZRTUZasrleqlP4XFEesLWuclk+QxpcThD+5NmRJqRbYVtnrKk
	9VE65vRacPbgrAbWwhQprBwLwNLfoJJo0SgqjunFFNp5qb0l71ji2+/aik/2yp0E/f+150PtUpJ
	pKvlaHq+1fPpVviKq2lF/cvhWA6iYWN9oLil61ZmNH1TvKRDwX98br3xkpxE63m5OgYVUwPo1Tj
	gHb1ik5G4kDZJtCu+8bkfawyrtnzxx99wYW4SZ1wmX9ze4p3pn4mkqsiiA9aSvSQkiqEZO6lF0O
	MBe/G4uH3sErl7/p35jJMQUpMFfqyv9WM3y6clzAlj2M/qbrVSz61xRmS+1CinqUFL157sqr3LM
	7CEZVMAVh5tW4=
X-Google-Smtp-Source: AGHT+IELg+xWGYFXtVQWxsJbv6FTQvo29AtJj2U/WL+8krJllbbwnZhNGVJMTTx+ZN0Ro/B0i5hSKw==
X-Received: by 2002:a17:903:f8e:b0:295:7454:34fd with SMTP id d9443c01a7336-29d6841a76dmr6420915ad.39.1764724169469;
        Tue, 02 Dec 2025 17:09:29 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce2e676esm164710355ad.0.2025.12.02.17.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 17:09:26 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6A01A4353260; Wed, 03 Dec 2025 08:09:21 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux NFS <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Snitzer <snitzer@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/3] NFSD: Add toctree entry for NFSD IO modes docs
Date: Wed,  3 Dec 2025 08:09:09 +0700
Message-ID: <20251203010911.14234-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203010911.14234-1-bagasdotme@gmail.com>
References: <20251203010911.14234-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=bagasdotme@gmail.com; h=from:subject; bh=Z0aBSNRh8FsZikWs+4hiqB4YrcaG4UI4KRU2o9/GRvY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn6Pe9qLz0+XfRBXT3h6v6lLn/2H114vzvmeobwdIPvI mX7WS7O7ihlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEjk5lZJjVyv1EIqNz9dsL 12dNE5IScX2rO/mTlNlfn4yLxxhfyfxj+J+q7N3K2biJRzI868ryTvXL4XMf5T8Vy3idm1l0W8K oiQ0A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit fa8d4e6784d1b6 ("NFSD: add
Documentation/filesystems/nfs/nfsd-io-modes.rst") adds documentation for
NFSD I/O modes, but it forgets to add toctree entry for it. Hence,
Sphinx reports:

Documentation/filesystems/nfs/nfsd-io-modes.rst: WARNING: document isn't included in any toctree [toc.not_included]

Add the entry.

Fixes: fa8d4e6784d1b6 ("NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251202152506.7a2d2d41@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/nfs/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/filesystems/nfs/index.rst
index 95c2c009874cef..a29a212b5b4df4 100644
--- a/Documentation/filesystems/nfs/index.rst
+++ b/Documentation/filesystems/nfs/index.rst
@@ -13,5 +13,6 @@ NFS
    rpc-cache
    rpc-server-gss
    nfs41-server
+   nfsd-io-modes
    knfsd-stats
    reexport
-- 
An old man doll... just what I always wanted! - Clara


