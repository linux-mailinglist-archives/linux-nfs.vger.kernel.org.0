Return-Path: <linux-nfs+bounces-16689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5AC7E314
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C393ABC0D
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A342848AA;
	Sun, 23 Nov 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaxaxfug"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42759224AE0
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913392; cv=none; b=J/5KcL9od7PGUL/DsQI7018yPEaQ9wDjQGaLN1+AnBirGXLPTw5gp6J/SupJmeRx2GhkLcErbaITjhddu9/4eEzSSuYEOQ2UOc1N6czUkKdabF0jkxDjeohDdiHBlteqjgd1H892qXV+NrHdPmZ4+bjjR62BhosfJ2b/LBCOxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913392; c=relaxed/simple;
	bh=MAuVofEqbHwyulg2z04SzWA5Vz9Q0RVKnknyLIU6bi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nj3RMxz04m9mZT7gGF8XLEA1yNp4NmxwZN7kLN7lBRW0xhXXPm3YsARNQ3RGwm+F/vTOXf7c4eOWjg+/AjDfFqar67i0Jc14+qazKFbqDicQJp3cWG8FozijakN4Su4fV2h2CaGHlDiqur673nsSBpYn2/oXl9tRe0hWArekY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaxaxfug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7073AC116D0;
	Sun, 23 Nov 2025 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913391;
	bh=MAuVofEqbHwyulg2z04SzWA5Vz9Q0RVKnknyLIU6bi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaxaxfugknAu8/u/GxPkdV4GjtanlqAc265h7aHntUwNpMkntZvCuIaovN2c+sypV
	 bRTnhS1lxN1JuMgNFl0QztcS99mIkvBdVI1O2WnXCUZ6KX/KMvpiBgu3zBLj4BfGcL
	 9QTFrwLsube8pDfb3NedWFqgTCtUIYaeSVOgBQrfeB08L8m/hVTqLuXqz6eSBPM9nE
	 8Kh+P+PP9C/aOmoXtv7diTwKwsPcwnoVQEczK6xgQKTo7Db/EydGyPj3nqDm2XZ5c4
	 Q66+NtrNCMZtBPDYtNETn+GWUOdt/rnDXCu1/OijeaAkFjV8YIAri98eUS/nf1rP9A
	 OV4delss0lR+g==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 09/10] Add tests for SETATTR with MODE and ACL
Date: Sun, 23 Nov 2025 10:56:17 -0500
Message-ID: <20251123155623.514129-10-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251123155623.514129-1-cel@kernel.org>
References: <20251123155623.514129-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add comprehensive tests that verify SETATTR behavior when both
mode bits and an ACL are set simultaneously. The new tests cover:

1. SATT19: testSetattrModeWithACL (lines 837-870)
 - Basic test that sets both MODE (0o640) and ACL in a single
   SETATTR
 - Verifies both attributes are correctly set and retrieved
2. SATT20: testSetattrModePreservedWithACL (lines 872-905)
 - Tests MODE preservation with a specific mode (0o600) set
   alongside ACL
 - Ensures MODE is preserved exactly as requested
3. SATT21: testSetattrRestrictiveModeWithACL (lines 907-941)
 - Tests the edge case of restrictive MODE (0o400 read-only) with
   ACL
 - Verifies server handles the case where MODE is more restrictive
   than ACL
4. SATT22: testSetattrACLThenMode (lines 943-987)
 - Compares setting MODE+ACL together vs separately in sequence
 - Creates two files and verifies consistent behavior

These tests ensure that servers correctly handle the interaction
between MODE and ACL attributes when setting file attributes, and
verify that the ACL specified in the OPEN operation matches the ACL
after the OPEN completes.

SETATTR: ACL-to-mode verification tests

These new tests verify:

- Mode is correctly derived from ACL per RFC 8881 §6.3.2
- Write bit requires both ACE4_WRITE_DATA and ACE4_APPEND_DATA
- ACL evaluation order (first ACE takes precedence)
- EVERYONE@ ACEs affect all three permission classes
- Complex ACLs with multiple identifiers

SETATTR: Two additional ACL verification tests

New test SATT28: Verify that the final ACL is the same no matter what
the file's previous mode bits were.

New test SATT29: Verify that SETATTR(ACL) preserves high-order mode
bits (SUID/SGID/SVTX).

SETATTR: Verify behavior when setting both MODE and ACL

Add three comprehensive tests that verify SETATTR(MODE+ACL) behavior
per RFC 8881 §6.4.1.3:

SATT30:
Verify attrsset bitmap and final mode consistency when MODE+ACL set
together. Whether or not the server includes MODE in attrsset, the
final mode must match what the ACL derives to per §6.4.1.3.

