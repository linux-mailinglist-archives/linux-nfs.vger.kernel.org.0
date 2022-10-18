Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B526560264F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 10:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJRIBJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 04:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJRIBG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 04:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E10844DD
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 01:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666080055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C8PSLW80t9Xp9/9nA3nRtJc/+1iNr08vIv/jpOvHEHQ=;
        b=cjigYMfG9u7E9kZJUGINabbaaH6v4MNVdhjciGF6bn+/VepsXnBHv3x4F7ymL334XLmf+R
        Nq7NlpNJ2ulj/aOQZ3PlhDCP80KO+kuuyjx4Y2yhuuMZzwaBLZnD3eE4LqWoS2qn6SUUGJ
        X+6/GTv8Mbk8MsppbY/4aNyPUMlk7YU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-UubqMQMkMHag-WdpBSrpRg-1; Tue, 18 Oct 2022 04:00:51 -0400
X-MC-Unique: UubqMQMkMHag-WdpBSrpRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B15A8041B5;
        Tue, 18 Oct 2022 08:00:51 +0000 (UTC)
Received: from localhost (unknown [10.66.61.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DEFC404CD9A;
        Tue, 18 Oct 2022 08:00:49 +0000 (UTC)
From:   Jianhong Yin <jiyin@redhat.com>
To:     dros@monkey.org, dros@netapp.com
Cc:     linux-nfs@vger.kernel.org, Jianhong Yin <jiyin@redhat.com>,
        Jianhong Yin <yin-jianhong@163.com>
Subject: [PATCH] merge python3 patch from fedora nfsometer package
Date:   Tue, 18 Oct 2022 15:59:46 +0800
Message-Id: <20221018075946.283516-1-jiyin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

see: https://src.fedoraproject.org/rpms/nfsometer/tree/rawhide

nfsometer upstream can not work on latest linux with python3, just
copy the python3 patch from fedora nfsometer pkg back to upstream

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---
 README                     |  17 +++--
 nfsometer.py               |  23 +++----
 nfsometerlib/cmd.py        |  12 ++--
 nfsometerlib/collection.py |  76 +++++++++++----------
 nfsometerlib/config.py     |  10 +--
 nfsometerlib/graph.py      |  46 ++++++-------
 nfsometerlib/options.py    |  35 +++++-----
 nfsometerlib/parse.py      | 131 +++++++++++++++++++------------------
 nfsometerlib/report.py     |  82 +++++++++++++----------
 nfsometerlib/selector.py   |  34 ++++++----
 nfsometerlib/trace.py      | 103 +++++++++++++++--------------
 nfsometerlib/workloads.py  |  47 ++++++-------
 setup.py                   |   8 +--
 13 files changed, 330 insertions(+), 294 deletions(-)

diff --git a/README b/README
index 750db9e..f9cdacf 100644
--- a/README
+++ b/README
@@ -17,15 +17,18 @@ Dependencies
   nfsometer depends on several third-party packages and will not run without
   them installed.
 
-   - matplotlib - used for graph plotting
-   - numpy      - used by matplotlib, stats functions
-   - mako       - used for html templating of reports
-   - nfs-utils  - mount.nfs, mountstats, etc
-   - time       - /bin/time
+   - python3-setuptools - as you known
+   - python3-matplotlib - used for graph plotting
+   - python3-numpy      - used by matplotlib, stats functions
+   - python3-mako       - used for html templating of reports
+   - python3-devel      - used for build from source code
+   - nfs-utils          - mount.nfs, mountstats, etc
+   - time               - /bin/time
+   - filebench          - /usr/bin/filebench
 
   On a fedora system the following command will install these packages:
 
-  # sudo yum install python-matplotlib numpy python-mako nfs-utils time
+  # sudo yum install python3-{setuptools,matplotlib,numpy,mako,devel} nfs-utils time filebench
 
   Other distros will have a similar command.
 
@@ -40,7 +43,7 @@ Installation
   nfsometer can also be installed to standard python site-packages and
   executable directories (must be run as root):
 
-  # python setup.py install
+  # python3 setup.py install
   # nfsometer --help
 
 
diff --git a/nfsometer.py b/nfsometer.py
index cbd544b..9dd2faa 100755
--- a/nfsometer.py
+++ b/nfsometer.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 """
 Copyright 2012 NetApp, Inc. All Rights Reserved,
 contribution by Weston Andros Adamson <dros@netapp.com>
@@ -15,6 +15,7 @@ FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 import posix
 import sys
 import os
+import six
 
 from nfsometerlib import trace
 from nfsometerlib import options
@@ -46,19 +47,19 @@ def mode_notes(opts):
     collection = TraceCollection(opts.resultdir)
     collection.notes_edit()
 
-    print 'Saved notes for results %s' % (opts.resultdir)
+    print('Saved notes for results %s' % (opts.resultdir))
 
 def mode_list(opts):
     collection = TraceCollection(opts.resultdir)
 
-    print 'Result directory \'%s\' contains:\n\n%s' % \
-        (opts.resultdir, '\n'.join(collection.show_contents(pre='')))
+    print('Result directory \'%s\' contains:\n\n%s' % \
+        (opts.resultdir, '\n'.join(collection.show_contents(pre=''))))
 
 def mode_workloads(opts):
-    print "Available workloads:"
-    print "  %s" % '\n  '.join(available_workloads())
-    print "Unavailable workloads:"
-    print "  %s" % '\n  '.join(unavailable_workloads())
+    print("Available workloads:")
+    print("  %s" % '\n  '.join(available_workloads()))
+    print("Unavailable workloads:")
+    print("  %s" % '\n  '.join(unavailable_workloads()))
 
 def mode_loadgen(opts):
     # XXX check idle?
@@ -75,7 +76,7 @@ def mode_fetch_trace(opts, fetch_only=False):
     check_idle_before_start(opts)
     collection = TraceCollection(opts.resultdir)
     trace.run_traces(collection, opts, fetch_only=fetch_only)
-    print
+    print('')
 
 def mode_report(opts):
     collection = TraceCollection(opts.resultdir)
@@ -83,7 +84,7 @@ def mode_report(opts):
         rpt = ReportSet(collection, opts.serial_graph_gen)
         rpt.generate_reports()
     else:
-        print "No tracedirs found"
+        print("No tracedirs found")
 
 def main():
     opts = options.Options()
@@ -129,5 +130,5 @@ if __name__ == '__main__':
     try:
         main()
     except KeyboardInterrupt:
-        print >>sys.stderr, "\nCancelled by user...\n"
+        six.print_("\nCancelled by user...\n", file=sys.stderr)
 
diff --git a/nfsometerlib/cmd.py b/nfsometerlib/cmd.py
index a2ebcef..32ddcd0 100644
--- a/nfsometerlib/cmd.py
+++ b/nfsometerlib/cmd.py
@@ -12,9 +12,9 @@ FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 """
 
 import os
-import posix
 import sys
 import subprocess
+import six
 
 # command wrappers
 def simplecmd(args):
@@ -41,11 +41,11 @@ class CmdErrorOut(CmdError):
 def cmd(args, raiseerrorcode=True, raiseerrorout=True, instr='',
         env=None, pass_output=False):
 
-    #print "command> %s" % args
+    #print("command> %s" % args)
 
     if env:
-        curenv = dict(posix.environ)
-        for k,v in env.iteritems():
+        curenv = dict(os.environ)
+        for k,v in six.iteritems(env):
             curenv[k] = v
         env = curenv
 
@@ -82,11 +82,13 @@ def cmd(args, raiseerrorcode=True, raiseerrorout=True, instr='',
                             (args, errstr))
 
     if outstr:
-        o_str = outstr.split('\n')
+        o_str = outstr.decode('utf-8').split('\n')
     else:
         o_str = ''
 
     if errstr:
+        if isinstance(errstr, six.binary_type):
+          errstr = errstr.decode('utf-8')
         e_str = errstr.split('\n')
     else:
         e_str = ''
diff --git a/nfsometerlib/collection.py b/nfsometerlib/collection.py
index 6d83862..95227d3 100644
--- a/nfsometerlib/collection.py
+++ b/nfsometerlib/collection.py
@@ -14,11 +14,12 @@ FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 import os
 import numpy as np
 from subprocess import call
+import six
 
-from config import *
-from selector import Selector
-import parse
-from trace import TraceAttrs
+from .config import *
+from .selector import Selector
+from . import parse
+from .trace import TraceAttrs
 
 class Stat:
     """
@@ -64,7 +65,7 @@ class Stat:
         return "Stat(name=%r, values=%r, tracedirs=%r)" % \
                     (self.name, self._values, self._tracedirs)
 
-    def __nonzero__(self):
+    def __bool__(self):
         return not self.empty()
 
     def num_runs(self):
@@ -75,7 +76,7 @@ class Stat:
         """ return the value for the run associated with tracedir """
         try:
             run = self._tracedirs.index(tracedir)
-        except ValueError, e:
+        except ValueError as e:
             if args:
                 assert len(args) == 1
                 return args[0]
@@ -83,7 +84,7 @@ class Stat:
 
         try:
             return self._values[run]
-        except IndexError, e:
+        except IndexError as e:
             if args:
                 assert len(args) == 1
                 return args[0]
@@ -161,12 +162,12 @@ class Bucket:
         self._empty = None
         self._num_runs = None
 
-    def __nonzero__(self):
+    def __bool__(self):
         return not self.empty()
 
     def _sort(self):
         if not self._sorted:
-            self._stats.sort(lambda x,y: -1 * cmp(x.mean(), y.mean()))
+            self._stats.sort(key=lambda x: x.mean(), reverse=True)
             self._sorted = True
 
     def foreach(self):
@@ -182,12 +183,12 @@ class Bucket:
 
     def mean(self):
         if self._mean == None:
-            self._mean = np.mean(self._sum_by_tracedir.values())
+            self._mean = np.mean(list(self._sum_by_tracedir.values()))
         return self._mean
 
     def std(self):
         if self._std == None:
-            self._std = np.std(self._sum_by_tracedir.values())
+            self._std = np.std(list(self._sum_by_tracedir.values()))
         return self._std
 
     def max(self):
@@ -223,7 +224,7 @@ class Bucket:
             if not d in self._tracedirs:
                 self._tracedirs.append(d)
 
-            if not self._sum_by_tracedir.has_key(d):
+            if d not in self._sum_by_tracedir:
                 self._sum_by_tracedir[d] = 0.0
             self._sum_by_tracedir[d] += vals[i]
 
@@ -240,15 +241,16 @@ class TraceStats:
         self._num_runs = None
 
     def add_attr(self, name, value):
-        if not self._attrs.has_key(name):
-            self._attrs[name] = set()
-        self._attrs[name].add(value)
+        if name not in self._attrs:
+            self._attrs[name] = set([value])
+        else:
+            self._attrs[name].add(value)
 
     def get_attr(self, name):
         return self._attrs[name]
 
     def has_attr(self, name):
-        return self._attrs.has_key(name)
+        return name in self._attrs
 
     def merge_attrs(self, new):
         str_attrs = ['workload_command', 'workload_description']
@@ -264,7 +266,7 @@ class TraceStats:
         """ add a value for the key.  should be called once on each key for
             every workload result directory """
 
-        if not self._values.has_key(key):
+        if key not in self._values:
             self._values[key] = Stat(key)
 
         self._values[key].add_value(float(value), filename, tracedir)
@@ -293,7 +295,7 @@ class TraceStats:
             every workload result directory """
         assert isinstance(stat, Stat), repr(stat)
 
-        if not self._values.has_key(bucket_name):
+        if bucket_name not in self._values:
             self._values[bucket_name] = Bucket(bucket_name)
 
         self._values[bucket_name].add_stat_to_bucket(stat)
@@ -337,7 +339,7 @@ class TraceCollection:
                 # new
                 elif ent.startswith(TRACE_DIR_PREFIX) and os.path.isdir(ent):
                     self.load_tracedir(ent)
-            except IOError, e:
+            except IOError as e:
                 self.warn(ent, str(e))
 
         os.chdir(cwd)
@@ -351,7 +353,7 @@ class TraceCollection:
         servers = set()
         paths = set()
 
-        for sel, tracestat in self._tracestats.iteritems():
+        for sel, tracestat in six.iteritems(self._tracestats):
             parse.gather_buckets(self, tracestat)
 
             workloads.add(sel.workload)
@@ -391,7 +393,7 @@ class TraceCollection:
     def notes_get(self):
         notes_file = os.path.join(self.resultsdir, NOTES_FILE)
         try:
-            return file(notes_file).readlines()
+            return open(notes_file).readlines()
         except IOError:
             return []
 
@@ -401,19 +403,19 @@ class TraceCollection:
         if msg.startswith('[Errno '):
             msg = msg[msg.find(']') + 1:]
 
-        if not self._warnings.has_key(tracedir):
+        if tracedir not in self._warnings:
             self._warnings[tracedir] = []
         self._warnings[tracedir].append(msg.replace(tracedir, '[dir]/'))
         warn(tracedir + ': ' + msg)
 
     def warnings(self):
-        return [ (d, tuple(self._warnings[d])) for d in self._warnings.keys() ]
+        return [ (d, tuple(self._warnings[d])) for d in list(self._warnings.keys()) ]
 
     def empty(self):
         return len(self._tracestats) == 0
 
     def set_stat_info(self, key, info):
-        if not self._stat_info.has_key(key):
+        if key not in self._stat_info:
             self._stat_info[key] = info
         else:
             assert self._stat_info[key] == info, \
@@ -450,7 +452,7 @@ class TraceCollection:
 
         assert sel.is_valid_key(), "Invalid key: %r" % sel
 
-        if not self._tracestats.has_key(sel):
+        if sel not in self._tracestats:
             self._tracestats[sel] = TraceStats(self)
 
         return self._tracestats[sel]
@@ -462,7 +464,7 @@ class TraceCollection:
         """ return True if this collection has any traces matching 'selection',
             otherwise returns False """
         for x in selection.foreach():
-            if self._tracestats.has_key(x):
+            if x in self._tracestats:
                 return True
         return False
 
@@ -474,7 +476,7 @@ class TraceCollection:
         attr_file = os.path.join(tracedir, 'arguments')
         trace_attrs = TraceAttrs(filename=attr_file).to_dict()
 
-        for k, v in trace_attrs.iteritems():
+        for k, v in six.iteritems(trace_attrs):
             attr[k] = v
 
         return attr
@@ -485,7 +487,7 @@ class TraceCollection:
             returns empty string if nothing is found
         """
         def _check_lines(f):
-            return '\n'.join([ x[2:] for x in file(f).readlines()
+            return '\n'.join([ x[2:] for x in open(f).readlines()
                 if x.startswith('>') and x.lower().find('nfs:') >= 0 ])
 
         diff = os.path.join(tracedir, 'dmesg.diff')
@@ -528,14 +530,18 @@ class TraceCollection:
         for subsel in selection.foreach():
             try:
                 tracestat = self.get_trace(subsel)
-            except KeyError:
+            except KeyError as e:
                 continue
 
             if tracestat.has_attr(attr_name):
                 trace_attr = tracestat.get_attr(attr_name)
                 attr = attr.union(trace_attr)
 
-        attr = list(attr)
+        if not attr:
+            attr = []
+        else:
+            attr = list(attr)
+
         attr.sort()
 
         return tuple(attr)
@@ -568,9 +574,9 @@ class TraceCollection:
                 if not mdt in map_order:
                     map_order.append(mdt)
 
-                if not tmpmap.has_key(mdt):
+                if mdt not in tmpmap:
                     tmpmap[mdt] = {}
-                if not tmpmap[mdt].has_key(nruns):
+                if nruns not in tmpmap[mdt]:
                     tmpmap[mdt][nruns] = []
 
                 tmpmap[mdt][nruns].append(subsel.workload)
@@ -578,10 +584,10 @@ class TraceCollection:
             wmap = {}
             worder = []
             for mdt in map_order:
-                if not tmpmap.has_key(mdt):
+                if mdt not in tmpmap:
                     continue
 
-                runs = tmpmap[mdt].keys()
+                runs = list(tmpmap[mdt].keys())
                 runs.sort()
 
                 for r in runs:
@@ -633,7 +639,7 @@ class TraceCollection:
         order = ['workload', 'client', 'server', 'mountopt', 'detect', 'tag', 'kernel', 'path']
 
         for subsel in selection.foreach(order):
-            assert not vals.has_key(subsel)
+            assert subsel not in vals
             vals[subsel] = {}
 
             try:
diff --git a/nfsometerlib/config.py b/nfsometerlib/config.py
index 76d74d9..8439c44 100644
--- a/nfsometerlib/config.py
+++ b/nfsometerlib/config.py
@@ -12,7 +12,7 @@ FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 """
 
 import re
-import os, posix, stat, sys
+import os, stat, sys
 import socket
 
 NFSOMETER_VERSION='1.9'
@@ -20,7 +20,7 @@ NFSOMETER_VERSION='1.9'
 NFSOMETER_MANPAGE='nfsometer.1'
 
 NFSOMETERLIB_DIR=os.path.split(__file__)[0]
-NFSOMETER_DIR=os.path.join(posix.environ['HOME'], '.nfsometer')
+NFSOMETER_DIR=os.path.join(os.environ['HOME'], '.nfsometer')
 
 
 #
@@ -47,7 +47,7 @@ TRACE_LOADGEN_STAGGER_MAX = 60
 #
 MOUNTDIR=os.path.join(RUNNING_TRACE_DIR, 'mnt')
 WORKLOADFILES_ROOT=os.path.join(NFSOMETER_DIR, 'workload_files')
-RESULTS_DIR=os.path.join(posix.environ['HOME'], 'nfsometer_results')
+RESULTS_DIR=os.path.join(os.environ['HOME'], 'nfsometer_results')
 HOSTNAME=socket.getfqdn()
 RUNROOT='%s/nfsometer_runroot_%s' % (MOUNTDIR, HOSTNAME)
 HTML_DIR="%s/html" % NFSOMETERLIB_DIR
@@ -139,7 +139,7 @@ TEMPLATE_REPORTINFO='%s/report_info.html' % HTML_DIR
 _TEMPLATE_CACHE={}
 def html_template(filename):
     global _TEMPLATE_CACHE
-    if not _TEMPLATE_CACHE.has_key(filename):
+    if filename not in _TEMPLATE_CACHE:
         _TEMPLATE_CACHE[filename] = Template(filename=filename)
     return _TEMPLATE_CACHE[filename]
 
@@ -244,7 +244,7 @@ def groups_by_nfsvers(groups):
     gmap = {}
     for g in groups:
         vers = mountopts_version(g.mountopt)
-        if not gmap.has_key(vers):
+        if vers not in gmap:
             gmap[vers] = []
         gmap[vers].append(g)
     return gmap
diff --git a/nfsometerlib/graph.py b/nfsometerlib/graph.py
index 3cd2e8d..18b2552 100644
--- a/nfsometerlib/graph.py
+++ b/nfsometerlib/graph.py
@@ -11,15 +11,15 @@ ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 """
 
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 import multiprocessing
-import cPickle
-import os, sys, time
+from six.moves import cPickle
+import os, sys, time, errno
 
-from collection import *
-from config import *
-import selector
+from .collection import *
+from .config import *
+from . import selector
 
 _GRAPH_COLLECTION = None
 
@@ -52,8 +52,8 @@ class GraphFactory:
 
         try:
             os.mkdir(self.imagedir)
-        except OSError, e:
-            assert e.errno == os.errno.EEXIST
+        except OSError as e:
+            assert e.errno == errno.EEXIST
 
         self._entries = set(os.listdir(imagedir))
 
@@ -104,8 +104,8 @@ class GraphFactory:
         if classes:
            other_attrs.append('class="%s"' % ' '.join(classes))
 
-        if attrs.has_key('groups'):
-            if not attrs.has_key('gmap'):
+        if 'groups' in attrs:
+            if 'gmap' not in attrs:
                 attrs['gmap'] = groups_by_nfsvers(attrs['groups'])
             gmap = attrs['gmap']
 
@@ -116,7 +116,7 @@ class GraphFactory:
             cur = 0
             sub_src = []
             for vers in NFS_VERSIONS:
-                if not gmap.has_key(vers):
+                if vers not in gmap:
                     continue
 
                 assert cur < num
@@ -288,26 +288,26 @@ class GraphFactory:
 
         inform('\rGraph Summary:                                  ')
         if self.gen_count:
-            print '  %u images generated' % self.gen_count
+            print('  %u images generated' % self.gen_count)
         if self.cached_count:
-            print '  %u cached images' % self.cached_count
+            print('  %u cached images' % self.cached_count)
         if self.prune_count:
-            print '  %u files pruned' % self.prune_count
+            print('  %u files pruned' % self.prune_count)
 
 def _fmt_data(x, scale):
     assert not isinstance(x, (list, tuple))
-    if isinstance(x, Stat):
+    if isinstance(x, Stat) or type(x).__name__ == 'Stat':
         return x.mean() / scale, x.std() / scale
 
     # disallow?
-    elif isinstance(x, (float, int, long)):
+    elif isinstance(x, (float,)+six.integer_types):
         return x, 0.0
 
     elif x == None:
         # when graphing, no data can just be zero
         return 0.0, 0.0
 
-    raise ValueError('Unexpected data type for %r' % (val,))
+    raise ValueError('Unexpected data type for %r' % (x,))
 
 def _graphize_units(units):
     if not units:
@@ -321,7 +321,7 @@ def graph_cb_wrapper(graph_f, imgfile, attrs):
         graph_f(imgfile, attrs)
     except KeyboardInterrupt:
         return False
-    except Exception, e:
+    except Exception as e:
         return e
     return True
 
@@ -365,7 +365,7 @@ def make_bargraph_cb(imgfile, attrs):
     ax1 = fig.add_subplot(111)
     ax1.set_autoscale_on(True)
     ax1.autoscale_view(True,True,True)
-    for i in ax1.spines.itervalues():
+    for i in six.itervalues(ax1.spines):
         i.set_linewidth(0.0)
 
     # width of bars within a group
@@ -409,14 +409,14 @@ def make_bargraph_cb(imgfile, attrs):
 
         val = vals[g].get(key, None)
         hidx = 0 # default hatch
-        if isinstance(val, Bucket):
+        if isinstance(val, Bucket) or type(val).__name__ == 'Bucket':
             for s in val.foreach():
                 x_v, x_s = _fmt_data(s, scale)
                 hidx = hatch_map[s.name]
 
-                assert not valmap[key].has_key(hidx), \
+                assert hidx not in valmap[key], \
                     '%u, %r' % (hidx, val)
-                assert not errmap[key].has_key(hidx), \
+                assert hidx not in errmap[key], \
                     '%u, %r' % (hidx, val)
                 valmap[key][hidx] = x_v
                 errmap[key][hidx] = x_s
@@ -496,7 +496,7 @@ def make_legend_cb(imgfile, attr):
     ax1 = fig.add_subplot(111)
     ax1.set_autoscale_on(True)
     ax1.autoscale_view(True,True,True)
-    for i in ax1.spines.itervalues():
+    for i in six.itervalues(ax1.spines):
         i.set_linewidth(0.0)
 
     ax1.get_xaxis().set_visible(False)
diff --git a/nfsometerlib/options.py b/nfsometerlib/options.py
index 43c41ed..af3cf96 100644
--- a/nfsometerlib/options.py
+++ b/nfsometerlib/options.py
@@ -14,8 +14,9 @@ FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 import os, posix, sys
 import getopt
 import re
+import six
 
-from config import *
+from .config import *
 
 _progname = sys.argv[0]
 
@@ -356,7 +357,7 @@ Example 8: Long running nfsometer trace
         try:
             opts, args = getopt.getopt(sys.argv[1:], shortstr, longlist)
 
-        except getopt.GetoptError, err:
+        except getopt.GetoptError as err:
             self.usage(str(err))
 
         # parse options
@@ -464,7 +465,7 @@ Example 8: Long running nfsometer trace
         for x in mountopts:
             try:
                 vers = mountopts_version(x)
-            except ValueError, e:
+            except ValueError as e:
                 self.usage(str(e))
             self.mountopts.append(x)
 
@@ -490,7 +491,7 @@ Example 8: Long running nfsometer trace
             err = False
             for name in ('NFSOMETER_CMD', 'NFSOMETER_NAME', 'NFSOMETER_DESC',):
                 if not name in posix.environ:
-                    print >>sys.stderr, "%s not set" % name
+                    six.print_("%s not set" % name, file=sys.stderr)
                     err = True
 
             if err:
@@ -564,10 +565,9 @@ Example 8: Long running nfsometer trace
         return lines
 
     def error(self, msg=''):
-        print >>sys.stderr, msg
-        print >>sys.stderr, \
-            '\nrun "%s --help" and "%s examples" for more info' % \
-            (_progname, _progname)
+        six.print_(msg, file=sys.stderr)
+        six.print_('\nrun "%s --help" and "%s examples" for more info' % \
+            (_progname, _progname), file=sys.stderr)
         sys.stderr.flush()
         sys.exit(1)
 
@@ -593,19 +593,19 @@ Example 8: Long running nfsometer trace
         return self._synopsis_fmt % script
 
     def examples(self):
-        print >>sys.stdout, self._examples()
+        print(self._examples())
 
     def usage(self, msg=''):
-        print >>sys.stderr, "usage: %s" % self._synopsis(_progname)
-        print >>sys.stderr, self._modes_description(_progname)
+        six.print_("usage: %s" % self._synopsis(_progname), file=sys.stderr)
+        six.print_(self._modes_description(_progname), file=sys.stderr)
 
-        print >>sys.stderr
-        print >>sys.stderr, "Options:"
-        print >>sys.stderr, '  %s' % '\n  '.join(self._option_help())
+        six.print_("", file=sys.stderr)
+        six.print_("Options:", file=sys.stderr)
+        six.print_('  %s' % '\n  '.join(self._option_help()), file=sys.stderr)
 
         if msg:
-            print >>sys.stderr
-            print >>sys.stderr, "Error: " + msg
+            six.print_('', file=sys.stderr)
+            six.print_("Error: " + msg, file=sys.stderr);
 
         sys.exit(1)
 
@@ -635,5 +635,6 @@ Example 8: Long running nfsometer trace
         for i in range(len(o)):
             o[i] = o[i].strip().replace('-', '\\-')
 
-        file(output_path, 'w+').write('\n'.join(o))
+        with open(output_path, 'w+') as f:
+          f.write('\n'.join(o))
 
diff --git a/nfsometerlib/parse.py b/nfsometerlib/parse.py
index 06eb215..6c2b5ff 100644
--- a/nfsometerlib/parse.py
+++ b/nfsometerlib/parse.py
@@ -13,8 +13,9 @@ FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 import os
 import re
+import six
 
-from config import *
+from .config import *
 
 #
 # Regular Expressions section
@@ -113,7 +114,7 @@ class BucketDef:
         return r
 
     def add_key(self, bucket_name, key, display):
-        if self._key2bucket.has_key(key) or key in self._other_keys:
+        if key in self._key2bucket or key in self._other_keys:
             return
 
         if display:
@@ -189,7 +190,7 @@ nfsstat_op_map_def = {
     ),
 }
 nfsstat_op_map = {}
-for b, ops in nfsstat_op_map_def.iteritems():
+for b, ops in six.iteritems(nfsstat_op_map_def):
     for o in ops:
         nfsstat_op_map[o] = b
 
@@ -245,7 +246,7 @@ mountstat_op_map_def = {
 }
 
 mountstat_op_map = {}
-for b, ops in mountstat_op_map_def.iteritems():
+for b, ops in six.iteritems(mountstat_op_map_def):
     for o in ops:
         mountstat_op_map[o] = b
 
@@ -299,7 +300,7 @@ def parse_tracedir(collection, tracestat, tracedir, attrs):
 
         try:
             p(tracestat, tracedir, attrs)
-        except Exception, e:
+        except Exception as e:
             collection.warn(tracedir, str(e))
 
 
@@ -310,7 +311,7 @@ def parse_time(tracestat, tracedir, attrs):
 
     path = os.path.join(tracedir, filename)
 
-    lines = [ x.strip() for x in file(path) if x.strip() ]
+    lines = [ x.strip() for x in open(path) if x.strip() ]
     assert len(lines) == 3
 
     def _parse_time(minutes, seconds):
@@ -376,8 +377,7 @@ def parse_mountstats(tracestat, tracedir, attrs):
 
     path = os.path.join(tracedir, filename)
 
-    f = file(path)
-
+    f = open(path)
     for line in f:
         found = False
 
@@ -388,7 +388,7 @@ def parse_mountstats(tracestat, tracedir, attrs):
 
         m = RE['ms_read_norm'].match(line)
         if m:
-            val = long(m.group(1))
+            val = int(m.group(1))
             tracestat.add_stat(prefix + 'read_normal',
                         val, 'B',
                         'Bytes read through the read() syscall',
@@ -400,7 +400,7 @@ def parse_mountstats(tracestat, tracedir, attrs):
 
         m = RE['ms_write_norm'].match(line)
         if m:
-            val = long(m.group(1))
+            val = int(m.group(1))
             tracestat.add_stat(prefix + 'write_normal',
                         val, 'B',
                         'Bytes written through write() syscall',
@@ -412,7 +412,7 @@ def parse_mountstats(tracestat, tracedir, attrs):
 
         m = RE['ms_read_odir'].match(line)
         if m:
-            val = long(m.group(1))
+            val = int(m.group(1))
             tracestat.add_stat(prefix + 'read_odirect',
                         val, 'B',
                         'Bytes read through read(O_DIRECT) syscall',
@@ -424,7 +424,7 @@ def parse_mountstats(tracestat, tracedir, attrs):
 
         m = RE['ms_write_odir'].match(line)
         if m:
-            val = long(m.group(1))
+            val = int(m.group(1))
             tracestat.add_stat(prefix + 'write_odirect',
                         val, 'B',
                         'Bytes written through write(O_DIRECT) syscall',
@@ -436,7 +436,7 @@ def parse_mountstats(tracestat, tracedir, attrs):
 
         m = RE['ms_read_nfs'].match(line)
         if m:
-            val = long(m.group(1))
+            val = int(m.group(1))
             tracestat.add_stat(prefix + 'read_nfs',
                         val, 'B',
                         'Bytes read via NFS RPCs',
@@ -448,7 +448,7 @@ def parse_mountstats(tracestat, tracedir, attrs):
 
         m = RE['ms_write_nfs'].match(line)
         if m:
-            val = long(m.group(1))
+            val = int(m.group(1))
             tracestat.add_stat(prefix + 'write_nfs',
                         val, 'B',
                         'Bytes written via NFS RPCs',
@@ -461,21 +461,21 @@ def parse_mountstats(tracestat, tracedir, attrs):
         m = RE['ms_rpc_line'].match(line)
         if m:
             tracestat.add_stat(prefix + 'rpc_requests',
-                        long(m.group(1)), 'RPCs',
+                        int(m.group(1)), 'RPCs',
                         'Count of RPC requests',
                         BETTER_LESS_IF_IO_BOUND,
                         None,
                         filename,
                         tracedir)
             tracestat.add_stat(prefix + 'rpc_replies',
-                        long(m.group(2)), 'RPCs',
+                        int(m.group(2)), 'RPCs',
                         'Count of RPC replies',
                         BETTER_LESS_IF_IO_BOUND,
                         None,
                         filename,
                         tracedir)
             tracestat.add_stat(prefix + 'xid_not_found',
-                        long(m.group(3)), 'RPCs',
+                        int(m.group(3)), 'RPCs',
                         'Count of RPC replies that couldn\'t be matched ' +
                         'with a request',
                         BETTER_ALWAYS_LESS,
@@ -487,7 +487,7 @@ def parse_mountstats(tracestat, tracedir, attrs):
         m = RE['ms_rpc_backlog'].match(line)
         if m:
             tracestat.add_stat(prefix + 'backlog_queue_avg',
-                        long(m.group(1)), 'RPCs',
+                        int(m.group(1)), 'RPCs',
                         'Average number of outgoing requests on the backlog ' +
                         'queue',
                         BETTER_ALWAYS_LESS,
@@ -500,9 +500,10 @@ def parse_mountstats(tracestat, tracedir, attrs):
     op = None
     oplineno = 0
     for line in f:
-        m = RE['ms_ops_header'].match(line.strip())
+        ls = line.strip()
+        m = RE['ms_ops_header'].match(ls)
         if m:
-            assert op == None
+            #assert op is None,"failed op==None, m==%s" % m
             op = m.group(1)
             op_bucket = mountstat_op_map.get(op, BUCKET_OTHER)
             oplineno = 1
@@ -511,7 +512,7 @@ def parse_mountstats(tracestat, tracedir, attrs):
         if oplineno == 1:
             m = RE['ms_ops_line1'].match(line)
             if m:
-                assert op != None
+                assert op is not None,"failed op != None"
                 oplineno += 1
                 continue
 
@@ -563,6 +564,8 @@ def parse_mountstats(tracestat, tracedir, attrs):
         elif op:
             raise ParseError("Didn't match line: %s" % line)
 
+    f.close()
+
 def parse_nfsiostat(tracestat, tracedir, attrs):
     prefix = 'nfsiostat:'
     stat_desc = 'output of nfsiostat(1)'
@@ -570,7 +573,7 @@ def parse_nfsiostat(tracestat, tracedir, attrs):
 
     path = os.path.join(tracedir, filename)
 
-    lines = file(path).readlines()
+    lines = open(path).readlines()
 
     # skip until we find our mount
     name=None
@@ -656,7 +659,7 @@ def parse_nfsstats(tracestat, tracedir, attrs):
 
     path = os.path.join(tracedir, filename)
 
-    lines = file(path).readlines()
+    lines = open(path).readlines()
 
     m = RE['ns_rpc_title'].match(lines[0])
 
@@ -675,7 +678,7 @@ def parse_nfsstats(tracestat, tracedir, attrs):
         raise ParseError("Can't find RPC call count")
 
     tracestat.add_stat(prefix + 'rpc_calls',
-                long(m.group(1)), 'Calls',
+                int(m.group(1)), 'Calls',
                 'Count of RPC calls',
                 BETTER_LESS_IF_IO_BOUND,
                 None,
@@ -709,12 +712,12 @@ def parse_nfsstats(tracestat, tracedir, attrs):
             m = RE['ns_count_data'].match(line)
             if m:
                 for i, t in enumerate(titles):
-                    assert not op_counts.has_key(t), "dup op count %s" % t
-                    op_counts[t] = long(m.group(i+1))
+                    assert t not in op_counts, "dup op count %s" % t
+                    op_counts[t] = int(m.group(i+1))
 
             titles = None
 
-    for op, count in op_counts.iteritems():
+    for op, count in six.iteritems(op_counts):
         if count:
             op_bucket = nfsstat_op_map.get(op, BUCKET_OTHER)
             tracestat.add_stat(prefix + op.upper() + ' Count',
@@ -734,7 +737,8 @@ def parse_filebench(tracestat, tracedir, attrs):
 
     # NOTE: BETTER_* based on fact that filebench output is only ever time bound
     found = False
-    for line in file(path):
+    with open(path) as f:
+      for line in f:
         m = RE['filebench_stats'].match(line)
         if m:
             tracestat.add_stat(prefix + 'op_count',
@@ -784,16 +788,15 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
 
     path = os.path.join(tracedir, filename)
 
-    f = file(path)
-
-    found = False
-    for line in f:
+    with open(path) as f:
+      found = False
+      for line in f:
         m = RE['pms_events'].match(line)
         if m:
             found = True
 
             tracestat.add_stat(prefix + 'inode_revalidate',
-                        long(m.group(1)), 'events',
+                        int(m.group(1)), 'events',
                         'Count of inode_revalidate events',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -801,7 +804,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'dentry_revalidate',
-                        long(m.group(2)), 'events',
+                        int(m.group(2)), 'events',
                         'Count of dentry_revalidate events',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -809,7 +812,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'data_invalidate',
-                        long(m.group(3)), 'events',
+                        int(m.group(3)), 'events',
                         'Count of data_invalidate events',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -817,7 +820,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'attr_invalidate',
-                        long(m.group(4)), 'events',
+                        int(m.group(4)), 'events',
                         'Count of attr_invalidate events',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -825,7 +828,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_open',
-                        long(m.group(5)), 'events',
+                        int(m.group(5)), 'events',
                         'Count of file and directory opens',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -833,7 +836,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_lookup',
-                        long(m.group(6)), 'events',
+                        int(m.group(6)), 'events',
                         'Count of lookups',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -841,7 +844,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_access',
-                        long(m.group(7)), 'events',
+                        int(m.group(7)), 'events',
                         'Count of access calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -849,7 +852,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_updatepage',
-                        long(m.group(8)), 'events',
+                        int(m.group(8)), 'events',
                         'Count of updatepage calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -857,7 +860,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_readpage',
-                        long(m.group(9)), 'events',
+                        int(m.group(9)), 'events',
                         'Count of readpage calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -865,7 +868,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_readpages',
-                        long(m.group(10)), 'events',
+                        int(m.group(10)), 'events',
                         'Count of readpages calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -873,7 +876,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_writepage',
-                        long(m.group(11)), 'events',
+                        int(m.group(11)), 'events',
                         'Count of writepage calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -881,7 +884,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_writepages',
-                        long(m.group(12)), 'events',
+                        int(m.group(12)), 'events',
                         'Count of writepages calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -889,7 +892,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_getdents',
-                        long(m.group(13)), 'events',
+                        int(m.group(13)), 'events',
                         'Count of getdents calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -897,7 +900,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_setattr',
-                        long(m.group(14)), 'events',
+                        int(m.group(14)), 'events',
                         'Count of setattr calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -905,7 +908,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_flush',
-                        long(m.group(15)), 'events',
+                        int(m.group(15)), 'events',
                         'Count of flush calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -913,7 +916,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_fsync',
-                        long(m.group(16)), 'events',
+                        int(m.group(16)), 'events',
                         'Count of fsync calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -921,7 +924,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_lock',
-                        long(m.group(17)), 'events',
+                        int(m.group(17)), 'events',
                         'Count of lock calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -929,7 +932,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'vfs_release',
-                        long(m.group(18)), 'events',
+                        int(m.group(18)), 'events',
                         'Count of release calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -937,7 +940,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'congestion_wait',
-                        long(m.group(19)), 'events',
+                        int(m.group(19)), 'events',
                         'Count of congestion_wait',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -945,7 +948,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'setattr_trunc',
-                        long(m.group(20)), 'events',
+                        int(m.group(20)), 'events',
                         'Count of setattr_trunc',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -953,7 +956,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'extend_write',
-                        long(m.group(21)), 'events',
+                        int(m.group(21)), 'events',
                         'Count of extend_write',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -961,7 +964,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'silly_rename',
-                        long(m.group(22)), 'events',
+                        int(m.group(22)), 'events',
                         'Count of silly_rename',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -969,7 +972,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'short_read',
-                        long(m.group(23)), 'events',
+                        int(m.group(23)), 'events',
                         'Count of short_read',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -977,7 +980,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'short_write',
-                        long(m.group(24)), 'events',
+                        int(m.group(24)), 'events',
                         'Count of short_write',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -985,7 +988,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'delay',
-                        long(m.group(25)), 'events',
+                        int(m.group(25)), 'events',
                         'Count of delays (v3: JUKEBOX, v4: ERR_DELAY, grace period, key expired)',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -993,7 +996,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'pnfs_read',
-                        long(m.group(26)), 'events',
+                        int(m.group(26)), 'events',
                         'Count of pnfs_read calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -1001,7 +1004,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
                         tracedir)
 
             tracestat.add_stat(prefix + 'pnfs_write',
-                        long(m.group(27)), 'events',
+                        int(m.group(27)), 'events',
                         'Count of pnfs_write calls',
                         BETTER_ALWAYS_LESS | BETTER_NO_VARIANCE,
                         None,
@@ -1016,7 +1019,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
             if len(values) > 10:
                 # older mountstats don't have so many values
                 tracestat.add_stat(prefix + 'xprt_max_slots',
-                        long(values[10]), 'slots',
+                        int(values[10]), 'slots',
                         'Max slots used by rpc transport',
                         BETTER_ALWAYS_LESS,
                         None,
@@ -1031,7 +1034,7 @@ def parse_proc_mountstats(tracestat, tracedir, attrs):
             if len(values) > 8:
                 # older mountstats don't have so many values
                 tracestat.add_stat(prefix + 'xprt_max_slots',
-                        long(values[8]), 'slots',
+                        int(values[8]), 'slots',
                         'Max slots used by rpc transport',
                         BETTER_ALWAYS_LESS,
                         None,
@@ -1049,7 +1052,6 @@ def parse_iozone(tracestats, tracedir, attrs):
     filename = 'test.log'
 
     path = os.path.join(tracedir, filename)
-    f = file(path)
 
     rpt_name = None
     rpt_col_hdr = []
@@ -1057,7 +1059,8 @@ def parse_iozone(tracestats, tracedir, attrs):
     # maps name -> (%u_%u) -> value
     newkeys = []
 
-    for line in f:
+    with open(path) as f:
+      for line in f:
         line = line.strip()
         if rpt_name:
             if not line:
@@ -1097,7 +1100,7 @@ def parse_iozone(tracestats, tracedir, attrs):
         y = int(skey[-1])
 
         tracestat.add_stat(prefix + key + ' iozone',
-            long(value), 'KB/s',
+            int(value), 'KB/s',
             '%s: size kb: %u, reclen: %u' % (report, x, y),
             BETTER_ALWAYS_MORE,
             (iozone_bucket_def, report + ' iozone'),
diff --git a/nfsometerlib/report.py b/nfsometerlib/report.py
index 0d7fb8e..9da86af 100644
--- a/nfsometerlib/report.py
+++ b/nfsometerlib/report.py
@@ -15,11 +15,11 @@ import os
 from math import sqrt, pow
 import time
 
-import graph
-from collection import *
-from selector import Selector, SELECTOR_ORDER
-from config import *
-from workloads import *
+from . import graph
+from .collection import *
+from .selector import Selector, SELECTOR_ORDER
+from .config import *
+from .workloads import *
 
 ENABLE_PIE_GRAPHS=False
 
@@ -238,6 +238,8 @@ class Table:
             cell = val
         elif isinstance(val, (Stat, Bucket)):
             cell = html_fmt_value(val.mean(), val.std(), units=self.units)
+        elif type(val).__name__ == "Bucket" or type(val).__name__ == 'Stat':
+            cell = html_fmt_value(val.mean(), val.std(), units=self.units)
         else:
             assert val == None, "Not a string, Stat or Bucket: %r\ng = %s, k = %s" % (val, g, k)
 
@@ -279,7 +281,7 @@ class WideTable:
         cur = 0
 
         for vers in NFS_VERSIONS:
-            if not gmap.has_key(vers):
+            if vers not in gmap:
                 continue
 
             assert cur < num
@@ -392,7 +394,7 @@ class Dataset:
             value_map[g] = {}
             v = vals.get(g, {}).get(key, None)
             if v != None:
-                if isinstance(v, Bucket):
+                if isinstance(v, Bucket) or type(v).__name__ == 'Bucket':
                     self.all_buckets = True
                     for stat in v.foreach():
                         value_map[g][stat.name] = stat.mean()
@@ -405,8 +407,9 @@ class Dataset:
         self.bucket_pie = ''
 
         # does ordering matter here?
-        bk_order = [ (k,v) for k, v in self.hatch_map.iteritems() ]
-        bk_order.sort(lambda x,y: cmp(x[1], y[1]))
+        bk_order = [ (k,v) for k, v in six.iteritems(self.hatch_map) ]
+        if bk_order:
+            bk_order.sort(key=lambda x: x[1])
 
         table_values = {}
         bucket_names = []
@@ -483,7 +486,7 @@ class Dataset:
             self.make_comparison_vals(vals, key, groups, select_order)
 
         self.gmap = groups_by_nfsvers(groups)
-        self.nfs_versions = [ v for v in NFS_VERSIONS if self.gmap.has_key(v) ]
+        self.nfs_versions = [ v for v in NFS_VERSIONS if v in self.gmap ]
 
         # ensure the order of groups is in nfs_version order
         groups = []
@@ -549,7 +552,7 @@ class Dataset:
                  ' style="display: none;">%s</div>' % (hits,)
 
 
-        for compare, compvals in self.comparison_vals_map.iteritems():
+        for compare, compvals in six.iteritems(self.comparison_vals_map):
             if compvals:
                 c += '<div class="compare_%s" ' \
                      'style="display: none;">' \
@@ -563,7 +566,7 @@ class Dataset:
             table_rows = []
             color_idx = COLORS.index(self.color_map[g])
 
-            if isinstance(stat, Bucket):
+            if isinstance(stat, Bucket) or type(stat).__name__ == 'Bucket':
                 table_hdrs.append('run')
                 for x in stat.foreach():
                     hidx = self.hatch_map[x.name]
@@ -585,7 +588,7 @@ class Dataset:
                 row = []
                 row.append('<a href="%s">%s</a>' % (tracedir, run))
 
-                if isinstance(stat, Bucket):
+                if isinstance(stat, Bucket) or type(stat).__name__ == 'Bucket':
                     for x in stat.foreach():
                         row.append('<a href="%s/%s">%s</a>' %
                             (tracedir, stat.filename(),
@@ -619,26 +622,26 @@ class Dataset:
             if stat == None:
                 continue
 
-            if isinstance(stat, Bucket):
+            if isinstance(stat, Bucket) or type(stat).__name__ == 'Bucket':
                 for sub in stat.foreach():
-                    if not key2val.has_key(sub.name):
+                    if sub.name not in key2val:
                         key2val[sub.name] = 0.0
                     key2val[sub.name] += sub.mean()
                     total_val += sub.mean()
             else:
                 # a basic Stat - makes hatch map with one entry
-                if not key2val.has_key(stat.name):
+                if stat.name not in key2val:
                     key2val[stat.name] = 0.0
                 key2val[stat.name] += stat.mean()
                 total_val += stat.mean()
 
-        ordered = [ (k, v) for k, v in key2val.iteritems() ]
-        ordered.sort(lambda x,y: cmp(x[1], y[1]))
-        ordered.reverse()
+        ordered = [ (k, v) for k, v in six.iteritems(key2val) ]
+        if ordered:
+             ordered.sort(key=lambda x: x[1], reverse=True)
 
         k2h = {}
         for i, kv in enumerate(ordered):
-            assert not k2h.has_key(kv[0])
+            assert kv[0] not in k2h
             k2h[kv[0]] = i
 
         return k2h, key2val, total_val
@@ -656,7 +659,7 @@ class Dataset:
         for g in groups:
             idx = None
             for i, cg in enumerate(compare_groups):
-                if g.compare_order(cg[0], select_order) == 0:
+                if g.match_order(cg[0], select_order):
                     # found a group!
                     idx = i
                     break
@@ -671,7 +674,7 @@ class Dataset:
             ref_val = None
             ref_g = None
             for g in cg:
-                if not newvals.has_key(g):
+                if g not in newvals:
                     newvals[g] = {}
 
                 # handle no data
@@ -727,9 +730,9 @@ class Dataset:
 
     def fmt_cell_hits(self, value):
         classes = ('hatch_hit',)
-        if isinstance(value, Bucket):
+        if isinstance(value, Bucket) or type(value).__name__ == 'Bucket':
             stat_list = [ x for x in value.foreach() ]
-            stat_list.sort(lambda x,y: -1 * cmp(x.mean(), y.mean()))
+            stat_list.sort(key=lambda x: x.mean(), reverse=True)
 
             units = self.report.collection.stat_units(value.name)
 
@@ -1045,8 +1048,9 @@ class BucketWidget(Widget):
                              bucket_def=self.bucket_def,
                              units=units)
 
-        bucket_info = [ (k, v) for k, v in bucket_totals.iteritems() ]
-        bucket_info.sort(lambda x, y: cmp(x[1], y[1]) * -1)
+        bucket_info = [ (k, v) for k, v in six.iteritems(bucket_totals) ]
+        if bucket_info:
+            bucket_info.sort(key=lambda x: x[1], reverse=True)
 
         bucket_info = [ x for x in bucket_info if x[1] ]
 
@@ -1166,12 +1170,18 @@ class Info:
 
         for wsel in topsel.foreach('workload'):
             workload_name = wsel.fmt('workload')
+            workload_command = ''
+            workload_description = ''
 
             # XXX 0?
-            workload_command = \
-                self.collection.get_attr(wsel, 'workload_command')[0]
-            workload_description = \
-                self.collection.get_attr(wsel, 'workload_description')[0]
+            col = self.collection
+            atr = col.get_attr(wsel, 'workload_command')
+            if atr:
+              workload_command = atr[0]
+
+            atr = col.get_attr(wsel, 'workload_description')
+            if atr:
+              workload_description = atr[0]
 
             wdesc = '<span class="workload_name">%s</span>' \
                     '<span class="workload_description">%s</span>' % \
@@ -1228,7 +1238,7 @@ class Info:
                     if not mdt in seen_mdts:
                         seen_mdts.append(mdt)
 
-                    if not mount_options.has_key(mdt):
+                    if mdt not in mount_options:
                         mount_options[mdt] = set()
                     mount_options[mdt] = \
                         mount_options[mdt].union(real_info['mount_options'])
@@ -1236,7 +1246,7 @@ class Info:
                     # lowlite (opposite of hilite) values same as prev row.
                     info = {}
                     ignore = ('runs',)
-                    for k in real_info.keys():
+                    for k in list(real_info.keys()):
                         if not k in ignore and last_info and \
                            real_info[k] == last_info[k]:
                             info[k] = '<span class="lowlite">%s</span>' % \
@@ -1425,14 +1435,14 @@ class ReportSet:
 
     def _write_report(self, r):
         abs_path = os.path.join(self.reportdir, r.path)
-        file(abs_path, 'w+').write(r.html())
-        print " %s" % r.path
+        with open(abs_path, 'w+') as f:
+          f.write(r.html())
 
     def _write_index(self):
         path = 'index.html'
         abs_path = os.path.join(self.reportdir, path)
-        file(abs_path, 'w+').write(self.html_index())
-        print " %s" % path
+        with open(abs_path, 'w+') as f:
+          f.write(self.html_index())
 
     def _step_through_reports(self, cb_f):
         for x in self.collection.selection.foreach('workload'):
diff --git a/nfsometerlib/selector.py b/nfsometerlib/selector.py
index c20361e..37eb54a 100644
--- a/nfsometerlib/selector.py
+++ b/nfsometerlib/selector.py
@@ -11,7 +11,7 @@ ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 """
 
-from config import *
+from .config import *
 
 SELECTOR_ORDER=(
     'workload',
@@ -70,19 +70,29 @@ class Selector(object):
 
         return hash(tuple(args))
 
-    def __cmp__(self, other):
+    def __eq__(self, other):
         for name in SELECTOR_ORDER:
-            r = cmp(getattr(self, name + 's'), getattr(other, name + 's'))
-            if r:
-                return r
-        return 0
+            if getattr(self, name + 's') != getattr(other, name + 's'):
+                return False
+        return True
+
+    def __lt__(self, other):
+        return NotImplemented
+
+    def __le__(self, other):
+        return NotImplemented
 
-    def compare_order(self, other, order):
+    def __gt__(self, other):
+        return NotImplemented
+
+    def __ge__(self, other):
+        return NotImplemented
+
+    def match_order(self, other, order):
         for name in order:
-            r = cmp(getattr(self, name + 's'), getattr(other, name + 's'))
-            if r != 0:
-                return r
-        return 0
+            if getattr(self, name + 's') != getattr(other, name + 's'):
+                return False
+        return True
 
     def __repr__(self):
         args = []
@@ -102,7 +112,7 @@ class Selector(object):
         elif hasattr(superself, attr):
             return getattr(superself, attr)
         else:
-            raise AttributeError, "invalid attribute: %r" % attr
+            raise AttributeError("invalid attribute: %r" % attr)
 
     def __add__(self, other):
         new = Selector()
diff --git a/nfsometerlib/trace.py b/nfsometerlib/trace.py
index 0b25540..6dedd6f 100644
--- a/nfsometerlib/trace.py
+++ b/nfsometerlib/trace.py
@@ -22,10 +22,10 @@ import random
 import atexit
 import pwd
 
-from cmd import *
-from config import *
-from workloads import *
-import selector
+from .cmd import *
+from .config import *
+from .workloads import *
+from . import selector
 
 _server_path_v4 = re.compile('([^:]+):(\S+)')
 _server_path_v6 = re.compile('(\[\S+\]):(\S+)')
@@ -70,8 +70,8 @@ class TraceAttrs:
 
         if not temp and not new:
             try:
-                f = file(self.__attrfile)
-            except IOError, e:
+                f = open(self.__attrfile)
+            except IOError as e:
                 raise IOError('Attr file not found')
             for line in f:
                 if line.strip():
@@ -79,13 +79,13 @@ class TraceAttrs:
                     self.__attrs[name.strip()] = \
                         val.strip().replace('\\n', '\n')
 
-        if not self.__attrs.has_key('tracedir'):
+        if 'tracedir' not in self.__attrs:
             self.__attrs['tracedir'] = RUNNING_TRACE_DIR
 
-        if not self.__attrs.has_key('stoptime'):
+        if 'stoptime' not in self.__attrs:
             self.__attrs['stoptime'] = 'ongoing'
 
-        if not self.__attrs.has_key('tracedir_version'):
+        if 'tracedir_version' not in self.__attrs:
             if new or temp:
                 self.__attrs['tracedir_version'] = TRACE_DIR_VERSION
             else:
@@ -101,7 +101,7 @@ class TraceAttrs:
             if tracedir_vers == 1:
                 # move tags from separate attrs to one 'tags' attr
                 v1_tags = [ 'delegations_enabled', 'pnfs_enabled', 'remote' ]
-                tag_names = [ x for x in self.__attrs.keys() if x in v1_tags ]
+                tag_names = [ x for x in list(self.__attrs.keys()) if x in v1_tags ]
 
                 for name in tag_names:
                     assert int(self.__attrs[name]) == 1
@@ -202,12 +202,12 @@ class TraceAttrs:
         self.__attrs['tracedir_version'] = TRACE_DIR_VERSION
 
     def _sorted_names(self):
-        names = self.__attrs.keys()
+        names = list(self.__attrs.keys())
         names.sort()
         return names
 
     def get(self, name, *args):
-        if self.__attrs.has_key(name):
+        if name in self.__attrs:
             return self.__attrs[name]
 
         # handle optional default value
@@ -233,14 +233,14 @@ class TraceAttrs:
     def write(self):
         if self.__temp:
             return
-        f = file(self.__attrfile, 'w+')
-        for k, v in self.__attrs.iteritems():
+        with open(self.__attrfile, 'w+') as f:
+          for k, v in six.iteritems(self.__attrs):
             f.write('%s = %s\n' % (k, str(v).replace('\n', '\\n')))
 
 def _dir_create():
     try:
         os.mkdir(RUNNING_TRACE_DIR)
-    except OSError, e:
+    except OSError as e:
         if e.errno == errno.EEXIST:
             raise IOError('An NFS trace is already running')
         raise
@@ -292,7 +292,7 @@ def _try_mount(attrs, quiet=False):
         for old_syntax in (False, True):
             try:
                 _mount(attrs, old_syntax=old_syntax)
-            except Exception, e:
+            except Exception as e:
                 if not quiet:
                     sys.stdout.write('.')
                     sys.stdout.flush()
@@ -310,7 +310,7 @@ def _try_mount(attrs, quiet=False):
         sys.stdout.flush()
 
     if err:
-        raise e
+        raise err
 
 def _is_mounted(attrs):
     try:
@@ -358,7 +358,7 @@ def _try_unmount(attrs, quiet=False, cleanup=False):
     for i in range(tries):
         try:
             _unmount(attrs)
-        except Exception, e:
+        except Exception as e:
             if not quiet:
                 sys.stdout.write('.')
                 sys.stdout.flush()
@@ -441,12 +441,12 @@ def _collect_stats(commands):
     for c in commands:
         stats.append(c['file'])
         out = cmd(c['cmd'])
-        f = file(os.path.join(RUNNING_TRACE_DIR, c['file']), 'w+')
-        f.write('\n'.join(out[0]))
+        with open(os.path.join(RUNNING_TRACE_DIR, c['file']), 'w+') as f:
+          f.write('\n'.join(out[0]))
 
 def probe_detect(probe_trace_dir, mountopt):
     lines = [ x.strip()
-             for x in file(os.path.join(probe_trace_dir,
+             for x in open(os.path.join(probe_trace_dir,
                            'proc_mountstats.stop')) ]
 
     # find this mountpoint
@@ -519,7 +519,7 @@ def probe_detect(probe_trace_dir, mountopt):
     return detect
 
 def _is_auth_gss():
-    lines = [ x.strip() for x in file('/proc/self/mountstats') ]
+    lines = [ x.strip() for x in open('/proc/self/mountstats') ]
     mounted_on = ' mounted on %s with ' % MOUNTDIR
     start = -1
     end = -1
@@ -554,7 +554,7 @@ def _has_creds():
 
 def _has_tkt(server):
     princ = re.compile('nfs/' + server + '\S+$')
-    lines = [ x.strip() for x in file(os.path.join(RUNNING_TRACE_DIR,
+    lines = [ x.strip() for x in open(os.path.join(RUNNING_TRACE_DIR,
                                                    'klist_user.start')) ]
     for i, line in enumerate(lines):
         if re.search(princ, line):
@@ -625,7 +625,7 @@ def start(mountopts, serverpath, workload, detects, tags, is_setup=False,
     attrs.set('server', server)
     attrs.set('path', path)
     attrs.set('localpath', MOUNTDIR)
-    attrs.set('starttime', long(time.time()))
+    attrs.set('starttime', int(time.time()))
     attrs.set('workload', workload)
     attrs.set('workload_command', workload_command(workload, pretty=True))
     attrs.set('workload_description', workload_description(workload))
@@ -655,8 +655,8 @@ def stop(resdir=None):
     attrs.set('stoptime', time.time())
     attrs.write()
 
-    is_setup = long(attrs.get('is_setup', 0))
-    is_probe = long(attrs.get('is_probe', 0))
+    is_setup = int(attrs.get('is_setup', 0))
+    is_probe = int(attrs.get('is_probe', 0))
 
     if not is_setup:
         _save_stop_stats(attrs)
@@ -669,11 +669,11 @@ def stop(resdir=None):
     if resdir != None:
         cmd('mv %s %s' % (RUNNING_TRACE_DIR, resdir))
         if not is_probe:
-            print 'Results copied to: %s' % (os.path.split(resdir)[-1],)
+            print('Results copied to: %s' % (os.path.split(resdir)[-1],))
     else:
         cmd('rm -rf %s' % (RUNNING_TRACE_DIR))
         if not is_setup:
-            print 'Results thrown away'
+            print('Results thrown away')
 
 def find_mounted_serverpath(mountdir):
     try:
@@ -723,16 +723,16 @@ def get_trace_list(collection, resultdir, workloads_requested,
                 workloads[name] = obj
                 new.append(name)
             except KeyError:
-                print
+                print('')
                 warn('Invalid workload: "%s"' % w)
-                print
-                print "Available workloads:"
-                print "  %s" % '\n  '.join(available_workloads())
+                print('')
+                print("Available workloads:")
+                print("  %s" % '\n  '.join(available_workloads()))
                 sys.exit(2)
         workloads_requested = new
 
     else:
-        for w, workload_obj in WORKLOADS.iteritems():
+        for w, workload_obj in six.iteritems(WORKLOADS):
             if not workload_obj.check():
                 name = workload_obj.name()
                 workloads[name] = workload_obj
@@ -745,7 +745,7 @@ def get_trace_list(collection, resultdir, workloads_requested,
     current_kernel = get_current_kernel()
     client = get_current_hostname()
 
-    for w, workload_obj in workloads.iteritems():
+    for w, workload_obj in six.iteritems(workloads):
         for mountopt, detects, tags in mountopts_detects_tags:
             sel = selector.Selector(w, current_kernel, mountopt,
                                     detects, tags,
@@ -820,7 +820,7 @@ def probe_mounts(opts):
 
         try:
             cmd('mkdir -p "%s"' % RUNROOT)
-        except CmdErrorCode, e:
+        except CmdErrorCode as e:
             msg = str.format('"mkdir -p {:s}" failed.', RUNROOT)
             # try to hint why it failed
             if e.code == errno.EPERM:
@@ -831,9 +831,8 @@ def probe_mounts(opts):
             # and bail out right now
             sys.exit(1)
 
-        f = file(fpath, 'w+')
-        f.write('nfsometer probe to determine server features: %s' % m)
-        f.close()
+        with open(fpath, 'w+') as f:
+            f.write('nfsometer probe to determine server features: %s' % m)
 
         # force delegation if supported
         fd1 = os.open(fpath, os.O_RDWR)
@@ -869,14 +868,14 @@ def run_traces(collection, opts, fetch_only=False):
                        mountopts_detects_tags, opts.num_runs, opts.server,
                        opts.path)
 
-    for w, workload_obj in workloads.iteritems():
+    for w, workload_obj in six.iteritems(workloads):
         workload_obj.fetch()
 
     if fetch_only:
         return
 
     # check each workload to make sure we'll be able to run it
-    for w, workload_obj in workloads.iteritems():
+    for w, workload_obj in six.iteritems(workloads):
         check_mesg = workload_obj.check()
 
         if check_mesg:
@@ -884,12 +883,12 @@ def run_traces(collection, opts, fetch_only=False):
 
     this_trace = 0
 
-    print
-    print "Requested: %u workloads X %u options X %u runs = %u traces" % \
-        (len(workloads), len(mountopts_detects_tags), int(opts.num_runs), requested)
+    print('')
+    print("Requested: %u workloads X %u options X %u runs = %u traces" % \
+        (len(workloads), len(mountopts_detects_tags), int(opts.num_runs), requested))
     if skipped:
-        print "Results directory already has %u matching traces" % (skipped,)
-    print "Need to run %u of %u requested traces" % (total, requested)
+        print("Results directory already has %u matching traces" % (skipped,))
+    print("Need to run %u of %u requested traces" % (total, requested))
 
     for workload_obj, mountopt, detects, tags, nruns in trace_list:
         mdt = mountopt
@@ -897,8 +896,8 @@ def run_traces(collection, opts, fetch_only=False):
             mdt += ' ' + detects
         if tags:
             mdt += ' ' + tags
-        print " %s - needs %u runs of %s" % (workload_obj.name(), nruns, mdt)
-    print
+        print(" %s - needs %u runs of %s" % (workload_obj.name(), nruns, mdt))
+    print('')
 
     dir_remove_old_asides()
 
@@ -916,7 +915,7 @@ def run_traces(collection, opts, fetch_only=False):
         for run in range(nruns):
             this_trace += 1
 
-            print
+            print('')
             mdt = mountopt
             if detects:
                 mdt += ' ' + detects
@@ -925,7 +924,7 @@ def run_traces(collection, opts, fetch_only=False):
 
             inform("Trace %u/%u: %u of %u for %s: %s" %
                    (this_trace, total, run+1, nruns, workload_obj.name(), mdt))
-            print
+            print('')
 
             sys.stdout.write("< SETUP WORKLOAD >\n")
             sys.stdout.flush()
@@ -936,7 +935,7 @@ def run_traces(collection, opts, fetch_only=False):
 
             stop()
 
-            print
+            print('')
 
             sys.stdout.write("< RUN WORKLOAD >\n")
             sys.stdout.flush()
@@ -983,7 +982,7 @@ def _loadgen_pool_f(workload, num):
             inform("loadgen %u: %s stop" % (num, workload))
             stop = True
 
-        except Exception, e:
+        except Exception as e:
             warn("loadgen %u: %s error:\n%s" % (num, workload, e))
             time.sleep(1.0)
 
@@ -1029,7 +1028,7 @@ def loadgen(opts):
         workpool.terminate()
         workpool.join()
 
-    except Exception, e:
+    except Exception as e:
         workpool.terminate()
         workpool.join()
         raise e
diff --git a/nfsometerlib/workloads.py b/nfsometerlib/workloads.py
index 392ac4a..f1dbde9 100644
--- a/nfsometerlib/workloads.py
+++ b/nfsometerlib/workloads.py
@@ -14,15 +14,15 @@ import os
 import errno
 import re
 
-from cmd import *
-from config import *
+from .cmd import *
+from .config import *
 
 _re_which = re.compile('[\s\S]*which: no (\S+) in \([\s\S]*')
 
 def _mkdir_quiet(path):
     try:
         os.mkdir(path)
-    except OSError, e:
+    except OSError as e:
         if e.errno != errno.EEXIST:
             raise e
 
@@ -94,15 +94,15 @@ class Workload:
 
             if not os.path.exists(url_out):
                 if url.startswith('git://'):
-                    print "Fetching git: %s" % url
+                    print("Fetching git: %s" % url)
                     fetch_cmd = 'git clone "%s" "%s"' % (url, url_out)
                 else:
-                    print "Fetching url: %s" % url
+                    print("Fetching url: %s" % url)
                     fetch_cmd = 'wget -O "%s" "%s"' % (url_out, url)
 
                 try:
                     cmd(fetch_cmd, pass_output=True, raiseerrorout=True)
-                except Exception, e:
+                except Exception as e:
                     cmd('rm -rf "%s"' % url_out)
                 finally:
                     if not os.path.exists(url_out):
@@ -115,7 +115,7 @@ class Workload:
             assert not url and not url_out
 
     def check(self):
-        if not self._cache.has_key('check'):
+        if not 'check' in self._cache:
             res = cmd('%s check %s' % (self.script, self.defname))
             res = ', '.join([ x.strip() for x in res[0]]).strip()
             self._cache['check'] = res
@@ -123,7 +123,7 @@ class Workload:
         return self._cache['check']
 
     def command(self):
-        if not self._cache.has_key('command'):
+        if not 'command' in self._cache:
             res = cmd('%s command %s' % (self.script, self.defname))
             res = '\n'.join(res[0]).strip()
             assert not '\n' in res
@@ -132,7 +132,7 @@ class Workload:
         return self._cache['command']
 
     def description(self):
-        if not self._cache.has_key('description'):
+        if not 'description' in self._cache:
             res = cmd('%s description %s' % (self.script, self.defname))
             res = '\n'.join(res[0]).strip()
             assert not '\n' in res
@@ -141,7 +141,7 @@ class Workload:
         return self._cache['description']
 
     def name(self):
-        if not self._cache.has_key('name'):
+        if not 'name' in self._cache:
             res = cmd('%s name %s' % (self.script, self.defname))
             res = '\n'.join(res[0]).strip()
             assert not '\n' in res
@@ -150,7 +150,7 @@ class Workload:
         return self._cache['name']
 
     def url(self):
-        if not self._cache.has_key('url'):
+        if not 'url' in self._cache:
             res = cmd('%s url %s' % (self.script, self.defname))
             res = '\n'.join(res[0]).strip()
             assert not '\n' in res
@@ -159,7 +159,7 @@ class Workload:
         return self._cache['url']
 
     def url_out(self):
-        if not self._cache.has_key('url_out'):
+        if not 'url_out' in self._cache:
             res = cmd('%s url_out %s' % (self.script, self.defname))
             res = '\n'.join(res[0]).strip()
             assert not '\n' in res
@@ -174,14 +174,15 @@ class Workload:
 
         command = self.command()
 
-        print "Running command: %s" % command
+        print("Running command: %s" % command)
         sys.stdout.flush()
 
         oldcwd = os.getcwd()
         os.chdir(self.rundir)
 
         # write command to file
-        file(cmdfile, 'w+').write(command)
+        with open(cmdfile, 'w+') as f:
+          f.write(command)
 
         sh_cmd = "sh %s > %s 2>&1" % (cmdfile, logfile)
         wrapped_cmd = '( time ( %s ) ) 2> %s' % (sh_cmd, timefile)
@@ -193,7 +194,7 @@ class Workload:
             # re-raise
             raise KeyboardInterrupt
 
-        except Exception, e:
+        except Exception as e:
             os.chdir(oldcwd)
             # re-raise
             raise e
@@ -207,14 +208,15 @@ class Workload:
         cmdfile = os.path.join(self.rundir, 'command.sh')
         command = self.command()
 
-        print "Running command without trace: %s" % command
+        print("Running command without trace: %s" % command)
         sys.stdout.flush()
 
         oldcwd = os.getcwd()
         os.chdir(self.rundir)
 
         # write command to file
-        file(cmdfile, 'w+').write(command)
+        with open(cmdfile, 'w+') as f:
+          f.write(command)
 
         sh_cmd = "sh %s > %s 2>&1" % (cmdfile, logfile)
 
@@ -226,7 +228,7 @@ class Workload:
             # re-raise
             raise KeyboardInterrupt
 
-        except Exception, e:
+        except Exception as e:
             os.chdir(oldcwd)
             # re-raise
             raise e
@@ -245,7 +247,7 @@ for w in workloads:
     WORKLOADS[w] = Workload(w)
 
 def workload_command(workload, pretty=False):
-    if workload == posix.environ.get('NFSOMETER_NAME', None):
+    if workload == os.getenv('NFSOMETER_NAME', None):
         workload = 'custom'
     try:
         obj = WORKLOADS[workload]
@@ -262,7 +264,7 @@ def workload_command(workload, pretty=False):
     return cmdstr
 
 def workload_description(workload):
-    if workload == posix.environ.get('NFSOMETER_NAME', None):
+    if workload == os.getenv('NFSOMETER_NAME', None):
         workload = 'custom'
     try:
         obj = WORKLOADS[workload]
@@ -273,8 +275,7 @@ def workload_description(workload):
 
 def available_workloads():
     o = []
-    defnames = WORKLOADS.keys()
-    defnames.sort()
+    defnames = sorted( WORKLOADS.keys() )
     for defname in defnames:
         check_mesg = WORKLOADS[defname].check()
 
@@ -287,7 +288,7 @@ def unavailable_workloads():
     """ return a string containing a comma separated list of the available 
         workload """
     o = []
-    defnames = WORKLOADS.keys()
+    defnames = list(WORKLOADS.keys())
     defnames.sort()
     for defname in defnames:
         check_mesg = WORKLOADS[defname].check()
diff --git a/setup.py b/setup.py
index 51e7d34..a0cca64 100644
--- a/setup.py
+++ b/setup.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 """
 Copyright 2012 NetApp, Inc. All Rights Reserved,
 contribution by Weston Andros Adamson <dros@netapp.com>
@@ -21,7 +21,7 @@ import nfsometerlib.options
 class sdist(_sdist):
     def run(self):
         if not self.dry_run:
-            print "generating manpage %s" % NFSOMETER_MANPAGE
+            print("generating manpage %s" % NFSOMETER_MANPAGE)
             o = nfsometerlib.options.Options()
             o.generate_manpage(NFSOMETER_MANPAGE)
 
@@ -37,7 +37,7 @@ class install(_install):
             manpath = self.root + manpath
             gzpath = self.root + gzpath
 
-        print "gzipping manpage %s" % (gzpath,)
+        print("gzipping manpage %s" % (gzpath,))
         os.system('mkdir -p %s' % manpath)
         os.system('gzip -f --stdout "%s" > "%s"' % (manpage, gzpath))
 
@@ -52,7 +52,7 @@ class install(_install):
             old = self.root + old
             new = self.root + new
 
-        print "stripping .py from script %s" % (old,)
+        print("stripping .py from script %s" % (old,))
         os.rename(old, new)
 
     def run(self):
-- 
2.37.3

