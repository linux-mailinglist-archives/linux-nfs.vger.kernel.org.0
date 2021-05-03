Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2A3717C8
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhECPXm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhECPXl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:23:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 768C861176
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:22:48 +0000 (UTC)
Subject: [PATCH v1 00/29] server-side lockd XDR overhaul
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:22:47 -0400
Message-ID: <162005520101.23028.15766816408658851498.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Same approach as what has been done for NFSv2, NFSv3, and NFSv4: XDR
decoding and encoding functions have been updated to use xdr_stream.
This adopts common XDR infrastructure for these functions and makes
constructing and parsing more secure and robust.

---

Chuck Lever (29):
      lockd: Remove stale comments
      lockd: Create a simplified .vs_dispatch method for NLM requests
      lockd: Common NLM XDR helpers
      lockd: Update the NLMv1 void argument decoder to use struct xdr_stream
      lockd: Update the NLMv1 TEST arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 LOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 CANCEL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 UNLOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 nlm_res arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 SM_NOTIFY arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 SHARE arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 FREE_ALL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 void results encoder to use struct xdr_stream
      lockd: Update the NLMv1 TEST results encoder to use struct xdr_stream
      lockd: Update the NLMv1 nlm_res results encoder to use struct xdr_stream
      lockd: Update the NLMv1 SHARE results encoder to use struct xdr_stream
      lockd: Update the NLMv4 void arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 TEST arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 LOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 CANCEL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 UNLOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 nlm_res arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 SM_NOTIFY arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 SHARE arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 FREE_ALL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 void results encoder to use struct xdr_stream
      lockd: Update the NLMv4 TEST results encoder to use struct xdr_stream
      lockd: Update the NLMv4 nlm_res results encoder to use struct xdr_stream
      lockd: Update the NLMv4 SHARE results encoder to use struct xdr_stream


 fs/lockd/svc.c             |  43 ++++
 fs/lockd/svcxdr.h          | 151 ++++++++++++++
 fs/lockd/xdr.c             | 402 ++++++++++++++++++------------------
 fs/lockd/xdr4.c            | 403 +++++++++++++++++++------------------
 include/linux/lockd/xdr.h  |   6 -
 include/linux/lockd/xdr4.h |   7 +-
 6 files changed, 610 insertions(+), 402 deletions(-)
 create mode 100644 fs/lockd/svcxdr.h

--
Chuck Lever

