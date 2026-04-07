Return-Path: <linux-nfs+bounces-20720-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PlwM16Y1WmG7wcAu9opvQ
	(envelope-from <linux-nfs+bounces-20720-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 01:50:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A033B58A9
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 01:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D96B301021E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B66389469;
	Tue,  7 Apr 2026 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OihUQ3ap"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F2387571
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605848; cv=none; b=LGGYbOtCkUfS2ZroRIVsCBia6GbZn4yl7vS+sCm5HhgMP4zsq0NAUWY6xphRcSjIpnVHMd6nenGmZnqkhIUNZodLhgoYR+HHimXSt0GaeHxJixsaY/W92lhw8bAYd+LgzuS9xBet5k5ipiZ76FwZDgP2rrdtya8oUysxgYZ30oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605848; c=relaxed/simple;
	bh=54TdEqwkwI2zf/uIsAECf6LKBvi5454i8q5nJaib6g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTI0iG073KDgt8aBli2T27LqwMJ8oC6SRA9r7a7QHiUkx8+rdKxpaerHTNUvLj78M0+5nuo+VVEwuGb36dVazVQjkn7D/GVwSq5DQgggr799rreqIg4x2huYuswqfnmgq17dMq1pun7kG5rGpk4qvLanuLBeyXK5Y2mJMpTnor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OihUQ3ap; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775605845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1rm6SbriEzHJihvGY5Lnm7Hv377VlqBSkXDVwsrgF6I=;
	b=OihUQ3apPhw6vVM/EuuVRbVoP/q0P5DLC1sEIGsbsKjjAGT1xMi2S5ESqJ1BPIaRdeDQwB
	pYV8aRKIoIAXALyfMlcoOQHwfNybW/gJAWga7M3Fjd96yvu428jyRTLEcKN9MWAoc5ChPL
	Y4zhsYNtYo5iKcJoOJLcPjU+a1k1mUs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-ycRokK3kMJGkmFvXK_frxw-1; Tue,
 07 Apr 2026 19:50:42 -0400
X-MC-Unique: ycRokK3kMJGkmFvXK_frxw-1
X-Mimecast-MFC-AGG-ID: ycRokK3kMJGkmFvXK_frxw_1775605841
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A349195608C;
	Tue,  7 Apr 2026 23:50:41 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.80.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3F851955D84;
	Tue,  7 Apr 2026 23:50:39 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 0/3] nfsd update mtime/ctime on CLONE/COPY with delegated attritutes 
Date: Tue,  7 Apr 2026 19:50:35 -0400
Message-ID: <20260407235038.55749-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20720-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D0A033B58A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

generic/407 is failing in presence of delegated attributes and this patch series 
explores the solution where the CLONE compound returns updated mtime/ctime
in the GETATTR op in the compound.

It's broken into several pieces as I consider asynchronous copy update the trickest
because the copy thread currently have no dentry to call notify_change() on. And
if we are going to keep a copy of it while the copy is running we probably need to
take a reference on it (which I attempt to do).

An outstanding question I have is whether or not a CLONE/COPY operation is supposed to
also update the atime on the source file? But also atime for the dest file as well?
I'm updating both ctime and mtime for the destination (though Jeff only suggested
mtime and perhaps I'm missing something in updating ctime as well but I thought it 
was appropriate). 

COPY was tested by modifying the linux client to send a GETATTR in the COPY compound.
Whether or not the client should add the GETATTR to the COPY compound is yet another
question I have but I guess it would be for Trond.

Olga Kornievskaia (3):
  nfsd: update mtime/ctime on CLONE in presense of delegated attributes
  nfsd: update mtime/ctime on synchronous COPY with delegated attributes
  nfsd: update mtime/ctime on asynchronous COPY with delegated
    attributes

 fs/nfsd/nfs4proc.c | 38 +++++++++++++++++++++++++++++++++++++-
 fs/nfsd/xdr4.h     |  1 +
 2 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.52.0


