Return-Path: <linux-nfs+bounces-16497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7BFC6B7F1
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 20:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 550734E4941
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C042DC79F;
	Tue, 18 Nov 2025 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDty9WFq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F9280A20
	for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495630; cv=none; b=f03MINj6uDBy2qY2OHWT3nH93aH62St2XacoxbL56pMgDuJxh9GCCfqHuCuzF/jSFgIkzmg8/Tbc/WX1T1dBxo2F4HSxn4mn2BahNaO3PP6EggvnVigAGcP7T1CcqVt/TjkjmtEtuiRV+cOnjoMAduUczGTFV+JYCQE2tyt6pK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495630; c=relaxed/simple;
	bh=3kk21AVR0BUcua2zkddv676b0sKfxa6DENI/ptrFn4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tv8vEeDU3X2EqWVr5Z66OwzRBatc6sehUPwN0LxjGgWB2xfXbFzSMnrJ9/mLsd5CZbVV9pkF0JsXDf8PHVNGWpwvETW3WKPoDtNR5ctrf+07E6gX6ycp54LIcNlTnMUZ5feUaBCI1qv/kcuar+2E7xpVIZpPVBbqJwzVU/SsWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDty9WFq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29586626fbeso62854525ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763495628; x=1764100428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5SpKL5XOhSd8b79ER6CmdySWzSN2pcIo7OGXrr04v0U=;
        b=QDty9WFqmuaXBEv5vCBVmOOmmEZ6bbqbT4EymEHkKZdPvLYqQ9qVFoL1R0n/10Iq+1
         EZyK/WAhaVUYJwhcsrOBuPHPjDNg2eQDavrnngPKtaNsdc99xzmmo3lfW5PN0OFZzl1Y
         XmrgBjFivuTHeeggCITF7i2vZ7PL5XR8FTOcjXsuFUx7YSiEwwpTItTAx8su4RBJMZW7
         Fo4W+L/iroiUZwh1RJsagm9PtlQGUQuFhT6QGmH+bYRizcvNMlPMmS6Y4xseWivkM/zI
         aLkMSRHFX0iGqmG2Dsk6faNBWDHVgiXdyPmIULPhPAR9er9JJMDM7jDbW2y+QRISN7FJ
         A4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763495628; x=1764100428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SpKL5XOhSd8b79ER6CmdySWzSN2pcIo7OGXrr04v0U=;
        b=Tl5YgQgf7NczhT9AZFRaDewe4uGcluS/pDGU75KAmDaN1qmdaiHvXZuX7NoI0aQWMY
         7PrB7laA8yXHrVreGa2jSo0IrWr15aomS7XT6YcVvQZg4a31E+zVdLHuZ/ia7n6nsXbK
         DwOOW1ZvMD4eLVu+D7N/syqxKvDQOfB+Komf11lICgDDyPifNQE4MA22msxScMYo+rnd
         o+jwxjM/RwZ6Lb8VRs0eRVVLM0bQ91gI4JENuFmDCzboDqWgWUKQUS3O2JT30hKLdP3y
         RrseheyAgkltrBFfHTsMvwNVfG2W5Au21ii6PVZ2rxwfEDrXJ3DPSTvWxEiyanBXt3ca
         V8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwHOFz9oa6ct8pnAHut7AAyPfGNB4+mUBa+wC8O1PcGwCtIvG0MsqX7E4zg87MnmG++eM2b2CKeJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/DroSLL1qJL1JmTwiKHbSkiU2AB10IYPzKPsj3JFIhJvyg0a
	LibRAkYakb1UQHX6yX+IFiSxkKD2RgQmY8FCfMIJc+X615RsbL1kauowPUOZDR4i3O0=
