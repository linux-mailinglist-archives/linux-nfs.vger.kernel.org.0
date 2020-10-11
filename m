Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32C128AACF
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Oct 2020 00:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgJKWAx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Oct 2020 18:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgJKWAx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Oct 2020 18:00:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D019FC0613CE
        for <linux-nfs@vger.kernel.org>; Sun, 11 Oct 2020 15:00:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j136so15656939wmj.2
        for <linux-nfs@vger.kernel.org>; Sun, 11 Oct 2020 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=t90tp0pAyxJA9j5e5d0HWwQNau/QQIIx9fGan61yZSw=;
        b=HvR6wpr5pvV5K2SQI+bReQoU2KPKI/7uAEbESzRUOu3C0zPfnQdFDZj9BNGFe/2fmG
         FqhW7jqUvARyvziHQNrj+ACtdDpfDZN1HrzKWQkC5bJYKsOmgGwf8PsroFM+Z6UGb1Fh
         ThnLiWIPBl0/x6X6mVMWqyRgrE2u0JE0DllW8AhoOGiebP9K6i7kcWxpV+JaJHDdLsHs
         2PtbCzOUF9FBcScKGU44L00S7E4bIsyjneFpVsEJdRYndYe9k4x1pXeY6EGveBzxQf/4
         5UkHrRDZjaZlaOFAPvYnaWR7r4sG0gmcbAbxwxhDA9YhapT4zDzYGrKhrg4LFrF7RI1U
         by7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=t90tp0pAyxJA9j5e5d0HWwQNau/QQIIx9fGan61yZSw=;
        b=j9Ly+LuXBE/WeOJOCMGEBTZRqV37I71tTFLxXWovAkGh5ZXsJrooeUjjMXufCVSBMS
         WQFR72uIUV2gI35ieGPBsIlOj5n84TClfezcJ6hqD/3IHGhFvSY7BhRiUvP2ubQT1RXx
         vlrGyqZohoUxql4jOEHqhzZWokkqckknTCMnH1jPmat4m43fcs0zdMjWWzgIisHeEesB
         pErmYsj6pfy5WEJ+HwHNpaEFfkVysCyZyGybngSpfmosuyy0dr7fNFWYIMeFVJ1ytH8T
         BA1sbXMHHncMASJaRGgD/rEryGWCruivvo2vYGW8BhTzqIINiOmikoff//1+PlBYCeiw
         X0JQ==
X-Gm-Message-State: AOAM532epIxvLrUUXm0+me2TqkqRP7K8vDgDDGzHh80u8rZZmzNgJDYr
        jUiAaMum2h0e3x9ow9XZeUxmbPJhLQTc4dGK
X-Google-Smtp-Source: ABdhPJxRESn1JvbsVzHE/DMJogGiEdWc+0UxGxRfV+bVvM9WHywUByNDTcbSefsOfgrWB48i9iqmIA==
X-Received: by 2002:a7b:cb8d:: with SMTP id m13mr7953409wmi.59.1602453647351;
        Sun, 11 Oct 2020 15:00:47 -0700 (PDT)
Received: from [192.168.50.190] ([194.158.213.176])
        by smtp.gmail.com with ESMTPSA id v17sm10557894wru.44.2020.10.11.15.00.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 15:00:46 -0700 (PDT)
From:   Artur Molchanov <arturmolchanov@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH v2] net/sunrpc: Fix return value for sysctl sunrpc.transports
Message-Id: <20C3D746-91F5-45E1-B105-0A1B1ABAA9BB@gmail.com>
Date:   Mon, 12 Oct 2020 01:00:45 +0300
Cc:     linux-nfs@vger.kernel.org
To:     bfields@fieldses.org, chuck.lever@oracle.com
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix returning value for sysctl sunrpc.transports.
Return error code from sysctl proc_handler function proc_do_xprt instead =
of number of the written bytes.
Otherwise sysctl returns random garbage for this key.

Since v1:
- Handle negative returned value from memory_read_from_buffer as an =
error


Signed-off-by: Artur Molchanov <arturmolchanov@gmail.com>
Cc: stable@vger.kernel.org
---
 net/sunrpc/sysctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 999eee1ed61c..e81a28f30f1d 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -70,7 +70,13 @@ static int proc_do_xprt(struct ctl_table *table, int =
write,
 		return 0;
 	}
 	len =3D svc_print_xprts(tmpbuf, sizeof(tmpbuf));
-	return memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, =
len);
+	*lenp =3D memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, =
len);
+
+	if (*lenp < 0) {
+		*lenp =3D 0;
+		return -EINVAL;
+	}
+	return 0;
 }
=20
 static int
--=20
2.20.1

