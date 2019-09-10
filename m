Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1CAEDB3
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2019 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfIJOuF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Sep 2019 10:50:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbfIJOuF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Sep 2019 10:50:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A19C5C099432
        for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2019 14:50:04 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54B4860BFB;
        Tue, 10 Sep 2019 14:50:04 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id EF16E20ACC; Tue, 10 Sep 2019 10:50:03 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v3 3/4] Add a tool for manipulating the nfsdcld sqlite database schema.
Date:   Tue, 10 Sep 2019 10:50:02 -0400
Message-Id: <20190910145003.4165-4-smayhew@redhat.com>
In-Reply-To: <20190910145003.4165-1-smayhew@redhat.com>
References: <20190910145003.4165-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 10 Sep 2019 14:50:04 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The "clddb-tool" is mainly for downgrading the nfsdcld sqlite database
schema in the event that an admin wants to downgrade nfsdcld.  It also
provides options for fixing corrupt table names (note newer versions of
nfsdcld take care of this automatically) and for printing the contents
of the database.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 configure.ac                    |   1 +
 tools/Makefile.am               |   4 +
 tools/clddb-tool/Makefile.am    |  13 ++
 tools/clddb-tool/clddb-tool.man |  83 ++++++++++
 tools/clddb-tool/clddb-tool.py  | 266 ++++++++++++++++++++++++++++++++
 5 files changed, 367 insertions(+)
 create mode 100644 tools/clddb-tool/Makefile.am
 create mode 100644 tools/clddb-tool/clddb-tool.man
 create mode 100644 tools/clddb-tool/clddb-tool.py