X-Gm-Gg: ASbGncsIs8x4zJAWemlJK2dljeCF3Phg9lz7lmh+uq28iAnOAlNFE0MCeiKCS2HxJI5
	n2KaOZHO5wBfREsGjEVlMldese7rf5RcMSyCyijs+oqssl8uBst/xNN8PgAlcInT6Gikg2OyUnc
	AfAuyZtcuFSPMq/DuNd6lTUV6fOC5kRGJvK5t4TsFLrCiNnTPJW0DGds5IkUJKs8k0nDtHdDNKa
	pAaRae+2/f9mF0d6WK+EVYWfY7ArV0KTn6dIqxF2s7OkYSH4XfIfMAH+DnCkg9LEkcKDxdd7xKS
	hWaKqMt2Ko4Gwo6LFE2INE4PWeJYs2Dy+ltram6Vi/1nyiLW/MgNq+XcAKlqFv9JIjwxrIuHZE7
	Sq3pPqI5XUOA1hbNDMNYQEFk0UK/XHYmr9pWvLxsvH36kMEplIb7FvnG2ZIKFuXLwvHOFntWI8u
	6Mju3UiTH7Mg==
X-Google-Smtp-Source: AGHT+IG73H9fMzBHLW9z64tVvn4pTF1swZZsbvhjuhF9VgeDf0MxRI4T4My4bdGDW+hWCxUACqwVuw==
X-Received: by 2002:a17:902:ebd2:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-2986a750101mr220915645ad.40.1763495628422;
        Tue, 18 Nov 2025 11:53:48 -0800 (PST)
Received: from snowman ([2401:4900:647d:8da9:4ba8:dd95:deb3:d9e4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm183220085ad.18.2025.11.18.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 11:53:47 -0800 (PST)
From: Khushal Chitturi <kc9282016@gmail.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <kc9282016@gmail.com>
Subject: [PATCH] xdrgen: improve error reporting for invalid void declarations
Date: Wed, 19 Nov 2025 01:22:58 +0530
Message-ID: <20251118195258.6497-1-kc9282016@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC 4506 defines void as a zero-length type that may appear only as
union arms or as program argument/result types. It cannot be declared
with an identifier, so constructs like "typedef void temp;" are not
valid XDR.

Previously, xdrgen raised a NotImplementedError when it encountered a
void declaration in a typedef. Which was misleading, as the problem is an
invalid RPC specification rather than missing functionality in xdrgen.

This patch replaces the NotImplementedError for _XdrVoid in typedef
handling with a clearer ValueError that specifies incorrect use of void
in the XDR input, making it clear that the issue lies in the RPC
specification being parsed.

Signed-off-by: Khushal Chitturi <kc9282016@gmail.com>
---
 tools/net/sunrpc/xdrgen/generators/typedef.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/generators/typedef.py b/tools/net/sunrpc/xdrgen/generators/typedef.py
index fab72e9d6915..75e3a40e14e1 100644
--- a/tools/net/sunrpc/xdrgen/generators/typedef.py
+++ b/tools/net/sunrpc/xdrgen/generators/typedef.py
@@ -58,7 +58,7 @@ def emit_typedef_declaration(environment: Environment, node: _XdrDeclaration) ->
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        raise ValueError("invalid void usage in RPC Specification")
     else:
         raise NotImplementedError("typedef: type not recognized")
 
@@ -104,7 +104,7 @@ def emit_type_definition(environment: Environment, node: _XdrDeclaration) -> Non
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        raise ValueError("invalid void usage in RPC Specification")
     else:
         raise NotImplementedError("typedef: type not recognized")
 
@@ -165,7 +165,7 @@ def emit_typedef_decoder(environment: Environment, node: _XdrDeclaration) -> Non
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        raise ValueError("invalid void usage in RPC Specification")
     else:
         raise NotImplementedError("typedef: type not recognized")
 
@@ -225,7 +225,7 @@ def emit_typedef_encoder(environment: Environment, node: _XdrDeclaration) -> Non
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        raise ValueError("invalid void usage in RPC Specification")
     else:
         raise NotImplementedError("typedef: type not recognized")
 
-- 
2.51.2


