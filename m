Return-Path: <linux-nfs+bounces-22491-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UrFPHob5Kmo90QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22491-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:08:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7AD674504
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:08:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M1AXUj7r;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22491-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22491-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE12834731ED
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6804DC535;
	Thu, 11 Jun 2026 17:51:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06B481641;
	Thu, 11 Jun 2026 17:51:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200268; cv=none; b=LNt0+7rhKXHjRi7JXZ6vvRS/MTBOJ/qj0exh0vvDXKT2ddtlE3T3xnjLaNh8Pl8nLf/6xAn0z5UP80hdqrYa5PI1ANc87RrFJZ4gT9VpZBHej2Ai5LiBNJ/DtwBmn+Af2QtmGGHdsAbr10awceyNlBXQZ7m0UeaDZr3D2HD/2Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200268; c=relaxed/simple;
	bh=b4hbzahPlTlpr/FchnlHPCHN8IuOc196YmLM1DdFzKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0Vq+vDAUghZBWzneyJ1P0MeeWx0fwmR+V5St+nZ/BCOj8Vvj3a+kOfS5sXzKstrieDYB+D8Pfmm3H0IABlN0meinw6CYuJa5rOVJsIjrobLQkmKuPZg+Q7TqxutbLP9l+dVa+wYKUa5QWk7Lyk5Hg3Ne22uMtyUkzSbuAFd//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1AXUj7r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1471F00898;
	Thu, 11 Jun 2026 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200266;
	bh=2+hfBNcjXxvB8tFKrEepFnMvRobBM/QjiUotS5EyytM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M1AXUj7r+x9OiRGkH+oaBJAX8kG/Mf42VkwK4aFlYrzK/EBUZVxqVdo8srsBnmqOU
	 4vGynEwC0J+r95VlEEgD6dZwuXuSh0ypEFaYKTqWGQkb4NIHsazK5ggQVMB0JJ5xG4
	 k0+stQfOSzIgKuITVk8cm8Q9pftoIKvRZ1UN2Kyp5OKCF0suq90pZkFjHNDbwsVHQJ
	 9FOtj8dGXoI2RPf1PqTrGkmt85jKHZqxUF23L1gT6+Rs9vF6YcPiNtvtGADSFe0AEU
	 SrLS1KaVNOboTZrP5hia03gvUo3eg6QSIITC6hAVOP0Ihe11NYvl3H1NvsbORbC8QU
	 nvICqcpqVL+bg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:24 -0400
Subject: [PATCH v6 18/20] nfsd: properly track requested child attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-18-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
In-Reply-To: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3832; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=b4hbzahPlTlpr/FchnlHPCHN8IuOc196YmLM1DdFzKI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVkeo5dXf9jKkyKavEM6bM7iw81vSM1xCGI4
 R+MEnDJjSGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1ZAAKCRAADmhBGVaC
 FRgwEACmWYwPrkOAKjA66JfwqwPilvsZvp9NFYHfSv3pBH8o9heWcCgvFA78CD4S1uwxB18YIlI
 VAcNXBStSpg26FRBYqY1CfpWYD1wWIqx12ig4E04Xw33hwvM9z0AyNUrnzuEMnr3YucyQW0Xkn+
 ylttzuuFUm+2vMMG9A4M2tEWCJ3e+EmmY5mdtSfeeWcHYEj1cE77+wCeCKRLZQuGrTGLJOVR542
 VZbpAr8TJp0nSCBGoA87aXA6xdoXraDWkZUXJjhi85I6VaPwbeVyYlCps5cHifhOvlaowq+Xx45
 66Hqz7nAFJLxKPGRZ/TmHGL/G3CEw4wy/fQRZd5vuEuql0e/jajJ3UuaUSUf2pYKmkw09FHSt7R
 EXAkreapR2F5C7OR9xHOJa2QRpHyo9WkHhL6HgLUyfjM7XcpJqhoAXV4YKr1p0Kxc5R3B1MGJAp
 0L38+81OY5LeZjz+qbrKvz+w+s5v3uUWNi5/36/OUCkpXMgqlAcQMvvQYs8ZlSox2SG+w1IZgre
 tlQzkCRAXWQbfIIFRkyCqzIIYn7Bzw1IgYdjQwTHlnMKyw4W2nyaYqXKWZ3RLKMQplFyKvVHV/a
 VTIEZcqTF1QxsS1Mq+I6wWo2CrtqHnRfmda4LVF/JEkrZw/+9EfUd12jmtYd+CTyC4SzE9Eqfaw
 v+dWEP/cR/Txg2g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22491-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA7AD674504

Track the union of requested and supported child attributes in the
delegation, and only encode the attributes in that union when sending
add/remove/rename updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  2 ++
 fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
 fs/nfsd/nfs4xdr.c   | 15 ++++++---------
 fs/nfsd/state.h     |  3 +++
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 29f7339dc220..caec82e77081 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2577,6 +2577,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 
 	gdd->gddrnf_status = GDD4_OK;
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
+	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
+	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index aa99783ce901..0e6e008c121e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9930,6 +9930,21 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	return status;
 }
 
+#define GDD_WORD0_CHILD_ATTRS	(FATTR4_WORD0_TYPE |		\
+				 FATTR4_WORD0_CHANGE |		\
+				 FATTR4_WORD0_SIZE |		\
+				 FATTR4_WORD0_FILEID |		\
+				 FATTR4_WORD0_FILEHANDLE)
+
+#define GDD_WORD1_CHILD_ATTRS	(FATTR4_WORD1_MODE |		\
+				 FATTR4_WORD1_NUMLINKS |	\
+				 FATTR4_WORD1_RAWDEV |		\
+				 FATTR4_WORD1_SPACE_USED |	\
+				 FATTR4_WORD1_TIME_ACCESS |	\
+				 FATTR4_WORD1_TIME_METADATA |	\
+				 FATTR4_WORD1_TIME_MODIFY |	\
+				 FATTR4_WORD1_TIME_CREATE)
+
 /**
  * nfsd_get_dir_deleg - attempt to get a directory delegation
  * @cstate: compound state
@@ -9998,6 +10013,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		dp->dl_stid.sc_export =
 			exp_get(cstate->current_fh.fh_export);
 
+	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
+	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
+
 	/*
 	 * NB: gddr_notification[0] represents the notifications that
 	 * will be granted to the client
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 15ccd54ffdb6..1e3c360c06cd 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4271,18 +4271,15 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
 	args.change_attr = nfsd4_change_attribute(&args.stat);
 
-	attrmask[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
-		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FILEID;
-	attrmask[1] = FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS | FATTR4_WORD1_RAWDEV |
-		      FATTR4_WORD1_SPACE_USED | FATTR4_WORD1_TIME_ACCESS |
-		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
+	attrmask[0] = dp->dl_child_attrs[0];
+	attrmask[1] = dp->dl_child_attrs[1];
 	attrmask[2] = 0;
 
-	if (setup_notify_fhandle(dentry, fi, nf, &args))
-		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+	if (!setup_notify_fhandle(dentry, fi, nf, &args))
+		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
 
-	if (args.stat.result_mask & STATX_BTIME)
-		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
+	if (!(args.stat.result_mask & STATX_BTIME))
+		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
 
 	ne->ne_attrs.attrmask.count = 2;
 	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d912e3d04dd7..0763893bfd48 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -297,6 +297,9 @@ struct nfs4_delegation {
 	struct timespec64	dl_atime;
 	struct timespec64	dl_mtime;
 	struct timespec64	dl_ctime;
+
+	/* For dir delegations */
+	uint32_t		dl_child_attrs[2];
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.54.0


