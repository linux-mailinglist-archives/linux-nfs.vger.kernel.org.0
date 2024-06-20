Return-Path: <linux-nfs+bounces-4179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F59C910F1F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65193B2B9CB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0791C8FA4;
	Thu, 20 Jun 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XP9SKSTX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FA1C68AF
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904806; cv=none; b=FntsLf0ceKWEWPSxeufneZ2s6GLxy+OULQ2H851NXPP7oAYbIaeTOm3wvdnOrlF5ygMBisR11LGGJonMbF96WLG77S7j45ARLa0gZAmDKvZXBaQzJPuep+tr4GjfGir3mRMuNYvN2z3199y8kLow2FL9ozkPMciAW85M759Ehlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904806; c=relaxed/simple;
	bh=7q+wJzCww2SNJ3UcaKpzQR7ZAsX6Gi9tg4x7dh6z0Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo6NSPj7lgOc5k83LapL35j7Vuo2OXUvvnx//THX/0+5oTFyJJa/v1GpoJdIJtWhe2bIZhYv4v+XjPqsaJ19GxdrjEuH3LRLH0thLObliVeItvoqu8UJSMQVCjVnitXPjFxxED88k8+O9vePAsQqvucH5VaE6CZOUXRXm5kYT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XP9SKSTX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uX8xcUkGpuu8sXJI7G0aibuVHEQvl2VRr7qcOSjNkD0=;
	b=XP9SKSTXA3RFY2iI65ANRUPaympwFndBKciSdwyPHvZS79IIbK/MXYzd+93ehmb4lToV+k
	k/OW/E+wa5iSOItUBlzq0hVEKOX895o2Zev6e9oFzC398/19n03bLaaYhoHtbfKXr80OzA
	NoDVooYYXhGJ/AlBCxfsbwAttxcVU2I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-5gkrIObUOdmWGIEp57IBsQ-1; Thu,
 20 Jun 2024 13:33:22 -0400
X-MC-Unique: 5gkrIObUOdmWGIEp57IBsQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDA6719560BE;
	Thu, 20 Jun 2024 17:33:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76B5219560AF;
	Thu, 20 Jun 2024 17:33:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>
Subject: [PATCH 11/17] cifs: Move the 'pid' from the subreq to the req
Date: Thu, 20 Jun 2024 18:31:29 +0100
Message-ID: <20240620173137.610345-12-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Move the reference pid from the cifs_io_subrequest struct to the
cifs_io_request struct as it's the same for all subreqs of a particular
request.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h |  2 +-
 fs/smb/client/cifssmb.c  |  8 ++++----
 fs/smb/client/file.c     | 10 +++-------
 fs/smb/client/smb2pdu.c  |  4 ++--
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index b48d3f5e8889..bbcc552c07be 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1495,6 +1495,7 @@ struct cifs_io_request {
 	struct netfs_io_request		rreq;
 	struct cifsFileInfo		*cfile;
 	struct TCP_Server_Info		*server;
+	pid_t				pid;
 };
 
 /* asynchronous read support */
@@ -1505,7 +1506,6 @@ struct cifs_io_subrequest {
 		struct cifs_io_request *req;
 	};
 	ssize_t				got_bytes;
-	pid_t				pid;
 	unsigned int			xid;
 	int				result;
 	bool				have_xid;
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 25e9ab947c17..595c4b673707 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1345,8 +1345,8 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	if (rc)
 		return rc;
 
-	smb->hdr.Pid = cpu_to_le16((__u16)rdata->pid);
-	smb->hdr.PidHigh = cpu_to_le16((__u16)(rdata->pid >> 16));
+	smb->hdr.Pid = cpu_to_le16((__u16)rdata->req->pid);
+	smb->hdr.PidHigh = cpu_to_le16((__u16)(rdata->req->pid >> 16));
 
 	smb->AndXCommand = 0xFF;	/* none */
 	smb->Fid = rdata->req->cfile->fid.netfid;
@@ -1689,8 +1689,8 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	if (rc)
 		goto async_writev_out;
 
-	smb->hdr.Pid = cpu_to_le16((__u16)wdata->pid);
-	smb->hdr.PidHigh = cpu_to_le16((__u16)(wdata->pid >> 16));
+	smb->hdr.Pid = cpu_to_le16((__u16)wdata->req->pid);
+	smb->hdr.PidHigh = cpu_to_le16((__u16)(wdata->req->pid >> 16));
 
 	smb->AndXCommand = 0xFF;	/* none */
 	smb->Fid = wdata->req->cfile->fid.netfid;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 16fa1ac1ed2d..45c860f0e7fd 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -178,14 +178,8 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	pid_t pid;
 	int rc = 0;
 
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
-		pid = req->cfile->pid;
-	else
-		pid = current->tgid; // Ummm...  This may be a workqueue
-
 	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
 		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
 		 subreq->transferred, subreq->len);
@@ -199,7 +193,6 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	}
 
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-	rdata->pid = pid;
 
 	rc = rdata->server->ops->async_readv(rdata);
 out:
@@ -236,12 +229,15 @@ static int cifs_init_request(struct netfs_io_request *rreq, struct file *file)
 
 	rreq->rsize = cifs_sb->ctx->rsize;
 	rreq->wsize = cifs_sb->ctx->wsize;
+	req->pid = current->tgid; // Ummm...  This may be a workqueue
 
 	if (file) {
 		open_file = file->private_data;
 		rreq->netfs_priv = file->private_data;
 		req->cfile = cifsFileInfo_get(open_file);
 		req->server = cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
+		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
+			req->pid = req->cfile->pid;
 	} else if (rreq->origin != NETFS_WRITEBACK) {
 		WARN_ON_ONCE(1);
 		return -EIO;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index e213cecd5094..2ae2dbb6202b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4621,7 +4621,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	io_parms.length = rdata->subreq.len;
 	io_parms.persistent_fid = rdata->req->cfile->fid.persistent_fid;
 	io_parms.volatile_fid = rdata->req->cfile->fid.volatile_fid;
-	io_parms.pid = rdata->pid;
+	io_parms.pid = rdata->req->pid;
 
 	rc = smb2_new_read_req(
 		(void **) &buf, &total_len, &io_parms, rdata, 0, 0);
@@ -4873,7 +4873,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		.length = wdata->subreq.len,
 		.persistent_fid = wdata->req->cfile->fid.persistent_fid,
 		.volatile_fid = wdata->req->cfile->fid.volatile_fid,
-		.pid = wdata->pid,
+		.pid = wdata->req->pid,
 	};
 	io_parms = &_io_parms;
 


