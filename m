Return-Path: <linux-nfs+bounces-21974-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CRVJX+zFWpxYAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21974-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:51:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A256D5D7F4B
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F2A4301B505
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904133BD62C;
	Tue, 26 May 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="j79BdPRg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8F3DA7EE
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806456; cv=none; b=mHT2U8chD497NzFrEDVxrYAL5Cpn6SPVff0Eh4gb0/HIgFXh/PKm4dafrdJNwKh13eG2SNOuY8stKaMY+ziWpPoXeAGILykbgGLfW6M21CrKDlURDhd7WO0kVYwOt55wtzzZ0kbSf6KMQVzKneBeyV+rVQwZuFPAvlP3+OxGYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806456; c=relaxed/simple;
	bh=napvv/KqfPSozs+8ZK+7xCCyvS2sb5OqeuXcIUdB+aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZNNy6I8Zkoi51wh+xi7n0zJxM1FcJSBdSd6LQZgoBF2kH2gGQ4S3TqXU6AlRayv8BpIu9b588Ed+Dczphjwl/7eSm33iKXL6l4Q+tQH/ZYe0oKBVkcKNQIuB4eBTtpbqYnJyO6jGf50vPxWbHGSTA+fhR3VCXceN3Cvm7GqjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=j79BdPRg; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43bfe209e45so672681fac.0
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779806453; x=1780411253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp5tGwbmQjk9IdWnEMIGuRnn0WuPL/peHZuqx6Du2ts=;
        b=j79BdPRgX3eh9FPyqnS2e2zMtDsY7Nfy/EhCTuW9F8la1fVuUz23NtRW+hoscdHz3S
         HbuGI9lorcLZmf3eva+Cbhy6zBC+oTgoArApZVQGjc07GTR4gmqCGvlnhTGhFhlV4Is2
         V+LmPqh+WMjRiGv0i8HL+CbpvfR5ghnQUZLVGi+Imk2h8bjoiyLlz6T5yoIjz5r/EfhB
         0/itCxozfEyVyRZ3yfEOuBLql5VHhu1BF9BDkgFR8cZYp7eYwud27VPPXvDmcqHGmola
         rPLcmUtYMPe+OhBCgoLb2BQlpIDcR4wPHL2FFkq70mAdwERdmnvH0ETivay6HC6O6MD1
         eG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806453; x=1780411253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tp5tGwbmQjk9IdWnEMIGuRnn0WuPL/peHZuqx6Du2ts=;
        b=KqaEDssk9zKBsu1SZCNOuvGPTpWuqSz4WWoTXSZ4rD6hRcZu/hFdDCxHMDwlEXnBDS
         g536RDGkP+GmLiuNYL8q4k4KIkqY5wn8VYsUE4i5sz8JGaZnCsDAsOYab93LNJsuNyeY
         +rMDvA6pu2SNN8bmsaVXO5mZaocm2l8A5pXFjwvs+DLmko4f3XtR0fSrqwBhZ29R3egU
         vAQawiK9I5FiuFdOTUVHx5qnXBu0ytO/n+mS9xU6TpJW58EalNsDc1QMb2c1ZgW9VZpd
         ynMZyinr00BXZ4UVb5Cb41CjydJN7n1RQTlSuxl0eLnHTI+Oum0CYTHUw7TtWqFm0K/A
         LLlQ==
X-Gm-Message-State: AOJu0YzF3NdHjjP/8Ap9I7zbQzCDu5JAoGMr2I+CZgAhNNBg6HFcDhgx
	/lIm7WKpmfMMObdH5DbWTq14xHu1CvKVS6g44eziPpub1Zny6QeXzUERWFkMhAchfAD7zv4yh06
	hMyDI
