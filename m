Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E39849BBCB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiAYTJx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiAYTJv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:51 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A89DC06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:51 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id d8so5626231qvv.2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+G+khJ+4q/8j018SJn5jdvwb/eI6plL2kwVmOnCRX4=;
        b=VvWC9GDzU2JsvkS21z3hME9LXeEzMRfMCim0VImkg4p6nu+QtO3wccguGqkJusihCi
         O4BNLki6o7ycjuKt3MmBP66GwwzGzv7XT7UEePjFkpGKZjakHbHx4Sy9nnPYL2VxpqBO
         ikWGLbpiL7dxbeOrzglKH25aNlgxGY70uNRXuOi3hQK5uktOJxE36rTMwHN8uEQ7pihr
         btHIf3PrCndG8U0hkL9RUcCNP68cNQJV4NrSt2yw4YY3oWxzSy86tdAh/ZRxLv+F7jaG
         v2EUsjReCUWRrreKPveylEASLV7VCWKd3qGj/Cd+tFDSHbLGDv1o1FaDclbml+XnIzX6
         LpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2+G+khJ+4q/8j018SJn5jdvwb/eI6plL2kwVmOnCRX4=;
        b=2OrgSJs92BwNG/0EcnD/IBEDO0YAYY0DMKpiGpIo8kkzbeHStisOqMbbtyQOLrft2n
         dBdPmFu2vCIrJv7t28kr/nTGZRgTXPCI+VxI0CfjZqWbfeKiLGkQeOC6nnis+fix9gbu
         oJ2f2V6VWBj4qqnbqqf7BrRBw5kKzxcFwKLs2rGOziZl+i+cM2RY+HBRFDokTAbqoXRf
         wI6fdDZHpn3WjPEk+6sJfPnbB6HcfR/Ze91GJ46m+J65rFDIA0i98eNoWFQLn51EPISw
         CpKiIcWcZnf1UXdpvqDdQyuOtndqIj00Kn5wm0+oxoHPmDosxmf5FvPyaqOFqqqrcOlx
         t6Uw==
X-Gm-Message-State: AOAM532PChBUoTPNGwfyLmafb0fthyuZwn9AqqNZ7yXFWGDH5p0ilAk4
        XjeZwHMH7cAvkIoywyML7uM=
X-Google-Smtp-Source: ABdhPJyTGp9Q3RV6koftuYFh+6FnLwM+MNmS4MxidqxNi0E2xBDJh+S4rR/hesXohjlIf7KIfTiRtw==
X-Received: by 2002:a05:6214:19ed:: with SMTP id q13mr21022291qvc.38.1643137790666;
        Tue, 25 Jan 2022 11:09:50 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:49 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 3/9] rpcctl: Add a command for printing individual xprts
Date:   Tue, 25 Jan 2022 14:09:40 -0500
Message-Id: <20220125190946.23586-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
References: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This shows more detailed information than what is presented with xprt
switches. I take the chance to add a main-export indicator to the
small_str() used when printing out xprt-switches.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v6: Squash into a single file
---
 tools/rpcctl/rpcctl.py | 43 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index a6bd418f8d4a..ae338e06f802 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -37,13 +37,53 @@ class Xprt:
         self.path = path
         self.id = int(path.stem.split("-")[1])
         self.type = path.stem.split("-")[2]
+        self.info = read_info_file(path / "xprt_info")
         self.dstaddr = read_addr_file(path / "dstaddr")
+        self.srcaddr = read_addr_file(path / "srcaddr")
+
+        with open(path / "xprt_state") as f:
+            self.state = ','.join(f.readline().split()[1:])
 
     def __lt__(self, rhs):
         return self.id < rhs.id
 
+    def _xprt(self):
+        main = ", main" if self.info.get("main_xprt") else ""
+        return f"xprt {self.id}: {self.type}, {self.dstaddr}, " \
+               f"port {self.info['dst_port']}, state <{self.state}>{main}"
+
+    def _src_reqs(self):
+        return f"	Source: {self.srcaddr}, port {self.info['src_port']}, " \
+               f"Requests: {self.info['num_reqs']}"
+
+    def _cong_slots(self):
+        return f"	Congestion: cur {self.info['cur_cong']}, win {self.info['cong_win']}, " \
+               f"Slots: min {self.info['min_num_slots']}, max {self.info['max_num_slots']}"
+
+    def _queues(self):
+        return f"	Queues: binding {self.info['binding_q_len']}, " \
+               f"sending {self.info['sending_q_len']}, pending {self.info['pending_q_len']}, " \
+               f"backlog {self.info['backlog_q_len']}, tasks {self.info['tasks_queuelen']}"
+
+    def __str__(self):
+        return "\n".join([self._xprt(), self._src_reqs(),
+                          self._cong_slots(), self._queues() ])
+
     def small_str(self):
-        return f"xprt {self.id}: {self.type}, {self.dstaddr}"
+        main = " [main]" if self.info.get("main_xprt") else ""
+        return f"xprt {self.id}: {self.type}, {self.dstaddr}{main}"
+
+    def add_command(subparser):
+        parser = subparser.add_parser("xprt", help="Commands for individual xprts")
+        parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt to show")
+        parser.set_defaults(func=Xprt.list_all)
+
+    def list_all(args):
+        xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
+        xprts.sort()
+        for xprt in xprts:
+            if args.id == None or xprt.id == args.id[0]:
+                print(xprt)
 
 
 class XprtSwitch:
@@ -88,6 +128,7 @@ parser.set_defaults(func=show_small_help)
 
 subparser = parser.add_subparsers(title="commands")
 XprtSwitch.add_command(subparser)
+Xprt.add_command(subparser)
 
 args = parser.parse_args()
 args.func(args)
-- 
2.34.1

