Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0728165CACD
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 01:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjADA10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 19:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADA1Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 19:27:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9251020
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 16:27:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 320D0764D9;
        Wed,  4 Jan 2023 00:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672792042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7xT5vNr+mfPYIklBkzX3Ok4ID8aQPxkK3K4FX8XgwwY=;
        b=XS7CDYWEY29WIIWMs3c2h8gI9JrGPFJV600KIP6+hSSnv1usQE4dF+DskFTjNXgFE2tior
        WyzW7Gqq00XbFixt1LtCmDc10oLeYzxkbBDQaAAf4ZMtk0oaClE4QjzXOSCVJq6hHlXhs6
        FeO/pSYKmEnhUkpCFbJEzcuYRW/1DWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672792042;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7xT5vNr+mfPYIklBkzX3Ok4ID8aQPxkK3K4FX8XgwwY=;
        b=MD6ae96/AiP+KvxNmzkltpQgVGN1g58Ay5vlN03wA6NLmOfu3qEiSssXXrjxRTAk2YwCiI
        imWe8bL49lXL1wBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9896A1342C;
        Wed,  4 Jan 2023 00:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MvjBEujHtGMTXAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 04 Jan 2023 00:27:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: Handle missing attributes in OPEN reply
Date:   Wed, 04 Jan 2023 11:27:16 +1100
Message-id: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


If a NFSv4 OPEN reply reports that the file was successfully opened but
the subsequent GETATTR fails, Linux-NFS will attempt a stand-alone
GETATTR request.  If that also fails, handling of the reply is aborted
with error -EAGAIN and the open is attempted again from the start.

This leaves the server with an active state (because the OPEN operation
succeeded) which the client doesn't know about.  If the open-owner
(local user) did not have the file already open, this has minimal
consequences for the client and only causes the server to spend
resources on an open state that will never be used or explicitly closed.

If the open-owner DID already have the file open, then it will hold a
reference to the open-state for that file, but the seq-id in the
state-id will now be out-of-sync with the server.  The server will have
incremented the seq-id, but the client will not have noticed.  So when
the client next attempts to access the file using that state (READ,
WRITE, SETATTR), the attempt will fail with NFS4ERR_OLD_STATEID.

The Linux-client assumes this error is due to a race and simply retries
on the basis that the local state-id information should have been
updated by another thread.  This basis is invalid in this case and the
result is an infinite loop attempting IO and getting OLD_STATEID.

This has been observed with a NetApp Filer as the server (ONTAP 9.8 p5,
using NFSv4.0).  The client is creating, writing, and unlinking a
particular file from multiple clients (.bash_history).  If a new OPEN
from one client races with a REMOVE from another client while the first
client already has the file open, the Filer can report success for the
OPEN op, but NFS4ERR_STALE for the ACCESS or GETATTR ops in the OPEN
request.  This gets the seq-id out-of-sync and a subsequent write to the
other open on the first client causes the infinite loop to occur.

The reason that the client returns -EAGAIN is that it needs to find the
inode so it can find the associated state to update the seq-id, but the
inode lookup requires the file-id which is provided in the GETATTR
reply.  Without the file-id normal inode lookup cannot be used.

This patch changes the lookup so that when the file-id is not available
the list of states owned by the open-owner is examined to find the state
with the correct state-id (ignoring the seq-id part of the state-id).
If this is found it is used just as when a normal inode lookup finds an
inode.  If it isn't found, -EAGAIN is returned as before.

This bug can be demonstrated by modifying the Linux NFS server as
follows:

