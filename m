Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7BD309FC9
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Feb 2021 01:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhBAAxo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jan 2021 19:53:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBAAxn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 31 Jan 2021 19:53:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E36F64E0F;
        Mon,  1 Feb 2021 00:53:02 +0000 (UTC)
Subject: [PATCH v1] SUNRPC: Fix NFS READs that start at non-page-aligned
 offsets
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     avian@extremenerds.net
Date:   Sun, 31 Jan 2021 19:53:01 -0500
Message-ID: <161214078155.1093.2334504504623797564.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Anj Duvnjak reports that the Kodi.tv NFS client is not able to read
video files from a v5.10.11 Linux NFS server.

The new sendpage-based TCP sendto logic was not attentive to non-
zero page_base values. nfsd_splice_read() sets that field when a
READ payload starts in the middle of a page.

The Linux NFS client rarely emits an NFS READ that is not page-
aligned. All of my testing so far has been with Linux clients, so I
missed this one.

Reported-by: A. Duvnjak <avian@extremenerds.net>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=211471
Fixes: 4a85a6a3320b ("SUNRPC: Handle TCP socket sends with kernel_sendpage() again")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index c9766d07eb81..5a809c64dc7b 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1113,14 +1113,15 @@ static int svc_tcp_sendmsg(struct socket *sock, struct msghdr *msg,
 		unsigned int offset, len, remaining;
 		struct bio_vec *bvec;
 
-		bvec = xdr->bvec;
-		offset = xdr->page_base;
+		bvec = xdr->bvec + (xdr->page_base >> PAGE_SHIFT);
+		offset = offset_in_page(xdr->page_base);
 		remaining = xdr->page_len;
 		flags = MSG_MORE | MSG_SENDPAGE_NOTLAST;
 		while (remaining > 0) {
 			if (remaining <= PAGE_SIZE && tail->iov_len == 0)
 				flags = 0;
-			len = min(remaining, bvec->bv_len);
+
+			len = min(remaining, bvec->bv_len - offset);
 			ret = kernel_sendpage(sock, bvec->bv_page,
 					      bvec->bv_offset + offset,
 					      len, flags);


