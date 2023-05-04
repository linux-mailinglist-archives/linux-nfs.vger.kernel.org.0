Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FBC6F7762
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjEDUtH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEDUsh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:48:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41390A5CD
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1015E639ED
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 20:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18864C433EF;
        Thu,  4 May 2023 20:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233234;
        bh=FOZ1GrAVh5I0qJWWkitu/EJL95GloK40iE8/Q3F1AX8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iCDlZ05T8MycL/nwI4x+KkOzgsDL6x+bSAbj4qh/k0awpYprdV0gTbboph4MBwANY
         EDBeiz99FVqcF1UCy7xt9yrK4kHul5zD933UYQYJQMej/TH7ii+3KrrVYEgSMSsv/2
         2zQzHPnpNo/fVnanNHCcR8ponUn6mouD0GY/09KIk0LDUnSe+8DrZyRZEBnYEy+nip
         kbDFqTux1KIyyv2/J8Wy6bavEwCDsY+1HsfODSmI2P9e76HSuhHUHdsFaWBhDP8mT/
         qLUQj/zy4G0HROUkT+A81OTGLQxjh9nh6eQBL4B6XJjoSZrhF1tWxM7dOtE/tFuJYj
         xMObCRynU8VfQ==
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 04 May 2023 16:47:11 -0400
Subject: [PATCH 1/6] NFSv4.2: Clean up: Move the encode_copy_commit()
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-xattr-ctime-v1-1-ac3fc5a00942@Netapp.com>
References: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
In-Reply-To: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516;
 i=Anna.Schumaker@Netapp.com; h=from:subject:message-id;
 bh=YhAIFcPa9anoSlOC3BpN7M/+TE5eHPyERBNbF0fuIKk=;
 b=owEBbQKS/ZANAwAIAdfLVL+wpUDrAcsmYgBkVBnQTcoFK5cW2XQya7QPae5Q08cwVc3AxSP5+
 +L2dk4L7N+JAjMEAAEIAB0WIQSdnkxBOlHtwtTsoSnXy1S/sKVA6wUCZFQZ0AAKCRDXy1S/sKVA
 63xOD/4+EcFEH58zIeooBfYJzrqcSXDmfN2TmnViM3gnkd0huM0GsGU0IW5bTh3cFvVREw9Mw9p
 P/lGtqXTUWrdr4mI5Aee+6jxhWZ+O4Fz7gN/HlmhYnkDyn6OckD0YgckmiZm2hiX+4Uqqh3xrLl
 +4aM8R5SJscqvHUEcVSORBPqKQOeXghn2w+63cSNf7COpZWglp8n1F4hNr86Or7O1R87znuT6Ux
 xN+L7dUV7UA15yO7PjjMKMHKwe/2uSsHJOsDnW5zTd+lWm4UqfO5YOpf2nkMtl/gpJIy1WR8NfR
 CfZC/5VRNmgXWlA/q5HJzwXRgQHecgfpQ4FS8md3zPQvsf30cnZI2TFdGoyu07WMyLGOp0od66K
 NTyyPRT/FkOl3ooZeNia0o4CbWTO8876z3PZyw3Q+IuPT21yTDp8npGcopqHR3GKs5TGKjL7emb
 w+X1MIIe3hbcUbeXIGiVGjeCWlIWRFxVXzackvRfCAa9Wq5NEg3UGjgGMaAaU+Q57l5dW1Wi/LN
 ZL4+fe6twq0IixNkXmCNgYdpY24Ls3omhFYbAOpaTorU5Um05xuwyfEf5HdEob1nlGcbujK3TvW
 NUAwotr0/U5Phim8ugdBSV4HV4ODcZUNv2jYeqO1MoT6QHKBZit3ucJ7dJZ253IG521IKF2BC5K
 1nU+iEpsdcI+GNw==
X-Developer-Key: i=Anna.Schumaker@Netapp.com; a=openpgp;
 fpr=9D9E4C413A51EDC2D4ECA129D7CB54BFB0A540EB
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Move the function to be with the other encode_*() functions, instead of
in the middle of the nfs4_xdr_enc_*() section.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index a6df815a140c..dfac3f62c7ed 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -317,6 +317,18 @@ static void encode_copy(struct xdr_stream *xdr,
 	encode_nl4_server(xdr, args->cp_src);
 }
 
+static void encode_copy_commit(struct xdr_stream *xdr,
+			  const struct nfs42_copy_args *args,
+			  struct compound_hdr *hdr)
+{
+	__be32 *p;
+
+	encode_op_hdr(xdr, OP_COMMIT, decode_commit_maxsz, hdr);
+	p = reserve_space(xdr, 12);
+	p = xdr_encode_hyper(p, args->dst_pos);
+	*p = cpu_to_be32(args->count);
+}
+
 static void encode_offload_cancel(struct xdr_stream *xdr,
 				  const struct nfs42_offload_status_args *args,
 				  struct compound_hdr *hdr)
@@ -671,18 +683,6 @@ static void nfs4_xdr_enc_allocate(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
-static void encode_copy_commit(struct xdr_stream *xdr,
-			  const struct nfs42_copy_args *args,
-			  struct compound_hdr *hdr)
-{
-	__be32 *p;
-
-	encode_op_hdr(xdr, OP_COMMIT, decode_commit_maxsz, hdr);
-	p = reserve_space(xdr, 12);
-	p = xdr_encode_hyper(p, args->dst_pos);
-	*p = cpu_to_be32(args->count);
-}
-
 /*
  * Encode COPY request
  */

-- 
2.40.1

