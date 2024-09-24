Return-Path: <linux-nfs+bounces-6630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F4984A21
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7A0B22BB6
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC612F375;
	Tue, 24 Sep 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fev56h80"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09D3612D;
	Tue, 24 Sep 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197732; cv=none; b=i7vXf37VhKKdh56tcXIrrqXkYtgqoo1ma6FKnp4B59IL3rL3vE28OeKn/b3o4l57eapEQTk/EU4P7tynn6++vnVATI/8BGJpA8f5XK7AkUoKhdzFo8TItnoguudmcp2CrLsAqnoAPuSUiu9fUIorfbseoMSyic4z/BOYSIDkV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197732; c=relaxed/simple;
	bh=WXQev4DVSIB44S9TWGxK57v+B8SHH0vsGb5EKjUsFqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/SDBcURJsCbP2TuH6v4NWuT+IltHeBGYlwquMVsq2ihjXajFwLveBQdvU4ylEw6qMUzOUFgDMj5++kJB5L6tE81/1jO1hv7xuxDfYpB237c/XIQ6BZdYu2iJTEQJtr9NEJ5S2v/v12cHT+oSvUBZg4zYG+L5f5ZAmJ3R6Lgnuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fev56h80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC77EC4CEC4;
	Tue, 24 Sep 2024 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727197731;
	bh=WXQev4DVSIB44S9TWGxK57v+B8SHH0vsGb5EKjUsFqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fev56h80KquL9001NIGMhrQ2nZRGQPNRO+XyQSgtnZ2hl2L5vq/DkBaLoaBQ1S0eb
	 FM6HjBvzasPcADEhQMFi4mMIhfVeUwLj/C0TcNgWCDMlUk7hDEgK3Cv+TvjrGexN6E
	 taNAWG1vc1bKpF8Y5IZaWTuAvE8c0OdxeX4KvW8n227mfizQSNs/IA35oJkUj+mRvz
	 zjI+J7W/4hLqSPl0gv8K9aiYj4lygjmti7rGED2KSvcDCfQnQRfu3Dz7EbjBbK7KA7
	 bO3FaKyHjdXdQO5MJvfGN3aKIZZsROan7kZwwGeef5g4XvPTeptTwElFFjU2+9sgnR
	 urxttbYVcN8TA==
Date: Tue, 24 Sep 2024 13:08:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@gmail.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	NFS Mailing List <linux-nfs@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the nfs-anna tree
Message-ID: <ZvLyIiyyu-FPG_yK@kernel.org>
References: <20240924144626.3b374ff3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924144626.3b374ff3@canb.auug.org.au>

On Tue, Sep 24, 2024 at 02:46:26PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the nfs-anna tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/filesystems/nfs/localio.rst:43: ERROR: Unexpected indentation.
> Documentation/filesystems/nfs/localio.rst:56: ERROR: Unexpected indentation.
> Documentation/filesystems/nfs/localio.rst:179: WARNING: Inline emphasis start-string without end-string.
> Documentation/filesystems/nfs/localio.rst:190: WARNING: Definition list ends without a blank line; unexpected unindent.
> Documentation/filesystems/nfs/localio.rst:191: WARNING: Definition list ends without a blank line; unexpected unindent.
> Documentation/filesystems/nfs/localio.rst: WARNING: document isn't included in any toctree
> 
> Introduced by commit
> 
>   92945bd81ca4 ("nfs: add Documentation/filesystems/nfs/localio.rst")

Sorry for the trouble.

Anna, the following fixes all errors and warnings for me, please feel
free to fold this into the initial localio.rst commit Stephen
referenced, thanks:

diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/filesystems/nfs/index.rst
index 8536134f31fd..9298b47518d9 100644
--- a/Documentation/filesystems/nfs/index.rst
+++ b/Documentation/filesystems/nfs/index.rst
@@ -14,3 +14,4 @@ NFS
    nfs41-server
    knfsd-stats
    reexport
+   localio
diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index 3c9bc370079b..5502c25021a0 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -40,12 +40,14 @@ using XDR and RPC for reads, writes and commits can be extreme, e.g.:
 
 fio for 20 secs with directio, qd of 8, 16 libaio threads:
 - With LOCALIO:
+
   4K read:    IOPS=979k,  BW=3825MiB/s (4011MB/s)(74.7GiB/20002msec)
   4K write:   IOPS=165k,  BW=646MiB/s  (678MB/s)(12.6GiB/20002msec)
   128K read:  IOPS=402k,  BW=49.1GiB/s (52.7GB/s)(982GiB/20002msec)
   128K write: IOPS=11.5k, BW=1433MiB/s (1503MB/s)(28.0GiB/20004msec)
 
 - Without LOCALIO:
+
   4K read:    IOPS=79.2k, BW=309MiB/s  (324MB/s)(6188MiB/20003msec)
   4K write:   IOPS=59.8k, BW=234MiB/s  (245MB/s)(4671MiB/20002msec)
   128K read:  IOPS=33.9k, BW=4234MiB/s (4440MB/s)(82.7GiB/20004msec)
@@ -53,12 +55,14 @@ fio for 20 secs with directio, qd of 8, 16 libaio threads:
 
 fio for 20 secs with directio, qd of 8, 1 libaio thread:
 - With LOCALIO:
+
   4K read:    IOPS=230k,  BW=898MiB/s  (941MB/s)(17.5GiB/20001msec)
   4K write:   IOPS=22.6k, BW=88.3MiB/s (92.6MB/s)(1766MiB/20001msec)
   128K read:  IOPS=38.8k, BW=4855MiB/s (5091MB/s)(94.8GiB/20001msec)
   128K write: IOPS=11.4k, BW=1428MiB/s (1497MB/s)(27.9GiB/20001msec)
 
 - Without LOCALIO:
+
   4K read:    IOPS=77.1k, BW=301MiB/s  (316MB/s)(6022MiB/20001msec)
   4K write:   IOPS=32.8k, BW=128MiB/s  (135MB/s)(2566MiB/20001msec)
   128K read:  IOPS=24.4k, BW=3050MiB/s (3198MB/s)(59.6GiB/20001msec)
@@ -85,19 +89,21 @@ Linux Kernel Organization       400122  nfslocalio
 
 The LOCALIO protocol spec in rpcgen syntax is:
 
-/* raw RFC 9562 UUID */
-#define UUID_SIZE 16
-typedef u8 uuid_t<UUID_SIZE>;
+::
 
-program NFS_LOCALIO_PROGRAM {
-    version LOCALIO_V1 {
-        void
-            NULL(void) = 0;
+  /* raw RFC 9562 UUID */
+  #define UUID_SIZE 16
+  typedef u8 uuid_t<UUID_SIZE>;
 
-        void
-            UUID_IS_LOCAL(uuid_t) = 1;
-    } = 1;
-} = 400122;
+  program NFS_LOCALIO_PROGRAM {
+      version LOCALIO_V1 {
+          void
+              NULL(void) = 0;
+
+          void
+              UUID_IS_LOCAL(uuid_t) = 1;
+      } = 1;
+  } = 400122;
 
 LOCALIO uses the same transport connection as NFS traffic. As such,
 LOCALIO is not registered with rpcbind.

