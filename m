Return-Path: <linux-nfs+bounces-22709-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RO9gLx2XNWqw0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22709-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B226A77D6
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OElRuQ4U;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22709-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22709-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7E7A300BCBE
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB4E25B09B;
	Fri, 19 Jun 2026 19:23:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4C3469FA
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896980; cv=none; b=OqOqE6fLWilrfkMENBHExG8YAoKnrxj2DOqcMkt4LkvNjfN2RWuuSPYee+Jd/BDH0IH84COth/Rd/BOP5KyvwU1+f0ZJ2UZLhZ2E/37SIsyLl44Afuu0vLwkT04QebuIFUXHpKESFqabvYHRC5jhHWM3kGJeEP+985jtm0PKmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896980; c=relaxed/simple;
	bh=2U1jUcmSI2Le3mSkLSLJOg+Lbx/uNc6l+SFPcD019Go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbDI4iSpcHm7TxxPKDGKgdstigBH5dU36Es8+FTk0041Q3rf7coTT10ZdIJhy/WzyNJVDX13XmLKR4+Qq/AXsIST2lVuI029fhF4bozRLqMshlH8x89o8xUmz6phlAVfS9aWzj55Bg20nrh01CgfhnbdYi3ArwdkFanFggF5/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OElRuQ4U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093421F00ACA;
	Fri, 19 Jun 2026 19:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896974;
	bh=GE1sGYPibuQIwE8Lr0riGq2ni2/Kw79eTgqacQRHq6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OElRuQ4Ug4hxpttXQP0A04ZfSBd2WlVBbSr/yQ23bhqV79I+iJnxJ+gw+qURkvC9A
	 ln6ZrEwM/1I0ZtyN7SPftV5Fq+TG70rQK2n0TcN7HGGKJbaXmiiAx5kZWUnRze1LQ7
	 Sqrr55lnJ5p5WfVanHwbNf8ULtkZH282buYl1NZ+SUlc7CzMU4HrJOsbjbaNpfY1uF
	 ygjLC2Q08mkKR/tjMMOkaKyqIn6XqeU+Ob6ZnSk2Y3r/J+gNXRZScD4Wvfb3/j+ZJL
	 BCcr0NwiZeQt3Dz1Hc4nPGsQooMlYc0E2KWMygmdhKlWXhjn5KicfrcssgvNtPndUg
	 WNunGAZ+cDv+w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:31 -0400
Subject: [PATCH pynfs v3 12/26] server41tests: add a test for removal from
 dir with dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-12-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4948; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2U1jUcmSI2Le3mSkLSLJOg+Lbx/uNc6l+SFPcD019Go=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb7LfBeGyTFguZrsEaP8UmZputPMZ/JAMHDg
 UyFCNYSTFKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+wAKCRAADmhBGVaC
 Fdl6D/4ye0lqns69BDkJq5EvoOoU00WhQ2B2D1SOLGftg9Ds4j+e94XVv0cBPwnC5kTHkF5iIJU
 O4NFXR8hUF6FdLRIoFjs8QMlF0YLcxLazbhbGStbG29F1r+/USlFufG/tQO+dzrJ+dcbEALfltq
 r4BUq5saErCX80HmrPD3dFsiDQzqvYl2HI8QchqcmFW88WqjBsJUjGMkCFCf7CqPvS0GkemAnsk
 SmA7YmWhTkVJDV+i4WKJpvfbJtLEtm17CXOE7j43Qr1WvwDQTvS5L4s5pIukSn2/dyy2kdTWydv
 3X+oSKP4Fln/xr2CnqGHHfaJH1HC/8Qhmopt5e0mVRf47WZ/H5Q4EyDD6F2tT4D4ev5r8INYi2k
 vFxD1IFqrCjkhpq3A1ozHjyFXvO/QWG1gWLeErjfNkEmslwT/4+/yedBZzppYT/nRS4VBmHuSgn
 DyofRTXhpVB9wlCdREvoCpUUrbIVZG1hEC4KCMFrzHWH12O7S5Twe8R8qm+rMnZzdLGqKjRyBrO
 4xonoQR64K+KhLsZCO/8JiwGWrF4CSE+cRnW2GOXMWRZtta/U74g+dy5+fONUKUAuWlN7Ex4rJ5
 f6NM/yssS8oEeYvSSmiBpyx3QVMa7DC72GXjUlWLT+wvJELz5rnosM5eDhDNH8uExQ59xK2J0TU
 z9rnbpKuGtP3bUQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22709-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:smayhew@redhat.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0B226A77D6