X-Gm-Gg: Acq92OEQx8t/TIzwbFunEhw7MbABjwHdmtfysDVfRnW9SfEnEIPhgWEGxObquV438fk
	MCMMngwiN8tV7nSoss+zDIxlL5ZXxZi/indyCUvt1dFWvJqJSpIdUa/MNcsshtJA/qI6tf/uTH7
	BBzrbHBdY5lg9n/z4Q2TqctTVzWcmXE6n+ScaelGeBiTOlRGs77vmAVLnovXId0DCuLXtjt3rkn
	g8y0qGYpLifEK8WTMlP7XsppV0KhrApzRbbfAlVLkx9ms4LCLoCRcnYgYytTJ46BlBWeEpMtTpH
	rQzWV+fCSqAdMA4zHS7Eei9G4WJt39Ys2lpBENBVL+0ljp3y66d45PLAO93lWldtGCtZ1dSxRl3
	8F1qHjv8DDPAdtDcen0pPl0s62jGR+rF8+3Nyxy89St0/bpxJF4LdRhSQiHclu1m574cw1H6MWx
	ptJGPlSJ8y2O1TXGJbX6tUveztELzgDeUBaQtlHeYIin3QMtzGGx2K6Papq2Q=
X-Received: by 2002:a05:6820:2087:b0:696:8ccc:55a0 with SMTP id 006d021491bc7-69d7ec75e81mr8872017eaf.42.1779806453043;
        Tue, 26 May 2026 07:40:53 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63512d63sm13071941fac.2.2026.05.26.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:40:52 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 1/1] nfs-fh-verify: add tool to validate kNFSD filehandle signatures
Date: Tue, 26 May 2026 10:40:49 -0400
Message-ID: <3fa7080b029562aa687ebac6c60e0a01f3f7e65d.1779805943.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779805943.git.bcodding@hammerspace.com>
References: <cover.1779805943.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21974-lists,linux-nfs=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A256D5D7F4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

knfsd optionally signs filehandles with an 8-byte SipHash-2-4 MAC for
exports marked with the sign_fh option (see fs/nfsd/nfsfh.c, kernel
commit 2a83ffc55750).  When triaging captures or filehandle issues it is
useful to confirm offline that a given filehandle's MAC verifies under
the same key the running server was configured with.

Add a small standalone utility, nfs-fh-verify, that:

  - reads filehandles in ASCII hex from stdin (one per line, tolerant of
    "0x" prefixes, ':' or whitespace separators, '#' comments, and
    mixed case);
  - derives the 128-bit SipHash key from a key file using the existing
    hash_fh_key_file() helper, matching what nfsdctl pushes to the
    kernel via NFSD_A_SERVER_FH_KEY;
  - recomputes the trailing 8-byte MAC over fh[0..n-8] and reports
    OK, BAD, or MALFORMED for each filehandle;
  - exits 0 if every parsed filehandle verified, 1 on any BAD/MALFORMED,
    or 2 on setup error.

The SipHash-2-4 implementation is embedded as a small reference port of
the kernel's lib/siphash.c, validated at startup against two published
Aumasson/Bernstein test vectors so that an incorrect build refuses to
emit verdicts rather than silently mis-reporting.

Wired in behind --disable-nfs-fh-verify (default on), mirroring the
existing nfsrahead pattern.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>
---
 configure.ac                          |   7 +
 tools/Makefile.am                     |   4 +
 tools/nfs-fh-verify/Makefile.am       |  10 +
 tools/nfs-fh-verify/main.c            | 337 ++++++++++++++++++++++++++
 tools/nfs-fh-verify/nfs-fh-verify.man | 171 +++++++++++++
 5 files changed, 529 insertions(+)
 create mode 100644 tools/nfs-fh-verify/Makefile.am
 create mode 100644 tools/nfs-fh-verify/main.c
 create mode 100644 tools/nfs-fh-verify/nfs-fh-verify.man

