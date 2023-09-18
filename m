Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E21C7A4BFD
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjIRPYS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbjIRPYQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:24:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E78BA
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:22:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773A7C116D3;
        Mon, 18 Sep 2023 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045676;
        bh=7T/ahaIQ40lO0iadikPZJwQTz6UCKqt6StYeT1YAY9c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BnyKX4ZJW2VfzBToga9cZ7p1Sz+8NcuVdMPhJzIo4bhIGw4Nq80UhbUq5F9Muq2Ol
         lEutkaxaFT3LKJTtb7wxF7nlCZ7MqmEVK5/r71/XsxjbbhKK8tnKz3zE5UOmdZdSKP
         YL7vNmAq6w6wvV36dD3HDpVKjTvfMAfB1OZgdXb8xebTa5qFrFfbulHIZRStlbgqlB
         RqkPf+lBFjRwLaJUoEjPVhEG5eRk6Uwqun/y7/eNghXMo5cuc+or9yq/kHZS6DHtvN
         kJnicJ0fMmTS+tTR91IQw4M7Fc6Opluj5fcv5k+niBgVA8jhKzA7vS0a//1L9E0rk6
         lsjV0AIrlCalg==
Subject: [PATCH v1 42/52] NFSD: Add nfsd4_encode_fattr4_time_modify()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:15 -0400
Message-ID: <169504567550.133720.11907611503992862711.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Refactor the encoder for FATTR4_TIME_MODIFY into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 75121b4a6020..730596c53258 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3268,6 +3268,12 @@ static __be32 nfsd4_encode_fattr4_time_metadata(struct xdr_stream *xdr,
 	return nfsd4_encode_nfstime4(xdr, &args->stat.ctime);
 }
 
+static __be32 nfsd4_encode_fattr4_time_modify(struct xdr_stream *xdr,
+					      const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_nfstime4(xdr, &args->stat.mtime);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3611,7 +3617,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_MODIFY) {
-		status = nfsd4_encode_nfstime4(xdr, &args.stat.mtime);
+		status = nfsd4_encode_fattr4_time_modify(xdr, &args);
 		if (status)
 			goto out;
 	}


