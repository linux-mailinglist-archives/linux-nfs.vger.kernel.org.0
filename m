Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24EB379310
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhEJPxH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231846AbhEJPxC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:53:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8E5E6128B;
        Mon, 10 May 2021 15:51:56 +0000 (UTC)
Subject: [PATCH RFC 03/21] NFSD: Drop TRACE_DEFINE_ENUM for NFSD4_CB_<state>
 macros
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:51:56 -0400
Message-ID: <162066191603.94415.8588558802672891808.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

TRACE_DEFINE_ENUM() is necessary for enum {} but not for C macros.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 27a93ebd1d80..9378a6ec4089 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -828,11 +828,6 @@ TRACE_EVENT(nfsd_cb_nodelegs,
 	TP_printk("client %08x:%08x", __entry->cl_boot, __entry->cl_id)
 )
 
-TRACE_DEFINE_ENUM(NFSD4_CB_UP);
-TRACE_DEFINE_ENUM(NFSD4_CB_UNKNOWN);
-TRACE_DEFINE_ENUM(NFSD4_CB_DOWN);
-TRACE_DEFINE_ENUM(NFSD4_CB_FAULT);
-
 #define show_cb_state(val)						\
 	__print_symbolic(val,						\
 		{ NFSD4_CB_UP,		"UP" },				\


