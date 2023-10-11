Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E191D7C4920
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 07:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjJKFQI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjJKFQI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 01:16:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21909E
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 22:16:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CA5121861;
        Wed, 11 Oct 2023 05:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697001365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sF9gazo37wlzVi1cJeo+H2C/bzJkmsUXqEo9YfoPyNw=;
        b=PnQdgOqByoKef3iS7xRQtBGTaQj5THJm1EFNHSlQN3A1fpM4K0q+ZxPG2uKYNUKjIDHquU
        eqEt4srN1oii9pbWN1ljI/DjEa8wPy3phdcDg9p3Rkpb0PCz3+8QRH+XDCNuylgsXSeWOB
        pjigTweniJSdpd5xBU4/1OQw9/noR3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697001365;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sF9gazo37wlzVi1cJeo+H2C/bzJkmsUXqEo9YfoPyNw=;
        b=Q82xK+sYopeUVQCI7GXvbw6EesJA2a54XCuiDEdmVhNIUwOMh31FdIHI8FGcriRyJaP5AA
        IH8EmhPiBTj1dOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E57E13586;
        Wed, 11 Oct 2023 05:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0cd9OJMvJmVmQgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 11 Oct 2023 05:16:03 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH 0/3 nfs-utils] fixes for error handling in nfsd_fh
Date:   Wed, 11 Oct 2023 15:57:59 +1100
Message-ID: <20231011051131.24667-1-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When the kernel ask mountd to map the fsid from a filehandle to a path
name the request is handled by nfsd_fh().
The kernel expects to get a definitive answer - either a path name or
an clear statement that there is no path name.  However mountd sometimes cannot 
give a definitive answer - it wants to say "ask again later", but it cannot.

One case that it wants to say "ask again" is when a 'stat' of a
mountpoint fails with a non-path-name error.  This might mean that a
re-exported NFS mount is having problems.

The code for handling this case is incorrect.  mountd potentially scan
every moint point.  If any mount point matches the fsid, it should
succeed even if some other mountpoint appears to have problems.  Instead
assumes failure is *any* mountpoint has problems.  The first patch fixes
this - so now the error handling is only triggered if no matching mount
can be found.

This list of errors that are considered "path-name errors" does not
included EACCES.  This error can be returned, e.g., by fuse filesystem
that only allow a single use to have access.  The should be treated as a
path-name error.  The second patch fixes this.

However this still leave the error handling to be wrong.  The response
when no match is found and at least one questionable path is seen, is to
not send a response to the kernel.  The result of this is that the
kernel never asks again.  It return NFS4ERR_DELAY (for NFSv4) to the
client, but doesn't ever re-queue the request as the request is already
queued.  There is no way to tell the kernel "dequeue this request treat
the lookup as failure".

The third patch proposes a machanism to do this.  It returns a negative
result to the kernel with an expiry time in the past.  This could
reasonably be interpreted as "dequeue the request but do return a
definitive result".  The kernel doesn't currently treat it like that.
Rather it treats it as definitive just once, and will ask again for the
next request. But that will only come after the client has seen a failure.

We could easily change the kernel to respond differently, but we would
need to think carefully about the behaviour on older kernels, and about
the possibility of a much higher rate of fsid lookup requests being sent
from kernel to mountd.

So the third patch is just an RFC.  The first two patches are, I think,
suitable for immediate release (subject to normal review).

Thanks,
NeilBrown



