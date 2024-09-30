Return-Path: <linux-nfs+bounces-6706-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A0E9898AF
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45320B22778
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 00:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012BCA62;
	Mon, 30 Sep 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvNissX1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C707C2E9
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657436; cv=none; b=fqV+FU0btac9fsMsK0Mlwd/9v0K4DgWQpgL/AphJ91MPHplU1/FrPqYQJ0Vb+4SbQBFH+0pnKmSadpn5G9hYjLdhC0bmPVKIZ+LvVSkMMPX3hHTGtM0Zdxb6/PCD2Dm9XoMoa94ESG2dA+7hkbgAdNfJierKPON4PGBYXJsDYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657436; c=relaxed/simple;
	bh=dYxzd3/OQUWiOeTW8JHR0r93nRSuH5EV/PfR+YS2U50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfDWvOTkDKL6zHP4aRpWKw/l64M6cdf2e5LOnZ5u8fxQGKURH2Yq0eQop15A88tRWYAo8Dc/isBbhFFiJk+Zpu4iNaIQXhvztuIADdgYma29WUpYrULhWBTNxSRptr/aurDmS3dqRZfxWSUgdKq8z6seLuKwA9tk1aIWluE1daA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvNissX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652C8C4CEC6;
	Mon, 30 Sep 2024 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727657436;
	bh=dYxzd3/OQUWiOeTW8JHR0r93nRSuH5EV/PfR+YS2U50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvNissX1DnLgiHarnR6Kdg4TVkVcXNqIDjV4JA1ms/swCG4hcrdouz9Mc0p6OX8N/
	 hi+jJjAkjm/kvS18qz+bwjN3zYKXTyWOShY7D5vvorhbXMFecbDafG6+u2ELunv9og
	 QNjSTo1Von4xFxoEmDYlRytcGEyvLj86v/6jXtkdOOuiK2otSMSXA2ysPIpNM01X49
	 bMdiVop++9JG03N0/8sqQT2mnXSaHGErXBRTXn8rzeXOoQxWQuf6KlYafZ0Ydm/Yrf
	 k48dYp25HH5W79xa244BQZDwy3RxKszm7/9QOsDF0QL5aqCEIlSVD2vP6RuaOQWXyp
	 gGMXySjEJ/AMA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 4/6] xdrgen: Rename enum's declaration Jinja2 template
Date: Sun, 29 Sep 2024 20:50:14 -0400
Message-ID: <20240930005016.13374-6-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930005016.13374-1-cel@kernel.org>
References: <20240930005016.13374-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

"close.j2" is a confusing name.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/generators/enum.py                      | 2 +-
 .../xdrgen/templates/C/enum/declaration/{close.j2 => enum.j2}   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/net/sunrpc/xdrgen/templates/C/enum/declaration/{close.j2 => enum.j2} (100%)

diff --git a/tools/net/sunrpc/xdrgen/generators/enum.py b/tools/net/sunrpc/xdrgen/generators/enum.py
index 855e43f4ae38..e37b5c297821 100644
--- a/tools/net/sunrpc/xdrgen/generators/enum.py
+++ b/tools/net/sunrpc/xdrgen/generators/enum.py
@@ -18,7 +18,7 @@ class XdrEnumGenerator(SourceGenerator):
     def emit_declaration(self, node: _XdrEnum) -> None:
         """Emit one declaration pair for an XDR enum type"""
         if node.name in public_apis:
-            template = self.environment.get_template("declaration/close.j2")
+            template = self.environment.get_template("declaration/enum.j2")
             print(template.render(name=node.name))
 
     def emit_definition(self, node: _XdrEnum) -> None:
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
similarity index 100%
rename from tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2
rename to tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
-- 
2.46.2


