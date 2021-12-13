Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30BC473295
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 17:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhLMQ6I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 11:58:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51098 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbhLMQ6H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 11:58:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A168EB811D7
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 16:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ED2C34602
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 16:58:04 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: De-duplicate nfsd4_decode_bitmap4()
Date:   Mon, 13 Dec 2021 11:58:02 -0500
Message-Id:  <163941438065.1156.4689848046690033429.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546; h=from:subject:message-id; bh=RVIfCzb9AbBqbXb+eP3GqfTxbiXkfGWUf2Z5KfH+lLY=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBht3uS9mDz8NdKNJOfo4iVnOP6wY4pifLdVr3C0ykT FGXlCQyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYbd7kgAKCRAzarMzb2Z/l97OD/ oCmszCs2nu2iAQlpNGulXkCInW5OTV5WBQHSVOHlWy4EUbgoJw3Rq7fIfLeyOY2yuLu35HaDChnttN /QMZXaRKe0gKMLlHstiF6HT6NSRLAaBsgSG5x2OouuA+cRR/Gky/aQkue/M7xdkqKzk/hyADOYCIaY TW6/SoZA8GdnCwWtHAdn10sOWJ402EYD1/DcjxtAn57vvjwuNNQKeLCJ7bMzHSuiJU8WkHpwQDsGhm ZeUuwHyVS3HKFaVRtTrbQXj0q1AvHwkVSgC4ocspIRbqsKfCglBvBawFu14xP5L8/ulaadMy7lN5YS DWpKy4LJg1neIdU3qwFYLOYbLQsr877h+Cq37DPapCvvfRj7coI+DgfR1edkV7DxsoogrLjCoU8n9A EcpXe7npJd3cj8ZbZ1TYhdck1BGm0gLSLAXQfStuP0wtpKz1Yluma17KsXZYdpDTTM6MJvM89SHoSf /V0OVsSm5o7XHfR7VSfXMYjD8ItIavqk7cMYu7m6Ne/eLlu8vFsIy03SoEEi4Ae6C0Qsy6jqEqhGnx 7mfFt/mnSKQiBmQ7eyjjxtvpNLLYW2lAGnbs7I4nEAtePR0kGW98rQMskP4iM+2s8Vg2lh2FTalzoF TdvbMnt8XKy83kRXlqbel6Ijb+8FoMA07Ip1C+3CDKPZPi0hEwpW+9tVSdRA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. Trond points out that xdr_stream_decode_uint32_array()
does the same thing as nfsd4_decode_bitmap4().

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

This patch replaces "NFSD: Replace nfsd4_decode_bitmap4()". Changes
since that version:

- My copy of pynfs was out of date. I've updated to the latest
- I reproduced Bruce's BADXDR report with the latest pynfs
- I tested this version likewise and could not reproduce the issue
- The nice documenting comment is preserved

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5a93a5db4fb0..df5a4c7ea8ec 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -277,21 +277,10 @@ nfsd4_decode_verifier4(struct nfsd4_compoundargs *argp, nfs4_verifier *verf)
 static __be32
 nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
 {
-	u32 i, count;
-	__be32 *p;
-
-	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
-		return nfserr_bad_xdr;
-	/* request sanity */
-	if (count > 1000)
-		return nfserr_bad_xdr;
-	p = xdr_inline_decode(argp->xdr, count << 2);
-	if (!p)
-		return nfserr_bad_xdr;
-	for (i = 0; i < bmlen; i++)
-		bmval[i] = (i < count) ? be32_to_cpup(p++) : 0;
+	ssize_t status;
 
-	return nfs_ok;
+	status = xdr_stream_decode_uint32_array(argp->xdr, bmval, bmlen);
+	return status == -EBADMSG ? nfserr_bad_xdr : nfs_ok;
 }
 
 static __be32

