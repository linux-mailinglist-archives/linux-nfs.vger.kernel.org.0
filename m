Return-Path: <linux-nfs+bounces-9235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A5EA12955
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 18:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223A53A30A7
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C750155C96;
	Wed, 15 Jan 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZVLb0lV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD915957D
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960461; cv=none; b=QR0kTg0Y8wjTm+coOv9wJ6/0hjCGlatEGrqQqHcfWccYUs6MnjhKPbQoTvaASVgXMLFeMqxPpiAHeEN6SeZzgoxEG2/vsElm3E4MRuk+siE73vjtKFt669++p19ekhT6810/0ncCoERPerOwt0p5MKi2oa7hhqAmL0vyFnNhgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960461; c=relaxed/simple;
	bh=T5eMvrrLLc1rR+IiAjBxHgFC+OhvsIJ+6A2BpPwJJl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NG1cuYdmSkYq0ILDbm8QIMiorLKCGfBjUurTlsm+j9d+p+xBYLEu695KK8ptVTqI7JMxdMXHg3zJht4YYwUq/s8nGFZv1SlIFRT+6baSnmPn3bJBy1fBeUdaIZLlE4KOEb2XQkap8MW4vRN7wy+TpVDdZTk9yXkBwh5SVG3te50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZVLb0lV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736960457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vktX/UYNAyEWeF68kBbqe7pZFMmcUe0Ay7931QAzz0=;
	b=eZVLb0lVs8uPz74Mjxo265Xo0g8WOprPRvAAqfFooW54RxPH1aeRrgusp1ftDFaIuM8jF6
	eXxXakq5qD725Gc0ip4D52RWvqFU8WxtHlB52y/b4pmuo4MF+pUzswn3pYtV5JDQhmgU9e
	FX7nbEDfSQsJu5u640vcxooeFQnj8cU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-1Lk72sweM--amXFvkttRlA-1; Wed,
 15 Jan 2025 12:00:54 -0500
X-MC-Unique: 1Lk72sweM--amXFvkttRlA-1
X-Mimecast-MFC-AGG-ID: 1Lk72sweM--amXFvkttRlA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79EED1955DE9;
	Wed, 15 Jan 2025 17:00:53 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.89.167])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C527195E3EA;
	Wed, 15 Jan 2025 17:00:53 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 39E50312C4A;
	Wed, 15 Jan 2025 12:00:51 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] nfsdctl: debug logging fixups
Date: Wed, 15 Jan 2025 12:00:51 -0500
Message-ID: <20250115170051.8947-1-smayhew@redhat.com>
In-Reply-To: <0068c0d811976aca15818b60192a96ca017893f8.camel@kernel.org>
References: <0068c0d811976aca15818b60192a96ca017893f8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move read_nfsd_conf() out of autostart_func() and into main().  Remove
hard-coded NFSD_FAMILY_NAME in the first error message in
netlink_msg_alloc() and make the error messages in netlink_msg_alloc()
more descriptive/unique.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
SteveD - this would go on top of Jeff's "nfsdctl: add support for new
lockd configuration interface" patches.

 utils/nfsdctl/nfsdctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 003daba5..f81c78ae 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -436,7 +436,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
 
 	id = genl_ctrl_resolve(sock, family);
 	if (id < 0) {
-		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
+		xlog(L_ERROR, "failed to resolve %s generic netlink family", family);
 		return NULL;
 	}
 
@@ -447,7 +447,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
 	}
 
 	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
-		xlog(L_ERROR, "failed to allocate netlink message");
+		xlog(L_ERROR, "failed to add generic netlink headers to netlink message");
 		nlmsg_free(msg);
 		return NULL;
 	}
@@ -1509,8 +1509,6 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		}
 	}
 
-	read_nfsd_conf();
-
 	grace = conf_get_num("nfsd", "grace-time", 0);
 	ret = lockd_configure(sock, grace);
 	if (ret) {
@@ -1728,6 +1726,8 @@ int main(int argc, char **argv)
 	xlog_syslog(0);
 	xlog_stderr(1);
 
+	read_nfsd_conf();
+
 	/* Parse the preliminary options */
 	while ((opt = getopt_long(argc, argv, "+hdsV", pre_options, NULL)) != -1) {
 		switch (opt) {
-- 
2.48.0


