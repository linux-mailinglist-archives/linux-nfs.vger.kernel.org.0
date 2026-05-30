Return-Path: <linux-nfs+bounces-22105-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAteMiXkGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22105-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E7560CF0A
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 626E23038548
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF273C8C60;
	Sat, 30 May 2026 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfT8II0r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929573C2BAC;
	Sat, 30 May 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147184; cv=none; b=J/QAwXr8M5j2BK6ZyNTs0h6Yvz/0XYyCjX+3nReK8BhFgwpDE8fc2CMhIVyw2DYdSH170+0tRCEFYbwjH4b3mS0GxwsWoW3MA4sIDdx1y6qCPJTyPcQpxXykTD5HNqU0VN9hLpz+aHTjwJ1FEAaJ07ty03PaZIqVd5bCy7U53WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147184; c=relaxed/simple;
	bh=yIZRNwjDCyh2HZes6RC2XeEH/IL+x6J+MIjmstzfZNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qaer4NUn2EbWWuZKYRH18Zd67MUEtlQcvWqVFwCklgaXkxVrswM37W0mZVMtrtslyyOlZsLFEUvsoUA9E6FUNc3FytC19H5FojrIOOysagRPAFFIZcacfp0VeHejYNl/BAhowUH5KeLCiaRj85u7CNxRWDfWRWyS9P0Y14V0h4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfT8II0r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0161F0089B;
	Sat, 30 May 2026 13:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147183;
	bh=vdCQo/MlgpG3cQHwUX7abR52uTne4QlqANsOSZIJmGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YfT8II0rli/P42zXSc4UjNfIZxp6ThIYkT5JDoI2XwKVWGjonMe2TNvBxFZaN19OR
	 qyZAM5BExBZeFuK0rNtdi7hjuTATknRFKyfzFgUCb0G7yNGUCMiEBODELw3tCpN68x
	 89tmBN2tAJojyXgqE00mhXyppdaKmOBP2cvgL8dcUU86Nxvo5b+R0Qd5T7RcpiMVJH
	 iYXbqbGbWVTDvPnv9CJZIxEknnwObVFbeDLlOX2zeV4+JXD6unmSNLBv4lPCwwzErW
	 coe5QJFgLLimYNHl4NanzWWgpirKRACOrYU9U57i0RCqoNrHczONuuIf3kjbkvYbBB
	 +0zKmPR61HnrA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:23 -0400
Subject: [PATCH v2 7/9] nfsd: fix partial-write detection in
 nfsd_direct_write
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-nfsd-fixes-v2-7-f27e8eb4d974@kernel.org>
References: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
In-Reply-To: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2462; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IQbABHhBX2jwO/cRadiSto8B2Or6VNR8U8NOL2nNkTM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPiHImNW5NnoBhOWp28KxD1i1S/Hp3X70lOz
 QmbH0ZrJHKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj4gAKCRAADmhBGVaC
 FXKID/92WtmJp44etI2SZRH+u/CbJTbe/pc3Ogem7MFrJAOTLWVKuWGNVL16oveOZgEU39KrUPl
 PZAb7QXPn7G+IBvPUNC0oPNNNCdNrozH9+m2ZPx2XZ3N7pphF3eJ/a8FLIocpe33SJN4T/yKCjA
 XszqPuRdeBlK+tnqAP+951jGF7wPwo+AXLCaCdF+xsZnxEi+1d3ujURRsWpnvfoXPVlGXslR4T9
 HoK3mCFgk0QrTVquHYRDQ4Wia68wJhK/CnMJ5tuRqu5OOYLxIn5ajbK59jlqapEGrWRY3dMt+E6
 eYBtItL4JzRX5dX5Vcv8Tq+RHg9/i8izaUEgtTz4RWHRezJtn/DtE1hFBhysdwC/8jLr3Hd4scL
 32QupMhBpJFcoLgCk3jua7kiyzZJuncSoKQrIHTZ8G06TaoFAmXNU70/KMI8c0qTX2/I7ahPZr9
 DeE6PM2Qw2Skkswl0jnT3kTiTptEpKdVMFL5H3zfCtD/2fyO4naSBoB/OJyre0/JrlxvuikSiTH
 9wUrYxUKwZxsorE9s0TWczSWG11NSojSKuBIQXxlw3Yt1ilnhthfJyxHykaAngywV63ovaxx/ji
 LK+cgC4vAmZECBQxXuqOnm1HHI8AebDsO8tRIKo1m72M5SdGbr8Hll+zv00c7bes8l+zJ71d4iV
 hk1l0iM88En3Rvg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22105-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 81E7560CF0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd_direct_write() walks a list of write segments and, after each
vfs_iocb_iter_write(), tries to detect a short write so the loop can
stop before placing the next segment at a wrong file offset:

    host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
    if (host_err < 0)
            return host_err;
    *cnt += host_err;
    if (host_err < segments[i].iter.count)
            break;	/* partial write */

vfs_iocb_iter_write() runs the iter through ->write_iter(), which
advances the iter by the number of bytes written. By the time the
check runs, segments[i].iter.count is the residual, not the original
request length:

    before write_iter: iter.count == original_len
    after  write_iter: iter.count == original_len - host_err

The condition then reduces to host_err < original_len - host_err, so
the break fires only when less than half of the segment was written.
Any short write completing between 50% and 99% of the segment slips
through; the loop advances to the next segment with kiocb->ki_pos
only bumped by the short amount, writing the next segment's payload
at the wrong offset and over-reporting *cnt to the NFS client.

Snapshot the segment's byte count before the write and compare
host_err against that snapshot so any short write breaks the loop.

Fixes: 06c5c97293e3 ("NFSD: Implement NFSD_IO_DIRECT for NFS WRITE")
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/vfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 07a9a68408ba..62b56d73432a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1380,6 +1380,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct file *file = nf->nf_file;
 	unsigned int nsegs, i;
 	ssize_t host_err;
+	size_t expected;
 
 	nsegs = nfsd_write_dio_iters_init(nf, rqstp->rq_bvec, nvecs,
 					  kiocb, *cnt, segments);
@@ -1401,11 +1402,13 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				kiocb->ki_flags |= IOCB_DONTCACHE;
 		}
 
+		expected = iov_iter_count(&segments[i].iter);
+
 		host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
 		if (host_err < 0)
 			return host_err;
 		*cnt += host_err;
-		if (host_err < segments[i].iter.count)
+		if (host_err < (ssize_t)expected)
 			break;	/* partial write */
 	}
 

-- 
2.54.0


