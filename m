Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6525E5853EF
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbiG2QsD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiG2Qrs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 12:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABD89AB1
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 09:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8621E61E78
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 16:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943A0C433D6;
        Fri, 29 Jul 2022 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659113238;
        bh=YF2T6sWpacxzBtfnZu9MFHtFQKZAqialkskW4wsao54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIYx41C+770Lx+Zcp8bXY+E38h9n3TLKDXKmtK/JYF3gXAgpcIxubjVVeckajwgL1
         heS0TXA3WDgcaLDvX5PybCiSmTrIqiefSWhU1uSUzjY/+QFpyUormrCrSbhSC9wFov
         9FgoKGxPlKS53QumdY9wa/YunHpRd3mHfrQUma9FevLWa1qD+CFkZsSvPyhB0m1wvr
         jInyKhunZGQ0+nbcMKoM6UTvk5jIfDOVm4fyD4w4qi41QS+O1yl0hDJXiEu3J1QrNG
         0Ygn7HMrLr1srhtDLtfc1c3vCqO9db8JMh+sZMm3RSxerGhP4fSdzGkbBMVy6N5CNo
         hAySikGE99uhQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Olga Kornieskaia <kolga@netapp.com>
Subject: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
Date:   Fri, 29 Jul 2022 12:47:15 -0400
Message-Id: <20220729164715.75702-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729164715.75702-1-jlayton@kernel.org>
References: <20220729164715.75702-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We had a report from the spring Bake-a-thon of data corruption in some
nfstest_interop tests. Looking at the traces showed the NFS server
allowing a v3 WRITE to proceed while a read delegation was still
outstanding.

Currently, we only set NFSD_FILE_BREAK_* flags if
NFSD_MAY_NOT_BREAK_LEASE was set when we call nfsd_file_alloc.
NFSD_MAY_NOT_BREAK_LEASE was intended to be set when finding files for
COMMIT ops, where we need a writeable filehandle but don't need to
break read leases.

It doesn't make any sense to consult that flag when allocating a file
since the file may be used on subsequent calls where we do want to break
the lease (and the usage of it here seems to be reverse from what it
should be anyway).

Also, after calling nfsd_open_break_lease, we don't want to clear the
BREAK_* bits. A lease could end up being set on it later (more than
once) and we need to be able to break those leases as well.

This means that the NFSD_FILE_BREAK_* flags now just mirror
NFSD_MAY_{READ,WRITE} flags, so there's no need for them at all. Just
drop those flags and unconditionally call nfsd_open_break_lease every
time.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2107360
Fixes: 65294c1f2c5e (nfsd: add a new struct file caching facility to nfsd)
Reported-by: Olga Kornieskaia <kolga@netapp.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 26 +++-----------------------
 fs/nfsd/filecache.h |  4 +---
 fs/nfsd/trace.h     |  2 --
 3 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 4758c2a3fcf8..7e566ddca388 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -283,7 +283,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf, struct inode *inode)
 }
 
 static struct nfsd_file *
-nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
+nfsd_file_alloc(struct nfsd_file_lookup_key *key)
 {
 	struct nfsd_file *nf;
 
@@ -301,12 +301,6 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
 		/* nf_ref is pre-incremented for hash table */
 		refcount_set(&nf->nf_ref, 2);
 		nf->nf_may = key->need;
-		if (may & NFSD_MAY_NOT_BREAK_LEASE) {
-			if (may & NFSD_MAY_WRITE)
-				__set_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags);
-			if (may & NFSD_MAY_READ)
-				__set_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
-		}
 		nf->nf_mark = NULL;
 	}
 	return nf;
@@ -1090,7 +1084,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (nf)
 		goto wait_for_construction;
 
-	new = nfsd_file_alloc(&key, may_flags);
+	new = nfsd_file_alloc(&key);
 	if (!new) {
 		status = nfserr_jukebox;
 		goto out_status;
@@ -1130,21 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nfsd_file_lru_remove(nf);
 	this_cpu_inc(nfsd_file_cache_hits);
 
-	if (!(may_flags & NFSD_MAY_NOT_BREAK_LEASE)) {
-		bool write = (may_flags & NFSD_MAY_WRITE);
-
-		if (test_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags) ||
-		    (test_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags) && write)) {
-			status = nfserrno(nfsd_open_break_lease(
-					file_inode(nf->nf_file), may_flags));
-			if (status == nfs_ok) {
-				clear_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
-				if (write)
-					clear_bit(NFSD_FILE_BREAK_WRITE,
-						  &nf->nf_flags);
-			}
-		}
-	}
+	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
 out:
 	if (status == nfs_ok) {
 		if (open)
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index d534b76cb65b..8e8c0c47d67d 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -37,9 +37,7 @@ struct nfsd_file {
 	struct net		*nf_net;
 #define NFSD_FILE_HASHED	(0)
 #define NFSD_FILE_PENDING	(1)
-#define NFSD_FILE_BREAK_READ	(2)
-#define NFSD_FILE_BREAK_WRITE	(3)
-#define NFSD_FILE_REFERENCED	(4)
+#define NFSD_FILE_REFERENCED	(2)
 	unsigned long		nf_flags;
 	struct inode		*nf_inode;	/* don't deref */
 	refcount_t		nf_ref;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index e9c5d0f56977..2bd867a96eba 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -758,8 +758,6 @@ DEFINE_CLID_EVENT(confirmed_r);
 	__print_flags(val, "|",						\
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
-		{ 1 << NFSD_FILE_BREAK_READ,	"BREAK_READ" },		\
-		{ 1 << NFSD_FILE_BREAK_WRITE,	"BREAK_WRITE" },	\
 		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
 
 DECLARE_EVENT_CLASS(nfsd_file_class,
-- 
2.37.1

