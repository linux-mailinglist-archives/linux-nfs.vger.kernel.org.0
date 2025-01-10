Return-Path: <linux-nfs+bounces-9098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E1A09266
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 14:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2F01883236
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C5A20B804;
	Fri, 10 Jan 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuC48NTt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEBB20E329
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516804; cv=none; b=n9zdPekjx/PeNE/CAbbZwJOM+mJ1AhQyw3wyg9AD4RTu17qvBtxGA0pcGEdQolHJFZZHGPmhFw8WqZkJupZvFOdWbcoi/8SjAdMG+tyHq9ZXm03SYakJXw2CsVl6I5Q+PFpZS5eHR0hAcjkTuKSB9yRZucGWnMYrLONJoL6/e5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516804; c=relaxed/simple;
	bh=5i0DE7GCBuobU6++argKUBH/vG9xHtJoNgfnmIfCuZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCy/ADAAvA2XM0+HC9YqXlD+LkduZdCrLKTDlyYqi+fqOWLkk7UQ4rF6WnEwkWTXJM/Wjw2iJBENbQCS5PiX9pFe1jxjgGiO+Rt4Bf/2Oo3wuMGUk6f0WxHh6wh/bijfW9a/xBGzBLAcy2rpt6H0pknHlAFTGyV120vESsBBGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuC48NTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F763C4CEE4;
	Fri, 10 Jan 2025 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736516804;
	bh=5i0DE7GCBuobU6++argKUBH/vG9xHtJoNgfnmIfCuZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AuC48NTtdfc9vYu7eDdnfwE0uWWzT+w50/oRNywtODz7pe2aqx2zd6LFsrZo4r4k+
	 I4n2aIka+OmpByknwg9YCcEnbXfTXKXPCRSI6a3a8TkZQgosyXWtloqJlAda/pwS6N
	 5QOfl2QRuNsxVWwLW8eLiRB+e+QOb3WXMc5EknunWq+z1E2sWYvuRlVdzbbY8+FFyd
	 riFpoQyRXG7gi2//jU5MocDmiQAJbHp/MkZBv0O9LxoEV5YGosFD4ZQ79jT1Z3ejEf
	 Ne3QW5KM0EW3dwIlI3MSnkdCPy0gE+7FWJmMP1PutFb18gEBnfpnK9J1UqeqyMCVu4
	 QeRiWBB3BcxLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Jan 2025 08:46:22 -0500
Subject: [PATCH v2 2/3] nfsdctl: fix the --version option
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-lockd-nl-v2-2-e3abe78cc7fb@kernel.org>
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
In-Reply-To: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=583; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5i0DE7GCBuobU6++argKUBH/vG9xHtJoNgfnmIfCuZ8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBngSTC3JcMlSOQqkyhRC6AwNFnBMGPzERHheCtT
 XOnRv0N81CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ4EkwgAKCRAADmhBGVaC
 FX/ZD/9QJDjnw5AHgoXhdvSsFsXeFmR6d9B3KysOmwkb02J4FSw9G75Kz8qu4Ru566WIcUvkpw3
 zy3esOXL3r2A181Po+AoEr3eKyNAtta48ILSiTWNYSIx2wad/q95idfj14e3W8VWyfOnEiAAm0x
 BHSdcNfHxRi+2trjCSlcWP6NExcXr6SROOUZtLhK+oU+42J/MXCQZ1LPh/qQXfxFZ1XipvAHx/I
 uCkElm95vtn3Ru1H26JoHSb202kyy+8RyuqZSsdozljVmdv++ETt/Ub79jj6xRezg1arcc4qMpH
 qLmx6627GZK6E39HbMFTvWDnOIH+t0b5AgDWLoPO8wcJQHBf1SLwDlygQMIbwuZH/6DYzfgFmF7
 94duqyOWbIYmf7uHWZXOMmNjw3EOWoAWu5YxXUXV09UbigqRk+CYAosqsdBIPZD7x0Uk4t+uyqE
 6k9VnO3EuHIw8V+NWmgsSKaOAmvp/7jIrZK7JRlc6zvzXAobjj7asehiv63p+PAqjqeI0w8j23O
 cTIjSvH9YEAIDWx4VOeZW9x3CXMM/gsIwNxF9J/i9nt4ycJerNhQdDG7bJL81kXtEDWSeTiz2VB
 esW8ABaljqdSCsCvcaZkhZkwuhlvGo94hQGbHXnHeT+IBM+Gm2jiKktEpJ7KkhqiLOd68Gdch4U
 tzHfoYK5r8KcHEQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index e6819aec9890ae675a43b8259021ebaa909b08b9..5c319a74273fd2bbe84003c1261043c4b2f1ff29 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1550,7 +1550,7 @@ int main(int argc, char **argv)
 			xlog_stderr(0);
 			break;
 		case 'V':
-			// FIXME: print_version();
+			fprintf(stdout, "nfsdctl: " VERSION "\n");
 			return 0;
 		}
 	}

-- 
2.47.1


