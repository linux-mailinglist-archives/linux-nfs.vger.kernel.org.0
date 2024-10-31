Return-Path: <linux-nfs+bounces-7597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F49B7BDB
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96A12824A5
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236E19E98E;
	Thu, 31 Oct 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REznCYkN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31813D886
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382013; cv=none; b=S21TpVTZrM7qnldp34q+che7xtAywxJg/XrRLUjCVRL02ttTYJxgo7tLmUZ8mFmfWejedqwcy/5qeTEVoWDXHwtV3Gwjc2eyaB/wK0eVHJgzBLEq5c/fDS6HQvXo9F+7BQhYTgHnm2/KRKnqNkuEi5il98N6+vjyyThpnAZXd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382013; c=relaxed/simple;
	bh=NLTfNQgpIrN8nSWD2KGZi3NiduOAIgMC5LCO/UqVZqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDWvNyhJ/calNZqm0rngfHJKL4Kk5PErbJCggBA3n5/kCIcxPeau6HNV6sqzirTQ39K9vdxmQv3po7UB4J2QRioosNjZ2dNjvJSJIkjx8QmwZVWebzgfMlAwBBPLzqZyo1NcapiSMMf4qG0yBdvWtZ9m1gQgb6l7rElBasOAvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REznCYkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28886C4AF10;
	Thu, 31 Oct 2024 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730382012;
	bh=NLTfNQgpIrN8nSWD2KGZi3NiduOAIgMC5LCO/UqVZqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REznCYkN60z8gEUlTxTHW3xRdNIQNhxuDEvUJQ3csv/d5fz6VGS5PnJHcRkPvr68Y
	 CxXo/hI9zdTL5jq2pqMqIVjZjKsSgFSQLqKVoSWB8LfQ40EzVmLdE7DVkagN2mFtY8
	 MwuYrDoyMXNOb1e+BuJ4Hav5dB4bINfkKYUnQr6i024U1bttI39KueblaR62+bvyNn
	 JuRhqFhalukQJ5SLIswQ7q67rin1xd1HLlhOZ+bsPa4/T7oWQdvWLWM/1KIRfWNDut
	 wwXZivpf6gUI7sf3Ymz1R+ewiLPS4jJk9DCuAiUtjSt7acQj26Td49R/3PxBGZLmpV
	 wD8MQmonDYVYQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 2/8] NFSD: Fix nfsd4_shutdown_copy()
Date: Thu, 31 Oct 2024 09:40:03 -0400
Message-ID: <20241031134000.53396-12-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031134000.53396-10-cel@kernel.org>
References: <20241031134000.53396-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=chuck.lever@oracle.com; h=from:subject; bh=R/WZk8vkBpzwiEAkmXEKVL+foWiT5chmxIeSH1OQJdU=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnI4i2xcaWe1nJSbWJB6vFJ1GxIq44a/yvlwm8v KyNDXhG0zOJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyOItgAKCRAzarMzb2Z/ lyVFEACQ3nzwY8CmP16QuHVj/eZ98gUfOqOQXz04r4vrzd64I/5tjSUfZ7eDZeFIKCMslCu8d9g GrwdzriBFshoJ//qN8LtJSYwYASYRvHDqnJFD4LOV/fLMH75OVxUYx7TMd7ttSnPRl5+DLM4j5d or/dV+5qUGaTBO5V/7wr0df7TE2aMrQW6n/2+SYJn2FT+bXipDM+Ts5kys9y6bK3ULu0elT5AKq CzELAsBm6+arnJAMkWSPHmfdkCx/oD990nfX1LKgQ5wthMCX8I8CLRRidOy3MjI8R/5930O0HzH 3NuyrvLQqzCoOx74cGVmclOUdb3smKF8kSbP2IXPuOo2wwdFasaV0WJd08RWysH9MF7kcr1iRGr OZJqawkzVL3o/BXSTtArigmM2bp5RG5+eZwKTeS5VE+3Ug3+uQ5sCxNaYEORm3lPsC0ppZL1diD 3rTFWU1Yxf6XiS6lFfzZYGaW+X6AcLjuRDLAoPLoUNlyGTQ0upIrrUx40XPHWNe1Br7IYwOtDB7 rFC2+CFhOGNZLqPgLkgMUk59dkxkgofroV0i1XpjFDb0ILwYB6w5oUNZ28zjg693GKicqXtnJfH J0V36FeX7/lLy8D3wqWJRoOjb37Tl3dNoe/V49WQ6ZOqwfy0j4FY75hf0kVLzxQG5I2BPQUXIeI +PVPMAIKrvw3iXg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

nfsd4_shutdown_copy() is just this:

	while ((copy = nfsd4_get_copy(clp)) != NULL)
		nfsd4_stop_copy(copy);

nfsd4_get_copy() bumps @copy's reference count, preventing
nfsd4_stop_copy() from releasing @copy.

A while loop like this usually works by removing the first element
of the list, but neither nfsd4_get_copy() nor nfsd4_stop_copy()
alters the async_copies list.

Best I can tell, then, is that nfsd4_shutdown_copy() continues to
loop until other threads manage to remove all the items from this
list. The spinning loop blocks shutdown until these items are gone.

Possibly the reason we haven't seen this issue in the field is
because client_has_state() prevents __destroy_client() from calling
nfsd4_shutdown_copy() if there are any items on this list. In a
subsequent patch I plan to remove that restriction.

Fixes: e0639dc5805a ("NFSD introduce async copy feature")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9f6617fa5412..8229bbfdd735 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1302,6 +1302,9 @@ static struct nfsd4_copy *nfsd4_get_copy(struct nfs4_client *clp)
 		copy = list_first_entry(&clp->async_copies, struct nfsd4_copy,
 					copies);
 		refcount_inc(&copy->refcount);
+		copy->cp_clp = NULL;
+		if (!list_empty(&copy->copies))
+			list_del_init(&copy->copies);
 	}
 	spin_unlock(&clp->async_lock);
 	return copy;
-- 
2.47.0