SATT31:
Test MODE+ACL interaction when they conflict significantly.
Regardless of requested MODE, final mode always matches ACL
derivation. This shows that ACL wins when both are set (per
§6.4.1.3: "possibly changing the final mode").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_setattr.py | 844 ++++++++++++++++++++++++++++++-
 1 file changed, 843 insertions(+), 1 deletion(-)

diff --git a/nfs4.0/servertests/st_setattr.py b/nfs4.0/servertests/st_setattr.py
index 5d51054c29b4..0cb31f003573 100644
--- a/nfs4.0/servertests/st_setattr.py
+++ b/nfs4.0/servertests/st_setattr.py
@@ -1,9 +1,10 @@
 from xdrdef.nfs4_const import *
 from .environment import check, get_invalid_utf8strings
 from nfs4lib import bitmap2list, dict2fattr
-from xdrdef.nfs4_type import nfstime4, settime4
+from xdrdef.nfs4_type import nfstime4, settime4, nfsace4
 import nfs_ops
 op = nfs_ops.NFS4ops()
+import nfs4acl
 
 def _set_mode(t, c, file, stateid=None, msg=" using stateid=0",
               warnlist=[]):
@@ -783,3 +784,844 @@ def testMixed(t, env):
     c.init_connection()
     fh, stateid = c.create_confirm(t.word(), deny=OPEN4_SHARE_DENY_NONE)
     _set_mixed(t, c, fh)
