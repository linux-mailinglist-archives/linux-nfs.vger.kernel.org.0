Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43309225B14
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 11:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGTJPF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 05:15:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:58634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgGTJPC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Jul 2020 05:15:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AF94ADC2;
        Mon, 20 Jul 2020 09:15:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@fieldses.org>
Subject: [RFC PATCH 1/1] Remove nfsv4
Date:   Mon, 20 Jul 2020 11:14:49 +0200
Message-Id: <20200720091449.19813-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Reasons to drop:
* outdated tests (from 2005)
* not used (NFS kernel maintainers use pynfs [1])
* written in Python (we support C and shell, see [2])

[1] http://git.linux-nfs.org/?p=bfields/pynfs.git;a=summary
[2] https://github.com/linux-test-project/ltp/issues/547

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
@Chuck, Bruce: FYI RFC to drop NFS related legacy test suite from LTP.

Kind regards,
Petr

 testcases/network/.gitignore                  |    2 -
 testcases/network/nfsv4/Makefile              |   26 -
 testcases/network/nfsv4/acl/Makefile          |   29 -
 testcases/network/nfsv4/acl/README            |   21 -
 testcases/network/nfsv4/acl/acl1.c            |  373 ------
 testcases/network/nfsv4/acl/cleangroups.py    |   10 -
 testcases/network/nfsv4/acl/cleanusers.py     |   12 -
 testcases/network/nfsv4/acl/create_users.py   |   21 -
 testcases/network/nfsv4/acl/random_gen.py     |  251 ----
 testcases/network/nfsv4/acl/runtest           |   70 --
 testcases/network/nfsv4/acl/setacl_stress.py  |   32 -
 testcases/network/nfsv4/acl/test_acl.py       |  122 --
 testcases/network/nfsv4/acl/test_long_acl.py  |   44 -
 testcases/network/nfsv4/locks/Makefile        |   33 -
 testcases/network/nfsv4/locks/README          |  169 ---
 testcases/network/nfsv4/locks/VERSION         |    3 -
 .../nfsv4/locks/deploy/locktests.tar.gz       |  Bin 12354 -> 0 bytes
 testcases/network/nfsv4/locks/deploy_info     |   37 -
 testcases/network/nfsv4/locks/locktests.c     | 1034 -----------------
 testcases/network/nfsv4/locks/locktests.h     |  165 ---
 testcases/network/nfsv4/locks/locktests.py    |  236 ----
 testcases/network/nfsv4/locks/netsync.c       |  201 ----
 22 files changed, 2891 deletions(-)
 delete mode 100644 testcases/network/nfsv4/Makefile
 delete mode 100644 testcases/network/nfsv4/acl/Makefile
 delete mode 100644 testcases/network/nfsv4/acl/README
 delete mode 100644 testcases/network/nfsv4/acl/acl1.c
 delete mode 100755 testcases/network/nfsv4/acl/cleangroups.py
 delete mode 100755 testcases/network/nfsv4/acl/cleanusers.py
 delete mode 100755 testcases/network/nfsv4/acl/create_users.py
 delete mode 100755 testcases/network/nfsv4/acl/random_gen.py
 delete mode 100755 testcases/network/nfsv4/acl/runtest
 delete mode 100755 testcases/network/nfsv4/acl/setacl_stress.py
 delete mode 100755 testcases/network/nfsv4/acl/test_acl.py
 delete mode 100755 testcases/network/nfsv4/acl/test_long_acl.py
 delete mode 100644 testcases/network/nfsv4/locks/Makefile
 delete mode 100644 testcases/network/nfsv4/locks/README
 delete mode 100644 testcases/network/nfsv4/locks/VERSION
 delete mode 100644 testcases/network/nfsv4/locks/deploy/locktests.tar.gz
 delete mode 100644 testcases/network/nfsv4/locks/deploy_info
 delete mode 100644 testcases/network/nfsv4/locks/locktests.c
 delete mode 100644 testcases/network/nfsv4/locks/locktests.h
 delete mode 100755 testcases/network/nfsv4/locks/locktests.py
 delete mode 100644 testcases/network/nfsv4/locks/netsync.c

diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index dab2bc34e..b5cdb351a 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -17,8 +17,6 @@
 /nfs/nfs_stress/nfs05_make_tree
 /nfs/nfslock01/nfs_flock
 /nfs/nfslock01/nfs_flock_dgen
-/nfsv4/acl/acl1
-/nfsv4/locks/locktests
 /rpc/basic_tests/rpc01/rpc1
 /rpc/basic_tests/rpc01/rpc_server
 /sctp/sctp_big_chunk
