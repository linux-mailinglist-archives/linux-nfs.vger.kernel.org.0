Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC675FA3A
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGXOxs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGXOxr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 10:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331A810C7;
        Mon, 24 Jul 2023 07:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCBBA611CE;
        Mon, 24 Jul 2023 14:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7962AC433CA;
        Mon, 24 Jul 2023 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690210426;
        bh=JvxzI2ec4nmjfcSx7Dk5ZGMMTg3mm1W+45Wt9adUQn0=;
        h=From:Date:Subject:To:Cc:From;
        b=Hyaiu9wKl1597Jykx6MIkp3p2w9NyKmkR46knQGiHN+WHxcQuZ8zqKcD1C4FUkjNE
         HrW3fjhHWmG4gaVE6NxDtdc76VEWgurYVISMJra3uh8JaJ+U35YQ16E5NkU0YdTt3b
         jBYsXGa3ji/BiaOxYVqTjxdIBH1+zgqOCXny6S2zztvDOAK0192iG+MMQ1KdJvWBdw
         wItdKVoH8hcFCSh/UXRDwbaYSZDTEcvIvOnEYySwOc5CtLkamD94CSB/MDiZVZgPyG
         ZRw7JIJysp2P4UqjOIhOMgnNoT65YXvD5K8MzUbJ9dbgQL4sqVo/A9dXqWfBAhWQVz
         GGZ+2DI6XvhnA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 24 Jul 2023 10:53:39 -0400
Subject: [PATCH RFC] nfsd: set missing after_change as before_change + 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-bz2223560-v1-1-b6da868c0fc6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHKQvmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyMT3aQqIyMjY1MzA13T1BSzpGTjRNOUJHMloPqCotS0zAqwWdFKQW7
 OSrG1tQC4mS3XYAAAAA==
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JvxzI2ec4nmjfcSx7Dk5ZGMMTg3mm1W+45Wt9adUQn0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkvpB5K3xyXadUePxkbITjV0wr5i3sW9yPqwRuH
 fq29BBvN0WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZL6QeQAKCRAADmhBGVaC
 FauDD/0S+0CLT+t0uMc0+7sYPkn462IXnlMUmCDYC4Uf2epjFLYX+Lpjoq9e3AlQRNjV7lM7fXa
 1IuP7V+HONzuV5H0X0C8ZQRaMngyMA1v6WpEGyYZivvecwLmlvcO0WS1bAnFXc1gldE3SPfTEgB
 IFqDqcKFEAclOeAkslrXM++Q8vON7icGc9pAud23iWZFXg4NqGKcktWvKPLyi8kzF38W44LuUBc
 IiKLNjoinEhpfst2C0q9181By19+INvO9q592rYRAJisU6HRut7lpZ6Yb/xgOtB6vYDwhjhFJOy
 xXRsIftqYy2e6IHMLBnZygXG6Dt14Y8qlaHxGGFloFJzEDlrcnYpX/LCiAfAz4/fiID97zjyN7/
 cnqL+e4U3oDEoGJ1W+CvIeFX/iAurm0rGr569jtzrqzm8MzPw8Xf1CdDFaMmJkyq6mwxOFkgCZ2
 HqecpHrzFKkVu2Jm+qJMyMIPBZBEHdp7N2ebzkOWNiKTGQ5sevrGfCN6yvrJ2Y+d8uWois0uhUk
 T1OfKn6H8Sp8JGU1cJYJSHASAqA+pfuYot3HEAzrHWI/dGQSiatrpVGLT53yX8lQxIpbs6aVKfW
 DdrtMrAC++R23oX2IA/SpJYz1CcT6HkMo+Mu4pReJUeDKgdzWJaulo4p4GDaudxzlXNo6X2w51D
 A9CryTIjyVsUaZA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In the event that we can't fetch post_op_attr attributes, we still need
to set a value for the after_change. The operation has already happened,
so we're not able to return an error at that point, but we do want to
ensure that the client knows that its cache should be invalidated.

If we weren't able to fetch post-op attrs, then just set the
after_change to before_change + 1. The atomic flag should already be
clear in this case.

Suggested-by: Neil Brown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3f6710c9c5c9..f0f318e78630 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -411,7 +411,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 	if (WARN_ON_ONCE(!fhp->fh_pre_saved))
 		cinfo->before_change = 0;
 	if (!fhp->fh_post_saved)
-		cinfo->after_change = 0;
+		cinfo->after_change = cinfo->before_change + 1;
 }
 
 static __be32

---
base-commit: 97a5d0146ef443df148805a4e9c3c44111f14ab1
change-id: 20230724-bz2223560-5ed6bc3a5db7

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

