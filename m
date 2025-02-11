Return-Path: <linux-nfs+bounces-10043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EC9A3168D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 21:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A47166D70
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1BD262162;
	Tue, 11 Feb 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKPHCWWV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52F26562D
	for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305476; cv=none; b=Kplxvj1iBlQI/R6s4qvhF1gdWPNAePLvzPQdyECPCJ3r3LVLMw0g74P/Ec0EgYPaVYMGanBa5EDqVSy0t1CrqCoY2UuasQd20D7gHan7dXFN5SjDmlm70dZh8FU0WmZfC3N69dxH4BMjbuf8H6TECfTUP7ykjLp7kzgIRu42VDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305476; c=relaxed/simple;
	bh=B9vvdrWVNc6dUQxgIua2sOpR0WaqBXRSU0WHSpcAjdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbdx5rHfivcQ1cD3JLuCUWD9GE5swRkJKgC7wVIlKQuRwfiyU4rJk4orfMV/iOe44y3rn8nGcwJWerCUZaVLndIhOmQnPLAeepNU810DncKrSLNYYzF8mETYa7gqgiNcmDMWmqRK6pluQhI7w+OwqQF1fqUi/r4a6JVfwbRScMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKPHCWWV; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fc8f74d397so1071448eaf.3
        for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739305474; x=1739910274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXetNZ68wDwjE/Fzwp1nNP0C1tEkb42sdEH2esgxuqs=;
        b=kKPHCWWV+lSAeBUDMUoSE27eY9a07ZnyB9v+nxdf1J9ab0J0lI9vPZZsQsPsBc/1dE
         wNCDp5Gopon5uhWpoxHcmchCPKwk0rpBlUSIf1muky7AnC8ktccuxbX8hsb3Wwh69jKp
         1wYgcTOgzTXPYHMZ2tTY4YzoTqEeJumrpDBvbQaF1Uk9piCarK3B4Hz55pxZuEWoyn1x
         wkznKo6NslImRWUNdQwNi1GJPimicJ1G/jFspW6y7aT3+sLYY3jwTt410wAYRv6A1DDw
         8eajVMrxoku31d09HVVJzMSAA+1eUNiSMT2bYN/a2YAcakarY9RJRkLe0tPouHKZk5DB
         Duzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739305474; x=1739910274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXetNZ68wDwjE/Fzwp1nNP0C1tEkb42sdEH2esgxuqs=;
        b=dA6hY0XH9SKOZnKq8BIP1TC0GRXJ7e6kx8pUcpHmVxp0hp+2CEKISLTRwHNsLRDxJ/
         jXt48Fluc2RvF1PEJOLjqvU4OkQmaPUBrqSWuRatL39zoxVSlUJ+nLfdlL93G4AVU/9S
         o/8lhOgWLI7lTUvxcYf5Wh4mIhKIcPDUFyHQyCwYXGaTcmObNFL4SnelEvmi7nL1G+oA
         /50K9xejjXg9sdR92pc3v3frCHXb7qCAYnLQ8MpxalVk2TsGe5C5RFBVBeER/3mqdyyT
         1DA/d7wv+6mevxM6iIEbxFSF9mit1ixJPYzwm2nJC8ScnclwxtBWTYIY5I7YRsyEI/8U
         Cfiw==
X-Forwarded-Encrypted: i=1; AJvYcCVa89UQX19s/Ht7KyojrgBnodkn7IMctAUIPsPTCth9ju7YKuyQgW2N+dHxYYVxZXaSHEISe2LDYOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCjHDQeUrNZCdeCAeAiN1X86FlGfBBAqFATqDqYGpsxcAMU06
	p33pinjbaFntlAeBQlZzEHXjmev2aaXckG/lc/AIvsYLZZfWTN2mkH1DOuQS
X-Gm-Gg: ASbGncv64v8pbhwImu8vY1eYIpkf+a1fi9JfmeRs1HEY1L/XlkeuxFHkVoPZJRsDMgn
	5P2sgomVOHYPLNLpT6+Dp51nc0Upy8D8Xlji155dWD/5g+xbfkmDtueSnkLbCLyC/VlpUkUhY3f
	ohO6AldA4HPgiEwKvhSKlD6TEHQfUnOFiMgf3MbuWPD1xD/uo/+K1b5mPZrGNIO7By7n5W3u75B
	imkFEqPkTsnnkzEz/4VMgnRtQylcwfzZsnB1MXSPVFsMUOFJJMlb4vgARXpWB4onESd2JDj+0le
	UiM7NrMuZzu8AZrzdqgkduxXQob3+3p1oJQ=