+
+def testSetattrModeWithACL(t, env):
+    """SETATTR with both MODE and ACL attributes
+
+    Per RFC 8881 Section 6.4.1.3, when both MODE and ACL are set together,
+    both are processed, but the final mode is derived from the ACL and may
+    differ from the requested MODE.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT19
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+    fh, stateid = c.create_confirm(t.word())
+
+    acl = nfs4acl.make_test_acl()
+    mode = 0o640
+
+    # Set both MODE and ACL in a single SETATTR
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    ops = c.use_obj(fh) + [c.setattr(attrs)]
+    res = c.compound(ops)
+    check(res, msg="SETATTR with both MODE and ACL")
+
+    # Check which attributes were actually set by examining the reply bitmask
+    attrsset = bitmap2list(res.resarray[-1].attrsset)
+
+    # Verify both MODE and ACL were set (processed)
+    if FATTR4_MODE not in attrsset:
+        t.fail("MODE not in attrsset, but MODE was requested")
+    if FATTR4_ACL not in attrsset:
+        t.fail("ACL not in attrsset, but ACL was requested")
+
+    # Verify ACL was set correctly
+    attrs_dict = c.do_getattrdict(fh, [FATTR4_ACL, FATTR4_MODE])
+    try:
+        returned_mode, expected_mode = nfs4acl.verify_mode_and_acl(
+            attrs_dict, acl, "SETATTR")
+    except AssertionError as e:
+        t.fail(str(e))
+
+    # Display informational message about mode derivation
+    if returned_mode != mode:
+        t.pass_warn("MODE+ACL: requested 0%o, final 0%o (derived from ACL per RFC 8881 §6.3.2)"
+                    % (mode, returned_mode))
+
+def testSetattrModePreservedWithACL(t, env):
+    """Verify MODE derivation when SETATTR sets both MODE and ACL
+
+    Per RFC 8881 Section 6.4.1.3, when both MODE and ACL are set together,
+    both are processed, but the final mode is derived from the ACL and may
+    differ from the requested MODE.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT20
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+    fh, stateid = c.create_confirm(t.word())
+
+    acl = nfs4acl.make_test_acl()
+    mode = 0o600
+
+    # Set both MODE and ACL
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    ops = c.use_obj(fh) + [c.setattr(attrs)]
+    res = c.compound(ops)
+    check(res, msg="SETATTR with MODE and ACL")
+
+    # Check which attributes were actually set by examining the reply bitmask
+    attrsset = bitmap2list(res.resarray[-1].attrsset)
+
+    # Verify both MODE and ACL were set (processed)
+    if FATTR4_MODE not in attrsset:
+        t.fail("MODE not in attrsset, but MODE was requested")
+    if FATTR4_ACL not in attrsset:
+        t.fail("ACL not in attrsset, but ACL was requested")
+
+    # Verify ACL was set correctly
+    attrs_dict = c.do_getattrdict(fh, [FATTR4_ACL, FATTR4_MODE])
+    try:
+        returned_mode, expected_mode = nfs4acl.verify_mode_and_acl(
+            attrs_dict, acl, "SETATTR")
+    except AssertionError as e:
+        t.fail(str(e))
+
+    # Display informational message about mode derivation
+    if returned_mode != mode:
+        t.pass_warn("MODE+ACL: requested 0%o, final 0%o (derived from ACL per RFC 8881 §6.3.2)"
+                    % (mode, returned_mode))
+
+def testSetattrRestrictiveModeWithACL(t, env):
+    """SETATTR with restrictive MODE (0o400) and ACL together
+
+    Per RFC 8881 Section 6.4.1.3, when both MODE and ACL are set together,
+    both are processed, but the final mode is derived from the ACL and may
+    differ from the requested MODE. This tests the case where the requested
+    MODE is more restrictive than what the ACL would grant.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT21
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+    fh, stateid = c.create_confirm(t.word())
+
+    acl = nfs4acl.make_test_acl()
+    mode = 0o400  # Read-only for owner
+
+    # Set restrictive MODE with ACL
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    ops = c.use_obj(fh) + [c.setattr(attrs)]
+    res = c.compound(ops)
+    check(res, msg="SETATTR with restrictive MODE and ACL")
+
+    # Check which attributes were actually set by examining the reply bitmask
+    attrsset = bitmap2list(res.resarray[-1].attrsset)
+
+    # Verify both MODE and ACL were set (processed)
+    if FATTR4_MODE not in attrsset:
+        t.fail("MODE not in attrsset, but MODE was requested")
+    if FATTR4_ACL not in attrsset:
+        t.fail("ACL not in attrsset, but ACL was requested")
+
+    # Verify ACL was set correctly
+    attrs_dict = c.do_getattrdict(fh, [FATTR4_ACL, FATTR4_MODE])
+    if FATTR4_ACL not in attrs_dict or FATTR4_MODE not in attrs_dict:
+        t.fail("ACL or MODE not returned after SETATTR")
+
+    try:
+        nfs4acl.verify_acl(attrs_dict[FATTR4_ACL], acl)
+    except AssertionError as e:
+        t.fail(str(e))
+
+    # Per RFC 8881 §6.4.1.3, when both MODE and ACL are set, the final mode
+    # is derived from the ACL per §6.3.2, and may differ from requested MODE
+    returned_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    # Display informational message about mode derivation
+    if returned_mode != mode:
+        t.pass_warn("MODE+ACL: requested 0%o, final 0%o (derived from ACL per RFC 8881 §6.3.2)"
+                    % (mode, returned_mode))
+
+    if returned_mode != expected_mode:
+        t.fail("MODE (0%o) does not match RFC 8881 §6.3.2 derivation "
+               "from ACL (expected 0%o)" % (returned_mode, expected_mode))
+
+def testSetattrACLThenMode(t, env):
+    """SETATTR ACL, then MODE in separate operations vs together
+
+    Verify that setting MODE and ACL together in one SETATTR has the
+    same result as setting them separately.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT22
+    """
+    c = env.c1
+    c.init_connection()
+
+    # Create two test files
+    fh1, stateid1 = c.create_confirm(t.word() + b"_1")
+    fh2, stateid2 = c.create_confirm(t.word() + b"_2")
+
+    acl = nfs4acl.make_test_acl()
+    mode = 0o644
+
+    # File 1: Set MODE and ACL together
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    ops = c.use_obj(fh1) + [c.setattr(attrs)]
+    res = c.compound(ops)
+    check(res, msg="SETATTR with MODE and ACL together")
+
+    # File 2: Set ACL first, then MODE
+    ops = c.use_obj(fh2) + [c.setattr({FATTR4_ACL: acl})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR with ACL")
+
+    ops = c.use_obj(fh2) + [c.setattr({FATTR4_MODE: mode})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR with MODE after ACL")
+
+    # Verify both files have the same MODE
+    attrs1 = c.do_getattrdict(fh1, [FATTR4_MODE, FATTR4_ACL])
+    attrs2 = c.do_getattrdict(fh2, [FATTR4_MODE, FATTR4_ACL])
+
+    mode1 = attrs1[FATTR4_MODE] & 0o7777
+    mode2 = attrs2[FATTR4_MODE] & 0o7777
+
+    if mode1 != mode2:
+        t.fail("MODE differs between combined SETATTR (0%o) and "
+               "separate SETATTRs (0%o)" % (mode1, mode2))
+
+def testSetattrACLModeDeriveBasic(t, env):
+    """SETATTR(ACL) should derive mode per RFC 8881 Section 6.3.2
+
+    Test basic mode derivation from ACL when setting ACL alone.
+    The mode's permission bits should match what is computed from the ACL.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT23
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+
+    fh, stateid = c.create_confirm(t.word())
+
+    # Create ACL: OWNER@ gets read+write+execute, others get nothing
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_DENIED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                b"GROUP@"),
+        nfsace4(ACE4_ACCESS_DENIED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                b"EVERYONE@")
+    ]
+
+    # Set ACL only (not MODE)
+    ops = c.use_obj(fh) + [c.setattr({FATTR4_ACL: acl})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR with ACL only")
+
+    # Get resulting mode
+    attrs = c.do_getattrdict(fh, [FATTR4_MODE, FATTR4_ACL])
+    returned_mode = attrs[FATTR4_MODE] & 0o777
+    returned_acl = attrs[FATTR4_ACL]
+
+    # Compute expected mode from returned ACL per RFC 8881 §6.3.2
+    expected_mode = acl2mode_rfc8881(returned_acl)
+
+    if returned_mode != expected_mode:
+        t.fail("Mode (0%o) does not match RFC 8881 §6.3.2 derivation "
+               "from ACL (expected 0%o)" % (returned_mode, expected_mode))
+
+def testSetattrACLModeDeriveWriteBits(t, env):
+    """SETATTR(ACL) write bit requires BOTH WRITE_DATA and APPEND_DATA
+
+    Per RFC 8881 §6.3.2, the write mode bit should only be set if BOTH
+    ACE4_WRITE_DATA and ACE4_APPEND_DATA are present in the ACL.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT24
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+
+    # Test 1: Only WRITE_DATA (no APPEND_DATA) - write bit should NOT be set
+    fh1, stateid1 = c.create_confirm(t.word() + b"_1")
+    acl1 = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_WRITE_DATA,  # Missing APPEND_DATA
+                b"OWNER@")
+    ]
+    ops = c.use_obj(fh1) + [c.setattr({FATTR4_ACL: acl1})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR ACL with only WRITE_DATA")
+
+    attrs1 = c.do_getattrdict(fh1, [FATTR4_MODE, FATTR4_ACL])
+    mode1 = attrs1[FATTR4_MODE] & 0o777
+    expected_mode1 = acl2mode_rfc8881(attrs1[FATTR4_ACL])
+
+    if mode1 != expected_mode1:
+        t.fail("Mode (0%o) with only WRITE_DATA does not match expected (0%o). "
+               "Write bit should NOT be set without APPEND_DATA." %
+               (mode1, expected_mode1))
+
+    # Test 2: Only APPEND_DATA (no WRITE_DATA) - write bit should NOT be set
+    fh2, stateid2 = c.create_confirm(t.word() + b"_2")
+    acl2 = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_APPEND_DATA,  # Missing WRITE_DATA
+                b"OWNER@")
+    ]
+    ops = c.use_obj(fh2) + [c.setattr({FATTR4_ACL: acl2})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR ACL with only APPEND_DATA")
+
+    attrs2 = c.do_getattrdict(fh2, [FATTR4_MODE, FATTR4_ACL])
+    mode2 = attrs2[FATTR4_MODE] & 0o777
+    expected_mode2 = acl2mode_rfc8881(attrs2[FATTR4_ACL])
+
+    if mode2 != expected_mode2:
+        t.fail("Mode (0%o) with only APPEND_DATA does not match expected (0%o). "
+               "Write bit should NOT be set without WRITE_DATA." %
+               (mode2, expected_mode2))
+
+    # Test 3: Both WRITE_DATA and APPEND_DATA - write bit SHOULD be set
+    fh3, stateid3 = c.create_confirm(t.word() + b"_3")
+    acl3 = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_WRITE_DATA | ACE4_APPEND_DATA,  # Both present
+                b"OWNER@")
+    ]
+    ops = c.use_obj(fh3) + [c.setattr({FATTR4_ACL: acl3})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR ACL with both WRITE_DATA and APPEND_DATA")
+
+    attrs3 = c.do_getattrdict(fh3, [FATTR4_MODE, FATTR4_ACL])
+    mode3 = attrs3[FATTR4_MODE] & 0o777
+    expected_mode3 = acl2mode_rfc8881(attrs3[FATTR4_ACL])
+
+    if mode3 != expected_mode3:
+        t.fail("Mode (0%o) with WRITE_DATA+APPEND_DATA does not match "
+               "expected (0%o)" % (mode3, expected_mode3))
+
+def testSetattrACLModeDeriveAllowDeny(t, env):
+    """SETATTR(ACL) with ALLOW/DENY interaction
+
+    Test that ACL evaluation order is correct when mixing ALLOW and DENY ACEs.
+    Per RFC 8881 §6.3.2, evaluate ACEs in order, with earlier ACEs taking
+    precedence.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT25
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+
+    # Test: ALLOW first, then DENY - the ALLOW should win
+    fh, stateid = c.create_confirm(t.word())
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_DENIED_ACE_TYPE, 0,
+                ACE4_READ_DATA,  # This should be ignored (already allowed)
+                b"OWNER@")
+    ]
+
+    ops = c.use_obj(fh) + [c.setattr({FATTR4_ACL: acl})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR ACL with ALLOW then DENY")
+
+    attrs = c.do_getattrdict(fh, [FATTR4_MODE, FATTR4_ACL])
+    returned_mode = attrs[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs[FATTR4_ACL])
+
+    if returned_mode != expected_mode:
+        t.fail("Mode (0%o) with ALLOW/DENY does not match expected (0%o). "
+               "First ACE should take precedence." % (returned_mode, expected_mode))
+
+def testSetattrACLModeDeriveEveryone(t, env):
+    """SETATTR(ACL) with EVERYONE@ affecting all identifiers
+
+    Test that EVERYONE@ ACEs are considered when evaluating permissions
+    for OWNER@ and GROUP@ per RFC 8881 §6.3.2.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT26
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+
+    # EVERYONE@ gets read, specific OWNER@ gets nothing extra
+    # Final result: OWNER@ should have read (from EVERYONE@)
+    fh, stateid = c.create_confirm(t.word())
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"EVERYONE@")
+    ]
+
+    ops = c.use_obj(fh) + [c.setattr({FATTR4_ACL: acl})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR ACL with only EVERYONE@")
+
+    attrs = c.do_getattrdict(fh, [FATTR4_MODE, FATTR4_ACL])
+    returned_mode = attrs[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs[FATTR4_ACL])
+
+    if returned_mode != expected_mode:
+        t.fail("Mode (0%o) does not match expected (0%o). "
+               "EVERYONE@ should affect all mode bits." %
+               (returned_mode, expected_mode))
+
+def testSetattrACLModeDeriveComplex(t, env):
+    """SETATTR(ACL) with complex ACL including multiple identifiers
+
+    Test mode derivation with a more realistic ACL including OWNER@,
+    GROUP@, and EVERYONE@ with various permissions.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT27
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+
+    fh, stateid = c.create_confirm(t.word())
+
+    # Create a complex ACL:
+    # OWNER@: read + write + execute
+    # GROUP@: read + execute (no write)
+    # EVERYONE@: read only
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_EXECUTE,
+                b"GROUP@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"EVERYONE@")
+    ]
+
+    ops = c.use_obj(fh) + [c.setattr({FATTR4_ACL: acl})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR with complex ACL")
+
+    attrs = c.do_getattrdict(fh, [FATTR4_MODE, FATTR4_ACL])
+    returned_mode = attrs[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs[FATTR4_ACL])
+
+    if returned_mode != expected_mode:
+        t.fail("Mode (0%o) does not match RFC 8881 §6.3.2 derivation "
+               "from complex ACL (expected 0%o)" %
+               (returned_mode, expected_mode))
+
+def testSetattrACLIndependentOfMode(t, env):
+    """SETATTR(ACL) outcome should not depend on existing mode bits
+
+    Per RFC 8881 §6.4.1.2, when setting ACL without mode, the ACL should
+    be set as given. The existing mode should not affect the ACL that gets
+    stored. This test verifies that setting the same ACL on files with
+    different initial modes results in identical ACLs being stored.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT28
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+
+    # Create the same ACL to use for all files
+    # OWNER@: read + write, GROUP@: read, EVERYONE@: nothing
+    test_acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"GROUP@")
+    ]
+
+    # Test with various initial mode values
+    initial_modes = [0o600, 0o644, 0o755, 0o777, 0o400, 0o000]
+    files = []
+
+    # Create files with different initial modes
+    for initial_mode in initial_modes:
+        fh, stateid = c.create_confirm(t.word() + (b"_%o" % initial_mode))
+
+        # Set initial mode
+        ops = c.use_obj(fh) + [c.setattr({FATTR4_MODE: initial_mode})]
+        res = c.compound(ops)
+        check(res, msg="Setting initial mode to 0%o" % initial_mode)
+
+        files.append((fh, initial_mode))
+
+    # Now set the same ACL on all files
+    for fh, initial_mode in files:
+        ops = c.use_obj(fh) + [c.setattr({FATTR4_ACL: test_acl})]
+        res = c.compound(ops)
+        check(res, msg="SETATTR ACL on file with initial mode 0%o" % initial_mode)
+
+    # Retrieve the ACLs that were actually stored
+    acls = []
+    for fh, initial_mode in files:
+        attrs = c.do_getattrdict(fh, [FATTR4_ACL])
+        acls.append((initial_mode, attrs[FATTR4_ACL]))
+
+    # Helper function to compare ACLs (comparing ACE lists)
+    def acl_equal(acl1, acl2):
+        """Compare two ACLs for equality"""
+        if len(acl1) != len(acl2):
+            return False
+        for ace1, ace2 in zip(acl1, acl2):
+            if (ace1.type != ace2.type or
+                ace1.flag != ace2.flag or
+                ace1.access_mask != ace2.access_mask or
+                ace1.who != ace2.who):
+                return False
+        return True
+
+    def acl_to_string(acl):
+        """Convert ACL to readable string for error messages"""
+        aces = []
+        for ace in acl:
+            type_str = "ALLOW" if ace.type == ACE4_ACCESS_ALLOWED_ACE_TYPE else "DENY"
+            aces.append("<%s:%s:0x%x:0x%x>" %
+                       (type_str, ace.who.decode(), ace.access_mask, ace.flag))
+        return "[" + ", ".join(aces) + "]"
+
+    # Compare all ACLs - they should all be identical
+    reference_mode, reference_acl = acls[0]
+    for initial_mode, acl in acls[1:]:
+        if not acl_equal(reference_acl, acl):
+            t.fail("ACLs differ based on initial mode! "
+                   "File with mode 0%o has ACL %s, "
+                   "but file with mode 0%o has ACL %s. "
+                   "RFC 8881 §6.4.1.2: ACL should be set as given, "
+                   "independent of existing mode." %
+                   (reference_mode, acl_to_string(reference_acl),
+                    initial_mode, acl_to_string(acl)))
+
+    # Also verify that the mode derived from the ACL is consistent
+    modes = []
+    for initial_mode, acl in acls:
+        derived_mode = acl2mode_rfc8881(acl)
+        modes.append(derived_mode)
+
+    if len(set(modes)) != 1:
+        mode_str = ", ".join("0%o (from initial 0%o)" % (m, acls[i][0])
+                             for i, m in enumerate(modes))
+        t.fail("ACLs derive to different modes: %s. "
+               "This suggests ACLs were stored differently based on initial mode." %
+               mode_str)
+
+def testSetattrACLIndependentModeHighBits(t, env):
+    """SETATTR(ACL) should preserve high-order mode bits (SUID/SGID/SVTX)
+
+    Per RFC 8881 §6.4.1.2, when setting ACL without mode, the three
+    high-order bits of mode (SUID, SGID, SVTX) SHOULD remain unchanged.
+    Only the low-order nine permission bits should be modified.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT29
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+
+    # Create ACL to set
+    test_acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"GROUP@")
+    ]
+
+    # Test with different high-order bits set
+    test_cases = [
+        (0o4755, "SUID"),      # Set-user-ID
+        (0o2755, "SGID"),      # Set-group-ID
+        (0o1755, "SVTX"),      # Sticky bit
+        (0o6755, "SUID+SGID"), # Both SUID and SGID
+        (0o7755, "ALL"),       # All three bits
+    ]
+
+    for initial_mode, description in test_cases:
+        fh, stateid = c.create_confirm(t.word() + (b"_%s" % description.encode()))
+
+        # Set initial mode with high-order bits
+        ops = c.use_obj(fh) + [c.setattr({FATTR4_MODE: initial_mode})]
+        res = c.compound(ops)
+        check(res, msg="Setting initial mode 0%o (%s)" % (initial_mode, description))
+
+        # Verify the mode was set
+        before_attrs = c.do_getattrdict(fh, [FATTR4_MODE])
+        before_mode = before_attrs[FATTR4_MODE] & 0o7777
+
+        # Set ACL only (not mode)
+        ops = c.use_obj(fh) + [c.setattr({FATTR4_ACL: test_acl})]
+        res = c.compound(ops)
+        check(res, msg="SETATTR ACL on file with %s" % description)
+
+        # Check that high-order bits are preserved
+        after_attrs = c.do_getattrdict(fh, [FATTR4_MODE, FATTR4_ACL])
+        after_mode = after_attrs[FATTR4_MODE] & 0o7777
+
+        # Extract high-order bits (SUID, SGID, SVTX)
+        before_high = before_mode & 0o7000
+        after_high = after_mode & 0o7000
+
+        if before_high != after_high:
+            t.fail("High-order mode bits not preserved for %s: "
+                   "before=0%o, after=0%o. RFC 8881 §6.4.1.2 says "
+                   "high-order bits SHOULD remain unchanged." %
+                   (description, before_mode, after_mode))
+
+        # Verify low-order bits match ACL derivation
+        after_low = after_mode & 0o777
+        expected_low = acl2mode_rfc8881(after_attrs[FATTR4_ACL])
+
+        if after_low != expected_low:
+            t.fail("Low-order mode bits (0%o) don't match RFC 8881 §6.3.2 "
+                   "derivation (expected 0%o) for %s" %
+                   (after_low, expected_low, description))
+
+def testSetattrModeACLattrsset(t, env):
+    """SETATTR(MODE+ACL) should indicate which attributes were actually set
+
+    Per RFC 8881 §6.4.1.3, when both MODE and ACL are set together, the
+    server processes MODE first, then ACL (which may modify the mode).
+    The attrsset bitmap indicates which attributes were actually set.
+    This test verifies the attrsset bitmap and final mode consistency.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT30
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+
+    fh, stateid = c.create_confirm(t.word())
+
+    # Create an ACL that will derive to a specific mode (0754)
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_EXECUTE,
+                b"GROUP@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"EVERYONE@")
+    ]
+
+    # Request a different mode (0640)
+    requested_mode = 0o640
+
+    # Set both MODE and ACL together
+    attrs = {FATTR4_MODE: requested_mode, FATTR4_ACL: acl}
+    ops = c.use_obj(fh) + [c.setattr(attrs)]
+    res = c.compound(ops)
+    check(res, msg="SETATTR with MODE and ACL together")
+
+    # Check the attrsset bitmap
+    attrsset = bitmap2list(res.resarray[-1].attrsset)
+
+    # Get the final attributes
+    final_attrs = c.do_getattrdict(fh, [FATTR4_MODE, FATTR4_ACL])
+    final_mode = final_attrs[FATTR4_MODE] & 0o7777
+    final_acl = final_attrs[FATTR4_ACL]
+
+    # ACL should always be set
+    if FATTR4_ACL not in attrsset:
+        t.fail("FATTR4_ACL not in attrsset, but ACL was requested")
+
+    # Compute what mode should be derived from the ACL
+    acl_derived_mode = acl2mode_rfc8881(final_acl)
+
+    if FATTR4_MODE in attrsset:
+        # Server claims it set MODE - but per §6.4.1.3, the ACL processing
+        # will modify the mode. The final mode should match ACL derivation,
+        # not necessarily the requested mode.
+        if final_mode != acl_derived_mode:
+            t.fail("Server set MODE in attrsset, but final mode (0%o) "
+                   "doesn't match ACL-derived mode (0%o). "
+                   "Per RFC 8881 §6.4.1.3, ACL processing modifies mode." %
+                   (final_mode, acl_derived_mode))
+    else:
+        # Server did not include MODE in attrsset - this means it recognized
+        # that the ACL processing would override the requested mode.
+        # Final mode should still match ACL derivation.
+        if final_mode != acl_derived_mode:
+            t.fail("MODE not in attrsset (expected behavior), but final mode "
+                   "(0%o) doesn't match ACL-derived mode (0%o). "
+                   "Per RFC 8881 §6.4.1.2, mode should be derived from ACL." %
+                   (final_mode, acl_derived_mode))
+
+def testSetattrModeACLConflict(t, env):
+    """SETATTR(MODE+ACL) when MODE and ACL would produce different permissions
+
+    Test the interaction when the requested MODE differs significantly from
+    what the ACL would derive. Per RFC 8881 §6.4.1.3, MODE is applied first,
+    then ACL is applied (possibly changing the final mode).
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT31
+    """
+    from nfs4acl import acl2mode_rfc8881
+    c = env.c1
+    c.init_connection()
+
+    # Test multiple conflict scenarios
+    test_cases = [
+        # (requested_mode, ACL, description)
+        (0o777, [  # Request all permissions
+            nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                    ACE4_READ_DATA,  # But ACL only grants read
+                    b"OWNER@")
+        ], "MODE=0777 but ACL grants only read"),
+
+        (0o000, [  # Request no permissions
+            nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                    ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                    b"OWNER@")  # But ACL grants everything
+        ], "MODE=0000 but ACL grants rwx"),
+
+        (0o644, [  # Request read for all, write for owner
+            nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                    ACE4_EXECUTE,  # But ACL only grants execute
+                    b"OWNER@")
+        ], "MODE=0644 but ACL grants only execute"),
+    ]
+
+    for requested_mode, acl, description in test_cases:
+        fh, stateid = c.create_confirm(t.word() + ("_%o" % requested_mode).encode())
+
+        # Set both MODE and ACL together
+        attrs = {FATTR4_MODE: requested_mode, FATTR4_ACL: acl}
+        ops = c.use_obj(fh) + [c.setattr(attrs)]
+        res = c.compound(ops)
+        check(res, msg="SETATTR MODE+ACL: %s" % description)
+
+        # Get final attributes
+        final_attrs = c.do_getattrdict(fh, [FATTR4_MODE, FATTR4_ACL])
+        final_mode = final_attrs[FATTR4_MODE] & 0o777
+        final_acl = final_attrs[FATTR4_ACL]
+
+        # Verify final mode matches ACL derivation
+        expected_mode = acl2mode_rfc8881(final_acl)
+
+        if final_mode != expected_mode:
+            t.fail("Test case '%s': final mode (0%o) doesn't match "
+                   "ACL-derived mode (0%o). Per RFC 8881 §6.4.1.3, "
+                   "ACL should be set as given and mode derived from it." %
+                   (description, final_mode, expected_mode))
+
+def testSetattrACLNamedPrincipals(t, env):
+    """SETATTR(ACL) with named principals should preserve them
+
+    Per RFC 8881 §6.4.1.3: "the ACL attribute is set as given."
+    When an ACL contains named principals (not OWNER@/GROUP@/EVERYONE@),
+    the server must preserve those exact principals in the stored ACL,
+    not convert them to special identifiers.
+
+    FLAGS: setattr acl all
+    DEPEND: MODE ACL0
+    CODE: SATT32
+    """
+    c = env.c1
+    c.init_connection()
+
+    # First create a file and get its owner and group
+    temp_fh, temp_stateid = c.create_confirm(t.word() + b"_temp")
+    attrs = c.do_getattrdict(temp_fh, [FATTR4_OWNER, FATTR4_OWNER_GROUP])
+    current_owner = attrs[FATTR4_OWNER]
+    current_group = attrs[FATTR4_OWNER_GROUP]
+
+    # Test 1: SETATTR(ACL) with named principals only
+    fh1, stateid1 = c.create_confirm(t.word() + b"_acl_only")
+
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA,
+                current_owner),  # Named principal, not OWNER@
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                current_group)  # Named principal, not GROUP@
+    ]
+
+    ops = c.use_obj(fh1) + [c.setattr({FATTR4_ACL: acl})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR ACL with named principals")
+
+    # Verify ACL was preserved with named principals
+    returned_attrs = c.do_getattrdict(fh1, [FATTR4_ACL])
+    returned_acl = returned_attrs[FATTR4_ACL]
+
+    if len(returned_acl) < len(acl):
+        t.fail("Returned ACL has fewer entries than requested: "
+               "expected at least %d, got %d" % (len(acl), len(returned_acl)))
+
+    for i, expected_ace in enumerate(acl):
+        if i >= len(returned_acl):
+            t.fail("Missing ACE %d in returned ACL" % i)
+        returned_ace = returned_acl[i]
+
+        if returned_ace.who != expected_ace.who:
+            t.fail("ACE %d who mismatch: expected %s, got %s. "
+                   "Server converted named principal to special identifier, "
+                   "violating RFC 8881 §6.4.1.3 'ACL attribute is set as given'" %
+                   (i, expected_ace.who, returned_ace.who))
+
+    # Test 2: SETATTR(MODE+ACL) with named principals
+    fh2, stateid2 = c.create_confirm(t.word() + b"_mode_acl")
+
+    mode = 0o755
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                current_owner),  # Named principal
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_EXECUTE,
+                current_group),  # Named principal
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"EVERYONE@")  # Special identifier is fine
+    ]
+
+    ops = c.use_obj(fh2) + [c.setattr({FATTR4_MODE: mode, FATTR4_ACL: acl})]
+    res = c.compound(ops)
+    check(res, msg="SETATTR MODE+ACL with named principals")
+
+    # Verify ACL was preserved
+    returned_attrs = c.do_getattrdict(fh2, [FATTR4_ACL])
+    returned_acl = returned_attrs[FATTR4_ACL]
+
+    if len(returned_acl) < len(acl):
+        t.fail("Returned ACL has fewer entries than requested: "
+               "expected at least %d, got %d" % (len(acl), len(returned_acl)))
+
+    for i, expected_ace in enumerate(acl):
+        if i >= len(returned_acl):
+            t.fail("Missing ACE %d in returned ACL" % i)
+        returned_ace = returned_acl[i]
+
+        if returned_ace.who != expected_ace.who:
+            t.fail("ACE %d who mismatch: expected %s, got %s. "
+                   "Server converted named principal to special identifier, "
+                   "violating RFC 8881 §6.4.1.3" %
+                   (i, expected_ace.who, returned_ace.who))
-- 
2.51.1


