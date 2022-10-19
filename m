Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169BE604F18
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 19:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJSRnr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiJSRno (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 13:43:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08631C4909
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 10:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF699B8259D
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 17:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E726C433B5;
        Wed, 19 Oct 2022 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666201419;
        bh=uwCVdX1ulfgefYmg7XZs99cD0gzgSY50547f4XFvpF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2PiE+5fvXpe0j7d3qjrUux3sNXsjtnAVJb0efiWHvqRvz+b+LIcNeN6/RTlq7eYk
         kfzeQQagn6FiYccnIDrfBCRmbYme09i/6D26l/RTv4bsgMtPJlpnyFnF9bo8BRbYjU
         joM115Pq3UL35+T9n+TYONv2kN7h/5iSJTXAQtbuohg/zFlXhb1qLPTmrsDCbcsagw
         HDIVkRyeutpZtNezRIH3e4+B/Eu3VybI9eGAq5pNsSfCqzpbxCPuNB5EXDtJ72NcpN
         MhYqgenHv85Xk3elD51lqutB6x/wTH5DrPdKvuyf7+jI6rDgQH5zCDL7glgCLyukQm
         DRY5xv20seJZg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/4] NFSv4.2: Fix a memory stomp in decode_attr_security_label
Date:   Wed, 19 Oct 2022 13:36:50 -0400
Message-Id: <20221019173651.32096-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019173651.32096-2-trondmy@kernel.org>
References: <20221019173651.32096-1-trondmy@kernel.org>
 <20221019173651.32096-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We must not change the value of label->len if it is zero, since that
indicates we stored a label.

Fixes: b4487b935452 ("nfs: Fix getxattr kernel panic and memory overflow")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 9103e022376a..deec76cf5afe 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4236,12 +4236,10 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 			return -EIO;
 		bitmap[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 		if (len < NFS4_MAXLABELLEN) {
-			if (label) {
-				if (label->len) {
-					if (label->len < len)
-						return -ERANGE;
-					memcpy(label->label, p, len);
-				}
+			if (label && label->len) {
+				if (label->len < len)
+					return -ERANGE;
+				memcpy(label->label, p, len);
 				label->len = len;
 				label->pi = pi;
 				label->lfs = lfs;
-- 
2.37.3

