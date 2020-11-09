Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD492AC4BD
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgKITLN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbgKITLN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:11:13 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D7AC0613CF;
        Mon,  9 Nov 2020 11:11:13 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 73487AB6; Mon,  9 Nov 2020 14:11:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 73487AB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1604949072;
        bh=w7fHvXEletg5+a7Lbz7J9G1vhosCa/9rtc1juG2Kp8M=;
        h=Date:To:Cc:Subject:From:From;
        b=XRAXAYf4IeIPNq6D7+WfTaOIKlVoytPBq1yf/Carrw6BPmzOZVHP+Gn1Xwwyx7lGE
         X36yIzxxCrHkdQcXDvHGsbU+ne1JOBJCVvimkEPXDxGc7HUHnxgwT7J6Smmbkyj4zx
         CYAEIU2UiIHW7fJ3mIkx8JSYU/IewG8A5gquCVWk=
Date:   Mon, 9 Nov 2020 14:11:12 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] nfsd 5.10 fixes
Message-ID: <20201109191112.GE11144@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull nfsd fixes for 5.10 from

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.10-1

This is mainly server-to-server copy and fallout from Chuck's 5.10 rpc
refactoring.

--b.

Chuck Lever (3):
      NFSD: NFSv3 PATHCONF Reply is improperly formed
      SUNRPC: Fix general protection fault in trace_rpc_xdr_overflow()
      NFSD: MKNOD should return NFSERR_BADTYPE instead of NFSERR_INVAL

Dai Ngo (2):
      NFSD: Fix use-after-free warning when doing inter-server copy
      NFSD: fix missing refcount in nfsd4_copy by nfsd4_do_async_copy

Dan Carpenter (2):
      net/sunrpc: return 0 on attempt to write to "transports"
      net/sunrpc: fix useless comparison in proc_do_xprt()

 fs/nfsd/nfs3proc.c            | 6 +-----
 fs/nfsd/nfs3xdr.c             | 1 +
 fs/nfsd/nfs4proc.c            | 3 ++-
 include/trace/events/sunrpc.h | 8 ++++----
 net/sunrpc/sysctl.c           | 9 +++++----
 5 files changed, 13 insertions(+), 14 deletions(-)
