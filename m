Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E12F12D169
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2019 16:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfL3PUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Dec 2019 10:20:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41595 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfL3PUb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Dec 2019 10:20:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so33617215ljc.8;
        Mon, 30 Dec 2019 07:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=FkOelivhlR8vsUum4XrcQmOy/XHM9k5BZJl+I/MmXUs=;
        b=MaS0CJ3FaCeHMfRsMUuffIRYl9RTexnDxiOPNBRtFVT0c/Zv6H/e2F+scDg08zanjD
         3hM7e3gFcrFM3/99Au/aHQn94sE0kAh9dx73ZRx17xRZaM4XNDP7u3DAlORywK5GpuyK
         /+BTsUUPEfnrTG/OaeIUSFU6t4f9EAMHWoqr/+R5vRnGVrTa/FRLtx0ozXeM/+OkGTWb
         xR/nxVkZYyqGp/uMfFtEB4Vy9938OBlgX/LlbfrGmzFUx16oza2+KKOw4QiFVBf8srJB
         2RJMv2MUBBqLIdLyTp5+tokjzGs3ERvPVy/jchkLx5dkcDfvlyIA9VdQVVzIB59GIcqO
         lYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=FkOelivhlR8vsUum4XrcQmOy/XHM9k5BZJl+I/MmXUs=;
        b=RM8DgbQuO6mp61TRBHX6rU9aWJA97ghnwdSpBzRABPxNwOfEHCGeBOSQ5dyS/PZv3g
         lkqAs9xJfZZg8OtiAmf28MhRSo+9JYhMZiMfUrFR8v6j3JB2W0uAghpxwlcSczXnAWze
         HBV8YOSKDjZQ4P/KizMe3Q/H9AW8pcMbF8LkmXVB9sBspN04OFG24CUHiIcJd+DGxgHy
         D87jdiD561yORg1uY7weD50zBp2EuT4EJGRzyvQQ/BTE2Pbbm6JYZd9uZZmuWzOFFjoq
         OtANnEHDzFRrsZhyyogR5H/8m5pfTKtMDcyw2jQT8I8u3yXvpS7OohHPLO20V+eT3h2k
         yLSQ==
X-Gm-Message-State: APjAAAUf8Y2hKQCh2kZsQeM49e9LNUKPoJT3/58oej6kguQs0f931yj/
        hXrpvCtlJ8xDEG2HnXGiYgd9ypBSRDX7lw==
X-Google-Smtp-Source: APXvYqyepb4jHBm/pR+s3wWeEi1r57pjmUro1coUKO564ZHhaqKGAD7IZaluz0fCjdcF7JqKLOEfzQ==
X-Received: by 2002:a2e:b044:: with SMTP id d4mr30453850ljl.158.1577719228230;
        Mon, 30 Dec 2019 07:20:28 -0800 (PST)
Received: from loulrmilkow1 (227.46-29-148.tkchopin.pl. [46.29.148.227])
        by smtp.gmail.com with ESMTPSA id t9sm18623784lfl.51.2019.12.30.07.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 07:20:27 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>
Cc:     "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals
Date:   Mon, 30 Dec 2019 15:20:25 -0000
Message-ID: <025801d5bf24$aa242100$fe6c6300$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdW/I2auAYB5hyQWQDmn+e9BiY7hDA==
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Robert Milkowski <rmilkowski@gmail.com>

Currently, each time nfs4_do_fsinfo() is called it will do an implicit
NFS4 lease renewal, which is not compliant with the NFS4 specification.
This can result in a lease being expired by an NFS server.

Commit 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
introduced implicit client lease renewal in nfs4_do_fsinfo(),
which can result in the NFSv4.0 lease to expire on a server side,
and servers returning NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.

This can easily be reproduced by frequently unmounting a sub-mount,
then stat'ing it to get it mounted again, which will delay or even
completely prevent client from sending RENEW operations if no other
NFS operations are issued. Eventually nfs server will expire client's
lease and return an error on file access or next RENEW.

This can also happen when a sub-mount is automatically unmounted
due to inactivity (after nfs_mountpoint_expiry_timeout), then it is
mounted again via stat(). This can result in a short window during
which client's lease will expire on a server but not on a client.
This specific case was observed on production systems.

This patch makes an explicit lease renewal instead of an implicit one,
by adding RENEW to a compound operation issued by nfs4_do_fsinfo(),
similarly to NFSv4.1 which adds SEQUENCE operation.

Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/nfs4proc.c       |  4 ++++
 fs/nfs/nfs4xdr.c        | 13 +++++++++++--
 include/linux/nfs_xdr.h |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..6d075f0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4998,12 +4998,16 @@ static int nfs4_proc_statfs(struct nfs_server *server, struct nfs_fh *fhandle, s
 static int _nfs4_do_fsinfo(struct nfs_server *server, struct nfs_fh *fhandle,
 		struct nfs_fsinfo *fsinfo)
 {
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_fsinfo_arg args = {
 		.fh = fhandle,
 		.bitmask = server->attr_bitmask,
+		.clientid = clp->cl_clientid,
+		.renew = nfs4_has_session(clp) ? 0 : 1,		/* append RENEW */
 	};
 	struct nfs4_fsinfo_res res = {
 		.fsinfo = fsinfo,
+		.renew = nfs4_has_session(clp) ? 0 : 1,
 	};
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_FSINFO],
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 936c577..0ce9a10 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -555,11 +555,13 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define NFS4_enc_fsinfo_sz	(compound_encode_hdr_maxsz + \
 				encode_sequence_maxsz + \
 				encode_putfh_maxsz + \
-				encode_fsinfo_maxsz)
+				encode_fsinfo_maxsz + \
+				encode_renew_maxsz)
 #define NFS4_dec_fsinfo_sz	(compound_decode_hdr_maxsz + \
 				decode_sequence_maxsz + \
 				decode_putfh_maxsz + \
-				decode_fsinfo_maxsz)
+				decode_fsinfo_maxsz + \
+				decode_renew_maxsz)
 #define NFS4_enc_renew_sz	(compound_encode_hdr_maxsz + \
 				encode_renew_maxsz)
 #define NFS4_dec_renew_sz	(compound_decode_hdr_maxsz + \
@@ -2646,6 +2648,8 @@ static void nfs4_xdr_enc_fsinfo(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
 	encode_fsinfo(xdr, args->bitmask, &hdr);
+	if (args->renew)
+		encode_renew(xdr, args->clientid, &hdr);
 	encode_nops(&hdr);
 }
 
@@ -6778,6 +6782,11 @@ static int nfs4_xdr_dec_fsinfo(struct rpc_rqst *req, struct xdr_stream *xdr,
 		status = decode_putfh(xdr);
 	if (!status)
 		status = decode_fsinfo(xdr, res->fsinfo);
+	if (status)
+		goto out;
+	if (res->renew)
+		status = decode_renew(xdr);
+out:
 	return status;
 }
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 72d5695..49bd673 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1025,11 +1025,14 @@ struct nfs4_fsinfo_arg {
 	struct nfs4_sequence_args	seq_args;
 	const struct nfs_fh *		fh;
 	const u32 *			bitmask;
+	clientid4			clientid;
+	unsigned char			renew:1;
 };
 
 struct nfs4_fsinfo_res {
 	struct nfs4_sequence_res	seq_res;
 	struct nfs_fsinfo	       *fsinfo;
+	unsigned char			renew:1;
 };
 
 struct nfs4_getattr_arg {
-- 
1.8.3.1