Request a dir delegation with REMOVE_ENTRY notifications. Create a
file, then remove it from a second client. Verify the server sends
a CB_NOTIFY with the correct REMOVE event.

Also add full child and directory attribute bitmaps to the
GET_DIR_DELEGATION request for all CB_NOTIFY tests.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 65 ++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 8fe2ba54fc67..5b39f38a478c 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -68,8 +68,26 @@ def _getDirDeleg(t, env, notify_mask, cb):
     mask_bm = nfs4lib.list2bitmap(notify_mask)
     ops = [ op.putfh(fh), op.get_dir_delegation(False, nfs4lib.list2bitmap(notify_mask),
                                                 zerotime, zerotime,
-                                                nfs4lib.list2bitmap([]),
-                                                nfs4lib.list2bitmap([]))]
+                                                nfs4lib.list2bitmap([FATTR4_TYPE,
+                                                                     FATTR4_CHANGE,
+                                                                     FATTR4_SIZE,
+                                                                     FATTR4_FILEID,
+                                                                     FATTR4_FILEHANDLE,
+                                                                     FATTR4_MODE,
+                                                                     FATTR4_NUMLINKS,
+                                                                     FATTR4_RAWDEV,
+                                                                     FATTR4_SPACE_USED,
+                                                                     FATTR4_TIME_ACCESS,
+                                                                     FATTR4_TIME_METADATA,
+                                                                     FATTR4_TIME_MODIFY,
+                                                                     FATTR4_TIME_CREATE]),
+                                                nfs4lib.list2bitmap([FATTR4_CHANGE,
+                                                                     FATTR4_SIZE,
+                                                                     FATTR4_NUMLINKS,
+                                                                     FATTR4_SPACE_USED,
+                                                                     FATTR4_TIME_ACCESS,
+                                                                     FATTR4_TIME_METADATA,
+                                                                     FATTR4_TIME_MODIFY]))]
     res = sess1.compound(ops)
     check(res, [NFS4_OK, NFS4ERR_NOTSUPP])
     if (res.status == NFS4ERR_NOTSUPP):
@@ -354,3 +372,46 @@ def testDirDelegFiltering(t, env):
 
     if not cb.got_recall:
         fail("Expected CB_RECALL for unrequested notification type")
+
+def testDirDelegRemove(t, env):
+    """Create a dir_deleg that accepts notification of REMOVE events
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG9
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_CHANGE_DIR_ATTRS,
+                                      NOTIFY4_REMOVE_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess1.compound(open_op)
+    check(res)
+    open_stateid = res.resarray[-2].stateid
+    file_fh = res.resarray[-1].object
+    close_file(sess1, file_fh, stateid=open_stateid)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    res = sess2.compound(remove_op)
+    check(res)
+
+    completed = cb.wait(5)
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+
+    if (not completed or not cb.got_notify):
+        fail("Didn't receive a CB_NOTIFY from the server!")
+
+    evt_type, evt = decode_notify_event(cb.changes[0])
+    if evt_type != NOTIFY4_REMOVE_ENTRY:
+        fail("Expected REMOVE notification, got %d" % evt_type)
+    if evt.nrm_old_entry.ne_file != env.testname(t):
+        fail("Wrong entry name in REMOVE notification")

-- 
2.54.0


