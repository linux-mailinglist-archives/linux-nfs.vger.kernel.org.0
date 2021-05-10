Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6F037930E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhEJPwv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhEJPwt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:52:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 609B2611CA;
        Mon, 10 May 2021 15:51:44 +0000 (UTC)
Subject: [PATCH RFC 01/21] NFSD: Constify @fh argument of knfsd_fh_hash()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:51:43 -0400
Message-ID: <162066190354.94415.3711879718192471702.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enable knfsd_fh_hash() to be invoked in functions where the
filehandle pointer is a const.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index aff2cda5c6c3..6106697adc04 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -225,15 +225,12 @@ static inline bool fh_fsid_match(struct knfsd_fh *fh1, struct knfsd_fh *fh2)
  * returns a crc32 hash for the filehandle that is compatible with
  * the one displayed by "wireshark".
  */
-
-static inline u32
-knfsd_fh_hash(struct knfsd_fh *fh)
+static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, (unsigned char *)&fh->fh_base, fh->fh_size);
 }
 #else
-static inline u32
-knfsd_fh_hash(struct knfsd_fh *fh)
+static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return 0;
 }