1/ The second time a file is opened, unlink it.  This simulates
   a race with another client, without needing to have a race:

    --- a/fs/nfsd/nfs4proc.c
    +++ b/fs/nfsd/nfs4proc.c
    @@ -594,6 +594,12 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
     	if (reclaim && !status)
     		nn->somebody_reclaimed =3D true;
     out:
    +	if (!status && open->op_stateid.si_generation > 1) {
    +		printk("Opening gen %d\n", (int)open->op_stateid.si_generation);
    +		vfs_unlink(mnt_user_ns(resfh->fh_export->ex_path.mnt),
    +			   resfh->fh_dentry->d_parent->d_inode,
    +			   resfh->fh_dentry, NULL);
    +	}
     	if (open->op_filp) {
     		fput(open->op_filp);
     		open->op_filp =3D NULL;

2/ When a GETATTR op is attempted on an unlinked file, return ESTALE

    @@ -852,6 +858,11 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
     	if (status)
     		return status;

    +	if (cstate->current_fh.fh_dentry->d_inode->i_nlink =3D=3D 0) {
    +		printk("Return Estale for unlinked file\n");
    +		return nfserr_stale;
    +	}
    +
     	if (getattr->ga_bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1)
     		return nfserr_inval;

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

Probably when the OPEN succeeds, the GETATTR fails, and we don't already
have the state open, we should explicitly close the state.  Leaving it
open could cause problems if, for example, the server revoked it and
signalled the client that there was a revoked state.  The client would
not be able to find the state that needed to be relinquished.  I haven't
attempted to implement this.

For stable backports prior to 4.14 the nfs_fhget() that needs an
alternate is in _nfs4_opendata_to_nfs4_state().

Cc: stable@vger.kernel.org
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/nfs4_fs.h   |  1 +
 fs/nfs/nfs4proc.c  | 18 ++++++++++++++----
 fs/nfs/nfs4state.c | 17 +++++++++++++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 5edd1704f735..5f2f5371a620 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -493,6 +493,7 @@ extern void nfs4_put_state_owner(struct nfs4_state_owner =
*);
 extern void nfs4_purge_state_owners(struct nfs_server *, struct list_head *);
 extern void nfs4_free_state_owners(struct list_head *head);
 extern struct nfs4_state * nfs4_get_open_state(struct inode *, struct nfs4_s=
tate_owner *);
+extern struct inode *nfs4_get_inode_by_stateid(nfs4_stateid *stateid, struct=
 nfs4_state_owner *owner);
 extern void nfs4_put_open_state(struct nfs4_state *);
 extern void nfs4_close_state(struct nfs4_state *, fmode_t);
 extern void nfs4_close_sync(struct nfs4_state *, fmode_t);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 40d749f29ed3..b441b1d14a50 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2008,10 +2008,20 @@ nfs4_opendata_get_inode(struct nfs4_opendata *data)
 	case NFS4_OPEN_CLAIM_NULL:
 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
 	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
-		if (!(data->f_attr.valid & NFS_ATTR_FATTR))
-			return ERR_PTR(-EAGAIN);
-		inode =3D nfs_fhget(data->dir->d_sb, &data->o_res.fh,
-				&data->f_attr);
+		if (data->f_attr.valid & NFS_ATTR_FATTR) {
+			inode =3D nfs_fhget(data->dir->d_sb, &data->o_res.fh,
+					  &data->f_attr);
+		} else {
+			/* We don't have the fileid and so cannot do inode
+			 * lookup.  If we already have this state open we MUST
+			 * update the seqid to match the server, so we need to
+			 * find it if possible.
+			 */
+			inode =3D nfs4_get_inode_by_stateid(&data->o_res.stateid,
+							  data->owner);
+			if (!inode)
+				inode =3D ERR_PTR(-EAGAIN);
+		}
 		break;
 	default:
 		inode =3D d_inode(data->dentry);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 2a0ca5c7f082..80c36c61ae20 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -752,6 +752,23 @@ nfs4_get_open_state(struct inode *inode, struct nfs4_sta=
te_owner *owner)
 	return state;
 }
=20
+struct inode *
+nfs4_get_inode_by_stateid(nfs4_stateid *stateid, struct nfs4_state_owner *ow=
ner)
+{
+	struct nfs4_state *state;
+	struct inode *inode =3D NULL;
+
+	spin_lock(&owner->so_lock);
+	list_for_each_entry(state, &owner->so_states, open_states)
+		if (nfs4_stateid_match_other(stateid, &state->open_stateid)) {
+			inode =3D state->inode;
+			ihold(inode);
+			break;
+		}
+	spin_unlock(&owner->so_lock);
+	return inode;
+}
+
 void nfs4_put_open_state(struct nfs4_state *state)
 {
 	struct inode *inode =3D state->inode;
--=20
2.39.0

