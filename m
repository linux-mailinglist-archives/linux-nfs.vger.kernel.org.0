Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99199514E66
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352746AbiD2O45 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377978AbiD2O44 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 10:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B37B562
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 07:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F35761F91
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D23C385A7
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:37 +0000 (UTC)
Subject: [PATCH 1/6] NFSD: Remove dprintk call sites from tail of nfsd4_open()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:53:36 -0400
Message-ID: <165124401661.1060.5623859799097995836.stgit@bazille.1015granger.net>
In-Reply-To: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
References: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: These relics are not likely to benefit server
administrators.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 28bae84d7809..0c5c0a685f02 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -622,13 +622,9 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			break;
 		case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
              	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
-			dprintk("NFSD: unsupported OPEN claim type %d\n",
-				open->op_claim_type);
 			status = nfserr_notsupp;
 			goto out;
 		default:
-			dprintk("NFSD: Invalid OPEN claim type %d\n",
-				open->op_claim_type);
 			status = nfserr_inval;
 			goto out;
 	}


