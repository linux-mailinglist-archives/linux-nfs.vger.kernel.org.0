Return-Path: <linux-nfs+bounces-22872-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 42WrMS4ZQmql0AkAu9opvQ
	(envelope-from <linux-nfs+bounces-22872-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 09:05:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7336E6D6B55
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 09:05:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=HvjgLc9t;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22872-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22872-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E511E3038D3D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54013B47DF;
	Mon, 29 Jun 2026 06:59:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F923B388A;
	Mon, 29 Jun 2026 06:59:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716398; cv=none; b=imc0IdnDILMuA+0pFDpBCMy5b2GjI4XTMI4KSFec028QDeDbsPkY6D6fwEgKRa3ZLDSlU3SLXgz8x8z8pGnFCaPujZkYypToGxCETHCpc6IyQhjEJNc/hm2mFmsOkEdkJZF0Gj1vWmRLVxs/UTQFfilJPDMh8hVt8gYEp6xpkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716398; c=relaxed/simple;
	bh=6qzG+s+o0ntSMLj3f0AMOalFGqBsSo63rEgrfvI/OqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgyErqX5dW5y8lKS2IqgC4bKClViHVDRV1GCcKzfrhhzE4VLJtt0/jcbycnwHCgB5/ODTjKZSEB1lfNNWmjdi1p3XGn5nkZxTBTVfZ6ZaJnY40j7eeP2b15rDuQs2PWIOla2QsOqmanKn4CIrbzZwlkDptV2QzOdVl9T4VW7QFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvjgLc9t; arc=none smtp.client-ip=103.168.172.142
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id C743913801A0;
	Mon, 29 Jun 2026 02:59:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 02:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782716396; x=1782723596; bh=O
	dOkzuKr6PMGP0Swb+3TBhVRv/cseWllGDt56sDblRs=; b=HvjgLc9t3YyxCa4ow
	ky52JhgHPeriumxhHt8q6kcpfaWO9XKn122fSgobz8Fx4DjCp/tT/4/CJEcUvJCz
	yqHgpd7xDZGMnPcKH8m48tqvnqd/SQFcpcmcpvQmAaraS4tbcZ9LVB0TC9Wn8Cum
	QnOG32skVZNbCRu0EvSBUT7Fr3aae6r0vsLFC0rAbYeZ8uLZqwZG2yWpXU3KV4sT
	MBLFlKNgU+5JKOiak7cGLO3rKYHFWKCdJlm41ujEZHF5z1375pUvU8Y69EX29zZ2
	R60EoZjqOvrp4g7oH/gipnqvs4WP/INR+oG2ap6FaYHLJzsl6oIHDZ+ena8eGiXQ
	Y1PNA==
X-ME-Sender: <xms:7BdCak_wuhvrZWx21VNQGeJeuzjiFYtQgeNw3YAYuseM_cF5x7CvGw>
    <xme:7BdCavWKSGGdsYA00MhsvQ9Jbn-6KtrmmUIzP8XbJYZxtUK2M2fYJvABDRuBbFuEH
    dKXQD9yseTgiUYuqldmciCSm6enOlYsIhYATeUIDshbUwyBYwfZJGM>
X-ME-Received: <xmr:7BdCapj2sIJY4U8eI2AXIpMp-3WWEcQGcYzfsgEdi_5lIPvUx5Wl5-PzCOHKhGoq6kZ3ynlvhrQqgQrh6fH5I5eeB_REQ_HTmEkFTg>
X-ME-Proxy-Cause: dmFkZTFXRXqXXHQig7aOEXscQpb861yO5R1n/JZ6/neobiLJxdwcQzvLtKpg3rAKseaAOK
    QsJhQwi62/No698HcwnilN3sG7YXlAfqWy/lDrcLEbeiS6jMSOcpT8xMw4CYYBtDSPh9ua
    fbkHZ4sq8c9RILgSHAvyMaHp4hjTZcdv0ZCaXt3xRyvWX2TfrkxRsebc3IizW4gRw8G5PK
    egy7dn1PuCGj8lbOqc95xmreGYhBGeCRsZ8NvMQ3TGqmgXLN4na69GZ07y8Q5aNxwOSqVq
    phXG20pRAzX8AuKD1hIURFKnXT3/UUySz0y1LRBFEWGzEXoNvnA32P6m9f2FXjRHKlHnr/
    zWYb3y4oIArybB1B6dKf5EZT9gG4pXqx8qAtOT6OkrlP4d40o72eIvDP6NvR0sp1XjsgUb
    9AgebZ+ED5ZSb5HIlRcCUZWXWpo+SvWI/xu08Ai6fZP51goYJgSchB48NX3dt0BhAx/A/G
    NVzQIIiqroByFKkdSv7bHbZiQ8OjMCiUrvXBQi75M7Ge2lgm8fRqmF7k0pmuAJymrBhFRJ
    iDsMOFEduArHeOQqBqzSGb3YkpYRwSqxQwic95jXUrvnIICJWRMt8qKayX9DvzauKEiuo2
    IaipwU+ZfJjAk0qzW3cDwjlDuQYqn6IdfFN3qLY/JsJdBDb9kD7/POtIDHJA
X-ME-Proxy: <xmx:7BdCalyCi3bFm0sipMMoR9dgxkruyI4uCGTAeslIddje3ODzPihr5g>
    <xmx:7BdCanpPx6jj-a5Mh2pwZWmE2Rn4imia49U6ehlBgla0KJKfbuuQJw>
    <xmx:7BdCaol0T_gS5Y_NelxguUGHVmOTjiHCTb7FGb6YpJJmVhmZkJSvng>
    <xmx:7BdCaqpflORfKOWzwSYhzKo57-Yb26o9mveikzD7FcD4_o_eVQ_0LA>
    <xmx:7BdCas3bMn6sxD1z4DrX373wpl6HY2BI2yUmUxN5vcssHQUyYDHtp4kc>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 02:59:55 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: "Andy Lutomirski" <luto@kernel.org>,	"Al Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,	"Jan Kara" <jack@suse.cz>,
	"David Howells" <dhowells@redhat.com>,	"Chuck Lever" <cel@kernel.org>,
	"Jeff Layton" <jlayton@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"David Laight" <david.laight.linux@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,	"Li Chen" <me@linux.beauty>,
	"Cong Wang" <cwang@multikernel.io>,	"Arnd Bergmann" <arnd@arndb.de>,
	"Thomas Gleixner" <tglx@kernel.org>,	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	"Jonathan Corbet" <corbet@lwn.net>,	"Kees Cook" <kees@kernel.org>,
	"Sergei Zimmerman" <sergei@zimmerman.foo>,
	"Farid Zakaria" <farid.m.zakaria@gmail.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-api <linux-api@vger.kernel.org>,	netfs <netfs@lists.linux.dev>,
	linux-nfs <linux-nfs@vger.kernel.org>
Cc: John Ericson <mail@JohnEricson.me>
Subject: [RFC PATCH 1/3] fs: Add documentation to some `struct fs_struct` fields
Date: Mon, 29 Jun 2026 02:58:20 -0400
Message-ID: <20260629065934.1425479-2-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260629065934.1425479-1-John.Ericson@Obsidian.Systems>
References: <20260629065934.1425479-1-John.Ericson@Obsidian.Systems>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-22872-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,redhat.com,linuxfoundation.org,gmail.com,zytor.com,linux.beauty,multikernel.io,arndb.de,alien8.de,linux.intel.com,lwn.net,zimmerman.foo,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dhowells@redhat.com,m:cel@kernel.org,m:jlayton@kernel.org,m:skhan@linuxfoundation.org,m:david.laight.linux@gmail.com,m:hpa@zytor.com,m:me@linux.beauty,m:cwang@multikernel.io,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:corbet@lwn.net,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:netfs@lists.linux.dev,m:linux-nfs@vger.kernel.org,m:mail@JohnEricson.me,m:davidlaightlinux@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John.Ericson@Obsidian.Systems,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Obsidian.Systems:mid,Obsidian.Systems:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,vger.kernel.org:from_smtp,johnericson.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7336E6D6B55

From: John Ericson <mail@JohnEricson.me>

This will be expanded upon in the next commit.

Link: https://lore.kernel.org/all/a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com/
Signed-off-by: John Ericson <mail@JohnEricson.me>
---
 include/linux/fs_struct.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..b5db5de9eb01 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -12,7 +12,21 @@ struct fs_struct {
 	seqlock_t seq;
 	int umask;
 	int in_exec;
-	struct path root, pwd;
+
+	/*
+	 * The root directory for the task(s) that points to this
+	 * `fs_struct`. The root directory also controls how `..`
+	 * resolve; path traversal is not allowed to resolve upwards
+	 * beyond the root directory. (It is for this latter reason that
+	 * `chroot` is a privileged operation.)
+	 */
+	struct path root;
+
+	/*
+	 * The current working directory for the task(s) that points to
+	 * this `fs_struct`.
+	 */
+	struct path pwd;
 } __randomize_layout;
 
 extern struct kmem_cache *fs_cachep;
-- 
2.51.2