X-Google-Smtp-Source: AGHT+IE14/oIvA626EUBGKS2RZfe/O5Xzv27DT5WOPP/xZQMNy3hirss12cOJryTUQtQeX61p++Bwg==
X-Received: by 2002:a05:6830:25c1:b0:724:ca70:2320 with SMTP id 46e09a7af769-726f1d46819mr475863a34.22.1739305473952;
        Tue, 11 Feb 2025 12:24:33 -0800 (PST)
Received: from localhost.localdomain ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af914464sm3687840a34.7.2025.02.11.12.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:24:33 -0800 (PST)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: calum.mackay@oracle.com,
	linux-nfs@vger.kernel.org
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH pynfs] build: convert from deprecated distutils to setuptools
Date: Tue, 11 Feb 2025 13:24:32 -0700
Message-ID: <20250211202432.20356-1-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to PEP 632 [1], distutils is obsolete and removed after Python
v3.12. Setuptools is the replacement.

There is a migration guide at [2] that suggests the following
replacements:

    {distutils.core => setuptools}.setup
    {distutils => setuptools}.command
    distutils.dep_util => setuptools.modified

Prior to setuptools v69.0.0 [3], `newer_group` was exposed through
the now-deprecated `setuptools.dep_util` instead of
`setuptools.modified`.

Rather than updating distutils.core.Extension, I remove it as it does
not appear to be used.

Link: https://peps.python.org/pep-0632/ [1]
Link: https://setuptools.pypa.io/en/latest/deprecated/distutils-legacy.html [2]
Link: https://setuptools.pypa.io/en/latest/history.html#v69-0-0 [3]
Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
I'm not deeply familiar with the Python ecosystem, so it'd be good to
have this patch reviewed by someone who is.

I needed these changes to get pynfs to build on an Arch linux system
with Python version 3.13.1.

I also tested on an AlmaLinux 8.10 system with Python version 3.6.8 and
setuptools version 59.6.0, and it built succesfully for me there.
---
 nfs4.0/setup.py | 8 ++++++--
 nfs4.1/setup.py | 4 ++--
 rpc/setup.py    | 4 ++--
 setup.py        | 2 +-
 xdr/setup.py    | 2 +-
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/nfs4.0/setup.py b/nfs4.0/setup.py
index 58349d9..0f8380e 100755
--- a/nfs4.0/setup.py
+++ b/nfs4.0/setup.py
@@ -3,8 +3,12 @@
 from __future__ import print_function
 from __future__ import absolute_import
 import sys
-from distutils.core import setup, Extension
-from distutils.dep_util import newer_group
+from setuptools import setup
+try:
+    from setuptools.modified import newer_group
+except ImportError:
+    # for older (before v69.0.0) versions of setuptools:
+    from setuptools.dep_util import newer_group
 import os
 import glob
 try:
diff --git a/nfs4.1/setup.py b/nfs4.1/setup.py
index e13170e..bfadea1 100644
--- a/nfs4.1/setup.py
+++ b/nfs4.1/setup.py
@@ -1,5 +1,5 @@
 
-from distutils.core import setup
+from setuptools import setup
 
 DESCRIPTION = """
 nfs4
@@ -8,7 +8,7 @@ nfs4
 Add stuff here.
 """
 
-from distutils.command.build_py import build_py as _build_py
+from setuptools.command.build_py import build_py as _build_py
 import os
 from glob import glob
 try:
diff --git a/rpc/setup.py b/rpc/setup.py
index 99dad5a..922838f 100644
--- a/rpc/setup.py
+++ b/rpc/setup.py
@@ -1,5 +1,5 @@
 
-from distutils.core import setup
+from setuptools import setup
 
 DESCRIPTION = """
 rpc
@@ -8,7 +8,7 @@ rpc
 Add stuff here.
 """
 
-from distutils.command.build_py import build_py as _build_py
+from setuptools.command.build_py import build_py as _build_py
 import os
 from glob import glob
 try:
diff --git a/setup.py b/setup.py
index 83dc6b5..203514d 100755
--- a/setup.py
+++ b/setup.py
@@ -2,7 +2,7 @@
 
 from __future__ import print_function
 
-from distutils.core import setup
+from setuptools import setup
 
 import sys
 import os
diff --git a/xdr/setup.py b/xdr/setup.py
index 3acb8a2..3778abb 100644
--- a/xdr/setup.py
+++ b/xdr/setup.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 
-from distutils.core import setup
+from setuptools import setup
 
 DESCRIPTION = """
 xdrgen
-- 
2.48.1


