Return-Path: <linux-nfs+bounces-20814-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOpcH/0p2WlumwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20814-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 18:49:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 606F63DAB1A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 18:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55373301818F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8150C3E1CFB;
	Fri, 10 Apr 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOSIaKP5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9703E0C53
	for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839696; cv=none; b=k+YQ2bYSejVCet37aWytMiTJEAfNLCRUBFmOdSdcHKITsgEu8alTcVzjVqTdk3WN9D7jGt8haDOtdNuXDWghVrx+Tp+Fn/GL2lXwMloqdWw9pgnftQyWJKumtno6TgA6Z4RlGvzsV5mObn6MW9dVmQ8QQo4JJuqX4SQgIENct9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839696; c=relaxed/simple;
	bh=AnjWyPTARuSrrXsBNovzJ6YXQUQoElBg2cQexkfAVs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mcr7ImIXKp7i/zDxByUZxwPQwadKziEcQ6+598Fvu/IjUyGsmXdwPuQG8wJsDksNWwPfyXVP3I9WLdCjQFyPS3JSvW+iN0Nfwx8pxsKiobVyOKXa82JcTqcL/wM122mO16AYsQvf72OFaFoLBs1IUVisB6f8etP4/HzZfQT3KDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOSIaKP5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775839691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mpF+r6go6ScizDBfkJmz2uShNhgWaUTF9w5KVUWz1nY=;
	b=fOSIaKP57MOAit61oDhv6xIbf/C6VIQOWtmn7JNjO5L/PMPtgHoDEbRRx4t7qqbp4XcknL
	xJA4m2C9oOy472Bm1MZQGKAnYDhiov9VBFTwuNhM4IAwwILmml7CCZgvd3mJMSWSOrbyyU
	uC9dhM8W8uXQn9BhpNcxqjuD8XF97GU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-jJwiclgIPtej_xPaUG1zEw-1; Fri,
 10 Apr 2026 12:48:08 -0400
X-MC-Unique: jJwiclgIPtej_xPaUG1zEw-1
X-Mimecast-MFC-AGG-ID: jJwiclgIPtej_xPaUG1zEw_1775839687
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 701721956048;
	Fri, 10 Apr 2026 16:48:07 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFCE91800451;
	Fri, 10 Apr 2026 16:48:06 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4: retry GETATTR if GET_DIR_DELEGATION failed
Date: Fri, 10 Apr 2026 12:48:05 -0400
Message-ID: <20260410164805.57887-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20814-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 606F63DAB1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, getting a directory delegation is opportinistic and gets
added to an existing GETATTR that's trying to retrieve some needed
attributes. However, GET_DIRDELEGATION can fail and that currently
causes a GETATTR to fail and an error is propagated to the user.

Instead, the original GETATTR should be retried without requesting
a directory delegation. Also, now chosing to clear asking for
the direct delegation for this specific inode.

Fixes: 156b09482933 ("NFS: Request a directory delegation on ACCESS, CREATE, and UNLINK")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

-- Note: instead of clearing NFS_INO_REQ_DIR_DELEG perhaps turning
off directory delegations for the whole server is appropriate but
I wasn't sure.
---
 fs/nfs/nfs4proc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 768de9935ff1..6632d06556a5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4469,6 +4469,13 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 		case -ENOTSUPP:
 		case -EOPNOTSUPP:
 			server->caps &= ~NFS_CAP_DIR_DELEG;
+			break;
+		case -NFS4ERR_INVAL:
+		case -NFS4ERR_IO:
+		case -NFS4ERR_DIRDELEG_UNAVAIL:
+		case -NFS4ERR_NOTDIR:
+			clear_bit(NFS_INO_REQ_DIR_DELEG, &(NFS_I(inode)->flags));
+			status = -EAGAIN;
 		}
 	}
 
@@ -4490,6 +4497,7 @@ int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 		default:
 			err = nfs4_handle_exception(server, err, &exception);
 			break;
+		case -EAGAIN:
 		case -ENOTSUPP:
 		case -EOPNOTSUPP:
 			exception.retry = true;
-- 
2.52.0