diff --git a/configure.ac b/configure.ac
index 8ca06fd62b47..1fc8f8cb9552 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,6 +247,12 @@ AC_ARG_ENABLE(nfsrahead,
 		PKG_CHECK_MODULES([LIBMOUNT], [mount])
 	fi
 
+AC_ARG_ENABLE(nfs-fh-verify,
+	[AS_HELP_STRING([--disable-nfs-fh-verify],[disable nfs-fh-verify command @<:@default=no@:>@])],
+	enable_nfs_fh_verify=$enableval,
+	enable_nfs_fh_verify="yes")
+	AM_CONDITIONAL(CONFIG_NFS_FH_VERIFY, [test "$enable_nfs_fh_verify" = "yes" ])
+
 AC_ARG_ENABLE(nfsdcltrack,
 	[AS_HELP_STRING([--enable-nfsdcltrack],[enable NFSv4 clientid tracking programs @<:@default=no@:>@])],
 	enable_nfsdcltrack=$enableval,
@@ -753,6 +759,7 @@ AC_CONFIG_FILES([
 	tools/mountstats/Makefile
 	tools/nfs-iostat/Makefile
 	tools/nfsrahead/Makefile
+	tools/nfs-fh-verify/Makefile
 	tools/rpcctl/Makefile
 	tools/nfsdclnts/Makefile
 	tools/nfsconf/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 48fd0cdf1f83..4478b3cfd664 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -16,6 +16,10 @@ if CONFIG_NFSRAHEAD
 OPTDIRS += nfsrahead
 endif
 
+if CONFIG_NFS_FH_VERIFY
+OPTDIRS += nfs-fh-verify
+endif
+
 SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/nfs-fh-verify/Makefile.am b/tools/nfs-fh-verify/Makefile.am
new file mode 100644
index 000000000000..6403d9b9cab7
--- /dev/null
+++ b/tools/nfs-fh-verify/Makefile.am
@@ -0,0 +1,10 @@
+## Process this file with automake to produce Makefile.in
+
+sbin_PROGRAMS = nfs-fh-verify
+nfs_fh_verify_SOURCES = main.c
+nfs_fh_verify_LDADD = ../../support/nfs/libnfs.la
+
+man8_MANS = nfs-fh-verify.man
+EXTRA_DIST = $(man8_MANS)
+
+MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/nfs-fh-verify/main.c b/tools/nfs-fh-verify/main.c
new file mode 100644
index 000000000000..389d1765ba60
--- /dev/null
+++ b/tools/nfs-fh-verify/main.c
@@ -0,0 +1,337 @@
+/*
+ * nfs-fh-verify - Verify NFS filehandle signatures produced by knfsd.
+ *
+ * Reads filehandles in ASCII hex from stdin (one per line) and, using a
+ * filehandle signing key file, reports whether the trailing 8-byte
+ * SipHash-2-4 MAC verifies under that key.
+ *
+ * Mirrors the kernel signing layout in fs/nfsd/nfsfh.c (commit 2a83ffc55750)
+ * and the key derivation in support/nfs/fh_key_file.c.
+ */
+#include "config.h"
+
+#include <ctype.h>
+#include <endian.h>
+#include <errno.h>
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <uuid/uuid.h>
+
+#include "nfslib.h"
+#include "xlog.h"
+
+#define FH_MAC_LEN	8
+#define FH_MAX_LEN	128	/* NFSv3=64, NFSv4=128 */
+
+/*
+ * SipHash-2-4. Matches lib/siphash.c in the kernel byte-for-byte:
+ * 2 compression rounds per 64-bit block, 4 finalization rounds, length
+ * in the high byte of the final word, output v0^v1^v2^v3.
+ */
+static inline uint64_t rotl64(uint64_t x, int b)
+{
+	return (x << b) | (x >> (64 - b));
+}
+
+#define SIPROUND do {							\
+	v0 += v1; v1 = rotl64(v1, 13); v1 ^= v0; v0 = rotl64(v0, 32);	\
+	v2 += v3; v3 = rotl64(v3, 16); v3 ^= v2;			\
+	v0 += v3; v3 = rotl64(v3, 21); v3 ^= v0;			\
+	v2 += v1; v1 = rotl64(v1, 17); v1 ^= v2; v2 = rotl64(v2, 32);	\
+} while (0)
+
+static uint64_t load_le64(const uint8_t *p)
+{
+	return  (uint64_t)p[0]        | ((uint64_t)p[1] <<  8) |
+	       ((uint64_t)p[2] << 16) | ((uint64_t)p[3] << 24) |
+	       ((uint64_t)p[4] << 32) | ((uint64_t)p[5] << 40) |
+	       ((uint64_t)p[6] << 48) | ((uint64_t)p[7] << 56);
+}
+
+static uint64_t siphash24(const uint8_t *data, size_t len,
+			  uint64_t k0, uint64_t k1)
+{
+	uint64_t v0 = 0x736f6d6570736575ULL ^ k0;
+	uint64_t v1 = 0x646f72616e646f6dULL ^ k1;
+	uint64_t v2 = 0x6c7967656e657261ULL ^ k0;
+	uint64_t v3 = 0x7465646279746573ULL ^ k1;
+	uint64_t b = ((uint64_t)len) << 56;
+	const uint8_t *end = data + (len & ~(size_t)7);
+	size_t left = len & 7;
+	uint64_t m;
+
+	for (; data != end; data += 8) {
+		m = load_le64(data);
+		v3 ^= m;
+		SIPROUND;
+		SIPROUND;
+		v0 ^= m;
+	}
+
+	switch (left) {
+	case 7: b |= ((uint64_t)data[6]) << 48; /* fallthrough */
+	case 6: b |= ((uint64_t)data[5]) << 40; /* fallthrough */
+	case 5: b |= ((uint64_t)data[4]) << 32; /* fallthrough */
+	case 4: b |= ((uint64_t)data[3]) << 24; /* fallthrough */
+	case 3: b |= ((uint64_t)data[2]) << 16; /* fallthrough */
+	case 2: b |= ((uint64_t)data[1]) <<  8; /* fallthrough */
+	case 1: b |= ((uint64_t)data[0]);
+		break;
+	case 0:
+		break;
+	}
+
+	v3 ^= b;
+	SIPROUND;
+	SIPROUND;
+	v0 ^= b;
+	v2 ^= 0xff;
+	SIPROUND;
+	SIPROUND;
+	SIPROUND;
+	SIPROUND;
+	return v0 ^ v1 ^ v2 ^ v3;
+}
+
+/*
+ * Two well-known SipHash-2-4 reference vectors (Aumasson/Bernstein) with
+ * key = bytes 0x00..0x0f. Verifies the embedded implementation at startup;
+ * if this fails we refuse to run rather than emit wrong verdicts.
+ */
+static int siphash_self_test(void)
+{
+	static const uint8_t key[16] = {
+		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	};
+	static const uint8_t msg15[15] = {
+		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
+		0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+	};
+	uint64_t k0 = load_le64(key);
+	uint64_t k1 = load_le64(key + 8);
+	uint64_t got;
+
+	got = siphash24(NULL, 0, k0, k1);
+	if (got != 0x726fdb47dd0e0e31ULL) {
+		fprintf(stderr,
+			"nfs-fh-verify: siphash self-test failed (len=0): %016lx\n",
+			(unsigned long)got);
+		return -1;
+	}
+	got = siphash24(msg15, sizeof(msg15), k0, k1);
+	if (got != 0xa129ca6149be45e5ULL) {
+		fprintf(stderr,
+			"nfs-fh-verify: siphash self-test failed (len=15): %016lx\n",
+			(unsigned long)got);
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * Parse one filehandle line into a byte buffer.
+ *
+ * Accepts: optional "0x" prefix; hex pairs optionally separated by ':' or
+ * whitespace; '#' starts a comment; blank lines yield len=0.
+ *
+ * Returns 0 on success and sets *len, or -1 with errno set on bad input.
+ */
+static int parse_hex_fh(const char *line, uint8_t *out, size_t max,
+			size_t *len)
+{
+	const char *p = line;
+	size_t n = 0;
+	int hi = -1;
+
+	while (*p && isspace((unsigned char)*p))
+		p++;
+	if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X'))
+		p += 2;
+
+	for (; *p; p++) {
+		unsigned char c = (unsigned char)*p;
+		int v;
+
+		if (c == '#' || c == '\n' || c == '\r')
+			break;
+		if (isspace(c) || c == ':')
+			continue;
+
+		if (c >= '0' && c <= '9')
+			v = c - '0';
+		else if (c >= 'a' && c <= 'f')
+			v = c - 'a' + 10;
+		else if (c >= 'A' && c <= 'F')
+			v = c - 'A' + 10;
+		else {
+			errno = EINVAL;
+			return -1;
+		}
+
+		if (hi < 0) {
+			hi = v;
+		} else {
+			if (n >= max) {
+				errno = E2BIG;
+				return -1;
+			}
+			out[n++] = (uint8_t)((hi << 4) | v);
+			hi = -1;
+		}
+	}
+
+	if (hi >= 0) {
+		errno = EINVAL;	/* odd nibble count */
+		return -1;
+	}
+	*len = n;
+	return 0;
+}
+
+static void print_hex(FILE *f, const uint8_t *buf, size_t len)
+{
+	for (size_t i = 0; i < len; i++)
+		fprintf(f, "%02x", buf[i]);
+}
+
+static void usage(FILE *f, const char *prog)
+{
+	fprintf(f,
+"Usage: %s -k <fh-key-file> [-q] [-v]\n"
+"\n"
+"  Reads NFS filehandles in ASCII hex from stdin, one per line, and\n"
+"  reports whether each filehandle's trailing 8-byte SipHash-2-4 MAC\n"
+"  verifies under the key derived from <fh-key-file>.\n"
+"\n"
+"Options:\n"
+"  -k FILE   Filehandle signing key file (same file passed to nfsdctl).\n"
+"  -q        Quiet: print just OK/BAD/MALFORMED per line.\n"
+"  -v        Verbose: also print computed MAC and trailing MAC bytes.\n"
+"  -h        Show this help.\n"
+"\n"
+"Input format:\n"
+"  Hex chars per filehandle, one filehandle per line. Optional \"0x\"\n"
+"  prefix; ':' and whitespace between hex pairs ignored; '#' starts a\n"
+"  comment; blank lines are skipped.\n"
+"\n"
+"Exit status:\n"
+"  0  every parsed filehandle verified OK\n"
+"  1  any BAD or MALFORMED verdict\n"
+"  2  setup error (key file unreadable, bad usage, etc.)\n",
+		prog);
+}
+
+int main(int argc, char **argv)
+{
+	const char *keyfile = NULL;
+	bool quiet = false;
+	bool verbose = false;
+	uuid_t key_uuid;
+	uint64_t k0, k1;
+	char *line = NULL;
+	size_t cap = 0;
+	ssize_t nread;
+	int rc, opt;
+	int saw_bad = 0;
+
+	xlog_stderr(1);
+	xlog_syslog(0);
+	xlog_open("nfs-fh-verify");
+
+	while ((opt = getopt(argc, argv, "k:qvh")) != -1) {
+		switch (opt) {
+		case 'k': keyfile = optarg; break;
+		case 'q': quiet = true; break;
+		case 'v': verbose = true; break;
+		case 'h': usage(stdout, argv[0]); return 0;
+		default:  usage(stderr, argv[0]); return 2;
+		}
+	}
+	if (!keyfile) {
+		fprintf(stderr, "nfs-fh-verify: -k <fh-key-file> is required\n");
+		usage(stderr, argv[0]);
+		return 2;
+	}
+	if (optind != argc) {
+		fprintf(stderr, "nfs-fh-verify: unexpected positional argument\n");
+		return 2;
+	}
+
+	if (siphash_self_test() != 0)
+		return 2;
+
+	rc = hash_fh_key_file(keyfile, key_uuid);
+	if (rc != 0) {
+		/* hash_fh_key_file() already logged via xlog */
+		return 2;
+	}
+
+	k0 = load_le64(key_uuid);
+	k1 = load_le64(key_uuid + 8);
+
+	if (verbose) {
+		char ustr[37];
+		uuid_unparse(key_uuid, ustr);
+		fprintf(stderr, "key uuid: %s  k0=%016lx k1=%016lx\n",
+			ustr, (unsigned long)k0, (unsigned long)k1);
+	}
+
+	while ((nread = getline(&line, &cap, stdin)) != -1) {
+		uint8_t fh[FH_MAX_LEN];
+		size_t fh_len = 0;
+		const char *verdict;
+		uint64_t mac, trailing;
+
+		if (parse_hex_fh(line, fh, sizeof(fh), &fh_len) != 0) {
+			saw_bad = 1;
+			if (!quiet)
+				fputs(line, stdout);
+			printf("MALFORMED (%s)\n",
+			       errno == E2BIG ? "filehandle too long"
+					      : "bad hex");
+			continue;
+		}
+		if (fh_len == 0)
+			continue;	/* blank/comment line */
+		if (fh_len <= FH_MAC_LEN) {
+			saw_bad = 1;
+			if (!quiet) {
+				print_hex(stdout, fh, fh_len);
+				putchar(' ');
+			}
+			printf("MALFORMED (too short for MAC)\n");
+			continue;
+		}
+
+		mac = siphash24(fh, fh_len - FH_MAC_LEN, k0, k1);
+		trailing = load_le64(fh + fh_len - FH_MAC_LEN);
+		verdict = (mac == trailing) ? "OK" : "BAD";
+		if (verdict[0] == 'B')
+			saw_bad = 1;
+
+		if (!quiet) {
+			print_hex(stdout, fh, fh_len);
+			putchar(' ');
+		}
+		fputs(verdict, stdout);
+		if (verbose)
+			printf(" expected=%016lx got=%016lx",
+			       (unsigned long)mac, (unsigned long)trailing);
+		putchar('\n');
+	}
+
+	free(line);
+	if (ferror(stdin)) {
+		fprintf(stderr, "nfs-fh-verify: error reading stdin: %s\n",
+			strerror(errno));
+		return 2;
+	}
+	return saw_bad ? 1 : 0;
+}
diff --git a/tools/nfs-fh-verify/nfs-fh-verify.man b/tools/nfs-fh-verify/nfs-fh-verify.man
new file mode 100644
index 000000000000..dc3594cafd17
--- /dev/null
+++ b/tools/nfs-fh-verify/nfs-fh-verify.man
@@ -0,0 +1,171 @@
+.\" Manpage for nfs-fh-verify.
+.nh
+.ad l
+.TH NFS-FH-VERIFY 8 "20 May 2026" "nfs-utils" "System Manager's Manual"
+.SH NAME
+nfs-fh-verify \- verify NFS filehandle signatures produced by knfsd
+
+.SH SYNOPSIS
+.B nfs-fh-verify
+.B \-k
+.I fh-key-file
+.RB [ \-q ]
+.RB [ \-v ]
+
+.SH DESCRIPTION
+.B nfs-fh-verify
+reads NFS filehandles in ASCII hex from standard input, one filehandle per
+line, and reports whether each filehandle's trailing 8-byte SipHash-2-4
+Message Authentication Code (MAC) verifies under the key derived from
+.IR fh-key-file .
+It is intended for offline analysis of filehandles captured from network
+traces, for example with tcpdump(8) or tshark(1).
+
+The kernel NFS server (knfsd) optionally appends a SipHash-2-4 MAC to
+filehandles for exports marked with the
+.B sign_fh
+export option. The MAC is keyed by a 128-bit secret derived from a key
+file passed to the server via
+.BR nfsdctl (8).
+This tool reproduces that key derivation and MAC computation so that
+filehandles can be validated without involving the running server.
+
+.SH OPTIONS
+.TP
+.BI \-k " fh-key-file"
+Path to the filehandle signing key file. This is the same file passed to
+.B nfsdctl
+and configured via the
+.B fh-key-file
+setting in
+.BR nfsd (7).
+The file's contents are hashed (SHA-1) into a 16-byte key that is then
+interpreted as a SipHash-2-4 key.
+.TP
+.B \-q
+Quiet mode: print only the per-filehandle verdict
+.RB ( OK ", " BAD ", or " MALFORMED ),
+suppressing the input hex.
+.TP
+.B \-v
+Verbose mode: also print the computed MAC and the trailing 8 MAC bytes
+extracted from each filehandle, in hex. Useful when debugging captures or
+disagreements between client and server.
+.TP
+.B \-h
+Show usage and exit.
+
+.SH INPUT FORMAT
+One filehandle per line. Each line may contain:
+.IP \(bu 2
+An optional
+.B 0x
+prefix.
+.IP \(bu 2
+Hex digits in upper or lower case.
+.IP \(bu 2
+.B ":"
+or whitespace between byte pairs (ignored).
+.IP \(bu 2
+A
+.B "#"
+to start a trailing comment.
+.PP
+Blank lines and comment-only lines are skipped. An odd number of hex
+nibbles, a non-hex character, or a filehandle longer than the NFSv4
+maximum (128 bytes) is reported as
+.BR MALFORMED .
+
+.SH VERDICTS
+.TP
+.B OK
+The last 8 bytes of the filehandle match
+.BR siphash24 ( fh [0..n\-8] ", " key ).
+.TP
+.B BAD
+The MAC does not verify. The filehandle was either signed with a
+different key, tampered with, or never signed at all (note: signing is
+per-export, so an unsigned filehandle from an export without
+.B sign_fh
+will also appear as
+.BR BAD ).
+.TP
+.B MALFORMED
+The line could not be parsed as a hex filehandle, or was too short to
+contain an 8-byte MAC.
+
+.SH EXIT STATUS
+.TP
+.B 0
+Every parsed filehandle verified
+.BR OK .
+.TP
+.B 1
+At least one filehandle was
+.B BAD
+or
+.BR MALFORMED .
+.TP
+.B 2
+Setup error: bad usage, key file unreadable, internal self-test failure.
+
+.SH EXAMPLES
+Watch live traffic on the loopback interface and verify every filehandle
+as it goes by \(em a quick way to confirm that an export is actually
+signing filehandles:
+.PP
+.RS 4
+.nf
+$ tshark \-i lo \-T fields \-E separator=\\n \-e nfs.fhandle \\
+    | nfs\-fh\-verify \-k /etc/nfs_fh.key
+.fi
+.RE
+.PP
+Capturing on the loopback interface
+.RB ( "\-i lo" )
+only sees NFS traffic when the server has mounted one of its own exports,
+so that client and server are the same host. To check filehandles handed
+out to a remote client, capture on the interface that carries the NFS
+traffic instead (for example
+.BR "\-i eth0" ).
+.PP
+The
+.B nfs.fhandle
+field carries the raw filehandle for both NFSv3 and NFSv4, and
+.B "\-E separator=\en"
+puts each filehandle on its own line so that responses carrying more than
+one filehandle are checked individually.
+.PP
+Verify filehandles extracted from a saved capture:
+.PP
+.RS 4
+.nf
+$ tshark \-r capture.pcap \-Y nfs \-T fields \-E separator=\\n \\
+    \-e nfs.fhandle | nfs\-fh\-verify \-k /etc/nfs_fh.key
+.fi
+.RE
+.PP
+Summarize the verdicts over a large capture:
+.PP
+.RS 4
+.nf
+$ tshark \-r capture.pcap \-T fields \-E separator=\\n \-e nfs.fhandle \\
+    | nfs\-fh\-verify \-q \-k /etc/nfs_fh.key | sort | uniq \-c
+.fi
+.RE
+.PP
+Inline check of one filehandle with debug output:
+.PP
+.RS 4
+.nf
+$ echo 0x01000601...deadbeef | nfs\-fh\-verify \-v \-k /etc/nfs_fh.key
+.fi
+.RE
+
+.SH SEE ALSO
+.BR nfsdctl (8),
+.BR exportfs (8),
+.BR exports (5).
+
+.SH AUTHORS
+Written for the nfs-utils project.
-- 
2.53.0


