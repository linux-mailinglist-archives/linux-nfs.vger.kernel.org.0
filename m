Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0BF2FF015
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 17:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbhAUQV7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 11:21:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732786AbhAUQVs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 11:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611246021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=B77pImGVlPsw/RIYAIYbui87mrHnzpnWVNf4T08blD8=;
        b=XaPjEn0+ZEy+4DYtNTdLM23tf0qHZJgNxndiTjjpckFZ83L5JDS7def83an9WyLyi9L3Zp
        elaOebRVuxJpUJOJbrveupWV+lXWrmIxjUevYzPBW9qYAAgAeC/rQFFnQWWCvlZvy52nkg
        cylXiS0uSa0IeZJt43ae+W1AaaqLzUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-w5crbgy9NCONStyMGs13kA-1; Thu, 21 Jan 2021 11:20:20 -0500
X-MC-Unique: w5crbgy9NCONStyMGs13kA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17E921800D41;
        Thu, 21 Jan 2021 16:20:19 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-28.rdu2.redhat.com [10.10.113.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67D2974ACB;
        Thu, 21 Jan 2021 16:20:18 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] Fix crash in trace_rpcgss_context due to 0-length acceptor
Date:   Thu, 21 Jan 2021 11:20:14 -0500
Message-Id: <1611246016-21129-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

 include/linux/sunrpc/xdr.h          | 36 ++++++++++++++++++++++++++++++++++--
 net/sunrpc/auth_gss/auth_gss.c      | 29 -----------------------------
 net/sunrpc/auth_gss/gss_krb5_mech.c | 29 -----------------------------
 3 files changed, 34 insertions(+), 60 deletions(-)

-- 
1.8.3.1

