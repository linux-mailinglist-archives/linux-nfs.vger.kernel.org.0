Return-Path: <linux-nfs+bounces-11398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E9DAA8146
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509A25A6948
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085A27C15F;
	Sat,  3 May 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWXwgEFU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C7627C156;
	Sat,  3 May 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285113; cv=none; b=id78diAUhOJt7hp2WtGLfh474onOEnFRYk1IT1Gd/KK+nmMsR9dPktx1CPf83QXN2qvDDt8Rq3REbUAj3t+8Qe+9VQKruFV1dWJN2xu72YrzP471pJCEitj2B4k/knqJsuF52gYy82+FIwl8+A9mmEcuXg1BtUIRYSssEZSFyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285113; c=relaxed/simple;
	bh=OiUW+mvHETW7R0EmP48dKkSegRZ9RvbZdCGlAp34BEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9IrBBimsjXmBzmWbrZdhwwdP4weZ1UdBQWH3bDJLdg6sKEdWsrtOVU+qn7cUEpjdfKCAAhtsfvCqKPrlRFdUyL6ZZ2a9lFzK2KpZ94I0HLeF9wdw2XpckwHLXqhvpwwUlqCqjZSo5jOq2jjUEHTEAcxQvcGqvwobf7MtaA8f9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWXwgEFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0F9C4CEE9;
	Sat,  3 May 2025 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285113;
	bh=OiUW+mvHETW7R0EmP48dKkSegRZ9RvbZdCGlAp34BEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QWXwgEFUC5r8egLhXdNuLCaysIU412Kg5kXRmG2UxcidWMC8NSGcdJlPiOhxC982p
	 l+JxB1JDJWqNP9jhgpnWAS/kgwL6/0iUyTuW+Bgnj5xN/DV7yhg1xHR2i0kaIvRZTa
	 VaUMTfROSDlLfWTu3m9dbMfLdRXKf/MqZxFW776jriYo6xLV7kzXd9T5WhViuyToJ8
	 0MVunsFijVjsdG4SMNqSvbOcU0+BufNBD3zdvKbBt1QMq2I/n86I0PTcXNwWAWiJGy
	 PKncv/3xvlI/UmoH9KqhXqY54D7e7p9EeaXICdR3TXmari5AYaqQaRdEzdvs5oXRQE
	 HYIA2I422OKzQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:24 -0400
Subject: [PATCH v3 08/17] nfsd: add tracepoint to nfsd_rename
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-8-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OiUW+mvHETW7R0EmP48dKkSegRZ9RvbZdCGlAp34BEU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjItlox3v5dU2m84jXBVHW5L8OWZhiW0mp4qy
 iqesHpvXV+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLQAKCRAADmhBGVaC
 FXB6EACeoh+deRVDFYq/qM7rDVKUkYP/lruvNus2ELmqjDfIgoy9ukeWQDzxZb6VEGRgjzuU8Zr
 Aet6N3yoMO2jd+8Vc7GMpaSTu8one9v3nx8hL+WApMaQDohDms3ScrP8WbKyp/lmFX82X8xJqbh
 iyQI6bZPWD+R5SKeETOiGx+aTW81GIhZEJuJOxKlC1V3a4Es6HvzqeP1E2VdVJ2mMz6TFxDiKK9
 F7NK0MGcRHiWunaWcslzUoJCkwTA8GgHlB0x/CRL9Dk/+R4lx7q31EjPjGsg1W92abRD97UoWO5
 MP3iw+tRB2xxw7saQZf4tN+buKUeXu+WoOJs+bIme5EgAZcIzMGABdkvh0J9yIl4JpOlOgYezRE
 kQxukzthMMvlTunZJHwBEM+FXUahiP+gdaOc2acwnFN2znxqIr0/ILBxZGiFgw1NMTdNq6TCAHu
 +bKj8Z+c5A/3XhAO8lrxwr/y7uX3SUe67Mjj4/keP8Xjt0vxB0qflfzYiQvyN1vAgEDYAcE5UMh
 GGPxgOYtsHjbWVtc4Npf96tHAm+4zN1rU+d1ONM5uyblVGXSYUvwoiYasxOvZNaEUsiGirsRzMs
 plkDKod7tZqk9kEtoU5j/W7Qr+Yf79I6nAnaaLwSLDD6KxW2I5jr9CqvxpsoEn6TMEEuz8T6C91
 uXIl9wkfAxEpVOQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 28 ++++++++++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 24e3c32d9db48bd8bf51eb41dda46b889dfa9e8d..4e873ceca602098d2899c5ff2deee610ddb670a0 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2484,6 +2484,34 @@ TRACE_EVENT(nfsd_vfs_unlink,
 		  __entry->xid, __entry->fh_hash,
 		  __get_str(name))
 );
+
+TRACE_EVENT(nfsd_vfs_rename,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *sfhp,
+		 struct svc_fh *tfhp,
+		 const char *name,
+		 unsigned int namelen,
+		 const char *tgt,
+		 unsigned int tgtlen),
+	TP_ARGS(rqstp, sfhp, tfhp, name, namelen, tgt, tgtlen),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, sfh_hash)
+		__field(u32, tfh_hash)
+		__string_len(name, name, namelen)
+		__string_len(tgt, tgt, tgtlen)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->sfh_hash = knfsd_fh_hash(&sfhp->fh_handle);
+		__entry->tfh_hash = knfsd_fh_hash(&tfhp->fh_handle);
+		__assign_str(name);
+		__assign_str(tgt);
+	),
+	TP_printk("xid=0x%08x sfh_hash=0x%08x tfh_hash=0x%08x name=%s target=%s",
+		  __entry->xid, __entry->sfh_hash, __entry->tfh_hash,
+		  __get_str(name), __get_str(tgt))
+);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index bd19e5926ef198279e39ac9ef1873eab289cb4a0..9fd5f7d277b452e12a2d5854b9d3ff79418a8818 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1865,6 +1865,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	int		host_err;
 	bool		close_cached = false;
 
+	trace_nfsd_vfs_rename(rqstp, ffhp, tfhp, fname, flen, tname, tlen);
+
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
 	if (err)
 		goto out;

-- 
2.49.0


