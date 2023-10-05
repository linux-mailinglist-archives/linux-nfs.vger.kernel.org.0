Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910B57BA066
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbjJEOi2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 10:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjJEOgJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 10:36:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F357144873
        for <linux-nfs@vger.kernel.org>; Thu,  5 Oct 2023 07:00:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB4CC43215;
        Thu,  5 Oct 2023 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696514360;
        bh=5SmXWapcJyPZQUeif7XTx8G5LatpZwA1DoGJ9KZSHH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j1EsiQvZxi2OzCy8jzXh6IS84qtfOMBw8ea/qT3HyImvMlI0vOqtnTEOEgkV1P2Ms
         R7P6JWNUOcdaI4Qesf6+uZDVvs+InTeBeX/wpk87kXHfchAnovr1SuqU8Mox36MkFd
         Kv5Dk3n0rJWhKgkZR19XGzBEsZzHZpbYfRlg8zWRHxcUc7hnx3a5RvW9ivEydQgi6Z
         nCX6GVX4qGa3br/NzpchHu0lvpujd6ArQEPIRd6qRCwjgXXvN3BG9ShxWnnElIR73a
         o4qyfknOt5jVovGnPZubtlee+WMfnfcB0MqW6kVk5YMJVOhNzRrnNLf4QsgYDQEHxL
         cc96rJPwY9IEg==
Date:   Thu, 5 Oct 2023 06:59:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        neilb@suse.de, chuck.lever@oracle.com, netdev@vger.kernel.org
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Message-ID: <20231005065919.6001b7ca@kernel.org>
In-Reply-To: <ZR55TnN4Sr/O5z4a@lore-desk>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
        <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
        <ZQ2+1NhagxR5bZF+@lore-desk>
        <20231004100428.3ca993aa@kernel.org>
        <ZR55TnN4Sr/O5z4a@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 5 Oct 2023 10:52:30 +0200 Lorenzo Bianconi wrote:
> running ynl-regen.sh, I got the following error for the get method:
> 
> $ ./tools/net/ynl/ynl-regen.sh
>         GEN kernel      fs/nfsd/netlink.h
> Traceback (most recent call last):
>   File "/home/lorenzo/workspace/nfsd-next/tools/net/ynl/ynl-gen-c.py", line 2609, in <module>
>     main()
>   File "/home/lorenzo/workspace/nfsd-next/tools/net/ynl/ynl-gen-c.py", line 2445, in main
>     print_req_policy_fwd(cw, ri.struct['request'], ri=ri)
>                              ~~~~~~~~~^^^^^^^^^^^
> KeyError: 'request'
> 
> am I missing something?

Not at all, the codegen was only handling dumps with no ops.
This change seems to make it a little happier, at least it
doesn't throw any exceptions. Will it work for your case?

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 168fe612b029..593be2632f23 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -645,6 +645,33 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self.inherited = [c_lower(x) for x in sorted(self._inherited)]
 
 
+class StructNone:
+    def __init__(self, family, space_name):
+        self.family = family
+        self.space_name = space_name
+        self.attr_set = family.attr_sets[space_name]
+
+        if family.name == c_lower(space_name):
+            self.render_name = f"{family.name}"
+        else:
+            self.render_name = f"{family.name}_{c_lower(space_name)}"
+
+        self.request = False
+        self.reply = False
+
+        self.attr_list = []
+        self.attrs = dict()
+
+    def __iter__(self):
+        yield from self.attrs
+
+    def __getitem__(self, key):
+        return self.attrs[key]
+
+    def member_list(self):
+        return self.attr_list
+
+
 class EnumEntry(SpecEnumEntry):
     def __init__(self, enum_set, yaml, prev, value_start):
         super().__init__(enum_set, yaml, prev, value_start)
@@ -1041,9 +1068,12 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if op_mode == 'notify':
             op_mode = 'do'
         for op_dir in ['request', 'reply']:
-            if op and op_dir in op[op_mode]:
-                self.struct[op_dir] = Struct(family, self.attr_set,
-                                             type_list=op[op_mode][op_dir]['attributes'])
+            if op:
+                if op_dir in op[op_mode]:
+                    self.struct[op_dir] = Struct(family, self.attr_set,
+                                                 type_list=op[op_mode][op_dir]['attributes'])
+                else:
+                    self.struct[op_dir] = StructNone(family, self.attr_set)
         if op_mode == 'event':
             self.struct['reply'] = Struct(family, self.attr_set, type_list=op['event']['attributes'])
 
@@ -1752,6 +1782,8 @@ _C_KW = {
 
 
 def print_req_type_helpers(ri):
+    if isinstance(ri.struct["request"], StructNone):
+        return
     print_alloc_wrapper(ri, "request")
     print_type_helpers(ri, "request")
 
@@ -1773,6 +1805,8 @@ _C_KW = {
 
 
 def print_req_type(ri):
+    if isinstance(ri.struct["request"], StructNone):
+        return
     print_type(ri, "request")
 
 
@@ -2515,9 +2549,8 @@ _C_KW = {
                 if 'dump' in op:
                     cw.p(f"/* {op.enum_name} - dump */")
                     ri = RenderInfo(cw, parsed, args.mode, op, 'dump')
-                    if 'request' in op['dump']:
-                        print_req_type(ri)
-                        print_req_type_helpers(ri)
+                    print_req_type(ri)
+                    print_req_type_helpers(ri)
                     if not ri.type_consistent:
                         print_rsp_type(ri)
                     print_wrapped_type(ri)
-- 
2.41.0

