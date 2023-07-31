Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA4F76A1D5
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 22:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGaU1i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaU1h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 16:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB23133;
        Mon, 31 Jul 2023 13:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0674612CB;
        Mon, 31 Jul 2023 20:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EFAC433C8;
        Mon, 31 Jul 2023 20:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690835255;
        bh=TmbK524pfD8a3wRy4IrVFirwLTHysXeU3Jn2VfJulsQ=;
        h=From:Date:Subject:To:Cc:From;
        b=ZygBj+AMp4tlhH/6B20I9e1AhTXK71uW09MNLzKXq76l23R7Mg9jrQnRNzzM4i/E1
         sQ63hOBkya0hX/N3/K8T8Rntb/gub/FnoDiZDtYUF5mXY54evXtIVilNRPkLE2PdyQ
         VZyevRaH4LdtW7kpXgSXy/Pp+PqYo3vcmpgDVtj1M4PvDPKu/XV/5m4BSG4UZKb5mI
         qic/XjjFtTL+uxKMADZqHIdPAHmtBD6qv0ySSVAbAiA9Sw6/0RHXD8NvygSMVbVJVI
         4hrmXLVlIffiQ1NRS7B7SCk6VmWUBas21L7cmEzedzY/OGh17chuobRvwgQSkODitG
         y6i5lM9SCkXEA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 31 Jul 2023 16:27:30 -0400
Subject: [PATCH RFC] nfsd: don't hand out write delegations on O_WRONLY
 opens
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-wdeleg-v1-1-f8fe1ce11b36@kernel.org>
X-B4-Tracking: v=1; b=H4sIADEZyGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc2ND3fKU1JzUdN2kpJQksyQj00TjZDMloOKCotS0zAqwQdFKQW7OSrG
 1tQCgK1ToXQAAAA==
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TmbK524pfD8a3wRy4IrVFirwLTHysXeU3Jn2VfJulsQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkyBk2u6nbq3M7Vqj+uN7GKDpu6v5UE5FoFoEKa
 yTCfF3CqKSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZMgZNgAKCRAADmhBGVaC
 FVydEADOE1IOAcbwePjD7rmhaUtW4W+4f6uA28DwVoHhLJAsP9GGCijdqeSXpoY3js0bbRKdc8L
 Eoi7FdsYcZw0pncyx2GAtQUlvu7V5i2cpucu/o568T3PN86cGBbDhKDuF3lAKYcSSsXLG7iQkaj
 0uw5z6nQCH8BI3dazkQoKphuKx1WZIWe0d+VfTsPxa1ScFZdSlQv/cwsU5SCEKFzu/DhIu4mIsS
 qdfMdZG6ca7ooVQzqjWTPt7UXEtsDBZRgynVIM8SRNObMwqL1vlMxFuzmipcM4L5v6hjPczhsvb
 Khkupqd0imwdmmGP+XTKlrcB7Qvfji+0Zo3GeP7RF1jQPF5knHTap2JDhR2fpIzZHhtOR3igJNd
 UW8yWYM7nwqVZXYyP9oHyuOkDAbeM643X9EMWQlGjw1Bcqw028eIztoCYdo+/6FnUqnBKs+MqSR
 t7LfxQyNFTZYzHLF3GWjUC48nZcmJrKIlYAqp2zlxR0FBbm83aS6TtsIxyO8ldt0qq1ueYHNL61
 bm8NHW52sHaPOTeXALLNUD2eArsdKlctGhoMYLqtPJTeHVZdsAFVe/YAxbGKc4ziN89eVvE2z1n
 40KAchXnqJBhCAhQNqfdxJfqzlP9REpNL2UbwlSxbRjeVcGcUhZn9At8Q204lsAByaERVwo1YgG
 zSgGf4Y2vSBdGBQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I noticed that xfstests generic/001 was failing against linux-next nfsd.

The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
would hand out a write delegation. The client would then try to use that
write delegation as the source stateid in a COPY or CLONE operation, and
the server would respond with NFS4ERR_STALE.

The problem is that the struct file associated with the delegation does
not necessarily have read permissions. It's handing out a write
delegation on what is effectively an O_WRONLY open. RFC 8881 states:

 "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
  own, all opens."

Given that the client didn't request any read permissions, and that nfsd
didn't check for any, it seems wrong to give out a write delegation.

Don't hand out a delegation if the client didn't request
OPEN4_SHARE_ACCESS_BOTH.

This fixes xfstest generic/001.

Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ef7118ebee00..9f1c90afed72 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5462,6 +5462,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		return ERR_PTR(-EAGAIN);
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
+		if (!(open->op_share_access & NFS4_SHARE_ACCESS_READ))
+			return ERR_PTR(-EBADF);
 		nf = find_writeable_file(fp);
 		dl_type = NFS4_OPEN_DELEGATE_WRITE;
 	} else {

---
base-commit: ec89391563792edd11d138a853901bce76d11f44
change-id: 20230731-wdeleg-bbdb6b25a3c6

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

