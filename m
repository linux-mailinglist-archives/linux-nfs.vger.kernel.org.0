Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FEE7B55CE
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbjJBOvm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbjJBOvl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 10:51:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB52B8
        for <linux-nfs@vger.kernel.org>; Mon,  2 Oct 2023 07:51:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE7C433C9;
        Mon,  2 Oct 2023 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696258298;
        bh=jSAf2uLBVHRO+A8Zet2h3ZWYDeFN0+UkCxTBIlRDi4Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KBbSPnu0O0Fm6ljgQ3W6M2ImXZODM7/o4PiO7MsFUobgWTnQ8gJe2vrtWAUsSh7k+
         DtZZ8lMryTAabUgRsHUoiSebICnSsLhWdM81Vza6r60IgE8e2gOYRNipV9d8f+xDMQ
         FFTTGVit4ueLeqTGOVz8fI9DqlSUP/hbN2/hS1QSRamicMZrSzTQVanGTGLBisoJw/
         r1RHc8rBO1S/V7g1sVjZGMN/aJ6ZHeft7q5VJep3Y8d5wl9QGJKwxGOSlxNCDTZDka
         DtRtYm7vKoabEpG8ATD1yDLuo20PQlt0lKQlvm8Iq0kTOPqYteE+ZOosNISRiH/48W
         ubAIwp8BvhwIw==
Subject: [PATCH v1 4/4] NFSD: Clean up nfsd4_encode_sequence()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 02 Oct 2023 10:51:37 -0400
Message-ID: <169625829708.1640.1086998477611708664.stgit@klimt.1015granger.net>
In-Reply-To: <169625819958.1640.14102064750083176117.stgit@klimt.1015granger.net>
References: <169625819958.1640.14102064750083176117.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

De-duplicate open-coded encoding of the sessionid, and convert the
rest of the function to use conventional XDR utility functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   37 +++++++++++++++++++++++++------------
 fs/nfsd/xdr4.h    |    1 +
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 505f397a6e5b..f1f0b707c7d9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4849,22 +4849,35 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_sequence *seq = &u->sequence;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, NFS4_MAX_SESSIONID_LEN + 20);
-	if (!p)
-		return nfserr_resource;
-	p = xdr_encode_opaque_fixed(p, seq->sessionid.data,
-					NFS4_MAX_SESSIONID_LEN);
-	*p++ = cpu_to_be32(seq->seqid);
-	*p++ = cpu_to_be32(seq->slotid);
+	/* sr_sessionid */
+	nfserr = nfsd4_encode_sessionid4(xdr, &seq->sessionid);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* sr_sequenceid */
+	nfserr = nfsd4_encode_sequenceid4(xdr, seq->seqid);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* sr_slotid */
+	nfserr = nfsd4_encode_slotid4(xdr, seq->slotid);
+	if (nfserr != nfs_ok)
+		return nfserr;
 	/* Note slotid's are numbered from zero: */
-	*p++ = cpu_to_be32(seq->maxslots - 1); /* sr_highest_slotid */
-	*p++ = cpu_to_be32(seq->maxslots - 1); /* sr_target_highest_slotid */
-	*p++ = cpu_to_be32(seq->status_flags);
+	/* sr_highest_slotid */
+	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* sr_target_highest_slotid */
+	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* sr_status_flags */
+	nfserr = nfsd4_encode_uint32_t(xdr, seq->status_flags);
+	if (nfserr != nfs_ok)
+		return nfserr;
 
 	resp->cstate.data_offset = xdr->buf->len; /* DRC cache data pointer */
-	return 0;
+	return nfs_ok;
 }
 
 static __be32
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 7983eb679ba7..cd124969589e 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -97,6 +97,7 @@ nfsd4_encode_uint32_t(struct xdr_stream *xdr, u32 val)
 #define nfsd4_encode_mode4(x, v)	nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_nfs_lease4(x, v)	nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_sequenceid4(x, v)	nfsd4_encode_uint32_t(x, v)
+#define nfsd4_encode_slotid4(x, v)	nfsd4_encode_uint32_t(x, v)
 
 /**
  * nfsd4_encode_uint64_t - Encode an XDR uint64_t type result


