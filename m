Return-Path: <linux-nfs+bounces-22826-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QfvRKPHoPGo0uQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22826-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 10:38:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 001266C3E72
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 10:38:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TXFDTm8A;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22826-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22826-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C1633007ADF
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B7B331EDF;
	Thu, 25 Jun 2026 08:38:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822240D595
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 08:38:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376685; cv=none; b=ubsyPAgmDLh7XOclQA7dKCpuK/i/IYYwm+ouwVqbBRmaCpwBjG/K9/CU0ifQ4IfxSyDVmgZgctgdYp/5qA1jiGUb47i73x8aPx0gBFTBIPyc+mh0TegiqT3Y8so67xM1ydIUyFJLtHy6OTsKsqslUNCmoxrQoceuE42bqlVuDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376685; c=relaxed/simple;
	bh=aLcNni8TGAQpZmSKThSn+Y3evyp2AYJjsgvmHFd4l6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGMXpBwy/bMcRy0OK1z9HX3bhERJ4ogh+vxwCUBrOu7H+Rx+VGTW4WCX28zINxHZqeEC8HRoPyEf+sSjGNkrZZH0YjiY7i1D1ZzYgfPlPRAYhlnoMbDhFEbTk6A8iKQvE6A6alWHfyXnrxM8Ik8qPzjuKTJx9BIBRhjlFNfCzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXFDTm8A; arc=none smtp.client-ip=209.85.210.41
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e94d272a86so1310985a34.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376683; x=1782981483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VR1FjK16oQkZqZyukMIT6OmTXvF7+XZOdqzaj1ouRQc=;
        b=TXFDTm8ABgMXsiWxwl3tHqJso9nE1vvSkicp6bGcF0PaOLA3dOa60uaRYzfqjQTLJQ
         EKhT+y5UeGnBl/KLQsikvml7EwQ9muL69McY103wsuRLmXuVx3bYlhCidslDIA7hsLKN
         zgpe0sG4lg+dKbxlu36XCsrOBw40UpJkokceurm8KGY+gqndGAc92ALrV2pC2o+SdRFG
         G7CU+Z+/PNIxhKcRRkAYwa+wf99RT27oqyJxMlRRbLCMZVk7hzzuWDZku/fCHplONkgn
         1UayK2x7bE/Y8Ye68K8DYEbJmqvH9ri4ObeGvTpUD4L6Y88LMvn/I9fB4S93IHry6Vod
         wczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376683; x=1782981483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR1FjK16oQkZqZyukMIT6OmTXvF7+XZOdqzaj1ouRQc=;
        b=ZzT8hA0dXo/UHkKqa1m2T4PktZlTuZD7cUhWJuYDy1fU3ATpTOKmJ4WZqthAVpu0T4
         KC2GiUb0bik81kut0xrk0HMphZDd9prvoyILYaFmVNXeT7p936Ia6eJO1M0HWShhktRI
         S93RNZodPyDnlxRtJQr2RsqNFn7wicVSHc6XKICHO0y5ZFCKTntMCZBL+i/nVm+i6HDl
         745D+63rgCuri4RUZjaidS5+pai7srGLXsFoK/xIU39UJhEcaZS59+H2haC40P8Ixhm1
         5cPpjwgMov4Hhj0wHAgAZHDRIZeDQiCcwphJLo0MDR8fJvKRzeZW2IomwQ307GjUp2oz
         WQZQ==
X-Gm-Message-State: AOJu0Yw0Mt4HnHIufv0+8GjsPqfOG4k0uCpz3p9JMlk8WhvcfXp/gLAm
	fGduzCH32pYURf9agQqAeApyteVakmReavpVDw+ZcqScdDchteG/D7BE
X-Gm-Gg: AfdE7ckSTtMAGSSnFUGPJtaGF3q4oyBHVfZ6B+H12kgZqw9fp9IrIyZTfDPnlbwncBw
	E3xomy8ani+4jJSUJHVpT9ftlPDAuGExGpzHAqMsrplJaSgkOzBPMA6mH/vAHEfOSFvkmkJQF7x
	iQ2TzlUPuEzP+JZNfVxuPJvsAhakY33f6vD+X2Pzk1LyLZ36expAco3w2WVMqhSMFREpZ0dMvEP
	8d+eOqzoxXyHspOKIiO8j7aD8WjzZ9irbUbzjqpDk9q/oVcpX8L//663kkWkdM004HbDXrg0BCc
	TSXFY6KiNo1+39LwO2auyR1XC7urlMoWtV6F6ekUae6f/hGMPfAnLO/gEKdB7Ns2c6ZSWrPSEF0
	B/ejJJsaPjTFpr7YLeDELfFP118SVUizw6Rbg6AmjvQvGEnNKEBrXd1iGnvd/m95x+nK19Uoqb2
	2HTxvDgS3p
X-Received: by 2002:a05:6808:ecb:b0:485:5f3f:bd1b with SMTP id 5614622812f47-4921573e973mr1711339b6e.3.1782376683504;
        Thu, 25 Jun 2026 01:38:03 -0700 (PDT)
Received: from houminxi.lan ([61.170.226.21])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf23ce4sm10448652b6e.9.2026.06.25.01.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:38:02 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH] flex: add ffl_flags validation test
Date: Thu, 25 Jun 2026 16:37:56 +0800
Message-ID: <20260625083756.1799608-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22826-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[houminxi@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:linux-nfs@vger.kernel.org,m:houminxi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 001266C3E72

Add FFFL1 which verifies that the ffl_flags field in the LAYOUTGET
response contains only bits defined in RFC 8435 Section 5.1:
NO_LAYOUTCOMMIT, NO_IO_THRU_MDS, and NO_READ_IO. The three flag
constants were already defined in nfs4_const.py but had no test
coverage.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 nfs4.1/server41tests/st_flex.py | 48 +++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 766b213..96195e5 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -1117,3 +1117,51 @@ def testFlexLayoutReturn100(t, env):
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
+
+def testFlexFlags(t, env):
+    """Verify ffl_flags contains only valid RFC 8435 bits.
+
+    FLAGS: flex
+    CODE: FFFL1
+    """
+    sess = env.c1.new_pnfs_client_session(env.testname(t))
+
+    # Create file
+    res = create_file(sess, env.testname(t))
+    check(res)
+    fh = res.resarray[-1].object
+    open_stateid = res.resarray[-2].stateid
+
+    # LAYOUTGET
+    ops = [op.putfh(fh),
+           op.layoutget(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_RW,
+                        0, 8192, 8192, open_stateid, 0xffff)]
+    res = sess.compound(ops)
+    check(res)
+    lo_stateid = res.resarray[-1].logr_stateid
+
+    # Unpack ff_layout4 and check ffl_flags
+    layout = res.resarray[-1].logr_layout[-1]
+    p = FlexUnpacker(layout.loc_body)
+    opaque = p.unpack_ff_layout4()
+
+    valid_flags = (FF_FLAGS_NO_LAYOUTCOMMIT |
+                   FF_FLAGS_NO_IO_THRU_MDS |
+                   FF_FLAGS_NO_READ_IO)
+    if opaque.ffl_flags & ~valid_flags:
+        t.fail("ffl_flags 0x%x has undefined bits set (valid: 0x%x)"
+               % (opaque.ffl_flags, valid_flags))
+
+    # LAYOUTRETURN
+    ops = [op.putfh(fh),
+           op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
+                           layoutreturn4(LAYOUTRETURN4_FILE,
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                            lo_stateid,
+                                                            empty_p.get_buffer())))]
+    res = sess.compound(ops)
+    check(res)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
-- 
2.54.0


