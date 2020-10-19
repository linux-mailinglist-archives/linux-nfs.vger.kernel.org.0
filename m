Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B14292F21
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Oct 2020 22:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgJSUHw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Oct 2020 16:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgJSUHw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Oct 2020 16:07:52 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F099E223BE;
        Mon, 19 Oct 2020 20:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603138072;
        bh=zAq15FUstWOfqVbeSiCLmKkzw+9KyJ7WYxUv7eeBroo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgNdj05ypFcn6iVbVF/ziKGiJFuaddrYP2aSsrMYTexL9xY/OcryD3AszR9l6FcjF
         RS2v4UN/cFnVLN/01kHO31pZObwUvkIe4cge0/RDynGauv6fa94P/AAF6e/6aWg6ie
         vmfAE+uszs42IT+o+7xH6qriOv9vdiL1ggkOw1SQ=
From:   trondmy@kernel.org
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] Add NFSv3 emulation of the lookupp operation
Date:   Mon, 19 Oct 2020 16:05:41 -0400
Message-Id: <20201019200543.606847-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In order to use the open-by-filehandle functionality with NFSv3, we
need to ensure that the NFS client can convert disconnected dentries
into connected ones by doing a reverse walk of the filesystem path.
To do so, NFSv4 provides the LOOKUPP operation, which does not
exist in NFSv3, but which can usually be emulated using lookup("..").

v2:
 - Fix compilation issues for "NFSv3: Refactor nfs3_proc_lookup() to
   split out the dentry"

Trond Myklebust (2):
  NFSv3: Refactor nfs3_proc_lookup() to split out the dentry
  NFSv3: Add emulation of the lookupp() operation

 fs/nfs/nfs3proc.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

-- 
2.26.2

