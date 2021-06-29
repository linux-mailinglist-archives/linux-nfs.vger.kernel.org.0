Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E43B70D5
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 12:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhF2KmX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 06:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhF2KmW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 06:42:22 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAACC061574
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 03:39:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f6so6165771qka.0
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=gpnegibjESzjLmnBYt7iWeZ4TVX2erbyB91qo1q1cTY=;
        b=dwa990JYjfCO2j4/nhKKkViSHjS9L0H+K1FtX5K9G9PkQxj65m4j03+XZDG/UUro+y
         W/O6XljGt5pgPmYmMwmg94HgN1hv6RdddnQP/po2408nMAREoBWOSuAppzSh0NfAiTaB
         +ochfxrtkyQ+LMiJezC9vg1jIrcxfW57ZlEz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=gpnegibjESzjLmnBYt7iWeZ4TVX2erbyB91qo1q1cTY=;
        b=rhviAIl+IfXN5P7yDCHo+3PukvaAaD3aDX409h6aHmmI4zpa2Qq7yNQAjTlvZaagGi
         nm2ktsGMzqNZIkmR1OqtWXqrqfPiOAYDCUS360al8VyBpKAiXZOA9tR6BBt/hGMirgFB
         aNodqtiVF6FRqrYXHlY5EH5/n/jwshjbB71rT7bYQOJkTdxILknwkeE1ymV9uxSrtdh4
         UlF4nZFt/mRhO9vG0ptWX3KFk/EyT8v3KPKp37/l15vl0cEFsfyH3hRjjAtdE0i4H4D3
         deir9QaxGXzcvmdnRl6sc/FgKKPpOqEfdF8nz3v09m1XG5bA4uKsQ3F/uehW9ckN14Tg
         fcow==
X-Gm-Message-State: AOAM5335+3daxbrOMsC07Rhb/21mjYA0pBrml0gvBBK+MHUbnB4jUDS3
        bCdT1DmwTaytFnvroH5erHAJdJHOMHXDlg57
X-Google-Smtp-Source: ABdhPJwkPNLdoyLz2ROEczMKE9xRmrZDvc+8ruNBqbNaV4JsBFLfcrQ/7KdmiosAKgQZiWEKzcdjnQ==
X-Received: by 2002:ae9:ed52:: with SMTP id c79mr14710480qkg.260.1624963194427;
        Tue, 29 Jun 2021 03:39:54 -0700 (PDT)
Received: from WARPC ([2600:4040:400a:8500::f7aa])
        by smtp.gmail.com with ESMTPSA id s6sm423535qkc.125.2021.06.29.03.39.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 03:39:53 -0700 (PDT)
From:   "Justin Piszcz" <jpiszcz@lucidpixels.com>
To:     <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>
Subject: linux 5.13 kernel regression for NFS server
Date:   Tue, 29 Jun 2021 06:39:53 -0400
Message-ID: <004d01d76cd3$18db1830$4a914890$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adds0xh8TyPplr3rRaqlXbtYqWYwkg==
Content-Language: en-us
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

ISSUE: Can no longer mount NFS server(5.13) share.
WORKAROUND: Reverting back to the 5.13-rc7 kernel for the NFS server, all
clients can then mount the share.

Kernel 5.13 vs. 5.13-rc7 for x86_64

With Kernel 5.13-rc7:

## mount is successful (from multiple clients, phone, tv, other Linux
client)
# mount 192.168.1.2:/r1 /r1
#

With Kernel 5.13 (hangs from multiple clients, phone, tv, other Linux
client)

## mount hangs:
# mount 192.168.1.2:/r1 /r1

(strace output where it is hanging)
...
clone(child_stack=NULL,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x7f2285e303d0) = 1741
wait4(1741, 0x7ffeaab6ce08, 0, NULL)    = ? ERESTARTSYS (To be restarted if
SA_RESTART is set)
--- SIGWINCH {si_signo=SIGWINCH, si_code=SI_KERNEL} ---
wait4(1741,

No user changes in the kernel .config other than the comment for the version
text:

--- config-20210628.1624867695  2021-06-28 04:08:15.152781940 -0400
+++ config-20210628.1624867962  2021-06-28 04:12:42.591981706 -0400
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/x86 5.13.0-rc7 Kernel Configuration
+# Linux/x86 5.13.0 Kernel Configuration
 #
 CONFIG_CC_VERSION_TEXT="gcc (Debian 10.2.1-6) 10.2.1 20210110"
 CONFIG_CC_IS_GCC=y

Justin.

