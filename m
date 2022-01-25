Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC13D49BBCE
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiAYTJz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiAYTJy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:54 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C896C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:54 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id o12so5677146qke.5
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glCIF45lcj+8BiuUMyKiYl5GPRpcLA2pBDqOPqIHpDA=;
        b=QAMtL3spYRWNHMWk9A/sWJKGmSrNrhdkNPRAn0b7V87439Rnw0BGc6aOGfRXmz1wkG
         2sixb0VR7efp29n9NC785EWRniBbnMZAgw795Q26w97kOuZrwdUmeIfsQAdjRAmtWvXm
         fR3sbXxKklUDS+GIkTueZL6vja5Qv8rBQ797EMnM1arhd5+Ka7EO46T5FzdkSXJt9FJ1
         U+hi8okPjbHxDya1iq640GlCNTp76TTfVBxOb6eVVxipAk5tyLBSi8RnjnTaxafl/vJw
         JthgotNe+UIiO40T1C1txfa/Ppty9zRZ+O9DFXmi2O2aTZWEIz786+MSQczzwF5zocVl
         tVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=glCIF45lcj+8BiuUMyKiYl5GPRpcLA2pBDqOPqIHpDA=;
        b=HHHnU0Hh0KrInul9ALthf+xnzdLQBZTo5bEh1QKblqnxD86RC++aMjuJC0AMdHKNAg
         0IMy7M/B48/IAMAbzveNBOpolSrDaj92NwQHMTWI/baFOyf7DQAOoWRoXGCUAYgqAGeD
         cVU4LXwJIARQfnu/IupCap6HikDbPsd7bTYuV+tw6r0IoxU5lLoHRW2ix8rm5yBqQj7y
         +DwVw89iZ16qthVlJwgxsvf8Zq8UiesdeRv9Ain001/Gdy6763wVxQYVI54jjN17b/+g
         3TpyWrLE6omj/8oY5YGG4JLDDMpGTACVEjGvYIvh7FolbzXeBJGlMjAUrgo4bbtOkcqS
         i1fQ==
X-Gm-Message-State: AOAM5337zsN+RXRiENuMA89+POaX4oRht2lj2y036FW7wQFNTLmT6rLM
        C4uIxgMe9GUCmL072dOaG7A=
X-Google-Smtp-Source: ABdhPJycLcnYW9sZcIZ1ph0BwAm/nHNg402RlkUnnYLP7vvQx1S3HhX3eof1xZvRGSTuS16qb8/beg==
X-Received: by 2002:a37:2c02:: with SMTP id s2mr14110031qkh.42.1643137793189;
        Tue, 25 Jan 2022 11:09:53 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:52 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 6/9] rpcctl: Add a command for changing xprt switch dstaddrs
Date:   Tue, 25 Jan 2022 14:09:43 -0500
Message-Id: <20220125190946.23586-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
References: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This is basically the same as for xprts, but it iterates through all
xprts attached to the switch to apply the new address.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v6: Continue single file squash
---
 tools/rpcctl/rpcctl.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index a5f83c46298f..0c6c9d0f006c 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -143,6 +143,12 @@ class XprtSwitch:
         parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt-switch to show")
         parser.set_defaults(func=XprtSwitch.list_all)
 
+        subparser = parser.add_subparsers()
+        parser = subparser.add_parser("set", help="Set an xprt switch property")
+        parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of an xprt-switch to modify")
+        parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+        parser.set_defaults(func=XprtSwitch.set_property)
+
     def list_all(args):
         switches = [ XprtSwitch(f) for f in (sunrpc / "xprt-switches").iterdir() ]
         switches.sort()
@@ -150,6 +156,16 @@ class XprtSwitch:
             if args.id == None or xs.id == args.id[0]:
                 print(xs)
 
+    def set_property(args):
+        switch = XprtSwitch(sunrpc / "xprt-switches" / f"switch-{args.id[0]}")
+        try:
+            for xprt in switch.xprts:
+                if args.dstaddr != None:
+                    xprt.set_dstaddr(args.dstaddr[0])
+            print(switch)
+        except Exception as e:
+            print(e)
+
 
 class RpcClient:
     def __init__(self, path):
-- 
2.34.1