diff --git a/configure.ac b/configure.ac
index 3709694..30b07c1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -655,6 +655,7 @@ AC_CONFIG_FILES([
 	tools/mountstats/Makefile
 	tools/nfs-iostat/Makefile
 	tools/nfsconf/Makefile
+        tools/clddb-tool/Makefile
 	utils/Makefile
 	utils/blkmapd/Makefile
 	utils/nfsdcld/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 4266da4..53e6117 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -8,6 +8,10 @@ endif
 
 OPTDIRS += nfsconf
 
+if CONFIG_NFSDCLD
+OPTDIRS += clddb-tool
+endif
+
 SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/clddb-tool/Makefile.am b/tools/clddb-tool/Makefile.am
new file mode 100644
index 0000000..15a8fd4
--- /dev/null
+++ b/tools/clddb-tool/Makefile.am
@@ -0,0 +1,13 @@
+## Process this file with automake to produce Makefile.in
+PYTHON_FILES =  clddb-tool.py
+
+man8_MANS	= clddb-tool.man
+
+EXTRA_DIST	= $(man8_MANS) $(PYTHON_FILES)
+
+all-local: $(PYTHON_FILES)
+
+install-data-hook:
+	$(INSTALL) -m 755 clddb-tool.py $(DESTDIR)$(sbindir)/clddb-tool
+
+MAINTAINERCLEANFILES=Makefile.in
diff --git a/tools/clddb-tool/clddb-tool.man b/tools/clddb-tool/clddb-tool.man
new file mode 100644
index 0000000..e80b2c0
--- /dev/null
+++ b/tools/clddb-tool/clddb-tool.man
@@ -0,0 +1,83 @@
+.\"
+.\" clddb-tool(8)
+.\"
+.TH clddb-tool 8 "07 Aug 2019"
+.SH NAME
+clddb-tool \- Tool for manipulating the nfsdcld sqlite database
+.SH SYNOPSIS
+.B clddb-tool
+.RB [ \-h | \-\-help ]
+.P
+.B clddb-tool
+.RB [ \-p | \-\-path
+.IR dbpath ]
+.B fix-table-names
+.RB [ \-h | \-\-help ]
+.P
+.B clddb-tool
+.RB [ \-p | \-\-path
+.IR dbpath ]
+.B downgrade-schema
+.RB [ \-h | \-\-help ]
+.RB [ \-v | \-\-version
+.IR to-version ]
+.P
+.B clddb-tool
+.RB [ \-p | \-\-path
+.IR dbpath ]
+.B print
+.RB [ \-h | \-\-help ]
+.RB [ \-s | \-\-summary ]
+.P
+
+.SH DESCRIPTION
+.RB "The " clddb-tool " command is provided to perform some manipulation of the nfsdcld sqlite database schema and to print the contents of the database."
+.SS Sub-commands
+Valid
+.B clddb-tool
+subcommands are:
+.IP "\fBfix-table-names\fP"
+.RB "A previous version of " nfsdcld "(8) contained a bug that corrupted the reboot epoch table names.  This sub-command will fix those table names."
+.IP "\fBdowngrade-schema\fP"
+Downgrade the database schema.  Currently the schema can only to downgraded from version 4 to version 3.
+.IP "\fBprint\fP"
+Display the contents of the database.  Prints the schema version and the values of the current and recovery epochs.  If the
+.BR \-s | \-\-summary
+option is not given, also prints the clients in the reboot epoch tables.
+.SH OPTIONS
+.SS Options valid for all sub-commands
+.TP
+.B \-h, \-\-help
+Show the help message and exit
+.TP
+\fB\-p \fIdbpath\fR, \fB\-\-path \fIdbpath\fR
+Open the sqlite database located at
+.I dbpath
+instead of
+.IR /var/lib/nfs/nfsdcld/main.sqlite ".  "
+This is mainly for testing purposes.
+.SS Options specific to the downgrade-schema sub-command
+.TP
+\fB\-v \fIto-version\fR, \fB\-\-version \fIto-version\fR
+The schema version to downgrade to.  Currently the schema can only be downgraded to version 3.
+.SS Options specific to the print sub-command
+.TP
+.B \-s, \-\-summary
+Do not list the clients in the reboot epoch tables in the output.
+.SH NOTES
+The
+.B clddb-tool
+command will not allow the
+.B fix-table-names
+or
+.B downgrade-schema
+subcommands to be used if
+.BR nfsdcld (8)
+is running.
+.SH FILES
+.TP
+.B /var/lib/nfs/nfsdcld/main.sqlite
+.SH SEE ALSO
+.BR nfsdcld (8)
+.SH AUTHOR
+Scott Mayhew <smayhew@redhat.com>
diff --git a/tools/clddb-tool/clddb-tool.py b/tools/clddb-tool/clddb-tool.py
new file mode 100644
index 0000000..8a66131
--- /dev/null
+++ b/tools/clddb-tool/clddb-tool.py
@@ -0,0 +1,266 @@
+#!/usr/bin/python3
+"""Tool for manipulating the nfsdcld sqlite database
+"""
+
+__copyright__ = """
+Copyright (C) 2019 Scott Mayhew <smayhew@redhat.com>
+
+This program is free software; you can redistribute it and/or
+modify it under the terms of the GNU General Public License
+as published by the Free Software Foundation; either version 2
+of the License, or (at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+MA  02110-1301, USA.
+"""
+
+import argparse
+import os
+import sqlite3
+import sys
+
+
+class CldDb():
+    def __init__(self, path):
+        self.con = sqlite3.connect(path)
+        self.con.row_factory = sqlite3.Row
+        for row in self.con.execute('select value from parameters '
+                                    'where key = "version"'):
+            self.version = int(row['value'])
+        for row in self.con.execute('select * from grace'):
+            self.current = int(row['current'])
+            self.recovery = int(row['recovery'])
+
+    def __del__(self):
+        self.con.close()
+
+    def __str__(self):
+        return ('Schema version: {self.version} '
+                'current epoch: {self.current} '
+                'recovery epoch: {self.recovery}'.format(self=self))
+
+    def _print_clients(self, epoch):
+        if epoch:
+            for row in self.con.execute('select * from "rec-{:016x}"'
+                                        .format(epoch)):
+                if self.version >= 4:
+                    if row['princhash'] is not None:
+                        princhash = row['princhash'].hex()
+                    else:
+                        princhash = "(null)"
+                    print('id = {}, princhash = {}'
+                          .format(row['id'].decode(), princhash))
+                else:
+                    print('id = {}'.format(row['id'].decode()))
+
+    def print_current_clients(self):
+        print('Clients in current epoch:')
+        self._print_clients(self.current)
+
+    def print_recovery_clients(self):
+        if self.recovery:
+            print('Clients in recovery epoch:')
+            self._print_clients(self.recovery)
+
+    def check_bad_table_names(self):
+        bad_names = []
+        for row in self.con.execute('select name from sqlite_master '
+                                    'where type = "table" '
+                                    'and name like "%rec-%" '
+                                    'and length(name) < 20'):
+            bad_names.append(row['name'])
+        return bad_names
+
+    def fix_bad_table_names(self):
+        try:
+            self.con.execute('begin exclusive transaction')
+            bad_names = self.check_bad_table_names()
+            for bad_name in bad_names:
+                epoch = int(bad_name.split('-')[1], base=16)
+                if epoch == self.current or epoch == self.recovery:
+                    if epoch == self.current:
+                        which = 'current'
+                    else:
+                        which = 'recovery'
+                    print('found invalid table name {} for {} epoch'
+                          .format(bad_name, which))
+                    self.con.execute('alter table "{}" '
+                                     'rename to "rec-{:016x}"'
+                                     .format(bad_name, epoch))
+                    print('renamed to rec-{:016x}'.format(epoch))
+                else:
+                    print('found invalid table name {} for unknown epoch {}'
+                          .format(bad_name, epoch))
+                    self.con.execute('drop table "{}"'.format(bad_name))
+                    print('dropped table {}'.format(bad_name))
+        except sqlite3.Error:
+            self.con.rollback()
+        else:
+            self.con.commit()
+
+    def has_princ_data(self):
+        if self.version < 4:
+            return False
+        for row in self.con.execute('select count(*) '
+                                    'from "rec-{:016x}" '
+                                    'where princhash not null'
+                                    .format(self.current)):
+            count = row[0]
+        if self.recovery:
+            for row in self.con.execute('select count(*) '
+                                        'from "rec-{:016x}" '
+                                        'where princhash not null'
+                                        .format(self.current)):
+                count = count + row[0]
+        if count:
+            return True
+        return False
+
+    def _downgrade_table_v4_to_v3(self, epoch):
+        if not self.con.in_transaction:
+            raise sqlite3.Error
+        try:
+            self.con.execute('create table "new_rec-{:016x}" '
+                             '(id blob primary key)'.format(epoch))
+            self.con.execute('insert into "new_rec-{:016x}" '
+                             'select id from "rec-{:016x}"'
+                             .format(epoch, epoch))
+            self.con.execute('drop table "rec-{:016x}"'.format(epoch))
+            self.con.execute('alter table "new_rec-{:016x}" '
+                             'rename to "rec-{:016x}"'
+                             .format(epoch, epoch))
+        except sqlite3.Error:
+            raise
+
+    def downgrade_schema_v4_to_v3(self):
+        try:
+            self.con.execute('begin exclusive transaction')
+            for row in self.con.execute('select value from parameters '
+                                        'where key = "version"'):
+                version = int(row['value'])
+            if version != self.version:
+                raise sqlite3.Error
+            for row in self.con.execute('select * from grace'):
+                current = int(row['current'])
+                recovery = int(row['recovery'])
+            if current != self.current:
+                raise sqlite3.Error
+            if recovery != self.recovery:
+                raise sqlite3.Error
+            self._downgrade_table_v4_to_v3(current)
+            if recovery:
+                self._downgrade_table_v4_to_v3(recovery)
+            self.con.execute('update parameters '
+                             'set value = "3" '
+                             'where key = "version"')
+            self.version = 3
+        except sqlite3.Error:
+            self.con.rollback()
+            print('Downgrade failed')
+        else:
+            self.con.commit()
+            print('Downgrade successful')
+
+
+def nfsdcld_active():
+    rc = os.system('ps -C nfsdcld >/dev/null 2>/dev/null')
+    if rc == 0:
+        return True
+    return False
+
+
+def fix_table_names_command(db, args):
+    if nfsdcld_active():
+        print('Warning: nfsdcld is running!')
+        ans = input('Continue? ')
+        if ans.lower() not in ['y', 'yes']:
+            print('Operation canceled.')
+            return
+    bad_names = db.check_bad_table_names()
+    if not bad_names:
+        print('No invalid table names found.')
+        return
+    db.fix_bad_table_names()
+
+
+def downgrade_schema_command(db, args):
+    if nfsdcld_active():
+        print('Warning: nfsdcld is running!')
+        ans = input('Continue? ')
+        if ans.lower() not in ['y', 'yes']:
+            print('Operation canceled')
+            return
+    if db.version != 4:
+        print('Cannot downgrade database from schema version {}.'
+              .format(db.version))
+        return
+    if args.version != 3:
+        print('Cannot downgrade to version {}.'.format(args.version))
+        return
+    bad_names = db.check_bad_table_names()
+    if bad_names:
+        print('Invalid table names detected.')
+        print('Please run "{} fix-table-names" before downgrading the schema.'
+              .format(sys.argv[0]))
+        return
+    if db.has_princ_data():
+        print('Warning: database has principal data, which will be erased.')
+        ans = input('Continue? ')
+        if ans.lower() not in ['y', 'yes']:
+            print('Operation canceled')
+            return
+    db.downgrade_schema_v4_to_v3()
+
+
+def print_command(db, args):
+    print(str(db))
+    if not args.summary:
+        bad_names = db.check_bad_table_names()
+        if bad_names:
+            print('Invalid table names detected.')
+            print('Please run "{} fix-table-names".'.format(sys.argv[0]))
+            return
+        db.print_current_clients()
+        db.print_recovery_clients()
+
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument('-p', '--path',
+                        default='/var/lib/nfs/nfsdcld/main.sqlite',
+                        help='path to the database '
+                        '(default: /var/lib/nfs/nfsdcld/main.sqlite)')
+    subparsers = parser.add_subparsers(help='sub-command help')
+    fix_parser = subparsers.add_parser('fix-table-names',
+                                       help='fix invalid table names')
+    fix_parser.set_defaults(func=fix_table_names_command)
+    downgrade_parser = subparsers.add_parser('downgrade-schema',
+                                             help='downgrade database schema')
+    downgrade_parser.add_argument('-v', '--version', type=int, choices=[3],
+                                  default=3,
+                                  help='version to downgrade to')
+    downgrade_parser.set_defaults(func=downgrade_schema_command)
+    print_parser = subparsers.add_parser('print',
+                                         help='print database info')
+    print_parser.add_argument('-s', '--summary', default=False,
+                              action='store_true',
+                              help='print summary only')
+    print_parser.set_defaults(func=print_command)
+    args = parser.parse_args()
+    if not os.path.exists(args.path):
+        return parser.print_usage()
+    clddb = CldDb(args.path)
+    return args.func(clddb, args)
+
+
+if __name__ == '__main__':
+    if len(sys.argv) == 1:
+        sys.argv.extend(['print', '--summary'])
+    main()
-- 
2.17.2

