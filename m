Return-Path: <linux-nfs+bounces-20490-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC8pG1OAx2mpYQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20490-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 08:16:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F934D989
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 08:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649963032CF4
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8B23EA83;
	Sat, 28 Mar 2026 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6Vggc6i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A06B67E
	for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2026 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774682191; cv=none; b=oWwsbZZFs5+tBSH/8bmJaOg1dA+S4BFWzerkXsA+hjUfvf1pLmC7sqn5G3xP62e2dg+hiLVdW91yjryL8ce/p9laNksiq/yFjupRsd+NGnpn0o9xpanbLtin8DC1ZNOg3EpbHMb/EzcDY4G4tMWnUinJTxp3iyiITiH0Z2NFdyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774682191; c=relaxed/simple;
	bh=BAizR8ok2MSjJ9xscjsDiqx3lrk451MQcELXnxtPANA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIgsbXIzOFx2fmnBbw9rXag2sGt9QnWLnf5VfoYUSSM/uz3B2JzM/X19yp0bGJaZNb45oeQaHn1gsP55uK0KW+Vndo5ZGu8wsKp0C4Ot4KGpAqqoLUYfHXCypTlM7xkxgaY4vF5/uoZVK1Vo2oZk8atVuWXuQzA54tDCYwjLPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6Vggc6i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774682189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iotSsP8xAe4TXVwQC7GnRZrzrwlb9YnsJCK4R3qsJPM=;
	b=D6Vggc6idIonV+8tsU1PEI37HnVXq8LdtHk1vVn9Qnqz6OY70nX0PJmwx1TMJyXgD8RHG3
	a6XVTHZAjXCpfSlT0YWq9a63UAqnDRydgOgFE/Ra2XpiA6o0vGue4L2bs9bBfA3L/DXzXS
	zn53dgrfRzR15ihc3sMJ/nOSL8Nq5cg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178--rXWaDP6PPmqfgbrns5Cpg-1; Sat,
 28 Mar 2026 03:16:25 -0400
X-MC-Unique: -rXWaDP6PPmqfgbrns5Cpg-1
X-Mimecast-MFC-AGG-ID: -rXWaDP6PPmqfgbrns5Cpg_1774682184
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1BF7195608B;
	Sat, 28 Mar 2026 07:16:24 +0000 (UTC)
Received: from localhost (dell-per660-10.rhts.eng.pek2.redhat.com [10.73.4.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0219A30001A1;
	Sat, 28 Mar 2026 07:16:23 +0000 (UTC)
From: Jianhong Yin <jiyin@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: calum.mackay@oracle.com,
	jlayton@kernel.org,
	bcodding@redhat.com,
	smayhew@redhat.com,
	jiyin@redhat.com,
	Jianhong Yin <yin-jianhong@163.com>
Subject: [PATCH v3 4/4] pynfs: fix various types of errors in nfs4.1/nfs4proxy.py
Date: Sat, 28 Mar 2026 15:15:33 +0800
Message-ID: <20260328071533.3135266-4-jiyin@redhat.com>
In-Reply-To: <20260328071533.3135266-1-jiyin@redhat.com>
References: <20260328071533.3135266-1-jiyin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20490-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,redhat.com,163.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiyin@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 115F934D989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most of the strings in pynfs are not str but rather "bytes" objects.
- "string" -> b"string"
- python3: is -> '=='

test pass on RHEL-9, RHEL-10,Fedora-43

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---
 nfs4.1/nfs4proxy.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/nfs4.1/nfs4proxy.py b/nfs4.1/nfs4proxy.py
index 1b935fa..8cc4002 100755
--- a/nfs4.1/nfs4proxy.py
+++ b/nfs4.1/nfs4proxy.py
@@ -46,7 +46,7 @@ class NFS4Proxy(rpc.Server):
             self.cb_versions = [cb_version]
             # currently support only root (? fix ? )
             rpcsec = rpc.security.instance(rpc.AUTH_SYS)
-            self.default_cred = rpcsec.init_cred(uid=0,gid=0,name="root")
+            self.default_cred = rpcsec.init_cred(uid=0,gid=0,name=b"root")
             if pipe: #reuse connection
                 self.pipe = pipe
             else:
@@ -60,7 +60,7 @@ class NFS4Proxy(rpc.Server):
             return (min(self.cb_versions), max(self.cb_versions))
 
         def _find_method(self, msg):
-            method = getattr(self.proxy, 'handle_cb_%i' % msg.proc, None)
+            method = getattr(self.proxy, b'handle_cb_%i' % msg.proc, None)
             if method is not None:
                 return method
             return None
@@ -162,8 +162,8 @@ class NFS4Proxy(rpc.Server):
             log.debug("** CALLBACK **")
         log.debug("Handling NULL")
         try:
-            self.forward_call(calldata="", callback=callback, procedure=0)
-            return rpc.SUCCESS, ''
+            self.forward_call(calldata=b"", callback=callback, procedure=0)
+            return rpc.SUCCESS, b''
         except rpc.RPCTimeout:
             log.critical("Error: cannot connect to destination server")
             return rpc.GARBAGE_ARGS, None
@@ -192,7 +192,7 @@ class NFS4Proxy(rpc.Server):
             env = CompoundState(args, cred)
         for arg in args.argarray:
             env.index += 1
-            opname = nfs_opnum4.get(arg.argop, 'op_illegal')
+            opname = nfs_opnum4.get(arg.argop, b'op_illegal')
             log.info("*** %s (%d) ***" % (opname, arg.argop))
             # look for functions implemented by the proxy
             # that override communication
@@ -210,7 +210,7 @@ class NFS4Proxy(rpc.Server):
             if error is not None:
                 result = encode_status_by_name(opname.lower()[3:],
                                             int(error),
-                                            msg="Proxy Rewrite Error")
+                                            msg=b"Proxy Rewrite Error")
                 env.results.append(result)
                 p = nfs4lib.FancyNFS4Packer()
                 if callback:
@@ -288,7 +288,7 @@ class NFS4Proxy(rpc.Server):
                     attrs.ca_maxoperations = chan.maxoperations
                 if chan.maxrequests < attrs.ca_maxrequests:
                     attrs.ca_maxrequests = chan.maxrequests
-            if direction is 0: # client to proxy
+            if direction == 0: # client to proxy
                 # XXX: this might be buggy with more than one clients (?)
                 self.start_cb_proxy(arg.opcreate_session.csa_cb_program,
                                     version=1, client_pipe=cred.connection)
@@ -296,7 +296,7 @@ class NFS4Proxy(rpc.Server):
                                        self.fchannel)
                 _adjust_channel_values(arg.opcreate_session.csa_back_chan_attrs,
                                        self.bchannel)
-            elif direction is 1: # proxy to client
+            elif direction == 1: # proxy to client
                 pass
 #FUNCTION OVERRIDING END
 
-- 
2.53.0


