Return-Path: <linux-nfs+bounces-14140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DAB501DE
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17050162F09
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ACD25A2DA;
	Tue,  9 Sep 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1ibc6zE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4D260578;
	Tue,  9 Sep 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432899; cv=none; b=tGqPF/fyJTJys6CmnzL3Nf9SZz2DKhalE47joZuPxC0hWmUN6Jo9gw7DLC2sL3pCyeCpUCYJSbEfrSLcfidJdrKDzX4d60Mo1f8gIDPE3rCMewDKnl31hBbiAmg0/RAjIdRm51swJGtwzDFp01iu+awO3pgLs6WURw1hORAerGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432899; c=relaxed/simple;
	bh=tRrIg15HEYoHjQLRwxjOEm2FO9KzuZ6msqcICp3U2hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RHG9SNTIhO+NhGtCdV/z3BwbwqAPYbXjdOzJunQ/+N+VPoiNHimmxu8bWu6D+UOhgsGV7xxtxQWSO8+Y1DRFLQkEYwBa+UMvCQrmqB+3aMlwitmeL6cTrxmz+1AcqtzwmRIh3tr+4mqa8lmR9kYchzT2vy5sU52JoGp9DRlxeww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1ibc6zE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A912BC4CEF4;
	Tue,  9 Sep 2025 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432898;
	bh=tRrIg15HEYoHjQLRwxjOEm2FO9KzuZ6msqcICp3U2hQ=;
	h=From:Date:Subject:To:Cc:From;
	b=Q1ibc6zEluBEvCOoC4ymVsgcZFF1QxEdd6VDMWfVzC9CZ5kimA6B45nzSKvauUG0k
	 sHvi/WdZdHPJlZxzhImPPQGAPU5rdEkNNcpRBXxwH/qXK88NVmQ4PaaWoI9Twg6ADz
	 1MjD8642aTo5SQKzauBNK+ARhWiBRY9gSJ+TfReozV3+KW350Kk5tRu2ESqpG6dnS1
	 +iB2H13oAdT5CXcCYwqd+OfLzxRtKN2OU+ZBb8XBt88gohTL3GhGTaQiv0nqXbuU1F
	 w3iZmhrUhc3dlc26p+xDkd0HbntZ/bfRXIFrlVPqK20KI1w+dGA+DpYyJXtICyfTeo
	 /BWiUr+1AXRGw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Sep 2025 11:48:08 -0400
Subject: [PATCH] nfsd: switch the default for NFSD_LEGACY_CLIENT_TRACKING
 to "n"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-nfsd-6-18-v1-1-c87fe3b85ca2@kernel.org>
X-B4-Tracking: v=1; b=H4sIADhMwGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNL3by04hRdM11DC9205GSjxLS0JEMLIwMloPqCotS0zAqwWdGxtbU
 AhzYrDlsAAAA=
X-Change-ID: 20250909-nfsd-6-18-fcc2affb1820
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tRrIg15HEYoHjQLRwxjOEm2FO9KzuZ6msqcICp3U2hQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBowEw6SjeDyclDxEirK+PN1lq7afNKxjlghSbif
 wD2SEOjwKiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaMBMOgAKCRAADmhBGVaC
 FZIcEAC54DJ8Rj0sHb07l6MgT4YCigfETQr2fM47HVjhtau0URYv3GySFs8NNhpcFV45yAZX+Uw
 noUPXWQTtN2UYcuhh5Ytix55lMg4ykbHUfXTG9GhBl4h3BgrUC3w+Fx+4SieZTBrXsm+Tnw+s2b
 ivzdw3Bncn/fb5Fb/pTW4P3bpU8xhg9b8N+ZoivbGCDUMuvuZKLE+FqmnZrmWJW6+cB33VvSLx+
 B4aHC+v00F5plHQwO1rabox6zaqD98wZ9ZbOZaVu4aYZkauxxIHdlYb9U9iMSQQSUJ1gk83YRnD
 64fvKCeJLsTo4Lw3bg/kTMgnpVfKKCXL/eqKBPxxjosN6wDzLXJ+dNRUFWZWgWuoHdz/qLvni21
 29QpiH76bLRs4YSQ0RoLR17DIhFgUb4Tm2BRlFb6AoX98+MNq5oiUb2AdphwMMvm0x5qTvc98oa
 Bhjs6Zuy20EUyR8l7kf+YZkZh7fVJp/D9yWI3dZQMvlST9CNkZX+ilSYRtYePGSyaDtrLpcjw4P
 byFqVF/t7qKRCS1mTeW95BxkObinTixr+47Uc94J44fp2pPkxEs1vlzGGgStpGOLybW3WL2VcWz
 rX376t8uTnmCyykhy5JYbAdfvGiOv+Aneh1hhOfF4za3H4SQHY1V6YFMZjQ7PoyM8JOMjkxg3pL
 SzEjRpQqn1QftAg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We added this Kconfig option a little over a year ago. Switch the
default to "n" in preparation for its eventual removal.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index e134dce45e350cde8b78bfac2dbed4b638d9ec7d..df09c5cefb7c1f5124b7963f52bb67254d5c08b6 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -164,7 +164,7 @@ config NFSD_V4_SECURITY_LABEL
 config NFSD_LEGACY_CLIENT_TRACKING
 	bool "Support legacy NFSv4 client tracking methods (DEPRECATED)"
 	depends on NFSD_V4
-	default y
+	default n
 	help
 	  The NFSv4 server needs to store a small amount of information on
 	  stable storage in order to handle state recovery after reboot. Most

---
base-commit: 737a649eb793bcb88852e905870aaf67d2925f16
change-id: 20250909-nfsd-6-18-fcc2affb1820

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


