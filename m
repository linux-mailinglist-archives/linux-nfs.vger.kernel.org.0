Return-Path: <linux-nfs+bounces-14628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54097B97ABD
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 00:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9926C189BC1B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09BC30F552;
	Tue, 23 Sep 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxlP12yQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF49281355
	for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664803; cv=none; b=A4dc2xgL6VGClqmfAclgAZZaa2gdTVvWVkoepQnM8sc6dx5zMrAPfDqyR4nLSQrocHP2TNykhaFKVQZ8EaErQRZMNfkRLrnY2rNSkcSHH9jVJtTqeKMaCNE90zpula8YN7NiL0E3KTxNhhQ3nKew6jNJ+WD4EOhEjXGNl2APqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664803; c=relaxed/simple;
	bh=DF7OmchyHhg1MsHloWlvkiQy9vAuMearNPwllWBAEXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyggsaSjnZbUjecDXMNXrJb90ijWu2Iab8Y5fAMbkiQV2oTQeqTWTQd7Svq7ZJHbObdftajxjPj66W16TeoskuCKyf9TKmjzdXkyIxD7fgfe2j3b14X5uBcmhoXWlzWMqGZ7t/7hjDbK5fvzIHTrEnQk8g+tJkHmOHefkwB5KE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxlP12yQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758664800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h05DjLZgMN64YZzuzOf9hsuR4erUst7D4aONUxjtAJc=;
	b=QxlP12yQVZsAzu+GE36/SQxB5LRMuuIStJJrc8rIKwQBG5nzMtRSMKMKl3ZhFua2uieClm
	tIoICRd/1vukTe+fYyrtfIxnXZ+ysQNBK2eQMCaE37Fclqr3BzFP53GrG8fjETyrQH3iJK
	jHZzVeKc/B1FdwS8dAPkUKPT+F+u18A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-HsSkRQ_SOa-vNLXBFdHsPg-1; Tue,
 23 Sep 2025 17:59:56 -0400
X-MC-Unique: HsSkRQ_SOa-vNLXBFdHsPg-1
X-Mimecast-MFC-AGG-ID: HsSkRQ_SOa-vNLXBFdHsPg_1758664796
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDE0B19560B4;
	Tue, 23 Sep 2025 21:59:55 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.89.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91CDB3000198;
	Tue, 23 Sep 2025 21:59:55 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id F130D46F6F6;
	Tue, 23 Sep 2025 17:59:53 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] pynfs: add an option to forcibly expire clients to the serverhelper scripts
Date: Tue, 23 Sep 2025 17:59:51 -0400
Message-ID: <20250923215953.165858-3-smayhew@redhat.com>
In-Reply-To: <20250923215953.165858-1-smayhew@redhat.com>
References: <20250923215953.165858-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Some tests may want to sleep a certain amount of time to allow client
objects to expire.  The courteous server in newer kernels thwarts this,
so add the ability to forcibly expire clients using the proc interface.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 examples/localhost_helper.sh | 12 ++++++++++++
 examples/server_helper.sh    | 15 +++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/examples/localhost_helper.sh b/examples/localhost_helper.sh
index 6db1233..b360ed6 100755
--- a/examples/localhost_helper.sh
+++ b/examples/localhost_helper.sh
@@ -5,6 +5,15 @@
 # without a password.
 #
 
+function expire_client() {
+	for f in $(find /proc/fs/nfsd/clients -name info); do
+		if grep -q "^name: \"$1\"" $f; then
+			d=$(dirname $f)
+			echo "expire" >$d/ctl
+		fi
+	done
+}
+
 # server argument is ignored here
 server=$1
 command=$2
@@ -26,4 +35,7 @@ link )
 chmod )
 	chmod $1 $2
 	;;
+expire )
+	expire_client $1
+	;;
 esac
diff --git a/examples/server_helper.sh b/examples/server_helper.sh
index fbd32bc..a2bed6d 100755
--- a/examples/server_helper.sh
+++ b/examples/server_helper.sh
@@ -5,6 +5,18 @@
 # --serverhelper=sample/server_helper.sh --serverhelperarg=SERVERNAME
 # to testserver.py's commandline arguments.
 
+function expire_client() {
+	for f in $(find /proc/fs/nfsd/clients -name info); do
+		if grep -q "^name: \"$1\"" $f; then
+			d=$(dirname $f)
+			echo "expire" >$d/ctl
+			echo "expired $1"
+		fi
+	done
+}
+
+export -f expire_client
+
 server=$1
 command=$2
 shift; shift
@@ -34,4 +46,7 @@ link )
 chmod )
 	ssh $server "chmod $1 $2"
 	;;
+expire )
+	ssh root@$server "$(declare -f expire_client); expire_client $1"
+	;;
 esac
-- 
2.51.0