diff --git a/testcases/network/nfsv4/Makefile b/testcases/network/nfsv4/Makefile
deleted file mode 100644
index a311eaa42..000000000
--- a/testcases/network/nfsv4/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-#    network/nfsv4 test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/nfsv4/acl/Makefile b/testcases/network/nfsv4/acl/Makefile
deleted file mode 100644
index 8c55a6bbd..000000000
--- a/testcases/network/nfsv4/acl/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/nfsv4/acl testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, September 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-LDLIBS			+= $(ACL_LIBS)
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/nfsv4/acl/README b/testcases/network/nfsv4/acl/README
deleted file mode 100644
index 15a0e0a48..000000000
--- a/testcases/network/nfsv4/acl/README
+++ /dev/null
@@ -1,21 +0,0 @@
-ACL testing
-Aurélien Charbon - Bull SA
-
-# GOAL :
-Testing ACL conformance, ACL limits, and ACL robustness
-
-# REQUIREMENTS :
-ACL support must be present on the remote host
-attr and acl packages must be install for the stestsuite to build/run.
-This testsuite is not built by the default make in the LTP root directory
-
-acl1: verify the conformance ok access regarding the ACL of files and directory.
-stress: multiprocess application to stress the ACL
-
-setacl_stress.py: python script that does lots of setfacl function
-
-test_long_acl.py: try to "build" ACLs of different length. Stop when the specified maximum length is reached.
-
-To run the test:
-make (builds the binaries)
-./runtest (executes the sequence of tests)
diff --git a/testcases/network/nfsv4/acl/acl1.c b/testcases/network/nfsv4/acl/acl1.c
deleted file mode 100644
index ad778cd33..000000000
--- a/testcases/network/nfsv4/acl/acl1.c
+++ /dev/null
@@ -1,373 +0,0 @@
-/*
- *	Aurélien Charbon - Bull SA
- *	ACL testing basic program
- *	Purpose: setting an acl on a file a verifies that the accesses are right
- */
-
-#include <sys/param.h>
-
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/time.h>
-#include <sys/stat.h>
-#include <stdio.h>
-#include <string.h>
-#include <dirent.h>
-#include <unistd.h>
-#include <errno.h>
-
-#include "config.h"
-#include "tst_res_flags.h"
-
-#ifdef HAVE_LIBACL
-
-#include <sys/acl.h>
-
-#define OP_READ 0x1
-#define OP_WRITE 0x2
-#define OP_EXEC 0x4
-
-acl_t testacl;
-/* the "typical" acl used for the test */
-
-static char *permtab[] =
-    { "---", "r--", "-w-", "rw-", "--x", "r-x", "-wx", "rwx" };
-
-struct statstore {
-	/* number of passed tests */
-	int ok;
-	/* number of failed tests */
-	int failed;
-} aclstat;
-
-int do_file_op(char *filename)
-{
-	int exe;
-	int result;
-	uid_t uid;
-	result = 0;
-	FILE *fptr;
-	char str[256] = "./";
-
-	uid = geteuid();
-	strcat(str, filename);
-
-	exe = execl(str, NULL, NULL);
-	if (exe == -1 && errno != EACCES)
-		result = result + OP_EXEC;
-
-	fptr = fopen(filename, "r");
-	if (fptr != NULL) {
-		result = result + OP_READ;
-		fclose(fptr);
-	}
-
-	fptr = fopen(filename, "r+");
-	if (fptr != NULL) {
-		result = result + OP_WRITE;
-		fclose(fptr);
-	}
-
-	return result;
-}
-
-/*  acl with user entries used for the test */
-acl_t test_acl_user_create(void)
-{
-	char acl_text[] =
-	    "u::rwx,u:user1:rwx,u:user2:rw-,u:user3:r--,u:user4:r-x,u:user5:---,g::r-x,o::r-x,m::rwx";
-	acl_t acl;
-	acl = acl_from_text(acl_text);
-	return acl;
-}
-
-/*  acl with group entries used for the test */
-
-acl_t test_acl_grp_create(void)
-{
-	char acl_text[] =
-	    "u::rwx,g:grp1:rwx,g:grp2:rw-,g:grp3:r--,g:grp4:r-x,g:grp5:---,g::---,o::r-x,m::rwx";
-	acl_t acl;
-	acl = acl_from_text(acl_text);
-	return acl;
-}
-
-acl_t test_acl_default_create(void)
-{
-	char acl_text[] =
-	    "u::rwx,u:user1:rwx,u:user2:rw-,u:user3:r--,u:user4:r-x,u:user5:---,g::r-x,m::rwx,o::r-x";
-	acl_t acl;
-	acl = acl_from_text(acl_text);
-	return acl;
-}
-
-static void report(testnum, expected, result, fail)
-int testnum;			/* test number */
-int expected;			/* expected result */
-int result;			/* actual result */
-int fail;			/* fail or warning */
-{
-	char *res;
-	if (expected == result) {
-		res = "[OK]";
-		aclstat.ok++;
-	} else {
-		res = "[FAILED]";
-		aclstat.failed++;
-	}
-	printf("\ttest #%d - Expected: %s - Obtained: %s - %s\n", testnum,
-	       permtab[expected], permtab[result], res);
-
-	fflush(stdout);
-}
-
-/*
- * set acl in order the file is only readable for the testuser
- * - try to read
- * - try to write
- */
-static void test1(char *file)
-{
-	int result;
-	if (seteuid((uid_t) 601) == 0) {
-		result = do_file_op(file);
-		/* expected result = OP_READ || OP_WRITE || OP_EXEC */
-		report(1, OP_READ + OP_WRITE + OP_EXEC, result);
-		seteuid((uid_t) 0);
-		setegid((gid_t) 0);
-	}
-}
-
-/*
- * set acl in order the file is only readable for the testgroup
- * - try to read with test user
- * - try to write with test user
- *
- */
-
-static void test2(char *file)
-{
-	int result;
-	if (seteuid((uid_t) 602) == 0) {
-		result = do_file_op(file);
-		/* expected result = OP_READ || OP_WRITE */
-		report(2, OP_READ + OP_WRITE, result);
-		seteuid((uid_t) 0);
-	}
-}
-
-/*
- * set acl in order the file is only readable for the testuser
- * - try to read
- * - try to write
- */
-
-static void test3(char *file)
-{
-	int result;
-	if (seteuid((uid_t) 603) == 0) {
-		result = do_file_op(file);
-		/* expected result = OP_READ */
-		report(3, OP_READ, result);
-		seteuid((uid_t) 0);
-	}
-}
-
-/*
- * set read-write acl on the file for the testuser
- * - try to read
- * - try to write
- */
-
-static void test4(char *file)
-{
-	int result;
-	if (seteuid((uid_t) 604) == 0) {
-		result = do_file_op(file);
-		/* expected result = OP_READ || OP_EXEC */
-		report(4, OP_READ + OP_EXEC, result);
-		seteuid((uid_t) 0);
-	}
-}
-
-static void test5(char *file)
-{
-	int result;
-	if (seteuid((uid_t) 605) == 0) {
-		result = do_file_op(file);
-		/* expected result = 0x0 */
-		report(5, 0x00, result);
-		seteuid((uid_t) 0);
-	}
-}
-
-static void testgrp1(char *file)
-{
-	int result;
-	if (setegid((gid_t) 601) == 0) {
-		if (seteuid((uid_t) 601) == 0) {
-			result = do_file_op(file);
-			/* expected result = OP_READ || OP_WRITE || OP_EXEC */
-			report(1, OP_READ + OP_WRITE + OP_EXEC, result);
-			seteuid((uid_t) 0);
-			setegid((gid_t) 0);
-		}
-	}
-}
-
-/*
- * set acl in order the file is only readable for the testgroup
- * - try to read with test user
- * - try to write with test user
- *
- */
-
-static void testgrp2(char *file)
-{
-	int result;
-	if ((setegid((gid_t) 602) == 0) && (seteuid((uid_t) 602) == 0)) {
-		result = do_file_op(file);
-		/* expected result = OP_READ || OP_WRITE */
-		report(2, OP_READ + OP_WRITE, result);
-		seteuid((uid_t) 0);
-		setegid((gid_t) 0);
-	}
-}
-
-/*
- * set acl in order the file is only readable for the testuser
- * - try to read
- * - try to write
- */
-
-static void testgrp3(char *file)
-{
-	int result;
-	if ((setegid((gid_t) 603) == 0) && (seteuid((uid_t) 603) == 0)) {
-		result = do_file_op(file);
-		/* expected result = OP_READ */
-		report(3, OP_READ, result);
-		seteuid((uid_t) 0);
-		setegid((gid_t) 0);
-	}
-}
-
-/*
- * set read-write acl on the file for the testuser
- * - try to read
- * - try to write
- */
-
-static void testgrp4(char *file)
-{
-	int result;
-	if (setegid((gid_t) 604) == 0) {
-		if (seteuid((uid_t) 604) == 0)
-			result = do_file_op(file);
-		/* expected result = OP_READ || OP_EXEC */
-		report(4, OP_READ + OP_EXEC, result);
-		seteuid((uid_t) 0);
-		setegid((gid_t) 0);
-	}
-}
-
-static void testgrp5(char *file)
-{
-	int result;
-	if (setegid((gid_t) 605) == 0) {
-		if (seteuid((uid_t) 605) == 0)
-			result = do_file_op(file);
-		/* expected result = 0x0 */
-		report(5, 0x00, result);
-		seteuid((uid_t) 0);
-		setegid((gid_t) 0);
-	}
-}
-
-/* testing default acl */
-void test_acl_default(char *dir, acl_t acl)
-{
-	/* set default acl on directory */
-	/* create a file in this directory */
-	/* compare the file's acl and the parent directory's one */
-	int res;
-	acl_t acl1, acl2;
-
-	res = acl_set_file(dir, ACL_TYPE_DEFAULT, acl);
-	acl1 = acl_get_file(dir, ACL_TYPE_DEFAULT);
-	if (res == -1)
-		printf("path = %s **** errno = %d", dir, errno);
-	char *path = strcat(dir, "/testfile");
-	fopen(path, "w+");
-	char *cmd = malloc(256);
-
-	strcpy(cmd, "chmod 7777 ");
-	printf(cmd, NULL);
-	strcat(cmd, dir);
-	system(cmd);
-	acl2 = acl_get_file(path, ACL_TYPE_ACCESS);
-
-	test1(path);
-	test2(path);
-	test3(path);
-	test4(path);
-	test5(path);
-}
-
-static void showstats(void)
-{
-	printf("\nACL TESTS RESULTS: %d passed, %d failed\n\n", aclstat.ok,
-	       aclstat.failed);
-}
-
-int main(int argc, char *argv[])
-{
-	int result;
-	aclstat.ok = 0;
-	aclstat.failed = 0;
-	acl_t testacl;
-	printf("Test acl with entries on users\n");
-	testacl = test_acl_user_create();
-
-	/* set the right acl for the test */
-	result = acl_set_file(argv[1], ACL_TYPE_ACCESS, testacl);
-	if (result == -1) {
-		printf("setting acl on file %s failed\nBad NFS configuration",
-		       argv[1]);
-		exit(1);
-	}
-	test1(argv[1]);
-	test2(argv[1]);
-	test3(argv[1]);
-	test4(argv[1]);
-	test5(argv[1]);
-	acl_free(testacl);
-	printf("\nTest of default acl:\n");
-
-	testacl = test_acl_default_create();
-	test_acl_default(argv[2], testacl);
-
-	printf("\nTest acl with entries concerning groups\n");
-	testacl = test_acl_grp_create();
-	result = acl_set_file(argv[1], ACL_TYPE_ACCESS, testacl);
-	if (result == -1)
-		printf("setting acl on file %s failed\n", argv[1]);
-
-	testgrp1(argv[1]);
-	testgrp2(argv[1]);
-	testgrp3(argv[1]);
-	testgrp4(argv[1]);
-	testgrp5(argv[1]);
-
-	acl_free(testacl);
-
-	showstats();
-	return 1;
-}
-#else
-int main(void)
-{
-	printf("The acl library was missing upon compilation.\n");
-	return TCONF;
-}
-#endif /* HAVE_LIBACL */
diff --git a/testcases/network/nfsv4/acl/cleangroups.py b/testcases/network/nfsv4/acl/cleangroups.py
deleted file mode 100755
index 3c064783c..000000000
--- a/testcases/network/nfsv4/acl/cleangroups.py
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/usr/bin/env python3
-from random_gen import *
-from optparse import OptionParser
-import subprocess
-import os
-import random
-
-test = RandomGen()
-test.getGroupList()
-test.cleanGroups()
diff --git a/testcases/network/nfsv4/acl/cleanusers.py b/testcases/network/nfsv4/acl/cleanusers.py
deleted file mode 100755
index 3e652c5b7..000000000
--- a/testcases/network/nfsv4/acl/cleanusers.py
+++ /dev/null
@@ -1,12 +0,0 @@
-#!/usr/bin/env python3
-from random_gen import *
-from optparse import OptionParser
-import subprocess
-import os
-import random
-
-test = RandomGen()
-test.getUserList()
-test.getGroupList()
-test.cleanUsers()
-test.cleanGroups()
diff --git a/testcases/network/nfsv4/acl/create_users.py b/testcases/network/nfsv4/acl/create_users.py
deleted file mode 100755
index 3203aff8b..000000000
--- a/testcases/network/nfsv4/acl/create_users.py
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/usr/bin/env python3
-'''
-	Access Control Lists testing based on newpynfs framework
-	Aurelien Charbon - Bull SA
-'''
-
-from random_gen import *
-from optparse import OptionParser
-
-parser = OptionParser()
-parser.add_option("-u", "--users", dest="nu",type="int",help="number of users to create")
-parser.add_option("-g", "--group",dest="ng",type="int",help="number of groups to create")
-
-(options, args) = parser.parse_args()
-
-''' Measuring time to add an ACE to a list regarding the number of ACE already in the list'''
-''' Doing the measurement on 100 files '''
-test=RandomGen()
-test.createNGroup(options.ng)
-test.getGroupList()
-test.createNUser(options.nu)
diff --git a/testcases/network/nfsv4/acl/random_gen.py b/testcases/network/nfsv4/acl/random_gen.py
deleted file mode 100755
index 4b6ba9625..000000000
--- a/testcases/network/nfsv4/acl/random_gen.py
+++ /dev/null
@@ -1,251 +0,0 @@
-#!/usr/bin/env python3
-import subprocess
-import random
-import re
-
-alphabet = 'azertyuiopqsdfghjklmwxcvbnAZERTYUIOPQSDFGHJKLMWXCVBN123456789-_'
-a_length = len(alphabet)
-
-""" ACL support attribute """
-ACL4_SUPPORT_ALLOW_ACL = 0x00000001
-ACL4_SUPPORT_DENY_ACL = 0x00000002
-ACL4_SUPPORT_AUDIT_ACL = 0x00000004
-ACL4_SUPPORT_ALARM_ACL = 0x00000008
-
-class RandomGen(object):
-
-
-	"""  List of ACE possible who fields """
-	ace_who=["OWNER@","GROUP@","EVERYONE@","ANONYMOUS@","AUTHENTICATED@"]
-
-	""" List of GID than can be used to do the tests """
-	gList=[]
-	gListSize = len(gList)
-	uList = []
-	uListSize = len(uList)
-
-	fList=[]
-	fListSize = len(fList)
-
-	""" Create a user in available groups to do the tests """
-	def createUser(self,username):
-		group = self.gList[random.randint(0,len(self.gList)-1)][0]
-		opts = "-g" + group + " -p" + "1pilot" + " -m " + username
-		u = subprocess.getoutput('/usr/sbin/useradd '+ opts)
-		if u != "":
-			print("create user " + username + "failed" + u)
-
-	def createFile(self,path,n):
-		for i in range(n):
-			fName = 'file' + str(i)
-			u = subprocess.getoutput('touch ' + path + '/'+ fName)
-			self.fList.append(fName)
-
-	def createGroup(self, grpname, gid):
-		u = subprocess.getoutput('/usr/sbin/groupadd -g' + gid + " " + grpname)
-		if u != "":
-			print(u)
-
-	def createNGroup(self, n):
-		for i in range(n):
-			gName = 'grp' + str(i)
-			gid = str(500+i)
-			self.createGroup(gName, gid)
-
-
-	""" Random creation of n user """
-	def createNUser(self,n):
-		for i in range(n):
-			userName= "user" + str(i)
-			self.createUser(userName)
-
-	""" clean all users created to do the tests """
-	def cleanUsers(self):
-		for name in self.uList:
-			u = subprocess.getoutput('/usr/sbin/userdel -r '+ name)
-		self.uList = []
-
-	""" clean all users created to do the tests """
-	def cleanGroups(self):
-		for name in self.gList:
-			u = subprocess.getoutput('/usr/sbin/groupdel '+ name[0])
-		self.gList = []
-
-	""" Retrieve the list of user from /etc/passwd file """
-	def getUserList(self):
-		f = open('/etc/passwd','r')
-		lines = f.readlines()
-		for line in lines:
-			splitedline = line.split(':')
-			userName = splitedline[0]
-			gid = splitedline[3]
-		# TO FIX: verify that the group is OK (in the right range)
-			NameOK = re.match("user",userName)
-			# We keep only usernames starting with "user"
-			if NameOK != None:
-				self.uList.append(userName)
-		f.close()
-
-	def getFileList(self,path):
-		u = subprocess.getoutput('ls ' + path)
-		tmp = u.split('\n')
-		for i in range (len(tmp)-1):
-			NameOK = re.match("file",tmp[i])
-			if NameOK != None:
-				self.fList.append(tmp[i])
-
-	def getNUserList(self,nb):
-		f = open('/etc/passwd','r')
-		lines = f.readlines()
-		n = 0
-		for line in lines:
-			splitedline = line.split(':');
-			userName = splitedline[0]
-			gid = splitedline[3]
-		# TO FIX: verify that the group is OK (in the right range)
-			NameOK = re.match("user",userName)
-			# We keep only usernames starting with "user"
-			if NameOK != None:
-				self.uList.append(userName)
-				n = n+1
-			if n==nb:
-				break;
-		f.close()
-
-	""" Get group list """
-	def getGroupList(self):
-		f = open('/etc/group','r')
-		lines = f.readlines()
-		for line in lines:
-			splitedline = line.split(':');
-			groupName = splitedline[0]
-			gid = splitedline[2]
-			NameOK = re.match("grp",groupName)
-			if NameOK != None:
-				self.gList.append([groupName,gid])
-		f.close()
-
-	""" Get a list of n group """
-	def getNGroupList(self,nb):
-		f = open('/etc/group','r')
-		lines = f.readlines()
-		n = 0
-		for line in lines:
-			splitedline = line.split(':');
-			groupName = splitedline[0]
-			gid = splitedline[2]
-			NameOK = re.match("grp",groupName)
-			if NameOK != None:
-				self.gList.append([groupName,gid])
-				n = n+1
-			if n==nb:
-				break;
-		f.close()
-
-	def printUserList(self):
-		print(self.uList)
-
-	def printGroupList(self):
-		print(self.gList)
-
-	""" Create a random name of random length """
-	def createOneNameRandomLength(self,maxlength):
-		outputString =""
-		l=random.randint(0,maxlength)
-		for i in range(l):
-			a = random.randint(0,a_length-1)
-			outputString =outputString  + alphabet[a]
-		return outputString
-
-	""" Create a random name of fixed length """
-	def createOneName(self,lenght):
-		outputString =""
-		for i in range(length):
-			a = random.randint(0,a_length-1)
-			outputString = outputString + alphabet[a]
-		return outputString
-
-	""" Create Random User List with fixed length user names """
-	def createRandomUserList(self,listlength,usernamelength):
-		userlist = []
-		for i in range(listlength):
-			user = createOneName(lenght)
-			userlist.append(user)
-		return userlist
-
-	""" Create Random ACE for a file and a given usr """
-	def createRandomACE(self,user):
-		type = ace_type[random.randint(0,len(ace_type))]
-		flag = ace_flags[random.randint(0,len(ace_flags))]
-		mask = ace_mask[random.randint(0,len(ace_mask))]
-		who = ace_who[random.randint(0,len(ace_who))]
-		return nfsace4(type, flag, mask, who)
-
-	""" Create Random ACL for a file with a fixed number a entries """
-	def createRandomACL(self,acl_size):
-		acl = []
-		userList = uList
-		userListSize = uListSize
-		for i in range(acl_size):
-			n = random.randint(0,userListSize-1)
-			usr = userList.pop(n)
-			newace = createRandomACE(usr)
-			acl.append(newace)
-		return acl
-
-	""" Return a mode string like 'xwr' or 'x' """
-	def createRandomMode(self):
-		out_str = ""
-		while (out_str == ""):
-				if random.randint(0,1) == 1:
-					out_str += 'x'
-				if random.randint(0,1) == 1:
-					out_str += 'w'
-				if random.randint(0,1) == 1:
-					out_str += 'r'
-		return out_str
-
-	""" Create a random ACL operation (delete / remove / modify on user / group ) """
-	def randomOp(self,path):
-		a = random.randint(1,4)
-		mode = self.createRandomMode()
-		file = self.fList[random.randint(0,len(self.fList)-1)]
-		if a == 1:	# creation/modification
-			user = self.uList[random.randint(0,len(self.uList)-1)]
-			u = subprocess.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + file)
-
-		if a == 2:	# with group
-			group = self.gList[random.randint(0,len(self.gList)-1)][0]
-			u = subprocess.getoutput('setfacl -m g:' + group + ':' + mode + " " + path + "/" + file)
-
-		if a == 3:	# deletation
-			user = self.uList[random.randint(0,len(self.uList)-1)]
-			u = subprocess.getoutput('setfacl -x u:' + user + " " + path + "/" + file)
-
-		if a == 4:	# with group
-			group = self.gList[random.randint(0,len(self.gList)-1)][0]
-			u = subprocess.getoutput('setfacl -x g:' + group + " " + path + "/" + file)
-
-		# request on a unexisting group
-		'''if a == 5:
-			group = self.createOneNameRandomLength(16)
-			print 'setfacl -x g:' + group + " " + path + "/" + file
-			u = commands.getoutput('setfacl -x g:' + group + " " + path + "/" + file)
-		if a == 6:
-			user = self.createOneNameRandomLength(16)
-			u = commands.getoutput('setfacl -x u:' + user + " " + path + "/" + file)
-
-		if a == 7:	# creation/modification
-			user = self.createOneNameRandomLength(16)
-			u = commands.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + file)
-
-		if a == 8:	# with group
-			group = self.createOneNameRandomLength(16)
-			u = commands.getoutput('setfacl -m g:' + group + ':' + mode + " " + path + "/" + file)
-
-		if a == 9:     	#Copying the ACL of one file to another
-			file2 = self.fList[random.randint(0,len(self.fList)-1)]
-              		u = commands.getoutput('getfacl ' + path + "/" + file + "| setfacl --set-file=- " + path + "/" + file2)
-		if u!="":
-			print u'''
-
diff --git a/testcases/network/nfsv4/acl/runtest b/testcases/network/nfsv4/acl/runtest
deleted file mode 100755
index a859e85bc..000000000
--- a/testcases/network/nfsv4/acl/runtest
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/bin/sh
-#
-#       @(#)runtests
-#
-# runtests script for ACL testing
-REMOTEHOST=nfsserver
-MAXLENGTH=30 # maximum ACL length - NB: the current NFSv4 acl implementation does not allow ACL greater than one page (about 35 entries with 6 character user name length and 10 character domain name)
-NFSMNTDIR=/mnt/nfs-acl
-echo "Test on NFS server $REMOTEHOST"
-ACLTESTDIR=testdir
-ACLTESTFILE=testfile
-
-USER_NB=20 # total number of users to create
-GRP_NB=20 # total number of groups to create
-FILE_NB=10 # total number of files for the test
-
-# creation of users on the local machine
-for i in 1 2 3 4 5
-do
-	groupadd -g 60$i grp$i
-	useradd -u 60$i  user$i
-done
-
-#  creation of users on the remote machine (removed only at the end of the tests)
-rsh -n $REMOTEHOST python3 $PWD/create_users.py -u 50 -g 50
-
-echo "Starting ACL testing"
-
-echo "Starting BASIC tests"
-
-echo "Creating testing file and directory"
-touch $NFSMNTDIR/$ACLTESTFILE
-mkdir $NFSMNTDIR/$ACLTESTDIR
-if test ! -d $NFSMNTDIR/$ACLTESTDIR
-then
-	echo "Can't make directory $ACLTESTDIR"
-	exit 1
-fi
-
-# File and Directory tree creation test
-echo "Execute acl1 $NFSMNTDIR/$ACLTESTFILE $NFSMNTDIR/$ACLTESTDIR"
-./acl1 $NFSMNTDIR/$ACLTESTFILE $NFSMNTDIR/$ACLTESTDIR
-#./stress $ACLTESTFILE
-for i in 1 2 3 4 5
-    do
-        userdel user$i
-        groupdel grp$i
-    done
-
-echo "Basic tests finished"
-
-echo "LONG ACL TEST"
-echo "creating necessary users and groups"
-python3 create_users.py -u 50 -g 50
-echo "creating necessary users and groups on the remote host"
-mkdir $NFSMNTDIR/lacl-testdir
-python3 test_long_acl.py -l $MAXLENGTH -p $NFSMNTDIR/lacl-testdir
-rm -rf $NFSMNTDIR/lacl-testdir
-echo "Long ACL test OK with $MAXLENGTH entries"
-echo "ACL STRESSING TEST"
-python3 setacl_stress.py -n 100 -u $USER_NB -g $GRP_NB -f $FILE_NB -p $NFSMNTDIR
-
-# remove local an remote users
-python3 cleanusers.py
-python3 cleangroups.py
-rsh -n $REMOTEHOST python3 $PWD/cleanusers.py
-
-echo "Test OK"
-
-exit 0
diff --git a/testcases/network/nfsv4/acl/setacl_stress.py b/testcases/network/nfsv4/acl/setacl_stress.py
deleted file mode 100755
index c93ac8bc0..000000000
--- a/testcases/network/nfsv4/acl/setacl_stress.py
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/usr/bin/env python3
-'''
-	Access Control Lists stressing script
-	To lauch on the first client
-	Aurelien Charbon - Bull SA
-'''
-
-from random_gen import *
-from optparse import OptionParser
-import subprocess
-import os
-import random
-
-alphabet='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789_-()'
-t_alphabet=len(alphabet)
-
-test = RandomGen()
-
-parser = OptionParser()
-parser.set_defaults(nbfiles=5,nbusers=5,nbgroups=5,nloop=100 )
-parser.add_option("-n","--nloop", dest="nloop",type="int", help="number of loop to do in the test")
-parser.add_option("-p", "--path", dest="path",help="path on which the test is executed")
-parser.add_option("-f", "--nbfiles", dest="nbfiles",type="int",help="nb of files to do the test (default=5)")
-parser.add_option("-u", "--nbusers", dest="nbusers",type="int",help="nb of users (default=5)")
-parser.add_option("-g", "--nbgrp", dest="nbgroups",type="int",help="nb of groups (default=5)")
-(options, args) = parser.parse_args()
-
-test.createFile(options.path,options.nbfiles)
-test.getNUserList(options.nbusers)
-test.getNGroupList(options.nbgroups)
-for i in range (options.nloop):
-	test.randomOp(options.path)
diff --git a/testcases/network/nfsv4/acl/test_acl.py b/testcases/network/nfsv4/acl/test_acl.py
deleted file mode 100755
index 8699b0206..000000000
--- a/testcases/network/nfsv4/acl/test_acl.py
+++ /dev/null
@@ -1,122 +0,0 @@
-#!/usr/bin/env python3
-'''
-	Access Control Lists testing based on newpynfs framework
-	Aurelien Charbon - Bull SA
-'''
-from random_gen import *
-import subprocess
-import os
-import threading
-import time
-import random
-
-alphabet='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789_-() ~'
-t_alphabet=len(alphabet)
-
-def test_acl_default(path):
-
-# set default acl on the test directory
-	u = subprocess.getoutput('mkdir ' + path + "/" + testdir)
-	u = subprocess.getoutput('getfacl ' + path + "/" + testdir)
-	acl=[]
-	for i in range (len(splitedresult)-1):
-		splitedline = splitedresult[i].split('::')
-		name = splitedline[0]
-		entry = splitedline[1]
-		acl.append(name,entry)
-# create a file in this directory
-	u = subprocess.getoutput('touch ' + path + "/" + testdir + testfile)
-# get the file's ACL and verify
-	u = subprocess.getoutput('getfacl ' + path + "/" + testdir + testfile)
-	splitedresult = u.split('\n')
-	acl2=[]
-	for i in range (len(splitedresult)-1):
-		splitedline = splitedresult[i].split('::')
-		name = splitedline[0]
-		entry = splitedline[1]
-		acl2.append(name,entry)
-
-	result_final = True
-	while i < len(acl2):
-		result = False
-		while j < len(acl2) and result == False:
-			if acl2[i] == acl[j]:
-				result = True
-		if result == False:
-			result_final = False
-
-''' Measuring time to add an ACE to a list regarding the number of ACE already in the list'''
-''' Doing the measurement on 100 files '''
-def test_acl_long():
-	path = '/mnt/nfs/test-acl'
-	test = RandomGen()
-	test.createFile(path,100)
-	test.getUserList()
-	t0=time.time()
-	for test_file in test.fList:
-		for user in test.uList:
-			mode = test.createRandomMode()
-			u = subprocess.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + test_file)
-	t1=time.time()
-	print(t1-t0)
-
-def test_nfs_acl():
-	print("test acl 10000\n")
-	test = RandomGen()
-	f = open('/tmp/acl-result-10000','w')
-	path = '/mnt/nfs/test-acl'
-	for i in range(10000):
-		print("test avec " + str(i) + " ACE")
-		test.getUserList()
-		testfile = 'testfile' + str(i)
-		u = subprocess.getoutput('touch ' + path + "/" + testfile)
-		t0=time.time()
-		for j in range(i):
-			user = test.uList.pop()
-			mode = test.createRandomMode()
-			u = subprocess.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + testfile)
-			t1=time.time()
-			f.write(str(i) + "\t" + str(t1-t0)+"\n")
-			f.close()
-
-
-def test_nfs_getfacl():
-	# mesures sur le getfacl
-	test = RandomGen()
-
-	path = '/mnt/nfs/test-acl' # NFS mounted directory
-	u = subprocess.getoutput('rm ' + path + "/*")	# clean directory
-	print("test acl getfacl\n")
-	f = open('/tmp/acl-result-getfacl','w')
-	for i in range(37):
-
-		test.getUserList()
-		testfile = 'testfile' + str(i)
-
-		u = subprocess.getoutput('touch ' + path + "/" + testfile)
-		print("setfacl " + str(i) + " " + u)
-		for j in range(i):
-			user = test.uList.pop()
-			mode = test.createRandomMode()
-			u = subprocess.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + testfile)
-
-		t1=time.time()
-		u = subprocess.getoutput('getfacl ' + path + "/" + testfile)
-		print("getfacl - " + str(i) + u + "\n")
-		t2=time.time()
-		f.write(str(i) + "\t" + str(t2-t1)+"\n")
-		f.close()
-
-
-def main():
-	# test getFileList
-	path = '/mnt/nfs/test-acl'
-	test = RandomGen()
-	test.getFileList(path)
-	print(test.fList)
-main()
-
-
-
-
-
diff --git a/testcases/network/nfsv4/acl/test_long_acl.py b/testcases/network/nfsv4/acl/test_long_acl.py
deleted file mode 100755
index 893855b42..000000000
--- a/testcases/network/nfsv4/acl/test_long_acl.py
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/usr/bin/env python3
-'''
-	Access Control Lists testing based on newpynfs framework
-	Aurelien Charbon - Bull SA
-'''
-from random_gen import *
-from optparse import OptionParser
-import subprocess
-import os
-import threading
-import time
-import random
-
-alphabet='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789_-() ~'
-t_alphabet=len(alphabet)
-
-
-
-def test_longacl(l,path):
-	# mesures sur le getfacl
-	test = RandomGen()
-
-	u = subprocess.getoutput('rm ' + path + "/*")	# clean directory
-	print("test acl getfacl\n")
-	for i in range(l):
-		test.getUserList()
-		testfile = 'testfile' + str(i)
-		u = subprocess.getoutput('touch ' + path + "/" + testfile)
-		print("setfacl with " + str(i) + " entries\n " + u)
-		for j in range(i):
-			user = test.uList.pop()
-			mode = test.createRandomMode()
-			u = subprocess.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + testfile)
-			if u != "":
-				print("setfacl -m u:" + user + ':' + mode + " " + path + "/" + testfile)
-				print(u)
-def main():
-	parser = OptionParser()
-	parser.add_option("-l", "--length", dest="length",type="int",help="max lentgh of ACL")
-	parser.add_option("-p", "--path", dest="path",help="path of test file")
-	(options, args) = parser.parse_args()
-	test_longacl(options.length,options.path)
-main()
-
diff --git a/testcases/network/nfsv4/locks/Makefile b/testcases/network/nfsv4/locks/Makefile
deleted file mode 100644
index 5812dea3a..000000000
--- a/testcases/network/nfsv4/locks/Makefile
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-#    network/nfsv4/locks testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-MAKE_TARGETS		:= locktests
-
-LDLIBS			+= -lpthread
-
-$(MAKE_TARGETS): $(patsubst $(abs_srcdir)/%.c,%.o,$(wildcard $(abs_srcdir)/*.c))
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/nfsv4/locks/README b/testcases/network/nfsv4/locks/README
deleted file mode 100644
index cf044a45c..000000000
--- a/testcases/network/nfsv4/locks/README
+++ /dev/null
@@ -1,169 +0,0 @@
-COMPILE : make
-RUN LOCAL: ./locktests -n <number of concurent process> -f <test file> [-T]
-
-
-GOAL : This test is aimed at stressing the fcntl locking functions.
-A master process sets a lock on a file region (byte range locking).
-Several slave processes try to perform operations on this region, such
-as: read, write, set a new lock ...
-The expected results of these operations are known.
-If the operation's result is the same as the expected one, the test
-succeeds, otherwise it fails.
-
-
-HISTORY : This program was been written to stress NFSv4 locks.
-
-Slaves are concurrent processes or threads.
--n <num>  : Number of threads to use (mandatory).
--f <file> : Run the test on a test file defined by the -f option (mandatory).
--T        : Use threads instead of processes (optional).
-
-
-
-* RUN NETWORK *
-
-Test server:
-./locktests -n <number of concurent processes> -f <test file> -c <number of clients>
-
-Test clients:
-./locktests --server <server host name>
-
-
-Multiple clients options
-_______________________
-
-These options have been developed to test NFSv4 locking when multiple
-clients try to use the same file.  It uses a test server and several test
-clients.
-
-				--------------
-				|            |
-				| NFS SERVER |
-				|            |
-				--------------
-				      |
-				      |
-		-----------------------------------------------
-		|		      |			      |
-		|		      |			      |
-	------------------    -------------------     ------------------
-	|  NFS Client 1  |    |  NFS Client 1   |     |  NFS Client 1  |
-	|    running     |    |    running      |     |    running     |
-	| a CLIENT TEST  |    | the SERVER TEST |     | a CLIENT TEST  |
-	------------------    -------------------     ------------------
-
-See the DEPLOY file to know how to configure client test on each client.
-
-Server options are:
-
--n <num>  : Number of threads to use (mandatory).
--f <file> : Run the test on given test file defined by the -f option (mandatory).
--c <num>  : Number of clients to connect before starting the tests.
-
-
-Client options
-______________
---server <server hostname>
-
-
-* EXAMPLES *
-============
-
-Local testing:
-./locktests -n 50 -f /file/system/to/test
-
-Multiple clients:
--on the test server (called host1):
-	./locktest -n 50 -f /network/file/system/to/test -c 3
-	(Server waiting for 3 clients to be connected)
-
--test clients:
-	./locktest --server host1
-
-
-HOW TO UNDERSTAND TEST RESULTS
-==============================
-Ten tests are performed:
- 1. WRITE ON A READ  LOCK
- 2. WRITE ON A WRITE LOCK
- 3. READ  ON A READ  LOCK
- 4. READ  ON A WRITE LOCK
- 5. SET A READ  LOCK ON A READ  LOCK
- 6. SET A WRITE LOCK ON A WRITE LOCK
- 7. SET A WRITE LOCK ON A READ  LOCK
- 8. SET A READ  LOCK ON A WRITE LOCK
- 9. READ LOCK THE WHOLE FILE BYTE BY BYTE
- 10. WRITE LOCK THE WHOLE FILE BYTE BY BYTE
-
-
-For each test, the MASTER process takes a lock (READ/WRITE LOCK) and
-the SLAVE processes try to perform the following operations on the
-locked section:
-
- - WRITE
- - READ
- - SET A WRITE LOCK
- - SET A WRITE LOCK
-
-If a slave process performs its test operation without error it prints
-"=", otherwise it prints "x".
-
-An operation performed "without error" means:
-
- - The operation (write, read, fcntl ...) returns no error code, and
- - errno is not changed.
-
-However, "the slave performs its test operation without error" does NOT
-mean the "result is correct".  For example, a slave process is NOT
-allowed to set a READ LOCK on an already-set WRITE LOCK.  When such
-operations are performed, the correct and expected result is that the
-tested function returns the EAGAIN error code.
-
-When all tests have been processed, the result of each process for each
-test is compared with the table of expected results, and a new table is
-displayed:
-
-For example:
-    200 processes of 200 successfully ran test : READ  ON A READ  LOCK
-    200 processes of 200 successfully ran test : SET A READ  LOCK ON A WRITE LOCK
-
-This result lists the process/thread both on local and remote machines.
-
-Note that the testing locks with thread on multiple clients is disabled
-because it does not make sense: 2 different clients obviously run at
-least 2 different processes (thread information cannot be shared
-between this thread over the network).
-
-EXPECTED RESULTS
-================
-Here is the table of expected results, depending on :
- - Slave test operations (READ, WRITE, SET A WRITE LOCK ... )
- - Master Operation (SET A READ/A WRITE LOCK )
- - Slave types (Processes, threads)
- - Locking profile (POSIX locking, Mandatory locking)
-
-
-================================================================================================
-                                   |                     Master  process/thread                |
-===================================|===========================================================|
-Slave type  |   Test operation     |  advisory         locking    |   mandatory      locking   |
-___________________________________|______________________________|____________________________|
-            |                      |  read lock       write lock  |   read lock     write lock |
-___________________________________|______________________________|____________________________|
-thread      |   set a read lock    |   Allowed         Allowed    |    Allowed       Allowed   |
-            |   set a write lock   |   Allowed         Allowed    |    Allowed       Allowed   |
-            |   read               |   Allowed         Allowed    |    Allowed       Allowed   |
-            |   write              |   Allowed         Allowed    |    Allowed       Allowed   |
-===================================+==============================+============================|
-process     |   set a read lock    |   Allowed         Denied     |    Allowed       Denied    |
-            |   set a write lock   |   Denied          Denied     |    Denied        Denied    |
-            |   read               |   Allowed         Allowed    |    Denied        Allowed   |
-            |   write              |   Allowed         Allowed    |    Denied        Denied    |
-================================================================================================
-
-
-**************
-Bull SA - 2006 - http://nfsv4.bullopensource.org
-Tony Reix: tony.reix@bull.net
-Aurélien Charbon: aurelien.charbon@ext bull.net
-**************
diff --git a/testcases/network/nfsv4/locks/VERSION b/testcases/network/nfsv4/locks/VERSION
deleted file mode 100644
index aead93e4f..000000000
--- a/testcases/network/nfsv4/locks/VERSION
+++ /dev/null
@@ -1,3 +0,0 @@
-* 08/02/06 copyediting (bryce)
-* 03/01/06 remove unicode and translate comments in english.
-* 21/12/05 free alocated memory before exiting
diff --git a/testcases/network/nfsv4/locks/deploy/locktests.tar.gz b/testcases/network/nfsv4/locks/deploy/locktests.tar.gz
deleted file mode 100644
index 1e0b517f2bbad3318e8036f494cfa547cd4fda89..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 12354
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

diff --git a/testcases/network/nfsv4/locks/deploy_info b/testcases/network/nfsv4/locks/deploy_info
deleted file mode 100644
index b8a4660f2..000000000
--- a/testcases/network/nfsv4/locks/deploy_info
+++ /dev/null
@@ -1,37 +0,0 @@
-locktest.py script aims to help deploying and running locktests over multiple NFS
-clients accessing the same server.
-
-The source code of NFS client test is in ./deploy/locktests.tar.gz
-
-Setting up lock test with several test machines.
-================================================
-./locktests.py --setup -c <machine1> [machine2 ...] -s <my_nfs_server>:</>
-
---setup                    : Option to setup the test
--c <machine> [...]         : Setup test on these clients
--s <server>:<mountpoint>   : NFS server to use, followed by full directory to mount
-
-
-Example:
-./locktests.py --setup -c client1 client2 client3 -s NFS_Server:/exported/directory
-
-
-Running lock test over several test machines.
-=============================================
-Run test on already configured test machines.
-./locktests.py -n <pid> -f <file> -c <machine1> [machine2 ...]
-
--n <process_id>     : Process number each test machine will lauch to perform the test
--f <file>           : Test file. That must be the same on each machine
--c <machine> [...]  : Clients. run tests from this clients
-
-
-Example:
-./locktests.py -n 50 -f /mnt/nfsv4/testfile -c testmachine1 testmachine2
-
-
-
-_________________________________
- Vincent ROQUETA - Bull SA - 2005
- vincent.roqueta@ext.bull.net
-
diff --git a/testcases/network/nfsv4/locks/locktests.c b/testcases/network/nfsv4/locks/locktests.c
deleted file mode 100644
index 961354e42..000000000
--- a/testcases/network/nfsv4/locks/locktests.c
+++ /dev/null
@@ -1,1034 +0,0 @@
-/* *************************************************
- * *********** README ******************************
- * *************************************************
- *
- * COMPILE : make
- * RUN : ./locktests -n <number of concurent process> -f <test file> [-P]
- *
- * GOAL : This test tries to stress the fcntl locking functions.  A
- * master process sets a lock on a file region (this is called "byte
- * range locking").  Some slave processes try to perform operations on
- * this region, such as read, write, set a new lock ... The expected
- * results of these operations are known.  If the operation result is
- * the same as the expected one, the test suceeds, else it fails.
- *
- *
- *
- * Slaves are concurent processes or thread.
- * -n <num>  : Number of threads to use (mandatory).
- * -f <file> : Run the test on given test file defined by the -f option (mandatory).
- * -c <num>  : Number of clients to connect before starting the tests.
- *
- * HISTORY : This program was written to stress NFSv4 locks.
- * EXAMPLE : ./locktests -n 50 -f /file/system/to/test
- *
- *
- * Vincent ROQUETA 2005 - vincent.roqueta@ext.bull.net
- * BULL S.A.
- */
-
-#include "locktests.h"
-
-int MAXLEN = 64;
-int MAXTEST = 10;
-extern int maxClients;
-extern int fdServer;
-
-char message[M_SIZE];
-int slaveReader;
-int masterReader;
-int slaveWriter;
-
-/* Which lock will be applied by the master process on test startup */
-int LIST_LOCKS[] = { READLOCK, WRITELOCK,
-	READLOCK, WRITELOCK,
-	READLOCK, WRITELOCK,
-	READLOCK, WRITELOCK,
-	BYTELOCK_READ, BYTELOCK_WRITE
-};
-
-/* The operations the slave processes will try to perform */
-int LIST_TESTS[] = { WRONLY, WRONLY,
-	RDONLY, RDONLY,
-	READLOCK, WRITELOCK,
-	WRITELOCK, READLOCK,
-	BYTELOCK_READ, BYTELOCK_WRITE
-};
-
-/* List of test names */
-char *LIST_NAMES_TESTS[] = { "WRITE ON A READ  LOCK",
-	"WRITE ON A WRITE LOCK",
-	"READ  ON A READ  LOCK",
-	"READ  ON A WRITE LOCK",
-	"SET A READ  LOCK ON A READ  LOCK",
-	"SET A WRITE LOCK ON A WRITE LOCK",
-	"SET A WRITE LOCK ON A READ  LOCK",
-	"SET A READ  LOCK ON A WRITE LOCK",
-	"READ LOCK THE WHOLE FILE BYTE BY BYTE",
-	"WRITE LOCK THE WHOLE FILE BYTE BY BYTE"
-};
-
-/* List of expected test results, when slaves are processes */
-int LIST_RESULTS_PROCESS[] = { SUCCES, SUCCES,
-	SUCCES, SUCCES,
-	SUCCES, ECHEC,
-	ECHEC, ECHEC,
-	SUCCES, SUCCES
-};
-
-/* List of expected test results, when slaves are threads */
-int LIST_RESULTS_THREADS[] = { SUCCES, SUCCES,
-	SUCCES, SUCCES,
-	SUCCES, SUCCES,
-	SUCCES, SUCCES,
-	ECHEC, ECHEC
-};
-
-int *LIST_RESULTS = NULL;
-char *eType = NULL;
-
-int TOTAL_RESULT_OK[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
-
-void *slave(void *data);
-int (*finish) (int a);
-
-int finishProcess(int a)
-{
-	exit(a);
-}
-
-int (*load) (void);
-
-struct dataPub dp;
-
-/* Functions to access tests/tests names/tests results*/
-int testSuiv(int n)
-{
-	return LIST_TESTS[n];
-}
-
-int resAttSuiv(int n)
-{
-	return LIST_RESULTS[n];
-}
-
-char *nomTestSuiv(int n)
-{
-	return LIST_NAMES_TESTS[n];
-}
-
-int lockSuiv(int n)
-{
-	return LIST_LOCKS[n];
-}
-
-/* Verify the test result is the expected one */
-int matchResult(int r, int n)
-{
-
-	P("r=%d\n", r);
-	if (r == LIST_RESULTS[n])
-		return 1;
-	else
-		return 0;
-}
-
-/* Increments the number of process which have successfully passed the test */
-void counter(int r, int n)
-{
-	TOTAL_RESULT_OK[n] += matchResult(r, n);
-}
-
-/* Special case for test 'lock file byte byte by byte'.
- * We ensure each byte is correctly locked.
- */
-void validationResults(int n)
-{
-	int i, u, l, fsize;
-	struct flock request;
-
-	fsize = dp.nclnt * (maxClients + 1);
-	TOTAL_RESULT_OK[n] = 0;
-	l = FALSE;
-	u = TRUE;
-
-	/* If the expected operation result is a success, we will have to increase the number of correct results */
-	if (LIST_RESULTS[n]) {
-		l = TRUE;
-		u = FALSE;
-	}
-
-	for (i = 0; i < fsize; i++) {
-		request.l_type = F_WRLCK;
-		request.l_whence = SEEK_SET;
-		request.l_start = i;
-		request.l_len = 1;
-		fcntl(dp.fd, F_GETLK, &request);
-		/* Ensure the lock is correctly set */
-		if (request.l_type != F_UNLCK)
-			TOTAL_RESULT_OK[n] += l;
-		else
-			TOTAL_RESULT_OK[n] += u;
-	}
-}
-
-int initTest(void)
-{
-
-	P("Master opens %s\n", dp.fname);
-	dp.fd = open(dp.fname, OPENFLAGS, MANDMODES);
-	if (dp.fd < 0) {
-		perror("lock test : can't open test file :");
-		finish(1);
-	}
-	P("fd=%d\n", dp.fd);
-	return 0;
-}
-
-struct dataChild *initClientFork(int i)
-{
-	struct dataPriv *dpr;
-	struct dataChild *df;
-
-	/* Initialize private data fields */
-	dpr = malloc(sizeof(struct dataPriv));
-	df = malloc(sizeof(struct dataChild));
-	dpr->whoami = i;
-	df->dp = &dp;
-	df->dpr = dpr;
-	/* Initialize master to client pipe */
-	dp.lclnt[i] = malloc(sizeof(int) * 2);
-	if (pipe(dp.lclnt[i]) < 0) {
-		perror("Impossible to create pipe\n");
-		exit(1);
-	}
-	P("Initialization %d\n", i);
-	write(0, ".", 1);
-	return df;
-}
-
-int initialize(int clnt)
-{
-
-	/* Initialize private data fields */
-	printf("Init\n");
-	dp.nclnt = clnt;
-	dp.lclnt = malloc(sizeof(int *) * clnt);
-	dp.lthreads = malloc(sizeof(pthread_t) * clnt);
-
-	/* Initialize client to master pipe */
-	if (pipe(dp.master) < 0) {
-		perror("Master pipe creation error\n");
-		exit(1);
-	}
-	printf("%s initialization\n", eType);
-	load();
-	initTest();
-
-	return 0;
-}
-
-void cleanClient(struct dataChild *df)
-{
-	int i;
-	i = df->dpr->whoami;
-	free(dp.lclnt[i]);
-	free(df->dpr);
-	free(df);
-}
-
-void clean(void)
-{
-	free(dp.lthreads);
-	free(dp.lclnt);
-}
-
-int loadProcess(void)
-{
-	int i;
-	struct dataChild *df;
-	for (i = 0; i < dp.nclnt; i++) {
-		df = initClientFork(i);
-		if (!fork()) {
-			P("Running slave num: %d\n", df->dpr->whoami);
-			write(0, ".", 1);
-			slave((void *)df);
-			cleanClient(df);
-			exit(0);
-		}
-	}
-	return 0;
-}
-
-void lockWholeFile(struct flock *request)
-{
-	request->l_whence = SEEK_SET;
-	request->l_start = 0;
-	/* Lock the whole file */
-	request->l_len = 0;
-}
-
-void selectTest(int n, struct s_test *test)
-{
-
-	test->test = testSuiv(n);
-	test->resAtt = resAttSuiv(n);
-	test->nom = nomTestSuiv(n);
-	test->type = lockSuiv(n);
-}
-
-/* Final test report */
-int report(int clnt)
-{
-	int rc = 0;
-	int i;
-	int totalClients;
-	totalClients = clnt * (maxClients + 1);
-	printf
-	    ("\n%s number : %d - Remote clients: %d local client 1 - Total client %d - Total concurent tests: %d\n",
-	     eType, clnt, maxClients, maxClients + 1, totalClients);
-	printf("%s number running test successfully :\n", eType);
-	for (i = 0; i < MAXTEST; i++) {
-		if (TOTAL_RESULT_OK[i] != totalClients)
-			rc = 1;
-
-		printf("%d %s of %d successfully ran test : %s\n",
-		       TOTAL_RESULT_OK[i], eType, totalClients,
-		       LIST_NAMES_TESTS[i]);
-    }
-    return rc;
-}
-
-int serverSendLocal(void)
-{
-	int i;
-	/* Synchronize slave processes */
-	/* Configure slaves for test */
-
-	for (i = 0; i < dp.nclnt; i++)
-		write(dp.lclnt[i][1], message, M_SIZE);
-	return 0;
-
-}
-
-void serverSendNet(void)
-{
-	writeToAllClients(message);
-}
-
-int serverReceiveNet(void)
-{
-	int i, c;
-	for (c = 0; c < maxClients; c++) {
-		for (i = 0; i < dp.nclnt; i++) {
-			serverReceiveClient(c);
-		}
-	}
-	return 0;
-}
-
-int serverReceiveLocal(void)
-{
-	int i;
-	for (i = 0; i < dp.nclnt; i++)
-		read(masterReader, message, M_SIZE);
-	return 0;
-}
-
-int clientReceiveLocal(void)
-{
-	read(slaveReader, message, M_SIZE);
-	return 0;
-}
-
-int clientSend(void)
-{
-	write(slaveWriter, message, M_SIZE);
-	return 0;
-}
-
-int serverSend(void)
-{
-	serverSendNet();
-	serverSendLocal();
-	return 0;
-}
-
-int serverReceive(void)
-{
-	serverReceiveNet();
-	serverReceiveLocal();
-	return 0;
-}
-
-/* binary structure <-> ASCII functions used to ensure data will be correctly used over
- * the network, especially when multiples clients do not use the same hardware architecture.
- */
-int serializeTLock(struct s_test *tLock)
-{
-	memset(message, 0, M_SIZE);
-	sprintf(message, "T:%d:%d:%d::", tLock->test, tLock->type,
-		tLock->resAtt);
-	return 0;
-}
-
-void unSerializeTLock(struct s_test *tLock)
-{
-	sscanf(message, "T:%d:%d:%d::", &(tLock->test), &(tLock->type),
-	       &(tLock->resAtt));
-	memset(message, 0, M_SIZE);
-
-}
-
-void serializeFLock(struct flock *request)
-{
-	int len, pid, start;
-	memset(message, 0, M_SIZE);
-	len = (int)request->l_len;
-	pid = (int)request->l_pid;
-	start = (int)request->l_start;
-	/* Beware to length of integer conversions ... */
-	sprintf(message, "L:%hd:%hd:%d:%d:%d::",
-		request->l_type, request->l_whence, start, len, pid);
-}
-
-void serializeResult(int result)
-{
-	memset(message, 0, M_SIZE);
-	sprintf(message, "R:%d::", result);
-
-}
-
-void unSerializeResult(int *result)
-{
-	sscanf(message, "R:%d::", result);
-}
-
-void unSerializeFLock(struct flock *request)
-{
-	int len, pid, start;
-	sscanf(message, "L:%hd:%hd:%d:%d:%d::",
-	       &(request->l_type), &(request->l_whence), &start, &len, &pid);
-	request->l_start = (off_t) start;
-	request->l_len = (off_t) len;
-	request->l_pid = (pid_t) pid;
-}
-
-int serverSendLockClient(struct flock *request, int client)
-{
-	serializeFLock(request);
-	return serverSendClient(client);
-}
-
-int serverSendLockLocal(struct flock *request, int slave)
-{
-	serializeFLock(request);
-	return write(dp.lclnt[slave][1], message, M_SIZE);
-}
-
-int getLockSection(struct flock *request)
-{
-	memset(message, 0, M_SIZE);
-	clientReceiveLocal();
-	unSerializeFLock(request);
-	return 0;
-}
-
-int sendLockTest(struct s_test *tLock)
-{
-	serializeTLock(tLock);
-	serverSend();
-	return 0;
-}
-
-int getLockTest(struct s_test *tLock)
-{
-	clientReceiveLocal();
-	unSerializeTLock(tLock);
-	return 0;
-}
-
-int sendResult(int result)
-{
-	serializeResult(result);
-	clientSend();
-	return 0;
-}
-
-int getResults(int ntest)
-{
-	int i, c;
-	int result = 0;
-	/* Add remote test results */
-	for (c = 0; c < maxClients; c++) {
-		for (i = 0; i < dp.nclnt; i++) {
-			serverReceiveClient(c);
-			unSerializeResult(&result);
-			counter(result, ntest);
-
-		}
-	}
-	/* Add local test results */
-	for (i = 0; i < dp.nclnt; i++) {
-		read(masterReader, message, M_SIZE);
-		unSerializeResult(&result);
-		counter(result, ntest);
-	}
-
-	return 0;
-}
-
-#ifdef DEBUG
-#define P(a,b)  memset(dbg,0,16);sprintf(dbg,a,b);write(0,dbg,16);
-#endif
-
-/* In the case of a network use, the master of the client application si only
- * a 'repeater' of information. It resends server-master instructions to its own slaves.
- */
-void masterClient(void)
-{
-	fd_set fdread;
-	struct timeval tv;
-	int n, i, r, m, start;
-#ifdef DEBUG
-	char dbg[16];
-#endif
-	struct flock lock;
-	int t;
-
-	masterReader = dp.master[0];
-	FD_ZERO(&fdread);
-	tv.tv_sec = 50;
-	tv.tv_usec = 0;
-	n = fdServer > masterReader ? fdServer : masterReader;
-	printf("Master Client - fdServer=%d\n", fdServer);
-	while (1) {
-		/* Add slave and server pipe file descriptors */
-		FD_ZERO(&fdread);
-		FD_SET(fdServer, &fdread);
-		FD_SET(masterReader, &fdread);
-		r = select(n + 1, &fdread, NULL, NULL, &tv);
-		if (r < 0) {
-			perror("select:\n");
-			continue;
-		}
-		if (r == 0) {
-			exit(0);
-		}
-
-		if (FD_ISSET(fdServer, &fdread)) {
-			/* We just have received information from the server.
-			 * We repeat it to slaves.
-			 */
-			i = readFromServer(message);
-			t = message[0];
-			switch (t) {
-			case 'L':
-				/* Lock instruction. We need to send a different section to lock to each process */
-				unSerializeFLock(&lock);
-				start = lock.l_start;
-				for (i = 0; i < dp.nclnt; i++) {
-					lock.l_start = start + i;
-					serializeFLock(&lock);
-					write(dp.lclnt[i][1], message, M_SIZE);
-				}
-				printf("\n");
-				continue;
-			case 'T':
-				/* Test instruction. Ensure server is not sending the END(ish) instruction to end tests */
-				/* To be rewritten asap */
-				m = atoi(&(message[2]));
-				if (m == END)
-					break;
-				if (m == CLEAN)
-					printf("\n");
-
-				serverSendLocal();
-				continue;
-			}
-			break;
-		} else {
-			/* Else, we read information from slaves and repeat them to the server */
-			for (i = 0; i < dp.nclnt; i++) {
-				r = read(masterReader, message, M_SIZE);
-				r = write(fdServer, message, M_SIZE);
-				if (r < 0)
-					perror("write : ");
-
-			}
-			continue;
-		}
-	}
-
-	/* Receive the END(ish) instruction */
-
-	/* Repeat it to the slaves */
-	printf("Exitting...\n");
-	serverSendLocal();
-
-	/* Ok, we can quit */
-	printf("Bye :)\n");
-
-}
-
-int master(void)
-{
-	int i, n, bl;
-	int clnt;
-	char tmp[MAXLEN], *buf;
-#ifdef DEBUG
-	char dbg[16];
-#endif
-	struct flock request;
-	struct s_test tLock;
-	enum state_t state;
-	int offset;
-	/* A test sentence written in the file */
-	char phraseTest[] =
-	    "Ceci est une phrase test ecrite par le maitre dans le fichier";
-	bl = -1;
-	clnt = dp.nclnt;
-	masterReader = dp.master[0];
-	state = SELECT;
-	/* Start with the first test ;) */
-	n = 0;
-	printf("\n--------------------------------------\n");
-	while (1) {
-		switch (state) {
-		case SELECT:
-			/* Select the test to perform   */
-			printf("\n");
-			E("Master: SELECT");
-			selectTest(n, &tLock);
-			state = tLock.type;
-			bl = 0;
-			if (n < MAXTEST) {
-				memset(tmp, 0, MAXLEN);
-				sprintf(tmp, "TEST : TRY TO %s:",
-					LIST_NAMES_TESTS[n]);
-				write(0, tmp, strlen(tmp));
-			} else
-				state = END;
-			P("state=%d\n", state);
-			n += 1;
-			continue;
-
-		case RDONLY:
-		case WRONLY:
-
-		case READLOCK:
-			P("Read lock :%d\n", state);
-			request.l_type = F_RDLCK;
-			state = LOCK;
-			continue;
-
-		case WRITELOCK:
-			P("Write lock :%d\n", state);
-			request.l_type = F_WRLCK;
-			state = LOCK;
-			continue;
-
-		case LOCK:
-			/* Apply the wanted lock */
-			E("Master: LOCK");
-			write(dp.fd, phraseTest, strlen(phraseTest));
-			lockWholeFile(&request);
-			if (fcntl(dp.fd, F_SETLK, &request) < 0) {
-				perror("Master: can't set lock\n");
-				perror("Echec\n");
-				exit(0);
-			}
-			E("Master");
-			state = SYNC;
-			continue;
-
-		case BYTELOCK_READ:
-			bl = 1;
-			request.l_type = F_RDLCK;
-			state = SYNC;
-			continue;
-
-		case BYTELOCK_WRITE:
-			bl = 1;
-			request.l_type = F_WRLCK;
-			state = SYNC;
-			continue;
-
-		case BYTELOCK:
-			/* The main idea is to lock all the bytes in a file. Each slave process locks one byte.
-			 *
-			 * We need :
-			 * - To create a file of a length equal to the total number of slave processes
-			 * - send the exact section to lock to each slave
-			 * - ensure locks have been correctly set
-			 */
-
-			/* Create a string to record in the test file. Length is exactly the number of sub process */
-			P("Master: BYTELOCK: %d\n", state);
-			buf = malloc(clnt * (maxClients + 1));
-			memset(buf, '*', clnt);
-			write(dp.fd, buf, clnt);
-			free(buf);
-
-			/* Each slave process re-writes its own field to lock */
-			request.l_whence = SEEK_SET;
-			request.l_start = 0;
-			request.l_len = 1;
-
-			/* Start to send sections to lock to remote process (network clients) */
-			for (i = 0; i < maxClients; i++) {
-				/* Set the correct byte to lock */
-				offset = (i + 1) * clnt;
-				request.l_start = (off_t) offset;
-				serverSendLockClient(&request, i);
-			}
-
-			/* Now send sections to local processes */
-			for (i = 0; i < clnt; i++) {
-				request.l_start = i;
-				serverSendLockLocal(&request, i);
-			}
-			state = RESULT;
-			continue;
-
-		case SYNC:
-			sendLockTest(&tLock);
-			if (bl) {
-				state = BYTELOCK;
-				continue;
-			}
-
-			if (n < MAXTEST + 1)
-				state = RESULT;
-			else
-				state = END;
-			continue;
-
-		case RESULT:
-			/* Read results by one */
-			getResults(n - 1);
-			if (bl)
-				validationResults(n - 1);
-			state = CLEAN;
-			continue;
-
-		case CLEAN:
-			/* Ask the clients to stop testing ... */
-			tLock.test = CLEAN;
-			serializeTLock(&tLock);
-			serverSend();
-			/* ... and wait for an ack before closing */
-			serverReceive();
-			/* Ignore message content : that is only an ack */
-
-			/* close and open file */
-			close(dp.fd);
-			initTest();
-			state = SELECT;
-			continue;
-		case END:
-			tLock.test = END;
-			serializeTLock(&tLock);
-			serverSend();
-			sleep(2);
-			break;
-
-			printf("(end)\n");
-			exit(0);
-
-		}
-		break;
-	}
-
-	return report(clnt);
-}
-
-/* Slave process/thread */
-
-void *slave(void *data)
-{
-	struct dataChild *df;
-	int i, a, result, ftest;
-	struct s_test tLock;
-	struct flock request;
-	char tmp[16];
-#ifdef DEBUG
-	char dbg[16];
-#endif
-	char *phraseTest = "L'ecriture a reussi";
-	int len;
-	enum state_t state;
-
-	result = -1;
-	ftest = -1;
-	len = strlen(phraseTest);
-	df = (struct dataChild *)data;
-	i = df->dpr->whoami;
-	P("Slave n=%d\n", i);
-	slaveReader = dp.lclnt[i][0];
-	slaveWriter = dp.master[1];
-	state = SYNC;
-	errno = 0;
-	memset(tmp, 0, 16);
-	while (1) {
-		switch (state) {
-		case SELECT:
-		case SYNC:
-			getLockTest(&tLock);
-			state = tLock.test;
-			P("Slave State=%d\n", state);
-
-			continue;
-		case RDONLY:
-			/* Try to read a file */
-			P("TEST READ ONLY %d\n", RDONLY);
-			if ((ftest = open(dp.fname, O_RDONLY | O_NONBLOCK)) < 0) {
-				result = ECHEC;
-				state = RESULT;
-				if (dp.verbose)
-					perror("Open:");
-				continue;
-			}
-			P("fd=%d\n", ftest);
-			a = read(ftest, tmp, 16);
-			if (a < 16)
-				result = ECHEC;
-			else
-				result = SUCCES;
-			state = RESULT;
-			continue;
-
-		case WRONLY:
-			/* Try to write a file */
-			P("TEST WRITE ONLY %d\n", WRONLY);
-			if ((ftest = open(dp.fname, O_WRONLY | O_NONBLOCK)) < 0) {
-				result = ECHEC;
-				state = RESULT;
-				if (dp.verbose)
-					perror("Open read only:");
-				continue;
-			}
-			P("fd=%d\n", ftest);
-			if (write(ftest, phraseTest, len) < len)
-				result = ECHEC;
-			else
-				result = SUCCES;
-			state = RESULT;
-			continue;
-
-		case LOCK:
-
-		case READLOCK:
-			/* Try to read a read-locked section */
-			P("READ LOCK %d\n", F_RDLCK);
-			if ((ftest = open(dp.fname, O_RDONLY | O_NONBLOCK)) < 0) {
-				result = ECHEC;
-				state = RESULT;
-				if (dp.verbose)
-					perror("Open read-write:");
-				continue;
-			}
-
-			P("fd=%d\n", ftest);
-			/* Lock the whole file */
-			request.l_type = F_RDLCK;
-			request.l_whence = SEEK_SET;
-			request.l_start = 0;
-			request.l_len = 0;
-
-			if (fcntl(ftest, F_SETLK, &request) < 0) {
-				if (dp.verbose || errno != EAGAIN)
-					perror("RDONLY: fcntl");
-				result = ECHEC;
-			} else
-				result = SUCCES;
-			state = RESULT;
-			continue;
-
-		case WRITELOCK:
-			/* Try to write a file */
-			P("WRITE LOCK %d\n", F_WRLCK);
-			if ((ftest = open(dp.fname, O_WRONLY | O_NONBLOCK)) < 0) {
-				result = ECHEC;
-				state = RESULT;
-				if (dp.verbose)
-					perror("\nOpen:");
-				continue;
-			}
-			/* Lock the whole file */
-			P("fd=%d\n", ftest);
-			request.l_type = F_WRLCK;
-			request.l_whence = SEEK_SET;
-			request.l_start = 0;
-			request.l_len = 0;
-
-			if (fcntl(ftest, F_SETLK, &request) < 0) {
-				if (dp.verbose || errno != EAGAIN)
-					perror("\nWRONLY: fcntl");
-				result = ECHEC;
-			} else
-				result = SUCCES;
-			state = RESULT;
-			continue;
-
-		case BYTELOCK_READ:
-			P("BYTE LOCK READ: %d\n", state);
-			state = BYTELOCK;
-			continue;
-
-		case BYTELOCK_WRITE:
-			P("BYTE LOCK WRITE: %d\n", state);
-			state = BYTELOCK;
-			continue;
-
-		case BYTELOCK:
-			/* Wait for the exact section to lock. The whole file is sent by the master */
-			P("BYTE LOCK %d\n", state);
-			getLockSection(&request);
-			if ((ftest = open(dp.fname, O_RDWR | O_NONBLOCK)) < 0) {
-				result = ECHEC;
-				state = RESULT;
-				if (dp.verbose)
-					perror("\nOpen:");
-				continue;
-			}
-
-			if (fcntl(ftest, F_SETLK, &request) < 0) {
-				if (dp.verbose || errno != EAGAIN)
-					perror("\nBTLOCK: fcntl");
-				result = ECHEC;
-				state = RESULT;
-				continue;
-			}
-			/* Change the character at the given position for an easier verification */
-			a = lseek(ftest, request.l_start, SEEK_SET);
-			write(ftest, "=", 1);
-			result = SUCCES;
-			state = RESULT;
-			continue;
-
-		case RESULT:
-			if (result == SUCCES)
-				write(0, "=", 1);
-			else
-				write(0, "x", 1);
-			P("RESULT: %d\n", result);
-			sendResult(result);
-			state = SYNC;
-			continue;
-
-		case CLEAN:
-			close(ftest);
-			/* Send CLEAN Ack */
-			sendResult(result);
-			state = SYNC;
-			continue;
-
-		case END:
-			E("(End)\n");
-			finish(0);
-			printf("Unknown command\n");
-			finish(1);
-
-		}
-	}
-
-}
-
-char *nextArg(int argc, char **argv, int *i)
-{
-	if (((*i) + 1) < argc) {
-		(*i) += 1;
-		return argv[(*i)];
-	}
-	return NULL;
-}
-
-int usage(void)
-{
-	printf("locktest -n <number of process> -f <test file> [-T]\n");
-	printf("Number of child process must be higher than 1\n");
-	exit(0);
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	int rc = 0;
-	int i, nThread = 0;
-	char *tmp;
-	int type = 0;
-	int clients;
-	type = PROCESS;
-	dp.fname = NULL;
-	dp.verbose = 0;
-	int server = 1;
-	char *host;
-
-	host = NULL;
-	clients = 0;
-
-	for (i = 1; i < argc; i++) {
-
-		if (!strcmp("-n", argv[i])) {
-			if (!(tmp = nextArg(argc, argv, &i)))
-				usage();
-			nThread = atoi(tmp);
-			continue;
-		}
-
-		if (!strcmp("-f", argv[i])) {
-			if (!(dp.fname = nextArg(argc, argv, &i)))
-				usage();
-			continue;
-		}
-		if (!strcmp("-v", argv[i])) {
-			dp.verbose = TRUE;
-			continue;
-		}
-		if (!strcmp("-c", argv[i])) {
-			if (!(clients = atoi(nextArg(argc, argv, &i))))
-				usage();
-			continue;
-		}
-
-		if (!strcmp("--server", argv[i])) {
-			if (!(host = nextArg(argc, argv, &i)))
-				usage();
-			server = 0;
-			continue;
-		}
-		printf("Ignoring unknown option: %s\n", argv[i]);
-	}
-
-	if (server) {
-		if (!(dp.fname && nThread))
-			usage();
-		if (clients > 0) {
-			configureServer(clients);
-			setupClients(type, dp.fname, nThread);
-		}
-	} else {
-		configureClient(host);
-		dp.fname = malloc(512);
-		memset(dp.fname, 0, 512);
-		getConfiguration(&type, dp.fname, &nThread);
-	}
-
-	if (dp.verbose)
-		printf("By process.\n");
-	load = loadProcess;
-	eType = "process";
-	finish = finishProcess;
-	LIST_RESULTS = LIST_RESULTS_PROCESS;
-	initialize(nThread);
-	if (server) {
-		rc = master();
-	} else {
-		masterClient();
-		free(dp.fname);
-	}
-	clean();
-
-	return rc;
-}
diff --git a/testcases/network/nfsv4/locks/locktests.h b/testcases/network/nfsv4/locks/locktests.h
deleted file mode 100644
index a40e4172e..000000000
--- a/testcases/network/nfsv4/locks/locktests.h
+++ /dev/null
@@ -1,165 +0,0 @@
-/* *************************************************
- * *********** README ******************************
- * *************************************************
- *
- * COMPILE : make
- * RUN : ./locktests -n <number of concurent process> -f <test file> [-P]
- *
- * GOAL : This test tries to stress the fcntl locking functions.  A
- * master process sets a lock on a file region (this is called "byte
- * range locking").  Some slave processes try to perform operations on
- * this region, such as read, write, set a new lock ... The expected
- * results of these operations are known.  If the operation's result is
- * the same as the expected one, the test suceeds, else it fails.
- *
- * Slaves are either concurent processes or threads.
- * -n <num>  : Number of threads to use (mandatory).
- * -f <file> : Run the test on a test file defined by the -f option (mandatory).
- * -T        : Use threads instead of processes (optional).
- *
- * HISTORY : This program has been written to stress NFSv4 locks. -P
- * option was created to verify NFSv4 locking was thread-aware, and so,
- * locking behaviour over NFSv4 was POSIX correct both using threads and
- * process. This option may not be useful to stress.
- *
- * EXAMPLE : ./locktests -n 50 -f /file/system/to/test
- *
- *
- * Vincent ROQUETA 2005 - vincent.roqueta@ext.bull.net
- * BULL S.A.
- */
-
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <math.h>
-#ifdef STDARG
-#include <stdarg.h>
-#endif
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/param.h>
-#include <sys/times.h>
-#ifdef MMAP
-#include <sys/mman.h>
-#endif
-#include <inttypes.h>
-#include <pthread.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <sys/select.h>
-
-#ifdef O_SYNC
-#define OPENFLAGS       (O_CREAT | O_RDWR | O_SYNC )
-#else
-#define OPENFLAGS       (O_CREAT | O_RDWR )
-#endif
-#define OPENMODES       (0600)
-#define MANDMODES       (0600)
-/*(02666)*/
-
-#define SUCCES 1
-#define ECHEC  0
-
-#define TRUE 1
-#define FALSE 0
-
-#define PROCESS 0
-#define THREAD 1
-
-
-//#define DEBUG
-#ifdef DEBUG
-        #define E(a)  perror(a)
-        #define P(a,b) printf(a,b)
-#else
-        #define E(a)
-        #define P(a,b)
-#endif
-
-
-
-#ifndef LOCKTESTS_H
-#define LOCKTESTS_H
-
-#define M_SIZE 512
-
-int writeToAllClients(char *foo);
-
-int serverReceiveNet();
-int clientReceiveNet();
-int serverReceiveClient(int n);
-int setupClients(int type, char *fname, int nThread);
-int serverCloseConnection();
-int getConfiguration(int *type, char *fname, int *nThread);
-int readFromServer(char *message);
-int serverSendClient(int n);
-
-
-enum state_t     {
-                CLEAN,
-                RDONLY,
-                RESULT,
-                WRONLY,
-                SELECT,
-                LOCK,
-                SYNC,
-                END,
-                READLOCK,
-                WRITELOCK,
-                BYTELOCK,
-                BYTELOCK_READ,
-                BYTELOCK_WRITE
-};
-
-/* Public data */
-struct dataPub {
-    /* Number of clients */
-    int nclnt;
-    /* List of master to slave pipes */
-    int **lclnt;
-    /* Slave to master pipe */
-    int master[2];
-    /* Thread list */
-    pthread_t *lthreads;
-    /* test file name */
-    char *fname;
-    /* test file file-descriptor */
-    int fd;
-    /* Detailed error messages */
-    int verbose;
-};
-
-/* private data */
-struct dataPriv {
-    /* thread number */
-    int whoami;
-};
-
-struct dataChild{
-    struct dataPub *dp;
-    struct dataPriv *dpr;
-};
-
-
-struct s_test {
-    int test;
-    int type;
-    char *nom;
-    int resAtt;
-
-};
-
-
-
-
-int configureServer(int  max);
-int configureClient(char *s);
-
-#endif
diff --git a/testcases/network/nfsv4/locks/locktests.py b/testcases/network/nfsv4/locks/locktests.py
deleted file mode 100755
index 9876a86ef..000000000
--- a/testcases/network/nfsv4/locks/locktests.py
+++ /dev/null
@@ -1,236 +0,0 @@
-#!/usr/bin/env python3
-# This script aims to help to run locktests with several clients.
-#
-# Report bugs to Vincent ROQUETA : vincent.roqueta@ext.bull.net
-
-import encodings
-import shutil
-import os, sys
-import getopt, sys
-import string
-import socket
-from stat import *
-from sys import *
-from os import *
-
-NFS4_PATH="/mnt/nfsv4"
-NFS4_SERVER=""
-TEST_HOME="/home/vincent/locks/"
-testfile=NFS4_PATH+"/testfile"
-
-app="locktests"
-SRC="locktests.tar.gz"
-SRC_PATH="deploy"
-install="'tar xzf "+SRC+"; cd locks;  make `"
-user="root"
-
-
-
-
-
-class Machine:
-
-    def mkdir(self,dir):
-        self.command="mkdir -p "+dir
-        self.do()
-    def rmdir(self,dir):
-        self.command="rm -rf "+dir
-        self.do()
-
-    def printc(self):
-        print("->"+self.command)
-        print("\n")
-
-class Client(Machine):
-
-    def __init__(self, machine):
-        self.command=""
-        self.machine=machine
-        self.mountPath=NFS4_PATH
-
-    def do(self):
-        self.command="ssh "+user+"@"+self.machine+" "+self.command
-        os.system(self.command)
-
-    def isomount(self, dir):
-        export=NFS4_SERVER
-        mntpoint=NFS4_PATH
-        self.command="'mkdir -p "+mntpoint+"; mount -t nfs4 "+export+" "+mntpoint+"'"
-        self.do()
-
-    def umount(self, dir):
-        mntpoint=self.mountPath+"/"+dir
-        self.command="umount "+mntpoint
-        self.do()
-    def install(self, path):
-        self.command="'cd "+path+"; tar xzf "+SRC+"; cd locks;  make'"
-        self.do()
-
-    def run(self, appli):
-        self.command=appli
-        self.do()
-    def cp(self, fichier, path):
-        command="scp "+fichier+" "+user+"@"+self.machine+":"+path
-        os.system(command)
-
-
-class Serveur(Machine):
-
-    def __init__(self, ip, exportPath):
-        self.SERVEUR=ip
-        self.exportPath=exportPath
-
-    def do(self):
-        self.command="ssh "+self.SERVEUR+" "+self.command
-        os.system(self.command)
-
-    def configure(self, dir):
-        exportDir=self.exportPath+'/'+dir
-        self. mkdir(exportDir)
-#self.printc()
-        self.export(exportDir)
-#self.printc()
-    def clean(self, dir):
-        unexportDir=self.exportPath+'/'+dir
-        self.unexport(unexportDir)
-        self.rmdir(unexportDir)
-def usage():
-		print("\n")
-		print("usage:")
-		print("locktests.py <-n process -f testfile ><--setup -s fs_server> -c host1, host2, host3 ... ")
-		print("--setup : setup the configuration, deploy test on other test machines; This option also requires -c and -s")
-		print("-c <machine>     : host list to deploy/run/clean the test")
-		print("-s <machine>     : NFS server to use to setup the test")
-		print("-n <num>         : number of processes each test machine will lauch to perform the test")
-		print("-f <file>        : test file. This must be the same on each machine")
-		print(" ")
-		print("Example :")
-		print("=========")
-		print("*Setup machines for testing")
-		print("./locktests.py --setup -c testmachine1 testmachine2 testmachine3 -s my_nfs_server:/")
-		print("\n")
-		print("*Run test on testmachine1,testmachine2 with 50 process on each machine using /mnt/nfsv4/testfile")
-		print("./locktests.py -n 50 -f /mnt/nfsv4/testfile -c testmachine1 testmachine2")
-		print("\n")
-		print("_________________________________")
-		print("Vincent ROQUETA - Bull SA - 2005\n")
-
-		return 0
-
-
-
-def setup():
-    path=os.path.abspath(".")
-    fichier=SRC_PATH+"/"+SRC
-    commande=""
-    for i in clients:
-        print("Setting up machine "+i)
-        c=Client(i)
-        c.mkdir(path)
-        c.cp(fichier, path)
-        c.install(path)
-        c.isomount(NFS4_PATH)
-    #Setup localhost
-    print("Setting up localhost")
-    commande="make; mkdir -p "+NFS4_PATH+" ; mount -t nfs4 "+NFS4_SERVER+" "+NFS4_PATH+" &"
-    os.system(commande)
-
-
-def run():
-    path=os.path.abspath(".")
-    nbreClients=len(clients)
-    hostname=socket.gethostname()
-    # Lancement du serveur en local
-    # Launch the server locally
-    commande=path+"/"+app+" -n "+nbreProcess+" -f "+filename+" -c "+str(nbreClients)+" &"
-    os.system(commande)
-    commande=path+"/locks/"+app+" --server "+hostname
-    for i in clients:
-        c=Client(i)
-        c.run(commande)
-
-def clean():
-   for i in clients:
-    client.umount(NFS4_PATH)
-
-
-
-
-
-
-args=sys.argv[1:]
-rge=list(range(len(args)))
-a=""
-r=True
-s=False
-nfsServer=False
-c=False
-f=False
-n=False
-clients=[]
-for i in rge:
-    if args[i] in ("--install", "-i", "--setup"):
-        r=False
-        s=True
-        continue
-    if args[i] in ("-s", "--server"):
-        a="nfsServer"
-        nfsServer=True
-        continue
-    if args[i] in ("-h", "--help"):
-        usage()
-        sys.exit(1)
-    if args[i] in ("--clients", "-c"):
-        a="clients"
-        c=True
-        continue
-    if args[i] == "-n":
-        a="nbre"
-        n=True
-        continue
-    if args[i] == "-f":
-        a="file"
-        f=True
-        continue
-
-    if a=="clients":
-       clients.append(args[i])
-       continue
-    if a=="file":
-       filename=args[i]
-       continue
-    if a=="nbre":
-       nbreProcess=args[i]
-       continue
-    if a=="nfsServer":
-        NFS4_SERVER=args[i]
-        continue
-
-
-    usage()
-# For ...
-if s:
-    if (not c) or (not nfsServer):
-        usage()
-        sys.exit(1)
-    print("Setup")
-    print(NFS4_SERVER)
-    setup()
-    print("Setup complete")
-
-if r:
-    if (not c) or (not f) or (not n):
-        usage()
-        sys.exit(1)
-
-    print("Running test")
-    run()
-
-
-
-
-
-
-
-
-
diff --git a/testcases/network/nfsv4/locks/netsync.c b/testcases/network/nfsv4/locks/netsync.c
deleted file mode 100644
index b40c002fe..000000000
--- a/testcases/network/nfsv4/locks/netsync.c
+++ /dev/null
@@ -1,201 +0,0 @@
-#include "locktests.h"
-
-#include <netdb.h>
-#include <string.h>
-#define PORT 12346
-#define MAX_CONNECTION 16
-
-int maxClients;
-int *fdClient;
-char *server_name;
-int fdServer;
-extern char message[M_SIZE];
-
-int serverReceiveClient(int c)
-{
-	char tmp[M_SIZE];
-	int r, s;
-	/* Ensure we read _exactly_ M_SIZE characters in the message */
-	memset(message, 0, M_SIZE);
-	memset(tmp, 0, M_SIZE);
-	r = 0;
-	s = 0;
-
-	while (s < M_SIZE) {
-		r = read(fdClient[c], tmp, M_SIZE - s);
-		/* Loop until we have a complete message */
-		strncpy(message + s, tmp, r);
-		s += r;
-	}
-	return s;
-}
-
-int serverSendClient(int n)
-{
-	return write(fdClient[n], message, M_SIZE);
-}
-
-int clientReceiveNet(void)
-{
-	readFromServer(message);
-	return 0;
-}
-
-int setupConnectionServer(void)
-{
-	struct sockaddr_in local;
-	int c;
-	socklen_t size;
-	int sock;
-	struct sockaddr_in remote;
-
-	if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
-		perror("socket");
-		exit(1);
-	}
-	memset(&local, 0x00, sizeof(local));
-	local.sin_family = AF_INET;
-	local.sin_port = htons(PORT);
-	local.sin_addr.s_addr = INADDR_ANY;
-	memset(&(local.sin_zero), 0x00, 8);
-
-	if (bind(sock, (struct sockaddr *)&local, sizeof(struct sockaddr)) ==
-	    -1) {
-		perror("bind");
-		exit(1);
-	}
-
-	if (listen(sock, MAX_CONNECTION) == -1) {
-		perror("listen");
-		return 1;
-	}
-	size = sizeof(struct sockaddr_in);
-	for (c = 0; c < maxClients; c++) {
-		if ((fdClient[c] =
-		     accept(sock, (struct sockaddr *)&remote, &size)) == -1) {
-			perror("accept");
-			return 1;
-		}
-
-	}
-	return 0;
-}
-
-int writeToClient(int c, char *message)
-{
-	return write(fdClient[c], message, 512);
-}
-
-int serverCloseConnection(void)
-{
-	int c;
-	for (c = 0; c < maxClients; c++)
-		close(fdClient[c]);
-	return 0;
-
-}
-
-int writeToAllClients(char *foo)
-{
-	int c;
-	for (c = 0; c < maxClients; c++)
-		writeToClient(c, foo);
-	return 0;
-}
-
-int setupClients(int type, char *fname, int nThread)
-{
-	/*
-	 * Send parameters to all slaves :
-	 *
-	 * We must send :
-	 * - the position of the test file
-	 * - the number of slaves for each client
-	 * - The kind of slaves : process or thread
-	 */
-	char message[512];
-	sprintf(message, "%d:%s:%d::", type, fname, nThread);
-	writeToAllClients(message);
-	return 0;
-}
-
-int configureServer(int max)
-{
-	maxClients = max;
-	fdClient = malloc(sizeof(int) * max);
-
-	setupConnectionServer();
-
-	return 0;
-}
-
-int setupConnectionClient(void)
-{
-
-	struct hostent *server;
-	struct sockaddr_in serv_addr;
-
-	if (!(server = gethostbyname(server_name))) {
-		printf("erreur DNS\n");
-		return 1;
-	}
-
-	fdServer = socket(AF_INET, SOCK_STREAM, 0);
-	if (fdServer < 0) {
-		perror("socket");
-		return 1;
-	}
-
-	serv_addr.sin_addr = *(struct in_addr *)server->h_addr;
-	serv_addr.sin_port = htons(PORT);
-	serv_addr.sin_family = AF_INET;
-	if (connect(fdServer, (struct sockaddr *)&serv_addr, sizeof(serv_addr))
-	    < 0) {
-		perror("connect");
-		return 1;
-	}
-	return 0;
-}
-
-int readFromServer(char *message)
-{
-	char tmp[M_SIZE];
-	int r, s;
-	/* Ensure we read exactly M_SIZE characters */
-	memset(message, 0, M_SIZE);
-	memset(tmp, 0, M_SIZE);
-	r = 0;
-	s = 0;
-	while (s < M_SIZE) {
-		r = read(fdServer, tmp, M_SIZE - s);
-		/* Loop until we have a complete message */
-		strncpy(message + s, tmp, r);
-		s += r;
-	}
-	return s;
-}
-
-int getConfiguration(int *type, char *fname, int *nThread)
-{
-	char conf[M_SIZE];
-	char *p;
-	int i;
-	readFromServer(conf);
-	p = strtok(conf, ":");
-	printf("%s\n", p);
-	*type = atoi(p);
-	p = strtok(NULL, ":");
-	i = strlen(p);
-	strncpy(fname, p, i);
-	p = strtok(NULL, ":");
-	*nThread = atoi(p);
-
-	return 0;
-}
-
-int configureClient(char *s)
-{
-	server_name = s;
-	setupConnectionClient();
-	return 0;
-}
-- 
2.27.0

