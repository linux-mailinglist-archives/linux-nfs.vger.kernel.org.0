Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF37B69542D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 23:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBMW5T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 17:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMW5S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 17:57:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745E83E6
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 14:57:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6237C20582;
        Mon, 13 Feb 2023 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1676329035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V/hJy2i81LjxxI7B081Pen+EENxI9StoRSdKuu03DaQ=;
        b=gg1yDgVjKcfWN1SZ/msugslqpb7YTD3rm2pG6BNkKxeRaQIqMKKZdzSB1/YBhs6OPSlqED
        4cXu569mlSD96oRZAVu6mbAbHoj7IJGSxrTseB+yft3aKvknaYJ8ZGd1qZNDNyrJR4CWHz
        H2env9PnqM3bXyppxUfKRrliUyCxM6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1676329035;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V/hJy2i81LjxxI7B081Pen+EENxI9StoRSdKuu03DaQ=;
        b=HtTd8wmN9IDyWE3IXkSzjNKWzug5AHRLAshZCjfpPo0unVCzvwz0NBbxrdLbjhtbGed6Up
        TN6eIwrFyD9vgsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DA1D1391B;
        Mon, 13 Feb 2023 22:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mlHmA0nA6mM6cQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Feb 2023 22:57:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: avoid infinite NFS4ERR_OLD_STATEID loops
Date:   Tue, 14 Feb 2023 09:57:09 +1100
Message-id: <167632902904.1896.16364452992981515041@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Linux-NFS responds to NFS4ERR_OLD_STATEID by simply retrying the
request, hoping to make use of an updated stateid that might have
arrived from the server.  This is usually successful.

However if the client and server get out-of-sync for some reason and if
there is no new stateid to try, this can result in an indefinite loop
which looks a bit like a DoS attack.

This can particularly happen when a server replies with success to an
OPEN request, but fails a subsequent GETATTR.  This has been observed
with Netapp and Hitachi servers when a concurrent unlink from a
different client removes the file between the OPEN and the GETATTR.  The
GETATTR returns NFS4ERR_STALE.

In this situation Linux-NFS ignores the successful open and in
particular does not record the new stateid.  If the same file was
already open, those active opens will now have an OLD_STATEID.

When the Netapp/Hitachi servers receive subseqent WRITE requests with
the STALE file handle and OLD stateid, they choose to report the
OLD_STATEID error rather than the STALE error.  This causes Linux-NFS to
loop indefinitely.

To protect against this or other scenarios that might result in old
stateids being used, this patch limits the number of retry attempts when
OLD_STATEID is received.  The first 4 retries are sent immediately after
an error.  After that the standard timed back-off retry scheme is used
until a 2-second delay is reached.  After than the OLD_STATEID error is
mapped to ESTALE so the write fails rather than hanging indefinitely.

This pattern of server behaviour can be demonstrated - and so the patch
can be tested - by modifying the Linux NFS server as follows:

1/ The second time a file is opened, unlink it.  This simulates
   a race with another client, without needing to have a race:

>    --- a/fs/nfsd/nfs4proc.c
>    +++ b/fs/nfsd/nfs4proc.c
>    @@ -594,6 +594,12 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>     	if (reclaim && !status)
>     		nn->somebody_reclaimed =3D true;
>     out:
>    +	if (!status && open->op_stateid.si_generation > 1) {
>    +		printk("Opening gen %d\n", (int)open->op_stateid.si_generation);
>    +		vfs_unlink(mnt_user_ns(resfh->fh_export->ex_path.mnt),
>    +			   resfh->fh_dentry->d_parent->d_inode,
>    +			   resfh->fh_dentry, NULL);
>    +	}
>     	if (open->op_filp) {
>     		fput(open->op_filp);
>     		open->op_filp =3D NULL;

2/ When a GETATTR op is attempted on an unlinked file, return ESTALE

>    @@ -852,6 +858,11 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>     	if (status)
>     		return status;
>
>    +	if (cstate->current_fh.fh_dentry->d_inode->i_nlink =3D=3D 0) {
>    +		printk("Return Estale for unlinked file\n");
>    +		return nfserr_stale;
>    +	}
>    +
>     	if (getattr->ga_bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1)
>     		return nfserr_inval;

Then mount the filesystem and

  Thread 1            Thread 2
  open a file
                      open the same file (will fail)
  write to that file

I use this shell fragment, using 'sleep' for synchronisation.
The use of /bin/echo ensures the write is flushed when /bin/echo closes
the fd on exit.

    (
        /bin/echo hello
        sleep 3
        /bin/echo there
    ) > /import/A/afile &
    sleep 3
    cat /import/A/afile

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/nfs4proc.c       | 21 +++++++++++++++++++--
 include/linux/nfs_xdr.h |  2 ++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 40d749f29ed3..ee77bf42ec38 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -408,7 +408,7 @@ static long nfs4_update_delay(long *timeout)
 	long ret;
 	if (!timeout)
 		return NFS4_POLL_RETRY_MAX;
-	if (*timeout <=3D 0)
+	if (*timeout <=3D NFS4_POLL_RETRY_MIN)
 		*timeout =3D NFS4_POLL_RETRY_MIN;
 	if (*timeout > NFS4_POLL_RETRY_MAX)
 		*timeout =3D NFS4_POLL_RETRY_MAX;
@@ -562,9 +562,24 @@ static int nfs4_do_handle_exception(struct nfs_server *s=
erver,
 			return 0;
=20
 		case -NFS4ERR_RETRY_UNCACHED_REP:
-		case -NFS4ERR_OLD_STATEID:
 			exception->retry =3D 1;
 			break;
+		case -NFS4ERR_OLD_STATEID:
+			/* Simple retry is usually safe, but buggy
+			 * servers can cause DoS - so be careful.
+			 */
+			if (exception->timeout > HZ*2) {
+				ret =3D -ESTALE;
+			} else if (exception->timeout < 5) {
+				/* 5 tries with no delay */
+				exception->retry =3D 1;
+				exception->timeout +=3D 1;
+				ret =3D 0;
+			} else {
+				exception->delay =3D 1;
+				ret =3D 0;
+			}
+			break;
 		case -NFS4ERR_BADOWNER:
 			/* The following works around a Linux server bug! */
 		case -NFS4ERR_BADNAME:
@@ -5506,10 +5521,12 @@ static int nfs4_write_done_cb(struct rpc_task *task,
 			.inode =3D hdr->inode,
 			.state =3D hdr->args.context->state,
 			.stateid =3D &hdr->args.stateid,
+			.timeout =3D hdr->timeout,
 		};
 		task->tk_status =3D nfs4_async_handle_exception(task,
 				NFS_SERVER(inode), task->tk_status,
 				&exception);
+		hdr->timeout =3D exception.timeout;
 		if (exception.retry) {
 			rpc_restart_call_prepare(task);
 			return -EAGAIN;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e86cf6642d21..0c791e5b213c 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1625,6 +1625,8 @@ struct nfs_pgio_header {
 	unsigned int		good_bytes;	/* boundary of good data */
 	unsigned long		flags;
=20
+	long			timeout;
+
 	/*
 	 * rpc data
 	 */
--=20
2.39.1

