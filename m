Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE1031B199
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBNRmI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 12:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBNRmH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Feb 2021 12:42:07 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38ACC061574
        for <linux-nfs@vger.kernel.org>; Sun, 14 Feb 2021 09:41:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lg21so7660116ejb.3
        for <linux-nfs@vger.kernel.org>; Sun, 14 Feb 2021 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MB4xb1KU+v2EsUfLSLO02BE9ItBBcIJkzgSb9EQ/3Ws=;
        b=JqiAvPd84zAod+lXF8V3GbJvDCc+THWyhaVemy6LPY0VbCwlKmIyO0OxsGz1AfvqMz
         DXLSrTqcuRCCZllYWI40PhOGuTjenVrAkGOOPIZmaYoqIq49JqCIfS+AFmEggdNHbpLu
         QNY/pvircmLOUFIgB+onbYSS5x+fLp1LUh230UHnRAMH5J1ONn3lXUBQeZS5Zg2MXbmE
         X2IMs6zXNGNTZtJTWDaxScrz6ihl1Ff3+I9rWwD2tYeLgkzEHH8GfKn0c9bPuJmoc6fC
         Yv8RiVhzo5+hCIOMGei4dvBRxgM3G1RVjuUqrrfFV+yTt/aHedkCrFK0iiGtXvXZW3Wa
         ySHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MB4xb1KU+v2EsUfLSLO02BE9ItBBcIJkzgSb9EQ/3Ws=;
        b=TTX7C5N4U/V44aO3GlghVci2c5uFI2VzaDOGyQD+gzswq6W/RmlBW/G9ZMz010o9r2
         Zao7e6USqR0veMDVQAVFvjpyFoa2di13Pwm9dzeo5mH6JYJZ28tpTxrkpUy/hZc2QAbM
         KuReP4k+Uc7E7bQyDw27DP7A1e8Esx71eAw+rqeiEnltWj3IRXeto0cr6CjZLIr3iH4o
         QDIUVDXwhRbiws7t63XoBP7wSkp2NoldMary9JjCx5RhMozfCs2iMGWSXiP1MBNCVSCP
         QXODe5SCYAQBaP5gZteswa9Q1hizNhtgM/HjhQyAcC1O0Eksx/kjv2FLRnNUy9TwGuUU
         L5Zg==
X-Gm-Message-State: AOAM532ZQmdj+VamVucPjqoypDDdLjE7Bcfz8IMeZXDkTbX4bQiHfdS4
        JH1YKJS+r3pWVXywHi+39LVZZg==
X-Google-Smtp-Source: ABdhPJwlGaQW64EV7ZPlc0jwrWq3a6quonzhDKRNHsQFhGfLbInslsMGkPUFe3KXv8zhn1OqLvpJKQ==
X-Received: by 2002:a17:906:1457:: with SMTP id q23mr10578917ejc.43.1613324485501;
        Sun, 14 Feb 2021 09:41:25 -0800 (PST)
Received: from gmail.com ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id p25sm8708539eds.55.2021.02.14.09.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 09:41:24 -0800 (PST)
Date:   Sun, 14 Feb 2021 19:41:21 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Message-ID: <20210214174121.3n7lxeal4ifdoygn@gmail.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
 <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
 <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
 <20210202192417.ug32gmuc2uciik54@gmail.com>
 <8A686173-B3FF-4122-990C-6E8795D35161@redhat.com>
 <20210203212035.qncen4u3o6pr57h6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203212035.qncen4u3o6pr57h6@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 03, 2021 at 11:20:35PM +0200, Dan Aloni wrote:
> On Tue, Feb 02, 2021 at 02:49:38PM -0500, Benjamin Coddington wrote:
> > On 2 Feb 2021, at 14:24, Dan Aloni wrote:
> > > Also, what do you think would be a straightforward way for a userspace
> > > program to find what sunrpc client id serves a mountpoint? If we add an
> > > ioctl for the mountdir AFAIK it would be the first one that the NFS
> > > client supports, so I wonder if there's a better interface that can work
> > > for that.
> > 
> > I'm a fan of adding an ioctl interface for userspace, but I think we'd
> > better avoid using NFS itself because it would be nice to someday implement
> > an NFS "shutdown" for non-responsive servers, but sending any ioctl to the
> > mountpoint could revalidate it, and we'd hang on the GETATTR.
> 
> For that, I was looking into using openat2() with the very recently
> added RESOLVE_CACHED flag. However from some experimentation I see that it
> still sleeps on the unresponsive mount in nfs_weak_revalidate(), and the
> latter cannot tell whether LOOKUP_CACHED flag was passed to
> d_weak_revalidate().
> 
> > Maybe we can figure out a way to expose the superblock via sysfs for each
> > mount.
> 
> Essentially this is what fspick() syscall lets you do. I imagine that it
> can be implemented entirely under fs/nfs, using fsconfig() from under a
> FSCONFIG_SET_STRING passing a special string such as
> "report-clients-ids", causing a list of sunrpc client IDs to get written
> to the fs_context log.
> 
> However even with this interface we may still need to verify that the
> path lookup that `fspick` does using `user_path_at` is not blocking on
> non-responsive NFS mounts.

