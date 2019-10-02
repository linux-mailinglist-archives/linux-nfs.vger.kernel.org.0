Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE091C4526
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 02:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfJBAwA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 20:52:00 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:37454 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfJBAv7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Oct 2019 20:51:59 -0400
Received: by mail-ed1-f48.google.com with SMTP id r4so13668330edy.4
        for <linux-nfs@vger.kernel.org>; Tue, 01 Oct 2019 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctX/aTCOvi1xU5kNGBiyEP8KrxUy9bB72b3N4qkB1y0=;
        b=Ls6MBcGcaRTHE1c3khIXoRoj7B3feSZnyotI9UMhXGWQrvPYgoE5qqMTDpRv8Y8zs5
         /w579jeVklNHTc8EHaYJCnFQkdDSmIVnN5gM0k0bnDp3V3Fos5hBRof+nhr/PUHESqpX
         VjBFxyk/GJFpYMmBCXE7bTz2vIutMHS7vOBheUFLj8QYyOnFqXJLIED+y7JdiqsvVdAN
         PsBGxh9YUB8eEW8qOMt0s3WJqryBIMbuSbLoFx2+mAlYdPJUiCt+1SyseLxZfO4XYEDO
         /sJD3pgZwIv0AvMz+pdb3ZCb/0a9J5GJS4qGwVTcnLXgEVzJuMgQR9N1wCTZTvb/0DTE
         tUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctX/aTCOvi1xU5kNGBiyEP8KrxUy9bB72b3N4qkB1y0=;
        b=Ziwp7PHvallKqWXrj1VYNot/lLt/Dnz9dLniBDkZV1I5euaoPBRU7BYdH20Dq+GH5/
         RgJUo8kjPPMPhiPwe8I6/veudBluVO2c87ZJwqM6erRyQKKOACg6bGP28ZKOGRetPEPc
         zX8J+LTTZmK8+nNtkd3XZbXB7lse3jmC7+XLbpRm/NRUN/gAPRvGoIYRt+0PlqBkKHEs
         6r42d5tAF+Pqhw5lFShRR3/AXpmUIIQ7SHwj8l0yvOQd4doGdN6zrGpHcqnHRkCGrX+c
         hQQPeLw3Up8CDy2tVYmHghz2mOyWivRX4JSJEUjKBbZ3QxXSIdIxfePZ/ogfRUjenXKb
         eFCw==
X-Gm-Message-State: APjAAAVDOI4oloWfrkUKDPd6X02/wZ0itHrLtOqbyrlziopeEuFBpFT1
        4kID1y/hXpDHGTUm6oqnUjvLyaL3EHE=
X-Google-Smtp-Source: APXvYqwn5o+joglben9IsbqaGh47vXjMY7I4lxvT7Rg+5029tJjntklPY/j0RIyPm6uoyRtT1GqMxQ==
X-Received: by 2002:a50:9a05:: with SMTP id o5mr1172436edb.44.1569977517671;
        Tue, 01 Oct 2019 17:51:57 -0700 (PDT)
Received: from continental.suse.de (179.187.205.11.dynamic.adsl.gvt.net.br. [179.187.205.11])
        by smtp.gmail.com with ESMTPSA id e27sm2049290ejc.1.2019.10.01.17.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 17:51:56 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-nfs@vger.kernel.org, steved@redhat.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] utils/statd.man: Clarify the --name argument usage
Date:   Tue,  1 Oct 2019 21:52:41 -0300
Message-Id: <20191002005241.28308-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

The man page does not clarifies that the --name argument is only used by
the sm-notify command, and statd itself listen to all interfaces. This
change makes clear that the --name argument is only passed to sm-notify.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 utils/statd/statd.man | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/utils/statd/statd.man b/utils/statd/statd.man
index 71d58461..03732a6f 100644
--- a/utils/statd/statd.man
+++ b/utils/statd/statd.man
@@ -185,18 +185,16 @@ restarts without the
 option.
 .TP
 .BI "\-n, " "" "\-\-name " ipaddr " | " hostname
-Specifies the bind address used for RPC listener sockets.
+This string is only used by the
+.B sm-notify
+command as the source address from which to send reboot notification requests.
+.IP
 The
 .I ipaddr
 form can be expressed as either an IPv4 or an IPv6 presentation address.
 If this option is not specified,
 .B rpc.statd
 uses a wildcard address as the transport bind address.
-.IP
-This string is also passed to the
-.B sm-notify
-command to be used as the source address from which
-to send reboot notification requests.
 See
 .BR sm-notify (8)
 for details.
-- 
2.23.0

