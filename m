Return-Path: <linux-nfs+bounces-11099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80763A84F20
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F83C1B87271
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA661E5B62;
	Thu, 10 Apr 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b="aujiA5I/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592E20AF88
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319949; cv=none; b=mBLtdSBl7i5MQcsVuAgyfYezg8DVMHgZl04No1RDzqYcL0cpl6z8Lo0FcLRAD2Ccr1k2+LgMjBOgprhN5ydgAK22uqSi074y+QQ2gC6GImh5q7JJMHCZGLss0gCnmrohuDcm7ht8V36HhZStpHPEVXw0zvlnU/sbmtdL0F2+bOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319949; c=relaxed/simple;
	bh=o7Y+50V3RsfruLo2UsNXFbe8EZ997vkMUEH0pZPOVKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IzQjW89c8CNHPPq5oDL9bZplBJA1DGEf0lHhQLvFXwRe6XMd8zLTnyzvQLqjUqdgM8IbUwA9uVE19Fd0ixJFu9ujtriQotwrkPWoUH5VnObaLTt8AEHSr807iy5MX72OJNUMRgQy0azxrP8nRKL3t8vfOUz7rLAWu9BiMqBBWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org; spf=pass smtp.mailfrom=schmersal.org; dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b=aujiA5I/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmersal.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7394945d37eso1178535b3a.3
        for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmersal.org; s=google; t=1744319947; x=1744924747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1UzKhdY8FEOO4eVHTJwOcyKD5aCpAX7v32GsB+CRPA=;
        b=aujiA5I/WEj8oc5afXUVUirPNFcDEvQex9uCxBU9VdVazVE9Zb0+sa0IJi4+W4nVFG
         Qrrx56zgxcqYSA0Z2+39PggTNzlkJvVx7LBTBsQVV2B2Sda7mbG9Ae3dVXD128PvOrGz
         esDzfxd3ucdajz1MyKh5NVX0OmsZtPRMVESe4J+vqeJq1DvOfga+v1Y2QMfo7ACb9XYE
         +9/DghKHEG+OepGTR9pVHUdhsOpfFGWJ+iL2nn9yAsYoVacEgn8pDuXbkh33VKQQQ+hd
         E78p+MZVhtDZzTK19fK1Z4LJ7VWsE2QLfJeEgXPSZxhX5xcqBu+Tlnd7x/2Yb+8AxH0W
         7nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744319947; x=1744924747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1UzKhdY8FEOO4eVHTJwOcyKD5aCpAX7v32GsB+CRPA=;
        b=q0JjIFndmohVw49TmyfvtZ8fdcP1zxsRPjY5M8X/Tw8zN1bo/7EsVTWPWstgzmrlT5
         C6IcLjD2Y1zJWlU/Dn5juu+/DGTnq5eQew+oOj+ok+vZn6pSUrt2MFUoxE/3OJSRwY9/
         CELG7ReDzFU33o0FNxBQU9DoKbPGS7ozXDTe3Fn8LNuEIMRr0eUy5ogEE5qFAMssPKXg
         4iiXclgnyMdHpgsjTu3kXI1t48RJgqv5L+9rZIMRY7smxgIv96SnqNgKBP7eC5lZR7Jg
         CYrOXqg0soULXW2vnYCtb4ARd5pVki+N2CEs2TUf1hAjjJCeUykJiA4dGPAz9fKO9co/
         nT7w==
X-Gm-Message-State: AOJu0YwdZaFviZgGpU+cm6Skp7fxmNGxzx+c0mLWS9zlSAh952wSGdEz
	tAwi7Ef90Asef+lH3PjDRjdn1mihsBXa4ANbgclXwrPYCw0xZnpOQdYP42q3yG4=
