Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D502EB538
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 23:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbhAEWIE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 17:08:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731697AbhAEWIE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 17:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609884397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xAoxDXMsPZj/qMTI5eu+lcfOwwdoSBWw9N6hHhAbBv4=;
        b=AQl1xbfy8DbZiJhNZPuAn5XVfYHgNUv1ES1A7a1euEXYnO6sMOYWkFz6C4Y7qHuCawcOfm
        WQPk8GqW9EwzrcdoujgMtY7Y/YutPdo8k/7s8RTVcTxIrjY3sTDqfdecxHl3nGVwG5DIYw
        YUmcb4LSydMGBV3xADOAB+UyUEvF1Fc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-cCeW_ydFPlm8WKZWhnIJUQ-1; Tue, 05 Jan 2021 17:06:35 -0500
X-MC-Unique: cCeW_ydFPlm8WKZWhnIJUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C35CC59
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 22:06:34 +0000 (UTC)
Received: from f31-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F13C271A9
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 22:06:34 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Fix crash in trace_rpcgss_context due to 0-length acceptor
Date:   Tue,  5 Jan 2021 17:06:32 -0500
Message-Id: <20210105220634.27910-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This small patchset fixes a kernel crash when the rpcgss_context trace event is
enabled and IO is in flight when a kerberos ticket expires.  The crash occurs
because the acceptor name may be 0 bytes long and the gss_fill_context() function
does not handle it properly.  This causes the ctx->gc_acceptor.data to be
ZERO_SIZE_PTR which is not properly recognized by the tracepoint code.

The first patch is a simple refactor and eliminates duplicate helper functions
related to the crash.  The second patch is the actual fix inside one of the
helper functions due to the definition of an opaque XDR object.  This object
is defined in RFC 4506 (see section 4.10), where 'length' is an integer in a
range including 0.

Reproducer

# Enable the tracepoint and mount the share
trace-cmd start -e rpcgss:*
mount -osec=krb5 nfs-server:/export /mnt/nfs

# Obtain a kerberos ticket
# Set ticket lifetime to something small like 20 seconds
su test -c "kinit -l 20 test"

# Sleep for a portion of the ticket lifetime so we are writing while the ticket expires
sleep 10

# Now run some IO long enough that the ticket expires midway
dd if=/dev/urandom of=/mnt/nfs/file bs=1M count=100


Dave Wysochanski (2):
  SUNRPC: Move simple_get_bytes and simple_get_netobj into xdr.h
  SUNRPC: Handle 0 length opaque XDR object data properly

 include/linux/sunrpc/xdr.h          | 33 +++++++++++++++++++++++++++--
 net/sunrpc/auth_gss/auth_gss.c      | 29 -------------------------
 net/sunrpc/auth_gss/gss_krb5_mech.c | 29 -------------------------
 3 files changed, 31 insertions(+), 60 deletions(-)

-- 
2.25.2

