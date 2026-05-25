Return-Path: <linux-nfs+bounces-21911-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COrHJwHrE2qoHQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21911-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 08:24:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0814E5C65B3
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 08:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D63813002B31
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 06:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6739B97B;
	Mon, 25 May 2026 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Dj3CMT1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LfOSjeqK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD27399CED;
	Mon, 25 May 2026 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690236; cv=none; b=JNwWFXgqlbDtRvBqAEGEsq7EG3jO/IccV6PQPzCmh9oCojj2QuJiO5Czp/lgkLm9bjgr01e6wImRmzwj/Kr4X3t04vDdRDTGqgsIHGhnV/BNy0OuxjrvWOd4njIhxWSqP8UfkTYdwH/ogOF80DTQGzClWVzYWZAK3xM+sTlKwOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690236; c=relaxed/simple;
	bh=7uXO3wP7UZHM7PnhYv1/J0y5rH0gQtE0MbtPYBgwkho=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=Pw2JocKRRy8sGbWUxcCQ4kZzuwQXDYT1l276Z0CMyUpcM32MQXbDB8h21yqSNvvYXFjxBT8cgNCWIOcCbIiYCRL+Yf+dwcA7WQ3Bx9cr4psr27l7KJqtcAB20Hzr83wCfEEzs5NBcBOTz9fgPBcTQFZTpBBOt9vbabW2Th7jIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Dj3CMT1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LfOSjeqK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E9CA6EC0667;
	Mon, 25 May 2026 02:23:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 25 May 2026 02:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm3; t=1779690231; x=
	1779776631; bh=YRq7eCOpItE+VLVvwjfJhWvX72kPUeFlO1OcuB3VA90=; b=D
	j3CMT1HG6v/aHTvaFUmXyQHty1XjbKwgi6FTE6P7a88M2AZ0bHewmRw/Ft3S4hd/
	wkIog6WFGDsBfEmEnw2EDVJwtd7yG7A3VqQ0RiYXUiy7TYOpP63qvJU+Cbh0a7hN
	+3Je8+4KkT0VhV9c6I3+RurZw6ocivxrWPu+ariS8Lfrk4yYQNcPTXAkL3wCdQJw
	QqAvKQxWmExosYJrQM+2QbYikVmGqH8YORzzVN2UDkEW3ABlgAs8Hie5gfRtqczi
	b6usT9uaGzM1d2ZjTteTOIm9glujshIPOAdCkvJ/njZ1ihxo+KLCXfaUBXlJdMnB
	Eu3aprEfvTAYG3SpmATag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1779690231; x=1779776631; bh=YRq7eCOpItE+V
	LVvwjfJhWvX72kPUeFlO1OcuB3VA90=; b=LfOSjeqKlu3QfW1Q1jt49wLXYN8hC
	AqsHDTulxldjcQt50+o9nMURMyq6pR2v9XbyO/V/0HC4q1WcApweakCz1mNqVrH9
	cxvyhzlH54+qnh08W4uZQ/moRdZ9gU4AUEx4nO5i0iN2n6C+Gh4VTbxjHrbw/kgr
	QmMahtMZ8EHXruZiQXRC0zvLz6Ks4rF92AXpzLIUfn67iZiaDSYYTMPjPqxeUdIW
	RcxyCeBBr6fNRX5FydUxtTT/S+j3BDcOqFQrqfKosEnTxi+g8o7hpNDG5HemGOBh
	ReWBwlXjauKZ6w2Do5tgdbCE6ypfPOE7j3+3sF5rLfasVNF1nhGEFCNMA==
X-ME-Sender: <xms:9-oTajOMu8mZbnsiKif9FA8YqRd7Y_7gRtv1-edyqP8NpsCZ0ajVtQ>
    <xme:9-oTaq1Y8mRmnz6v9OflsJuZTUGazN-sbdFLhib1xtjgDQz2Ke_8sKIykZHLbc8Sc
    FiVD0e4n1g1PIwrOLhBDaLjaZkyLoRLDPxktYD_30808Nl->