X-Gm-Gg: ASbGncvZLpEWDEu0h3moIvMfefQ/k2yF1/TcauxmCwQQSJzG5kjWE6vFq3P9+TmokJd
	RKUYFu9Ag/W70WWWaE9jW6nzpYRxMpaq/S8KQJiJPQ6OQ2jxg+hkyVQNq+9DFNKy/x5bzeclnfT
	4GnwSZApnt+8GL+ml4pQB0yTpXQKh7aQtPiP/npKEX6qXX1TxzO7b9GunGBWp3/BuxK6q+K5WPs
	+4SQ5Tvw7WIN93Hl6X8bo56kkf9/L+HryFXTxeNO0JZOhX5AjzyPcL0Bje2nDoj2yM+REOfl76W
	IqnjcEOrJwEAk4GhIgYiQv/SaIIoewkh2dwVPszYL4DZrqjJN6tQVx1COZzWAfhEJpE3ByZS/RU
	ySh7jPQD5BxjjQNwDLrsA5RvQGJVg1fjSVNj3YcY=
X-Google-Smtp-Source: AGHT+IFGXeosq20Y+MbkglypGuvu64ZDQw+lTzjy3bnumTf0xFzWEvveNym3s+uZp+We1+l5zng9YA==
X-Received: by 2002:a05:6a00:2184:b0:734:b136:9c39 with SMTP id d2e1a72fcca58-73bd1263c2fmr454098b3a.19.1744319946884;
        Thu, 10 Apr 2025 14:19:06 -0700 (PDT)
Received: from bryan-ThinkStation-P520.tds.net (h69-129-150-238.mdsnwi.tisp.static.tds.net. [69.129.150.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21949dasm36822b3a.35.2025.04.10.14.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:19:06 -0700 (PDT)
From: bryan@schmersal.org
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Bryan Schmersal <bryan@schmersal.org>
Subject: [PATCH pynfs] Replace references of non-existant StandardError with Exception
Date: Thu, 10 Apr 2025 14:18:17 -0700
Message-Id: <20250410211816.480625-1-bryan@schmersal.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan Schmersal <bryan@schmersal.org>

Signed-off-by: Bryan Schmersal <bryan@schmersal.org>
---
 nfs4.1/nfs4client.py     | 2 +-
 nfs4.1/nfs4commoncode.py | 2 +-
 nfs4.1/nfs4server.py     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index ba1e087..ae90cc2 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -211,7 +211,7 @@ class NFS4Client(rpc.Client, rpc.Server):
                 except NFS4Replay:
                     # Just pass this on up
                     raise
-                except StandardError:
+                except Exception:
                     # Uh-oh.  This is a server bug
                     traceback.print_exc()
                     result = encode_status_by_name(opname.lower()[3:],
diff --git a/nfs4.1/nfs4commoncode.py b/nfs4.1/nfs4commoncode.py
index bba5a69..2d47d93 100644
--- a/nfs4.1/nfs4commoncode.py
+++ b/nfs4.1/nfs4commoncode.py
@@ -43,7 +43,7 @@ def %(encode_status)s_by_name(name, status, *args, **kwargs):
         if tag:
             result.tag = tag
         return result
-    except StandardError:
+    except Exception:
         raise
         pass
     raise RuntimeError("Problem with name %%r" %% name)
diff --git a/nfs4.1/nfs4server.py b/nfs4.1/nfs4server.py
index f56806e..d51732b 100755
--- a/nfs4.1/nfs4server.py
+++ b/nfs4.1/nfs4server.py
@@ -350,7 +350,7 @@ class ClientRecord(object):
                         state.delete()
                     # STUB - what about LAYOUT?
                     # STUB - config whether DELEG OK or not
-            except StandardError as e:
+            except Exception as e:
                 log_41.exception("Ignoring problem during state removal")
         self.state = {}
         self.lastused = time.time()
@@ -837,7 +837,7 @@ class NFS4Server(rpc.Server):
                 except NFS4Replay:
                     # Just pass this on up
                     raise
-                except StandardError:
+                except Exception:
                     # Uh-oh.  This is a server bug
                     traceback.print_exc()
                     result = encode_status_by_name(opname.lower()[3:],
-- 
2.34.1


