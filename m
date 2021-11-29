Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400B14627DF
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Nov 2021 00:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhK2XOT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 18:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbhK2XOE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 18:14:04 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1443C048F5A
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 14:40:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 330656F29; Mon, 29 Nov 2021 17:40:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 330656F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638225600;
        bh=n+60GEqPir8T1/Wn6LnfSAJAfnVHXseEUWWrIGpLuio=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ZHbg8u4Ut4Tv4s0fehPFMnNwhRBSoix/ImjnUGE6tgR0wqhS6VAL5f5VL69PI8Nt/
         oJYdaq8GaJaijBEpC7a05QNHsctOXkzpRoM840Y/YTDFAo0dlvDSdkm37Vjp8LL+WM
         FK+G1smo2iterwg07fcBbxsnftsl3pfXCl4iwlN4=
Date:   Mon, 29 Nov 2021 17:40:00 -0500
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] Remove NFS v2 support from the client and server
Message-ID: <20211129224000.GF24258@fieldses.org>
References: <20211129192731.783466-1-steved@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129192731.783466-1-steved@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 29, 2021 at 02:27:28PM -0500, Steve Dickson wrote:
> These patches will remove the all references and 
> support of NFS v2 in both the server and client.
> 
> On server side the support has been off, by default, 
> since 2013 (6b4e4965a6b). With this server patch the
> ability to enable v2 will be remove.
> 
> Currently even with CONFIG_NFS_V2 not set
> v2 mounts are still tied (over-the-wire).

So the client is running a kernel built with CONFIG_NFS_V2 not set, and
you're still seeing it send NFSv2 calls?

That's very weird.

> I looked at creating a kernel parameter module so support could
> re-enabled but that got ugly quick.

I don't think there's much point to a module parameter.

One other thing we might want to do is provide a way for distros to
configure out support on the server side too.  That'd help confirm that
people really aren't using it before we tear it out completely.

E.g., untested, and should probably remove more than this, but as a
start:

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 3d1d17256a91..7b9e9afc5fcb 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -35,6 +35,16 @@ config NFSD_V2_ACL
 	bool
 	depends on NFSD
 
+config NFSD_V2
+	bool "NFS server support for NFS version 2"
+	depends on NFSD
+	help
+	  This option enables server support for version 2 of the NFS
+	  protocol.  This version has significant limitations and is no
+	  longer widely used.
+
+	  If unsure, say N.
+
 config NFSD_V3
 	bool "NFS server support for NFS version 3"
 	depends on NFSD
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 80431921e5d7..09c376063ff0 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -116,7 +116,9 @@ static struct svc_stat	nfsd_acl_svcstats = {
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
 
 static const struct svc_version *nfsd_version[] = {
+#if defined(CONFIG_NFSD_V2)
 	[2] = &nfsd_version2,
+#endif
 #if defined(CONFIG_NFSD_V3)
 	[3] = &nfsd_version3,
 #endif