Pending a response from Anna about this, in the meanwhile I've prepared
patch for the fspick approach. My experiments show that it does not
block over hung mounts compared to the ioctl method. I'll repost
following comments.

-

Using a flag named "sunrpc-id" with set-flags following fspick syscall,
the information regarding related sunrpc client IDs can be determined on
a mountpoint:

    int fd = fspick(AT_FDCWD, "/mnt/export", FSPICK_CLOEXEC |
	FSPICK_NO_AUTOMOUNT);
    fsconfig(fd, FSCONFIG_SET_FLAG, "sunrpcid", NULL, 0);

Example output:

    i sunrpc-id main 4
    i sunrpc-id shared 0
    i sunrpc-id acl 5
    i sunrpc-id nlm 3
    i sunrpc-id -

Here `-` is used as end-of-list sentinel.

The advantage over adding a potential NFS ioctl is that no `open`
syscall is needed, therefore caching invalidation issues that
may result in a hung query are avoided.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 fs/nfs/fs_context.c | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h   |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 06894bcdea2d..a63aeeaaf6ce 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/lockd/lockd.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
@@ -76,6 +77,7 @@ enum nfs_param {
 	Opt_softerr,
 	Opt_softreval,
 	Opt_source,
+	Opt_sunrpcid,
 	Opt_tcp,
 	Opt_timeo,
 	Opt_udp,
@@ -161,6 +163,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_flag  ("softerr",	Opt_softerr),
 	fsparam_flag  ("softreval",	Opt_softreval),
 	fsparam_string("source",	Opt_source),
+	fsparam_flag  ("sunrpcid",	Opt_sunrpcid),
 	fsparam_flag  ("tcp",		Opt_tcp),
 	fsparam_u32   ("timeo",		Opt_timeo),
 	fsparam_flag  ("udp",		Opt_udp),
@@ -430,6 +433,41 @@ static int nfs_parse_version_string(struct fs_context *fc,
 	return 0;
 }
 
+static void nfs_client_report_sunrpcid(struct fs_context *fc,
+					struct rpc_clnt *clnt,
+					const char *kind)
+{
+	/* Client ID representation here must match /sys/kernel/sunrpc/net! */
+	nfs_resultf(fc, "sunrpcid %s %x", kind, clnt->cl_clid);
+}
+
+static int nfs_client_report_clients(struct fs_context *fc)
+{
+	struct nfs_server *server;
+
+	if (!fc->root) {
+		nfs_errorf(fc, "NFS: no root yet");
+		return 0;
+	}
+
+	server = NFS_SB(fc->root->d_sb);
+	if (!server) {
+		nfs_errorf(fc, "NFS: no superblock yet");
+		return 0;
+	}
+
+	nfs_client_report_sunrpcid(fc, server->client, "main");
+	nfs_client_report_sunrpcid(fc, server->nfs_client->cl_rpcclient, "shared");
+	nfs_client_report_sunrpcid(fc, server->client_acl, "acl");
+
+	if (server->nlm_host != NULL)
+		nfs_client_report_sunrpcid(
+			fc, server->nlm_host->h_rpcclnt, "nlm");
+
+	nfs_resultf(fc, "sunrpcid -");
+	return 0;
+}
+
 /*
  * Parse a single mount parameter.
  */
@@ -778,6 +816,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		ctx->sloppy = true;
 		dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
 		break;
+	case Opt_sunrpcid:
+		nfs_client_report_clients(fc);
+		break;
 	}
 
 	return 0;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index c8939d2cce1b..fd061304434e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -160,6 +160,10 @@ struct nfs_fs_context {
 	warnf(fc, fmt, ## __VA_ARGS__) :			\
 	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
 
+#define nfs_resultf(fc, fmt, ...) ((fc)->log.log ?		\
+	infof(fc, fmt, ## __VA_ARGS__) :			\
+	({ ; }))
+
 static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
 {
 	return fc->fs_private;
-- 
2.26.2


-- 
Dan Aloni