X-ME-Received: <xmr:9-oTaiDl44nSkr1L6M5ZRUSLtpjxtQMPYCkqzAcjHmKr_9cMQ-YzqPB0hrdM-5L8lcbfl1OR3OWTA9ua-oLnCsftertIUXE>
X-ME-Proxy-Cause: dmFkZTFq0PHIUf66jG74J9936rqJWKiNWD4b62nSo4XGnXFlOJUo9qq4TMxx0QvQ2PEOMu
    tD7u6JMf+6EB2+1jrhIrQw2t5G8hFAwkAoo3eF5kTsL9SP5DBKzlJudUiJb/rt0FFqDFq6
    AtZAwyACuvDtQGdXdKI97yng5mh6qQcf+0ESEjQF0Od/81L1L7SFSXdSzZYQVVcUvdfwZV
    3/fmTWTbunqyLvC8oNdVnhxapT+tA3SRndi4J96Vw7Lq8mXzkqtF1abF8zkO+1AazYpx9P
    HafF/fLLFNm+zSJyM80Uqqu3Nwv5RIDvrkvdNlIwCcZ7GClwmVUXU0rFvVOGIip5ENVlDj
    xtkstPFcAxN1rYgmRzOhg4nhyWMURtfiRChg1//qeve9gWElu4/yha/KdLpqF/u9rQctxW
    wIqBrjfPGb8vxg+EB8m2eGvVISfpJ2bCEvto1DbbINTbhKM7G4CWOVb0PllgXVnt/EjtFg
    RqLrWfoB+ft6+VjVyuPpIRRYsckj20eW04+y1gAb+oa/pqSIu77cYNWXSyR1LIjwpqAgwB
    zTEG/HAUY0obzJAUXoI9CQkHJ0R4EyoR/560WCvFgfsuSd2uKJ8Tj95gUxpJeckd+w+Hc/
    ssuM14GFkyEpjg8Zi+xpjCR38yvAtAyciu3JKS5CpAruigsXPkBOmWLohqbg
X-ME-Proxy: <xmx:9-oTanJ-4_BxoXCQ0YCy7ypB2LnF2fVh42t2xDcOwuWBYF7oudLsAw>
    <xmx:9-oTarn4MHP1YgWEGd_QHAjBW81OyTkReNQpY3E4ruAsqQcWJFXIMg>
    <xmx:9-oTagYZ44xfQBRXEcWB86_aV5GmkwomTJdtxrQC5qyjl6Xl2ifLiA>
    <xmx:9-oTan_ygMLT41ZpMmMt27FrPBZyIXQPv-Gk2T29sv-ZIe9CpUvyLA>
    <xmx:9-oTahwVyapnU-VwsF3DaNxeQhF2AdPMvPt8F3LfgxovDhbLfvl9yCBo>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 02:23:48 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] VFS: fix possible failure to unlock in nfsd4_create_file()
Date: Mon, 25 May 2026 16:23:45 +1000
Message-id: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21911-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,brown.name:replyto,brown.name:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 0814E5C65B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


atomic_create() in fs/namei.c drops the reference to the dentry
when it returns an error.
This behaviour was imported into dentry_create() so that it
will drop the reference if an error is returned from atomic_create(),
though not if vfs_create() returns an error (in the case where
->atomic_create is not supported).

The caller - nfsd4_create_file() - is made aware of this by checking
path->dentry, which will either be a counted reference to a dentry, or
an error pointer.

However the change to use start_creating()/end_creating() (which landed
shortly before the dentry_create() change landed, though was likely
developed around the same time) means that nfsd4_create_file() *needs* a
valid dentry so that it can unlock the parent.

The net result is that if NFSD exports a filesystem which uses
->atomic_create, and if a call to ->atomic_create returns an error, then
nfsd4_create_file() will pass an error pointer to end_creating()
and the parent will not be unlocked.

Fix this by changing dentry_create() to make sure path->dentry is always
a valid dentry, never an error-pointer.  The actual error is already
returned a different way.

Note that if ->atomic_create() returns a different dentry (which may not
be possible in practice) we are guaranteed (because it is only ever
provided by d_spliace_alias()) that it will have the same d_parent and
so it will have the same effect when passed to end_creating().

Fixes: 64a989dbd144 ("VFS/knfsd: Teach dentry_create() to use atomic_open()")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..4787244ca4a7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5024,6 +5024,7 @@ struct file *dentry_create(struct path *path, int flags=
, umode_t mode,
 {
 	struct file *file __free(fput) =3D NULL;
 	struct dentry *dentry =3D path->dentry;
+	struct dentry *orig_dentry =3D dentry;
 	struct dentry *dir =3D dentry->d_parent;
 	struct inode *dir_inode =3D d_inode(dir);
 	struct mnt_idmap *idmap;
@@ -5043,9 +5044,18 @@ struct file *dentry_create(struct path *path, int flag=
s, umode_t mode,
 		if (create_error)
 			flags &=3D ~O_CREAT;
=20
+		/* atomic_open will dput(dentry) on error */
+		dget(orig_dentry);
 		dentry =3D atomic_open(path, dentry, file, flags, mode);
 		error =3D PTR_ERR_OR_ZERO(dentry);
=20
+		if (IS_ERR(dentry))
+			/* keep the original */
+			dentry =3D orig_dentry;
+		else
+			/* Drop the extra reference */
+			dput(orig_dentry);
+
 		if (unlikely(create_error) && error =3D=3D -ENOENT)
 			error =3D create_error;
=20
--=20
2.50.0.107.gf914562f5916.dirty


